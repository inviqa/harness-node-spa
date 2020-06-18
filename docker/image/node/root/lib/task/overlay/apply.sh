#!/bin/bash

function task_overlay_apply()
{
    run "rsync --exclude='*.twig' --exclude='_twig' -rl /home/node/application/overlay/ /app/"
}
