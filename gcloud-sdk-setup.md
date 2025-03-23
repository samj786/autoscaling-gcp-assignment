# Google Cloud SDK Setup Guide for Autoscaling Project

This guide explains how to set up the Google Cloud SDK on your local Ubuntu VM for the autoscaling project.

---

## 1. Download Google Cloud SDK Tarball

```bash
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-456.0.0-linux-x86_64.tar.gz
```

## 2. Extract the SDK

```bash
tar -xvzf google-cloud-sdk-456.0.0-linux-x86_64.tar.gz
```

## 3. Install Google Cloud SDK

```bash
cd google-cloud-sdk
./install.sh
source ./path.bash.inc
```

## 4. Create Service Account on GCP Console

- Go to **GCP Console > IAM & Admin > Service Accounts**
- Click **Create Service Account**
- Assign **Compute Admin** and **Service Account User** roles
- Generate and download a **JSON key file**

## 5. Authenticate Using Service Account Key

Move the JSON key to your VM directory and run:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/service-account-key.json"
```

## 6. Configure gcloud to Your Project

```bash
gcloud config set project <your-project-id>
```

## 7. Enable Compute Engine API

```bash
gcloud services enable compute.googleapis.com
```

---

✅ **Done!** Now your Google Cloud SDK is ready to use in scripts like `autoscale.sh` for autoscaling actions.

---

> ⚠️ **Note:** Ensure that the service account JSON key is never uploaded to any public repositories.