<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Site.Master"
    CodeBehind="Wordonthestreet.aspx.vb" Inherits="CrowdBoardsApp.Wordonthestreet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Word on the Street</title>
    <link href="../WebContent/Theme/styles/newsviewfull.css" rel="stylesheet" type="text/css" />
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>  
   <%-- <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>--%>
   
    <style type="text/css">
        .popup_box_allCrowdNews
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 550px;
            width: 460px;
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
            background: #ececee;
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
        }
        
        .popup_box_boost
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 200px;
            width: 460px;
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
        .LabelheadingWhite
        {
            font-size: 16px;
            margin-bottom: 5px;
        }
    </style>
    <style>
        .itemDistricts
        {
            width: 15%;
        }
        .itemDistricts.w2
        {
            width: 50%;
        }
        .view-full-button
        {
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            bottom: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            padding: 8px 10px;
            float: right;
            margin-top: 5px;
            margin-right: 10px;
        }
        .view-full-button:hover
        {
            background-color: #3c6c79;
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
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <div class="districts">
        <div class="title">
            Districts
            <br />
            <%-- <asp:LinkButton ID="showAllLinkButton" runat="server" Text="Show All" Visible="false"
                            Style="color: #75b4c6; font-size: 17px;">
                        </asp:LinkButton>--%>
        </div>
        <asp:DataList ID="districtDataList" runat="server" DataSourceID="sdDistricts" RepeatColumns="10"
            Style="float: right;" RepeatLayout="Table" RepeatDirection="Horizontal">
            <ItemTemplate>
                <div class="districts-list-item">
                    <asp:HiddenField ID="hdnUserCount" runat="server" Value='<%#Eval("UserCount")%>' />
                    <asp:HiddenField ID="hdnIsExists" runat="server" Value='<%#Eval("IsExists")%>' />
                    <asp:HiddenField ID="hdndistrictID" runat="server" Value='<%#Eval("districtID")%>' />
                    <asp:HiddenField ID="hdnDistrictName" runat="server" Value='<%#Eval("DistrictName")%>' />
                    <asp:HiddenField ID="hdnDistrictRowNumber" runat="server" Value='<%#Eval("rownumber") %>' />
                    <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                        CommandName="ShowBoards" CommandArgument='<%#Eval("districtID")%>'></asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <div style="float: right; padding: 10px;">
            <asp:Label ID="lblMessageSearch" runat="server"></asp:Label></div>
    </div>
    <div class="update-container" style="height: 100%; margin-bottom: 15px;">
        <div class="title district-news">
            <%--<input type="button" value="Add District" id="add-district-button" />--%>
            <asp:Button ID="addDistrictRemoveButton" runat="server" Text="Add District" CssClass="view-full-button"
                Font-Size="24px" />
            <asp:LinkButton ID="backLinkButton" runat="server">
            </asp:LinkButton>
            <span>
                <asp:Label ID="districtNameLable" runat="server"></asp:Label>
                District</span>
            <div>
                <asp:LinkButton ID="wordonStretLinkButton" runat="server" Text="Word on the Street">
                </asp:LinkButton>
                <asp:LinkButton ID="populationLinkButton" runat="server" Text="Population">
                </asp:LinkButton>                
                <asp:Label ID="lblMessage" runat="server" Style="margin-left: 100px; font-size: 12px;"></asp:Label>
            </div>
        </div>
        <asp:MultiView ID="wordonStreetMultiview" runat="server" ActiveViewIndex="0">
            <asp:View ID="wordonStreetView" runat="server">
                <div class="left-column" style="float: left; width: 22%; margin-top: 50px; padding: 1%;">
                    <div class="profile-picture">
                        <a href="#">
                            <img id="userProfileImage" runat="server" /></a>
                    </div>
                    <div id="boarder-name">
                        <asp:Label ID="userNameLabel" runat="server"></asp:Label></div>
                    <%-- <br />
                    <asp:button id="addDistrictSpecificPost" runat="server" text="Post" cssclass="view-full-button" />--%>
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="3">
                                <asp:TextBox ID="districtSpecificPostTextBox" runat="server" placeholder="Post an update to the district..."
                                    TextMode="Multiline">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 40%;">
                                <asp:Button ID="fileAttachButton" runat="server" Text="Upload" Style="display: none;" />
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
                                <asp:Button ID="addDistrictSpecificPost" runat="server" Text="Post" CssClass="post-button"
                                    Style="float: right;" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="right-column" style="float: left; width: 77%; margin-top: 50px; overflow-y: scroll;
                    overflow-x: hidden;">
                    <div id="containerDistricts" style="width: 100%;">
                        <asp:DataList ID="districtSpecificNewsDataList" runat="server" DataSourceID="sdCrowdNewsDistrictSpecific"
                            RepeatLayout="Table" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <div class="itemDistricts">
                                    <div style="width: 360px;">
                                        <asp:HiddenField ID="hdnPostID" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                        <div class="crowdnews-post" style="width: 315px; margin-left: 5px; margin-right: 0px;">                                    
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
                                                    <tr id="Tr2" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
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
                                        <div id='<%#"popup_box_Boost" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                            <table width="100%">
                                                <tr>
                                                    <td style="text-align: right; float: right;">
                                                        <a id="A1" onclick='<%# "return unloadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'>
                                                            <img src="Images/btncross.png" alt='Close' style="cursor: pointer;
                                                                height: 25px; width: 25px;" /></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center;">
                                                        <span class="LabelheadingBrown">Select where to Boost</span>
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
                                                        <asp:ImageButton ID="btnFacebookShare" CommandName="IBoostOnFacebook" CommandArgument='<%# Container.DataItem("PostID")%>'
                                                            AlternateText="login" ImageUrl="~/Images/fb_share.jpg" runat="server" Height="30px"
                                                            Width="150px"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnTwitterShare" CommandName="IBoostOnTwitter" CommandArgument='<%# Container.DataItem("PostID")%>'
                                                            AlternateText="login" ImageUrl="~/Images/twitter_share.jpg" runat="server" Height="30px"
                                                            Width="150px"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id='<%#"popup_box_post" +Eval("PostID").ToString()  %>' class="popup_box_allCrowdNews">
                                            <table width="100%">
                                                <tr>
                                                    <td style="text-align: right; padding: 5px; float: right;">
                                                        <a id="popupBoxClosePost" onclick='<%# "return unloadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                            <img src="Images/btncross.png" alt='Close' style="cursor: pointer;
                                                                width: 20px; height: 20px;" /></a>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="Image1" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <span class="LabelheadingBrown">
                                                            <%# Container.DataItem("FriendUserName")%>
                                                            Says:</span>
                                                    </td>
                                                </tr>
                                                <tr id="Tr1" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td style="width: 10%;">
                                                                </td>
                                                                <td style="width: 80%;">
                                                                    <asp:Image ID="imgAttachedImage" runat="server" Height="200px" Width="100%" ImageUrl='<%# isAvail(Eval("AttachedFileName", "~/Upload/UserPostsFiles/{0}")) %>' />
                                                                </td>
                                                                <td style="width: 10%;">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" CssClass="LabelBrownSmall" Text='<%# Eval("Text").toString()%>'> ></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table width="100%" border="0" style="font-size: 14px;">
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="lbtnRecommendsPost1" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                        Font-Size="Small" ForeColor="#75b4c6" CommandName="IRecommend" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                    </asp:LinkButton>
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                    <asp:LinkButton ID="lbtnBoostPost" runat="server" Text="Boost" Font-Size="Small"
                                                                        ForeColor="#75b4c6" OnClientClick='<%# "return loadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'></asp:LinkButton>
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblRecommendsPost" runat="server" Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>
                                                                    Recommends
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblBoosrCountPost" runat="server" Text='<%# Container.DataItem("BoostCount")%>'></asp:Label>
                                                                    Boosts
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCommentCount" runat="server" Text='<%#Eval("CommentCount").ToString() + " Comments " %>'
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
                                                        <telerik:RadTextBox ID="txtSingleComment" runat="server" TextMode="MultiLine" Rows="4"
                                                            Width="100%">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right;">
                                                        <asp:Button ID="btnSingleComment" runat="server" Text="Comment" CssClass="post-button"
                                                            CommandName="IComment" CommandArgument='<%# Container.DataItem("PostID")%>' />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="singlePostRepliesDataList" runat="server" RepeatDirection="Vertical"
                                                            RepeatLayout="Table" RepeatColumns="1">
                                                            <ItemTemplate>
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("ReplyByName", IIf(Convert.ToString(Eval("ReplyByName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                <asp:Image ID="boarderPic" runat="server" Height="40px" Width="40px" ImageUrl='<%# isAvail(Eval("ReplyByName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                            <span class="LabelBrownSmall">Says </span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <span class="LabelBrownSmall">
                                                                                <%# Eval("Comment").ToString()%>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
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
            </asp:View>
            <asp:View ID="populationView" runat="server">
                <div class="boarders-container" style="overfolw-y: scroll; overflow-x: hidden; margin-left: 8px;
                    margin-right: 8px;">
                    <asp:DataList ID="nonFriendDataList" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                        RepeatLayout="Table">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("UserName")%>' />
                            <div class="boarder-lineup" style="float: left; width: 380px; margin: 10px;">
                                <div class="boarder-lineup-image" style="float: left; width: 35%; height: 150px;">
                                    <asp:HyperLink ID="userLink" runat="server" Height="150" Width="130" NavigateUrl='<%# Eval("UserName", IIf(Convert.ToString(Eval("UserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                        <div id="firendDiv" runat="server">
                                            <div style="width: 100%; height: 80%;">
                                            </div>
                                            <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                opacity: 0.4; background-color: #262626;">
                                                <div style="height: 6px;">
                                                    &nbsp;</div>
                                                <span style="color: White;">
                                                    <%# Container.DataItem("UserName")%></span></div>
                                            <%--</div>--%>
                                        </div>
                                    </asp:HyperLink>
                                </div>
                                <div class="lineup-content" style="float: right; width: 55%; height: 150px;">
                                    <div style="height: 95%; width: 100%; word-wrap: break-word;">
                                        <div class="boarder-location">
                                            <span>Location:
                                                <%# Container.DataItem("Location")%></span></div>
                                        <div class="boarder-profession">
                                            Profession:<span><%# Container.DataItem("Profession")%></span></div>
                                        <div class="boarder-districts">
                                            Districts:<span><%#Eval("UserDistricts") %></span></div>
                                    </div>
                                    <div class="add-boarder" style="text-align: right; height: 5%; vertical-align: text-bottom;
                                        width: 100%;">
                                        <asp:Button ID="btnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("UserID")%>'
                                            Text="Add Boarder" CssClass="view-full-button" Style="font-size: 14px;" /></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            loadNew();
        });

        function loadNew() {
            var $container = $('#containerDistricts');

            $container.masonry({
                columnWidth: 320,
                itemSelector: '.itemDistricts'
            });
        }
       
    </script>
      <script type="text/javascript">


          function loadPopupBoxPostAllFull(i) {
              $('#popup_box_post' + i).fadeIn("slow");
              return false;

          }

          function unloadPopupBoxPost(i) {

              $('#popup_box_post' + i).fadeOut("slow");

              return false;
          }

          function loadPopupBoxBoost(i) {

              $('#popup_box_Boost' + i).fadeIn("slow");
              return false;

          }
          function unloadPopupBoxBoost(i) {

              $('#popup_box_Boost' + i).fadeOut("slow");

              return false;
          }
          function ClickRecommend(divID) {
              divID.click();
              return false;
          }

    </script>
    <asp:SqlDataSource ID="sdDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT districtID ,DistrictName,row_number()over(order by D.SortOrder) as rownumber,  (Select COUNT(DistrictID) from UserDistricts UD  where UD.DistrictID = D.DistrictID and UD.UserID=@UserID) as IsExists,(Select COUNT(DistrictID) from UserDistricts UD  where UD.DistrictID = D.DistrictID) as UserCount  FROM Districts D  Order by D.DistrictName">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <%--<asp:SessionParameter Name="areaID" SessionField="areaID" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCrowdNewsDistrictSpecific" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from userposts U inner join Boarders B ON (U.UserID=B.userId1 or U.Userid=B.Userid2) and B.Status=1 and (B.UserID1=@useriD or B.UserID2=@useriD) left join vwBoardInfo v  ON (U.Text lIke '%@' +V.boardname+'@%') where v.district=@District or U.Text like '%@'+@District+'%' order by u.DatePosted desc">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
            <asp:SessionParameter Name="District" SessionField="District" />
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
    <asp:SqlDataSource ID="sdCheckBoardName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckuserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select *  from Users"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="Select DistrictID,DistrictName from Districts"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdAllAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT areaID,AreaName FROM Areas"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        InsertCommand="INSERT INTO UserDistricts (UserID,DistrictID )VALUES(@UserID,@DistrictID)"
        DeleteCommand="DELETE FROM UserDistricts WHERE UserID =@UserID AND DistrictID =@DistrictID">
        <InsertParameters>
            <asp:Parameter Name="UserID" Type="Int32" DefaultValue="%" />
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="Int32" DefaultValue="%" />
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from Boards B inner join Users U on B.UserID=U.UserID where B.BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdPopulation" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select *,(SELECT top 1 UserName From Users where UserID=UD.UserID) AS UserName,(SELECT  top 1 Job From Users where UserID=UD.UserID) AS Profession,(dbo.fUserDistricts(UD.UserID)) As UserDistricts,(SELECT  top 1 Status  From Users where UserID=UD.UserID) AS friendStatus,(SELECT  top 1 IsNULL(City,'')+','+ISNULL(state,'') From Users where UserID=UD.UserID) AS Location from UserDistricts UD where UD.DistrictID=@DistrictID">
        <SelectParameters>
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdIRecommend" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="UserPostReplies_Recommend" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
            <asp:Parameter Name="Recommend" />
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
    <asp:SqlDataSource ID="sdPostReplies" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Liked) VALUES(@UserID,@PostID,GetDate(),1)"
        SelectCommand="SELECT UR.ReplyID,UR.UserID,UR.DateReplies,UR.Comment,(SELECT UserName FROM Users WHERE UserID=UR.UserID) as ReplyByName FROM UserPostReplies UR WHERE UR.PostID=@PostID AND UR.Comment IS NOT NULL order by UR.ReplyID desc">
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="PostID" />
        </SelectParameters>
    </asp:SqlDataSource>
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
    </div>
</asp:Content>
