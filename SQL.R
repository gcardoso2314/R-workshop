#Invoke the library
library(sqldf)

#Download Titanic data, identify features and structure.
data(titanic3, package='PASWR')
titanic=titanic3
head(titanic) # shows the top 6 rows 
View(titanic) #shows the data in a new tab
str(titanic) #shows the structure of DF, colnames, type of feature, examples


########################### Select * from dataframe ###########################

#create the titanic object with all the rows and columns from titanic
titanic1=sqldf('select * from titanic') 

dim(titanic)
dim(titanic1)
head(titanic1)

#Select some columns from dataframe

titanic_cols=sqldf('select pclass, survived, name from titanic')

dim(titanic)
dim(titanic_cols)
head(titanic_cols)

######################## Select * from dataframe WHERE ########################

#select rows when the feature is numeric
titanic_rows=sqldf('select * from titanic where survived=1') 

dim(titanic)
dim(titanic_rows)
head(titanic_rows)

#select rows when the feature is a character or factor
titanic_rows2=sqldf('select * from titanic 
                    where pclass="1st"') 
dim(titanic)
dim(titanic_rows2)
head(titanic_rows2)

#select rows with a logical filter (=, >, <, >=, <=, !=)
titanic_rows3=sqldf('select * from titanic 
                    where age<5') 
dim(titanic)
dim(titanic_rows3)
head(titanic_rows3)

#select rows using and/or
titanic_rows4=sqldf('select * from titanic 
                    where age<5 and sex="female"') 
dim(titanic)
dim(titanic_rows4)
head(titanic_rows4)

#select rows where the feature contain the pattern at any part of the string
titanic_rows5=sqldf('select * from titanic 
                    where name like "%Allison%"') 
head(titanic_rows5)

#select rows where the feature is any of the strings in the parenthesis
head(titanic_rows6)
titanic_rows6=sqldf('select * from titanic 
                    where embarked in ("Southampton","Cherbourg")') 
tail(titanic_rows6)
dim(titanic_rows6)

#select rows where the feature is not any of the strings in the parenthesis
titanic_rows7=sqldf('select * from titanic 
                    where embarked not in ("Southampton","Cherbourg")') 
dim(titanic_rows7)

#select rows where the feature is not null
titanic_rows8=sqldf('select pclass, survived, name,sex, age from titanic 
                    where embarked in ("Southampton","Cherbourg") 
                    and age is not null') 
head(titanic_rows8)
tail(titanic_rows8)

######################## Select count(1) from dataframe ORDER BY ########################

#ordering the rows descending (ascending by default)
titanic_rows9=sqldf('select pclass, survived, name,sex, age from titanic 
                    where embarked in ("Southampton","Cherbourg") 
                    and age is not null
                    order by age desc') 
titanic_rows9

titanic_rows9=sqldf('select pclass, survived, name,sex, age from titanic 
                    where embarked in ("Southampton","Cherbourg") 
                    and age is not null
                    order by age desc, pclass') 
titanic_rows9

######################## Select count(1) from dataframe GROUP BY ########################

#aggregate data by feature(s)
titanic_g1=sqldf('select pclass from titanic 
                 group by pclass') 
titanic_g1

titanic_g2=sqldf('select pclass, count(1) cnt 
                 from titanic 
                 group by 1') 
titanic_g2

#aggregate data by feature(s) and get summary stats: count, min, max, avg, etc
titanic_g3=sqldf('select pclass, sex, count(1) cnt, max(age) max_age, min(age) min_age, avg(age) mean_age 
                 from titanic 
                 group by 1,2') 
titanic_g3

#case when else end 
titanic_g4=sqldf('select pclass, case when sex="female" then 1 else 0 end female_flag, count(1) cnt 
                 from titanic 
                 group by 1,2') 
titanic_g4

titanic_g5=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_cnt,
                  sum(case when sex="male" then 1 else 0 end) male_cnt 
                  from titanic 
                  group by 1') 
titanic_g5

titanic_g6=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_cnt,
                  sum(case when sex="male" then 1 else 0 end) male_cnt 
                  from titanic 
                  where age>=5
                  group by 1 order by pclass desc ') 
titanic_g6

######################## Select count(1) from dataframe GROUP BY HAVING ########################

#add a special filter
titanic_g7=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_cnt,
                  sum(case when sex="male" then 1 else 0 end) male_cnt 
                  from titanic 
                  group by 1
                  having sum(case when sex="female" then 1 else 0 end)>120') 
titanic_g7

######################## INNER JOIN and LEFT OUTER JOIN ########################

titanic_kids=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_kids_cnt,
                  sum(case when sex="male" then 1 else 0 end) male_kids_cnt 
                  from titanic 
                  where age<=6
                  group by 1') 

titanic_teens=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_teens_cnt,
                   sum(case when sex="male" then 1 else 0 end) male_teens_cnt 
                   from titanic 
                   where age>6 and age<=20
                   group by 1') 

#merge dataframes whose rows fulfill the matching criteria
join_1=sqldf('select a.*, female_teens_cnt, male_teens_cnt
             from titanic_kids a inner join titanic_teens b on a.pclass=b.pclass')
join_1

#merge dataframes, all rows from the left table and only the rows from the right table that fulfill the matching criteria
join_2=sqldf('select a.*, female_teens_cnt, male_teens_cnt
             from titanic_kids a left outer join titanic_teens b on a.pclass=b.pclass')
join_2

titanic_teens_2=sqldf('select pclass, sum(case when sex="female" then 1 else 0 end) female_teens_cnt,
                   sum(case when sex="male" then 1 else 0 end) male_teens_cnt 
                    from titanic 
                    where age>6 and age<=20
                    group by 1
                    having sum(case when sex="female" then 1 else 0 end) >20 ') 

#merge dataframes whose rows fulfill the matching criteria
join_3=sqldf('select a.*, female_teens_cnt, male_teens_cnt
             from titanic_kids a inner join titanic_teens_2 b on a.pclass=b.pclass')
join_3

#merge dataframes, all rows from the left table and only the rows from the right table that fulfill the matching criteria
join_4=sqldf('select a.*, female_teens_cnt, male_teens_cnt
             from titanic_kids a left outer join titanic_teens_2 b on a.pclass=b.pclass')
join_4
