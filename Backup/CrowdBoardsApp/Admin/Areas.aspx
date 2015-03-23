<%@ Page Title="Areas" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="Areas.aspx.vb" Inherits="CrowdBoardsApp.Areas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            var btnUploadID;

           
            function OnClientClicked() {

                if (!window.confirm("Are you sure ?")) {
                    return false;
                }
                else {
                    return true;
                }
            }
            function UploadButtonClick(btnID) {
                btnUploadID = btnID
            }

            function fileUploaded(sender, args) {
                document.getElementById(btnUploadID).click();
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
                    <telerik:RadGrid ID="rgAreas" runat="server" AutoGenerateColumns="False" GridLines="None"
                        Width="100%" DataSourceID="sdAreas" AutoGenerateEditColumn="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView DataSourceID="sdAreas" CommandItemDisplay="Top" DataKeyNames="areaID">
                            <Columns>
                                <telerik:GridDropDownColumn DataSourceID="sdDistrictComboBox" HeaderText="District Name"
                                    ListTextField="DistrictName" ListValueField="districtID" UniqueName="districtID"
                                    Display="false">
                                </telerik:GridDropDownColumn>
                                <telerik:GridBoundColumn DataField="AreaName" HeaderText="Areas" UniqueName="AreaName"
                                    HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Logo" UniqueName="Logo" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Image ID="areaPic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                            ImageUrl='<%# Eval("areaID", "~/Upload/AreasPics/{0}.jpg") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="DistrictName" HeaderText="District" UniqueName="DistrictName"
                                    HeaderStyle-Width="200px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="[#Boards]" HeaderText="#Boards" UniqueName="#Boards"
                                    HeaderStyle-Width="200px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="[#Active]" HeaderText="#Active" UniqueName="#Active"
                                    HeaderStyle-Width="200px" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AmountInvested" HeaderText="AmountInvested" UniqueName="AmountInvested"
                                    HeaderStyle-Width="200px" ReadOnly="true" DataFormatString="{0:c}">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Upload Logo" UniqueName="UploadLogo" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Automatic"
                                            OnClientFilesUploaded="fileUploaded" HttpHandlerUrl="~/CustomHandler.ashx">
                                        </telerik:RadAsyncUpload>
                                        <asp:Button ID="btnUpload" runat="server" Text="upload" CommandName="upload" Style="display: none" />
                                        <asp:HiddenField ID="hfareaID" runat="server" Value='<%#Eval("areaID") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="Action" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="districtIDHiddenField" runat="server" Value='<%#Eval("districtID") %>' />
                                        <asp:LinkButton ID="moveUpColumnPositionLinkButton" Visible='<%#  IIf(Eval("SortOrderDes").ToString() = "Last" Or (Eval("SortOrderDes").ToString() = "No"), True,False )%>'
                                            runat="server" CommandName="MoveUp" ToolTip="Move Column Position Up" CommandArgument='<%#Eval("areaID")%>'>
                                            <img id="upArrow" runat="server" src="~/Images/up_arrow.png" height="12" width="12" /></asp:LinkButton>
                                        <asp:LinkButton ID="moveDownColumnPositionLinkButton" Visible='<%#  IIf((Eval("SortOrderDes").ToString() = "First") Or (Eval("SortOrderDes").ToString() = "No"), True,False )%>'
                                            runat="server" CommandName="MoveDown" ToolTip="Move Column Position Down" CommandArgument='<%#Eval("areaID")%>'>
                                            <img id="downArrow" runat="server" src="~/Images/down_arrow.png" height="12" width="12" /></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Button ID="deleteRadButton" runat="server" Text="Delete" CommandName="IDelete"
                                            CssClass="primaryMiniButton" OnClientClick="return OnClientClicked();" Visible='<%#  IIf((Convert.ToInt16(Eval("[#Boards]"))>0), False, True) %>'>
                                        </asp:Button>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemSettings AddNewRecordText="Add Area" ExportToPdfText="Export to Pdf" />
                        </MasterTableView>
                        <HeaderContextMenu EnableAutoScroll="True">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
     <asp:SqlDataSource ID="sdAreas" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT areaID,AreaName,districtID,districtName,SortOrder,SortOrderDes,[#Boards],[#Active],AmountInvested FROM vwAreaLoadAll order by SortOrder"
            InsertCommand="Areas_Insert" InsertCommandType="StoredProcedure" UpdateCommand="UPDATE Areas SET AreaName=@AreaName,districtID=@districtID WHERE areaID=@areaID"
            DeleteCommand="DELETE FROM Areas WHERE areaID=@areaID">
            <InsertParameters>
                <asp:Parameter Name="AreaName" Type="String" />
                <asp:Parameter Name="districtID" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="AreaName" Type="String" />
                <asp:Parameter Name="areaID" Type="Int32" />
                <asp:Parameter Name="districtID" Type="Int32" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="areaID" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdDistrictComboBox" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="SELECT 0 as districtID,'--Select District--' AS DistrictName   UNION  SELECT districtID ,DistrictName  FROM Districts">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdAreaSortOrder" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
            SelectCommand="Areas_ReOrderPosition" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="Id" Type="Int32" />
                <asp:Parameter Name="action" Type="String" />
                <asp:Parameter Name="districtID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>
