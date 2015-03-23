<%@ Page Title="Posts" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
   CodeBehind="Posts.aspx.vb" Inherits="CrowdBoardsApp.Posts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                    <div>
                        <telerik:RadTabStrip ID="RadTabStripPosts" runat="server" MultiPageID="RadMultiPagePosts"
                            Skin="Outlook" SelectedIndex="0">
                            <Tabs>
                                <telerik:RadTab runat="server" Text="Posts" PageViewID="pvAllPosts" Selected="True">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Comments" PageViewID="pvAllComments">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                    </div>
                    <telerik:RadMultiPage ID="RadMultiPagePosts" runat="server" Width="100%" SelectedIndex="0"
                        TabIndex="1">
                        <telerik:RadPageView runat="server" ID="pvAllPosts">
                            <telerik:RadGrid ID="allPostsRadGrid" runat="server" AutoGenerateColumns="False"
                                GridLines="None" Width="100%" DataSourceID="sdsUserPosts" AutoGenerateEditColumn="true">
                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                </HeaderContextMenu>
                                <MasterTableView DataSourceID="sdsUserPosts" CommandItemDisplay="Top" DataKeyNames="PostID">
                                    <CommandItemSettings ShowAddNewRecordButton="false"></CommandItemSettings>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Text" HeaderText="Text" UniqueName="Text" HeaderStyle-Width="400px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="UserName" HeaderText="User Name" UniqueName="UserName"
                                            ReadOnly="true" HeaderStyle-Width="300px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DatePosted" HeaderText="Date Posted" UniqueName="DatePosted"
                                            ReadOnly="true" HeaderStyle-Width="300px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" Display="true">
                                            <ItemTemplate>
                                                <asp:Button ID="btnDeletePost" runat="server" Text="Delete" CommandName="DeletePost"
                                                    OnClientClick="return OnClientClicked();" CommandArgument='<%#Eval("PostID") %>'
                                                    CssClass="primaryMiniButton"></asp:Button>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </telerik:RadPageView>
                        <telerik:RadPageView runat="server" ID="pvAllComments">
                            <telerik:RadGrid ID="commentsRadGrid" runat="server" AutoGenerateColumns="False"
                                GridLines="None" Width="100%" DataSourceID="sdsComments" AutoGenerateEditColumn="true">
                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                </HeaderContextMenu>
                                <MasterTableView DataSourceID="sdsComments" CommandItemDisplay="Top" DataKeyNames="ReplyID">
                                    <CommandItemSettings ShowAddNewRecordButton="false"></CommandItemSettings>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Comment" HeaderText="Comment" UniqueName="Comment"
                                            HeaderStyle-Width="400px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="UserName" HeaderText="User Name" UniqueName="UserName"
                                            ReadOnly="true" HeaderStyle-Width="300px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DateReplies" HeaderText="Date Replies" UniqueName="DateReplies"
                                            ReadOnly="true" HeaderStyle-Width="300px">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" Display="true">
                                            <ItemTemplate>
                                                <asp:Button ID="btnDeleteCommentID" runat="server" Text="Delete" CommandName="DeleteComment"
                                                    OnClientClick="return OnClientClicked();" CommandArgument='<%#Eval("ReplyID") %>'
                                                    CssClass="primaryMiniButton"></asp:Button>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdsUserPosts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="  Select UP.PostID,UP.Text,UP.DatePosted,UP.UserID,UP.AttachedFileName,isnull(U.FirstName,'')+' '+isnull(U.LastName,'')as UserName  from UserPosts UP inner join [Users] U on UP.UserID =U.UserID order by UP.DatePosted desc"
        UpdateCommand="UPDATE UserPosts SET Text=@Text WHERE PostID=@PostID" DeleteCommand="Delete from UserPosts where PostID=@PostID">
        <UpdateParameters>
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="PostID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="PostID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsComments" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UPR.ReplyID,UPR.Comment,UPR.DateReplies,UPR.UserID ,isnull(U.FirstName,'')+' '+isnull(U.LastName,'') As UserName FROM UserPostReplies UPR INNER JOIN [USERS] U on UPR.UserID=U.UserID ORDER BY UPR.DateReplies DESC"
        UpdateCommand="UPDATE UserPostReplies SET Comment=@Comment WHERE ReplyID=@ReplyID"
        DeleteCommand="Delete from UserPostReplies where ReplyID=@ReplyID">
        <UpdateParameters>
            <asp:Parameter Name="Comment" Type="String" />
            <asp:Parameter Name="ReplyID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="ReplyID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>
