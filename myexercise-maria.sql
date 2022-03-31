-- WORLD DATABASE EXERCISES

-- Using COUNT, get the number of cities in the USA.
SELECT countrycode, COUNT(DISTINCT `name`) AS numberOfUSACities FROM city WHERE countrycode = 'USA';

-- Find out the population and life expectancy for people in Argentina.
use world;
SELECT AVG(Population and LifeExpectancy) AS populationAndLifeExpectancyArgentina FROM country;

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
use world;
SELECT * FROM country;
SELECT NAME,lifeExpectancy FROM country ORDER BY lifeExpectancy DESC LIMIT 1 ;

-- Using JOIN ... ON, find the capital city of Spain.
SELECT city.name, country.name
FROM country
LEFT JOIN city
ON country.capital=city.ID
AND country.code=city.countryCode
WHERE country.code='ESP';

-- Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT LANGUAGE,region
FROM countrylanguage
LEFT JOIN country
ON countrylanguage.CountryCode=country.code
WHERE country.region='Southeast Asia';

-- Using a single query, list 25 cities around the world that start with the letter F.
SELECT name FROM city WHERE SUBSTRING(name FROM 1 FOR 1) = 'F' LIMIT 25;

-- Using COUNT and JOIN ... ON, get the number of cities in China.
Select count(*) FROM city
JOIN country on city.CountryCode = Country.Code
WHERE country.Name='China';

-- Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
USE world;
SELECT * from country
WHERE Population IS NOT NULL and Population!='0' ORDER BY Population ASC LIMIT 1;

-- Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(name)
FROM country;

-- What are the top ten largest countries by area?
SELECT name, SurfaceArea
FROM country
ORDER BY SurfaceArea ASC LIMIT 10;

-- List the five largest cities by population in Japan.
SELECT population
FROM city where countrycode= 'jpn'
ORDER BY Population ASC LIMIT 5;

-- List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
Update country
SET HeadOfState='Elizabeth II'
Where HeadOfState='Elisabeth II';
SELECT name, code from country
WHERE HeadOfState='Elizabeth II';

-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT Name, (population/surfacearea) AS Ratio
FROM country where (population/surfacearea) != 0 ORDER BY Ratio ASC LIMIT 10;

-- List every unique world language.
SELECT DISTINCT language
FROM countrylanguage;

-- List the names and GNP of the world's top 10 richest countries.
SELECT name, GNP, Capital FROM country ORDER BY Capital DESC LIMIT 10;

-- List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT countryCode, language, IsOfficial as Top10
FROM countrylanguage where IsOfficial= 'T' order by Top10 desc limit 10 ;

-- List every country where over 50% of its population can speak German.
SELECT countryCode, language, Percentage
FROM countrylanguage where language='german' and Percentage >= '50';



-- Which country has the worst life expectancy? Discard zero or null values.
SELECT Name from country
WHERE LifeExpectancy IS NOT NULL and LifeExpectancy!='0' ORDER BY LifeExpectancy ASC LIMIT 1;

-- List the top three most common government forms.
SELECT GovernmentForm, COUNT(GovernmentForm) AS `mostcommon` 
FROM country ORDER BY `mostcommon` LIMIT 3;

-- How many countries have gained independence since records began?
SELECT IndepYear, COUNT(IndepYear) AS `howmanycountries` 
FROM country ORDER BY `howmanycountries`;



-- Sakilla Database

-- List all actors.
use sakila;
Select * from actor;

-- Find the surname of the actor with the forename 'John'.
SELECT first_name, last_name
FROM actor
WHERE first_name = "John";

-- Find all actors with surname 'Neeson'.
SELECT first_name, last_name
FROM actor 
WHERE last_name='Neeson';

-- Find all actors with ID numbers divisible by 10.
SELECT first_name, last_name 
FROM actor 
WHERE actor_id%10 = 0;

