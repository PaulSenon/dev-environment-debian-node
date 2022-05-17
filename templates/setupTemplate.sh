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
  exit 1
fi

# check if $1 is a folder name in ~/.templates
if [ ! -d $HOME/.templates/$1 ]; then
  echo "Template $1 not found"
  exit 1
fi
# check if $1 is a folder name in ~/.templates (but another way)

# setup yarn defaults
yarn init -y
json -I -f package.json -e "this.scripts={\"start\":\"node index.js\"}"

# do the setup if ./templates/$1/setup.sh exists
if [ -f $HOME/.templates/$1/setup.sh ]; then
  echo "Running setup for $1"
  $HOME/.templates/$1/setup.sh
fi

# copy the template files
echo "Copying template files"
cp -r $HOME/.templates/$1/src/* .