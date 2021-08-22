describe "POST /sessions" do

    context "login com sucesso" do
    
        before(:all) do
            payload = { email: "carolina_silva@rocklov.com", password: "pwd123" }
            @result = Sessions.new.login(payload)
        end

        it "Valida status code" do
            expect(@result.code).to eql 200
            # puts result.parsed_response["_id"]
            # puts result.parsed_response.class
        end

        it "valida id do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end

    # Utilizando massa de teste no código
    # examples = [
    #     {
    #         title: "senha incorreta",
    #         payload: { email: "carolina@rocklov.com", password: "123456" },
    #         code: 401,
    #         error: "Unauthorized",
    #     },
    #     {
    #         title: "usuario não existe",    
    #         payload: { email: "404@rocklov.com", password: "123456" },
    #         code: 401,
    #         error: "Unauthorized",
    #     }
    # ]

    # Utilizando massa de teste com arquivos yml
    examples = Helpers::get_fixture("login")

    examples.each do |e|

        context "#{e[:title]}" do
            before(:all) do
                @result = Sessions.new.login(e[:payload])
            end
    
            it "Valida status code #{e[:code]}" do
                expect(@result.code).to eql e[:code]
            end
    
            it "Valida retorno não autorizado" do
                expect(@result.parsed_response["error"]).to eql e[:error]
            end
        end
    end
end
