🔭 Monitoring Kubernetes with Prometheus & Grafana

Production-Style Observability on Azure Kubernetes Service (AKS)










📌 Overview

This project demonstrates a production-ready Kubernetes observability stack deployed on Azure Kubernetes Service (AKS) using Prometheus and Grafana.

It mirrors how enterprise DevOps and SRE teams monitor live workloads: automated installation, secure access, namespace isolation, and deep visibility into CPU, memory, networking, and storage performance.

Everything is deployed using Helm and Bash automation, validated with live cluster metrics, and fully documented with evidence screenshots.

🔗 GitHub Repository: https://github.com/seyiabello/Monitoring-with-Prometheus-Grafana

🚀 What This Project Delivers

End-to-end Kubernetes monitoring using kube-prometheus-stack

Automated deployment via Helm and Bash scripting

Dedicated monitoring namespace (production best practice)

Prometheus scraping cluster, node, and pod metrics

Grafana dashboards auto-provisioned from Kubernetes mixins

Live application monitoring for the nimbus-site workload

Enterprise-style observability aligned with real-world AKS environments

🧠 Architecture Summary
Prometheus

Scrapes Kubernetes, node, and pod metrics

Stores time-series performance data

Acts as the primary datasource for Grafana

Grafana

Visualizes metrics collected by Prometheus

Includes 20+ prebuilt Kubernetes dashboards

Exposed via AKS LoadBalancer

Secured using auto-generated credentials stored in Kubernetes Secrets

kube-prometheus-stack (Helm)

A single Helm release that deploys:

Prometheus

Grafana

Alertmanager

Node Exporter

kube-state-metrics

Auto-imported dashboards

Default alerting rules

All components run inside a dedicated monitoring namespace, ensuring clean separation of concerns.

⚙️ Installation & Automation

The entire observability stack is deployed using a single Bash script:

code/setup-monitoring.sh

What the script automates

Adds the Prometheus Helm repository

Creates the monitoring namespace

Installs kube-prometheus-stack

Waits for all pods to become ready

Retrieves external LoadBalancer IPs

Decodes the Grafana admin password from Kubernetes Secrets

(Screenshots of the script and execution are included below in this README.)

▶️ Deployment Evidence

The setup script installs and validates the full stack automatically.

Helm successfully deploys Prometheus and Grafana

All monitoring pods reach Ready state

AKS provisions a public LoadBalancer for Grafana access

This confirms the cluster is fully observable.

🌐 Grafana Access

Once deployed, Grafana is accessible via the AKS LoadBalancer:

http://<EXTERNAL-IP>:31832


Admin credentials are retrieved securely:

kubectl get secret -n monitoring kps-grafana \
  -o jsonpath='{.data.admin-password}' | base64 -d


This follows secure-by-default Kubernetes practices.

📊 Kubernetes Dashboards

The kube-prometheus-stack automatically provisions production-grade dashboards sourced from official Kubernetes mixins.

These dashboards provide visibility into:

Pods and namespaces

Nodes and workloads

Networking and storage

Control-plane components (API server, etcd, CoreDNS)

No manual dashboard configuration required.

📈 Performance Metrics (Live Evidence)

All metrics shown below are live data from the AKS cluster monitoring the nimbus-site deployment.

Cluster Overview

CPU usage vs requests & limits

Memory usage vs requests & limits

High-level capacity visibility

CPU Usage & Quotas

Per-pod CPU usage

Requests and limits enforcement

Supports capacity planning and autoscaling decisions

Memory Usage

Pod-level memory consumption

Early detection of memory pressure and OOM risk

Network Metrics

Bytes transmitted and received

Packet rates per pod

Useful for diagnosing traffic spikes or connectivity issues

Storage I/O

Read/write IOPS

Storage throughput per pod

Identifies disk bottlenecks for stateful workloads

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
│   ├── terminalmonitoring*.png
│   ├── setupmonitoring.sh*.png
│   └── welcometografana.png
│
└── README.md

🧠 Skills Demonstrated
Kubernetes Observability

kube-prometheus-stack deployment

Prometheus metric scraping

Grafana dashboard provisioning

Namespace-level monitoring

DevOps Automation

Bash scripting

Helm package management

Repeatable, idempotent deployments

Cloud Engineering (AKS)

LoadBalancer services

Secure access patterns

Production-style cluster monitoring

SRE & Reliability Practices

Metric-driven visibility

Resource utilisation analysis

Foundations for alerting with Alertmanager

👤 Author

Oluwaseyi Adesegun Bello
DevOps Engineer | MSc Human-Centred AI

🔗 GitHub: https://github.com/seyiabello

🔗 LinkedIn: https://www.linkedin.com/in/oluwaseyi-bello-2653a2215/
