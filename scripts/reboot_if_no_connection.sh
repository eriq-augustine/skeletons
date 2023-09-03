#!/bin/bash

readonly PING_ADDRESS='google.com'

function reboot() {
    echo "Rebooting..."
    systemctl reboot
    exit 10
}

function main() {
    trap exit SIGINT

    if [[ "$@" =~ '--help' || "$@" =~ '-h' ]] ; then
        echo "USAGE: $0 [network_interface ...]"
        exit 0
    fi

    local interfaces=$@

    if [[ $(id -u) -ne 0 ]] ; then
        echo "Script must be executed as superuser."
        exit 2
    fi

    # Ignore this script if there are users currely logged in.
    if [[ $(users) != "" ]] ; then
        echo "Active users seen, skipping reboot."
        exit 0
    fi

    for interface in $interfaces ; do
        ip link show "${interface}" >/dev/null 2>&1
        if [[ $? -ne 0 ]] ; then
            echo "Interface '${interface}' does not exist, rebooting."
            reboot
        fi
    done

    ping -c 1 "${PING_ADDRESS}" >/dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        echo "Could not ping '${PING_ADDRESS}', rebooting."
        reboot
    fi

    echo "Conditions met, no reboot required."
    exit 0
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
