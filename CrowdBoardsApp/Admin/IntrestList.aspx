<%@ Page Title="Intrest List" Language="vb" AutoEventWireup="false" CodeBehind="IntrestList.aspx.vb"
    Inherits="CrowdBoardsApp.IntrestList" MasterPageFile="~/publicMaster.master" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder2" runat="server">
    <div style="border: 0px solid; float: left; width: 100%; margin-bottom: 10px; padding: 15px;">
        <table style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr valign="top">
                <td style="width: 60%">
                    <telerik:RadGrid ID="grIntrestList" runat="server" AutoGenerateColumns="False" DataSourceID="sdIntrestList"
                        AllowMultiRowSelection="true" Width="100%" GridLines="None" AllowSorting="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="email">
                            <CommandItemSettings ShowExportToExcelButton="true" ShowAddNewRecordButton="false">
                            </CommandItemSettings>
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" ItemStyle-Width="10"
                                    HeaderText="Select All">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" UniqueName="FirstName"
                                    HeaderStyle-Width="60px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="LastName" SortExpression="LastName" HeaderText="Last Name"
                                    UniqueName="LastName" HeaderStyle-Width="60px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Email" SortExpression="Email" HeaderText="Email Address"
                                    UniqueName="Email" HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="UType" SortExpression="UType" HeaderText="User Type"
                                    UniqueName="UType" HeaderStyle-Width="40px">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="True"></Selecting>
                        </ClientSettings>
                        <ExportSettings FileName="Intrest List">
                        </ExportSettings>
                    </telerik:RadGrid>
                </td>
                <td>
                    <div style="border: 1px solid silver; height: 300px; width: 450px; padding: 10px;
                        margin-left: 20px;">
                        <table>
                            <tr>
                                <td style="text-align: center;">
                                    <asp:label id="lblErrorMessage" runat="server" visible="false"></asp:label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:textbox id="subjectTextBox" runat="server" placeholder="Subject" width="400">
                                    </asp:textbox>
                                    <asp:requiredfieldvalidator id="rfvEmail" runat="server" controltovalidate="subjectTextBox"
                                        display="Dynamic" forecolor="Red" text="*" errormessage="message subject Required"
                                        validationgroup="send">
                                    </asp:requiredfieldvalidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:textbox id="messageBodyTextbox" runat="server" placeholder="message" textmode="MultiLine"
                                        height="150" width="400">
                                    </asp:textbox>
                                    <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" controltovalidate="messageBodyTextbox"
                                        display="Dynamic" forecolor="Red" text="*" errormessage="message body Required"
                                        validationgroup="send">
                                    </asp:requiredfieldvalidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:button id="sendMailButton" runat="server" text="Send Mail" cssclass="primaryButton"
                                        validationgroup="send" />

                                         <asp:button id="resetButton" runat="server" text="Reset" cssclass="primaryButton"
                                         />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:sqldatasource id="sdIntrestList" runat="server" connectionstring="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        selectcommand="Select * from ( Select *, Row_number() OVER(PARTITION BY Email ORDER BY Email)rn from ( SELECT FirstName,LastName,Email,'Interest User' as UType from Contactus where Email is not null Union all Select FirstName,LastName,Email,'Signup User' as UType from users where Email is not null) main ) t where t.rn =1 Order by FirstName ">
    </asp:sqldatasource>
</asp:content>
