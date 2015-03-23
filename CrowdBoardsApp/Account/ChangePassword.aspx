<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Account_ChangePassword"
    CodeBehind="ChangePassword.aspx.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Change Password</title>
      <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'/>
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #DCDCDC;">
    <form id="form1" runat="server">
    <div class="loginDiv">
        <%-- <div style="border-right: 3px outset; border-top: 3px outset; z-index: 103; left: 24px;
            border-left: 3px outset; width: 600px; border-bottom: 3px outset; position: relative;
            top: 24px; height: 550px; background-color: gainsboro;">--%>
        <div class="DivCorner" style="background-color: #FFFFFF; width: 600px; margin: auto;">
            <%-- <table style="position: relative;" align="center">--%>
            <table align="center">
                <tr>
                    <td>
                        <h2>
                            Change Password
                        </h2>
                        <p>
                            Use the form below to change your password.
                        </p>
                        <hr />
                        <asp:ChangePassword ID="ChangeUserPassword" runat="server" CancelDestinationPageUrl="~/Home.aspx"
                            EnableViewState="false" SuccessPageUrl="~/Home.aspx">
                            <ChangePasswordTemplate>
                                <span>
                                    <%--  <span class="failureNotification">--%>
                                    <%--<asp:Literal ID="FailureText" runat="server"></asp:Literal>--%>
                                    <asp:Label ID="FailureText" runat="server" ForeColor="Red"></asp:Label>
                                </span>
                                <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" ForeColor="Red"
                                    ValidationGroup="ChangeUserPasswordValidationGroup" />
                                <div class="accountInfo">
                                    <%-- <fieldset class="changePassword">
                                        <legend>Account Information</legend>--%>
                                    <p>
                                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Old Password:</asp:Label>
                                        <asp:TextBox ID="CurrentPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                            ForeColor="Red" ErrorMessage="Password is required." ToolTip="Old Password is required."
                                            ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                    </p>
                                    <p>
                                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                        <asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                            ForeColor="Red" ErrorMessage="New Password is required." ToolTip="New Password is required."
                                            ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                    </p>
                                    <p>
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                            ForeColor="Red" Display="Dynamic" ErrorMessage="Confirm New Password is required."
                                            ToolTip="Confirm New Password is required." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                            ControlToValidate="ConfirmNewPassword" ForeColor="Red" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                                            ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:CompareValidator>
                                    </p>
                                    <%--  </fieldset>--%>
                                    <p class="submitButton">
                                        <%-- <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Cancel" />
                                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                            Text="Change Password" ValidationGroup="ChangeUserPasswordValidationGroup" />--%>
                                        <asp:ImageButton ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                            Height="30px" Width="120px" ImageUrl="../Images/Changepasswod.png" Text="Change Password"
                                            ValidationGroup="ChangeUserPasswordValidationGroup" />
                                        <asp:ImageButton ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Height="30px" Width="70px" ImageUrl="../Images/Cancel.png" Text="Cancel" />
                                    </p>
                                </div>
                            </ChangePasswordTemplate>
                        </asp:ChangePassword>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
