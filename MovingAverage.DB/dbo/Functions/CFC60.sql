-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION CFC60 
(
	-- Add the parameters for the function here
	@dataPoint float,
	@dataPointMinusOne float,
	@dataPointMinusTwo float,
	@filteredDataPointMinusOne float,
	@filteredDataPointMinusTwo float
)
RETURNS float 
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result float

	Declare @CFC60 AS DECIMAL = 100
	Declare @T AS DECIMAL = 1
	Declare @wd as decimal = 2 * PI() * @CFC60 * 2.0775
	Declare @wa as decimal = SIN(@wd * @T/2)/COS(@wd * @T/2)
	Declare @a0 as decimal = POWER(@wa , 2) / (1 + SQRT(2)*@wa + POWER(@wa, 2))
	Declare @a1 as decimal = 2 * @a0
	Declare @a2 as decimal = @a0
	Declare @b1 as decimal = (-2 * (POWER(@wa, 2) - 1))/(1 + SQRT(2) * @wa + POWER(@wa, 2))
	Declare @b2 as decimal = (-1 + SQRT(2) * @wa - POWER(@wa, 2))/(1 + SQRT(2) * @wa + POWER(@wa, 2))


	-- Add the T-SQL statements to compute the return value here
	SELECT @result = @a0 * @dataPoint + @a1 * @dataPointMinusOne + @a2 * @dataPointMinusTwo + @b1 * @filteredDataPointMinusOne + @b2 * @filteredDataPointMinusTwo

	-- Return the result of the function
	RETURN @result

END