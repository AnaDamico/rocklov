describe "POST /signup" do

    context "novo usuario" do
        before(:all) do
            payload = { name: "Joao", email: "joao@rocklov.com", password: "pwd123"}
            MongoDB.new.remove_user(payload[:email])
            @result = Signup.new.create(payload)
        end

        it "Valida status code" do
            expect(@result.code).to eql 200
        end
        
        it "valida id do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end

    context "usuario já existe" do
        before(:all) do
            payload = { name: "Maria", email: "maria@rocklov.com", password: "pwd123"}
            MongoDB.new.remove_user(payload[:email])
            Signup.new.create(payload)
            @result = Signup.new.create(payload)
        end

        it "Valida status code 409" do
            expect(@result.code).to eql 409
        end
        
        it "deve retornar mensagem" do
            expect(@result.parsed_response["error"]).to eql "Email already exists :("
        end
    end

    examples = Helpers::get_fixture("cadastro")

    examples.each do |e|

        context "#{e[:title]}" do
            before(:all) do
                @result = Signup.new.create(e[:payload])
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