#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPTDIR/common.sh"

IMAGE_DIR="${1:-.}"

SPL_IMAGE=flash-spl.bin
UBOOT_IMAGE=flash-uboot.bin
UBOOT_ENV_IMAGE=flash-uboot-env.bin
UBI_IMAGE=flash-rootfs.bin

require fastboot

"${SCRIPTDIR}/gotofastboot.sh" "${IMAGE_DIR}" || exit 1

wait_for_fastboot

fastboot erase spl-backup
fastboot erase uboot
fastboot erase env
fastboot erase UBI

fastboot flash spl        "${IMAGE_DIR}/${SPL_IMAGE}"
fastboot flash spl-backup "${IMAGE_DIR}/${SPL_IMAGE}"
fastboot flash uboot      "${IMAGE_DIR}/${UBOOT_IMAGE}"
fastboot flash env        "${IMAGE_DIR}/${UBOOT_ENV_IMAGE}" 
fastboot flash UBI        "${IMAGE_DIR}/${UBI_IMAGE}"
