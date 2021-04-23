#!/bin/bash

#Check whether the file subjList.txt exists; if not, create it
if [ ! -f subjList.txt ]; then
        ls -d sub-?? > subjList.txt
fi

#Loop over all subjects and format timing files into FSL format
for subj in `cat subjList.txt` ; do
        cd $subj/func #Navigate to the subject's func directory, which contains the timing files
        
        #Create a separate regressor and parametric regressor for each Gamble, Gain, and Loss trial for each run
        cat ${subj}_task-mixedgamblestask_run-01_events.tsv | awk 'NR>1{print $1, $2, "1"}' > gambles_run1.txt
        cat ${subj}_task-mixedgamblestask_run-02_events.tsv | awk 'NR>1{print $1, $2, "1"}' > gambles_run2.txt
        cat ${subj}_task-mixedgamblestask_run-03_events.tsv | awk 'NR>1{print $1, $2, "1"}' > gambles_run3.txt
        cat ${subj}_task-mixedgamblestask_run-01_events.tsv | awk 'NR>1{print $1, $2, $3}' > gambles_loss_run1.txt
        cat ${subj}_task-mixedgamblestask_run-02_events.tsv | awk 'NR>1{print $1, $2, $3}' > gambles_loss_run2.txt
        cat ${subj}_task-mixedgamblestask_run-03_events.tsv | awk 'NR>1{print $1, $2, $3}' > gambles_loss_run3.txt
        cat ${subj}_task-mixedgamblestask_run-01_events.tsv | awk 'NR>1{print $1, $2, $5}' > gambles_gain_run1.txt
        cat ${subj}_task-mixedgamblestask_run-02_events.tsv | awk 'NR>1{print $1, $2, $5}' > gambles_gain_run2.txt
        cat ${subj}_task-mixedgamblestask_run-03_events.tsv | awk 'NR>1{print $1, $2, $5}' > gambles_gain_run3.txt

        
        cd ../..
done
