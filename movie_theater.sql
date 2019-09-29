CREATE TABLE Movies (
  Code INTEGER PRIMARY KEY NOT NULL,
  Title TEXT NOT NULL,
  Rating TEXT
);

CREATE TABLE MovieTheaters (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Movie INTEGER
    CONSTRAINT fk_Movies_Code REFERENCES Movies(Code)
);

INSERT INTO Movies(Code,Title,Rating) VALUES(9,'Citizen King','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
 INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
 INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
 INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
 INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
 INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);

 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
 INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);


--  1. Select the title of all movies.

select title from movies;

-- 2. Show all the distinct ratings in the database.

select distinct rating
from movies;

-- 3. Show all unrated movies.

select * from Movies
where rating is null;

-- 4. Select all movie theaters that are not currently showing a movie.

select * from MovieTheaters
where movie is null;

-- 5. Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

select *
from MovieTheaters mt
left join Movies m on mt.movie = m.code;

-- 6. Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.

select * from movies m
left join MovieTheaters mt on m.code = mt.movie;

-- 7. Show the titles of movies not currently being shown in any theaters.

select m.title from movies m
left join MovieTheaters mt on m.code = mt.movie
where mt.movie is null;

-- 8. Add the unrated movie "One, Two, Three".

insert into movies(title, rating)
  values('One, Two, Three', NULL);

-- 9. Set the rating of all unrated movies to "G".

update Movies
  set rating = 'G'
  where rating is null;

-- 10. Remove movie theaters projecting movies rated "NC-17".

delete from MovieTheaters
where movie in (select code from movies where rating = 'NC-17');
