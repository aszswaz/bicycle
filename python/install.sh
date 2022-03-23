#!/bin/zsh

cd $(dirname $0)

source ./venv/bin/activate
pip install -r requirements.txt
pip freeze >>requirements.txt

set -x
for file in $(find ! -path '*/venv/*' -name '*.py'); do
    if [ -x $file ] && [ ! -e "../bin/$(basename $file)" ]; then
        ln -s "$(realpath $file)" "../bin/$(basename $file)"
    fi
done
