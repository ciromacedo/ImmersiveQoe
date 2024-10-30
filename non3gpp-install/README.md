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

* Acesse a VM do _fee5gc-core_, execute o comando ```ifconfig``` e anote o nome da interface de rede que dá acesso a internet **internet network interface**, conforme ilustrado a seguir:
<p align="center">
    <img src="../images/if_config.png"/> 
</p>
substitua o º marcador```<internet-network-interface>```, ilustrado na figura a seguir na cor vermelha, pelo nome da interface de rede que dá acesso a internet.
<p align="center">
    <img src="../images/ip_free5gc_hosts.png"/> 
</p>
Obs: Mantenha o parâmetro n3iwf_install com o valor FALSE para o host _fee5gc-core_

* Substitua o 3º marcador ```<IP-address>```, ilustrado na cor amarela na figura a seguir, pelo endereço IP da VM onde  _fee5gc-n3iwf_ será configurada.
* Substitua o 4º marcador ```<free5gc-core-IP-address>```, ilustrado na cor amarela na figura a seguir, pelo endereço IP da  VM onde o _fee5gc-core_ será configurado (mesmo endereço IP informado no 1º marcador).
<p align="center">
    <img src="../images/ip_free5gc_hosts.png"/> 
</p>

### Testando a conexão do Ansible
Agora vamos testar a conectividade do Ansible com os hosts configurados anteriormente. Em um terminal, dentro do diretório ```_ImmersiveQoe/non3gpp-install```, execute o comando a seguir:
```
ansible -i ./hosts -m ping all -u root
```
Deverá ser apresentado como resultado no terminal um _pong_ para  cada um dos hosts.

### Instalando GO via Ansible
O comando a seguir vai instalar a versão GO v.1.14 nas VMs do free5gc e da N3iwf. O comando deverá ser executado no termninal dentro do diretório ``_ImmersiveQoe/non3gpp-install```.

```
ansible-playbook ./go-install-1.14.yaml -i ./hosts
```

Diferentemente do free5gc e da n3iwf, o UE-non3GPP faz uso da versão 1.21 do Go. A instalação pode ser realizada com o comando abaixo:
```
ansible-playbook ./go-install-1.21.yaml -i ./hosts
```

Após a instalação é necessário entrar em cada uma das VMs e atualizar o bashrc com o comando a seguir:
```
source ~/.bashrc
```