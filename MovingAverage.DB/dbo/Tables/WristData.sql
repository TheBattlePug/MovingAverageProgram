CREATE TABLE [dbo].[WristData] (
    [t]                 FLOAT (53) NOT NULL,
    [x_tracker]         FLOAT (53) NULL,
    [y_tracker]         FLOAT (53) NULL,
    [x_calc]            FLOAT (53) NULL,
    [y_calc]            FLOAT (53) NULL,
    [v_x_calc]          FLOAT (53) NULL,
    [v_y_calc]          FLOAT (53) NULL,
    [a_x_calc]          FLOAT (53) NULL,
    [a_y_calc]          FLOAT (53) NULL,
    [v_x_tracker]       FLOAT (53) NULL,
    [v_y_tracker]       FLOAT (53) NULL,
    [a_x_tracker]       FLOAT (53) NULL,
    [a_y_tracker]       FLOAT (53) NULL,
    [v_x_calc_filtered] FLOAT (53) NULL,
    [v_y_calc_filtered] FLOAT (53) NULL,
    [a_x_calc_filtered] FLOAT (53) NULL,
    [a_y_calc_filtered] FLOAT (53) NULL,
    [v_x_calc_machine]  FLOAT (53) NULL,
    CONSTRAINT [PK_copyOfWristData] PRIMARY KEY CLUSTERED ([t] ASC)
);

