<%@ Page Language="VB" MasterPageFile="~/publicMaster.master" AutoEventWireup="false"
    Inherits="CrowdBoardsApp.MyProfileOld" Title="Untitled Page" CodeBehind="MyProfile-Old.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
        <ClientEvents OnResponseEnd="OnResponseEnd" OnRequestStart="OnRequestStart"></ClientEvents>
    </telerik:RadAjaxManager>
    <script language="javascript" type="text/javascript">
        function OnClientClicked(button, args) {
            if (!window.confirm("Are you sure you want delete this?")) {
                button.set_autoPostBack(false);
            }
            else {
                button.set_autoPostBack(true);
            }
        }
        function OnRequestStart(sender, args) {


        }

        function OnResponseEnd(sender, args) {


        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
        width="849" border="0">
        <tr>
            <td style="width: 950px">
                <asp:Button ID="btnClose" runat="server" Text="Close" Width="60px" Visible="false" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadAjaxPanel ID="RadJobAjaxPanel" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
                    ClientEvents-OnRequestStart="OnRequestStart">
                    <fieldset style="margin-top: 10px; width: 849px">
                        <legend>Public Information</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="width: 15%">
                                    First Name:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtFirstName" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    Last Name:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtLastName" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%">
                                    Job:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtJob" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    Birthdate:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtBirthdate" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%">
                                    About Me:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtAboutMe" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true" TextMode="MultiLine" Width="80%">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    My Dreams:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtMyDreams" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true" TextMode="MultiLine" Width="80%">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; vertical-align: top; padding-top: 5px;">
                                    Profile Picture:
                                </td>
                                <td style="width: 35%">
                                    <table style="width: 100%" border="0">
                                        <tr>
                                            <td style="width: 40%">
                                                <telerik:RadUpload ID="ruProfilePic" runat="server" ControlObjectsVisibility="None"
                                                    Height="28px" Width="275px" AllowedFileExtensions=".jpg" />
                                            </td>
                                            <td style="width: 60%; vertical-align: top;">
                                                <asp:Button ID="btnUploadProfilePic" runat="server" Text="Upload" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblUploadProfilePic" runat="server" ForeColor="green"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; vertical-align: top; padding-top: 5px;">
                                    Background Picture:
                                </td>
                                <td style="width: 35%">
                                    <table style="width: 100%" border="0">
                                        <tr>
                                            <td style="width: 40%">
                                                <telerik:RadUpload ID="ruBackgroundPicture" runat="server" ControlObjectsVisibility="None"
                                                    Height="28px" Width="275px" AllowedFileExtensions=".jpg" />
                                            </td>
                                            <td style="width: 60%; vertical-align: top;">
                                                <asp:Button ID="btnUploadBackgroundPicture" runat="server" Text="Upload" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblUploadBackgroundPicture" runat="server" ForeColor="green"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td>
                <div style="font-size: x-large; margin-top: 10px;">
                    Private Information</div>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
                    ClientEvents-OnRequestStart="OnRequestStart">
                    <fieldset style="margin-top: 10px; width: 849px">
                        <legend>Billing Information</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="width: 15%">
                                    Address:
                                </td>
                                <td style="width: 60%">
                                    <telerik:RadTextBox ID="txtAddress" runat="server" TextMode="MultiLine" BackColor="Transparent"
                                        Font-Names="Arial" Font-Size="9pt" Width="60%" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    City:
                                </td>
                                <td style="width: 35%">
                                    <telerik:RadTextBox ID="txtCity" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%">
                                    State:
                                </td>
                                <td style="width: 60%">
                                    <telerik:RadTextBox ID="txtState" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 15%">
                                    Zip:
                                </td>
                                <td style="width: 20%">
                                    <telerik:RadTextBox ID="txtZip" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 25%">
                                    Social Security Number:
                                </td>
                                <td style="width: 60%">
                                    <telerik:RadTextBox ID="txtSsn" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td align="center">
                <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
                    ClientEvents-OnRequestStart="OnRequestStart">
                    <telerik:RadGrid ID="rgUserDistricts" runat="server" AutoGenerateColumns="False"
                        DataSourceID="sdUserDistricts" GridLines="None" AutoGenerateEditColumn="false"
                        Width="100%">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView DataKeyNames="DistrictID" DataSourceID="sdUserDistricts" CommandItemDisplay="Top">
                            <Columns>
                                <telerik:GridDropDownColumn DataSourceID="sdDistrictComboBox" HeaderText="District Name"
                                    ListTextField="DistrictName" ListValueField="DistrictID" UniqueName="DistrictName"
                                    Display="false">
                                </telerik:GridDropDownColumn>
                                <telerik:GridBoundColumn DataField="DistrictName" HeaderText="District Name" UniqueName="districtName"
                                    HeaderStyle-Width="300px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ButtonType="LinkButton" CommandName="Delete" Text="Delete"
                                    UniqueName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Are You Sure You want to delete?">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <CommandItemSettings AddNewRecordText="Add Districts" />
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdBillingInformation" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select userid,address,city,state,zip,socialsecuritynumber,FirstName,LastName,Job,Birthdate,AboutMe,MyDreams from Users WHERE UserID=@UserID"
        UpdateCommand="UPDATE USERS SET Address=@Address,City=@City,State=@State,Zip=@Zip,SocialSecurityNumber=@SocialSecurityNumber,FirstName=@FirstName,LastName=@LastName,Job=@Job,Birthdate=@Birthdate,AboutMe=@AboutMe,MyDreams=@MyDreams WHERE UserID=@UserID">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="userName" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="State" Type="String" />
            <asp:Parameter Name="Zip" Type="String" />
            <asp:Parameter Name="SocialSecurityNumber" Type="String" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Job" Type="String" />
            <asp:Parameter Name="Birthdate" Type="String" />
            <asp:Parameter Name="AboutMe" Type="String" />
            <asp:Parameter Name="MyDreams" Type="String" />
            <asp:SessionParameter Name="UserID" SessionField="userName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand=" SELECT UD.UserID,UD.DistrictID,D.DistrictName  FROM UserDistricts UD  INNER JOIN Districts D ON UD.DistrictID =D.districtID  WHERE UD.UserID=@UserID"
        InsertCommand=" INSERT INTO UserDistricts (UserID,DistrictID )VALUES(@UserID,@DistrictID)"
        DeleteCommand=" DELETE FROM UserDistricts WHERE UserID =@UserID AND DistrictID =@DistrictID">
        <InsertParameters>
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="userName" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdDistrictComboBox" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="  SELECT 0 as districtID,'--Select Districts--' AS DistrictName   UNION  SELECT districtID ,DistrictName  FROM Districts ">
    </asp:SqlDataSource>
</asp:Content>
