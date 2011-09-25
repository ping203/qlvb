CREATE TABLE [dbo].[DMPHONGBAN] (
    [MAPHONG]   NVARCHAR (2)  NOT NULL,
    [IDUYQUYEN] NVARCHAR (6)  NULL,
    [TENPHONG]  NVARCHAR (50) NOT NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Mã phòng 2 Ký tự, từ 10-99
Đối với cấp lãnh đạo (Không có mã phòng) thì xem mã phòng là 00', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMPHONGBAN', @level2type = N'COLUMN', @level2name = N'MAPHONG';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID người được ủy quyền; NULL = Không ủy quyền', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMPHONGBAN', @level2type = N'COLUMN', @level2name = N'IDUYQUYEN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tên phòng/ban', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMPHONGBAN', @level2type = N'COLUMN', @level2name = N'TENPHONG';

