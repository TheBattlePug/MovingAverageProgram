-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[MovingAverageYAcceleration] 
(
	-- Add the parameters for the function here
	@t float, @n int
)
RETURNS float
AS
BEGIN
	
	DECLARE @result float, @count int

	select @result = sum(a_y_calc_filtered) from dbo.WristData where t between @t - 0.001 * (@n - 1) and @t
	select @count = count(*) from dbo.WristData where t between @t - 0.001 * (@n - 1) and @t
	set @result = @result/@count
	RETURN @result

END