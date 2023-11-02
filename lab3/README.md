# Отчет по третьей лабораторной работе

## Подключение к базе данных

- Запустите контейнер Docker
    ```shell
    docker run --rm --name pgdocker -e POSTGRES_PASSWORD=admin1234 -e POSTGRES_USER=admin -e POSTGRES_DB=surgu -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
    ```
    При необходимости замените значения флагов `POSTGRES_PASSWORD`, `POSTGRES_USER`, `POSTGRES_DB` на пользовательские значения.

- Подключитесь к созданной базе данных через интерфейс pgAdmin.

## Подготовка

- Скопируйте файл в контейнер Docker
  ```shell
  docker cp demo-small-20170815.sql pgdocker:/tmp/demo-small-20170815.sql
  ```
  
- Восстановите БД из dump-файла
  ```shell
  docker exec -it pgdocker psql -f /tmp/demo-small-20170815.sql -U admin -d surgu
  ```
  
## Учебные примеры

- Задание 1. Получите список аэропортов с указанием их кода и города из таблицы airports_data БД demo.
  ```sql
  SELECT airport_code, airport_name, city FROM airports_data;
  ```

- Задание 2. Получите список мест с указанием числа места (первые 2 символа), сектора (3 символ) места и класса (бизнес, 
эконом, комфорт), а также его идентификационного номера. Список должен быть упорядочен по номеру места.
  ```sql
  SELECT (SUBSTRING (seat_no,1,2) ||' '|| SUBSTRING (seat_no,3,1) ||' '|| fare_conditions )
      AS seats_class, aircraft_code FROM seats
  ORDER BY seat_no;
  ```
  
- Задание 3. Получите список самолётов, дальность полёта которых
находится в диапазоне от 3000 км до 6000 км, отсортировав его по
дальности.

  ```sql
  SELECT * FROM aircrafts
  WHERE (range>=3000) and (range<=6000)
  ORDER BY 3;
  ```
  
  ```sql
  SELECT * FROM aircrafts
  WHERE range BETWEEN 3000 and 6000
  ORDER BY 3;
  ```
  
- Задание 4. Выведите все кодировки самолётов, их модели и дальность
полёта, кроме самолётов модели Аэробус и Боинг.

  ```sql
  SELECT * FROM aircrafts
  WHERE model NOT LIKE 'Аэробус%'
  AND model NOT LIKE 'Боинг%';
  ```
  
- Задание 5. Получите список самолётов компаний модели Аэробус или Боинг

  ```sql
  SELECT * FROM aircrafts WHERE model ~ '^(А|Бои)';
  ```
  
- Задание 6. Получите список рейсов, у которых не указан ближайший вылет.

  ```sql
  SELECT * FROM flights WHERE actual_departure ISNULL;
  ```
  
## Самостоятельная работа

1. Запрос на полную выборку данных.
    ```sql
    SELECT * FROM airports_data;
    ```
2. Запрос на выборку данных без повторений.
    ```sql
    SELECT fare_conditions AS "Types of tariffs" FROM seats GROUP BY fare_conditions;
    ```
3. Запрос на выборку первых 10 записей.
    ```sql
    SELECT * FROM flights
    ORDER BY flight_id
    LIMIT 10;
    ```
4. Запрос на выборку последних 15 записей.
    ```sql
    SELECT * FROM flights
    ORDER BY flight_id DESC
    LIMIT 15;
    ```
5. Запросы на выполнение функций Average, Max, Min.
    ```sql
    SELECT min(amount) AS "Minimum price",
           max(amount) AS "Maximum price",
           round(avg(amount)) AS "Average price"
    FROM ticket_flights;
    ```
   
6. Сконструируйте запросы с использованием оператора Where:
    ```sql
    -- запрос на возвращение определенного кортежа по первичному ключу
    SELECT * FROM tickets WHERE ticket_no = '0005432000992';
    ```
    
    ```sql
    -- запросы на возвращение значения по условию больше
    SELECT * FROM bookings WHERE total_amount > 1000000 ORDER BY total_amount;
    ```
    
    ```sql
    -- запросы на возвращение значения по условию меньше
    SELECT * FROM bookings WHERE total_amount < 5000 ORDER BY total_amount;
    ```
    
    ```sql
    -- запросы на возвращение значения по условию между
    SELECT *
    FROM bookings
    WHERE total_amount BETWEEN 3000 and 4000
    ORDER BY total_amount;
    ```
    
    ```sql
    -- запросы на возвращении всех кортежей по условию с использованием оператора LIKE и ESCAPE
    SELECT *
    FROM airports_data
    WHERE timezone LIKE 'Asia/%' ESCAPE '!';
    ```
    
    ```sql
    -- запрос на возвращение кортежей со сложным условием на основе логических операторов И, ИЛИ, НЕ, EXISTS
    SELECT flight_id, flight_no, departure_airport, arrival_airport, aircraft_code
    FROM flights
    WHERE status = 'Arrived'
      AND (arrival_airport IN ('LED', 'OVB') OR departure_airport IN ('LED', 'OVB'))
      AND NOT flight_no = 'PG0405'
    ORDER BY flight_no DESC;
    ```
    
    ```sql
    -- запрос с использованием оператора NOT NULL в условии отбора.
    SELECT count(*) AS "Total flight"
    FROM flights
    WHERE actual_arrival NOTNULL;
    ```

7. Запрос с простыми условиями, условиями, содержащими IN или
BETWEEN.
8. Запросы с сортировкой по нескольким полям, направлениям.
9. Запросы с использованием групповых операций (группировка статистические функции, отбор по групповым функциям).
10. Запросы с операцией над множествами (обязательно используя сортировку).
11. Запросы на обновление.
12. Запросы на удаление.
13. Запросы на вставку.
14. Используя таблицу с персональными данными из своей БД или demo БД в PostgreSQL отобразите список сотрудников/персон (указав их Фамилию И.
в одной колонке), которые в следующем месяце будут отмечать юбилей, с указанием возраста, даты рождения, даты юбилея. Заголовки должны
соответствовать шаблону вывода данных.