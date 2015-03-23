<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SiteSearch.aspx.vb" Inherits="CrowdBoardsApp.SiteSearch"
    MasterPageFile="~/MasterPage/Site.Master" Title="CrowdBoard Search Results" %>

<%@ Register TagPrefix="uc1" TagName="TitleBar" Src="~/uc_Notifications.ascx" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/searchresults.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">

        .thermometer
        {
            width: 100%;
            height: 80px;
          <%-- background: transparent url('Images/thermometer.jpg') no-repeat;--%>
        }
        .thermometerSlider div.rslDisabled
        {
            filter: none;
            -moz-opacity: 1;
            opacity: 1;
           
        }
        
        .thermometerSlider div.rslDisabled, .thermometerSlider div.rslDisabled a, .thermometerSlider div.rslDisabled li
        {
            cursor: pointer; /* all browsers but IE */
            cursor: default; /* IE */
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
            padding:5px;
            border:2px solid #75b4c6;
        }
        
.cb-btn {
    background-color: #ffffff;
    border: medium none;
    color: #75b4c6 !important;
    cursor: pointer;
    display: block;
    font-size: 16px !important;
    font-weight: 600;
    height: 31px;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    text-align:center;
    padding:5px;
}
.cb-btn:hover
{
    background-color: #3c6c79;
    border: 1px solid #fff;
    color: #fff !important;
    
    }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <!-- New -->
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <div class="container">
                <div class="first-row">
                    <span>Search Results
                        <asp:LinkButton ID="lnkbtnCrowdBoards" runat="server" Text="CrowdBoards"></asp:LinkButton>
                        <asp:LinkButton ID="lnkbtnCrowdBoarders" runat="server" Text="CrowdBoarders"></asp:LinkButton>
                        <asp:LinkButton ID="lnkbtnCrowdNews" runat="server" Text="Crowd News"></asp:LinkButton>
                    </span>
                </div>
                <div class="main-body">
                    <div style="text-align: right;">
                        <asp:Label ID="lblMessageSearch" runat="server"></asp:Label>
                    </div>
                    <asp:MultiView ID="MultiViewSearchResult" runat="server" ActiveViewIndex="0">
                        <asp:View ID="ViewCrowdBoards" runat="server">
                            <asp:Repeater ID="surfBoardsRepeater" runat="server" DataSourceID="sdAllBoards">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("TotalOffer") %>' />
                                     <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                    <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                    <div class="crowdboard-container group">
                                        <div class="crowdboard-video">
                                         <div id="covPicLineup" runat ="server">                                           
                                            <div class="play-button">
                                                <asp:ImageButton ID="ibtnPlay" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                    Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                    Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' /></div>
                                        </div>
                                        </div>
                                        <div class="crowdboard-profile-picture">
                                            <a href="">
                                                <img src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60,"thumbnail","thumbs") %>' /></a>
                                        </div>
                                        <div class="crowdboard-mini-console">
                                            <div class="crowdboard-measure">
                                                <table width="100%">
                                                    <tr valign="top">
                                                        <td style="width: 10%;">
                                                            <div style="margin-bottom: 10px;">
                                                                <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                    TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="96px"
                                                                    Style="margin-top: 4px;" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                    ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                    CssClass="thermometerSlider" BackColor="Transparent">
                                                                </telerik:RadSlider>
                                                            </div>
                                                        </td>
                                                        <td style="width: 90%;">
                                                            <div class="crowdboard-measure-text" style="margin-left: 5px; margin-bottom: 20px;">
                                                                <div class="crowdboard-measure-level">
                                                                    Level
                                                                    <asp:Label ID="lblBoardLevel" runat="server" Text='<%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%>'></asp:Label></div>
                                                                <div class="crowdboard-measure-max-left">
                                                                    Amount Left
                                                                    <asp:Label ID="lblAmountLeft" runat="server" Text='<%#GetAmount(Eval("AmountRemaining"),Eval("BankLocation"))%>'></asp:Label></div>
                                                                <div class="crowdboard-measure-boarders-in">
                                                                    Boarders In
                                                                    <asp:Label ID="lblBoardersIn" runat="server" Text='<%#Eval("BoarderInCount") %>'></asp:Label></div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<div class="crowdboard-status-bar"></div>--%>
                                                <%-- <div class="crowdboard-status-bar-position"></div>--%>
                                            </div>
                                            <a href="">
                                                <img src="WebContent/images/comment.png" /><div class="comment-number">
                                                    <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label></div>
                                            </a><a href="">
                                                <img src="WebContent/images/recommend.png" /><div class="recommend-number">
                                                    (2)</div>
                                            </a><a href="">
                                                <img src="WebContent/images/boost.png" /><div class="boost-number">
                                                    (3)</div>
                                            </a><a href="">
                                                <img src="WebContent/images/watchwbg.png" /><div class="watch-number">
                                                    <asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label></div>
                                            </a>
                                            <input type="button" value="INVEST!" id="invest-button" />
                                        </div>
                                        <div class="crowdboard-text">
                                            <div class="crowdboard-line-name">
                                                Name: <span>
                                                    <asp:Label ID="lblCrowdBoard" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label></span></div>
                                            <div class="crowdboard-line-location">
                                                Location: <span>
                                                    <asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location") %>'></asp:Label></span></div>
                                            <div class="crowdboard-line-seeking">
                                                Seeking: <span>
                                                    <asp:Label ID="lblSeeking" runat="server" Text='<%#GetAmount(Eval("TotalOffer"),Eval("BankLocation"))%>'></asp:Label></span></div>
                                            <div class="crowdboard-line-DA">
                                                District: <span class="district-tag">
                                                    <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label></span>
                                                Area: <span class="area-tag">
                                                    <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label></span></div>
                                            <div class="crowdboard-line-live-since">
                                                Live Since: <span>
                                                    <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label></span></div>
                                            <div class="crowdboard-wrapper-description">
                                                Description:<br></br>
                                                <div class="crowdboard-description">
                                                    <asp:Label ID="lblDescription" Font-Bold="false" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:HyperLink ID="boardLink" runat="server" CssClass="cb-btn" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                            Text="View CrowdBoard">
                                        </asp:HyperLink>
                                    </div>
                                    <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()  %>'>
                                        <div style="text-align: right;">
                                            <a id="popupBoxCloseYoutube" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
                                                <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: default;" /></a></div>
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
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:View>
                        <asp:View ID="ViewCrowdBoarders" runat="server">
                            <asp:Repeater ID="nonFriendRepater" runat="server" DataSourceID="sdAllBoardersList">
                                <ItemTemplate>
                                    <div class="boarder-lineup">
                                        <div class="boarder-lineup-image">
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("username")%>'
                                                    ImageUrl='<%# isAvail(Eval("username", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <div class="boarder-name-container">
                                                <div class="boarder-name">
                                                    <a href="">
                                                        <%# Container.DataItem("username")%></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="lineup-content">
                                            <div class="crowdboard-line-name">
                                                Name:
                                                <%# Container.DataItem("FirstName")%>&nbsp;<%# Container.DataItem("LastName")%>
                                                <asp:Label ID="lblPendingStatus" runat="server" Text="Pending" Visible='<%# IIf(Eval("friendStatus")=0,true,false) %>'></asp:Label>
                                            </div>
                                            <div class="boarder-location">
                                                Location:<span>Lucknow..</span></div>
                                            <div class="boarder-profession">
                                                Profession: <span>CrowdBoarders</span>
                                            </div>
                                            <div class="boarder-districts">
                                                Districts: <span>Technology,</span> <span>Green,</span> <span>Eco,</span> <span>Causes</span>
                                            </div>
                                            <div class="add-boarder">
                                                <input id="add-boarder-button" type="button" value="Add Boarder">
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:View>
                        <asp:View ID="ViewCrowdNews" runat="server">
                            <asp:Repeater ID="newsRepeater" runat="server" DataSourceID="sdCrowdNewsAll">
                                <ItemTemplate>
                                    <div class="crowdnews-post">
                                        <div class="posted-material">
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <div class="poster-options">
                                                <a class="comment-img" href="#">
                                                    <img src="WebContent/images/comment.png">
                                                    <div class="comment-number">
                                                        (1)</div>
                                                </a><a class="recommend-img" href="#">
                                                    <img src="WebContent/images/recommend.png">
                                                    <div class="recommend-number">
                                                        (2)</div>
                                                </a><a class="boost-img" href="#">
                                                    <img src="WebContent/images/boost.png">
                                                    <div class="boost-number">
                                                        (3)</div>
                                                </a>
                                            </div>
                                            <div class="poster-name">
                                                <%# Container.DataItem("FriendUserName")%>
                                                says:</div>
                                            <div class="poster-comment">
                                                <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
                                            </div>
                                            <div class="time-stamp">
                                                06/24/2014</div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- End New -->
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function unloadPopupBox(i) {    // TO Unload the Popupbox

                $('#popup_box_' + i).fadeOut("slow");
                //$("#container").css({ // this is just for style       
                //    "opacity": "1" 
                //});
                return false;
            }
            function loadPopupBox(i) {    // To Load the Popupbox
                //alert(i);
                $('#popup_box_' + i).fadeIn("slow");
                return false;

            }
        </script>
    </telerik:RadScriptBlock>
    <asp:SqlDataSource ID="sdAllBoardersList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Userid,username,FirstName,LastName,friendStatus FROM f_GetBoardersList(@UserID) WHERE username is not null and (username Like '%'+@searchKeyWord+'%'  or FirstName = '%'+@searchKeyWord+'%'  or LastName = '%'+@searchKeyWord+'%') ORDER BY friendstatus">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue=" " />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdAllBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName, CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,isnull(V.TotalOffer,0)as TotalOffer,V.BankLocation,V.Offer,V.RaisedTotal,V.AmountRemaining,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount  FROM vwBoardInfo   V  INNER JOIN Users U ON v.UserID =U.UserID WHERE V.Status=1 and V. Boardname Like '%'+@searchKeyWord+'%'">
        <SelectParameters>
            <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue=" " />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCrowdNewsAll" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT U.PostID,CASE WHEN LEN(U.Text) > 70 THEN substring(U.Text,0,65) + '...' ELSE U.Text END AS Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID   where (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) and U.UserID<>@UserID and U.Text like '%'+@searchKeyWord+'%' order by u.DatePosted desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
            <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue=" " />
        </SelectParameters>
    </asp:SqlDataSource>
    <script src="WebContent/Theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/main.js" type="text/javascript"></script>
</asp:Content>
