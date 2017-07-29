<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="webcam.aspx.cs" Inherits="WebApplication1.webcam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="shortcut icon" href="">
</head>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src='<%=ResolveUrl("~/Webcam_Plugin/jquery.webcam.js") %>' type="text/javascript"></script>
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("~/webcam.aspx") %>';
        $(function () {
            jQuery("#webcam").webcam({
                width: 320,
                height: 240,
                mode: "save",
                swffile: '<%=ResolveUrl("~/Webcam_Plugin/jscam.swf") %>',
            debug: function (type, status) {
                $('#camStatus').append(type + ": " + status + " " + Date().toString() + '<br /><br />');
            },
            onSave: function (data) {
                $.ajax({
                    type: "POST",
                    url: pageUrl + "/GetCapturedImage",
                    data: '',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        $("[id*=imgCapture]").css("visibility", "visible");
                        //$("#webcam").css("visibility", "hidden");
                        $("[id*=imgCapture]").attr("src", r.d);
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            },
            onCapture: function () {
                webcam.save(pageUrl);
            }
            });
        });
        function Capture() {
            webcam.capture();
            return false;
        }
</script>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center">
                        <b>Live Camera</b>
                    </td>
                    <td>
                    </td>
                    <td align="center">
                        <b>Captured Picture</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="webcam">
                        </div>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <table border="0">
                            <tr>
                                <td>
                                    <asp:Image ID="imgCapture" runat="server" Style="visibility: hidden; width: 320px; height: 240px" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
            </table>
            </div>
            <asp:Button ID="btnLogIn" Text="Log In" runat="server" OnClientClick="return Capture();" />
            <div>
                <span id="camStatus"></span>
            </div>
    </form>
</body>
</html>
