<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
    <title></title>
    <style type="text/css">
        .x-window-mc {
            background-color : #CED9E7 !important;
        }
    </style>

    <script runat="server">
        
        [DirectMethod]
        public void onEdit2()
        {
            txtMachucvu.Call("remoteValidate");
            txtTenchucvu.Call("remoteValidate");
        }

        protected void CheckComboChucnang(object sender, RemoteValidationEventArgs e)
        {
            ComboBox cb = (ComboBox)sender;
            if (cb.Value == null)
            {
                e.Success = false;
                e.ErrorMessage = "Hãy chọn chức năng";
            }
            else
            {
                e.Success = true;
            }
        }
        
        protected void CheckMaChucvu(object sender, RemoteValidationEventArgs e)
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

        function onAdd() {
            Ext.get('txtMachucvu').setValue('');
            Ext.get('txtTenchucvu').setValue('');
            Ext.get('EditRowIndex').setValue(-1);
            cbChucnang.setValue('');
            btnOK.setText('Thêm');
            TestWindow.show();
        }

        function onEdit() {
            if (GridPanel1.hasSelection()) {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                Ext.get('txtMachucvu').setValue(record.data.MACHUCVU);
                Ext.get('txtTenchucvu').setValue(record.data.TENCHUCVU);
                Ext.get('EditRowIndex').setValue(index);
                cbChucnang.setValue(record.data.MACHUCNANG);
                btnOK.setText('Sửa');
                valid = true;
                btnOK.setDisabled(false);
                TestWindow.show();
            }
        }

        function insertNewRow() {
            var rowIndex = Ext.get('EditRowIndex').getValue();
            var maChucvu = Ext.get('txtMachucvu').getValue();
            var maChucnang = cbChucnang.getValue();
            var tenChucvu = Ext.get('txtTenchucvu').getValue();
            if (rowIndex == -1) {
                GridPanel1.insertRecord(0, { MACHUCVU: maChucvu, TENCHUCVU: tenChucvu, MACHUCNANG:maChucnang });
            } else {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected();
                record.set("MACHUCVU", maChucvu);
                record.set("TENCHUCVU", tenChucvu);
                record.set("MACHUCNANG", maChucnang);
            }
        }

        function onCommitDone() {
            Ext.net.Notification.show({
                pinEvent: 'none',
                html: 'Lưu vào cơ sở dữ liệu thành công!',
                title: ''
            });
        }

        var ChucnangValidator = function (v) {
            var _MaChucnang = cbChucnang.getValue();
            if (_MaChucnang == null)
                return false;
            if (_MaChucnang.length == 0)
                return false;

            return true;
        }

    </script>
</head>
<body>
    <ext:ResourceManager runat="server"/>

    <ext:Store ID="StoreDmChucnang" 
    runat="server" 
    AutoLoad="true"
    WarningOnDirty="false">
        <Proxy>
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/ChucnangList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MACHUCNANG" />
                    <ext:RecordField Name="TENCHUCNANG" />
                </Fields>
            </ext:JsonReader>
        </Reader>
 
    </ext:Store>

    <ext:Store ID="Store1" runat="server" WarningOnDirty="false">
        <Proxy>
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/ChucvuList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MACHUCVU" />
                    <ext:RecordField Name="TENCHUCVU" />
                    <ext:RecordField Name="MACHUCNANG" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/Admin/ChucvuList_Save/" />
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
        Height="150" 
        Title="Thêm chức vụ"
        Draggable="true"
        Width="350"
        Modal="true"
        Layout="FitLayout"
        BodyBorder="false"
        Padding="5">
        <Items>
                <ext:FormPanel 
                    runat="server" 
                    FormID="form1"
                    Border="false"
                    Layout="FormLayout"
                    BodyBorder="false" 
                    Unstyled="false"
                    BodyStyle="background-color:transparent;"
                    MonitorValid="true"
                    >
                    <Items>
                        <ext:TextField 
                            ID="txtMachucvu" 
                            runat="server" 
                            FieldLabel="Mã chức vụ" 
                            AllowBlank="false"
                            BlankText="Hãy nhập mã chức vụ"
                            Width="200"
                            MaxLength="2"
                            IsRemoteValidation="true" >
                                <RemoteValidation OnValidation="CheckMaChucvu" /> 
                            </ext:TextField>
                        <ext:TextField 
                            ID="txtTenchucvu" 
                            runat="server" 
                            FieldLabel="Tên chức vụ" 
                            AllowBlank="false" 
                            BlankText="Hãy nhập tên chức vụ"
                            Text="" 
                            Width="200"
                            >
                            </ext:TextField>

                        <ext:NumberField 
                            ID="EditRowIndex" 
                            runat="server" 
                            AllowBlank="false"
                            FieldLabel="EditRowIndex" 
                            Hidden="true"
                            />
                        <ext:ComboBox ID="cbChucnang"
                            StoreID="StoreDmChucnang"
                            DisplayField="TENCHUCNANG"
                            ValueField="MACHUCNANG"
                            runat="server" 
                            FieldLabel="Chức năng"
                            EmptyText="Hãy chọn chức năng"
                            Validator="ChucnangValidator"
                            Editable="false"
                            Width="200">
                            <Listeners>
                                <Select Handler="this.triggers[0].show(); this.remoteValidate();" />
                                <TriggerClick Handler="this.clearValue(); this.triggers[0].hide(); " />
                            </Listeners>
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                            </Triggers>
                            <RemoteValidation OnValidation="CheckComboChucnang" />
                        </ext:ComboBox>
                    </Items>
                    <Listeners>
                        <ClientValidation Handler="#{btnOK}.setDisabled(!valid);" />
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
            AutoExpandColumn="TENCHUCVU" 
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
                                <Click Handler="onEdit(); Ext.net.DirectMethods.onEdit2();" />
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

           <ColumnModel runat="server">
                <Columns>
                    <ext:Column ColumnID="MACHUCVU" Header="Mã" DataIndex="MACHUCVU" Width="50" Sortable="true" />
                    <ext:Column ColumnID="TENCHUCVU" Header="Tên chức vụ" DataIndex="TENCHUCVU" Width="230" Sortable="true" />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" >
                    <Listeners>
                        <RowSelect Handler="#{btnDelete}.enable();#{btnEdit}.enable();" />
                        <RowDeselect Handler="if (!#{GridPanel1}.hasSelection()) {#{btnDelete}.disable();}" />
                    </Listeners>
                </ext:RowSelectionModel>
            </SelectionModel>            
            
                
            <LoadMask ShowMask="true" />
            <Listeners>
                <RowDblClick Handler="onEdit(); Ext.net.DirectMethods.onEdit2();" />
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
