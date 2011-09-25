CREATE TABLE [dbo].[DEN_DINHKEM] (
    [ID]             INT             IDENTITY (1, 1) NOT NULL,
    [IDVB]           INT             NOT NULL,
    [FILENAME]       NVARCHAR (255)  NOT NULL,
    [DATA]           VARBINARY (MAX) NOT NULL,
    [GHICHU]         TEXT            NOT NULL,
    [IDFILETRANSFER] NVARCHAR (50)   NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID Tự sinh', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_DINHKEM', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<> NULL do Service nhận tự động được đặt bằng giá trị do Service gửi đến', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_DINHKEM', @level2type = N'COLUMN', @level2name = N'IDFILETRANSFER';

