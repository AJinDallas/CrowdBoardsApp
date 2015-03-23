<%@ Page Title="Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="Users.aspx.vb" Inherits="CrowdBoardsApp.Users" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <script>
        function OnClientClicked() {

            if (!window.confirm("Are you sure ?")) {
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder2" runat="server">
    <div style="border: 0px solid; float: left; width: 100%; margin-bottom: 10px;">
        <table style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td style="text-align: center;">
                    <asp:label id="lblErrorMessage" runat="server" visible="false" font-bold="true"></asp:label>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="grAllUsers" runat="server" AutoGenerateColumns="False" DataSourceID="sdAllUsers"
                        Width="100%" GridLines="None" AllowSorting="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView CommandItemDisplay="Top">
                            <CommandItemSettings ShowExportToExcelButton="true" ShowAddNewRecordButton="false">
                            </CommandItemSettings>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="User Name" UniqueName="UserName">
                                    <ItemTemplate>
                                        <asp:hyperlink id="UserName" navigateurl='<%# String.Format("~/Profile.aspx?User={0}", Eval("UserName")) %>'
                                            target="_blank" text='<%# Eval("UserName") %>' runat="server" style="font-size:12px; text-decoration:unerline;">
                                        </asp:hyperlink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%-- <telerik:GridBoundColumn DataField="UserName" HeaderText="User Name" UniqueName="UserName"
                                    HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="Name" SortExpression="Name" HeaderText="Name"
                                    UniqueName="Name" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Email" SortExpression="Email" HeaderText="Email Address"
                                    UniqueName="Email" HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EmailVerified" SortExpression="EmailVerified"
                                    HeaderText="Email Verified" UniqueName="EmailVerified" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="City/State" SortExpression="City/State" HeaderText=" City/State"
                                    UniqueName="cityState" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DateRegistered" SortExpression="DateRegistered"
                                    HeaderText=" Date Joined" UniqueName="DateRegistered" DataType="System.DateTime"
                                    DataFormatString="{0:d}" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DateLastLoggedIn" SortExpression="DateLastLoggedIn"
                                    HeaderText="Last Login Date" UniqueName="DateLastLoggedIn" DataType="System.DateTime"
                                    DataFormatString="{0:d}" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="NetwordSize" SortExpression="NetwordSize" HeaderText="Network Size"
                                    UniqueName="NetwordSize" HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BoardInvestedIn" SortExpression="BoardInvestedIn"
                                    HeaderText="# Boards Invested In" HeaderStyle-Width="200px" UniqueName="BoardInvestedIn">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AmountInvestedIn" HeaderText="Investment Total"
                                    SortExpression="AmountInvestedIn" DataFormatString="{0:c}" DataType="System.Decimal"
                                    UniqueName="AmountInvestedIn" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="crowdboards" HeaderText="Crowdboards Created"
                                    SortExpression="crowdboards" UniqueName="crowdboards" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ActiveCrowdboards" HeaderText="Active Boards"
                                    SortExpression="ActiveCrowdboards" UniqueName="ActiveCrowdboards" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ClosedCrowdboards" HeaderText="Closed Boards"
                                    SortExpression="ClosedCrowdboards" UniqueName="ClosedCrowdboards" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FundedCrowdboards" HeaderText="Funded Boards"
                                    SortExpression="FundedCrowdboards" UniqueName="FundedCrowdboards" HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="RaiseTotal" HeaderText=" Raised Total" DataFormatString="{0:c}"
                                    DataType="System.Decimal" UniqueName="RaiseTotal" HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action">
                                    <ItemTemplate>
                                        <asp:linkbutton id="btnUserStatus" runat="server" text="Deactivate" commandname="deactivateUsers"
                                            commandargument='<%#Eval("UserID") %>' cssclass="primaryButton" style="font-size: 14px;
                                            color: #ececee;" visible='<%#Convert.ToBoolean(Eval("Status"))%>'>
                                        </asp:linkbutton>
                                        <asp:linkbutton id="btnActivateUser" runat="server" text="Activate" commandname="activateUsers"
                                            commandargument='<%#Eval("UserID") %>' cssclass="primaryButton" style="font-size: 14px;
                                            color: #ececee;" visible='<%#Convert.ToBoolean(Eval("Status"))%>'>
                                        </asp:linkbutton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Account Status" UniqueName="account">
                                    <ItemTemplate>
                                        <asp:linkbutton id="btnUserAccountStatus" runat="server" text="Unlock" commandname="unlockUsers"
                                            commandargument='<%#Eval("memberID") %>' cssclass="primaryButton" style="font-size: 14px;
                                            color: #ececee;" visible='<%#Convert.ToBoolean(Eval("IsLockedOut"))%>'>
                                        </asp:linkbutton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="deleteUser">
                                    <ItemTemplate>
                                        <asp:linkbutton id="btndeleteUser" runat="server" text="Delete" commandname="deleteUser"
                                            onclientclick="return OnClientClicked();" commandargument='<%#Eval("UserID") %>'
                                            cssclass="primaryButton" style="font-size: 14px; color: #ececee;">
                                        </asp:linkbutton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ExportSettings FileName="AllUsers">
                        </ExportSettings>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:sqldatasource id="sdAllUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="select main.*,U.Email,AM.UserId AS memberID,AM.IsLockedOut  from (
SELECT userid,UserName,DateLastLoggedIn,FirstName,Name,
[City/State],SSN,DOB,LastName,city,State,SocialSecurityNumber,DateRegistered,
BoardInvestedIn,AmountInvestedIn,crowdboards,ActiveCrowdboards,ClosedCrowdboards,
NetwordSize,FundedCrowdboards,RaiseTotal, Status,
case when TwitterUserID  is not null  then 'N/A' when FacebookUserID  is not null   then 'N/A' 
when LinkedInUserID  is not null   then 'N/A'
when Status=1 and (LinkedInUserID is  null and FacebookUserID is  null  and TwitterUserID is  null)  then 'Check' else  'No Check'end as EmailVerified 
 FROM vwAllUsersInfo)main inner join Users U on U.UserID =main.userid 
  INNER JOIN aspnet_Users AU ON AU.UserName =U.UserName
  INNER JOIN aspnet_Membership AM   ON AM.UserId =AU.UserId"></asp:sqldatasource>
    <asp:sqldatasource id="sdUsersStatus" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE Users SET status=@status WHERE UserID =@UserID">
        <updateparameters>
            <asp:Parameter Name="status" />
            <asp:Parameter Name="UserID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUsersAccountStatus" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        updatecommand="UPDATE ASPNET_MEMBERSHIP SET IsLockedOut=0 WHERE UserId=@memberID">
        <updateparameters>
            <asp:Parameter Name="memberID" />
        </updateparameters>
    </asp:sqldatasource>
    <asp:sqldatasource id="sdUsersDelete" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="User_Delete" selectcommandtype="StoredProcedure">
        <selectparameters>          
            <asp:Parameter Name="userID" Type="Int32"  />
        </selectparameters>
    </asp:sqldatasource>
</asp:content>
