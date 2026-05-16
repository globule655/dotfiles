#!/usr/bin/env python3
"""One-shot battery query for supported wireless mice.

Prints a single Waybar-compatible JSON line to stdout and exits.
"""

import json
import sys
import time

try:
    import hid
except ImportError:
    print(json.dumps({"text": "?", "tooltip": "mouse-battery: hid module not found", "class": "error"}))
    sys.exit(1)


ENDGAME_VID = 0x3367
ENDGAME_USAGE_PAGE = 0xFF01
ENDGAME_USAGE = 0x0002
ENDGAME_DONGLE_PID = 0x1970
ENDGAME_REPORT_ID = 0xA1
ENDGAME_BATTERY_CMD = 0xB4

VAXEE_VID = 0x3057
VAXEE_USAGE_PAGE = 0xFF05
VAXEE_USAGE = 0x0001
VAXEE_REPORT_ID = 0x0E
VAXEE_HEADER = 0xA5
VAXEE_READ = 0x01
VAXEE_BATTERY_CMD = 0x0B
VAXEE_CHARGING_CMD = 0x10

REPORT_SIZE = 64

ENDGAME_DEVICES = [
    ("Endgame Gear wireless dongle", ENDGAME_DONGLE_PID, False),
    ("Endgame Gear OP1W", 0x1972, True),
    ("Endgame Gear XM2W v2", 0x1982, True),
]

VAXEE_DEVICES = [
    ("VAXEE Dongle", 0x0005),
    ("VAXEE Dongle", 0x1001),
    ("VAXEE 4K Dongle", 0x1002),
    ("VAXEE 4K Dongle (Dual-track)", 0x2001),
    ("VAXEE XE Wireless", 0x1003),
    ("ZYGEN NP-01S Wireless", 0x1004),
    ("VAXEE AX Wireless", 0x1005),
    ("ZYGEN NP-01 Wireless", 0x1006),
    ("VAXEE XE-S Wireless", 0x1007),
    ("VAXEE XE-S-L Wireless", 0x1008),
    ("VAXEE x NINJUTSO Sora Wireless", 0x1009),
    ("VAXEE E1 Wireless", 0x1010),
    ("ZYGEN NP-01S V2 Wireless", 0x1011),
    ("VAXEE XE V2 Wireless", 0x1012),
    ("ZYGEN NP-01S Ergo Wireless", 0x1013),
]


def endgame_device(name, pid, charging):
    return {
        "name": name,
        "protocol": "endgame",
        "vid": ENDGAME_VID,
        "pid": pid,
        "usage_page": ENDGAME_USAGE_PAGE,
        "usage": ENDGAME_USAGE,
        "charging": charging,
    }


def vaxee_device(name, pid):
    return {
        "name": name,
        "protocol": "vaxee",
        "vid": VAXEE_VID,
        "pid": pid,
        "usage_page": VAXEE_USAGE_PAGE,
        "usage": VAXEE_USAGE,
    }


SUPPORTED_DEVICES = [
    *[endgame_device(*device) for device in ENDGAME_DEVICES],
    *[vaxee_device(*device) for device in VAXEE_DEVICES],
]


def waybar_output(text, tooltip, css_class):
    print(json.dumps({"text": text, "tooltip": tooltip, "class": css_class}))


def find_device():
    """Return (device, path) for the first matching supported HID interface."""
    for device in SUPPORTED_DEVICES:
        for info in hid.enumerate(device["vid"], device["pid"]):
            if info["usage_page"] == device["usage_page"] and info["usage"] == device["usage"]:
                return device, info["path"]
    return None, None


def read_endgame_battery(device, path):
    """
    Return (level: int, charging: bool) or (None, None) on failure.
    Protocol requires two cycles; first is a wake-up, second has real data.
    """
    buf = bytearray(REPORT_SIZE)
    buf[0] = ENDGAME_REPORT_ID
    buf[1] = ENDGAME_BATTERY_CMD

    try:
        dev = hid.Device(path=path)
        try:
            dev.send_feature_report(bytes(buf))
            time.sleep(0.35)
            dev.get_feature_report(ENDGAME_REPORT_ID, REPORT_SIZE)
            time.sleep(0.1)

            dev.send_feature_report(bytes(buf))
            time.sleep(0.35)
            data = dev.get_feature_report(ENDGAME_REPORT_ID, REPORT_SIZE)
        finally:
            dev.close()

        if data and len(data) > 16 and data[1] in (0x01, 0x08):
            return min(data[16], 100), device["charging"]
    except Exception:
        pass
    return None, None


def vaxee_read_command(dev, command):
    buf = bytearray(REPORT_SIZE)
    buf[0] = VAXEE_REPORT_ID
    buf[1] = VAXEE_HEADER
    buf[2] = command
    buf[3] = VAXEE_READ
    buf[4] = 0x01

    dev.send_feature_report(bytes(buf))
    time.sleep(0.1)
    data = dev.get_feature_report(VAXEE_REPORT_ID, REPORT_SIZE)

    if data and len(data) > 5 and data[1] == VAXEE_HEADER and data[2] != 0:
        return data[5]
    return None


def read_vaxee_battery(path):
    """Return (level: int, charging: bool) or (None, None) on failure."""
    try:
        dev = hid.Device(path=path)
        try:
            level_raw = vaxee_read_command(dev, VAXEE_BATTERY_CMD)
            charging_raw = vaxee_read_command(dev, VAXEE_CHARGING_CMD)
        finally:
            dev.close()

        if level_raw is not None:
            level = min(level_raw * 5, 100)
            charging = charging_raw is not None and charging_raw != 0
            return level, charging
    except Exception:
        pass
    return None, None


def read_battery(device, path):
    if device["protocol"] == "endgame":
        return read_endgame_battery(device, path)
    if device["protocol"] == "vaxee":
        return read_vaxee_battery(path)
    return None, None


def main():
    device, path = find_device()

    if device is None:
        waybar_output("?", "Mouse battery: no supported mouse found", "unknown")
        return

    level, charging = read_battery(device, path)

    if level is None:
        waybar_output("?", f"{device['name']}: read failed", "error")
        return

    if charging:
        tooltip = f"{device['name']}: {level}% (charging)"
        css_class = "charging"
    else:
        tooltip = f"{device['name']}: {level}%"
        css_class = "normal" if level > 20 else "low"

    waybar_output(f"{level}%", tooltip, css_class)


if __name__ == "__main__":
    main()
