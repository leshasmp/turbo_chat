# frozen_string_literal: true

Дано('Октрываем главную страницу') do
  create(:user, email: 'example@example.com', password: 'password')
  visit root_path
end

Тогда('Появится форма авторизации') do
  expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  expect(page).to have_content('Log in')
end

Когда('Вводим свой email и password') do
  fill_in 'user_email', with: 'example@example.com'
  fill_in 'user_password', with: 'password'
end

Когда('Нажимаем "Log in"') do
  click_link_or_button 'Log in'
end

Тогда('Происходит переход на страницу общего чата после авторизации') do
  common_room = Room.where(is_common: true).first
  expect(page).to have_current_path(room_path(common_room), ignore_query: true)
  expect(page).to have_content('Signed in successfully.')
end
