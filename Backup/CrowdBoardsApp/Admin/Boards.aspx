<%@ Page Title="Boards" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="Boards.aspx.vb" Inherits="CrowdBoardsApp.Boards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
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
                <telerik:RadGrid ID="grAllBoard" runat="server" AutoGenerateColumns="False" GridLines="None"
                                            Width="100%" AllowSorting="true" DataSourceID="sdAllBorads">
                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                            </HeaderContextMenu>
                                            <MasterTableView CommandItemDisplay="Top">
                                                <CommandItemSettings ShowExportToExcelButton="true" ShowAddNewRecordButton="false">
                                                </CommandItemSettings>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Board Name" UniqueName="Board_Name" Display="true"
                                                        SortExpression="boardname">
                                                        <ItemTemplate>
                                                        <asp:HiddenField ID="hdnOwnerEmail" runat="server" Value='<%#Eval("OwnerEmail") %>' />
                                                            <asp:HyperLink ID="boardLink" runat="server" CssClass="whiteLink" Target="_blank"
                                                                NavigateUrl='<%# Eval("DirectoryName","~/{0}") %>' Text='<%#Eval("boardname") %>'
                                                                Font-Size="small">
                                                            </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Owned By" UniqueName="OwnedBy" Display="true"
                                                        SortExpression="OwnedBy">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="ownedByLink" runat="server" Target="_blank" CssClass="whiteLink"
                                                                NavigateUrl='<%# Eval("OwnedBy","~/Profile.aspx?User={0}") %>' Text='<%#Eval("OwnedBy") %>'
                                                                Font-Size="small">
                                                            </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField=" StatusText" SortExpression="StatusText" HeaderText=" Status"
                                                        UniqueName="StatusText" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="CreatedOn" SortExpression="CreatedOnt" HeaderText=" CreatedOn"
                                                        UniqueName="CreatedOn" HeaderStyle-Width="300px" DataFormatString="{0:d}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvType" SortExpression="InvType" HeaderText="Investment Type"
                                                        UniqueName="InvType" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="NoOfBoardLevels" SortExpression="NoOfBoardLevels"
                                                        HeaderText="# of Levels" UniqueName="NoOfBoardLevels" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="TotalOffer" SortExpression="TotalOffer" HeaderText="Seeking"
                                                        UniqueName="seeking" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="InvestmentsSold" HeaderText=" Investments Sold"
                                                        SortExpression="InvestmentsSold" UniqueName="InvestmentsSold" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="RaisedTotal" HeaderText=" Raised Total" DataFormatString="{0:c}"
                                                        SortExpression="RaisedTotal" DataType="System.Decimal" UniqueName="RaisedTotal"
                                                        HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="NoOfWatchers" HeaderText="Watchers" UniqueName="NoOfWatchers"
                                                        SortExpression="NoOfWatchers" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Commentors" HeaderText="# Of Commenters" UniqueName="Commentors"
                                                        SortExpression="Commentors" HeaderStyle-Width="300px">
                                                    </telerik:GridBoundColumn>
                                                      <telerik:GridBoundColumn DataField="FederalTaxID" HeaderText="Tax ID" UniqueName="FederalTaxID"
                                                        SortExpression="FederalTaxID" HeaderStyle-Width="250px">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" Display="true">
                                                        <ItemTemplate>
                                                            <telerik:RadButton ID="btnDeactivateBoard" runat="server" Text="Deactivate" CommandName="deactivateBoards"
                                                                OnClientClicked="OnClientClicked" CommandArgument='<%#Eval("BoardID") %>' Visible='<%# IIf(Eval("Status")<>3, IIf(Eval("Status")<>0, True,False),False) %>'>
                                                            </telerik:RadButton>
                                                            <telerik:RadButton ID="btnApproveBoard" OnClientClicked="OnClientClicked" CommandArgument='<%#Eval("BoardID") %>'
                                                                CommandName="aproveBoards" runat="server" Text="Approve" Visible='<%# IIf(Eval("Status")=4, True,False) %>'>
                                                            </telerik:RadButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action" UniqueName="DeleteBoard" Display="true">
                                                        <ItemTemplate>
                                                            <telerik:RadButton ID="btnDeleteBoard" runat="server" Text="Delete Board" CommandName="DeleteBoard"
                                                                OnClientClicked="OnClientClicked" CommandArgument='<%#Eval("BoardID") %>'>
                                                            </telerik:RadButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ExportSettings FileName="AllBoards">
                                            </ExportSettings>
                                        </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="sdAllBorads" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT BoardID,boardname,OwnedBy,StatusText,InvType,NoOfBoardLevels,InvestmentsAvailable,InvestmentsSold,RaisedTotal,NoOfWatchers,Commentors,Status,TotalOffer,CreatedOn,DirectoryName,UserID,OwnerEmail,FederalTaxID  FROM vwAllBoardsInfo">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdInActiveBoards" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT BoardID,boardname,InvType,NoOfBoardLevels,InvestmentsAvailable,InvestmentsSold,RaisedTotal,NoOfWatchers,Commentors,Status,FederalTaxID  FROM vwAllBoardsInfo where Status=3">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoardDelete" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="sp_DeleteBoards" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="BoardID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdBoardStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            UpdateCommand="UPDATE boards SET status=@status,DateActivated=GETDATE() WHERE BoardID =@BoardID">
            <UpdateParameters>
                <asp:Parameter Name="status" Type="Int32" />
                <asp:Parameter Name="BoardID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
</asp:Content>
