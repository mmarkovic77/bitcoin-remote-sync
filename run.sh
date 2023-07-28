#!/bin/bash
set -e
python3 -m venv venv
. venv/bin/activate
pip install "pip>=21.3.1"
pip install -r requirements.txt
ANSIBLE_JINJA2_NATIVE=1 ansible-playbook main.yml
