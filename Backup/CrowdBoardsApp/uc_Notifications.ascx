<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="uc_Notifications.ascx.vb"
    Inherits="CrowdBoardsApp.uc_Notifications" %>
<div>
    <a href="#" class="open-notify_uc" style="text-decoration: none;">
        <div style="width: 60px; height: 39px; background-image: url('Images/notification.jpg');">
            <br />
            &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Label ID="lblUpdates" runat="server" Font-Size="Small" ForeColor="Red"></asp:Label>
        </div>
    </a>
</div>
<div id='notification' style="overflow: auto; text-align: justify;">
    <div style="text-align: center; height: 3%;">
        <b>Notifications!</b></div>
    <div style="min-height: 93%;">
        <asp:Repeater ID="notificationsRepeater" runat="server">
            <ItemTemplate>
                <table width="100%" border="0" style="text-align: left;">
                    
                    <tr id="Tr4" runat="server" visible='<%# IIf(Eval("type")="fra",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink8" runat="server" Text='<%# Eval("Users") %>'
                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; is now friend with &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink9" runat="server" Text='<%# Session("userName").ToString() %>'
                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr id="Tr6" runat="server" visible='<%# IIf(Eval("type")="frPending",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink10" runat="server" Text='<%# Eval("Users") %>'
                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has sent boarder request to you
                            
                        </td>
                    </tr>
                    <tr id="TrComments" runat="server" visible='<%# IIf(Eval("type")="postComments",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink12" runat="server" Text='<%# Eval("Users") %>'
                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; comments on&nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink13" runat="server" Text='<%# Session("userName").ToString() %>'
                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                            </asp:HyperLink>
                            &nbsp Post
                        </td>
                    </tr>
                    <tr id="TrPosts" runat="server" visible='<%# IIf(Eval("type")="postBoosts",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink14" runat="server" Text='<%# Eval("Users") %>'
                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; Boosts &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink15" runat="server" Text='<%# Session("userName").ToString() %>'
                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                            </asp:HyperLink>
                            &nbsp Post
                        </td>
                    </tr>
                    <tr id="TrRecommand" runat="server" visible='<%# IIf(Eval("type")="postRecommend",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink16" runat="server" Text='<%# Eval("Users") %>'
                                NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; Recommends &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink17" runat="server" Text='<%# Session("userName").ToString() %>'
                                NavigateUrl='<%# "~/Profile.aspx?User="+Session("userName").ToString() %>'>
                            </asp:HyperLink>
                            &nbsp Post
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="recentActivityOnBoardsRepeater" runat="server">
            <ItemTemplate>
                <table width="100%" border="0">
                    <tr id="investTR1" runat="server" visible='<%# IIf(Eval("type")="i",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="userLink" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just invested in &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="boardLink" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>&nbsp; a crowdboard you have invested in or watching
                        </td>
                    </tr>
                    <tr id="commentTR1" runat="server" visible='<%# IIf(Eval("type")="c",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink4" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just commented on
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink5" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                            a crowdboard you are watchning or invested in
                        </td>
                    </tr>
                    <tr id="recommendTR1" runat="server" visible='<%# IIf(Eval("type")="r",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink18" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just recommended
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink19" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                            a crowdboard you are watchning or invested in
                        </td>
                    </tr>
                    <tr id="watchTr1" runat="server" visible='<%# IIf(Eval("type")="w",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink20" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just watched
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink21" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                            a crowdboard you are watchning or invested in
                        </td>
                    </tr>
                    <tr id="investTR2" runat="server" visible='<%# IIf(Eval("type")="mybi",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink22" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just invested in your board &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink23" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr id="commentTR2" runat="server" visible='<%# IIf(Eval("type")="mybc",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink24" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just commented on your board &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink25" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr id="recommendTR2" runat="server" visible='<%# IIf(Eval("type")="mybr",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink26" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just recommended your board &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink27" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr id="watchTr2" runat="server" visible='<%# IIf(Eval("type")="mybw",true,false) %>'>
                        <td>
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink28" runat="server" Text='<%# Eval("userName") %>'
                                NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                            </asp:HyperLink>&nbsp; has just watched your board &nbsp;
                            <asp:HyperLink ForeColor="#99CCFF" ID="HyperLink29" runat="server" Text='<%# Eval("BoardName") %>'
                                NavigateUrl='<%# Eval("DirectoryName", "~/{0}") %>'>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <input id="hdnNotification" type="hidden" value="0" />
    <span style="vertical-align: baseline; height: 3%; text-align: center; font-size: larger;
        margin-left: 20px;">
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Notifications.aspx">  VIEW ALL NOTIFICATIONS                                                                   
        </asp:HyperLink>
    </span>
</div>
<asp:SqlDataSource ID="sdNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="select * from  dbo.u_recentActivities(@userID,@DateLastLoggedIn)">
    <SelectParameters>
        <asp:Parameter Name="userID" />
        <asp:Parameter Name="DateLastLoggedIn" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdRecentActivityOnBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="select * from  dbo.f_RecentActivityOnBoards(@userID,@DateLastLoggedIn)">
    <SelectParameters>
        <asp:Parameter Name="userID" />
        <asp:Parameter Name="DateLastLoggedIn" />
    </SelectParameters>
</asp:SqlDataSource>
<script type="text/javascript">
    $(document).ready(function () {
        initializePopUps_UC()
    });
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(function () {
        //alert("called");
        initializePopUps_UC();
    });
    function initializePopUps_UC() {
        $("a.open-notify_uc").click(function () {
            var hdnNotify = document.getElementById('hdnNotification');
            if (hdnNotify.value == "0") {
                $("#notification").fadeIn(1500);
                hdnNotify.value = "1";
            }
            else {
                $("#notification").fadeOut(1500);
                hdnNotify.value = "0";
            }
            return false;
        });

        $("#notification a.close-notify1").click(function () {
            $("#notification").fadeOut(1500);
            return false;
        });

        $("body").click(function () {
            $("#notification").fadeOut(100).removeClass("active");
            var hdnNotify = document.getElementById('hdnNotification');
            hdnNotify.value = "0";
        });
    }
</script>
<style type="text/css">
    #notification
    {
        display: none;
        height: 450px;
        width: 250px;
        background-color: #ececee;
        color: #262626;
        z-index: 999;
        filter: alpha(opacity=70);
        opacity: 1.0;
        position: absolute;
        left: 540px;
        top: 46px;
        overflow: auto;
        overflow-x: hidden;
        border-color: #99CCFF;
        border-style: solid;
        border-width: 1px;
    }
</style>
