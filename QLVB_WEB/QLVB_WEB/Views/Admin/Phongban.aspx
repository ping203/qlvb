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
        
            if (field.Text.Length <= 2)
            {
                e.Success = true;
            }
            else
            {
                e.Success = false;
                e.ErrorMessage = "Tối đa 2 kí tự";
            }

        }

    </script>

    <script type="text/javascript">

        var onDelete = function () {

            Ext.MessageBox.confirm("Xóa", "Xóa bản ghi đã chọn?");
            //Ext.MessageBox.show({title: 'Failure',msg: 'sdgdgfd',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.OK});
        }

        function isValid() {
            var maPhong = Ext.get('txtMaphong').getValue();
            var tenPhong = Ext.get('txtTenphong').getValue();
            return (maPhong.length < 3 && maPhong.length > 0 && tenPhong.length > 0);
        }

        function onAdd() {
            Ext.get('txtMaphong').setValue('');
            Ext.get('txtTenphong').setValue('');
            Ext.get('EditRowIndex').setValue(-1);
            btnOK.setText('Thêm');
            TestWindow.show();
        }

        function onEdit() {
            if (GridPanel1.hasSelection()) {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                Ext.get('txtMaphong').setValue(record.data.MAPHONG);
                Ext.get('txtTenphong').setValue(record.data.TENPHONG);
                Ext.get('EditRowIndex').setValue(index);
                btnOK.setText('Sửa');
                btnOK.setDisabled(false);
                TestWindow.show();
            }
        }

        function insertNewRow() {
            var rowIndex = Ext.get('EditRowIndex').getValue();
            var maPhong = Ext.get('txtMaphong').getValue();
            var tenPhong = Ext.get('txtTenphong').getValue();

            if (rowIndex == -1) {
                GridPanel1.insertRecord(0, { MAPHONG: maPhong, TENPHONG: tenPhong });
            } else {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected();
                //record.set("MAPHONG", maPhong);
                record.set("TENPHONG", tenPhong);
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
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/PhongbanList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MAPHONG" />
                    <ext:RecordField Name="TENPHONG" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/Admin/PhongbanList_Save/" />
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
        Height="120" 
        Title="Thêm phòng ban"
        Draggable="true"
        Width="300"
        Modal="true"
        Layout="fit"
        BodyBorder="false"
        Padding="5">
        <Items>
                <ext:FormPanel ID="FormPanel1" 
                    runat="server" 
                    FormID="form1"
                    Border="false"
                    Layout="form"
                    BodyBorder="false" 
                    Unstyled="false"
                    BodyStyle="background-color:transparent;"
                    MonitorValid="true"
                    >
                    <Items>
                        <ext:TextField 
                            ID="txtMaphong" 
                            runat="server" 
                            FieldLabel="Mã phòng ban" 
                            AllowBlank="false"
                            BlankText="Hãy nhập mã phòng ban"
                            AutoWidth="true"
                            IsRemoteValidation="true" >
                                <RemoteValidation OnValidation="CheckField" /> 
                            </ext:TextField>
                        <ext:TextField 
                            ID="txtTenphong" 
                            runat="server" 
                            FieldLabel="Tên phòng ban" 
                            AllowBlank="false" 
                            AutoWidth="true"
                            BlankText="Hãy nhập tên phòng ban."
                            Text=""
                        />
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
            AutoExpandColumn="TENPHONG" 
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
                    <ext:Column ColumnID="MAPHONG" Header="Mã" DataIndex="MAPHONG" Width="50" Sortable="true" />
                    <ext:Column ColumnID="TENPHONG" Header="Tên phòng ban" DataIndex="TENPHONG" Width="250" Sortable="true" />
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