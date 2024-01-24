# frozen_string_literal: true

Дано('Открываю страницу регистрации') do
  visit new_user_registration_path
end

Тогда('Должен увидеть страницу регистрации') do
  expect(page).to have_current_path(new_user_registration_path, ignore_query: true)
  expect(page).to have_content('Sign up')
end

Когда('Ввожу свое имя, email, пароль и подтверждение пароля') do
  fill_in 'user_name', with: 'alex'
  fill_in 'user_email', with: 'example@example.com'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
end

Когда("Нажимаю 'Sign up'") do
  click_link_or_button 'commit'
end

Тогда('Происходит переход на страницу общего чата после регистрации') do
  common_room = Room.where(is_common: true).first
  expect(page).to have_current_path(room_path(common_room), ignore_query: true)
  expect(page).to have_content('Welcome! You have signed up successfully.')
end
