<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InsiderNews.aspx.vb" MasterPageFile="~/MasterPage/Site.Master"
    Inherits="CrowdBoardsApp.InsiderNews" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Insider News</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/insider.css" rel="stylesheet" type="text/css" />
    <%--<link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .size1of3
        {
            float: left;
            width: 20%;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <asp:UpdatePanel ID="userUpdatePanel" runat="server">
        <ContentTemplate>
            <div class="container">
                <div class="main-body" style="height: auto;">
                    <div class="title">
                        <a href="BoardFolio.aspx">Back to Bordfolio</a>
                           <%--<asp:Label runat="server" ID="lblCrowdboardName"></asp:Label>
                        &nbsp;--%><asp:HyperLink
                            ID="boardNameLink" runat="server"  Font-Size="34px"></asp:HyperLink></span>
                        <asp:Label ID="lblmessage" runat="server"></asp:Label></div>
                    <div class="navigational-links">
                        <asp:LinkButton id="lbtInsiderNews" runat="server" Text="Insider News"></asp:LinkButton>
                      <asp:LinkButton id="lbtInsiderDetails" runat="server" Text="Insider Details"></asp:LinkButton>
                       
                       </div>
                    <div class="post-container">
                        <div>
                            <asp:LinkButton ID="btnPrevious" runat="server" ForeColor="#ececee"><img src="Images/previousInsiderNews.png" height="40" width="60" /></asp:LinkButton>
                        </div>
                        <div style="min-height: 210px; width: 100%; color: #262626;">
                            <div style="float: left; width: 50%;">
                                <asp:DataList ID="investorsPosts" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                    RepeatLayout="Table">
                                    <ItemTemplate>
                                        <div class="crowdnews-post" style="margin-left: 85px; width: 80%">
                                            <div class="posted-material">
                                                <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("PostedByUserName", IIf(Convert.ToString(Eval("PostedByUserName"))= Convert.ToString(Session("PostedByUserName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                    <asp:Image ID="boarderPic" CssClass="poster-image" runat="server" ToolTip='<%# Container.DataItem("PostedByUserName")%>'
                                                        ImageUrl='<%# isAvail(Eval("PostedByUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                <div class="poster-name">
                                                    <%# Container.DataItem("PostedByUserName")%>
                                                    says:</div>
                                                <div class="poster-comment">
                                                    <%# Container.DataItem("Text")%>
                                                </div>
                                                <div class="time-stamp">
                                                    <%# DataBinder.Eval(Container.DataItem, "DatePosted", "{0:MMM d, yyyy}")%></div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div style="float: right; min-height: 200px; width: 50%;" id="investorPostDiv" runat="server"
                                visible="false">
                                <asp:Button ID="btnInvestorPost" runat="server" Text="Post" CssClass="save-button button" />
                                <asp:Label ID="lblMessageInvestorPost" runat="server"></asp:Label><br />
                                <table width="100%" id="investorPostTable" runat="server" border="0" visible="false">
                                    <tr>
                                        <td>
                                            <telerik:RadTextBox ID="txtInvestorPost" runat="server" Width="50%" TextMode="MultiLine"
                                                Rows="3" ForeColor="#262626">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnCancelInvestorPost" runat="server" Text="Cancel" CssClass="save-button button" />
                                            <asp:Button ID="btnSendInvestorPost" runat="server" Text="Send" CssClass="save-button button" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div style="text-align: right; width: 100%;">
                            <asp:LinkButton ID="btnNext" runat="server" ForeColor="#ececee"><img src="Images/nextInsiderNews.png" height="40" width="60" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                    <div class="post-container">
                        <div style="border-top-color: #99CCFF; border-top-style: solid; border-top-width: 1;
                            margin-top: 2px;">
                            <br />
                            <div>
                                <asp:LinkButton ID="lbtnPreviousOwnerPosts" runat="server" ForeColor="#ececee"><img src="Images/previousInsiderNews.png" height="40" width="60" /></asp:LinkButton>
                                &nbsp;
                            </div>
                            <div style="min-height: 210px; width: 100%;">
                                <div style="float: left; width: 50%;">
                                    <asp:DataList ID="ownerPosts" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                        Width="100%" RepeatLayout="Table">
                                        <ItemTemplate>
                                            <div class="crowdnews-post" style="margin-left: 85px; width: 73%">
                                                <div class="posted-material">
                                                    <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("PostedByUserName", IIf(Convert.ToString(Eval("PostedByUserName"))= Convert.ToString(Session("PostedByUserName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                        <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("PostedByUserName")%>'
                                                            CssClass="poster-image" ImageUrl='<%# isAvail(Eval("PostedByUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                    <div class="poster-name">
                                                        <%# Container.DataItem("PostedByUserName")%>
                                                        says:</div>
                                                    <div class="poster-comment">
                                                        <%# Container.DataItem("Text")%>
                                                    </div>
                                                    <div class="time-stamp">
                                                        <%# DataBinder.Eval(Container.DataItem, "DatePosted", "{0:MMM d, yyyy}")%></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList></div>
                                <div style="float: right; min-height: 200px; width: 50%;" id="ownerPostDiv" runat="server"
                                    visible="false">
                                    <asp:Button ID="btnOwnerPost" runat="server" Text="Post" CssClass="save-button button" />
                                    <asp:Label ID="lblMessageOwnerPost" runat="server"></asp:Label><br />
                                    <table width="100%" id="ownerPostTable" runat="server" border="0" visible="false">
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtOwnerPost" runat="server" Width="50%" TextMode="MultiLine"
                                                    Rows="3" ForeColor="#262626">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnCancelOwnerPost" runat="server" Text="Cancel" CssClass="save-button button" />
                                                <asp:Button ID="btnSendOwnerPost" runat="server" Text="Send" CssClass="save-button button" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div style="text-align: right;">
                                <asp:LinkButton ID="lbtnNextOwnerPosts" runat="server" ForeColor="#ececee"><img src="Images/nextInsiderNews.png" height="40" width="60" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                    </div>
                    <div class="post-container">
                        <div style="min-height: 300px;">
                            <div style="font-size: 22px; font-weight: 600; margin-bottom: 8px;">
                                <span class="LabelheadingWhiteNew">Recent Activities</span></div>
                            <br />
                            <asp:Repeater ID="recentActivityOnBoardRepeater" runat="server" DataSourceID="sdRecentActivityOnBoard">
                                <ItemTemplate>
                                    <div class="size1of3">
                                        <div>
                                            <table width="100%" border="0">
                                                <tr id="commentTR" runat="server" visible='<%# IIf(Eval("ResultType")="c",true,false) %>'>
                                                    <td>
                                                        <div class="crowdnews-post" style="width:90%;">
                                                            <div class="posted-material">
                                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                    <asp:Image ID="Image1" runat="server" ToolTip='<%# Container.DataItem("userName")%>'
                                                                        CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                <div class="poster-name">
                                                                    <%# Container.DataItem("userName")%>
                                                                    Commnented:</div>
                                                                <div class="poster-comment">
                                                                    <%# Container.DataItem("Text")%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="investTR" runat="server" visible='<%# IIf(Eval("ResultType")="i",true,false) %>'>
                                                    <td>
                                                        <div class="crowdnews-post" style="width:90%;">
                                                            <div class="posted-material">
                                                                <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                    <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("userName")%>'
                                                                        CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                <div class="poster-name">
                                                                    <%# Container.DataItem("userName")%>
                                                                    has just invested in :</div>
                                                                <div class="poster-comment">
                                                                    <asp:HyperLink ForeColor="#0080FF" ID="boardLink" runat="server" Text='<%# Eval("BoardName") %>'
                                                                        NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                                    </asp:HyperLink>
                                                                </div>
                                                            </div>
                                                    </td>
                                                </tr>
                                                <tr id="Tr1" runat="server" visible='<%# IIf(Eval("ResultType")="w",true,false) %>'>
                                                    <td>
                                                        <div class="crowdnews-post" style="width:90%;">
                                                            <div class="posted-material">
                                                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                    <asp:Image ID="Image2" runat="server" ToolTip='<%# Container.DataItem("userName")%>'
                                                                        CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                <div class="poster-name">
                                                                    <%# Container.DataItem("userName")%>
                                                                    is watching :</div>
                                                                <div class="poster-comment">
                                                                    <asp:HyperLink ForeColor="#0080FF" ID="HyperLink3" runat="server" Text='<%# Eval("BoardName") %>'
                                                                        NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                                    </asp:HyperLink>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdBoardInsiderPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT IP.InsPostID,IP.BoardID,IP.Text,IP.DatePosted,IP.UserID,(SELECT Username from Users where UserID=IP.UserID) As PostedByUserName,CASE WHEN IP.UserID=(SELECT UserID FROM Boards WHERE BoardID=IP.BoardID) THEN 'IsOwnerPost' ELSE 'IsInvesterPost' END As PostBy from InsiderPosts IP WHERE IP.BoardID=@BoardID ORDER BY DatePosted DESC">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetBoardIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardId from Boards WHERE DirectoryName=@Name">
        <SelectParameters>
            <asp:Parameter Name="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdInsiderPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO InsiderPosts(BoardID,UserID,TEXT,DatePosted) VALUES(@BoardID,@UserID,@Text,GETDATE())">
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckIsOwner" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID from Boards WHERE DirectoryName=@Name">
        <SelectParameters>
            <asp:Parameter Name="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdRecentActivityOnBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from  dbo.f_BoardActivities(@userID,@BoardID)">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>
</asp:Content>
