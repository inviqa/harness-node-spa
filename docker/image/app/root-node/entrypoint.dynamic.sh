#!/bin/bash

main()
{
    source /entrypoint.sh
}

setup_app_volume_permissions()
{
    case "$STRATEGY" in
        "host-linux-normal")
            usermod  -u "$(stat -c '%u' /app)" node
            groupmod -g "$(stat -c '%g' /app)" node
            ;;
        "host-osx-normal")
            usermod  -u 1000 node
            groupmod -g 1000 node
            ;;
        "host-osx-dockersync")
            usermod  -u 1000 node
            groupmod -g 1000 node
            ;;
        *)
            exit 1
    esac

    chown node:node /app
}

resolve_volume_mount_strategy()
{
    if [ "${HOST_OS_FAMILY}" = "linux" ]; then
        STRATEGY="host-linux-normal"
    elif [ "${HOST_OS_FAMILY}" = "darwin" ]; then
        if (mount | grep "/app type fuse.osxfs") > /dev/null 2>&1; then
            STRATEGY="host-osx-normal"
        elif (mount | grep "/app type fuse.grpcfuse") > /dev/null 2>&1; then
            STRATEGY="host-osx-normal"
        elif (mount | grep "/app type virtiofs") > /dev/null 2>&1; then # virtiofs (Docker Desktop < 4.15)
            STRATEGY="host-osx-normal"
        elif (mount | grep "/app type fakeowner") > /dev/null 2>&1; then # virtiofs (Docker Desktop >= 4.15)
            STRATEGY="host-osx-normal"
        elif (mount | grep "/app type ext4") > /dev/null 2>&1; then
            STRATEGY="host-osx-dockersync"
        elif (mount | grep "/app type btrfs") > /dev/null 2>&1; then
            STRATEGY="host-linux-normal"
        else
            exit 1
        fi
    else
        exit 1
    fi
}

bootstrap()
{
    resolve_volume_mount_strategy
    setup_app_volume_permissions
}

bootstrap
main "$@"
