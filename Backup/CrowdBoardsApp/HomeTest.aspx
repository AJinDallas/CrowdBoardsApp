<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HomeTest.aspx.vb" Inherits="CrowdBoardsApp.HomeTest" %>

<%@ Register TagPrefix="uc4" TagName="TitleBar4" Src="~/uc_Notifications.ascx" %>
<%@ Register TagPrefix="uc5" TagName="TitleBar5" Src="~/uc_PendingRequests.ascx" %>
<%@ Register TagPrefix="uc6" TagName="TitleBar6" Src="~/uc_UnreadMessages.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
    <style type="text/css">
        .popup_box_allCrowdNews
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 550px;
            width: 400px;
            background: #ececee;
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
        }
        /* popup_box DIV-Styles*/
        .popup_box
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 450px;
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
        
        .popup_box_boost
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 200px;
            width: 400px;
            background: #ececee;
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
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
    <style type="text/css">
        .ShowBoard
        {
            overflow-x: hidden;
            height: 320px;
            overflow: auto;
        }
        .HideBoard
        {
            height: 330px;
            overflow: hidden;
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
            background: #262626;
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
            border-color: #99CCFF;
            border-style: solid;
            border-width: 1px;
        }
        .pageloaddiv
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
    </style>
</head>
<body style="z-index: 120; margin: 2px;" class="backgroundColorAndFontColor">
    <form id="form1" runat="server">
    <input id="hdnNotification" type="hidden" value="0" />
    <input id="hdnAreaID" type="hidden" value="0" runat="server" />
    <input id="hdnType" type="hidden" value="0" runat="server" />
    <asp:Button ID="joinArea" runat="server" Style="display: none;" />
    <asp:Button ID="btnAddDistrctHidden" runat="server" Style="display: none;" />
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <%-- <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />--%>
        </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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
            function loadPopupBoxArea(i, name) {

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


            function unloadPopupBoxOnlyDistrict() {

                $('#popup_DistrictDiv').fadeOut("slow");

                return false;
            }

            function loadPopupBoxOnlyDistrict() {

                $('#popup_DistrictDiv').fadeIn("slow");
                return false;
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
            function CloseFullNews() {
                var messageFull = document.getElementById("messageFull");
                var middleDivAll = document.getElementById("middleDivAll");
                var btn = document.getElementById("<%= lbtnCloseCrowdNewsAllFull.ClientID %>");

                middleDivAll.style.display = 'block';
                messageFull.style.display = 'none';
                btn.click();
                return false;
            }
            function ShowFullNewsDiv() {
                var messageFull = document.getElementById("messageFull");
                var middleDivAll = document.getElementById("middleDivAll");
                var btn = document.getElementById("<%= lbtnShowAllCrowdNewsView.ClientID %>");
                middleDivAll.style.display = 'none';
                messageFull.style.display = 'block';
                btn.click();
                return false;
            }

            function ShowAllBoardersDiv() {
                var middleDivAddBoarders = document.getElementById("middleDivAddBoarders");
                var middleDiv = document.getElementById("middleDiv");
                var btn = document.getElementById("<%= lbtnShowAddBoarderView.ClientID %>");
                middleDiv.style.display = 'none';
                middleDivAddBoarders.style.display = 'block';
                btn.click();
                return false;
            }
            function HideAllBoardersDiv() {
                var middleDivAddBoarders = document.getElementById("middleDivAddBoarders");
                var middleDiv = document.getElementById("middleDiv");
                var btn = document.getElementById("<%= lbtnShowBoarderDetailsViewBack.ClientID %>");
                middleDiv.style.display = 'block';
                middleDivAddBoarders.style.display = 'none';
                btn.click();
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    <div class="popup_box_all" id="popup_DistrictDiv">
        <div style="text-align: right;">
            <asp:LinkButton ID="LinkButton1" ForeColor="Red" runat="server" OnClientClick="return unloadPopupBoxOnlyDistrict();">X</asp:LinkButton></div>
        <div class="span12">
            <asp:DataList ID="districtAddDataList" runat="server" RepeatColumns="5" RepeatLayout="Table"
                DataSourceID="sdDistricts">
                <ItemTemplate>
                    <div style="height: 110px; width: 100%;">
                        <table width="100%" border="0">
                            <tr>
                                <td style="width: 30%;">
                                    <div style="background-image: url('<%# isAvail(Eval("districtID", "Upload/DistrictPics/{0}.jpg")) %>');
                                        height: 50px; color: #ececee; width: 65px; text-align: center; background-repeat: no-repeat;
                                        overflow: hidden; background-size: 100% 100%;">
                                    </div>
                                </td>
                                <td style="vertical-align: top; width: 70%;">
                                    <asp:ImageButton ID="btnRemoveArea" runat="server" ImageUrl="~/Images/delete.png"
                                        Visible='<%# IIF(IsDBNull(Eval("IsExist")),false,true) %>' Height="12" Width="12"
                                        CommandName="IRemoveDistrict" CommandArgument='<%# Container.DataItem("districtID")%>' />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                        OnClientClick="return false;" ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton ID="btnAddDistrict" Visible='<%# IIF(IsDBNull(Eval("IsExist")),true,false) %>'
                                        CommandName="IAddDistrict" CommandArgument='<%#Eval("districtID")%>' ForeColor="#ececee"
                                        runat="server" Text="Add"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
    <div class="popup_box_all" id="popup_box_AddRemove">
        <div style="text-align: right;">
            <asp:LinkButton ID="lbtnCloseDistrict" ForeColor="Red" runat="server" OnClientClick="return unloadPopupBoxDistricts();">X</asp:LinkButton></div>
        <div class="span12">
            <span class="LabelheadingWhite">Please Select District To View Areas</span>
            <table width="100%" border="0" cellspacing="6">
                <tr>
                    <td style="text-align: center;">
                        <div style="margin-top: 10px; margin-left: 50px;">
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataList ID="districtDataList" runat="server" DataSourceID="sdDistricts" RepeatColumns="5"
                            RepeatLayout="Table">
                            <ItemTemplate>
                                <div style="height: 110px; width: 100%;">
                                    <table width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <div style="background-image: url('<%# isAvail(Eval("DistrictID", "Upload/DistrictPics/{0}.jpg")) %>');
                                                    height: 50px; color: #ececee; width: 65px; text-align: center; background-repeat: no-repeat;
                                                    overflow: hidden; background-size: 100% 100%;">
                                                </div>
                                                <asp:HiddenField ID="hdnDistrictName" runat="server" Value='<%#Eval("DistrictName")%>' />
                                                <asp:HiddenField ID="hdnDistrictID" runat="server" Value='<%#Eval("districtID")%>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                                    ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="popup_box_all" id='<%#"popup_Area" +Eval("districtID").ToString()  %>'>
                                    <div style="background-color: #262626;">
                                        <asp:Label ID="districtNameLabel" runat="server" CssClass="LabelBlueLarge"></asp:Label>
                                        <div class="span12">
                                            <div style="vertical-align: top;">
                                                <img id="scroll_L_Arrow" width="30" height="30" onclick='<%# "return unloadPopupBoxArea("+ Eval("districtID").ToString() + ");" %>'
                                                    style="cursor: pointer;" src="/Images/arrowPrevioustHome.png">
                                                <span class="LabelheadingWhite" style="vertical-align: top;">&nbsp;&nbsp;&nbsp;Now Select
                                                    an Area to Join</span></div>
                                            <br />
                                            <asp:DataList ID="areaDataList" runat="server" RepeatColumns="5" RepeatLayout="Table">
                                                <ItemTemplate>
                                                    <div style="height: 110px; width: 100%;">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td style="width: 40%;">
                                                                    <div style="background-image: url('<%# isAvail(Eval("areaid", "Upload/AreasPics/{0}.jpg")) %>');
                                                                        height: 50px; color: #ececee; width: 65px; text-align: center; background-repeat: no-repeat;
                                                                        overflow: hidden; background-size: 100% 100%;">
                                                                    </div>
                                                                    <asp:HiddenField ID="hdnAreaName" runat="server" Value='<%#Eval("AreaName")%>' />
                                                                </td>
                                                                <td style="vertical-align: top; width: 60%;">
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/delete.png"
                                                                        Visible='<%# IIF(IsDBNull(Eval("IsExist")),false,true) %>' Height="12" Width="12"
                                                                        OnClientClick='<%# "return loadPopupBoxAddArea("+ Eval("AreaID").ToString() + ",&#39;Remove&#39;);" %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:LinkButton ID="areaNameLinkButton" runat="server" Text='<%#Eval("AreaName")%>'
                                                                        OnClientClick="return false;" ForeColor='<%# IIf(Eval("AreaName").ToString() = AreaName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <div>
                                                                        <asp:LinkButton ID="btnAddArea" Visible='<%# IIF(IsDBNull(Eval("IsExist")),true,false) %>'
                                                                            ForeColor="#ececee" runat="server" Text="Join" OnClientClick='<%# "return loadPopupBoxAddArea("+ Eval("AreaID").ToString() + ",&#39;Add&#39;);" %>'></asp:LinkButton>
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
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style="z-index: 120; margin: auto; width: 100%;">
        <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
            width="100%" border="0">
            <tr align="center">
                <td>
                    <div style="background-color: #ececee; height: 43px; color: #262626;">
                        <asp:Panel ID="headerPanel" runat="server" DefaultButton="lbtnSearch">
                            <table width="100%" border="0">
                                <tr style="height: 35px">
                                    <td style="width: 25%; font-size: Large;">
                                        &nbsp;<asp:Label ID="lbluserName" runat="server"></asp:Label>
                                    </td>
                                    <td style="width: 27%; color: Red; font-size: Large; font-weight: bold;">
                                        <a href="mailto:info@crowdboarders.com" target="_top" style="color:Red;text-decoration:underline;">CONTACT US</a>
                                    </td>
                                    <td style="width: 6%; text-align: center;">
                                        <uc5:TitleBar5 ID="TitleBar2" runat="server" />
                                    </td>
                                    <td style="width: 6%; text-align: center;">
                                        <uc4:TitleBar4 ID="TitleBar1" runat="server" />
                                    </td>
                                    <td style="width: 6%; text-align: center;">
                                        <uc6:TitleBar6 ID="TitleBar3" runat="server" />
                                    </td>
                                    <td style="width: 30%; text-align: right;">
                                        <asp:LinkButton ID="lbtnAdmin" runat="server" Text="Admin" ForeColor="#262626"></asp:LinkButton>&nbsp;&nbsp;
                                        <asp:LinkButton ID="lbtnLogout" runat="server" Text="Logout" ForeColor="#262626"></asp:LinkButton>&nbsp;&nbsp;
                                        <asp:LinkButton ID="lbtnSearch" runat="server" Text="Search" ForeColor="#262626"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="searchBoardsTextBox" runat="server" BackColor="#262626" ForeColor="#ececee"
                                            Width="250">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <%--<telerik:RadMultiPage ID="radMultiPageCrowdNewFull" runat="server" SelectedIndex="1">
                        <telerik:RadPageView ID="radPageViewCrowdNewsFull" runat="server">--%>
                    <div>
                        <div id='messageFull' style="min-height: 420px; color: #ececee; float: left; width: 100%;
                            display: none;">
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <span class="LabelheadingWhiteNew">Crowd News</span>
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:LinkButton ID="lbtnCloseCrowdNewsView" runat="server" ForeColor="#ececee" Text="Close CrowdNews"
                                            OnClientClick="return CloseFullNews();"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <div id='slide-wrapFull' style="width: 1280px; height: 580px; overflow: hidden; padding: 0 auto;">
                                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                            <ProgressTemplate>
                                                                <div class="pageloaddiv">
                                                                </div>
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <div id="containerCrowdNewsFull">
                                                                    <asp:LinkButton ID="lbtnCloseCrowdNewsAllFull" runat="server" ForeColor="#ececee"
                                                                        Text="Close CrowdNews" Style="display: none;"></asp:LinkButton>
                                                                    <asp:LinkButton ID="lbtnShowAllCrowdNewsView" runat="server" Text="View All CrowdNews"
                                                                        ForeColor="#ececee" Style="margin-right: 25px; display: none;"></asp:LinkButton>
                                                                    <asp:DataList ID="crowdNewsAllDataListFull" runat="server" RepeatDirection="Horizontal"
                                                                        RepeatLayout="Table">
                                                                        <ItemTemplate>
                                                                            <div class="itemAllNewsFull">
                                                                                <div style="width: 300px;">
                                                                                    <asp:HiddenField ID="hdnPostIDFull" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                                                    <div style="background-color: #ececee; border: thick solid #262626; width: 100%;">
                                                                                        <table width="100%" border="0">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                                        <tr>
                                                                                                            <td rowspan="2">
                                                                                                                <asp:HyperLink ID="userLinkFull" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                                                    <asp:Image ID="boarderPicFull" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                &nbsp;
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <span class="LabelheadingBrown" style="cursor: text;">
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
                                                                                                        <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'
                                                                                                            CssClass="LabelBrownSmall"></asp:Label>
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
                                                                                                    <asp:Label ID="lblCommentFull" runat="server" Text='<%# Eval("Text") %>' CssClass="LabelBrownSmall"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    &nbsp;
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr style="cursor: pointer;" onclick='<%# "return loadPopupBoxPostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                <td colspan="3">
                                                                                                    <table width="100%" border="0" class="LabelBrownSmall">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:Label ID="lblCommentsCountFull" runat="server" Text='<%# Container.DataItem("CommentCount")%>'></asp:Label>
                                                                                                                Comments
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:Label ID="lblRecommendCountFull" runat="server" Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>
                                                                                                                Recommends
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:Label ID="lblBoostCountFull" runat="server" Text='<%# Container.DataItem("BoostCount")%>'></asp:Label>
                                                                                                                Boosts
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                    <div id='<%#"popup_box_Boost_AllFull" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td style="text-align: right;">
                                                                                                    <a id="boostClose" onclick='<%# "return unloadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                        <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a>
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
                                                                                                        <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a>
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
                                                                                                    <asp:Label ID="Label3Full" runat="server" CssClass="LabelBrownSmall" Text='<%# Eval("Text").toString()%>'> ></asp:Label>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table width="100%" border="0" class="LabelBrownSmall">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:LinkButton ID="lbtnRecommendsNewsAllFull" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                                                                    Font-Size="Small" ForeColor="#262626" CommandName="IRecommend" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                                                                </asp:LinkButton>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:LinkButton ID="lbtnBoostNewsAllFull" runat="server" Text="Boost" Font-Size="Small"
                                                                                                                    ForeColor="#262626" OnClientClick='<%# "return loadPopupBoxBoostAllFull("+ Eval("PostID").ToString() + ");" %>'></asp:LinkButton>
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
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <telerik:RadTextBox ID="txtSingleCommentFull" runat="server" TextMode="MultiLine"
                                                                                                        Rows="4" Width="100%">
                                                                                                    </telerik:RadTextBox>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td style="text-align: right;">
                                                                                                    <asp:Button ID="btnSingleCommentFull" runat="server" Text="Comment" CssClass="primaryButton"
                                                                                                        CommandName="IComment" CommandArgument='<%# Container.DataItem("PostID")%>' />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:DataList>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
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
                    <%--  </telerik:RadPageView>
                        <telerik:RadPageView ID="RadPageView2" runat="server">--%>
                    <div id="middleDivAll">
                        <div style="border-color: #99CCFF; min-height: 125px; border-top-style: solid; border-bottom-style: solid;
                            border-top-width: 3px; border-bottom-width: 3px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 15%; vertical-align: top; text-align: center;">
                                        <span class="LabelheadingWhiteNew">Boarders Lineup</span>
                                        <asp:LinkButton ID="lbtnShowAddBoarderViewNew" runat="server" Text="Edit" ForeColor="#ececee"
                                            Font-Size="Small" OnClientClick="return ShowAllBoardersDiv();"></asp:LinkButton>
                                    </td>
                                    <td style="width: 82%;">
                                        <div id="boardersDiv" class="HideBoarder">
                                            <asp:DataList ID="boardersDataList" runat="server" DataSourceID="sdBoarders" RepeatColumns="6"
                                                RepeatDirection="Horizontal" RepeatLayout="Table">
                                                <ItemTemplate>
                                                    <table width="100%" border="0" cellspacing="4px" cellpadding="0">
                                                        <tr>
                                                            <td>
                                                                <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("Users")%>' />
                                                                <div style="width: 110px; float: left; background-color: #ececee; border: thick solid #262626;">
                                                                    <asp:HyperLink ID="userLink" runat="server" Height="95" Width="110" NavigateUrl='<%# Eval("Users", IIf(Convert.ToString(Eval("Users"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                        <div id="firendDiv" runat="server" style="width: 100%;">
                                                                            <div style="width: 100%; height: 80%;">
                                                                            </div>
                                                                            <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                                                opacity: 0.4; background-color: #262626;">
                                                                                <div style="height: 1px;">
                                                                                    &nbsp;</div>
                                                                                <span class="LabelheadingWhite">
                                                                                    <%# Container.DataItem("Users")%></span>
                                                                            </div>
                                                                        </div>
                                                                    </asp:HyperLink>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div style="position: relative; margin-left: 1200px; padding-bottom: 10px;">
                                <asp:Panel ID="Panel1" Visible="false" runat="server">
                                    <asp:ImageButton ID="ImageBtnShow" Width="30" Height="20" OnClientClick="return showBoarders();"
                                        ImageUrl="Images/arrowDownHome.png" runat="server" />
                                </asp:Panel>
                            </div>
                        </div>
                        <div style="border-left-color: #82C753; border-left-width: 3px; border-left-style: solid;
                            border-right-style: solid; border-right-color: #82C753; border-right-width: 3px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <%--<telerik:RadMultiPage ID="radMultiPageMiddle" runat="server" SelectedIndex="0">
                                            <telerik:RadPageView ID="rpvBoarderDetails" runat="server" Selected="true">--%>
                                        <div id='middleDiv'>
                                            <div style="min-height: 320px; color: #ececee; float: left; width: 25%;">
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td style="width: 50%;">
                                                            <span class="LabelheadingWhiteNew">My Districts</span>&nbsp;<asp:LinkButton ID="lbtnEditDistricts"
                                                                runat="server" Text="Edit" ForeColor="#ececee" Font-Size="Small" OnClientClick="return loadPopupBoxOnlyDistrict();"></asp:LinkButton>
                                                        </td>
                                                        <td style="width: 50%;">
                                                            <span class="LabelheadingWhiteNew">My Areas</span>&nbsp;<asp:LinkButton ID="lbtnEditAreas"
                                                                runat="server" Text="Edit" ForeColor="#ececee" Font-Size="Small" OnClientClick="return loadPopupBoxDiscricts();"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="vertical-align: top; width: 50%;">
                                                            <div style="height: 285px; overflow: auto; overflow-x: hidden;">
                                                                <asp:Repeater ID="districtsRepeater" runat="server" DataSourceID="sdUsersDistricts">
                                                                    <ItemTemplate>
                                                                        <table width="100%" border="0">
                                                                            <tr>
                                                                                <td style="width: 30%;">
                                                                                    <asp:HyperLink ID="districtHyperLink" runat="server" NavigateUrl='<%#Eval("DistrictName","~/Search.aspx?District={0}")%>'>
                                                                        <div style="background-image: url('<%# isAvail(Eval("DistrictID", "Upload/DistrictPics/{0}.jpg")) %>');
                                                                            height: 50px; color: #ececee; width: 65px;
                                                                            line-height: 50px; text-align: center;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;">                       
                                                                        </div>
                                                                                    </asp:HyperLink>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="vertical-align: top;">
                                                                                    <asp:Label ID="lblDistrictName" runat="server" Text=' <%# Container.DataItem("DistrictName")%>'
                                                                                        CssClass="LabelBlue"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </td>
                                                        <td style="width: 50%; vertical-align: top;">
                                                            <div style="height: 285px; overflow: auto; overflow-x: hidden;">
                                                                <asp:Repeater ID="userAreasRepeater" runat="server" DataSourceID="sdUserAreas">
                                                                    <ItemTemplate>
                                                                        <table width="100%" border="0">
                                                                            <tr>
                                                                                <td style="width: 30%;">
                                                                                    <asp:HyperLink ID="areaHyperLink" runat="server" NavigateUrl='<%#Eval("AreaName","~/Search.aspx?Area={0}")%>'>
                                                                                                <div style="background-image: url('<%# isAvail(Eval("areaID", "Upload/AreasPics/{0}.jpg")) %>');
                                                                                                    height: 50px; color: #ececee; width: 65px; line-height: 50px;
                                                                                                    text-align: center;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;">
                                                                                                </div></asp:HyperLink>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="vertical-align: top;">
                                                                                    <asp:Label ID="lblAreaaName" runat="server" Text=' <%# Container.DataItem("AreaName")%>'
                                                                                        CssClass="LabelGreen"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="border-color: #82C753; background-color: #ececee; min-height: 320px;
                                                color: #262626; float: left; width: 25%; border-right-style: solid; border-left-style: solid;
                                                border-right-width: 3px; border-left-width: 3px;">
                                                <div>
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Image ID="profilePic" runat="server" Height="60px" Width="60px" />
                                                                <span style="color: #262626;">Boarder </span>
                                                                <asp:Label ID="lblBoarderID" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="messagesHyperLink" runat="server" NavigateUrl="~/Messages.aspx"
                                                                    Text="Messages" ForeColor="#262626"></asp:HyperLink>
                                                                <i>
                                                                    <asp:Label ID="msgCountLabel" runat="server" Text="" ForeColor="Red"></asp:Label></i>
                                                            </td>
                                                        </tr>
                                                        <tr id="postTableRow" runat="server">
                                                            <td>
                                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="userUpdatePanel">
                                                                    <ProgressTemplate>
                                                                        <div class="pageloaddiv">
                                                                        </div>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                                <asp:UpdatePanel ID="userUpdatePanel" runat="server">
                                                                    <ContentTemplate>
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="messageLabel" runat="server" Text="" Visible="false"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <telerik:RadTextBox ID="txtPost" runat="server" Width="100%" TextMode="MultiLine"
                                                                                        BackColor="#ececee" BorderColor="#99CCFF" ForeColor="#262626">
                                                                                    </telerik:RadTextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <table width="100%" border="0">
                                                                                        <tr>
                                                                                            <td style="width: 20%;">
                                                                                                <asp:Button ID="fileAttachButton" runat="server" Text="Upload" Style="display: none;" />
                                                                                            </td>
                                                                                            <td style="text-align: right; width: 30%; vertical-align: bottom;">
                                                                                                <telerik:RadAsyncUpload ID="fileAttachRadAsyncUpload" runat="server" MultipleFileSelection="Disabled"
                                                                                                    HideFileInput="true" OnClientFilesUploaded="fileAttach" HttpHandlerUrl="~/CustomHandler.ashx"
                                                                                                    Font-Bold="true" Width="100%" Skin="Web20" Style="display: none;">
                                                                                                    <Localization Select="Attach" />
                                                                                                </telerik:RadAsyncUpload>
                                                                                            </td>
                                                                                            <td style="width: 50%; vertical-align: top; text-align: right;">
                                                                                                <input type="button" id="clickRadAsyncUpload" value="Attach" onclick="clickRadUploadbtn();"
                                                                                                    class="primaryMiniButton" />
                                                                                                <asp:Button ID="postRadButton" runat="server" Text="Post" CssClass="primaryMiniButton" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="visitDistrictHyperLink" ForeColor="#262626" runat="server" NavigateUrl="~/Search.aspx"
                                                                    Text="Visit Districts"></asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="LabelheadingBrown">Profile</span>
                                                                <asp:HyperLink ID="viewProfile" runat="server" NavigateUrl="~/Profile.aspx" Style="font-size: medium;"
                                                                    ForeColor="#262626" Text="View"></asp:HyperLink>/<asp:HyperLink ID="editProfile"
                                                                        runat="server" NavigateUrl="~/MyProfile.aspx" Style="font-size: medium;" ForeColor="#262626"
                                                                        Text="Edit"></asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="myCrowdBoardsHyperlink" runat="server" NavigateUrl="~/CrowdboardCommand.aspx"
                                                                    Text="CrowdBoard Command" ForeColor="#262626"></asp:HyperLink>
                                                                <asp:Label ID="crowdBoardsCount" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="investmentsHyperlink" runat="server" ForeColor="#262626" Text="My BoardFolio"
                                                                    CssClass="LabelheadingNew"></asp:HyperLink>
                                                                <asp:Label ID="investmentsSet" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="text-align: center;">
                                                    <br />
                                                    <asp:LinkButton ID="btnCreateBoard" runat="server" Font-Size="X-Large" ForeColor="#262626">
                                                Create CrowdBoard</asp:LinkButton></div>
                                            </div>
                                            <div style="min-height: 320px; float: left; width: 48%;">
                                                <table width="100%;">
                                                    <tr>
                                                        <td>
                                                            <table border="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <span class="LabelheadingWhiteNew">CrowdNews</span>
                                                                    </td>
                                                                    <td style="text-align: right;">
                                                                        <asp:LinkButton ID="lbtnShowAllCrowdNewsViewShow" runat="server" Text="View All CrowdNews"
                                                                            ForeColor="#ececee" Style="margin-right: 25px;" OnClientClick="return ShowFullNewsDiv();"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id='scrollPostDiv' style="width: 650px; height: 258px; overflow: hidden; padding: 0 auto;">
                                                                <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="crowdNewsUpdatePanel">
                                                                    <ProgressTemplate>
                                                                        <div class="pageloaddiv">
                                                                        </div>
                                                                    </ProgressTemplate>
                                                                </asp:UpdateProgress>
                                                                <asp:UpdatePanel ID="crowdNewsUpdatePanel" runat="server">
                                                                    <ContentTemplate>
                                                                        <div id="container">
                                                                            <asp:DataList ID="crowdNewsDataList" runat="server" RepeatLayout="Table" RepeatDirection="Horizontal">
                                                                                <ItemTemplate>
                                                                                    <div class="item">
                                                                                        <asp:HiddenField ID="hdnPostID" runat="server" Value='<%# Container.DataItem("PostID")%>' />
                                                                                        <div style="width: 320px;">
                                                                                            <div style="background-color: #ececee; border: thick solid #262626;">
                                                                                                <table width="100%" border="0">
                                                                                                    <tr style="cursor: pointer;">
                                                                                                        <td colspan="2">
                                                                                                            <table width="100%" border="0">
                                                                                                                <tr>
                                                                                                                    <td rowspan="2">
                                                                                                                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("FriendUserName", IIf(Convert.ToString(Eval("FriendUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                                                            <asp:Image ID="boarderPic" runat="server" Height="60px" Width="60px" ImageUrl='<%# isAvail(Eval("FriendUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                                                                                                    </td>
                                                                                                                    <td onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                        &nbsp;
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <span class="LabelheadingBrown" style="cursor: text;">
                                                                                                                            <%# Container.DataItem("FriendUserName")%>
                                                                                                                            Says:</span>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td colspan="1">
                                                                                                            <div style="cursor: pointer; min-height: 60px;" onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                &nbsp;</div>
                                                                                                        </td>
                                                                                                        <td style="vertical-align: top; text-align: right;">
                                                                                                            <div style="cursor: text;">
                                                                                                                <asp:Label ID="lblDatePosted" runat="server" Text='<%# Convert.ToDateTime (Eval("DatePosted")).ToString("MM/dd/yyyy") %>'
                                                                                                                    CssClass="LabelBrownSmall"></asp:Label>
                                                                                                            </div>
                                                                                                            <div style="cursor: pointer; min-height: 43px;" onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                &nbsp;</div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td colspan="3">
                                                                                                            <asp:Label ID="lblComment" runat="server" Text='<%# Eval("Text").ToString() %>' CssClass="LabelBrownSmall"></asp:Label>
                                                                                                        </td>
                                                                                                        <td style="cursor: pointer;" onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                        </td>
                                                                                                        <td style="cursor: pointer;" onclick='<%# "return loadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="LabelBrownSmall" style="font-size: smaller;">
                                                                                                            <asp:Label ID="lblCommentCounts" runat="server" Text='<%# Container.DataItem("CommentCount")%>'></asp:Label>
                                                                                                            Comments
                                                                                                        </td>
                                                                                                        <td class="LabelBrownSmall" style="font-size: smaller;">
                                                                                                            <asp:Label ID="lblRecommendCount" runat="server" Text='<%# Container.DataItem("RecommendCount")%>'></asp:Label>
                                                                                                            Recommends
                                                                                                        </td>
                                                                                                        <td class="LabelBrownSmall" style="font-size: smaller;">
                                                                                                            <asp:Label ID="lblSharesCount" runat="server" Text='<%# Container.DataItem("BoostCount")%>'></asp:Label>
                                                                                                            Boosts
                                                                                                        </td>
                                                                                                        <td colspan="2" class="LabelBrownSmall" style="font-size: smaller;">
                                                                                                            <asp:LinkButton ID="lbtnRecommendPost" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                                                                Font-Size="smaller" ForeColor="#262626" CommandName="IRecommendPost" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                                                            </asp:LinkButton>/<asp:LinkButton ID="lbtnComment" runat="server" Text="Comment"
                                                                                                                OnClientClick='<%# "return openRadWindow("+ Eval("PostID").ToString() + ");" %>'
                                                                                                                Font-Size="smaller" ForeColor="#262626"></asp:LinkButton>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                            <div id='<%#"popup_box_Boost" +Eval("PostID").ToString()  %>' class="popup_box_boost">
                                                                                                <table width="100%">
                                                                                                    <tr>
                                                                                                        <td style="text-align: right;">
                                                                                                            <a id="boostClose" onclick='<%# "return unloadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a>
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
                                                                                                        <td style="text-align: right;">
                                                                                                            <a id="popupBoxClosePost" onclick='<%# "return unloadPopupBoxPost("+ Eval("PostID").ToString() + ");" %>'>
                                                                                                                <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a>
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
                                                                                                    <tr id="attachedImageTr" runat="server" visible='<%# IIf(IsDBNull(Eval("AttachedFileName")),False,True)%>'>
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
                                                                                                            <table width="100%" border="0" class="LabelBrownSmall">
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:LinkButton ID="lbtnRecommendsPost1" runat="server" Text='<%# IIf(Eval("Recommend") = True,"Recommended","Recommend")%>'
                                                                                                                            Font-Size="Small" ForeColor="#262626" CommandName="IRecommendPost1" CommandArgument='<%# Container.DataItem("PostID")%>'>
                                                                                                                        </asp:LinkButton>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:LinkButton ID="lbtnBoostPost" runat="server" Text="Boost" Font-Size="Small"
                                                                                                                            ForeColor="#262626" OnClientClick='<%# "return loadPopupBoxBoost("+ Eval("PostID").ToString() + ");" %>'></asp:LinkButton>
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
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <telerik:RadTextBox ID="txtSingleComment" runat="server" TextMode="MultiLine" Rows="4"
                                                                                                                Width="100%">
                                                                                                            </telerik:RadTextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="text-align: right;">
                                                                                                            <asp:Button ID="btnSingleComment" runat="server" Text="Comment" CssClass="primaryButton"
                                                                                                                CommandName="IComment" CommandArgument='<%# Container.DataItem("PostID")%>' />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </asp:DataList>
                                                                        </div>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                            <div style="margin-top: 5px;">
                                                                <div style="width: 50%; float: right; text-align: right;">
                                                                    <asp:ImageButton ID="crowdNewFullImageButton" runat="server" ImageUrl="../Images/arrowDownHome.png"
                                                                        AlternateText="Show All News" Height="40" Width="42" OnClientClick="return ShowFullNewsDiv();" />
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <%-- </telerik:RadPageView>
                                            <telerik:RadPageView ID="rpvAddBoarders" runat="server">--%>
                                        <div id='middleDivAddBoarders' style="min-height: 350px; color: #ececee; float: left;
                                            display: none; width: 100%;">
                                            <asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="updatePanelSearch">
                                                <ProgressTemplate>
                                                    <div class="pageloaddiv">
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <asp:UpdatePanel ID="updatePanelSearch" runat="server">
                                                <ContentTemplate>
                                                    <div style="min-height: 380px; width: 100%;">
                                                        <asp:LinkButton ID="lbtnShowAddBoarderView" runat="server" Text="Edit" ForeColor="#ececee"
                                                            Font-Size="Small" Style="display: none;"></asp:LinkButton>
                                                        <asp:LinkButton ID="lbtnShowBoarderDetailsViewBack" runat="server" Style="display: none;">
                <img id="img1" src="Images/arrowUpHome.png" height="40" width="40" style="cursor: pointer;"/>
                                                        </asp:LinkButton>
                                                        <div>
                                                            <table width="100%" border="0">
                                                                <tr>
                                                                    <td style="width: 15%; text-align: center;">
                                                                        <span class="LabelheadingWhiteNew">Boarders</span>
                                                                    </td>
                                                                    <td style="width: 40%;">
                                                                    </td>
                                                                    <td style="width: 12%;">
                                                                        <span class="LabelheadingWhiteNew">Search Boarders</span>
                                                                    </td>
                                                                    <td style="width: 20%;">
                                                                        <telerik:RadTextBox ID="txtSearchBoarders" runat="server" ForeColor="#262626" BackColor="#ececee"
                                                                            Width="200px">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="width: 23%;">
                                                                        <asp:Button ID="btnSearchBoarder" runat="server" Text="Find" CssClass="primaryButton" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="lblMessageAddBoarder" runat="server" Text="" Visible="false"></asp:Label>
                                                        </div>
                                                        <div style="margin-top: 3px; overflow: auto; height: 330px; float: left; width: 100%;">
                                                            <asp:DataList ID="nonFriendDataList" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                                                RepeatLayout="Table">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("username")%>' />
                                                                    <div style="width: 315px; float: left; background-color: #ececee; border: thick solid #262626;">
                                                                        <div style="float: left; width: 50%; height: 150px;">
                                                                            <asp:HyperLink ID="userLink" runat="server" Height="150" Width="150" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                <div id="firendDiv" runat="server">
                                                                                    <div style="width: 100%; height: 80%;">
                                                                                    </div>
                                                                                    <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                                                        opacity: 0.4; background-color: #262626;">
                                                                                        <div style="height: 6px;">
                                                                                            &nbsp;</div>
                                                                                        <span class="LabelheadingWhite">
                                                                                            <%# Container.DataItem("username")%></span>
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
                                                                                <asp:Label ID="lblPendingStatus" runat="server" Text="Pending" Visible='<%# IIf(Eval("friendStatus")=0,true,false) %>'
                                                                                    CssClass="LabelBrownSmall"></asp:Label>
                                                                                <asp:Button ID="btnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                                                    Text="Add Boarder" CssClass="primaryButton" Visible='<%# IIf(Eval("friendStatus")=3 or Eval("friendStatus")=2,true,false) %>' />
                                                                                <asp:Button ID="btnRemoveBoarder" runat="server" CommandName="IRemoveBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                                                    Text="Remove Boarder" CssClass="primaryButton" Visible='<%# IIf(Eval("friendStatus")=1,true,false) %>'
                                                                                    OnClientClick="return confirm('Are you sure ?');" />&nbsp;
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </div>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <div style="text-align: right; margin-right: 20px; margin-bottom: 5px;">
                                                <asp:LinkButton ID="lbtnShowBoarderDetailsViewBackNew" runat="server" OnClientClick="return HideAllBoardersDiv();">
                <img id="img2" src="Images/arrowUpHome.png" height="40" width="40" style="cursor: pointer;"/>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <%-- </telerik:RadPageView>
                                        </telerik:RadMultiPage>--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <%-- </telerik:RadPageView>
                    </telerik:RadMultiPage>--%>
                </td>
            </tr>
        </table>
    </div>
    <div style="min-height: 350px; float: right; margin-left: 0px;" class="divBottomTopBlueLeftRightGreen">
        <table width="100%" border="0">
            <tr>
                <td>
                    <asp:Panel runat="server" ID="latestBoardPanel" DefaultButton="btnSearchDistrics">
                        <div style="width: 100%; float: left; height: 370px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 35%">
                                        <asp:LinkButton ID="lbtnLatestBoards" runat="server" Text="> Latest Boards" BorderStyle="None"
                                            ForeColor="#ececee" PostBackUrl="~/Search.aspx?FromHome=1">                                                       
                                                        Latest Boards</asp:LinkButton>
                                    </td>
                                    <td style="width: 15%;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 42%; text-align: right;">
                                        <asp:LinkButton ID="btnSearchDistrics" runat="server" Text="Search CrowdBoards" BorderStyle="None"
                                            ForeColor="#ececee">
                                        </asp:LinkButton>
                                        <telerik:RadTextBox ID="searchTextBox" runat="server" Width="200" ForeColor="#262626"
                                            BackColor="#ececee">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div id="boardsDetailsDiv" class="HideBoard">
                                            <asp:Repeater ID="surfBoardsRepeater" runat="server" DataSourceID="sdAllBoards">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("Seeking") %>' />
                                                    <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                                    <asp:HiddenField ID="hdnBoardName" runat="server" Value='<%#Eval("BoardName") %>' />
                                                    <asp:HiddenField ID="hdnYoutubeVideoUrl" runat="server" Value='<%#Eval("YoutubeVideoUrl") %>' />
                                                    <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                                    <div class="size1of4">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td>
                                                                    <div style="background-color: #ececee; min-height: 300px; border: 5px solid #ECECEE;">
                                                                        <div id="coverPicDiv" runat="server" style="min-height: 55px;">
                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                                <tr>
                                                                                    <td rowspan="2" style="width: 40px;">
                                                                                        <div style="vertical-align: bottom; margin-left: 0px; background-color: #DDDFDA;">
                                                                                            <img id="imgBoard" runat="server" height="65" width="60" src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' />
                                                                                        </div>
                                                                                    </td>
                                                                                    <td align="center">
                                                                                        <div style="min-height: 45px;">
                                                                                            <%-- <asp:HyperLink ID="boardNameLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/Board.aspx?Name={0}") %>'
                                                                                                Text='<%#Eval("BoardName") %>' ForeColor="#ececee" Font-Size="Large">                                                                     
                                                                                            </asp:HyperLink><br />--%>
                                                                                            <div style="margin-left: 20px;">
                                                                                                <asp:ImageButton ID="ibtnPlay" ImageUrl="~/Images/playHome.png" Height="25" Width="50"
                                                                                                    runat="server" Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>'
                                                                                                    CommandName="ShowVideo" CommandArgument='<%#Eval("YoutubeVideoUrl") %>' /></div>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="background-color: #DDDFDA; min-height: 2px;">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        <div style="background-color: #DDDFDA; min-height: 220px; font-size: small;">
                                                                            <table width="100%">
                                                                                <tr style="text-align: right;">
                                                                                    <td style="color: #262626; font-weight: bold;">
                                                                                        Watches:&nbsp;<asp:Label ID="lblWatches" runat="server" Text='<%#Eval("Watches") %>'></asp:Label>
                                                                                        Comments:&nbsp;<asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <table width="100%" style="color: #262626; vertical-align: top;" border="0">
                                                                                            <tr valign="top">
                                                                                                <td class="span9">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Name:</b>&nbsp;<asp:Label ID="lblCrowdBoard" runat="server" Text='<%#Eval("BoardName") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Location:</b>&nbsp;<asp:Label ID="lblLocation" runat="server" Text='<%#Eval("Location") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Type:</b>&nbsp;<asp:Label ID="lblOffers" runat="server" Text='<%#Eval("invType") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Seeking:</b>&nbsp;<asp:Label ID="lblSeeking" runat="server" Text='<%#String.Format("{0:C0}",Convert.ToDouble(Eval("Seeking")))%>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>District:</b>&nbsp;
                                                                                                                <asp:Label ID="lblDistrict" Font-Bold="false" runat="server" Text='<%#Eval("District") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Area:</b>&nbsp;
                                                                                                                <asp:Label ID="lblArea" Font-Bold="false" runat="server" Text='<%#Eval("AreaName") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <b>Live Since:</b>&nbsp;
                                                                                                                <asp:Label ID="lblLive" Font-Bold="false" runat="server" Text='<%#Eval("DateActivated") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                                <td class="span3">
                                                                                                    <div style="height: 150px; width: 100%; overflow: hidden; background-image: url('Images/thermometerSmall.png');
                                                                                                        background-repeat: no-repeat">
                                                                                                        <table width="100%" border="0">
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <div class="thermometer" style="margin-left: 17px;">
                                                                                                                        <telerik:RadSlider Skin="Black" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                                                                            TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="120px"
                                                                                                                            Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false" ShowIncreaseHandle="false"
                                                                                                                            IsDirectionReversed="true" Value="1000" Enabled="false" CssClass="thermometerSlider"
                                                                                                                            BackColor="Transparent">
                                                                                                                        </telerik:RadSlider>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <table width="100%">
                                                                                                                        <tr>
                                                                                                                            <td>
                                                                                                                                <span style="color: #ececee; font-size: medium;">Level</span><br />
                                                                                                                                <asp:Label ID="lblBoardLevel" runat="server" Text='<%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%>'
                                                                                                                                    ForeColor="Red"></asp:Label>
                                                                                                                            </td>
                                                                                                                            <td>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                        <tr>
                                                                                                                            <td>
                                                                                                                                <span style="color: #ececee; font-size: medium;">Max Left</span><br />
                                                                                                                                <asp:Label ID="lblAmountLeft" runat="server" Text='<%#String.Format("{0:C0}",Convert.ToDouble(Eval("Amountleft")))%>'
                                                                                                                                    ForeColor="Gold"></asp:Label>
                                                                                                                            </td>
                                                                                                                            <td>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                        <tr>
                                                                                                                            <td>
                                                                                                                                <span style="color: #ececee; font-size: medium;">BoardersIn</span><br />
                                                                                                                                <asp:Label ID="lblBoardersIn" runat="server" Text='<%#Eval("BoarderInCount") %>'
                                                                                                                                    CssClass="LabelGreen"></asp:Label>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </div>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="2">
                                                                                                    <b>Description:</b>&nbsp;<br />
                                                                                                    <asp:Label ID="lblDescription" Font-Bold="false" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        <div style="font-size: smaller; text-align: center;">
                                                                            <asp:HyperLink ID="boardLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/Board.aspx?Name={0}") %>'
                                                                                Text="VIEW CROWDBOARD" CssClass="whiteLink">
                                                                            </asp:HyperLink>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <div class="popup_box" id='popup_box_Video'>
                                            <div style="text-align: right;">
                                                <a id="popupBoxCloseYoutube" onclick="return unloadPopupBoxVideo();">
                                                    <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a></div>
                                            <div>
                                                <telerik:RadMediaPlayer ID="RadMediaPlayer1" runat="server" Width="580px" BackColor="#262626"
                                                    StartVolume="80" Height="400px">
                                                </telerik:RadMediaPlayer>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
        </table>
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
                    columnWidth: 320,
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
        <asp:SqlDataSource ID="sdAllBoardersList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT Userid,username,FirstName,LastName,friendStatus,Location,Profession,UserDistricts FROM f_GetBoardersList(@UserID) WHERE username is not null and (username like '%' + @searchKeyWord + '%' or FirstName like '%' + @searchKeyWord + '%' or LastName LIKE '%' + @searchKeyWord + '%') ORDER BY friendstatus"
            DeleteCommand="DELETE FROM Boarders WHERE (userid1=@UserID1 and UserId2=@UserID2) OR (userid1=@UserID2 and UserId2=@UserID1)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue="%" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="select BoardInvestedIn,crowdboards,PendingRequestCount,MessageCount,BoardsWatching from vwUserInfo where UserID=@userID">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdUsersDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT UD.UserID,UD.DistrictID,D.DistrictName  FROM UserDistricts UD INNER JOIN Districts D ON UD.DistrictID =D.districtID  WHERE UD.UserID=@userID order by D.SortOrder"
            DeleteCommand="DELETE FROM UserDistricts WHERE UserID=@UserID and DistrictID=@DistrictID"
            InsertCommand="INSERT INTO UserDistricts (UserID,DistrictID )VALUES(@UserID,@DistrictID)">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:Parameter Name="DistrictID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="DistrictID" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdUserAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT UA.UserID,A.areaID,A.AreaName FROM UserAreas UA INNER JOIN Areas A ON UA.AreaID =A.areaID WHERE UA.UserID=@userID order by A.SortOrder"
            DeleteCommand="DELETE FROM UserAreas WHERE UserID=@UserID and areaID=@areaID"
            InsertCommand="INSERT INTO UserAreas (AreaID,UserID)VALUES(@AreaID,@UserID)">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
                <asp:Parameter Name="areaID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="AreaID" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCrowdNews" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="select top 4 * from(SELECT  distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID where (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) )a order by DatePosted desc">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCrowdNewsFull" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT distinct U.PostID,U.AttachedFileName,U.Text,U.UserID,U.DatePosted,(SELECT username from Users where UserID=U.UserID) As FriendUserName,ISnull((SELECT Liked From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Liked is not null),0) as Liked,ISnull((SELECT Recommend From UserPostReplies UPR WHERE UPR.PostID=U.PostID AND UPR.UserID=@UserID and UPR.Recommend is not null),0) as Recommend,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Boost is not null ) AS BoostCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Comment is not null ) AS CommentCount,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Liked is not null ) AS LikeCount ,(SELECT Count(*) from UserPostReplies WHERE PostID=U.PostID and Recommend=1) AS RecommendCount from boarders b INNER JOIN UserPosts U on b.UserID1=u.userid or b.UserID2=U.UserID where (b.UserID1=@UserID Or b.UserID2=@UserID) and (b.Status=1) order by u.DatePosted desc">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
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
        <asp:SqlDataSource ID="sdAllBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT top 4 CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) >145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Watches,V.Comments,V.YoutubeVideoUrl,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer As Seeking,V.Offer,V.invType,V.RaisedTotal,V.AmountRemaining as Amountleft,(SELECT count(*) FROM(SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount FROM vwBoardInfo   V  INNER JOIN Users U ON v.UserID =U.UserID WHERE V.Status=1 Order by V.CommentDate desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCheckRequest" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
            <SelectParameters>
                <asp:Parameter Name="UserID1" />
                <asp:Parameter Name="UserID2" />
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
        <asp:SqlDataSource ID="sdIRecommend" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="UserPostReplies_Recommend" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="PostID" />
                <asp:Parameter Name="Recommend" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCheckBoardName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdCheckuserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select *  from Users"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAllAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT areaID,AreaName FROM Areas"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT districtID,DistrictName,row_number()over(order by D.SortOrder) as rownumber,(select districtID from UserDistricts where UserID=@userID and DistrictID=D.districtID) as IsExist  FROM Districts D  Order by D.DistrictName">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName,(select areaID from UserAreas where UserID=@userID and AreaID=A.areaid) as IsExist FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <SelectParameters>
                <asp:Parameter Name="districtID" />
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="Select DistrictID,DistrictName from Districts"></asp:SqlDataSource>
    </div>
</body>
</html>
