--psql --host=127.0.0.1 --port=5432 --dbname=db-PPCIC-rsalles --username=rsalles

CREATE TABLE LINEITEM
                      ( L_ORDERKEY    INTEGER NOT NULL,
                        L_PARTKEY     INTEGER NOT NULL,
                        L_SUPPKEY     INTEGER NOT NULL,
                        L_LINENUMBER  INTEGER NOT NULL,
                        L_QUANTITY    FLOAT NOT NULL,
                        L_EXTENDEDPRICE  FLOAT NOT NULL,
                        L_DISCOUNT    FLOAT NOT NULL,
                        L_TAX         FLOAT NOT NULL,
                        L_RETURNFLAG  CHAR(1) NOT NULL,
                        L_LINESTATUS  CHAR(1) NOT NULL,
                        L_SHIPDATE    DATE NOT NULL,
                        L_COMMITDATE  DATE NOT NULL,
                        L_RECEIPTDATE DATE NOT NULL,
                        L_SHIPINSTRUCT CHAR(25) NOT NULL,
                        L_SHIPMODE     CHAR(10) NOT NULL,
                        L_COMMENT      VARCHAR(44) NOT NULL,
                        TEMP          VARCHAR(2));

--LOAD DATA LOCAL INFILE 'data/lineitem.tbl'
--  INTO TABLE LINEITEM FIELDS TERMINATED BY '|';

\COPY lineitem FROM '/home/rsalles/druid-benchmark/data/lineitem.tbl' ( FORMAT CSV, DELIMITER('|') );
ALTER TABLE lineitem DROP TEMP;

CREATE INDEX index_shipdate ON LINEITEM USING BTREE (L_SHIPDATE);
CREATE INDEX index_commitdate ON LINEITEM USING BTREE (L_COMMITDATE);
CREATE INDEX index_partkey ON LINEITEM USING BTREE (L_PARTKEY);
CREATE INDEX index_shipmode ON LINEITEM USING BTREE (L_SHIPMODE);
--OPTIMIZE TABLE LINEITEM;
VACUUM LINEITEM;
