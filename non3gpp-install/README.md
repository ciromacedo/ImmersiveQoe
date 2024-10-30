# Setup non3GPP
Passos para o setup do ambiente non3GPP.

### Ambiente
O conteúdo descrito neste repositório foi testado em um ambiente de nuvem da [Digital Occean](https://www.digitalocean.com/). 1ª VM onde o free5GC será executado (exceto N3IWF) e 2ª VM onde o N3IWF será executado, cada uma com as seguintes configurações:

* SO: Ubuntu 20.04 (LTS) x64
* Uname -r: 5.4.0-122-generic
* Memory: 4 GB
* Disk: 10 GB

#### Antes de começar
A configuração do ambiente de desenvolvimento é executada pelo Ansible. Antes de iniciar, é necessário acessar via SSH cada uma das VMs e executar o seguinte comando para instalar algumas dependências básicas.

```
sudo apt update && apt -y install python && sudo apt -y install git && sudo apt -y install ansible && sudo apt -y install net-tools && sudo apt -y install traceroute && sudo apt -y install wireless-tools
```