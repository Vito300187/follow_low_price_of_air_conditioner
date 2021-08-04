class TelegramHelpers
  def self.send_in_message(items)
    (puts 'Nothing'; return) if items.empty?

    chat_id = Telegram.bot.get_updates['result'].last['message']['chat']['id']
    items.each do |item|
      item_info = "#{item[:description]} - #{item[:price]} руб. ( #{item[:url]} )"
      puts "Найден товар #{item_info}"

      Telegram.bots[:default].send_message(
        chat_id: chat_id,
        text: item_info
      )
    end
  end
end
