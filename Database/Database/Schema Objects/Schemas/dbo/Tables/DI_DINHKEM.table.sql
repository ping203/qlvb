CREATE TABLE [dbo].[DI_DINHKEM] (
    [ID]             INT             NOT NULL,
    [IDVB]           INT             NOT NULL,
    [FILENAME]       NVARCHAR (255)  NOT NULL,
    [GHICHU]         TEXT            NULL,
    [DATA]           VARBINARY (MAX) NOT NULL,
    [IDFILETRANSFER] NVARCHAR (50)   NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID văn bản chứa tệp đính kèm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_DINHKEM', @level2type = N'COLUMN', @level2name = N'IDVB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tên file tệp đính kèm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_DINHKEM', @level2type = N'COLUMN', @level2name = N'FILENAME';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Thông tin thêm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_DINHKEM', @level2type = N'COLUMN', @level2name = N'GHICHU';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Dữ liệu', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_DINHKEM', @level2type = N'COLUMN', @level2name = N'DATA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'IDTransfer: ID Định danh file đính kèm theo Server, lấy theo IDĐính kèm + ID Máy (ID HDD + CPU ID)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_DINHKEM', @level2type = N'COLUMN', @level2name = N'IDFILETRANSFER';

