<%@ Page Language="VB" AutoEventWireup="false" Inherits="CrowdBoardsApp.Invest"
    MasterPageFile="~/publicMaster.master" Codebehind="Invest.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
   
    <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
        width="849" border="0">
        <tr>
            <td>
                <asp:Button ID="btnClose" runat="server" Text="Close" /></td>
        </tr>
        <tr>
            <td style="height: 67px">
                <telerik:RadGrid ID="rgBoardInvestorLevel" runat="server" AutoGenerateColumns="False"
                    AllowSorting="True" GridLines="None" DataSourceID="sdInvestmentLevel" AutoGenerateEditColumn="False">
                    <MasterTableView DataSourceID="sdInvestmentLevel" DataKeyNames="LevelID">
                        <Columns>
                            <telerik:GridBoundColumn DataField="LevelName" HeaderText="Level Name" UniqueName="LevelName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Description" HeaderText="Description" SortExpression="Description"
                                UniqueName="Description">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NumOffered" HeaderText="Num Offered" SortExpression="NumOffered"
                                UniqueName="NumOffered">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LevelAmount" HeaderText="Level Amount" SortExpression="LevelAmount"
                                UniqueName="LevelAmount">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn>
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlInvest" runat="server" Text="Invest" NavigateUrl='<%# String.Format("Confirm.aspx?Name={0}&LevelName={1}", Eval("DirectoryName"), Eval("LevelName")) %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderContextMenu EnableAutoScroll="True">
                    </HeaderContextMenu>
                </telerik:RadGrid></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdInvestmentLevel" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select LevelID,LevelName,Description,NumOffered,LevelAmount,DirectoryName FROM vBoardLevelDetail where DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
