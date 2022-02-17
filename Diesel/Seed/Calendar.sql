USE Diesel
GO

DECLARE @startDate DATE = '20200101',
		@endDate DATE = '20250101'

DECLARE @i DATE = @startDate
		
WHILE @i < @endDate
BEGIN
	INSERT INTO Calendar(DateID)
	SELECT cast(convert(NVARCHAR, @i, 112) as int)

	SET @i = DATEADD(DAY, 1, @i)
END