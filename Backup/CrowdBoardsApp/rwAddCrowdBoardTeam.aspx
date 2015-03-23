<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwAddCrowdBoardTeam.aspx.vb"
    Inherits="CrowdBoardsApp.rwAddCrowdBoardTeam" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Crowdboard Team Request</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function closeMe() {
            var oWindow = GetRadWindow();
            oWindow.Close();
        }
        function Cancel() {
            var oWindow = GetRadWindow();
            oWindow.Close("CANCEL");
        }
        function Ok() {
            var oWindow = GetRadWindow();

        }
    </script>
</head>
<body style="background-color: #2B2B2B; color: White;">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="width: 100%;">
                    <table width="100%" border="0">
                        <tr>
                            <td style="text-align: center;">
                                <span class="LabelheadingWhite">Search Boarders</span>&nbsp;<telerik:RadTextBox ID="txtSearchBoarders"
                                    runat="server" BackColor="white" ForeColor="Black" Width="200px">
                                </telerik:RadTextBox>
                                <asp:Button ID="btnSearchBoarder" runat="server" Text="Find" CssClass="primaryButton" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <asp:Label ID="lblMessageAddBoarder" runat="server" Text="" Visible="false"></asp:Label></div>
                                <div style="margin-top: 15px;">
                                    <asp:DataList ID="nonFriendDatalist" runat="server" DataSourceID="sdAllBoardersList"
                                        RepeatColumns="8" RepeatLayout="Table">
                                        <ItemTemplate>
                                            <div>
                                                <table width="100%" border="0" cellspacing="4">
                                                    <tr>
                                                        <td style="background-color: #ECECEE; color: Black;">
                                                            <asp:HiddenField ID="hdnMemberID" runat="server" Value='<%# Container.DataItem("userID")%>' />
                                                            <asp:CheckBox ID="cbuser" runat="server" /><br />
                                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("username")%>'
                                                                    Height="50" Width="50" ImageUrl='<%# isAvail(Eval("username", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                            <br />
                                                            <%# Container.DataItem("username")%><br />
                                                            <%# Container.DataItem("FirstName")%>&nbsp;<%# Container.DataItem("LastName")%><br />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <asp:Button ID="btnSendrRequest" runat="server" Text="Send Request" CssClass="primaryButton" />
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
    <asp:SqlDataSource ID="sdAllBoardersList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Userid,username,FirstName,LastName FROM Users WHERE UserID<>@UserID and  username is not null and status=1 and (username like '%' + @searchKeyWord + '%' or FirstName like '%' + @searchKeyWord + '%' or LastName LIKE '%' + @searchKeyWord + '%')">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCrowdBoardTeam" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardID,MemberID,status,Description FROM BoardOwners WHERE BoardID=@BoardID AND MemberID=@MemberID"
        InsertCommand="INSERT INTO BoardOwners(BoardID,MemberID,status,DateRequested) VALUES(@BoardID,@MemberID,0,getdate())"
        UpdateCommand="UPDATE BoardOwners SET status=0,DateRequested=GETDATE(),DateRejected=null WHERE BoardID=@BoardID AND MemberID=@MemberID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</body>
</html>
