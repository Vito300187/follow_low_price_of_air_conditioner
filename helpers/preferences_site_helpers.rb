class PreferencesSiteHelper
  include Capybara::DSL

  def set_city(city)
    find(:xpath, '//a[contains(text(), "Выбрать город")]').click
    fill_in('Ваш город', with: city)
    puts "Введен город #{city}"

    all(:xpath, "//a[contains(@data-drop-item-name, '#{city}')]").first.click
    puts "Выбран город #{city}"
  end
end
