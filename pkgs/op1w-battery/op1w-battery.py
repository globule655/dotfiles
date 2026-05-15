#!/usr/bin/env python3
"""One-shot battery query for Endgame Gear OP1w 4k mouse.

Prints a single Waybar-compatible JSON line to stdout and exits.
"""

import json
import sys
import time

try:
    import hid
except ImportError:
    print(json.dumps({"text": "?", "tooltip": "op1w: hid module not found", "class": "error"}))
    sys.exit(1)

VID = 0x3367
DONGLE_PID = 0x1970   # wireless dongle
WIRED_PID = 0x1972    # mouse connected via USB cable (also means charging)

USAGE_PAGE = 0xFF01
USAGE = 0x0002

REPORT_ID = 0xA1
BATTERY_CMD = 0xB4
REPORT_SIZE = 64


def find_device():
    """Return (pid, path) for the first matching Endgame Gear HID interface."""
    for pid in (DONGLE_PID, WIRED_PID):
        for info in hid.enumerate(VID, pid):
            if info["usage_page"] == USAGE_PAGE and info["usage"] == USAGE:
                return pid, info["path"]
    return None, None


def read_battery(pid, path):
    """
    Return (level: int, charging: bool) or (None, None) on failure.
    Protocol requires two cycles; first is a wake-up, second has real data.
    """
    buf = bytearray(REPORT_SIZE)
    buf[0] = REPORT_ID
    buf[1] = BATTERY_CMD

    try:
        dev = hid.Device(path=path)
        try:
            # First cycle: wake up the device
            dev.send_feature_report(bytes(buf))
            time.sleep(0.35)
            dev.get_feature_report(REPORT_ID, REPORT_SIZE)
            time.sleep(0.1)

            # Second cycle: real data
            dev.send_feature_report(bytes(buf))
            time.sleep(0.35)
            data = dev.get_feature_report(REPORT_ID, REPORT_SIZE)
        finally:
            dev.close()

        if data and len(data) > 16 and data[1] in (0x01, 0x08):
            level = min(data[16], 100)
            charging = (pid == WIRED_PID)
            return level, charging
    except Exception:
        pass
    return None, None


def main():
    pid, path = find_device()

    if pid is None:
        print(json.dumps({
            "text": "?",
            "tooltip": "OP1w: not found",
            "class": "unknown",
        }))
        return

    level, charging = read_battery(pid, path)

    if level is None:
        print(json.dumps({
            "text": "?",
            "tooltip": "OP1w: read failed",
            "class": "error",
        }))
        return

    text = f"{level}%"
    if charging:
        tooltip = f"OP1w: {level}% (charging)"
        css_class = "charging"
    else:
        tooltip = f"OP1w: {level}%"
        css_class = "normal" if level > 20 else "low"

    print(json.dumps({
        "text": text,
        "tooltip": tooltip,
        "class": css_class,
    }))


if __name__ == "__main__":
    main()
