🔭 Monitoring Kubernetes with Prometheus & Grafana

Real-World Observability on Azure Kubernetes Service (AKS)

This project demonstrates how I deployed a full observability stack on an AKS cluster using Prometheus for metrics collection and Grafana for live visualization.
It mirrors how monitoring is implemented in real enterprise DevOps and SRE environments.

📌 Project Overview

I built an end-to-end Kubernetes monitoring pipeline using the kube-prometheus-stack Helm chart.

This observability setup provides:

Cluster-wide and namespace-wide performance dashboards

CPU, memory, network, and storage I/O analytics

Pod-level visibility

Automatic Grafana dashboard provisioning

Prometheus scraping and metric retention

Live metrics from my deployed Nimbus web application (nimbus-site)

This README documents the full deployment process, including screenshots, automation code, and live metric evidence.

🧠 Architecture Overview
🧩 Prometheus

Scrapes Kubernetes, node, and pod metrics

Stores time-series data

Acts as the primary datasource for Grafana

📊 Grafana

Visualizes metrics collected by Prometheus

Includes 20+ prebuilt dashboards from the Kubernetes mixin

Exposed via AKS LoadBalancer

Secured with auto-generated admin credentials

⚙️ kube-prometheus-stack

A single Helm chart that deploys:

Prometheus

Grafana

Alertmanager

Node Exporter

kube-state-metrics

Auto-imported dashboards

Default alerting rules

📁 Monitoring Namespace

All observability components are deployed into a dedicated namespace:

monitoring


This aligns with real-world Kubernetes best practices.

⚙️ Installation & Automation

To automate the entire observability stack, I wrote a Bash script:

code/setup-monitoring.sh


This script performs:

Adding the Prometheus Helm repository

Creating the monitoring namespace

Installing kube-prometheus-stack

Waiting for all pods to become ready

Retrieving external IPs

Decoding the Grafana admin password

Setup Script (Automation)




▶️ Running the Setup Script

The script installs and validates the full stack automatically.

Deployment Evidence






Prometheus and Grafana were successfully deployed, and AKS provisioned a public LoadBalancer for Grafana.

🌐 Grafana Access

Once deployed, Grafana is accessible via the external IP:

http://<EXTERNAL-IP>:31832


Grafana admin password is retrieved securely from Kubernetes secrets:

kubectl get secret -n monitoring kps-grafana \
  -o jsonpath='{.data.admin-password}' | base64 -d

Grafana Login Page

📊 Kubernetes Monitoring Dashboards

The kube-prometheus-stack automatically provisions a full set of production-grade Kubernetes dashboards.

Dashboard Browser

These dashboards are sourced from official Kubernetes mixins, covering:

Pods

Namespaces

Nodes

Workloads

Networking

Control-plane components (API server, etcd, CoreDNS)

📈 Performance Metrics (Evidence)

Below are live metrics from my AKS cluster monitoring the nimbus-site deployment.

🧾 Cluster Headlines (Overview)

This provides a high-level view of:

CPU utilisation (requests vs limits)

Memory utilisation (requests vs limits)

🧮 CPU Usage & Quota

This panel shows per-pod CPU:

Actual usage

Requested CPU

Defined limits

This is critical for:

Capacity planning

Preventing noisy-neighbour issues

Autoscaling decisions

💾 Memory Usage

Memory usage metrics help detect:

Memory pressure

Risk of OOMKills

Poorly sized workloads

📡 Network Bandwidth & Packets
Current Bandwidth

Packet Rate

These dashboards visualize:

Bytes transmitted and received

Packet rates per pod

Useful for detecting abnormal traffic patterns or networking issues.

🧱 Storage I/O Distribution

Storage I/O metrics show:

Read/write IOPS

Throughput per pod

This is especially important for stateful workloads and identifying disk bottlenecks.

🧱 Project Structure
monitoring/
│
├── code/
│   └── setup-monitoring.sh
│
├── images/
│   ├── cpuquota.png
│   ├── currentbandwidth.png
│   ├── dashboards.png
│   ├── headlinescpuusage.png
│   ├── memorynetworkusage.png
│   ├── packetsbandwidth.png
│   ├── storageiodistribution.png
│   ├── terminalmonitoring.png
│   ├── terminalmonitoring1.png
│   ├── terminalmonitoring2.png
│   ├── terminalmonitoring3.png
│   ├── setupmonitoring.sh.png
│   ├── setupmonitoring.sh1.png
│   └── welcometografana.png
│
└── README.md

🚀 Skills Demonstrated
Kubernetes Observability

kube-prometheus-stack deployment

Prometheus metric scraping

Grafana dashboard provisioning

Namespace-level monitoring

DevOps Automation

Bash scripting

Helm package management

Automated namespace and release configuration

Cloud Engineering (AKS)

AKS LoadBalancer services

Namespace isolation

Live pod performance analysis

SRE / Monitoring Practices

Metric visualization

Cluster health analysis

Performance diagnostics

Alerting foundations with Alertmanager

👤 Author

Oluwaseyi Adesegun Bello
DevOps Engineer | MSc Human-Centred AI
Azure | Kubernetes | Terraform | Monitoring

🔗 GitHub: https://github.com/seyiabello

🔗 LinkedIn: https://www.linkedin.com/in/oluwaseyi-bello-2653a2215/