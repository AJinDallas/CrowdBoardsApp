﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TwitterRegister.aspx.vb"
    Inherits="CrowdBoardsApp.TwitterRegister" %>

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
        <table width="100%">
            <tr>
                <td>
                    <asp:label id="lblMessage" runat="server"></asp:label>
                </td>
            </tr>
        </table>
    </div>
    <asp:sqldatasource id="sdUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="IF EXISTS(SELECT * FROM  Users Where TwitterUserID=@TwitterUserID) (select userid as status,UserName as UserName,Status as userStatus,DateLastLoggedIn as DateLastLoggedIn from Users where TwitterUserID=@TwitterUserID) else select 'NotExist' as [status]"
        insertcommand="INSERT INTO Users (UserName,FirstName,LastName,DateRegistered,DateLastLoggedIn,Status,TwitterUserID,ReferalValue, ReferalUserID) VALUES (@UserName,@FirstName,@LastName,getdate(),getdate(),1,@TwitterUserID,@ReferalValue, @ReferalUserID)"
        updatecommand="UPDATE Users SET DateLastLoggedIn=getdate() WHERE UserName=@UserName">
        <selectparameters>
            <asp:Parameter Name="TwitterUserID" Type="String" />
        </selectparameters>
        <updateparameters>
            <asp:Parameter Name="UserName" Type="String" />
        </updateparameters>
        <insertparameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="TwitterUserID" Type="String" />
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
    </form>
</body>
</html>