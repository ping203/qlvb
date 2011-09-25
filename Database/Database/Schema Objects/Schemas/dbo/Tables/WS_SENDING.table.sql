CREATE TABLE [dbo].[WS_SENDING] (
    [IDFILETRANSFER] NVARCHAR (50)  NOT NULL,
    [IDVBTRANSFER]   NVARCHAR (50)  NOT NULL,
    [FILELENGTH]     INT            NULL,
    [FILENAME]       NVARCHAR (255) NOT NULL,
    [MD5HASH]        NVARCHAR (50)  NULL,
    [TEMPFILENAME]   NVARCHAR (255) NOT NULL,
    [THOIGIAN]       DATETIME       NOT NULL,
    [DOKHAN]         INT            NULL,
    [RETRYCOUNT]     INT            NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0,1,2,3: Độ khẩn; ưu tiên 3,2,1,0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WS_SENDING', @level2type = N'COLUMN', @level2name = N'DOKHAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số lần gửi file thất bại', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WS_SENDING', @level2type = N'COLUMN', @level2name = N'RETRYCOUNT';

