require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"

#CONFIG = YAML.load_file(File.join(Dir.pwd, "features\\support\\config\\#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
    @driver = :selenium
when "firefox_headless"
    @driver = :selenium_headless
when "chrome"
    @driver = :selenium_chrome
when "chrome_headless"
    @driver = :selenium_chrome_headless
else
    raise "Navegador Incorreto, variável @driver está vazia !!"
end

Capybara.configure do |config|

    #chrome = selenium_chrome / firefox = :selenium / _headless para ambos
    #config.default_driver = :selenium_chrome

    config.default_driver = @driver

    #config.app_host = CONFIG["url"]
    config.app_host = "http://rocklov-web:3000"

    config.default_max_wait_time = 15
end

AllureCucumber.configure do |config|
    config.results_directory = "/logs"
    config.clean_results_directory = true
end