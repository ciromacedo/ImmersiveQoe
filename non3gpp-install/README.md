# Setup non3GPP
Passos para o setup do ambiente non3GPP.

### Ambiente
O conteúdo descrito neste repositório foi testado em um ambiente de nuvem da [Digital Occean](https://www.digitalocean.com/). 1ª VM onde o free5GC será executado (exceto N3IWF) e 2ª VM onde o N3IWF será executado, cada uma com as seguintes configurações:

* SO: Ubuntu 20.04 (LTS) x64
* Uname -r: 5.4.0-122-generic
* Memory: 4 GB
* Disk: 10 GB

#### Antes de começar
A configuração do ambiente de desenvolvimento é executada pelo Ansible. Antes de iniciar, é necessário instalar na sua máquina (supondo que ela será a máquina do operador, que vai acessar via SSH as VMs e instalar os elementos) o ansible. Abra o terminal da sua máquina e execute o comando a seguir:
```
sudo apt update && apt -y install python && sudo apt -y install git && sudo apt -y install ansible
```

Para que o ansible consiga acessar as VMs e executar o processo de instalação é necessário ter acesso root através de chaves SSH.  Isso é feito por meio de uma troca de chaves SSH, conforme descrito a seguir:

* Gerando a chave SSH:
```
ssh-keygen -t ecdsa -b 521
```
obs: após a execução do comando acima precione ENTER 3x.

* Após gerar, vamos copiar a chave para cada uma das VMs:
```
ssh-copy-id -i ~/.ssh/id_ecdsa.pub root@<free5gc-ip-address>
ssh-copy-id -i ~/.ssh/id_ecdsa.pub root@<n3iwf-ip-address>
ssh-copy-id -i ~/.ssh/id_ecdsa.pub root@<ue-non3gpp-ip-address>
```

Após copiar, é necessário testar o acesso a cada uma das VMs. É importante verificar se o acesso é root, pois o Ansible necessita de controle total para executar o setup dos componentes.


### Procedimento para o Setup do Ambiente
Primeiro vamos clonar o repositório através do comando a seguir:
```
apt update && git https://github.com/ciromacedo/ImmersiveQoe.git 
```

Após clonar o projeto, é necessário editar o arquivo **hosts**, localizado em _ImmersiveQoe/non3gpp-install_. O arquivo _hosts_ contém 3 hosts mapeados (_fee5gc-core_, _fee5gc-n3iwf_ e _labora-UE-non3GPP_). Vamos configurar fee5gc-core e fee5gc-n3iwf.

Vamos começar com as configurações do host responsável por executar o fee5gc-core.
* Substitua o primeiro marcador ```<IP-address>```, ilustrado na figura a seguir em vermelho, pelo endereço IP da VM onde o fee5gc-core será configurado.
<p align="center">
    <img src="../images/ip_free5gc_hosts.png"/> 
</p>


 via SSH cada uma das VMs e executar o seguinte comando para instalar algumas dependências básicas.

```
sudo apt update && apt -y install python && sudo apt -y install git && sudo apt -y install ansible && sudo apt -y install net-tools && sudo apt -y install traceroute && sudo apt -y install wireless-tools
```