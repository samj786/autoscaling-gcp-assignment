#!/bin/bash

# Configurations
PROMETHEUS_URL="http://localhost:9090/api/v1/query?query=100-(avg by(instance)(rate(node_cpu_seconds_total{mode='idle'}[2m])) * 100)"
THRESHOLD=70
PROJECT_ID="a3" # Replace with your GCP Project ID
ZONE="us-central1-a" # Replace with your desired zone
MACHINE_TYPE="e2-micro"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
INSTANCE_NAME="autoscaled-vm-$(date +%s)"

# Get current CPU Usage
CPU_USAGE=$(curl -s "$PROMETHEUS_URL" | jq '.data.result[0].value[1]' | tr -d '"')
CPU_USAGE_INT=${CPU_USAGE%.*}  # Convert to integer

echo "Current CPU Usage: $CPU_USAGE_INT%"

# Check against threshold
if [ "$CPU_USAGE_INT" -gt "$THRESHOLD" ]; then
    echo "CPU usage is high! Triggering auto-scale to GCP..."
    gcloud compute instances create "$INSTANCE_NAME" \
        --project="$PROJECT_ID" \
        --zone="$ZONE" \
        --machine-type="$MACHINE_TYPE" \
        --image-family="$IMAGE_FAMILY" \
        --image-project="$IMAGE_PROJECT" \
        --quiet
else
    echo "CPU usage is normal, no action required."
fi
