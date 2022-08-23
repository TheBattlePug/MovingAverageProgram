-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AccelerationY]
(
	@t float
)
RETURNS float
AS
BEGIN
	DECLARE
		@y float,
		@yMinusTwo float,
		@yMinusOne float, 
		@yPlusOne float,
		@yPlusTwo float,

		@tMinusOne float,
		@tMinusTwo float,
		@tPlusOne float,
		@tPlusTwo float,
		@AccelerationResult float,
		@deltaT float

	
	set @tMinusTwo = @t - 0.002
	set @tMinusOne = @t - 0.001
	set @tPlusOne = @t + 0.001
	set @tPlusTwo = @t + 0.002
	set @deltaT = 0.001
	


	SELECT @y = coalesce(y_calc, 0) from dbo.WristData where abs(t - @t) < 0.00001
	SELECT @yMinusTwo = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tMinusTwo) < 0.00001
	SELECT @yMinusOne = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tMinusOne) < 0.00001 
	SELECT @yPlusOne = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tPlusOne) < 0.00001 
	SELECT @yPlusTwo = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tPlusTwo) < 0.00001
	
	set @AccelerationResult = (2 * @yPlusTwo - @yMinusOne - 2 * @y - @yMinusOne + 2 * @yMinusTwo)/(7 * POWER(@deltaT, 2))

	RETURN @AccelerationResult

END