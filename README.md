# rtfMRI_prep
These scripts are for processing functional localizer data immediately after data collection to define individual-level ROIs to target with real-time fMRI.

**Setup**
1. After cloning this repository, add the path to your bash startup script (.bash_profile on Mac), e.g. by adding these 2 lines (using your own path) to the script:

_PATH="/Users/ak4379/Documents/scripts/rtfMRI_prep:${PATH}"_

_export PATH_

2. Make sure that all of the scripts are executable. For example, go to the rtfMRI_prep path in terminal and type "_chmod u+x *_"

3. Make sure that FSL is installed.

**Running the code**

All scripts must be run from the terminal within the folder that contains 3 files: **(1)** fMRI data (one run) from functional localizer task; **(2)** anatomical data; **(3)** Text file with event information in 3-column format for performing GLM in FSL ("EV" file; required only for rtfmri_localizer_proc)

**rtfmri_localizer_proc**: Main function that computes ROIs using functional localizer task data. Requires 3 arguments: **(1)** subject name; **(2)** name of fMRI file; **(3)** name of T1 (anatomical) file. Outputs an "OpenNFT" folder within the path where to command was run.

**rtfmri_localizer_proc_noGLM**: Faster function that uses registration from standard space to get ROIs (does not use functional localizer task to generate the ROIs) and outputs OpenNFT folder. Requires same arguments as rtfmri_localizer_proc.

**rtfmri_view_localizer_rois**: Use fsleyes to view ROIs on functional data after running rtfmri_localizer_proc. No arguments required (just run it from the folder containing original files).

**rtfmri_view_localizer_rois_noGLM**: Use fsleyes to view ROIs on functional data after running rtfmri_localizer_proc_noGLM. No arguments required (just run it from the folder containing original files).
