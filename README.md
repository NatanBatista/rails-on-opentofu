# rails-on-opentofu 🚀

Infraestrutura como Código (IaC) para deploy de uma aplicação **Ruby on Rails** simples, somente com uma página estática de apresentação e uma rota health check /up com retorno CODE 200 no **AWS Fargate**, usando **OpenTofu**.  
Automatiza a criação de:
- Cluster ECS
- Serviço ECS
- Task Definition
- Load Balancer
- Target Group
- Load balancer listener
- VPC e Subnets privadas
- Internet e NAT gateway
- Segurança com IAM Roles
- Injeção segura de Secrets no container

---

## 🚀 Tecnologias utilizadas

- **OpenTofu** (Fork open source ao Terraform)
- **AWS ECS**
- **AWS Fargate**
- **AWS ECR**
- **AWS VPC**
- **AWS Aplication Load Balancer**
- **AWS IAM**
- **Docker**
- **Ruby on Rails**

---

## 📦 Estrutura do projeto

```bash
.
├── main.tf             # Configuração principal
├── variables.tf        # Variáveis de entrada
├── providers.tf        # Configuração do provider AWS
├── modules/
│   ├── ecs/            # Definições ECS (Task Definition, Service)
│   ├── ecr/            # Configuração do repositório Docker ECR
│   ├── vpc/            # Rede (VPC, Subnets, etc.)
│   ├── load_balancer/  # Configuração do Load Balancer
│   └── security_groups/ # Regras de segurança (Security Groups)
└── README.md           # Este arquivo
```

---

## 🔥 Como rodar o projeto

### 1. Configurar AWS Credentials

Salve suas credenciais no arquivo `~/.aws/credentials`:

```ini
[default]
aws_access_key_id = SUA_ACCESS_KEY
aws_secret_access_key = SUA_SECRET_KEY
aws_session_token = SEU_SESSION_TOKEN
```

### 1.1 Verificar credenciais configuradas

Após configurar as credenciais, execute o comando abaixo para verificar se estão corretas:

```bash
aws sts get-caller-identity
```

Esse comando retorna informações sobre a identidade associada às credenciais configuradas.

### 2. Exportar variáveis de ambiente (se precisar)

```bash
export TF_VAR_container_image="sua-uri"
export TF_VAR_rails_master_key="sua-chave-secreta-aqui"
```

### 3. Inicializar o OpenTofu

```bash
tofu init
```

### 4. Planejar a infra

```bash
tofu plan
```

### 5. Aplicar a infra

```bash
tofu apply
```

---

## 🛡️ Role utilizada no `execution_role_arn`

Para o parâmetro `execution_role_arn`, foi utilizada uma Role já existente na AWS, chamada `LabRole`. Essa Role foi obtida através do recurso `data` do OpenTofu:

```hcl
data "aws_iam_role" "LabRole" {
  name = "LabRole"
}
```

Essa Role já estava previamente criada no ambiente AWS Academy, pois não era permitido criar novas Roles diretamente. Por isso, foi necessário reutilizar essa configuração existente.

---

## 🔍 Sobre o projeto

Esse projeto nasceu da necessidade de automatizar o deploy de um app Rails na AWS usando infraestrutura moderna e open source.

O objetivo principal foi automatizar um projeto desenvolvido na disciplina de **Computação em Nuvem**, cursada na **Universidade Federal de Sergipe (UFS)**. 

A ideia foi criar ambientes escaláveis e seguros, reduzindo a configuração manual e aumentando a produtividade.


---

## 👨‍💻 Autor

Feito por [Natan da Silva Batista](https://www.linkedin.com/in/natan-batista-5589aa1bb/)

Se quiser bater um papo sobre cloud, IaC ou desenvolvimento, chama lá no LinkedIn! 👋