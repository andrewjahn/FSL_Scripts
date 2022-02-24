#!/bin/bash

  # Generate the subject list to make modifying this script
  # to run just a subset of subjects easier.

  for id in 01 ; do
      subj="sub-$id"
      echo "===> Starting processing of $subj"
      echo
      cd $subj

          # If the brain mask doesn’t exist, create it
          if [ ! -f anat/${subj}_T1w_brain_f02.nii.gz ]; then
              echo "Skull-stripped brain not found, using bet with a fractional intensity threshold of 0.5"
              # Note: This fractional intensity appears to work well for most of the subjects in the
              # Flanker dataset. You may want to change it if you modify this script for your own study.
              bet2 anat/${subj}_T1w.nii.gz \
                  anat/${subj}_T1w_brain.nii.gz
          fi

          # Copy the design files into the subject directory, and then
          # change “sub-01” to the current subject number
          cp ../design_run1.fsf .

          # Note that we are using the | character to delimit the patterns
          # instead of the usual / character because there are / characters
          # in the pattern.
          sed -i '' "s|sub-01|${subj}|g" \
              design_run1.fsf

          # Now everything is set up to run feat
          echo "===> Starting feat for run 1"
          feat design_run1.fsf
                  echo

      # Go back to the directory containing all of the subjects, and repeat the loop
      cd ..
  done

  echo
