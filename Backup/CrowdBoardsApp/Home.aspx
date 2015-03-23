<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home.aspx.vb" Inherits="CrowdBoardsApp.Home" %>

<%@ Register TagPrefix="uc1" TagName="TitleBar" Src="~/uc_Notifications.ascx" %>
<%@ Register TagPrefix="uc2" TagName="TitleBar2" Src="~/uc_PendingRequests.ascx" %>
<%@ Register TagPrefix="uc3" TagName="TitleBar3" Src="~/uc_UnreadMessages.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width" />
    <link href="WebContent/styles/main.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
    <!--Add the following script at the bottom of the web page (before </html>)-->
<%--<script type="text/javascript" defer="defer" src="https://mylivechat.com/chatwidget.aspx?hccid=72490377"></script>--%>
    <script>
        function getValue() {

            var searchValue = document.getElementById("searchTextBox").value;
            document.getElementById("areaSeachValueHdn").value = searchValue;
            return true;
        }
    </script>
    <script type="text/javascript">
        function setActive() {
            $('.navbar>li').removeClass('focus');
            $('a[href=' + location.pathname.substring(1) + ']').parent().addClass('focus');
        }
    </script>

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
    <style type="text/css">
        .size1of4
        {
            float: left;
            width: 25%;
        }
        
        .thermometer
        {
            width: 100%;
            height: 150px;
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
        .item
        {
            width: 24%;
        }
        .item.w2
        {
            width: 60%;
        }
        .itemAllNews
        {
            width: 15%;
        }
        .itemAllNews.w2
        {
            width: 50%;
        }
        .itemAllNewsFull
        {
            width: 15%;
        }
        .itemAllNewsFull.w2
        {
            width: 50%;
        }
    </style>
    <style>
        .accept-button, .decline-button
        {
            background-color: #75b4c6;
            border: medium none;
            border-radius: 5px;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.5) inset;
            color: #ffffff;
            cursor: pointer;
            font-size: 10px;
            font-weight: 600;
            margin: 0;
            padding: 4px 8px 5px;
        }
        .post-button:hover, .attach-button:hover, .invest-button:hover, .accept-button:hover, .decline-button:hover
        {
            background-color: #3C6C79;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
    <style type="text/css">
        .ShowBoard
        {
            overflow-x: hidden;
            height: 280px;
            overflow: auto;
        }
        .HideBoard
        {
            height: 370px;
        }
        .ShowBoarder
        {
            overflow-x: hidden;
            height: 118px;
            overflow: auto;
            width: 90%;
        }
        .HideBoarder
        {
            height: 118px;
            overflow: hidden;
            width: 90%;
        }
        .popup_box_all
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 520px;
            width: 600px;
            left: 400px;
            top: 70px;
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
        .linkCss
        {
            color: #ffffff;
            background-color: #75b4c6;
            margin: 2px;
            border: 2px solid #75b4c6;
            border-radius: 5px;
            padding: 2px;
        }
        .linkCss:hover
        {
            border: 2px solid #3C6C79;
            background-color: #3C6C79;
        }
    </style>
</head>
<body style="z-index: 120; margin: 0px;">
    <form id="form1" runat="server">
    <input id="hdnNotification" type="hidden" value="0" />
    <input id="hdnAreaID" type="hidden" value="0" runat="server" />
    <input id="hdnType" type="hidden" value="0" runat="server" />
    <asp:button id="joinArea" runat="server" style="display: none;" />
    <asp:button id="btnAddDistrctHidden" runat="server" style="display: none;" />
    <asp:scriptmanager runat="server" id="RadScriptManager1">
        <scripts>
            <%-- <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />--%>
        </scripts>
    </asp:scriptmanager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date(); a = s.createElement(o),
                    m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-38612034-1', 'crowdboarders.com');
            ga('send', 'pageview');

        </script>
        <script type="text/javascript">


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

            function unloadPopupBoxBoost(i) {

                $('#popup_box_Boost' + i).fadeOut("slow");

                return false;
            }

            function loadPopupBoxBoost(i) {
                $('#popup_box_Boost' + i).fadeIn("slow");
                return false;

            }

            function unloadPopupBoxBoostAll(i) {

                $('#popup_box_Boost_All' + i).fadeOut("slow");

                return false;
            }

            function loadPopupBoxBoostAll(i) {
                //alert(i);
                $('#popup_box_Boost_All' + i).fadeIn("slow");
                return false;

            }

            function unloadPopupBoxPost(i) {

                $('#popup_box_post' + i).fadeOut("slow");

                return false;
            }

            function loadPopupBoxPost(i) {
                $('#popup_box_post' + i).fadeIn("slow");
                return false;

            }
            function unloadPopupBoxPostAll(i) {

                $('#popup_box_postAll' + i).fadeOut("slow");

                return false;
            }

            function loadPopupBoxPostAll(i) {
                $('#popup_box_postAll' + i).fadeIn("slow");
                return false;

            }
            function fileAttach(sender, args) {
                document.getElementById("<%= fileAttachButton.ClientID %>").click();

            }



            function unloadPopupBoxVideo() {

                $('#popup_box_Video').fadeOut("slow");

                return false;
            }

            function loadPopupBoxVideo() {

                $('#popup_box_Video').fadeIn("slow");
                return false;

            }



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

            function loadPopupBoxDiscricts() {

                $('#popup_box_AddRemove').fadeIn("slow");
                return false;
            }
            function loadPopupBoxArea(i) {

                $('#popup_Area' + i).fadeIn("slow");
                return false;

            }


            function unloadPopupBoxArea(i) {



                $('#popup_Area' + i).fadeOut("slow");

                loadPopupBoxDiscricts();
                return false;
            }
            function loadPopupBoxAddArea(area, type) {
                document.getElementById('hdnType').value = type;
                document.getElementById('hdnAreaID').value = area;
                var btn = document.getElementById("<%= joinArea.ClientID %>");
                btn.click();
                return false;
            }
            function loadPopBoxAddArea(type) {
                document.getElementById('hdnType').value = type;

                var btn = document.getElementById("<%= joinArea.ClientID %>");
                btn.click();
                return false;
            }


            function unloadPopupBoxOnlyDistrict() {

                $('#popup_DistrictDiv').fadeOut("slow");

                return false;
            }

            function loadPopupBoxOnlyDistrict() {

                $('#popup_DistrictDiv').fadeIn("slow");
                return false;
            }

            function anchotInvestClick(board) {
                window.location.replace("" + board + "?fromSearch=1#investDiv");
            }
        </script>
        <script type="text/javascript">
            function OnClientClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
            }
            function openRadWindow(args) {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwComment.aspx?PostID=" + args;
                manager.open(url, "RadWindow1");
                return false;

            }



            function showBoarders() {
                var boardersDiv = document.getElementById("boardersDiv")
                var ImageBtnShow = document.getElementById("ImageBtnShow")

                if (boardersDiv.className == "HideBoarder") {
                    boardersDiv.className = "ShowBoarder";
                    ImageBtnShow.src = "Images/arrowUp.png";
                }

                else {
                    boardersDiv.className = "HideBoarder";
                    ImageBtnShow.src = "Images/arrowDownHome.png";
                }

                return false;
            }
        </script>
        <script type="text/javascript">
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                loadNew();
            });

        </script>
        <script type="text/javascript">
            function clickRadUploadbtn() {
                $telerik.$(".ruFileInput").click();

            }
          
        </script>
    </telerik:RadScriptBlock>
    <div class="popup_box_all" id="popup_DistrictDiv">
        <div style="text-align: right;">
            <asp:linkbutton id="LinkButton1" forecolor="Red" runat="server" onclientclick="return unloadPopupBoxOnlyDistrict();">
                <img src="Images/btncross.png" alt="X" height="25px" width="25px" /></asp:linkbutton></div>
        <div class="span12">
            <asp:datalist id="districtAddDataList" runat="server" repeatcolumns="5" repeatlayout="Table"
                datasourceid="sdDistricts">
                <itemtemplate>
                 <%-- <div style="text-align: center; min-height: 50px;" class="linkCss">--%>
                    <div class="other-boarder-image">
                        <table width="100%" border="0">
                            <tr>
                                <td style="width: 30%;">
                                    <div style="width: 100%; height: 85%; padding: 5px;">
                                        <div style="background-image: url('<%# isAvail(Eval("districtID", "Upload/DistrictPics/{0}.jpg")) %>');
                                            height: 50px; width: 80px; text-align: center; background-repeat: no-repeat;
                                            overflow: hidden; background-size: 100% 100%;">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <span class="other-boarder-name">
                                        <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                            OnClientClick="return false;" ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#75B4C6"))%>'></asp:LinkButton>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton ID="btnAddDistrict" Visible='<%# IIF(IsDBNull(Eval("IsExist")),true,false) %>'
                                        CommandName="IAddDistrict" CommandArgument='<%#Eval("districtID")%>' ForeColor="#75b4c6"
                                        runat="server" Text="Add"></asp:LinkButton>
                                    <asp:ImageButton ID="btnRemoveArea" runat="server" ImageUrl="~/Images/delete.png"
                                        Visible='<%# IIF(IsDBNull(Eval("IsExist")),false,true) %>' Height="12" Width="12"
                                        CommandName="IRemoveDistrict" CommandArgument='<%# Container.DataItem("districtID")%>' />
                                </td>
                            </tr>
                        </table> 
                        </div>
                   <%-- </div>--%>
                   
                </itemtemplate>
            </asp:datalist>
        </div>
    </div>
    <div class="popup_box_all" id="popup_box_AddRemove">
        <div style="text-align: right;">
        </div>
        <div class="span12">
            <table width="100%" border="0" cellspacing="6">
                <tr>
                    <td>
                        <p>
                            <span style="float: left; font-size: 18px;">Please Select District To View Areas</span>
                            <asp:linkbutton id="lbtnCloseDistrict" forecolor="Red" runat="server" onclientclick="return unloadPopupBoxDistricts();">
                                <img src="Images/btncross.png" alt="X" height="25px" width="25px" style="float: right;" /></asp:linkbutton></p>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                    <hr />
                        <div style="margin-top: 10px; margin-left: 50px;">
                            <asp:label id="Label1" runat="server" font-size="16"></asp:label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:datalist id="districtDataList" runat="server" datasourceid="sdDistricts" repeatcolumns="5"
                            repeatlayout="Table">
                            <itemtemplate>
                                <div class="other-boarder-image">
                                    <table width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <div style="width: 100%; height: 85%; padding: 5px;">
                                                    <div style="background-image: url('<%# isAvail(Eval("DistrictID", "Upload/DistrictPics/{0}.jpg")) %>');
                                                        height: 70px; color: #75B4C6; width: 80px; text-align: center; background-repeat: no-repeat;
                                                        overflow: hidden; background-size: 100% 100%;">
                                                    </div>
                                                    <asp:HiddenField ID="hdnDistrictName" runat="server" Value='<%#Eval("DistrictName")%>' />
                                                    <asp:HiddenField ID="hdnDistrictID" runat="server" Value='<%#Eval("districtID")%>' />
                                                    <span class="other-boarder-name">
                                                        <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                                            ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#75B4C6"))%>'></asp:LinkButton></span>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="popup_box_all" id='<%#"popup_Area" +Eval("districtID").ToString()  %>'>
                                    <div style="background-color: #ffffff;">
                                        <asp:Label ID="districtNameLabel" runat="server" CssClass="LabelBlueLarge" Font-Size="16"></asp:Label>
                                        <div class="span12">
                                            <div style="vertical-align: top;">
                                                <img id="scroll_L_Arrow" onclick='<%# "return unloadPopupBoxArea("+ Eval("districtID").ToString() + ");" %>'
                                                    style="cursor: pointer;" src="WebContent/Theme/images/backImage.png">
                                                <span class="LabelheadingWhite" style="vertical-align: top;">&nbsp;&nbsp;&nbsp;Now Select
                                                    an Area to Join</span>
                                               <asp:Button ID="btnAddArea" style="float:right;" cssClass="decline-button" runat="server" Text="ADD" OnClientClick='<%# "return loadPopBoxAddArea(&#39;Add&#39;);" %>' />
                                            </div>
                                          <hr />
                                            <asp:DataList ID="areaDataList" runat="server" RepeatColumns="5" RepeatLayout="Table">
                                                <ItemTemplate>
                                                    <div class="other-boarder-image" style="height: 120px;">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td style="width: 40%;">
                                                                    <div style="width: 100%; height: 85%; padding: 5px;">
                                                                        <div style="background-image: url('<%# isAvail(Eval("areaid", "Upload/AreasPics/{0}.jpg")) %>');
                                                                            height: 50px; color: #75b4c6; width: 80px; text-align: center; background-repeat: no-repeat;
                                                                            overflow: hidden; background-size: 100% 100%;">
                                                                        </div>
                                                                        <asp:HiddenField ID="hdnAreaName" runat="server" Value='<%#Eval("AreaName")%>' />
                                                                        <asp:HiddenField ID="hdnAreaID" runat="server" Value='<%#Eval("AreaID")%>' />
                                                                    </div>
                                                                    <span class="other-boarder-name">
                                                                        <asp:LinkButton ID="areaNameLinkButton" runat="server" Text='<%#Eval("AreaName")%>'
                                                                            OnClientClick="return false;" ForeColor='<%# IIf(Eval("AreaName").ToString() = AreaName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#75b4c6"))%>'></asp:LinkButton>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div>
                                                                        <asp:CheckBox ID="chkArea" runat="server" Visible='<%# IIF(IsDBNull(Eval("IsExist")),true,false) %>' />
                                                                        <%-- <asp:LinkButton ID="btnAddArea" Visible='<%# IIF(IsDBNull(Eval("IsExist")),true,false) %>'
                                                                            ForeColor="#75b4c6" runat="server" Text="Join" OnClientClick='<%# "return loadPopupBoxAddArea("+ Eval("AreaID").ToString() + ",&#39;Add&#39;);" %>'></asp:LinkButton>--%>
                                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/delete.png"
                                                                            Visible='<%# IIF(IsDBNull(Eval("IsExist")),false,true) %>' Height="12" Width="12"
                                                                            OnClientClick='<%# "return loadPopupBoxAddArea("+ Eval("AreaID").ToString() + ",&#39;Remove&#39;);" %>' />
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </div>
                                    </div>
                                </div>
                            </itemtemplate>
                        </asp:datalist>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:panel id="headPanel" runat="server" defaultbutton="lbtnSearch">
        <asp:hiddenfield id="areaSeachValueHdn" runat="server">
        </asp:hiddenfield>
        <div id="navbar">
            <ul>
                <li>
                    <asp:linkbutton id="liHome" runat="server" text="My Console" class="focus">
                    </asp:linkbutton></li>
                <li>
                    <asp:linkbutton id="liSearch" runat="server" text="All Districts">
                    </asp:linkbutton></li>
                <li>
                    <asp:linkbutton id="liCrowdNews" runat="server" text="Crowd News">
                    </asp:linkbutton></li>
                <li id="last"><a href="">
                    <img src="WebContent/images/cogs.png" /></a>
                    <ul>
                        <li><a class="menu-link" href="FAQ.aspx">FAQ</a></li>
                        <li id="isAdminli" runat="server"><a class="menu-link" href="Admin/Users.aspx">ADMIN</a></li>
                        <li><a class="menu-link" href="mailto:info@crowdboarders.com" target="_top">CONTACT
                            US</a></li>
                        <li>
                            <asp:linkbutton id="lbtlogout" runat="server" class="menu-link" text="Log Out">
                            </asp:linkbutton></li>
                    </ul>
                </li>
                <li class="menu-image" id="search">
                    <input name="q" type="text" size="40" placeholder="Search..." runat="server" id="searchBoardsTextBox" />
                </li>
                <li class="menu-image"><a href=""><span>
                    <asp:label id="requestsCountLabel" runat="server"></asp:label></span><img src="../Webcontent/theme/images/crowd.png" /></a>
                    <ul class="messages-menu" style="min-height: 180px; overflow-y: scroll; width: 467px;
                        right: -210px !important; z-index: 100; background: none repeat scroll 0 0 rgba(60, 60, 60, 0.8);">
                        <li style="margin-left: 0;">Boarder Requests</li>
                        <asp:label id="lblMessage" runat="server" visible="false"></asp:label>
                        <asp:repeater id="boardersRepeater" runat="server" datasourceid="sdPendingRequests">
                            <itemtemplate>
                                <li style="margin-left: 0;"><span class="new-notification"><span class="new-friend">
                                    <div class="boarder-message">
                                        <div class="boarder-message-image">
                                            <asp:HiddenField ID="requesterEmailID" runat="server" Value='<%# Container.DataItem("Email")%>' />
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("senderName","~/Profile.aspx?User={0}") %>'>
                                                <asp:Image ID="nonFriendPic" runat="server" ToolTip='<%# Container.DataItem("senderName")%>'
                                                    Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("senderName", "~/Upload/ProfilePics/{0}.jpg")) %>' />
                                            </asp:HyperLink>
                                        </div>
                                        <div class="boarder-message-text">
                                            <div class="boarder-message-name">
                                                <%# Container.DataItem("senderName")%>
                                            </div>
                                            Invited you to connect.
                                            <table cellpadding="5">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="decline-button"
                                                            CommandName="IAccept" CommandArgument='<%# Container.DataItem("senderID")%>' />
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="declineButton" runat="server" Text="Decline" CssClass="decline-button"
                                                            CommandName="IDecline" CommandArgument='<%# Container.DataItem("senderID")%>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </span></span></li>
                            </itemtemplate>
                        </asp:repeater>
                        <asp:repeater id="crowdBoardInvitationsRepeater" runat="server" datasourceid="sdsCrowdBoardInvites">
                            <itemtemplate>
                                <li style="margin-left: 0;">
                                <li style="margin-left: 0;"><span class="new-notification"><span class="new-friend">
                                    <div class="boarder-message">
                                        <div class="boarder-message-image">
                                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("OwnerName","~/Profile.aspx?User={0}") %>'>
                                                <asp:Image ID="Image1" runat="server" ToolTip='<%# Container.DataItem("OwnerName")%>'
                                                    Height="50px" Width="50px" ImageUrl='<%# isAvail(Eval("OwnerName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                        </div>
                                        <div class="boarder-message-text">
                                            <div class="boarder-message-name">
                                                <%# Container.DataItem("OwnerName")%>
                                            </div>
                                            Invited you to his/her
                                            <br />
                                            CrowdBoard team for &nbsp;
                                            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                ForeColor="#99CCFF" Text='<%# Eval("BoardName", "@{0}@") %>'>                                                                     
                                            </asp:HyperLink>
                                            <table cellpadding="5">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="acceptButton" runat="server" Text="Accept" CssClass="decline-button"
                                                            CommandName="IAccept" CommandArgument='<%# Container.DataItem("BoardID")%>' />
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="declineButton" runat="server" Text="Decline" CssClass="decline-button"
                                                            CommandName="IDecline" CommandArgument='<%# Container.DataItem("BoardID")%>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </span></span></li>
                            </itemtemplate>
                        </asp:repeater>
                        <input id="hdnPendingRequest" type="hidden" value="0" />
                    </ul>
                    <ul class="messages-menu" style="width: 467px; margin-top: 180px; right: -210px !important;">
                        <li style="margin-left: 0; bottom: 0; right: 0px !important; width: 466px !important;">
                            <a class="menu-link" style="width: 466px !important;" href="../BoarderRequests.aspx">
                                View All Boarder Requests</a></li>
                    </ul>
                </li>
                <li class="menu-image"><a href=""><span>
                    <asp:label id="lblUpdates" runat="server"></asp:label></span><img src="../Webcontent/theme/images/email.png" /></a>
                    <ul class="messages-menu" style="min-height: 180px; overflow-y: scroll; width: 467px;
                        right: -210px !important; z-index: 100; background: none repeat scroll 0 0 rgba(60, 60, 60, 0.8);">
                        <li style="margin-left: 0;">Messages</li>
                        <asp:repeater id="messageRepeater" runat="server" datasourceid="sdMessages">
                            <itemtemplate>
                                <li class="boarder-message-li" style="margin-left: 0;">
                                    <div class="boarder-message">
                                        <div class="boarder-message-image">
                                            <a href='<%# Eval("FromUserName","Profile.aspx?User={0}") %>'>
                                                <img src='<%# isAvail(Eval("FromUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' title='<%# Container.DataItem("FromUserName")%>' />
                                            </a>
                                        </div>
                                        <div class="boarder-message-timestamp">
                                            <%# Container.DataItem("Datesent")%>
                                        </div>
                                        <div class="boarder-message-text">
                                            <div class="boarder-message-name">
                                                <%# Container.DataItem("FromUserName")%>
                                                says</div>
                                            <%# Container.DataItem("Text")%>
                                        </div>
                                    </div>
                                </li>
                            </itemtemplate>
                        </asp:repeater>
                        <%--<li style="margin-left: 0; bottom: 0; right: 0px !important;"><a class="menu-link" href="../Messages.aspx">
                            View All Messages</a></li>--%>
                    </ul>
                    <ul class="messages-menu" style="width: 467px; margin-top: 180px; right: -210px !important;">
                        <li style="margin-left: 0; bottom: 0; right: 0px !important; width: 466px !important;">
                            <a class="menu-link" style="width: 466px !important;" href="../Messages.aspx">View All
                                Messages</a></li>
                    </ul>
                </li>
                <li class="menu-image"><a href=""><span>
                    <asp:label id="countNotification" runat="server"></asp:label></span><img id="crowdboard-logo"
                        src="../Webcontent/theme/images/crowdboarders.png" /></a>
                    <ul class="messages-menu" style="min-height: 180px; overflow-y: scroll; width: 467px;
                        right: -210px !important; z-index: 100; background: none repeat scroll 0 0 rgba(60, 60, 60, 0.8);">
                        <li style="margin-left: 0;">Notifications</li>
                        <asp:repeater id="notificationsRepeater" runat="server">
                            <itemtemplate>
                                <li style="margin-left: 0;" id="Tr4" runat="server" visible='<%# IIf(Eval("type")="fra",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("Users") %></a></span> is now friend with <span class="current-user"><a
                                            href='<%# "Profile.aspx?User="+Session("userName").ToString() %>'>
                                            <%# Session("userName").ToString() %></a></span> </span></li>
                                <li style="margin-left: 0;" id="Tr6" runat="server" visible='<%# IIf(Eval("type")="frPending",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("Users") %></a></span> has sent boarder request to you </li>
                                <li style="margin-left: 0;" id="TrComments" runat="server" visible='<%# IIf(Eval("type")="postComments",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("Users") %></a></span> comments on <span class="current-user"><a href='<%# "Profile.aspx?User="+Session("userName").ToString() %>'>
                                            <%# Session("userName").ToString() %></a></span> Post </span></li>
                                <li style="margin-left: 0;" id="TrPosts" runat="server" visible='<%# IIf(Eval("type")="postBoosts",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("Users") %></a> </span>Boosts <span class="current-user"><a href='<%# "Profile.aspx?User="+Session("userName").ToString() %>'>
                                            <%# Session("userName").ToString() %></a></span> Post </span></li>
                                <li style="margin-left: 0;" id="TrRecommand" runat="server" visible='<%# IIf(Eval("type")="postRecommend",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("Users") %></a> </span>Recommends <span class="current-user"><a href='<%# "Profile.aspx?User="+Session("userName").ToString() %>'>
                                            <%# Session("userName").ToString() %></a></span> Post </span></li>
                            </itemtemplate>
                        </asp:repeater>
                        <asp:repeater id="recentActivityOnBoardsRepeater" runat="server">
                            <itemtemplate>
                                <li style="margin-left: 0;" id="investTR1" runat="server" visible='<%# IIf(Eval("type")="i",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just invested in <span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> a crowdboard you have invested in or watching
                                    </span></li>
                                <li style="margin-left: 0;" id="commentTR1" runat="server" visible='<%# IIf(Eval("type")="c",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just commented on <span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> a crowdboard you are watchning or invested
                                        in </span></li>
                                <li style="margin-left: 0;" id="recommendTR1" runat="server" visible='<%# IIf(Eval("type")="r",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just recommended <span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> a crowdboard you are watchning or invested
                                        in </span></li>
                                <li style="margin-left: 0;" id="watchTr1" runat="server" visible='<%# IIf(Eval("type")="w",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just watched <span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> a crowdboard you are watchning or invested
                                        in </span></li>
                                <li style="margin-left: 0;" id="investTR2" runat="server" visible='<%# IIf(Eval("type")="mybi",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just invested in your board<span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> </span></li>
                                <li style="margin-left: 0;" id="commentTR2" runat="server" visible='<%# IIf(Eval("type")="mybc",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just commented on your board<span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> </span></li>
                                <li style="margin-left: 0;" id="recommendTR2" runat="server" visible='<%# IIf(Eval("type")="mybr",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName")%></a> </span>has just recommended your board<span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> </span></li>
                                <li style="margin-left: 0;" id="watchTr2" runat="server" visible='<%# IIf(Eval("type")="mybw",true,false) %>'>
                                    <span class="new-notification"><span class="new-friend"><a href='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                        <%# Eval("userName") %></a> </span>has just watched your board<span class="current-user"><a
                                            href='<%# Eval("DirectoryName", "{0}") %>'>
                                            <%# Eval("BoardName") %></a></span> </span></li>
                            </itemtemplate>
                        </asp:repeater>
                        <%-- <li style="margin-left: 0; bottom: 0; right: 0px !important;"><a class="menu-link" href="../Notifications.aspx">
                            View All Notifications</a></li>--%>
                    </ul>
                    <ul class="messages-menu" style="width: 467px; margin-top: 180px; right: -210px !important;">
                        <li style="margin-left: 0; bottom: 0; right: 0px !important; width: 466px !important;">
                            <a class="menu-link" style="width: 466px !important;" href="../Notifications.aspx">View
                                All Notifications</a></li>
                    </ul>
                </li>
                <li class="navbar-responsive">
                    <img src="../Webcontent/theme/images/menu.png" />
                    <ul>
                        <li><a class="menu-link" href="../Home.aspx">My Console</a></li>
                        <li><a class="menu-link" href="../Search.aspx">All Districts</a></li>
                        <li><a class="menu-link" href="../CrowdNews.aspx">Crowd News</a></li>
                        <li><a class="menu-link" href="../Notifications.aspx">Notifications</a></li>
                        <li><a class="menu-link" href="../Messages.aspx">Messages</a></li>
                        <li><a class="menu-link" href="../BoarderRequests.aspx">Boarder Requests</a></li>
                    </ul>
                </li>               

            </ul>
            <asp:linkbutton id="lbtnSearch" runat="server" text="Search" style="display: none;">
            </asp:linkbutton>
        </div>
    </asp:panel>
    <div class="container first_block" style="height: 590px;">
        <telerik:RadMultiPage ID="radMultiPageCrowdNewFull" runat="server" SelectedIndex="0">
            <%-- to remove  <telerik:RadPageView ID="radPageViewCrowdNewsFull" runat="server">--%>
            <%--<telerik:RadPageView ID="radPageViewCrowdNewsFull" runat="server">
                <div>
                    <div id='messageFull' style="min-height: 420px; color: #788586; float: left; width: 100%;">
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <span style="padding: 4px;">Crowd News</span>
                                </td>
                                <td style="text-align: right; padding: 5px;">
                                    <asp:linkbutton id="lbtnCloseCrowdNewsAllFull" runat="server" forecolor="#75B4C6"
                                        text="Close CrowdNews">
                                    </asp:linkbutton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <div class="container second_block">
                                                    <div class="latest-crowd-boards group" style="margin: 5px;">
                                                        <div id='slide-wrapFull' style="width: 1255px; height: 530px; overflow: hidden; padding: 0 auto;">
                                                            <asp:updatepanel id="UpdatePanel1" runat="server">
                                                                <contenttemplate>
                                                                    <div id="containerCrowdNewsFull">
                                                                        <asp:DataList ID="crowdNewsAllDataListFull" runat="server" RepeatDirection="Horizontal"
                                                                            RepeatLayout="Table">
                                                                            <ItemTemplate>
                                                                                <div class="itemAllNewsFull">
                                                                                    <div style="width: 300px;">
                                                                                        <div class="crowdboard-container group">
                                                                                            <asp:HiddenField ID="hdnPostIDFull" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                                                            <div style="background-color: #f6f6f6; width: 100%; color: #788586;">
                                                                                                <table width="100%" border="0" style="font-size: 14px;">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                                                <tr>
                                                                                                                    <td rowspan="2">
                                                                                                                        <asp:HyperLink ID="userLinkFull" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                                                            <div class="other-boarder-image" style="height: 64px; width: 64px;">
                                                                                                                                <asp:Image ID="boarderPicFull" runat="server" Height="60px" Width="60px" Style="margin-top: 2px;"
                                                                                                                                    ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></div>
                                                                                                                        </asp:HyperLink>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        &nbsp;
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <span style="cursor: text;">
                                                                                                                            <%# Container.DataItem("FriendUserName")%>
                                                                                                                            Says:</span>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td colspan="1">
                                                                                                            <div style="min-height: 60px;">
                                                                                                                &nbsp;</div>
                                                                                                        </td>
                                                                                                        <td style="vertical-align: top; text-align: right;">
                                                                                                            <div style="cursor: text;">
                                                                                                                <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                                                                                            </div>
                                                                                                            <div style="min-height: 43px;">
                                                                                                                &nbsp;</div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr id="Tr2" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
                                                                                                        <td colspan="3">
                                                                                                            <table width="100%">
                                                                                                                <tr>
                                                                                                                    <td style="width: 10%;">
                                                                                                                    </td>
                                                                                                                    <td style="width: 80%;">
                                                                                                                        <asp:Image ID="Image2Full" runat="server" Height="200px" Width="100%" ImageUrl='<%# isAvail(Eval("AttachedFileName", "~/Upload/UserPostsFiles/{0}")) %>' />
                                                                                                                    </td>
                                                                                                                    <td style="width: 10%;">
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="2">
                                                                                                            <asp:Label ID="lblCommentFull" Style="font-size: 14px;" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            &nbsp;
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr style="cursor: pointer;" onclick='<%# "return loadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                        <td colspan="3">
                                                                                                             <div class="crowdboard-mini-console" style="height:auto;">
                                                                                                            <div class="poster-options">
                                                                                                                <table width="100%" border="0">
                                                                                                                    <tr>
                                                                                                                        <td>
                                                                                                                            <img src="WebContent/images/comment.png">
                                                                                                                            <div class="comment-number">
                                                                                                                                <asp:Label ID="lblCommentsCountFull" runat="server" Text='<%# Container.DataItem("CommentCount")%>'></asp:Label></div>
                                                                                                                              Comments
                                                                                                                        </td>
                                                                                                                        <td>
                                                                                                                            <img src="WebContent/images/recommend.png">
                                                                                                                            <div class="recommend-number">
                                                                                                                                <asp:Label ID="lblRecommendCountFull" runat="server" Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label></div>
                                                                                                                              Recommends
                                                                                                                        </td>
                                                                                                                        <td>
                                                                                                                            <img src="WebContent/images/boost.png">
                                                                                                                            <div class="boost-number">
                                                                                                                                <asp:Label ID="lblBoostCountFull" runat="server" Text='<%# Container.DataItem("BoostCount")%>'></asp:Label></div>
                                                                                                                             Boosts
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                            <div id='<%#"popup_box_Boost_AllFull" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td style="text-align: right;">
                                                                                                            <a id="boostClose" onclick='<%# "return unloadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                <img src="WebContent/Theme/images/closebox.png" alt='Close' style="cursor: pointer;" /></a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="text-align: center;">
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
                                                                                                                <img src="WebContent/Theme/images/closebox.png" alt='Close' width='20' height='20'
                                                                                                                    style="cursor: pointer;" /></a>
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
                                                                                                   
                                                                                                </table>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </div>
                                                                </contenttemplate>
                                                            </asp:updatepanel>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td valign="top">
                                                <img height="40" width="42" id='Img4' src='/Images/arrowUp.png' title="Previous"
                                                    style="cursor: pointer;" onclick="scrollThumbFull('Go_U')" />
                                                <div style="min-height: 500px;">
                                                    &nbsp;</div>
                                                <img height="40" width="42" id='Img5' src='/Images/arrowDownHome.png' style="cursor: pointer;"
                                                    title="Next" onclick="scrollThumbFull('Go_D')" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </telerik:RadPageView>--%>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <div class="col1">
                    <span class="titles">My Districts </span>
                    <asp:linkbutton id="lbtnEditDistricts" runat="server" text="Add" style="font-size: 18px;
                        text-decoration: none; color: #75b4c6;" onclientclick="return loadPopupBoxOnlyDistrict();">
                    </asp:linkbutton>
                    <div id="mydistricts">
                        <asp:repeater id="districtsRepeater" runat="server" datasourceid="sdUsersDistricts">
                            <itemtemplate>
                                <a href='<%#Eval("DistrictName","Search.aspx?District={0}")%>'>
                                    <div class="district">
                                        <img src='<%# isAvail(Eval("DistrictID", "Upload/DistrictPics/{0}.jpg")) %>'><span
                                            class="DAcontent"><%# Container.DataItem("DistrictName")%></span></div>
                                </a>
                            </itemtemplate>
                        </asp:repeater>
                    </div>
                    <span class="titles">My Areas </span><a>
                        <asp:linkbutton id="lbtnEditAreas" runat="server" onclientclick="return loadPopupBoxDiscricts();"
                            style="font-size: 18px; text-decoration: none; color: #75b4c6;" text="Join">
                        </asp:linkbutton></a>
                    <div id="myareas">
                        <asp:repeater id="userAreasRepeater" runat="server" datasourceid="sdUserAreas">
                            <itemtemplate>
                                <a href='<%#Eval("AreaName","Search.aspx?Area={0}")%>'>
                                    <div class="district">
                                        <img src='<%# isAvail(Eval("areaID", "Upload/AreasPics/{0}.jpg")) %>'><span 
                                            class="DAcontent"><%# Container.DataItem("AreaName")%></span></img></div>
                                </a>
                            </itemtemplate>
                        </asp:repeater>
                    </div>
                </div>
                <div class="col2 command-center">
                    <div class="profile-picture">
                        <asp:image id="profilePic" runat="server" height="109px" width="127px" />
                    </div>
                    <div id="boarder-number" style="font-size: 18px;">
                        Boarder ID<br />
                                    <asp:label id="lblBoarderID" runat="server"></asp:label>
                                   
                    </div>
                    <div id="boarder-name">
                        <asp:label id="lbluserName" runat="server" autosize="true"></asp:label><br />
                        <%--<asp:hyperlink id="messagesHyperLink" style="color: #788586; text-decoration: none;
                            font-size: 19px;" runat="server" navigateurl="~/Messages.aspx" text="Messages">
                        </asp:hyperlink>
                        <i>
                            <asp:label id="msgCountLabel" runat="server" text="" forecolor="Red" style="font-size: 13px;">
                            </asp:label></i><br />--%>
                    </div>
                    <div id="profile">
                        Profile <a href="Profile.aspx">View</a><a href="MyProfile.aspx">/Edit</a></div>
                    <form>
                    <%--   <asp:updatepanel id="userUpdatePanel" runat="server">
                <contenttemplate>
                    --%>
                    <textarea id="txtPost" runat="server" placeholder="Write a post to the Crowd News..."></textarea>
                    <table width="100%" border="0">
                        <tr>
                            <td colspan="3">
                                <asp:label id="messageLabel" runat="server" font-size="15px" text="" visible="false">
                                </asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                <asp:button id="fileAttachButton" runat="server" text="Upload" style="display: none;" />
                            </td>
                            <td style="text-align: right; width: 30%; vertical-align: bottom;">
                                <telerik:RadAsyncUpload ID="fileAttachRadAsyncUpload" runat="server" MultipleFileSelection="Disabled"
                                    HideFileInput="true" OnClientFilesUploaded="fileAttach" HttpHandlerUrl="~/CustomHandler.ashx"
                                    Font-Bold="true" Width="100%" Skin="Web20" Style="display: none;">
                                    <localization select="Add File" />
                                </telerik:RadAsyncUpload>
                            </td>
                            <td style="width: 50%; vertical-align: top; text-align: right;">
                                <input type="button" id="clickRadAsyncUpload" value="Add File" onclick="clickRadUploadbtn();"
                                    class="attach-button" />
                            </td>
                            <td style="width: 5%;">
                                <asp:button id="postRadButton" runat="server" text="Post" cssclass="post-button" />
                            </td>
                        </tr>
                    </table>
                    <%--  </contenttemplate>
            </asp:updatepanel>--%>
                    </form>
                    <div id="command-center-controls">
                        <span>My Crowdboards
                            <asp:label id="crowdBoardsCount" runat="server" text="" visible="false"></asp:label>
                            <a href="CrowdboardCommand.aspx">Manage</a> </span>
                        <br />
                        <span>My Boardfolio
                            <asp:label id="investmentsSet" runat="server" text="" visible="false"></asp:label>
                            <a href="BoardFolio.aspx">Access</a></span><br />
                    </div>
                    <asp:button id="btnCreateBoard" runat="server" class="create-crowdboard-button" text="Create CrowdBoard"
                        postbackurl="CreateCrowdboard.aspx"></asp:button>
                </div>
                <div class="col3">
                    <div class="lineup-main">
                        <div class="title">
                            Boarders Lineup <span>
                                <asp:linkbutton id="lbtnShowAddBoarderView" runat="server" text="Connect">
                                </asp:linkbutton>
                            </span>
                        </div>
                        <div class="lineup">
                            <div>
                                <table width="100%" border="0">
                                    <tr>
                                        <td style="width: 15%; vertical-align: top; text-align: center;">
                                            <div class="other-boarder-image">
                                                <asp:linkbutton id="lbtnImageAddBoarder" runat="server" text="Edit" forecolor="#ececee"
                                                    enabled="false" font-size="Small">
                                                    <img id="imgAddBoarder" src="Upload/ProfilePics/thumbnail/noimage.jpg" height="95"
                                                        width="92" style="cursor: default; margin-top: 8px;" />
                                                </asp:linkbutton>
                                            </div>
                                        </td>
                                        <td style="width: 82%;">
                                            <div id="boardersDiv">
                                                <asp:datalist id="boardersDataList" runat="server" datasourceid="sdBoarders" repeatcolumns="5"
                                                    repeatdirection="Horizontal" repeatlayout="Table">
                                                    <itemtemplate>
                                                        <a href='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                                            <div class="other-boarder-image">
                                                                <div style="width: 100%; height: 85%; padding: 5px;">
                                                                    <div id="firendDiv" runat="server">
                                                                    </div>
                                                                </div>
                                                                <span class="other-boarder-name" >
                                                                    <%# Container.DataItem("Users")%></span>
                                                            </div>
                                                        </a>
                                                        <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("Users")%>' />
                                                    </itemtemplate>
                                                </asp:datalist>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <div style="padding-bottom: 10px;">
                                    <asp:panel id="Panel1" visible="false" runat="server">
                                        <asp:imagebutton id="ImageBtnShow" width="30" height="20" onclientclick="return showBoarders();"
                                            imageurl="Images/arrowDownHome.png" runat="server" />
                                    </asp:panel>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="crowdnews-main">
                        Crowd News
                        <asp:linkbutton id="lbtnShowAllCrowdNewsView" runat="server" text="Latest" forecolor="#75b4c6"
                            style="font-size: 18px;">
                        </asp:linkbutton>
                        <div class="crowdnews">
                            <asp:updatepanel id="crowdNewsUpdatePanel" runat="server">
                                <contenttemplate>
                                    <asp:DataList ID="crowdNewsDataList" runat="server" RepeatLayout="Table" RepeatDirection="vertical"
                                        Style="width: 100%;">
                                        <ItemTemplate>
                                            <div class="crowdnews-post">
                                                <div class="posted-material">
                                                    <asp:HiddenField ID="hdnPostID" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                    <a href="">
                                                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                            <asp:Image ID="boarderPic" runat="server" Height="65px" Width="90px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                    </a>
                                                    <div class="poster-options">
                                                        <a href="#" class="comment-img">
                                                            <img src="WebContent/images/comment.png" alt="Comments" onclick='<%# "return openRadWindow("+ Eval("PostID").ToString() + ");" %>' />
                                                        <div class="comment-number">
                                                                <asp:Label ID="lblCommentCounts" runat="server" 
                                                                Text='<%# Container.DataItem("CommentCount")%>'></asp:Label></div>
                                                        </a><a href="#" class="recommend-img">
                                                            <img src="WebContent/images/recommend.png" alt="Recommends" onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>' />
                                                        <div class="recommend-number">
                                                                <asp:Label ID="lblRecommendCount" runat="server" 
                                                                Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label></div>
                                                        </a><a href="#" class="boost-img">
                                                            <img src="WebContent/images/boost.png" alt="Boosts" onclick='<%# "return loadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>' />
                                                        <div class="boost-number">
                                                                <asp:Label ID="lblSharesCount" runat="server" 
                                                                Text='<%# Container.DataItem("BoostCount")%>'></asp:Label></div>
                                                        </a>
                                                    </div>
                                                    <div class="poster-name">
                                                        <%# Container.DataItem("FriendUserName")%>
                                                        says:</div>
                                                    <div class="poster-comment">
                                                        <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text").ToString() %>'></asp:Label>
                                                    </div>
                                                    <div class="time-stamp">
                                                        <%--<asp:LinkButton ID="lbtnRecommendPost" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                            CommandName="IRecommendPost" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="lbtnComment" runat="server" Text="Comment" OnClientClick='<%# "return openRadWindow("+ Eval("PostID").ToString() + ");" %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'></asp:Label>
                                                    </div>
                                                    <div id='<%#"popup_box_Boost" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                               <p>  <span style="float:left; font-size:18px;">Select where to Boost</span>   <a id="A1" onclick='<%# "return unloadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'>
                                                                        <img src="Images/btncross.png" alt='Close' style="cursor: pointer;
                                                                            height: 20px; width: 20px; float: right;" /></a></p>
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
                                                    <div id='<%#"popup_box_post" +Eval("PostID").ToString()  %>' class="popup_box_allCrowdNews">
                                                        <table width="100%">
                                                            <tr>
                                                                <td style="text-align: right; padding: 5px; float: right;">
                                                                    <a id="popupBoxClosePost" onclick='<%# "return unloadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                        <img src="Images/btncross.png"  alt='Close' style="cursor: pointer;
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
                                                                                    Font-Size="Small" ForeColor="#75b4c6" CommandName="IRecommendPost1" CommandArgument='<%# Container.DataItem("PostID")%>'>
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
                                </contenttemplate>
                            </asp:updatepanel>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="rpvAddBoarder" runat="server">
                <div class="container second_block">
                    <div class="latest-crowd-boards group">
                        <div id='middleDivAddBoarders' style="min-height: 450px; color: #ececee; float: left;
                            width: 100%;">
                            <div style="text-align: right; margin-right: 20px; margin-bottom: 5px;">
                                <asp:linkbutton id="lbtnShowBoarderDetailsViewBack" runat="server">
                                    <img id="img1" src="Images/arrowUpHome.png" height="40" width="40" style="cursor: pointer;"
                                        title="Close" />
                                </asp:linkbutton>
                            </div>
                            <asp:updatepanel id="updatePanelSearch" runat="server">
                                <contenttemplate>
                                    <div>
                                        <asp:Label ID="lblMessageAddBoarder" runat="server" Text="" Visible="false" Font-Size="16"></asp:Label>
                                    </div>
                                </contenttemplate>
                            </asp:updatepanel>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <div class="container second_block">
        <div class="latest-crowd-boards group">
            <table width="100%" border="0">
                <tr>
                    <td>
                        <asp:panel runat="server" id="latestBoardPanel" defaultbutton="btnSearchDistrics">
                            <table width="100%" border="0" cellpadding="10px">
                                <tr>
                                    <td style="width: 35%">
                                        Latest Crowdboards <a href="Search.aspx?FromHome=1">View All</a>
                                    </td>
                                    <td style="width: 15%;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 42%; padding: 5px;">
                                        <div style="width: 243px; border: 0px solid red; display: inline-block; float: right;">
                                            <div style="width: 200px; float: right; display: none;">
                                                <asp:linkbutton id="btnSearchDistrics" runat="server" text="Search CrowdBoards" borderstyle="None"
                                                    onclientclick="return getValue();" forecolor="#75b4c6">
                                                </asp:linkbutton>
                                            </div>
                                            <div id="search" style="width: 260px; float: left;" class="menu-image">
                                                <input name="searchTextBox" type="text" placeholder="Search CrowdBoards..." runat="server"
                                                    id="searchTextBox" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div id="boardsDetailsDiv" class="HideBoard">
                                            <asp:repeater id="surfBoardsRepeater" runat="server" datasourceid="sdAllBoards">
                                                <itemtemplate>
                                                    <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("Seeking") %>' />
                                                    <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                                    <asp:HiddenField ID="hdnBoardName" runat="server" Value='<%#Eval("BoardName") %>' />
                                                    <asp:HiddenField ID="hdnYoutubeVideoUrl" runat="server" Value='<%#Eval("YoutubeVideoUrl") %>' />
                                                    <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                                    <div class="size1of4">
                                                        <div class="crowdboard-container group">
                                                            <div class="crowdboard-video">
                                                                <div id="coverPicDiv" runat="server">
                                                                    <div class="play-button">
                                                                        <asp:LinkButton ID="ShowVideoLinkButton" runat="server" CommandName="ShowVideo" CommandArgument='<%#Eval("YoutubeVideoUrl") %>'>
                                                                            <asp:ImageButton ID="ibtnPlay" ImageUrl="WebContent/images/playbutton.png" Height="49"
                                                                                Width="49" runat="server" Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' /></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="crowdboard-profile-picture">
                                                                <a href='<%# Eval("DirectoryName","{0}") %>'>
                                                                    <img id="img2" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' /></a>
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
                                                                                    <%--  <div class="crowdboard-status-bar-position"></div> --%>
                                                                                </div>
                                                                            </td>
                                                                            <td style="width: 90%;">
                                                                                <div class="crowdboard-measure-text">
                                                                                    <div class="crowdboard-measure-level">
                                                                                        Level<br><span><%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span></div>
                                                                                    <div class="crowdboard-measure-max-left">
                                                                                        Max Left<br><span><%#GetAmount(Eval("Amountleft"),Eval("BankLocation"))%></span></div>
                                                                                    <div class="crowdboard-measure-boarders-in">
                                                                                        Boarders In<br><span><%#Eval("BoarderInCount") %></span></div>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <%--  <div class="crowdboard-status-bar"></div>--%>
                                                                </div>
                                                                <a href='<%# Eval("DirectoryName") %>'>
                                                                    <img src="WebContent/images/comment.png" /><div class="comment-number">
                                                                        (<%#Eval("Comments") %>)</div>
                                                                </a><a href='<%# Eval("DirectoryName") %>'>
                                                                    <img src="WebContent/images/recommend.png" /><div class="recommend-number">
                                                                        (<%#Eval("RecommendCount") %>)</div>
                                                                </a><a href='<%# Eval("DirectoryName") %>'>
                                                                    <img src="WebContent/images/boost.png" /><div class="boost-number">
                                                                        (3)</div>
                                                                </a><a href='<%# Eval("DirectoryName") %>'>
                                                                    <img src="WebContent/images/watchwbg.png" /><div class="watch-number">
                                                                        (<%#Eval("Watches") %>)</div>
                                                                </a>
                                                                <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" />
                                                            </div>
                                                            <asp:LinkButton ID="lbBoardDetail" runat="server" CommandName="ToBoard" CommandArgument='<%# Eval("DirectoryName") %>'>
                             <table style="color:#788586"><tr><td>                    
        <div class="crowdboard-text">
          <div class="crowdboard-line-name">Name: <span><%#Eval("BoardName") %></span></div>
          <div class="crowdboard-line-location">Location: <span><%#Eval("Location") %></span></div>
          <div class="crowdboard-line-seeking">Seeking: <span><%#GetAmount(Eval("Seeking"),Eval("BankLocation"))%></span></div>
          <div class="crowdboard-line-DA">District: <span class="district-tag"><a href='Search.aspx?District=<%#Eval("District") %>'><%#Eval("District") %></a></span> Area: <span class="area-tag"><a href='Search.aspx?Area=<%#Eval("AreaName") %>'><%#Eval("AreaName") %></a></span></div>
          <div class="crowdboard-line-live-since">Live Since: <span><%#Eval("DateActivated") %></span></div>
          <div class="crowdboard-wrapper-description">Description:<br></br>
            <div class="crowdboard-description"><%#Eval("Description") %>
            </div>
          </div>
        </div>          
    </td></tr></table></asp:LinkButton>
                                                            <a href='<%# Eval("DirectoryName","{0}") %>'>
                                                                <asp:Button ID="viewbutton" class="view-crowdboard-button" Text="View CrowdBoard"
                                                                    PostBackUrl='<%# Eval("DirectoryName","~/{0}") %>' runat="Server"></asp:Button></a>
                                                        </div>
                                                    </div>
                                                </itemtemplate>
                                            </asp:repeater>
                                        </div>
                                        <div class="popup_box" id='popup_box_Video'>
                                            <div style="text-align: right;">
                                                <a id="popupBoxCloseYoutube" onclick="return unloadPopupBoxVideo();">
                                                    <img src="Images/btncross.png" alt='Close' style="cursor: pointer; height: 20px;
                                                        width: 20px; margin-bottom: 5px;" /></a></div>
                                            <div>
                                                <telerik:RadMediaPlayer ID="RadMediaPlayer1" runat="server" Width="580px" BackColor="#262626"
                                                    StartVolume="80" Height="400px">
                                                </telerik:RadMediaPlayer>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:panel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="400" Width="600px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
                loadNew();
            });

            function loadNew() {
                var $container = $('#container');
                var $containerCrowdNews = $('#containerCrowdNews');
                var $containerCrowdNewsFull = $('#containerCrowdNewsFull');
                // initialize
                $container.masonry({
                    columnWidth: 320,
                    itemSelector: '.item'
                });

                $containerCrowdNews.masonry({
                    columnWidth: 320,
                    itemSelector: '.itemAllNews'
                });

                $containerCrowdNewsFull.masonry({
                    columnWidth: 312,
                    itemSelector: '.itemAllNewsFull'
                });
            }
      

        </script>
        <script type="text/javascript">
            function SetSelectedView(radMultiPage, page) {

                var multiPage = $find(radMultiPage);
                var pageView = multiPage.findPageViewByID(page);
                if (pageView)
                    pageView.set_selected(true);
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    </form>
    <div>
        <asp:sqldatasource id="sdBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select  M.Users,M.UserID1,M.UserID2,M.Status,M.DateRequested,M.DateAccepted,(SELECT IsNULL(City,'')+','+ISNULL(state,'') from users WHERE UserName=M.Users) as Location,(SELECT Job from users WHERE UserName=M.Users) as Profession,dbo.fUserDistricts(CASE WHEN M.UserID1=@UserID Then M.UserID2 Else M.UserID1 End) As UserDistricts from (SELECT CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As Users,userid1,userid2,Status,DateRequested,DateAccepted from vwBoardersDetail where (UserID1=@UserID or UserID2=@UserID) AND Status=1)M"
            insertcommand="INSERT INTO Boarders(UserID1,UserID2,Status,DateRequested) VALUES(@UserID1,@UserID2,0,getdate())"
            updatecommand="UPDATE Boarders SET Status=0,DateRequested=getdate(),DateRejected=null,userID1=@UserID1,UserID2=@UserID2 WHERE (UserID1=@UserID1 AND UserID2=@UserID2) OR (UserID1=@UserID2 AND UserID2=@UserID1)">
            <selectparameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </insertparameters>
            <updateparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select BoardInvestedIn,crowdboards,PendingRequestCount,MessageCount,BoardsWatching from vwUserInfo where UserID=@userID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUsersDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct UD.DistrictID,UD.UserID,D.DistrictName,D.SortOrder  FROM UserDistricts UD INNER JOIN Districts D ON UD.DistrictID =D.districtID  WHERE UD.UserID=@userID order by D.SortOrder"
            deletecommand="DELETE FROM UserDistricts WHERE UserID=@UserID and DistrictID=@DistrictID"
            insertcommand="INSERT INTO UserDistricts (UserID,DistrictID )VALUES(@UserID,@DistrictID)">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
            <deleteparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:Parameter Name="DistrictID" />
            </deleteparameters>
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="DistrictID" />
            </insertparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct A.areaID,UA.UserID,A.AreaName,A.SortOrder FROM UserAreas UA INNER JOIN Areas A ON UA.AreaID =A.areaID WHERE UA.UserID=@UserID order by A.SortOrder"
            deletecommand="DELETE FROM UserAreas WHERE UserID=@UserID and areaID=@areaID"
            insertcommand="INSERT INTO UserAreas (AreaID,UserID)VALUES(@AreaID,@UserID)">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
            <deleteparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:Parameter Name="areaID" />
            </deleteparameters>
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="AreaID" />
            </insertparameters>
        </asp:sqldatasource>
        <%--  <asp:sqldatasource id="sdMessageCount" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>--%>
        <asp:sqldatasource id="sdCrowdNews" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select top 4 * from (SELECT distinct  U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,B.Status,ISnull((SELECT top 1 Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT top 1 Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from UserPosts U Left JOIN boarders b  on (b.UserID1=u.userid or b.UserID2=U.UserID) and (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) where U.UserID=@Userid or (U.UserID=B.UserID1 or U.UserID=B.UserID2))a order by DatePosted desc">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <%--<asp:sqldatasource id="sdCrowdNewsFull" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,B.Status,ISnull((SELECT top 1 Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT top 1 Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from UserPosts U Left JOIN boarders b  on (b.UserID1=u.userid or b.UserID2=U.UserID) and (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) where U.UserID=@Userid or (U.UserID=B.UserID1 or U.UserID=B.UserID2) order by u.DatePosted desc">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>--%>
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
        <asp:sqldatasource id="sdAllBoards" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT top 4 CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) >145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Watches,V.Comments,V.RecommendCount,V.YoutubeVideoUrl,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer As Seeking,V.Offer,V.invType,V.RaisedTotal,V.AmountRemaining as Amountleft,V.BankLocation,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount FROM vwBoardInfo   V  INNER JOIN Users U ON v.UserID =U.UserID WHERE V.Status=1 Order by case when V.CommentDate>V.DateActivated then V.CommentDate else V.DateActivated end desc">
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCheckRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
            <selectparameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdPostReplies" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO UserPostReplies(UserID,PostID,DateReplies,Liked) VALUES(@UserID,@PostID,GetDate(),1)"
            selectcommand="SELECT UR.ReplyID,UR.UserID,UR.DateReplies,UR.Comment,(SELECT UserName FROM Users WHERE UserID=UR.UserID) as ReplyByName FROM UserPostReplies UR WHERE UR.PostID=@PostID AND UR.Comment IS NOT NULL order by UR.ReplyID desc">
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
            </insertparameters>
            <selectparameters>
                <asp:Parameter Name="PostID" />
            </selectparameters>
        </asp:sqldatasource>
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
        <asp:sqldatasource id="sdCheckBoardName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:sqldatasource>
        <asp:sqldatasource id="sdCheckuserName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select *  from Users"></asp:sqldatasource>
        <asp:sqldatasource id="sdAllAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT areaID,AreaName FROM Areas"></asp:sqldatasource>
        <asp:sqldatasource id="sdDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT districtID,DistrictName,row_number()over(order by D.SortOrder) as rownumber,(select top 1  districtID from UserDistricts where UserID=@userID and DistrictID=D.districtID) as IsExist  FROM Districts D  Order by D.DistrictName">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName,(select top 1 areaID from UserAreas where UserID=@userID and AreaID=A.areaid) as IsExist FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <selectparameters>
                <asp:Parameter Name="districtID" />
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="Select DistrictID,DistrictName from Districts"></asp:sqldatasource>
        <asp:sqldatasource id="sdMessages" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  MessageID,FromUser,ToUser,FromUserName,Datesent,ToUserName,Unread,FileName, substring(FileName,CHARINDEX('+-',filename)+2,LEN(filename)) as FileText,Text   FROM vwMessagesDetail   Where ToUserName=@UserName  and unread=1 Order by datesent desc">
            <selectparameters>
                <asp:SessionParameter Name="UserName" SessionField="userName" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdMessageCount" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdNotifications" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select * from  dbo.u_recentActivities(@userID,@DateLastLoggedIn)">
            <selectparameters>
                <asp:Parameter Name="userID" />
                <asp:Parameter Name="DateLastLoggedIn" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRecentActivityOnBoards" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select  * from  dbo.f_RecentActivityOnBoards(@userID,@DateLastLoggedIn)">
            <selectparameters>
                <asp:Parameter Name="userID" />
                <asp:Parameter Name="DateLastLoggedIn" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdPendingRequests" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  status,DateRequested,DateAccepted,userid1 AS senderID,UserID2 AS accepterID,(SELECT UserName FROM Users WHERE UserID=UserID1) AS senderName,(SELECT Isnull(Email,'') as Email From Users where UserID=UserID1) AS Email,(SELECT FirstName FROM Users WHERE UserID=UserID1) AS senderFirstName,(SELECT LastName FROM Users WHERE UserID=UserID1) AS senderLastName,(SELECT UserName FROM Users WHERE UserID=UserID2) AS accepterName FROM Boarders WHERE status=0  AND UserID2=@userID"
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
            selectcommand="select Sum(Request+Request2) as RequestCount from(select *,(SELECT COUNT(*) Request FROM Boarders WHERE status=0  AND UserID2=@UserID) as Request2 from(SELECT count (*) Request from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=0 AND MemberID=@UserID)a)main"
            updatecommand="UPDATE Boarders SET DateRejected=getdate(),Status=2 where UserID1=@userID1 AND UserID2=@userID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="userID1" />
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsCrowdBoardInvites" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BO.BoardID,BO.MemberID,BO.status as RequestStatus,BO.Description,V.BoardName,V.DirectoryName,V.Watches,V.comments,V.Investors,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,BO.DateRequested,BO.DateAccepted,V.UserID as OwnerID,V.TotalOffer,V.Offer,CASE WHEN LEN(V.Description) > 53 THEN substring(V.Description,0,50) + '...' ELSE V.Description END AS BoardDescription,(SELECT UserName from Users WHERE UserID=V.UserID) As OwnerName from BoardOwners BO INNER JOIN  vwBoardInfo V ON BO.BoardID=V.BoardID WHERE BO.Status=0 AND MemberID=@MemberID"
            updatecommand="UPDATE BoardOwners SET Status=1,DateAccepted=getdate() WHERE BoardID=@BoardID AND MemberID=@MemberID">
            <selectparameters>
                <asp:SessionParameter Name="MemberID" SessionField="userID" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:SessionParameter Name="MemberID" SessionField="userID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRejectCrowdboardTeamRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE BoardOwners SET DateRejected=getdate(),Status=2 where BoardID=@BoardID AND MemberID=@MemberID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:SessionParameter Name="MemberID" SessionField="userID" />
            </updateparameters>
        </asp:sqldatasource>
    </div>
</body>
</html>
