#!/bin/bash

function task_skeleton_apply()
{
    run rsync --exclude='*.twig' --exclude='_twig' -rl /home/node/application/skeleton/ /app/
}
