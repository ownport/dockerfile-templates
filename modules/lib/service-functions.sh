#!/usr/bin/env bash

#
#   get command name
#
get_command_name() {

    echo $(cat ${RERUN_COMMAND_DIR}/metadata | grep NAME | cut -d= -f 2)
}


#
#   prepare /run/ directory before exporting config files
#
prepare_directory() {

    local _TARGET_DIR=${1}

    [ ! -d ${_TARGET_DIR%%/}/modules/ ] && {
        mkdir -p ${_TARGET_DIR%%/}/modules/lib/ || {
            echo "** Error! Cannot create directory: ${_TARGET_DIR%%/}/modules/lib/"
            exit 1
        }
    } 

    for rc_level in $(seq 0 9)
    do
        local _CURRENT_RUNLEVEL_DIR="${_TARGET_DIR%%/}/modules/rc${rc_level}/"
        mkdir -p ${_CURRENT_RUNLEVEL_DIR}
        echo "NAME=rc${rc_level}" >> ${_CURRENT_RUNLEVEL_DIR%%/}/metadata
        echo "DESCRIPTION=\"Runlevel rc${rc_level} configs\"" >> ${_CURRENT_RUNLEVEL_DIR%%/}/metadata
        echo "VERSION=rc${rc_level}" >> ${_CURRENT_RUNLEVEL_DIR%%/}/metadata
    done

    cp ${RERUN} ${_TARGET_DIR}
    cp ${RERUN_MODULES%%/}/lib/* ${_TARGET_DIR%%/}/modules/lib/
}

#
#	export command scripts to specific directory
#
export_to() {

    local _TARGET_DIR=${1}

    [ -z ${_TARGET_DIR} ] && {
        echo "Error! Target directory for exporting config file cannot be empty"
        exit 1
    }

    [ -z ${RERUN_COMMAND_DIR} ] && {
        echo "Error! Export can be done only in rerun environment"
        exit 1
    }

    [ -z ${RUNLEVEL} ] && {
        echo "Error! RUNLEVEL is not set into the config script"
        exit 1        
    }

    prepare_directory "${_TARGET_DIR}"

    local _COMMAND_NAME=$(get_command_name)
    echo "- Exporting '${_COMMAND_NAME}' (${RERUN_COMMAND_DIR}) to '${_TARGET_DIR%%/}/modules/${RUNLEVEL}/commands/${_COMMAND_NAME}/'"
    [ ! -d ${_TARGET_DIR%%/}/modules/${RUNLEVEL}/commands/${_COMMAND_NAME}/ ] && {
        mkdir -p ${_TARGET_DIR%%/}/modules/${RUNLEVEL}/commands/${_COMMAND_NAME}/
    }

    cp "${RERUN_COMMAND_DIR%%/}"/* "${_TARGET_DIR%%/}/modules/${RUNLEVEL}/commands/${_COMMAND_NAME}/" 

    echo "- Export completed"

}

#
#   check command options
#

handle_command_options() {

    [ "$#" -eq 0 ] && {
        usage
    }

    # Get the options
    while [ "$#" -gt 0 ]; do
        OPT="$1"
        case "$OPT" in
            # options without arguments
            # options with arguments   
            --run)
                run
                exit 0
                ;;
            --export-to)
                export_to "$2"
                exit 0
                ;;
            *)
                echo "Unknown attribute: ${OPT}"
                break
                ;;   
        esac
        shift
    done    
}