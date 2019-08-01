# Desafio

## Detalhes da solução 

Todo o aplicativo foi desenvolvido em Swift e implementado somente com frameworks nativas conforme solicitado.
A API foi construída em Node-Red com integração ao banco de dados NoSQL Cloudant, utilizando documentos em JSON para armazenar as informações. Para acessar o link da API [clique aqui](https://api-murilo.mybluemix.net/red/) e visualize toda a solução implementada.

## Rotas criadas

Foram criadas as seguintes rodas para atender as necessidades da aplicação:
- /usuario/list -> lista o nome de todos os usuários;
- /usuario/search -> procura um usuário específico através do nome passado como parâmetro;
- /usuario/new -> cria um novo usuário com o nome passado por parâmetro;
- /conta/transfer -> realiza a transferência baseado nos valores passados por parâmetro pela aplicação;
- /usuario/delete -> deleta um usuário (não utilizado na aplicação, somente acessível com todos os dados do usuário necessário para exclusão);

Além dessas rotas utilizadas pela aplicação, foi criado uma rotina que zera o valor de limite de transferência diário todos os dias às 0h. 

## Modelo de JSON adotado

Para a construção da API, utilizei o seguinte modelo de documento JSON:

```json
{
  "_id": "848145865434jbab11043fc190b8f834r",
  "_rev": "4-277dec832jabbedfd0f9cf2380d39234j",
  "name": "JOSE",
  "transferLimitUsed": 0,
  "account": {
    "balance": 5000,
    "historic": [
      {
        "description": "Saldo inicial",
        "value": 5000,
        "date": "29/7/2019"
      }
    ]
  },
  "savings": {
    "balance": 50000,
    "historic": [
      {
        "description": "Saldo inicial",
        "value": 50000,
        "date": "29/7/2019"
      }
    ]
  }
}
```

- id -> valor criado automaticamente pelo banco de dados para identificação do documento;
- rev -> valor criado automaticamente pelo banco de dados para identificação da revisão do documento;
- name -> nome do usuario;
- transferLimitUsed -> limite diário de transferência utilizado;
- account -> dados da conta corrente;
  - balance -> saldo da conta;
  - historic -> histórico da conta;
    - description -> descrição da transação;
    - value -> valor da transação;
    - date -> data da transação;
- savings -> dados da conta poupança;
  - balance -> saldo da poupança;
  - historic -> histórico da poupança;
    - description -> descrição da transação;
    - value -> valor da transação;
    - date -> data da transação;

## Forma de login

O login foi criado de maneira simples, apenas o nome do usuário é necessário e para cada nome só existe uma conta. Alguns nomes já foram inseridos durante os testes.
Caso o usuário tente realizar o login com um nome inexistente, a aplicação irá perguntar se o usuário deseja criar uma nova conta, assim como ao tentar criar uma conta que já existe, a aplicação vai perguntar se deseja acessar a conta existente.

## Alertas e atividade

Todos os erros e confirmações sao exibidos em forma de alerta para deixar o usuário por dentro de todas as informações, assim como também é exibido um activity indicator sempre que uma requisiçao está sendo realizada ao servidor.

## Telas

![Tela 1](imgs/tela1.png "Imagem da tela 1" | height=100)
