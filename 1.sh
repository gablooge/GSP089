#!/bin/bash
gcloud auth revoke --all

while [[ -z "$(gcloud config get-value core/account)" ]]; 
do echo "waiting login" && sleep 2; 
done

while [[ -z "$(gcloud config get-value project)" ]]; 
do echo "waiting project" && sleep 2; 
done

# open Monitoring, wait, and create uptime check with alert
export PROJECT_ID=$(gcloud info --format='value(config.project)')
open "https://console.cloud.google.com/monitoring/signup?project=$PROJECT_ID&nextPath=monitoring"

gcloud beta compute instances create lamp-1-vm --zone=us-central1-a --machine-type=n1-standard-2 --tags=http-server

# gcloud beta compute instances create lamp-1-vm --zone=us-central1-a --machine-type=n1-standard-2 --tags=http-server --metadata startup-script='#! /bin/bash
# sudo su -
# apt-get update 
# sudo apt-get install apache2 php7.0'

gcloud compute firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="sudo apt-get -y install apache2 php7.0"


gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh && sudo bash add-monitoring-agent-repo.sh && sudo apt-get update && sudo apt-get install stackdriver-agent"


gcloud beta compute ssh --zone "us-central1-a" "lamp-1-vm" --quiet --command="curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh && sudo bash add-logging-agent-repo.sh && sudo apt-get update && sudo apt-get install google-fluentd"


