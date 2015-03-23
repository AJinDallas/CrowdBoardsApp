<%@ Page Title="Districts" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="Districts.aspx.vb" Inherits="CrowdBoardsApp.Districts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
         
            var btnDistrictUploadID;
           
            function OnClientClicked() {

                if (!window.confirm("Are you sure ?")) {
                    return false;
                }
                else {
                    return true;
                }
            }
          
            function DistrictUploadButtonClick(btnDistrictID) {
                btnDistrictUploadID = btnDistrictID
            }

            function districtFileUploaded(sender, args) {
                document.getElementById(btnDistrictUploadID).click();
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
                    <telerik:RadGrid ID="rgDistricts" runat="server" AutoGenerateColumns="False" GridLines="None"
                        Width="100%" DataSourceID="sdDistricts" AutoGenerateEditColumn="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView DataSourceID="sdDistricts" CommandItemDisplay="Top" DataKeyNames="DistrictID">
                            <Columns>
                                <%--<telerik:GridDropDownColumn DataSourceID="sdAreasComboBox" HeaderText="Area Name"
                                                        ListTextField="AreaName" ListValueField="AreaID" UniqueName="AreaID" Display="false">
                                                    </telerik:GridDropDownColumn>--%>
                                <telerik:GridBoundColumn DataField="DistrictName" HeaderText="Districts" UniqueName="DistrictName"
                                    HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Logo" UniqueName="Logo" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Image ID="districtPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                            ImageUrl='<%# Eval("DistrictID", "~/Upload/DistrictPics/{0}.jpg") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Description" HeaderText="Description" UniqueName="Description"
                                    HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Quotation" HeaderText="Quotation" UniqueName="Quotation"
                                    HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridBoundColumn DataField="AreaName" HeaderText="Area" UniqueName="AreaName"
                                                        HeaderStyle-Width="200px" ReadOnly="true">
                                                    </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="[#Boards]" HeaderText="#Boards" UniqueName="#Boards"
                                    HeaderStyle-Width="200px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="[#Active]" HeaderText="#Active" UniqueName="#Active"
                                    HeaderStyle-Width="200px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AmountInvested" HeaderText="AmountInvested" UniqueName="AmountInvested"
                                    HeaderStyle-Width="200px" ReadOnly="true" DataFormatString="{0:c}">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Upload Logo" UniqueName="UploadLogo" HeaderStyle-Width="200px">
                                    <ItemTemplate>
                                        <telerik:RadAsyncUpload ID="rAsyncUploadDistric" runat="server" MultipleFileSelection="Automatic"
                                            OnClientFilesUploaded="districtFileUploaded" HttpHandlerUrl="~/CustomHandler.ashx">
                                        </telerik:RadAsyncUpload>
                                        <asp:Button ID="btnDistrictUpload" runat="server" Text="upload" CommandName="upload"
                                            Style="display: none;" />
                                        <asp:HiddenField ID="hfDistrictID" runat="server" Value='<%#Eval("DistrictID") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Manager" UniqueName="Manager">
                                    <ItemTemplate>
                                        <asp:Label ID="lblManager" runat="server" Text='<%#Eval("ManagerName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList ID="ddlUserList" runat="server" DataSourceID="sdUserList"
                                            DataTextField="UserName" DataValueField="UserID">
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <%--<asp:HiddenField ID="areaIDHiddenField" runat="server" Value='<%#Eval("areaID") %>' />--%>
                                        <asp:LinkButton ID="moveUpColumnPositionLinkButton" Visible='<%#  IIf(Eval("SortOrderDes").ToString() = "Last" Or (Eval("SortOrderDes").ToString() = "No"), True,False )%>'
                                            runat="server" CommandName="MoveUp" ToolTip="Move Column Position Up" CommandArgument='<%#Eval("DistrictID")%>'>
                                            <img id="upArrow" runat="server" src="~/Images/up_arrow.png" height="12" width="12" /></asp:LinkButton>
                                        <asp:LinkButton ID="moveDownColumnPositionLinkButton" Visible='<%#  IIf((Eval("SortOrderDes").ToString() = "First") Or (Eval("SortOrderDes").ToString() = "No"), True,False )%>'
                                            runat="server" CommandName="MoveDown" ToolTip="Move Column Position Down" CommandArgument='<%#Eval("DistrictID")%>'>
                                            <img id="downArrow" runat="server" src="~/Images/down_arrow.png" height="12" width="12" /></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Button ID="deleteRadButton" runat="server" Text="Delete" CommandName="IDelete"
                                            CssClass="primaryMiniButton " Visible='<%#  IIf((Convert.ToInt16(Eval("[#Boards]"))>0), False, True) %>'
                                            OnClientClick="return OnClientClicked();"></asp:Button>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemSettings AddNewRecordText="Add District" ExportToPdfText="Export to Pdf" />
                        </MasterTableView>
                        <HeaderContextMenu EnableAutoScroll="True">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdDistricts" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Select * from vwDistrictsLoadAll order by SortOrder" InsertCommand="Districts_Insert"
        InsertCommandType="StoredProcedure" UpdateCommand="UPDATE Districts SET DistrictName=@DistrictName,Description=@Description,Quotation=@Quotation,Manager=NullIf(@Manager,0) WHERE DistrictID=@DistrictID"
        DeleteCommand="DELETE FROM Districts WHERE DistrictID=@DistrictID">
        <InsertParameters>
            <asp:Parameter Name="DistrictName" Type="String" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Quotation" />
            <asp:Parameter Name="Manager" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="DistrictName" Type="String" />
            <asp:Parameter Name="DistrictID" Type="Int32" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="Quotation" />
            <asp:Parameter Name="Manager" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="DistrictID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdDistrictsSortOrder" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="Districts_ReOrderPosition" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="action" Type="String" />
            <%--<asp:Parameter Name="areaID" Type="String" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdUserList" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT '--Select User--' as UserName,0  UserID,0 as indexs union SELECT UserName,UserID,1 as indexs from Users WHERE Status=1 and UserName is not null order by indexs">
    </asp:SqlDataSource>
</asp:Content>
