<%@ Page Title="Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="ReferralUsers.aspx.vb" Inherits="CrowdBoardsApp.ReferralUsers" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
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
                    <telerik:RadGrid ID="grAllReferralUsers" runat="server" AutoGenerateColumns="False"
                        DataSourceID="sdAllReferralUsers" Width="100%" GridLines="None" AllowSorting="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView CommandItemDisplay="Top">
                            <CommandItemSettings ShowExportToExcelButton="true" ShowAddNewRecordButton="false">
                            </CommandItemSettings>
                            <Columns>
                                <telerik:GridBoundColumn DataField="UserName" HeaderText="User Name" UniqueName="UserName"
                                    HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Name" SortExpression="Name" HeaderText="Name"
                                    UniqueName="Name" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Email" SortExpression="Email" HeaderText="Email Address"
                                    UniqueName="Email" HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EmailVerified" SortExpression="EmailVerified"
                                    HeaderText="Email Verified" UniqueName="EmailVerified" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>                               
                                <telerik:GridBoundColumn DataField="DateRegistered" SortExpression="DateRegistered"
                                    HeaderText=" Date Joined" UniqueName="DateRegistered" DataType="System.DateTime"
                                    DataFormatString="{0:d}" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ReferalValue" SortExpression="ReferalValue" HeaderText="ReferalValue"
                                    UniqueName="ReferalValue" HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ReferalUserID" SortExpression="ReferalUserID" HeaderText="From"
                                    UniqueName="ReferalURL" HeaderStyle-Width="150px">
                                </telerik:GridBoundColumn>
                                
                            </Columns>
                        </MasterTableView>
                        <ExportSettings FileName="AllUsers">
                        </ExportSettings>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:sqldatasource id="sdAllReferralUsers" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select   IsNull(FirstName,'')+' '+IsNull(LastName,'') as Name,IsNull(City,'')+'/'+IsNull(State,'') as [City/State],* from users where ReferalUserID is not null and ReferalUserID<>0">
    </asp:sqldatasource>
</asp:content>
