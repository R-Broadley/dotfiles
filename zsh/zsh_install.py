#!/usr/bin/env python3
"""Setup .zshrc file."""

from datetime import datetime
from os import readlink, rename, symlink
from os.path import abspath, dirname, exists, expanduser
from os.path import join as pathjoin

SELF_DIR = abspath(dirname(__file__))
ZSH_DIR = expanduser("~/.zsh")
ZSHRC_PATH = expanduser("~/.zshrc")


def generate_zshrc():
    """Write zshrc file based on template."""
    with open(pathjoin(SELF_DIR, "zshrc.template")) as template_file:
        zshrc_template = template_file.read()

    def format_id(string):
        return string.rstrip().replace('"', "").title()

    distro = None
    distrofamily = None
    with open("/etc/os-release") as release_file:
        for line in release_file:
            if line.startswith("ID="):
                distro = format_id(line.lstrip("ID="))
            if line.startswith("ID_LIKE="):
                distrofamily = format_id(line.lstrip("ID_LIKE="))

    if distro and not distrofamily:
        distrofamily = distro

    zshrc = zshrc_template.format(
        ZSHDEST=ZSH_DIR, DISTRO=distro, DISTROFAMILY=distrofamily
    )

    # Backup existing zshrc if one exists
    if exists(ZSHRC_PATH):
        rename(ZSHRC_PATH, ".".join((ZSHRC_PATH, datetime.now().isoformat())))

    # Write zshrc file
    with open(ZSHRC_PATH, "w") as output_file:
        output_file.write(zshrc)


def create_symlink():
    """Symlink dotfiles zsh to ~/.zsh."""
    src_dir = pathjoin(SELF_DIR, "zsh")
    try:
        symlink(src_dir, ZSH_DIR)
    except FileExistsError:
        if not readlink(ZSH_DIR) == src_dir:
            raise


if __name__ == "__main__":
    generate_zshrc()
    create_symlink()
