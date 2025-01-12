#!/bin/bash

set -e

# SESSION_NAME="MSC01_ses1_motor_run01"
WORKING_DIRECTORY=$1

# SESSION_NAME="MSC01_ses1_motor_run01"
SESSION_NAME=$2

# MASKS_PATH="../../../david_data/AAl2_masks"
MASKS_PATH=$3

# BRAIN_REGION="Supp_Motor_Area"
BRAIN_REGION=$4

SOURCE_SCAN="${WORKING_DIRECTORY}/filtered_func_in_MNI.nii.gz"
MASK_FILE="${BRAIN_REGION}_mask.nii.gz"
OUTPUT_FILE="${WORKING_DIRECTORY}/${SESSION_NAME}_${BRAIN_REGION}_masked.nii"
VOXEL_SIGNAL_FOLDER="${WORKING_DIRECTORY}/${SESSION_NAME}_${BRAIN_REGION}_voxel_export"
ASCII_TEMPLATE_NAME="${BRAIN_REGION}_"

echo "=> >>>"
echo "=> Doing fslmath"
fslmaths "${SOURCE_SCAN}" -mul "${MASKS_PATH}/${MASK_FILE}" "${OUTPUT_FILE}"
echo "=> fslmath done."
echo "=> <<<"

if [[ -e "${VOXEL_SIGNAL_FOLDER}" ]]; then
    echo "=> Output folder exists"
else
    mkdir "${VOXEL_SIGNAL_FOLDER}"
fi

echo "=> >>>"
echo "=> Doing fsl2ascii"
fsl2ascii "${OUTPUT_FILE}" "${VOXEL_SIGNAL_FOLDER}/${ASCII_TEMPLATE_NAME}"
echo "=> fsl2ascii done."
echo "=> <<<"
