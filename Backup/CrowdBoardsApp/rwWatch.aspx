<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwWatch.aspx.vb" Inherits="CrowdBoardsApp.rwWatch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Watch</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
     <script language="javascript" type="text/javascript">
         function GetRadWindow() {
             var oWindow = null;
             if (window.radWindow) oWindow = window.radWindow;
             else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
             return oWindow;
         }
         function closeMe() {
             var oWindow = GetRadWindow();
             oWindow.Close();
         }
         function Cancel() {
             var oWindow = GetRadWindow();
             oWindow.Close("CANCEL");
         }
         function Ok(args) {
             var oWindow = GetRadWindow();
             var directoryName = '<%=directoryName %>';
             var fromSeacrhPage = '<%=fromSearchPage %>';
             var url;
             if (args == "login") {
                 url = "Default.aspx";
             }
             else {
                 if (fromSeacrhPage.toString() == 1) {
                     url = "/" + directoryName + "&fromSearch=1";
                 }
                 else {
                     url = "/" + directoryName;
                 }
             }
             oWindow.Close(url);
         }
    </script>
</head>
<body class="backgroundColorAndFontColor">
     <form id="form1" runat="server">
    <div>
        <asp:ScriptManager runat="server" ID="ScriptManager1">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table width="100%" cellpadding="5" cellspacing="5">
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Label ID="lblMessage" runat="server" CssClass="LabelGreenLarge" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnWatchPublicly" runat="server" Text="Watch Publicly" CssClass="primaryMiniButton" />
                                        &nbsp;<span>(Other boarders can see)</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnWatchPrivately" runat="server" Text="Watch Privately" CssClass="primaryMiniButton" />
                                        &nbsp;<span>(No one knows you are watching)</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
     <asp:SqlDataSource ID="sdBoardInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,Boardname,UserID,Description,Keywords,AudienceDesc,UniquenessDesc,RevenueDesc,Watches,Comments,Investors,District,AreaName,RecentComment,CommenterUserID,city,state,country,District1,InvestmentTypeID,RaisedTotal,TotalOffer as seekingAmount,NoOfBoardLevels,TotalOffer As Seeking,Offer,AmountRemaining as Amountleft,question1,question2,question3,question4,answer1,answer2,answer3,answer4,AboutMe,InvType,InvTypeDescription,case when minLevelPrice=maxLevelPrice then  '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) else '$'+ convert(varchar(12),cast(minLevelPrice as dec(10,0)),1) + ' - $'+ convert(varchar(12),cast(maxLevelPrice as dec(10,0)),1) END As PricedFrom,BoardLevel,RecommendCount from vwBoardInfo where BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   <asp:SqlDataSource ID="sdWatchers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spWatchBoard" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="UserID"  />
            <asp:Parameter Name="BoardID"  />
            <asp:Parameter Name="PrivateWatch"  />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BI.BoardID,BI.BoardName,BI.Status,BI.UserID FROM vBoardInformation BI WHERE BI.DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from Boards B inner join Users U on B.UserID=U.UserID where B.BoardID=@BoardID">
        <SelectParameters>
           <asp:Parameter Name="BoardID"  />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
