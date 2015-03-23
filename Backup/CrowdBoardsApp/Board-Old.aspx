<%@ Page Language="VB" Title="Board" AutoEventWireup="false" Inherits="CrowdBoardsApp.BoardOld"
    EnableEventValidation="false" MasterPageFile="~/publicMaster.master" CodeBehind="Board-Old.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
        width="99%" border="0">
        <tr align="center">
            <td>
                <asp:Button ID="btnClose" runat="server" Text="&lt; Back" BorderStyle="None" Font-Underline="True"
                    Width="73px" />
                <telerik:RadTextBox ID="txtBoardName" runat="server" BackColor="Transparent" Font-Names="Arial"
                    Font-Size="12pt" ReadOnly="true" Rows="1" Width="525px" Font-Bold="True">
                </telerik:RadTextBox>
                <asp:Button ID="btnInvest" runat="server" Text="Invest!" BorderStyle="None" Font-Underline="True"
                    Width="83px" Font-Size="Medium" />
                <asp:Button ID="btnWatch" runat="server" Text="Watch!" BorderStyle="None" Font-Underline="True"
                    Width="83px" Font-Size="Medium" />
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="margin-top: 10px">
                    <legend></legend>
                    <telerik:RadAjaxPanel ID="RadJobAjaxPanel" runat="server" Width="100%" EnableAJAX="true">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="width: 20%">
                                    Investment Type:
                                </td>
                                <td style="width: 25%">
                                    <telerik:RadTextBox ID="txtInvType" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" Width="80%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 25%">
                                    Board Status:
                                </td>
                                <td style="width: 30%">
                                    <telerik:RadTextBox ID="txtStatus" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" Width="100%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <telerik:RadTextBox ID="txtDescription" runat="server" TextMode="MultiLine" BackColor="Transparent"
                                        Font-Names="Arial" Font-Size="9pt" Width="100%" ReadOnly="true" Rows="4">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 25%" align="center">
                                    <table>
                                        <tr>
                                            <td align="center">
                                                <b>Owned By</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:LinkButton ID="btnOwnedBy" runat="server">
                                                    <img id="imgOwnedBy" runat="server" height="60" width="60" /></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    Investments Remaining:
                                </td>
                                <td style="width: 20%">
                                    <telerik:RadTextBox ID="txtRemaining" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" Width="80%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    Active Since:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="rdtdDateActivated" runat="server" BackColor="Transparent"
                                        Font-Names="Arial" Font-Size="9pt" Width="100%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%">
                                    Area:
                                </td>
                                <td style="width: 25%">
                                    <telerik:RadTextBox ID="txtArea" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" Width="80%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td colspan="2">
                                    <table width="100%" border="0">
                                        <tr>
                                            <td style="width: 10%">
                                                Audience:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtAudience" runat="server" BackColor="Transparent" Font-Names="Arial"
                                                    Font-Size="9pt" Width="100%" ReadOnly="true" TextMode="MultiLine" Rows="4">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%" border="0">
                                        <tr>
                                            <td style="width: 10%">
                                                Uniqueness:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtUniqueness" runat="server" TextMode="MultiLine" Rows="4"
                                                    BackColor="Transparent" Font-Names="Arial" Font-Size="9pt" Width="95%" ReadOnly="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td style="width: 20%">
                                                Revenue Generation:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtRevenueGeneration" runat="server" BackColor="Transparent"
                                                    Font-Names="Arial" Font-Size="9pt" Width="100%" TextMode="MultiLine" Rows="4"
                                                    ReadOnly="true">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadAjaxPanel>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <iframe id="ifUrl" runat="server" height="400px" width="100%"></iframe>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <div style="font-size: x-large; margin-top: 20px;">
                    Comments</div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnOwnedBy" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Label ID="messageLabel" runat="server" Text="" ForeColor="Red"></asp:Label>
                            <telerik:RadGrid ID="rgBoardComments" runat="server" AutoGenerateColumns="False"
                                GridLines="None" DataSourceID="sdBoardComments">
                                <MasterTableView DataSourceID="sdBoardComments" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Comment" UniqueName="Comment">
                                            <ItemTemplate>
                                                <asp:Label ID="commentLabel" runat="server" Text='<%#Eval("Text") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Add Comment" UniqueName="Comments" Display="false">
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="addCommentRadTextBox" runat="server" TextMode="MultiLine"
                                                    Rows="5" Width="500px">
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridDateTimeColumn DataField="CommentDate" HeaderText="Comment Date" SortExpression="CommentDate"
                                            UniqueName="CommentDate" DataFormatString="{0:d}" FilterControlAltText="Filter Date column"
                                            ReadOnly="true">
                                        </telerik:GridDateTimeColumn>
                                    </Columns>
                                    <CommandItemSettings AddNewRecordText="Add Comment" />
                                </MasterTableView>
                                <HeaderContextMenu EnableAutoScroll="True">
                                </HeaderContextMenu>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BI.BoardID,BI.BoardName,BI.Description,BI.DateActivated,BI.URL,BI.Keywords,BI.Status,BI.DirectoryName,BI.InvestmentTypeName,BI.InvestmentTypeDescription,BI.BoardStatus,BI.UserID,BI.AudienceDesc,BI.UniquenessDesc,BI.RevenueDesc,A.AreaName FROM vBoardInformation BI WHERE BI.DirectoryName=@Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdWatchers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        InsertCommand="INSERT INTO Watchers (WatchingBy,WatchDate,BoardID)VALUES(@WatchingBy,@WatchDate,@BoardID)">
        <InsertParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
            <asp:Parameter Name="WatchingBy" Type="String" />
            <asp:Parameter Name="WatchDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardComments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Top 10 Text,CommentDate FROM BoardComments WHERE BoardID=@BoardID Order By CommentDate DESC"
        InsertCommand="INSERT INTO BoardComments(BoardID,Text,userID,CommentDate) VALUES(@BoardID,@Text,@userID,@CommentDate)">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="CommentDate" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
