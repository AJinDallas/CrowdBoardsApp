<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Account_Register"
    CodeBehind="Register.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Register</title>
      <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'/>
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link href="../Css/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #DCDCDC;">
    <form id="form1" runat="server">
    <div class="DivCorner" style="background-color: #FFFFFF; width: 600px; margin: auto;">
        <table align="center">
            <tr>
                <td>
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false">
                        <WizardSteps>
                            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                                <ContentTemplate>
                                    <div>
                                        <h2>
                                            Sign Up
                                        </h2>
                                        <p>
                                            Join CrowdBoarders Now!
                                            <hr />
                                            <p>
                                            </p>
                                            <span>
                                                <asp:Label ID="ErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                                            </span>
                                            <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" ValidationGroup="RegisterUserValidationGroup"
                                                ForeColor="Red" />
                                            <p>
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username</asp:Label>
                                                <asp:TextBox ID="UserName" runat="server" CssClass="input-large"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ForeColor="Red"
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </p>
                                            <p>
                                                <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstNameTextBox">First Name</asp:Label>
                                                <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="input-large"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstNameTextBox"
                                                    ForeColor="Red" ErrorMessage="First Name is required." ToolTip="First Name is required."
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </p>
                                            <p>
                                                <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastNameTextBox">Last Name</asp:Label>
                                                <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="input-large"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastNameTextBox"
                                                    ErrorMessage="Last Name is required." ToolTip="Last Name is required." ForeColor="Red"
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </p>
                                            <p>
                                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">Email</asp:Label>
                                                <asp:TextBox ID="Email" runat="server" CssClass="input-large"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                    ErrorMessage="E-mail is required." ToolTip="E-mail is required." ForeColor="Red"
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </p>
                                            <p>
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password</asp:Label>
                                                <asp:TextBox ID="Password" runat="server" CssClass="input-large" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ForeColor="Red"
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                            </p>
                                            <p>
                                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password</asp:Label>
                                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="input-large" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                    Display="Dynamic" ErrorMessage="Confirm Password is required." ForeColor="Red"
                                                    ToolTip="Confirm Password is required." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                                    ControlToValidate="ConfirmPassword" Display="Dynamic" ForeColor="Red" ErrorMessage="The Password and Confirmation Password must match."
                                                    ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                                            </p>
                                            <p>
                                                <table width="70%">
                                                    <tr>
                                                        <td class="control-group">
                                                            <div class="controls">
                                                                <asp:RadioButton ID="termsRadioButton" runat="server" CssClass="radio row-fluid"
                                                                    Text="I accept the Terms of use" Width="100%" />
                                                                &nbsp;<a href="#">View Terms to Use</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </p>
                                            <p>
                                                <asp:ImageButton ID="CreateUserButton" runat="server" CommandName="MoveNext" Height="30px"
                                                    ImageUrl="../Images/signup.png" Text="Create User" ValidationGroup="RegisterUserValidationGroup"
                                                    Width="80px" />
                                            </p>
                                        </p>
                                    </div>
                                </ContentTemplate>
                                <CustomNavigationTemplate>
                                </CustomNavigationTemplate>
                            </asp:CreateUserWizardStep>
                            <asp:CompleteWizardStep runat="server">
                            </asp:CompleteWizardStep>
                        </WizardSteps>
                    </asp:CreateUserWizard>
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
            <tr>
                <td>
                    <div style="margin-top: 5px;">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdUsers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO Users (UserName,FirstName,LastName) VALUES (@UserName,@FirstName,@LastName)">
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
