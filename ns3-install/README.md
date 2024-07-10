# Instalação NS3
Procedimentos de instalação do NS3.
**Atenção: Todos os procedimentos de instalação devem ser executados com privilégios de root (SUDO SU).**

#### 1º Instalação das dependências
Remover Python3.10 e instalar o Python3.9:
```
sudo apt remove python3.10 -y
sudo apt autoremove -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9 -y
sudo apt install python3.9-distutils -y
```

Install git + ansible:
```
sudo apt update && sudo apt -y install git && sudo apt -y install ansible && sudo apt -y install libgcrypt20-dev && sudo apt -y python3-empy
```

Clonar este repositório:
```
git clone https://github.com/rosanapilar/ImmersiveQoe.git
```

Acessar o diretório de instalação do NS3 e executar o playbook utilizando Ansible:
```
cd ImmersiveQoe/ns3-install &&  ansible-playbook -K ns3-install.yaml
```

Após a finalização abrir o arquivo
```
/root/ns-allinone-3.35/pybindgen-0.22.0/pybindgen/cppclass.py 
```

comentar
```
import collections
```

e adicionar
```
 try:
    from collections.abc import Callable
except ImportError:
    from collections import Callable
```

Os últimos passos visao corrigir BUG de compilação do python 3.10.12.

A execução do comando acima vai executar todos os procedimentos de instalação. O ambiente foi construído supondo um VM da DigitalOcean. O código Ansible vai instalar todas as dependencias, fazer o download do NS3 e instalar no direório root. Devido a quantidade de procedimentos o comando acima pode demorar alguns minutos. Execute o comando e aguarde. Vá acompanhando os logs do Teminal, caso algum erro venha a acontecer o mesmo será apresentado como FAIL em uma mensagem na cor vermelha.

## Resolução de Probelmas
### Limpar e recompilar o NS3 com Waf:
```
cd ~/ns-allinone-3.35/ns-3.35
./waf configure --enable-examples --enable-tests
./waf -v build
```

### Diferenças entre build.py e ./waf build
O arquivo **build.py** no diretório ns-allinone-3.35 é um script de conveniência fornecido pelo pacote ns-3 all-in-one. Esse script executa uma série de passos para configurar, compilar e instalar todos os componentes do pacote ns-3, incluindo possíveis dependências e subcomponentes. O comando **./waf build** localizado no diretório **ns-allinone-3.35/ns-3.35** é específico para a compilação do core do ns-3.

#### Quando Usar Cada Um
* **build.py:** Use este script quando estiver configurando e compilando o ns-3 pela primeira vez ou quando precisar garantir que todas as dependências e subcomponentes do pacote all-in-one sejam configurados e compilados corretamente.

* **./waf build:** Use este comando quando já tiver configurado o ns-3 e estiver recompilando após fazer modificações no código ou quando precisar apenas recompilar o core do ns-3 e os exemplos.