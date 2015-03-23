<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CrowdNews.aspx.vb" MasterPageFile="~/MasterPage/Site.Master"
    Inherits="CrowdBoardsApp.CrowdNews" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>CrowdNews</title>
    <link href="WebContent/Theme/styles/crowdnews.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .itemAllNewsFull
        {
            width: 15%;
        }
        .itemAllNewsFull.w2
        {
            width: 50%;
        }
        
        .left-column
        {
            float: left;
            height: 515px;
            padding: 1%;
            width: 22%;
            margin-top: 50px;
        }
        .right-column
        {
            float: left;
            height: 475px;
            overflow: hidden;
            padding-bottom: 18px;
            padding-left: 1%;
            width: 77%;
            margin-top: 50px;
            overflow-y: scroll;
            overflow-x: hidden;
        }
    </style>
    <style type="text/css">
        .popup_box_allCrowdNews
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 550px;
            width: 440px;
            left: 320px;
            top: 50px;
            z-index: 100; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        /* popup_box DIV-Styles*/
        .popup_box
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 450px;
            width: 620px;
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
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        
        .popup_box_boost
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 200px;
            width: 440px;
            left: 300px;
            top: 150px;
            z-index: 200; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            padding: 15px;
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
            background-color: #ffffff;
            border: 2px solid #cacdce;
        }
        
        /* This is for the positioning of the Close Link */
        #popupBoxClose
        {
            font-size: 20px;
            line-height: 15px;
            right: 5px;
            top: 5px;
            position: absolute;
            color: #6fa5e2;
            font-weight: 500;
        }
        
        .RadSlider_Vista .rslItem, .RadSlider_Vista .rslLargeTick span
        {
            color: #ffffff;
        }
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
        }
        #fileAttachRadAsyncUpload. RadUpload_Default .ruButton
        {
            /*it is an example URL*/
            background-color: url("Images/ruSprite.png");
        }
    </style>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function clickRadUploadbtn() {
            $telerik.$(".ruFileInput").click();
        }

        function fileAttach(sender, args) {
            document.getElementById("<%= fileAttachButton.ClientID %>").click();

        }
    
    </script>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <div class="col2" style="width: 99%;">
        <div class="title" style="float: none;">
            Crowd News <span>
                <asp:label id="searchValueLabel" runat="server"></asp:label>
            </span><span class="population-text district-text">
                <asp:linkbutton id="viewAllPostLinkButton" runat="server" text="View All Posts">
                </asp:linkbutton>
            </span>
        </div>
        <table style="width: 100%; display: table;">
            <tr>
              
                    <td style="width: 20%; padding: 2px;">
                        <div class="left-column" style="width:100%;">
                            <textarea id="txtPost" runat="server" placeholder="Write a post to the Crowd News..."
                                rows="5" style="width: 100%; border: 1px solid #75b4c6;"></textarea><br />
                            <table width="100%" border="0">
                                <tr>
                                    <td colspan="3">
                                        <asp:label id="messageLabel" runat="server" text="" visible="false" width="100%"
                                            font-bold="true" style="margin-top: 10px;"></asp:label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 40%;">
                                        <asp:button id="fileAttachButton" runat="server" text="Upload" style="display: none;" />
                                        <%-- </td>
                    <td style="<%--text-align: right; width: 30%; vertical-align: bottom;--%>
                                        <telerik:RadAsyncUpload ID="fileAttachRadAsyncUpload" runat="server" MultipleFileSelection="Disabled"
                                            HideFileInput="true" OnClientFilesUploaded="fileAttach" HttpHandlerUrl="~/CustomHandler.ashx"
                                            Font-Bold="true" Width="100%" Skin="Web20" Style="display: none;">
                                            <Localization Select="Add File" />
                                        </telerik:RadAsyncUpload>
                                    </td>
                                    <td style="vertical-align: top; text-align: right;">
                                        <input type="button" id="clickRadAsyncUpload" value="Add File" onclick="clickRadUploadbtn();"
                                            class="attach-button" style="float: right;" />
                                    </td>
                                    <td>
                                        <asp:button id="postRadButton" runat="server" text="Post" cssclass="post-button"
                                            style="float: right;" />
                                    </td>
                                </tr>
                            </table>
                            <div class="mydistricts" style="width: 95%;">
                                <span class="title" style="font-size: 22px; float: none;">My Districts</span><span>
                                    &nbsp;Word on the Street</span>
                                <div style="overflow-x: hidden; overflow-y: scroll; height: 100px;">
                                    <asp:repeater id="districtsRepeater" runat="server" datasourceid="sdUsersDistricts">
                                        <itemtemplate>
                            <div class="district-text">
                                <asp:LinkButton ID="districtPost" runat="server" Text='<%# Container.DataItem("DistrictName")%>'
                                    CommandName="districtFilter" CommandArgument='<%# Container.DataItem("DistrictName")%>'></asp:LinkButton>
                            </div>
                        </itemtemplate>
                                    </asp:repeater>
                                </div>
                            </div>
                            <div class="myareas" style="width: 95%;">
                                <span class="title" style="font-size: 22px; float: none;">My Areas</span> <span>&nbsp;Incrowd
                                    News</span>
                                <div style="overflow-x: hidden; overflow-y: scroll; height: 100px;">
                                    <asp:repeater id="userAreasRepeater" runat="server" datasourceid="sdUserAreas">
                                        <itemtemplate>
                            <div class="area-text">
                                <asp:LinkButton ID="areaPost" runat="server" Text='<%# Container.DataItem("AreaName")%>'
                                    CommandName="areaFilter" CommandArgument='<%# Container.DataItem("AreaName")%>'></asp:LinkButton>
                            </div>
                        </itemtemplate>
                                    </asp:repeater>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td style="width: 80%; padding: 2px;">
                        <div class="right-column" style="width:100%;">
                            <div id="containerCrowdNewsFull" style="width: 100%;">
                                <asp:datalist id="crowdNewsAllDataListFull" runat="server" repeatdirection="Horizontal"
                                    repeatlayout="Table">
                                    <itemtemplate>
                        <div class="itemAllNewsFull">
                            <div style="width: 360px;">
                                <div class="crowdnews-post">
                                    <asp:HiddenField ID="hdnPostIDFull" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                    <div class="posted-material">
                                        <asp:HyperLink ID="userLinkFull1" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <asp:Image ID="boarderPicFull1" runat="server" Height="60px" Width="60px" Style="margin-top: 2px;"
                                                ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                        <table>
                                            <tr>
                                                <td>
                                                    <div class="poster-options">
                                                        <a class="comment-img" href="#" onclick='<%# "return loadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                            <img src="WebContent/theme/images/comment.png">
                                                            <div class="comment-number">
                                                                (<%# Container.DataItem("CommentCount")%>)</div>
                                                        </a>
                                                        <asp:Image ID="recommendImg" runat="server" ImageUrl="WebContent/theme/images/recommend.png"
                                                            Style="cursor: pointer;" />
                                                        <div class="recommend-number">
                                                            <asp:LinkButton ID="lbtnRecommendsNewsAllFull" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                Style="text-decoration: none; font-size: 7px;" ForeColor="White" CommandName="IRecommend"
                                                                CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                            </asp:LinkButton>(<asp:Label ID="lblRecommendsCount" runat="server" ForeColor="White"
                                                                Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>)
                                                        </div>
                                                        <a class="boost-img" href="#" onclick='<%# "return loadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                            <img src="WebContent/theme/images/boost.png">
                                                            <div class="boost-number">
                                                                (<%# Container.DataItem("BoostCount")%>)</div>
                                                        </a>
                                                    </div>
                                                    <div class="poster-name">
                                                        <%# Container.DataItem("FriendUserName")%>
                                                        says:</div>
                                                    <div class="poster-comment">
                                                        <asp:Label ID="lblCommentFull" Style="font-size: 14px;" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="Tr1" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
                                                <td>
                                                    <asp:Image ID="Image2Full" runat="server" Height="150px" Width="150px" ImageUrl='<%# isAvail(Eval("AttachedFileName", "~/Upload/UserPostsFiles/{0}")) %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="time-stamp">
                                                        <%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %></div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div id='<%#"popup_box_Boost_AllFull" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <p>
                                                    <span style="float: left; font-size:18px;">Select where to Boost</span> <a id="boostClose"
                                                        onclick='<%# "return unloadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                        <img src="Images/btncross.png" alt='Close' style="cursor: pointer; height: 20px;
                                                            width: 20px; float: right;" /></a></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center; font-size: 16px;">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;">
                                                <div style="margin-top: 10px;">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="btnFacebookShareFull" CommandName="IBoostOnFacebook" CommandArgument='<%# Container.DataItem("PostID")%>'
                                                    AlternateText="login" ImageUrl="~/Images/fb_share.jpg" runat="server" Height="30px"
                                                    Width="150px"></asp:ImageButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="btnTwitterShareFull" CommandName="IBoostOnTwitter" CommandArgument='<%# Container.DataItem("PostID")%>'
                                                    AlternateText="login" ImageUrl="~/Images/twitter_share.jpg" runat="server" Height="30px"
                                                    Width="150px"></asp:ImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id='<%#"popup_box_postAllFull" +Eval("PostID").ToString()  %>' class="popup_box_allCrowdNews">
                                    <table width="100%">
                                        <tr>
                                            <td style="text-align: right;">
                                                <a id="popupBoxClosePostFull" onclick='<%# "return unloadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                    <img src="Images/btncross.png" alt='Close' style="cursor: pointer; height: 20px;
                                                        width: 20px;" /></a>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td>
                                                <asp:HyperLink ID="friendUserHyperLinkFull" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                    <asp:Image ID="ImageFull" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                <span class="LabelheadingBrown">
                                                    <%# Container.DataItem("FriendUserName")%>
                                                    Says:</span>
                                            </td>
                                        </tr>
                                        <tr id="attachedImageTr" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
                                            <td>
                                                <table width="100%">
                                                    <tr>
                                                        <td style="width: 10%;">
                                                        </td>
                                                        <td style="width: 80%;">
                                                            <asp:Image ID="imgAttachedImageFull" runat="server" Height="200px" Width="100%" ImageUrl='<%# isAvail(Eval("AttachedFileName", "~/Upload/UserPostsFiles/{0}")) %>' />
                                                        </td>
                                                        <td style="width: 10%;">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label3Full" runat="server" Style="font-size: 14px;" Text='<%# Eval("Text").toString()%>'> ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellpadding="2">
                                                    <tr>
                                                        <%--<td>
                                                                        <asp:LinkButton ID="lbtnRecommendsNewsAllFull" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                            Font-Size="Small" ForeColor="#75b4c6" CommandName="IRecommend" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                        </asp:LinkButton>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;<asp:LinkButton ID="lbtnBoostNewsAllFull" runat="server" Text="Boost" Font-Size="Small"
                                                                            ForeColor="#75b4c6" OnClientClick='<%# "return loadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'></asp:LinkButton>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblRecommendsNewsAllFull" runat="server" Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>
                                                                        Recommends
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblBoostNewsAllCountFull" runat="server" Text='<%# Container.DataItem("BoostCount")%>'></asp:Label>
                                                                        Boosts
                                                                    </td>--%>
                                                        <td>
                                                            <asp:Label ID="lblCommentCountFull" runat="server" Text='<%#Eval("CommentCount").ToString() + " Comments " %>'
                                                                CssClass="LabelBrownSmall"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <asp:DataList ID="singlePostRepliesDataListFull" runat="server" RepeatDirection="Vertical"
                                                    RepeatLayout="Table" RepeatColumns="1">
                                                    <ItemTemplate>
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:HyperLink ID="userLinkFull" runat="server" NavigateUrl='<%# Eval("ReplyByName", IIf(Convert.ToString(Eval("ReplyByName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                        <asp:Image ID="boarderPicFull" runat="server" Height="40px" Width="40px" ImageUrl='<%# isAvail(Eval("ReplyByName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                    <span class="LabelBrownSmall">Says </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <span style="font-size: 14px;">
                                                                        <%# Eval("Comment").ToString()%>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:radtextbox id="txtSingleCommentFull" runat="server" textmode="MultiLine"
                                                    rows="4" width="100%">
                                                </telerik:radtextbox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;">
                                                <asp:Button ID="btnSingleCommentFull" runat="server" Text="Comment" CssClass="post-button"
                                                    CommandName="IComment" CommandArgument='<%# Container.DataItem("PostID")%>' />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </itemtemplate>
                                </asp:datalist>
                            </div>
                        </div>
                    </td>
                
            </tr>
        </table>
    </div>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            loadNew();
        });

        function loadNew() {
            var containerCrowdNewsFull = $('#containerCrowdNewsFull');

            containerCrowdNewsFull.masonry({
                columnWidth: 320,
                itemSelector: '.itemAllNewsFull'
            });
        }
      

    </script>
    <script type="text/javascript">

        function loadPopupBoxPostAllFull(i) {
            $('#popup_box_postAllFull' + i).fadeIn("slow");
            return false;

        }

        function unloadPopupBoxPostAllFull(i) {

            $('#popup_box_postAllFull' + i).fadeOut("slow");

            return false;
        }

        function loadPopupBoxBoostAllFull(i) {

            $('#popup_box_Boost_AllFull' + i).fadeIn("slow");
            return false;

        }


        function unloadPopupBoxBoostAllFull(i) {

            $('#popup_box_Boost_AllFull' + i).fadeOut("slow");

            return false;
        }
        function unloadPopupBoxDistricts() {

            $('#popup_box_AddRemove').fadeOut("slow");

            return false;
        }
        function ClickRecommend(divID) {
            divID.click();
            return false;
        }

    </script>
    <script>
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
    <div>
        <asp:sqldatasource id="sdCrowdNewsFull" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,B.Status,ISnull((SELECT top 1 Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT top 1 Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from UserPosts U Left JOIN boarders b  on (b.UserID1=u.userid or b.UserID2=U.UserID) and (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) where U.UserID=@Userid or (U.UserID=B.UserID1 or U.UserID=B.UserID2) order by u.DatePosted desc">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCheckuserName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select *  from Users"></asp:sqldatasource>
        <asp:sqldatasource id="sdCheckBoardName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:sqldatasource>
        <asp:sqldatasource id="sdAllAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT areaID,AreaName FROM Areas"></asp:sqldatasource>
        <asp:sqldatasource id="sdsDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="Select DistrictID,DistrictName from Districts"></asp:sqldatasource>
        <asp:sqldatasource id="sdCommentOnPost" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Comment) VALUES(@UserID,@PostID,GETDATE(),@Comment)"
            selectcommand="Sp_BoostUserPost" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
                <asp:Parameter Name="Comment" />
            </insertparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdIRecommend" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="UserPostReplies_Recommend" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
                <asp:Parameter Name="Recommend" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdPostReplies" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Liked) VALUES(@UserID,@PostID,GetDate(),1)"
            selectcommand="SELECT UR.ReplyID,UR.UserID,UR.DateReplies,UR.Comment,(SELECT UserName FROM Users WHERE UserID=UR.UserID) as ReplyByName FROM UserPostReplies UR WHERE UR.PostID=@PostID AND UR.Comment IS NOT NULL">
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
            </insertparameters>
            <selectparameters>
                <asp:Parameter Name="PostID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdPosts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="UserPost_Insert" selectcommandtype="StoredProcedure" updatecommand="UPDATE UserPosts SET AttachedFileName=@AttachedFileName WHERE PostID=@PostID">
            <selectparameters>
                <asp:Parameter Name="Text" />
                <asp:Parameter Name="UserID" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="PostID" />
                <asp:Parameter Name="AttachedFileName" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct A.areaID,UA.UserID,A.AreaName,A.SortOrder FROM UserAreas UA INNER JOIN Areas A ON UA.AreaID =A.areaID WHERE UA.UserID=@UserID order by A.SortOrder">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUsersDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct UD.DistrictID,UD.UserID,D.DistrictName,D.SortOrder  FROM UserDistricts UD INNER JOIN Districts D ON UD.DistrictID =D.districtID  WHERE UD.UserID=@userID order by D.SortOrder">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
    </div>
</asp:content>
