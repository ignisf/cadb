CREATE TABLE granici AS
SELECT
    e.ekatte AS l8,
    NULL AS l7,
    NULL AS l5,
    NULL AS l4,
    NULL AS l3,
    ST_ExteriorRing (geom) AS geom
FROM
    zemlishta AS z
    INNER JOIN ekatte AS e ON z.ekatte = e.ekatte
UNION
SELECT
    NULL AS l8,
    e.kmetstvo AS l7,
    NULL AS l5,
    NULL AS l4,
    NULL AS l3,
    ST_Boundary (ST_Union (geom)) AS geom
FROM
    zemlishta AS z
    INNER JOIN ekatte AS e ON z.ekatte = e.ekatte
GROUP BY
    (e.kmetstvo)
UNION
SELECT
    NULL AS l8,
    NULL AS l7,
    e.obshtina AS l5,
    NULL AS l4,
    NULL AS l3,
    ST_ExteriorRing (ST_Union (geom)) AS geom
FROM
    zemlishta AS z
    INNER JOIN ekatte AS e ON z.ekatte = e.ekatte
GROUP BY
    (e.obshtina)
UNION
SELECT
    NULL AS l8,
    NULL AS l7,
    NULL AS l5,
    e.oblast AS l4,
    NULL AS l3,
    ST_ExteriorRing (ST_Union (geom)) AS geom
FROM
    zemlishta AS z
    INNER JOIN ekatte AS e ON z.ekatte = e.ekatte
GROUP BY
    (e.oblast)
UNION
SELECT
    NULL AS l8,
    NULL AS l7,
    NULL AS l5,
    NULL AS l4,
    'BG' AS l3,
    ST_ExteriorRing (ST_Union (geom)) AS geom
FROM
    zemlishta AS z;

CREATE INDEX sidx_granici_geom ON granici USING GIST (geom);

CREATE INDEX idx_granici_l8 ON granici (l8 ASC NULLS LAST);

CREATE INDEX idx_granici_l7 ON granici (l7 ASC NULLS LAST);

CREATE INDEX idx_granici_l5 ON granici (l5 ASC NULLS LAST);

CREATE INDEX idx_granici_l4 ON granici (l4 ASC NULLS LAST);

CREATE INDEX idx_granici_l3 ON granici (l3 ASC NULLS LAST);
