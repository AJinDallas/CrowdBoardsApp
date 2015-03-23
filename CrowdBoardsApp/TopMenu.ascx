<%@ Control Language="vb" AutoEventWireup="false" Inherits="CrowdBoardsApp.TopMenu" Codebehind="TopMenu.ascx.vb" %>
<meta name="vs_snapToGrid" content="False" />

<style type="text/css">
    .RadItem
    {
        FONT-WEIGHT: bold; FONT-SIZE: 9pt; WIDTH: 90%; COLOR: black; BORDER-TOP-STYLE: none; FONT-FAMILY: Arial; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 90%; BACKGROUND-COLOR: transparent; BORDER-BOTTOM-STYLE: none
    }
</style>
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager>
                <table id="Table3" style="z-index: 101;border-top-style: none; border-right-style: none;
                    border-left-style: none; border-bottom-style: none"
                    height="20" cellspacing="0" cellpadding="0" width="950" bgcolor="white" border="0"
                    runat="server" align="center">
                    <tr>
                        <td style="width:100%">
                            <telerik:RadMenu ID="rmMainMenu" CausesValidation="False" runat="server" width="950"
                               BorderWidth="0px" BorderStyle="None" BorderColor="Transparent">
                                <Items>
                                   
                                     <telerik:RadMenuItem runat="server" NavigateUrl="~/Home.aspx" Text="Home">
                                    </telerik:RadMenuItem>
                                    <telerik:RadMenuItem runat="server" NavigateUrl="Account/Login.aspx" Text="Logout">
                                    </telerik:RadMenuItem>
                                </Items>
                                
                            </telerik:RadMenu>
                        </td>
                    </tr>
                    <tr><td><br /></td></tr>
                </table>
