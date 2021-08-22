describe "POST /equipos/{equipo_id}/bookings" do

    before(:all) do
        payload = { email: "phoebe@rocklov.com", password: "pwd123" }
        result = Sessions.new.login(payload)
        @x_id = result.parsed_response["_id"]
    end

    context "solicitar locacao" do
        
        before(:all) do

            # dado que chandler tem um equipamento para locação

            result = Sessions.new.login({ email: "chandler@rocklov.com", password: "pwd123" })
            chandler_id = result.parsed_response["_id"]

            equipamento = {
                thumbnail: Helpers::get_thumb("violino.jpg"),
                name: "Violino do Titanic",
                category: "Cordas",
                price: 999,
            }

            MongoDB.new.remove_equipo(equipamento[:name], chandler_id)

            result = Equipos.new.create(equipamento, chandler_id)
            chandler_equipo_id = result.parsed_response["_id"]


            # Solicitação de locação
            @result = Equipos.new.booking(chandler_equipo_id, @x_id)


        end

        it "deve retornar status 200" do
            expect(@result.code).to eql 200
        end

    end

end
