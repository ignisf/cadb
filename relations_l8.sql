CREATE TABLE relations_l8 AS
SELECT
    8 AS admin_level,
    'boundary' AS type,
    'administrative' AS boundary,
    e.name AS name,
    'землище' AS "name:prefix",
    e.ekatte AS ekatte,
    ST_Collect (geom) AS geom
FROM
    ways_l8 AS l8
    JOIN ekatte AS e ON e.ekatte = l8.left_l8
    OR e.ekatte = l8.right_l8
GROUP BY
    e.ekatte;

CREATE INDEX sidx_relations_l8 ON relations_l8 USING GIST (geom);
