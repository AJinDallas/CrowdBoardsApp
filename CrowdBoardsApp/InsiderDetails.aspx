<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InsiderDetails.aspx.vb"
    MasterPageFile="~/MasterPage/Site.Master" Inherits="CrowdBoardsApp.InsiderDetails" %>

<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <title>Insider Details</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/insider.css" rel="stylesheet" type="text/css" />
    <%-- <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .size1of3
        {
            float: left;
            width: 33%;
        }
    </style>
    <style type="text/css">
          .thermometer
        {
            width:20px;
            height: 100px;           
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
     </style>
    <style type="text/css">
        .btn
        {
            background-color: #ffffff;
            border: medium none;
            color: #75b4c6;
            cursor: pointer;
            display: block;
            font-size: 16px !important;
            font-weight: 600;
            height: 31px;
            margin-left: auto;
            margin-right: auto;
            width: 100%;
        }
        .btn:hover
        {
            background-color: #3c6c79;
            border: 1px solid #fff;
            color: #fff;
        }
        
        .second-row
        {
            clear: both;
            padding-top: 24px;
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
            height: auto;
            overflow: inherit;
            width: 100%;
        }
        
        .inputbox
        {
            color: #788586;
            font-size: 18px;
            line-height: 2em;
            margin-bottom: 6px;
            padding-left: 5px;
            width: 100%;
        }
        .atext
        {
            color: #75b4c6;
            font-size: 14px;
            font-weight: 400;
            margin-left: 16px;
        }
    </style>
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <%--<asp:ScriptManager runat="server" ID="RadScriptManager1">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </asp:ScriptManager>--%>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function WithdrawInvestment() {
                alert("I'm sorry.  Your funds cannot be withdrawn at this time.");
                return false;
            }
        </script>
    </telerik:RadScriptBlock>
    <asp:updatepanel id="userUpdatePanel" runat="server">
        <contenttemplate>
            <div class="container">
                <div class="main-body" style="height: auto;">
                    <div class="title">
                        <a href="BoardFolio.aspx">Back to Bordfolio</a>
                        <%-- <asp:Label runat="server" ID="lblCrowdboardName"></asp:Label>
                         &nbsp;--%><asp:HyperLink
                            ID="boardNameLink" runat="server" Font-Size="34px"></asp:HyperLink></span>
                        <asp:Label ID="lblmessage" runat="server" style="font-size:12px;"></asp:Label></div>
                    <div class="navigational-links">
                     <asp:LinkButton id="lbtInsiderNews" runat="server" Text="Insider News"></asp:LinkButton>
                      <asp:LinkButton id="lbtInsiderDetails" runat="server" Text="Insider Details"></asp:LinkButton>
                       
                        </div>
                    <div class="details-container">
                        <div class="first-row">
                            <div class="left-column">
                                <div>
                                    Level Bought:<span class="level-bought"><asp:Label ID="lblLevelBought" runat="server"></asp:Label></span><asp:LinkButton
                                        ID="lbtnChangeLevelBought" runat="server" Text="Change"></asp:LinkButton></div>
                                <div id="boardLevelDiv" runat="server" visible="false">
                                    <table width="100%" border="0">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="rcbBoardLevels" runat="server" DataTextField="DataTextField"
                                                    DataValueField="LevelID">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="boardLevelsRequiredFieldValidator" runat="server"
                                                    ErrorMessage="Select" ControlToValidate="rcbBoardLevels" ForeColor="Red" ValidationGroup="BoardLevels"
                                                    Display="Dynamic" InitialValue="--Select Level--">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnInvest" runat="server" Text="Invest" CssClass="primaryMiniButton"
                                                    ValidationGroup="BoardLevels" />
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryMiniButton" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div>
                                    Purchased For:<span class="purchased-for"><asp:Label ID="lblPurchasedFor" runat="server"></asp:Label></span></div>
                                <div>
                                    Date Purchased:<span class="date-purchased"><asp:Label ID="lblDatePurchased" runat="server"></asp:Label></span></div>
                                <div>
                                    Reward:<span class="reward"><asp:Label ID="lblReward" runat="server"></asp:Label></span><a
                                        href="">Change</a></div>
                                <div>
                                    Your Investment Rating:<span class="reward">
                                        <asp:Label ID="lblInvestmentRating" runat="server" style="font-size:12px;"></asp:Label></span>
                                    <telerik:RadTextBox ID="txtRating" runat="server" 
                                        Width="20%" Visible="false">
                                    </telerik:RadTextBox>&nbsp;&nbsp<asp:LinkButton ID="lbtnChangerating" runat="server"
                                        Text="Change"></asp:LinkButton>
                                    <asp:LinkButton ID="lbtnSaveRating" runat="server" Text="Save" Visible="false" ValidationGroup="ratingGroup"></asp:LinkButton>
                                    <asp:Label ID="lblMessageRating" runat="server"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ratingRequiredFieldValidator" runat="server" ErrorMessage="Enter Rating"
                                        ControlToValidate="txtRating" ForeColor="Red" ValidationGroup="ratingGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RangeValidator ID="ratingRangeValidator" runat="server" ErrorMessage="Enter between 1 and 10 Numeric Only"
                                        ControlToValidate="txtRating" ForeColor="Red" MaximumValue="10" MinimumValue="1"
                                        Type="Double" ValidationGroup="ratingGroup" Display="Dynamic"></asp:RangeValidator></div>
                            </div>
                            <div class="right-column">
                                <div>
                                    CrowdBoard Raised:<span class="crowdboard-raised"><asp:Label ID="lblCrowdBoardRaised"
                                        runat="server"></asp:Label></span></div>
                                <div>
                                    CrowdBoard Funded:<span class="crowdboard-funded"><asp:Label ID="lblCrowdBoardFullyFunded"
                                        runat="server"></asp:Label></span></div>
                                <div>
                                    Amount Invested:<span class="amount-invested"><asp:Label ID="lblAmountInvested" runat="server"></asp:Label></span></div>
                            </div>
                        </div>
                        <div class="second-row">
                            <div class="left-column">
                                <div class="title">
                                    Your Shipping Information<br />
                                    <asp:Label ID="lblMessageShippingInfo" runat="server"></asp:Label></div>
                                <div>
                                    <telerik:RadTextBox ID="txtStreetAddress" runat="server" placeholder="Street Address"
                                        Width="300px" Height="35" ReadOnly="true">
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="StreetAddressRequiredFieldValidator" runat="server"
                                        ErrorMessage="Enter Street Address" ControlToValidate="txtStreetAddress" ForeColor="Red"
                                        ValidationGroup="ShippingInfo" Display="Dynamic">*</asp:RequiredFieldValidator>
                                </div>
                                <br />
                                <div>
                                    <telerik:RadTextBox ID="txtCity" runat="server" placeholder="City" Width="300px"
                                        Height="35" ReadOnly="true">
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="cityRequiredFieldValidator" runat="server" ErrorMessage="Enter City"
                                        ControlToValidate="txtCity" ForeColor="Red" ValidationGroup="ShippingInfo" Display="Dynamic">*</asp:RequiredFieldValidator></div>
                                <br />
                                <div class="final-row">
                                    <telerik:RadTextBox ID="txtZipOrPostCode" runat="server" placeholder="Post Code"
                                        Width="195px" Height="35" ReadOnly="true">
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="zipOrPostCodeRequiredFieldValidator" runat="server"
                                        ErrorMessage="Enter Zip/Post Code" ControlToValidate="txtZipOrPostCode" ForeColor="Red"
                                        ValidationGroup="ShippingInfo" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    <asp:LinkButton ID="lbtnSaveShippingInfo" runat="server" ValidationGroup="ShippingInfo" CssClass="button"
                                        Enabled="false">Save</asp:LinkButton>
                                    <asp:LinkButton ID="lbtnChangeShippingInfo" CssClass="button" runat="server">Change</asp:LinkButton>
                                </div>
                                <br />
                                <div class="title">
                                    Boarder Notes &nbsp;
                                    <asp:Label ID="lblMessageBoarderNotes" runat="server"></asp:Label></div>
                                <div style="width: 650px;">
                                    <telerik:RadTextBox ID="txtBoarderNotes" runat="server" TextMode="MultiLine" Rows="7"
                                        Width="500px" Height="135" ReadOnly="true">
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="boarderNotesRequiredFieldValidator" runat="server"
                                        ErrorMessage="Enter Notes" ControlToValidate="txtBoarderNotes" ForeColor="Red"
                                        ValidationGroup="BoarderNotes" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:LinkButton ID="lbtnSaveBoarderNotes" runat="server" CssClass="button" ValidationGroup="BoarderNotes"
                                        Enabled="false">Save</asp:LinkButton>
                                    <asp:LinkButton ID="lbtnChangeBoarderNotes" runat="server" CssClass="button">Change</asp:LinkButton>
                                </div>
                            </div>
                            <div class="right-column">
                                <asp:Button ID="btnWidthrawInvestment" runat="server" Text="Withdraw Investment"
                                    Style="font-size: 16px; padding: 8px 18px 12px;" CssClass="button" OnClientClick="return WithdrawInvestment()" />
                            </div>
                        </div>
                    </div>
                    <div class="right-crowdboard-container">
                        <div class="crowdboard-container group">
                            <div class="crowdboard-video">
                              <div id="covPicLineup" runat ="server">
                                <a href="">
                                   <%-- <img src="WebContent/images/crowdboardvideopreview.png" />--%>
                                    <div class="play-button">
                                        <img src="../WebContent/images/playbutton.png" /></div>
                                </a>
                                </div>
                            </div>
                            <div class="crowdboard-profile-picture">
                                <a href="#">
                                    <img id="imgBoard" runat="server" /></a>
                            </div>
                            <div class="crowdboard-mini-console">
                                <div class="crowdboard-measure">
                                    <table>
                                        <tr valign="top">
                                            <td>
                                                <div style="margin-top: 0px; margin-left: 3px; margin-bottom: 5px;">
                                                    <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="Tick"
                                                        TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                                                        Height="94px" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                        ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                        CssClass="thermometerSlider" BackColor="Transparent">
                                                    </telerik:RadSlider>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="crowdboard-measure-text" style="margin-left: 5px; margin-top: 5px;">
                                                    <div class="crowdboard-measure-level">
                                                        Level</br><span><asp:Label ID="lblBoardLevel" runat="server"></asp:Label></span></div>
                                                    <div class="crowdboard-measure-max-left">
                                                        Max Left</br><span><asp:Label ID="lblAmountLeft" runat="server"></asp:Label></span></div>
                                                    <div class="crowdboard-measure-boarders-in">
                                                        Boarders In</br><span>
                                                            <asp:Label ID="lblBoardersInBoard" runat="server"></asp:Label></span></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <a href="">
                                    <img src="../WebContent/images/comment.png" /><div class="comment-number">
                                        <asp:Label ID="lblCommentsBoard" runat="server"></asp:Label></div>
                                </a><a href="">
                                    <img src="../WebContent/images/recommend.png" /><div class="recommend-number">
                                        (0)</div>
                                </a><a href="">
                                    <img src="../WebContent/images/boost.png" /><div class="boost-number">
                                        (0)</div>
                                </a><a href="">
                                    <img src="../WebContent/images/watchwbg.png" /><div class="watch-number">
                                        <asp:Label ID="lblWatchesBoard" runat="server"></asp:Label></div>
                                </a>
                                <input type="button" value="INVEST!" id="invest-button" />
                            </div>
                            <div class="crowdboard-text">
                                <div class="crowdboard-line-name">
                                    Name: <span>
                                        <asp:Label ID="lblCrowdBoard" runat="server"></asp:Label></span></div>
                                <div class="crowdboard-line-location">
                                    Location: <span>
                                        <asp:Label ID="lblLocation" runat="server"></asp:Label></span></div>
                                <div class="crowdboard-line-seeking">
                                    Seeking: <span>
                                        <asp:Label ID="lblSeeking" runat="server"></asp:Label></span></div>
                                <div class="crowdboard-line-DA">
                                    District: <span class="district-tag"><a href="">
                                        <asp:Label ID="lblDistrict" runat="server"></asp:Label></a></span> Area: <span class="area-tag">
                                            <a href="">
                                                <asp:Label ID="lblArea" runat="server"></asp:Label></a></span></div>
                                <div class="crowdboard-line-live-since">
                                    Live Since: <span>
                                        <asp:Label ID="lblLiveSince" runat="server"></asp:Label></span></div>
                                <div class="crowdboard-wrapper-description">
                                    Description:</br>
                                    <div class="crowdboard-description">
                                        <asp:Label ID="lblDescription" Font-Bold="false" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <asp:Button ID="viewbutton" class="view-crowdboard-button" Text="View CrowdBoard"
                                runat="Server"></asp:Button></a>
                        </div>
                    </div>
                    <br />
                    <div class="main-body">
                        <div class="left-column">
                            <div class="title" style="font-size: 22px; font-weight: 600; margin-bottom: 8px;">
                                <h2>
                                    CrowdBoard Posts</h2>
                            </div>
                        </div>
                        <asp:Repeater ID="recentActivityOnBoardRepeater" runat="server" DataSourceID="sdBoardComments">
                            <ItemTemplate>
                                <div class="crowdnews-post" style="width: 31.5%;">
                                    <div class="posted-material">
                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("CommneterName", IIf(Convert.ToString(Eval("CommneterName"))= Convert.ToString(Session("CommneterName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                            <asp:Image ID="Image1" runat="server" ToolTip='<%# Container.DataItem("CommneterName")%>'
                                                ImageUrl='<%# isAvail(Eval("CommneterName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                        <div class="poster-options">
                                            <a class="comment-img" href="#">
                                                <img src="WebContent/Theme/images/comment.png">
                                                <div class="comment-number">
                                                    (1)</div>
                                            </a><a class="recommend-img" href="#">
                                                <img src="/WebContent/Theme/images/recommend.png">
                                                <div class="recommend-number">
                                                    (2)</div>
                                            </a>
                                        </div>
                                        <div class="poster-name">
                                            <%# Container.DataItem("CommneterName")%>
                                            says:</div>
                                        <div class="poster-comment">
                                            <%# Container.DataItem("Text")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </contenttemplate>
    </asp:updatepanel>
    <asp:sqldatasource id="sdBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select CONVERT(VARCHAR(11),DateActivated,106) as DateActivated,BoardID,status,Boardname,District,AreaName,status,UserID,CASE WHEN LEN(Description) >145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,Watches,Comments,Investors,city,state,country,isnull(city,'')+','+ISNULL(State,'') as Location,InvestmentTypeID,case when BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(isnull(RaisedTotal,0) as dec(10,0)),1) As RaisedTotalText,RaisedTotal,TotalOffer,NoOfBoardLevels,Offer,AmountRemaining,AboutMe,InvType,InvTypeDescription,BoardLevel,BankLocation from vwBoardInfo  Where directoryName=@DirectoryName">
        <selectparameters>
            <asp:Parameter Name="DirectoryName" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvestmentDetails" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BI.LevelID,BI.AmountInvested,case when ISNUll(U.BankLocation,'US')='US' then '$' else '£' end + convert(varchar(12),cast(BI.AmountInvested as dec(10,0)),1) As AmountInvestedText,BI.Rating,BI.BoarderNotes,BI.DateInvested FROM BoardInvestors BI INNER JOIN Boards B ON BI.BoardID=B.BoardID INNER JOIN Users U ON B.UserID=U.UserID WHERE BI.BoardID=@BoardID AND BI.UserID=@UserID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoardLevels" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT '0' as LevelID,'--Select Level--' as DataTextField UNION SELECT Main.LevelID,convert(varchar(12),Main.LevelNumber) +' - ' + case when main.BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(Main.LevelAmount as dec(10,0)),1) As DataTextField From (SELECT ROW_NUMBER() OVER(ORDER BY LevelAmount) AS LevelNumber,BL.LevelID,BL.BoardID,BL.LevelAmount,isnull(U.BankLocation,'US') as  BankLocation FROM BoardLevels BL INNER JOIN Boards B ON BL.BoardID=B.BoardID INNER JOIN Users U ON B.UserID=U.UserID  WHERE BL.BoardID=@BoardID )Main WHERE Main.LevelNumber>@LevelNumber">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="LevelNumber" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdInvstmentLevelDetail" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT Main.LevelNumber,Main.LevelID,Main.LevelAmount,(SELECT MAX(LevelAmount) from BoardLevels WHERE BoardID=Main.BoardID) AS MaxLevelAmount From (SELECT ROW_NUMBER() OVER(ORDER BY LevelAmount) AS LevelNumber,LevelID,BoardID,LevelAmount FROM BoardLevels WHERE BoardID=@BoardID )Main WHERE Main.LevelID=@LevelID">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="LevelID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoardComments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT TOP 5 BC.BoardID,TEXT,BC.CommentDate,BC.UserID,(SELECT Username FROM Users WHERE userid=BC.userID) AS CommneterName FROM Boardcomments BC WHERE BC.BoardID=@BoardID ORDER BY BC.CommentDate DESC">
        <selectparameters>
            <asp:Parameter Name="BoardID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetBoardIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT BoardId FROM Boards WHERE DirectoryName=@Name">
        <selectparameters>
            <asp:Parameter Name="Name" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdShippingInformation" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT Address,City,State,Zip from users Where userid=@Userid"
        updatecommand="UPDATE Users SET Address=@Address,City=@City,zip=@Zip WHERE UserID=@UserID">
        <selectparameters>
            <asp:Parameter Name="Userid" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="Address" />
            <asp:Parameter Name="City" />
            <asp:Parameter Name="zip" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdRating" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE BoardInvestors SET Rating=@Rating WHERE LevelID=@LevelID AND UserID=@UserID AND BoardID=@BoardID">
        <updateparameters>
            <asp:Parameter Name="Userid" />
            <asp:Parameter Name="Rating" />
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="LevelID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdBoarderNotes" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE BoardInvestors SET BoarderNotes=@BoarderNotes WHERE LevelID=@LevelID AND UserID=@UserID AND BoardID=@BoardID">
        <updateparameters>
            <asp:Parameter Name="Userid" />
            <asp:Parameter Name="BoarderNotes" />
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="LevelID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUpdateInvestment" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT * from BoardLevels where LevelID=@NewLevelID" updatecommand="UPDATE boardInvestors SET AmountInvested=@AmountInvested,LevelID=@NewLevelID,DateInvested=GETDATE(),WatchDate=GETDATE() where UserID=@UserID AND BoardID=@BoardID AND LevelID=@OldLevelID">
        <selectparameters>
            <asp:Parameter Name="NewLevelID" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="AmountInvested" />
            <asp:Parameter Name="NewLevelID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="OldLevelID" />
        </updateparameters>
    </asp:sqldatasource>
    <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>
</asp:content>
