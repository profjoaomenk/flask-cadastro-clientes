#!/bin/bash

# ==========================================================
# DEPLOY FLASK NO AZURE APP SERVICE
#
# Executar no Azure Cloud Shell - Bash
#
# Fluxo:
# GitHub
#   ↓
# Resource Group
#   ↓
# App Service Plan
#   ↓
# Web App
#   ↓
# az webapp deploy
# ==========================================================

set -euo pipefail


# ==========================================================
# CONFIGURAÇÕES
# ==========================================================

# Repositório GitHub contendo a aplicação Flask
#
# Altere para seu Repositório GitHub
#
#REPO_URL="https://github.com/SEU_GITHUB/flask-cadastro-clientes.git"
REPO_URL="https://github.com/profjoaomenk/flask-cadastro-clientes.git"

# Nome da pasta criada pelo git clone
PROJECT_DIR="flask-cadastro-clientes"

# Azure
RESOURCE_GROUP="rg-flask-demo"
#
# Altere para sua localização (Verifique as regiões na Política)
#
LOCATION="brazilsouth"

# App Service
APP_SERVICE_PLAN="plan-flask-demo"

#
# Altere para seu RM
#
APP_NAME="flask-cadastro-rm9999"

# Runtime Python
RUNTIME="PYTHON:3.14"

# SKU do App Service Plan
SKU="F1"

echo
echo "=================================================="
echo "1. CRIANDO RESOURCE GROUP"
echo "=================================================="
echo

az group create \
    --name "$RESOURCE_GROUP" \
    --location "$LOCATION" \
    --output table

echo

echo
echo "=================================================="
echo "2. CRIANDO APP SERVICE PLAN"
echo "=================================================="
echo

az appservice plan create \
    --name "$APP_SERVICE_PLAN" \
    --resource-group "$RESOURCE_GROUP" \
    --location "$LOCATION" \
    --sku "$SKU" \
    --is-linux \
    --output table

echo


echo
echo "=================================================="
echo "3. CRIANDO AZURE WEB APP - Serviço de Aplicativo"
echo "=================================================="
echo

az webapp create \
    --name "$APP_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --plan "$APP_SERVICE_PLAN" \
    --runtime "$RUNTIME" \
    --output table

echo

echo
echo "==========================================================="
echo "4. CONFIGURANDO BUILD DA APLICAÇÃO - VARIÁVEIS DE AMBIENTE"
echo "==========================================================="
#
# Configura as variáveis de ambiente necessárias ao projeto, poderiam ser: URL, Usuário e Senha de um Banco por exemplo
#
echo

az webapp config appsettings set \
    --name "$APP_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --settings \
        SCM_DO_BUILD_DURING_DEPLOYMENT=true

echo

echo
echo "====================================================="
echo "5. CONFIGURAR STARTUP COMMAND - CONFIGURANDO GUNICORN"
echo "====================================================="
#
# Quando iniciar este Web App, use o Gunicorn para executar a aplicação Flask que está no arquivo app.py
#
echo

az webapp config set \
    --name "$APP_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --startup-file "gunicorn --bind=0.0.0.0:8000 app:app"

echo

echo
echo "=================================================="
echo "6. REALIZANDO DEPLOY COM AZ WEBAPP DEPLOY"
echo "=================================================="
echo

#
# Zipar a aplicação
#
zip -r app.zip . -x "*.git*"

az webapp deploy \
    --name "$APP_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --src-path ./app.zip \
    --type zip

echo

echo
echo "=================================================="
echo "7. REINICIANDO WEB APP"
echo "=================================================="
echo

az webapp restart \
    --name "$APP_NAME" \
    --resource-group "$RESOURCE_GROUP"

echo

echo
echo "=================================================="
echo "DEPLOY CONCLUÍDO!"
echo "=================================================="
echo

echo "Resource Group:"
echo "$RESOURCE_GROUP"

echo
echo "App Service Plan:"
echo "$APP_SERVICE_PLAN"

echo
echo "Web App:"
echo "$APP_NAME"

echo
echo "URL da aplicação:"
echo "https://${APP_NAME}.azurewebsites.net"

echo
echo "=================================================="
echo "ACESSE A APLICAÇÃO:"
echo "https://${APP_NAME}.azurewebsites.net"
echo "=================================================="
echo
