# PowerShell-VirtualBoxBIOSDateTool
A PS script that automates the process of setting BIOS date offsets on VirtualBox virtual machines.

## Purpose
This tool allows you to automate the otherwise tedious process off specifying an date offset for an Oracle VirtualBox virtual machine. 

## Why
As of the latest commit date for this repo, VirtualBox does not provide GUI-based options for modifying the virtual machine's system (or BIOS/UEFI) date. Unlike the simple methods for doing so for VMware and Virtual PC VMs, VirtualBox requires you call an executable to pass in the offset for the BIOS date (relative to host system date) in milliseconds. This script aims to automate this process a bit to make it quicker and more accessible.
