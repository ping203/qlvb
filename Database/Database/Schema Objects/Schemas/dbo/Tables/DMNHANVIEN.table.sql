CREATE TABLE [dbo].[DMNHANVIEN] (
    [MANV]        NVARCHAR (6)  NOT NULL,
    [TEN]         NVARCHAR (50) NOT NULL,
    [USERNAME]    NVARCHAR (50) NULL,
    [PASSWORD]    NVARCHAR (50) NULL,
    [TRANGTHAI]   INT           NOT NULL,
    [NICKSKYPE]   NVARCHAR (50) NULL,
    [NICKYAHOO]   NVARCHAR (50) NULL,
    [EMAIL]       NVARCHAR (50) NULL,
    [MOBILE]      NVARCHAR (20) NULL,
    [DIACHI]      NVARCHAR (50) NULL,
    [CHUCVU]      NVARCHAR (50) NULL,
    [OFFICEPHONE] NVARCHAR (20) NULL,
    [CAPBAC]      NVARCHAR (50) NULL,
    [CHUCNANG]    NVARCHAR (50) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'2 ký tự đầu là mã phòng/ban. 4 kí tự sau là mã nhân viên', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMNHANVIEN', @level2type = N'COLUMN', @level2name = N'MANV';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Trạng thái = 0 là đã nghỉ (Hoặc hết hiệu lực)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMNHANVIEN', @level2type = N'COLUMN', @level2name = N'TRANGTHAI';

