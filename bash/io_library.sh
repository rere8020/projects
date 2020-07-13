#!/bin/bash

function create_file() {
  local FNAME=$1
  touch "${FNAME}"
  ls "${FNAME}" # if it does not return a name, file is not there
}

function delete_file() {
  local FNAME=$1
  rm "${FNAME}"
  ls "${FNAME}" # if it does not return a name, file is not there
}
