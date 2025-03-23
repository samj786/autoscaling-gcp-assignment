# Autoscaling VM to Google Cloud Platform Based on CPU Usage

## Overview
This project demonstrates an automated method to monitor CPU usage on a local VM and scale to Google Cloud Platform (GCP) by launching a new VM instance when CPU usage exceeds a defined threshold (70%).

## Tools Used:
- VirtualBox (for local VM)
- Ubuntu 20.04 LTS
- Node Exporter
- Prometheus
- Google Cloud SDK
- Bash scripting
- stress (CPU load generator)

## Setup Instructions

### 1. Node Exporter Setup:
- Download and extract node_exporter:
  ```bash
  wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz
  tar -xvzf node_exporter-1.8.0.linux-amd64.tar.gz
  ./node_exporter
  ```
- Verify on: `http://localhost:9100/metrics`

### 2. Prometheus Setup:
- Download and extract Prometheus:
  ```bash
  wget https://github.com/prometheus/prometheus/releases/download/v2.50.0/prometheus-2.50.0.linux-amd64.tar.gz
  tar -xvzf prometheus-2.50.0.linux-amd64.tar.gz
  ```
- Replace `prometheus.yml` with the one provided.
- Start Prometheus:
  ```bash
  ./prometheus --config.file=prometheus.yml
  ```
- Verify on: `http://localhost:9090`

### 3. Google Cloud SDK Setup:
- Follow the steps in `gcloud-sdk-setup.md` to install and authenticate GCP.

### 4. Autoscaling Script:
- Edit `autoscale.sh` with your GCP project ID and zone.
- Make it executable:
  ```bash
  chmod +x autoscale.sh
  ./autoscale.sh
  ```

### 5. Testing:
- Simulate high CPU:
  ```bash
  stress --cpu 2 & 
  ```
- Run `./autoscale.sh` to trigger auto-scaling.

## Notes:
- Service account JSON is not included for security.
- Ensure Compute Engine API is enabled on GCP.
