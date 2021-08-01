# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'nokogiri'
require 'pry'
require 'selenium/webdriver'
require 'telegram/bot'
require 'yaml'
require_relative 'helpers/path_helpers'
require_relative 'helpers/preferences_site_helpers'

if !File.file?('telegram_bot.yml') || File.empty?('telegram_bot.yml')
  raise 'Sorry, but you need to create file named `telegram_bot.yml` and set `CHAT_BOT_TOKEN: ...`'
end

def chrome_version
  `chromedriver -v`.split(' ')
    .reject { |a| a == 'ChromeDriver' }
    .first
    .split('.')[0] << '.0'
end

def wait_minutes(count)
  puts Time.now.strftime('%d/%m/%y - %H:%M')
  page.refresh
  sleep 60 * count
end

Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :remote_chrome
  config.javascript_driver = :remote_chrome
end
Capybara.register_driver(:remote_chrome) do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome
  caps[:browser_name] = 'chrome'
  caps[:version] = chrome_version
  caps['enableVNC'] = true
  caps['sessionTimeout'] = '720h'
  caps['goog:chromeOptions'] = { 'args' => %w[--no-sandbox] }
  opts = {
    browser: :remote,
    url: 'http://localhost:4444/wd/hub',
    desired_capabilities: caps
  }
  Capybara::Selenium::Driver.new(app, **opts)
end
RSpec.configure { Capybara.page.driver.browser.manage.window.maximize }
Telegram.bots_config = { default: YAML.safe_load(File.read('telegram_bot.yml'))['CHAT_BOT_TOKEN'] }

DELICIOUS_PRICE = ENV['PRICE'].nil? ? 20_000 : ENV['PRICE']
PATHS = PathsHelpers.paths
HOME_PAGE_MVIDEO = PATHS[:home_page]
PREFERENCES_SITE = PreferencesSiteHelper.new
