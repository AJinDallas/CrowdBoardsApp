<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home-Old.aspx.vb" Inherits="CrowdBoardsApp.HomeOld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="width: 849px; z-index: 120; margin: auto;">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <table width="100%" border="0">
        <tr>
            <td>
                <asp:Label ID="messageLabel" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 33%; vertical-align: top;">
                <asp:Image ID="logoImage" runat="server" ImageUrl="~/Images/image1.png" Height="60px"
                    Width="300px" />
            </td>
            <td valign="top" style="width: 34%;">
                <div style="background-color: #FFFAFA;">
                    <table width="100%">
                        <tr>
                            <td style="text-align: center;">
                                <b>Boarders</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Repeater ID="boardersRepeater" runat="server" DataSourceID="sdBoarders">
                                    <ItemTemplate>
                                        <div class="size1of3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:HyperLink ID="userLink" runat="server" Text='<%# Container.DataItem("Users")%>'
                                                            NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'></asp:HyperLink>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="boarderPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                                            ImageUrl='<%# Eval("Users", "~/ProfilePics/{0}.jpg") %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <br style="clear: left;" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <b>Boarder Requests</b>
                                <asp:Label ID="pendingRequestsCount" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 33%; vertical-align: top;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnLogout" runat="server" Text="Logout">
                            </telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSearch" runat="server" Text="Search">
                            </telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnAdmin" runat="server" Text="Admin">
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 33%;">
            </td>
            <td style="width: 34%; text-align: center;">
                <div style="background-color: #FFFAFA;">
                    <table border="0">
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 34%;">
                                <i>
                                    <asp:HyperLink ID="messagesHyperLink" runat="server" NavigateUrl="~/Messages.aspx"
                                        Text="Messages"></asp:HyperLink></i>
                                <asp:Label ID="msgCountLabel" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Image ID="profilePic" runat="server" Height="125px" Width="125px" AlternateText="No Image" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadButton ID="postRadButton" runat="server" Text="Post">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="txtPost" runat="server" TextMode="MultiLine" Rows="3" Width="200px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>Profile </b>
                                <asp:HyperLink ID="viewProfile" runat="server" NavigateUrl="~/Profile.aspx" Text="View"></asp:HyperLink>/<asp:HyperLink
                                    ID="editProfile" runat="server" NavigateUrl="~/MyProfile.aspx" Text="Edit"></asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>
                                    <asp:HyperLink ID="myCrowdBoardsHyperlink" runat="server" NavigateUrl="~/Home.aspx"
                                        Text="My CrowdBoards"></asp:HyperLink></b>
                                <asp:Label ID="crowdBoardsCount" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>
                                    <asp:HyperLink ID="investmentsHyperlink" runat="server" NavigateUrl="~/Home.aspx"
                                        Text="Investments"></asp:HyperLink></b>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 33%; vertical-align: top;">
                <div style="background-color: #FFFAFA;">
                    <asp:Repeater ID="latestPostRepeater" runat="server" DataSourceID="sdRecentPosts">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="boardPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                            ImageUrl='<%# Eval("UserID", "~/ProfilePics/{0}.jpg") %>' />
                                    </td>
                                    <td>
                                        <%# Container.DataItem("Text")%>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </td>
        </tr>
        <tr>
            <td style="width: 33%;">
            </td>
            <td style="width: 34%;">
                <asp:LinkButton ID="btnCreateBoard" runat="server">
                    <img id="imgCreateBoard" runat="server" height="60" width="300" src="~/Images/createBoard.png" /></asp:LinkButton>
            </td>
            <td style="width: 33%;">
            </td>
        </tr>
        <tr>
            <td style="width: 33%;">
            </td>
            <td style="width: 34%; text-align: center;">
                <div style="background-color: #FFFAFA;">
                    <table border="0" width="100%">
                        <tr>
                            <td valign="top" style="width: 33%;">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <b>Watch</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Repeater ID="watchRepeater" runat="server" DataSourceID="sdBoardRecentlyOnWatch">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Image ID="boardPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                                                    ImageUrl='<%# Eval("DirectoryName", "~/thumbnail/{0}.jpg") %>' />
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <%# Container.DataItem("BoardName")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" style="width: 34%;">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <b>Comments</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Repeater ID="commentsOrInvestedRepeater" runat="server" DataSourceID="sdBoardRecentlyWatchedOrInvested">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Image ID="boardPic1" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                                                    ImageUrl='<%# Eval("DirectoryName", "~/thumbnail/{0}.jpg") %>' />
                                                            </td>
                                                            <td style="vertical-align: top;">
                                                                <%# Container.DataItem("BoardName")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" style="width: 33%;">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <b>Investments</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Repeater ID="myInvestments" runat="server" DataSourceID="sdBoardsInvestedByUser">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Image ID="boardPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                                                    ImageUrl='<%# Eval("DirectoryName", "~/thumbnail/{0}.jpg") %>' />
                                                            </td>
                                                            <td>
                                                                <%# Container.DataItem("BoardName")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 34%; text-align: center;" colspan="3">
                                <asp:HyperLink ID="browseHyperlink" runat="server" NavigateUrl="~/Search.aspx">Browse Crowdboards</asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 33%;">
            </td>
        </tr>
    </table>
    </form>
    <asp:SqlDataSource ID="sdBoarders" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT CASE WHEN UserID1=@userID Then UserID2 Else UserID1 End As Users,UserID1,UserID2,Status,DateRequested,DateAccepted FROM Boarders Where UserID2=@userID OR UserID1=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCrowdBoardsCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(BoardID) BoardsCount from boards where UserID=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdPendingRequests" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(userid2) PendingRequestCount from Boarders where UserID2=@userID and Status=0">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCreateNewBoardDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spCreateNewBoard" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserPosts(UserID,Text,DatePosted) VALUES(@UserID,@Text,@DatePosted)">
        <InsertParameters>
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="DatePosted" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdRecentPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select top 3 U.UserID,u.Text,u.DatePosted from UserPosts U inner join Boarders B on u.UserID=B.UserID1 or U.UserID=b.UserID2 where U.UserID<>@userID and (b.UserID1=@userID or b.UserID2=@userID) order by u.DatePosted desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardRecentlyOnWatch" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select top 1 b.directoryname,b.BoardName from boards b left outer join  Watchers w on w.BoardID=b.BoardID where w.WatchingBy=@userID order by w.watchdate desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardRecentlyWatchedOrInvested" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Top 1 B.DirectoryName,B.BoardID, B.BoardName,BI.DateInvested,BC.CommentDate,W.WatchingBy ,W.WatchDate FROM Boards B  left JOIN Watchers W ON b.BoardID =W.BoardID  Left outer JOIN BoardInvestors BI ON B.BoardID=BI.BoardID  left JOIN BoardComments BC ON B.BoardID=BC.BoardID WHERE (BI.UserID=@userId or W.WatchingBy=@userId or BC.userID=@userId) Order By (case when BC.CommentDate Is Null then W.WatchDate when W.WatchDate IS null then BI.DateInvested else BC.CommentDate end) Desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardsInvestedByUser" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT top 1 BI.BoardID,B.BoardName,B.[Description],B.Keywords,BI.DateInvested,B.URL,B.DirectoryName FROM Boards B INNER JOIN BoardInvestors BI ON B.BoardID=BI.BoardID WHERE BI.UserID=@userID order by DateInvested desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
