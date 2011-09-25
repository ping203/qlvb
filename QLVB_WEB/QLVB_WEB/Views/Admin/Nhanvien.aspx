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
    
    [DirectMethod]
    public void onEdit2()
    {
        txtTenDangnhap.Call("remoteValidate");
        txtPassword.Call("remoteValidate");
        txtEmail.Call("remoteValidate");
    }

   
    protected void CheckEmail(object sender, RemoteValidationEventArgs e)
    {
        TextField field = (TextField)sender;
        bool bValid = true;
        int nPos1 = field.Text.IndexOf('@');
        int nPos2 = field.Text.IndexOf('.');
        int nPos3 = field.Text.IndexOf((char)32);
        int nLength = field.Text.Length;
        
        if (nPos1 == -1 || nPos2 == -1) bValid = false;
        if (bValid && nPos1 > nPos2) bValid = false;
        if (bValid && nPos3 >= 0) bValid = false;
        if (bValid && nPos2 >= nLength-2) bValid = false;

        if (!bValid)
        {
            e.Success = false;
            e.ErrorMessage = "Địa chỉ email không hợp lệ";
        }
        else
        {
            e.Success = true;
        }
    }

    protected void CheckTenDangnhap(object sender, RemoteValidationEventArgs e)
    {
        TextField field = (TextField)sender;

        if (field.Text.Length == 0)
        {
            e.Success = false;
            e.ErrorMessage = "Tên đăng nhập không được phép rỗng";
        }
        else if (field.Text.IndexOf((char)32) >= 0)
        {
            e.Success = false;
            e.ErrorMessage = "Tên đăng nhập không được phép chứa dấu cách";
        }
        else
        {
            e.Success = true;
        }
    }

    protected void CheckPassword(object sender, RemoteValidationEventArgs e)
    {
        TextField field = (TextField)sender;
        
        if (this.EditRowIndex.Value.ToString() == "-1" && field.Text.Length == 0)
        {
            e.Success = false;
            e.ErrorMessage = "Mật khẩu không được phép rỗng";
        }
        else
        {
            e.Success = true;
        }
    }

    protected void CheckPasswordRetype(object sender, RemoteValidationEventArgs e)
    {
        TextField field = (TextField)sender;

        if (this.txtPassword.Text.Length != this.txtPasswordRetype.Text.Length)
        {
            e.Success = false;
            e.ErrorMessage = "Mật khẩu gõ lại không khớp";
        }
        else
        {
            e.Success = true;
        }
    }
</script>

