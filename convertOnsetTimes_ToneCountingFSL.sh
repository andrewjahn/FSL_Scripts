  #!/bin/bash

  #Check whether the file subjList.txt exists; if not, create it
  if [ ! -f subjList.txt ]; then
          ls -d sub-?? > subjList.txt
  fi

  #Loop over all subjects and format timing files into FSL format
  for subj in `cat subjList.txt` ; do
          cd $subj/func #Navigate to the subject's func directory, which contains the timing files

          cat ${subj}_task-tonecounting_events.tsv | awk '{if (NR!=1 && $5=="") {print $1, $2, "1"}}' > toneCount_run1.txt
          cat ${subj}_task-tonecounting_events.tsv | awk '{if ($5=="probe") {print $1, $2, "1"}}' > toneProbe_run1.txt

          cd ../..
  done
