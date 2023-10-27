# Goliath National Bank

![](https://i.imgur.com/upxSyjW.png)

<p align="justify">
Você já se perguntou como é trabalhar em um dos maiores bancos do mundo? Como é ter acesso a oportunidades incríveis de negócios, viagens, festas e mulheres? Como é ser um vencedor em todos os sentidos? Então você precisa conhecer o Goliath National Bank!
</p>

<p align="justify">
No Goliath National Bank, nós não somos apenas um banco, nós somos uma potência global. Nós financiamos projetos de bilhões de dólares, como a nova sede do banco em Manhattan, um arranha-céu de 70 andares que vai mudar o skyline da cidade. Nós temos parcerias com as maiores empresas e governos do mundo, como a Microsoft, a Apple, a China e a Suécia. Nós somos responsáveis por movimentar trilhões de dólares todos os dias, com segurança, rapidez e eficiência.
</p>

<p align="justify">
Mas o que realmente faz o Goliath National Bank ser o melhor banco do mundo são as pessoas que trabalham aqui. Pessoas como eu, que são inteligentes, talentosas, carismáticas e bonitas. Pessoas que sabem como se divertir e aproveitar a vida. Pessoas que não se contentam com o medíocre, mas que buscam sempre a excelência. Pessoas que seguem o meu lema: “<i>When I get sad, I stop being sad and be awesome instead</i>”.
</p>

<p align="justify">
Então, se você quer fazer parte dessa equipe vencedora, se você quer ter uma carreira de sucesso e uma vida de aventuras, se você quer ser um GNBer, como nós chamamos os nossos funcionários, não perca tempo e envie o seu currículo hoje mesmo para o Goliath National Bank. E prepare-se para entrar em um mundo onde tudo é possível. Um mundo onde você vai dizer: “<i>Legen… wait for it… dary!</i>”

Goliath National Bank (membro FDIC)
</p>

## Testando a API

A API recebeu deploy em: [https://goliathnationalbank.fly.dev/api/](https://goliathnationalbank.fly.dev/api/)

## Endpoints Abertos

### Criar um Usuário 

<details>

**Verbo HTTP**: POST

**URL**: `localhost:4000/api/users`

**Descrição**: Cria um usuário. 

```json
{
    "first_name": "Barney",
    "last_name": "Stinson",
    "password": "legendary",
    "cpf": "10284420093"
}
```

</details>

### Login 

<details>

**Verbo HTTP**: POST

**URL**: `localhost:4000/api/users/login`

**Descrição**: Loga o um usuário, retorna o Token. 

```json
{
    "id": 8,
    "password": "legendary"
}
```

</details>

## Endpoints Protegidos

### Busca um Usuário

<details>

**Verbo HTTP**: GET

**URL**: `localhost:4000/api/users/9`

**Descrição**: Busca um usuário pelo ID.

</details>

### Edita um Usuário

<details>

**Verbo HTTP**: PUT

**URL**: `localhost:4000/api/users/8`

**Descrição**: Edita a informação do usuário especificado. 

```json
{
    "first_name": "Jim",
    "last_name": "Nacho"
}
```

</details>

### Deleta um Usuário

<details>

**Verbo HTTP**: DELETE

**URL**: `localhost:4000/api/users/8`

**Descrição**: Deleta um usuário pelo ID.

</details>

### Lista todos os Usuários

<details>

**Verbo HTTP**: GET

**URL**: `localhost:4000/api/users/`

**Description**: Recebe uma lista de todos os usuários cadastrados.

</details>

### Cria uma Conta

<details>

**Verbo HTTP**: POST

**URL**: `localhost:4000/api/accounts`

**Descrição**: Cria uma conta para o usuário passado com o saldo inicial passado. 

```json
{
	"user_id": 5,
	"balance": 2894.12
}
```

</details>

### Recebe o Saldo de uma Conta

<details>

**Verbo HTTP**: GET

**URL**: `localhost:4000/api/accounts/balance/2`

**Descrição**: Retorna o saldo de uma conta.

</details>

### Cria uma Transação entre Contas

<details>

**Verbo HTTP**: POST

**URL**: `localhost:4000/api/transactions`

**Descrição**: Create a transaction with the following JSON data in the request body:

```json
{
    "sender_id": 2,
    "receiver_id": 3,
    "amount": 123.67
}
```
</details>

### Lista Transações entre Datas

<details>

**Verbo HTTP**: GET

**URL**: `localhost:4000/api/transactions/2023-10-01/2023-10-31`

**Descrição**: Retorna todas as transações feitas entre a data inicial e a final.

</details>

## Rodando o Projeto Local

Clonar esse repositório, instalar o PostgreSQL e fazer as configurações de comunicação em `config/dev.exs` e então rodar:
``` 
$ mix do setup, phx.server
```
E então o servidor vai iniciar em [http://localhost:4000/api](http://localhost:4000/api) e então acessar algum dos endpoints como na doc passando as informações necessárias.

Para rodar os testes:
``` 
$ mix test
```