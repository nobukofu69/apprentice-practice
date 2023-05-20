# インターネットTV
## ステップ1

[テーブル設計](https://docs.google.com/spreadsheets/d/e/2PACX-1vRRgotTJjfhbQa5ZB6WhS8x89YstEGCYS36gFbrUjAGhQG5_h20baJfE8GjMi7BQtp3yIEZJqzW1QPc/pubhtml?gid=417302730&single=true)

[ER図](https://github.com/nobukofu69/apprentice-practice/blob/main/week5-6/internet_tv.pu)
<img src="https://github.com/nobukofu69/apprentice-practice/blob/main/week5-6/er.png">

## ステップ2
1. [internet_tv.sql](https://github.com/nobukofu69/apprentice-practice/blob/main/week5-6/internet_tv.sql)が配置されたディレクトリに移動します｡
2. [internet_tv.sql](https://github.com/nobukofu69/apprentice-practice/blob/main/week5-6/internet_tv.sql)を実行します｡
```
mysql -u root -p < internet_tv.sql
```
3. データベース internet_tv が作成されている事を確認します｡
```
show databases;
```
4. 以下実行し､各種テーブルが作成されている事を確認します｡
```
use internet_tv;
show tables;
```
5. 各種テーブルにデータがINSERTされていることを確認します｡
```
SELECT * FROM テーブル名;
```
## ステップ3
[quest_step3.sql](https://github.com/nobukofu69/apprentice-practice/blob/main/week5-6/quest_step3.sql)で回答しました｡