<%@ Page Language="VB" MasterPageFile="~/publicMaster.master" AutoEventWireup="false"
    Inherits="CrowdBoardsApp.BoardPage" Title="Untitled Page" CodeBehind="BoardPage.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <table id="Table1" style="z-index: 120; margin: auto;" cellspacing="0" cellpadding="0"
        width="849px" border="0">
        <tr>
            <td align="center" style ="width :400px;">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </td>
            <td  align="center" style ="width :400px;">
            <telerik:RadButton ID="btnBack" runat ="server" Text ="Back"></telerik:RadButton>
            </td>
        </tr>
        <tr align="center">
            <td colspan ="2">
                <telerik:RadEditor ID="reCreatePage" runat="server">
                </telerik:RadEditor>
            </td>
        </tr>
        <tr align="center">
            <td colspan ="2">
                <div style="margin-top: 20px">
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save">
                    </telerik:RadButton>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdUpdateUrlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Boards SET URL=@URL where DirectoryName=@Name">
        <UpdateParameters>
            <asp:Parameter Name="URL" Type="String" />
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
