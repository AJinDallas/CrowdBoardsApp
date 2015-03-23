<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BoarderLineup.aspx.vb"
    Inherits="CrowdBoardsApp.BoarderLineup" MasterPageFile="~/MasterPage/Site.Master" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/main.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/searchresults.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/boarderslineup.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
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
                new_style_message: true,
                message: 'Invitation to join CrowdBoarders',
                link: "https://crowdboarders.com/default.aspx"
            });

            //            FB.ui({ method: 'apprequests',
            //                new_style_message: true,
            //                title: "Join CrowdBoarders",
            //                message: 'Invitation to join CrowdBoarders'
            //                // request_url: "https://crowdboarders.com/default.aspx"   


            //            }, requestCallback);
        }
        function requestCallback(response) {

            // Handle callback here

        }

        //        function unloadPopupBoxVideo() {

        //            $('#popup_box_Video').fadeOut("slow");
        //            return false;
        //        }

        //        function loadPopupBoxVideo() {
        //            $('#popup_box_Video').fadeIn("slow");
        //            return false;

        //        }
        

    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <style>
        .main
        {
            width: 780px;
            margin: 0 auto;
            height: 300px;
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
        // alert(api_key);
        // api_key: 75wmje5ejt33bf
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
            var title = "Crowdboard Invitation";  //document.getElementById('h1Title').innerHTML;
            var message = "https://crowdboarders.com";
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
             .error(function error(e) { alert("No dice"); document.getElementById("btnLinkedin").style = "display:none;" });
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
            document.getElementById("btnLinkedin").style = "display:block;"
        }
    </script>
    <style type="text/css">

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
        