<script type="text/javascript">

    function CheckValid() {
        var errString = '';
        var bValid = true;
        var rowIndex = Ext.get('EditRowIndex').getValue();

        var _txtHoten = Ext.get('txtHoten').getValue().trim();
        var _txtTenDangnhap = Ext.get('txtTenDangnhap').getValue().trim();
        var _txtPassword = Ext.get('txtPassword').getValue().trim();
        var _txtPasswordRetype = Ext.get('txtPasswordRetype').getValue().trim();
        var _txtEmail = Ext.get('txtEmail').getValue().trim();
        
        if (_txtHoten.length == 0 && bValid) {
            bValid = false;
            errString = 'Họ tên không được phép rỗng';
        }
        if (_txtTenDangnhap.length == 0 && bValid) {
            bValid = false;
            errString = 'Tên đăng nhập không được phép rỗng';
        }

        if (_txtTenDangnhap.search(" ") != -1 && bValid) {
            bValid = false;
            errString = 'Tên đăng nhập không được chứa dấu cách';
        }

        if (_txtEmail.length == 0 && bValid) {
            bValid = false;
            errString = 'Địa chỉ email không được phép rỗng';
        }
        
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (bValid && !filter.test(_txtEmail)) {
            bValid = false;
            errString = 'Địa chỉ email không hợp lệ';

        }
                
        if (bValid) {
            btnOK.setDisabled(false);
        }
        else {
            btnOK.setDisabled(true);
        }
    }
        
    function onDelete() {
        Ext.MessageBox.confirm("Xóa", "Xóa nhân viên đã chọn?");
        //Ext.MessageBox.show({title: 'Failure',msg: 'sdgdgfd',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.OK});
    }

    function setFilter() {
        Pager1.changePage(1);
        Store1.reload();
        Store1.dataBind();
           
    }

    function onAdd() {
        Ext.get('txtHoten').setValue('');
        Ext.get('txtTenDangnhap').setValue('');
        Ext.get('txtPassword').setValue('');
        Ext.get('txtPasswordRetype').setValue('');
        Ext.get('cbPhong').setValue('');
        Ext.get('cbChucvu').setValue('');
        Ext.get('txtEmail').setValue('');

        Ext.get('txtDiachi').setValue('');
        Ext.get('txtMobile').setValue('');
        Ext.get('txtOfficePhone').setValue('');
        Ext.get('txtYahoo').setValue('');
        Ext.get('txtSkype').setValue('');
        Ext.get('cbTrangthai').setValue(1);
        Ext.get('cbAdmin').setValue(0);

        Ext.get('EditRowIndex').setValue(-1);
        
        cbTrangthai.setValue(1);
        cbAdmin.setValue(0);

        btnOK.setText('Thêm');
        UserWindow.show();
    }

    function onEdit() {
        if (GridPanel1.hasSelection()) {
            var grid = GridPanel1,
                record = grid.getSelectionModel().getSelected(),
                index = grid.store.indexOf(record);

            Ext.get('txtHoten').setValue(record.data.TEN);
            Ext.get('txtTenDangnhap').setValue(record.data.USERNAME);
            Ext.get('txtPassword').setValue('');
            Ext.get('txtPasswordRetype').setValue('');
            cbPhong.setValue(record.data.MAPHONG);
            if (record.data.MAPHONG.length > 0)
                cbPhong.triggers[0].show();
            else
                cbPhong.triggers[0].hide();

            cbChucvu.setValue(record.data.CHUCVU);
            if (record.data.CHUCVU.length > 0)
                cbChucvu.triggers[0].show();
            else
                cbChucvu.triggers[0].hide();

            Ext.get('txtEmail').setValue(record.data.EMAIL);

            Ext.get('txtDiachi').setValue(record.data.DIACHI);
            Ext.get('txtMobile').setValue(record.data.MOBILE);
            Ext.get('txtOfficePhone').setValue(record.data.OFFICEPHONE);
            Ext.get('txtYahoo').setValue(record.data.NICKYAHOO);
            Ext.get('txtSkype').setValue(record.data.NICKSKYPE);

            cbTrangthai.setValue(record.data.TRANGTHAI);
            cbAdmin.setValue(record.data.ADMIN);

            Ext.get('EditRowIndex').setValue(index);
            btnOK.setText('Sửa');
            UserWindow.show();
        }
    }

    function onBtnOKClick() {
        var _txtPassword = Ext.get('txtPassword').getValue();
        if (_txtPassword.length != 0) {
            Ext.Ajax.request({
                url: "/Account/EncryptPassword",
                method: "POST",
                params: {
                    txtPassword: _txtPassword
                },
                jsonData: {
                    txtPassword: _txtPassword
                },
                success: function (result) {
                    _txtPassword = result.responseText;
                    Ext.get('EncryptedPassword').setValue(_txtPassword);
                    insertNewRow();
                },
                failure: function (result) {
                    _txtPassword = '';
                }
            });
        } else {
            insertNewRow();
        }
    }

    function insertNewRow() {
        var rowIndex = Ext.get('EditRowIndex').getValue();
        var _EncryptedPassword = Ext.get('EncryptedPassword').getValue();
        var _txtHoten = Ext.get('txtHoten').getValue();
        var _txtTenDangnhap = Ext.get('txtTenDangnhap').getValue();
        var _txtPassword = Ext.get('txtPassword').getValue();
        var _txtPasswordRetype = Ext.get('txtPasswordRetype').getValue();
        
        var _cbPhong = cbPhong.getValue();
        var _cbChucvu = cbChucvu.getValue();
        var _txtEmail = Ext.get('txtEmail').getValue();

        var _txtDiachi = Ext.get('txtDiachi').getValue();
        var _txtMobile = Ext.get('txtMobile').getValue();
        var _txtOfficePhone = Ext.get('txtOfficePhone').getValue();
        var _txtYahoo = Ext.get('txtYahoo').getValue();
        var _txtSkype = Ext.get('txtSkype').getValue();

        var _Trangthai = cbTrangthai.getValue();
        var _Admin = cbAdmin.getValue();

        var _cbChucvuText = Ext.get('cbChucvu').getValue();
        var _cbPhongText = Ext.get('cbPhong').getValue();


        if (rowIndex == -1) {
            var store = GridPanel1.getStore();
            store.insertRecord(0, { TEN: _txtHoten
            , USERNAME: _txtTenDangnhap
            , PASSWORD: _EncryptedPassword
            , TRANGTHAI: _Trangthai
            , NICKSKYPE: _txtSkype
            , NICKYAHOO: _txtYahoo
            , EMAIL: _txtEmail
            , MOBILE: _txtMobile
            , DIACHI: _txtDiachi
            , CHUCVU: _cbChucvu
            , OFFICEPHONE: _txtOfficePhone
            , ADMIN: _Admin
            , MAPHONG: _cbPhong
            , TENPHONG: _cbPhongText
            , TENCHUCVU: _cbChucvuText
            });
        } else {
            var grid = GridPanel1,
                record = grid.getSelectionModel().getSelected();

            record.set("TEN", _txtHoten);
            record.set("USERNAME", _txtTenDangnhap);
            
            if (_txtPassword.length != 0)
                record.set("PASSWORD", _EncryptedPassword);

            record.set("TRANGTHAI", _Trangthai);
            record.set("NICKSKYPE", _txtSkype);
            record.set("NICKYAHOO", _txtYahoo);
            record.set("EMAIL", _txtEmail);
            record.set("MOBILE", _txtMobile);
            record.set("DIACHI", _txtDiachi);
            record.set("CHUCVU", _cbChucvu);
            record.set("OFFICEPHONE", _txtOfficePhone);
            record.set("ADMIN", _Admin);
            record.set("MAPHONG", _cbPhong);
            record.set("TENPHONG", _cbPhongText);
            record.set("TENCHUCVU", _cbChucvuText);
        }
    }

    function onCommitDone() {
        Ext.net.Notification.show({
            pinEvent: 'none',
            html: 'Lưu vào cơ sở dữ liệu thành công!',
            title: ''
        });
    }

    var PasswordValidator = function (v) {
        var _txtPassword = Ext.get('txtPassword').getValue();
        var rowIndex = Ext.get('EditRowIndex').getValue();

        if (rowIndex == -1 && _txtPassword.length == 0)
            return false;
        return true;
    }

    var PasswordRetypeValidator = function (v) {
        var _txtPassword = Ext.get('txtPassword').getValue();
        var _txtPasswordRetype = Ext.get('txtPasswordRetype').getValue();

        if (_txtPassword != _txtPasswordRetype)
            return false;
        return true;
    }

    var PhongValidator = function (v) {
//        var _MaPhong = cbPhong.getValue();
//        if (_MaPhong == null)
//            return false;
//        if (_MaPhong.length == 0)
//            return false;

        return true;
    }

