<%@ Page Title="Images" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="AllImages.aspx.vb" Inherits="CrowdBoardsApp.AllImages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">

            function OnClientClicked() {

                if (!window.confirm("Are you sure ?")) {
                    return false;
                }
                else {
                    return true;
                }
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="border: 0px solid; float: left; width: 100%; margin-bottom: 10px;">
        <table style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td>
                    <asp:Label ID="lblErrorMessage" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="allImagesGrid" runat="server" AutoGenerateColumns="False" GridLines="None"
                        AllowPaging="true" PageSize="10" Width="60%"  Style="margin-left: 100px;">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="uploadedImage" runat="server" Height="75px" Width="75px" ImageUrl='<%#Eval("ImageUrl") %>' />
                                        <asp:HiddenField ID="hdnImageType" runat="server" Value='<%# Eval("ImageType") %>' />
                                        <asp:HiddenField ID="hdnDirectoryName" runat="server" Value='<%# Eval("DirectoryName") %>' />
                                        <asp:HiddenField ID="hdnUserID" runat="server" Value='<%# Eval("UserID") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Type" DataField="ImageType">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Username" DataField="UserName">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn DataField="DateUploaded" HeaderText="Date Uploaded" DataFormatString="{0:d}">
                                </telerik:GridDateTimeColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDeleteImage" runat="server" Text="Delete" CommandName="DeleteImage"
                                            OnClientClick="return OnClientClicked();" ToolTip="Delete Image" CommandArgument='<%#Eval("FileName") %>'
                                            CssClass="primaryMiniButton"></asp:Button>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdAllImages" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from dbo.GetAllImages() order by DatePosted desc" UpdateCommand="Update Messages SET FileName=null WHERE FromUser=@UserID and FileName=@FileName"
        DeleteCommand="Delete from BoardFiles WHERE FileName=@FileName">
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="FileName" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="FileName" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetUserDetailsByDirectoryName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select B.DirectoryName,B.UserID,(Select UserName FROm Users where UserID=B.UserID) AS UserName from Boards B where DirectoryName=@DirectoryName"
        UpdateCommand="Update UserPosts SET AttachedFileName=null WHERE UserID=@UserID and AttachedFileName=@FileName">
        <SelectParameters>
            <asp:Parameter Name="DirectoryName" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserID" />
            <asp:Parameter Name="FileName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetUserIDByUserName" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID from Users where UserName=@UserName">
        <SelectParameters>
            <asp:Parameter Name="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
