create database habits;
use habits ;
select * from shp; -- shp = student habits performance 
describe shp;
 -- finding the null values.
 
select sum(student_id is null) student_id_null,sum(age is null) age_null,sum(gender is null) gender_null,
sum(study_hours_per_day is null) study_hours_per_day_null,sum(social_media_hours is null) social_media_hours_null
,sum(netflix_hours is null) netflix_hours_null,sum(part_time_job is null ) part_time_job_null,
sum(attendance_percentage is null ) attendance_percentage_null,sum(sleep_hours is null) sleep_hours_null,
sum(diet_quality is null) diet_quality_null,sum(exercise_frequency is null) exercise_frequency_null,
sum(parental_education_level is null) parental_education_level_null,sum(internet_quality is null) 
internet_quality_null,sum(mental_health_rating is null) mental_health_rating_null,
sum(extracurricular_participation is null) extracurricular_participation_null,
sum(exam_score is null) exam_score_null from shp;
  
  
  
-- Q) Which student habits are most strongly associated with high academic performance?
  SELECT 
  CASE 
    WHEN exam_score >= 80 THEN 'High Performer'
    ELSE 'Others'
  END AS performance_group,
  ROUND(AVG(study_hours_per_day), 2) AS avg_study_hours,
  ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours,
  ROUND(AVG(social_media_hours), 2) AS avg_social_media_hours,
  ROUND(AVG(exercise_frequency), 2) AS avg_exercise_hours
FROM shp
GROUP BY performance_group;
 -- Insight 
 -- Students who perform better academically tend to have more structured 
 -- and healthier habits, especially more study time and less social media use.


  
-- Q) How does part-time job status influence study hours, sleep, and exam scores? 
select part_time_job,avg(sleep_hours) avg_sleep_hour,
avg(study_hours_per_day) avg_study_hour,avg(exam_score)avg_exam_score 
from shp group by part_time_job;
-- Insight
-- Students with part-time jobs tend to sleep and study less, 
-- which may slightly impact their exam performance compared to those without jobs.




-- Q) Do students with higher attendance tend to have better exam results?
select  case when attendance_percentage>=75 then "Higher_attendence"
         when attendance_percentage between 50 and 74 then "medium_percentage"
         else "low_percentage"
         end as attendence_group,count(*) as total_student,avg(exam_score) as avg_score
         from shp group by attendence_group order by avg_score; 
-- Insight
-- While higher attendance generally leads to better scores, a small group of low-attendance 
-- students outperformed, suggesting other factors also impact success.



-- Q) What’s the performance variation across students with different parental education levels?
SELECT
  parental_education_level,
  COUNT(*) AS total_students,
  AVG(exam_score) AS avg_score,
  MIN(exam_score) AS min_score,
  MAX(exam_score) AS max_score
  FROM shp
GROUP BY parental_education_level
ORDER BY avg_score DESC;

-- Insight
-- Students with parents holding a Bachelor's degree scored highest on average, 
-- while those with Master's-educated parents scored lowest, showing no direct link 
-- between parental education and student performance.




-- Q) What’s the average exam score for students who sleep more than 8 hours vs.those who sleep less? 
SELECT
  CASE 
    WHEN sleep_hours > 8 THEN 'More than 8 hours'
    ELSE '8 hours or less'
  END AS sleep_group,
  COUNT(*) AS total_students,
  AVG(exam_score) AS avg_exam_score
FROM shp
GROUP BY 
  CASE 
    WHEN sleep_hours > 8 THEN 'More than 8 hours'
    ELSE '8 hours or less'
  END;
  -- Insight 
  -- the average exam score for students who sleep more than 8 hours is greater then  
  -- those who sleep less by difference of 2.03.



-- Q) Do students with regular exercise habits score better in exams? -- 
select
 case
 when exercise_frequency>=4 then "Regular exercise"
  else "Not Regular"
 end as exercise_group,
 count(*) total_student,round(avg(exam_score),3) avg_exam_score
 from shp 
 group by 
  case
 when exercise_frequency>=4 then "Regular exercise"
  else "Not Regular"
  end;
-- Insight
-- Students who reported regular exercise habits scored an average of 4.48 points higher.



-- Q) find students whose social media use is above average but still manage to score above average.
select student_id,social_media_hours,exam_score from shp where social_media_hours>
(select avg(social_media_hours) from shp) and exam_score >(select avg(exam_score) from shp); 

-- Insight
-- 224 students showed high academic performance despite above-average social media usage 
-- — possibly indicating stronger time management or multi-tasking abilities.

-- End .... End..   