<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="QLVB_WEB" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Quy trinh di</title>
	<link rel="stylesheet" href="/resources/css/dynamicAnchorsDemo.css" />
    <script type="text/javascript" src="/resources/js/ga.js"></script>
    <script type="text/javascript" src="/resources/js/jquery.js"></script>
	<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>
	<script type="text/javascript" src="/resources/js/jquery_002.js"></script>

    <script type="text/javascript">

        function movePosition(id, left, top) {
            var obj = document.getElementById(id);
            obj.style.position = 'absolute';
            obj.style.top = top + "px";
            obj.style.left = left + "px";
        }

        function getPosition(e) {
            var left = 0;
            var top = 0;

            while (e.offsetParent) {
                left += e.offsetLeft;
                top += e.offsetTop;
                e = e.offsetParent;
            }

            left += e.offsetLeft;
            top += e.offsetTop;

            return left + "," + top;
        }

        function Trim(sInString) {
            sInString = sInString.replace(/^\s+/g, ""); // strip leading
            return sInString.replace(/\s+$/g, ""); // strip trailing
        }

        function btnSave_Click() {
            var s = "Position: ";

            var divs = document.getElementsByTagName("DIV");
            for (var i = 0; i < divs.length; i++) {
                var styleClassName = Trim(divs[i].className.replace("ui-draggable", ""));
                if (styleClassName == "window" || styleClassName == "startend") {
                    s = s + divs[i].id + ":";
                    s = s + getPosition(divs[i]) + ";";

                }
            }

            s = s + "Connection: ";

            //            try {
            //                var c1 = jsPlumb.getConnections(jsPlumb.getDefaultScope());
            //                var c2 = c1[jsPlumb.getDefaultScope()];
            //                for (var i = 0; i < c2.length; i++) {
            //                    s = s + c2[i].sourceId + "-" + c2[i].targetId + ";";
            //                    
            //                }
            //            } catch (err)
            //            {
            //            }

            try {
                var c1 = jsPlumb.getConnections(jsPlumb.getDefaultScope());
                var c2 = c1[jsPlumb.getDefaultScope()];
                for (var i = 0; i < c2.length; i++) {
                    s = s + c2[i].sourceEndpoint.getUuid() + "-" + c2[i].targetEndpoint.getUuid() + ";";

                }
            } catch (err) {
            }

            document.forms["form1"].txtConfig.value = s;
            document.forms["form1"].submit();
        }

    </script>
</head>

