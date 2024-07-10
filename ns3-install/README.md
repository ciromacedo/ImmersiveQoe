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
cd ImmersiveQoe/ns3-install &&  ansible-playbook -K ns3-install.yaml
```
A execução do comando acima vai executar todos os procedimentos de instalação. O ambiente foi construído supondo um VM da DigitalOcean. O código Ansible vai instalar todas as dependencias, fazer o download do NS3 e instalar no direório root. Devido a quantidade de procedimentos o comando acima pode demorar alguns minutos. Execute o comando e aguarde. Vá acompanhando os logs do Teminal, caso algum erro venha a acontecer o mesmo será apresentado como FAIL em uma mensagem na cor vermelha.