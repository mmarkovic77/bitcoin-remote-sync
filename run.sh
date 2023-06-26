set -e
python3 -m venv venv
. venv/bin/activate
pip install "pip>=21.3.1"
pip install -r requirements.txt
ansible-playbook main.yml -e "CLOUD_PROVIDER=$BRS_CLOUD_PROVIDER" -e "CLOUD_API_KEY=$BRS_CLOUD_API_KEY"
