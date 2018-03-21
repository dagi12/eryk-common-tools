#!/usr/bin/env bash

# comment in production
#set -x
#set -v
set -e

WORKING_DIR=`pwd -P`

# 1 - prompt info, 2 - yes fun, 3 - no fun
function prompt {
    while true; do
        read -p "$1" tn
        case ${tn} in
            [Tt]* ) $2;
                    break
                    ;;
            [Nn]* ) $3
		    break
                    ;;
            * ) echo "Wybierz (T/n)"
		break
                ;;
        esac
    done
}

# 1 - promted wrong data string, 2 - loop fun, 3 - check fun
function prompt_loop {
    local valid=false
    local first_time=true
    while [ "$valid" = false ]; do
        if [ "$first_time" = true ]; then
            first_time=false
        else
            echo $1
        fi
        $2
        valid=$($3)
    done
}

function exit_ok {
    exit 0
}

function get_free_port {
    local port_test=$1
    local valid=false
    while [ "$valid" = false ]; do
        valid=$(is_port_free ${port_test})
        if [ "$valid" = true ]; then
            echo ${port_test}
        else
            let "port_test++"
        fi
    done
}

function exit_error {
    exit 1
}


function is_port_free {
    if [ "$(netstat -tulpn | grep :$1)" ]; then
        echo false
    else
        echo true
    fi
}

function check_root {
    if [ "$EUID" -ne 0 ]; then
        echo "Uruchom skrypt z uprawnieniami administratora."
	exit 1
    fi
}


function stub_fun {
    :
}

function is_internet {
    wget -q --spider http://google.com
    if [ $? -eq 0 ]; then
        echo 1
    else
        echo 0
    fi
}

function is_ubuntu {
    python -mplatform | grep -qi Ubuntu
    if [ $? -eq 0 ]; then
        echo 1
    else
        echo 0
    fi
}

function return_false {
    echo false
}
