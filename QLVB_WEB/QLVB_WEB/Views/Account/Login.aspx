<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hệ thống quản lý công văn</title>    
    <style type="text/css">
        h1 {
            font: normal 60px tahoma, arial, verdana;
            color: #E1E1E1;
        }
        
        h2 {
            font: normal 20px tahoma, arial, verdana;
            color: #E1E1E1;
        }
        
        h2 a {
            text-decoration: none;
            color: #E1E1E1;
        }
        
        .x-window-mc {
            background-color : #CED9E7 !important;
        }
    </style>
    <script type="text/javascript">
        if (window.top.frames.length !== 0) {
            window.top.location = self.document.location;
        }
    </script>
    <link rel="shortcut icon" href="/resources/images/documents.ico" />
</head>
<body>
    <ext:ResourceManager runat="server" StateProvider="Cookie">
        <Listeners>
		    <DocumentReady Handler="#{txtUsername}.setValue(Ext.util.Cookies.get('LastUserID'));" />
	    </Listeners>
    </ext:ResourceManager>

    <br />
    <div>
        <h1 style="margin-left: 20px">HỆ THỐNG QUẢN LÝ CÔNG VĂN</h1>
        <h2 style="margin-left: 20px">SOFTEND JSC.</h2>
    </div>
    
    <ext:Window 
        ID="LoginWindow"
        runat="server" 
        Closable="false"
        Resizable="false"
        Height="140" 
        Icon="Lock" 
        Title="Đăng nhập"
        Draggable="true"
        Width="300"
        Modal="true"
        Layout="fit"
        BodyBorder="false"
        Padding="5">
        <Items>
                <ext:FormPanel 
                    runat="server" 
                    FormID="form1"
                    Border="false"
                    Layout="form"
                    BodyBorder="True" 
                    BodyStyle="background-color:transparent;"
                    Url='<%# Html.AttributeEncode(Url.Action("Login")) %>' ID="ctl292">
                    <Items>
                        <ext:TextField 
                            ID="txtUsername" 
                            runat="server" 
                            FieldLabel="Tên đăng nhập" 
                            AllowBlank="false"
                            BlankText="Hãy nhập tên."
                            Text='<%# this.ViewData["LastUserID"] %>' 
                            AnchorHorizontal="100%"
                            />
                        <ext:TextField 
                            ID="txtPassword" 
                            runat="server" 
                            InputType="Password" 
                            FieldLabel="Mật mã" 
                            AllowBlank="false" 
                            BlankText="Hãy nhập mật mã."
                            Text=""
                            AnchorHorizontal="100%"
                            />
                        <ext:HyperLink 
                            ID="HyperLink1" 
                            runat="server" 
                            NavigateUrl="http://www.ext.net" 
                            Text="Quên mật mã" />
                    </Items>
                    <Listeners>
                        <Render Handler="#{txtUsername}.focus();" Delay="50" />
                    </Listeners>
                </ext:FormPanel>
        </Items>
        

        <Buttons>
            <ext:Button ID="btnLogin" runat="server" Text="Đăng nhập" Icon="Accept">
                <DirectEvents>
                    <Click 
                        Url="~/Account/Login2/" 
                        Timeout="60000"
                        FormID="form1"
                        CleanRequest="true" 
                        Method="POST"
                        Before="Ext.Msg.wait('Đang kiểm tra...', 'Chứng thực');
                            "
                        Failure="Ext.Msg.show({
                           title:   'Lỗi',
                           msg:     result.errorMessage,
                           buttons: Ext.Msg.OK,
                           icon:    Ext.MessageBox.ERROR
                        });">
                        <EventMask MinDelay="250" />
                        <ExtraParams>
                            <ext:Parameter Name="ReturnUrl" Value="Ext.urlDecode(String(document.location).split('?')[1]).r || '/'" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:Button>
        </Buttons>
    </ext:Window>

    <ext:KeyMap ID="KeyMap1" runat="server" Target="={#{LoginWindow}.getBody()}" >
        <ext:KeyBinding>
            <Keys>
                <ext:Key Code="ENTER" />
            </Keys>
            <Listeners>
                <Event Handler="e.stopEvent();#{btnLogin}.fireEvent('click');" />
            </Listeners>
        </ext:KeyBinding>  
    </ext:KeyMap>

    
</body>
</html>
