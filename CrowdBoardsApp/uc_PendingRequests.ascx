<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="uc_PendingRequests.ascx.vb"
    Inherits="CrowdBoardsApp.uc_PendingRequests" %>
<div>
    <a href="#" class="open-pending_uc" style="text-decoration: none;">
        <div style="width: 60px; height: 37px; text-align: right; background-image: url('Images/pendingRequest.png');
            float: left;">
            <br />
            &nbsp; &nbsp; &nbsp;
            <asp:Label ID="lblUpdates" runat="server" Font-Size="Small" ForeColor="Red"></asp:Label>
        </div>
    </a>
</div>
<div id='pendingRequest' style="overflow: auto; text-align: justify;">
    <div style="text-align: center; font-size: larger; height: 5%;">
        Boarder Requests<br />
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </div>
    <div>
        <asp:Repeater ID="boardersRepeater" runat="server" DataSourceID="sdPendingRequests">
            <ItemTemplate>
                <table width="100%" cellspacing="2px">
                    <tr>
                        <td>
                            <asp:HiddenField ID="requesterEmailID" runat="server" Value='<%# Container.DataItem("Email")%>' />
                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("senderName","~/Profile.aspx?User={0}") %>'>
                                <asp:Image ID="nonFriendPic" runat="server" ToolTip='<%# Container.DataItem("senderName")%>'
                                    Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("senderName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                            <%# Container.DataItem("senderName")%>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center; font-size: large;">
                            <span>Invited you to connect</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="primaryButton"
                                CommandName="IAccept" CommandArgument='<%# Container.DataItem("senderID")%>' />
                            <asp:Button ID="declineButton" runat="server" Text="Decline" CssClass="primaryButton"
                                CommandName="IDecline" CommandArgument='<%# Container.DataItem("senderID")%>' />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="crowdBoardInvitationsRepeater" runat="server" DataSourceID="sdsCrowdBoardInvites">
            <ItemTemplate>
                <table width="100%" cellspacing="2px">
                    <%--<tr>
                        <td>
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("OwnerName","~/Profile.aspx?User={0}") %>'>
                                <asp:Image ID="nonFriendPic" runat="server" ToolTip='<%# Container.DataItem("OwnerName")%>'
                                    Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("OwnerName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                            <%# Container.DataItem("OwnerName")%>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: justify;">
                            Invited you to view<br />
                            <asp:HyperLink ID="boardNameLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/Board.aspx?Name={0}") %>'
                                Text='<%# Eval("BoardName", "@{0}@") %>' ForeColor="#99CCFF">                                                                     
                            </asp:HyperLink>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("OwnerName","~/Profile.aspx?User={0}") %>'>
                                <asp:Image ID="Image1" runat="server" ToolTip='<%# Container.DataItem("OwnerName")%>'
                                    Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("OwnerName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                            <%# Container.DataItem("OwnerName")%>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: justify;">
                            <span>Invited you to his
                                <br />
                                CrowdBoard team for<br />
                                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                    ForeColor="#99CCFF" Text='<%# Eval("BoardName", "@{0}@") %>'>                                                                     
                                </asp:HyperLink></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="primaryButton"
                                CommandName="IAccept" CommandArgument='<%# Container.DataItem("BoardID")%>' />&nbsp;<asp:Button
                                    ID="declineButton" runat="server" Text="Decline" CssClass="primaryButton" CommandName="IDecline"
                                    CommandArgument='<%# Container.DataItem("BoardID")%>' />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
        <input id="hdnPendingRequest" type="hidden" value="0" />
    </div>
    <div style="vertical-align: baseline; text-align: center; font-size: larger;">
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/BoarderRequests.aspx">  View All Boarder Requests                                                                   
        </asp:HyperLink></div>
</div>
<asp:SqlDataSource ID="sdPendingRequests" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="SELECT status,DateRequested,DateAccepted,userid1 AS senderID,UserID2 AS accepterID,(SELECT UserName FROM Users WHERE UserID=UserID1) AS senderName,(SELECT Isnull(Email,'') as Email From Users where UserID=UserID1) AS Email,(SELECT FirstName FROM Users WHERE UserID=UserID1) AS senderFirstName,(SELECT LastName FROM Users WHERE UserID=UserID1) AS senderLastName,(SELECT UserName FROM Users WHERE UserID=UserID2) AS accepterName FROM Boarders WHERE status=0  AND UserID2=@userID"
    UpdateCommand="UPDATE Boarders SET Status=1,DateAccepted=getdate() where UserID1=@userID1 AND UserID2=@userID">
    <UpdateParameters>
        <asp:Parameter Name="userID1" />
        <asp:SessionParameter Name="userID" SessionField="userID" />
    </UpdateParameters>
    <SelectParameters>
        <asp:SessionParameter Name="userID" SessionField="userID" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdRejectRequest" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="select Sum(Request+Request2) as RequestCount from(select *,(SELECT COUNT(*) Request FROM Boarders WHERE status=0  AND UserID2=@UserID) as Request2 from(SELECT count (*) Request from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=0 AND MemberID=@UserID)a)main"
    UpdateCommand="UPDATE Boarders SET DateRejected=getdate(),Status=2 where UserID1=@userID1 AND UserID2=@userID">
    <SelectParameters>
        <asp:SessionParameter Name="userID" SessionField="userID" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="userID1" />
        <asp:SessionParameter Name="userID" SessionField="userID" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsCrowdBoardInvites" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    SelectCommand="SELECT BO.BoardID,BO.MemberID,BO.status as RequestStatus,BO.Description,V.BoardName,V.DirectoryName,V.Watches,V.comments,V.Investors,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,BO.DateRequested,BO.DateAccepted,V.UserID as OwnerID,V.TotalOffer,V.Offer,CASE WHEN LEN(V.Description) > 53 THEN substring(V.Description,0,50) + '...' ELSE V.Description END AS BoardDescription,(SELECT UserName from Users WHERE UserID=V.UserID) As OwnerName from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=0 AND MemberID=@MemberID"
    UpdateCommand="UPDATE BoardOwners SET Status=1,DateAccepted=getdate() WHERE BoardID=@BoardID AND MemberID=@MemberID">
    <SelectParameters>
        <asp:SessionParameter Name="MemberID" SessionField="userID" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="BoardID" />
        <asp:SessionParameter Name="MemberID" SessionField="userID" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdRejectCrowdboardTeamRequest" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
    UpdateCommand="UPDATE BoardOwners SET DateRejected=getdate(),Status=2 where BoardID=@BoardID AND MemberID=@MemberID">
    <UpdateParameters>
        <asp:Parameter Name="BoardID" />
        <asp:SessionParameter Name="MemberID" SessionField="userID" />
    </UpdateParameters>
</asp:SqlDataSource>
<script type="text/javascript">
    $(document).ready(function () {
        initializePopUps_pending_UC()
    });
    var prm1 = Sys.WebForms.PageRequestManager.getInstance();
    prm1.add_endRequest(function () {
        //alert("called");
        initializePopUps_pending_UC();
    });
    function initializePopUps_pending_UC() {
        $("a.open-pending_uc").click(function () {
            var hdnPendingRequest = document.getElementById('hdnPendingRequest');
            if (hdnPendingRequest.value == "0") {
                $("#pendingRequest").fadeIn(1500);
                hdnPendingRequest.value = "1";
            }
            else {
                $("#pendingRequest").fadeOut(1500);
                hdnPendingRequest.value = "0";
            }
            return false;
        });

        $("#pendingRequest a.close-notify1").click(function () {
            $("#pendingRequest").fadeOut(1500);
            return false;
        });

        $("body").click(function () {
            $("#pendingRequest").fadeOut(100).removeClass("active");
            var hdnPendingRequest = document.getElementById('hdnPendingRequest');
            hdnPendingRequest.value = "0";
        });
    }
</script>
<style type="text/css">
    #pendingRequest
    {
        display: none;
        height: 450px;
        width: 200px;
        background-color: #ececee;
        color: #262626;
        z-index: 999;
        filter: alpha(opacity=70);
        opacity: 1.0;
        position: absolute;
        top: 46px;
        left: 410px;
        overflow: auto;
        overflow-x: hidden;
        border-color: #99CCFF;
        border-style: solid;
        border-width: 1px;
    }
</style>
