# language: ru
Фича: Авторизация

  Сценарий: Авторизация пользователя
    Дано Октрываем главную страницу
    Тогда Появится форма авторизации
    Когда Вводим свой email и password
    И Нажимаем "Log in"
    Тогда Происходит переход на страницу общего чата после авторизации
