module LinkHelpers
  def self.get_item_link(item)
    {
      url: "https://www.mvideo.ru#{item.xpath(PATHS[:url_item]).first['href']}",
      image: item.xpath('.//img').first.attributes['src'].value,
      description: item.xpath(PATHS[:description_item]).xpath('.//h3').text.strip,
      price: item.xpath(PATHS[:price_item]).text.strip.split.first.gsub(' ', '').to_i
    }
  end
end
