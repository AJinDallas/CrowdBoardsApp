<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Notifications.aspx.vb"
    MasterPageFile="~/MasterPage/Site.Master" Inherits="CrowdBoardsApp.Notifications" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Notifications</title>
    <style type="text/css">
        .sizeof3
        {
            width: 40%;
            height: 100px;
            margin-bottom: 2px;
            background-image: url("Images/notificationBubble.png");
            background-repeat: no-repeat;
            background-size: 90% 100%;
            margin-left: 80px;
            overflow: hidden;
        }
        .myClass
        {
            background-image: url("Images/messageOther.png");
            width: 100%;
            margin-bottom: 2px;
            background-repeat: no-repeat;
            background-size: 90% 100%;
            overflow: hidden;
        }
        .itemAllNewsFull
        {
            width: 15%;
        }
        .itemAllNewsFull.w2
        {
            width: 50%;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/crowdnews.css" rel="stylesheet" type="text/css" />
    <%--  <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <%--<asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
              <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assemblyd="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>--%>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {

                loadNew();
            });

            function loadNew() {

                var $containerCrowdNewsFull = $('#containerCrowdNewsFull');

                $containerCrowdNewsFull.masonry({
                    columnWidth: 320,
                    itemSelector: '.itemAllNewsFull'
                });
            }

            function scrollThumbFull(direction) {

                if (direction == 'Go_U') {
                    $('#slide-wrapFull').animate({
                        scrollTop: "-=" + 250 + "px"
                    }, function () {
                        // createCookie('scrollPos', $('#slide-wrap').scrollLeft());
                    });
                } else
                    if (direction == 'Go_D') {
                        $('#slide-wrapFull').animate({
                            scrollTop: "+=" + 250 + "px"
                        }, function () {
                            // createCookie('scrollPos', $('#slide-wrap').scrollLeft());
                        });
                    }
        }
        </script>
    </telerik:RadScriptBlock>
    <div class="col2" style="width: 99%;">
        <%--<div style="background-color: #ececee; color: #262626;">
            <table width="100%" border="0">
                <tr>
                    <td style="width: 10%;">
                        &nbsp;
                        <asp:LinkButton ID="lbtnHome" runat="server" Text="Home" ForeColor="#262626"></asp:LinkButton>
                    </td>
                     <td style="width: 30%; color: Red; font-size: Large; font-weight: bold; text-align: center;">
                                <a href="mailto:info@crowdboarders.com" target="_top" style="color:Red;text-decoration:underline;">CONTACT US</a>
                            </td>
                    <td style="width: 8%; text-align: center;">
                        <uc1:TitleBar ID="TitleBar1" runat="server" />
                    </td>
                    <td style="width: 40%; text-align: right;">
                        &nbsp;
                        <asp:LinkButton ID="lbtnLogout" runat="server" Text="Logout" ForeColor="#262626"></asp:LinkButton>&nbsp;
                        <asp:LinkButton ID="lbtnSearch" runat="server" Text="Search" ForeColor="#262626"></asp:LinkButton>
                    </td>
                    <td style="width: 10%;">
                        <telerik:RadTextBox ID="searchBoardsTextBox" runat="server" BackColor="#262626" ForeColor="#ececee"
                            Width="250">
                        </telerik:RadTextBox>
                    </td>
                </tr>
            </table>
        </div>--%>
        <div style="width: 100%;">
            <div class="title">
                <span class="contentWhiteLarger">Recent Notifications</span><br />
            </div>
            <span style="margin-left: 15px;">
                <asp:Label ID="lblMessageRecent" runat="server"></asp:Label></span>
            <asp:Repeater ID="notificationsRepeater" runat="server">
                <ItemTemplate>
                    <div class="crowdnews-post">
                        <table width="100%" border="0" style="text-align: left; margin-top: 5px;">
                            <tr id="Tr4" runat="server" visible='<%# IIf(Eval("type")="fra",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#262626" ID="HyperLink8" runat="server" Text='<%# Eval("Users") %>'
                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; is now friend with &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#262626" ID="HyperLink9" runat="server" Text='<%# Session("userName").ToString() %>'
                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                            </asp:HyperLink>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="Tr6" runat="server" visible='<%# IIf(Eval("type")="frPending",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink10" runat="server" Text='<%# Eval("Users") %>'
                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>
                                        </div>
                                        <div class="poster-comment">
                                            has sent Boarder request to you
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="TrComments" runat="server" visible='<%# IIf(Eval("type")="postComments",true,false) %>'>
                                <td style="margin-left: 15px;">
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink12" runat="server" Text='<%# Eval("Users") %>'
                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; is comments on &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink13" runat="server" Text='<%# Session("userName").ToString() %>'
                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                            </asp:HyperLink>
                                            &nbsp;Post
                                            <br />
                                            &nbsp;&nbsp;&nbsp; <span>
                                                <%# Eval("Text") %></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="TrPosts" runat="server" visible='<%# IIf(Eval("type")="postBoosts",true,false) %>'>
                                <td style="margin-left: 15px;">
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink14" runat="server" Text='<%# Eval("Users") %>'
                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; Boosts &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink15" runat="server" Text='<%# Session("userName").ToString() %>'
                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                            </asp:HyperLink>
                                            &nbsp;Post
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="TrRecommand" runat="server" visible='<%# IIf(Eval("type")="postRecommend",true,false) %>'>
                                <td style="margin-left: 15px;">
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink16" runat="server" Text='<%# Eval("Users") %>'
                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; Recommends &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink17" runat="server" Text='<%# Session("userName").ToString() %>'
                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                            </asp:HyperLink>
                                            &nbsp;Post
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Repeater ID="recentActivityOnBoardsRepeater" runat="server">
                <ItemTemplate>
                    <div class="crowdnews-post">
                        <table width="100%" border="0">
                            <tr id="investTR1" runat="server" visible='<%# IIf(Eval("type")="i",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="userLink" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just invested in &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="boardLink" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>&nbsp; a crowdboard you have invested in or watching
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="commentTR1" runat="server" visible='<%# IIf(Eval("type")="c",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink4" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just commented on</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink5" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                            a crowdboard you are watchning or invested in
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="recommendTR1" runat="server" visible='<%# IIf(Eval("type")="r",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink18" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just recommended</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink19" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                            a crowdboard you are watchning or invested in
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="watchTr1" runat="server" visible='<%# IIf(Eval("type")="w",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <a href="">
                                            <img class="poster-image" src="images/Georgie.jpg" /></a>
                                        <div class="poster-options">
                                            <a href="#" class="comment-img">
                                                <img src="images/comment.png" /><div class="comment-number">
                                                    (1)</div>
                                            </a><a href="#" class="recommend-img">
                                                <img src="images/recommend.png" /><div class="recommend-number">
                                                    (2)</div>
                                            </a>
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink20" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just watched</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink21" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                            a crowdboard you are watchning or invested in
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="investTR2" runat="server" visible='<%# IIf(Eval("type")="mybi",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink22" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just invested in your board &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink23" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="commentTR2" runat="server" visible='<%# IIf(Eval("type")="mybc",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink24" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just commented on your board &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink25" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="recommendTR2" runat="server" visible='<%# IIf(Eval("type")="mybr",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <div class="poster-options">
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink26" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just recommended your board &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink27" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr id="watchTr2" runat="server" visible='<%# IIf(Eval("type")="mybw",true,false) %>'>
                                <td>
                                    <div class="posted-material">
                                        <a href="">
                                            <img class="poster-image" src="images/Georgie.jpg" /></a>
                                        <div class="poster-options">
                                            <a href="#" class="comment-img">
                                                <img src="images/comment.png" /><div class="comment-number">
                                                    (1)</div>
                                            </a><a href="#" class="recommend-img">
                                                <img src="images/recommend.png" /><div class="recommend-number">
                                                    (2)</div>
                                            </a>
                                        </div>
                                        <div class="poster-name">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink28" runat="server" Text='<%# Eval("userName") %>'
                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            </asp:HyperLink>&nbsp; has just watched your board &nbsp;</div>
                                        <div class="poster-comment">
                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink29" runat="server" Text='<%# Eval("BoardName") %>'
                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                            </asp:HyperLink>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <br />
        <div class="title">
            All Notifications <%--<span style="float: right;"><span style="cursor: pointer; color: #75b4c6;"
                title="Previous" onclick="scrollThumbFull('Go_U')">Previous</span><span> / </span>
                <span style="cursor: pointer; color: #75b4c6;" title="Next" onclick="scrollThumbFull('Go_D')">
                    Next</span></span>--%>
        </div>
        <div id='messageFull' style="min-height: 320px; color: #788586; float: left; width: 100%;">
            <div id='slide-wrapFull' style="width: 1300px; height: 580px; overflow-x:hidden; overflow-y:scroll; padding: 0 auto;">
                <div id="containerCrowdNewsFull" >
                    <asp:DataList ID="notificationsDataListFull" runat="server" RepeatDirection="Vertical"
                        RepeatLayout="Table">
                        <ItemTemplate>
                            <div class="itemAllNewsFull">
                                <div style="width: 300px;">
                                    <div class="crowdnews-post">
                                        <table width="100%" border="0" style="text-align: left;">
                                            <tr id="Tr4" runat="server" visible='<%# IIf(Eval("type")="fra",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink8" runat="server" Text='<%# string.Concat("@",Eval("Users").ToString()) %>'
                                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>
                                                            &nbsp; is now friend with</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink9" runat="server" Text='<%# string.Concat("@",Session("userName").ToString()) %>'
                                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="Tr6" runat="server" visible='<%# IIf(Eval("type")="frPending",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink10" runat="server" Text='<%# Eval("Users") %>'
                                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; has sent boarder request to you</div>
                                                        <div class="poster-comment">
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="TrComments" runat="server" visible='<%# IIf(Eval("type")="postComments",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink12" runat="server" Text='<%# Eval("Users") %>'
                                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; comments on
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink13" runat="server" Text='<%# Session("userName").ToString() %>'
                                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="TrPosts" runat="server" visible='<%# IIf(Eval("type")="postBoosts",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink14" runat="server" Text='<%# Eval("Users") %>'
                                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; Boosts
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink15" runat="server" Text='<%# Session("userName").ToString() %>'
                                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                                            </asp:HyperLink>
                                                            &nbsp Post
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="TrRecommand" runat="server" visible='<%# IIf(Eval("type")="postRecommend",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink16" runat="server" Text='<%# Eval("Users") %>'
                                                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; Recommends
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink17" runat="server" Text='<%# Session("userName").ToString() %>'
                                                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                                                            </asp:HyperLink>
                                                            &nbsp Post
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:DataList ID="activityOnBoardsDataList" runat="server" RepeatDirection="Vertical"
                        RepeatLayout="Table">
                        <ItemTemplate>
                            <div class="itemAllNewsFull">
                                <div style="width: 300px;">
                                    <div class="crowdnews-post">
                                        <table width="100%" border="0" style="text-align: left;">
                                            <tr id="commentTR1" runat="server" visible='<%# IIf(Eval("type")="c",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="userLinkC" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="userPicC" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            commented on board you are watching or invested in &nbsp;
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="boardLink" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text").toString() %>'> </asp:Label>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="lblActivityDateC" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="investTR1" runat="server" visible='<%# IIf(Eval("type")="i",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ID="HyperLink3" ForeColor="#99CCFF" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>&nbsp; board you are watching or invested in has a new investment
                                                            of
                                                            <%# Eval("AmountInvested")%>
                                                            from&nbsp;</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink2" runat="server" Text='<%# string.Concat("@",Eval("userName").ToString()) %>'
                                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>
                                                            on
                                                            <%# CheckNull(Eval("ActivityDate")) %>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="recommendTR1" runat="server" visible='<%# IIf(Eval("type")="r",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="userLinkR" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="userPicR" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            has recommended &nbsp;
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink11" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="poster-comment">
                                                            board you are watching or invested in
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="Label1" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="watchTr1" runat="server" visible='<%# IIf(Eval("type")="w",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="HyperLink30" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="Image1" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ID="HyperLink6" ForeColor="#99CCFF" runat="server" Text='<%# string.Concat("@",Eval("userName").ToString()) %>'
                                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; is watching &nbsp;</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ID="HyperLink31" ForeColor="#99CCFF" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                            board you are watching or invested in
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="Label4" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="commentTR2" runat="server" visible='<%# IIf(Eval("type")="mybc",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="HyperLink32" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="Image2" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            commented on your board &nbsp;
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink33" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Text").toString() %>'> </asp:Label>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="Label5" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="investTR2" runat="server" visible='<%# IIf(Eval("type")="mybi",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink34" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>&nbsp; board has a new investment of
                                                            <%# Eval("AmountInvested")%>
                                                            from&nbsp;</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink35" runat="server" Text='<%# string.Concat("@",Eval("userName").ToString()) %>'
                                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>
                                                            on
                                                            <%# CheckNull(Eval("ActivityDate")) %>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <%# CheckNull(Eval("ActivityDate")) %></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="recommendTR2" runat="server" visible='<%# IIf(Eval("type")="mybr",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="HyperLink36" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="Image3" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            has recommended your board &nbsp;</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink37" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="Label7" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="watchTr2" runat="server" visible='<%# IIf(Eval("type")="mybw",true,false) %>'>
                                                <td>
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="HyperLink38" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="Image4" runat="server" CssClass="poster-image" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <div class="poster-options">
                                                        </div>
                                                        <div class="poster-name">
                                                            <asp:HyperLink ID="HyperLink1" ForeColor="#99CCFF" runat="server" Text='<%# string.Concat("@",Eval("userName").ToString()) %>'
                                                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            </asp:HyperLink>&nbsp; is watching your board &nbsp;</div>
                                                        <div class="poster-comment">
                                                            <asp:HyperLink ID="HyperLink39" ForeColor="#99CCFF" runat="server" Text='<%# string.Concat("@",Eval("BoardName").ToString() + "@") %>'
                                                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                                                            </asp:HyperLink>
                                                        </div>
                                                        <div class="time-stamp">
                                                            <asp:Label ID="Label8" runat="server" Text='<%# CheckNull(Eval("ActivityDate")) %>'></asp:Label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function scrollThumbFull(direction) {
            if (direction == 'Go_U') {
                $('#slide-wrapFull').animate({
                    scrollTop: "-=" + 250 + "px"
                }, function () {
                    // createCookie('scrollPos', $('#slide-wrap').scrollLeft());
                });
            } else
                if (direction == 'Go_D') {
                    $('#slide-wrapFull').animate({
                        scrollTop: "+=" + 250 + "px"
                    }, function () {
                        // createCookie('scrollPos', $('#slide-wrap').scrollLeft());
                    });
                }
    }
    </script>
    <asp:SqlDataSource ID="sdNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from  dbo.u_recentActivities(@userID,@DateLastLoggedIn)">
        <SelectParameters>
            <asp:Parameter Name="userID" />
            <asp:Parameter Name="DateLastLoggedIn" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdNotificationsAll" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from  dbo.u_recentActivitiesAll(@userID) order by activityDate desc">
        <SelectParameters>
            <asp:Parameter Name="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdRecentActivityOnBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from  dbo.f_RecentActivityOnBoards(@userID,@DateLastLoggedIn)">
        <SelectParameters>
            <asp:Parameter Name="userID" />
            <asp:Parameter Name="DateLastLoggedIn" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardActivitiesAll" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from  dbo.f_RecentActivityOnBoardsFull(@userID) order by activityDate desc">
        <SelectParameters>
            <asp:Parameter Name="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
