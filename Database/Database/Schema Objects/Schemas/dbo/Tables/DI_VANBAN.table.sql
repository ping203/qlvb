CREATE TABLE [dbo].[DI_VANBAN] (
    [IDVB]         INT           IDENTITY (1, 1) NOT NULL,
    [KYHIEU]       NVARCHAR (50) NOT NULL,
    [NGAYVANBAN]   DATE          NOT NULL,
    [LOAIVANBAN]   NVARCHAR (50) NOT NULL,
    [TRICHYEU]     TEXT          NOT NULL,
    [MAHOSO]       NVARCHAR (50) NOT NULL,
    [DOMAT]        INT           NOT NULL,
    [DOKHAN]       INT           NOT NULL,
    [SOTRANG]      INT           NOT NULL,
    [SLPHATHANH]   INT           NOT NULL,
    [NGUOIKY]      NVARCHAR (6)  NULL,
    [DAPHATHANH]   INT           NULL,
    [IDVBTRANSFER] NVARCHAR (50) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID tự sinh', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'IDVB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Số/Ký hiệu văn bản ví dụ như: 139/VTLTNN-TTTH', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'KYHIEU';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ngày ban hành văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'NGAYVANBAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tên loại văn bản theo khung phân loại văn bản (Pháp luật, Thông tư...)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'LOAIVANBAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nội dung trích yếu', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'TRICHYEU';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Thường, 1: Mật; 2: Tuyệt mật; 3: Tuyệt mật', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'DOMAT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0: Thường; 1: Khẩn; 2: Thượng khẩn; 3: Hỏa tốc', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'DOKHAN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tổng Số trang trong văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'SOTRANG';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tổng số lượng phát hành', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'SLPHATHANH';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID người ký văn bản', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'NGUOIKY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trạng thái văn bản, 1: Đã phát hành', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'DAPHATHANH';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'IDTransfer: ID Định danh văn bản theo Server, lấy theo IDVB + ID Máy (ID HDD + CPU ID)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DI_VANBAN', @level2type = N'COLUMN', @level2name = N'IDVBTRANSFER';

