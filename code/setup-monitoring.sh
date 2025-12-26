#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
NS="monitoring"
RELEASE="kps" # release name for the chart
CHART="prometheus-community/kube-prometheus-stack"
CHART_VERSION="57.2.1" # pin a known-good version

# Service types (AKS will provision public IPs for these)
PROM_SVC_TYPE="LoadBalancer"
GRAF_SVC_TYPE="LoadBalancer"

echo "[1/6] Add/update Helm repo https://prometheus-community.github.io/helm-charts"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

echo "[2/6] Create namespace if missing: ${NS}"
kubectl get ns "${NS}" >/dev/null 2>&1 || kubectl create ns "${NS}"

echo "[3/6] Install/upgrade kube-prometheus-stack (Helm v4 compatible - no include-crds)"
helm upgrade --install "${RELEASE}" "${CHART}" \
  --namespace "${NS}" \
  --create-namespace \
  --version "${CHART_VERSION}" \
  --set prometheus.service.type="${PROM_SVC_TYPE}" \
  --set grafana.service.type="${GRAF_SVC_TYPE}"

echo "[4/6] Wait for pods to be Ready"
kubectl wait --namespace "${NS}" \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/instance="${RELEASE}" \
  --timeout=5m

echo "[5/6] Get external IPs (may show <pending> for ~1–2 minutes)"
echo "Grafana service:"
kubectl get svc -n "${NS}" -l app.kubernetes.io/name=grafana
echo
echo "Prometheus service:"
kubectl get svc -n "${NS}" -l app.kubernetes.io/name=prometheus
echo

echo "[6/6] Show Grafana admin password"
kubectl get secret -n "${NS}" "${RELEASE}-grafana" -o jsonpath='{.data.admin-password}' | base64 -d; echo
echo "Username: admin"

echo "Tip: If EXTERNAL-IP is <pending>, wait 60–90 seconds and re-check:"
echo "kubectl get svc -n ${NS}"

