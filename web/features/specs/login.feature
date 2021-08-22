#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "carolina@rocklov.com" "pwd123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenário: Tentar logar
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input | email_input          | senha_input | mensagem_output                  |
            | Carolina   | carolina@rocklov.com | abc123      | Usuário e/ou senha inválidos.    |
            | Carolina   | carol@rocklov.com    | pwd123      | Usuário e/ou senha inválidos.    |
            | Carolina   | carol##rocklov.com   | pwd123      | Oops. Informe um email válido!   |
            | Carolina   |                      | pwd123      | Oops. Informe um email válido!   |
            | Carolina   | carolina@rocklov.com |             | Oops. Informe sua senha secreta! |