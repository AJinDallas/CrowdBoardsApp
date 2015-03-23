<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CreateCrowdboard.aspx.vb"
    Inherits="CrowdBoardsApp.CreateCrowdboard" MasterPageFile="~/MasterPage/Site.Master" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title></title>
    <style type="text/css">
        .horizontalDirection
        {
            float: left;
            width: 110px;
        }
        .size1of3
        {
            float: left;
            width: 33.3%;
        }
    </style>
    <style type="text/css">
        .style2
        {
            display: none;
        }
    </style>
    <style>
        .popup_box_all
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 350px;
            width: 600px;
            left: 400px;
            top: 200px;
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
        .popup_box_Confirm
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 200px;
            width: 300px;
            left: 400px;
            top: 200px;
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
        
        table
        {
            border-collapse: separate;
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
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/createcrowdboard.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <div id="fb-root">
    </div>
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery-ui.js" type="text/javascript"></script>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rieBackgroundPic"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript" language="javascript">
            Telerik.Web.UI.ImageEditor.CommandList["customSave"] = function (imageEditor, commandName, args) {
                imageEditor.saveImageOnServer("", true);
            }

            var prm = Sys.WebForms.PageRequestManager.getInstance();

            prm.add_endRequest(function () {
                $("#accordion").accordion();
                HideShow();
            });
            $(document).ready(function () {

                $("#accordion").accordion();
                HideShow();

            });

            function HideShow() {
                var index = document.getElementById("BodyContent_hdnIndex").value;
                $("#accordion").accordion("option", "active", parseInt(index));
            }

            function OnClientClicked() {

                if (!window.confirm("Are you sure ?")) {
                    return false;
                }
                else {
                    return true;
                }
            }
            
        </script>
        <script type='text/javascript'>

            function imgEditorSavedHandler(imgEditor, args) {

                $get("<%=lblMessageStep2.ClientID %>").innerHTML = args.get_argument();
            }
        </script>
        <script type="text/javascript">
            function fileUploadedProfile(sender, args) {
                document.getElementById("<%= btnProfilePicture.ClientID %>").click();
            }
           
            
        </script>
        <script type="text/javascript">

            function unloadPopupBoxDistricts() {    // TO Unload the Popupbox

                $('#popup_box_News').fadeOut("slow");
                $('#popup_Confirm').fadeOut("slow");

                return false;
            }

            function loadPopupBoxDiscricts() {    // To Load the Popupbox

                $('#popup_box_News').fadeIn("slow");
                return false;
            }

            function unloadPopupBoxArea() {    // TO Unload the Popupbox

                $('#popup_Area').fadeOut("slow");

                return false;
            }

            function unloadPopupBoxConfirm() {  // TO Unload the Popupbox

                var district = document.getElementById('BodyContent_hdnSelectedDistrict').value;
                var area = document.getElementById('BodyContent_hdnSelectedArea').value;

                if (area != '') {

                    document.getElementById('BodyContent_areaLabelControl').innerHTML = '';
                    document.getElementById('BodyContent_districtLabel').innerHTML = district + ' District';
                    document.getElementById('BodyContent_areaLabel').innerHTML = 'You have Selected the ' + area + '  Area in the ';
                    document.getElementById('BodyContent_selectedDistrict').innerHTML = district
                    document.getElementById('BodyContent_SelectedAres').innerHTML = area
                }
                else {
                    document.getElementById('BodyContent_areaLabelControl').innerHTML = 'Please Select Area';
                    document.getElementById('BodyContent_districtLabel').innerHTML = '';
                    document.getElementById('BodyContent_areaLabel').innerHTML = '';
                    document.getElementById('BodyContent_selectedDistrict').innerHTML
                    document.getElementById('BodyContent_SelectedAres').innerHTML
                }

                $('#popup_Confirm').fadeOut("slow");

                //$("#container").css({ // this is just for style       
                //    "opacity": "1" 
                //});
                return false;
            }

            function loadPopupBoxConfirm(areaName) {    // To Load the Popupbox
                // alert(areaName);
                // $('#popup_Confirm').fadeIn("slow");
                return false;
            }


            function loadPopupBoxArea(i, name) {    // To Load the Popupbox

                document.getElementById('BodyContent_hdnSelectedDistrict').value = name;
                $('#popup_Area' + i).fadeIn("slow");
                return false;

            }


            function unloadPopupBoxArea(i) {    // TO Unload the Popupbox

                //districtDataList_hdnDistrictName_0

                $('#popup_Area' + i).fadeOut("slow");
                //$("#container").css({ // this is just for style       
                //    "opacity": "1" 
                //});
                loadPopupBoxDiscricts();
                return false;
            }




            function loadPopupBoxConfirm(area) {
                document.getElementById('BodyContent_hdnSelectedArea').value = area;
                var district = document.getElementById('BodyContent_hdnSelectedDistrict').value;
                document.getElementById("<%= lblDistrict.ClientID %>").innerHTML = district;
                document.getElementById("<%= lblArea.ClientID %>").innerHTML = area;

                //alert(district);
                // $('#popup_Area' + i).fadeOut("slow");
                $('#popup_box_News').fadeOut("slow");
                $('#popup_Confirm').fadeIn("slow");


                // alert(i);
                return false;


            }


            function popupEquitytype(value) {
                if (value == "Equity") {
                    $('#popupEquitytypeDiv').fadeIn("slow");
                    //$.wait(22500);
                    setTimeout(function () { "seconds" }, 30000);
                    return true;
                }
                else {
                    return true;
                }
            }

            function popupEquitytypeClose() {
                $('#popupEquitytypeDiv').fadeOut("slow");


                return true;

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
        </script>
    </telerik:RadScriptBlock>
    <asp:hiddenfield id="hdnSelectedDistrict" runat="server" />
    <asp:hiddenfield id="hdnSelectedArea" runat="server" />
    <asp:label id="areaLabelControl" runat="Server" font-size="11"></asp:label>
    <div style="width: 1000px; z-index: 120; margin: auto; padding: 0px;">
        <div class="popup_box_Confirm" id="popup_Confirm">
            <div>
                <table width="100%">
                    <tr>
                        <td colspan="2">
                            <span class="LabelheadingWhite">You have Selected the
                                <asp:label id="lblArea" runat="server" style="color: #48a88d;"></asp:label>
                                Area in the
                                <asp:label id="lblDistrict" runat="server" style="color: #75b4c6;"></asp:label>
                                District</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:button id="btnChangeArea" runat="server" text="Change" cssclass="add-level-button"
                                onclientclick="return loadPopupBoxDiscricts();" />
                        </td>
                        <td>
                            <asp:button id="btnConfirmArea" runat="server" text="Confirm" cssclass="add-level-button"
                                onclientclick="return unloadPopupBoxConfirm();" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="popup_box_all" id="popup_box_News">
            <div style="text-align: right;">
                <asp:linkbutton id="lbtnCloseDistrict" forecolor="Red" runat="server" onclientclick="return unloadPopupBoxDistricts();">
                    <img src="Images/btncross.png" alt="X" style="height: 20px; width: 20px;" /></asp:linkbutton></div>
            <div class="span12">
                <span class="LabelheadingWhite">Please Select Which district best Suits your CrowdBoard</span>
                <table width="100%" border="0" cellspacing="6">
                    <tr>
                        <td style="text-align: center;">
                            <div style="margin-top: 10px; margin-left: 50px;">
                                <asp:label id="Label1" runat="server"></asp:label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:datalist id="districtDataList" runat="server" datasourceid="sdDistricts" repeatcolumns="5"
                                repeatlayout="Table">
                                <itemtemplate>
                                    <div style="min-height: 50px; text-align: center;" class="linkCss">
                                        <table width="100%" cellpadding="3">
                                            <tr>
                                                <td style="height: 5px;">
                                                    <asp:HiddenField ID="hdnDistrictName" runat="server" Value='<%#Eval("DistrictName")%>' />
                                                    <asp:HiddenField ID="hdnDistrictID" runat="server" Value='<%#Eval("districtID")%>' />
                                                    <asp:LinkButton ID="DistrictNameLinkButton" runat="server" Text='<%#Eval("DistrictName")%>'
                                                        ForeColor='<%# IIf(Eval("DistrictName").ToString() = DistrictName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="LabelSmall">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="popup_box_all" id='<%#"popup_Area" +Eval("districtID").ToString()  %>'>
                                        <div style="background-color: #ffffff;">
                                            <asp:Label ID="districtNameLabel" runat="server" CssClass="LabelBlueLarge"></asp:Label>
                                            <div class="span12">
                                                <div style="vertical-align: top;">
                                                    <img id="scroll_L_Arrow" width="25" onclick='<%# "return unloadPopupBoxArea("+ Eval("districtID").ToString() + ");" %>'
                                                        style="cursor: pointer;" src="WebContent/Theme/images/backImage.png">
                                                    <span class="LabelheadingWhite" style="vertical-align: top;">&nbsp;&nbsp;&nbsp;Now Select
                                                        an Area Within your District</span></div>
                                                <br />
                                                <asp:DataList ID="areaDataList" runat="server" RepeatColumns="2" RepeatLayout="Table">
                                                    <ItemTemplate>
                                                        <div style="text-align: center; min-height: 50px;" class="linkCss">
                                                            <table width="100%" cellpadding="3">
                                                                <tr>
                                                                    <td style="height: 5px;">
                                                                        <asp:HiddenField ID="hdnAreaName" runat="server" Value='<%#Eval("AreaName")%>' />
                                                                        <asp:LinkButton ID="areaNameLinkButton" runat="server" Text='<%#Eval("AreaName")%>'
                                                                            ForeColor='<%# IIf(Eval("AreaName").ToString() = AreaName,Drawing.ColorTranslator.FromHtml("#99CCFF"),Drawing.ColorTranslator.FromHtml("#ececee"))%>'
                                                                            OnClientClick="return loadPopupBoxConfirm(this.innerHTML);"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="LabelSmall">
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
        <div id="popupEquitytypeDiv" class="popup_box_all" style="height: 200px; width: 465px;
            left: 300px; top: 150px;">
            <div style="padding: 10px; text-align: center;">
                <span style="font-size: 18px;">Other locations are not supported at this time.</span>
                <a id="popupBoxClose" onclick="return popupEquitytypeClose();">
                    <img src="Images/btncross.png" alt='Close' width='20' height='20' style="cursor: pointer;" /></a>
            </div>
            <hr>
            <div style="float: left; font-size: 17px; margin-top: 10px;">
                Choose Location &nbsp;&nbsp;&nbsp;</div>
            <div>
                <asp:dropdownlist id="EquityTypesDropDownList" datavaluefield="ID" datatextfield="typeName"
                    style="width: 200px; height: 30px;" datasourceid="sdEquityTypes" runat="server">
                </asp:dropdownlist>
            </div>
            <br />
        </div>
        <asp:label id="messageLabel" runat="server" text=""></asp:label>
    </div>
    <asp:updatepanel id="updatepanel2" runat="server">
        <contenttemplate>
            <asp:TextBox runat="server" ID="hdnIndex" CssClass="style2"></asp:TextBox></contenttemplate>
    </asp:updatepanel>
    <div id="accordion" style="width: 100%; z-index: 120; margin: auto; padding: 0px;
        border: 0px solid blue;">
        <div class="accordionNew">
        </div>
        <asp:updatepanel id="updatepanel3" runat="server">
            <contenttemplate>
                <div class="main-body" style="height: 449px;">
                    <asp:Label ID="lblMessageStep0" runat="server" Font-Size="11"></asp:Label>
                    <div class="welcome-text">
                        Raise money quickly by creating a CrowdBoard in 4 easy steps</div>
                    <asp:Button ID="btnGetStarted" runat="server" Text="Get Started" CssClass="get-started-button" />
                </div>
            </contenttemplate>
            <triggers>
                <asp:AsyncPostBackTrigger ControlID="btnGetStarted" EventName="click" />
            </triggers>
        </asp:updatepanel>
        <div class="accordianNew">
            <div class="step-title">
                Step One:<a href="#">Choose Type</a></div>
        </div>
        <div class="accordian-body">
            <asp:updatepanel id="updatepanel1" runat="server">
                <contenttemplate>
                    <div class="crowdboard-type-container">
                        <asp:Label ID="lblMessageStep1" runat="server"></asp:Label>
                        <asp:DataList ID="invTypeDataList" runat="server" DataSourceID="sdInvestmentType"
                            RepeatColumns="3" RepeatLayout="Table">
                            <ItemTemplate>
                                <span class="crowdboard-type">
                                    <table width="100%" border="0">
                                        <tr>
                                            <td style="text-align: center;">
                                                <asp:HiddenField ID="hdnEnglishName" runat="server" Value='<%#Eval("EnglishName") %>' />
                                                <asp:LinkButton CssClass="LabelheadingWhite" ID="englishNameLinkButton" runat="server"
                                                    Style="font-size: 24px; font-weight: 400;" Text='<%#Eval("EnglishName")%>' ForeColor='<%# IIf(Eval("EnglishName").ToString() = EnglishName,Drawing.ColorTranslator.FromHtml("#262626"),Drawing.ColorTranslator.FromHtml("#fff"))%>'
                                                    OnClientClick="return popupEquitytype(this.innerHTML);" CommandName="SetInvestmentType" CommandArgument='<%#Eval("Value")%>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="LabelSmall" style="text-align: center;">
                                                <asp:Label ID="lblDescription" runat="server" ToolTip='<%#Eval("EnglishDescription")%>'
                                                    Text='<%#Eval("ShortEnglishDesc")%>' Style="font-size: large;" ForeColor='<%# IIf(Eval("EnglishName").ToString() = EnglishName,Drawing.ColorTranslator.FromHtml("#262626"),Drawing.ColorTranslator.FromHtml("#fff"))%>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </span>
                            </ItemTemplate>
                        </asp:DataList>
                        <div class="not-sure">
                            Not Sure?<a href="#">Click here</a></div>
                    </div>
                </contenttemplate>
                <triggers>
                    <asp:AsyncPostBackTrigger ControlID="invTypeDataList" EventName="ItemCommand" />
                </triggers>
            </asp:updatepanel>
        </div>
        <div class="accordianNew">
            <div class="step-title">
                Step Two:<a href="#">Enter Details</a></div>
        </div>
        <div class="accordian-body">
            <div style="margin-left: 0px;">
                <table width="100%" border="0" cellspacing="0">
                    <tr>
                        <td style="text-align: center;">
                            <div style="margin-top: 10px; margin-left: 50px;">
                                <asp:updatepanel id="updatepanel6" runat="server">
                                    <contenttemplate>
                                        <asp:Label ID="lblMessageStep2" runat="server" Text="" Font-Size="11"></asp:Label></contenttemplate>
                                    <triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gotoStep3" EventName="click" />
                                    </triggers>
                                </asp:updatepanel>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="crowdboard-details-container">
                    <div class="left-portion" style="border: 0px solid red;">
                        <asp:updatepanel id="updatepanel4" runat="server">
                            <contenttemplate>
                                <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                                    <Windows>
                                        <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose">
                                        </telerik:RadWindow>
                                    </Windows>
                                </telerik:RadWindowManager>
                                <table width="100%" border="1" cellspacing="0" style="border-spacing: 5px;">
                                    <tr>
                                        <td style="width: 18%; vertical-align: top;">
                                            <span class="first-row">Upload Picture</span>
                                        </td>
                                        <td rowspan="2">
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td colspan="2">
                                                        <telerik:RadAsyncUpload ID="rauProfilePicture" runat="server" MultipleFileSelection="Disabled"
                                                            OnClientFilesUploaded="fileUploadedProfile" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx"
                                                            AllowedFileExtensions=".jpg">
                                                        </telerik:RadAsyncUpload>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 15%;">
                                                        <div style="height: 121px; width: 121px; border: thin solid #c6c7c8; color: #788586;">
                                                            <div class="picture-frame">
                                                                <asp:Image ID="imgProfile" runat="server" Height="119px" Width="119px" ImageUrl="~/Images/blankBoardImage.png"
                                                                    Style="font-size: 12px; vertical-align: bottom;" />
                                                            </div>
                                                        </div>
                                                        <asp:Button ID="btnProfilePicture" runat="server" Text="Upload" Style="display: none;" />
                                                    </td>
                                                    <td style="vertical-align: bottom; width: 75%;">
                                                        <div class="name-crowdboard">
                                                            <telerik:RadTextBox ID="txtBoardName" runat="server" placeholder="Name your CrowdBoard max 25 characters " MaxLength ="25"
                                                                Width="300px" Height="33px" Style="margin-left: 20px;">
                                                            </telerik:RadTextBox>
                                                            <asp:HiddenField runat="server" ID="hdnDirectoryName" />
                                                            <asp:RequiredFieldValidator ID="rfvBoardName" runat="server" ForeColor="Red" ControlToValidate="txtBoardName"
                                                                SetFocusOnError="true" Display="Dynamic" ValidationGroup="addBoard" ErrorMessage="</br>Please Enter Board Name"
                                                                EnableClientScript="true"></asp:RequiredFieldValidator>  
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtBoardName"
                                                                 ForeColor="Red"  Display="Dynamic" ValidationGroup="addBoard"  SetFocusOnError="true" ValidationExpression="^[^\%\/\\\&\?\,\'\;\:\!\-\<\>\|\'\*]+$" ErrorMessage="</br>No Special Character"></asp:RegularExpressionValidator>
                                                           
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" style="border-spacing: 5px;">
                                    <tr>
                                        <td style="width: 10%; vertical-align: top;">
                                            <div class="fourth-row">
                                                <%-- <div class = "third-row">--%>
                                                <div class="description">
                                                    <span>Description</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 90%;">
                                            <telerik:RadTextBox ID="txtDescription" TextMode="MultiLine" runat="server" Width="410px"
                                                placeholder="About Your CrowdBoard (145 Characters)">
                                            </telerik:RadTextBox>
                                            <asp:RegularExpressionValidator ID="revDesc" runat="server" ControlToValidate="txtDescription"
                                                ErrorMessage="</br>Please enter upto 145 characters" ForeColor="Red" ValidationExpression="^.{1,145}$"
                                                Display="Dynamic" ValidationGroup="addBoard"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%;">
                                            <div class="fourth-row">
                                                Location</div>
                                        </td>
                                        <td style="width: 90%;">
                                            <telerik:RadTextBox ID="txtCity" runat="server" placeholder="city" Height="33px">
                                            </telerik:RadTextBox>
                                            &nbsp;
                                            <telerik:RadTextBox ID="txtCounty" runat="server" placeholder="state or country"
                                                Height="33px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" cellspacing="0" border="0" style="border-spacing: 5px;">
                                    <tr>
                                        <td style="width: 45%;">
                                            <div class="fifth-row">
                                                Set Your Target Amount To Raise
                                            </div>
                                        </td>
                                        <td style="width: 55%;">
                                            <asp:Label runat="server" ID="lblAmtType" Font-Bold="true"></asp:Label>
                                            <telerik:RadTextBox ID="txtSeeking" runat="server" placeholder="100" Height="33px">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="rfvtxtSeeking" runat="server" ForeColor="Red" ControlToValidate="txtSeeking"
                                                Display="Dynamic" ValidationGroup="addBoard" ErrorMessage="</br>Please Enter Seeking Amount"
                                                EnableClientScript="true"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ForeColor="Red"
                                                ControlToValidate="txtSeeking" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"
                                                Text="Number Only" runat="server" ValidationGroup="addBoard" EnableClientScript="true" />
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValueToCompare="0" ControlToValidate="txtSeeking"
                                                ErrorMessage="<br/>Must enter value greater than 0" ForeColor="Red" Operator="GreaterThan"
                                                Type="Integer" ValidationGroup="addBoard" EnableClientScript="true"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table id="taxIDTable" runat="server" visible="false">
                                                <tr>
                                                    <td>
                                                        <span class="LabelheadingWhiteNew">
                                                            <asp:Label ID="lblFederalTaxID" runat="server" Text="Federal Tax ID" Font-Size="11"></asp:Label></span>&nbsp;
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtFederalTaxID" runat="server" Height="33px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="sixth-row">
                                                Select District/Area
                                                <asp:Button ID="btnSeeDistrict" runat="server" CssClass="see-district-button" Text="See Districts"
                                                    OnClientClick="return loadPopupBoxDiscricts();"></asp:Button></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <span>
                                                <asp:Label ID="areaLabel" runat="server" Style="color: #48a88d;"></asp:Label>
                                                <asp:Label ID="districtLabel" runat="server" Style="color: #48a88d;"></asp:Label>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                                <div class="bottom-right-corner">
                                    <asp:Button ID="gotoStep3" runat="server" ValidationGroup="addBoard" Text="Next Step"
                                        CssClass="get-started-button" Style="padding: 10px 24px 11px; font-size: 24px;
                                        margin-bottom: 5px;"></asp:Button>
                                    &nbsp;</div>
                            </contenttemplate>
                            <triggers>
                                <asp:AsyncPostBackTrigger ControlID="gotoStep3" EventName="click" />
                            </triggers>
                        </asp:updatepanel>
                    </div>
                    <div class="right-portion">
                        <div class="preview-container" style="background-color: #fff;">
                            <telerik:RadImageEditor ID="rieBackgroundPic" OnClientSaved="imgEditorSavedHandler"
                                OnImageSaving="rieBackgroundPic_OnImageSaving" runat="server" Height="400px"
                                Width="400px" AllowedSavingLocation="Server">
                                <Tools>
                                    <telerik:ImageEditorToolGroup>
                                        <telerik:ImageEditorTool CommandName="Crop"></telerik:ImageEditorTool>
                                        <telerik:ImageEditorTool CommandName="Resize"></telerik:ImageEditorTool>
                                        <telerik:ImageEditorTool CommandName="ZoomIn"></telerik:ImageEditorTool>
                                        <telerik:ImageEditorToolSeparator></telerik:ImageEditorToolSeparator>
                                        <telerik:ImageEditorTool CommandName="ZoomOut"></telerik:ImageEditorTool>
                                        <telerik:ImageEditorTool Text="Save Image" CommandName="customSave" ImageUrl="~/Images/saveImage.jpg" />
                                    </telerik:ImageEditorToolGroup>
                                </Tools>
                            </telerik:RadImageEditor>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="accordianNew">
            <div class="step-title">
                Step Three:<a href="#">Set Levels</a></div>
        </div>
        <div class="accordian-body">
            <asp:updatepanel id="updatepanel5" runat="server">
                <contenttemplate>
                    <div style="margin-left: 30px; text-align: center;">
                        <asp:Label ID="lblMessageStep3" runat="server" Font-Size="11"></asp:Label>
                    </div>
                    <div class="span12 LabelheadingWhite" style="margin-left: 75px;">
                        Please Enter the Details for your Investment Levels</div>
                    <div class="crowdboard-levels-container">
                        <div class="left-portion">
                            <div class="first-row">
                                <span>Level&nbsp;<asp:Label ID="levelNumberLabel" runat="server"></asp:Label></span>
                                <asp:Button ID="addLevelButton" runat="server" Text="Add Level" CssClass="add-level-button"
                                    ValidationGroup="LevelNameValidationGroup"></asp:Button>
                            </div>
                            <div style="margin-left: 130px;">
                                <span>Level Name</span>
                                <telerik:RadTextBox ID="txtLevelName" runat="server" Height="30px">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="rfvLevelName" runat="server" ControlToValidate="txtLevelName"
                                    ForeColor="Red" ToolTip="Level Name is required." ValidationGroup="LevelNameValidationGroup">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="third-row">
                                <span>Amount</span>
                                <telerik:RadComboBox ID="cbInvestmentLevels" runat="server" DataTextField="FundAmountText"
                                    DataValueField="FundAmount" DataSourceID="sdInvestmentLevelsAmount" AutoPostBack="true">
                                </telerik:RadComboBox>
                                <asp:HiddenField ID="hdnPrice" runat="server" />
                                <asp:RequiredFieldValidator ID="rfvLevelAmount" runat="server" ControlToValidate="cbInvestmentLevels"
                                    ForeColor="Red" ToolTip="Level Amount is required." ValidationGroup="LevelNameValidationGroup"
                                    Display="Dynamic" InitialValue="--Select Amount--">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="fourth-row">
                                <span>Quantity Offered</span>
                                <telerik:RadTextBox ID="txtMaximumOffered" placeholder="Maximum Offered" runat="server"
                                    Height="30px">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="rfvMaximumOffered" runat="server" ControlToValidate="txtMaximumOffered"
                                    ForeColor="Red" ToolTip="Maximum Offered is required." ValidationGroup="LevelNameValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revMaximumOffered" ForeColor="Red" ControlToValidate="txtMaximumOffered"
                                    ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic" Text="Number Only" runat="server"
                                    ValidationGroup="LevelNameValidationGroup" />
                                <asp:CompareValidator ID="cvMaximumOffered" runat="server" ValueToCompare="0" ControlToValidate="txtMaximumOffered"
                                    ErrorMessage="Must enter value greater than 0" ForeColor="Red" Operator="GreaterThan"
                                    Type="Integer" ValidationGroup="LevelNameValidationGroup"></asp:CompareValidator>
                            </div>
                            <div class="fifth-row">
                                <span>Description</span>
                                <asp:TextBox ID="txtLevelDescription" placeholder="What you are offering  and what the investor  will get for purchasing this level"
                                    runat="server" TextMode="MultiLine" Rows="4">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLevelDescription" runat="server" ControlToValidate="txtLevelDescription"
                                    ForeColor="Red" ToolTip="Description is required." ValidationGroup="LevelNameValidationGroup">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="bottom-right-corner">
                                <asp:Button ID="gotoStep4" runat="server" Text="Next Step" CssClass="next-step-button"
                                    Style="padding: 10px 24px 11px; font-size: 24px;"></asp:Button>
                            </div>
                        </div>
                        <div class="right-portion">
                            <div id="grid">
                                <telerik:RadGrid ID="GridViewLevel" runat="server" AutoGenerateColumns="False" GridLines="None"
                                    AllowPaging="false">
                                    <MasterTableView DataKeyNames="LevelID">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Level Name" UniqueName="LevelName">
                                                <ItemTemplate>
                                                    <asp:Label ID="levelNameLabel" runat="server" Text='<%#Eval("LevelName") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnLevelName" runat="server" Value='<%#Eval("LevelName") %>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                                <ItemTemplate>
                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnDescription" runat="server" Value='<%#Eval("Description") %>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Level Amount" UniqueName="LevelAmount">
                                                <ItemTemplate>
                                                    <asp:Label ID="levelAmountLabel" runat="server" Text='<%#String.Format("{0:C0}",Convert.ToDouble(Eval("LevelAmount")))%>'></asp:Label>
                                                    <asp:HiddenField ID="hdnLevelAmount" runat="server" Value='<%#Eval("LevelAmount") %>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Maximum Offered" UniqueName="MaximumOffered">
                                                <ItemTemplate>
                                                    <asp:Label ID="maximumOfferedLabel" runat="server" Text='<%#Eval("NumOffered")%>'></asp:Label>
                                                    <asp:HiddenField ID="hdnMaximumOffered" runat="server" Value='<%#Eval("NumOffered") %>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" Display="true">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="editLinkButton" runat="server" CommandName="Iedit" ToolTip="Edit Level"
                                                        CommandArgument='<%#Eval("LevelID")%>'>
                                                        <img id="downArrow" runat="server" src="~/Images/1379101373_pencil.png" height="15"
                                                            width="15" /></asp:LinkButton>&nbsp;&nbsp;
                                                    <asp:LinkButton ID="deleteLevelLinkButton" runat="server" CommandName="Idelete" ToolTip="Delete Level"
                                                        OnClientClick="return OnClientClicked();" CommandArgument='<%#Eval("LevelID")%>'>
                                                        <img id="Img1" runat="server" src="~/Images/delete.png" height="15" width="15" /></asp:LinkButton>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </contenttemplate>
                <triggers>
                    <asp:AsyncPostBackTrigger ControlID="addLevelButton" EventName="click" />
                    <asp:AsyncPostBackTrigger ControlID="gotoStep4" EventName="click" />
                </triggers>
            </asp:updatepanel>
        </div>
        <div class="accordianNew">
            <div class="step-title">
                Step Four:<a href="#">See Preview</a></div>
        </div>
        <div class="accordian-body">
            <br />
            <br />
            <asp:updatepanel id="updatepanel7" runat="server">
                <contenttemplate>
                    <div style="margin-left: 30px; text-align: center;">
                        <asp:Label ID="lblMessageStep4" runat="server" Font-Size="11"></asp:Label>
                    </div>
                    <div class="crowdboard-preview-container">
                        <asp:LinkButton ID="addInExtraLinkButton" runat="server" Text="Add In Extra" ForeColor="#99CCFF"></asp:LinkButton>
                        <div class="left-portion" style="border: 0px solid red; width: 60%;">
                            <div class="crowdboard-container group">
                                <div class="crowdboard-video">
                                    <a href="">
                                        <img src="Webcontent/theme/images/profilebanner.jpeg" /><div class="play-button">
                                            <img src="Webcontent/theme/images/playbutton.png" /></div>
                                    </a>
                                </div>
                                <div class="crowdboard-profile-picture">
                                    <a href="#">
                                        <asp:Image ID="imgBoardProfile" runat="server" ImageUrl="~/Images/blankBoardImage.png" /></a>
                                </div>
                                <div class="crowdboard-mini-console">
                                    <div class="crowdboard-measure">
                                        <div class="crowdboard-status-bar">
                                        </div>
                                        <div class="crowdboard-status-bar-position">
                                        </div>
                                        <div class="crowdboard-measure-text">
                                            <div class="crowdboard-measure-level">
                                                Level<br>
                                                <br></br>
                                                <span>
                                                <asp:Label ID="maxlevel" runat="server"></asp:Label>
                                                </span></br></div>
                                            <div class="crowdboard-measure-max-left">
                                                Max Left<br>
                                                <br></br>
                                                <span>
                                                <asp:Label ID="maxLeft" runat="server"></asp:Label>
                                                </span></br></div>
                                            <div class="crowdboard-measure-boarders-in">
                                                Boarders In<br>
                                                <br></br>
                                                <span>0</span></br></div>
                                        </div>
                                    </div>
                                    <a href="">
                                        <img src="Webcontent/theme/images/comment.png" /><div class="comment-number">
                                            (0)</div>
                                    </a><a href="">
                                        <img src="Webcontent/theme/images/recommend.png" /><div class="recommend-number">
                                            (0)</div>
                                    </a><a href="">
                                        <img src="Webcontent/theme/images/boost.png" /><div class="boost-number">
                                            (0)</div>
                                    </a><a href="">
                                        <img src="Webcontent/theme/images/watchwbg.png" /><div class="watch-number">
                                            (0)</div>
                                    </a>
                                    <input type="button" value="INVEST!" id="invest-button" />
                                </div>
                                <div class="crowdboard-text">
                                    Type:
                                    <asp:Label ID="lblBoardType" runat="server"></asp:Label>
                                    <div class="crowdboard-line-name">
                                        Name: <span>
                                            <asp:Label ID="lblCrowdBoardName" runat="server"></asp:Label></span></div>
                                    <div class="crowdboard-line-location">
                                        Location: <span>
                                            <asp:Label ID="lblLocation" runat="server"></asp:Label></span></div>
                                    <div class="crowdboard-line-seeking">
                                        Seeking: <span>
                                            <asp:Label ID="lblSeeking" runat="server"></asp:Label></span></div>
                                    <div class="crowdboard-line-DA">
                                        District: <span class="district-tag"><a href="#">
                                            <asp:Label ID="selectedDistrict" runat="server"></asp:Label></a></span> Area:
                                        <span class="area-tag"><a href="#">
                                            <asp:Label ID="SelectedAres" runat="server"></asp:Label></a></span></div>
                                    <div class="crowdboard-line-live-since">
                                        Live Since: <span></span>
                                    </div>
                                    <div class="crowdboard-wrapper-description">
                                        Description:<br>
                                        <br></br>
                                        <div class="crowdboard-description">
                                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                        </div>
                                        </br>
                                    </div>
                                </div>
                                <a href="#">
                                    <input type="button" value="View CrowdBoard" id="view-crowdboard-button" /></a>
                            </div>
                            <div class="bottom-right-corner">
                                <asp:Button ID="btnFinalSaveToDraft" runat="server" Text="Save" CssClass="save-button">
                                </asp:Button>
                                <asp:Button ID="btnFinalAddExtras" runat="server" Text="Add Extras" CssClass="save-button"
                                    Visible="false"></asp:Button>
                                <asp:Button ID="btnSendLive" runat="server" Text="Submit for Approval" CssClass="save-button"
                                    Visible="false"></asp:Button>
                            </div>
                        </div>
                    </div>
                </contenttemplate>
            </asp:updatepanel>
        </div>
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function SetImageUrl() {

                var path = '<%=BoardPicUrl %>'; //get the path of the selected image

                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest(path); //Invoke AJAX request to load the new image inside ImageEditor

            }
        </script>
    </telerik:RadCodeBlock>
    <div>
        <asp:sqldatasource id="sdBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT UserID,BoardID,Boardname,InvType,Description,city,Country,Investors,Watches,Comments,'$'+ convert(varchar(12),cast(RaisedTotal as dec(10,0)),1) As RaisedTotal,'$'+ convert(varchar(12),cast(TotalOffer as dec(10,0)),1) As TotalOfferText,DirectoryName,ISNULL(city,'')+' '+ISNULL (country,'') as Location,ViewsCount,TotalOffer,URL,areaID,Tags,YoutubeVideoUrl,Offer,VisibilityType,District,Areaname,BankLocation,FederalTaxID  FROM vwBoardInfo  Where BoardID=@BoardID"
            updatecommand="UPDATE Boards SET BoardName=@BoardName,Description=@Description,DirectoryName=@DirectoryName,InvType=@InvType,AreaID=@AreaID,Status=@Status,TotalOffer=@TotalOffer,city=@city,country=@country,EquityID=@EquityID  WHERE BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="BoardName" />
                <asp:Parameter Name="Description" />
                <asp:Parameter Name="DirectoryName" />
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="InvType" />
                <asp:Parameter Name="AreaID" />
                <asp:Parameter Name="Status" />
                <asp:Parameter Name="TotalOffer" />
                <asp:Parameter Name="city" />
                <asp:Parameter Name="country" />
                 <asp:Parameter Name="EquityID" Type="Int32" ConvertEmptyStringToNull="true" DefaultValue="" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdSaveExtraDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Tags=@Tags,Offer=@Offer,YoutubeVideoUrl=@YoutubeVideoUrl,VisibilityType=@VisibilityType WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Tags" />
                <asp:Parameter Name="Offer" />
                <asp:Parameter Name="YoutubeVideoUrl" />
                <asp:Parameter Name="VisibilityType" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCreateNewBoardDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spCreateNewBoard" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCheckBoardName" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from Boards WHERE BoardName=@BoardName">
            <selectparameters>
                <asp:Parameter Name="BoardName" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetBoardIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BoardId from Boards WHERE DirectoryName=@Name and UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="Name" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardsQuestion" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE boards SET Question1=@Question1,Question2=@Question2,Question3=@Question3,Question4=@Question4,Answer1=@Answer1,Answer2=@Answer2,Answer3=@Answer3,Answer4=@Answer4,AboutMe=@AboutMe WHERE BoardID=@BoardID AND UserID=@UserID">
            <updateparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                <asp:Parameter Name="Question1" Type="String" />
                <asp:Parameter Name="Question2" Type="String" />
                <asp:Parameter Name="Question3" Type="String" />
                <asp:Parameter Name="Question4" Type="String" />
                <asp:Parameter Name="Answer1" Type="String" />
                <asp:Parameter Name="Answer2" Type="String" />
                <asp:Parameter Name="Answer3" Type="String" />
                <asp:Parameter Name="Answer4" Type="String" />
                <asp:Parameter Name="AboutMe" Type="String" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardLevels" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO BoardLevels(BoardID,LevelName,Description,LevelAmount,NumOffered) VALUES(@BoardID,@LevelName,@Description,@LevelAmount,@NumOffered)"
            selectcommand="SELECT LevelID,BoardID,LevelName,Description,LevelAmount,NumOffered FROM BoardLevels WHERE BoardID=@BoardID"
            deletecommand="DELETE FROM BoardLevels WHERE BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="LevelName" />
                <asp:Parameter Name="Description" />
                <asp:Parameter Name="LevelAmount" />
                <asp:Parameter Name="NumOffered" />
            </insertparameters>
            <deleteparameters>
                <asp:Parameter Name="BoardID" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdSaveStatus" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Status=@Status WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="Status" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdActivateBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Status=4,DateActivated=GETDATE() WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdSaveVisibilityType" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET VisibilityType=@VisibilityType WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="VisibilityType" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestmentType" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT Value,EnglishName,EnglishDescription,ShortEnglishDesc FROM InvestmentType"
            updatecommand="Update Boards SET FederalTaxID=@FederalTaxID where BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="FederalTaxID" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <%-- <asp:SqlDataSource ID="sdAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT '0' As AreaID,'--Select Area--' as AreaName UNION SELECT AreaID,Districts.DistrictName+' - '+Areas.AreaName As  AreaName FROM Areas INNER JOIN Districts ON Areas.districtID=Districts.districtID">
    </asp:SqlDataSource>--%>
        <asp:sqldatasource id="sdAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <selectparameters>
                <asp:Parameter Name="districtID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT districtID,DistrictName,row_number()over(order by D.SortOrder) as rownumber FROM Districts D  Order by D.DistrictName">
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUpdateUrlDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET URL=@URL,YoutubeVideoUrl=@YoutubeVideoUrl where DirectoryName=@Name">
            <updateparameters>
                <asp:Parameter Name="URL" />
                <asp:Parameter Name="YoutubeVideoUrl" />
                <asp:Parameter Name="Name" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBalancedOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from BalancedUserRecord WHERE UserId=@UserId and UserBankAccountUri is not null">
            <selectparameters>
                <asp:Parameter Name="UserId" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdStripeOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from UserStripeAccount WHERE UserId=@UserId and StripeUserID is not null">
            <selectparameters>
                <asp:Parameter Name="UserId" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestmentLevelsAmount" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT '--Select Amount--' as FundAmountText,0  FundAmount,0 as indexs union SELECT CASE WHEN @BankLocation='US' THEN  '$ '+ CONVERT(varchar(50),FundAmount) ELSE '£ '+ CONVERT(varchar(50),FundAmount) END as FundAmountText,FundAmount,1 as indexs from InvestmentLevels order by FundAmount">
            <selectparameters>
                <asp:Parameter Name="BankLocation" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetAreaID" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT areaID from Areas WHERE AreaName=@AreaName">
            <selectparameters>
                <asp:Parameter Name="AreaName" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetBankLocation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT IsNull(BankLocation,'US') as BankLocation from Users WHERE UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetDistrictManagerEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand=" SELECT U.Email FROM Users U  Left Join districts D  ON U.UserID=D.Manager INNER JOIN Areas A On D.districtID=A.districtID WHERE A.AreaID=@AreaID">
            <selectparameters>
                <asp:Parameter Name="AreaID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdIsValidEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select main.*,U.Email from (SELECT userid,UserName, Status,case when TwitterUserID  is not null  then 'N/A' when FacebookUserID  is not null   then 'N/A'when LinkedInUserID  is not null   then 'N/A' when Status=1 and (LinkedInUserID is  null and FacebookUserID is  null  and TwitterUserID is  null)  then 'Check' else  'No Check' end as EmailVerified  FROM vwAllUsersInfo)main inner join Users U on U.UserID =main.userid where U.UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdEquityTypes" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select ID,TypeName,RequiredDocName1,RequiredDocName2,RequiredDocName3  from EquityTypes">
        </asp:sqldatasource>
    </div>
    <%-- <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>--%>
</asp:content>
