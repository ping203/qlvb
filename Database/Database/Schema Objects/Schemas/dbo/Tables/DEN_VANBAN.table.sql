CREATE TABLE [dbo].[DEN_VANBAN] (
    [IDVB]         INT           IDENTITY (1, 1) NOT NULL,
    [SODEN]        NVARCHAR (10) NOT NULL,
    [NGAYDEN]      DATETIME      NOT NULL,
    [KYHIEU]       NVARCHAR (50) NOT NULL,
    [NGAYVANBAN]   DATE          NULL,
    [LOAIVANBAN]   NVARCHAR (50) NULL,
    [TRICHYEU]     TEXT          NULL,
    [MAHOSO]       NVARCHAR (50) NOT NULL,
    [DOMAT]        INT           NOT NULL,
    [DOKHAN]       INT           NOT NULL,
    [SOTO]         INT           NOT NULL,
    [THOIHAN]      DATETIME      NULL,
    [CANXULY]      INT           NOT NULL,
    [IDVBTRANSFER] NVARCHAR (50) NULL,
    [IDNGUOINHAP]  NVARCHAR (6)  NULL,
    [RECVSTATUS]   INT           NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID van, tự sinh từ  1, 2, 3...', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'IDVB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số văn bản đến', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'SODEN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ngày giờ văn bản đến', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'NGAYDEN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số và Ký hiệu văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'KYHIEU';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ngày ký văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'NGAYVANBAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tên phân loại văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'LOAIVANBAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trích yếu nội dung văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'TRICHYEU';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Thường, 1: Mật, 2: Tuyệt mật; 3: Tối mật', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'DOMAT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Bình thường; 1: Khẩn; 2: Thượng Khẩn; 3: Hỏa tốc', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'DOKHAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số tờ có trong văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'SOTO';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Thời hạn giải quyết văn bản (Có thể NULL)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'THOIHAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Văn bản không cần xử lý', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'CANXULY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<> NULL do Service nhận tự động được đặt bằng giá trị do Service gửi đến', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'IDVBTRANSFER';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID của người nhập văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'IDNGUOINHAP';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trạng thái nhận dữ liệu từ Webservice. 1: Đang nhận; 2: Đã nhận xong (Phụ thuộc vào việc đã nhận đủ file attach hay chưa?)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DEN_VANBAN', @level2type = N'COLUMN', @level2name = N'RECVSTATUS';

