-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Gets the description of the crime scene. Only one happened that day on that street.
-- Theft was at 10:15am at the Humphrey Street bakery. 3 witnesses. Littering at 16:36 and no witnesses.

 SELECT description
   ...>     FROM crime_scene_reports
   ...>     WHERE month = 7 AND day = 28
   ...>     AND street = 'Humphrey Street';

-- Get interview transcripts

SELECT name, transcript
   ...>     FROM interviews
   ...>     WHERE month = 7 AND day = 28;

-- | Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
-- | Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
-- | Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |


-- bakery security logs for license plates
SELECT hour, minute, activity, license_plate
   ...>    FROM bakery_security_logs
   ...>    WHERE month = 7 AND day = 28
   ...>    AND year = 2023
   ...>    AND hour = 10
   ...>    AND minute > 14 AND minute < 26
   ...> ;

-- | 10   | 16     | exit     | 5P2BI95       |
-- | 10   | 18     | exit     | 94KL13X       |
-- | 10   | 18     | exit     | 6P58WS2       |
-- | 10   | 19     | exit     | 4328GD8       |
-- | 10   | 20     | exit     | G412CB7       |
-- | 10   | 21     | exit     | L93JTIZ       |
-- | 10   | 23     | exit     | 322W7JE       |
-- | 10   | 23     | exit     | 0NTHK55

-- atm transactions from that day

SELECT *
   ...> FROM atm_transactions
   ...>     WHERE month = 7 AND day = 28 AND year = 2023
   ...>     AND atm_location = 'Leggett Street';
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     |
| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 275 | 86363979       | 2023 | 7     | 28  | Leggett Street | deposit          | 10     |
| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     |
| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
+-----+----------------+------+-------+-----+----------------+------------------+--------+

-- callers
ssqlite> SELECT caller, receiver, duration
   ...> FROM phone_calls
   ...>     WHERE month = 7 AND day = 28 AND year = 2023
   ...>     AND duration < 60;
+----------------+----------------+----------+
|     caller     |    receiver    | duration |
+----------------+----------------+----------+
| (130) 555-0289 | (996) 555-8899 | 51       |
| (499) 555-9472 | (892) 555-8872 | 36       |
| (367) 555-5533 | (375) 555-8161 | 45       |
| (499) 555-9472 | (717) 555-1342 | 50       |
| (286) 555-6063 | (676) 555-6554 | 43       |
| (770) 555-1861 | (725) 555-3243 | 49       |
| (031) 555-6622 | (910) 555-3251 | 38       |
| (826) 555-1652 | (066) 555-9701 | 55       |
| (338) 555-6650 | (704) 555-2131 | 54       |

-- NAMES OF BANK ACCOUNTS

sqlite> SELECT bank_accounts.person_id, people.name
   ...> FROM bank_accounts
   ...>     JOIN people ON person_id = people.id
   ...>     JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
   ...>     where atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.year = 2023
   ...>     AND atm_transactions.atm_location = 'Leggett Street';
+-----------+---------+
| person_id |  name   |
+-----------+---------+
| 686048    | Bruce   |
| 948985    | Kaelyn  |
| 514354    | Diana   |
| 458378    | Brooke  |
| 395717    | Kenny   |
| 396669    | Iman    |
| 467400    | Luca    |
| 449774    | Taylor  |
| 438727    | Benista |
+-----------+---------+

-- PEOPLE WHO LEFT BAKERY IN THAT TIME WINDOW

sqlite> SELECT people.name, bakery_security_logs.license_plate
   ...> FROM people
   ...>     JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
   ...>     WHERE bakery_security_logs.month = 7 AND bakery_security_logs.day = 28 AND bakery_security_logs.year = 2023
   ...>     AND bakery_security_logs.hour = 10
   ...>     AND bakery_security_logs.minute > 14 AND bakery_security_logs.minute < 26;
+---------+---------------+
|  name   | license_plate |
+---------+---------------+
| Vanessa | 5P2BI95       |
| Bruce   | 94KL13X       |
| Barry   | 6P58WS2       |
| Luca    | 4328GD8       |
| Sofia   | G412CB7       |
| Iman    | L93JTIZ       |
| Diana   | 322W7JE       |
| Kelsey  | 0NTHK55       |
+---------+---------------+

