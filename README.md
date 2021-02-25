## Teclogias e versões
```
Ruby - 2.7.1p83
Rails - 6.1.3
PostgreSql - 12.2-alpine
Node - 12.20.1
Angular CLI - 9.1.13
Docker-Compose -  1.27.4
Docker - 20.10.2
Sistema Operacional - Debian GNU/Linux 10 (buster)
```

## Escopo e solução aplicada
### Tarefa 1 - Ter uma tela (via um formulário) para fazer o upload do arquivo

Resolvido no projeto frontend, com um módulo de upload de arquivo do Angular chamado **angular-file-uploader**, onde o mesmo realiza uma request POST no projeto backend no endpoint **api/v1/importer/import_file**.

### Tarefa 2 - Interpretar ("parsear") o arquivo recebido, normalizar os dados, e salvar corretamente a informação em um banco de dados relacional, **se atente as documentações** que estão logo abaixo.

Resolvido no projeto do backend, através do service Importer, onde o mesmo, interpreta o arquivo que foi realizado o upload na tarefa anterior, e transforma as informações em hash, para poder salvar no banco de dados cada entidade, sendo a entidade Cliente (Customer), Fornecedor (Provider) e Transação (Transaction).

### Tarefa 3 - Exibir uma lista das operações importadas por lojas, e nesta lista deve conter um totalizador do saldo em conta

Resolvido na tela inicial do projeto frontend, onde foi disponibilizado um endpoint GET no projeto backend (**api/v1/transactions**) para listar a relação dos Fornecedor e o total de saldo em contas das transações realizadas.

### Tarefa 4 - Ser escrita obrigatoriamente em Ruby 2.0+
O projeto foi desenvolvido na versão **2.7.1p83**.

### Tarefa 5 - Ser simples de configurar e rodar, funcionando em ambiente compatível com Unix (Linux ou Mac OS X). Ela deve utilizar apenas linguagens e bibliotecas livres ou gratuitas.
Contemplado e descrito no tópico **Teclogias e versões**.

## Configuração dos projetos
### Setup Backend com Docker
```console
$ cd backend
$ docker-compose build && docker-compose up -d
$ docker-compose run web rake db:setup db:create db:migrate
```

### Setup Backend sem Docker
```console
$ cd backend
$ bundle install
$ rails db:setup db:crete db:migrate
$ yarn instal --check-files
```

#### Observação
Necessário alterar as configurações do **database.yml** do projeto do backend, informando o novo banco de dados, já que o projeto do backend o banco de dados encontra-se "dockerizado".

### Setup Frontend com Docker
```console
$ cd frontend
$ docker-compose build && docker-compose up -d
```

### Setup Frontent sem Docker
```console
$ cd frontend
$ npm install
$ npm run start
```
## Specs
Foi criado testes unitários para o projeto do backend, onde foi realizado testes de cenários de sucesso e falha.

### Setup dos specs
```console
$ cd backend
$ bundle exec rspec spec
Finished in 0.6387 seconds (files took 1.2 seconds to load)
13 examples, 0 failures
```
