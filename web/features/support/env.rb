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

    Capybara.register_driver :selenium_chrome_headless do |app|
        version = Capybara::Selenium::Driver.load_selenium
        options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
        browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
          opts.add_argument('--headless')
          opts.add_argument('--disable-gpu')
          opts.add_argument('--disable-site-isolation-trials')
          opts.add_argument('--no-sandbox')
          opts.add_argument('--disable-dev-shm-usage')
        end

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