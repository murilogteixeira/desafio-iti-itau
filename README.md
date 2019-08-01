# Desafio

## Detalhes da solução 

Todo o aplicativo foi desenvolvido em Swift e implementado somente com frameworks nativas conforme solicitado.
A API foi construída em Node-Red com integração ao banco de dados NoSQL Cloudant, utilizando documentos em JSON para armazenar as informações. Para acessar o link da API [clique aqui](https://api-murilo.mybluemix.net/red/){:target="_blank"} e visualize toda a solução implementada.

## Rotas criadas

Foram criadas as seguintes todas para atender as necessidades da aplicação:
- /usuario/list -> lista o nome de todos os usuários;
- /usuario/search -> procura um usuário específico através do nome passado como parâmetro;
- /usuario/new -> cria um novo usuário com o nome passado por parâmetro;
- /conta/transfer -> realiza a transferência baseado nos valores passados por parâmetro pela aplicação;
- /usuario/delete -> deleta um usuário (não utilizado na aplicação, somente acessível com todos os dados do usuário necessário para exclusão);

Além dessas rotas utilizadas pela aplicação, foi criado uma rotina que zera o valor de limite de transferência diário todos os dias às 0h.

