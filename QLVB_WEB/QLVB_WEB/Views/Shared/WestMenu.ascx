<%@ Control Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:AccordionLayout runat="server" Animate="true">
    <Items>
        <ext:MenuPanel 
            ID="acReports" 
            runat="server" 
            Border="false" 
            SaveSelection="false"
            Cls="white-menu" 
            Collapsed="true" 
            Title="Văn bản đến">
            <Menu runat="server">
                <Items>
                    <ext:MenuItem 
                        ID="mnTiepnhanXuly" 
                        runat="server" 
                        Text="Tiếp nhận và xử lý"
                        Icon="Report">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/VBDen/TiepnhanXuly/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>
                    <ext:MenuItem 
                        runat="server" 
                        Text="Tra cứu" 
                        Icon="ChartBar">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/VBDen/Tracuu/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>
                </Items>
                <Listeners>
                    <ItemClick Handler="QLVB.addTab({ title: menuItem.text, url: menuItem.url, icon: menuItem.iconCls, passParentSize: menuItem.passParentSize});" />
                </Listeners>
            </Menu>
        </ext:MenuPanel>
        <ext:MenuPanel 
            ID="acCustomers" 
            runat="server" 
            Collapsed="true" 
            Title="Customers & Orders"
            Border="false" 
            SaveSelection="false" 
            Cls="white-menu">
            <Menu runat="server">
                <Items>
                    <ext:MenuItem runat="server" Text="Customer Details" Icon="ApplicationForm">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Customer/CustomerDetails/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>
                    <ext:MenuItem ID="mnCustomerList" runat="server" Text="Customer List" Icon="ApplicationForm">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Customer/CustomerList/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>                   
                    <ext:MenuItem ID="mnOrderList" runat="server" Text="Order List" Icon="ApplicationForm">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Order/OrderList/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>
                </Items>
                <Listeners>
                    <ItemClick Handler="QLVB.addTab({ title: menuItem.text, url: menuItem.url, icon: menuItem.iconCls });" />
                </Listeners>
            </Menu>
        </ext:MenuPanel>
        <ext:MenuPanel 
            ID="acExamples" 
            runat="server" 
            Collapsed="true" 
            Title="Examples"
            Border="false" 
            SaveSelection="false" 
            Cls="white-menu">
            <Menu runat="server">
                <Items>
                    <ext:MenuItem ID="mnRest" runat="server" Text="REST Demo" Icon="Application">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/RestDemo/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>
                    <ext:MenuItem ID="mnPartial" runat="server" Text="Partial Views" Icon="Application">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Partial/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>                                           
                </Items>
                <Listeners>
                    <ItemClick Handler="QLVB.addTab({ title : menuItem.text, url : menuItem.url, icon : menuItem.iconCls });" />
                </Listeners>
            </Menu>
        </ext:MenuPanel>
        <ext:MenuPanel 
            ID="acAdmin" 
            runat="server" 
            Collapsed="true" 
            Title="Quản trị hệ thống"
            Border="false" 
            Hidden="false"
            SaveSelection="false" 
            Cls="white-menu">
            <Menu ID="MenuAdmin" runat="server">
                <Items>
                    <ext:MenuItem ID="MenuItem1" runat="server" Text="Danh mục chức vụ" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Chucvu/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem2" runat="server" Text="Danh mục cơ quan" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Coquan/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem3" runat="server" Text="Danh mục phòng ban" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Phongban/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem4" runat="server" Text="Danh mục nhân viên" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Nhanvien/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem8" runat="server" Text="Danh mục loại văn bản" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/LoaiVanban/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem9" runat="server" Text="Danh mục sổ văn bản" Icon="Book">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/SoVanban/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem5" runat="server" Text="Tham số hệ thống" Icon="Application">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Thamso/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem6" runat="server" Text="Quy trình văn bản đi" Icon="Application">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Quytrinhdi/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                    <ext:MenuItem ID="MenuItem7" runat="server" Text="Quy trình văn bản đến" Icon="Application">
                        <CustomConfig>
                            <ext:ConfigItem Name="url" Value="/Admin/Quytrinhden/" Mode="Value" />
                        </CustomConfig>
                    </ext:MenuItem>

                </Items>
                <Listeners>
                    <ItemClick Handler="QLVB.addTab({ title : menuItem.text, url : menuItem.url, icon : menuItem.iconCls });" />
                </Listeners>
            </Menu>
        </ext:MenuPanel>
    </Items>
</ext:AccordionLayout>
