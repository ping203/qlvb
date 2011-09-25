<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
    <title></title>
    <style type="text/css">
        .x-window-mc {
            background-color : #CED9E7 !important;
        }
    </style>

    <script runat="server">
        protected void CheckField(object sender, RemoteValidationEventArgs e)
        {
            TextField field = (TextField)sender;
        
            if (field.Text.Length <= 10)
            {
                e.Success = true;
            }
            else
            {
                e.Success = false;
                e.ErrorMessage = "Tối đa 10 kí tự";
            }

        }

    </script>

    <script type="text/javascript">

        var onDelete = function () {

            Ext.MessageBox.confirm("Xóa", "Xóa bản ghi đã chọn?");
            //Ext.MessageBox.show({title: 'Failure',msg: 'sdgdgfd',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.OK});
        }

        function isValid() {
            var maCoquan = Ext.get('txtMacoquan').getValue();
            var tenCoquan = Ext.get('txtTencoquan').getValue();
            var ghiChu = Ext.get('txtGhichu').getValue();
            var url = Ext.get('txtUrl').getValue().toLowerCase();
            var b1 = (maCoquan.length < 50 && maCoquan.length > 0 && tenCoquan.length > 0);
            var b2 = true;
            if (url.length > 0) {
                if (url.search("http://") == -1 && url.search("https://") == -1) b2 = false;
            }

            return b1 && b2;
        }

        function onAdd() {
            Ext.get('txtMacoquan').setValue('');
            Ext.get('txtTencoquan').setValue('');
            Ext.get('txtGhichu').setValue('');
            Ext.get('txtUrl').setValue('');
            Ext.get('EditRowIndex').setValue(-1);
            btnOK.setText('Thêm');
            TestWindow.show();
        }

        function onEdit() {
            if (GridPanel1.hasSelection()) {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                Ext.get('txtMacoquan').setValue(record.data.MACOQUAN);
                Ext.get('txtTencoquan').setValue(record.data.TENCOQUAN);
                Ext.get('txtGhichu').setValue(record.data.GHICHU);
                Ext.get('txtUrl').setValue(record.data.WEBSERVICEURL);
                Ext.get('EditRowIndex').setValue(index);
                btnOK.setText('Sửa');
                valid = true;
                btnOK.setDisabled(false);
                TestWindow.show();
            }
        }

        function insertNewRow() {
            var rowIndex = Ext.get('EditRowIndex').getValue();
            var maCoquan = Ext.get('txtMacoquan').getValue();
            var tenCoquan = Ext.get('txtTencoquan').getValue();
            var ghiChu = Ext.get('txtGhichu').getValue();
            var url = Ext.get('txtUrl').getValue();
            if (rowIndex == -1) {
                GridPanel1.insertRecord(0, { MACOQUAN: maCoquan, TENCOQUAN: tenCoquan, GHICHU: ghiChu, WEBSERVICEURL: url });
            } else {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected();
                //record.set("MACOQUAN", maCoquan);
                record.set("TENCOQUAN", tenCoquan);
                record.set("GHICHU", ghiChu);
                record.set("WEBSERVICEURL", url);
            }
        }

        function onCommitDone() {
            Ext.net.Notification.show({
                pinEvent: 'none',
                html: 'Lưu vào cơ sở dữ liệu thành công!',
                title: ''
            });
        }

    </script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server"/>

    <ext:Store ID="Store1" runat="server" WarningOnDirty="false">
        <Proxy>
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/CoquanList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MACOQUAN" />
                    <ext:RecordField Name="TENCOQUAN" />
                    <ext:RecordField Name="GHICHU" />
                    <ext:RecordField Name="WEBSERVICEURL" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/Admin/CoquanList_Save/" />
        </UpdateProxy>
        <Listeners>
            <LoadException Handler="var e = e || {message: response.responseText}; alert('Load failed: ' + e.message);" />
            <CommitDone Handler="onCommitDone();" />
        </Listeners>
    </ext:Store>

    <ext:Window 
        ID="TestWindow"
        Hidden="true"
        runat="server" 
        Closable="true"
        Resizable="false"
        Height="170" 
        Title="Thêm cơ quan"
        Draggable="true"
        Width="400"
        Modal="true"
        BodyBorder="false"
        Padding="5">
        <Items>
                <ext:FormPanel ID="FormPanel1" 
                    runat="server" 
                    FormID="form1"
                    Border="false"
                    Layout="FormLayout"
                    AutoWidth="true"
                    AutoHeight="true"
                    BodyBorder="false" 
                    Unstyled="false"
                    BodyStyle="background-color:transparent;"
                    MonitorValid="true"
                    >
                    <Items>
                        <ext:TextField 
                            ID="txtMacoquan" 
                            runat="server" 
                            FieldLabel="Mã cơ quan" 
                            AllowBlank="false"
                            BlankText="Hãy nhập mã cơ quan"
                            AnchorHorizontal="100%"
                            IsRemoteValidation="false" >
                                <RemoteValidation OnValidation="CheckField" /> 
                            </ext:TextField>

                        <ext:TextField 
                            ID="txtTencoquan" 
                            runat="server" 
                            FieldLabel="Tên cơ quan" 
                            AllowBlank="false" 
                            AnchorHorizontal="100%"
                            BlankText="Hãy nhập tên cơ quan."
                            Text="" >
                        </ext:TextField>
                        <ext:TextField 
                            ID="txtGhichu" 
                            runat="server" 
                            FieldLabel="Ghi chú" 
                            AllowBlank="true" 
                            AnchorHorizontal="100%"
                            Text="" >
                        </ext:TextField>
                        <ext:TextField 
                            ID="txtUrl" 
                            runat="server" 
                            FieldLabel="Web service" 
                            AllowBlank="true" 
                            AnchorHorizontal="100%"
                            Text="" >
                        </ext:TextField>
                        <ext:NumberField 
                            ID="EditRowIndex" 
                            runat="server" 
                            AllowBlank="false"
                            FieldLabel="EditRowIndex" 
                            Hidden="true"
                            />
                    </Items>
                    <Listeners>
                        <ClientValidation Handler="#{btnOK}.setDisabled(!isValid());" />
                    </Listeners>
                </ext:FormPanel>
        </Items>
        

        <Buttons>
            <ext:Button ID="btnOK" runat="server" Text="Thêm" Icon="Accept">
                <Listeners>
                    <Click Handler="#{TestWindow}.hide();insertNewRow();" />
                </Listeners>
            </ext:Button>
        </Buttons>
        
    </ext:Window>

    <ext:ViewPort ID="ViewPort1" runat="server" Layout="FitLayout">
    <Items>    
    <ext:GridPanel ID="GridPanel1" 
            runat="server"
            StoreID="Store1"
            AutoExpandColumn="GHICHU" 
            AutoHeight="true"
            Layout="FitLayout"
            >
            
            <TopBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" >
                        <Items>

                        <ext:Button ID="btnAdd" runat="server" Text="Thêm " Icon="Add" >
                            <Listeners>
                                <Click Handler="onAdd();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnDelete" runat="server" Text="Xóa " Icon="Delete" >
                            <Listeners>
                                <Click Handler="#{GridPanel1}.deleteSelected();if (!#{GridPanel1}.hasSelection()) {#{btnDelete}.disable();#{btnEdit}.disable();}" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnEdit" runat="server" Text="Sửa " Icon="BookEdit" Width="30">
                            <Listeners>
                                <Click Handler="onEdit();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnSave" runat="server" Text="Lưu " Icon="Disk">
                            <Listeners>
                                <Click Handler="#{GridPanel1}.save();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRefresh" runat="server" Text="Tải lại" Icon="ArrowRefresh">
                            <Listeners>
                                <Click Handler="#{btnDelete}.disable();#{btnEdit}.disable();#{GridPanel1}.reload();" />
                            </Listeners>
                        </ext:Button>
            </Items>
            </ext:Toolbar>
            </TopBar>                

           <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ColumnID="MACOQUAN" Header="Mã" DataIndex="MACOQUAN" Width="150" Sortable="true" />
                    <ext:Column ColumnID="TENCOQUAN" Header="Tên cơ quan" DataIndex="TENCOQUAN" Width="250" Sortable="true" />
                    <ext:Column ColumnID="WEBSERVICEURL" Header="Web service" DataIndex="WEBSERVICEURL" Width="250" Sortable="true" />
                    <ext:Column ColumnID="GHICHU" Header="Ghi chú" DataIndex="GHICHU" Sortable="true" />
                </Columns>
            </ColumnModel>
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

    </Items>
    </ext:ViewPort>
    <ext:KeyMap ID="KeyMap1" runat="server" Target="={#{TestWindow}.getBody()}" >
        <ext:KeyBinding>
            <Keys>
                <ext:Key Code="ENTER" />
            </Keys>
            <Listeners>
                <Event Handler="e.stopEvent();#{btnOK}.fireEvent('click');" />
            </Listeners>
        </ext:KeyBinding>  
    </ext:KeyMap>

</body>
</html>