<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="System.Collections.Generic" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    
    <style type="text/css">
        div.item-wrap {
	        float  : left;
	        border : 1px solid transparent;
	        margin : 5px 25px 5px 25px;
	        width  : 100px;
	        cursor : pointer;
	        height : 120px;
	        text-align : center;
        }

        div.item-wrap img {
	        margin : 5px 0px 0px 5px;
	        width  : 61px;
	        height : 77px;
        }

        div.item-wrap h6 {
	        font-size : 14px;
	        color : #3A4B5B;
	        font-family : tahoma,arial,san-serif;
        }
        
        .items-view .x-view-over { 
            border : solid 1px silver; 
        }

        #items-ct { 
            padding : 20px 30px 24px 30px; 
        }

        #items-ct h2 {
            border-bottom : 2px solid #3A4B5B;           
            cursor : pointer;      
        }

        #items-ct h2 div {
            background  : transparent url(/resources/images/group-expand-sprite.gif) no-repeat 3px -47px;
            padding     : 4px 4px 4px 17px;
            font-family : tahoma,arial,san-serif;
            font-size   : 12px;
            color       : #3A4B5B;
        }

        #items-ct .collapsed h2 div { background-position: 3px 3px; }
        #items-ct dl { margin-left: 2px; }
        #items-ct .collapsed dl { display:none; }

    </style>
    
    <script type="text/javascript">

        var selectionChanged = function(dv, nodes) {
            if (nodes.length > 0) {
                var panel = nodes[0].getAttribute('ext:panel');
                var menu = nodes[0].getAttribute('ext:menu');

                if (!Ext.isEmpty(panel, false)) {
                    parent.window[panel].expand(false);
                }

                if (!Ext.isEmpty(menu, false)) {
                    (function(){
                        parent.window[menu].parentMenu.fireEvent("itemclick", parent.window[menu]);
                    }).defer(250);                    
                }
            }
        };
        
        var viewClick = function(dv, e) {
            var group = e.getTarget('h2', 3, true);
            if (group) {
                group.up('div').toggleClass('collapsed');
            }
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server"/>
    <font style="font-family: 'Times New Roman', Times, serif; font-size: x-large; font-weight: bold; color: #15428B;">Dashboard mesage.</font>
</body>
</html>