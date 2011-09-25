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
        
        .x-panel-body {
          border-color: #0fa7e0;
          background-color: #ffffff;
          border-bottom-width:thick;
          border-top-width:thick;
          border-left-width:thick;
          border-right-width:thin;
        }
        
        .x-menu
        {
            background-color:#ffffff;
        }
        
        .my-menu span 
        {
            font-size:small;
        }
            
        .x-menu-item-active 
        {
            background-color: #0fa7e0;
            background-image: none;
        }
        
    </style>

    <script type="text/javascript">
        var menuItemClick = function (item) {
            //pnlCenter.body.update(String.format("Clicked: {0}", item.text)).highlight();
            pnlCenter.body.update(String.format("Clicked: {0}", item.text));
        };
    </script>
    
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Default"/>
    
</body>
</html>