</script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server"/>

    <ext:Store ID="StoreDmChucvu" 
    runat="server" 
    AutoLoad="true"
    WarningOnDirty="false">
        <Proxy>
            <ext:HttpProxy Json="true" Method="POST" Url="~/Admin/ChucvuList/" />
        </Proxy>
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MACHUCVU" />
                    <ext:RecordField Name="TENCHUCVU" />
                </Fields>
            </ext:JsonReader>
        </Reader>
 
    </ext:Store>

    <ext:Store ID="Store1" 
    runat="server" 
    DirtyWarningText="Chưa lưu dữ liệu đã sửa. Bỏ qua?"
    DirtyWarningTitle="Lưu dữ liệu"
    WarningOnDirty="true"
    >
        <Proxy>
            <ext:HttpProxy 
            Json="true" 
            Method="POST" 
            Url="~/Admin/NhanvienList/" />
        </Proxy>
        <AutoLoadParams>
            <ext:Parameter Name="start" Value="0" Mode="Raw" />
            <ext:Parameter Name="limit" Value="10" Mode="Raw" />
        </AutoLoadParams>
        <BaseParams>
            <ext:Parameter Name="state" Value="#{ComboBox1}.getValue()" Mode="Raw" />
            <ext:Parameter Name="phong" Value="#{ComboBox2}.getValue()" Mode="Raw" />
        </BaseParams>
        
        <Reader>
            <ext:JsonReader Root="data">
                <Fields>
                    <ext:RecordField Name="MANV" />
                    <ext:RecordField Name="TEN" />
                    <ext:RecordField Name="USERNAME" />
                    <ext:RecordField Name="PASSWORD" />
                    <ext:RecordField Name="TRANGTHAI" />
                    <ext:RecordField Name="NICKSKYPE" />
                    <ext:RecordField Name="NICKYAHOO" />
                    <ext:RecordField Name="EMAIL" />
                    <ext:RecordField Name="MOBILE" />
                    <ext:RecordField Name="DIACHI" />
                    <ext:RecordField Name="CHUCVU" />
                    <ext:RecordField Name="OFFICEPHONE" />
                    <ext:RecordField Name="ADMIN" />
                    <ext:RecordField Name="MAPHONG" />
                    <ext:RecordField Name="TENPHONG"/>
                    <ext:RecordField Name="TENCHUCVU"/>
                </Fields>
            </ext:JsonReader>
        </Reader>
        <UpdateProxy>
            <ext:HttpWriteProxy Url="~/Admin/NhanvienList_Save/" />
        </UpdateProxy>
        <Listeners>
            <LoadException Handler="var e = e || {message: response.responseText}; alert('Load failed: ' + e.message);" />
            <CommitDone Handler="onCommitDone();" />
        </Listeners>
    </ext:Store>

    <ext:Store ID="StoreDmPhong" 
    runat="server" 
    WarningOnDirty="false">
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
 
    </ext:Store>

    <ext:Window 
        ID="UserWindow"
        Hidden="true"
        runat="server" 
        Closable="true"
        Resizable="false"
        Height="290" 
        Title="Người sử dụng"
        Draggable="true"
        Width="400"
        Modal="true"
        Layout="FitLayout"
        BodyBorder="false"
        Padding="5">
        <Items>

        <ext:FormPanel runat="server" 
        MonitorValid="true"
        Layout="FitLayout">
            <Items>
                <ext:TabPanel ID="TabPanel1" runat="server" 
            DeferredRender="false"
            LayoutOnTabChange="true"
            Border="false">
            <Items> 
                <ext:Panel ID="Panel1" runat="server" Title="Thông tin chính" Padding="5" BodyStyle="background-color:#CED9E7;">
                    <Items>
                        <ext:TextField 
                            ID="txtHoten" 
                            runat="server" 
                            FieldLabel="Họ và tên" 
                            AllowBlank="false"
                            MinLength="1"
                            MaxLength="50"
                            CausesValidation="true"
                            BlankText="Hãy nhập họ tên nhân viên"
                            Width="340"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                        <ext:TextField 
                            ID="txtTenDangnhap" 
                            runat="server" 
                            FieldLabel="Tên đăng nhập" 
                            AllowBlank="false" 
                            AnchorHorizontal="100%"
                            MaxLength="50"
                            Width="340"
                            BlankText="Tên user khi đăng nhập hệ thống."
                            IsRemoteValidation="true"
                            Text="" >
                            <RemoteValidation OnValidation="CheckTenDangnhap" /> 
                        </ext:TextField>

                        <ext:TextField 
                            ID="txtPassword" 
                            runat="server" 
                            FieldLabel="Mật khẩu" 
                            AllowBlank="true" 
                            InputType="Password" 
                            MaxLength="50"
                            Width="340"
                            Validator="PasswordValidator"
                            InvalidText="Mật khẩu không được phép rỗng"
                            IsRemoteValidation="true"
                            EnableKeyEvents="true"
                            AnchorHorizontal="100%">
                            <RemoteValidation OnValidation="CheckPassword" /> 
                        </ext:TextField>

                        <ext:TextField 
                            ID="txtPasswordRetype" 
                            runat="server" 
                            FieldLabel="Gõ lại khẩu" 
                            InputType="Password" 
                            Width="340"
                            MaxLength="50"
                            Validator="PasswordRetypeValidator"
                            InvalidText="Mật khẩu gõ lại không đúng"
                            AnchorHorizontal="100%"
                            >
                            <RemoteValidation OnValidation="CheckPasswordRetype" /> 
                        </ext:TextField>

                        <ext:ComboBox ID="cbPhong"
                            StoreID="StoreDmPhong"
                            DisplayField="TENPHONG"
                            ValueField="MAPHONG"
                            FieldLabel="Phòng"
                            Width="340"
                            Validator="PhongValidator"
                            EmptyText=""
                            runat="server" 
                            Editable="false"
                            >
                            <Listeners>
                                <Select Handler="this.triggers[0].show(); " />
                                <TriggerClick Handler="this.clearValue(); this.triggers[0].hide(); " />
                            </Listeners>
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                            </Triggers>
                        </ext:ComboBox>

                        <ext:ComboBox ID="cbChucvu"
                            StoreID="StoreDmChucvu"
                            DisplayField="TENCHUCVU"
                            ValueField="MACHUCVU"
                            runat="server" 
                            FieldLabel="Chức vụ"
                            EmptyText="Hãy chọn chức vụ"
                            Editable="false"
                            Width="340">
                            <Listeners>
                                <Select Handler="this.triggers[0].show(); " />
                                <TriggerClick Handler="this.clearValue(); this.triggers[0].hide(); " />
                            </Listeners>
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                            </Triggers>
                        </ext:ComboBox>

                        <ext:TextField 
                            ID="txtEmail" 
                            runat="server" 
                            FieldLabel="Email" 
                            AllowBlank="false"
                            Width="340"
                            MaxLength="50"
                            IsRemoteValidation="true"
                            AnchorHorizontal="100%">
                            <RemoteValidation OnValidation="CheckEmail" /> 
                         </ext:TextField>
                         
                         <ext:NumberField 
                            ID="EditRowIndex" 
                            runat="server" 
                            AllowBlank="false"
                            FieldLabel="EditRowIndex" 
                            Hidden="true"
                            />
                        <ext:TextField 
                            ID="EncryptedPassword" 
                            runat="server" 
                            Hidden="true"
                            AnchorHorizontal="100%"
                            />
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Title="Thông tin mở rộng" Padding="5" BodyStyle="background-color:#CED9E7;">
                    <Items>
                        <ext:TextField 
                            ID="txtDiachi" 
                            runat="server" 
                            FieldLabel="Địa chỉ" 
                            AllowBlank="true"
                            MaxLength="200"
                            BlankText="Hãy nhập địa chỉ"
                            Width="350"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                         <ext:TextField 
                            ID="txtMobile" 
                            runat="server" 
                            FieldLabel="Mobile" 
                            AllowBlank="true"
                            MaxLength="20"
                            BlankText="Hãy nhập số điện thoại"
                            Width="350"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                         <ext:TextField 
                            ID="txtOfficePhone" 
                            runat="server" 
                            FieldLabel="Điện thoại CQ" 
                            AllowBlank="true"
                            MaxLength="20"
                            BlankText="Hãy nhập số điện thoại CQ"
                            Width="350"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                         <ext:TextField 
                            ID="txtYahoo" 
                            runat="server" 
                            FieldLabel="Yahoo" 
                            AllowBlank="true"
                            Width="350"
                            MaxLength="50"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                         <ext:TextField 
                            ID="txtSkype" 
                            runat="server" 
                            FieldLabel="Skype" 
                            AllowBlank="true"
                            Width="350"
                            MaxLength="50"
                            AnchorHorizontal="100%">
                         </ext:TextField>

                         <ext:Checkbox ID="cbTrangthai" runat="server" FieldLabel="Đang hoạt động">
                        </ext:Checkbox>

                        <ext:Checkbox ID="cbAdmin" runat="server" FieldLabel="Quyền quản trị" >
                        </ext:Checkbox>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:TabPanel>
            </Items>
            <Listeners>
                <ClientValidation Handler="#{btnOK}.setDisabled(!valid);" />
            </Listeners>
        </ext:FormPanel>

        </Items>
        
        <Buttons>
            <ext:Button ID="btnOK" runat="server" Text="Thêm" Icon="Accept">
                <Listeners>
                    <Click Handler="#{UserWindow}.hide(); onBtnOKClick();" />
                </Listeners>
            </ext:Button>
        </Buttons>
        
    </ext:Window>




