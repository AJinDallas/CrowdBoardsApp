<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Board.aspx.vb" Inherits="CrowdBoardsApp.Board"
    MasterPageFile="~/MasterPage/Site.Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<asp:content id="HeadContent" contentplaceholderid="HeadContent" runat="Server">
    <%-- <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%--   <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
    <%-- <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <style type="text/css">
        
        .itemAllNewsFull
        {
            width: 15%;
        }
        .itemAllNewsFull.w2
        {
            width: 50%;
        }
        
     .thermometer
        {
            width: 20%;
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
         .RadSlider_Vista .rslItem, .RadSlider_Vista .rslLargeTick span
        {
            color: #ffffff;
        }
        .RadSlider .rslItem, .RadSlider .rslLargeTick span
        {
            width: 40px !important;
        }
        .popup_box_all
        {
            display: none; /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 250px;
            width: 500px;
          
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
        
         .size1of2
        {
            float: left;
            width: 50%;
        }
         .size1of3
        {
            float: left;
            width: 50%;            
        }
        
      @media screen and (min-width: 0px) and (max-width: 960px) {
       #miniBoardDiv { display:none ; }      
      
}

   
    </style>
    <script type="text/javascript">

        function anchotInvestClick() {
            document.getElementById('anchotInvest').click();
        }
        function ClickRecommend() {
            document.getElementById('BodyContent_lbtnRecommend').click();
        }  

        
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link href="styles/style.css" rel="stylesheet" type="text/css" />
    <!-- new css -->
    <link href="WebContent/Theme/styles/crowdboard.css" rel="stylesheet" type="text/css" />
    <link href="WebContent/Theme/styles/investmentlevel.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="WebContent/Theme/styles/popup.css" />
</asp:content>
<asp:content id="BodyContent" contentplaceholderid="BodyContent" runat="Server">
    <div style="z-index: 199; margin-top: 48px; position: fixed; width: 375px;">
        <nav id="menu-wrap" onclick="hideShow();">
        <ul id="menu" >
            <li><a href="#moreInfoDiv">More Information</a></li>
            <li><a href="#BodyContent_mediaLinksDiv">Media Links</a></li>
            <li><a href="#BodyContent_fileDiv">Info Pack</a></li>
            <li><a href="#performanceChartsDiv">Performance Charts</a></li>
            <li><a href="#BodyContent_crowdBoardTeamDiv">CrowdBoard Team</a></li>
            <li> <a href="#investDiv" id="a1">Investment Levels</a></li>
            <li> <a href="#CWRDiv">Comments/Watches/Recommends</a></li>	
        </ul>
        </nav>
    </div>
    <asp:hiddenfield id="hdnGoback" runat="server" />
    <asp:hiddenfield id="hdnScrollType" runat="server" />
      <asp:hiddenfield id="hdnBoardName" runat="server" />
    <!--        First Row            -->
    <div class="container" id="first-row" style="height: 150px">
        <div class="crowdboard-banner">
            <div class="crowdboard-banner-picture">
                <%-- src="WebContent/Theme/images/profilebanner.jpeg"--%>
                <asp:image id="coverPicDiv" runat="server">
                </asp:image>
            </div>
            <div class="crowdboard-profile-picture">
                <img id="imgOwnedBy" runat="server" src="thumbnail/noimage.jpg" /></div>
            <div class="crowdboard-profile-name-tag">
                <span class="crowdboard-profile-name">
                    <asp:label id="boardNameLabel" runat="server"></asp:label>
                    &nbsp;&nbsp;&nbsp;
                    <label>
                        Created By:</label>
                    <asp:hyperlink id="boardOwnerHyperLink" runat="server" style="text-align: right;
                        color: #72B2C7; font-family: helvitica;">
                    </asp:hyperlink>
                </span>
            </div>
        </div>
    </div>
    <!--        Main Body            -->
    <div class="container" id="mainDiv" runat="server">
        <!--        floating navigation            -->
        <!-- thermometer -->
        <%-- <div class="main-body">--%>
        <div style="background-color: White; width: 29%; float: right; height: 30px; right: 5px;
            margin-top: 5px;">
            <center>
                <asp:label id="messageLabel" runat="server" visible="false" style="text-align: center;
                    margin: 5px; font-size: 16px;"></asp:label>
            </center>
        </div>
        <div class="floating-column fixedElement" style="right: 12px; margin-top: 15px; width: 29%;
            z-index: 200;" id="miniBoardDiv">
            <div class="floating-first-row">
                <span class="previous">
                    <asp:linkbutton id="btnPreviousBoard" runat="server" text="Previous">
                    </asp:linkbutton>
                </span><span class="middle">District:<span class="district-tag"><asp:hyperlink id="hyperlinkDistrict"
                    runat="server" forecolor="#99CCFF"></asp:hyperlink></span> Area:<span class="area-tag"><asp:hyperlink
                        id="areaHyperLink" runat="server" text="" forecolor="#99CCFF"></asp:hyperlink></span></span>
                <span class="next">
                    <asp:linkbutton id="btnNextBoard" runat="server" text="Next">
                    </asp:linkbutton></span>
            </div>
            <div class="crowdboard-mini-console" style="border: 1 solid red;">
                <div class="crowdboard-measure" style="width: 79%;">
                    <div style="float: left; margin: 35px 0px 0px 30px">
                        <telerik:RadSlider Skin="Metro" ID="ThermometerSlider" runat="server" ItemType="item"
                            DataSourceID="sdBoardInfo" MinimumValue="0" Orientation="Vertical" Height="150px"
                            TrackPosition="TopLeft" Width="15px" ShowDragHandle="false" ShowDecreaseHandle="false"
                            ShowIncreaseHandle="false" IsDirectionReversed="true" Enabled="false" CssClass="thermometerSlider"
                            BackColor="Transparent">
                        </telerik:RadSlider>
                    </div>
                    <div class="crowdboard-measure-text" style="float: left; margin-left: 12px;">
                        <div class="crowdboard-measure-level">
                            Level<br />
                            <span>
                                <asp:label id="lblBoardLevel" runat="server"></asp:label></span></div>
                        <div class="crowdboard-measure-max-left">
                            Amount Left<br />
                            <span>
                                <asp:label id="lblAmountLeft" runat="server"></asp:label></span></div>
                        <div class="crowdboard-measure-boarders-in">
                            Boarders In<br />
                            <span>
                                <asp:label id="lblBoardersIn" runat="server"></asp:label></span></div>
                    </div>
                </div>
                <div class="crowdboard-comment" style="width: 20%;">
                    <a href="">
                        <asp:linkbutton id="lbtnComment" runat="server" forecolor="#99CCFF" text="Comment"
                            onclientclick="return loadPopupBoardComment();">
                            <img src="WebContent/images/comment.png" style="width: 80%;" /></asp:linkbutton>
                        <div class="comment-number">
                            Comment
                            <asp:label id="lblCommentsBottom" runat="server" text="" forecolor="#ececee"></asp:label></div>
                    </a>
                </div>
                <div class="crowdboard-recommend" style="width: 20%;">
                    <img src="WebContent/images/recommend.png" onclick="return ClickRecommend();" style="cursor: pointer;
                        width: 80%;" />
                    <div class="recommend-number">
                        <asp:linkbutton id="lbtnRecommend" forecolor="#FFFFFF" runat="server" onclientclick="return Loadlogin();">
                        </asp:linkbutton><asp:label id="lblRecommendsCount" runat="server" forecolor="#ececee"></asp:label>
                    </div>
                </div>
                <div class="crowdboard-boost" style="width: 20%;">
                    <asp:linkbutton id="lbtnBoost" runat="server" forecolor="#99CCFF" text="Boost" onclientclick="return loadPopupBoost();">
                        <img src="WebContent/images/boost.png" style="width: 80%;" /></asp:linkbutton>
                    <div class="boost-number">
                        boost 0</div>
                </div>
                <div class="crowdboard-watch" style="width: 20%;">
                    <%-- <a href="#" onclick="return openRadWindow();">
                                <img src="WebContent/images/watchwbg.png" alt=""/>
                            </a>--%>
                    <div id="divImageWatch" runat="server">
                        <a href="#" onclick="return openRadWindow();">
                            <img src="WebContent/images/watchwbg.png" alt="" style="width: 80%;" />
                        </a>
                    </div>
                    <div id="divImageStopWatch" runat="server">
                        <a href="#" onclick="return clickStopWatchingButton();">
                            <img src="WebContent/images/watchwbg.png" alt="" style="width: 80%;" />
                        </a>
                    </div>
                    <div class="watch-number">
                        <asp:linkbutton id="btnWatch" runat="server" forecolor="#FFFFFF" text="Watch" onclientclick="return openRadWindow();">
                        </asp:linkbutton>
                        <asp:linkbutton id="btnStopWatching" runat="server" text="Stop Watching" forecolor="#FFFFFF">
                        </asp:linkbutton>
                        <asp:label id="lblWatches" runat="server" text="" forecolor="#ececee"></asp:label>
                        <asp:label id="lblWatchesBottom" runat="server" text="" forecolor="#ececee" visible="false">
                        </asp:label>
                    </div>
                </div>
                <input type="button" value="INVEST!" id="invest-button" onclick="anchotInvestClick();" />
            </div>
            <div class="floating-last-box">
                <span>What would you like to see?</span>
                <div>
                    <a href="#moreInfoDiv">More Information</a></div>
                <div id="mediaLinksTr" runat="server">
                    <a href="#BodyContent_mediaLinksDiv">Media Links</a></div>
                <div id="filesUploadedTr" runat="server">
                    <a href="#BodyContent_fileDiv">Info Pack</a></div>
                <div>
                    <a href="#performanceChartsDiv">Performance Charts</a></div>
                <div id="crowdBoardTeamLinkTr" runat="server">
                    <a href="#BodyContent_crowdBoardTeamDiv">CrowdBoard Team</a></div>
                <div>
                    <a href="#BodyContent_boardersInDiv">Boarders In</a></div>
                <div>
                    <a href="#investDiv" id="anchotInvest">Investment Levels</a></div>
                <div>
                    <a href="#CWRDiv">Comments/Watches/Recommends</a></div>
            </div>
        </div>
        <%-- </div>--%>
        <!-- end thermometer -->
        <!--        core content     -->
        <div class="main-body">
            <div class="main-column">
                <!--        video content            -->
                <div class="crowdboard-video" id="playDiv" runat="server">
                    <div class="crowdboard-play-button">
                        <div style="padding: 5px;">
                            <telerik:RadMediaPlayer ID="RadMediaPlayer1" runat="server" Width="100%" StartVolume="80"
                                Height="424px">
                            </telerik:RadMediaPlayer>
                        </div>
                    </div>
                </div>
                <!--        introductory content            -->
                <div class="introductory-box content-box">
                    <div class="intro-first-row">
                        <span class="left">CrowdBoard Type:<span class="crowdboard-priced"><asp:label id="lblCrowdBoardType"
                            runat="server" text=""></asp:label></span></span> <span class="middle">Seeking:<span
                                class="crowdboard-priced"><asp:label id="lblSeeking" runat="server" text=""></asp:label></span></span>
                        <span class="right">Priced from:<span class="crowdboard-priced"><asp:label id="lblPricedFrom"
                            runat="server" text=""></asp:label></span></span>
                    </div>
                    <div class="intro-second-row">
                        Description:<span><asp:label id="lblDescription" runat="server" text=""></asp:label></span>
                    </div>
                </div>
            </div>
        </div>
        <!--        more information content            -->
        <div class="main-body" id="moreInfoDiv">
            <div class="main-column">
                <div class="title">
                    More Information
                </div>
                <div class="more-information-box content-box">
                    <div class="sub-heading">
                        <%-- Get Involved in the Guards Museum Today!--%></div>
                    <div class="more-information-content">
                        <asp:label id="moreInfoLabel" runat="server"></asp:label>
                    </div>
                </div>
            </div>
        </div>
        <!--        media links content         Could stand to be refractored   -->
        <div id="mediaLinksDiv" runat="server">
            <div class="main-body">
                <div class="main-column">
                    <div class="title">
                        Media Links</div>
                    <div class="media-links-box content-box">
                        <asp:datalist id="mediaLinksDataList" runat="server" repeatdirection="Horizontal"
                            repeatlayout="Table" repeatcolumns="4" datasourceid="sdBoardMediaLinks" width="100%">
                            <itemtemplate>
                                <asp:HyperLink ID="hlMediaLink" runat="server" ForeColor="#99CCFF" Text='<%#Eval("Name") %>'
                                    NavigateUrl='<%#Eval("Url") %>' Target="_blank"></asp:HyperLink>
                            </itemtemplate>
                        </asp:datalist>
                    </div>
                </div>
            </div>
        </div>
        <!--        info pack content      Could stand to be refractored      -->
        <div id="fileDiv" runat="server">
            <div class="main-body">
                <div class="main-column">
                    <div class="title">
                        Info Pack</div>
                    <div class="info-pack-box content-box">
                        <asp:datalist id="filesUploadedDataList" runat="server" repeatdirection="Horizontal"
                            repeatlayout="Table" repeatcolumns="4" datasourceid="sdFilesUploaded" width="100%">
                            <itemtemplate>
                                <asp:LinkButton ID="lbtnFileShow" ToolTip="Download" runat="server" Text='<%#Eval("FileName") %>'
                                    ForeColor="#99CCFF" CommandName="Download" CommandArgument='<%# Eval("FilePath")%>'
                                    OnClientClick="return Loadlogin();"></asp:LinkButton>
                            </itemtemplate>
                        </asp:datalist>
                    </div>
                </div>
            </div>
        </div>
        <!--        performance charts content            -->
        <div class="main-body">
            <div class="main-column">
                <div class="title" id="performanceChartsDiv">
                    Performance Charts</div>
                <div class="performance-charts-box content-box">
                    <div class="sub-heading">
                        Performance Chart 1</div>
                    <div>
                        <telerik:RadChart ID="RadChart1" runat="server" AutoLayout="True" Skin="DeepGray"
                            DefaultType="Line" Height="400px" Width="600px">
                            <PlotArea>
                                <XAxis AutoScale="False">
                                    <AxisLabel TextBlock-Text="Days" Visible="false">
                                        <TextBlock Text="Days">
                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="51, 51, 51">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </XAxis>
                                <YAxis AutoScale="False" MinValue="0" Step="100">
                                    <AxisLabel TextBlock-Text="Amount Raised" Visible="true">
                                        <TextBlock Text="Amount Raised">
                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="51, 51, 51">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </YAxis>
                                <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                    <FillStyle MainColor="51, 51, 51" FillType="Solid">
                                    </FillStyle>
                                    <Border Color="62, 62, 62"></Border>
                                </Appearance>
                            </PlotArea>
                            <ChartTitle TextBlock-Text="Amount raised">
                            </ChartTitle>
                            <Series>
                                <telerik:ChartSeries DataYColumn="InvestAmount" Name="Series 1" Type="Line">
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
                                        <PointMark Visible="false" Border-Width="10" Border-Color="DarkKhaki" FillStyle-FillSettings-HatchStyle="BackwardDiagonal">
                                            <Border Color="DarkKhaki" Width="10"></Border>
                                        </PointMark>
                                        <Border Color="187, 149, 58" />
                                    </Appearance>
                                </telerik:ChartSeries>
                            </Series>
                            <Legend Visible="false">
                                <Appearance Visible="False" Position-AlignedPosition="BottomRight" Dimensions-Margins="1px, 2%, 9%, 1px">
                                    <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                    </ItemTextAppearance>
                                    <FillStyle MainColor="Transparent">
                                    </FillStyle>
                                    <Border Color="Transparent"></Border>
                                </Appearance>
                            </Legend>
                        </telerik:RadChart>
                    </div>
                    <div class="sub-heading">
                        Performance Chart 2</div>
                    <div>
                        <telerik:RadChart ID="RadChart2" runat="server" AutoLayout="True" Skin="DeepGray"
                            Height="350px" Width="400px" DefaultType="Bar">
                            <PlotArea>
                                <XAxis AutoScale="False" MaxValue="10" MinValue="1" Step="1" MaxItemsCount="10">
                                    <AxisLabel TextBlock-Text="Levels" Visible="true">
                                        <TextBlock Text="Levels">
                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="Black">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </XAxis>
                                <YAxis AutoScale="False" MinValue="0" Step="100">
                                    <AxisLabel TextBlock-Text="Amount Needed" Visible="true">
                                        <TextBlock Text="Amount Needed">
                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="Black">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </YAxis>
                                <Appearance Dimensions-Margins="18%, 100px, 12%, 8%">
                                    <FillStyle MainColor="51, 51, 51" FillType="Solid">
                                    </FillStyle>
                                    <Border Color="62, 62, 62"></Border>
                                </Appearance>
                            </PlotArea>
                            <ChartTitle TextBlock-Text="Level reached">
                            </ChartTitle>
                            <Series>
                                <telerik:ChartSeries Name="Series 1" Type="Bar" DataYColumn="AmountNeeded" DataXColumn="number">
                                    <Items>
                                        <telerik:ChartSeriesItem YValue="10">
                                        </telerik:ChartSeriesItem>
                                        <telerik:ChartSeriesItem YValue="15">
                                        </telerik:ChartSeriesItem>
                                        <telerik:ChartSeriesItem YValue="50">
                                        </telerik:ChartSeriesItem>
                                        <telerik:ChartSeriesItem YValue="25">
                                        </telerik:ChartSeriesItem>
                                    </Items>
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
                                        <PointMark Visible="True" Border-Width="10" Border-Color="DarkKhaki" FillStyle-FillSettings-HatchStyle="BackwardDiagonal">
                                            <Border Color="DarkKhaki" Width="10"></Border>
                                        </PointMark>
                                        <Border Color="187, 149, 58" />
                                    </Appearance>
                                </telerik:ChartSeries>
                            </Series>
                            <Legend Visible="false">
                                <Appearance Visible="False" Position-AlignedPosition="BottomRight" Dimensions-Margins="1px, 2%, 9%, 1px">
                                    <ItemTextAppearance TextProperties-Color="159, 159, 159" TextProperties-Font="Arial, 10pt">
                                    </ItemTextAppearance>
                                    <FillStyle MainColor="Transparent">
                                    </FillStyle>
                                    <Border Color="Transparent"></Border>
                                </Appearance>
                            </Legend>
                        </telerik:RadChart>
                    </div>
                </div>
            </div>
        </div>
        <!--        Crown Board Team charts content            -->
        <div id="crowdBoardTeamDiv" runat="server">
            <div class="main-body">
                <div class="main-column">
                    <div class="title">
                        CrowdBoard Team</div>
                    <div class="performance-charts-box content-box">
                        <asp:repeater id="crowdBoardTeamRepeater" runat="server" datasourceid="sdCrowdBoardTeam">
                            <itemtemplate>
                                <div class="crowdboard-team-member" style="min-width: 50px; min-height: 150px;">
                                    <div class="team-member-image">
                                        <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("username", "~/Profile.aspx?User={0}") %>'
                                            onclick="return Loadlogin();">
                                            <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("username")%>'
                                                ImageUrl='<%# isAvail(Eval("username", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                        <div class="boarder-name-container">
                                            <div class="boarder-name" style="font-size: 14px;">
                                                <%# Container.DataItem("FirstName")%>&nbsp;<%# Container.DataItem("LastName")%>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <%-- <span class="team-member-name" style="word-wrap: break-word;">
                                        <%# Container.DataItem("FirstName")%>&nbsp;<%# Container.DataItem("LastName")%></span>
                                    <br />
                                    <%# Container.DataItem("Description")%>--%>
                                </div>
                            </itemtemplate>
                        </asp:repeater>
                    </div>
                </div>
            </div>
        </div>
        <!--        boarders in content            -->
        <div id="boardersInDiv" runat="server">
            <div class="main-body">
                <div class="main-column">
                    <div class="title">
                        Boarders In</div>
                    <div class="boarders-in-box content-box">
                        <div id="containerCrowdNewsFull" style="width: 100%;">
                            <asp:datalist id="boardInvestedDataList" runat="server" repeatdirection="Horizontal"
                                repeatcolumns="2" repeatlayout="Table">
                                <itemtemplate>
                                    <div class="itemAllNewsFull">
                                        <div style="width: 360px;">
                                            <div class="boarder-lineup" style="width: 315px; margin-left: 5px; margin-right: 0px;">
                                                <div class="boarder-lineup-image">
                                                    <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("userName", "~/Profile.aspx?User={0}") %>'
                                                        onclick="return Loadlogin();">
                                                        <asp:Image ID="boarderPic" runat="server" ToolTip='<%# Container.DataItem("userName")%>'
                                                            ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink><br />
                                                    <div class="boarder-name-container">
                                                        <div class="boarder-name" style="font-size: 14px; color: White;">
                                                            <%# Eval("userName") %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="lineup-content">
                                                    <div class="boarder-location">
                                                        Activity: <span>
                                                            <%# Container.DataItem("userName")%>
                                                            &nbsp; has just invested in &nbsp;
                                                            <%# Eval("BoardName") %></span>
                                                    </div>
                                                    <div class="boarder-profession">
                                                        Date: <span>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Convert.ToDateTime (Eval("ActivityDate")).ToString("MM/dd/yyyy") %>'
                                                                CssClass="LabelBrownSmall"></asp:Label></span>
                                                    </div>
                                                    <%--
                                    <div class="add-boarder">
                                        <input id="add-boarder-button" type="button" value="Add Boarder">
                                    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </itemtemplate>
                            </asp:datalist>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--        investment levels content            -->
        <div class="main-body">
            <div class="main-column">
                <div class="title">
                    Investment</div>
                <div class="investment-levels-box content-box" id="investDiv">
                    <asp:repeater id="boardLevelsRepeater" runat="server" datasourceid="sdBoardLevels">
                        <itemtemplate>
                            <div class="level-container">
                                <div class="level-core-content">
                                    <div class="level-name">
                                        <asp:Label ID="lblInvType" runat="server" Text='<%# IIf(IsDBNull (Eval("InvestmentType")),Eval("LevelName"),Eval("InvestmentType")+ " " +Convert.ToString(Eval("Row"))+" : "+Eval("LevelName")) %>'></asp:Label></div>
                                    <div class="level-description">
                                        <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description") %>'></asp:Label></div>
                                </div>
                                <div class="level-action-area">
                                    <div class="level-price">
                                        <asp:Label ID="lblLevelAmount" runat="server" Text='<%#GetAmount(Eval("LevelAmount"),Eval("BankLocation")) %>'></asp:Label>
                                    </div>
                                    <a href="payment.html">
                                        <div class="level-invest">
                                            <asp:Button ID="lbtnInvest" runat="server" CssClass="invest-button" Text="Invest!"
                                                Style="height: 30px; font-size: 25px !important;" CommandName="IInvest" CommandArgument='<%# Eval("LevelName") %>' />
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </itemtemplate>
                    </asp:repeater>
                </div>
            </div>
        </div>
        <!--        comments/watches/recommends content            -->
        <!-- new -->
        <div class="main-body">
            <div class="main-column">
                <div class="title">
                    Comments/Watches/Recommends</div>
                <div class="cwr-box content-box" id="CWRDiv">
                    <asp:hiddenfield id="boardIDHiddenField" runat="server" />
                    <div class="newsfeed-message standard-newsfeed">
                        <asp:datalist id="WCRDataList" runat="server" repeatdirection="Vertical" repeatlayout="Table"
                            repeatcolumns="3">
                            <itemtemplate>
                                <div class="size1of3">
                                    <itemtemplate>
                                                <div class="newsfeed-message standard-newsfeed">
                                                    <div class="newsfeed-comment">
                                                        <div class="newsfeed-image">
                                                            <asp:hyperlink id="HyperLink2" runat="server" navigateurl='<%# Eval("userName",   "~/Profile.aspx?User={0}") %>'
                                                                onclick="return Loadlogin();">
                                                                <asp:image id="Image2" runat="server" tooltip='<%# Container.DataItem("userName")%>'
                                                                    imageurl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' />
                                                            </asp:hyperlink></div>
                                                        <div class="message-attribution">
                                                            <span class="boarder-message-name">
                                                                <%# Container.DataItem("userName")%></span></div>
                                                         <%# Eval("ResultType")%> <span class="district-tag"><a href='#'>
                                                            <%# Eval("BoardName") %></a>
                                                            <br />
                                                            <%#Eval("Text") %>
                                                            <br />
                                                            <asp:label id="Label3" runat="server" text='<%# Convert.ToDateTime (Eval("ActivityDate")).ToString("MM/dd/yyyy") %>'>
                                                            </asp:label>
                                                        </span>
                                                    </div>
                                                </div>
                                            </itemtemplate>
                                </div>
                            </itemtemplate>
                        </asp:datalist>
                    </div>
                </div>
                <!-- end new -->
            </div>
        </div>
    </div>
    <script src="WebContent/Theme/jQuery/jquery.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/navbar.js" type="text/javascript"></script>
    <script src="WebContent/Theme/scripts/crowdboard.js" type="text/javascript"></script>
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>
    <%-- <script src='<%=ResolveClientUrl( "~/js/jquery-1.7.2.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/jquery-1.4.1-vsdoc.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/jquery-1.4.1.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl( "~/js/masonry.pkgd.min.js")%>' type="text/javascript"></script>--%>
    <%-- <script src="js/masonry.pkgd.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        /* Mobile */


        var boardName = document.getElementById("BodyContent_hdnBoardName").value;

        $('#menu-wrap').prepend('<div id="menu-trigger" style="color:#72B2C7;">' + boardName + '</div>');
        $("#menu-trigger").on("click", function () {
            $("#menu").slideToggle();
        });
        // iPad
        var isiPad = navigator.userAgent.match(/iPad/i) != null;
        if (isiPad) $('#menu ul').addClass('no-transition');
    </script>
    <script type="text/javascript">
        function hideShow() {
            $("#menu").slideToggle();
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            // loadNew();
        });
        function loadNew() {
            var $container = $('#containerCrowdNewsFull');

            $container.masonry({
                columnWidth: 320,
                itemSelector: '.itemAllNewsFull'
            });
        }     

    </script>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <%--  <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="rgComments" LoadingPanelID="RadAjaxLoadingPanel2">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>--%>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <%--  <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgRecommend" LoadingPanelID="RadAjaxLoadingPanel1">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>--%>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <%-- <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgWatches" LoadingPanelID="RadAjaxLoadingPanel3">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>--%>
            </telerik:AjaxSetting>
        </AjaxSettings>
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
                else if (arg != null) {
                    window.location = arg;
                }
            }
            function openLoginRadWindow() {
                var dirName = '<%=directoryName %>'
                var manager = $find("<%= RadWindowManager1.ClientID %>");
                var url = "rwWrongPassword.aspx?page=Board&dirName=" + dirName;
                manager.open(url, "loginRadWindow");
                return false;

            }

            function GoBack() {
                alert("This board is no longer active");
                //                window.location = document.getElementById("hdnGoback").value;
                history.go(-1);
            }

            function loadPopupBoxVideo() {    // To Load the Popupbox
                $('#popup_box_Video').fadeIn("slow");
                return false;
            }

            function unloadPopupBoxVideo() {    // TO Unload the Popupbox

                $('#popup_box_Video').fadeOut("slow");
                return false;
            }

            function loadPopupBoardComment() {    // To Load the Popupbox

                if ('<%=Session("UserID") %>' == '') {
                    openLoginRadWindow();
                }
                else {
                    $('#boardCommentDiv').fadeIn("slow");
                }

                return false;
            }

            function unloadPopupBoardComment() {    // TO Unload the Popupbox

                $('#boardCommentDiv').fadeOut("slow");
                return false;
            }

            function Loadlogin() {
                if ('<%=Session("UserID") %>' == '') {
                    openLoginRadWindow();
                    return false;
                }
                else {
                    return true;
                }
            }

            function CheckLogin() {

                if ('<%=Session("UserID") %>' == '') {
                    alert('shoab');

                    window.location.replace("InvestSignup.aspx?name=" + '<%=directoryName %>');

                }
                else {
                    return true;
                }
            }


            function loadPopupBoost() {    // To Load the Popupbox
                if ('<%=Session("UserID") %>' == '') {
                    openLoginRadWindow();
                }
                else {
                    $('#popupBoxBoost').fadeIn("slow");
                }

                return false;
            }

            function unloadPopupBoost() {    // TO Unload the Popupbox

                $('#popupBoxBoost').fadeOut("slow");
                return false;
            }

            function validateCommentEntry() {
                var commentText = document.getElementById("<%= txtComment.ClientID %>").value;
                var valid = 1;
                if ($.trim(commentText).length == 0) {
                    // alert("called");
                    document.getElementById("lblErrorMessage").innerHTML = "Please Enter Text";
                    valid = 0;
                }

                if (valid == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function validateBoostEntry() {
                var boostText = document.getElementById("<%= txtBoostContent.ClientID %>").value;
                var valid = 1;
                if ($.trim(boostText).length == 0) {
                    // alert("called");
                    document.getElementById("lblErrorBoost").innerHTML = "Please Enter Text";
                    valid = 0;
                }

                if (valid == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function openRadWindow() {
                var directoryName = '<%=directoryName %>';
                var fromSeacrhPage = '<%=fromSearchPage %>';
                var url;
                var manager = $find("<%= RadWindowManager1.ClientID %>");
                if (fromSeacrhPage == "1") {
                    url = "rwWatch.aspx?Name=" + directoryName + "&fromSearch=1"
                }
                else {
                    url = "rwWatch.aspx?Name=" + directoryName;
                }
                manager.open(url, "RadWindow2");
                return false;

            }

            function clickStopWatchingButton() {
                var btn = document.getElementById('<%=btnStopWatching.ClientID%>');
                btn.click();
            }
        </script>
    </telerik:RadScriptBlock>
    <div id='popupBoxBoost' class="popup_box_all">
        <table width="100%">
            <tr>
                <td style="text-align: right;">
                    <asp:linkbutton id="lbtnCloseBoostPopup" forecolor="Red" runat="server" onclientclick="return unloadPopupBoost();">
                        <img src="Images/btncross.png" alt="X" /></asp:linkbutton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:label id="Label1" runat="server" font-bold="true">Select where to Boost</asp:label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:label id="lblSuccessBoost" runat="server" cssclass="LabelGreenLarge"></asp:label>
                    <asp:label id="lblErrorBoost" runat="server" cssclass="LabelheadingRed"></asp:label>
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
                    <telerik:RadTextBox ID="txtBoostContent" runat="server" TextMode="MultiLine" Rows="5"
                        Width="350px">
                    </telerik:RadTextBox>
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
                    <asp:imagebutton id="btnFacebookShare" commandname="IBoostOnFacebook" alternatetext="login"
                        imageurl="~/Images/fb_share.jpg" runat="server" height="25px" width="120px" onclientclick="return validateBoostEntry();">
                    </asp:imagebutton>&nbsp;<asp:imagebutton id="btnTwitterShare" commandname="IBoostOnTwitter"
                        alternatetext="login" imageurl="~/Images/twitter_share.jpg" runat="server" height="25px"
                        onclientclick="return validateBoostEntry();" width="120px"></asp:imagebutton>&nbsp;
                    <script src="http://platform.linkedin.com/in.js" type="text/javascript"></script>
                    <script type="IN/Share"></script>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div class="popup_box_all" id="boardCommentDiv">
        <div style="text-align: right;">
            <asp:linkbutton id="lbtnCloseBoardComments" forecolor="Red" runat="server" onclientclick="return unloadPopupBoardComment();">
                <img src="Images/btncross.png" style="height: 20px; width: 20px;" /></asp:linkbutton></div>
        <div>
            <table width="100%" cellpadding="5" cellspacing="5">
                <tr>
                    <td colspan="2" align="center">
                        <asp:label id="lblSuccessMessage" runat="server" cssclass="LabelGreenLarge"></asp:label>
                        <asp:label id="lblErrorMessage" runat="server" cssclass="LabelheadingRed"></asp:label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <table width="100%" cellpadding="5px;" cellspacing="5">
                                <tr>
                                    <td>
                                        <asp:label runat="server" font-bold="true">Enter Comment</asp:label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <telerik:RadTextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5"
                                            Width="350px">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="two-buttons" style="padding: 5px;">
                                            <asp:button id="btnOk" runat="server" text="Ok" cssclass="email-button" onclientclick="return validateCommentEntry();">
                                            </asp:button>
                                            <asp:button id="btnCancel" runat="server" text="Cancel" cssclass="email-button" onclientclick="return unloadPopupBoardComment();">
                                            </asp:button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
        Height="350px" Width="500px">
    </telerik:RadWindow>
    <div>
        <asp:sqldatasource id="sdBoardsList" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.InvestmentTypeID,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer As Seeking, V.Offer,V.BoardLevel   FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1)  Order By CASE WHEN WatchDate >= dateinvestedDate and WatchDate >= FirstViewDate THEN WatchDate  WHEN dateinvestedDate >= WatchDate and dateinvestedDate >= FirstViewDate THEN dateinvestedDate else FirstViewDate  END DESC">
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardsByArea" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT V.UserID,V.BoardID,V.Boardname,U.UserName,CASE WHEN LEN(Description) > 145 THEN substring(Description,0,145) + '...' ELSE Description END AS Description,V.Keywords,CASE WHEN LEN(AudienceDesc) > 125 THEN SUBSTRING(AudienceDesc,0,122) + '...'   ELSE V.AudienceDesc END AS AudienceDesc,CASE WHEN LEN(UniquenessDesc) > 125 THEN SUBSTRING(UniquenessDesc,0,122) + '...'   ELSE V.UniquenessDesc END AS UniquenessDesc,CASE WHEN LEN(RevenueDesc) > 125 THEN SUBSTRING(RevenueDesc,0,122) + '...'    ELSE V.RevenueDesc END AS RevenueDesc,V.Watches,V.Comments,V.Investors,V.District,V.RecentComment,V.CommenterUserID,V.DirectoryName,V.InvestmentTypeID,ISNULL(V.city,'')+' '+ISNULL (V.state,'') as Location,V.TotalOffer As Seeking, V.Offer,V.BoardLevel   FROM vwBoardInfo  V  INNER JOIN Users U ON v.UserID =U.UserID WHERE (V.Status=1) AND AreaName=@AreaName  Order By CASE WHEN WatchDate >= dateinvestedDate and WatchDate >= FirstViewDate THEN WatchDate  WHEN dateinvestedDate >= WatchDate and dateinvestedDate >= FirstViewDate THEN dateinvestedDate else FirstViewDate  END DESC">
            <selectparameters>
                <asp:Parameter Name="AreaName" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BI.BoardID,BI.BoardName,BI.Status,BI.UserID FROM vBoardInformation BI WHERE BI.DirectoryName=@Name">
            <selectparameters>
                <asp:Parameter Name="Name" />
                <%--  <asp:QueryStringParameter Name="Name" QueryStringField="Name" />--%>
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdWatchers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spWatchBoard" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdWatching" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="IF EXISTS(SELECT *  FROM BoardInvestors where UserID=@UserID and BoardID=@BoardID and WatchDate IS NOT NULL) SELECT 'IsExist' as result Else select 'NotExist' as result"
            updatecommand="UPDATE BoardInvestors SET WatchDate=null WHERE UserID=@UserID AND BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="BoardID" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardComments" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BC.UserID,BC.Text,BC.CommentDate,(SELECT UserName FROM Users Where UserID=BC.UserID) AS CommenterUserName FROM BoardComments BC WHERE BC.BoardID=@BoardID ORDER BY BC.CommentDate DESC"
            insertcommand="INSERT INTO BoardComments(BoardID,Text,userID,CommentDate) VALUES(@BoardID,@Text,@userID,GETDATE())">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
            <insertparameters>
                <asp:Parameter Name="BoardID" />
                <asp:Parameter Name="Text" />
                <asp:Parameter Name="UserID" />
            </insertparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="Select BoardID,Boardname,UserID,Description,Keywords,YoutubeVideoUrl,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Comments,Investors,District,AreaName,RecentComment,CommenterUserID,city,state,country,District1,InvestmentTypeID,RaisedTotal,TotalOffer as seekingAmount,NoOfBoardLevels,TotalOffer As Seeking,Offer,AmountRemaining as Amountleft,question1,question2,question3,question4,answer1,answer2,answer3,answer4,AboutMe,InvType,InvTypeDescription,case when minLevelPrice=maxLevelPrice then case when BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) else case when BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) + ' - ' + case when BankLocation='US' then '$' else '£' end + convert(varchar(12),cast(maxLevelPrice as dec(10,0)),1) END As PricedFrom,BoardLevel,RecommendCount,MoreInfo,BankLocation,OwnerName from vwBoardInfo where BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUpdates" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="select COUNT(commentID) CommentCount from BoardComments where cast(CommentDate as date)=cast(getdate() as date) and BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardLevels" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
            selectcommand="SELECT ISNULL(BL.LevelAmount,0) as LevelAmount,BL.LevelName,BL.Description,BL.NumOffered ,(SELECT EnglishName FROM investmenttype WHERE value=(SELECT InvType FROM Boards WHERE BoardID= BL.BoardID)) As InvestmentType,ROW_NUMBER() OVER (ORDER BY BoardId) AS Row,(SELECT ISNULL(BankLocation,'US') FROM Users WHERE UserID=(SELECT UserID FROM Boards WHERE BoardID= BL.BoardID)) As BankLocation FROM BoardLevels BL WHERE BL.BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdViewBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spViewBoard" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="UserID" Type="Int32" />
                <asp:Parameter Name="BoardID" Type="Int32" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAllBoardersList" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select BI.UserID,(SELECT UserName From Users Where UserID=BI.UserID) As username,(SELECT FirstName From Users Where UserID=BI.UserID) As FirstName,(SELECT LastName From Users Where UserID=BI.UserID) As LastName from BoardInvestors BI where BoardID=@BoardID and AmountInvested is not null">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCrowdBoardTeam" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT BO.MemberID,BO.Description,(SELECT UserName From Users Where UserID=BO.MemberID) As username,(SELECT FirstName From Users Where UserID=BO.MemberID) As FirstName,(SELECT LastName From Users Where UserID=BO.MemberID) As LastName FROM BoardOwners BO where BoardID=@BoardID and status=1 union Select Boards.UserID as MemberID,'' as Description,Users.UserName,Users.FirstName,Users.LastName from Boards  inner join Users on Boards.UserID =Users.UserID where BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
                <%-- <asp:Parameter Name="MemberID" />--%>
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRecentActivityOnBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select * from  dbo.f_BoardAllActivities(@BoardID)">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
                <%--  <asp:SessionParameter Name="UserID" SessionField="UserID" />--%>
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdFilesUploaded" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from BoardFiles WHERE BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdBoardMediaLinks" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from BoardMediaLinks WHERE BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRecommend" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="spRecommendBoard" selectcommandtype="StoredProcedure" updatecommand="UPDATE BoardInvestors SET DateRecommended=null WHERE UserID=@UserID AND BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="BoardID" />
            </selectparameters>
            <updateparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="BoardID" />
            </updateparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdCheckRecommend" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="IF EXISTS(SELECT *  FROM BoardInvestors where UserID=@UserID and BoardID=@BoardID and DateRecommended IS NOT NULL) SELECT 'IsExist' as result Else select 'NotExist' as result">
            <selectparameters>
                <asp:Parameter Name="UserID" />
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdRecentCommentsOnBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsRecommended" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsWatchedOnBoard" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsBoardInvested" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * from(Select top 100 percent B.BoardID,B.BoardName,B.DirectoryName,NULL as Text,BI.UserID As userID,BI.AmountInvested, (SELECT UserName From Users where UserID=BI.UserID) AS UserName,Bi.DateInvested as ActivityDate from Boards B INNER JOIN boardinvestors BI ON B.BoardId=BI.BoardID WHERE B.BoardID=@BoardID AND BI.dateInvested is not null ORDER BY Bi.DateInvested DESC)main">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdLevelReachedGraph" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="sp_LevelReached" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdUserInfo" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="select * from Boards B inner join Users U on B.UserID=U.UserID where B.BoardID=@BoardID">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdAmountrRaisedGraph" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="sp_AmountrRaised" selectcommandtype="StoredProcedure">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
        <asp:sqldatasource id="sdsWCR" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            selectcommand="SELECT * From(Select top 100 percent  B.BoardID,B.BoardName,B.DirectoryName,BC.Text,BC.userID As userID,(SELECT UserName From Users where UserID=BC.UserID) AS UserName,'comments on' as ResultType,BC.CommentDate as ActivityDate from Boards B INNER JOIN BoardComments BC ON B.BoardId=BC.BoardID WHERE B.BoardID=@BoardID ORDER BY BC.CommentDate desc)Main union  SELECT * from (Select top 100 percent   B.BoardID,B.BoardName,B.DirectoryName,NULL as Text,BI.UserID As userID,(SELECT UserName From Users where UserID=BI.UserID) AS UserName,'Recommends' as ResultType,Bi.DateRecommended as ActivityDate from Boards B INNER JOIN boardinvestors BI ON B.BoardId=BI.BoardID WHERE B.BoardID=@BoardID AND BI.DateRecommended is not null ORDER BY Bi.DateRecommended DESC)Main union  SELECT * from (Select top 100 percent  B.BoardID,B.BoardName,B.DirectoryName, NULL as Text,BI.UserID As userID,(SELECT UserName From Users where UserID=BI.UserID) AS UserName,'is watching' as ResultType, Bi.WatchDate as ActivityDate from Boards B INNER JOIN boardinvestors BI ON B.BoardId=BI.BoardID WHERE B.BoardID=@BoardID AND BI.WatchDate is not null  ORDER BY Bi.WatchDate DESC)Main order by ActivityDate desc">
            <selectparameters>
                <asp:Parameter Name="BoardID" />
            </selectparameters>
        </asp:sqldatasource>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Height="347px" Width="493px">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow2" Behaviors="Close" OnClientClose="OnClientClose"
                Height="200px" Width="400px">
            </telerik:RadWindow>
            <telerik:RadWindow runat="server" ID="loginRadWindow" Behaviors="Close" OnClientClose="OnClientClose"
                Width="650" Height="550">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:content>