<body onunload="jsPlumb.unload();" >
        <div id="start" class="startend" style="cursor: pointer"> <table width="100%" height="100%" cellpadding="0" cellspacing="0"><tr><td valign="center">
            Bắt đầu</td></tr></table></div>

        <div id="end" class="startend" style="cursor: pointer"> <table width="100%" height="100%" cellpadding="0" cellspacing="0"><tr>
            <td valign="center" >
            Kết thúc</td></tr></table></div>

        <% foreach (var m in ViewData.Model) { %>
            <div id="<%= m.MACHUCVU %>" class="window" style="cursor: pointer"> <table width="100%" height="100%" cellpadding="0" cellspacing="0"><tr><td valign="center">
            <%= m.TENCHUCVU %>
            </td></tr></table></div>
        <% } %>

   
		<script type="text/javascript">
            

		    jsPlumb.bind("ready", function () {
		        // chrome fix.
		        document.onselectstart = function () { return false; };

		        jsPlumb.DefaultDragOptions = { cursor: 'pointer', zIndex: 2000 };
		        jsPlumb.setMouseEventsEnabled(true);


		        // helper method to set mouse handlers and the labelText member on connections.
		        var init = function (conn) {
		            conn.bind("click", function (conn) {
                        var source = conn.sourceEndpoint;
		                if (confirm("Xóa kết nối này?" ))
		                    jsPlumb.detach(conn);
		            });
		        };

		        // listen for new connections; initialise them the same way we initialise the connections at startup.
		        jsPlumb.bind("jsPlumbConnection", function (connInfo) {
		            init(connInfo.connection);
		        });

		        var exampleColor = '#00f';
		        var endpointColor = '#eeeeee';
		        var exampleDropOptions = {
		            tolerance: 'touch',
		            hoverClass: 'dropHover',
		            activeClass: 'dragActive'
		        };
                var LineWidth = 3;

                var connectionStyle = {
		                gradient: { stops: [[0, exampleColor], [0.5, '#09098e'], [1, exampleColor]] },
		                lineWidth: LineWidth,
		                strokeStyle: "#00f"
		            };

		        var EndpointBoth = {
		            endpoint: "Rectangle",
		            style: { width: 15, height: 15, fillStyle: endpointColor },
		            isSource: true,
		            connectorStyle: connectionStyle,
		            isTarget: true,
		            connectorOverlays: [["Arrow", { location: 0.8}]],
		            maxConnections: 20,
		            dropOptions: exampleDropOptions
		        };

		        var EndpointStart = {
		            endpoint: "Rectangle",
		            style: { width: 15, height: 15, fillStyle: endpointColor },
		            isSource: true,
		            connectorStyle: connectionStyle,
		            isTarget: false,
		            connectorOverlays: [["Arrow", { location: 0.8}]],
		            maxConnections: 20,
		            dropOptions: exampleDropOptions
		        };

		        var EndpointEnd = {
		            endpoint: "Rectangle",
		            style: { width: 15, height: 15, fillStyle: endpointColor },
		            isSource: false,
		            connectorStyle: connectionStyle,
		            isTarget: true,
		            connectorOverlays: [["Arrow", { location: 0.8}]],
		            maxConnections: 20,
		            dropOptions: exampleDropOptions
		        };

		        var anchors1 = [[0.5, 0, 0, -1]];
		        var anchors2 = [[1, 0.5, 1, 0]];
		        var anchors3 = [[0.5, 1, 0, 1]];
		        var anchors4 = [[0, 0.5, -1, 0]];

                var anchors = [[0.5, 0, 0, -1], [1, 0.5, 1, 0], [0.5, 1, 0, 1], [0, 0.5, -1, 0]];
			    var aConnection = {	
				    endpoint:[ "Rectangle", {width:15, height:15} ],				
				    endpointStyle:{ width:15, height:15, fillStyle:exampleColor },
				    paintStyle : {
					    gradient:{stops:[[0, exampleColor], [0.5, '#09098e'], [1, exampleColor]]},
					    lineWidth:LineWidth,
					    strokeStyle:"#00f"
				    },
				    dynamicAnchors:anchors,
                    overlays: [["Arrow", { location: 0.8}]]
			    };

                <% foreach (var m in ViewData.Model) { %>
                    jsPlumb.draggable("<%= m.MACHUCVU %>");
                    jsPlumb.addEndpoint('<%= m.MACHUCVU %>', { anchor: [[0.5, 0, 0, -1]], uuid:"<%= m.MACHUCVU %>_01" }, EndpointBoth);
		            jsPlumb.addEndpoint('<%= m.MACHUCVU %>', { anchor: [[1, 0.5, 1, 0]], uuid:"<%= m.MACHUCVU %>_02"  }, EndpointBoth);
		            jsPlumb.addEndpoint('<%= m.MACHUCVU %>', { anchor: [[0.5, 1, 0, 1]], uuid:"<%= m.MACHUCVU %>_03"  }, EndpointBoth);
		            jsPlumb.addEndpoint('<%= m.MACHUCVU %>', { anchor: [[0, 0.5, -1, 0]], uuid:"<%= m.MACHUCVU %>_04"  }, EndpointBoth);
                <% } %>

                jsPlumb.draggable("start");
                jsPlumb.addEndpoint('start', { anchor: [[0.5, 1, 0, 1]], uuid: "start_01" }, EndpointStart);
                jsPlumb.addEndpoint('start', { anchor: [[1, 0.5, 1, 0]], uuid: "start_02" }, EndpointStart);
                jsPlumb.addEndpoint('start', { anchor: [[0, 0.5, -1, 0]], uuid: "start_03" }, EndpointStart);

                jsPlumb.draggable("end");
                jsPlumb.addEndpoint('end', { anchor: [[0.5, 0, 0, -1]], uuid: "end_01" }, EndpointEnd);
                jsPlumb.addEndpoint('end', { anchor: [[1, 0.5, 1, 0]], uuid: "end_02" }, EndpointEnd);
                jsPlumb.addEndpoint('end', { anchor: [[0, 0.5, -1, 0]], uuid: "end_03" }, EndpointEnd);

                <% foreach (var m in ViewData["Position"] as List<QUYTRINH_POSITION>)
                { %> 
                    movePosition('<%= m.sID %>',<%= m.OffsetLeft %>,<%= m.OffsetTop %>); 
                <% } %>

                <% foreach (var m in ViewData["Connection"] as List<QUYTRINH_CONNECTION>)
                { %> 
                    var conn = jsPlumb.connect({uuids:["<%= m.SourceID %>", "<%= m.TargetID %>"], overlays: [["Arrow", { location: 0.8}]] });
                    init(conn);
                <% } %>



                jsPlumb.repaintEverything();
		    });
		</script>
        
         <form id="form1" runat="server" method="post" action="/Admin/Quytrinhden_Save/" >
            <input type="button" name="btnSave" onclick="btnSave_Click()" style="width: 86px; font-family: Arial;" value="Lưu lại" />
            <input type="hidden" name="txtConfig" value="" />
         </form>


        </body>
</html>

