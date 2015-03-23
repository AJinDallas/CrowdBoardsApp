<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Wepay.aspx.vb" Inherits="CrowdBoardsApp.Wepay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
    <asp:SqlDataSource ID="sdUserWePayAccount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO UserWePayAccount(UserID,WePayUserID,acces_token,AccountID,AccountUri,DateCreated,Status) VALUES(@UserID,@WePayUserID,@acces_token,@AccountID,@AccountUri,GETDATE(),1)">
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="WePayUserID" />
            <asp:Parameter Name="acces_token" />
            <asp:Parameter Name="AccountID" />
            <asp:Parameter Name="AccountUri" />
        </InsertParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="sdConfirmedInvestorsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="spInvest" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="AmountInvested" />
            <asp:Parameter Name="LevelID" />
            <asp:Parameter Name="CheckoutID" />
            <asp:Parameter Name="PreApprovalID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="sdUserWePayAccountDetails" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select * FROM UserWePayAccount WHERE UserID=@UserID ">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
