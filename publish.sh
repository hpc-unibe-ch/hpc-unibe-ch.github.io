#!/usr/bin/env bash

if [ ! -d gh-pages ]
then
  git clone git@github.com:hpc-unibe-ch/hpc-unibe-ch.github.io.git gh-pages
fi

cd gh-pages
mkdocs gh-deploy --config-file ../mkdocs.yml --remote-branch master
