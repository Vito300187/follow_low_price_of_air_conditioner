class PathsHelpers
  def self.paths
    {
      description_item: './/div[contains(@class, "fl-product-tile__description")]',
      home_page: 'https://www.mvideo.ru/promo/ustanovka-kondicionera-v-podarok-mark182891333?sort=priceLow',
      price_item: './/span[contains(@class, "fl-product-tile-price__current")]',
      products_block: '//div[contains(@data-sel, "product_tile-div")]',
      url_item: './/a[contains(@class, "fl-product-tile-picture__link")]'
    }
  end
end
