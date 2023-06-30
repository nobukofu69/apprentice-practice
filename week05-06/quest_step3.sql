-- ステップ3
/* 1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3の
      エピソードタイトルと視聴数を取得してください */
SELECT episode_title, views
  FROM episodes
 ORDER BY views DESC
 LIMIT 3;

/* 2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。
      エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、
      視聴数を取得してください */
SELECT p.program_title AS 番組タイトル,
       e.season_num  AS シーズン数,
       e.episode_num AS エピソード数,
       e.episode_title AS エピソードタイトル,
       e.views AS 視聴数
  FROM episodes AS e
       JOIN programs AS p
       ON e.program_id = p.id
 ORDER BY views DESC
 LIMIT 3;

/* 3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が
      放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、
      放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、
      エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される
      番組とみなすものとします */
SELECT c.name AS チャンネル名,
       t.start_time AS 開始時間,
       t.end_time AS 終了時間,
       e.season_num AS シーズン数,
       e.episode_num AS エピソード数,
       e.episode_title AS エピソードタイトル,
       e.episode_info AS エピソード詳細
  FROM channels AS c
       JOIN tv_schedules AS t
       ON c.id = t.channel_id 

       JOIN episodes AS e
       ON t.episode_id = e.id
 WHERE DATE (start_time) = CURDATE();

/* 4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、
      本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。
      ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、
      ピソードタイトル、エピソード詳細を本日から一週間分取得してください */
SELECT t.start_time AS 開始時間,
       t.end_time AS 終了時間,
       e.season_num AS シーズン数,
       e.episode_num AS エピソード数,
       e.episode_title AS エピソードタイトル,
       e.episode_info AS エピソード詳細
  FROM channels AS c
       JOIN tv_schedules AS t
       ON c.id = t.channel_id 

       JOIN episodes AS e
       ON t.episode_id = e.id
 WHERE c.name = 'ドラマ'
   AND start_time BETWEEN CURDATE() AND CURDATE() + INTERVAL 8 DAY;

/* 5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、
      エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください */
SELECT p.program_title AS 番組タイトル,
       t.views AS 視聴数
  FROM tv_schedules AS t
       JOIN episodes AS e
       ON t.episode_id = e.id

       JOIN programs AS p
       ON e.program_id = p.id 
 WHERE start_time BETWEEN CURDATE() AND CURDATE() + INTERVAL 8 DAY
 ORDER BY t.views DESC
 LIMIT 2;

/* 6. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングは
      エピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、
      ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。*/
      
SELECT ジャンル名,
       番組タイトル,
       エピソード平均視聴数
  FROM (SELECT g.name AS ジャンル名, 
               p.program_title AS 番組タイトル,
               ROUND(AVG(views)) AS エピソード平均視聴数,
               RANK() OVER (PARTITION BY g.name ORDER BY AVG(e.views)) AS ranking
          FROM episodes AS e
               JOIN programs AS p
               ON e.program_id = p.id
   
               JOIN program_genres AS pg
               ON p.id = pg.program_id
   
               JOIN genres AS g
               ON pg.genre_id = g.id
         GROUP BY p.id) AS t
 WHERE ranking = 1;