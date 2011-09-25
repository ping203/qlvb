<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>TiepnhanXuly</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
    <style type="text/css">
        .hide-border .x-panel-body {
            border: 1px solid #ffffff;
        }
        .show-border .x-panel-body {
            border: 1px solid #99bbe8;
        }
        .gobackbtn
        {
            background-image: url(/resources/images/goback.png) !important;
            background-position: center top;
        }
        
        .okbtn
        {
            background-image: url(/resources/images/ok.png) !important;
            background-position: center top;
        }
        
        /* For button align left */
        .btnLeft .x-btn-mc
        {
            text-align: left !important;
        }
        
        .btnLeft .x-btn-mc em {
            padding-left : 5px;
            padding-right : 5px;
        }

        .lock 
        {
            background-image: url(/resources/images/lock.png) !important;
            background-position: left center;
        }
        
        .lock_yellow
        {
            background-image: url(/resources/images/lock_yellow.png) !important;
            background-position: left center;
        }
        
        .lock_red
        {
            background-image: url(/resources/images/lock_red.png) !important;
            background-position: left center;
        }
        
        .dk_khan
        {
            background-image: url(/resources/images/dk_khan.png) !important;
            background-position: left center;
        }
        
        .dk_thuongkhan
        {
            background-image: url(/resources/images/dk_thuongkhan.png) !important;
            background-position: left center;
        }
        
        .dk_hoatoc
        {
            background-image: url(/resources/images/dk_hoatoc.png) !important;
            background-position: left center;
        }
        
        .x-window-mc {
            background-color : #CED9E7 !important;
        }
        
        /* Setting for column */
        .x-grid3-hd-NGAYDEN, .x-grid3-hd-SODEN, .x-grid3-hd-KYHIEU, .x-grid3-hd-TRICHYEU, .x-grid3-hd-NOIGUI, .x-grid3-hd-THOIHAN {
            text-align: center;
            font: 12px arial,tahoma,helvetica,sans-serif;
            font-weight: bold;
        }
        
        /* Setting for column */
        .x-grid3-hd-ATTACH {
            text-align: center;
            font: 12px arial,tahoma,helvetica,sans-serif;
            font-weight: bold;
            background: transparent url('/resources/images/attachment.gif') no-repeat center center !important;
        }
        
        /* Setting GidPanel header height */
        .x-grid3-hd-inner { height:20px !important; white-space: normal; } 
        
        .x-grid3-row td
        {
            font: 12px arial,tahoma,helvetica,sans-serif;
        }
        
        /* Chờ phân xử lý */
        .vb_state0 {
	        color: #ff0000;
        }
        
        /* Đã phân xử lý */
        .vb_state1 {
	        color: #000000;
        } 
        
        /* Quá hạn */ 
        .vb_state2 {
	        color: #8b4513;
        } 
        
        /* Hoàn thành */
        .vb_state3 {
	        color: #0000ff;
        } 
        
    </style>
    <script type="text/javascript">
        var getRowClass = function (record) {
            if (record.data.STATE <= 2) {
                return "vb_state0";
            }

            // Đã hoàn thành
            if (record.data.STATE == 6) {
                return "vb_state3";
            }

            if (record.data.STATE == 5) {
                return "vb_state2";
            }

            if (record.data.STATE == 4) {
                return "vb_state1";
            }

            return "vb_state2";
        }

        function linkRenderer(value, meta, record) {
            if (record.data.ATTACH > 0)
                return String.format('<img src="/resources/images/vb_attach.gif" alt="attach"/>');
            else
                return String.format("");
        }

        function onAdd() {
            GridPanel1.hide();
            vewVB.show();
        }

        function onTest() {
            PanelContent.body["removeClass"]("x-panel-body-noborder");
            PanelContent2.body["removeClass"]("x-panel-body-noborder");
        }
    </script>  
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    <ext:Store ID="Store1" runat="server" WarningOnDirty="false">
        <Proxy>
            <ext:HttpProxy Json="true" Method="POST" Url="~/VBDen/VBDenList/" />
        </Proxy>
        <AutoLoadParams>
            <ext:Parameter Name="start" Value="0" Mode="Raw" />
            <ext:Parameter Name="limit" Value="20" Mode="Raw" />
        </AutoLoadParams>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                <ext:RecordField Name="IDVB" />
                <ext:RecordField Name="NOIGUI" />
                <ext:RecordField Name="TENSOVB" />
                <ext:RecordField Name="SODEN" />
                <ext:RecordField Name="NGAYDEN" />
                <ext:RecordField Name="KYHIEU" />
                <ext:RecordField Name="NGAYVANBAN" />
                <ext:RecordField Name="LOAIVANBAN" />
                <ext:RecordField Name="TRICHYEU" />
                <ext:RecordField Name="MAHOSO" />
                <ext:RecordField Name="DOMAT" />
                <ext:RecordField Name="DOKHAN" />
                <ext:RecordField Name="SOTO" />
                <ext:RecordField Name="THOIHAN" />
                <ext:RecordField Name="NGUOIKY" />
                <ext:RecordField Name="CHUCVUNGUOIKY" />
                <ext:RecordField Name="CANXULY" />
                <ext:RecordField Name="ATTACH" />
                <ext:RecordField Name="STATE" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/VBDen/VBDenList_Save/" />
        </UpdateProxy>
        <Listeners>
            <LoadException Handler="var e = e || {message: response.responseText}; alert('Load failed: ' + e.message);" />
            <CommitDone Handler="onCommitDone();" />
        </Listeners>
    </ext:Store>

    <%-- Main view port --%>
    <ext:ViewPort ID="ViewPort1" runat="server" Layout="FitLayout">
    <Items>    
    <ext:GridPanel ID="GridPanel1" 
            runat="server"
            StoreID="Store1"
            AutoExpandColumn="TRICHYEU" 
            AutoHeight="true"
            Layout="FitLayout"
            >
            
            <TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" >
                        <Items>
                         <ext:Button ID="btnAdd" runat="server" Text="Thêm " Icon="Add" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="onAdd();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnEdit" runat="server" Text="Sửa " Icon="BookEdit" Disabled="true" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="onEdit();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnDelete" runat="server" Text="Xóa " Icon="Delete" Disabled="true" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="#{GridPanel1}.deleteSelected();if (!#{GridPanel1}.hasSelection()) {#{btnDelete}.disable();#{btnEdit}.disable();}" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarSeparator />
                        <ext:Button ID="btnSave" runat="server" Text="Lưu " Icon="Disk" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="#{GridPanel1}.save();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRefresh" runat="server" Text="Tải lại" Icon="ArrowRefresh"  Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="#{btnDelete}.disable();#{btnEdit}.disable();#{GridPanel1}.reload();" />
                            </Listeners>
                        </ext:Button>
                        
                        <ext:ToolbarSeparator />
                        <ext:ToolbarSpacer runat="server" Width="30"/>

                        <ext:Button ID="Button2" runat="server" Text="Phân xử lý" Icon="LayoutLightning" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button7" runat="server" Text="Phân quyền xem" Icon="UserComment" Height="32" Width="40" >
                            <Listeners>
                                <Click Handler="" />
                            </Listeners>
                        </ext:Button>
            </Items>
            </ext:Toolbar>
            </TopBar>  
            <BottomBar>
                <ext:Toolbar ID="Toolbar2" runat="server" >
                    <Items>
                        <ext:ToolbarFill />
                        <ext:Image runat="server" Visible="true" ImageUrl="/resources/images/legend.png">
                        </ext:Image>
                    </Items>
                </ext:Toolbar>
            </BottomBar>              

           <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ColumnID="ATTACH" Header="" DataIndex="ATTACH" Width="30" Sortable="false" Align="Center">
                        <Renderer Fn="linkRenderer" />
                    </ext:Column>
                    <ext:Column ColumnID="NGAYDEN" Header="Ngày đến" DataIndex="NGAYDEN" Width="100" Sortable="true" Align="Center">
                        <Renderer Handler="return Ext.util.Format.date(value, 'd/m/Y');" />
                    </ext:Column>
                    <ext:Column ColumnID="SODEN" Header="Số đến" DataIndex="SODEN" Width="70" Sortable="true" Align="Center"/>
                    <ext:Column ColumnID="NOIGUI" Header="Nơi gửi" DataIndex="NOIGUI" Width="250" Sortable="true" Align="Center"/>
                    <ext:Column ColumnID="KYHIEU" Header="Ký hiệu" DataIndex="KYHIEU" Width="110" Sortable="true" Align="Center"/>
                    <ext:Column ColumnID="TRICHYEU" Header="Trích yếu" DataIndex="TRICHYEU" Sortable="true" Align="Center"/>
                    <ext:Column ColumnID="THOIHAN" Header="Hạn giải quyết" DataIndex="THOIHAN" Width="100" Sortable="true" Align="Center">
                        <Renderer Handler="return Ext.util.Format.date(value, 'd/m/Y');" />
                    </ext:Column>
                    <ext:Column ColumnID="STATE" Header="test" DataIndex="STATE" Width="20" Sortable="true" Align="Center"/>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView ID="GridView1" runat="server">
                    <GetRowClass Fn="getRowClass" />
                </ext:GridView>
            </View>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" >
                    <Listeners>
                        <RowSelect Handler="#{btnDelete}.enable();#{btnEdit}.enable();" />
                        <RowDeselect Handler="if (!#{GridPanel1}.hasSelection()) {#{btnDelete}.disable();}" />
                    </Listeners>
                </ext:RowSelectionModel>
            </SelectionModel>            
            
                
            <LoadMask ShowMask="true" />
            <Listeners>
                <RowDblClick Handler="onEdit();" />
            </Listeners>
    </ext:GridPanel>    

    <%-- START: Window tạo mới một văn bản hoặc sửa văn bản --%>
    <ext:Panel ID="vewVB" Border="false" runat="server" 
    Layout="fit" Height="600" 
    Hidden="true"
    MonitorResize="true">
        <Items>
            <ext:Panel ID="panelPHADetails" runat="server" Frame="false" Border="false">
                <Items>
                    <ext:Panel ID="Panel2" runat="server" Border="false" Layout="FormLayout">

                    <%-- Start top menu--%>
                    <TopBar>
                <ext:Toolbar ID="Toolbar3" runat="server">
                    <Items>
                        <ext:ButtonGroup ID="ButtonGroup1" runat="server" Height="70">
                            <Items>
                                <ext:Button ID="Button10" runat="server" Text="Thêm" Scale="Medium" IconCls="okbtn" IconAlign="Top" Width="70" Height="67">
                                    <Listeners>
                                        <Click Handler="onTest();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup ID="ButtonGroup2" runat="server" >
                            <Items>
                                <ext:TableLayout ID="TableLayout2" runat="server" Columns="1">
                                <Cells>
                                        <ext:Cell>
                                            <ext:Button ID="Button3" runat="server" IconCls="lock" Cls="btnLeft" Width="110" IconAlign="Left" Text="Mật" EnableToggle="true" ToggleGroup="Group1" />
                                        </ext:Cell>
                                        <ext:Cell>
                                            <ext:Button ID="Button4" runat="server" IconCls="lock_yellow" Cls="btnLeft" Width="110" IconAlign="Left" Text="Tối mật" EnableToggle="true" ToggleGroup="Group1" />
                                        </ext:Cell>
                                        <ext:Cell>
                                            <ext:Button ID="Button5" runat="server" IconCls="lock_red" Cls="btnLeft" Width="110" IconAlign="Left" Text="Tuyệt mật" EnableToggle="true" ToggleGroup="Group1" />
                                        </ext:Cell>
                                    </Cells>
                                </ext:TableLayout>
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup ID="ButtonGroup3" runat="server">
                            <Items>
                                <ext:TableLayout ID="TableLayout3" runat="server" Columns="1">
                                <Cells>
                                        <ext:Cell>
                                            <ext:Button ID="Button6" runat="server" IconCls="dk_khan" Cls="btnLeft" Width="110" Text="Khẩn" EnableToggle="true" ToggleGroup="Group2" />
                                        </ext:Cell>
                                        <ext:Cell>
                                            <ext:Button ID="Button8" runat="server" IconCls="dk_thuongkhan" Cls="btnLeft" Width="110" Text="Thượng khẩn" EnableToggle="true" ToggleGroup="Group2" />
                                        </ext:Cell>
                                        <ext:Cell>
                                            <ext:Button ID="Button9" runat="server" IconCls="dk_hoatoc" Cls="btnLeft" Width="110" Text="Hỏa tốc" EnableToggle="true" ToggleGroup="Group2" />
                                        </ext:Cell>
                                    </Cells>
                                </ext:TableLayout>
                            </Items>
                        </ext:ButtonGroup>
                        <ext:ButtonGroup ID="ButtonGroup4" runat="server" Height="70">
                            <Items>
                                <ext:Button runat="server" Text="Quay lại" Scale="Medium" IconCls="gobackbtn" IconAlign="Top" Width="70" Height="67">
                                    <Listeners>
                                        <Click Handler="#{GridPanel1}.show();#{vewVB}.hide();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:ButtonGroup>

                    </Items>
                </ext:Toolbar>
            </TopBar>

                        <Items>
                        <ext:Panel ID="PanelContent" runat="server" Border="false" Frame="false" Layout="FormLayout" Cls="hide-border" BodyStyle="background-color:#ffffff;">
                        <Items>

                        <%-- Form chứa các control --%>
                        <ext:Panel ID="PanelContent2" runat="server" Layout="FormLayout" Padding="10" BodyStyle="background-color:#ffffff;">
                        <Items>
                        
                        <ext:Panel runat="server" Layout="FormLayout" Padding="10" BodyStyle="background-color:#f0f0f0;">
                        <Items>

                            <ext:Container ID="Container1" runat="server" Layout="Column" AutoHeight="true">
                                <LayoutConfig>
                                    <ext:ColumnLayoutConfig FitHeight="false" />
                                </LayoutConfig>
                                <Items>
                                    <ext:Container ID="Container11" runat="server" LabelAlign="Left" Layout="Form" LabelWidth="125" ColumnWidth=".4">
                                        <Items>
                                            <ext:TextField ID="TextboxPHAName" runat="server" FieldLabel="Name" MaxLength="60" AllowBlank="false" AnchorHorizontal="95%" />
                                            <ext:Label ID="LblRevalidation" runat="server" Visible="true" />
                                            <ext:TextField ID="TextRevalidation" runat="server" Visible="false" Width="90px" />
                                        </Items>
                                    </ext:Container>
                                    
                                    <ext:Container ID="Container12" runat="server" LabelAlign="Left" Layout="Form" LabelWidth="125" ColumnWidth=".2">
                                        <Items>
                                            <ext:Label runat="server"></ext:Label>
                                        </Items>
                                    </ext:Container>

                                    <ext:Container ID="Container13" runat="server" LabelAlign="Left" LabelWidth="125" Layout="Form" ColumnWidth=".4">
                                        <Items>
                                            <ext:TextField ID="TextboxPHAPrefix" runat="server" FieldLabel="Prefix" Width="60" MaxLength="8" AnchorHorizontal="50%" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="Container2" runat="server" Layout="Column" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container21" runat="server" LabelAlign="Left" LabelWidth="125" Layout="Form" ColumnWidth=".8">
                                        <Items>
                                            <ext:TextArea ID="TextboxScope" runat="server" FieldLabel="Scope" MaxLength="32766" AnchorHorizontal="100%" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>

                        </Items>
                        </ext:Panel>
                        </Items>
                        </ext:Panel>

                        </Items>
                        </ext:Panel> <%-- End panel content --%>
                        </Items>


                    </ext:Panel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Panel>
    <%-- END: Window tạo mới một văn bản hoặc sửa văn bản --%>

    </Items>
    </ext:ViewPort>
</body>
</html>
