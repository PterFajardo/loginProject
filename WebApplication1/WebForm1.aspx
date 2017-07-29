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
    
   
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; text-align:center;">
            <h1><asp:Literal ID="litTitle" runat="server"></asp:Literal></h1>
            <h3><asp:Literal ID="litAddress" runat="server"></asp:Literal></h3>
        </div>
        
        <asp:MultiView ID="multiView" runat="server">
            <asp:View ID="step1" runat="server">
                <div>
                    <h2>Step 1: Choose Type</h2>
                    <div id="visitType" class="visitType" runat="server" /> 
                </div>
            </asp:View>
            <asp:View ID="step2" runat="server">
                <div style="width: 100%; text-align:center;">
                    <h2>Step 2: Provide Info</h2>
                    <div>
                        First Name: <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                    </div>
                    <div>
                        Last Name: <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Button ID="btnStep2Cancel" Text="Reset" OnClick="btnStep2Cancel_Click" runat="server" />
                        <asp:Button ID="btnStep2Continue" Text="Continue" OnClick="btnStep2Continue_Click" runat="server" />
                    </div>
                </div>
            </asp:View>
            <asp:View ID="step3" runat="server">
                <div>
                    <h2>Step 3: Identify who will be visited and or reason for visit</h2>
                    <asp:ListView ID="grpData" runat="server" GroupItemCount="3" DataKeyNames="Id">
                        <LayoutTemplate>
                            <table runat="server" id="table1" >
                                <tr runat="server" id="groupPlaceholder" ></tr>
                            </table>
                            <%--<asp:DataPager runat="server" ID="DataPager" PageSize="2">
                              <Fields>
                                <asp:NumericPagerField ButtonCount="5" PreviousPageText="<--" NextPageText="-->" />
                              </Fields>
                            </asp:DataPager>--%>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <tr runat="server" id="personRow" style="height:80px">
                              <td runat="server" id="itemPlaceholder"></td>
                            </tr>
                          </GroupTemplate>
                          <ItemTemplate>
                              <td runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="picture" runat="server" ImageUrl='<%#Eval("Picture") %>' OnClick="imgButton_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%#Eval("FirstName") %>' />
                                            <asp:Label ID="LastNameLabel" runat="server" Text='<%#Eval("LastName") %>' />
                                        </td>
                                    </tr>
                                </table>
                              </td>
                          </ItemTemplate>
                    </asp:ListView>
                </div>
                <div>
                    <asp:Button ID="btnStep3Cancel" Text="Cancel" OnClick="btnStep3Cancel_Click" runat="server" />
                    <asp:Button ID="btnStep3Continue" Text="Continue" OnClick="btnStep3Continue_Click" runat="server" />
                </div>
            </asp:View>
            <asp:View ID="step4" runat="server">
                
        </asp:MultiView>
        <div id="hiddenAction">Current Activity: NONE</div>
        
    </form>
</body>
</html>
