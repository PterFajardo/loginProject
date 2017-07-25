<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        input {
            padding: 10px;
        }

        div.myResidents input {
            border-radius: 12px;
        }

        div.myResidents input:hover {
            border-radius: 12px;
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);

        }

        div.visitType{
            text-align: center;
            width:100%
        }
        div.visitType input {
            padding: 40px;
            border-radius: 12px;
            margin: 10px;
            width: 300px;
            font-size: xx-large;
            background: royalblue;
            color: white;
        }

        div.visitType input:hover {
            padding: 40px;
            border-radius: 12px;
            margin: 10px;
            width: 300px;
            font-size: xx-large;
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
        }

        .inactive {
            opacity: 0.4;
        }
       
        div {
            padding: 5px;
        }

    </style>
</head>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src='<%=ResolveUrl("~/Webcam_Plugin/jquery.webcam.js") %>' type="text/javascript"></script>
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("~/WebForm1.aspx") %>';
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
                        $("[id*=imgCapture]").attr("src", r.d);

                        var name = $("#txtFirstName").val().toUpperCase() + " " + $("#txtLastName").val().toUpperCase();
                        $("#labelName").text(name);
                        var visitorType = $("#visitorType input[type=radio]:checked").next().html();
                        $("#labelVisitorType").text(visitorType);
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
        function Capture(actionType) {
            $("#hiddenAction").text("Current Activity: " + actionType.toUpperCase());
            webcam.capture();
            return false;
        }
</script>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; text-align:center;"><h1>Fajardo Residence Sign-In System</h1></div>
        <div>
            <h2>Step 1: Choose Type</h2>
            <div id="visitType" class="visitType" runat="server">
                <%--<asp:Button ID="btnFamily" Text="Family" Font-Size="XX-Large" runat="server" OnClick="btnVisit_Click" />--%>
            </div>
            <%--<asp:RadioButtonList ID="visitorType" runat="server">
                <asp:ListItem Text="Family" Value="family"></asp:ListItem>
                <asp:ListItem Text="Professional Service" Value="professionalService"></asp:ListItem>
                <asp:ListItem Text="Other" Value="other"></asp:ListItem>
            </asp:RadioButtonList>--%>
        </div>
        <div>
            <h2>Step 2: Provide Info</h2>
            <div>
                First Name: <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
            </div>
            <div>
                Last Name: <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
            </div>
        </div>
        <div>
            <h2>Step 3: Identify who will be visited and or reason for visit</h2>
            <div id="divResidents" class="myResidents" runat="server">
                <%--<table>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/anton.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Peter Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/bea.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Vilma Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/lucas.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Niko Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/cloe.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Niki Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/kitty.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Nika Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ImageUrl="~/images/residents/kiwi.jpg" Height="250px" runat="server" />
                                    </td>
                                    <td>
                                        <div>Niko Fajardo</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
            </div>
        </div>
        <div>
            <h2>Step 4: Record Action</h2>
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
                                <h1><div id="labelName" style="padding: 10px" ></div></h1>
                                <div id="labelVisitorType" style="padding: 10px" ></div>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
        </div>
        <asp:Button ID="btnLogIn" Text="Log In" runat="server" OnClientClick="return Capture('in');" />
        <asp:Button ID="btnLogOut" Text="Log Out" runat="server" OnClientClick="return Capture('out');" />
        
        <div id="hiddenAction">Current Activity: NONE</div>
        <hr />
        <div>
            <span id="camStatus"></span>
        </div>
    </form>
</body>
</html>
