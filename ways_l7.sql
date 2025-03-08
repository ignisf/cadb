CREATE TABLE ways_l7 AS
SELECT
    left_l7,
    right_l7,
    geom
FROM
    (
        SELECT
            l.l7 AS left_l7,
            r.l7 AS right_l7,
            (
                ST_Dump (ST_LineMerge (st_intersection (l.geom, r.geom)))
            ).geom AS geom
        FROM
            granici l
            INNER JOIN granici r ON l.l7 > r.l7
            AND ST_Intersects (l.geom, r.geom)
    );

CREATE INDEX sidx_l7_ways ON ways_l7 USING GIST (geom);

CREATE INDEX idx_l7_ways_left ON ways_l7 (left_l7);

CREATE INDEX idx_l7_ways_right ON ways_l7 (right_l7);
