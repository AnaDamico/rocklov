class LoginPage

    include Capybara::DSL

    def open
        visit "/"
    end

    def with (email, password)
        find('#user_email').set email
        find("#user_password").set password
        click_button "Entrar"
    end
end