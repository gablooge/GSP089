#!/bin/bash

gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh && sudo bash add-monitoring-agent-repo.sh && sudo apt-get update && sudo apt-get install stackdriver-agent"

gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh && sudo bash add-logging-agent-repo.sh && sudo apt-get update && sudo apt-get install google-fluentd"

gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="sudo apt-get -y install apache2 php7.0"
