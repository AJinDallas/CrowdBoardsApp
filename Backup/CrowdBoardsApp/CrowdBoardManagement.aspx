<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CrowdBoardManagement.aspx.vb"
    ValidateRequest="false" Inherits="CrowdBoardsApp.CrowdBoardManagement" MasterPageFile="~/MasterPage/Site.Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>CrowdBoard Management</title>
    <link href="WebContent/Theme/styles/editmanageupdate.css" rel="stylesheet" type="text/css" />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
          .thermometer
        {
            width: 100%;
            height: 150px;           
           <%--background: transparent url('Images/thermometer.jpg') no-repeat;--%>
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
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
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
     </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <style>
        .main
        {
            width: 900px;
            margin: 0 auto;
            height: 400px;
            overflow: auto;
        }
        .inner
        {
            float: left;
            width: 200px;
        }
    </style>
    <!-- Load in the JavaScript framework and register a callback function -->
    <script type="text/javascript" src="https://platform.linkedin.com/in.js">
        api_key: <%=linkedinkey %>       
        onLoad: onLinkedInLoad
        authorize: true
    </script>
    <script type="text/javascript">

        function onLinkedInLoad() {
            // Listen for an auth event to occur
            IN.Event.on(IN, "auth", onLinkedInAuth);
            IN.Event.on(IN, "auth", function () { onLinkedInLogin(); });
        }

        function onLinkedInLogin() {
            // here, we pass the fields as individual string parameters
            IN.API.Connections("me")
        .fields("id", "firstName", "lastName", "pictureUrl", "publicProfileUrl")
        .result(function (result, metadata) {
            setConnections(result.values, metadata);
        });
        }

        function onLinkedInAuth() {
            // After they've signed-in, print a form to enable keyword searching
            //            var div = document.getElementById("sendMessageForm");
            //            div.innerHTML = '<form action="javascript:SendMessage();">' + '<input type="button" value="Send Message!" /></form>';
        }



        function removeLastComma(str) {
            return str.replace(/,(\s+)?$/, '');
        }


        function SendMessage(keywords) {
            // Call the Message sending API with the viewer's message     // On success, call displayMessageSent(); On failure, do nothing.
         
        
            var title = "Hi, you have invited to connect on CrowdBoarders";  //document.getElementById('h1Title').innerHTML;
         
            var message = "https:www//crowdboarders.com"          
            var names = [];
            $('input:checked').each(function () {
                names.push($(this).attr('id'));

            });
            var val = '';
            for (var ln = 0; ln < names.length; ln++) {
                val = val + '{"person":{"_path":"/people/' + names[ln] + '"}},';
            }
            if (val == '') {
                alert('please select a value');
                return false;
            }
            val = removeLastComma(val);
            console.log(val);
            var BODY = {
                "recipients": {
                    "values":
                 $.parseJSON('[' + val + ']')

                },
                "subject": title,
                "body": message
            }

            IN.API.Raw("/people/~/mailbox")
             .method("POST")
             .body(JSON.stringify(BODY))
             .result(displayMessageSent)
             .error(function error(e) { alert("No dice") });
        }

        function displayMessageSent() {
            var div = document.getElementById("sendMessageResult");
            div.innerHTML += "Message Successfully Sent";
        }
        function setConnections(connections) {
            var connHTML = "<div class='main'>";
            for (id in connections) {
                connHTML = connHTML + "<div class=\"inner\"><input type=\"checkbox\" class=\"checkBox\" id=\"" + connections[id].id + "\" value=\"" + connections[id].id + "\" />" + connections[id].firstName + " " + connections[id].lastName + "</div>";
            }

            connHTML = connHTML + "</div>";
            document.getElementById("connectionsdata").innerHTML = connHTML;
        }
    </script>
    <script>
        function unloadPopupBoxLikedInInvite() {

            $('#linkedinInviteDiv').fadeOut("slow");

            return false;
        }

        function loadPopupBoxLikedInInvite() {
            $('#linkedinInviteDiv').fadeIn("slow");
            return false;

        }

        function ClickGooleLinkButton() {

            var btn = document.getElementById("BodyContent_gooleInviteButton")

            btn.click();
        }
    </script>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <div id="fb-root">
    </div>
    <div class="popup_box" id="linkedinInviteDiv" style="background-color: #fff;">
        <h1 id="h1Title" style="color: #75b4c6; width: 300px; font-size: 20px;">
            Invite Friends to Join Crowdboard</h1>
        <div onclick='unloadPopupBoxLikedInInvite();' style="float: right; width: 30px;">
            <img src="Images/btncross.png" alt="X" style="cursor: pointer; width: 25px; height: 25px;" /></div>
        <p id="para">
            &nbsp;</p>
        <script type="IN/Login"></script>
        <div id="connectionstest">
            <div id="connectionsdata">
            </div>
        </div>
        <div id="sendMessageResult" style="color: Green;">
        </div>
        <div id="sendMessageForm">
            <input type="button" value="Invite!" class="invest-button" style="width: 150px;"
                onclick="return SendMessage();" />
            <br />
        </div>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <%--  <asp:ScriptManager runat="server" ID="RadScriptManager1">--%>
    <%-- <scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </scripts>--%>
    <%--  </asp:ScriptManager>--%>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>
        <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
        <script src="https://connect.facebook.net/en_US/all.js" type="text/javascript"></script>
        <script type="text/javascript">
            FB.init({
                appId: '<%=appID %>',
                cookie: true,
                status: true,
                xfbml: true
            });
            function FacebookInviteFriends() {

                FB.ui({
                    method: 'send',
                    link: "https://crowdboarders.com/default.aspx"
                });
                //                FB.ui({ method: 'apprequests',
                //                    new_style_message: true,
                //                    title: "Join CrowdBoarders",
                //                    message: 'Invitation to join CrowdBoarders'
                //                    //request_url: 'http://localhost:1385/Default.aspx'   


                //                }, requestCallback);
            }
            function requestCallback(response) {
                // Handle callback here

            }

            function unloadPopupBoxVideo() {

                $('#popup_box_Video').fadeOut("slow");
                return false;
            }

            function loadPopupBoxVideo() {
                $('#popup_box_Video').fadeIn("slow");
                return false;

            }

            function ClickYohooLinkButton() {
                var btn = document.getElementById("BodyContent_yahooInvite");
                btn.click();
            }

        </script>
        <script type='text/javascript'>
            if (top.location != self.location) {
                top.location = self.location
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
    <%--  <asp:updatepanel id="updatePanel1" runat="server">
        <triggers>
            <asp:PostBackTrigger ControlID="gmailInvite" />
            <asp:PostBackTrigger ControlID="yahooInvite" />
            <%--<asp:PostBackTrigger ControlID="btnCopy" />-
        </triggers>
        <contenttemplate>--%>
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
    <div class="manage-container">
        <div class="manage-navigation">
            <asp:linkbutton id="performanceLinkButton" runat="server">Performance</asp:linkbutton>
            <asp:linkbutton id="lbtnMarketing" runat="server">Marketing</asp:linkbutton>
            <asp:linkbutton id="lbtnAnalytics" runat="server">Analytics</asp:linkbutton>
        </div>
        <div class="title">
            Manage</div>
        <br />
        <asp:label id="lblMessage" runat="server"></asp:label>
        <asp:HiddenField id="userNameLable" runat="server"></asp:HiddenField>
        <br />
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
            <telerik:RadPageView ID="rpvPerformance" runat="server" Selected="true">
                <div class="performance-container">
                    <div class="column1">
                        <div class="left-column">
                            <div>
                                Funds Raised:</div>
                            <div class="content">
                                <asp:linkbutton id="lbtnBoardersIn" runat="server" forecolor="#788586">BoardersIn:</asp:linkbutton></div>
                            <div class="content">
                                <asp:linkbutton id="lbtnBoardersWatching" runat="server" forecolor="#788586">Boarders Watching:</asp:linkbutton></div>
                            <div>
                                Views:</div>
                            <%-- <div>
                                        Conversion Rate:</div>--%>
                        </div>
                        <div class="right-column">
                            <div class="funds-raised">
                                <asp:label id="lblRaised" runat="server"></asp:label></div>
                            <div class="boarders-in">
                                <asp:label id="lblBoardersIn" runat="server"></asp:label></div>
                            <div class="boarders-watching">
                                <asp:label id="lblWatches" runat="server"></asp:label></div>
                            <div class="views">
                                <asp:label id="lblViews" runat="server"></asp:label></div>
                            <div class="conversion-rate">
                                <%-- <asp:Label ID="lblConversionRate" runat="server">3%</asp:Label>--%></div>
                        </div>
                    </div>
                    <div class="column2">
                        <div class="box1">
                            <div class="heading">
                                Boarders Addresses</div>
                            <div class="content">
                                <asp:label id="lblEnterCount" runat="server"></asp:label><asp:linkbutton id="lnkExportToCSV"
                                    runat="server" text="Export CSV"></asp:linkbutton></div>
                            <div class="content">
                                <asp:label id="lblNoEnterCount" runat="server"></asp:label><asp:linkbutton id="lnkNoExportToCSV"
                                    runat="server" text="Export CSV"></asp:linkbutton></div>
                        </div>
                        <%-- <div class="box2">
                            <div class="heading">
                                Rewards</div>
                            <div class="content">
                                0 Received<a href="">Export CVS</a></div>
                            <div class="content">
                                0 Not Received<a href="">Export CVS</a></div>
                        </div>--%>
                    </div>
                    <div class="column3">
                        <div class="crowdboard-container group">
                            <div class="crowdboard-video">
                                <div id="coverPicDiv" runat="server">
                                    <a href="">
                                        <%--   <img src="../WebContent/Theme/images/crowdboardvideopreview.png" />--%>
                                        <div class="play-button">
                                            <asp:imagebutton id="ibtnPlay1" imageurl="~/WebContent/images/playbutton.png" runat="server"
                                                height="50px" width="50px" onclientclick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>' />
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="crowdboard-profile-picture">
                                <a href='<%#Eval("DirectoryName","{0}")%>' id="boardAnchor" runat="server">
                                    <img id="imgBoard" runat="server" src="../WebContent/Theme/images/crowdboardpreview.png" /></a>
                            </div>
                            <div class="crowdboard-mini-console">
                                <div class="crowdboard-measure">
                                    <asp:hyperlink id="watchhyperLink4" runat="server" navigateurl='<%# Eval("DirectoryName","~/{0}") %>'
                                        style="color: #788586;">
                                        <table border="1">
                                            <tr valign="top">
                                                <td style="width: 10%;">
                                                    <div style="margin-left: 3px; margin-bottom: 10px; margin-top: 3px;">
                                                    </div>
                                                    <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                        TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="96px"
                                                        Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false" ShowIncreaseHandle="false"
                                                        IsDirectionReversed="true" Value="1000" Enabled="false" CssClass="thermometerSlider"
                                                        BackColor="Transparent">
                                                    </telerik:RadSlider>
                                                </td>
                                                <td style="width: 90%;">
                                                    <div class="crowdboard-measure-text" style="margin-left: 4px;">
                                                        <div class="crowdboard-measure-level">
                                                            Level<br />
                                                            <asp:label id="lblBoardLevel" runat="server"></asp:label></div>
                                                        <div class="crowdboard-measure-max-left">
                                                            Max Left<br />
                                                            <asp:label id="lblAmountLeft" runat="server"></asp:label></div>
                                                        <div class="crowdboard-measure-boarders-in">
                                                            Boarders In<br />
                                                            <asp:label id="lblBoardersInBoard" runat="server"></asp:label></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:hyperlink>
                                    <%--<div class="crowdboard-status-bar" style="background-color: transparent;">--%>
                                    <%--  <div class="thermometer" style="margin-left: 50px; float: right;">--%>
                                    <%-- </div>--%>
                                    <%-- </div>--%>
                                    <%-- <div class="crowdboard-status-bar-position">
                                            </div>--%>
                                </div>
                                <a href="">
                                    <img src="../WebContent/Theme/images/comment.png" /><div class="comment-number">
                                        (<asp:label id="lblCommentsBoard" runat="server" font-size="Smaller"></asp:label>)</div>
                                </a><a href="">
                                    <img src="../WebContent/Theme/images/recommend.png" /><div class="recommend-number">
                                        (2)</div>
                                </a><a href="">
                                    <img src="../WebContent/Theme/images/boost.png" /><div class="boost-number">
                                        (3)</div>
                                </a><a href="">
                                    <img src="../WebContent/Theme/images/watchwbg.png" /><div class="watch-number">
                                        (<asp:label id="lblWatchesBoard" runat="server" font-size="Smaller"></asp:label>)</div>
                                </a>
                                <input type="button" value="INVEST!" id="invest-button" />
                            </div>
                            <div class="crowdboard-text">
                                <asp:hyperlink id="boardNameLink" visible="false" runat="server" forecolor="#72B2C7"
                                    font-size="Large">
                                </asp:hyperlink>
                                <div class="crowdboard-line-name">
                                    <b>Name:</b>&nbsp;<asp:label id="lblCrowdBoard" runat="server"></asp:label></div>
                                <div class="crowdboard-line-location">
                                    <b>Location:</b>&nbsp;<asp:label id="lblLocation" runat="server"></asp:label>
                                    <br />
                                    <b>Type:</b>&nbsp;<asp:label id="lblInvType" runat="server"></asp:label>
                                </div>
                                <div class="crowdboard-line-seeking">
                                    <b>Seeking:</b>&nbsp;<asp:label id="lblSeeking" runat="server"></asp:label></div>
                                <div class="crowdboard-line-DA">
                                    <b>District:</b>&nbsp;<asp:label id="lblDistrict" runat="server"></asp:label><br />
                                    <b>Area:</b>&nbsp;<asp:label id="lblArea" runat="server" cssclass="area-tag"></asp:label></div>
                                <div class="crowdboard-line-live-since">
                                    <b>Live Since:</b>&nbsp;<asp:label id="lblLiveSince" runat="server"></asp:label></div>
                                <div class="crowdboard-wrapper-description">
                                    <b>Description:</b></br>
                                    <div class="crowdboard-description">
                                        <asp:label id="lblDescription" font-bold="false" runat="server"></asp:label>
                                    </div>
                                </div>
                            </div>
                            <div id="view-crowdboard-button" align="center">
                                <asp:hyperlink id="boardLink" runat="server" text="View Crowdboard" forecolor="#75B4C6"
                                    style="margin: 10px;" width="100%">
                                </asp:hyperlink>
                            </div>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="rpvMarketing" runat="server">
                <div class="marketing-container">
                    <div class="left-container find-friends">
                        <div class="title">
                            Find and Invite friends from other networks</div>
                        <div class="connect-central">
                            <div>
                                <a href="#" onclick="FacebookInviteFriends(); return false;">
                                    <img src="../WebContent/Theme/images/facebookicon.png" /></a>Facebook<input type="button"
                                        value="Invite" class="invite-button" onclick="FacebookInviteFriends(); return false;" /></div>
                            <%-- <div>
                                <a href="">
                                    <img src="../WebContent/Theme/images/hotmailicon.png" /></a>Hotmail<input type="button"
                                        value="Invite" class="invite-button" /></div>--%>
                            <%-- <div>
                                <asp:linkbutton id="twitterInvite" runat="server">
                                    <img src="../WebContent/Theme/images/twittericon.png" /></asp:linkbutton>Twitter<input
                                        type="button" value="Invite" class="invite-button" /></div>--%>
                            <div>
                                <asp:linkbutton id="gooleInviteButton" runat="server">
                                    <img src="../WebContent/Theme/images/googleicon.png" /></asp:linkbutton>Google<input
                                        type="button" value="Invite" class="invite-button" onclick=" ClickGooleLinkButton();" /></div>
                            <div onclick="loadPopupBoxLikedInInvite();">
                                <img src="../WebContent/Theme/images/linkedinicon.png" />Linkedin<input type="button"
                                    value="invite" class="invite-button" onclick="loadPopupBoxLikedInInvite();" /></div>
                            <div>
                                <asp:linkbutton id="yahooInvite" runat="server">
                                    <img src="../WebContent/Theme/images/yahooicon.png" /></asp:linkbutton>Yahoo<input
                                        type="button" value="Invite" class="invite-button" onclick=" ClickYohooLinkButton();" /></div>
                            <%--  <div>
                                <asp:LinkButton ID="gmailInvite" runat="server"><img src="Images/gmailInviteCC.png" /></asp:LinkButton>Gmail<input
                                    type="button" value="Invite" class="invite-button" />
                            </div>--%>
                        </div>
                        <div class="connect-via-email">
                            <div class="title">
                                Invite and Connect via email</div>
                            <span style="font-style: oblique; margin-left: 50px;">copy and paste email list</span><br />
                            <telerik:RadTextBox ID="txtSendMultipleEmail" runat="server" TextMode="MultiLine"
                                Width="50%" Rows="8" Style="margin-left: 50px;">
                            </telerik:RadTextBox>
                            <br />
                            <asp:label id="lblMessageSendEmail" runat="server" style="margin-left: 50px;"></asp:label>
                        </div>
                        <div style="float: right; width: 55%;">
                            <asp:button id="btnSendEmail" runat="server" text="Send" cssclass="invite-button" />
                            <br />
                        </div>
                    </div>
                    <div class="right-container">
                        <div class="box1">
                            <div>
                                CrowdBoard Link:</div>
                            <input type="text" name="crowdboard-link" placeholder="www.crowdboard.com/yourcrowdboardnamehere" />
                        </div>
                        <div class="box2">
                            <div>
                                Embed:</div>
                            <div>
                                Put your CrowdBoard on any website</div>
                            <telerik:RadTextBox ID="txtEmbed" runat="server" TextMode="MultiLine" Rows="3" Width="100%">
                            </telerik:RadTextBox>
                            <div class="two-buttons-float-right">
                                <asp:button id="btnCopy" runat="server" text="COPY" cssclass="copy-button" style="font-size: 20px;" />
                                <asp:button id="btnEmail" runat="server" text="EMAIL" cssclass="copy-button" style="font-size: 20px;" />
                                <br />
                                <asp:label id="lblMessageEmbed" runat="server" font-size="18px" style="margin-right: 40px;">
                                </asp:label>
                            </div>
                        </div>
                    </div>
                    <br />
                    <br />
                    <%-- <table width="100%" border="0">
                        <tr>
                            <td style="width: 10%; text-align: center;">
                                <img src="Images/twitterInviteCC.png" height="60" width="50" />
                                <br />
                                <asp:LinkButton ID="syncTwitter" runat="server" Text="Start" Font-Size="Small" ForeColor="#72B2C7"></asp:LinkButton>
                            </td>
                            <td style="width: 10%; text-align: center;">
                                <img src="Images/facebookInviteCC.png" height="60" width="50" />
                                <br />
                                <asp:LinkButton ID="syncFacebook" runat="server" Text="Start" Font-Size="Small" ForeColor="#72B2C7"></asp:LinkButton>
                            </td>
                            <td style="width: 10%; text-align: center;">
                                <img src="Images/linkedInInviteCC.png" height="60" width="50" />
                                <br />
                                <asp:LinkButton ID="syncLinkedIn" runat="server" Text="Start" Font-Size="Small" ForeColor="#72B2C7"></asp:LinkButton>
                            </td>
                            <td style="width: 10%;">
                            </td>
                            <td style="width: 10%;">
                            </td>
                            <td style="width: 50%;">
                            </td>
                        </tr>
                    </table>--%>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="analyticsView" runat="server">
                <br />
                <table width="100%">
                    <tr>
                        <td>
                            <table cellpadding="5" cellspacing="5" width="100%">
                                <tr>
                                    <td>
                                        <asp:linkbutton id="lbtnViewsGraph" runat="server" forecolor="#72B2C7">Views</asp:linkbutton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:linkbutton id="lbtnWatchesGraph" runat="server" forecolor="#72B2C7">Watches</asp:linkbutton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:linkbutton id="lbtnCommentsGraph" runat="server" forecolor="#72B2C7">Comments</asp:linkbutton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:linkbutton id="lbtnBoardersInGraph" runat="server" forecolor="#72B2C7">BoardersIn</asp:linkbutton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:linkbutton id="lbtnConversionRateGraph" runat="server" forecolor="#72B2C7">Conversion Rate</asp:linkbutton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <telerik:RadMultiPage ID="RadMultiPageGraph" runat="server" SelectedIndex="0" Width="100%">
                                <telerik:RadPageView ID="viewsGraphRadPageView" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadChart ID="RadChartViews" runat="server" AutoLayout="True" Height="400px"
                                                    Skin="DeepGray" Width="450px">
                                                    <plotarea>
                                                        <XAxis AutoScale="False" MaxValue="8" MinValue="1" Step="1">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <TextAppearance TextProperties-Color="Black">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </XAxis>
                                                        <YAxis AutoScale="False" MaxValue="20" MinValue="0" Step="2">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48" MinorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <MinorGridLines Color="77, 77, 77"></MinorGridLines>
                                                                <TextAppearance TextProperties-Color="Black">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </YAxis>
                                                        <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                                            <FillStyle FillType="Solid" MainColor="51, 51, 51">
                                                            </FillStyle>
                                                            <Border Color="62, 62, 62"></Border>
                                                        </Appearance>
                                                    </plotarea>
                                                    <charttitle textblock-text="">
                                                        <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent" />
                                                        </Appearance>
                                                        <TextBlock Text="">
                                                            <Appearance TextProperties-Color="White" TextProperties-Font="Arial,10pt">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </charttitle>
                                                    <appearance>
                                                        <FillStyle MainColor="25, 25, 25">
                                                        </FillStyle>
                                                        <Border Color="5, 5, 5"></Border>
                                                    </appearance>
                                                    <series>
                                                        <telerik:ChartSeries DataXColumn="number" DataYColumn="ViewsCount" Name="Series 1">
                                                            <Appearance>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                                <FillStyle FillType="ComplexGradient" MainColor="222, 202, 155">
                                                                    <FillSettings>
                                                                        <ComplexGradient>
                                                                            <telerik:GradientElement Color="222, 202, 152" />
                                                                            <telerik:GradientElement Color="211, 185, 123" Position="0.5" />
                                                                            <telerik:GradientElement Color="183, 154, 84" Position="1" />
                                                                        </ComplexGradient>
                                                                    </FillSettings>
                                                                </FillStyle>
                                                                <PointMark Border-Color="DarkKhaki" Border-Width="10" FillStyle-FillType="Solid"
                                                                    Visible="true">
                                                                    <Border Color="DarkKhaki" Width="10"></Border>
                                                                </PointMark>
                                                                <Border Color="187, 149, 58" />
                                                            </Appearance>
                                                        </telerik:ChartSeries>
                                                    </series>
                                                    <legend visible="false">
                                                        <appearance dimensions-margins="1px, 2%, 9%, 1px" position-alignedposition="BottomRight"
                                                            visible="False">
                                                            <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                                            </ItemTextAppearance>
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent"></Border>
                                                        </appearance>
                                                    </legend>
                                                </telerik:RadChart>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span>Views Graph Description and Info</span>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="watchesGraphRadPageView" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadChart ID="RadChartWatches" runat="server" AutoLayout="True" Height="400px"
                                                    Skin="Black" Width="450px">
                                                    <plotarea>
                                                        <XAxis AutoScale="False" MaxValue="8" MinValue="1" Step="1">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </XAxis>
                                                        <YAxis AutoScale="False" MaxValue="20" MinValue="0" Step="2">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48" MinorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <MinorGridLines Color="77, 77, 77"></MinorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </YAxis>
                                                        <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                                            <FillStyle FillType="Solid" MainColor="51, 51, 51">
                                                            </FillStyle>
                                                            <Border Color="62, 62, 62"></Border>
                                                        </Appearance>
                                                    </plotarea>
                                                    <charttitle textblock-text="">
                                                        <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent" />
                                                        </Appearance>
                                                        <TextBlock Text="">
                                                            <Appearance TextProperties-Color="White" TextProperties-Font="Arial, 18pt">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </charttitle>
                                                    <appearance>
                                                        <FillStyle MainColor="25, 25, 25">
                                                        </FillStyle>
                                                        <Border Color="5, 5, 5"></Border>
                                                    </appearance>
                                                    <series>
                                                        <telerik:ChartSeries DataXColumn="number" DataYColumn="WatchersCount" Name="Series 1">
                                                            <Appearance>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                                <FillStyle FillType="ComplexGradient" MainColor="222, 202, 155">
                                                                    <FillSettings>
                                                                        <ComplexGradient>
                                                                            <telerik:GradientElement Color="222, 202, 152" />
                                                                            <telerik:GradientElement Color="211, 185, 123" Position="0.5" />
                                                                            <telerik:GradientElement Color="183, 154, 84" Position="1" />
                                                                        </ComplexGradient>
                                                                    </FillSettings>
                                                                </FillStyle>
                                                                <PointMark Border-Color="DarkKhaki" Border-Width="4" FillStyle-FillType="Solid" Visible="True">
                                                                    <FillStyle FillType="Solid">
                                                                    </FillStyle>
                                                                    <Border Color="DarkKhaki" Width="4"></Border>
                                                                </PointMark>
                                                            </Appearance>
                                                        </telerik:ChartSeries>
                                                    </series>
                                                    <legend visible="false">
                                                        <appearance dimensions-margins="1px, 2%, 9%, 1px" position-alignedposition="BottomRight"
                                                            visible="False">
                                                            <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                                            </ItemTextAppearance>
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent"></Border>
                                                        </appearance>
                                                    </legend>
                                                </telerik:RadChart>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span>Watches Graph Description and Info</span>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="commentsGraphRadPageView" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadChart ID="RadChartComments" runat="server" AutoLayout="True" Height="400px"
                                                    Skin="Black" Width="450px">
                                                    <plotarea>
                                                        <XAxis AutoScale="False" MaxValue="8" MinValue="1" Step="1">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </XAxis>
                                                        <YAxis AutoScale="False" MaxValue="20" MinValue="0" Step="2">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48" MinorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <MinorGridLines Color="77, 77, 77"></MinorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </YAxis>
                                                        <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                                            <FillStyle FillType="Solid" MainColor="51, 51, 51">
                                                            </FillStyle>
                                                            <Border Color="62, 62, 62"></Border>
                                                        </Appearance>
                                                    </plotarea>
                                                    <charttitle textblock-text="">
                                                        <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent" />
                                                        </Appearance>
                                                        <TextBlock Text="">
                                                            <Appearance TextProperties-Color="White" TextProperties-Font="Arial, 18pt">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </charttitle>
                                                    <appearance>
                                                        <FillStyle MainColor="25, 25, 25">
                                                        </FillStyle>
                                                        <Border Color="5, 5, 5"></Border>
                                                    </appearance>
                                                    <series>
                                                        <telerik:ChartSeries DataXColumn="number" DataYColumn="CommentCount" Name="Series 1">
                                                            <Appearance>
                                                                <Border Color="187, 149, 58"></Border>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                                <FillStyle FillType="ComplexGradient" MainColor="222, 202, 155">
                                                                    <FillSettings>
                                                                        <ComplexGradient>
                                                                            <telerik:GradientElement Color="222, 202, 152" />
                                                                            <telerik:GradientElement Color="211, 185, 123" Position="0.5" />
                                                                            <telerik:GradientElement Color="183, 154, 84" Position="1" />
                                                                        </ComplexGradient>
                                                                    </FillSettings>
                                                                </FillStyle>
                                                                <PointMark Border-Color="DarkKhaki" Border-Width="4" FillStyle-FillType="Solid" Visible="True">
                                                                    <FillStyle FillType="Solid">
                                                                    </FillStyle>
                                                                    <Border Color="DarkKhaki" Width="4"></Border>
                                                                </PointMark>
                                                            </Appearance>
                                                        </telerik:ChartSeries>
                                                    </series>
                                                    <legend visible="false">
                                                        <appearance dimensions-margins="1px, 2%, 9%, 1px" position-alignedposition="BottomRight"
                                                            visible="False">
                                                            <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                                            </ItemTextAppearance>
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent"></Border>
                                                        </appearance>
                                                    </legend>
                                                </telerik:RadChart>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span>Comments Graph Description and Info</span>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="boardersInGraphRadPageView" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadChart ID="RadChartInvestors" runat="server" AutoLayout="True" Height="400px"
                                                    Skin="Black" Width="450px">
                                                    <plotarea>
                                                        <XAxis AutoScale="False" MaxValue="8" MinValue="1" Step="1">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </XAxis>
                                                        <YAxis AutoScale="False" MaxValue="20" MinValue="0" Step="2">
                                                            <Appearance Color="62, 62, 62" MajorTick-Color="48, 48, 48" MinorTick-Color="48, 48, 48">
                                                                <MajorGridLines Color="77, 77, 77"></MajorGridLines>
                                                                <MinorGridLines Color="77, 77, 77"></MinorGridLines>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                            </Appearance>
                                                            <AxisLabel>
                                                                <TextBlock>
                                                                    <Appearance TextProperties-Color="159, 159, 159">
                                                                    </Appearance>
                                                                </TextBlock>
                                                            </AxisLabel>
                                                        </YAxis>
                                                        <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                                            <FillStyle FillType="Solid" MainColor="51, 51, 51">
                                                            </FillStyle>
                                                            <Border Color="62, 62, 62"></Border>
                                                        </Appearance>
                                                    </plotarea>
                                                    <charttitle textblock-text="">
                                                        <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent" />
                                                        </Appearance>
                                                        <TextBlock Text="">
                                                            <Appearance TextProperties-Color="White" TextProperties-Font="Arial, 18pt">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </charttitle>
                                                    <appearance>
                                                        <FillStyle MainColor="25, 25, 25">
                                                        </FillStyle>
                                                        <Border Color="5, 5, 5"></Border>
                                                    </appearance>
                                                    <series>
                                                        <telerik:ChartSeries DataXColumn="number" DataYColumn="InvestorsCount" Name="Series 1">
                                                            <Appearance>
                                                                <TextAppearance TextProperties-Color="159, 159, 159">
                                                                </TextAppearance>
                                                                <FillStyle FillType="ComplexGradient" MainColor="222, 202, 155">
                                                                    <FillSettings>
                                                                        <ComplexGradient>
                                                                            <telerik:GradientElement Color="222, 202, 152" />
                                                                            <telerik:GradientElement Color="211, 185, 123" Position="0.5" />
                                                                            <telerik:GradientElement Color="183, 154, 84" Position="1" />
                                                                        </ComplexGradient>
                                                                    </FillSettings>
                                                                </FillStyle>
                                                                <PointMark Border-Color="DarkKhaki" Border-Width="4" FillStyle-FillType="Solid" Visible="True">
                                                                    <FillStyle FillType="Solid">
                                                                    </FillStyle>
                                                                    <Border Color="DarkKhaki" Width="4"></Border>
                                                                </PointMark>
                                                            </Appearance>
                                                        </telerik:ChartSeries>
                                                    </series>
                                                    <legend visible="false">
                                                        <appearance dimensions-margins="1px, 2%, 9%, 1px" position-alignedposition="BottomRight"
                                                            visible="False">
                                                            <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                                            </ItemTextAppearance>
                                                            <FillStyle MainColor="Transparent">
                                                            </FillStyle>
                                                            <Border Color="Transparent"></Border>
                                                        </appearance>
                                                    </legend>
                                                </telerik:RadChart>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span>BoardersIn Graph Description and Info</span>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="conversionRateGraphRadPageView" runat="server">
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </telerik:RadPageView>
            <telerik:RadPageView ID="boardersInView" runat="server">
                <br />
                <div style="min-height: 300px; width: 100%;">
                    <asp:datalist id="boardersInDataList" runat="server" datasourceid="sdBoardersIn"
                        repeatdirection="Horizontal" repeatlayout="Table" repeatcolumns="5">
                        <itemtemplate>
                            <table width="100%" border="0" cellspacing="5" cellpadding="5">
                                <tr>
                                    <td style="background-color: #ececee; color: #262626; text-align: center;">
                                        <div style="min-height: 80px;">
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("WatchedBy", IIf(Convert.ToString(Eval("WatchedBy"))= Convert.ToString(Session("WatchedBy")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("WatchedBy")%>'
                                                    Height="60px" Width="70px" ImageUrl='<%# isAvail(Eval("WatchedBy", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <br />
                                            <%# Container.DataItem("FirstName")%><%# Container.DataItem("LastName")%><br />
                                            <asp:Button ID="btnAddBoarder" runat="server" Text="ADD BOARDER" CssClass="primaryMiniButton"
                                                CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("userID")%>'
                                                Visible='<%# IIf((Eval("status").ToString()="2") or (Eval("status").ToString()=""),true,false) %>' />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </itemtemplate>
                    </asp:datalist>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="boardersWatchingView" runat="server">
                <br />
                <div style="min-height: 300px; width: 100%;">
                    <asp:datalist id="boardersWatchingDataList" runat="server" datasourceid="sdBoardersWatching"
                        repeatdirection="Horizontal" repeatlayout="Table" repeatcolumns="5">
                        <itemtemplate>
                            <table width="100%" border="0" cellspacing="5" cellpadding="5">
                                <tr>
                                    <td style="background-color: #ececee; color: #262626; text-align: center;">
                                        <div style="min-height: 80px;">
                                            <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("WatchedBy", IIf(Convert.ToString(Eval("WatchedBy"))= Convert.ToString(Session("WatchedBy")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("WatchedBy")%>'
                                                    Height="60px" Width="70px" ImageUrl='<%# isAvail(Eval("WatchedBy", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <br />
                                            <%# Container.DataItem("FirstName")%><%# Container.DataItem("LastName")%><br />
                                            <asp:Button ID="btnAddBoarder" runat="server" Text="ADD BOARDER" CssClass="primaryMiniButton"
                                                CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("userID")%>'
                                                Visible='<%# IIf((Eval("status").ToString()="2") or (Eval("status").ToString()=""),true,false) %>' />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </itemtemplate>
                    </asp:datalist>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
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
    <telerik:RadGrid ID="rgInvestmentAddressExcel" runat="server" AutoGenerateColumns="False"
        GridLines="None" AllowPaging="true" PageSize="5" Style="display: none">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FullName" HeaderText="FullName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" HeaderText="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderAddress" HeaderText="BoarderAddress">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderCity" HeaderText="BoarderCity">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderState" HeaderText="BoarderState">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Boarderzip" HeaderText="Boarderzip">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <telerik:RadGrid ID="rgInvestmentNoAddressExcel" runat="server" AutoGenerateColumns="False"
        GridLines="None" AllowPaging="true" PageSize="5" Style="display: none">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn DataField="UserName" HeaderText="UserName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="FullName" HeaderText="FullName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Email" HeaderText="Email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderAddress" HeaderText="BoarderAddress">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderCity" HeaderText="BoarderCity">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BoarderState" HeaderText="BoarderState">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Boarderzip" HeaderText="Boarderzip">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <%--  </contenttemplate>
    </asp:updatepanel>--%>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="650" Width="900px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:sqldatasource id="sdBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select CONVERT(VARCHAR(11),DateActivated,106) as DateActivated,BoardID,status,Boardname,status,UserID,FacebookSync,LinkedInSync,TwitterSync,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,BankLocation,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Comments,Investors,District,AreaName,RecentComment,CommenterUserID,city,state,country,isnull(city,'')+','+ISNULL(State,'') as Location,District1,InvestmentTypeID,'$'+ convert(varchar(12),cast(RaisedTotal as dec(10,0)),1) As RaisedTotalText,isnull(RaisedTotal,0)as RaisedTotal,TotalOffer,NoOfBoardLevels,Offer,AmountRemaining,AboutMe,InvType,InvTypeDescription,case when minLevelPrice=maxLevelPrice then  '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) else '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) + ' - $'+ convert(varchar(12),cast(maxLevelPrice as dec(10,0)),1) END As PricedFrom,BoardLevel,ViewsCount,YoutubeVideoUrl from vwBoardInfo  Where directoryName=@DirectoryName">
        <selectparameters>
            <asp:Parameter Name="DirectoryName" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestorsAddressEmpty" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand=" Select * from (Select (SELECT UserName FROM Users WHERE UserId=BI.UserId)AS UserName,B.DirectoryName,(SELECT FirstName+' '+LastName FROM Users WHERE UserId=BI.UserId)AS FullName,(SELECT Email FROM Users WHERE UserId=BI.UserId)AS Email, (SELECT isnull(Address ,'')FROM Users WHERE UserId=BI.UserId) BoarderAddress,(SELECT isnull(City ,'')FROM Users WHERE UserId=BI.UserId) BoarderCity,(SELECT isnull(State ,'')FROM Users WHERE UserId=BI.UserId) BoarderState, (SELECT isnull(zip,'')FROM Users WHERE UserId=BI.UserId) Boarderzip  from BoardInvestors BI INNER Join Boards B on BI.BoardID= B.BoardID   where BI.AmountInvested is not null and B.DirectoryName=@DirectoryName ) main where ((BoarderAddress is  null or  BoarderAddress ='') and (BoarderCity is  null or  BoarderCity ='')  and (BoarderState is null or  BoarderState ='') and (Boarderzip is  null or  Boarderzip =''))">
        <selectparameters>
            <asp:Parameter Name="DirectoryName" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestorsAddressAdded" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="  Select * from (Select (SELECT UserName FROM Users WHERE UserId=BI.UserId)AS UserName,B.DirectoryName,(SELECT FirstName+' '+LastName FROM Users WHERE UserId=BI.UserId)AS FullName,(SELECT Email FROM Users WHERE UserId=BI.UserId)AS Email, (SELECT isnull(Address ,'')FROM Users WHERE UserId=BI.UserId) BoarderAddress,(SELECT isnull(City ,'')FROM Users WHERE UserId=BI.UserId) BoarderCity,(SELECT isnull(State ,'')FROM Users WHERE UserId=BI.UserId) BoarderState, (SELECT isnull(zip,'')FROM Users WHERE UserId=BI.UserId) Boarderzip  from BoardInvestors BI INNER Join Boards B on BI.BoardID= B.BoardID   where BI.AmountInvested is not null and B.DirectoryName=@DirectoryName ) main where ((BoarderAddress is not null and  BoarderAddress <>'') and (BoarderCity is not null and  BoarderCity <>'')  and (BoarderState is not null and  BoarderState <>'') and (Boarderzip is not null and  Boarderzip <>''))">
        <selectparameters>
            <asp:Parameter Name="DirectoryName" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetBoardIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BoardId from Boards WHERE DirectoryName=@Name">
        <selectparameters>
            <asp:Parameter Name="Name" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdComments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spCommentGraph" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdViews" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spViewsGraph" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdWatches" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spWatchersGraph" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="spInvestorsGraph" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoardersWatching" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select BI.BoardID,BI.UserID,(SELECT UserName from Users where UserID=BI.UserID) As WatchedBy,(SELECT FirstName from Users where UserID=BI.UserID) As FirstName,(SELECT LastName from Users where UserID=BI.UserID) As LastName,(select status from boarders where ((userid1=BI.UserID and userId2=@userID) or (userid1=@userID and userId2=BI.UserID))) as status from boardInvestors BI where BI.BoardID=@BoardID and BI.WatchDate is not null and BI.userid<>@userID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoardersIn" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select BI.BoardID,BI.UserID,(SELECT UserName from Users where UserID=BI.UserID) As WatchedBy,(SELECT FirstName from Users where UserID=BI.UserID) As FirstName,(SELECT LastName from Users where UserID=BI.UserID) As LastName,(select status from boarders where ((userid1=BI.UserID and userId2=@userID) or (userid1=@userID and userId2=BI.UserID))) as status from boardInvestors BI where BI.BoardID=@BoardID and BI.DateInvested is not null and BI.userid<>@userID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        insertcommand="INSERT INTO Boarders(UserID1,UserID2,Status,DateRequested) VALUES(@UserID1,@UserID2,0,getdate())"
        updatecommand="UPDATE Boarders SET Status=0,DateRequested=getdate(),DateRejected=null,userID1=@UserID1,UserID2=@UserID2 WHERE (UserID1=@UserID1 AND UserID2=@UserID2) OR (UserID1=@UserID2 AND UserID2=@UserID1)">
        <insertparameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </insertparameters>
        <updateparameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdCheckRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
        <selectparameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdSyncFacebook" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="Update Boards Set FacebookSync=@FacebookSync WHERE BoardID=@BoardID">
        <updateparameters>
            <asp:Parameter Name="FacebookSync" />
            <asp:Parameter Name="BoardID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdSyncLinkedIn" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="Update Boards Set LinkedInSync=@LinkedInSync WHERE BoardID=@BoardID">
        <updateparameters>
            <asp:Parameter Name="LinkedInSync" />
            <asp:Parameter Name="BoardID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdSyncTwitter" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="Update Boards Set TwitterSync=@TwitterSync WHERE BoardID=@BoardID">
        <updateparameters>
            <asp:Parameter Name="TwitterSync" />
            <asp:Parameter Name="BoardID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetUserEmail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT Email FROM users WHERE userid=@userid">
        <selectparameters>
            <asp:SessionParameter Name="userid" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
</asp:content>
