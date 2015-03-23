<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CrowdboardCommand.aspx.vb"
    Inherits="CrowdBoardsApp.CrowdboardCommand" MasterPageFile="~/MasterPage/Site.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>CrowdBboard Command</title>
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
        
        .thermometer
        {
            width: 100%;
            height: 150px;           
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
    </style>
    <style>
        .ShowBoard
        {
            overflow-x: hidden;
            height: 420px;
            overflow: auto;
        }
        .HideBoard
        {
            height: 420px;
            overflow: hidden;
        }
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
        }
    </style>
    <style type="text/css">
        .style2
        {
            display: none;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/mycrowdboardsproper.css" rel="stylesheet" type="text/css" />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
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

            function openRadWindow(args) {

                var manager = $find("<%= RadWindowManager1.ClientID %>");
                if (args == null) {
                    var url = "rwValidateEmail.aspx";
                }
                else {
                    var url = "rwPostFromBoard.aspx?Name=" + args;
                }

                manager.open(url, "RadWindow1");
                return false;

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

            function anchotInvestClick(board) {
                window.location.replace("" + board + "?fromSearch=1#investDiv");
            }
            function anchotClick(board) {
                window.location.replace(board);
            }
        </script>
    </telerik:RadScriptBlock>
    <%-- <asp:scriptmanager runat="server" id="RadScriptManager1">--%>
    <scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </scripts>
    <%-- </asp:scriptmanager>--%>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <asp:UpdatePanel ID="boardUpdatePanel" runat="server">
        <ContentTemplate>
            <div class="main-body">
                <div class="title">
                    My Crowdboards
                </div>
                <div>
                    <asp:Label ID="lblMessageSetOne" runat="server"></asp:Label>
                    <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                </div>
                <div id="boardsDetailsDiv">
                    <asp:Repeater ID="surfBoardsRepeater" runat="server">
                        <ItemTemplate>
                            <asp:HiddenField runat="server" ID="hdnDirectoryName" Value='<%# Container.DataItem("DirectoryName")%>' />
                            <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("Seeking") %>' />
                            <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                            <asp:HiddenField ID="hdnBoardName" runat="server" Value='<%#Eval("BoardName") %>' />
                            <div class="size1of3">
                                <div class="crowdboard-container group">
                                    <div class="crowdboard-video">
                                        <a href='<%# Eval("DirectoryName","/{0}") %>'>
                                            <div id="coverPicWatchDiv" runat="server">
                                                <div class="play-button">
                                                    <asp:ImageButton ID="ibtnPlay1" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                        Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                        Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="crowdboard-profile-picture">
                                        <a href='<%#Eval("DirectoryName","{0}")%>' id="boardProfile">
                                            <img src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60) %>' /></a>
                                    </div>
                                    <div class="crowdboard-mini-console">
                                        <div class="crowdboard-measure">
                                            <asp:HyperLink ID="watchhyperLink4" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                Style="color: #788586;">
                                                <table border="1">
                                                    <tr valign="top">
                                                        <td style="width: 10%;">
                                                            <div style="margin-left: 3px; margin-bottom: 10px; margin-top: 3px;">
                                                                <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                    TrackPosition="TopLeft" MinimumValue="0" Orientation="Vertical" Height="96px"
                                                                    Style="margin-top: 0px;" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                    ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                    CssClass="thermometerSlider" BackColor="Transparent">
                                                                </telerik:RadSlider>
                                                                <%--  <div class="crowdboard-status-bar-position"></div> --%>
                                                            </div>
                                                        </td>
                                                        <td style="width: 90%;">
                                                            <div class="crowdboard-measure-text" style="margin-left: 4px;">
                                                                <div class="crowdboard-measure-level">
                                                                    Level</br><span><%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span></div>
                                                                <div class="crowdboard-measure-max-left">
                                                                    Max Left</br><span><%#GetAmount(Eval("Amountleft"),Eval("BankLocation"))%></span></div>
                                                                <div class="crowdboard-measure-boarders-in">
                                                                    Boarders In</br><span><%#Eval("BoarderInCount") %></span></div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--  <div class="crowdboard-status-bar"></div>--%>
                                            </asp:HyperLink>
                                        </div>
                                        <a href="#" onclick="anchotClick('<%# Eval("DirectoryName") %>');">
                                            <img src="WebContent/theme/images/comment.png" /><div class="comment-number">
                                                (<%#Eval("Comments") %>)</div>
                                        </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName") %>');">
                                            <img src="WebContent/theme/images/recommend.png" /><div class="recommend-number">
                                                (<%#Eval("RecommendCount") %>)</div>
                                        </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName") %>');">
                                            <img src="WebContent/theme/images/boost.png" /><div class="boost-number">
                                                (3)</div>
                                        </a><a href="#" onclick="anchotClick('<%# Eval("DirectoryName") %>');">
                                            <img src="WebContent/theme/images/watchwbg.png" /><div class="watch-number">
                                                (<%#Eval("Watches") %>)</div>
                                        </a>
                                        <input type="button" value="INVEST!" id="invest-button" disabled="disabled" style="cursor: default;" />
                                    </div>
                                    <asp:HyperLink ID="watchhyperLink1" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                        Style="color: #788586;">
                                        <div class="crowdboard-text">
                                            <div class="crowdboard-line-name">
                                                Name: <span>
                                                    <%#Eval("BoardName") %></span></div>
                                            <div class="crowdboard-line-location">
                                                Location: <span>
                                                    <%#Eval("Location") %></span></div>
                                            <div class="crowdboard-line-seeking">
                                                Seeking: <span>
                                                    <%#GetAmount(Eval("TotalOffer"),Eval("BankLocation"))%></span></div>
                                            <div class="crowdboard-line-DA">
                                                District: <span class="district-tag">
                                                    <%#Eval("District") %></span> Area: <span class="area-tag">
                                                        <%#Eval("AreaName") %></span></div>
                                            <asp:HyperLink ID="watchhyperLink3" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                Style="color: #788586;">    <div class="crowdboard-line-live-since">Live Since: <span><%#Eval("DateActivated") %></span></div>
            <div class="crowdboard-wrapper-description">Description:</br>
              <div class="crowdboard-description"><%#Eval("Description") %>
              </div>
            </div></asp:HyperLink>
                                        </div>
                                    </asp:HyperLink>
                                    <a href='<%# Eval("DirectoryName", "BoardDetails.aspx?Name={0}") %>'>
                                        <input type="button" value="Edit" id="edit-crowdboard-button" class="view-crowdboard-button" /></a>
                                    <a href='<%# Eval("DirectoryName", "CrowdBoardManagement.aspx?Name={0}") %>'>
                                        <input type="button" value="Manage" id="crowdboard-management-button" class="view-crowdboard-button" /></a>
                                    <%--           <a href='<%# Eval("DirectoryName", "UpdateBoarders.aspx?Name={0}") %>'><input type="button" value="Update" id="updateButton" class="view-crowdboard-button" /></a>--%>
                                    <asp:Button ID="btnCrowdNewsUpdate" runat="server" Text="CrowdNews Update" CssClass="view-crowdboard-button"
                                        CommandName="SetBoardPost" CommandArgument='<%# Container.DataItem("BoardID")%>'>
                                    </asp:Button>
                                    <div class="amount-invested">
                                        <span class="dollar-amount">
                                            <%#GetAmount(Eval("TotalInvested"),Eval("BankLocation"))%></span>Raised</div>
                                </div>
                                <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()  %>'>
                                    <div style="text-align: right;">
                                        <a id="popupBoxCloseYoutube1" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
                                            <img src="Images/delete.png" alt='Close' width='20' height='20' style="cursor: default;" /></a>
                                    </div>
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
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <script type="text/javascript">
            function unloadPopupBox(i) {
                $('#popup_box_' + i).fadeOut("slow");
                return false;
            }
            function loadPopupBox(i) {
                $('#popup_box_' + i).fadeIn("slow");
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="350px" Width="500px">
            </telerik:RadWindow>
            <telerik:RadWindow runat="server" ID="RadWindow2" Behaviors="Close" OnClientClose="OnClientClose"
                Height="650" Width="900px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div>
        <asp:SqlDataSource ID="sdAllBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.InvType,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,U.UserName,V.TotalOffer As Seeking,V.RaisedTotal,V.AmountRemaining as Amountleft,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.Investors,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,isnull(U.BankLocation,'US')as BankLocation,V.TotalOffer,V.Status,V.Offer,BS.English As StatusText,CAST(ROUND(isnull(V.RaisedTotal,0), 0) AS int) as TotalInvested,V.YoutubeVideoUrl,V.RecommendCount, (SELECT count(*) FROM (SELECT UserID from BoardInvestors where BoardID=V.BoardID AND AmountInvested is not null union  SELECT MemberID as UserID from BoardOwners WHERE BoardID=V.BoardID AND Status=1)M  ) as BoarderInCount   FROM vwBoardInfo V  INNER JOIN Users U ON v.UserID =U.UserID INNER JOIN BoardStatus BS ON V.Status=BS.Value WHERE V.UserID=@UserID">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="select BoardInvestedIn,crowdboards,PendingRequestCount,MessageCount from vwUserInfo where UserID=@userID">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="userID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInvestors" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT B.DirectoryName,B.BoardID,B.userID As OwnerID,BI.UserID As InvstorID,(SELECT UserName FROM Users where UserID=BI.UserID) As InvestorName,(SELECT levelName FROM BoardLevels where LevelID=BI.LevelID) As LevelName FROM boards B INNER JOIN BoardInvestors BI ON B.BoardID=BI.BoardID AND BI.AmountInvested IS NOT NULL WHERE B.BoardID=@BoardID">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInvestmentLevels" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT LevelID,LevelName,#OfInvestments,'$'+ convert(varchar(12),cast(LevelRaisedTotal as dec(5,0)),1) As LevelRaisedTotal FROM vwInvestmentLevels WHERE BoardID=@BoardID">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT V.BoardLevel,V.UserID,V.BoardID,V.Boardname,V.InvType,V.city,V.Country,V.ViewsCount,V.Description,V.Investors,V.Watches,V.Comments,'$'+ convert(varchar(12),cast(V.RaisedTotal as dec(10,0)),1) As RaisedTotal, V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.Keywords,V.AudienceDesc  ,V.UniquenessDesc,V.RevenueDesc,V.offer,V.TotalOffer,V.Tags,V.VisibilityType,V.Offer, CASE V.ViewsCount WHEN 0 THEN '0' ELSE CAST((V.Investors/V.ViewsCount)*100 As NVARCHAR(20))+'%' END AS ConversionRate, V.AboutMe,V.AreaID,V.areaName,V.District,V.YoutubeVideoUrl,(select COUNT(*) from boardlevels where BoardID =v.BoardID) as levelCount  FROM vwBoardInfo   V  Where V.BoardID=@BoardID"
            UpdateCommand="UPDATE Boards SET BoardName=@BoardName, Description=@Description, DirectoryName=@DirectoryName, InvType=@InvType,AreaID=@AreaID, Status=@Status,TotalOffer=@TotalOffer, city=@city,country=@country  WHERE BoardID=@BoardID">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
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
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdGetBoardIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT BoardId from Boards WHERE DirectoryName=@Name and UserID=@UserID">
            <SelectParameters>
                <asp:Parameter Name="Name" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoardInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Select BoardID,Boardname,Description,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Status  from vwBoardInfo where BoardID=@BoardID">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdComments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="spCommentGraph" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdViews" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="spViewsGraph" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdWatches" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="spWatchersGraph" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInvestments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="spInvestorsGraph" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoardLevelsGraph" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="sp_BoardLevelsGraph" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoardLevels" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            InsertCommand="INSERT INTO BoardLevels(BoardID,LevelName,Description,LevelAmount,NumOffered) VALUES(@BoardID,@LevelName,@Description,@LevelAmount,@NumOffered)"
            SelectCommand="SELECT LevelID,BoardID,LevelName,Description,LevelAmount,NumOffered FROM BoardLevels WHERE BoardID=@BoardID"
            DeleteCommand="DELETE FROM BoardLevels WHERE BoardID=@BoardID" UpdateCommand="UPDATE BoardLevels SET LevelName=@LevelName,Description=@Description,LevelAmount=@LevelAmount,NumOffered=@NumOffered where LevelID=@LevelID">
            <SelectParameters>
                <asp:Parameter Name="BoardID" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="LevelName" />
                <asp:Parameter Name="Description" />
                <asp:Parameter Name="LevelAmount" />
                <asp:Parameter Name="NumOffered" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="LevelID" />
                <asp:Parameter Name="LevelName" />
                <asp:Parameter Name="Description" />
                <asp:Parameter Name="LevelAmount" />
                <asp:Parameter Name="NumOffered" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="BoardID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdChangeBoardStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE Boards SET Status=@Status,DateActivated=GETDATE() WHERE BoardID=@BoardID"
            DeleteCommand="DELETE FROM BoardOwners WHERE BoardID=@BoardID AND Status=0 OR Status=2">
            <UpdateParameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Status" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="BoardID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdActivateBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE Boards SET Status=@Status,DateActivated=GETDATE() WHERE BoardID=@BoardID">
            <UpdateParameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Status" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdSubmitForApproval" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE Boards SET Status=4 WHERE BoardID=@BoardID">
            <UpdateParameters>
                <asp:Parameter Name="BoardID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdGetDistrictManagerEmail" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand=" SELECT U.Email FROM Users U  Left Join districts D  ON U.UserID=D.Manager INNER JOIN Areas A On D.districtID=A.districtID WHERE A.AreaID=@AreaID">
            <SelectParameters>
                <asp:Parameter Name="AreaID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT '0' as areaID,'--Select Area--' As AreaName UNION SELECT areaID,AreaName FROM Areas">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAreasLoad" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT A.areaID,A.AreaName,row_number()over(order by A.SortOrder) as rownumber,A.districtID,D.DistrictName FROM Areas A  INNER JOIN Districts D on D.districtID =A.districtID  where A.districtID=@districtID Order by A.SortOrder">
            <SelectParameters>
                <asp:Parameter Name="districtID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            SelectCommand="SELECT districtID,DistrictName,row_number()over(order by D.SortOrder) as rownumber FROM Districts D  Order by D.DistrictName">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInvestmentType" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT Value,EnglishName FROM InvestmentType"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInvestmentLevelsAmount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT '--Select Amount--' as FundAmountText,0 as FundAmount,0 as indexs union SELECT '$ '+ CONVERT(varchar(50),FundAmount) as FundAmountText,FundAmount,1 as indexs from InvestmentLevels order by FundAmount">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdSaveExtraDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE Boards SET Tags=@Tags,Offer=@Offer,YoutubeVideoUrl=@YoutubeVideoUrl,VisibilityType=@VisibilityType WHERE BoardID=@BoardID">
            <UpdateParameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Tags" />
                <asp:Parameter Name="Offer" />
                <asp:Parameter Name="YoutubeVideoUrl" />
                <asp:Parameter Name="VisibilityType" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdGetAreaID" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT areaID from Areas WHERE AreaName=@AreaName">
            <SelectParameters>
                <asp:Parameter Name="AreaName" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBalancedOwnerDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT * from BalancedUserRecord WHERE UserId=@UserId">
            <SelectParameters>
                <asp:Parameter Name="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBalancedUserAccountInsert" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            InsertCommand="INSERT INTO BalancedUserRecord(UserID,UserAccountUri,UserBankAccountUri,DateCreated,CustomerID) VALUES(@UserID,@UserAccountUri,@UserBankAccountUri,GETDATE(),@CustomerID)"
            UpdateCommand="UPDATE BalancedUserRecord SET UserBankAccountUri=@UserBankAccountUri where UserID=@UserID">
            <InsertParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="UserAccountUri" />
                <asp:Parameter Name="UserBankAccountUri" />
                <asp:Parameter Name="CustomerID" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="UserBankAccountUri" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
