<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContactMe.aspx.vb" Inherits="CrowdBoardsApp.ContactMe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
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
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h2>
                            Request for the Registration
                        </h2>
                        <hr />
                        <div class="accountInfo">
                            <p>
                                <asp:Label ID="UserNameLabel" runat="server">Name:</asp:Label>
                                <asp:TextBox ID="Name" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="NameRequired" runat="server" ControlToValidate="Name"
                                    ForeColor="Red" ErrorMessage="Name is required." ToolTip="Name is required."
                                    ValidationGroup="NameValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="emailLabel" runat="server">E-mail:</asp:Label>
                                <asp:TextBox ID="email" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="emailRequired" runat="server" ControlToValidate="email"
                                    ForeColor="Red" ErrorMessage="E-mail is required." ToolTip="E-mail is required."
                                    ValidationGroup="NameValidationGroup">*</asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="txtEmailRegularExpressionValidator" runat="server"
                                    Display="Dynamic" ForeColor="Red" ControlToValidate="email" ValidationGroup="NameValidationGroup"
                                    ErrorMessage="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                            </p>
                            <p class="submitButton" style="text-align:center;">
                                <asp:Button ID="submitButton" runat="server" Height="30px" Text="Submit" ValidationGroup="NameValidationGroup"
                                    Width="80px" />
                            </p>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <asp:SqlDataSource ID="sdContactUs" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
       InsertCommandType="StoredProcedure"
            InsertCommand="ContactUsInsertUpdate">               
            <InsertParameters>
                <asp:Parameter Name="FirstName" />
                <asp:Parameter Name="LastName" />
                <asp:Parameter Name="Email" />
                <asp:Parameter Name="QuestionText" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
