<%@ Page Title="Investment Types" Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    CodeBehind="InvestmentTypes.aspx.vb" Inherits="CrowdBoardsApp.InvestmentTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
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
                    <telerik:RadGrid ID="rgInvestmentTypes" runat="server" AutoGenerateColumns="False"
                        Width="100%" GridLines="None" DataSourceID="sdInvestmentTypes" AutoGenerateEditColumn="true">
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                        <MasterTableView DataSourceID="sdInvestmentTypes" CommandItemDisplay="Top" DataKeyNames="Value">
                            <Columns>
                                <telerik:GridBoundColumn DataField="EnglishName" HeaderText="English Name" UniqueName="EnglishName"
                                    HeaderStyle-Width="200px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EnglishDescription" HeaderText="Description"
                                    UniqueName="EnglishDescription" HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ShortEnglishDesc" HeaderText="ShortEnglishDesc"
                                    UniqueName="ShortEnglishDesc" HeaderStyle-Width="300px">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Image ID="InvestmentTypePic" runat="server" Height="50px" Width="50px" AlternateText="No Image"
                                            ImageUrl='<%# Eval("Value", "~/Upload/InvestmentTypePics/{0}.jpg") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Upload Image" UniqueName="UploadImage" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <telerik:RadUpload ID="ruImage" runat="server" ControlObjectsVisibility="None" AllowedFileExtensions=".jpg">
                                        </telerik:RadUpload>
                                        <asp:Button ID="btnUpload" runat="server" Text="upload" CommandName="upload" />
                                        <asp:HiddenField ID="hfValue" runat="server" Value='<%#Eval("Value") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Model" UniqueName="Model" HeaderStyle-Width="300px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWePayModel" runat="server" Text='<%#Eval("WePayModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList ID="ddlModel" runat="server">
                                            <Items>
                                                <telerik:DropDownListItem Text="--Select Model--" Value="--Select Model--" Selected="true" />
                                                <telerik:DropDownListItem Text="PreApproval" Value="PreApproval" />
                                                <telerik:DropDownListItem Text="DirectCheckout" Value="DirectCheckout" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemSettings AddNewRecordText="Add Investment Type" ExportToPdfText="Export to Pdf"
                                ShowAddNewRecordButton="false" />
                        </MasterTableView>
                        <HeaderContextMenu EnableAutoScroll="True">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sdInvestmentTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CrowdBoardsConnectionString%>"
        SelectCommand="SELECT Value,EnglishName,EnglishDescription,FrenchName,FrenchDescription,WePayModel,ShortEnglishDesc FROM InvestmentType"
        UpdateCommand="UPDATE InvestmentType SET EnglishName=@EnglishName,EnglishDescription=@EnglishDescription,WePayModel=@WePayModel,ShortEnglishDesc=@ShortEnglishDesc WHERE Value=@Value">
        <UpdateParameters>
            <asp:Parameter Name="EnglishName" Type="String" />
            <asp:Parameter Name="EnglishDescription" Type="String" />
            <asp:Parameter Name="ShortEnglishDesc" Type="String" />
            <asp:Parameter Name="Value" Type="Int32" />
            <asp:Parameter Name="WePayModel" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
