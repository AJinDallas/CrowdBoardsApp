<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Site.Master"
    CodeBehind="Profile.aspx.vb" Inherits="CrowdBoardsApp.Profile" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>Profile</title>
    <link href="WebContent/Theme/styles/myconsole.css" rel="stylesheet" type="text/css" />
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/profile.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
         
        .tdSide
        {
            style="width:40Px"
        }
         .horizontalDirection
        {
            float: left;
            width: 70px;
        }
         .size1of3
        {
            float: left;
            width: 32%;
        }
        
        .size1of6
        {
            float: left;
            width: 16%;
        }
        
             .thermometer
        {
            width: 100%;
            height: 150px;           
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
        
        .post-button 
        {
            display: block;
            margin-top: 5px;
            padding-bottom: 1px;
            padding-top: 1px;
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            float: right;
            font-size: 16px !important;
            font-weight: 600;
            margin-bottom: 25px;
            margin-left:5px;
        }
        .post-button:hover 
        {
            background-color: #3c6c79;
        }
      
    </style>
    <style type="text/css">
        .open-notify
        {
        }
        .add-button
        {
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            display: block;
            font-size: 24px;
            font-weight: 600;
            margin: 10px auto 40px;
            padding: 8px 30px 9px;
        }
        .add-button:hover
        {
            background: none repeat scroll 0 0 #3c6c79;
            color: #fff;
        }
        .view-crowdboard-button
        {
            background-color: #ffffff;
            border: medium none;
            color: #75b4c6;
            cursor: pointer;
            display: block;
            font-size: 16px !important;
            font-weight: 600;
            height: 31px;
            margin-left: auto;
            margin-right: auto;
            width: 100%;
        }
        .view-crowdboard-button:hover
        {
            background-color: #3c6c79;
            border: 1px solid #fff;
            color: #fff;
        }
        .itemAllNewsFull
        {
            width: 15%;
        }
        .itemAllNewsFull.w2
        {
            width: 50%;
        }
        
        th, td
        {
            vertical-align: top;
        }
    </style>
    <script>
        function anchotInvestClick(board) {
            window.location.replace("" + board + "?Profile=1#investDiv");
        }
        function anchotClick(board) {
            window.location.replace("" + board + "?Profile=1");
        }
    </script>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <%--<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>--%>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <script type="text/javascript">
            function HideDiv() {
                $("#activityDiv").fadeOut();
                $("#BoardFolioDiv").fadeOut();
                $("#DistrictDiv").fadeOut();
                $("#AreaDiv").fadeOut();
                $("#DivCrowdboarders").fadeOut();
                $("#BoarderLineupDiv").fadeOut();
            }
            function showDiv(div) {
                HideDiv();
                $(div).fadeIn();
                return false;
            }

        </script>
    </telerik:RadScriptBlock>
    <div id="userBody" runat="server" style="z-index: 120; margin: auto; width: 100%;">
        <div id="first-row" class="container">
            <div class="profile-banner">
                <div class="banner-picture">
                    <%-- <img src="WebContent/images/profilebanner.jpeg">--%>
                    <asp:image id="coverPic" runat="server" alternatetext="No Image" />
                </div>
            </div>
            <div class="profile-picture">
                <asp:image id="profilePic" runat="server" alternatetext="No Image" />
            </div>
            <table style="width: 100%; display: table;">
                <tr>
                    <td style="width: 20%;">
                        <div class="col1" style="width: 100%; min-width:300px;">
                            <div class="profile-name">
                                <asp:label id="userNameLabel" runat="server" style="font-size: 19px;"></asp:label>
                            </div>
                            <div class="add-boarder">
                                <asp:label id="pendingLabel" text="Request Pending" runat="server" visible="false"></asp:label>
                                <asp:button id="addUsers" runat="server" cssclass="add-button" visible="false" />
                                <asp:button id="messageUser" runat="server" cssclass="add-button" text="" visible="false" />
                            </div>
                            <table>
                                <tr id="messageDiv" runat="server" visible="false">
                                    <td>
                                        <div class="WOTS-post-message">
                                            <asp:label id="sendMessageLabel" runat="server"></asp:label>
                                            <telerik:RadTextBox ID="sendMessageRadTexBox" runat="server" TextMode="MultiLine"
                                                Columns="28">
                                            </telerik:RadTextBox>
                                            <asp:button id="sendMessageRadButton" runat="server" text="Send" cssclass="post-button" />
                                            <asp:button id="cancelRadButton" runat="server" cssclass="post-button" text="Cancel" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div class="my-activity">
                                <asp:linkbutton id="activityLinkbutton" runat="server" onclientclick=" return showDiv(activityDiv);">My Activity</asp:linkbutton>
                            </div>
                            <div class="my-boardfolio" style="font-size: 14px;">
                                <asp:linkbutton id="boardfolioLinkbutton" runat="server" text="My Boardfolio" onclientclick=" return showDiv(BoardFolioDiv);">
                                </asp:linkbutton>
                                <span class="boardfolio-number">
                                    <asp:label id="myBoardfolioLabel" runat="server"></asp:label></span>
                            </div>
                            <div class="my-districts">
                                <asp:linkbutton id="districtsLinkbutton" runat="server" text="My Districts" onclientclick=" return showDiv(DistrictDiv);">
                                </asp:linkbutton>
                                <span class="districts-number">
                                    <asp:label id="myDistrictsLabel" runat="server"></asp:label></span>
                            </div>
                            <div class="my-areas">
                                <asp:linkbutton id="areasLinkbutton" runat="server" text="My Areas" onclientclick=" return showDiv(AreaDiv);">
                                </asp:linkbutton>
                                <span class="areas-number">
                                    <asp:label id="myAreasLabel" runat="server"></asp:label></span>
                            </div>
                            <div class="my-crowdboards">
                                <asp:linkbutton id="crowdboardsLinkbutton" runat="server" text="My Crowdboards" onclientclick=" return showDiv(DivCrowdboarders);">
                                </asp:linkbutton>
                                <span class="crowdboards-number">
                                    <asp:label id="MyBoardsLabel" runat="server"></asp:label></span>
                            </div>
                            <div class="my-lineup">
                                <asp:linkbutton id="crowdboardsLineupLinkbutton" runat="server" text="Boarders Lineup"
                                    onclientclick=" return showDiv(BoarderLineupDiv);">
                                </asp:linkbutton>
                                <span class="linup-number">
                                    <asp:label id="BoardersLineupLabel" runat="server"></asp:label></span>
                            </div>
                        </div>
                    </td>
                    <td style="width: 80%;">
                        <table style="width: 100%; display: table;">
                            <tr>
                                <td style="width: 40%; padding: 2px;">
                                    <div class="col2" style="width: 100%;">
                                        <div class="name">
                                            Name: <span>
                                                <asp:label id="nameLabel" runat="server"></asp:label></span>
                                        </div>
                                        <div class="profession">
                                            Profession: <span>
                                                <asp:label id="jobLabel" runat="server"></asp:label></span>
                                        </div>
                                         <div class="resides" id="divResides" runat="server">
                                        Resides In:
                                           <span>
                                                <asp:label id="residesInLabel" runat="server"></asp:label></span>
                                        </div>

                                       <%-- <div class="resides">
                                            Resides In: <span>
                                                <asp:label id="residesInLabel" runat="server"></asp:label></span>
                                        </div>--%>
                                        <div class="hometown">
                                            Hometown: <span>
                                                <asp:label id="homeTownLabel" runat="server"></asp:label></span>
                                        </div>
                                        <div class="birthday">
                                            Birthday: <span>
                                                <asp:label id="birthdateLabel" runat="server"></asp:label></span>
                                        </div>
                                        <div class="skills">
                                            Skills: <span>
                                                <asp:label id="skillsLabel" runat="server"></asp:label></span>
                                        </div>
                                        <div class="website">
                                            Website: <span>
                                                <asp:label id="websiteLabel" runat="server"></asp:label></span>
                                        </div>
                                    </div>
                                </td>
                                <td style="width: 60%; padding: 2px;">
                                    <div class="col3" style="width: 100%;">
                                        <div class="about-me">
                                            About Me:
                                            <div>
                                                <asp:label id="aboutMeLabel" runat="server"></asp:label></div>
                                        </div>
                                        <div class="passions">
                                            My Passions Are:
                                            <div>
                                                <asp:label id="myPassionsLabel" runat="server" text=""></asp:label></div>
                                        </div>
                                        <div class="dreams">
                                            My Dream is:
                                            <div>
                                                <asp:label id="myDreamsLabel" runat="server"></asp:label></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="width: 100%; padding: 2px;">
                                    <div class="col4" style="width: 100%; padding: 5px;">
                                        <asp:label id="messageLabel" runat="server" text="" visible="false"></asp:label>
                                        <%--  <span class="profile-name">
                        <asp:label id="userNameLabelActivity" runat="server"></asp:label></span>--%>
                                        <div class="container">
                                            <%-- <telerik:RadMultiPage ID="radMultiPage" runat="server" SelectedIndex="0">
                            <telerik:RadPageView ID="rpvActivityView" runat="server" Selected="true">--%>
                                            <div id="activityDiv" style="display: block;">
                                                <span class="profile-name">
                                                    <asp:label id="userNameLabelActivity" runat="server"></asp:label></span>
                                                <div class="col4-container">
                                                    <div id="createdBoardDiv" runat="server" class="newsfeed-message contains-crowdboard">
                                                        <div class="newsfeed-comment">
                                                            <div class="newsfeed-image">
                                                                <a href="">
                                                                    <asp:image id="createProfileImage" runat="server" alternatetext="No Image" /></a></div>
                                                            <div class="message-attribution" style="font-size: 14px;">
                                                                <span class="boarder-message-name">
                                                                    <asp:label id="createdBoardNameLable" runat="server"></asp:label>
                                                                    just created crowdboard</span>
                                                            </div>
                                                            <span class="district-tag"><a href='#'>
                                                                <asp:label id="lblDateCreated" runat="server"></asp:label></a> </span>
                                                            <asp:repeater id="surfBoardsRepeater" runat="server" datasourceid="sdsCreatedBoard">
                                                                <itemtemplate>
                                                    <asp:HiddenField ID="hdnDirectoryName1" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                                    <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("Seeking") %>' />
                                                    <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                                    <asp:HiddenField ID="hdnBoardName" runat="server" Value='<%#Eval("BoardName") %>' />
                                                    <asp:HiddenField ID="hdnYoutubeVideoUrl" runat="server" Value='<%#Eval("YoutubeVideoUrl") %>' />
                                                    <div class="size1of4">
                                                        <asp:LinkButton ID="lbBoardDetail" runat="server" CommandName="ToBoard" CommandArgument='<%# Eval("DirectoryName") %>'>
                                                            <div class="crowdboard-container group">
                                                                <div class="crowdboard-video">
                                                                    <div id="coverPicDiv" runat="server" style="background-color: #626262; min-height: 100px;
                                                                        width: 100%;">
                                                                        <div class="play-button">
                                                                            <asp:LinkButton ID="ShowVideoLinkButton" runat="server" CommandName="ShowVideo" CommandArgument='<%#Eval("YoutubeVideoUrl") %>'>
                                                                                <asp:ImageButton ID="ibtnPlay" ImageUrl="WebContent/images/playbutton.png" Height="49"
                                                                                    Width="49" runat="server" Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' /></asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="crowdboard-profile-picture">
                                                                    <a href='<%# Eval("DirectoryName","{0}") %>'>
                                                                        <img id="imgBoard" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' /></a>
                                                                </div>
                                                                <div class="crowdboard-mini-console">
                                                                    <div class="crowdboard-measure">
                                                                        <table border="1">
                                                                            <tr valign="top">
                                                                                <td style="width: 10%;">
                                                                                    <div style="margin-left: 3px;">
                                                                                        <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                                            TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="96px"
                                                                                            Style="margin-top: 4px;" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                                            ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                                            CssClass="thermometerSlider" BackColor="Transparent">
                                                                                        </telerik:RadSlider>
                                                                                        <%-- <div class="crowdboard-status-bar-position">
                                                                                    </div>--%>
                                                                                    </div>
                                                                                </td>
                                                                                <td style="width: 90%;">
                                                                                    <div class="crowdboard-measure-text" style="margin-left: 0px;">
                                                                                        <%--<div class="crowdboard-measure-level">
                                                                                        Level</br><span><%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span></div>--%>
                                                                                        <div class="crowdboard-measure-max-left">
                                                                                            Max Left</br><span><asp:Label ID="lblAmountLeft" runat="server" Text='<%#GetAmount(Eval("Amountleft"),Eval("BankLocation"))%>'></asp:Label></span>
                                                                                        </div>
                                                                                        <div class="crowdboard-measure-boarders-in">
                                                                                            Boarders In</br><span><asp:Label ID="lblBoardersIn" runat="server" Text='<%#Eval("BoarderInCount") %>'></asp:Label></span></div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <%--  <div class="crowdboard-status-bar"></div>--%>
                                                                    </div>
                                                                    <a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                                        <img src="WebContent/images/comment.png" /><div class="comment-number">
                                                                            <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label></div>
                                                                        <a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                                            <img src="WebContent/images/recommend.png" /><div class="recommend-number">
                                                                                (2)</div>
                                                                        </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                                            <img src="WebContent/images/boost.png" /><div class="boost-number">
                                                                                (3)</div>
                                                                        </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                                            <img src="WebContent/images/watchwbg.png" /><div class="watch-number">
                                                                                <asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label></div>
                                                                        </a>
                                                                        <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" />
                                                                </div>
                                                                <div class="crowdboard-text">
                                                                    <div class="crowdboard-line-name">
                                                                        Name: <span>
                                                                            <asp:Label ID="lblCrowdBoard" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label></span></div>
                                                                    <div class="crowdboard-line-location">
                                                                        Location: <span>
                                                                            <asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location") %>'></asp:Label></span></div>
                                                                    <div class="crowdboard-line-location">
                                                                        Type: <span>
                                                                            <asp:Label ID="lblOffers" runat="server" Text='<%#Eval("invType") %>'></asp:Label></span></div>
                                                                    <div class="crowdboard-line-seeking">
                                                                        Seeking: <span>
                                                                            <asp:Label ID="lblSeeking" runat="server" Text='<%#GetAmount(Eval("Seeking"),Eval("BankLocation"))%>'></asp:Label></span></div>
                                                                    <div class="crowdboard-line-DA">
                                                                        District: <span class="district-tag"><a href="">
                                                                            <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label></a></span>
                                                                        Area: <span class="area-tag"><a href="">
                                                                            <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label></a></span></div>
                                                                    <div class="crowdboard-line-live-since">
                                                                        Live Since: <span>
                                                                            <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label></span></div>
                                                                    <div class="crowdboard-wrapper-description">
                                                                        Description:</br>
                                                                        <div class="crowdboard-description">
                                                                            <asp:Label ID="lblDescription" Font-Bold="false" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <a href='<%# Eval("DirectoryName","{0}") %>'>
                                                                    <asp:Button ID="viewbutton" class="view-crowdboard-button" Text="View CrowdBoard"
                                                                        PostBackUrl='<%# Eval("DirectoryName","~/{0}") %>' runat="Server"></asp:Button></a>
                                                            </div>
                                                        </asp:LinkButton>
                                                    </div>
                                                </itemtemplate>
                                                            </asp:repeater>
                                                        </div>
                                                    </div>
                                                    <div id="recentInvestedTr" runat="server" class="newsfeed-message standard-newsfeed"
                                                        style="width: 33%;">
                                                        <div class="newsfeed-comment">
                                                            <div class="newsfeed-image">
                                                                <a href="">
                                                                    <asp:image id="investedProfileImage" runat="server" alternatetext="No Image" /></a></div>
                                                            <div class="message-attribution" style="font-size: 14px;">
                                                                <span class="boarder-message-name">
                                                                    <asp:label id="investedUserNameLabel" runat="server"></asp:label>
                                                                    &nbsp;<asp:hyperlink id="investedHyperLink" runat="server"></asp:hyperlink>
                                                                    <asp:label id="investmentLabel" runat="server"></asp:label>
                                                                </span>
                                                            </div>
                                                            <span class="district-tag">
                                                                <br />
                                                                <asp:hyperlink id="boardLink" runat="server" style="font-size: 12px;">
                                                                    <asp:label id="userLabel" runat="server"></asp:label>
                                                                </asp:hyperlink>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div id="recentCommentTr" runat="server" class="newsfeed-message standard-newsfeed"
                                                        style="width: 33%;">
                                                        <div class="newsfeed-comment">
                                                            <div class="newsfeed-image">
                                                                <a href="">
                                                                    <asp:image id="commentedProfileImage" runat="server" alternatetext="No Image" /></a></div>
                                                            <div class="message-attribution" style="font-size: 14px;">
                                                                <span class="boarder-message-name">
                                                                    <asp:label id="commentUserNameLabel" runat="server"></asp:label></span></div>
                                                            <span class="district-tag">
                                                                <br />
                                                                <asp:hyperlink id="commentBordNameLinkButton" runat="server" style="font-size: 12px;">
                                                                </asp:hyperlink>
                                                                <br />
                                                                <asp:label id="commentTextLabel" runat="server"></asp:label>&nbsp;&nbsp;
                                                                <asp:label id="lblCommentDate" runat="server"></asp:label></span>
                                                        </div>
                                                    </div>
                                                    <div id="watchBoardTr" runat="server" class="newsfeed-message standard-newsfeed"
                                                        style="width: 33%;">
                                                        <div class="newsfeed-comment">
                                                            <div class="newsfeed-image">
                                                                <a href="">
                                                                    <asp:image id="watchProfileImage" runat="server" alternatetext="No Image" /></a></div>
                                                            <div class="message-attribution" style="font-size: 14px;">
                                                                <span class="boarder-message-name">
                                                                    <asp:label id="watchUserNameLabel" runat="server"></asp:label>&nbsp; just Watched
                                                                </span>
                                                            </div>
                                                            <span class="district-tag">
                                                                <br />
                                                                <asp:hyperlink id="watchBoradNameHyperLink" runat="server" style="font-size: 12px;">
                                                                </asp:hyperlink>
                                                                <br />
                                                                <asp:label id="watchDateLabel" runat="server"></asp:label></span>
                                                        </div>
                                                    </div>
                                                    <div id="recentPostTr" runat="server" class="newsfeed-message standard-newsfeed"
                                                        style="width: 33%;">
                                                        <asp:repeater id="latestPostRepeater" runat="server" datasourceid="sdRecentPost">
                                                            <itemtemplate>
                                                <div class="newsfeed-comment">
                                                    <div class="newsfeed-image">
                                                        <asp:Image ID="boardPic" runat="server" AlternateText="No Image" ImageUrl='<%# isAvail(Eval("UserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></div>
                                                    <div class="message-attribution" style="font-size: 14px;">
                                                        <span class="boarder-message-name">
                                                            <%# Container.DataItem("UserName")%>
                                                            Posted </span>
                                                    </div>
                                                    <span class="district-tag">
                                                        <%# Container.DataItem("Text")%><br />
                                                        <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                                        <br />
                                                        <asp:Label ID="lblCommentsCountPost" runat="server" Text='<%#Eval("CommentsCount").ToString() + " Comments " %>'
                                                            CssClass="LabelBrownSmall"></asp:Label>
                                                        <asp:Label ID="lblRecommendsCountPost" runat="server" Text='<%#Eval("RecommendCount").ToString() + " Recommends " %>'
                                                            CssClass="LabelBrownSmall"></asp:Label></span>
                                                </div>
                                            </itemtemplate>
                                                        </asp:repeater>
                                                    </div>
                                                    <%--<div class="newsfeed-message standard-newsfeed">
                                        <div class="newsfeed-comment">
                                            <div class="newsfeed-image">
                                                <a href="">
                                                    <img src="images/dkpicture.png" /></a></div>
                                            <div class="message-attribution">
                                                <span class="boarder-message-name">Danny Kelman</span></div>
                                            just recommended <span class="district-tag"><a href='#'>@mkcrowdboard</a></span>
                                        </div>
                                    </div>--%>
                                                </div>
                                            </div>
                                            <%-- </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvBoardFolio" runat="server">--%>
                                            <div id="BoardFolioDiv" style="display: none;">
                                                <span class="profile-name">
                                                    <asp:label id="boardFolioLabelActivity" runat="server"></asp:label></span>
                                                <div style="margin-top: 15px; margin-left: 15px;">
                                                    <asp:datalist id="boardsInvestedDataList" runat="server" repeatcolumns="3" repeatdirection="Horizontal"
                                                        repeatlayout="Table" cellpadding="15">
                                                        <itemtemplate>
                                            <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                            <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("TotalOffer") %>' />
                                            <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                            <asp:HiddenField ID="hdnVisibilityType" runat="server" Value='<%#Eval("VisibilityType") %>' />
                                            <div class="crowdboard-container group">
                                                <div class="crowdboard-video">
                                                    <a href="">
                                                        <div id="boardInvertCoverDiv" runat="server">
                                                            <div class="play-button">
                                                                <asp:ImageButton ID="ibtnPlayInvestor" ImageUrl="~/WebContent/images/playbutton.png"
                                                                    runat="server" Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                                    Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                                <div class="crowdboard-profile-picture">
                                                    <a href="<%# Eval("DirectoryName","/{0}") %>">
                                                        <img id="img2" runat="server" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' />
                                                    </a>
                                                </div>
                                                <div class="crowdboard-mini-console">
                                                    <div class="crowdboard-measure">
                                                        <table>
                                                            <tr valign="top">
                                                                <td>
                                                                    <div style="margin-left: 3px;">
                                                                        <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                            TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                                                                            Height="90px" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                            ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                            CssClass="thermometerSlider" BackColor="Transparent">
                                                                        </telerik:RadSlider>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="crowdboard-measure-text" style="margin-top: 0px; margin-left: 5px;">
                                                                        <div class="crowdboard-measure-level">
                                                                            Level
                                                                            <br>
                                                                            <span>
                                                                                <%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span>
                                                                        </div>
                                                                        <div class="crowdboard-measure-max-left">
                                                                            Max Left
                                                                            <br>
                                                                            <span>
                                                                                <%#GetAmount(Eval("AmountRemaining"),Eval("BankLocation")) %></span>
                                                                        </div>
                                                                        <div class="crowdboard-measure-boarders-in">
                                                                            Boarders In
                                                                            <br>
                                                                            <span>
                                                                                <%#Eval("Investors") %></span>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                        <img src="WebContent/theme/images/comment.png">
                                                        <div class="comment-number">
                                                            <%#Eval("Comments") %></div>
                                                    </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                        <img src="WebContent/theme/images/recommend.png">
                                                        <div class="recommend-number">
                                                            (2)</div>
                                                    </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                        <img src="WebContent/theme/images/boost.png">
                                                        <div class="boost-number">
                                                            (3)</div>
                                                    </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                        <img src="WebContent/theme/images/watchwbg.png">
                                                        <div class="watch-number">
                                                            <%#Eval("Watches") %></div>
                                                    </a>
                                                    <input id="invest-button" type="button" value="INVEST!" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')">
                                                </div>
                                                <div class="crowdboard-text">
                                                    <div class="crowdboard-line-name">
                                                        Name: <a href="<%# Eval("DirectoryName","/{0}") %> "><span style="color: #788586;">
                                                            <%#Eval("BoardName") %></span></a>
                                                    </div>
                                                    <div class="crowdboard-line-location">
                                                        Location: <span>
                                                            <%#Eval("Location") %></span>
                                                    </div>
                                                    <div class="crowdboard-line-seeking">
                                                        Seeking: <span>
                                                            <%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %></span>
                                                    </div>
                                                    <div class="crowdboard-line-DA">
                                                        District: <span class="district-tag"><a href="">
                                                            <%#Eval("District") %></a> </span>Area: <span class="area-tag"><a href="">
                                                                <%#Eval("AreaName") %></a> </span>
                                                    </div>
                                                    <div class="crowdboard-line-live-since">
                                                        Live Since: <span>
                                                            <%#Eval("DateActivated") %></span>
                                                    </div>
                                                    <div class="crowdboard-wrapper-description">
                                                        Description:
                                                        <br>
                                                        <div class="crowdboard-description">
                                                            <%#Eval("Description") %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:Button ID="viewbutton" class="view-crowdboard-button" Text="View CrowdBoard"
                                                    PostBackUrl='<%# Eval("DirectoryName","~/{0}") %>' runat="Server"></asp:Button>
                                            </div>
                                            <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()  %>'>
                                                <div style="text-align: right;">
                                                    <a id="popupBoxCloseYoutube1" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
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
                                        </itemtemplate>
                                                    </asp:datalist>
                                                </div>
                                            </div>
                                            <%--  </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvDistrict" runat="server">--%>
                                            <div id="DistrictDiv" style="display: none;">
                                                <span class="profile-name">
                                                    <asp:label id="districtLabelActivity" runat="server"></asp:label></span>
                                                <asp:datalist id="districtsRepeater" runat="server" datasourceid="sdUsersDistricts"
                                                    repeatdirection="Vertical" repeatlayout="Table" repeatcolumns="6">
                                                    <itemtemplate>
                                        <div class="size1of6">
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Eval("DistrictName","~/Search.aspx?District={0}")%>'>
                                                <div class="district">
                                                    <asp:Image ID="areaPic" ToolTip='<%# Eval("DistrictName")%>' runat="server" ImageUrl='<%# isAvail(Eval("DistrictID", "Upload/DistrictPics/{0}.jpg")) %>' />
                                                    <span class="DAcontent">
                                                        <asp:Label ID="level3" runat="server" Text='<%# Container.DataItem("DistrictName")%>'></asp:Label></span>
                                            </asp:HyperLink>
                                        </div>
                                       
                  
                    </itemtemplate>
                                                </asp:datalist>
                                            </div>
                                            <%-- </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvArea" runat="server">--%>
                                            <div id="AreaDiv" style="display: none;">
                                                <span class="profile-name">
                                                    <asp:label id="areaLabelActivity" runat="server"></asp:label></span>
                                                <div class="container">
                                                    <asp:datalist id="userAreasRepeater" runat="server" datasourceid="sdUserAreas" repeatdirection="Vertical"
                                                        repeatlayout="Table" repeatcolumns="6">
                                                        <itemtemplate>
                                            <div class="size1of6">
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#Eval("AreaName","~/Search.aspx?Area={0}")%>'>
                                                    <div class="area">
                                                        <asp:Image ID="areaPic" ToolTip='<%# Eval("AreaName")%>' runat="server" ImageUrl='<%# isAvail(Eval("AreaID", "~/Upload/AreasPics/{0}.jpg")) %>' />
                                                        <span class="DAcontent">
                                                            <%# Eval("AreaName")%></span>
                                                </asp:HyperLink>
                                            </div>
                   
                    </itemtemplate>
                                                    </asp:datalist>
                                                </div>
                                            </div>
                                            <%--  </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvCrowdboarders" runat="server">--%>
                                            <div id="DivCrowdboarders" style="display: none;">
                                                <span class="profile-name">
                                                    <asp:label id="crowdboarderseLabelActivity" runat="server"></asp:label></span>
                                                <p>
                                                    &nbsp;</p>
                                                <asp:repeater id="crowdboardCommandRepeater" runat="server">
                                                    <itemtemplate>
                                        <asp:HiddenField runat="server" ID="hdnDirectoryName" Value='<%# Container.DataItem("DirectoryName")%>' />
                                        <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("Seeking") %>' />
                                        <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                        <asp:HiddenField ID="hdnBoardName" runat="server" Value='<%#Eval("BoardName") %>' />
                                        <div class="crowdboard-container group">
                                            <div class="crowdboard-video">
                                                <a href="#">
                                                    <div id="covPicLineup" runat="server">
                                                        <div class="play-button">
                                                            <asp:ImageButton ID="ibtnPlay" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                                Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                                Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="crowdboard-profile-picture">
                                                <a href="<%# Eval("DirectoryName","/{0}") %>">
                                                    <img id="img1" runat="server" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' />
                                                </a>
                                            </div>
                                            <div class="crowdboard-mini-console">
                                                <div class="crowdboard-measure">
                                                    <table>
                                                        <tr valign="top">
                                                            <td>
                                                                <div style="margin-left: 3px;">
                                                                    <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                        TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                                                                        Height="90px" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                        ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                        CssClass="thermometerSlider" BackColor="Transparent">
                                                                    </telerik:RadSlider>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="crowdboard-measure-text" style="margin-top: 0px; margin-left: 5px;">
                                                                    <div class="crowdboard-measure-level">
                                                                        Level
                                                                        <br>
                                                                        <span>
                                                                            <%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span>
                                                                    </div>
                                                                    <div class="crowdboard-measure-max-left">
                                                                        Max Left
                                                                        <br>
                                                                        <span>
                                                                            <%#GetAmount(Eval("Amountleft"),Eval("BankLocation"))%></span>
                                                                    </div>
                                                                    <div class="crowdboard-measure-boarders-in">
                                                                        Boarders In
                                                                        <br>
                                                                        <span>
                                                                            <%#Eval("Investors") %></span>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/comment.png">
                                                    <div class="comment-number">
                                                        <%#Eval("Comments") %></div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/recommend.png">
                                                    <div class="recommend-number">
                                                        (2)</div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/boost.png">
                                                    <div class="boost-number">
                                                        (3)</div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/watchwbg.png">
                                                    <div class="watch-number">
                                                        <%#Eval("Watches") %></div>
                                                </a>
                                                <input id="invest-button" type="button" value="INVEST!" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')">
                                            </div>
                                            <div class="crowdboard-text">
                                                <div class="crowdboard-line-name">
                                                    Name: <span><a href="<%# Eval("DirectoryName","/{0}") %>" style="color: #788586;">
                                                        <%#Eval("BoardName") %></a></span>
                                                </div>
                                                <div class="crowdboard-line-location">
                                                    Location: <span>
                                                        <%#Eval("Location") %></span>
                                                </div>
                                                <div class="crowdboard-line-seeking">
                                                    Seeking: <span>
                                                        <%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %></span>
                                                </div>
                                                <div class="crowdboard-line-DA">
                                                    District: <span class="district-tag"><a href="">
                                                        <%#Eval("District") %></a> </span>Area: <span class="area-tag"><a href="">
                                                            <%#Eval("AreaName") %></a> </span>
                                                </div>
                                                <div class="crowdboard-line-live-since">
                                                    Live Since: <span>
                                                        <%#Eval("DateActivated") %></span>
                                                </div>
                                                <div class="crowdboard-wrapper-description">
                                                    Description:
                                                    <br>
                                                    <div class="crowdboard-description">
                                                        <%#Eval("Description") %>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:Button ID="viewbutton" class="view-crowdboard-button" Text="View CrowdBoard"
                                                PostBackUrl='<%# Eval("DirectoryName","~/{0}") %>' runat="Server"></asp:Button>
                                        </div>
                                        <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()  %>'>
                                            <div style="text-align: right;">
                                                <a id="popupBoxCloseYoutube1" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
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
                                    </itemtemplate>
                                                </asp:repeater>
                                            </div>
                                            <%--  </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvBoarderLineup" runat="server">--%>
                                            <div id="BoarderLineupDiv" style="display: block;">
                                                <span class="profile-name">
                                                    <asp:label id="boarderLineupLabelActivity" runat="server"></asp:label></span>
                                                <p>
                                                    <asp:label id="lblMessageAddBoarder" runat="server"></asp:label></p>
                                                <div id="containerCrowdNewsFull" style="width: 100%;">
                                                    <asp:datalist id="boardersRepeater" runat="server" datasourceid="sdBoardersLineUp"
                                                        repeatdirection="Horizontal">
                                                        <itemtemplate>
                                            <div class="itemAllNewsFull">
                                                <div style="width: 360px;">
                                                    <asp:HiddenField ID="hdnisFriend" runat="server" Value='<%# Container.DataItem("isFriend")%>' />
                                                    <div class="boarder-lineup" style="width: 315px; margin-left: 5px; margin-right: 0px;">
                                                        <a href='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                                            <img src='<%# isAvail(Eval("UserName", "~/Upload/ProfilePics/{0}.jpg")) %>'></a>
                                                        <div class="lineup-content">
                                                            <div class="boarder-name">
                                                                <a href='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'
                                                                    style="color: #788586;">
                                                                    <%# Eval("Name")%></a></div>
                                                            <div class="boarder-location">
                                                                Location: <span>
                                                                    <%# Eval("Location")%></span>
                                                            </div>
                                                            <div class="boarder-profession">
                                                                Profession: <span>
                                                                    <%# Eval("Profession")%></span>
                                                            </div>
                                                            <div class="boarder-districts">
                                                                <p>
                                                                    &nbsp;</p>
                                                                Districts: <span style="word-wrap: break-word;">
                                                                    <%# Eval("UserDistricts")%></span>
                                                            </div>
                                                            <div class="add-boarder">
                                                                <asp:Label ID="lblPendingStatus" runat="server" Text="Pending" Visible='<%# IIf(Eval("isFriend")=0,true,false) %>'
                                                                    Style="color: #75b4c6; padding: 10px; vertical-align: bottom; padding: 5px 11px 6px;
                                                                    position: absolute; right: 5px; bottom: 6px;"></asp:Label>
                                                                <asp:Button ID="btnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                                    Text="Add Boarder" CssClass="add-boarder-button" Visible='<%# IIf(Eval("isFriend")=3 or Eval("isFriend")=2,true,false) %>' />
                                                                <asp:Button ID="btnRemoveBoarder" runat="server" CommandName="IRemoveBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                                    Text="Remove Boarder" CssClass="add-boarder-button" Visible='<%# IIf(Eval("isFriend")=1,true,false) %>'
                                                                    OnClientClick="return confirm('Are you sure ?');" />&nbsp;
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </itemtemplate>
                                                    </asp:datalist>
                                                </div>
                                            </div>
                                            <%-- </telerik:RadPageView>
                        </telerik:RadMultiPage>--%>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script src='<%=ResolveClientUrl( "~/js/jquery-1.7.2.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/jquery-1.4.1-vsdoc.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/jquery-1.4.1.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/masonry.pkgd.min.js")%>' type="text/javascript"></script>
    <%-- <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            loadNew();
            $("#BoarderLineupDiv").fadeOut();
        });

        function loadNew() {
            var $container = $('#containerCrowdNewsFull');

            $container.masonry({
                columnWidth: 320,
                itemSelector: '.itemAllNewsFull'
            });
        }     

    </script>
    <div>
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
            </script>
        </telerik:RadScriptBlock>
        <asp:sqldatasource id="sdUserInformation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT userid,UserName,ISNULL(FirstName,'')as FirstName,isnull(Name,'') as Name,SSN,DOB,LastName,city,State,SocialSecurityNumber,Job,AboutMe,MyDreams,Passions,Address,DateRegistered,BoardInvestedIn,AmountInvestedIn,crowdboards,ActiveCrowdboards,ClosedCrowdboards,NetwordSize,FundedCrowdboards,RaiseTotal,MyDistricts,PendingRequestCount,MessageCount,BackgroundImageStyle,PossessionCount,BoardsWatching,WebSite,Skills,MyAreas FROM vwUserInfo Where UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardersLineUp" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand=" Select *, isnull(userFriendStatus,3) as isFriend from ( SELECT Userid,username,isnull(FirstName,'')+' ' +ISNULL(LastName,'') as Name,friendStatus,Location,Profession,UserDistricts ,(SELECT top 1 [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=Userid) or (UserID1=Userid and UserID2=@UserID1)) as userFriendStatus from dbo.f_GetBoardersList(@UserID)where friendStatus =1) main"
            deletecommand="DELETE FROM Boarders WHERE (userid1=@UserID1 and UserId2=@UserID2) OR (userid1=@UserID2 and UserId2=@UserID1)">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:SessionParameter Name="UserID1" SessionField="userID" />
            </selectparameters>
            <deleteparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUsersDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT UD.UserID,UD.DistrictID,D.DistrictName  FROM UserDistricts UD INNER JOIN Districts D ON UD.DistrictID =D.districtID  WHERE UD.UserID=@UserID order by D.SortOrder">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.YoutubeVideoUrl,V.BoardID,V.Boardname,BI.UserID as InvestorID,V.Investors,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.invType,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,case when V.BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(V.RaisedTotal as dec(10,0)),1) As RaisedTotalText,V.RaisedTotal,V.TotalOffer,V.NoOfBoardLevels,V.Offer,V.AmountRemaining ,V.VisibilityType,V.OwnerType,V.BankLocation FROM vwBoardInfo V INNER JOIN BoardInvestors BI ON V.BoardID =BI.BoardID AND BI.DateInvested IS NOT NULL WHERE BI.UserID=@UserID ORDER BY BI.DateInvested">
            <selectparameters>
                <asp:SessionParameter Name="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardFolio" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select * from (SELECT BI.BoardID,B.BoardName,BI.DateInvested as ActivityDate,B.DirectoryName,(ISNULL(B.BoardName,'')+ ', '+ ISNULL(U.userName,'')) as boardOwner FROM Boards B INNER JOIN BoardInvestors BI ON B.BoardID=BI.BoardID INNER JOIN Users U ON B.UserID=U.UserID WHERE BI.AmountInvested IS NOT NULL AND BI.UserID=@UserID and B.Status=1 union SELECT BI.BoardID,B.BoardName,BI.WatchDate as ActivityDate,B.DirectoryName,(ISNULL(B.BoardName,'')+ ', '+ ISNULL(U.userName,'')) as boardOwner FROM BoardInvestors BI INNER JOIN Boards B ON BI.BoardID =B.BoardID  INNER JOIN USERS U ON B.userID=U.userID where BI.UserID=@UserID and B.status=1 and BI.WatchDate is not null and isnull(PrivateWatch,0)=0 ) main order by ActivityDate desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdActiveBoards" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT BoardID,BoardName,DirectoryName,(ISNULL(B.BoardName,'')+ ', '+ ISNULL(U.userName,'')) as boardOwner FROM Boards B INNER JOIN Users U ON B.UserID=U.UserID  WHERE B.status=1 AND B.UserID=@userID">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT UA.UserID,UA.AreaID,A.AreaName  FROM UserAreas UA INNER JOIN Areas A ON UA.AreaID=A.areaID  WHERE UA.UserID=@UserID order by A.SortOrder">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As Users,CASE WHEN (UserID1=@UserID OR UserID2=@UserID) And Status=1 then 1 Else 0 End as Isfriend,CASE WHEN (UserID1=@UserID OR UserID2=@UserID) And Status=0 then 1 Else 0 End as IsPending,CASE WHEN (UserID1=@UserID OR UserID2=@UserID) And Status=2 then 1 Else 0 End as IsRejected,UserID1,UserID2,UserID1UserName,UserID2UserName,Status,DateRequested,DateAccepted FROM vwBoardersDetail Where UserID1=@UserID OR UserID2=@UserID"
            insertcommand="INSERT INTO Boarders(UserID1,UserID2,Status,DateRequested) VALUES(@UserID1,@UserID2,0,@DateRequested)"
            updatecommand="UPDATE Boarders SET Status=0,DateRequested=getdate(),DateRejected=null,userID1=@UserID1,UserID2=@UserID2 WHERE (UserID1=@UserID1 AND UserID2=@UserID2) OR (UserID1=@UserID2 AND UserID2=@UserID1)">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="UserID1" Type="Int32" />
                <asp:Parameter Name="UserID2" Type="Int32" />
                <asp:Parameter Name="Status" Type="Boolean" />
                <asp:Parameter Name="DateRequested" Type="DateTime" />
            </insertparameters>
            <updateparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardsInvestedByUser" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT TOP 1 U.UserID,U.UserName,BI.BoardID,BI.AmountInvested,BI.DateInvested,B.BoardName,B.DirectoryName FROM users U INNER JOIN BoardInvestors BI ON U.UserID=BI.UserID AND BI.AmountInvested IS NOT NULL INNER JOIN Boards B ON BI.BoardID=B.BoardID WHERE U.UserID=@UserID ORDER BY BI.DateInvested DESC">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdMessages" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO Messages(FromUser,ToUser,DateSent,Text,Unread) Values(@FromUser,@ToUser,@DateSent,@Text,@Unread)">
            <insertparameters>
                <asp:Parameter Name="FromUser" Type="Int32" />
                <asp:Parameter Name="ToUser" Type="Int32" />
                <asp:Parameter Name="DateSent" Type="DateTime" />
                <asp:Parameter Name="Text" Type="String" />
                <asp:Parameter Name="Unread" Type="Boolean" />
            </insertparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRecentPost" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select Top 1 U.UserID,U.Text,U.PostID,US.UserName,U.DatePosted,(select COUNT(*) from UserPostReplies where PostID=U.PostID and Comment Is Not Null) as CommentsCount,(select COUNT(*) from UserPostReplies where PostID=U.PostID and Recommend=1) as RecommendCount from UserPosts U INNER JOIN Users US ON U.UserID=US.UserID where U.userID=@userID order by DatePosted desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRcentlyAddedFriend" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select top 1 CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As Friends from vwBoardersDetail where (UserID1=@UserID or UserID2=@UserID) and Status=1 order by DateAccepted desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetUserId" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select UserID from Users Where UserName=@UserName">
            <selectparameters>
                <asp:QueryStringParameter Name="UserName" QueryStringField="user" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsCreatedBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT top 1 CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) >145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Watches,V.Comments,V.YoutubeVideoUrl,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer As Seeking,V.BankLocation,V.Offer,V.invType,V.RaisedTotal,V.AmountRemaining as Amountleft,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount  FROM vwBoardInfo   V   INNER JOIN Users U ON v.UserID =U.UserID WHERE V.UserID =@UserID and  V.Status=1 order by V.BoardID Desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsComment" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select top 1 BC.Text,U.userName,BC.CommentDate,B.BoardName,B.DirectoryName from BoardComments BC INNER JOIN Users U ON BC.UserID=U.UserID inner join Boards B on BC.BoardID=B.BoardID where BC.userID=@UserID order by BC.CommentDate desc ">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsInvested" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="Select top 1 BI.BoardID,isnull(BI.AmountInvested,0) As AmountInvested,isnull(U.BankLocation,'UK')BankLocation, BI.DateInvested,B.BoardName,B.DirectoryName,U.UserName  from boardinvestors BI inner join Users U on BI.UserID =U.UserID  inner join Boards B on BI.BoardID =B.BoardID where BI.UserID=@UserID and BI.DateInvested is not null order by BI.DateInvested desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsWatched" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="Select top 1  BI.BoardID,BI.WatchDate,B.BoardName,B.DirectoryName,U.UserName  from boardinvestors BI inner join Users U on BI.UserID =U.UserID inner join Boards B on BI.BoardID =B.BoardID where BI.UserID=@UserID and BI.WatchDate is not null order by BI.WatchDate desc">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCheckRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
            <selectparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsUserEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT Email as userEmail from Users where UserID=@ToUser">
            <selectparameters>
                <asp:Parameter Name="ToUser" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAllBoards" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.InvType,V.BoardLevel,V.UserID,V.BoardID,V.YoutubeVideoUrl,V.Boardname,U.UserName,V.TotalOffer As Seeking,V.RaisedTotal,V.AmountRemaining as Amountleft,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Investors,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,isnull(U.BankLocation,'US')as BankLocation,V.TotalOffer,V.Status,V.Offer,BS.English As StatusText,CAST(ROUND(isnull(V.RaisedTotal,0), 0) AS int) as TotalInvested, (SELECT count(*) FROM (SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union  SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount   FROM vwBoardInfo V  INNER JOIN Users U ON v.UserID =U.UserID INNER JOIN BoardStatus BS ON V.Status=BS.Value WHERE V.UserID=@UserID and V.Status =1">
            <selectparameters>
                <asp:SessionParameter Name="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <%-- <asp:SqlDataSource ID="sdBoarderStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID1,UserID2,UserID1UserName,UserID2UserName,Status,DateRequested,DateAccepted FROM vwBoardersDetail Where (UserID1=@UserID1 and UserID2=@UserID2) or (UserID2=@UserID1 and UserID1=@UserID2)">
        <SelectParameters>
            <asp:Parameter Name="@UserID1" />
            <asp:Parameter Name="@UserID2" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    </div>
</asp:content>
