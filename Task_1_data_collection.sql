-- task1_data_processing.sql
-- Author: Алена Дутова
-- Task I — Data Collection and Processing
-- DB: PostgreSQL
-- This script creates initial tables, loads dataset structure, converts string dates into proper date formats,
-- and runs some analytical queries.

-- Create base tables from dataset
CREATE TABLE battle_statistics (
	battle_id TEXT,
	battle_start TEXT,
	player_id TEXT,
	vehicle_name  TEXT,
	team_id INT,
	tank_id INT,
	damage INT,
	credits INT,
	exp INT,
	team_won_id INT,
	dt TEXT
);

CREATE TABLE developers (
	dev_player_id TEXT
);

-- Add converted date columns to battle_statistics
ALTER TABLE battle_statistics ADD COLUMN battle_start_dt TIMESTAMP;
ALTER TABLE battle_statistics ADD COLUMN dt_d DATE;

UPDATE battle_statistics
SET battle_start_dt = TO_TIMESTAMP(battle_start, 'DD.MM.YY HH24:MI:SS');

UPDATE battle_statistics
SET dt_d = TO_DATE(dt, 'DD.MM.YY');

---------------------------------------------------------
-- Analytical Queries
---------------------------------------------------------

-- 1. Nations with more than 10,000 battles as of selected date (e.g., 23.12.22)
SELECT 
	SPLIT_PART(vehicle_name, ':', 1) AS vehicle_nations,
	COUNT(DISTINCT battle_id) AS cnt_battles
FROM battle_statistics
WHERE dt_d <= TO_DATE('23.12.22', 'DD.MM.YY')
GROUP BY vehicle_nations
HAVING COUNT(DISTINCT battle_id) > 10000
;

-- 2. Unique players active on both 08.03.23 and 09.03.23
SELECT 
	COUNT(*) AS cnt_active_players
FROM (
	SELECT player_id
	FROM battle_statistics
	WHERE dt_d = TO_DATE('08.03.23', 'DD.MM.YY')
	   OR dt_d = TO_DATE('09.03.23', 'DD.MM.YY')
	GROUP BY player_id
	HAVING COUNT(DISTINCT dt_d) = 2
) AS active_on_both_days
;

-- 3. Total damage and credits in the last lost battle per player (excluding developers)
WITH last_lost_battles AS (
	SELECT DISTINCT ON (player_id)
		player_id,
		damage,
		credits
	FROM battle_statistics
	WHERE team_id <> team_won_id
	  AND NOT EXISTS (
	    SELECT 1 FROM developers WHERE dev_player_id = player_id
	  )
	ORDER BY player_id, battle_start_dt DESC
)
SELECT 
	player_id,
	SUM(damage) AS total_damage,
	SUM(credits) AS total_credits
FROM last_lost_battles
GROUP BY player_id
;