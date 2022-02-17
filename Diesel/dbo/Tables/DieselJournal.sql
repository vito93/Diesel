CREATE TABLE [dbo].[DieselJournal] (
    [Id]                TINYINT       IDENTITY (1, 1) NOT NULL,
    [diesel_machine_id] VARCHAR (50)  NULL,
    [downtime_begin]    DATETIME2 (3) NULL,
    [downtime_end]      DATETIME2 (3) NULL,
    CONSTRAINT [PK_DieselJournal] PRIMARY KEY CLUSTERED ([Id] ASC)
);

