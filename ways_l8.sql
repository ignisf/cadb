CREATE TABLE ways_l8 AS
SELECT
    left_l8,
    right_l8,
    geom
FROM
    (
        SELECT
            l.l8 AS left_l8,
            r.l8 AS right_l8,
            (
                ST_Dump (ST_LineMerge (st_intersection (l.geom, r.geom)))
            ).geom AS geom
        FROM
            granici l
            INNER JOIN granici r ON l.l8 > r.l8
            AND ST_Intersects (l.geom, r.geom)
    );

CREATE INDEX sidx_l8_ways ON ways_l8 USING GIST (geom);

CREATE INDEX idx_l8_ways_left ON ways_l8 (left_l8);

CREATE INDEX idx_l8_ways_right ON ways_l8 (right_l8);
