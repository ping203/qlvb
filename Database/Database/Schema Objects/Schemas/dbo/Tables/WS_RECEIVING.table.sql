CREATE TABLE [dbo].[WS_RECEIVING] (
    [IDTRANSFER]   NVARCHAR (50)  NOT NULL,
    [IDVBTRANSFER] NVARCHAR (50)  NOT NULL,
    [FILELENGTH]   INT            NULL,
    [FILENAME]     NVARCHAR (255) NOT NULL,
    [TEMPFILENAME] NVARCHAR (255) NOT NULL,
    [MD5HASH]      NVARCHAR (50)  NOT NULL,
    [THOIGIAN]     DATETIME       NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Do nơi gửi cung cấp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WS_RECEIVING', @level2type = N'COLUMN', @level2name = N'IDTRANSFER';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Do nơi gửi cung cấp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WS_RECEIVING', @level2type = N'COLUMN', @level2name = N'IDVBTRANSFER';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'File tạm khi nhận dữ liệu sẽ ghi vào', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WS_RECEIVING', @level2type = N'COLUMN', @level2name = N'TEMPFILENAME';

