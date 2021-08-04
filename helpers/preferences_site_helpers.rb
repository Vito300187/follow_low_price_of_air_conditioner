class PreferencesSiteHelper
  include Capybara::DSL

  def set_city(city)
    find(:xpath, '//a[contains(text(), "Выбрать город")]').click
    fill_in('Ваш город', with: city)
    puts "Введен город #{city}"

    all(:xpath, "//a[contains(@data-drop-item-name, '#{city}')]").first.click
    puts "Выбран город #{city}"
  end

  def scroll(action)
    move = { up: -10_000, down: 10_000 }[action]
    page.execute_script "window.scrollTo(0, #{move})"
    sleep 5
  end
end
