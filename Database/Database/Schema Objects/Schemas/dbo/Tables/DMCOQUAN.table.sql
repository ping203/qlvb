CREATE TABLE [dbo].[DMCOQUAN] (
    [MACOQUAN]      NVARCHAR (50)  NOT NULL,
    [TENCOQUAN]     NVARCHAR (50)  NOT NULL,
    [GHICHU]        TEXT           NULL,
    [WEBSERVICEURL] NVARCHAR (255) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Địa chỉ webservice để gửi/nhận văn bản tự động', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMCOQUAN', @level2type = N'COLUMN', @level2name = N'WEBSERVICEURL';

