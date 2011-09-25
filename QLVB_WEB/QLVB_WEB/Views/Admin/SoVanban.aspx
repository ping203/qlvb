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


    <script type="text/javascript">

        var onDelete = function () {

            Ext.MessageBox.confirm("Xóa", "Xóa bản ghi đã chọn?");
            //Ext.MessageBox.show({title: 'Failure',msg: 'sdgdgfd',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.OK});
        }


        function onAdd() {
            Ext.get('txtSovanban').setValue('');
            Ext.get('EditRowIndex').setValue(-1);
            btnOK.setText('Thêm');
            TestWindow.show();
        }

        function onEdit() {
            if (GridPanel1.hasSelection()) {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected(),
                    index = grid.store.indexOf(record);

                Ext.get('txtSovanban').setValue(record.data.TENSOVB);
                Ext.get('EditRowIndex').setValue(index);
                btnOK.setText('Sửa');
                btnOK.setDisabled(false);
                TestWindow.show();
            }
        }

        function insertNewRow() {
            var rowIndex = Ext.get('EditRowIndex').getValue();
            var soVB = Ext.get('txtSovanban').getValue();

            if (rowIndex == -1) {
                GridPanel1.insertRecord(0, { IDSOVB: 0, TENSOVB: soVB });
            } else {
                var grid = GridPanel1,
                    record = grid.getSelectionModel().getSelected();
                record.set("TENSOVB", soVB);
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
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/SoVanbanList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="IDSOVB" />
                    <ext:RecordField Name="TENSOVB" />
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/Admin/SoVanbanList_Save/" />
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
        Height="60" 
        Title="Thêm/Sửa sổ văn bản"
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
                            ID="txtSovanban" 
                            runat="server" 
                            FieldLabel="Sổ văn bản" 
                            AllowBlank="false"
                            MaxLength="50"
                            BlankText="Hãy nhập sổ văn bản"
                            Width="170"
                            >
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
            AutoExpandColumn="TENSOVB" 
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
                    <ext:RowNumbererColumn />
                    <ext:Column ColumnID="TENSOVB" Header="Sổ văn bản" DataIndex="TENSOVB" Width="250" Sortable="true" />
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