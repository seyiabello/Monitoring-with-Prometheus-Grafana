# 🔭 Monitoring Kubernetes with Prometheus & Grafana  
**Production-Style Observability on Azure Kubernetes Service (AKS)**

![AKS](https://img.shields.io/badge/Azure-Kubernetes%20Service-0078D4?logo=microsoftazure&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Observability-326CE5?logo=kubernetes&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Metrics%20Collection-E6522C?logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Visualization-F46800?logo=grafana&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-Deployment%20Automation-0F1689?logo=helm&logoColor=white)

---

## 📌 Overview

This project demonstrates a **production-style Kubernetes observability stack** deployed on **Azure Kubernetes Service (AKS)** using **Prometheus** for metrics collection and **Grafana** for visualization.

I automated deployment using **Helm** and a **Bash setup script**, validated the installation end-to-end, and captured live dashboards showing CPU, memory, networking, and storage metrics for running workloads (including `nimbus-site`).

🔗 **Repository:** https://github.com/seyiabello/Monitoring-with-Prometheus-Grafana

---

## ✅ What This Project Delivers

- Automated deployment of **kube-prometheus-stack** using Helm  
- Dedicated `monitoring` namespace for clean separation  
- Prometheus scraping cluster/node/pod metrics  
- Grafana exposed via AKS **LoadBalancer** with admin credentials stored in Kubernetes Secrets  
- Auto-provisioned dashboards from official Kubernetes mixins  
- Evidence dashboards for **CPU, memory, network, and storage I/O**  
- Alerting foundations via **Alertmanager** (installed with the stack)

---

## 🧠 Architecture Summary

**Prometheus → Grafana (Datasource) → Dashboards**

- **Prometheus** scrapes and stores time-series metrics from Kubernetes and nodes  
- **Grafana** queries Prometheus and visualizes metrics using imported dashboards  
- **kube-prometheus-stack** installs the complete observability suite (Prometheus, Grafana, Alertmanager, exporters, and dashboards)

---

## 🧱 Project Structure

```bash
Monitoring-with-Prometheus-Grafana/
├── code/
│   └── setup-monitoring.sh
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
└── README.md
⚙️ Installation & Automation (Bash + Helm)
I deployed the entire stack using a single Bash automation script:

bash
Copy code
code/setup-monitoring.sh
What the script automates
Adds the Prometheus Helm repository

Creates the monitoring namespace

Installs kube-prometheus-stack with Grafana + Prometheus exposed as LoadBalancers

Waits for pods to become Ready

Retrieves service external IPs

Retrieves and decodes Grafana admin password

Setup Script (Evidence)


▶️ Running the Setup Script (Deployment Evidence)
These screenshots show the stack being installed and validated in AKS.





🌐 Grafana Access
Grafana is exposed via AKS LoadBalancer:

text
Copy code
http://<EXTERNAL-IP>:31832
Grafana password is retrieved securely from Kubernetes secrets:

bash
Copy code
kubectl get secret -n monitoring kps-grafana \
  -o jsonpath='{.data.admin-password}' | base64 -d
Grafana Login Page (Evidence)

📊 Dashboard Provisioning (Evidence)
Once installed, the stack automatically imports Kubernetes dashboards (mixins) into Grafana.


These dashboards include coverage for:

Pods / namespaces / workloads

Node health and resource usage

Networking metrics

Control-plane components (API server, etcd, CoreDNS)

📈 Live Performance Metrics (Evidence)
Below are live screenshots from my AKS cluster monitoring workloads (including nimbus-site).

🧾 Cluster Headlines (CPU & Memory Overview)
This provides a high-level view of CPU and memory utilisation relative to requests/limits.


🧮 CPU Usage & Quota
Shows per-pod CPU usage and how it compares to Kubernetes resource allocations.


💾 Memory Usage
Highlights pod-level memory consumption, useful for detecting memory pressure and OOM risk.


📡 Network Bandwidth & Packets
Useful for detecting traffic spikes, throughput issues, or unexpected networking behaviour.



🧱 Storage I/O Distribution
Shows read/write activity and throughput patterns per pod, useful for diagnosing disk bottlenecks.


🔔 Alerting Foundations (Installed)
kube-prometheus-stack also installs Alertmanager and default alert rules.
This provides a strong foundation for production alerting workflows (Slack/PagerDuty/email integrations) even if not fully configured in this demo.

🚀 Skills Demonstrated
Kubernetes Observability
Prometheus scraping and metric retention

Grafana dashboards (Kubernetes mixins)

Namespace-based monitoring patterns

DevOps Automation
Helm-driven deployments

Bash scripting for repeatable installation and validation

Cloud Engineering (AKS)
LoadBalancer services and public exposure for dashboards

Namespace isolation and operational tooling

SRE Monitoring Practices
Resource utilisation analysis (requests vs limits)

Capacity planning signals

Network and storage observability

👤 Author
Oluwaseyi Adesegun Bello
DevOps Engineer | MSc Human-Centred AI

🔗 GitHub: https://github.com/seyiabello
🔗 LinkedIn: https://www.linkedin.com/in/oluwaseyi-bello-2653a2215/
