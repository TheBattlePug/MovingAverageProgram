-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Calculate]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	truncate table dbo.WristData
	insert dbo.WristData (t, x_tracker, y_tracker, v_x_tracker, v_y_tracker, a_x_tracker, a_y_tracker)
		select t, x, y, v_x, v_y, a_x, a_y from dbo.RawWristDataAsFormatted

	declare @n as int = 20
	declare @timeShift float = 0.001 * @n + 0.001
	declare @maxTime float

	update WristData set
		x_calc = x_tracker,
		y_calc = y_tracker

	update WristData set
		x_calc = dbo.MovingAverageX(t, @n),
		y_calc = dbo.MovingAverageY(t, @n)
	
	update WristData set
		x_calc = dbo.MovingAverageX(t, @n),
		y_calc = dbo.MovingAverageY(t, @n)

	update w1 set
		x_calc = w2.x_calc, 
		y_calc = w2.y_calc 
	from WristData w1 inner join WristData w2
		on abs(w1.t - w2.t + @timeShift) < 0.00001
	

	update WristData set
		v_x_calc = dbo.SpeedX(t),
		v_y_calc = dbo.SpeedY(t),
		a_x_calc = dbo.AccelerationX(t),
		a_y_calc = dbo.AccelerationY(t)


	--smoothing velocity by applying moving average twice
	update WristData set
		v_x_calc_filtered = v_x_calc,
		v_y_calc_filtered = v_y_calc

	update WristData set
		v_x_calc_filtered = dbo.MovingAverageXVelocity(t, @n),
		v_y_calc_filtered = dbo.MovingAverageYVelocity(t, @n)

	update WristData set
		v_x_calc_filtered = dbo.MovingAverageXVelocity(t, @n),
		v_y_calc_filtered = dbo.MovingAverageYVelocity(t, @n)


	update w1 set
		v_x_calc_filtered = w2.v_x_calc_filtered, 
		v_y_calc_filtered = w2.v_y_calc_filtered 
	from WristData w1 inner join WristData w2
		on abs(w1.t - w2.t + @timeShift) < 0.00001


	--smoothing acceleration by applying moving average twice
	update WristData set
		a_x_calc_filtered = a_x_calc,
		a_y_calc_filtered = a_y_calc
		
	update WristData set
		a_x_calc_filtered = dbo.MovingAverageXAcceleration(t, @n),
		a_y_calc_filtered = dbo.MovingAverageYAcceleration(t,@n)

	update WristData set
		a_x_calc_filtered = dbo.MovingAverageXAcceleration(t, @n),
		a_y_calc_filtered = dbo.MovingAverageYAcceleration(t,@n)
   
   update w1 set
		a_x_calc_filtered = w2.a_x_calc_filtered, 
		a_y_calc_filtered = w2.a_y_calc_filtered 
	from WristData w1 inner join WristData w2
		on abs(w1.t - w2.t + @timeShift) < 0.00001

	select @maxTime = max(t) from WristData

   delete from WristData 
		where t > @maxTime - @timeShift * 2

	update WristData set v_x_calc_machine = v_x_calc_filtered + RAND()/4;

	truncate table dbo.DataForProcessing
	declare @constant as int
	set @constant = 10

	INSERT INTO dbo.DataForProcessing
	SELECT * FROM dbo.WristData
	WHERE convert(int, t * 1000) % @constant = 0;

	Select * from dbo.DataForProcessing

END