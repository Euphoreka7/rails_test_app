# Моя реализация тестового задания:

Мы создаём мобильные приложения и иногда для тестирования гипотез приходится запускать AB-тесты. Для этого нам нужна система, представляющая собой простейшее REST API, состоящее из одного эндпойнта.

## API и распределение

Мобильное приложение при запуске генерирует некоторый уникальный ID клиента (который сохраняется между сессиями) и запрашивает список экспериментов, добавляя HTTP-заголовок `Device-Token`. В ответ сервер отдаёт список экспериментов. Для каждого эксперимента клиент получает:

* Ключ: имя эксперимента. В клиенте есть код, который будет изменять какое-то поведение в зависимости от значения этого ключа
* Значение: строка, одна из возможных опций (см. ниже)

Важно, чтобы девайс попадал в одну группу и всегда оставался в ней.

## Эксперименты
### 1. Цвет кнопки

У нас есть гипотеза, что цвет кнопки «купить» влияет на конверсию в покупку

* Ключ: `button_color`
* Опции:
  * `#FF0000` → 33.3%
  * `#00FF00` → 33.3%
  * `#0000FF` → 33.3%

Так после 600 запросов к API с различными `DeviceToken` каждый цвет должны получить по 200 девайсов

### 2. Стоимость покупки

У нас есть гипотеза, что изменение стоимости покупки в приложении может повлять на нашу маржинальную прибыль. Но чтобы не терять деньги в случае неудачного эксперимента, 75% юзеров будут получать старую цену и только на малой части аудитории мы протестируем изменение:

* Ключ `price`
* Опции:
  * `10` → 75%
  * `20` → 10%
  * `50` → 5%
  * `5` → 10%


## Требования и ограничения

1. Если девайс однажды получил значение, то он всегда будет получать только его
1. Эксперимент проводится только для новых девайсов: если эксперимент создан после первого запроса от девайса, то девайс не должен ничего знать об этом эксперименте

## Задание

1. Спроектируйте, опишите и реализуйте API
2. Добавьте эксперименты (1) и (2) в приложение
3. Создайте страницу для статистики: простая таблица со списком экспериментов, общее количество девайсов, участвующих в эксперименте и их распределение между опциями

Можно использовать любые тенхологии и библиотеки

Плюсом будет:

* Наличие тестов
* Задеплоенная версия приложения
* Скорость ответа от сервера <100ms
