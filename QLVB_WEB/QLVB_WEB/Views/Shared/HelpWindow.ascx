<%@ Control Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:Window 
    ID="winAbout" 
    runat="server" 
    Title="Thông tin" 
    Icon="Information" 
    Modal="true"
    Height="225" 
    Width="350"
    Layout="fit"
    Hidden="true">
    <Items>
        <ext:TabPanel runat="server" Border="false">
            <Items>
                <ext:Panel runat="server" Title="Thông tin" Padding="5" BodyStyle="background-color:#fff;">
                    <Content>
                        HỆ THỐNG QUẢN LÝ CÔNG VĂN (1.0 RC)<br /><br />
                        Copyright(C) <a href="http://softend.vn/" target="_blank">SOFTEND JSC </a>2011<br /><br />
                    </Content>
                </ext:Panel>
                <ext:Panel runat="server" Title="Credits" Padding="5" BodyStyle="background-color:#fff;">
                    <Content>
                        Many icons provided by <a href="http://www.famfamfam.com/lab/icons/silk/" target="_blank">FamFamFam</a> under <a href="http://creativecommons.org/licenses/by/2.5/" target="_blank">Creative Commons Attribution 2.5 License</a>.
                    </Content>
                </ext:Panel>
                <ext:Panel 
                    runat="server" 
                    Title="Bản quyền" 
                    Padding="5"
                    BodyStyle="background-color:#fff;">
                    <Content>
                        Source code for the Ext.Net.MVC.Demo project is release by Ext.NET, Inc. under an MIT open source license, see <a href="/License/License.txt" target="_blank">license</a>.
                        <br />
                        <br />
                        Download project source code from GoogleCode, see <a href="http://extnet-mvc.googlecode.com/" target="_blank">http://extnet-mvc.googlecode.com/</a>
                        <br />
                        <br />
                        Licensing information and download of Ext.NET is available at <a href="http://www.ext.net/download/" target="_blank">http://www.ext.net/download/</a>.
                    </Content>
                </ext:Panel>
            </Items>
        </ext:TabPanel>
    </Items>
    <BottomBar>
        <ext:Toolbar runat="server">
            <Items>
                <ext:ToolbarFill runat="server" />
                <ext:ToolbarTextItem runat="server" Text="Copyright 2011 SOFTEND jsc.<br />" />
                <ext:ToolbarSpacer runat="server" />
            </Items>
        </ext:Toolbar>
    </BottomBar>
</ext:Window>