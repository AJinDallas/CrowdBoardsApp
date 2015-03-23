<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwPostFromBoard.aspx.vb"
    Inherits="CrowdBoardsApp.rwPostFromBoard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Post from Board</title>
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
        function Ok() {
            var oWindow = GetRadWindow();
            oWindow.Close("OK");
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
        <div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table width="100%" cellpadding="5" cellspacing="5">
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Label ID="lblSuccessMessage" runat="server"  Visible="false"></asp:Label>
                                <asp:Label ID="lblErrorMessage" runat="server"  Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5"
                                                    Width="350px" BackColor="#ececee" ForeColor="#262626">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnOk" runat="server" Text="Post" CssClass="primaryButton"></asp:Button>
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="primaryButton" OnClientClick="Cancel();">
                                                </asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
    <asp:SqlDataSource ID="sdBoardComments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO BoardComments(BoardID,Text,userID,CommentDate) VALUES(@BoardID,@Text,@userID,@CommentDate)">
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="Text" />
            <asp:Parameter Name="CommentDate" Type="DateTime" />
            <asp:Parameter Name="UserID" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardID FROM boards WHERE DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="sdCheckuserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select *  from Users"></asp:SqlDataSource>
         <asp:SqlDataSource ID="sdCheckBoardName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select BoardID,BoardName,DirectoryName  from Boards"></asp:SqlDataSource>
         <asp:SqlDataSource ID="sdPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="UserPost_Insert" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Text" />
            <asp:Parameter Name="UserID" />
        </SelectParameters>
       
    </asp:SqlDataSource>
</body>
</html>
