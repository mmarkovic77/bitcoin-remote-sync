#!/bin/bash
set -e
python3 -m venv venv
. venv/bin/activate
pip install "pip>=21.3.1"
pip install -r requirements.txt
ansible-playbook main.yml
