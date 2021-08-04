# frozen_string_literal: true

require_relative './spec_helper'
require_relative 'helpers/telegram_helpers'
require_relative 'helpers/link_helpers'

feature 'Feature for' do
  scenario 'Crawler' do
    include TelegramHelpers
    include LinkHelpers

    visit HOME_PAGE_MVIDEO
    PREFERENCES_SITE.set_city(ENV['CITY'] || 'Краснодар')

    loop do
      PREFERENCES_SITE.scroll(:down)
      wait_minutes(5)

      items_raw = Nokogiri::HTML.parse(source).xpath(PATHS[:products_block])
      puts 'Получение ссылок на url, image, description, price'

      items = items_raw.map { |product| LinkHelpers.get_item_link(product) }.
        reject { |item| item[:price] > DELICIOUS_PRICE }

      TelegramHelpers.send_in_message(items)
    end
  end
end
