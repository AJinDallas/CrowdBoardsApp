<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="scrollPage.aspx.vb" Inherits="CrowdBoardsApp.scrollPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .page
        {
            width: 1200px;
            background-color: #fff;
            margin: 20px auto 0px auto;
            border: 1px solid #496077;
        }
        .RadPanelBar .rpImage
        {
            height: 19px;
        }
        .RadPanelBar .rpLevel1 .rpImage
        {
            height: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <%--<asp:ScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>--%>
    <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grInterviws" LoadingPanelID="RadAjaxLoadingPanel2">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            function HandleScrollingInterview(e) {
                var grid = $find("<%=grInterviws.ClientID %>");
                var scrollArea = document.getElementById("<%= grInterviws.ClientID %>" + "_GridData");
                if (IsScrolledToBottom(scrollArea)) {
                    var currentlyDisplayedRecords = grid.get_masterTableView().get_pageSize() * (grid.get_masterTableView().get_currentPageIndex() + 1);

                    if (currentlyDisplayedRecords < 40) {

                        $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("LoadMoreRecords");
                    }
                }
            }
            function IsScrolledToBottom(scrollArea) {

                var currentPosition = scrollArea.scrollTop + scrollArea.clientHeight;

                return currentPosition == scrollArea.scrollHeight;
            }
        </script>
    </telerik:RadCodeBlock>
    <div>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
                style="border: 0;" />
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadGrid ID="grInterviws" runat="server" AutoGenerateColumns="False" GridLines="None"
            AllowSorting="true" AllowPaging="true" PageSize="10" Width="300px" ShowHeader="false">
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <PagerStyle Visible="false"></PagerStyle>
            <MasterTableView>
                <CommandItemSettings ExportToPdfText="Export to Pdf" />
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="Name" SortExpression="Name">
                        <ItemTemplate>
                            <div style="background-color: #ececee; border: thick solid #262626;">
                                <table width="100%">
                                    <tr>
                                        <td class="LabelBlack">
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("userName", IIf(Convert.ToString(Eval("userName"))= Convert.ToString(Session("userName")), "~/Profile.aspx", "~/Profile.aspx?User={0}")) %>'>
                                                <asp:Image ID="Image1" runat="server" ToolTip='<%# Container.DataItem("userName")%>'
                                                    Height="60px" Width="70px" ImageUrl='<%# isAvail(Eval("userName", "~/Upload/ProfilePics/{0}.jpg")) %>' /></asp:HyperLink>
                                            <span class="userName">
                                                <%# Container.DataItem("userName")%></span> Commented
                                            <br />
                                            <span class="Text">
                                                <%# Container.DataItem("Text")%></span>
                                        </td>
                                        <td style="vertical-align: top; text-align: right;">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToDateTime (Eval("ActivityDate")).ToString("MM/dd/yyyy") %>'
                                                CssClass="LabelBrownSmall"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="600px">
                </Scrolling>
                <ClientEvents OnScroll="HandleScrollingInterview"></ClientEvents>
            </ClientSettings>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sddatasource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select * from users">
         <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
        </asp:SqlDataSource>--%>
    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Height="600px" ExpandMode="FullExpandedItem"
        Width="100%">
        <Items>
            <telerik:RadPanelItem Text="Mail" ImageUrl="Img/mail.gif" Expanded="True" CssClass="accordionNew">
                <Items>
                    <telerik:RadPanelItem>
                        <ItemTemplate>
                            <asp:Button ID="btnTest" runat="server" Text="Button test" />
                        </ItemTemplate>
                    </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelItem>
            <telerik:RadPanelItem Text="Calendar" ImageUrl="Img/calendar.gif">
                <Items>
                    <telerik:RadPanelItem>
                        <ItemTemplate>
                            <telerik:RadCalendar runat="server" ID="Calendar1" Style="margin: 6px auto 0" />
                        </ItemTemplate>
                    </telerik:RadPanelItem>
                </Items>
            </telerik:RadPanelItem>
            <telerik:RadPanelItem Text="Contacts" ImageUrl="Img/contacts.gif">
                <Items>
                    <telerik:RadPanelItem ImageUrl="Img/contactsItems.gif" Text="My Contacts" />
                    <telerik:RadPanelItem ImageUrl="Img/contactsItems.gif" Text="Address Cards" />
                    <telerik:RadPanelItem ImageUrl="Img/contactsItems.gif" Text="Phone List" />
                    <telerik:RadPanelItem ImageUrl="Img/contactsItems.gif" Text="Shared Contacts" />
                </Items>
            </telerik:RadPanelItem>
            <telerik:RadPanelItem Text="Tasks" ImageUrl="Img/tasks.gif">
                <Items>
                    <telerik:RadPanelItem ImageUrl="Img/tasksItems.gif" Text="My Tasks" />
                    <telerik:RadPanelItem ImageUrl="Img/tasksItems.gif" Text="Shared Tasks" />
                    <telerik:RadPanelItem ImageUrl="Img/tasksItems.gif" Text="Active Tasks" />
                    <telerik:RadPanelItem ImageUrl="Img/tasksItems.gif" Text="Completed Tasks" />
                </Items>
            </telerik:RadPanelItem>
            <telerik:RadPanelItem Text="Notes" ImageUrl="Img/notes.gif">
                <Items>
                    <telerik:RadPanelItem ImageUrl="Img/notesItems.gif" Text="My Notes" />
                    <telerik:RadPanelItem ImageUrl="Img/notesItems.gif" Text="Notes List" />
                    <telerik:RadPanelItem ImageUrl="Img/notesItems.gif" Text="Shared Notes" />
                    <telerik:RadPanelItem ImageUrl="Img/notesItems.gif" Text="Archive" />
                </Items>
            </telerik:RadPanelItem>
            <telerik:RadPanelItem Text="Folders List" ImageUrl="Img/folderList.gif">
                <Items>
                    <telerik:RadPanelItem ImageUrl="Img/mailOutbox.gif" Text="My Client.Net" />
                    <telerik:RadPanelItem ImageUrl="Img/mailOutbox.gif" Text="My Profile" />
                    <telerik:RadPanelItem ImageUrl="Img/mailOutbox.gif" Text="My Support Tickets" />
                    <telerik:RadPanelItem ImageUrl="Img/mailOutbox.gif" Text="My Licenses" />
                </Items>
            </telerik:RadPanelItem>
        </Items>
    </telerik:RadPanelBar>
    </form>
</body>
</html>
