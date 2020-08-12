#!/bin/bash

function task_init()
{
    if [ ! -f /app/README.md ]; then
        task skeleton:apply
    fi

    task overlay:apply

    task welcome
}
