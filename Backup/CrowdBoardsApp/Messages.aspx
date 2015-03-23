<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Messages.aspx.vb" Inherits="CrowdBoardsApp.Messages"
    MasterPageFile="~/MasterPage/Site.Master" Title="Messages" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Messages</title>
    <link href="WebContent/Theme/styles/messages.css" rel="stylesheet" type="text/css" />
    <script src="WebContent/Theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/navbar.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <%--  <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>--%>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            var divToHide;
            var toUser;
            function forwardMessage(fromUser, messageID, divID) {
                divToHide = document.getElementById(divID);
                var inputArr = divToHide.getElementsByTagName("input");
                var userid;
                var objUserComboBox;
                for (var i = 0; i < inputArr.length; i++) {
                    if (inputArr[i].type == 'text' && inputArr[i].type != 'hidden') {
                        objUserComboBox = inputArr[i];
                        break;
                    }
                }

                toUser = objUserComboBox.value;
                $.ajax({
                    type: "POST",
                    url: "WebService/WebService.asmx/ForwardMessage",
                    data: "{'fromUser':'" + fromUser + "','toUser':'" + toUser + "','messageID':'" + messageID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessValidateLogin,
                    error: OnErrorCallValidateLogin
                });
                return false;
            }
            function OnSuccessValidateLogin(response) {

                if (response.d == "1") {
                    $(divToHide).fadeOut(500);
                }
                else if (response.d == "0") {
                    alert("Error in Forwarding Message");
                }
            }


            function OnErrorCallValidateLogin(response) {
                alert(response.status + " " + response.statusText);

            }

        </script>
        <script type="text/javascript">


            function fileUploaded(sender, args) {
                document.getElementById("<%= btnUploadFilePhoto.ClientID %>").click();
            }

            function fileUploadedNewMessage(sender, args) {
                document.getElementById("<%= newMessageUploadButton.ClientID %>").click();
            }

            function showMessages(args,divID) {

                if (document.getElementById("<%= hdnMessagesShow.ClientID %>").value != args) {
                    document.getElementById("<%= hdnMessagesShow.ClientID %>").value = args;                                 

                    document.getElementById("<%= hdnSelectedDivID.ClientID %>").value = divID;
                    document.getElementById("<%= btnShowMesaages.ClientID %>").click();
                    
                }
            }


            function initializePopUps() {
                $("a.open-notify").mousemove(function () {
                    $("#BodyContent_newMessageDiv").fadeIn(500);
                    document.getElementById("BodyContent_messageRepeaterDiv").style.visibility = "hidden";
                    document.getElementById("BodyContent_replyDiv").style.visibility = "hidden";
                    return false;
                });

                $("#BodyContent_newMessageDiv a.close-notify").click(function () {
                    $("#BodyContent_newMessageDiv").fadeOut(500);
                    return false;
                });

            }
            $(document).ready(function () {
                initializePopUps();
            });                             
                           
        </script>
        <script type="text/javascript">
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function () {
                alert("called");
                initializePopUps();
            });

        </script>
        <script type="text/javascript">

            function showPopup(divID) {
                var item = document.getElementById(divID);
                $(item).fadeIn(500); ;
            }
            function hidePopup(divID) {
                var item = document.getElementById(divID);
                $(item).fadeOut(500);
            }                
        </script>
    </telerik:RadScriptBlock>
    <div class="container">
    <asp:HiddenField ID="hdnSelectedDivID" runat="server" />
        <div class="left-column" style="min-height: 1200px;">
            <div class="title">
                Messages</div>
            <div class="sub-heading">
                <a href="#" class="open-notify">NEW MESSAGE</a> &nbsp;<asp:Label ID="newMessageLabel"
                    runat="server"></asp:Label>
                <asp:ImageButton ID="btnNewMessage" runat="server" AlternateText="NEW MESSAGE" ImageUrl="~/Images/newMessageBtn.png"
                    Style="display: none;" />
            </div>
            <asp:Repeater ID="boardersRepeater" runat="server" DataSourceID="userNameDataSource">
                <ItemTemplate>
                    <div class="latest-message-container">
                        <div class="highlighted-feature" id="users" runat="server">
                            <div class="first-row">
                                <div class="sender-image">
                                    <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("userID")%>' />
                                    <asp:LinkButton ID="userLink" runat="server" CommandName="ViewMessage" CommandArgument='<%# Eval("userID") %>'>
                                        <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("Users")%>'
                                            Height="60px" Width="70px" ImageUrl='<%# isAvail(Eval("Users", "~/Upload/ProfilePics/{0}.jpg")) %>' />
                                    </asp:LinkButton>
                                </div>
                                <div class="sender-name">
                                    <br />
                                    &nbsp;
                                    <asp:Label ID="usersLabel" runat="server" ToolTip='<%# Container.DataItem("Users")%>'
                                        ForeColor="#75b4c6"><%# Container.DataItem("Users")%></asp:Label>
                                </div>
                            </div>
                            <div class="message-container">
                                <div class="message-text">
                                    <%# Container.DataItem("recentMessage")%>
                                </div>
                            </div>
                            <%-- <asp:Image ID="imageCorner" runat="server" ImageUrl="Images/corner.png" Visible='<%# SelectUser(Eval("userID")) %>' />--%>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="right-column" style="min-height: 1200px;">
            <asp:HiddenField ID="hdnMessagesShow" runat="server" />
            <asp:HiddenField ID="htnImageID" runat="server" />
            <asp:Label ID="lblNewMessage" runat="server" CssClass="LabelGreenLarge" Text=""></asp:Label>
            <div id='newMessageDiv' runat="server">
                <a href="#" class="close-notify" style="color: #262626; float: right;">CLOSE</a>
                <div class="select-boarder">
                    Select a Boarder:
                    <telerik:RadComboBox ID="friendRadCombobox" runat="server" DataSourceID="sdsUserfriends"
                        DataTextField="Users" DataValueField="userID">
                    </telerik:RadComboBox>
                </div>
                <div class="send-message-row">
                    <div class="title">
                        Message</div>
                    <div class="text-area-container">
                        <telerik:RadTextBox ID="txtNewMessage" runat="server" TextMode="MultiLine" Rows="4"
                            Width="90%" Style="margin-left: 50px;">
                        </telerik:RadTextBox>
                        <br />
                    </div>
                    <div class="buttons-container">
                        <div id="newMessageUploadDiv" runat="server" style="margin-left: 50px;">
                            <br />
                            <label>
                                ADD FILE/ADD PHOTO</label>&nbsp;
                            <telerik:RadAsyncUpload ID="newMessageRadAsyncUpload" runat="server" MultipleFileSelection="Disabled"
                                OnClientFilesUploaded="fileUploadedNewMessage" HttpHandlerUrl="~/CustomHandler.ashx"
                                Width="110px" Height="30px">
                            </telerik:RadAsyncUpload>
                            <asp:Button ID="newMessageUploadButton" runat="server" Text="Upload" Style="display: none;" />
                            <asp:Button ID="newMessageSendRadButton" runat="server" Text="Send" CssClass="button"
                                Style="margin-right: 65px;"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
            <div id='messageRepeaterDiv' runat="server" class="conversation-container">
                <asp:Button ID="btnShowMesaages" runat="server" Text="Upload" Style="display: none;" />
                <div class="title">
                    <asp:Label ID="msgLabel" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Repeater ID="messageRepeater" runat="server" OnItemDataBound="messageRepeater_ItemDataBound">
                    <ItemTemplate>
                        <div id="messageDiv" runat="server" class="row-left" style="overflow: hidden;">
                            <div class="conversation-message-container">
                                <div class="first-row">
                                    <div class="sender-image">
                                        <asp:Label ID="fileNameLabel" runat="server" Text='<%# Eval("FileName")%>' Visible="false"></asp:Label>
                                        <asp:Image ID="userPic" runat="server" ToolTip='<%# Container.DataItem("FileText")%>'
                                            Visible="false" ImageUrl='<%#GetImageURL(Eval("FileName"),100,200,"Upload/MessageFiles","Upload/MessageFiles/Thumbnail") %>' />
                                        <asp:LinkButton ID="downLoadLinkButton" runat="server" Text=' <%# Eval("FileText")%>'
                                            ToolTip="Download" ForeColor="#262626" Font-Underline="true" Visible="false"
                                            CommandName="Download" CommandArgument='<%# Eval("FileName")%>'></asp:LinkButton>
                                    </div>
                                    <div class="sender-name">
                                        <a href="">
                                            <asp:Label ID="userNameLabel" runat="server" Text=' <%# Eval("Users")%>'></asp:Label>
                                            <asp:HiddenField ID="hdnMessageID" runat="server" Value='<%#Eval("MessageID")%>' />
                                        </a>
                                    </div>
                                    <div class="time-stamp">
                                        <%# Eval("datesent")%></div>
                                </div>
                                <div class="message-text">
                                    <asp:Label ID="messageText" runat="server" Text='<%# Eval("Text")%>'></asp:Label>
                                </div>
                            </div>
                            <div class="message-function-container">
                                <asp:ImageButton ID="deleteMessageImageButton" Height="30px" Width="20px" runat="server"
                                    Style="display: block; margin: 10px;" OnClientClick="return confirm('Are you sure you want to Delete?')"
                                    ImageUrl="~/WebContent/Theme/images/close.png" ToolTip="Delete" CommandName="IDelete"
                                    CommandArgument='<%#Eval("MessageID")%>' /><br />
                                <asp:ImageButton ID="forwareMessageImageButton" Height="30px" Style="display: block;
                                    margin: 10px;" Width="20px" runat="server" ToolTip="Forward" OnClientClick="return false"
                                    ImageUrl="~/WebContent/Theme/images/forward.png" CommandName="Forward" />                               
                            </div>
                            <div id="forwardDiv" runat="server" style="display: none; margin-top: 10px; margin-left:75px; margin-right:75px;" class="message-function-container">
                                    <table width="100%">
                                        <tr>
                                            <td align="center">
                                                <telerik:RadComboBox ID="forwardToRadCombobox" runat="server" DataSourceID="sdsUserfriends"
                                                    DataTextField="Users" DataValueField="userID" Width="120">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:ImageButton ID="cancelBtn" runat="server" OnClientClick="return false" AlternateText="Cancel"
                                                    Style="margin: 10px;" ImageUrl="~/WebContent/Theme/images/close.png" Height="10"
                                                    Width="15" CommandName="ICancel" ToolTip="Cancel" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:ImageButton ID="btnForword" runat="server" AlternateText="Forward" ImageUrl="~/WebContent/Theme/images/forward.png"
                                                    Style="margin: 10px;" Height="10" Width="15" ToolTip="Forward" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <br />
            <div id='replyDiv' visible="false" runat="server" class="send-message-row">
                <div class="title">
                    Message</div>
                <asp:Label ID="messageLabel" runat="server" Text="" Visible="false"></asp:Label>
                <div class="text-area-container">
                    <telerik:RadTextBox ID="replyMessageRadTexBox" runat="server" TextMode="MultiLine"
                        Rows="4" Width="500px" Style="margin-left: 50px;">
                    </telerik:RadTextBox>
                </div>
                <div class="buttons-container" style="margin-left: 50px;">
                    <br />
                    ADD FILE/ADD PHOTO
                    <telerik:RadAsyncUpload ID="RadUpload1" runat="server" MultipleFileSelection="Disabled"
                        OnClientFilesUploaded="fileUploaded" HttpHandlerUrl="~/CustomHandler.ashx" Height="28px"
                        Width="100%">
                    </telerik:RadAsyncUpload>
                    <asp:Button ID="btnUploadFilePhoto" runat="server" Text="Upload" Style="display: none;" />
                    <asp:Label ID="lblUploadFilePhoto" runat="server" ForeColor="green"></asp:Label>
                    <asp:Button ID="replyRadButton" runat="server" Text="Reply" CssClass="button" Style="margin-right: 70px;" />
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="userNameDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT userid,Users,(SELECT TOP 1 DateSent FROM messages WHERE (touser=@UserID AND FromUser=main.userID) or (touser=main.userID AND FromUser=@UserID) ORDER BY DateSent DESC) AS recentMessage from(SELECT DISTINCT CASE WHEN ToUser=@UserID THEN FromUser ELSE ToUser END AS userID,(SELECT Username FROM users WHERE UserID=CASE WHEN ToUser=@UserID THEN FromUser ELSE ToUser END) AS Users FROM messages WHERE (touser=@UserID OR FromUser=@UserID) and (touser is not null and FromUser is not null)) main ORDER BY recentMessage DESC">
        <SelectParameters>
            <asp:SessionParameter Name="userName" SessionField="UserName" />
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessages" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT MessageID,FromUser,ToUser,FromUserName,ToUserName,FileName, substring(FileName,CHARINDEX('+-',filename)+2,LEN(filename)) as FileText,  CASE WHEN FromUserName=@userIDNode Then FromUserName Else 'ME' End As Users,datesent,Text   FROM vwMessagesDetail   Where (FromUserName=@userIDNode   OR ToUserName=@userIDNode) AND (FromUserName=@userID OR   ToUserName=@userID) Order by datesent"
        InsertCommand="INSERT INTO Messages(FromUser,ToUser,DateSent,Text,Unread) VALUES(@FromUser,@ToUser,getdate(),@Text,@Unread)"
        UpdateCommand="UPDATE Messages SET Unread=0 WHERE Unread=1 and FromUser=@userIDNode and ToUser=@userID">
        <SelectParameters>
            <asp:Parameter Name="userIDNode" Type="string" />
            <asp:SessionParameter Name="userID" SessionField="userName" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="FromUser" />
            <asp:Parameter Name="ToUser" />
            <asp:Parameter Name="Text" />
            <asp:Parameter Name="Unread" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="userIDNode" />
            <asp:Parameter Name="userID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdMessageCount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select COUNT(text) MessageCount from Messages where unread=1 and ToUser=@userID">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select UserName from Users where UserID=@nodeUserName">
        <SelectParameters>
            <asp:Parameter Name="nodeUserName" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsMessageFiles" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="messagesInsert" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Messages] SET FileName=@FileName where messageID=@messageID"
        DeleteCommand="Delete FROM Messages where MessageID=@messageID">
        <SelectParameters>
            <asp:Parameter Name="FromUser" />
            <asp:Parameter Name="ToUser" />
            <asp:Parameter Name="Text" />
            <asp:Parameter Name="Unread" />
            <asp:Parameter Name="FileName" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="messageID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUserfriends" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT DISTINCT CASE WHEN UserID1UserName=@userName THEN UserID2UserName ELSE UserID1UserName END AS Users, CASE WHEN UserID1=@userID THEN UserID2 ELSE UserID1 END AS userID FROM vwBoardersDetail WHERE (UserID1UserName=@userName OR UserID2UserName=@userName) AND Status=1 and (UserID1 is not null and UserID2 is not null) ORDER BY Users">
        <SelectParameters>
            <asp:SessionParameter Name="userName" SessionField="UserName" />
            <asp:SessionParameter Name="userID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUserEmail" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Email as userEmail from Users where UserID=@ToUser">
        <SelectParameters>
            <asp:Parameter Name="ToUser" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