-- What is the description of the movie with an ID of 100?
SELECT description
FROM film_text
WHERE film_id=100;

-- Find every R-rated movie.
SELECT title, rating
FROM film 
WHERE rating='R';

-- find every non r-rated-movie
SELECT * FROM film WHERE rating NOT LIKE 'R';

-- find the ten shortest movies.
SELECT length as Top10Shortest
FROM film order by Top10Shortest desc limit 10 ;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT length as longest
FROM film order by longest asc;

-- Find all movies that have deleted scenes.
SELECT title, special_features
FROM film
where special_features like "%deleted%";

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name from actor
GROUP BY last_name
HAVING COUNT(last_name)=1
ORDER BY last_name DESC;

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS Frequency FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>1
ORDER BY (SELECT COUNT(last_name) FROM actor ORDER BY COUNT(last_name) DESC);

-- Which actor has appeared in the most films?
SELECT first_name AS First, last_name AS Last, COUNT(actor.actor_id) AS Frequency FROM actor
JOIN film_actor ON film_actor.actor_id=actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY COUNT(actor.actor_id) DESC
LIMIT 1;

-- When is 'Academy Dinosaur' due?
SELECT return_date
FROM rental r 
INNER JOIN inventory i ON i.inventory_id = r.inventory_id 
INNER JOIN  film f ON f.film_id = i.film_id 
WHERE f.title = "Academy Dinosaur"
ORDER BY return_date DESC;

-- What is the average runtime of all films?
SELECT AVG(length)
FROM film;

-- List the average runtime for every film category.
SELECT category.name, ROUND(AVG(length))
FROM film JOIN film_category USING (film_id) 
JOIN category USING (category_id)
GROUP BY category.name
ORDER BY AVG(length) DESC;

-- List all movies featuring a robot.
SELECT title, DESCRIPTION
FROM film
WHERE DESCRIPTION LIKE "%robot%";

-- How many movies were released in 2010?
SELECT title, count(release_year)
FROM film 
WHERE release_year=2010;

-- Find the titles of all the horror movies.
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON c.category_id=fc.category_id
WHERE c.name = "horror";

-- List the full name of the staff member with the ID of 2.
SELECT first_name, last_name
FROM staff
WHERE staff_id=2;

-- List all the movies that Fred Costner has appeared in.
SELECT title
FROM film 
INNER JOIN  film_actor f ON f.actor_id = f.actor_id 
WHERE actor_id=16;

-- How many distinct countries are there?
SELECT COUNT( DISTINCT country ) AS "Number of distinct countries" 
FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT name
FROM language
ORDER BY name DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%son" ORDER BY first_name ASC;

-- Which category contains the most films?
SELECT category.name, COUNT(film.title)
FROM film_category
JOIN film ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY category.name desc
LIMIT 1;

-- Movie Lens Database
use movielens;

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT *
FROM movies
where release_date between '1983-01-01' and '1993-01-01'
order by release_date desc;
;

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT title, rating
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
order by rating asc;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT users.id, genres.name, users.age, users.gender, ratings.rating
FROM genres_movies
JOIN movies ON genres_movies.movie_id = movies.id
JOIN genres ON genres_movies.genre_id = genres.id
JOIN ratings ON movies.id = ratings.movie_id
JOIN users ON ratings.user_id = users.id
WHERE ratings.rating = 5 AND
users.gender = 'M'
AND genres.name = 'Sci-Fi'
AND users.age = 24
group by users.id;

-- List the unique titles of each of the movies released on the most popular release day.
SELECT title, release_date from movies
WHERE release_date = (SELECT release_date FROM movies
GROUP BY release_date ORDER BY COUNT(id) DESC LIMIT 1);

-- Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT genres.name, count(movies.title) AS numberofmovies
FROM genres_movies
JOIN movies ON genres_movies.movie_id = movies.id
JOIN genres ON genres_movies.genre_id = genres.id
GROUP BY genres.name;
















