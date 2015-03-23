<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="Messages-Old.aspx.vb" Inherits="CrowdBoardsApp.MessagesOld" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnResponseEnd="OnResponseEnd" OnRequestStart="OnRequestStart"></ClientEvents>
    </telerik:RadAjaxManager>
    <script language="javascript" type="text/javascript">
        function OnClientClicked(button, args) {
            if (!window.confirm("Are you sure you want delete this?")) {
                button.set_autoPostBack(false);
            }
            else {
                button.set_autoPostBack(true);
            }
        }
        function OnRequestStart(sender, args) {


        }

        function OnResponseEnd(sender, args) {


        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server"
    width="849" style="margin: 10px;">
    <telerik:RadAjaxPanel ID="RadJobAjaxPanel" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
        ClientEvents-OnRequestStart="OnRequestStart">
        <table style="z-index: 120; margin: auto;" cellspacing="0" cellpadding="0" width="849"
            border="0">
            <tr>
                <td>
                    <asp:Label ID="messageLabel" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top;">
                    <telerik:RadTreeView ID="RadTreeView1" runat="server" Width="120px">
                    </telerik:RadTreeView>
                </td>
                <td style="vertical-align: top;">
                    <telerik:RadGrid ID="rgMessages" runat="server" AutoGenerateColumns="False" GridLines="None"
                        Visible="false">
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="User Name" UniqueName="username">
                                    <ItemTemplate>
                                        <asp:Label ID="usernameLabel" runat="server" Text='<%#Eval("Users") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Text" HeaderText="Message" UniqueName="Text">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn DataField="datesent" HeaderText="Date Sent" SortExpression="datesent"
                                    UniqueName="datesent" FilterControlAltText="Filter Date column">
                                </telerik:GridDateTimeColumn>
                            </Columns>
                        </MasterTableView>
                        <HeaderContextMenu EnableAutoScroll="True">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <div id="replyDiv" runat="server" visible="false">
                        <table border="0">
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="replyMessageRadTexBox" runat="server" TextMode="MultiLine"
                                        Rows="5" Width="500px">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadButton ID="replyRadButton" runat="server" Text="Send">
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </telerik:RadAjaxPanel>
    <asp:SqlDataSource ID="userNameDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT DISTINCT CASE WHEN UserID1UserName=@userName THEN UserID2UserName ELSE UserID1UserName END AS Users, CASE WHEN UserID1=@userID THEN UserID2 ELSE UserID1 END AS userID FROM vwBoardersDetail WHERE UserID1UserName=@userName OR UserID2UserName=@userName AND Status=1 ORDER BY Users">
        <SelectParameters>
            <asp:SessionParameter Name="userName" SessionField="UserName" />
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessages" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT FromUser,ToUser,FromUserName,ToUserName,  CASE WHEN FromUserName=@userIDNode Then FromUserName Else 'ME' End As Users,datesent,Text   FROM vwMessagesDetail   Where (FromUserName=@userIDNode   OR ToUserName=@userIDNode) AND (FromUserName=@userID OR   ToUserName=@userID) Order by datesent desc"
        InsertCommand="INSERT INTO Messages(FromUser,ToUser,DateSent,Text,Unread) VALUES(@FromUser,@ToUser,@DateSent,@Text,@Unread)"
        UpdateCommand="UPDATE Messages SET Unread=0 WHERE Unread=1 and FromUser=@userIDNode and ToUser=@userID">
        <SelectParameters>
            <asp:Parameter Name="userIDNode" Type="string" />
            <asp:SessionParameter Name="userID" SessionField="userName" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="FromUser" Type="Int32" />
            <asp:Parameter Name="ToUser" Type="Int32" />
            <asp:Parameter Name="DateSent" Type="DateTime" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="Unread" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="userIDNode" Type="Int32" />
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and FromUser=@countUserIDNode and ToUser=@userID">
        <SelectParameters>
            <asp:Parameter Name="countUserIDNode" Type="Int32" />
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select UserName from Users where UserID=@nodeUserName">
        <SelectParameters>
            <asp:Parameter Name="nodeUserName" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
