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

7. Запрос с простыми условиями, условиями, содержащими IN или BETWEEN.
    ```sql
    SELECT *
    FROM flights
    WHERE arrival_airport IN ('LED', 'OVB')
    ORDER BY flight_no DESC;
    ```
8. Запросы с сортировкой по нескольким полям, направлениям.
    ```sql
    SELECT flight_id, flight_no, departure_airport, arrival_airport, aircraft_code
    FROM flights
    WHERE arrival_airport IN ('LED', 'OVB')
    ORDER BY flight_no, status, departure_airport DESC;
    ```
9. Запросы с использованием групповых операций (группировка статистические функции, отбор по групповым функциям).
    ```sql
    -- узнать количество рейсов для каждой комбинации flight_no, status и departure_airport, когда arrival_airport либо 'LED', либо 'OVB'
    SELECT flight_no, departure_airport, status, COUNT(*) AS "Number of Flights"
    FROM flights
    WHERE arrival_airport IN ('LED', 'OVB')
    GROUP BY flight_no, departure_airport, status
    ORDER BY flight_no, departure_airport, status;
    ```
10. Запросы с операцией над множествами (обязательно используя сортировку).
    ```sql
    -- Выбрать все уникальные аэропорты из таблицы flights, куда прибыли или откуда вылетели рейсы
    SELECT departure_airport
    FROM flights
    UNION
    SELECT arrival_airport
    FROM flights
    ORDER BY departure_airport;
    ```
11. Запросы на обновление.
    ```sql
    -- Обновить статус рейса
    UPDATE flights
    SET status = 'Delayed'
    WHERE flight_no = 'SU1001';
    ```
12. Запросы на удаление.
    ```sql
    DELETE FROM tickets WHERE ticket_no = '0005432000987';
    ```
13. Запросы на вставку.
    ```sql
    INSERT INTO tickets 
        (ticket_no, book_ref, passenger_id, passenger_name, contact_data) 
    VALUES ('0005432000987', '06B046', '8149 604011','VALERIY TIKHONOV','');
    ```
14. Используя таблицу с персональными данными из своей БД или demo БД в PostgreSQL отобразите список сотрудников/персон (указав их Фамилию И.
в одной колонке), которые в следующем месяце будут отмечать юбилей, с указанием возраста, даты рождения, даты юбилея. Заголовки должны
соответствовать шаблону вывода данных.
    ```sql
    -- Создание таблицы
    CREATE TABLE Client (
        client_id SERIAL PRIMARY KEY,
        second_name VARCHAR(255) NOT NULL,
        name VARCHAR(255) NOT NULL,
        date_of_birth DATE NOT NULL
    );
    ```
    
    ```sql
    -- Заполнение данными
    INSERT INTO Client (second_Name, name, date_of_birth) VALUES
        ('Иванов', 'Иван', '1955-12-19'),
        ('Петров', 'Петр', '1956-12-23'),
        ('Сидоров', 'Николай', '1957-12-09'),
        ('Кузнецов', 'Сергей', '1958-12-02'),
        ('Смирнов', 'Алексей', '1962-12-02'),
        ('Васильев', 'Василий', '1964-12-28'),
        ('Павлов', 'Павел', '1965-12-17'),
        ('Семенов', 'Семен', '1966-12-14'),
        ('Голубев', 'Глеб', '1967-12-11'),
        ('Виноградов', 'Виктор', '1968-12-24'),
        ('Богданов', 'Борис', '1970-12-05'),
        ('Воробьев', 'Валерий', '1971-12-21'),
        ('Федоров', 'Федор', '1972-12-18'),
        ('Михайлов', 'Михаил', '1973-12-07'),
        ('Беляев', 'Белла', '1974-12-20'),
        ('Тарасов', 'Тарас', '1976-12-13'),
        ('Белов', 'Борислав', '1977-12-03'),
        ('Комаров', 'Константин', '1978-12-22'),
        ('Орлов', 'Орест', '1980-12-01'),
        ('Киселев', 'Кирилл', '1981-12-26'),
        ('Макаров', 'Макар', '1982-12-15'),
        ('Андреев', 'Андрей', '1984-12-09'),
        ('Ковалев', 'Константин', '1985-12-02'),
        ('Ильин', 'Илья', '1986-12-25'),
        ('Гусев', 'Геннадий', '1988-12-19'),
        ('Титов', 'Тимофей', '1989-12-12'),
        ('Кузьмин', 'Кузьма', '1990-12-06'),
        ('Кудрявцев', 'Кузьма', '1993-12-18'),
        ('Баранов', 'Борис', '1995-12-21'),
        ('Куликов', 'Кирилл', '1998-12-24');
    ```
    
    ```sql
    SELECT
        CONCAT("second_name", ' ', LEFT("name", 1), '.') AS "ФИО",
        DATE_PART('year', AGE(NOW(), "date_of_birth")) AS "Возраст",
        "date_of_birth" AS "Дата рождения",
        "date_of_birth" + INTERVAL '1 year' * DATE_PART('year', AGE(NOW(), "date_of_birth")) AS "Дата юбилея"
    FROM Client
    WHERE
      DATE_PART('month', "date_of_birth") = DATE_PART('month', NOW() + INTERVAL '1 MONTH')
      AND DATE_PART('year', AGE(NOW(), "date_of_birth"))::integer % 5 = 4;
    ```