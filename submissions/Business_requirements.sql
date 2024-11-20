#Business requirement 6
SELECT
    c.city_name,
    CASE 
        WHEN fps.month_name = '2024-01-01' THEN 'January'
        WHEN fps.month_name = '2024-02-01' THEN 'February'
        WHEN fps.month_name = '2024-03-01' THEN 'March'
        WHEN fps.month_name = '2024-04-01' THEN 'April'
        WHEN fps.month_name = '2024-05-01' THEN 'May'
        WHEN fps.month_name = '2024-06-01' THEN 'June'
    END AS 'Name of the Month',
    SUM(fps.total_passengers) AS total_passengers,
    SUM(fps.repeat_passengers) AS repeat_passengers,
    ROUND((SUM(fps.repeat_passengers) / SUM(fps.total_passengers)) * 100, 2) AS monthly_repeat_passenger_rate,
    (SELECT 
        ROUND((SUM(fps2.repeat_passengers) / SUM(fps2.total_passengers)) * 100, 2)
     FROM fact_passenger_summary fps2
     JOIN dim_city c2 ON fps2.city_id = c2.city_id
     WHERE c2.city_name = c.city_name
    ) AS city_overall_repeat_passenger_rate
FROM
    fact_passenger_summary fps
JOIN
    dim_city c ON fps.city_id = c.city_id
GROUP BY
    c.city_name, fps.month_name
ORDER BY
    c.city_name, fps.month_name;
