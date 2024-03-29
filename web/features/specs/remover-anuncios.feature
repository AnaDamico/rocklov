#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter meu Dashboard atualizado

    Contexto: Login
        * Login com "fred@rocklov.com" e "pwd123"


    Cenario: Remover um anúncio

        Dado que eu tenho um anúncio indesejado:
            | thumb     | telecaster.jpg    |
            | nome      | Telecaster        |
            | categoria | Cordas            |
            | preco     | 50                |
        Quando quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item em meu Dashboard
       

    Cenario: Cancelar a exclusão de um anúncio

        Dado que eu tenho um anúncio indesejado:
            | thumb     | conga.jpg    |
            | nome      | Conga        |
            | categoria | Outros       |
            | preco     | 100          |
        Quando quando eu solicito a exclusão desse item
            Mas não confirmo a exclusão
        Então esse item deve permanecer no meu Dashboard