<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmbedPage.aspx.vb" Inherits="CrowdBoardsApp.EmbedPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <%--  <link href="Css/Style.css" rel="stylesheet" type="text/css" />--%>
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
            width: 121px !important;
        }
     </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <div style="height: 150px; width: 140px; background-color: #353638; overflow: hidden;
        background-image: url('Images/thermometerSmall.png'); background-repeat: no-repeat;">
        <table width="100%">
            <tr>
                <td>
                    <div class="thermometer" style="margin-left: 17px;">
                        <telerik:RadSlider Skin="Black" ID="ThermometerSlider" runat="server" ItemType="Tick"
                            TrackPosition="TopLeft" MinimumValue="0" LargeChange="2000" Orientation="Vertical"
                            Height="123px" Width="100px" ShowDragHandle="false" ShowDecreaseHandle="false"
                            ShowIncreaseHandle="false" IsDirectionReversed="true" Value="1000" Enabled="false"
                            CssClass="thermometerSlider" BackColor="Transparent">
                        </telerik:RadSlider>
                    </div>
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <span style="color: #ececee; font-size: medium;">Level</span><br />
                                <asp:Label ID="lblBoardLevel" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color: #ececee; font-size: medium;">Max Left</span><br />
                                <asp:Label ID="lblAmountLeft" runat="server" ForeColor="Gold"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color: #ececee; font-size: medium;">BoardersIn</span><br />
                                <asp:Label ID="lblBoardersInBoard" runat="server" ForeColor="Green"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,status,Boardname,status,UserID,Investors,seeking as seekingAmount,RaisedTotal,case when BankLocation='US' then '$' else '£' end +convert(varchar(12),cast((isnull(Seeking,0)-isnull(RaisedTotal,0)) as dec(10,0)),1) as Amountleft,BoardLevel from vwBoardInfo  Where directoryName=@DirectoryName">
        <SelectParameters>
            <asp:Parameter Name="DirectoryName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetBoardIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardId from Boards WHERE DirectoryName=@Name">
        <SelectParameters>
            <asp:Parameter Name="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
