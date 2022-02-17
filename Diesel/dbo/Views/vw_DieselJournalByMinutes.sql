create view dbo.vw_DieselJournalByMinutes as
SELECT
	MachineCode
   ,DateColumn
   ,SUM(MinutesDuration) AS MinutesDuration
FROM (SELECT
		a.MachineCode
	   ,a.StartDatetime
	   ,a.EndDatetime
	   ,a.StartFlag
	   ,a.EndFlag
	   ,DateColumn
	   ,CASE
			WHEN a.StartFlag = 0 AND
				a.EndFlag = 0 THEN 1440
			ELSE CASE
					WHEN a.StartFlag = 1 AND
						a.EndFlag = 1 THEN DATEDIFF(MINUTE, a.StartDatetime, a.EndDatetime)
					ELSE CASE
							WHEN a.StartFlag = 1 THEN DATEDIFF(MINUTE, a.StartDatetime, DATEADD(DAY, 1, CAST(a.StartDatetime AS DATE)))
							WHEN a.EndFlag = 1 THEN DATEDIFF(MINUTE, CAST(a.EndDatetime AS DATE), a.EndDatetime)
						END

				END
		END AS MinutesDuration
	FROM (SELECT
			DJ.diesel_machine_id AS MachineCode
		   ,DJ.Downtime_begin AS StartDatetime
		   ,DJ.Downtime_end AS EndDatetime
		   ,C.DateColumn
		   ,CASE
				WHEN CAST(DJ.downtime_begin AS DATE) = C.DateColumn THEN 1
				ELSE 0
			END AS StartFlag
		   ,CASE
				WHEN CAST(DJ.downtime_end AS DATE) = C.DateColumn THEN 1
				ELSE 0
			END AS EndFlag
		FROM DieselJournal DJ
		JOIN Calendar C
			ON C.DateColumn BETWEEN CAST(DJ.downtime_begin AS DATE) AND CAST(DJ.downtime_end AS DATE)) a) b
GROUP BY MachineCode
		,DateColumn