<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Stripe.aspx.vb" Inherits="CrowdBoardsApp.StripeCallback" %>

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
    <asp:SqlDataSource ID="sdUserStripeAccount" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from UserStripeAccount where UserID=@UserID" InsertCommand="INSERT INTO UserStripeAccount(UserID,StripeUserID,acces_token,Publishable_key,refresh_token,DateCreated,Status) VALUES(@UserID,@StripeUserID,@acces_token,@Publishable_key,@refresh_token,GETDATE(),1)"
        UpdateCommand="UPDATE UserStripeAccount SET StripeUserID=@StripeUserID,acces_token=@acces_token,Publishable_key=@Publishable_key,refresh_token=@refresh_token,DateModified=GETDATE() where UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="UserID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="StripeUserID" />
            <asp:Parameter Name="acces_token" />
            <asp:Parameter Name="Publishable_key" />
            <asp:Parameter Name="refresh_token" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="StripeUserID" />
            <asp:Parameter Name="acces_token" />
            <asp:Parameter Name="Publishable_key" />
            <asp:Parameter Name="refresh_token" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetUserID" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * from Users where UserName=@UserName">
        <SelectParameters>
            <asp:Parameter Name="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
