# Desafio programação - para vaga Back-end

Por favor leiam este documento do começo ao fim, com muita atenção.
O intuito deste teste é avaliar seus conhecimentos técnicos com o back-end, para ser mais específico em Ruby.

O teste consiste em parsear [este arquivo de texto (CNAB)](https://github.com/mlalbuquerque/desafio-ruby-backend/blob/master/CNAB.txt) e salvar suas informações (transações financeiras) em uma base de dados a critério do candidato.

Este desafio deve ser feito por você em sua casa.

# Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no Github (crie uma se você não possuir).
2. Em seguida, implemente o projeto tal qual descrito abaixo, em seu clone local.
3. Por fim, envie via email um arquivo patch para seu contato na Impulso.

# Descrição do projeto

Você recebeu um arquivo CNAB com os dados das movimentações finanaceira de várias lojas.
Precisamos criar uma maneira para que estes dados sejam importados para um banco de dados.

Sua tarefa é criar uma interface web que aceite upload do [arquivo CNAB](https://github.com/mlalbuquerque/desafio-ruby-backend/blob/master/CNAB.txt), normalize os dados e armazene-os em um banco de dados relacional e exiba essas informações em tela.

**Sua aplicação web DEVE:**

1. Ter uma tela (via um formulário) para fazer o upload do arquivo
2. Interpretar ("parsear") o arquivo recebido, normalizar os dados, e salvar corretamente a informação em um banco de dados relacional, **se atente as documentações** que estão logo abaixo.
3. Exibir uma lista das operações importadas por lojas, e nesta lista deve conter um totalizador do saldo em conta
4. Ser escrita obrigatoriamente em Ruby 2.0+
5. Ser simples de configurar e rodar, funcionando em ambiente compatível com Unix (Linux ou Mac OS X). Ela deve utilizar apenas linguagens e bibliotecas livres ou gratuitas.

**Sua aplicação web NÃO precisa:**

1. Lidar com autenticação ou autorização (pontos extras se ela fizer, mais pontos extras se a autenticação for feita via OAuth).
2. Ser escrita usando algum framework específico (mas não há nada errado em usá-los também, use o que achar melhor).

# Documentação do CNAB

| Descrição do campo  | Inicio | Fim | Tamanho | Comentário
| ------------- | ------------- | -----| ---- | ------
| Tipo  | 1  | 1 | 1 | Tipo da transação
| Data  | 2  | 9 | 8 | Data da ocorrência
| Valor | 10 | 19 | 10 | Valor da movimentação. *Obs.* O valor encontrado no arquivo precisa ser divido por cem(valor / 100.00) para normalizá-lo.
| CPF | 20 | 30 | 11 | CPF do beneficiário
| Cartão | 31 | 42 | 12 | Cartão utilizado na transação
| Hora  | 43 | 48 | 6 | Hora da ocorrência atendendo ao fuso de UTC-3
| Dono da loja | 49 | 62 | 14 | Nome do representante da loja
| Nome loja | 63 | 81 | 19 | Nome da loja

# Documentação sobre os tipos das transações

| Tipo | Descrição | Natureza | Sinal |
| ---- | -------- | --------- | ----- |
| 1 | Débito | Entrada | + |
| 2 | Boleto | Saída | - |
| 3 | Financiamento | Saída | - |
| 4 | Crédito | Entrada | + |
| 5 | Recebimento Empréstimo | Entrada | + |
| 6 | Vendas | Entrada | + |
| 7 | Recebimento TED | Entrada | + |
| 8 | Recebimento DOC | Entrada | + |
| 9 | Aluguel | Saída | - |

# Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
2. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
3. Você seguiu as instruções de envio do desafio?
4. Qualidade e cobertura dos testes unitários.

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.

---

Boa sorte!

### Teclogias e versões
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

### Escopo e solução aplicada
#### Tarefa 1 - Ter uma tela (via um formulário) para fazer o upload do arquivo

Resolvido no projeto frontend, com um módulo de upload de arquivo do Angular chamado **angular-file-uploader**, onde o mesmo realiza uma request POST no projeto backend no endpoint **api/v1/importer/import_file**.

#### Tarefa 2 - Interpretar ("parsear") o arquivo recebido, normalizar os dados, e salvar corretamente a informação em um banco de dados relacional, **se atente as documentações** que estão logo abaixo.

Resolvido no projeto do backend, através do service Importer, onde o mesmo, interpreta o arquivo que foi realizado o upload na tarefa anterior, e transforma as informações em hash, para poder salvar no banco de dados cada entidade, sendo a entidade Cliente (Customer), Fornecedor (Provider) e Transação (Transaction).

#### Tarefa 3 - Exibir uma lista das operações importadas por lojas, e nesta lista deve conter um totalizador do saldo em conta

Resolvido na tela inicial do projeto frontend, onde foi disponibilizado um endpoint GET no projeto backend (**api/v1/transactions**) para listar a relação do Fornecedor e o total de saldo em conta das transações realizadas.

#### Tarefa 4 - Ser escrita obrigatoriamente em Ruby 2.0+
O projeto foi desenvolvido na versão **2.7.1p83**.

#### Tarefa 5 - Ser simples de configurar e rodar, funcionando em ambiente compatível com Unix (Linux ou Mac OS X). Ela deve utilizar apenas linguagens e bibliotecas livres ou gratuitas.
Contemplado e descrito no tópico **Teclogias e versões**.

### Setup dos projetos
#### Setup Backend com Docker
```console
$ cd backend
$ docker-compose build && docker-compose up -d
$ docker-compose run web rake db:setup db:create db:migrate
```

#### Setup Backend sem Docker
```console
$ cd backend
$ bundle install
$ rails db:setup db:crete db:migrate
$ yarn instal --check-files
```

#### Observação
Necessário alterar as configurações do **database.yml** do projeto do backend, informando o novo banco de dados, já que o projeto do backend o banco de dados encontra-se "dockerizado".

#### Setup Frontend com Docker
```console
$ cd frontend
$ docker-compose build && docker-compose up -d
```

#### Setup Frontent sem Docker
```console
$ cd frontend
$ npm install
$ npm run start
```
### Specs
Foi criado testes unitários para o projeto do backend, onde foi realizado testes de cenários de sucesso e falha.

#### Setup dos specs
```console
$ cd backend
$ bundle exec rspec spec
Finished in 0.6387 seconds (files took 1.2 seconds to load)
13 examples, 0 failures
```
