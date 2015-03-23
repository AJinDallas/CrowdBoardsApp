<%@ Page Title="Manage Roles" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master" 
    CodeBehind="AssignRole.aspx.vb" Inherits="CrowdBoardsApp.AssignRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function OnloginClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                    window.location = "AssignRole.aspx";
                }
                else if (arg == "CANCEL") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
            }
            function OnClientClose(oWnd, args) {
                var arg = args.get_argument();
                if (arg == "OK") {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    var Argument = "ReLoad";
                    ajaxManager.ajaxRequest(Argument);
                }
            }
           
        </script>
    </telerik:RadScriptBlock>
    <table style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0" width="849"
        border="0">
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="grAllUsers" runat="server" AutoGenerateColumns="False" DataSourceID="sdAllUsers"
                    GridLines="None">
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                    <MasterTableView>
                        <CommandItemSettings ShowAddNewRecordButton="false"></CommandItemSettings>
                        <Columns>
                            <telerik:GridBoundColumn DataField="UserName" HeaderText="User Name" UniqueName="UserName"
                                HeaderStyle-Width="200px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Roles Assinged" UniqueName="RolesAssinged" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                <asp:Label ID="lblRoles" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="hdnUserID" runat="server" Value='<%#Eval("UserName") %>'/>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="DateRegistered" HeaderText=" Date Joined" UniqueName="DateRegistered"
                                DataType="System.DateTime" DataFormatString="{0:d}" HeaderStyle-Width="200px">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Action" UniqueName="AssignRole" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                    <telerik:RadButton ID="btnAssignRole" runat="server" Text="Manage Role" CommandName="IAssignRole"
                                        CommandArgument='<%#Eval("UserName") %>'>
                                    </telerik:RadButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdAllUsers" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT userid,UserName ,FirstName,Name,[City/State],SSN,DOB,LastName,city,State,SocialSecurityNumber,DateRegistered FROM vwAllUsersInfo">
    </asp:SqlDataSource>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Height="347px" Width="493px">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnloginClose">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
