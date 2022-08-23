-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SpeedY] 
(	
	@t float
)
RETURNS float
AS
BEGIN

	DECLARE 
		@yMinusOne float, 
		@yPlusOne float,
		@tMinusOne float,
		@tPlusOne float,
		@speedResult float,
		@deltaT float


	set @tMinusOne = @t - 0.001
	set @tPlusOne = @t + 0.001
	set @deltaT = 0.001

	SELECT @yMinusOne = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tMinusOne) < 0.00001 
	SELECT @yPlusOne = coalesce(y_calc, 0) from dbo.WristData where abs(t - @tPlusOne) < 0.00001 
	
	set @speedResult = (@yPlusOne - @yMinusOne ) / (2 * @deltaT)
	RETURN @speedResult

END