# Altered basal forebrain regulation of intrinsic brain networks in depressive and anxiety disorders (under review)

The repository contains [group](Data/BMA_files) and [individual participant effective connectivity data](Data/GCM_files) and the [scripts used to generate figures](Figure_scripts) for this paper by [Jamieson and colleagues](https://www.biorxiv.org/content/10.1101/2024.11.06.622349v2.abstract).

This study investigated altered effective connectivity between basal forebrain subregions and key nodes of the default mode and salience networks in those with depressive and anxiety disorders. Through a combination of ultra-high field neuroimaging and dynamic causal modelling we identified that these changes were largely localised to the nucleus basalis of Meynert. 

## Data
This includes the individual participant effective connectivity data segmented into [all participants](Data/GCM_between_group_analysis_147_participants.mat), [only healthy controls and clinical participants with a depressive and/or anxiety disorder](Data/GCM_between_group_analysis_only_dep_anx_dx_129_participants), and [clinical participants with a depressive and/or anxiety disorder](Data/GCM_only_clinicals_dep_anx_dx_52_participants.mat).
Group level effective connectivity data used for [Figure 2](Data/BMA_search_PEB_between_group_analysis_147_participants.mat), [Supplementary Figure S2](Data/BMA_search_PEB_between_group_analysis_only_dep_anx_dx_129_participants.mat), and [Figure 4](Data/BMA_search_PEB_only_clinicals_dep_anx_dx_52_participants_symptoms.mat) can also be found here. These BMA files can be reviewed using spm_dcm_peb_review(BMA).

We have also included results from the leave-one-out cross validation analysis for predicting [diagnosis](LOOCV_outputs/LOO_diagnosis.mat), [depression](LOOCV_outputs/LOO_DASS_depressive_symptoms_dep_anx_dx.mat), and [anxiety symptoms](LOOCV_outputs/LOO_DASS_anxiety_symptoms_dep_anx_dx.mat).

## Figure_scripts
Scripts used to create connectivity maps for [Figure 2a-c](Figure_scripts/Matrix_between_group.R), [Supplementary Figure S2a-c](Figure_scripts/Matrix_between_group_dep_anx_dx.R), and [Figure 4a-c](Figure_scripts/Matrix_symptoms_clinical_group.R) are located here. Data for the these figures can be extracted from respective BMA.mat files using the respective scripts for [2](Figure_scripts/Ep_Pp_converter_2_plot.m) and [3 plots](Figure_scripts/Ep_Pp_converter_3_plot.m). Similarly, scripts used to generate the left and right plots in [Figure 3](Figure_scripts/graph_LOO_dx.R), and [Figure 4d](Figure_scripts/graph_LOO_DASS_depression.R) and [e](Figure_scripts/graph_LOO_DASS_anxiety.R) are also located in this folder.


