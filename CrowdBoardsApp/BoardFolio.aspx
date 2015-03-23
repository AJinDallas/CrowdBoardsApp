<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BoardFolio.aspx.vb" Inherits="CrowdBoardsApp.BoardFolio"
    MasterPageFile="~/MasterPage/Site.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
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
    </style>
    <style type="text/css">
          .thermometer
        {
            width: 100%;
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
         .RadSlider_Vista .rslItem, .RadSlider_Vista .rslLargeTick span
        {
            color: #ffffff;
        }
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
        }
     </style>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="WebContent/Theme/styles/boardfolio.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">
    <div class="container">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <div class="first-row">
                    <span>My Boardfolio
                        <asp:LinkButton ID="lbtnBoardfolio" runat="server" Text="Boardfolio">
                        </asp:LinkButton>
                        <asp:LinkButton ID="lbtnWatchList" runat="server" Text="Watch List">
                        </asp:LinkButton>
                          <asp:LinkButton ID="lbtnReferal" runat="server" Text="Referrals">
                        </asp:LinkButton>
                        </span>
                </div>
                <div class="main-body">
                    <telerik:RadMultiPage ID="radMultiPageBoardFolio" runat="server" SelectedIndex="0">
                        <telerik:RadPageView ID="rpvBoardfolio" runat="server" Selected="true">
                            <div class="boardfolio-overview">
                                Total Boards In:<span><asp:Label ID="lblTotalBoardsIn" runat="server"></asp:Label></span>In
                                For:<span><asp:Label ID="lblInFor" runat="server"></asp:Label></span>
                            </div>
                            <asp:DataList ID="boardsInvestedDataList" runat="server" DataSourceID="sdInvestments"
                                RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Table" CellPadding="15"
                                CellSpacing="15" Width="100%" Style="table-layout: fixed;">
                                <ItemTemplate>
                                    <div class="crowdboard-container group">
                                        <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("TotalOffer") %>' />
                                        <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                        <asp:HiddenField ID="hdnVisibilityType" runat="server" Value='<%#Eval("VisibilityType") %>' />
                                        <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                        <asp:HyperLink ID="dd" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>' />
                                        <div class="crowdboard-video">
                                            <div id="covPicLineup" runat="server">
                                                <div class="play-button">
                                                    <asp:ImageButton ID="ibtnPlay1" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                        Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                        Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="crowdboard-profile-picture">
                                            <a href="<%# Eval("DirectoryName","/{0}") %>">
                                                <img src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60,"thumbnail","thumbs") %>' /></a>
                                        </div>
                                        <div class="crowdboard-mini-console">
                                            <div class="crowdboard-measure">
                                                <%-- <div class="crowdboard-status-bar">
                                </div>--%>
                                                <table>
                                                    <tr valign="top">
                                                        <td>
                                                            <div style="margin-top: 0px; margin-left: 3px; margin-bottom: 5px;">
                                                                <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                    TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                                                                    Height="90px" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                    ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                    CssClass="thermometerSlider" BackColor="Transparent">
                                                                </telerik:RadSlider>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="crowdboard-measure-text" style="margin-left: 5px; margin-top: 5px;">
                                                                <div class="crowdboard-measure-level">
                                                                    Level</br><span><%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span></div>
                                                                <div class="crowdboard-measure-max-left">
                                                                    Max Left</br><span><%#GetAmount(Eval("AmountRemaining"),Eval("BankLocation")) %></span></div>
                                                                <div class="crowdboard-measure-boarders-in">
                                                                    Boarders In</br><span><%#Eval("Investors") %></span></div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                <img src="WebContent/Theme/images/comment.png" /><div class="comment-number">
                                                    (<%#Eval("Comments") %>)</div>
                                            </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                <img src="WebContent/Theme/images/recommend.png" /><div class="recommend-number">
                                                    (<%#Eval("RecommendCount") %>)</div>
                                            </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                <img src="WebContent/Theme/images/boost.png" /><div class="boost-number">
                                                    (3)</div>
                                            </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                <img src="WebContent/Theme/images/watchwbg.png" /><div class="watch-number">
                                                    (<%#Eval("Watches") %>)</div>
                                            </a>
                                            <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" />
                                        </div>
                                        <div class="crowdboard-text">
                                            <asp:HyperLink ID="watchhyperLink2" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                Style="color: #788586;">
                                                <div class="crowdboard-line-name">
                                                    <asp:Label ID="lblPublic" runat="server" Text="Public"></asp:Label>
                                                    <span>/</span>
                                                    <asp:Label ID="lblPrivate" runat="server" Text="Private"></asp:Label>
                                                </div>
                                                <div class="crowdboard-line-name">
                                                    Name: <span>
                                                        <%#Eval("BoardName") %></span></div>
                                                <div class="crowdboard-line-location">
                                                    Location: <span>
                                                        <%#Eval("Location") %></span></div>
                                                <div class="crowdboard-line-seeking">
                                                    Seeking: <span>
                                                        <%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %></span></div>
                                                <div class="crowdboard-line-DA">
                                                    District: <span class="district-tag"><a href='Search.aspx?District=<%#Eval("District") %>'
                                                        style="color: #75b4c6;">
                                                        <%#Eval("District") %></a></span> Area: <span class="area-tag"><a href='Search.aspx?Area=<%#Eval("AreaName") %>'>
                                                            <%#Eval("AreaName") %></a></span></div>
                                                <div class="crowdboard-line-live-since">
                                                    Live Since: <span>
                                                        <%#Eval("DateActivated") %></span></div>
                                                <div class="crowdboard-wrapper-description">
                                                    <asp:HyperLink ID="watchhyperLink3" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                        Style="color: #788586;"> 
                                Description:</br>
                                <div class="crowdboard-description">
                                    <%#Eval("Description") %>
                                </div>
                                                    </asp:HyperLink>
                                                </div>
                                            </asp:HyperLink>
                                        </div>
                                        <a href="<%# Eval("DirectoryName","/{0}") %>">
                                            <input type="button" value="View CrowdBoard" id="view-crowdboard-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" /></a>
                                        <a href='<%# Eval("DirectoryName","/InsiderNews.aspx?Name={0}") %>'>
                                            <input id="insider-news-button" type="button" value="Insider News" class="view-crowdboard-button" />
                                        </a><a href='<%# Eval("DirectoryName","/InsiderDetails.aspx?Name={0}") %>'>
                                            <input id="insiderdetails" type="button" value="Insider Details" class="view-crowdboard-button" />
                                        </a>
                                        <div class="amount-invested" style="text-align:center;">
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
                                </ItemTemplate>
                            </asp:DataList>
                        </telerik:RadPageView>
                        <telerik:RadPageView ID="rpvWatchList" runat="server">
                            <div class="boardfolio-overview">
                                Total Boards:<span><asp:Label ID="watchListCountLabel" runat="server"></asp:Label></span>
                            </div>
                            <div style="border-top-color: #99CCFF; border-top-style: solid; border-top-width: 1;">
                                <div style="margin-top: 15px; margin-left: 15px;">
                                    <asp:DataList ID="boardsWatchingDataList" runat="server" DataSourceID="sdBoardsWatching"
                                        RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Table" CellPadding="15"
                                        CellSpacing="15" Width="100%" Style="table-layout: fixed;">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnMaxValue" runat="server" Value='<%#Eval("TotalOffer") %>' />
                                            <asp:HiddenField ID="hdnValue" runat="server" Value='<%#Eval("RaisedTotal") %>' />
                                            <asp:HiddenField ID="hdnPrivateWatch" runat="server" Value='<%#Eval("PrivateWatch") %>' />
                                            <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%#Eval("DirectoryName") %>' />
                                            <asp:HyperLink ID="watchhyperLink" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'>
                                                <div class="crowdboard-container group">
                                                    <div class="crowdboard-video">
                                                        <div id="coverPicWatchDiv" runat="server">
                                                            <div class="play-button">
                                                                <asp:ImageButton ID="ibtnPlay" ImageUrl="~/WebContent/images/playbutton.png" runat="server"
                                                                    Height="50px" Width="50px" OnClientClick='<%# "return loadPopupBox("+ Eval("BoardID").ToString() + ");" %>'
                                                                    Visible='<%# IIf(IsDBNull(Eval("YoutubeVideoUrl")),false,true) %>' />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="crowdboard-profile-picture">
                                                        <a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                            <img src='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),65,60,"thumbnail","thumbs") %>' /></a>
                                                    </div>
                                                    <div class="crowdboard-mini-console">
                                                        <div class="crowdboard-measure">
                                                            <table>
                                                                <tr valign="top">
                                                                    <td>
                                                                        <div class="thermometer" style="margin-left: 3px;">
                                                                            <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                                                                                TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                                                                                Height="90px" Width="100%" ShowDragHandle="false" ShowDecreaseHandle="false"
                                                                                ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                                                                                CssClass="thermometerSlider" BackColor="Transparent">
                                                                            </telerik:RadSlider>
                                                                            <%--<div class="crowdboard-status-bar"></div>--%>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <%-- <div class="crowdboard-status-bar-position"></div>--%>
                                                                        <div class="crowdboard-measure-text" style="margin-left: 5px; margin-top: 5px;">
                                                                            <div class="crowdboard-measure-level">
                                                                                Level</br><span><%#IIf(Eval("BoardLevel")="Not Calculated","1", Eval("BoardLevel"))%></span></div>
                                                                            <div class="crowdboard-measure-max-left">
                                                                                Max Left</br><span><%#GetAmount(Eval("AmountRemaining"),Eval("BankLocation")) %></span></div>
                                                                            <div class="crowdboard-measure-boarders-in">
                                                                                Boarders In</br><span><%#Eval("Investors") %></span></div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                            <img src="WebContent/theme/images/comment.png" /><div class="comment-number">
                                                                (<%#Eval("Comments") %>)</div>
                                                        </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                            <img src="WebContent/theme/images/recommend.png" /><div class="recommend-number">
                                                                (<%#Eval("RecommendCount") %>)</div>
                                                        </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                            <img src="WebContent/theme/images/boost.png" /><div class="boost-number">
                                                                (3)</div>
                                                        </a><a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                            <img src="WebContent/theme/images/watchwbg.png" /><div class="watch-number">
                                                                (<%#Eval("Watches") %>)</div>
                                                        </a>
                                                        <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick('<%# Eval("DirectoryName","{0}") %>')" />
                                                    </div>
                                                    <div class="crowdboard-text">
                                                        <asp:HyperLink ID="watchhyperLink1" runat="server" NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>'
                                                            Style="color: #788586;">
                                                            <div class="crowdboard-line-name">
                                                                <asp:Label ID="lblPublic" runat="server" Text="Public"></asp:Label><span class="contentWhitelarge">/</span>
                                                                <asp:Label ID="lblPrivate" runat="server" Text="Private"></asp:Label>
                                                            </div>
                                                            <div class="crowdboard-line-name">
                                                                Name: <span>
                                                                    <%#Eval("BoardName") %></span></div>
                                                            <div class="crowdboard-line-location">
                                                                Location: <span>
                                                                    <%#Eval("Location") %></span></div>
                                                            <div class="crowdboard-line-seeking">
                                                                Seeking: <span>
                                                                    <%#GetAmount(Eval("TotalOffer"),Eval("BankLocation")) %></span></div>
                                                            <div class="crowdboard-line-DA">
                                                                District: <span class="district-tag"><a href='Search.aspx?District=<%#Eval("District") %>'
                                                                    style="color: #75b4c6;">
                                                                    <%#Eval("District") %></a></span> Area: <span class="area-tag"><a href='Search.aspx?Area=<%#Eval("AreaName") %>'>
                                                                        <%#Eval("AreaName") %></a></span></div>
                                                            <div class="crowdboard-line-live-since">
                                                                Live Since: <span>
                                                                    <%#Eval("DateActivated") %></span></div>
                                                            <div class="crowdboard-wrapper-description">
                                                                Description:</br>
                                                                <div class="crowdboard-description">
                                                                    <%#Eval("Description") %>
                                                                </div>
                                                            </div>
                                                        </asp:HyperLink>
                                                    </div>
                                                    <a href='<%# Eval("DirectoryName","/{0}") %>'>
                                                        <input type="button" value="View CrowdBoard" id="Button2" class="view-crowdboard-button" /></a>
                                                </div>
                                                <div class="popup_box" id='<%#"popup_box_" +Eval("BoardID").ToString()%>'>
                                                    <div style="text-align: right;">
                                                        <a id="popupBoxCloseYoutube" onclick='<%# "return unloadPopupBox("+ Eval("BoardID").ToString() + ");" %>'>
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
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView ID="rpvReferral" runat="server">
                            <span class="span1">Get paid when people you refer sign up and invest! Share a crowdboard link
                                with your friends</span>
                                <div style="margin-left:25px;">
                            <table width="50%" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMessageSendEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Select Board to send CrowdBoard link
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />                                        

                                        <asp:DropDownList ID="ddlCrowdboardlink" runat="server"  Width="250px" height="30px" onchange = "SetReferralUrl();" 
                                          >
                                        </asp:DropDownList>
                                        <br />
                                        <br />
                                       <span style="margin-bottom:15px;">Referral URL Link </span><br /><br />
                                        <asp:Label id="urlTextLabel" runat="server" style="color: #3c6c79;"></asp:Label>                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <span style="font-style: oblique;">copy and paste email list</span><br />
                                        <asp:TextBox ID="txtSendMultipleEmail" runat="server" TextMode="multiline" Width="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <asp:Button ID="btnSendEmail" runat="server" class="invest-button" style="width:100px; margin:5; padding:5px;" Text="Send"  />
                                    </td>
                                </tr>
                            </table>
                            <div style="margin-top: 15px;">
                                <div id="boardersDiv">
                                                <asp:datalist id="boardersDataList" runat="server" datasourceid="sdReferalBoarders" repeatcolumns="8"
                                                    repeatdirection="Horizontal" repeatlayout="Table">
                                                    <itemtemplate>
                                                        <a href='<%# Eval("UserName", IIf(Convert.ToString(Eval("UserName"))= Convert.ToString(Session("userName")), "Profile.aspx", "Profile.aspx?User={0}")) %>'>
                                                            <div class="other-boarder-image">
                                                                <div style="width: 100%; height: 85%; padding: 5px;">
                                                                    <div id="firendDiv" runat="server">
                                                                    </div>
                                                                </div>
                                                                <span class="other-boarder-name" >
                                                                    <%# Container.DataItem("UserName")%></span>
                                                            </div>
                                                             <asp:HiddenField ID="hdnFriend" runat="server" Value='<%# Container.DataItem("UserName")%>' />
                                                        </a>                                                       
                                                    </itemtemplate>
                                                </asp:datalist>
                                            </div>
                            </div>
                            </div>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
                function unloadPopupBox(i) {
                    $('#popup_box_' + i).fadeOut("slow");
                    return false;
                }
                function loadPopupBox(i) {
                    $('#popup_box_' + i).fadeIn("slow");
                    return false;
                }
                function anchotInvestClick(board) {
                    window.location.replace("" + board + "?BoardFolio=1#investDiv");
                }

                function SetReferralUrl() {
                    var userID = '<%=Session("UserID") %>'
                    var locationAddress = document.getElementById('BodyContent_ddlCrowdboardlink').value
                    var urlTextLabel = document.getElementById("BodyContent_urlTextLabel");
                    if (locationAddress == '0') {
                        urlTextLabel.innerHTML = '<%= ConfigurationManager.AppSettings("site").ToString() %>/Default.aspx?from=' + userID;
                    }
                    else {
                        urlTextLabel.innerHTML = '<%= ConfigurationManager.AppSettings("site").ToString() %>/' + locationAddress + '?from=' + userID;
                    }
                }
            </script>
        </telerik:RadScriptBlock>
    </div>
    <asp:SqlDataSource ID="sdInvestments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,BI.UserID as InvestorID,V.YoutubeVideoUrl,V.Investors,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.invType,V.Watches,V.Comments,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,case when V.BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(V.RaisedTotal as dec(10,0)),1) As RaisedTotalText,V.RaisedTotal,V.TotalOffer,V.NoOfBoardLevels,V.Offer,V.AmountRemaining ,V.VisibilityType,V.OwnerType,V.BankLocation,V.RecommendCount,CAST(ROUND(isnull(V.RaisedTotal,0), 0) AS int) as TotalInvested FROM vwBoardInfo V INNER JOIN BoardInvestors BI ON V.BoardID =BI.BoardID AND BI.DateInvested IS NOT NULL WHERE BI.UserID=@UserID ORDER BY BI.DateInvested">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardsWatching" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT  CONVERT(VARCHAR(11),V.DateActivated,106) as DateActivated,V.YoutubeVideoUrl,V.BoardLevel,V.UserID,V.BoardID,V.Boardname,BI.UserID as InvestorID,V.Investors,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...'  ELSE Description END AS Description,V.District,V.AreaName,V.invType,V.Watches,V.Comments,V.RecommendCount,V.DirectoryName,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,case when V.BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(V.RaisedTotal as dec(10,0)),1) As RaisedTotalText,V.RaisedTotal,V.NoOfBoardLevels,V.TotalOffer,V.Offer,V.AmountRemaining,V.VisibilityType,V.OwnerType,(SELECT isnull(PrivateWatch,0) from BoardInvestors where BoardID=BI.BoardID and UserID=@userID and BI.WatchDate IS NOT NULL) as PrivateWatch,V.BankLocation FROM vwBoardInfo V INNER JOIN BoardInvestors BI ON V.BoardID =BI.BoardID  WHERE BI.UserID=@UserID AND BI.WatchDate IS NOT NULL AND BI.DateInvested IS NULL ORDER BY BI.WatchDate">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdInvestmentDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Isnull(U.BankLocation,'US') as BankLocation,Count(*) TotalBoards,convert(varchar(12),cast(SUM(BI.AmountInvested) as dec(10,0)),1) As InFor FROM BoardInvestors BI INNER JOIN Boards B ON BI.BoardID=B.BoardID INNER JOIN Users U ON B.UserID=U.UserID WHERE BI.userID=@UserID AND BI.AmountInvested IS Not Null group by U.BankLocation">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:sqldatasource id="sdAllActiveBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select * from boards where UserID=@userID and Status=1 order by DirectoryName asc">
        <selectparameters>
            <asp:SessionParameter Name="userID" SessionField="userID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdReferalBoarders" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select * from Users where ReferalUserID=@ReferalUserID and Status=1">
        <selectparameters>
                <asp:SessionParameter Name="ReferalUserID" SessionField="UserID" />
            </selectparameters>
    </asp:sqldatasource>

    <script src="WebContent/theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/theme/scripts/main.js" type="text/javascript"></script>
</asp:Content>
