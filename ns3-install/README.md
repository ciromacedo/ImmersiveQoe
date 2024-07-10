# Instalação NS3
Procedimentos de instalação do NS3.
**Atenção: Todos os procedimentos de instalação devem ser executados com privilégios de root (SUDO SU).**

#### 1º Instalação das dependências
Install python + git + ansible:
```
sudo apt update && sudo apt -y install git && sudo apt -y install ansible
```

Clonar este repositório:
```
git clone https://github.com/rosanapilar/ImmersiveQoe.git
```

Acessar o diretório de instalação do NS3 e executar o playbook utilizando Ansible:
```
cd ImmersiveQoe/ns3-install &&  ansible-playbook -K ns3-install.yml
```
