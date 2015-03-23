<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="rwAddExtra.aspx.vb" Inherits="CrowdBoardsApp.rwAddExtra" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Extra</title>
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="Css/Style.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="js/DateFormat.js" type="text/javascript"></script>
    <style type="text/css">
        .boardImage
        {
            /* Hide the DIV */
            position: fixed;
            _position: absolute; /* hack for internet explorer 6 */
            height: 60px;
            width: 60px;
            background: #ececee;
            left: 470px;
            top: 200px;
            z-index: 200; /* Layering ( on-top of others), if you have lots of layers: I just maximized, you can change it yourself */
            margin-left: 15px; /* additional features, can be omitted */ /* border: 2px solid gray;*/
            font-size: 15px;
            -moz-box-shadow: 0 0 5px silver;
            -webkit-box-shadow: 0 0 5px silver;
            box-shadow: 0 0 5px silver;
            overflow: auto;
            overflow-x: hidden;
        }
    </style>
</head>
<body class="backgroundColorAndFontColor">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            function closeMe() {
                var oWindow = GetRadWindow();
                oWindow.Close();
            }
            function Cancel() {
                var oWindow = GetRadWindow();
                oWindow.Close("CANCEL");
            }

            function Ok() {
                //alert(page);
                var url;
                var oWindow = GetRadWindow();
                url = "CreateCrowdboard.aspx";
                oWindow.Close(url);
            }

            function fileUploadedBackground(sender, args) {
                document.getElementById("<%= btnBackgroungPicture.ClientID %>").click();
            }
            function fileUploadedCover(sender, args) {
                document.getElementById("<%= btnCoverPicture.ClientID %>").click();
            }
            function fileUploadedBoard(sender, args) {
                document.getElementById("<%= btnBoardFiles.ClientID %>").click();
            }
        </script>
    </telerik:RadScriptBlock>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnBackgroungPicture" />
            <asp:PostBackTrigger ControlID="btnCoverPicture" />
            <asp:PostBackTrigger ControlID="btnBoardFiles" />
        </Triggers>
        <ContentTemplate>
            <div id="boardImageDiv" runat="server" class="boardImage">
            <asp:Image ID="imgProfile" runat="server" Height="60px" Width="60px" />
               <%-- <img id="imgBoardPic" runat="server" height="60" width="60" />--%>
            </div>
            <br />
            <div style="margin-left: 30px; text-align: center;">
                <asp:Label ID="lblMessageAddExtra" runat="server"></asp:Label>
                <asp:Button ID="btnBackgroungPicture" runat="server" Text="Upload" Style="display: none;" />
                <asp:Button ID="btnCoverPicture" runat="server" Text="Upload" Style="display: none;" />
                <asp:Button ID="btnBoardFiles" runat="server" Text="Upload" Style="display: none;" />
            </div>
            <div style="width: 100%; border-bottom-color: #99CCFF; border-bottom-style: solid;
                border-bottom-width: medium;">
                <table width="100%" border="0">
                    <tr>
                        <td style="width: 8%;">
                            <img src="Images/previousInsiderNews.png" height="40" width="60" style="cursor: pointer;"
                                onclick="return closeMe();" />
                        </td>
                        <td style="width: 20%;">
                            <span class="LabelheadingWhiteLarger">Add Extra</span>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnDesign" runat="server" ForeColor="#ececee">Design</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnMoreInfo" runat="server" ForeColor="#ececee">More Info</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnMediaLinks" runat="server" ForeColor="#ececee">Media Links</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnUploadFiles" runat="server" ForeColor="#ececee">Upload Files</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnCrowdBoardTeam" runat="server" ForeColor="#ececee">CrowdBoard Team</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnPreview" runat="server" ForeColor="#ececee" Visible="false">Preview</asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 15px; width: 100%;">
                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%" SelectedIndex="0">
                    <telerik:RadPageView ID="designView" runat="server">
                        <div style="width: 100%; margin-top: 15px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td colspan="2">
                                        <div style="margin-left: 30px; text-align: center;">
                                            <asp:Label ID="lblMessageDesign" runat="server"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 45%; vertical-align: top;">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <span class="LabelheadingWhite">Add Background Picture</span>
                                                </td>
                                                <td>
                                                    <span>
                                                        <telerik:RadAsyncUpload ID="rauBackgroundPicture" runat="server" MultipleFileSelection="Disabled"
                                                            OnClientFilesUploaded="fileUploadedBackground" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx"
                                                            AllowedFileExtensions=".jpg">
                                                        </telerik:RadAsyncUpload>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                    <span class="LabelheadingWhite">Add Cover Picture</span>
                                                </td>
                                                <td>
                                                    <br />
                                                    <span>
                                                        <telerik:RadAsyncUpload ID="rauCoverPicture" runat="server" MultipleFileSelection="Disabled"
                                                            OnClientFilesUploaded="fileUploadedCover" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx"
                                                            AllowedFileExtensions=".jpg">
                                                        </telerik:RadAsyncUpload>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                    <span class="LabelheadingWhite">Youtube Video url</span>
                                                </td>
                                                <td>
                                                    <br />
                                                    <span>
                                                        <telerik:RadTextBox ID="txtYoutubeVideoUrl" runat="server" Width="100%" BackColor="#ececee"
                                                            ForeColor="#262626">
                                                        </telerik:RadTextBox>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:Button ID="btnAddToCrowdboardDesign" runat="server" Text="ADD TO CROWDBOARD"
                                                        CssClass="primaryButton" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 55%;">
                                        <div id="backgroundDiv" runat="server" style="width: 95%; height: 400px; border-color: #99CCFF;
                                            border-style: solid; border-width: thin; background-color: #262626;">
                                            <div style="width: 100%; height: 15%;">
                                                &nbsp;
                                            </div>
                                            <div style="width: 100%; height: 70%;">
                                                <div style="width: 15%; height: 100%; float: left;">
                                                    &nbsp;
                                                </div>
                                                <div style="width: 70%; height: 100%; float: left; border-color: #99CCFF; border-style: solid;
                                                    border-width: thin; background-color: #262626;">
                                                    <div id="coverPicDiv" runat="server" style="width: 100%; height: 30%; border-bottom-color: #99CCFF;
                                                        border-bottom-style: solid; border-bottom-width: thin; background-color: #262626;">
                                                        &nbsp;
                                                    </div>
                                                    <div style="width: 100%; height: 70%;">
                                                        &nbsp;
                                                    </div>
                                                </div>
                                                <div style="width: 15%; height: 15%; float: right;">
                                                    &nbsp;
                                                </div>
                                            </div>
                                            <div style="width: 100%; height: 15%;">
                                                &nbsp;
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="moreInfoView" runat="server">
                        <div style="margin-top: 30px;">
                            <div style="width: 50%; float: left;">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="LabelheadingWhiteLarger">More
                                    Info</span></div>
                            <div style="width: 50%; float: right; text-align: right;">
                                <span class="LabelheadingWhiteLarger">Add Tags</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                        </div>
                        <div style="height: 30px; width: 100%; text-align: center;">
                            &nbsp;
                            <asp:Label ID="lblMessageMoreInfo" runat="server"></asp:Label></div>
                        <div style="margin-top: 20px; text-align: center;">
                            <telerik:RadEditor ID="reCreatePage" runat="server" Width="95%" Height="370px" Style="margin-left: 18px;">
                            </telerik:RadEditor>
                        </div>
                        <div style="margin-top: 20px; text-align: right;">
                            <asp:Button ID="btnSaveMoreInfo" runat="server" Text="SAVE MORE INFO" CssClass="primaryButton" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="mediaLinksView" runat="server">
                        <div style="margin-top: 30px;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="LabelheadingWhiteLarger">Media
                                Links</span>
                        </div>
                        <div>
                            <br />
                            <span style="margin-left: 70px;" class="LabelheadingWhite">Feel free to add links that
                                will help you present your CrowdBoard</span>
                        </div>
                        <div style="margin-top: 20px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td colspan="3">
                                        <div style="text-align: center;">
                                            <asp:Label ID="lblMessageMediaLinks" runat="server"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 40%; vertical-align: top;">
                                        <br />
                                        <table width="100%;">
                                            <tr>
                                                <td style="width: 20%; text-align: right;">
                                                    <span class="LabelheadingWhite">Name</span>
                                                </td>
                                                <td style="width: 80%; vertical-align: top;">
                                                    <telerik:RadTextBox ID="txtMediaLinkName" runat="server" Width="95%" BackColor="#ececee"
                                                        ForeColor="#262626">
                                                    </telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="rfvMediaLinksName" runat="server" ControlToValidate="txtMediaLinkName"
                                                        ForeColor="Red" ErrorMessage="Name is Required" ValidationGroup="AddMediaLinks">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; text-align: right;">
                                                    <span class="LabelheadingWhite">Url</span>
                                                </td>
                                                <td style="width: 80%; vertical-align: top;">
                                                    <telerik:RadTextBox ID="txtMediaLinkUrl" runat="server" Width="95%" BackColor="#ececee"
                                                        ForeColor="#262626">
                                                    </telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="rfvMediaLinksUrl" runat="server" ControlToValidate="txtMediaLinkUrl"
                                                        ForeColor="Red" ErrorMessage="Url is Required" ValidationGroup="AddMediaLinks">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddMediaLink" runat="server" Text="ADD" CssClass="primaryButton"
                                                        ValidationGroup="AddMediaLinks" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 60%;">
                                        <telerik:RadGrid ID="rgBoardMediaLinks" runat="server" AutoGenerateColumns="False"
                                            GridLines="None" AllowPaging="true" PageSize="5">
                                            <MasterTableView DataKeyNames="ID">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="urlNameLabel" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                            <asp:HiddenField ID="hdnName" runat="server" Value='<%#Eval("Name") %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Url" UniqueName="Url">
                                                        <ItemTemplate>
                                                            <asp:Label ID="urlLabel" runat="server" Text='<%#Eval("Url") %>'></asp:Label>
                                                            <asp:HiddenField ID="hdnUrl" runat="server" Value='<%#Eval("Url") %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="DateCreated" SortExpression="DateCreated" HeaderText="Date Created"
                                                        UniqueName="DateCreated" DataType="System.DateTime" DataFormatString="{0:d}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="editLinkImageButton" Height="15px" Width="15px" runat="server"
                                                                ImageUrl="~/Images/1379101373_pencil.png" ToolTip="Edit" CommandName="IEdit"
                                                                CommandArgument='<%#Eval("ID")%>' />
                                                            <asp:ImageButton ID="deleteLinkImageButton" Height="15px" Width="15px" runat="server"
                                                                OnClientClick="return confirm('Are you sure you want to Delete?')" ImageUrl="~/Images/delete.png"
                                                                ToolTip="Delete" CommandName="IDelete" CommandArgument='<%#Eval("ID")%>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="uploadFilesView" runat="server">
                        <div style="margin-top: 30px;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="LabelheadingWhiteLarger">Upload
                                Files</span>
                        </div>
                        <div>
                            <br />
                            <span style="margin-left: 70px;" class="LabelheadingWhite">Please Upload any files that
                                will help you present your CrowdBoard</span>
                        </div>
                        <div style="margin-top: 20px;">
                            <table width="100%" border="0">
                                <tr>
                                    <td colspan="3">
                                        <div style="text-align: center;">
                                            <asp:Label ID="lblMesaageUploadFiles" runat="server"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; vertical-align: top;">
                                        <span class="LabelheadingWhite">Select File</span>
                                    </td>
                                    <td style="width: 20%; vertical-align: top;">
                                        <telerik:RadAsyncUpload ID="rauBoardFiles" runat="server" MultipleFileSelection="Disabled"
                                            OnClientFilesUploaded="fileUploadedBoard" Width="200px" HttpHandlerUrl="~/CustomHandler.ashx">
                                        </telerik:RadAsyncUpload>
                                    </td>
                                    <td style="width: 70%;">
                                        <telerik:RadGrid ID="rgBoardFiles" runat="server" AutoGenerateColumns="False" GridLines="None"
                                            AllowPaging="true" PageSize="5">
                                            <MasterTableView DataKeyNames="ID">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="FileName" UniqueName="FileName">
                                                        <ItemTemplate>
                                                            <asp:Label ID="fileNameLabel" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                                                            <asp:HiddenField ID="hdnFileName" runat="server" Value='<%#Eval("FileName") %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="DateUploaded" SortExpression="DateUploaded" HeaderText="Date Uploaded"
                                                        UniqueName="DateUploaded" DataType="System.DateTime" DataFormatString="{0:d}">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="deleteFileImageButton" Height="15px" Width="15px" runat="server"
                                                                OnClientClick="return confirm('Are you sure you want to Delete?')" ImageUrl="~/Images/delete.png"
                                                                ToolTip="Delete" CommandName="IDelete" CommandArgument='<%#Eval("ID")%>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="crowdBoardTeamView" runat="server">
                        <div style="margin-top: 30px;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span class="LabelheadingWhiteLarger">CrowdBoard
                                Team</span>
                        </div>
                        <div>
                            <br />
                            <span style="margin-left: 70px;" class="LabelheadingWhite">Invite CrowdBoarders who
                                are involved in your CrowdBoard to be on your "CrowdBoard Team"</span>
                        </div>
                        <div style="margin-top: 20px;">
                            <div style="width: 20%; float: left;">
                                &nbsp;
                            </div>
                            <div style="width: 60%; float: left;">
                                <table width="100%" border="0">
                                    <tr>
                                        <td colspan="2">
                                            <div style="text-align: center;">
                                                <asp:Label ID="lblMessageCrowdboardTeam" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <span class="LabelheadingWhite">Invite CrowdBoarder</span>
                                        </td>
                                        <td style="width: 70%;">
                                            <telerik:RadComboBox ID="cbAllBoardersList" runat="server" DataTextField="Name" DataValueField="Userid"
                                                DataSourceID="sdAllBoardersList" Width="60%">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvBoarder" runat="server" ControlToValidate="cbAllBoardersList"
                                                ForeColor="Red" ToolTip="Select Boarder" ValidationGroup="AddCrowdboardTeam"
                                                Display="Dynamic" InitialValue="--Select Boarder--">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <span class="LabelheadingWhite">Title</span>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtRequestTitle" runat="server" Width="80%" BackColor="#ececee"
                                                ForeColor="#262626">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right; vertical-align: top;">
                                            <span class="LabelheadingWhite">Description</span>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtRequestDescription" runat="server" TextMode="MultiLine"
                                                Rows="5" Width="80%" BackColor="#ececee" ForeColor="#262626">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSendrRequest" runat="server" Text="Send Request" CssClass="primaryButton"
                                                ValidationGroup="AddCrowdboardTeam" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style="width: 20%; float: right;">
                                &nbsp;</div>
                        </div>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="previewView" runat="server">
                        priview
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="sdUpdateUrlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Boards SET YoutubeVideoUrl=@YoutubeVideoUrl where DirectoryName=@DirectoryName">
        <UpdateParameters>
            <asp:Parameter Name="YoutubeVideoUrl" />
            <asp:Parameter Name="DirectoryName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoard" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT UserID,BoardID,Boardname,InvType,Description,city,Country,Investors,Watches,Comments,'$'+ convert(varchar(12),cast(RaisedTotal as dec(10,0)),1) As RaisedTotal,'$'+ convert(varchar(12),cast(TotalOffer as dec(10,0)),1) As TotalOfferText,DirectoryName,ISNULL(city,'')+' '+ISNULL (country,'') as Location,ViewsCount,TotalOffer,URL,areaID,Tags,YoutubeVideoUrl,Offer,VisibilityType,District,Areaname  FROM vwBoardInfo  Where BoardID=@BoardID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardFiles" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * FROM BoardFiles Where BoardID=@BoardID" InsertCommand="INSERT INTO BoardFiles(BoardID,FileName,FilePath,DateUploaded) VALUES(@BoardID,@FileName,@FilePath,GETDATE())"
        DeleteCommand="DELETE FROM BoardFiles WHERE ID=@ID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="FileName" />
            <asp:Parameter Name="FilePath" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdBoardMediaLinks" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT * FROM BoardMediaLinks Where BoardID=@BoardID" InsertCommand="INSERT INTO BoardMediaLinks(BoardID,Name,Url,DateCreated) VALUES(@BoardID,@Name,@Url,GETDATE())"
        DeleteCommand="DELETE FROM BoardMediaLinks WHERE ID=@ID" UpdateCommand="UPDATE BoardMediaLinks SET Name=@Name,Url=@Url,DateModified=GETDATE() WHERE ID=@ID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Url" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Url" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdAllBoardersList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT '--Select Boarder--' as Name,0  Userid,0 as indexs union SELECT isnull(FirstName,'')+' '+isnull(LastName,'') as Name,Userid,1 as indexs from Users WHERE UserID<>41 and  username is not null and status=1 order by indexs">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdCrowdBoardTeam" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT BoardID,MemberID,status,RequestTitle,Description FROM BoardOwners WHERE BoardID=@BoardID AND MemberID=@MemberID"
        InsertCommand="INSERT INTO BoardOwners(BoardID,MemberID,status,DateRequested,Description,RequestTitle) VALUES(@BoardID,@MemberID,0,getdate(),@Description,@RequestTitle)"
        UpdateCommand="UPDATE BoardOwners SET status=0,DateRequested=GETDATE(),DateRejected=null,Description=@Description,RequestTitle=@RequestTitle WHERE BoardID=@BoardID AND MemberID=@MemberID">
        <SelectParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
            <asp:Parameter Name="RequestTitle" />
            <asp:Parameter Name="Description" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="MemberID" />
            <asp:Parameter Name="RequestTitle" />
            <asp:Parameter Name="Description" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUpdateCreatePageUrl" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        UpdateCommand="UPDATE Boards SET URL=@Url where BoardID=@BoardID">
        <UpdateParameters>
            <asp:Parameter Name="BoardID" />
            <asp:Parameter Name="Url" />
        </UpdateParameters>
    </asp:SqlDataSource>
</body>
</html>