.cb-btn {
    background-color: #ffffff;
    border: medium none;
    color: #75b4c6 !important;
    cursor: pointer;
    display: block;
    font-size: 16px !important;
    font-weight: 600;
    height: 31px;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    text-align:center;
    padding:5px;
}
.cb-btn:hover
{
    background-color: #fff;
    border: 1px solid #fff;
    color: #000 !important;
    
    }
    .LabelheadingWhite
        {
            font-size:16px;
            margin-bottom:5px;
        }

    </style>
    <script>
        function unloadPopupBoxLikedInInvite() {

            $('#linkedinInviteDiv').fadeOut("slow");

            return false;
        }

        function loadPopupBoxLikedInInvite() {
            $('#linkedinInviteDiv').fadeIn("slow");
            return false;

        }

        function unloadPopupBoxYahooInvite() {

            $('#yahooInviteDiv').fadeOut("slow");

            return false;
        }

        function loadPopupBoxYahooInvite() {

            $('#yahooInviteDiv').fadeIn("slow");
            return false;
        }

        function ClickGooleLinkButton() {

            var btn = document.getElementById("BodyContent_gooleInviteButton")

            btn.click();
        }

    </script>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
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
            <input type="button" id="btnLinkedin" value="Invite!" class="connect-button" style="width: 150px;
                display: none;" onclick="return SendMessage();" />
            <br />
        </div>
    </div>
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
            }

            function ClickYohooLinkButton() {
                var btn = document.getElementById("BodyContent_yahooInvite");
                btn.click();
            }
        </script>
    </telerik:RadScriptBlock>
    <%-- <asp:updatepanel id="updatePanel1" runat="server">
        <contenttemplate>--%>
    <div class="container">
        <div class="first-row">
            <span>Connect
                <asp:linkbutton id="addFriendLinkButton" runat="server" text="Boarders Lineup">
                </asp:linkbutton>
                <asp:linkbutton id="removeFriendLinkButton" runat="server" text="Add CrowdBoarders">
                </asp:linkbutton>
                <asp:linkbutton id="mediaLinkLinkButton" runat="server" text="Find Friends">
                </asp:linkbutton>
                <asp:label id="followersLabel" runat="server"></asp:label>
            </span>
        </div>
        <div class="main-body">
            <div style="text-align: right;">
                <asp:panel id="headPanel" runat="server" defaultbutton="lbtnSearch">
                    <ul>
                        <li class="menu-image" id="search">
                            <%--  <input name="q" type="text" size="40" placeholder="Search..." runat="server" id="searchBoardsTextBox" />--%>
                            <asp:textbox id="searchBoardsTextBox" runat="server" size="40" placeholder="Search...">
                            </asp:textbox>
                        </li>
                    </ul>
                    <asp:linkbutton id="lbtnSearch" runat="server" text="Search" style="display: none">
                    </asp:linkbutton>
                </asp:panel>
            </div>
            <br />
            <div>
                <asp:label id="lblMessageAddBoarder" runat="server" text="" visible="false" font-size="16">
                </asp:label>
            </div>
            <br />
            <asp:multiview id="MultiViewFriendList" runat="server" activeviewindex="0">
                <asp:view id="removeFriendView" runat="server">
                    <asp:datalist id="removeFriendDataList" runat="server" repeatcolumns="4" repeatdirection="Horizontal"
                        repeatlayout="Table">
                        <itemtemplate>
                            <asp:HiddenField ID="hdnRemFriend" runat="server" Value='<%# Container.DataItem("username")%>' />
                            <div style="width: 315px; float: left; background-color: #f6f6f6; color: #788586;
                                font-size: 14px;">
                                <div class="crowdboard-container group">
                                    <div style="float: left; width: 50%; height: 150px;">
                                        <asp:HyperLink ID="remViewUserLink" runat="server" Height="150" Width="130" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <div id="remfirendDiv" runat="server">
                                                <div style="width: 100%; height: 80%;">
                                                </div>
                                                <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                    opacity: 0.4; background-color: #262626;">
                                                    <div style="height: 6px;">
                                                        &nbsp;</div>
                                                    <span style="color: White;">
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
                                            <asp:Label ID="remViewLblPendingStatus" runat="server" Text="Pending" Visible='<%# IIf(Eval("friendStatus")=0,true,false) %>'></asp:Label>
                                            <asp:Button ID="remViewBtnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                Text="Add Boarder" CssClass="invest-button" Style="border-radius: 4px;" Visible='<%# IIf(Eval("friendStatus")=3 or Eval("friendStatus")=2,true,false) %>' />
                                            <asp:Button ID="remViewBtnRemoveBoarder" runat="server" CommandName="IRemoveBoarder"
                                                CommandArgument='<%# Container.DataItem("Userid")%>' Text="Remove Boarder" CssClass="invest-button"
                                                Style="border-radius: 4px;" Visible='<%# IIf(Eval("friendStatus")=1,true,false) %>'
                                                OnClientClick="return confirm('Are you sure ?');" />&nbsp;
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </itemtemplate>
                    </asp:datalist>
                </asp:view>
                <asp:view id="addFriendsView" runat="server">
                    <asp:datalist id="addFriendDataList" runat="server" repeatcolumns="4" repeatdirection="Horizontal"
                        repeatlayout="Table">
                        <itemtemplate>
                            <asp:HiddenField ID="hdnAddFriend" runat="server" Value='<%# Container.DataItem("username")%>' />
                            <div style="width: 315px; float: left; background-color: #f6f6f6; color: #788586;
                                font-size: 14px;">
                                <div class="crowdboard-container group">
                                    <div style="float: left; width: 50%; height: 150px;">
                                        <asp:HyperLink ID="remViewUserLink" runat="server" Height="150" Width="130" NavigateUrl='<%# Eval("username", IIf(Convert.ToString(Eval("username"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <div id="addfirendDiv" runat="server">
                                                <div style="width: 100%; height: 80%;">
                                                </div>
                                                <div style="width: 100%; height: 20%; text-align: center; filter: alpha(opacity=70);
                                                    opacity: 0.4; background-color: #262626;">
                                                    <div style="height: 6px;">
                                                        &nbsp;</div>
                                                    <span style="color: White;">
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
                                            <asp:Label ID="addViewLblPendingStatus" runat="server" Text="Pending" Visible='<%# IIf(Eval("friendStatus")=0,true,false) %>'></asp:Label>
                                            <asp:Button ID="addViewBtnAddBoarder" runat="server" CommandName="IAddBoarder" CommandArgument='<%# Container.DataItem("Userid")%>'
                                                Text="Add Boarder" CssClass="invest-button" Style="border-radius: 4px;" Visible='<%# IIf(Eval("friendStatus")=3 or Eval("friendStatus")=2,true,false) %>' />
                                            <asp:Button ID="addViewBtnRemoveBoarder" runat="server" CommandName="IRemoveBoarder"
                                                CommandArgument='<%# Container.DataItem("Userid")%>' Text="Remove Boarder" CssClass="invest-button"
                                                Style="border-radius: 4px;" Visible='<%# IIf(Eval("friendStatus")=1,true,false) %>'
                                                OnClientClick="return confirm('Are you sure ?');" />&nbsp;
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </itemtemplate>
                    </asp:datalist>
                </asp:view>
                <asp:view id="mediaLinkView" runat="server">
                    <div class="find-friends">
                        <div class="title">
                            Find and Invite friends from other networks</div>
                        <div class="connect-central">
                            <div>
                                <a href="#" onclick="FacebookInviteFriends(); return false;">
                                    <img src="../WebContent/Theme/images/facebookicon.png" /></a>Facebook<input type="button"
                                        value="Connect" class="connect-button" onclick="FacebookInviteFriends(); return false;" />
                            </div>
                            <%-- <div>
                                <a href="">
                                    <img src="../WebContent/Theme/images/hotmailicon.png" /></a>Hotmail<input type="button"
                                        value="Connect" class="connect-button" /></div>--%>
                            <%--  <div>
                                <asp:linkbutton id="twitterInvite" runat="server">
                                    <img src="../WebContent/Theme/images/twittericon.png" /></asp:linkbutton>Twitter<input
                                        type="button" value="Connect" class="connect-button" /></div>--%>
                            <div>
                                <asp:linkbutton id="gooleInviteButton" runat="server">
                                    <img src="../WebContent/Theme/images/googleicon.png" /></asp:linkbutton>Google<input
                                        type="button" value="Connect" class="connect-button" onclick=" ClickGooleLinkButton();" /></div>
                            <div onclick="loadPopupBoxLikedInInvite();">
                                <img src="../WebContent/Theme/images/linkedinicon.png" />Linkedin<input type="button"
                                    value="Connect" class="connect-button" onclick="loadPopupBoxLikedInInvite();" /></div>
                            <div>
                                <asp:linkbutton id="yahooInvite" runat="server">
                                    <img src="../WebContent/Theme/images/yahooicon.png" /></asp:linkbutton>Yahoo<input
                                        type="button" value="Connect" class="connect-button" onclick=" ClickYohooLinkButton();" /></div>
                            <%--  <div>
                                        <asp:LinkButton ID="gmailInvite" runat="server"><img src="Images/gmailInviteCC.png" /></asp:LinkButton>Gmail<input
                                            type="button" value="Connect" class="connect-button" />
                                    </div>--%>
                        </div>
                        <div class="connect-via-email">
                            <div class="title">
                                Invite and Connect via email</div>
                            <div style="margin-left: 380px; width: 50%;">
                                <span style="float: right; font-style: oblique; margin-bottom: 2px; margin-right: 128px;">
                                    copy and paste email list</span>
                                <telerik:RadTextBox ID="txtSendMultipleEmail" Width="81%" Height="230" Style="border: 1px solid #c8dedf;
                                    border-radius: 2px; display: block; float: left; font-size: 16px; margin-left: auto;
                                    margin-right: auto; padding: 5px; resize: none; font-family: helvetica;" CssClass="textarea"
                                    runat="server" TextMode="MultiLine" Rows="8">
                                </telerik:RadTextBox>
                                <br />
                                <asp:label id="lblMessageSendEmail" runat="server"></asp:label>
                                <asp:button id="btnSendEmail" style="float: right; margin-left: 20px; margin-top: -54px;"
                                    runat="server" text="Connect" cssclass="connect-button" />
                            </div>
                        </div>
                    </div>
                </asp:view>
            </asp:multiview>
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <%--</contenttemplate>
    </asp:updatepanel>--%>
    <script src="WebContent/Theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/main.js" type="text/javascript"></script>
    <asp:sqldatasource id="sdAllBoardersList" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT Userid,username,FirstName,LastName,friendStatus,Location,Profession,UserDistricts FROM f_GetBoardersList(@UserID) WHERE username is not null and (username like '%' + @searchKeyWord + '%' or FirstName like '%' + @searchKeyWord + '%' or LastName LIKE '%' + @searchKeyWord + '%') ORDER BY friendstatus"
        deletecommand="DELETE FROM Boarders WHERE (userid1=@UserID1 and UserId2=@UserID2) OR (userid1=@UserID2 and UserId2=@UserID1)">
        <selectparameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:SessionParameter Name="searchKeyWord" SessionField="searchKeyWord" DefaultValue="%" />
        </selectparameters>
        <deleteparameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </deleteparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select M.Users,M.UserID1,M.UserID2,M.Status,M.DateRequested,M.DateAccepted,(SELECT IsNULL(City,'')+','+ISNULL(state,'') from users WHERE UserName=M.Users) as Location,(SELECT Job from users WHERE UserName=M.Users) as Profession,dbo.fUserDistricts(CASE WHEN M.UserID1=@UserID Then M.UserID2 Else M.UserID1 End) As UserDistricts from (SELECT CASE WHEN UserID1=@UserID Then UserID2UserName Else UserID1UserName End As Users,userid1,userid2,Status,DateRequested,DateAccepted from vwBoardersDetail where (UserID1=@UserID or UserID2=@UserID) AND Status=1)M"
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
    <asp:sqldatasource id="sdCheckRequest" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT [status]  FROM  Boarders  WHERE (UserID1=@UserID1 and UserID2=@UserID2) or (UserID1=@UserID2 and UserID2=@UserID1)">
        <selectparameters>
            <asp:Parameter Name="UserID1" />
            <asp:Parameter Name="UserID2" />
        </selectparameters>
    </asp:sqldatasource>
</asp:content>
