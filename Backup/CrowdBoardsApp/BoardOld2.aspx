<%@ Page Language="VB" Title="Board" AutoEventWireup="false" Inherits="CrowdBoardsApp.BoardOld2"
    CodeBehind="BoardOld2.aspx.vb" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        div.RemoveBorders .rgHeader, div.RemoveBorders th.rgResizeCol, div.RemoveBorders .rgFilterRow td
        {
            border-width: 0 0 1px 0; /*top right bottom left*/
        }
        
        div.RemoveBorders .rgRow td, div.RemoveBorders .rgAltRow td, div.RemoveBorders .rgEditRow td, div.RemoveBorders .rgFooter td
        {
            border-width: 0;
            padding-left: 7px; /*needed for row hovering and selection*/
        }
        
        div.RemoveBorders .rgGroupHeader td, div.RemoveBorders .rgFooter td
        {
            padding-left: 7px;
        }
        .thermometer
        {
            width: 60px;
            height: 180px;
            float: left;
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
</head>
<body style="width: 849px; z-index: 120; margin: auto;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnGoback" runat="server" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgBoardComments"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
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
            function GoBack() {
                alert("This board is no longer active");
                window.location = document.getElementById("hdnGoback").value;
            }
        </script>
    </telerik:RadScriptBlock>
    <div style="height: 200px; width: 180px;background-color:Black;color:White;">
        <table width="100%">
            <tr>
                <td>
                    <div >
                        <telerik:RadSlider Skin="Vista" ID="ThermometerSlider" runat="server" ItemType="Tick"
                            MinimumValue="25" MaximumValue="100" LargeChange="25" Orientation="Vertical"
                            Height="180px" Width="60px" ShowDragHandle="false" ShowDecreaseHandle="false"
                            ShowIncreaseHandle="false" IsDirectionReversed="true" Value="35" Enabled="false" ForeColor="White"
                            CssClass="thermometerSlider">
                        </telerik:RadSlider>
                    </div>
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                Amount Left<br />
                                <asp:Label ID="lblAmountLeft" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                BoardersIn<br />
                                <asp:Label ID="lblBoardersIn" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="userUpdatePanel" runat="server">
        <ContentTemplate>
            <div style="z-index: 120; margin: auto; width: 849px; background-color: White;">
                <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
                    width="849" border="0">
                    <tr>
                        <td>
                            <asp:Label ID="messageLabel" runat="server" Text="" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <div class="DivCorner" style="background-color: Gray;">
                                <table width="100%" border="0">
                                    <tr>
                                        <td style="text-align: center;" class="LabelheadingWhite">
                                            Updates&nbsp;<asp:Label ID="lblUpdates" runat="server" CssClass="LabelheadingRed"></asp:Label>
                                        </td>
                                        <td style="width: 60%; text-align: right;">
                                            <div class="whiteLink">
                                                <asp:LinkButton ID="btnStopWatching" runat="server" Text="Stop Watching" Visible="false"></asp:LinkButton>&nbsp;&nbsp;
                                                <asp:LinkButton ID="btnWatch" runat="server" Text="Watch this Board" Visible="false"></asp:LinkButton>&nbsp;&nbsp;
                                                <asp:LinkButton ID="lbtnHome" runat="server" Text="Home"></asp:LinkButton>&nbsp;&nbsp;
                                                <asp:LinkButton ID="lbtnLogout" runat="server" Text="Logout"></asp:LinkButton>&nbsp;&nbsp;
                                                <asp:LinkButton ID="lbtnSearch" runat="server" Text="Search"></asp:LinkButton>&nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="margin-top: 10px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" width="100%">
                                <tr>
                                    <td style="width: 10%">
                                    </td>
                                    <td align="center">
                                        <div class="DivCorner" style="background-color: #C0C0C0;">
                                            <table width="100%" border="0" cellspacing="3">
                                                <tr>
                                                    <td rowspan="5" style="width: 15%;">
                                                        <img id="imgOwnedBy" runat="server" height="120" width="120" class="DivCorner" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="LabelWhite">
                                                        FundBoard:&nbsp;<asp:Label ID="lblBoardName" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td class="LabelWhite">
                                                        Watches:&nbsp;<asp:Label ID="lblWatches" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td class="LabelWhite">
                                                        Rating:<asp:Label ID="lblRating" runat="server" Text="9.8" ForeColor="white"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="LabelWhite">
                                                        Loaction:&nbsp;<asp:Label ID="lblLoacation" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td class="LabelWhite">
                                                        Comments:&nbsp;<asp:Label ID="lblComments" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="LabelWhite">
                                                        Offer:&nbsp;<asp:Label ID="lblOffer" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td class="LabelWhite">
                                                        Seeking:&nbsp;<asp:Label ID="lblSeeking" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                    <td class="LabelWhite">
                                                        Investors:&nbsp;<asp:Label ID="lblInvestors" runat="server" Text="" ForeColor="white"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr valign="top">
                                                    <td style="color: White; vertical-align: top;">
                                                        District:&nbsp;
                                                        <asp:HyperLink ID="hlkdistrict1" runat="server">
                                                            <asp:Image ID="districtPic" runat="server" Height="40px" Width="40px" />
                                                        </asp:HyperLink>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td style="width: 10%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="margin-top: 15px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" width="100%">
                                <tr>
                                    <td style="width: 10%">
                                    </td>
                                    <td>
                                        <div class="DivCorner" style="background-color: #C0C0C0; height: auto;">
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <div style="margin-top: 2px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td style="color: White;">
                                                        <div class="DivCorner" style="background-color: Gray; min-height: 50px; text-align: justify;">
                                                            &nbsp;&nbsp;About Me<br />
                                                            &nbsp;&nbsp;<asp:Label ID="bleAboutMe" runat="server" ForeColor="white" Text=""></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="margin-top: 5px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td style="color: White;">
                                                        <div class="DivCorner" style="background-color: #000000;">
                                                            <table width="100%" border="0" cellspacing="8">
                                                                <tr>
                                                                    <td style="width: 50%">
                                                                        <div class="DivCorner" style="background-color: Gray; min-height: 100px;">
                                                                            &nbsp;&nbsp;<asp:Label ID="question1Label" runat="server" ForeColor="White"></asp:Label>
                                                                            <br></br>
                                                                            &nbsp;&nbsp;<asp:Label ID="answer1Label" runat="server" ForeColor="white" Text=""></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 50%">
                                                                        <div class="DivCorner" style="background-color: Gray; min-height: 100px;">
                                                                            &nbsp;&nbsp;<asp:Label ID="question2Label" runat="server" ForeColor="White"></asp:Label>
                                                                            <br></br>
                                                                            &nbsp;&nbsp;<asp:Label ID="answer2Label" runat="server" ForeColor="white" Text=""></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 50%">
                                                                        <div class="DivCorner" style="background-color: Gray; min-height: 100px;">
                                                                            &nbsp;&nbsp;
                                                                            <asp:Label ID="question3Label" runat="server" ForeColor="White"></asp:Label>
                                                                            <br></br>
                                                                            &nbsp;&nbsp;<asp:Label ID="answer3Label" runat="server" ForeColor="white" Text=""></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width: 50%">
                                                                        <div class="DivCorner" style="background-color: Gray; min-height: 100px;">
                                                                            &nbsp;&nbsp;<asp:Label ID="question4Label" runat="server" ForeColor="White"></asp:Label>
                                                                            <br></br>
                                                                            &nbsp;&nbsp;<asp:Label ID="answer4Label" runat="server" ForeColor="white" Text=""></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="margin-top: 2px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td>
                                                        <table border="0" width="100%">
                                                            <tr>
                                                                <td style="width: 40%;">
                                                                    <div class="DivCorner" style="background-color: Black; height: 180px; padding-top: 4px;">
                                                                        <telerik:RadChart ID="RadChart1" runat="server" AutoLayout="True" Skin="Black" DefaultType="Area"
                                                                            Height="170px" Width="260px">
                                                                            <PlotArea>
                                                                                <XAxis AutoScale="False" MaxValue="100" MinValue="0" Step="10" MaxItemsCount="10">
                                                                                    <AxisLabel TextBlock-Text="Days" Visible="true">
                                                                                        <TextBlock Text="Days">
                                                                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="Gray">
                                                                                            </Appearance>
                                                                                        </TextBlock>
                                                                                    </AxisLabel>
                                                                                </XAxis>
                                                                                <YAxis AutoScale="False" MinValue="0" Step="100">
                                                                                    <AxisLabel TextBlock-Text="Amount Raised" Visible="true">
                                                                                        <TextBlock Text="Amount Raised">
                                                                                            <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="Gray">
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
                                                                            <ChartTitle TextBlock-Text="">
                                                                                <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                                                    <FillStyle MainColor="Transparent">
                                                                                    </FillStyle>
                                                                                    <Border Color="Transparent" />
                                                                                </Appearance>
                                                                                <TextBlock Text="">
                                                                                    <Appearance TextProperties-Font="Arial, 12pt" TextProperties-Color="White">
                                                                                    </Appearance>
                                                                                </TextBlock>
                                                                            </ChartTitle>
                                                                            <Appearance>
                                                                                <FillStyle MainColor="25, 25, 25">
                                                                                </FillStyle>
                                                                                <Border Color="5, 5, 5"></Border>
                                                                            </Appearance>
                                                                            <Series>
                                                                                <telerik:ChartSeries DataYColumn="AmountInvested" Name="Series 1" Type="Area" DataXColumn="datedif">
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
                                                                </td>
                                                                <td style="width: 20%;">
                                                                    <div style="background-color: Black; height: 180px">
                                                                    </div>
                                                                </td>
                                                                <td style="width: 40%;">
                                                                    <div class="DivCorner" style="background-color: Black; height: 180px; padding-top: 4px;">
                                                                        <telerik:RadChart ID="RadChart2" runat="server" AutoLayout="True" Skin="Black" Height="175px"
                                                                            Width="260px" DefaultType="Line">
                                                                            <PlotArea>
                                                                                <XAxis AutoScale="False" MaxValue="100" MinValue="10" Step="10" Visible="False" MaxItemsCount="10">
                                                                                    <AxisLabel>
                                                                                        <TextBlock>
                                                                                            <Appearance TextProperties-Color="159, 159, 159">
                                                                                            </Appearance>
                                                                                        </TextBlock>
                                                                                    </AxisLabel>
                                                                                </XAxis>
                                                                                <YAxis AutoScale="False" MinValue="0" Step="100" MaxValue="600" Visible="False">
                                                                                    <AxisLabel>
                                                                                        <TextBlock>
                                                                                            <Appearance TextProperties-Color="159, 159, 159">
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
                                                                            <ChartTitle TextBlock-Text="">
                                                                                <Appearance Dimensions-Margins="3%, 10px, 14px, 6%">
                                                                                    <FillStyle MainColor="Transparent">
                                                                                    </FillStyle>
                                                                                    <Border Color="Transparent" />
                                                                                </Appearance>
                                                                                <TextBlock Text="">
                                                                                    <Appearance TextProperties-Font="Arial, 18pt" TextProperties-Color="White">
                                                                                    </Appearance>
                                                                                </TextBlock>
                                                                            </ChartTitle>
                                                                            <Appearance>
                                                                                <FillStyle MainColor="25, 25, 25">
                                                                                </FillStyle>
                                                                                <Border Color="5, 5, 5"></Border>
                                                                            </Appearance>
                                                                            <Series>
                                                                                <telerik:ChartSeries DataYColumn="AmountInvested" Name="Series 1" Type="Line" DataXColumn="datedif">
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
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="margin-top: 2px;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td>
                                                        <table border="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table border="0" width="100%" cellspacing="5">
                                                                        <tr>
                                                                            <td style="width: 33%">
                                                                                <div class="DivCorner" style="background-color: Black; min-height: 240px">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="Level1Name" runat="server" Text="" Font-Bold="true" ForeColor="White"></asp:Label>
                                                                                                <asp:HiddenField runat="server" ID="hdnLevel1Name" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:HyperLink ID="level1Hl" runat="server">
                                                                                                    <div id="level1Div" runat="server" class="DivCorner">
                                                                                                        <asp:Label ID="level1" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                                                                    </div>
                                                                                                </asp:HyperLink>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="level1Description" runat="server" Text="" ForeColor="White"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                            <td style="width: 33%">
                                                                                <div class="DivCorner" style="background-color: Black; min-height: 240px">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="Level2Name" runat="server" Text="" Font-Bold="true" ForeColor="White"></asp:Label>
                                                                                                <asp:HiddenField runat="server" ID="hdnLevel2Name" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:HyperLink ID="level2Hl" runat="server">
                                                                                                    <div id="level2Div" runat="server" class="DivCorner">
                                                                                                        <asp:Label ID="level2" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                                                                    </div>
                                                                                                </asp:HyperLink>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="Level2Description" runat="server" Text="" ForeColor="White"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                            <td style="width: 33%">
                                                                                <div class="DivCorner" style="background-color: Black; min-height: 240px">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="Level3Name" runat="server" Text="" Font-Bold="true" ForeColor="White"></asp:Label>
                                                                                                <asp:HiddenField runat="server" ID="hdnLevel3Name" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:HyperLink ID="level3Hl" runat="server">
                                                                                                    <div id="level3Div" runat="server" class="DivCorner">
                                                                                                        <asp:Label ID="level3" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                                                                    </div>
                                                                                                </asp:HyperLink>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="text-align: center;">
                                                                                                <asp:Label ID="Level3Description" runat="server" Text="" ForeColor="White"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <div class="whiteLink">
                                                                                    <asp:LinkButton ID="lbAddComment" runat="server" Text="ADD COMMNENT"></asp:LinkButton></div>
                                                                                <div class="DivCorner" id="commentDiv" runat="server" visible="false" style="background-color: Gray;">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <telerik:RadTextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5"
                                                                                                    Width="300px">
                                                                                                </telerik:RadTextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Button ID="btnOk" runat="server" Text="Ok" CssClass="primaryMiniButton"></asp:Button>
                                                                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryMiniButton">
                                                                                                </asp:Button>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblMessageGrid" runat="server" Visible="false"></asp:Label>
                                                                </td>
                                                                <td align="right" class="LabelheadingWhite">
                                                                    COMMENT
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td style="color: Black;">
                                                        <div class="DivCorner" style="background-color: #FFFFE0; min-height: 300px;">
                                                            <telerik:RadGrid CssClass="RemoveBorders" ID="rgBoardComments" runat="server" AutoGenerateColumns="False"
                                                                BackColor="LightYellow" ShowHeader="False" GridLines="None" AllowPaging="True"
                                                                PageSize="5" AllowSorting="True" CellSpacing="0">
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                                </HeaderContextMenu>
                                                                <MasterTableView TableLayout="Fixed" GridLines="None" NoMasterRecordsText="">
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridTemplateColumn UniqueName="CommenterUserName" ItemStyle-Width="18px">
                                                                            <ItemTemplate>
                                                                                <div>
                                                                                    <asp:HyperLink ID="userLink" runat="server" NavigateUrl='<%# Eval("CommenterUserName", IIf(Convert.ToString(Eval("CommenterUserName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                                                        <asp:Image ID="userPic" runat="server" Height="40px" Width="40px" ImageUrl='<%# isAvail(Eval("CommenterUserName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink><br />
                                                                                    <asp:Label ID="userLabel" runat="server" Text='<%#Eval("CommenterUserName") %>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="18px" />
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="Comment" ItemStyle-Width="300px">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="commentLabel" runat="server" Text='<%#Eval("Text") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="300px" />
                                                                        </telerik:GridTemplateColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td style="width: 10%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose"
                Height="350px" Width="500px">
            </telerik:RadWindow>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BI.BoardID,BI.BoardName,BI.Description,BI.DateActivated,BI.URL,BI.Keywords,BI.Status,BI.DirectoryName,BI.InvestmentTypeName,BI.InvestmentTypeDescription,BI.BoardStatus,BI.UserID,BI.AudienceDesc,BI.UniquenessDesc,BI.RevenueDesc FROM vBoardInformation BI WHERE BI.DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdWatchers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spWatchBoard" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdWatching" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="IF EXISTS(SELECT *  FROM BoardInvestors where UserID=@UserID and BoardID=@BoardID and WatchDate IS NOT NULL) SELECT 'IsExist' as result Else select 'NotExist' as result"
        UpdateCommand="UPDATE BoardInvestors SET WatchDate=null WHERE UserID=@UserID AND BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="BoardID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardComments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BC.UserID,BC.Text,BC.CommentDate,(SELECT UserName FROM Users Where UserID=BC.UserID) AS CommenterUserName FROM BoardComments BC WHERE BC.BoardID=@BoardID ORDER BY BC.CommentDate DESC"
        InsertCommand="INSERT INTO BoardComments(BoardID,Text,userID,CommentDate) VALUES(@BoardID,@Text,@userID,@CommentDate)">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="CommentDate" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,Boardname,UserID,Description,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Comments,Investors,District,RecentComment,CommenterUserID,city,state,country,District1,InvestmentTypeID,NoOfBoardLevels,'$'+ convert(varchar(12),cast(Seeking as dec(10,0)),1) As Seeking,Offer,question1,question2,question3,question4,answer1,answer2,answer3,answer4,AboutMe  from vwBoardInfo where BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdates" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="select COUNT(commentID) CommentCount from BoardComments where cast(CommentDate as date)=cast(getdate() as date) and BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdLevelAmount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT top 3 '$'+ convert(varchar(12),LevelAmount,1) As LevelAmount,LevelName,Description FROM BoardLevels WHERE BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdInvestment" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT *,DATEDIFF(dd,dateinvested,getdate()) as datedif from BoardInvestors where DateInvested BETWEEN GETDATE()-100 and GETDATE() AND BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdViewBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spViewBoard" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Height="347px" Width="493px">
        <Windows>
        </Windows>
    </telerik:RadWindowManager>
    </form>
</body>
</html>
