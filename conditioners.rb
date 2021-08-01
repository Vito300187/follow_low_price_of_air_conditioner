# frozen_string_literal: true

require_relative './spec_helper'
require_relative 'helpers/telegram_helpers'
require_relative 'helpers/link_helpers'

feature 'Feature for' do
  scenario 'Test for' do
    include TelegramHelpers
    include LinkHelpers

    visit HOME_PAGE_MVIDEO
    PREFERENCES_SITE.set_city(ENV['CITY'] || 'Краснодар')

    loop do
      wait_minutes(5)
      items = Nokogiri::HTML.parse(source).xpath(PATHS[:products_block]).map do |product|
        LinkHelpers.get_item_link(product)
      end.reject { |item| item[:price] > DELICIOUS_PRICE }

      TelegramHelpers.send_in_message(items)
    end
  end
end
