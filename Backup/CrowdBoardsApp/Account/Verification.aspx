<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Verification.aspx.vb"
    Inherits="CrowdBoardsApp.Verification" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function GoToLogin(url) {
            //alert(url);
            setTimeout(wait(url), 60000);
        }

        function wait(url) {
            //alert(url);
            window.location = url;

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center" style="text-align: center; margin-top:150px;  margin-left:350px;
        background-color: White; height: 150px; width:50%;">
        <br /><br />
        <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ></asp:Label>
        <br />
        <br />
        <asp:HyperLink ID="hlLogin" runat="server" Visible="false" NavigateUrl="~/Default.aspx"
            CssClass="primaryButton" Text="Login"></asp:HyperLink>
    </div>
    </form>
    <asp:SqlDataSource ID="sdGetUserInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID,UserName,FirstName,LastName,Email,Status,uuid from Users WHERE UserID=@UserID"
        UpdateCommand="UPDATE Users SET Status=1 where UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</body>
</html>
