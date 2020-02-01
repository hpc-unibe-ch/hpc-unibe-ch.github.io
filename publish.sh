#!/usr/bin/env bash

[ -d gh-pages ] && rm -rf gh-pages

git clone git@github.com:hpc-unibe-ch/hpc-unibe-ch.github.io.git gh-pages
cd gh-pages
mkdocs gh-deploy --config-file ../mkdocs.yml --remote-branch master
cd ..

exit 0
