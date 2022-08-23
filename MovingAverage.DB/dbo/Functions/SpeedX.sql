-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SpeedX] 
(	
	@t float
)
RETURNS float
AS
BEGIN

	DECLARE 
		@xMinusOne float, 
		@xPlusOne float,
		@tMinusOne float,
		@tPlusOne float,
		@speedResult float,
		@x float,
		@deltaT float
	
	set @tMinusOne = @t - 0.001
	set @tPlusOne = @t + 0.001
	set @deltaT = 0.001

	SELECT @xMinusOne = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tMinusOne) < 0.00001 
	SELECT @xPlusOne = coalesce(x_calc, 0) from dbo.WristData where abs(t - @tPlusOne) < 0.00001 
	
	set @speedResult = (@xPlusOne - @xMinusOne ) / (2 * @deltaT)

	RETURN @speedResult

END