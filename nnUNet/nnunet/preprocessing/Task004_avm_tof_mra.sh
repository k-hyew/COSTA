#!/bin/bash
export nnUNet_raw_data_base="/home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base"
export nnUNet_preprocessed="/home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_preprocessed"
export nnUNet_TRAINED_MODELS="/home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_trained_models/COSTA/CESAR/COSTA__nnUNetPlansv2.1"
export RESULTS_FOLDER="/home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_trained_models"

# # 01. brain_extraction
COSTA_brain_extraction -i /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base/nnUNet_raw_data/Task004_avm_tof_mra/imagesTs 

# # 02. train_landmarks
COSTA_train_landmarks -i /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base/nnUNet_raw_data/Task004_avm_tof_mra/SkullStripped -m /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base/nnUNet_raw_data/Task004_avm_tof_mra/BrainMask 

# # 03. standardization
COSTA_standardization -i /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base/nnUNet_raw_data/Task004_avm_tof_mra/imagesTs 

# # 04. convert_dataset
COSTA_convert_dataset -t 004

# # inference
CUDA_VISIBLE_DEVICES=0 COSTA_predict -i /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_raw_data_base/nnUNet_raw_data/Task004_avm_tof_mra/imagesTs\
 -o /home/nearbrain-infer/dnf_ai/test_seg/models/COSTA/nnUNet/nnunet/nnUNet_predictions/Task004_avm_tof_mra -t 004 -m CESAR -f 0 -chk model_best
# # The value of -f can be 0, 1, 2, 3, 4
