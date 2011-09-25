CREATE TABLE [dbo].[DI_NOINHAN] (
    [ID]           INT           IDENTITY (1, 1) NOT NULL,
    [IDVB]         INT           NOT NULL,
    [MACOQUAN]     NVARCHAR (50) NULL,
    [TRANGTHAIGUI] INT           NOT NULL,
    [RETRYCOUNT]   INT           NOT NULL,
    [MAPHONG]      NVARCHAR (2)  NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID: Tự sinh', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'IDVB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mã cơ quan  nơi nhận', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'MACOQUAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Chưa gửi (Mặc định); 
1: Đang gửi (Do webservice đặt);  
2: Đã gửi (Do webservice đặt); 
4 Không gửi tự động được (Webservice sẽ query các bản ghi = 0 (Chưa gửi) nếu địa chỉ nơi đến không có webservice nhận thì sẽ đặt trạng thái thành 4.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'TRANGTHAIGUI';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số lần đã thử gửi lại (Do webservice đặt)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'RETRYCOUNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mã phòng gửi nội bộ trong cơ quan', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_NOINHAN', @level2type = N'COLUMN', @level2name = N'MAPHONG';

