<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Success.aspx.vb" Inherits="CrowdBoardsApp.Success" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:label id="lblMessage" runat="server"></asp:label>
    </div>
    </form>
    <asp:sqldatasource id="sdUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="IF EXISTS(SELECT * FROM  Users Where FacebookUserID=@FacebookUserID) (select userid as status,UserName as UserName,Status as userStatus,DateLastLoggedIn as DateLastLoggedIn from Users where FacebookUserID=@FacebookUserID) else select 'NotExist' as [status]"
        insertcommand="INSERT INTO Users (UserName,FirstName,LastName,DateRegistered,DateLastLoggedIn,Email,Status,FacebookUserID,ReferalValue, ReferalUserID) VALUES (@UserName,@FirstName,@LastName,getdate(),getdate(),@Email,1,@FacebookUserID,@ReferalValue, @ReferalUserID)"
        updatecommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="FacebookUserID" Type="String" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </updateparameters>
        <insertparameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="FacebookUserID" Type="String" />
              <asp:Parameter Name="ReferalValue" Type="String" />
            <asp:Parameter Name="ReferalUserID" Type="Int32" />
        </insertparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdGetUserIdDataSource" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="SELECT UserID from Users WHERE UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUserPosts" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select * from UserPosts where PostID=@PostID">
        <selectparameters>
            <asp:Parameter Name="PostID" />
        </selectparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdFacebookBoost" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Sp_BoostUserPost" selectcommandtype="StoredProcedure">
        <selectparameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="PostID" />
        </selectparameters>
    </asp:sqldatasource>
</body>
</html>