<ext:ViewPort ID="ViewPort1" runat="server" Layout="FitLayout">
    <Items>    
    <ext:GridPanel ID="GridPanel1" 
            runat="server"
            StoreID="Store1"
            AutoExpandColumn="TEN" 
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
                        <ext:ToolbarSeparator>
                            
                        </ext:ToolbarSeparator>
                        <ext:ComboBox ID="ComboBox1"
                            runat="server" 
                            Editable="false"
                            Width="150">
                            <Items>
                                <ext:ListItem Text="Đã nghỉ" Value="0" />
                                <ext:ListItem Text="Đang làm việc" Value="1" />
                                <ext:ListItem Text="Tất cả" Value="2" />
                            </Items>
                            <SelectedItem Value="2" />
                            <Listeners>
                                <Select Handler="setFilter();" />
                            </Listeners>
                        </ext:ComboBox>

                        <ext:ToolbarSeparator>
                            
                        </ext:ToolbarSeparator>
                        <ext:ComboBox ID="ComboBox2"
                            StoreID="StoreDmPhong"
                            DisplayField="TENPHONG"
                            ValueField="MAPHONG"
                            runat="server" 
                            Editable="false"
                            Width="200">
                            <Listeners>
                                <Select Handler="this.triggers[0].show(); setFilter();" />
                                <TriggerClick Handler="this.clearValue(); this.triggers[0].hide(); setFilter();" />
                            </Listeners>
                            <Triggers>
                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                            </Triggers>
                        </ext:ComboBox>
                        
            </Items>
            </ext:Toolbar>
            </TopBar>                

            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:RowNumbererColumn />
                    <ext:Column ColumnID="TEN" Header="Tên nhân viên" DataIndex="TEN" Sortable="true" />
                    <ext:Column ColumnID="USERNAME" Header="Tên đăng nhập" DataIndex="USERNAME" Sortable="true" Width="140" />
                    <ext:Column ColumnID="EMAIL" Header="Địa chỉ email" DataIndex="EMAIL" Sortable="true" Width="140" />
                    <ext:Column ColumnID="TENCHUCVU" Header="Chức vụ" DataIndex="TENCHUCVU" Sortable="true" Width="110" >
                    </ext:Column>
                    <ext:Column ColumnID="TENPHONG" Header="Phòng" DataIndex="TENPHONG" Sortable="true"  Width="150"/>
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
                <RowDblClick Handler="onEdit(); Ext.net.DirectMethods.onEdit2();" />
            </Listeners>
            <Plugins>
                    <ext:GridFilters runat="server" ID="GridFilters1" Local="true">
                        <Filters>
                            <ext:NumericFilter DataIndex="TRANGTHAI" Active="false"/>
                        </Filters>
                    </ext:GridFilters>
            </Plugins>
            <BottomBar>
                <ext:PagingToolbar 
                ID="Pager1" 
                runat="server" 
                PageSize="10" 
                StoreID="Store1" 
                DisplayInfo="True" 
                BeforePageText="Trang" 
                DisplayMsg="Từ {0} đến {1} trong tổng số {2}" 
                EmptyMsg="Không có nhân viên nào!" 
                FirstText="Trang đầu" 
                LastText="Trang cuối" 
                NextText="Trang tiếp" 
                PrevText="Trang trước" 
                RefreshText="Tải lại" AfterPageText="trong tổng số {0}" >
                </ext:PagingToolbar>
            </BottomBar>
    </ext:GridPanel>
</Items>
    
</ext:ViewPort>
    
    <ext:KeyMap ID="KeyMap1" runat="server" Target="={#{UserWindow}.getBody()}" 
         >
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
