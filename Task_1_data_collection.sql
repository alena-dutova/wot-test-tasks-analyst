{\rtf1\ansi\ansicpg1251\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\csgray\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww26280\viewh14760\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs28 \cf2 -- task1_data_processing.sql\
-- Author: \uc0\u1040 \u1083 \u1077 \u1085 \u1072  \u1044 \u1091 \u1090 \u1086 \u1074 \u1072 \
-- Task I \'97 Data Collection and Processing\
-- DB: PostgreSQL\
-- This script creates initial tables, loads dataset structure, converts string dates into proper date formats,\
-- and runs some analytical queries.\
\
-- Create base tables from dataset\
CREATE TABLE battle_statistics (\
	battle_id TEXT,\
	battle_start TEXT,\
	player_id TEXT,\
	vehicle_name  TEXT,\
	team_id INT,\
	tank_id INT,\
	damage INT,\
	credits INT,\
	exp INT,\
	team_won_id INT,\
	dt TEXT\
);\
\
CREATE TABLE developers (\
	dev_player_id TEXT\
);\
\
-- Add converted date columns to battle_statistics\
ALTER TABLE battle_statistics ADD COLUMN battle_start_dt TIMESTAMP;\
ALTER TABLE battle_statistics ADD COLUMN dt_d DATE;\
\
UPDATE battle_statistics\
SET battle_start_dt = TO_TIMESTAMP(battle_start, 'DD.MM.YY HH24:MI:SS');\
\
UPDATE battle_statistics\
SET dt_d = TO_DATE(dt, 'DD.MM.YY');\
\
---------------------------------------------------------\
-- Analytical Queries\
---------------------------------------------------------\
\
-- 1. Nations with more than 10,000 battles as of selected date (e.g., 23.12.22)\
SELECT \
	SPLIT_PART(vehicle_name, ':', 1) AS vehicle_nations,\
	COUNT(DISTINCT battle_id) AS cnt_battles\
FROM battle_statistics\
WHERE dt_d <= TO_DATE('23.12.22', 'DD.MM.YY')\
GROUP BY vehicle_nations\
HAVING COUNT(DISTINCT battle_id) > 10000\
;\
\
-- 2. Unique players active on both 08.03.23 and 09.03.23\
SELECT \
	COUNT(*) AS cnt_active_players\
FROM (\
	SELECT player_id\
	FROM battle_statistics\
	WHERE dt_d = TO_DATE('08.03.23', 'DD.MM.YY')\
	   OR dt_d = TO_DATE('09.03.23', 'DD.MM.YY')\
	GROUP BY player_id\
	HAVING COUNT(DISTINCT dt_d) = 2\
) AS active_on_both_days\
;\
\
-- 3. Total damage and credits in the last lost battle per player (excluding developers)\
WITH last_lost_battles AS (\
	SELECT DISTINCT ON (player_id)\
		player_id,\
		damage,\
		credits\
	FROM battle_statistics\
	WHERE team_id <> team_won_id\
	  AND NOT EXISTS (\
	    SELECT 1 FROM developers WHERE dev_player_id = player_id\
	  )\
	ORDER BY player_id, battle_start_dt DESC\
)\
SELECT \
	player_id,\
	SUM(damage) AS total_damage,\
	SUM(credits) AS total_credits\
FROM last_lost_battles\
GROUP BY player_id\
;\
}