# Cadastro de Clientes

Aplicação web didática desenvolvida com Python e Flask para demonstrar
o deploy de uma aplicação no Azure App Service pelo CLI

## Funcionalidades

- Formulário com nome, CPF e telefone
- Envio por HTTP POST
- Mensagem de confirmação na página
- Sem banco de dados
- Sem persistência dos dados

> Aplicação exclusivamente demonstrativa. Não utilize dados pessoais
> reais. Os campos CPF e telefone não possuem validação de formato

## Tecnologias

- Python
- Flask
- Gunicorn
- HTML5
- CSS3
- Azure App Service

# Criando os Recursos e realizando o Deploy na Azure

Antes de executar o Script: 

1) Verifique se está em um terminal Bash
   
2) Verifique se está na conta da Azure correta

```bash
az account list -o table
```

3) Caso haja necessidade de trocar: 

```bash
az account set --subscription "nome-da-subscrição"
```

4) Realize o Clone do Projeto e entre no diretório criado

```bash
git clone https://github.com/profjoaomenk/flask-cadastro-clientes
```

```bash
cd flask-cadastro-clientes
```

5) Altere as variaveis: APP_NAME e LOCATION de acordo com a necessidade no arquivo: "deploy-azure.sh"

6) No terminal: 

```bash
chmod +x deploy-azure.sh
```
```bash
./deploy-azure.sh
```
