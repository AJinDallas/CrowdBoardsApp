<%@ Page Language="VB" Title="Default" AutoEventWireup="false" Inherits="CrowdBoardsApp.SearchOld"
    MasterPageFile="~/publicMaster.master" Codebehind="Search-Old.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <table style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0" width="849"
        border="0">
        <tr>
            <td>
                <asp:TextBox runat="server" ID="searchBoardTextBox"></asp:TextBox>
                <asp:Button runat="server" ID="searchBoardButton" Text="Search" />
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rgBoards" runat="server" AutoGenerateColumns="False" DataSourceID="sdBoards"
                    GridLines="None">
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                    <MasterTableView DataSourceID="sdBoards" ShowHeader="false">
                        <CommandItemSettings ExportToPdfText="Export to Pdf" />
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Board Name" DataField="BoardName" UniqueName="BoardNameTemplate" HeaderStyle-Width="225px">
                                <ItemTemplate>
                                    <div>
                                        <asp:HyperLink ID="hlBoardName" runat="server" Text='<%#Eval("BoardName")%>'
                                            NavigateUrl='<%#Eval("DirectoryName","~/Board.aspx?Name={0}")%>'></asp:HyperLink>
                                    </div>
                                    <div>
                                        <asp:Image ID="thumbnail" runat="server" ImageUrl='<%#GetImageURL(Eval("DirectoryName","{0}.jpg"),150,150) %>' />
                                    </div>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description" HeaderStyle-Width="300px">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="select BoardID,[Description],BoardName,DirectoryName from vBoards WHERE BoardName LIKE '%' + @BoardName + '%'">
        <SelectParameters>
            <asp:SessionParameter Name="BoardName" SessionField="BoardName" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
