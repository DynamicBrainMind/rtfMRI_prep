# rtfMRI-prep
These scripts are for processing functional localizer data immediately after data collection to define individual-level ROIs to target with real-time fMRI. The current version was based on using the [GradCPT](https://academic.oup.com/cercor/article/23/11/2712/303412) as the functional localizer task. Currently, functional localization is performed for two brain regions: dorsal anterior insular cortex (daIC) and posteromedial cortex (PMC), based on BOLD activation and deactivation, respectively, to target stimuli during GradCPT performance. The code generates set-up files for performing real-time fMRI analysis using [OpenNFT](https://www.sciencedirect.com/science/article/pii/S1053811917305050) software.

**Setup**
1. After cloning this repository, add the path to your bash startup script (.bash_profile on Mac), e.g. by adding these 2 lines (replacing the path below with your own path) to the script:

_PATH="/Users/ak4379/Documents/scripts/rtfMRI_prep:${PATH}"_

_export PATH_

2. Make sure that all of the scripts are executable. For example, go to the rtfMRI_prep path in terminal and type "_chmod u+x *_"

3. Make sure that [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki) is installed. If you'd like to use the scripts with "_niimath" suffix (which is slightly faster), make sure [niimath](https://github.com/rordenlab/niimath) is installed.

**Running the code**

All scripts must be run from the terminal within the folder that contains 3 files: **(1)** fMRI data (one run) from functional localizer task; **(2)** anatomical data; **(3)** Text file with event information in 3-column format for performing GLM in FSL ("EV" file; required only for rtfmri_localizer_proc)

**rtfmri_localizer_proc**: Main function that computes ROIs using functional localizer task data. Requires 3 arguments: **(1)** subject name; **(2)** name of fMRI file; **(3)** name of T1 (anatomical) file. Outputs an "OpenNFT" folder within the path where the command was run. Toward the end of completion, the script will output images displaying select brain slices with the functionally localized daIC and PMC ROIs.

**rtfmri_localizer_proc_niimathh**: Same as rtfmri_localizer_proc but uses niimath instead of fslmaths to speed things up.

**rtfmri_localizer_proc_noGLM**: Function that uses registration from standard space to get ROIs (does not use functional localizer task to generate the ROIs) and outputs OpenNFT folder. Requires same arguments as rtfmri_localizer_proc. This should be if, for example, the functional localizer task was not performed or there was error during data acquisition.

**rtfmri_view_localizer_rois**: Use fsleyes to view ROIs on functional data after running rtfmri_localizer_proc. No arguments required (just run it from the folder containing original files).

**rtfmri_view_localizer_rois_noGLM**: Use fsleyes to view ROIs on functional data after running rtfmri_localizer_proc_noGLM. No arguments required (just run it from the folder containing original files).
