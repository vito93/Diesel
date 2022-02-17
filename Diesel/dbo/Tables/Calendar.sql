CREATE TABLE [dbo].[Calendar] (
    [DateId]     INT NOT NULL,
    [DateColumn] AS  (CONVERT([date],CONVERT([nvarchar],[DateId]),(112))),
    CONSTRAINT [PK_Calendar] PRIMARY KEY CLUSTERED ([DateId] ASC)
);

