<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Account_Login"
    CodeBehind="Login.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login</title>
      <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'/>
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #DCDCDC;">
    <form id="form1" runat="server">
    <div class="loginDiv">
        <div class="DivCorner" style="background-color: #FFFFFF; width: 600px; margin: auto;">
            <table align="center">
                <tr>
                    <td>
                        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>
                            Log In
                        </h2>
                        <p>
                            Please Enter your username and password.
                            <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false" NavigateUrl="~/Account/Register.aspx">Register</asp:HyperLink>
                            if you don't have an account.
                        </p>
                        <hr />
                        <div>
                            <asp:Login ID="LoginUser" runat="server" EnableViewState="false" DestinationPageUrl="~/Home.aspx">
                                <LayoutTemplate>
                                    <span>
                                        <%-- <asp:Literal ID="FailureText" runat="server"></asp:Literal>--%>
                                        <asp:Label ID="FailureText" runat="server" ForeColor="Red"></asp:Label>
                                    </span>
                                    <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" ForeColor="Red"
                                        ValidationGroup="LoginUserValidationGroup" />
                                    <div class="accountInfo">
                                        <p>
                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                                            <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                ForeColor="Red" ErrorMessage="User Name is required." ToolTip="User Name is required."
                                                ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                                        </p>
                                        <p>
                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                            <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                ForeColor="Red" ErrorMessage="Password is required." ToolTip="Password is required."
                                                ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                                        </p>
                                        <div class="control-group">
                                            <div class="checkbox inline">
                                                <asp:CheckBox ID="RememberMe" runat="server" />
                                                <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe">Keep me logged in</asp:Label>
                                            </div>
                                        </div>
                                        <p class="submitButton">
                                            <asp:ImageButton ID="LoginButton" runat="server" CommandName="Login" Height="30px"
                                                ImageUrl="../Images/Log in.png" Text="Create User" ValidationGroup="LoginUserValidationGroup"
                                                Width="80px" />
                                        </p>
                                    </div>
                                </LayoutTemplate>
                            </asp:Login>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="control-group">
                        <div class="controls">
                            <h2>
                                Or
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="control-group">
                        <div class="controls">
                            <asp:LinkButton ID="signInFacebook" runat="server" Height="30px" Width="150px">
                                <img id="img1" runat="server" src="../Images/sign-up-form.jpg" /></asp:LinkButton>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
    <asp:SqlDataSource ID="sdGetUserIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID from Users WHERE UserName=@UserName">
        <SelectParameters>
           <asp:Parameter Name="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
