<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BoarderRequests.aspx.vb"
    Inherits="CrowdBoardsApp.BoarderRequests" MasterPageFile="~/MasterPage/Site.Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>Boarder Requests</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/editmanageupdate.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/searchresults.css" rel="stylesheet" type="text/css" />
    <%--<link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .AcceptDeclinebtn
        {
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            font-size: 15px !important;
            font-weight: 600;
            margin-bottom: 3px;
            margin-right: 10px;
            margin-top: 17px;
            padding: 3px 4px 3px !important;
        }
        .AcceptDeclinebtn:hover
        {
            background-color: #3c6c79;
            color: #fff;
        }
        
        
        .size1of3
        {
            float: left;
            width: 33%;
            margin-bottom: 10px;
        }
        
        .size1of4
        {
            float: left;
            width: 25%;
            margin-bottom: 10px;
        }
        
        .popup_box
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 420px;
            width: 614px;
            background: none repeat scroll 0 0 rgba(60, 60, 60, 0.8);
            left: 300px;
            top: 150px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            padding: 5px;
            border: 2px solid #75b4c6;
        }
    </style>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <%-- <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>--%>
    <div class="container">
        <div class="first-row">
            <div class="title">
                <span>Boarder Requests
                    <asp:linkbutton id="lnkbtnConnect" runat="server" text="Connect">
                    </asp:linkbutton>
                    <asp:linkbutton id="lnkbtnInvitations" runat="server" text="CrowdBoard Invitations">
                    </asp:linkbutton>
                    <asp:linkbutton id="lnkbtnCrowdTeam" runat="server" text="CrowdBoard Team">
                    </asp:linkbutton>
                </span>
                <center>
                    <asp:label id="lblMessage" runat="server" font-size="Small"></asp:label>
                </center>
            </div>
        </div>
        <div class="main-body">
            <asp:multiview id="MultiViewBoarder" runat="server" activeviewindex="0">
                <asp:view id="ViewConnect" runat="server">
                    <div style="height: auto;">
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <span class="titles">Connect</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:repeater id="boardersRepeater" runat="server" datasourceid="sdPendingRequests">
                                        <itemtemplate>
                                                    <div class="size1of3">
                                                        <div class="crowdnews-post">
                                                            <div class="posted-material" style="padding-bottom: 0px;">
                                                                <asp:HiddenField ID="requesterEmailID" runat="server" Value='<%# Container.DataItem("Email")%>' />
                                                                <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("senderName","~/Profile.aspx?User={0}") %>'>
                                                                    <asp:Image ID="nonFriendPic" runat="server" ToolTip='<%# Container.DataItem("senderName")%>'
                                                                        Height="70px" Width="70px" ImageUrl='<%# isAvail(Eval("senderName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                <div class="poster-name" style="margin-top: 15px;">
                                                                    <span class="contentWhite">
                                                                        <%# Container.DataItem("senderName")%></span>
                                                                    <br />
                                                                    <span class="contentWhite">
                                                                        <%# Container.DataItem("senderFirstName")%></span> <span class="contentWhite">
                                                                            <%# Container.DataItem("senderLastName")%></span>
                                                                </div>
                                                                <div align="center">
                                                                    <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="AcceptDeclinebtn"
                                                                        CommandName="IAccept" CommandArgument='<%# Container.DataItem("senderID")%>' />
                                                                    &nbsp; &nbsp;
                                                                    <asp:Button ID="declineButton" runat="server" Text="Decline" CssClass="AcceptDeclinebtn"
                                                                        CommandName="IDecline" CommandArgument='<%# Container.DataItem("senderID")%>' />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </itemtemplate>
                                    </asp:repeater>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:view>
                <asp:view id="ViewCrowdTeam" runat="server">
                    <div style="height: auto;">
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <span class="titles">CrowdBoard Invitations</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="margin-top: 5px;">
                                        <asp:repeater id="crowdBoardTeamRepeater" runat="server" datasourceid="sdsCrowdBoardInvites">
                                            <itemtemplate>
                                                        <div class="size1of3">
                                                            <table width="100%" cellspacing="10px">
                                                                <tr>
                                                                    <td style="color: #ececee;">
                                                                        <span class="titles">
                                                                                                                            <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                                                            <asp:HyperLink ForeColor="#99CCFF" ID="userLink" runat="server" NavigateUrl='<%# Eval("OwnerName","~/Profile.aspx?User={0}") %>'>@<%# Container.DataItem("OwnerName")%></asp:HyperLink>&nbsp;
                                                                            <span class="titles" style="color: #788586; font-size: 16px;">Invited you to their CrowdBoard </span></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="crowdboard-container group" style="margin-top: 0px;">
                                                                            <div class="crowdboard-video">
                                                                                <div id="coverPicDiv" runat="server" style=" min-height: 100px; width: 100%;">
                                                                                    
                                                                                    <div class="play-button">
                                                                                        <asp:ImageButton ID="ibtnPlay1" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                                                            Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                                                            Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="crowdboard-profile-picture">
                                                                                <img id="imgBoard" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),40,40,"thumbnail","thumbs") %>' />
                                                                                <asp:HyperLink ID="boardNameLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                                                    Text='<%#Eval("BoardName") %>' Visible="false" CssClass="contentWhiteXXLarger"
                                                                                    ForeColor="#ececee">                                                                     
                                                                                </asp:HyperLink>
                                                                            </div>
                                                                            <div class="crowdboard-text">
                                                                                <div class="crowdboard-line-name">
                                                                                    Name: <span>
                                                                                        <asp:Label ID="lblBoardName" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-location">
                                                                                    Location: <span>
                                                                                        <asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location") %>'></asp:Label></span>
                                                                                </div>
                                                                                <div class="crowdboard-line-seeking">
                                                                                    Seeking: <span>
                                                                                        <asp:Label ID="lblSeeking" runat="server" Text='<%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-DA">
                                                                                    District: <span class="district-tag">
                                                                                        <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label></span>
                                                                                    Area: <span class="area-tag">
                                                                                        <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-live-since">
                                                                                    Live Since: <span>
                                                                                        <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-wrapper-description">
                                                                                    Description:<br>
                                                                                    <div class="crowdboard-description">
                                                                                        <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("BoardDescription") %>'></asp:Label>
                                                                                    </div>
                                                                                    <div>
                                                                                        <b>Watches:&nbsp;<asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label></b>
                                                                                        <b>Comments:&nbsp;
                                                                                            <asp:Label ID="lblComments" runat="server" Text='<%#Eval("comments") %>'></asp:Label></b>
                                                                                    </div>
                                                                                </div>
                                                                                <div style="text-align: center;">
                                                                                    <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="AcceptDeclinebtn"
                                                                                        CommandName="IAccept" CommandArgument='<%# Container.DataItem("BoardID")%>' />&nbsp;<asp:Button
                                                                                            ID="declineButton" runat="server" Text="Decline" CssClass="AcceptDeclinebtn"
                                                                                            CommandName="IDecline" CommandArgument='<%# Container.DataItem("BoardID")%>' /></div>
                                                                            </div>
                                                                            <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()%>'>
                                                                                <div style="text-align: right;">
                                                                                    <a id="popupBoxCloseYoutube" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
                                                                                        <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: default;" /></a>
                                                                                </div>
                                                                                <div>
                                                                                    <object width="600" height="400">
                                                                                        <param name="movie" value='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),"http://www.youtube.com/v/sFqbhsvXE7M",Eval("YoutubeVideoUrl")) %>' />
                                                                                        <param name="allowFullScreen" value="true" />
                                                                                        <param name="allowscriptaccess" value="always" />
                                                                                        <embed src='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),"http://www.youtube.com/v/sFqbhsvXE7M",Eval("YoutubeVideoUrl")) %>'
                                                                                            type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true"
                                                                                            width="600" height="380"></embed>
                                                                                    </object>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </itemtemplate>
                                        </asp:repeater>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:view>
                <asp:view id="ViewInvitations" runat="server">
                    <div style="height: auto;">
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <span class="titles">CrowdBoard Teams</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="margin-top: 5px;">
                                        <asp:repeater id="crowdBoardInvitationsRepeater" runat="server" datasourceid="sdsCrowdBoardTeam">
                                            <itemtemplate>
                                                        <div class="size1of4">
                                                            <table width="100%" cellspacing="10px">
                                                                <tr>
                                                                    <td style="color: #ececee;">
                                                                        <span class="titles">
                                                                          <asp:HiddenField ID="hdnDirectoryName1" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                                                            <span class="titles" style="color: #788586; font-size: 16px;">Creadted By: </span> <asp:HyperLink ForeColor="#99CCFF" ID="userLink" runat="server" NavigateUrl='<%# Eval("OwnerName","~/Profile.aspx?User={0}") %>'>@<%# Container.DataItem("OwnerName")%></asp:HyperLink>&nbsp;
                                                                            </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="crowdboard-container group" style="margin-top: 0px;">
                                                                            <div class="crowdboard-video">
                                                                                <div id="coverPicDiv1" runat="server" style=" min-height: 100px; width: 100%;">
                                                                                    <div class="play-button">
                                                                                        <a>
                                                                                            <input type="image" style="height: 49px; width: 49px;" src="WebContent/images/playbutton.png">
                                                                                        </a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="crowdboard-profile-picture">
                                                                                <img id="img1" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),40,40,"thumbnail","thumbs") %>' />
                                                                                <asp:HyperLink ID="boardNameLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                                                    Text='<%#Eval("BoardName") %>' Visible="false" CssClass="contentWhiteXXLarger"
                                                                                    ForeColor="#ececee">                                                                     
                                                                                </asp:HyperLink>
                                                                            </div>
                                                                            <div class="crowdboard-text">
                                                                                <div class="crowdboard-line-name">
                                                                                    Name: <span>
                                                                                        <asp:Label ID="lblBoardName" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-location">
                                                                                    Location: <span>
                                                                                        <asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location") %>'></asp:Label></span>
                                                                                </div>
                                                                                <div class="crowdboard-line-seeking">
                                                                                    Seeking: <span>
                                                                                        <asp:Label ID="lblSeeking" runat="server" Text='<%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-DA">
                                                                                    District: <span class="district-tag">
                                                                                        <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label></span>
                                                                                    Area: <span class="area-tag">
                                                                                        <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-line-live-since">
                                                                                    Live Since: <span>
                                                                                        <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label></span></div>
                                                                                <div class="crowdboard-wrapper-description">
                                                                                    Description:<br>
                                                                                    <div class="crowdboard-description">
                                                                                        <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("BoardDescription") %>'></asp:Label>
                                                                                    </div>
                                                                                    <div>
                                                                                        <b>Watches:&nbsp;<asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label></b>
                                                                                        <b>Comments:&nbsp;
                                                                                            <asp:Label ID="lblComments" runat="server" Text='<%#Eval("comments") %>'></asp:Label></b>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </itemtemplate>
                                        </asp:repeater>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:view>
            </asp:multiview>
        </div>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function unloadPopupBox(i) {
                $('#popup_box_' + i).fadeOut("slow");
                return false;
            }
            function loadPopupBox(i) {

                $('#popup_box_' + i).fadeIn("slow");
                return false;
            }
            function anchotInvestClick(board) {
                window.location.replace("" + board + "?BoardFolio=1#investDiv");
            }
        </script>
    </telerik:RadScriptBlock>
    <asp:sqldatasource id="sdPendingRequests" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT status,DateRequested,DateAccepted,userid1 AS senderID,UserID2 AS accepterID,(SELECT UserName FROM Users WHERE UserID=UserID1) AS senderName,(SELECT isnull(Email,'') as Email From Users where UserID=UserID1) AS Email,(SELECT FirstName FROM Users WHERE UserID=UserID1) AS senderFirstName,(SELECT LastName FROM Users WHERE UserID=UserID1) AS senderLastName,(SELECT UserName FROM Users WHERE UserID=UserID2) AS accepterName FROM Boarders WHERE Status=0 and  UserID2=@userID"
        updatecommand="UPDATE Boarders SET Status=1,DateAccepted=getdate() where UserID1=@userID1 AND UserID2=@userID">
        <updateparameters>
            <asp:Parameter Name="userID1" />
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </updateparameters>
        <selectparameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdRejectRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE Boarders SET DateRejected=getdate(),Status=2 where UserID1=@userID1 AND UserID2=@userID">
        <updateparameters>
            <asp:Parameter Name="userID1" />
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdsCrowdBoardInvites" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BO.BoardID,BO.MemberID,V.YoutubeVideoUrl, BO.status as RequestStatus,BO.Description, CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.invType,V.BoardName,V.DirectoryName,V.Watches,V.comments,V.Investors,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,BO.DateRequested,BO.DateAccepted,V.UserID as OwnerID,V.TotalOffer,V.Offer,V.District,V.AreaName,CASE WHEN LEN(V.Description) > 50 THEN substring(V.Description,0,47) + '...' ELSE V.Description END AS BoardDescription,(SELECT UserName from Users WHERE UserID=V.UserID) As OwnerName,V.BankLocation from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=0 AND MemberID=@MemberID"
        updatecommand="UPDATE BoardOwners SET Status=1,DateAccepted=getdate() WHERE BoardID=@BoardID AND MemberID=@MemberID">
        <selectparameters>
            <asp:SessionParameter Name="MemberID" SessionField="userID" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="BoardID" />
            <asp:SessionParameter Name="MemberID" SessionField="userID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdsCrowdBoardTeam" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BO.BoardID,BO.MemberID,V.YoutubeVideoUrl, BO.status as RequestStatus,BO.Description, CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.invType,V.BoardName,V.DirectoryName,V.Watches,V.comments,V.Investors,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,BO.DateRequested,BO.DateAccepted,V.UserID as OwnerID,V.TotalOffer,V.Offer,V.District,V.AreaName,CASE WHEN LEN(V.Description) > 50 THEN substring(V.Description,0,47) + '...' ELSE V.Description END AS BoardDescription,(SELECT UserName from Users WHERE UserID=V.UserID) As OwnerName,V.BankLocation from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=1 AND MemberID=@MemberID">
        <selectparameters>
            <asp:SessionParameter Name="MemberID" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdRejectCrowdboardTeamRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE BoardOwners SET DateRejected=getdate(),Status=2 where BoardID=@BoardID AND MemberID=@MemberID">
        <updateparameters>
            <asp:Parameter Name="BoardID" />
            <asp:SessionParameter Name="MemberID" SessionField="userID" />
        </updateparameters>
    </asp:sqldatasource>
</asp:content>
