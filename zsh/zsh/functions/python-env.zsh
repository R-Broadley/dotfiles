#!/bin/zsh
#
# Auto activate a python virtualenv when entering the project directory.

VENV=".venv"

function venvnew() {
    VENV_DIR="$PWD/$VENV"
    VENV_ACTIVATE="$VENV_DIR/bin/activate"
    if [ -e $VENV_DIR ]; then
        echo "Could not create environment: one already exists!"
    else
        echo "Creating $VENV_DIR"
        python3 -m venv $VENV_DIR
        source $VENV_ACTIVATE
        pip install -U pip
        pip install black pylint python-language-server pydocstyle
    fi
}

function venvactivate() {
    VENV_DIR="$PWD/$VENV"
    VENV_ACTIVATE="$VENV_DIR/bin/activate"
    if [ -x $VENV_ACTIVATE ]; then
        echo "Could not activate environment ($VENV_ACTIVATE)!"
    else
        # Check to see if already activated to avoid redundant activating
        if [[ "$VIRTUAL_ENV" != "$VENV_DIR" ]]; then
            source $VENV_ACTIVATE
        fi
    fi
}

function _virtualenv_auto_activate() {
    VENV_DIR="$PWD/$VENV"
    VENV_ACTIVATE="$VENV_DIR/bin/activate"
    if [[ -f $VENV_ACTIVATE ]]; then
        venvactivate
    fi
}

chpwd_functions+=(_virtualenv_auto_activate)
precmd_functions=(_virtualenv_auto_activate $precmd_functions)
