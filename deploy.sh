#!/bin/bash

# Build Docker images
docker build -t frontend-app:latest ./frontend
docker build -t backend-app:latest ./backend

# Deploy to Kubernetes using Helm
helm install frontend ./charts/frontend
helm install backend ./charts/backend
