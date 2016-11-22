#!/bin/bash

#------------------------------------------------------------
require() {
  if [[ -z "$1" ]]; then
    echo -e "\nusage: require EXECUTABLE\n\n"
  fi

  path_to_executable=$(which $1) 

  if [[ -z "${path_to_executable}" ]]; then
    echo -e "\nERROR: cannot find $1 in PATH\n"

    if [[ ! -z "$2" ]]; then
      echo -e "$2\n"
    fi
  fi
}

#------------------------------------------------------------
onMac() {
  if [ "$(uname)" == "Darwin" ]; then
    return 0;
  else
    return 1;
  fi
}

#------------------------------------------------------------
filesize() {
  if onMac; then
    stat -f "%z" $1
  else
    stat --printf="%s" $1
  fi
}

#------------------------------------------------------------
read_nand_config() {
  local CONFIGFILE=$1

  if [[ -f "${CONFIGFILE}" ]]; then
    echo "Reading ${CONFIGFILE}"
    source "${CONFIGFILE}"
    export NAND_TYPE
    export NAND_MAXLEB_COUNT
    export NAND_SUBPAGE_SIZE
    export NAND_ERASE_BLOCK_SIZE
    export NAND_PAGE_SIZE
    export NAND_OOB_SIZE
  else
    echo -e "ERROR: cannot find NAND configuration \"$1\"."
  fi;
}

