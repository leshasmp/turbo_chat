# frozen_string_literal: true

Дано('Пользователь открывает страницу входа') do
  create(:user, name: 'first', email: 'first@first.com', password: 'password')
  create(:user, name: 'second', email: 'second@second.com', password: 'password')
  visit root_path
end

Когда('Вводит email и пароль') do
  fill_in 'user_email', with: 'first@first.com'
  fill_in 'user_password', with: 'password'
end

И('Нажимает "Log in"') do
  click_link_or_button 'Log in'
end

Тогда('Должен увидеть страницу общего чата') do
  common_room = Room.where(is_common: true).first
  expect(page).to have_current_path(room_path(common_room), ignore_query: true)
  expect(page).to have_content('Signed in successfully.')
end

Когда('Нажимает пользователя в левом меню') do
  click_link_or_button 'second'
end

Тогда('Происходит открытие чата с именем пользователя') do
  expect(page).to have_css('h2', text: 'second')
end

И('Воодит сообщение в поле ввода чата') do
  fill_in 'message_content', with: 'Моё новое сообщение'
end

И('Нажимает кнопку "Send"') do
  click_link_or_button 'Send'
end

Тогда('Происходит отравка сообщения другому пользователю') do
  visit root_path
  click_link_or_button 'second'
  within('.messages') do
    expect(page).to have_content('Моё новое сообщение')
  end
end
