---
name: ansible-ipam
description: Use when looking up the ansible inventory
---

# Ansible IPAM (dynamic inventory)

## Overview

Ansible uses a dynamic inventory constructed from API calls to a phpipam instance located at https://ipam.intra.digeiz.fr
It stores information such as hostnames, IP addresses, groups, NAT addresses where applicable and other useful things.

## When to use

* Looking up hosts in a specific group
* Looking up groups of a specific host
* Looking up IP addresses, subnets or other network related information about a host
* Exploring the ansible inventory in general

## How to use

* The command `nix run .#ipam -- -l` outputs the whole inventory in json format.
* `nix run .#ipam -- --group <group name> -a` outputs a list of host in the group defined by `<group name>`.
* `nix run .#ipam -- --group <group name>` outputs a list of groups nested under `<group name>`. For instance, the group `all` would output all groups in the inventory. Nested groups are idented.
* `nix run .#ipam -- --host <hostname>` outputs a json with the host related variable values.
* `nix run .#ipam -- --host <hostname> --belong` outputs a list of groups the host belongs to.
