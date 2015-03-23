<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BoardDetails.aspx.vb"
    Inherits="CrowdBoardsApp.BoardDetails" MasterPageFile="~/MasterPage/Site.Master" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>Board Details</title>
    <style type="text/css">
        .horizontalDirection
        {
            float: left;
            width: 110px;
        }
        .size1of3
        {
            float: left;
            width: 25%;
        }
        .boardImage
        {
            /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 60px;
            width: 60px;
            background: #ececee;
            left: 720px;
            top: 290px;
            z-index: 200; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
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
        
        .LabelheadingWhite
        {
            clear: both;
            font-size: 16px;
            line-height: 1.5em;
            margin-bottom: 8px;
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
        .bottom-right-corner
        {
            bottom: 17px;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%--  <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="WebContent/Theme/styles/editmanageupdate.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script type="text/javascript" src="https://js.balancedpayments.com/v1/balanced.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <div class="popup_box_all" id="createBalacedAccountDiv">
        <table width="100%">
            <tr>
                <td colspan="2" style="text-align: right;">
                    <asp:linkbutton id="lbtnCloseBalanced" forecolor="Red" runat="server" onclientclick="return unloadPopupcreateBalacedAccount();">X</asp:linkbutton>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <span class="LabelheadingWhiteLarger">Please fill your Account details</span><br />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:label id="lblSuccessBalanced" runat="server" style="color: green;"></asp:label>
                    <asp:label id="lblErrorBalanced" runat="server" style="color: red;"></asp:label>
                </td>
            </tr>
        </table>
        <table width="100%" id="accountTable">
            <tr>
                <td style="width: 20%;">
                    <span class="LabelheadingWhite">Name</span>
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtName" readonly="true" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <span class="LabelheadingWhite">Email Address</span>
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtEmailForBankAccount" readonly="true" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <span class="LabelheadingWhite">Routing Number</span>
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtRoutingNumber" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <span class="LabelheadingWhite">Account Number</span>
                </td>
                <td style="width: 80%;">
                    <asp:textbox id="txtAccountNumber" runat="server">
                    </asp:textbox>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                    <span class="LabelheadingWhite">Type</span>
                </td>
                <td style="width: 80%;">
                    <asp:radiobutton id="rbChecking" checked="true" text="Checking" groupname="typeh"
                        runat="server" />
                    <asp:radiobutton id="rbSaving" text="Saving" groupname="typeh" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 20%;">
                </td>
                <td style="width: 80%;">
                    <asp:button id="btnCreateAcc" runat="server" cssclass="see-district-button" text="Create Account"
                        onclientclick="return CreateBankAccount();" />
                </td>
            </tr>
        </table>
    </div>
    <asp:hiddenfield id="balancedBankAccountURI" runat="server" />
    <asp:button id="btnCreateAccount" runat="server" text="Create Account" style="display: none;" />
    <asp:button id="btnBackgroungPicture" runat="server" text="Upload" style="display: none;" />
    <asp:button id="btnCoverPicture" runat="server" text="Upload" style="display: none;" />
    <asp:button id="btnBoardFiles" runat="server" text="Upload" style="display: none;" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <%-- <asp:scriptmanager runat="server" id="RadScriptManager1">
        <scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </scripts>
    </asp:scriptmanager>--%>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            balanced.init('<%=apiMarketplace %>');

            function loadPopupcreateBalacedAccount() {    // To Load the Popupbox

                if (confirm("Please Configure your Balanced Account first")) {
                    $('#createBalacedAccountDiv').fadeIn("slow");
                    //                    var btn = document.getElementById("<%= btnActivateBoard.ClientID %>");
                    //                    btn.set_autoPostBack(false);
                }
                else {
                    return false;
                }
                return false;
            }
            function ConfirmStripeAccount() {

                if (confirm("Please Configure your Account first!")) {
                    document.getElementById("<%= btnCreateStripeAccount.ClientID %>").click();
                }
                else {
                    return false;
                }
                return false;
            }
            function unloadPopupcreateBalacedAccount() {    // TO Unload the Popupbox
                $('#createBalacedAccountDiv').fadeOut("slow");
                //                var btn = document.getElementById("<%= btnActivateBoard.ClientID %>");
                //                btn.set_autoPostBack(true);
                return false;
            }

            function validateBankAccountEntries() {
                var nameAcc = document.getElementById("BodyContent_txtName").value;
                var emailAddressAcc = document.getElementById("BodyContent_txtEmailForBankAccount").value;
                var routingNumber = document.getElementById("BodyContent_txtRoutingNumber").value;
                var accountNumber = document.getElementById("BodyContent_txtAccountNumber").value;


                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                var valid = 1;
                if ($.trim(nameAcc).length == 0 || $.trim(emailAddressAcc).length == 0 || $.trim(routingNumber).length == 0 || $.trim(accountNumber).length == 0) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "All fields are required";
                    valid = 0;
                }
                else if (!filter.test(emailAddressAcc)) {
                    document.getElementById("BodyContent_lblErrorBalanced").innerHTML = "Please provide valid email address";
                    valid = 0;
                }
                //                else if (!balanced.bankAccount.validateRoutingNumber(routingNumber)) {
                //                    document.getElementById("lblErrorBalanced").innerHTML = "Routing Number is not valid";
                //                    valid = 0;
                //                }

                if (valid == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }

            function CreateBankAccount() {
                if (!validateBankAccountEntries()) {

                    return false;
                }
                var Acctype;
                if (document.getElementById("BodyContent_rbChecking").checked) {
                    Acctype = 'checking';
                }
                else {
                    Acctype = 'saving';
                }

                var bankAccountData = {
                    name: document.getElementById("BodyContent_txtName").value,
                    routing_number: document.getElementById("BodyContent_txtRoutingNumber").value,
                    account_number: document.getElementById("BodyContent_txtAccountNumber").value,
                    type: Acctype
                };

                balanced.bankAccount.create(bankAccountData, responseCallbackHandler);

                return false;
            }
            function responseCallbackHandler(response) {
                if (response.status == 201) {
                    SetValueInHiddenForAccount(response.data)
                    document.getElementById("<%= btnCreateAccount.ClientID %>").click();

                }
                else {
                    alert("error: " + response.status);
                    return false;
                }

            }
            function SetValueInHiddenForAccount(response) {
                var balancedBankAccountURI = response['uri'];
                document.getElementById("<%=balancedBankAccountURI.ClientID %>").value = balancedBankAccountURI;
                // alert(document.getElementById('<%=balancedBankAccountURI.ClientID %>').value);
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
            function OpenAddExtraWindow(boardId, directoryName, PicUrl) {

                var manager = $find("<%= RadWindowManager1.ClientID %>");

                if (boardId == 0 || directoryName == "") {
                    HideShow();
                    alert("Please Select Board First");
                    return false;
                }
                else {
                    var url = "rwAddExtra.aspx?BoardId=" + boardId.toString() + "&directoryName=" + directoryName.toString() + "&url=" + PicUrl.toString();
                    manager.open(url, "RadWindow2");
                    return false;
                }

            }
            function fileUploadedBackground(sender, args) {
                document.getElementById("<%= btnBackgroungPicture.ClientID %>").click();
            }
            function fileUploadedCover(sender, args) {
                document.getElementById("<%= btnCoverPicture.ClientID %>").click();
            }
            function fileUploadedBoard(sender, args) {
                document.getElementById("<%= btnBoardFiles.ClientID %>").click();
            }      
        </script>
        <script type="text/javascript">

            function unloadPopupBoxDistricts() {    // TO Unload the Popupbox

                $('#popup_box_News').fadeOut("slow");
                $('#popup_Confirm').fadeOut("slow");
                //$("#container").css({ // this is just for style       
                //    "opacity": "1" 
                //});
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

            function loadPopupBoxArea() {    // To Load the Popupbox
                //alert(i);
                alert('Testing');
                $('#popup_Area').fadeIn("slow");
                return false;
            }
            function unloadPopupBoxConfirm() {  // TO Unload the Popupbox

                var district = document.getElementById('BodyContent_hdnSelectedDistrict').value;
                var area = document.getElementById('BodyContent_hdnSelectedArea').value;
                document.getElementById("<%= districtLabel.ClientID %>").innerHTML = district + ' District';
                document.getElementById("<%= areaLabel.ClientID %>").innerHTML = 'You have Selected the ' + area + '  Area in the ';

                $('#popup_Confirm').fadeOut("slow");

                return false;
            }

            function loadPopupBoxConfirm(areaName) {    // To Load the Popupbox
                // alert(areaName);
                // $('#popup_Confirm').fadeIn("slow");
                return false;
            }


            function loadPopupBoxArea(i, name) {
                document.getElementById('BodyContent_hdnSelectedDistrict').value = name;
                $('#popup_Area' + i).fadeIn("slow");
                return false;

            }


            function unloadPopupBoxArea(i) {
                $('#popup_Area' + i).fadeOut("slow");
                loadPopupBoxDiscricts();
                return false;
            }




            function loadPopupBoxConfirm(area) {
                document.getElementById('BodyContent_hdnSelectedArea').value = area;
                var district = document.getElementById('BodyContent_hdnSelectedDistrict').value;
                document.getElementById("<%= lblDistrict.ClientID %>").innerHTML = district;
                document.getElementById("<%= lblArea.ClientID %>").innerHTML = area;

                $('#popup_box_News').fadeOut("slow");
                $('#popup_Confirm').fadeIn("slow");
                return false;
            }

                
        </script>
        <script type="text/javascript">
            function fileUploadedProfile(sender, args) {
                document.getElementById("<%= btnProfilePicture.ClientID %>").click();
            }

            function ShowBoardsDetails() {

                var boardsDetailsDiv = document.getElementById("boardsDetailsDiv")
                var imgAddBoarder = document.getElementById("imgAddBoarder")
                if (boardsDetailsDiv.className == "HideBoard") {
                    boardsDetailsDiv.className = "ShowBoard";
                    imgAddBoarder.src = "Images/arrowUp.png";
                }
                else {
                    boardsDetailsDiv.className = "HideBoard";

                    imgAddBoarder.src = "Images/arrowDownHome.png";
                }
                return false;
            }
            function backAway() {

                window.location = "CrowdboardCommand.aspx"

            }
            function getContent() {

                var editor = $find("<%= reCreatePage.ClientID %>");

                alert("RadEditor HTML content: \n \n" + editor.get_html());

                return false;
            } 
        </script>
    </telerik:RadScriptBlock>
    <div style="width: 100%; z-index: 120; margin: auto;">
        <%-- <asp:UpdatePanel ID="messageUpdatePanel" runat="server">
            <ContentTemplate>--%>
        <asp:label id="lblMessage" runat="server" visible="false" font-size="15px"></asp:label>
        <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <%--<asp:UpdatePanel ID="boardUpdatePanel" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnProfilePicture" />
        </Triggers>
        <ContentTemplate>--%>
    <asp:hiddenfield id="hdnSelectedDistrict" runat="server" />
    <asp:hiddenfield id="hdnSelectedArea" runat="server" />
    <asp:button id="btnCreateStripeAccount" runat="server" text="Submit for Approval"
        style="display: none;" />
    <div class="popup_box_Confirm" id="popup_Confirm">
        <div style="background-color: #ffffff;">
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <span class="LabelheadingWhite">You have Selected the
                            <asp:label id="lblArea" runat="server"></asp:label>
                            Area in the
                            <asp:label id="lblDistrict" runat="server"></asp:label>
                            District</span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:button id="btnChangeArea" runat="server" text="Change" cssclass="see-district-button"
                            style="font-size: 14px;" onclientclick="return loadPopupBoxDiscricts();" />
                    </td>
                    <td>
                        <asp:button id="btnConfirmArea" runat="server" text="Confirm" cssclass="see-district-button"
                            style="font-size: 14px;" onclientclick="return unloadPopupBoxConfirm();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="popup_box_all" id="popup_box_News">
        <div style="text-align: right;">
            <asp:linkbutton id="lbtnCloseDistrict" forecolor="Red" runat="server" onclientclick="return unloadPopupBoxDistricts();">
                <img src="Images/btncross.png" alt="X" /></asp:linkbutton></div>
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
                                                    ForeColor="White"></asp:LinkButton>
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
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <div style="vertical-align: top;">
                                                            <img id="scroll_L_Arrow" width="25" onclick='<%# "return unloadPopupBoxArea("+ Eval("districtID").ToString() + ");" %>'
                                                                style="cursor: pointer;" src="WebContent/Theme/images/backImage.png">
                                                            <span class="LabelheadingWhite" style="vertical-align: top;">&nbsp;&nbsp;&nbsp;Now Select
                                                                an Area Within your District</span></div>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return unloadPopupBoxBoost();"><img src="Images/btncross.png" alt="X" /></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <asp:DataList ID="areaDataList" runat="server" RepeatColumns="2" RepeatLayout="Table">
                                                <ItemTemplate>
                                                    <div style="text-align: center; min-height: 50px" class="linkCss">
                                                        <table width="100%" cellpadding="3">
                                                            <tr>
                                                                <td style="height: 5px;">
                                                                    <asp:HiddenField ID="hdnAreaName" runat="server" Value='<%#Eval("AreaName")%>' />
                                                                    <asp:LinkButton ID="areaNameLinkButton" runat="server" Text='<%#Eval("AreaName")%>'
                                                                        ForeColor="White" OnClientClick="return loadPopupBoxConfirm(this.innerHTML);"></asp:LinkButton>
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
    <div class="main-body">
        <div class="title">
            <a href="../CrowdboardCommand.aspx">Back to My CrowdBoards</a>
            <asp:label runat="server" id="lblCrowdboardName"></asp:label>
            <div class="navigational-links">
                <asp:linkbutton id="lbtnEdit" runat="server" forecolor="#75b4c6">Edit</asp:linkbutton>
                <asp:linkbutton id="lbtnManage" runat="server" forecolor="#75b4c6">Manage</asp:linkbutton>
                <asp:linkbutton id="lbtnUpdate" runat="server" forecolor="#75b4c6">Updates</asp:linkbutton>
            </div>
        </div>
    </div>
    <div class="edit-container" style="margin-bottom: 8px; min-height: 675px; height:auto;">
        <div class="edit-navigation">
            <asp:linkbutton id="lbtnEditCrowdBoard" runat="server" forecolor="#75b4c6">Basic Information</asp:linkbutton>
            <asp:linkbutton id="lbtnLevels" runat="server" forecolor="#75b4c6">Set Levels</asp:linkbutton>
            <asp:linkbutton id="lbtnDesign" runat="server" forecolor="#75b4c6">Design</asp:linkbutton>
            <asp:linkbutton id="lbtnMoreInfo" runat="server" forecolor="#75b4c6">More Info</asp:linkbutton>
            <asp:linkbutton id="lbtnMediaLinks" runat="server" forecolor="#75b4c6">Extras</asp:linkbutton>
            <%-- <asp:linkbutton id="lbtnUploadFiles" runat="server" forecolor="#75b4c6">Upload Files</asp:linkbutton>
            <asp:linkbutton id="lbtnCrowdBoardTeam" runat="server" forecolor="#75b4c6">CrowdBoard Team</asp:linkbutton>--%>
            <%-- <a href="editcrowdboardextras.html">Extras</a>--%>
            <%-- <asp:linkbutton id="lbtnPreview" runat="server" forecolor="#75b4c6" visible="false">Preview</asp:linkbutton>--%>
        </div>
        <telerik:RadMultiPage ID="RadMultiPage2" runat="server" Width="100%" SelectedIndex="0">
            <telerik:RadPageView ID="editCrowdBoardView" runat="server" Selected="true">
                <div class="title">
                    Basic Information
                </div>
                <div style="margin-left: 525px">
                    <asp:label id="lblMessageStep2" runat="server" style="font-size: 15px; margin-left: 150px;">
                    </asp:label>
                    <asp:label id="lblMessageStepTwo" runat="server" style="font-size: 15px; text-align: right;
                        margin-right: 50px;"></asp:label>
                </div>
                <div class="crowdboard-details-container">
                    <div class="left-portion">
                        <div style="margin-left: 0px;">
                            <table width="60%" border="0" cellspacing="6">
                                <tr>
                                    <td>
                                        <span style="font-size: 20px; color: #788586;">Select Board Type</span>
                                    </td>
                                    <td>
                                        <telerik:RadDropDownList ID="rddlBoardType" runat="server" DataSourceID="sdInvestmentType"
                                            Width="170px" height="30px" DataTextField="EnglishName" DataValueField="Value"
                                            AutoPostBack="true">
                                        </telerik:RadDropDownList>
                                    </td>
                                </tr>
                                <tr runat="server" id="equityLocationTR">
                                    <td>  <div style="margin:2px;">
                                        <span style="font-size: 20px; color: #788586;">Choose Location</span>
                                   </div> </td>
                                    <td>
                                    <p style="font-size:14px;">Other locations are not supported at this time</p>
                                        <asp:dropdownlist id="EquityTypesDropDownList" datavaluefield="ID" datatextfield="typeName"
                                            style="width: 180px; height: 25px;" datasourceid="sdEquityTypes" runat="server">
                                        </asp:dropdownlist>
                                       <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ErrorMessage="<br>Please select Location" ControlToValidate="EquityTypesDropDownList" setfocusonerror="true" display="Dynamic" validationgroup="addBoard" InitialValue="0"  forecolor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="first-row">
                            <table>
                                <tr style="vertical-align: top;">
                                    <td>
                                        Upload Picture<br />
                                    </td>
                                    <td>
                                        <telerik:RadAsyncUpload ID="rauProfilePicture" runat="server" MultipleFileSelection="Disabled"
                                            OnClientFilesUploaded="fileUploadedProfile" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx"
                                            AllowedFileExtensions=".jpg,.gif,.png">
                                        </telerik:RadAsyncUpload>
                                    </td>
                                    <td>
                                        <div style="margin-left: 160px;">
                                            <asp:button id="btnActivateBoard" runat="server" text="Submit for Approval" visible="false"
                                                style="padding: 6px 28px 8px; font-size: 24px;" cssclass="submit-button" validationgroup="addBoard" />
                                            <asp:button id="btnDeActivateBoard" runat="server" text="DeActivate Board" visible="false"
                                                style="padding: 6px 28px 8px; font-size: 24px;" cssclass="submit-button" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="second-row1">
                            <table width ="100%">
                                <tr>
                                    <td style="text-align:center;">
                                        <%--<div class="picture-frame">--%>
                                        <div style="flot:right;">
                                            <asp:image id="imgProfile" runat="server" height="118px" width="118px" alternatetext="Upload Picture" />
                                            <asp:button id="btnProfilePicture" runat="server" text="Upload" style="display: none;" />
                                        </div>
                                    </td>
                                    <td>
                                   
                                       <%-- <div class="name-crowdboard">--%>
                                            <asp:textbox id="txtBoardName" runat="server" placeholder="Name your CrowdBoard">
                                            </asp:textbox>
                                            <asp:hiddenfield runat="server" id="hdnDirectoryName" />
                                            <asp:requiredfieldvalidator id="rfvBoardName" runat="server" forecolor="Red" controltovalidate="txtBoardName"
                                                setfocusonerror="true" display="Dynamic" validationgroup="addBoard" errormessage="</br>Please Enter Board Name">
                                            </asp:requiredfieldvalidator>
                                            <asp:regularexpressionvalidator id="rfvBordNameSpec" runat="server" controltovalidate="txtBoardName"
                                                forecolor="Red" display="Dynamic" validationgroup="addBoard" setfocusonerror="true"
                                                validationexpression="^[^\%\/\\\&\?\,\'\;\:\!\-\<\>\|\'\*]+$" errormessage="</br>No Special Character">
                                            </asp:regularexpressionvalidator>
                                       <%-- </div>--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    <div class="third-row">
                        <div class="description">
                            <span>Description</span>
                            <asp:textbox id="txtDescription" maxlength="145" textmode="MultiLine" runat="server"
                                placeholder="About Your CrowdBoard">
                            </asp:textbox>
                            <span>145 characters</span>
                            <asp:regularexpressionvalidator id="revDesc" runat="server" controltovalidate="txtDescription"
                                errormessage="</br>Please enter upto 145 characters" forecolor="Red" validationexpression="^.{1,145}$"
                                display="Dynamic" validationgroup="addBoard">
                            </asp:regularexpressionvalidator>
                        </div>
                    </div>
                    <div class="fourth-row">
                        Location
                        <asp:textbox id="txtCity" runat="server" placeholder="city">
                        </asp:textbox>
                        <asp:textbox id="txtCounty" runat="server" placeholder="State or Country">
                        </asp:textbox>
                    </div>
                    <div class="fifth-row">
                        Set your target amount to raise
                        <asp:label runat="server" id="lblAmtType" font-bold="true"></asp:label>
                        <asp:textbox id="txtSeeking" runat="server" placeholder="100">
                        </asp:textbox>
                        <asp:requiredfieldvalidator id="rfvtxtSeeking" runat="server" forecolor="Red" controltovalidate="txtSeeking"
                            setfocusonerror="true" display="Dynamic" validationgroup="addBoard" errormessage="</br>Please Enter Seeking Amount">
                        </asp:requiredfieldvalidator>
                        <asp:regularexpressionvalidator id="RegularExpressionValidator1" forecolor="Red"
                            controltovalidate="txtSeeking" validationexpression="\d+(\.\d{1,2})?" display="Dynamic"
                            setfocusonerror="true" text="Number Only" runat="server" validationgroup="addBoard" />
                        <asp:comparevalidator id="CompareValidator1" runat="server" valuetocompare="0" controltovalidate="txtSeeking"
                            errormessage="Must enter value greater than 0" forecolor="Red" operator="GreaterThan"
                            type="Integer" validationgroup="addBoard">
                        </asp:comparevalidator>
                    </div>
                    <div class="sixth-row">
                        Select District
                        <asp:button id="btnSeeDistrict" runat="server" cssclass="see-district-button" text="See Districts"
                            onclientclick="return loadPopupBoxDiscricts();"></asp:button>
                        <br />
                        <table id="taxIDTable" runat="server" visible="false" style="margin-top: 10px;">
                            <tr>
                                <td>
                                    <span class="LabelheadingWhiteNew">
                                        <asp:label id="lblFederalTaxID" runat="server" text="Federal Tax ID"></asp:label></span>&nbsp;
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtFederalTaxID" runat="server">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <span style="font-size: 12px; font-style: italic; font-weight: bold;">
                            <asp:label id="areaLabel" runat="server"></asp:label>
                            <asp:label id="districtLabel" runat="server"></asp:label>
                        </span>
                    </div>
                    <div class="bottom-right-corner">
                        <asp:button id="btnSaveBasicInfo" runat="server" validationgroup="addBoard" text="Save"
                            style="padding: 6px 28px 8px; font-size: 24px; margin-right: -20px;" cssclass="save-button">
                        </asp:button>
                    </div>
                </div>
                <%--<div class="right-portion">
                        <div class="preview-container">
                        </div>
                    </div>--%>
    </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="detailPageInformation" runat="server">
                <div class="title">
                    Set Levels</div>
                <div style="margin-left: 20px; text-align: center;">
                    <asp:label id="lblMessageStep3" runat="server" style="font-size: 12px;"></asp:label>
                </div>
                <div class="crowdboard-levels-container">
                    <div class="left-portion" style="width: 58%;">
                        <div class="first-row" style="margin-left: 184px;">
                            <span>Level
                                <asp:label id="levelNumberLabel" runat="server"></asp:label></span>
                            <asp:button id="addLevelButton" runat="server" text="Add Level" cssclass="add-level-button"
                                validationgroup="LevelNameValidationGroup"></asp:button>
                        </div>
                        <div class="second-row1">
                            <span>Level Name</span><asp:textbox id="txtLevelName" runat="server" placeholder="Level Name">
                            </asp:textbox>
                            <asp:requiredfieldvalidator id="rfvLevelName" runat="server" controltovalidate="txtLevelName"
                                forecolor="Red" tooltip="Level Name is required." validationgroup="LevelNameValidationGroup">*</asp:requiredfieldvalidator>
                        </div>
                        <div class="third-row">
                            <span>Amount</span>
                            <asp:dropdownlist id="ddlInvestmentLevels" style="line-height: 1.5em; margin-left: 5px;
                                height: 30px; width: 170px; padding-left: 5px;" runat="server" datasourceid="sdInvestmentLevelsAmount"
                                datatextfield="FundAmountText" datavaluefield="FundAmount" autopostback="true">
                            </asp:dropdownlist>
                            <asp:hiddenfield id="hdnPrice" runat="server" />
                            <asp:requiredfieldvalidator id="rfvLevelAmount" runat="server" controltovalidate="ddlInvestmentLevels"
                                forecolor="Red" tooltip="Level Amount is required." validationgroup="LevelNameValidationGroup"
                                display="Dynamic" initialvalue="0">*</asp:requiredfieldvalidator>
                        </div>
                        <div class="fourth-row">
                            <span>Quantity Offered</span>
                            <asp:textbox id="txtMaximumOffered" placeholder="Maximum Offered" runat="server">
                            </asp:textbox>
                            <asp:requiredfieldvalidator id="rfvMaximumOffered" runat="server" controltovalidate="txtMaximumOffered"
                                forecolor="Red" tooltip="Maximum Offered is required." validationgroup="LevelNameValidationGroup">*</asp:requiredfieldvalidator>
                            <asp:regularexpressionvalidator id="revMaximumOffered" forecolor="Red" controltovalidate="txtMaximumOffered"
                                validationexpression="\d+(\.\d{1,2})?" display="Dynamic" text="Number Only" runat="server"
                                validationgroup="LevelNameValidationGroup" />
                            <asp:comparevalidator id="cvMaximumOffered" runat="server" valuetocompare="0" controltovalidate="txtMaximumOffered"
                                errormessage="Must enter value greater than 0" forecolor="Red" operator="GreaterThan"
                                type="Integer" validationgroup="LevelNameValidationGroup">
                            </asp:comparevalidator>
                        </div>
                        <div class="fifth-row">
                            <span>Description</span>
                            <asp:textbox id="txtLevelDescription" placeholder="What you are offering  and what the investor  will get for purchasing this level"
                                runat="server" textmode="MultiLine">
                            </asp:textbox>
                            <asp:requiredfieldvalidator id="rfvLevelDescription" runat="server" controltovalidate="txtLevelDescription"
                                forecolor="Red" tooltip="Description is required." validationgroup="LevelNameValidationGroup">*</asp:requiredfieldvalidator>
                        </div>
                    </div>
                    <div class="right-portion" style="width: 42%;">
                        <telerik:RadGrid ID="rgBoardLevels" runat="server" AutoGenerateColumns="False" GridLines="None"
                            AllowPaging="false">
                            <mastertableview datakeynames="LevelID">
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
                                            <asp:Label ID="levelAmountLabel" runat="server" Text='<%# GetAmount(Eval("LevelAmount"))%>'></asp:Label>
                                            <asp:HiddenField ID="hdnLevelAmount" runat="server" Value='<%#Eval("LevelAmount") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Maximum Offered" UniqueName="MaximumOffered">
                                        <ItemTemplate>
                                            <asp:Label ID="maximumOfferedLabel" runat="server" Text='<%#Eval("NumOffered")%>'></asp:Label>
                                            <asp:HiddenField ID="hdnMaximumOffered" runat="server" Value='<%#Eval("NumOffered") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Action" ItemStyle-Width="75px">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="editLinkImageButton" Height="15px" Width="15px" runat="server"
                                                ImageUrl="~/Images/1379101373_pencil.png" ToolTip="Edit" CommandName="IEdit"
                                                CommandArgument='<%#Eval("LevelID")%>' />
                                            <asp:ImageButton ID="ImageButton1" Height="15px" Width="15px" runat="server" Visible='<%#Eval("isInvested")%>'
                                                OnClientClick="return confirm('Are you sure you want to Delete?')" ImageUrl="~/Images/delete.png"
                                                ToolTip="Delete" CommandName="IDelete" CommandArgument='<%#Eval("LevelID")%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </mastertableview>
                        </telerik:RadGrid>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="designView" runat="server">
                <div class="title">
                    Design</div>
                <div style="margin-left: 20px; text-align: center;">
                    <asp:label id="lblMessageDesign" runat="server" style="font-size: 12px;"></asp:label>
                </div>
                <div class="design-container">
                    <div class="left-column">
                        <div class="first-row">
                            <span>Video URL</span>
                            <asp:textbox id="txtYoutubeVideoUrl" runat="server" placeholder="Video URL">
                            </asp:textbox>
                        </div>
                        <div style="font-size: 18px; font-weight: 600;">
                            <table>
                                <tr>
                                    <td>
                                        <span>Video Image <span style="font-size: 10px;">(800 x 425 pixels)</span></span>
                                    </td>
                                    <td>
                                        <div style="padding-left: 15px;">
                                            <telerik:RadAsyncUpload ID="rauBackgroundPicture" runat="server" MultipleFileSelection="Disabled"
                                                OnClientFilesUploaded="fileUploadedBackground" Width="300px" HttpHandlerUrl="~/CustomHandler.ashx"
                                                AllowedFileExtensions=".jpg">
                                            </telerik:RadAsyncUpload>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="third-row">
                            <div class="image-box" style="background-color: #fff; border: 1px;">
                                <telerik:RadImageEditor ID="rieBackgroundPic" runat="server" Height="300px" Width="98%">
                                    <tools>
                                        <telerik:ImageEditorToolGroup>
                                            <telerik:ImageEditorTool CommandName="Crop"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorTool CommandName="ZoomIn"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorToolSeparator></telerik:ImageEditorToolSeparator>
                                            <telerik:ImageEditorTool CommandName="ZoomOut"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorTool CommandName="Save"></telerik:ImageEditorTool>
                                        </telerik:ImageEditorToolGroup>
                                    </tools>
                                </telerik:RadImageEditor>
                            </div>
                        </div>
                    </div>
                    <div class="right-column">
                        <div class="first-row">
                            <asp:button id="btnAddToCrowdboardDesign" runat="server" text="Save" cssclass="save-button" />
                        </div>
                        <div style="font-size: 18px; font-weight: 600;">
                            <table>
                                <tr>
                                    <td>
                                        <span>Cover Image <span style="font-size: 10px;">( 500 x 250 pixels)</span></span>
                                    </td>
                                    <td>
                                        <div style="padding-left: 15px;">
                                            <telerik:RadAsyncUpload ID="rauCoverPicture" runat="server" MultipleFileSelection="Disabled"
                                                OnClientFilesUploaded="fileUploadedCover" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx"
                                                AllowedFileExtensions=".jpg">
                                            </telerik:RadAsyncUpload>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <div class="image-box" style="background-color: #fff; border: 0px;">
                                <telerik:RadImageEditor ID="rieCoverPic" runat="server" Height="300px" Width="98%">
                                    <tools>
                                        <telerik:ImageEditorToolGroup>
                                            <telerik:ImageEditorTool CommandName="Crop"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorTool CommandName="ZoomIn"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorToolSeparator></telerik:ImageEditorToolSeparator>
                                            <telerik:ImageEditorTool CommandName="ZoomOut"></telerik:ImageEditorTool>
                                            <telerik:ImageEditorTool CommandName="Save"></telerik:ImageEditorTool>
                                        </telerik:ImageEditorToolGroup>
                                    </tools>
                                </telerik:RadImageEditor>
                            </div>
                        </div>
                    </div>
                    <%--<div class="left-column">
                    <table width="100%" border="0">
                        <tr>
                            <td style="width: 50%; vertical-align: top;">
                                <div id="backgroundDiv" runat="server" style="width: 95%; height: 400px; border-color: #99CCFF;
                                    border-style: solid; border-width: thin; background-color: #262626;">
                                    <div style="width: 100%; height: 15%;">
                                        &nbsp;
                                    </div>
                                    <div style="width: 100%; height: 70%;">
                                        <div style="width: 15%; height: 100%; float: left;">
                                            &nbsp;
                                        </div>
                                        <div style="width: 70%; height: 100%; float: left; border-color: #99CCFF; border-style: solid;
                                            border-width: thin; background-color: #262626;">
                                            <div id="coverPicDiv" runat="server" style="width: 100%; height: 30%; border-bottom-color: #99CCFF;
                                                border-bottom-style: solid; border-bottom-width: thin; background-color: #262626;">
                                                &nbsp;
                                            </div>
                                            <div style="width: 100%; height: 70%;">
                                                &nbsp;
                                            </div>
                                        </div>
                                        <div style="width: 15%; height: 15%; float: right;">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div style="width: 100%; height: 15%;">
                                        &nbsp;
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>--%>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="moreInfoView" runat="server">
                <div class="title">
                    More Information
                    <asp:button id="btnSaveMoreInfo" runat="server" text="Save" cssclass="save-button" />
                </div>
                <div style="width: 100%; text-align: center;">
                    <asp:label id="lblMessageMoreInfo" runat="server" style="font-size: 12px;"></asp:label></div>
                <div style="margin-top: 20px; text-align: center;">
                    <telerik:RadEditor ID="reCreatePage" runat="server" Width="95%" Height="435px" Style="margin-left: 18px;">
                        <tools>
                            <telerik:EditorToolGroup Tag="FileManagers">
                                <telerik:EditorTool Name="ImageManager"></telerik:EditorTool>
                            </telerik:EditorToolGroup>
                        </tools>
                        <imagemanager searchpatterns="*.jpeg,*.jpg,*.png,*.gif,*.bmp" enableasyncupload="true" />
                    </telerik:RadEditor>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="mediaLinksView" runat="server">
                <div class="title">
                    Extras</div>
                <div class="column1">
                    <div class="subheading">
                        Media Links</div>
                    <div class="extras-container">
                        <asp:label id="lblMessageMediaLinks" runat="server" style="font-size: 12px;"></asp:label>
                        <div class="preview-container">
                            <telerik:RadGrid ID="rgBoardMediaLinks" runat="server" AutoGenerateColumns="False"
                                GridLines="None" AllowPaging="true" PageSize="5">
                                <mastertableview datakeynames="ID">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="urlNameLabel" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                <asp:HiddenField ID="hdnName" runat="server" Value='<%#Eval("Name") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Url" UniqueName="Url">
                                            <ItemTemplate>
                                                <asp:Label ID="urlLabel" runat="server" Text='<%#Eval("Url") %>'></asp:Label>
                                                <asp:HiddenField ID="hdnUrl" runat="server" Value='<%#Eval("Url") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="DateCreated" SortExpression="DateCreated" HeaderText="Date Created"
                                            UniqueName="DateCreated" DataType="System.DateTime" DataFormatString="{0:d}">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="editLinkImageButton" Height="15px" Width="15px" runat="server"
                                                    ImageUrl="~/Images/1379101373_pencil.png" ToolTip="Edit" CommandName="IEdit"
                                                    CommandArgument='<%#Eval("ID")%>' />
                                                <asp:ImageButton ID="deleteLinkImageButton" Height="15px" Width="15px" runat="server"
                                                    OnClientClick="return confirm('Are you sure you want to Delete?')" ImageUrl="~/Images/delete.png"
                                                    ToolTip="Delete" CommandName="IDelete" CommandArgument='<%#Eval("ID")%>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </mastertableview>
                            </telerik:RadGrid>
                        </div>
                        <div class="form-row">
                            <telerik:RadTextBox ID="txtMediaLinkName" runat="server" Style="font-size: 20px;
                                line-height: 1.5em; margin-left: 3%; margin-top: 8px; padding-left: 8px;" Width="94%"
                                Height="30px" placeholder="Name">
                            </telerik:RadTextBox>
                            <asp:requiredfieldvalidator id="rfvMediaLinksName" runat="server" controltovalidate="txtMediaLinkName"
                                forecolor="Red" errormessage="Name is Required" validationgroup="AddMediaLinks">*</asp:requiredfieldvalidator></div>
                        <div class="form-row">
                            <telerik:RadTextBox ID="txtMediaLinkUrl" runat="server" Style="font-size: 20px; line-height: 1.5em;
                                margin-left: 3%; margin-top: 8px; padding-left: 8px;" Width="94%" Height="30px"
                                placeholder="URL">
                            </telerik:RadTextBox>
                            <asp:requiredfieldvalidator id="rfvMediaLinksUrl" runat="server" controltovalidate="txtMediaLinkUrl"
                                forecolor="Red" errormessage="Url is Required" validationgroup="AddMediaLinks">*</asp:requiredfieldvalidator></div>
                        <div>
                            <div class="float-left">
                                <asp:button id="btnAddMediaLink" runat="server" text="Add" cssclass="save-button"
                                    validationgroup="AddMediaLinks" /></div>
                            <%--<div class="float-right">
                                <input type="button" value="Save" id="save-button" /></div>--%>
                        </div>
                    </div>
                </div>
                <div class="column2">
                    <div class="subheading">
                        Upload Files</div>
                    <div style="text-align: center;">
                        <asp:label id="lblMesaageUploadFiles" runat="server"></asp:label>
                    </div>
                    <div class="extras-container">
                        <div class="preview-container">
                            <telerik:RadGrid ID="rgBoardFiles" runat="server" AutoGenerateColumns="False" GridLines="None"
                                AllowPaging="true" PageSize="5">
                                <mastertableview datakeynames="ID">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="FileName" UniqueName="FileName">
                                            <ItemTemplate>
                                                <asp:Label ID="fileNameLabel" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                                                <asp:HiddenField ID="hdnFileName" runat="server" Value='<%#Eval("FileName") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="DateUploaded" SortExpression="DateUploaded" HeaderText="Date Uploaded"
                                            UniqueName="DateUploaded" DataType="System.DateTime" DataFormatString="{0:d}">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="deleteFileImageButton" Height="15px" Width="15px" runat="server"
                                                    OnClientClick="return confirm('Are you sure you want to Delete?')" ImageUrl="~/Images/delete.png"
                                                    ToolTip="Delete" CommandName="IDelete" CommandArgument='<%#Eval("ID")%>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </mastertableview>
                            </telerik:RadGrid>
                        </div>
                        <div class="form-row">
                            <span style="padding-left: 5px; padding-right: 5px; font-size: 12px; color: #75b4c6;">
                                Please Upload any files that will help you present your CrowdBoard</span>
                        </div>
                        <div class="form-row">
                            &nbsp;
                        </div>
                        <div class="float-left">
                            <telerik:RadAsyncUpload ID="rauBoardFiles" runat="server" MultipleFileSelection="Disabled"
                                OnClientFilesUploaded="fileUploadedBoard" Width="94%" Height="42px" HttpHandlerUrl="~/CustomHandler.ashx">
                            </telerik:RadAsyncUpload>
                        </div>
                    </div>
                </div>
                <div class="column3">
                    <div class="subheading">
                        CrowdBoard Team</div>
                    <div style="text-align: center;">
                        <br />
                        <asp:label id="lblMessageCrowdboardTeam" runat="server" font-bold="true"></asp:label>
                    </div>
                    <div class="extras-container">
                        <div>
                            Select Boarder</div>
                        <div>
                            <telerik:RadDropDownList ID="cbAllBoardersList" runat="server" DataTextField="Name"
                                Autopostback="true" DataValueField="Userid" DataSourceID="sdAllBoardersList"
                                Width="200px">
                            </telerik:RadDropDownList>
                            <asp:requiredfieldvalidator id="rfvBoarder" runat="server" controltovalidate="cbAllBoardersList"
                                forecolor="Red" tooltip="Select Boarder" validationgroup="AddCrowdboardTeam"
                                display="Dynamic" initialvalue="--Select Boarder--">*</asp:requiredfieldvalidator>
                        </div>
                        <div class="form-row">
                            <asp:textbox id="txtRequestTitle" runat="server" placeholder="Title">
                            </asp:textbox>
                            <asp:textbox id="txtRequestDescription" runat="server" textmode="MultiLine" placeholder="Description">
                            </asp:textbox>
                        </div>
                        <div class="float-left">
                            <asp:button id="btnSendrRequest" runat="server" text="Send Request" cssclass="view-team-button"
                                validationgroup="AddCrowdboardTeam" />
                            <asp:button id="btnRequestDelete" runat="server" text="Delete" cssclass="view-team-button"
                                visible="false" />
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="350px" Width="500px">
            </telerik:RadWindow>
            <telerik:RadWindow runat="server" ID="RadWindow2" Behaviors="Close" OnClientClose="OnClientClose"
                Height="650" Width="900px">
            </telerik:RadWindow>
            <telerik:RadWindow runat="server" ID="RadWindow3" Behaviors="Close" OnClientClose="OnClientClose">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div>
        <asp:sqldatasource id="sdAllBoards" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  V.BoardLevel,V.UserID,V.BoardID,V.Boardname,U.UserName,V.TotalOffer As Seeking,V.RaisedTotal,V.AmountRemaining as Amountleft,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.Investors,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer,V.Status,V.Offer,BS.English As StatusText,CAST(ROUND(V.RaisedTotal, 0) AS int) as TotalInvested, (SELECT count(*) FROM (SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union  SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount, V.EquityID   FROM vwBoardInfo V  INNER JOIN Users U ON v.UserID =U.UserID INNER JOIN BoardStatus BS ON V.Status=BS.Value WHERE V.UserID=@UserID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select BoardInvestedIn,crowdboards,PendingRequestCount,MessageCount from vwUserInfo where UserID=@userID">
            <selectparameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestors" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT B.DirectoryName,B.BoardID,B.userID As OwnerID,BI.UserID As InvstorID,(SELECT UserName FROM Users where UserID=BI.UserID) As InvestorName,(SELECT levelName FROM BoardLevels where LevelID=BI.LevelID) As LevelName FROM boards B INNER JOIN BoardInvestors BI ON B.BoardID=BI.BoardID AND BI.AmountInvested IS NOT NULL WHERE B.BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestmentLevels" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT LevelID,LevelName,#OfInvestments,'$'+ convert(varchar(12),cast(LevelRaisedTotal as dec(5,0)),1) As LevelRaisedTotal FROM vwInvestmentLevels WHERE BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT V.BoardLevel,V.Name,V.Email,V.UserID,V.BoardID,V.Boardname,V.InvType,V.city,V.Country,V.ViewsCount,V.Description,V.Investors,V.Watches,V.Comments,'$'+ convert(varchar(12),cast(V.RaisedTotal as dec(10,0)),1) As RaisedTotal, V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.Keywords,V.AudienceDesc  ,V.UniquenessDesc,V.RevenueDesc,V.offer,V.TotalOffer,V.Tags,V.VisibilityType,V.Offer, CASE V.ViewsCount WHEN 0 THEN '0' ELSE CAST((V.Investors/V.ViewsCount)*100 As NVARCHAR(20))+'%' END AS ConversionRate, V.AboutMe,V.AreaID,V.areaName,V.District,V.YoutubeVideoUrl,(select COUNT(*) from boardlevels where BoardID =v.BoardID) as levelCount,V.FederalTaxID ,V.EquityID FROM vwBoardInfo   V  Where V.BoardID=@BoardID"
            updatecommand="UPDATE Boards SET BoardName=@BoardName, Description=@Description, DirectoryName=@DirectoryName, InvType=@InvType,AreaID=@AreaID, Status=@Status,TotalOffer=@TotalOffer, city=@city,country=@country,EquityID=@EquityID  WHERE BoardID=@BoardID">
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
        <asp:sqldatasource id="sdGetBoardIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT  Boards.BoardId,isnull(U.BankLocation,'UK') as BankLocation from Boards Inner join [Users] U on Boards.UserID =U.UserID WHERE Boards.DirectoryName=@Name and Boards.UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="Name" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select BoardID,Boardname,Description,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Status  from vwBoardInfo where BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdComments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spCommentGraph" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdViews" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spViewsGraph" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdWatches" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spWatchersGraph" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spInvestorsGraph" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardLevelsGraph" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="sp_BoardLevelsGraph" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardLevels" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO BoardLevels(BoardID,LevelName,Description,LevelAmount,NumOffered) VALUES(@BoardID,@LevelName,@Description,@LevelAmount,@NumOffered)"
            selectcommand="SELECT BL.LevelID,BL.BoardID,BL.LevelName,BL.Description,isnull(BL.LevelAmount,0) LevelAmount,BL.NumOffered,(Case when((Select Count(*)from BoardInvestors BI where BI.LevelID=BL.LevelID)>0) then 0 else 1 end)as isInvested FROM BoardLevels BL WHERE BL.BoardID=@BoardID"
            deletecommand="DELETE FROM BoardLevels WHERE LevelID=@LevelID" updatecommand="UPDATE BoardLevels SET LevelName=@LevelName,Description=@Description,LevelAmount=@LevelAmount,NumOffered=@NumOffered where LevelID=@LevelID">
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
            <updateparameters>
                <asp:Parameter Name="LevelID" />
                <asp:Parameter Name="LevelName" />
                <asp:Parameter Name="Description" />
                <asp:Parameter Name="LevelAmount" />
                <asp:Parameter Name="NumOffered" />
            </updateparameters>
            <deleteparameters>
                <asp:Parameter Name="LevelID" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdChangeBoardStatus" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Status=@Status,DateActivated=GETDATE() WHERE BoardID=@BoardID"
            deletecommand="DELETE FROM BoardOwners WHERE BoardID=@BoardID AND Status=0 OR Status=2">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Status" />
            </updateparameters>
            <deleteparameters>
                <asp:Parameter Name="BoardID" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdActivateBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Status=@Status,DateActivated=GETDATE() WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Status" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdSubmitForApproval" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET Status=4 WHERE BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetDistrictManagerEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand=" SELECT U.Email FROM Users U  Left Join districts D  ON U.UserID=D.Manager INNER JOIN Areas A On D.districtID=A.districtID WHERE A.AreaID=@AreaID">
            <selectparameters>
                <asp:Parameter Name="AreaID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAreas" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT '0' as areaID,'--Select Area--' As AreaName UNION SELECT areaID,AreaName FROM Areas">
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAreasLoad" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <selectparameters>
                <asp:Parameter Name="districtID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdDistricts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT districtID,DistrictName,row_number()over(order by D.SortOrder) as rownumber FROM Districts D  Order by D.DistrictName">
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestmentType" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT Value,EnglishName FROM InvestmentType" updatecommand="Update Boards SET FederalTaxID=@FederalTaxID where BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="FederalTaxID" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdInvestmentLevelsAmount" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT '--Select Amount--' as FundAmountText,0  FundAmount,0 as indexs union SELECT CASE WHEN @BankLocation='US' THEN  '$ '+ CONVERT(varchar(50),FundAmount) ELSE '£ '+ CONVERT(varchar(50),FundAmount) END as FundAmountText,FundAmount,1 as indexs from InvestmentLevels order by FundAmount">
            <selectparameters>
                <asp:Parameter Name="BankLocation" />
            </selectparameters>
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
        <asp:sqldatasource id="sdGetAreaID" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT areaID from Areas WHERE AreaName=@AreaName">
            <selectparameters>
                <asp:Parameter Name="AreaName" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBalancedOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from BalancedUserRecord WHERE UserId=@UserId">
            <selectparameters>
                <asp:Parameter Name="UserId" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBalancedUserAccountInsert" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            insertcommand="INSERT INTO BalancedUserRecord(UserID,UserAccountUri,UserBankAccountUri,DateCreated,CustomerID) VALUES(@UserID,@UserAccountUri,@UserBankAccountUri,GETDATE(),@CustomerID)"
            updatecommand="UPDATE BalancedUserRecord SET UserBankAccountUri=@UserBankAccountUri where UserID=@UserID">
            <insertparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="UserAccountUri" />
                <asp:Parameter Name="UserBankAccountUri" />
                <asp:Parameter Name="CustomerID" />
            </insertparameters>
            <updateparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="UserBankAccountUri" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAllBoardersList" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT '--Select Boarder--' as Name,0  Userid,0 as indexs union SELECT  isnull(FirstName,'')+' '+isnull(LastName,'') as Name ,Userid,1 as indexs FROM f_GetBoardersList(@UserID) WHERE username is not null and friendStatus =1 and UserID<>41 ORDER BY indexs">
            <selectparameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCrowdBoardTeam" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BoardID,MemberID,status,RequestTitle,Description FROM BoardOwners WHERE BoardID=@BoardID AND MemberID=@MemberID"
            insertcommand="INSERT INTO BoardOwners(BoardID,MemberID,status,DateRequested,Description,RequestTitle) VALUES(@BoardID,@MemberID,0,getdate(),@Description,@RequestTitle)"
            updatecommand="UPDATE BoardOwners SET status=@status,DateRequested=GETDATE(),DateRejected=null,Description=@Description,RequestTitle=@RequestTitle WHERE BoardID=@BoardID AND MemberID=@MemberID"
            deletecommand="Delete  FROM BoardOwners WHERE BoardID=@BoardID AND MemberID=@MemberID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="MemberID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="MemberID" />
                <asp:Parameter Name="RequestTitle" />
                <asp:Parameter Name="Description" />
                 <asp:Parameter Name="status" />
            </insertparameters>
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="MemberID" />
                <asp:Parameter Name="RequestTitle" />
                <asp:Parameter Name="Description" />
                 <asp:Parameter Name="status" />
            </updateparameters>
            <deleteparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="MemberID" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUpdateCreatePageUrl" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET URL=@Url,MoreInfo=@MoreInfo where BoardID=@BoardID">
            <updateparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Url" />
                <asp:Parameter Name="MoreInfo" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardFiles" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * FROM BoardFiles Where BoardID=@BoardID" insertcommand="INSERT INTO BoardFiles(BoardID,FileName,FilePath,DateUploaded) VALUES(@BoardID,@FileName,@FilePath,GETDATE())"
            deletecommand="DELETE FROM BoardFiles WHERE ID=@ID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="FileName" />
                <asp:Parameter Name="FilePath" />
            </insertparameters>
            <deleteparameters>
                <asp:Parameter Name="ID" />
            </deleteparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUpdateUrlDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            updatecommand="UPDATE Boards SET YoutubeVideoUrl=@YoutubeVideoUrl where DirectoryName=@DirectoryName">
            <updateparameters>
                <asp:Parameter Name="YoutubeVideoUrl" />
                <asp:Parameter Name="DirectoryName" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardMediaLinks" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * FROM BoardMediaLinks Where BoardID=@BoardID" insertcommand="INSERT INTO BoardMediaLinks(BoardID,Name,Url,DateCreated) VALUES(@BoardID,@Name,@Url,GETDATE())"
            deletecommand="DELETE FROM BoardMediaLinks WHERE ID=@ID" updatecommand="UPDATE BoardMediaLinks SET Name=@Name,Url=@Url,DateModified=GETDATE() WHERE ID=@ID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="Url" />
            </insertparameters>
            <deleteparameters>
                <asp:Parameter Name="ID" />
            </deleteparameters>
            <updateparameters>
                <asp:Parameter Name="ID" />
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="Url" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdGetBankLocation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT IsNull(BankLocation,'US') as BankLocation from Users WHERE UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdStripeOwnerDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from UserStripeAccount WHERE UserId=@UserId">
            <selectparameters>
                <asp:Parameter Name="UserId" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdIsValidEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select main.*,U.Email from (SELECT userid,UserName, Status,case when TwitterUserID  is not null  then 'N/A' when FacebookUserID  is not null   then 'N/A'when LinkedInUserID  is not null   then 'N/A' when Status=1 and (LinkedInUserID is  null and FacebookUserID is  null  and TwitterUserID is  null)  then 'Check' else  'No Check' end as EmailVerified  FROM vwAllUsersInfo)main inner join Users U on U.UserID =main.userid where U.UserID=@UserID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
            </selectparameters>
        </asp:sqldatasource>

          <asp:sqldatasource id="sdEquityTypes" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select ID,TypeName  from EquityTypes UNION ALL SELECT 0 as ID,'Select Location' as TypeName ORder by ID">
        </asp:sqldatasource>

    </div>
</asp:content>
