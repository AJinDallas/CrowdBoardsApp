<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PaypalSuccess.aspx.vb"
    Inherits="CrowdBoardsApp.PaypalSuccess" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    <asp:SqlDataSource ID="sdConfirmedInvestorsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spInvest" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="AmountInvested" />
            <asp:Parameter Name="LevelID" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
