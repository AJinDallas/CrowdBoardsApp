<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UpdateBoarders.aspx.vb"
    Inherits="CrowdBoardsApp.UpdateBoarders" MasterPageFile="~/MasterPage/Site.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Update Boarders</title>
    <link href="WebContent/Theme/styles/editmanageupdate.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function clickRadUploadbtn() {
            $telerik.$(".ruFileInput").click();

        }
          
    </script>
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
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <div class="main-body">
        <div class="title">
            <a href="../CrowdboardCommand.aspx">Back to My CrowdBoards</a>
            <asp:Label runat="server" ID="lblCrowdboardName"></asp:Label>
            <div class="navigational-links">
                <asp:LinkButton ID="lbtnEdit" runat="server" ForeColor="#75b4c6">Edit</asp:LinkButton>
                <asp:LinkButton ID="lbtnManage" runat="server" ForeColor="#75b4c6">Manage</asp:LinkButton>
                <asp:LinkButton ID="lbtnUpdate" runat="server" ForeColor="#75b4c6">Updates</asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="update-container" style="height: 550px;">
        <div class="update-navigation">
            <asp:Label ID="messageLabel" runat="server" Style="font-size: 18px; margin-right: 30px;">
            </asp:Label>
            <asp:LinkButton ID="lbtnUpdates" runat="server" ForeColor="#75b4c6">Update Boarders</asp:LinkButton>
            <asp:LinkButton ID="lbtnBodersin" runat="server" ForeColor="#75b4c6">BoardersIn</asp:LinkButton>
            <asp:LinkButton ID="lbtnWatching" runat="server" ForeColor="#75b4c6">Boarders Watching</asp:LinkButton>
        </div>
        <telerik:RadMultiPage ID="rmpUpdates" runat="server" Width="100%" SelectedIndex="0">
            <telerik:RadPageView ID="rpvUpdates" runat="server" Selected="true">
                <div class="title">
                    Updates
                </div>
                <div class="left-column" style="height: 500px;">
                    <div class="profile-picture">
                        <a href="">
                            <asp:Image ID="profilePic" runat="server" />
                        </a>
                    </div>
                    <div id="boarder-name">
                        <%= Session("userName").ToString%>
                    </div>
                    <textarea id="txtPost" runat="server" placeholder="Write a post to the Crowd News..."></textarea>
                    <asp:Button ID="postRadButton" runat="server" Text="Post" CssClass="post-button" />
                </div>
                <div class="right-column" style="height: 436px;">
                    <asp:DataList ID="ownerPosts" runat="server" RepeatLayout="Table" RepeatDirection="Horizontal"
                        RepeatColumns="2" Style="width: 100%;">
                        <ItemTemplate>
                            <div class="crowdnews-post" style="width: 98%;">
                                <asp:HiddenField ID="hdnPostIDFull" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                <div class="posted-material">
                                    <a href="">
                                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("PostedByUserName", IIf(Convert.ToString(Eval("PostedByUserName"))= Convert.ToString(Session("PostedByUserName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("PostedByUserName")%>'
                                                CssClass="poster-image" ImageUrl='<%# isAvail(Eval("PostedByUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                    </a>
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
                                        <%# Container.DataItem("PostedByUserName")%>
                                        says:</div>
                                    <%--<div id="Tr1" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
                                        <asp:Image ID="Image2Full" runat="server" Height="150px" Width="150px" ImageUrl='<%# isAvail(Eval("AttachedFileName", "~/Upload/UserPostsFiles/{0}")) %>' />
                                    </div>--%>
                                    <div class="poster-comment">
                                        <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text").ToString() %>'></asp:Label>
                                    </div>
                                    <div class="time-stamp">
                                        <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div id='<%#"popup_box_Boost_AllFull" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                <table width="100%">
                                    <tr>
                                        <td style="text-align: right;">
                                            <a id="boostClose" onclick='<%# "return unloadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                <img src="WebContent/Theme/images/closebox.png" alt='Close' width='20' height='20'
                                                    style="cursor: pointer;" /></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center; font-size: 16px;">
                                            <span>Select where to Boost</span>
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
                                                <img src="Images/btncross.png" alt='Close' 
                                                    style="cursor: pointer; width:20px; height:20px;" /></a>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0">
                                    <tr>
                                        <td>
                                            <asp:HyperLink ID="friendUserHyperLinkFull" runat="server" NavigateUrl='<%# Eval("PostedByUserName", IIf(Convert.ToString(Eval("PostedByUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="ImageFull" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("PostedByUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <span class="LabelheadingBrown">
                                                <%# Container.DataItem("PostedByUserName")%>
                                                Says:</span>
                                        </td>
                                    </tr>
                                    <%--  <tr id="attachedImageTr" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
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
                                    </tr>--%>
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
                                            <telerik:RadTextBox ID="txtSingleCommentFull" runat="server" TextMode="MultiLine"
                                                Rows="4" Width="100%">
                                            </telerik:RadTextBox>
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
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="rpvBodersin" runat="server">
                <div class="title" style="margin-top: 25px;">
                    BoardesIn
                </div>
                <asp:Label ID="lblMessageAddBoarder" runat="server"></asp:Label>
                <div class="boarders-container" style="height: 400px;">
                    <asp:DataList ID="nonFriendDataList" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                        RepeatLayout="Table">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("username")%>' />
                            <div style="width: 315px; float: left; background-color: #f6f6f6; color: #788586;
                                font-size: 14px;">
                                <div class="crowdboard-container group">
                                    <div style="float: left; width: 50%; height: 150px;">
                                        <asp:HyperLink ID="userLink" runat="server" Height="150" Width="130" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <div id="firendDiv" runat="server">
                                                <div style="width: 100%; height: 80%;">
                                                </div>
                                                <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                    opacity: 1.0; background: none repeat scroll 0 0 rgba(59, 59, 59, 0.6); color: #fff;">
                                                    <div style="height: 6px;">
                                                        &nbsp;</div>
                                                    <div class="boarder-name">
                                                        <%# Container.DataItem("username")%></div>
                                                </div>
                                            </div>
                                        </asp:HyperLink>
                                    </div>
                                    <div style="float: right; width: 50%; height: 150px;">
                                        <div style="height: 80%; width: 100%; word-wrap: break-word;">
                                            <span class="LabelBrownSmall">Location:
                                                <%# Container.DataItem("Location")%></span><br />
                                            <span class="LabelBrownSmall">Profession:
                                                <%# Container.DataItem("Profession")%></span><br />
                                            <span class="LabelBrownSmall">My Districts:
                                                <br />
                                                <%#Eval("UserDistricts") %></span>
                                        </div>
                                        <div style="text-align: right; height: 20%; vertical-align: text-bottom; width: 100%;">
                                            <asp:Button ID="btnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                Text="Add Boarder" CssClass="invest-button" Visible='<%# IIf(Eval("friendStatus")=3 or Eval("friendStatus")=2,true,false) %>' />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="rpvWatching" runat="server">
                <div class="title">
                    Boarders Watching
                    <asp:Label ID="lblMessage" runat="server" Style="font-size: 12px; margin-left: 100px;">
                    </asp:Label>
                </div>
                <br />
                <div class="boarders-container" style="height: 400px;">
                    <asp:DataList ID="watchBoardDataList" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                        RepeatLayout="Table">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("UserName")%>' />
                            <div style="width: 315px; float: left; background-color: #f6f6f6; color: #788586;
                                font-size: 14px;">
                                <div class="crowdboard-container group">
                                    <div style="float: left; width: 50%; height: 150px;">
                                   


                                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("UserName", IIf(Convert.ToString(Eval("UserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <div id="firendDiv" runat="server">
                                                <div style="width: 100%; height: 80%;">
                                                </div>
                                                <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                    opacity: 1.0; background: none repeat scroll 0 0 rgba(59, 59, 59, 0.6); color: #fff;">
                                                    <div style="height: 6px;">
                                                        &nbsp;</div>
                                                    <div class="boarder-name">
                                                        <%# Container.DataItem("UserName")%></div>
                                                </div>
                                            </div>
                                        </asp:HyperLink>
                                    </div>
                                    <div style="float: right; width: 50%; height: 150px;">
                                        <div style="height: 80%; width: 100%; word-wrap: break-word;">
                                            <span class="LabelBrownSmall">Location:
                                                <%# Container.DataItem("Location")%></span><br />
                                            <span class="LabelBrownSmall">My Districts:
                                                <br />
                                                <%#Eval("UserDistricts") %></span>
                                        </div>
                                        <div style="text-align: right; height: 20%; vertical-align: text-bottom; width: 100%;">
                                            <asp:Button ID="btnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("BoardID")%>'
                                                Text="Add Boarder" CssClass="invest-button" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
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
    <asp:SqlDataSource ID="sdAllBoardersList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from(Select top 100 percent B.BoardID,B.BoardName,B.DirectoryName,NULL as Text,BI.UserID As userID,BI.AmountInvested, (SELECT top 1 UserName From Users where UserID=BI.UserID) AS UserName,(SELECT  top 1 Job From Users where UserID=BI.UserID) AS Profession,(dbo.fUserDistricts(B.UserID)) As UserDistricts,(SELECT  top 1 Status  From Users where UserID=BI.UserID) AS friendstatus,(SELECT  top 1 IsNULL(City,'')+','+ISNULL(state,'') From Users where UserID=BI.UserID) AS Location,Bi.DateInvested as ActivityDate from Boards B INNER JOIN boardinvestors BI ON B.BoardId=BI.BoardID WHERE B.DirectoryName =@DirectoryName AND BI.dateInvested is not null ORDER BY Bi.DateInvested DESC) main">
        <SelectParameters>
            <asp:SessionParameter Name="DirectoryName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdWatchBoarders" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from(Select top 100 percent B.BoardID,B.BoardName,B.DirectoryName,NULL as Text,BI.UserID As userID,BI.AmountInvested, (SELECT top 1 UserName From Users where UserID=BI.UserID) AS UserName,(SELECT  top 1 Job From Users where UserID=BI.UserID) AS Profession,(dbo.fUserDistricts(B.UserID)) As UserDistricts,(SELECT  top 1 Status  From Users where UserID=BI.UserID) AS friendstatus,(SELECT  top 1 IsNULL(City,'')+','+ISNULL(state,'') From Users where UserID=BI.UserID) AS Location,Bi.DateInvested as ActivityDate from Boards B INNER JOIN boardinvestors BI ON B.BoardId=BI.BoardID WHERE B.DirectoryName =@DirectoryName AND BI.WatchDate is not null ORDER BY Bi.DateInvested DESC) main">
        <SelectParameters>
            <asp:SessionParameter Name="DirectoryName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="UserPost_Insert" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE UserPosts SET AttachedFileName=@AttachedFileName WHERE PostID=@PostID">
        <SelectParameters>
            <asp:Parameter Name="Text" />
            <asp:Parameter Name="UserID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="AttachedFileName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="Select DistrictID,DistrictName from Districts"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckBoardName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdAllAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT areaID,AreaName FROM Areas"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckuserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select *  from Users"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckRequest" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
        <SelectParameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoarders" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select M.Users,M.UserID1,M.UserID2,M.Status,M.DateRequested,M.DateAccepted,(SELECT IsNULL(City,'')+','+ISNULL(state,'') from users WHERE UserName=M.Users) as Location,(SELECT Job from users WHERE UserName=M.Users) as Profession,dbo.fUserDistricts(CASE WHEN M.UserID1=@UserID Then M.UserID2 Else M.UserID1 End) As UserDistricts from (SELECT CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As Users,userid1,userid2,Status,DateRequested,DateAccepted from vwBoardersDetail where (UserID1=@UserID or UserID2=@UserID) AND Status=1)M"
        InsertCommand="INSERT INTO Boarders(UserID1,UserID2,Status,DateRequested) VALUES(@UserID1,@UserID2,0,getdate())"
        UpdateCommand="UPDATE Boarders SET Status=0,DateRequested=getdate(),DateRejected=null,userID1=@UserID1,UserID2=@UserID2 WHERE (UserID1=@UserID1 AND UserID2=@UserID2) OR (UserID1=@UserID2 AND UserID2=@UserID1)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdWatchers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spWatchBoard" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="PrivateWatch" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BI.BoardID,BI.BoardName,BI.Status,BI.UserID FROM vBoardInformation BI WHERE BI.DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from Boards B inner join Users U on B.UserID=U.UserID where B.BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,Boardname,UserID,Description,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Comments,Investors,District,AreaName,RecentComment,CommenterUserID,city,state,country,District1,InvestmentTypeID,RaisedTotal,TotalOffer as seekingAmount,NoOfBoardLevels,TotalOffer As Seeking,Offer,AmountRemaining as Amountleft,question1,question2,question3,question4,answer1,answer2,answer3,answer4,AboutMe,InvType,InvTypeDescription,case when minLevelPrice=maxLevelPrice then  '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) else '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) + ' - $'+ convert(varchar(12),cast(maxLevelPrice as dec(10,0)),1) END As PricedFrom,BoardLevel,RecommendCount from vwBoardInfo where BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardInsiderPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT IP.InsPostID as PostID,IP.BoardID,IP.Text,IP.DatePosted,IP.UserID,
(SELECT Username from Users where UserID=IP.UserID) As PostedByUserName,
ISnull((SELECT top 1 Liked From UserPostReplies UPR WHERE UPR.PostID=IP.InsPostID AND UPR.UserID=IP.UserID and UPR.Liked is not null),0) as Liked,
ISnull((SELECT top 1 Recommend From UserPostReplies UPR WHERE UPR.PostID=IP.InsPostID AND UPR.UserID=IP.UserID and UPR.Recommend is not null),0) as Recommend,
(SELECT Count(*) from UserPostReplies WHERE PostID=IP.InsPostID and Boost is not null ) AS BoostCount,
(SELECT Count(*) from UserPostReplies WHERE PostID=IP.InsPostID and Comment is not null ) AS CommentCount,
(SELECT Count(*) from UserPostReplies WHERE PostID=IP.InsPostID and Liked is not null ) AS LikeCount ,
(SELECT Count(*) from UserPostReplies WHERE PostID=IP.InsPostID and Recommend=1) AS RecommendCount ,
CASE WHEN IP.UserID=(SELECT UserID FROM Boards WHERE BoardID=IP.BoardID) THEN 'IsOwnerPost' ELSE 'IsInvesterPost' END As PostBy 
from InsiderPosts IP WHERE IP.BoardID=@BoardID ORDER BY DatePosted DESC">
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
    <asp:SqlDataSource ID="sdPostReplies" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Liked) VALUES(@UserID,@PostID,GetDate(),1)"
        SelectCommand="SELECT UR.ReplyID,UR.UserID,UR.DateReplies,UR.Comment,(SELECT UserName FROM Users WHERE UserID=UR.UserID) as ReplyByName FROM UserPostReplies UR WHERE UR.PostID=@PostID AND UR.Comment IS NOT NULL">
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="PostID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCommentOnPost" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Comment) VALUES(@UserID,@PostID,GETDATE(),@Comment)"
        SelectCommand="Sp_BoostUserPost" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="Comment" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdIRecommend" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="UserPostReplies_Recommend" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="Recommend" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
