<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="uc_UnreadMessages.ascx.vb"
    Inherits="CrowdBoardsApp.uc_UnreadMessages" %>
<div>
    <a href="#" class="open-message_uc" style="text-decoration: none;">
        <div style="width: 60px; height: 39px; background-image: url('Images/unreadMessage.png');">
            <br />
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblUpdates" runat="server" Font-Size="Small" ForeColor="Red"></asp:Label>
        </div>
    </a>
</div>
<div id='UnreadMessages' style="overflow: auto; text-align: justify;">

<div style="height: 93%;">
    <asp:Label ID="lblMessage" runat="server"></asp:Label><br />
    <asp:Repeater ID="messageRepeater" runat="server" DataSourceID="sdMessages">
        <ItemTemplate>
            <table width="100%" border="0">
                <tr>
                    <td>
                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("FromUserName","~/Profile.aspx?User={0}") %>'>
                            <asp:Image ID="nonFriendPic" runat="server" ToolTip='<%# Container.DataItem("FromUserName")%>'
                                Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("FromUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                        <%# Container.DataItem("FromUserName")%>
                        says
                    </td>
                </tr>
                <tr>
                    <td>
                        <%# Container.DataItem("Text")%>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:Repeater>
    <input id="hdnUnreadMessages" type="hidden" value="0" /></div>
    <div style="vertical-align: baseline; height: 2%; text-align: center; font-size: larger;">
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Messages.aspx">  VIEW ALL MESSAGES                                                                   
        </asp:HyperLink></div>
</div>
<asp:SqlDataSource ID="sdMessages" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="SELECT top 3 MessageID,FromUser,ToUser,FromUserName,ToUserName,Unread,FileName, substring(FileName,CHARINDEX('+-',filename)+2,LEN(filename)) as FileText,Text   FROM vwMessagesDetail   Where ToUserName=@UserName  and unread=1 Order by datesent">
    <SelectParameters>
        <asp:SessionParameter Name="UserName" SessionField="userName" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
    <SelectParameters>
        <asp:SessionParameter Name="userID" SessionField="UserID" />
    </SelectParameters>
</asp:SqlDataSource>
<script type="text/javascript">
    $(document).ready(function () {
        initializePopUps_Message_UC()
    });
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(function () {
        //alert("called");
        initializePopUps_Message_UC();
    });
    function initializePopUps_Message_UC() {
        $("a.open-message_uc").click(function () {
            var hdnNotify = document.getElementById('hdnUnreadMessages');
            if (hdnNotify.value == "0") {
                $("#UnreadMessages").fadeIn(1500);
                hdnNotify.value = "1";
            }
            else {
                $("#UnreadMessages").fadeOut(1500);
                hdnNotify.value = "0";
            }
            return false;
        });

        $("#UnreadMessages a.close-notify1").click(function () {
            $("#UnreadMessages").fadeOut(1500);
            return false;
        });

        $("body").click(function () {
            $("#UnreadMessages").fadeOut(100).removeClass("active");
            var hdnNotify = document.getElementById('hdnUnreadMessages');
            hdnNotify.value = "0";
        });
    }
</script>
<style type="text/css">
    #UnreadMessages
    {
        display: none;
        height: 450px;
        width: 500px;
        background-color: #ececee;
        color: #262626;
        z-index: 999;
        filter: alpha(opacity=70);
        opacity: 1.0;
        position: absolute;
        top:46px;
        left:490px;
        overflow: auto;
        overflow-x: hidden;
        border-color: #99CCFF;
        border-style: solid;
        border-width: 1px;
    }
</style>
