#! /bin/bash

# if $1 not defined
if [ -z "$1" ]; then
  echo "Please choose a template from "
  ## for all folders in ~/.templates
  for i in ~/.templates/*; do
    ## if folder is a directory
    if [ -d $i ]; then
      ## print folder name
      name=$(sed 's/.*\///' <<< $i)
      echo "  - $name"
    fi
  done
  # for i in $(ls -d ~/.templates/*/); do
  #   ## remove the trailing slash
  #   i=${i%?}
  #   ## remove the leading ./
  #   i=${i#./}
  #   ## remove the templates/
  #   i=${i#templates/}
  #   ## print the folder name
  #   echo "  - $i"
  # done
  exit 1
fi

# check if $1 is a folder name in ~/.templates
if [ ! -d "~/.templates/$1" ]; then
  echo "Template $1 not found"
  exit 1
fi

# do the setup if ./templates/$1/setup.sh exists
if [ -f "~/.templates/$1/setup.sh" ]; then
  echo "Running setup for $1"
  ~/.templates/$1/setup.sh
fi

# copy the template files
echo "Copying template files"
cp -r ~/.templates/$1/src .

all done