<%@ Page Language="VB" Title="BoardDetails" AutoEventWireup="false" Inherits="CrowdBoardsApp.BoardDetailsOld"
    EnableEventValidation="false" MasterPageFile="~/publicMaster.master" CodeBehind="BoardDetails-Old.aspx.vb" %>

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
     <script type="text/javascript">
         function OnClientClose(oWnd, args) {
             //get the transferred arguments
             var arg = args.get_argument();
             if (arg == "OK") {
                 var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                 var Argument = "ReLoad";
                 ajaxManager.ajaxRequest(Argument);
             }
         }

         function confirmProfile(boardID) {
             if (confirm("Please update your profile before continuing..")) {
                 //alert("cancel");
                 window.location = "MyProfile.aspx?Name=" + boardID;
             }

         }
         function OnRequestStart(sender, args) {


         }

         function OnResponseEnd(sender, args) {


         }

         function conditionalPostback(sender, args) {
             if (args.get_eventTarget() == "<%= btnUpload.UniqueID %>") {
                 args.set_enableAjax(false);
             }

             if (args.get_eventTarget() == "<%= btnCreatePage.UniqueID %>") {
                 args.set_enableAjax(false);
             }
             if (args.get_eventTarget() == "<%= btnStatusChange.UniqueID %>") {
                 args.set_enableAjax(false);

             }
             if (args.get_eventTarget() == "<%= ruThumbnail.UniqueID %>") {
                 args.set_enableAjax(false);

             }
             if (args.get_eventTarget() == "<%= btnClose.UniqueID %>") {
                 args.set_enableAjax(false);

             }
         }
            
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    
   
       
      <telerik:RadAjaxPanel ID="RadAjaxPanel5" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
                        ClientEvents-OnRequestStart="OnRequestStart">
    <table id="Table1" style="z-index: 120; margin: auto" cellspacing="0" cellpadding="0"
        width="950" border="0">
         

        <tr>
            <td style="width: 950px">
            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="100%" ClientEvents-OnResponseEnd="OnResponseEnd"
                        ClientEvents-OnRequestStart="conditionalPostback">
                <asp:Button ID="btnClose" runat="server" Text="Close" Width="60px" />
                </telerik:RadAjaxPanel>
            </td>
        </tr>

        

          <tr>
            <td style="width: 950px" align="center">
              <asp:Label ID="lblErrorMessageForm" runat="server" ForeColor="red" Visible="false"></asp:Label>
            </td>
        </tr>

        <tr>
            <td>
                <fieldset style="margin-top: 10px">
                    <legend></legend>
                   
                    
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td style="width: 60%" colspan="2">
                                    <table>
                                        <tr>
                                            <td>
                                                Area:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="rcbArea" runat="server" DataSourceID="sdComboBoxAreas" DataTextField="AreaName"
                                                    DataValueField="AreaID" AutoPostBack="true">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>
                                                District:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="rcbDistrict" runat="server" AutoPostBack="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Board Name:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtBoardName" runat="server" BackColor="Transparent" Font-Names="Arial"
                                                    Font-Size="9pt" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td>
                                                Investment Type:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="rcbInvestmentType" runat="server" DataSourceID="sdComboBoxInvestmentType"
                                                    DataTextField="EnglishName" DataValueField="Value" AutoPostBack="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 10%">
                                    URL:
                                </td>
                                <td style="width: 30%">
                                    <div>
                                        <span>
                                            <telerik:RadTextBox ID="txtUrl" runat="server" BackColor="Transparent" Font-Names="Arial"
                                                Font-Size="9pt" AutoPostBack="true">
                                            </telerik:RadTextBox></span> <span>
                                                <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel3" ClientEvents-OnRequestStart="conditionalPostback">
                                                    <telerik:RadButton ID="btnCreatePage" runat="server" Text="Create Page">
                                                    </telerik:RadButton>
                                                </telerik:RadAjaxPanel>
                                            </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 11%">
                                    Description:
                                </td>
                                <td style="width: 59%">
                                    <telerik:RadTextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5"
                                        BackColor="Transparent" Font-Names="Arial" Font-Size="9pt" Width="95%" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 10%">
                                    Keywords:
                                </td>
                                <td style="width: 20%">
                                    <telerik:RadTextBox ID="txtKeword" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" Width="100%" AutoPostBack="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 10%">
                                                Audience:
                                            </td>
                                            <td style="width: 40%">
                                                <telerik:RadTextBox ID="txtAudience" runat="server" TextMode="MultiLine" Rows="5"
                                                    BackColor="Transparent" Font-Names="Arial" Font-Size="9pt" Width="95%" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td style="width: 10%">
                                                Uniqueness:
                                            </td>
                                            <td style="width: 40%">
                                                <telerik:RadTextBox ID="txtUniqueness" runat="server" BackColor="Transparent" Font-Names="Arial"
                                                    TextMode="MultiLine" Rows="5" Font-Size="9pt" Width="95%" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table>
                                        <tr>
                                            <td style="width: 10%">
                                                Revenue Generation:
                                            </td>
                                            <td style="width: 40%">
                                                <telerik:RadTextBox ID="txtRevenue" runat="server" BackColor="Transparent" Font-Names="Arial"
                                                    TextMode="MultiLine" Rows="5" Font-Size="9pt" Width="95%" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td style="width: 10%">
                                            </td>
                                            <td style="width: 40%">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                City:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtCity" runat="server" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td>
                                                State/Province:
                                            </td>
                                            <td>
                                                <telerik:RadTextBox ID="txtState" runat="server" AutoPostBack="true">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td>
                                                Country:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox ID="countryComboBox" runat="server" AutoPostBack="true">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 11%">
                                    Status:
                                </td>
                                <td style="width: 59%">
                                    <telerik:RadTextBox ID="txtStatus" runat="server" BackColor="Transparent" Font-Names="Arial"
                                        Font-Size="9pt" ReadOnly="true">
                                    </telerik:RadTextBox>
                                    <asp:HiddenField runat="server" ID="hdnStatusID" />
                                    <asp:HiddenField runat="server" ID="hdnDirectoryName" />
                                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel4" ClientEvents-OnRequestStart="conditionalPostback">
                                        <asp:Button ID="btnStatusChange" runat="server" Text="change" />
                                    </telerik:RadAjaxPanel>
                                </td>
                                <td style="width: 15%">
                                    Date Activated:
                                </td>
                                <td style="width: 20%">
                                    <telerik:RadTextBox ID="txtDateActivated" runat="server" BackColor="Transparent"
                                        Font-Names="Arial" Font-Size="9pt" Width="100%" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 11%; vertical-align: top; padding-top: 5px;">
                                    Cover Picture:
                                </td>
                                <td style="width: 59%">
                                    <table style="width: 100%" border="0">
                                        <tr>
                                            <td style="width: 40%">
                                                <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" ClientEvents-OnRequestStart="conditionalPostback">
                                                    <telerik:RadUpload ID="ruThumbnail" runat="server" ControlObjectsVisibility="None"
                                                        Height="28px" Width="328px" AllowedFileExtensions=".jpg" />
                                                    <asp:Button ID="btnUpload" runat="server" Text="Upload" />
                                                </telerik:RadAjaxPanel>
                                            </td>
                                            <td style="width: 60%">
                                                <%--<asp:Button ID="btnUpload" runat="server" Text="Upload" />--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblUploadedFile" runat="server" ForeColor="green"></asp:Label>
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
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblErrorMessageGrid" runat="server" ForeColor="red" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
               
                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td>
                                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                                    Skin="Outlook" SelectedIndex="0">
                                    <Tabs>
                                        <telerik:RadTab runat="server" Text="Investment Levels" PageViewID="pvBoardLevels"
                                            Selected="True">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" Text="Current Investors" PageViewID="pvConfirmedInvestors">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" Text="Outside Investors" PageViewID="pvUnconfirmedInvestors">
                                        </telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%" SelectedIndex="0"
                                    TabIndex="1">
                                    <telerik:RadPageView ID="pvBoardLevels" runat="server">
                                        <telerik:RadGrid ID="rgBoardInvestorLevel" runat="server" AutoGenerateColumns="False"
                                            AllowSorting="True" GridLines="None" DataSourceID="sdBoardLevel" AutoGenerateEditColumn="False">
                                            <MasterTableView DataSourceID="sdBoardLevel" CommandItemDisplay="Top" DataKeyNames="LevelID">
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
                                                    <telerik:GridBoundColumn DataField="NumRemaining" HeaderText="NumRemaining" SortExpression="NumRemaining"
                                                        UniqueName="NumRemaining" ReadOnly="true">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <CommandItemSettings AddNewRecordText="Add Item" ExportToPdfText="Export to Pdf" />
                                            </MasterTableView>
                                            <HeaderContextMenu EnableAutoScroll="True">
                                            </HeaderContextMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView ID="pvConfirmedInvestors" runat="server">
                                        <telerik:RadGrid ID="rgConfirmedInvestors" runat="server" AutoGenerateColumns="False"
                                            GridLines="None" DataSourceID="sdConfirmedInvestorsDataSource">
                                            <MasterTableView DataSourceID="sdConfirmedInvestorsDataSource">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="UserName" HeaderText="Investors" UniqueName="UserName">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AmountInvested" HeaderText="Amount Invested"
                                                        UniqueName="AmountInvested">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridDateTimeColumn DataField="DateInvested" HeaderText="Date Invested" UniqueName="DateInvested"
                                                        DataFormatString="{0:d}">
                                                    </telerik:GridDateTimeColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <HeaderContextMenu EnableAutoScroll="True">
                                            </HeaderContextMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView ID="pvUnconfirmedInvestors" runat="server">
                                        <telerik:RadGrid ID="rgUnconfirmedInvestors" runat="server" AutoGenerateColumns="False"
                                            GridLines="None" DataSourceID="sdUnconfirmedInvestors">
                                            <MasterTableView DataSourceID="sdUnconfirmedInvestors" CommandItemDisplay="Top">
                                                <Columns>
                                                    <telerik:GridDropDownColumn DataSourceID="sdComboBoxBoardLevelDataSource" HeaderText="Level Name"
                                                        ListTextField="LevelName" ListValueField="LevelID" UniqueName="LevelID" Display="false">
                                                    </telerik:GridDropDownColumn>
                                                    <telerik:GridBoundColumn DataField="LevelName" HeaderText="Level Name" UniqueName="LevelName"
                                                        Display="true" ReadOnly="true">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="EmailAddress" HeaderText="Email Address" UniqueName="EmailAddress">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                                <CommandItemSettings AddNewRecordText="Add Item" ExportToPdfText="Export to Pdf" />
                                            </MasterTableView>
                                            <HeaderContextMenu EnableAutoScroll="True">
                                            </HeaderContextMenu>
                                        </telerik:RadGrid>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </td>
                        </tr>
                    </table>
               
            </td>
        </tr>
    </table>
      </telerik:RadAjaxPanel>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT V.BoardID,V.BoardName,V.Description,V.URL,V.Keywords,V.DateActivated,V.Status,V.English,V.DirectoryName,V.InvType,V.District1,V.AudienceDesc,V.UniquenessDesc,V.RevenueDesc,D.districtID,A.AreaName,A.areaID,V.city,V.state,V.country FROM vBoardDetail V left outer join Districts D on D.districtID =V.district1 left outer join Areas A on A.areaID =D.areaID  Where V.BoardID=@BoardID"
        UpdateCommand="UPDATE Boards SET BoardName=@BoardName,Description=@Description,URL=@URL,Keywords=@Keywords,DirectoryName=@DirectoryName,Status=@Status,InvType=@InvType,District1=@District1,AudienceDesc=@AudienceDesc,UniquenessDesc=@UniquenessDesc,RevenueDesc=@RevenueDesc,city=@city,state=@state,country=@country,DateActivated=@DateActivated,DateDeactivated=@DateDeactivated WHERE BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="BoardName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="URL" Type="String" />
            <asp:Parameter Name="Keywords" Type="String" />
            <asp:Parameter Name="DirectoryName" Type="String" />
            <asp:Parameter Name="Status" Type="int32" />
            <asp:Parameter Name="BoardID" Type="Int32" />
            <asp:Parameter Name="InvType" Type="Int32" />
            <asp:Parameter Name="District1" Type="Int32" />
            <asp:Parameter Name="AudienceDesc" Type="String" />
            <asp:Parameter Name="UniquenessDesc" Type="String" />
            <asp:Parameter Name="RevenueDesc" Type="String" />
            <asp:Parameter Name="city" Type="String" />
            <asp:Parameter Name="state" Type="String" />
            <asp:Parameter Name="country" Type="String" />
            <asp:Parameter Name="DateActivated" Type="DateTime" DefaultValue=""/>
            <asp:Parameter Name="DateDeactivated" Type="DateTime" DefaultValue=""/>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardLevel" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString %>"
        SelectCommand="SELECT Status,LevelName,Description,NumOffered,LevelAmount,LevelID,NumRemaining FROM vBoardLevel WHERE BoardID=@BoardID"
        InsertCommand="INSERT INTO [BoardLevels]([BoardID],[LevelName],[Description],NumOffered,LevelAmount) VALUES
            (@BoardId,@LevelName,@Description,@NumOffered,@LevelAmount)" UpdateCommand="UPDATE BoardLevels SET LevelName=@LevelName,Description=@Description,NumOffered=@NumOffered,LevelAmount=@LevelAmount WHERE LevelID =@LevelID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" Type="int32" />
            <asp:Parameter Name="LevelName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="NumOffered" Type="int32" />
            <asp:Parameter Name="LevelAmount" Type="int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="LevelName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="NumOffered" Type="Int64" />
            <asp:Parameter Name="LevelAmount" Type="Int64" />
            <asp:Parameter Name="LevelID" Type="Int64" />
            <asp:Parameter Name="BoardID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdConfirmedInvestorsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT PI.UserID,U.UserName,PI.AmountInvested,PI.DateInvested,PI.BoardID FROM BoardInvestors PI INNER JOIN Users U ON PI.UserID=U.UserID  WHERE BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUnconfirmedInvestors" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardID,EmailAddress,Name,Status,LevelName FROM vUnConfirmedInvestors  WHERE BoardID=@BoardID"
        InsertCommand="INSERT INTO UnconfirmedInvestors (BoardID,EmailAddress,Name,BoardLevel) VALUES (@BoardID,@EmailAddress,@Name,@BoardLevel)">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardLevel" Type="Int64" />
            <asp:Parameter Name="BoardID" Type="Int64" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdComboBoxBoardLevelDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BL.LevelID,BL.LevelName FROM BoardLevels BL WHERE BL.BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBillingInformationDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="select address,city,state,zip,socialsecuritynumber from Users WHERE UserID=@UserID">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdGetBoardIdDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardId from Boards WHERE DirectoryName=@Name and UserID=@UserID">
        <SelectParameters>
            <asp:QueryStringParameter Name="Name" QueryStringField="Name" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCountry" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select '0' as CountryID,'--Select Country--' as CountryName from CountryMaster Union Select CountryID,CountryName from CountryMaster">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdComboBoxInvestmentType" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Value,EnglishName FROM InvestmentType"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdComboBoxAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT 0 as AreaID,'--Select Area--' as AreaName from Areas UNION SELECT AreaID,AreaName FROM Areas">
        <%--<SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="userName" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdComboBoxDistrict" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT 0 as DistrictID,'--Select District--' as DistrictName from Districts union SELECT DistrictID,DistrictName FROM Districts WHERE AreaID=@AreaID">
        <SelectParameters>
            <asp:Parameter Name="AreaID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCheckDistrictAndLevel" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT B.BoardID,CASE WHEN B.District1 IS NOT NULL AND (SELECT count(*) FROM BoardLevels BL WHERE BL.BoardID=B.BoardID)>0 THEN '1' ELSE '0' END As [Status] FROM boards B WHERE B.BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadWindowManager ID="rwLicense" runat="server" Height="200px" Width="300px">
        <Windows>
            <telerik:RadWindow runat="server" ID="RadWindow1" Behaviors="Close" OnClientClose="OnClientClose">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
