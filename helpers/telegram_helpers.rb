module TelegramHelpers
  def self.send_in_message(items)
    return if items.empty?

    chat_id = Telegram.bot.get_updates['result'].last['message']['chat']['id']
    items.each do |item|
      Telegram.bots[:default].send_message(
        chat_id: chat_id,
        text: "#{item[:description]} - #{item[:price]} руб. ( #{item[:url]}# )}"
      )
    end
  end
end
