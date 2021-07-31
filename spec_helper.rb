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

Capybara.default_max_wait_time = 5
Capybara.javascript_driver = :selenium_chrome
RSpec.configure { Capybara.current_driver = :selenium_chrome }

Telegram.bots_config = { default: YAML.safe_load(File.read('telegram_bot.yml'))['CHAT_BOT_TOKEN'] }

DELICIOUS_PRICE = 16_000
PATHS = PathsHelpers.paths
HOME_PAGE_MVIDEO = PATHS[:home_page]
PREFERENCES_SITE = PreferencesSiteHelper.new
