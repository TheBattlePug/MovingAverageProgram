-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AccelerationX]
(
	@t float
)
RETURNS float
AS
BEGIN
	DECLARE
		@x float,
		@xMinusTwo float,
		@xMinusOne float, 
		@xPlusOne float,
		@xPlusTwo float,

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

	SELECT @x = coalesce(x_calc, 0) from dbo.WristData where abs(t - @t) < 0.00001
	SELECT @xMinusTwo = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tMinusTwo) < 0.00001
	SELECT @xMinusOne = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tMinusOne) < 0.00001 
	SELECT @xPlusOne = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tPlusOne) < 0.00001 
	SELECT @XPlusTwo = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tPlusTwo) < 0.00001
	
	set @AccelerationResult = (2 * @xPlusTwo - @xMinusOne - 2 * @x - @xMinusOne + 2 * @xMinusTwo)/(7 * POWER(@deltaT, 2))

	RETURN @AccelerationResult

END