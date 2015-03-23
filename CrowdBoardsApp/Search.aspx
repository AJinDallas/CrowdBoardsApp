<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Search.aspx.vb" MasterPageFile="~/MasterPage/Site.Master"
    Inherits="CrowdBoardsApp.Search" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Search</title>
    <style type="text/css">
        .tdSide
        {
            width: 40px;
        }
        .size1of3
        {
            float: left;
            width: 33%;
        }
        
        .size1of7
        {
            float: left;
            width: 13%;
        }
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
        
        .RadSlider .rslItem,.RadSlider .rslLargeTick span
    {
       
       width:40px !important;
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
            height: 400px;
            width: 600px;
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
         .box
        {
            margin: 5px;
            padding: 20px;
            background-color: #ececee;
            box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
        }
        
         .itemDistricts { width: 15%; }
        .itemDistricts.w2 { width: 50%; }
        .items { width: 15%; }
        .items.w2 { width: 50%; }
         #pageloaddiv 
         {
             position: fixed;
             left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 999;
            opacity: 0.9; 
            filter: alpha(opacity=70);
            background: url('Images/loading_332.gif') no-repeat center center;
}
        .welcombtn
         {
            background-color: #efefef;
            border: medium none;
            border-radius: 5px;
            bottom: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #72b2c7;
            cursor: pointer;
            font-size: 12px !important;
            font-weight: 600;
            padding: 5px 8px;
            position: absolute;
            right: 5px;
        }
        .welcombtn:hover 
        {
            background: none repeat scroll 0 0 #3c6c79;
            color: #fff;
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
        }
        .post-button:hover 
        {
            background-color: #3c6c79;
        }
      
      .districtTitle {
    float: left;
    font-size: 26px;
    margin-bottom: 8px;
    margin-top: 8px;
    width: 100%;
    padding-left :10px;
}
.empty-crowdboard {
    font-size: 18px;
    height: 353px;
    line-height: 2em;
    padding-top: 104px;
    text-align: center;
}
.empty-crowdboard div a {
    color: #75b4c6;
    font-weight: 600;
    line-height: 4em;
    margin-top: 15px;  
}

.empty-crowdboard div a:hover{
    color: #3c6c79;   
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
        .addareabutton
        {
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff !important;
            cursor: pointer;
            font-size: 24px !important;
            font-weight: 600;
            padding: 5px 11px 6px;
            background-color: #48a88d;
            float: right;
            margin-right: 28px !important;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="WebContent/Theme/styles/DistrictsAreas.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/newsviewfull.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <link href="../WebContent/Theme/styles/newsviewfull.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function setAreaCss() {
            //            $('#BodyContent_welcomeDiv').removeClass('welcome-banner districts-welcome-banner');
            //            $('#BodyContent_welcomeDiv').addClass('welcome-banner areas-welcome-banner');
            //            $('#wotsBannerDiv').removeClass('WOTS-banner districts-WOTS-banner');
            //            $('#wotsBannerDiv').addClass('WOTS-banner areas-WOTS-banner');
            return true
        }

        function setDistrictCss() {
            //            $('#BodyContent_welcomeDiv').removeClass('welcome-banner areas-welcome-banner');
            //            $('#BodyContent_welcomeDiv').addClass('welcome-banner districts-welcome-banner');
            //            $('#wotsBannerDiv').removeClass('WOTS-banner areas-WOTS-banner');
            //            $('#wotsBannerDiv').addClass('WOTS-banner districts-WOTS-banner');
            return true
        }

        function anchotInvestClick(board) {
            window.location.replace("" + board + "?fromSearch=1#investDiv");
        }
        function anchotClick(board) {
            window.location.replace("" + board + "?fromSearch=1");
        }
        
    </script>
    <script>
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


        function loadAreaPopupBoxPostAllFull(i) {

            $('#popup_box_AreaPost' + i).fadeIn("slow");
            return false;

        }

        function unloadAreaPopupBoxPost(i) {

            $('#popup_box_AreaPost' + i).fadeOut("slow");

            return false;
        }

        function loadAreaPopupBoxBoostAllFull(i) {

            $('#popup_box_AreaBoost' + i).fadeIn("slow");
            return false;

        }


        function unloadAreaPopupBoxBoost(i) {

            $('#popup_box_AreaBoost' + i).fadeOut("slow");

            return false;
        }
        function ClickRecommend(divID) {
            divID.click();
            return false;
        }

    </script>
    <script type="text/javascript">
        function clickRadUploadbtn() {
            $telerik.$(".ruFileInput").click();
        }

        function fileAttach(sender, args) {
            document.getElementById("<%= fileAttachButton.ClientID %>").click();

        }
    
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <%--<asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
             <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>--%>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">


            function OnClientClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
                else if (arg != null) {
                    window.location = arg;
                }
            }

            function openRadWindow() {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwLogin.aspx?page=Search";
                manager.open(url, "RadWindow1");
                return false;

            }

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
        <script type="text/javascript">

            function scrollThumb123(direction) {
                //alert(direction);
                if (direction == 'Go_U') {

                    $('#scrollPostDiv').animate({
                        scrollTop: "-=" + 250 + "px"
                    }, function () {

                    });
                } else
                    if (direction == 'Go_D') {
                        $('#scrollPostDiv').animate({
                            scrollTop: "+=" + 250 + "px"
                        }, function () {

                        });
                    }
            }

        </script>
        <script type="text/javascript">
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                loadNew();
            });
           
 
        </script>
    </telerik:RadScriptBlock>
    <%--  <asp:updateprogress id="UpdateProgress2" runat="server" associatedupdatepanelid="UpdatePanel2">
        <progresstemplate>
            <div id="pageloaddiv">
            </div>
            <%--    <div id="processMessage">

            </div>
        </progresstemplate>
    </asp:updateprogress>--%>
    <%--<asp:updatepanel id="UpdatePanel2" runat="server" updatemode="Conditional">
        <contenttemplate>--%>
    <telerik:RadMultiPage ID="radMultiPage1" runat="server" SelectedIndex="0">
        <telerik:RadPageView ID="rpvTop" runat="server" Selected="true">
            <div class="container first-row">
                <div class="districts">
                    <div class="title" style="padding-left: 20px;">
                        Districts
                        <asp:LinkButton ID="showAllLinkButton" runat="server" Text="Show All" Visible="false"
                            Style="color: #75b4c6; font-size: 17px;">
                        </asp:LinkButton>
                    </div>
                    <div class="districts-container" style="float: left; height: 100%; width: 85%;">
                        <asp:DataList ID="districtDataList" runat="server" DataSourceID="sdDistricts" Width="85%"
                            Height="100%" Style="float: left;" RepeatColumns="10" RepeatLayout="Table" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <div class="districts-list-item" style="float: left; min-width: 87px; font-size: 14px;">
                                    <asp:HiddenField ID="hdnUserCount" runat="server" Value='<%#Eval("UserCount")%>' />
                                    <asp:HiddenField ID="hdnIsExists" runat="server" Value='<%#Eval("IsExists")%>' />
                                    <asp:HiddenField ID="hdndistrictID" runat="server" Value='<%#Eval("districtID")%>' />
                                    <asp:HiddenField ID="hdnDistrictName" runat="server" Value='<%#Eval("DistrictName")%>' />
                                    <asp:HiddenField ID="hdnDistrictRowNumber" runat="server" Value='<%#Eval("rownumber") %>' />
                                    <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                        ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#494949"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'
                                        CommandName="ShowBoards" CommandArgument='<%#Eval("districtID")%>'></asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                    <div style="float: right; padding: 10px;">
                        <asp:Label ID="lblMessageSearch" runat="server"></asp:Label></div>
                </div>
            </div>
            <div id="second-row" class="container">
                <div class="col1">
                    <div id="areasRepeaterDiv" runat="server">
                        <div class="title" id="areaTitleDiv" runat="server" visible="true">
                            Areas
                        </div>
                        <asp:Repeater ID="areaRepeater" runat="server" DataSourceID="sdAreas">
                            <ItemTemplate>
                                <div class="areas-list-item">
                                    <table width="100%" border="0">
                                        <tr>
                                            <td valign="middle" style="height: 5px; text-align: center;">
                                                <%-- <div class="contentWhitelarge">--%>
                                                <asp:HiddenField ID="hdnAreaName" runat="server" Value='<%#Eval("AreaName")%>' />
                                                <asp:HiddenField ID="hdnRowNumber" runat="server" Value='<%#Eval("rownumber") %>' />
                                                <asp:HiddenField ID="hdnIsExists" runat="server" Value='<%#Eval("IsExists")%>' />
                                                <asp:LinkButton ID="areaNameLinkButton" runat="server" Text='<%#Eval("AreaName")%>'
                                                    ForeColor='<%# IIf(Eval("AreaName").ToString() = AreaName,Drawing.ColorTranslator.FromHtml("#494949"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'
                                                    OnClientClick="setAreaCss();" CommandName="ShowBoards" CommandArgument='<%#Eval("areaID")%>'></asp:LinkButton>
                                                <%--</div>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div id="filterDiv" runat="server">
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLatestBoards" ForeColor="#ececee" runat="server" Text="Latest Boards">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnMostActive" ForeColor="#ececee" runat="server" Text="Most Active">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnMostWatched" ForeColor="#ececee" runat="server" Text="Most Watched">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnMostRaised" ForeColor="#ececee" runat="server" Text="Most Raised">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel9Plus" ForeColor="#ececee" runat="server" Text="Level 9+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel8Plus" ForeColor="#ececee" runat="server" Text="Level 8+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel7Plus" ForeColor="#ececee" runat="server" Text="Level 7+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel6Plus" ForeColor="#ececee" runat="server" Text="Level 6+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel5Plus" ForeColor="#ececee" runat="server" Text="Level 5+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel4Plus" ForeColor="#ececee" runat="server" Text="Level 4+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel3Plus" ForeColor="#ececee" runat="server" Text="Level 3+">
                            </asp:LinkButton>
                        </div>
                        <div class="areas-list-item">
                            <asp:LinkButton ID="lbtnLevel2Plus" ForeColor="#ececee" runat="server" Text="Level 2+">
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col2">
                    <div id="welcomeDistrictDiv" runat="server" visible="false">
                        <div id="welcomeDiv" runat="server" class="welcome-banner districts-welcome-banner"
                            style="height: 115px;">
                            <div class="welcoming-text">
                                <span class="district-name">
                                    <asp:Label ID="districtNameLabel" runat="server"></asp:Label></span>
                                <br />
                                <q class="quote-text">
                                    <asp:Label ID="lblDistrictDescription" runat="server"></asp:Label></q><cite>
                                        <asp:Label ID="lblDistrictQuotation" runat="server" Font-Size="Larger"></asp:Label></cite>
                            </div>
                            <div class="population-text">
                                <span class="population-number">
                                    <label>
                                        Population:</label>
                                    <a href="../WordontheStreet.aspx?s=population">
                                        <asp:Label ID="lblPopulationCount" runat="server" Style="text-decoration: underline;">
                                        </asp:Label></a></span>
                            </div>
                            <asp:Button ID="addDistrictRemoveButton" Text="Add to my Districts" runat="server"
                                CssClass="add-district-button" Style="float: right; margin-right: 10px; margin-top: 30px;">
                            </asp:Button>
                        </div>
                    </div>
                    <div id="welcomeAreaDiv" runat="server" visible="false" class="WOTS-banner areas-WOTS-banner">
                        <div class="welcoming-text">
                            <span class="district-name">
                                <asp:Label ID="lblAreaNameWelcome" runat="server"></asp:Label></span>
                        </div>
                        <div class="population-text">
                            <span class="population-number">
                                <label>
                                    Population:</label>
                                <asp:LinkButton ID="areaPopulationLabel" runat="server" Style="text-decoration: underline;">
                                </asp:LinkButton></span>
                        </div>
                        <asp:Button ID="btnJoinIncrowdArea" Text="Join Incrowd" runat="server" class="view-full-button"
                            Style="float: right; margin-top: 26px; margin-right: 10px;"></asp:Button>
                        <%--   <input id="join-incrowd-button" type="button" value="Join Incrowd">--%>
                    </div>
                    <div style="height: 600px; width: 100%;">
                        <div class="crowdboard-container empty-crowdboard group" id="createNewboardDiv" runat="server"
                            visible="false">
                            <div>
                                Your idea can be here!</div>
                            <div>
                                What are you waiting for?</div>
                            <div>
                                <a href="CreateCrowdboard.aspx">Create CrowdBoard</a></div>
                        </div>
                        <asp:Repeater ID="boardsRepeater" runat="server">
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("TotalOffer") %>' />
                                <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                <asp:LinkButton ID="lbBoardDetail" runat="server" CommandName="ToBoard" CommandArgument='<%# Eval("DirectoryName") %>'>
                               
                                    <div class="size1of3">
                                     <div style="min-height:450px;">
                                        <div class="crowdboard-container group" style="width: 100%;">
                                            <div class="crowdboard-video">
                                                <div id="coverPicDiv" runat="server">
                                                    <div class="play-button">
                                                        <asp:ImageButton ID="ibtnPlay" ImageUrl="WebContent/theme/images/playbutton.png"
                                                            Height="50" Width="50" runat="server" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                            Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="crowdboard-profile-picture">
                                                <img id="imgBoard" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60,"thumbnail","thumbs") %>' />
                                            </div>
                                            <div class="crowdboard-mini-console">
                                                <div class="crowdboard-measure">
                                                    <table border="0">
                                                        <tr valign="top">
                                                            <td style="width: 10%;">
                                                                <div style="margin-left: 3px; margin-bottom: 10px;">
                                                                    <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                        TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="96px"
                                                                        Style="margin-top: 0px;" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                        ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                        CssClass="thermometerSlider" BackColor="Transparent">
                                                                    </telerik:RadSlider>
                                                                    <%-- <div class="crowdboard-status-bar-position">
                                                                    </div>--%>
                                                                    <td>
                                                                        <div class="crowdboard-measure-text" style="margin-left: 2px;">
                                                                            <div class="crowdboard-measure-level">
                                                                                Level</br><span><asp:Label ID="lblBoardLevel" runat="server" Text='<%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%>'></asp:Label></span></div>
                                                                            <div class="crowdboard-measure-max-left">
                                                                                Max Left</br><span>
                                                                                    <asp:Label ID="lblAmountLeft" runat="server" Text='<%#GetAmount(Eval("AmountRemaining"),Eval("BankLocation"))%>'></asp:Label></span></div>
                                                                            <div class="crowdboard-measure-boarders-in">
                                                                                Boarders In</br><span><asp:Label ID="Label2" runat="server" Text='<%#Eval("BoarderInCount") %>'></asp:Label></span></div>
                                                                        </div>
                                                                    </td>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/comment.png" /><div class="comment-number">
                                                        (1)</div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/recommend.png" /><div class="recommend-number">
                                                        <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label></div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/boost.png" /><div class="boost-number">
                                                        (3)</div>
                                                </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName","{0}") %>')">
                                                    <img src="WebContent/theme/images/watchwbg.png" /><div class="watch-number">
                                                        <asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label></div>
                                                </a>
                                                <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" />
                                            </div>
                                            <div class="crowdboard-text" style="min-height:240px;">
                                                <%-- <asp:Label ID="lblInvType" runat="server" Text='<%#Eval("invType") %>'></asp:Label>--%>
                                                <div class="crowdboard-line-name">
                                                    Name: <span>
                                                        <asp:Label ID="lblCrowdBoard" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label></span></div>
                                                <div class="crowdboard-line-location">
                                                    Location: <span>
                                                        <asp:Label ID="lblInvested" runat="server" Text='<%#Eval("Location") %>'></asp:Label></span></div>
                                                <div class="crowdboard-line-seeking">
                                                    Seeking: <span>
                                                        <asp:Label ID="lblSeeking" runat="server" Text='<%#GetAmount(Eval("TotalOffer"),Eval("BankLocation"))%>'></asp:Label></span></div>
                                                <div class="crowdboard-line-DA">
                                                    District: <span class="district-tag"><a href='Search.aspx?District=<%#Eval("District") %>'>
                                                        <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label></a></span>
                                                    Area: <span class="area-tag"><a href='Search.aspx?Area=<%#Eval("AreaName") %>'>
                                                        <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label></a></span></div>
                                                <div class="crowdboard-line-live-since">
                                                    Live Since: <span>
                                                        <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label></span></div>
                                              
                                                  <div class="crowdboard-wrapper-description">
                                                    Description:</br>
                                                    <div class="crowdboard-description">
                                                        <asp:Label ID="lblDescription" Font-Bold="false" runat="server" Text='<%# If(Eval("Description").ToString().Length < 145, Eval("Description"), Eval("Description").Substring(0, 145)+"...") %>' ></asp:Label>
                                                    </div>
                                                </div>

                                            </div>
                                            <%-- <input type="button" value="View CrowdBoard"  id="view-crowdboard-button" />--%>
                                            <asp:Button ID="viewbutton" CssClass="view-crowdboard-button" Text="View CrowdBoard"
                                                PostBackUrl='<%# Eval("DirectoryName","~/{0}") %>' runat="Server"></asp:Button>
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
                                    </div></div>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div id="pagingDiv" runat="server" visible="true" class="crowdboard-container empty-crowdboard group"
                        style="box-shadow: none; background-color: #fbfbfb;">
                        <asp:Label ID="lblShowPangeNumber" runat="server"></asp:Label>
                        <br />
                        <asp:Button ID="btnPrevious" runat="server" CssClass="view-full-button" Text="Previous" />
                        <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="view-full-button" />
                    </div>
                </div>
                <div class="col3" style="overflow: hidden; width: 16%;">
                    <div id="wordOnStreetDiv" runat="server" style="display: none;">
                        <div class="WOTS-banner districts-WOTS-banner" id="wotsBannerDiv">
                            <div class="WOTS-text">
                                Word on the Street</div>
                            <asp:Button ID="btnViewFullWordOnStreetNews" Text="View Full" runat="server" CssClass="view-full-button"
                                Style="float: right; margin-right: 10px; margin-top: 24px;"></asp:Button>
                        </div>
                        <div id="postOnDistrictDiv" runat="server" class="WOTS-post-message">
                            <table width="100%" border="0" cellspacing="5px;">
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ID="txtPostOnDistrict" TextMode="MultiLine" runat="server" placeholder="Write a post...">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">
                                        <asp:Button ID="btnPostOnDitrict" runat="server" Text="Post" CssClass="post-button">
                                        </asp:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="width: 100%; overflow-x: hidden; overflow-y: scroll; height: 600px;">
                            <asp:Repeater ID="wordOntheStreetRepeater" runat="server" DataSourceID="sdCrowdNewsDistrictSpecific">
                                <ItemTemplate>
                                    <div class="WOTS-message">
                                        <asp:HiddenField ID="hdnPostIDFull" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                        <div class="WOTS-message-header">
                                            <a href='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' />
                                            </a>
                                            <div class="poster-options" onclick='<%# "return loadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                <a class="comment-img" href="#">
                                                    <img src="WebContent/Theme/images/comment.png" /><div class="comment-number">
                                                        <asp:Label ID="lblCommentCount" runat="server" Text='<%#Eval("CommentCount").ToString()  %>'></asp:Label></div>
                                                </a><a class="recommend-img" href="#">
                                                    <img src="WebContent/Theme/images/recommend.png" /><div class="recommend-number">
                                                        <asp:Label ID="lblRecommendsCount" runat="server" Text='<%#Eval("RecommendCount").ToString() %>'></asp:Label></div>
                                                </a><a class="boost-img" href="#">
                                                    <img src="WebContent/Theme/images/boost.png" /><div class="boost-number">
                                                        <asp:Label ID="lblBoostCount" runat="server" Text='<%#Eval("BoostCount").ToString() %>'></asp:Label></div>
                                                </a>
                                            </div>
                                            <div class="message-attribution">
                                                <span class="boarder-message-name">
                                                    <%# Container.DataItem("FriendUserName")%></span> says:</div>
                                        </div>
                                        <div class="poster-comment">
                                            <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text") %>'></asp:Label></span>
                                        </div>
                                    </div>
                                    <%--PostPopupDiv --%>
                                    <div id='<%#"popup_box_postAllFull" +Eval("PostID").ToString()  %>' class="popup_box_allCrowdNews">
                                        <table width="100%">
                                            <tr>
                                                <td style="text-align: right;">
                                                    <a id="popupBoxClosePostFull" onclick='<%# "return unloadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                        <img src="Images/btncross.png" alt='Close' style="cursor: pointer; width: 20px; height: 20px;" /></a>
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
                                                            <td>
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
                                                            </td>
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
                                    <%--BoostPopupDiv --%>
                                    <div id='<%#"popup_box_Boost_AllFull" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                        <table width="100%">
                                            <tr>
                                                <td style="text-align: right;">
                                                    <a id="boostClose" onclick='<%# "return unloadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                        <img src="Images/btncross.png" alt='Close' style="cursor: pointer; height: 20px;
                                                            width: 20px;" /></a>
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
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <div id="inCrowdLatestDiv" runat="server" style="display: none;">
                        <div style="text-align: center;" class="WOTS-banner areas-WOTS-banner">
                            <div class="WOTS-text">
                                Incrowd News</div>
                            <asp:Button ID="btnViewFullInCrowdLatest" Text="View Full" runat="server" CssClass="view-full-button"
                                Style="float: right; margin-right: 10px; margin-top: 26px;"></asp:Button>
                        </div>
                        <div id="postOnAreaDiv" runat="server" class="WOTS-post-message">
                            <telerik:RadTextBox ID="txtInCrowdLatestPost" TextMode="MultiLine" runat="server"
                                cols="34" Rows="4" placeholder="Write a post...">
                            </telerik:RadTextBox>
                            <asp:Button ID="btnInCrowdLatestPost" runat="server" Text="Post" CssClass="post-button">
                            </asp:Button>
                        </div>
                        <%-- <div>
                                                                        <span style="font-size: larger;">In-Crowd Latest</span><span style="float: right;"><asp:LinkButton
                                                                            ID="lbtnViewFullInCrowdLatest" runat="server" Text="View Full" ForeColor="#262626"></asp:LinkButton>&nbsp;&nbsp;&nbsp;</span>
                                                                    </div>--%>
                        <div style="width: 100%; height: 700px; overflow: auto; overflow-x: hidden;">
                            <asp:Repeater ID="inCrowdLatestRepeater" runat="server" DataSourceID="sdCrowdNewsAreaSpecific">
                                <ItemTemplate>
                                    <div class="WOTS-message">
                                        <div class="WOTS-message-header">
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <div class="poster-options">
                                                <a href="">
                                                    <img src="WebContent/theme/images/comment.png">
                                                    <div class="comment-number">
                                                        <asp:Label ID="lblCommentCount" runat="server" Text='<%#Eval("CommentCount").ToString()  %>'></asp:Label></div>
                                                </a><a href="">
                                                    <img src="WebContent/theme/images/recommend.png">
                                                    <div class="recommend-number">
                                                        <asp:Label ID="lblRecommendsCount" runat="server" Text='<%#Eval("RecommendCount").ToString() %>'></asp:Label></div>
                                                </a><a href="">
                                                    <img src="WebContent/theme/images/boost.png">
                                                    <div class="boost-number">
                                                        <asp:Label ID="lblBoostCount" runat="server" Text='<%#Eval("BoostCount").ToString() %>'></asp:Label></div>
                                                </a>
                                            </div>
                                            <div class="message-attribution">
                                                <span class="boarder-message-name">
                                                    <%# Container.DataItem("FriendUserName")%></span> says:
                                            </div>
                                        </div>
                                        <div class="poster-comment">
                                            <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="rpvAllAreaNewsView" runat="server">
            <div id="Div" class="container">
                <div class="update-container" style="height: 100%; margin-bottom: 15px;">
                    <div class="title area-news" style="text-align: left; width: 100%;">
                        <asp:LinkButton ID="joinAreaLinkButton" CssClass="addareabutton" runat="server" Text="Join">
                        </asp:LinkButton>
                        <asp:LinkButton ID="backFromAllAreaNews" runat="server">
                        </asp:LinkButton><span><asp:Label ID="selectedAreaNameLable" runat="server" Text=""></asp:Label></span>
                        <div>
                            <asp:LinkButton ID="incrowdLinkButton" runat="server" Text="Incrowd Latest">
                            </asp:LinkButton>
                            <asp:LinkButton ID="viewIncrowdLinkButton" runat="server" Text="Population">
                            </asp:LinkButton>
                            <asp:LinkButton ID="incrowdPostLinkButton" runat="server" Text="Incrowd Posts">
                            </asp:LinkButton>
                            <asp:Label ID="lblMessage" runat="server" Style="margin-left: 100px; font-size: 12px;"></asp:Label>
                        </div>
                    </div>
                    <%--     areaView IncrowdLatest --%>
                    <telerik:RadMultiPage ID="radMultiPageMiddle" runat="server" SelectedIndex="0">
                        <telerik:RadPageView ID="rpvIncrowdLatest" runat="server" Selected="true">
                            <table width="100%" style="float: left;">
                                <tr>
                                    <td>
                                        <div id='IncrowdViewLatestDiv' style="width: 1290px; height: 430px; overflow: scroll;
                                            overflow-y: hidden; padding: 0 auto; border: 0px solid red;">
                                            <div id="containerIncrowdViewLatest">
                                                <asp:DataList ID="areaSpecificNewsDataList" runat="server" DataSourceID="sdCrowdNewsAreaSpecific"
                                                    Width="100%" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="3">
                                                    <ItemTemplate>
                                                        <div class="items">
                                                            <asp:HiddenField ID="hdnAreaPostID" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                            <div class="crowdnews-post" style="width: 360px;">
                                                                <div class="posted-material">
                                                                    <asp:HyperLink ID="userIncrowdViewHyperLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                        <asp:Image ID="boarderIncrowdViewImage" runat="server" Height="60px" Width="60px"
                                                                            ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                    <div class="poster-options">
                                                                        <a href="#" class="comment-img">
                                                                            <img src="Webcontent/theme/images/comment.png" />
                                                                            <div class="comment-number" style="right: 122px; top: 14px;">
                                                                                <asp:Label ID="lblCommentCount" runat="server" Text='<%#Eval("CommentCount").ToString() %>'></asp:Label></div>
                                                                        </a><a href="#" class="recommend-img">
                                                                            <img src="Webcontent/theme/images/recommend.png" />
                                                                            <div class="recommend-number" style="right: 63px; top: 14px;">
                                                                                <asp:Label ID="lblRecommendsCount" runat="server" Text='<%#Eval("RecommendCount").ToString()  %>'></asp:Label></div>
                                                                        </a><a href="#" class="boost-img">
                                                                            <img src="Webcontent/theme/images/boost.png" />
                                                                            <div class="boost-number" style="right: 4px; top: 14px;">
                                                                                <asp:Label ID="lblBoostCount" runat="server" Text='<%#Eval("BoostCount").ToString() %>'></asp:Label></div>
                                                                        </a>
                                                                    </div>
                                                                    <div class="poster-name">
                                                                        <%# Container.DataItem("FriendUserName")%>
                                                                        Says:
                                                                    </div>
                                                                    <div class="poster-comment">
                                                                        <asp:Label ID="commentIncrowdViewLabel" runat="server" Text='<%# Eval("Text") %>'
                                                                            CssClass="LabelBrownSmall"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </telerik:RadPageView>
                        <%-- View Incrowd--%>
                        <telerik:RadPageView ID="rpvViewInCrowd" runat="server">
                            <div id='viewInCrowdDiv'>
                                <div id="Div5" class="container">
                                    <asp:DataList ID="viewInCrowdDataList" runat="server" DataSourceID="sdViewIncrowd"
                                        RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="5">
                                        <ItemTemplate>
                                            <a href='<%# Eval("UserName", IIf(Convert.ToString(Eval("UserName"))= Convert.ToString(Session("userName")), "../Profile.aspx", "../Profile.aspx?User={0}")) %>'>
                                                <div class="district">
                                                    <asp:Image ID="boarderImage" runat="server" ImageUrl='<%# isAvail(Eval("UserName", "~/Upload/ProfilePics/{0}.jpg")) %>' />
                                                    <span class="DAcontent" style="display: block; color: #788586; text-decoration: none;">
                                                        <%# Eval("UserName") %></span>
                                                </div>
                                            </a>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </div>
                        </telerik:RadPageView>
                        <telerik:RadPageView ID="rpvViewInCrowdPosts" runat="server">
                            <div class="left-column" style="float: left; width: 22%; margin-top: 25px; padding: 1%;">
                                <div id="areaPostDiv" runat="server" visible="false">
                                    <div class="profile-picture">
                                        <a href="../Profile.aspx">
                                            <img id="userProfileImage" runat="server" /></a>
                                    </div>
                                    <div id="boarder-name">
                                        <asp:Label ID="userNameLabel" runat="server"></asp:Label></div>
                                    <%--<div class="WOTS-post-message">
                                        <asp:textbox id="areaSpecificPostTextBox" runat="server" textmode="Multiline" cols="40"
                                            style="border: 1px solid #788586;" rows="4">
                                        </asp:textbox>
                                        <asp:button id="addAreaSpecificPost" runat="server" text="Post" class="post-button" /></div>--%>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td colspan="3">
                                                <asp:TextBox ID="areaSpecificPostTextBox" runat="server" placeholder="Post an update to the area..."
                                                    TextMode="Multiline" Style="border: 1px solid #788586;">
                                                </asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 40%;">
                                                <asp:Button ID="fileAttachButton" runat="server" Text="Upload" Style="display: none;" />
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
                                                <asp:Button ID="addAreaSpecificPost" runat="server" Text="Post" CssClass="attach-button"
                                                    Style="float: right;" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="right-column" style="float: left; width: 78%; margin-top: 25px; overflow-y: scroll;
                                overflow-x: hidden;" id='Div1'>
                                <div id="containerIncrowdViewLatest1">
                                    <asp:DataList ID="areaSpecificNewsDataListPost" runat="server" DataSourceID="sdCrowdNewsAreaSpecific"
                                        Width="100%" RepeatLayout="Table" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <div class="items">
                                                <asp:HiddenField ID="hdnAreaPostID" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                <div class="crowdnews-post" style="width: 315px; margin-left: 5px; margin-right: 0px;">
                                                    <div class="posted-material">
                                                        <asp:HyperLink ID="userIncrowdViewHyperLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="boarderIncrowdViewImage" runat="server" Height="60px" Width="60px"
                                                                ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                        <%-- <div class="poster-options">
                                                            <a href="#" class="comment-img">
                                                                <img src="Webcontent/theme/images/comment.png" />
                                                                <div class="comment-number">
                                                                    (<%#Eval("CommentCount").ToString() %>)</div>
                                                            </a><a href="#" class="recommend-img">
                                                                <img src="Webcontent/theme/images/recommend.png" />
                                                                <div class="recommend-number">
                                                                    (<%#Eval("RecommendCount").ToString()%>')</div>
                                                            </a><a href="#" class="boost-img">
                                                                <img src="Webcontent/theme/images/boost.png" />
                                                                <div class="boost-number">
                                                                    (<%#Eval("BoostCount").ToString() + " Boosts " %>)</div>
                                                            </a>
                                                        </div>
                                                        <div class="poster-name">
                                                            <%# Container.DataItem("FriendUserName")%>
                                                            Says:
                                                        </div>
                                                        <div class="poster-comment">
                                                            <asp:Label ID="commentIncrowdViewLabel" runat="server" Text='<%# Eval("Text") %>'
                                                                CssClass="LabelBrownSmall"></asp:Label>
                                                        </div>--%>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <div class="poster-options">
                                                                        <a class="comment-img" href="#" onclick='<%# "return loadAreaPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                            <img src="WebContent/theme/images/comment.png">
                                                                            <div class="comment-number" style="right: 122px; top: 14px;">
                                                                                (<%# Container.DataItem("CommentCount")%>)</div>
                                                                        </a>
                                                                        <asp:Image ID="recommendImg" runat="server" ImageUrl="WebContent/theme/images/recommend.png"
                                                                            Style="cursor: pointer;" />
                                                                        <div class="recommend-number" style="right: 63px; top: 14px;">
                                                                            <asp:LinkButton ID="lbtnRecommendsNewsAllFull" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                                Style="text-decoration: none; font-size: 7px;" ForeColor="White" CommandName="IRecommend"
                                                                                CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                            </asp:LinkButton>(<asp:Label ID="lblRecommendsCount" runat="server" ForeColor="White"
                                                                                Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>)
                                                                        </div>
                                                                        <a class="boost-img" href="#" onclick='<%# "return loadAreaPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                            <img src="WebContent/theme/images/boost.png">
                                                                            <div class="boost-number" style="right: 4px; top: 14px;">
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
                                                <div id='<%#"popup_box_AreaBoost" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <p>
                                                                    <span style="float: left; font-size: 18px;">Select where to Boost</span><a id="A1"
                                                                        onclick='<%# "return unloadAreaPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'>
                                                                        <img src="Images/btncross.png" alt='Close' style="cursor: pointer; height: 20px;
                                                                            width: 20px; float: right;" /></a></p>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: center;">
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
                                                <div id='<%#"popup_box_AreaPost" +Eval("PostID").ToString()  %>' class="popup_box_allCrowdNews">
                                                    <table width="100%">
                                                        <tr>
                                                            <td style="text-align: right; padding: 5px; float: right;">
                                                                <a id="popupBoxClosePost" onclick='<%# "return unloadAreaPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                    <img src="Images/btncross.png" alt='Close' style="cursor: pointer; width: 20px; height: 20px;" /></a>
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
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </div>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </div>
            </div>
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <%--</contenttemplate>
    </asp:updatepanel>--%>
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

            var $containerIncrowdViewLatest = $('#containerIncrowdViewLatest');

            $containerIncrowdViewLatest.masonry({
                columnWidth: 390,
                itemSelector: '.items'
            });

            var $containerIncrowdViewLatest1 = $('#containerIncrowdViewLatest1');

            $containerIncrowdViewLatest1.masonry({
                columnWidth: 320,
                itemSelector: '.items'
            });
        }
    </script>
    <div>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>
                <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                    Width="600" Height="200">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <asp:SqlDataSource ID="sdBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.District,V.AreaName,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.BankLocation,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer ,V.Offer,V.RaisedTotal,V.AmountRemaining , (SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount   FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1) AND V.AmountRemaining>0  AND ((V. Boardname Like '%' +@District+'%') OR (V. District Like '%' +@District + '%') )  Order By V.CommentDate desc">
            <SelectParameters>
                <%--  <asp:SessionParameter Name="District" SessionField="District" DefaultValue=""/>--%>
                <asp:Parameter Name="District" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdSearchValue" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.District,V.AreaName,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.BankLocation,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer ,V.Offer,V.RaisedTotal,V.AmountRemaining , (SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount   FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1) AND V.AmountRemaining>0  AND (V. Boardname Like '%' +@searchValue+'%')  Order By V.CommentDate desc">
            <SelectParameters>
                <%--  <asp:SessionParameter Name="District" SessionField="District" DefaultValue=""/>--%>
                <asp:Parameter Name="searchValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsLoadBordByArea" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.District,V.AreaName,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.BankLocation, V.status,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer,V.Offer,V.RaisedTotal,V.AmountRemaining,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount ,(SELECT count(*)FROM(SELECT AreaID from UserAreas where UserAreas.AreaID=V.AreaID and V.AreaName=@Area)as AreaCount) areaCount  FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE  V.status=1 AND V.AmountRemaining>0 AND V.AreaName=@Area Order By V.CommentDate desc">
            <SelectParameters>
                <asp:Parameter Name="Area" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT districtID ,DistrictName,row_number()over(order by D.SortOrder) as rownumber,  (Select COUNT(DistrictID) from UserDistricts UD  where UD.DistrictID = D.DistrictID and UD.UserID=@UserID) as IsExists,(Select COUNT(DistrictID) from UserDistricts UD  where UD.DistrictID = D.DistrictID) as UserCount  FROM Districts D  Order by D.DistrictName">
            <SelectParameters>
                <asp:Parameter Name="UserID" />
                <%--<asp:SessionParameter Name="areaID" SessionField="areaID" />--%>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName,(Select COUNT(Areaid) from UserAreas UD  where UD.areaid = A.areaID and UD.UserID=@UserID) as IsExists FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <SelectParameters>
                <asp:SessionParameter Name="districtID" SessionField="districtID" />
                <asp:Parameter Name="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
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
        <asp:SqlDataSource ID="sdUserAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            InsertCommand="INSERT INTO UserAreas (AreaID,UserID)VALUES(@AreaID,@UserID)"
            DeleteCommand="DELETE FROM UserAreas WHERE UserID =@UserID AND AreaID =@AreaID">
            <InsertParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="AreaID" />
            </InsertParameters>
            <DeleteParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="AreaID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdUpdates" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="select COUNT(commentID) CommentCount from BoardComments where cast(CommentDate as date)=cast(getdate() as date)">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdDistrictDesc" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT Description,Quotation FROM districts WHERE districtID=@districtID">
            <SelectParameters>
                <asp:SessionParameter Name="districtID" SessionField="districtID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCrowdNewsAll" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT U.PostID,CASE WHEN LEN(U.Text) > 70 THEN substring(U.Text,0,65) + '...' ELSE U.Text END AS Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID  order by u.DatePosted desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCrowdNews" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID where (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) order by u.DatePosted desc">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCheckBoardName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCheckuserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select *  from Users"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdViewIncrowd" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="select *,(SELECT Username from Users where UserID=UA.UserID) as UserName from UserAreas UA where UA.areaID=@areaID">
            <SelectParameters>
                <asp:SessionParameter Name="areaID" SessionField="areaID" />
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
        <asp:SqlDataSource ID="sdCrowdNewsDistrictSpecific" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="select distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from userposts U inner join Boarders B ON (U.UserID=B.userId1 or U.Userid=B.Userid2) and B.Status=1 and (B.UserID1=@useriD or B.UserID2=@useriD) left join vwBoardInfo v  ON (U.Text lIke '%@' +V.boardname+'@%') where v.district=@District or U.Text like '%@'+@District+'%' order by u.DatePosted desc">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:SessionParameter Name="District" SessionField="District" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCrowdNewsAreaSpecific" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID where (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) and U.Text like '%@'+@Area+'%' order by u.DatePosted desc">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:SessionParameter Name="Area" SessionField="Area" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdLoadBoardsByLevel" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="LoadBoardsByLevel" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="Levels" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdLoadBoardsMostRaised" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BankLocation,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.AreaName,V.RecentComment,V.CommenterUserID,V.DirectoryName, V.status,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer,V.Offer,V.RaisedTotal,V.AmountRemaining,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount   FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE  V.status=1 AND V.AmountRemaining>0 AND (V.RaisedTotal is not null or V.RaisedTotal>0) Order By V.CommentDate desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdLoadBoardsMostWatched" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.BankLocation,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,(ISNULL(V.Watches,0)+ISNULL(V.Investors,0)) as InvWatCount,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,ISNULL(V.Watches,0) As Watches,ISNULL(V.Comments,0) as Comments,ISNULL(V.Investors,0) as Investors,V.District,V.AreaName,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer ,V.Offer,V.RaisedTotal,V.AmountRemaining , (SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount FROM vwBoardInfo V INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1) AND V.AmountRemaining>0 and (ISNULL(V.Watches,0)+ISNULL(V.Investors,0))>0 Order By InvWatCount desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdLoadBoardsMostActive" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.BankLocation,V.UserID,V.BoardID,V.Boardname,V.YoutubeVideoUrl,U.UserName,(ISNULL(V.Watches,0)+ISNULL(V.Investors,0)) as InvWatCount,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,ISNULL(V.Watches,0) As Watches,ISNULL(V.Comments,0) as Comments,ISNULL(V.Investors,0) as Investors,V.District,V.AreaName,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.InvestmentTypeID,V.invType,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer ,V.Offer,V.RaisedTotal,V.AmountRemaining , (SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount FROM vwBoardInfo V INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1) AND V.AmountRemaining>0 and Comments>0 Order By Comments desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdGetDistrictName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT D.DistrictName,D.DistrictID FROM districts D INNER JOIN Areas A ON D.districtID=A.districtID  WHERE A.AreaName=@AreaName">
            <SelectParameters>
                <asp:Parameter Name="AreaName" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAllAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT areaID,AreaName FROM Areas"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAllBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT top 12 CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.BankLocation,V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) >145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Watches,V.Comments,V.YoutubeVideoUrl,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer,V.Offer,V.invType,V.RaisedTotal,V.AmountRemaining,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount FROM vwBoardInfo   V  INNER JOIN Users U ON v.UserID =U.UserID WHERE V.Status=1 Order by case when V.CommentDate>V.DateActivated then V.CommentDate else V.DateActivated end desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="Select DistrictID,DistrictName from Districts"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdIRecommend" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="UserPostReplies_Recommend" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
                <asp:Parameter Name="Recommend" />
            </SelectParameters>
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
    </div>
</asp:Content>
