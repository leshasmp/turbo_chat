# language: ru
Фича: Личные сообщения

  Сценарий: Пользователь отправляет личное сообщение другому пользователю
    Дано Пользователь открывает страницу входа
    Когда Вводит email и пароль
    И Нажимает "Log in"
    Тогда Должен увидеть страницу общего чата
    Когда Нажимает пользователя в левом меню
    Тогда Происходит открытие чата с именем пользователя
    И Воодит сообщение в поле ввода чата
    И Нажимает кнопку "Send"
    Тогда Происходит отравка сообщения другому пользователю
