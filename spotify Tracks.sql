
---Top 5 track genre on the basis of popularity

select top 5
   track_genre
from
   dbo.dataset
group by
   track_genre
order by
   sum(popularity) DESC;


----Top Ranked Songs by Genre on the basis of popularity

WITH
   RankedSongs AS (
SELECT
   track_genre,
   track_name,
   popularity,
        ROW_NUMBER() OVER (PARTITION BY track_genre ORDER BY popularity DESC) AS popularity_rank
FROM
	dbo.dataset)
SELECT 
   track_genre,  track_name, popularity
FROM 
   RankedSongs
where 
   popularity =100
ORDER BY
   popularity DESC;

---- analysis of average song durations across various genres

select 
   track_genre,avg (duration_ms) as avg_song_duration
from 
   dbo.dataset
group by 
   track_genre
order by  
   avg_song_duration desc;

----Top 10 songs

select  distinct TOP
  10 track_name,popularity
from  
  dbo.dataset
order by
  popularity desc;
  
-----distribution of songs on the basis of  track_popularity

SELECT 
   FLOOR(popularity/10)*10 AS popularity_range,
   COUNT(*) AS track_count
FROM 
  dbo.dataset
GROUP BY 
   FLOOR(popularity/10)
ORDER BY
   popularity_range,track_count DESC  ;

 ---- distribution of duration  of songs in minutes

SELECT
    FLOOR(duration_ms / 60000) AS duration_minutes,
    COUNT(distinct track_name) AS song_count
FROM
    dbo.dataset
GROUP BY
    FLOOR(duration_ms / 60000)
ORDER BY
    duration_minutes;
    

----Top 10 Artists

SELECT top 
   10 artists, count(distinct track_name)
AS song_count
FROM
	dbo.dataset
GROUP BY 
    artists
order by song_count desc;

---COLLABORATION OF MORE THAN ONE ARTIST IN A SPECIFIC TRACK

SELECT
    track_name,
    COUNT(number_of_artists) AS TOTAL_ARTISTS
FROM
    (SELECT
        track_name,
        artists,
        CAST(LEN(artists) - LEN(REPLACE(artists, ';', '')) + 1 AS NVARCHAR(MAX)) AS number_of_artists
    FROM
        dbo.dataset
    WHERE
        artists LIKE '%;%'
    ) AS total_artists
GROUP BY
    track_name
HAVING
    COUNT(number_of_artists) > 1
ORDER BY
    TOTAL_ARTISTS DESC;




	





	