-- could be BRUCE, LUCA, IMAN

-- CALLER NAME
SELECT caller, receiver, duration, name
   ...> FROM phone_calls
   ...>    JOIN people ON phone_number = caller
   ...>     WHERE month = 7 AND day = 28 AND year = 2023
   ...>     AND duration < 60;

+----------------+----------------+----------+---------+
|     caller     |    receiver    | duration |  name   |
+----------------+----------------+----------+---------+
| (130) 555-0289 | (996) 555-8899 | 51       | Sofia   |
| (499) 555-9472 | (892) 555-8872 | 36       | Kelsey  |
| (367) 555-5533 | (375) 555-8161 | 45       | Bruce   |
| (499) 555-9472 | (717) 555-1342 | 50       | Kelsey  |
| (286) 555-6063 | (676) 555-6554 | 43       | Taylor  |
| (770) 555-1861 | (725) 555-3243 | 49       | Diana   |
| (031) 555-6622 | (910) 555-3251 | 38       | Carina  |
| (826) 555-1652 | (066) 555-9701 | 55       | Kenny   |
| (338) 555-6650 | (704) 555-2131 | 54       | Benista |
+----------------+----------------+----------+---------+

-- RECEIVER NAME

sqlite> SELECT caller, receiver, duration, name
   ...> FROM phone_calls
   ...>    JOIN people ON phone_number = receiver
   ...>     WHERE month = 7 AND day = 28 AND year = 2023
   ...>     AND duration < 60;
+----------------+----------------+----------+------------+
|     caller     |    receiver    | duration |    name    |
+----------------+----------------+----------+------------+
| (130) 555-0289 | (996) 555-8899 | 51       | Jack       |
| (499) 555-9472 | (892) 555-8872 | 36       | Larry      |
| (367) 555-5533 | (375) 555-8161 | 45       | Robin      |
| (499) 555-9472 | (717) 555-1342 | 50       | Melissa    |
| (286) 555-6063 | (676) 555-6554 | 43       | James      |
| (770) 555-1861 | (725) 555-3243 | 49       | Philip     |
| (031) 555-6622 | (910) 555-3251 | 38       | Jacqueline |
| (826) 555-1652 | (066) 555-9701 | 55       | Doris      |
| (338) 555-6650 | (704) 555-2131 | 54       | Anna       |
+----------------+----------------+----------+------------+


--- airport nonces

sqlite>  SELECT name, flights.hour
   ...> FROM people
   ...>     JOIN passengers ON people.passport_number = passengers.passport_number
   ...>     JOIN flights ON passengers.flight_id = flights.id
   ...>     JOIN airports ON flights.origin_airport_id = airports.id
   ...>     WHERE full_name LIKE 'Fiftyville%'
   ...>     AND name LIKE 'Bruce' OR name LIKE 'Luca' OR name LIKE 'Iman'
   ...>     ORDER BY flights.hour;
+-------+------+
| name  | hour |
+-------+------+
| Bruce | 8    |
| Luca  | 8    |
| Luca  | 13   |
| Iman  | 13   |
| Luca  | 18   |

sqlite> SELECT people.name, destination_airport.full_name AS destination_airport
   ...> FROM people
   ...> JOIN passengers ON people.passport_number = passengers.passport_number
   ...> JOIN flights ON passengers.flight_id = flights.id
   ...> JOIN airports AS destination_airport ON flights.destination_airport_id = destination_airport.id
   ...> JOIN airports AS origin_airport ON flights.origin_airport_id = origin_airport.id
   ...> WHERE (people.name LIKE 'Bruce' OR people.name LIKE 'Luca' OR people.name LIKE 'Iman')
   ...> ORDER BY flights.hour;
+-------+-------------------------------------+
| name  |         destination_airport         |
+-------+-------------------------------------+
| Bruce | LaGuardia Airport                   |
| Luca  | LaGuardia Airport                   |
| Luca  | Indira Gandhi International Airport |
| Iman  | Fiftyville Regional Airport         |
| Luca  | Fiftyville Regional Airport         |
