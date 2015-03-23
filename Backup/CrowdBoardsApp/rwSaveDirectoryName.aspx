<%@ Page Language="VB" AutoEventWireup="false"
    Inherits="CrowdBoardsApp.rwSaveDirectory" EnableEventValidation="false" Codebehind="rwSaveDirectoryName.aspx.vb" %>

<%@ Register Src="TopMenu.ascx" TagName="TopMenu" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Board Detail</title>
      <script language="javascript" type="text/javascript">
    function GetRadWindow()
    {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow =window.frameElement.radWindow;
        return oWindow;
    }
    function closeMe()
    {
        var oWindow = GetRadWindow();
        oWindow.Close();
    }
    function Ok()
    {
        var oWindow = GetRadWindow();
        oWindow.Close("OK");    
    }
    </script>
      <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'/>
    <link href="Css/StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
       <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdpCalendar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdpTerrName" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table width="100%">
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblErrorMessageForm" runat="server" ForeColor="red" Text="Directory Name already exists"></asp:Label>
                </td>
            </tr>
            <tr>
                <td width="50%">
                    <asp:Label ID="lblDirectoryName" runat="server" Text="Directoy Name:"></asp:Label></td>
                <td width="50%">
                    <asp:TextBox ID="txtDirectoryName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnOk" runat="server" Text="OK" /></td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE Boards SET DirectoryName=@DirectoryName WHERE BoardID=@boardID">
            <SelectParameters>
                <asp:SessionParameter Name="BoardId" SessionField="boardID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="DirectoryName" Type="String" />
                <asp:SessionParameter Name="BoardId" SessionField="boardID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
