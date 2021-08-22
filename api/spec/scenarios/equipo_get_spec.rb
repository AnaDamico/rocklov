describe "GET /equipos/{equipo_id}" do
  before(:all) do
    @payload = { email: "anunciante@rocklov.com", password: "pwd123" }
    result = Sessions.new.login(@payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("trompete.jpg"),
        name: "Trompete",
        category: "Outros",
        price: 100,
      }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end

    it "deve retornar a categoria" do
      expect(@result.parsed_response).to include("category" => @payload[:category])
    end

    it "deve retornar o preço" do
      expect(@result.parsed_response).to include("price" => @payload[:price])
    end
  end

  context "equipamento não existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "joao_oli@rocklov.com", password: "pwd123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter a listagem de equipamentos" do
    before(:all) do
      payloads = [{
          thumbnail: Helpers::get_thumb("violao-nylon.jpg"),
          name: "Violao",
          category: "Cordas",
          price: 531,
        },
        {
                 thumbnail: Helpers::get_thumb("slash.jpg"),
                 name: "Guitarra",
                 category: "Cordas",
                 price: 821,
               },
        {
          thumbnail: Helpers::get_thumb("trompete.jpg"),
          name: "Trompete Novo",
          category: "Outros",
          price: 459,
        }]

      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar 200" do 
        expect(@result.code).to eql 200
    end

    it "deve retornar uma lista de equipamentos" do 
        expect(@result.parsed_response).not_to be_empty
        # puts @result.parsed_response
        # puts @result.parsed_response.class
    end

  end
end
