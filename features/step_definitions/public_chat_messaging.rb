# frozen_string_literal: true

Дано('Открываю главную страницу') do
  create(:user, email: 'example@example.com', password: 'password')
  create(:user)
  visit root_path
end

Когда('Ввожу email и password') do
  fill_in 'user_email', with: 'example@example.com'
  fill_in 'user_password', with: 'password'
end

И("Нажимаю 'Log in'") do
  click_link_or_button 'Log in'
end

Когда('Переходим в общий чат') do
  common_room = Room.where(is_common: true).first
  expect(page).to have_current_path(room_path(common_room), ignore_query: true)
  expect(page).to have_content('Signed in successfully.')
end

И('Ввожу сообщение в поле ввода чата') do
  fill_in 'message_content', with: 'Моё новое сообщение'
end

И("Нажимает кнопку 'Send'") do
  click_link_or_button 'Send'
end

Тогда('Происходит отравка сообщения в общий чат') do
  visit root_path
  within('.messages') do
    expect(page).to have_content('Моё новое сообщение')
  end
end
