-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getDSNoinhanVanbanDi]
	-- Add the parameters for the stored procedure here
	@vTrangThaigui int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- SELECT <@Param1, sysname, @p1>, <, sysname, @p2>
SELECT     DI_NOINHAN.ID, DI_NOINHAN.IDVB, DI_NOINHAN.MACOQUAN, DI_NOINHAN.TRANGTHAIGUI, DI_NOINHAN.RETRYCOUNT, DI_NOINHAN.MAPHONG
FROM         DI_VANBAN INNER JOIN
                      DI_NOINHAN ON DI_VANBAN.IDVB = DI_NOINHAN.IDVB
WHERE     (DI_NOINHAN.TRANGTHAIGUI = @vTrangThaigui) AND (DI_VANBAN.DAPHATHANH = 1)
ORDER BY DI_VANBAN.DOKHAN DESC, DI_VANBAN.NGAYVANBAN DESC
END
