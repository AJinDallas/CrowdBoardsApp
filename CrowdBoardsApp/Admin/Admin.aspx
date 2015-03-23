<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/publicMaster.master"
    Title="Admin" CodeBehind="Admin.aspx.vb" Inherits="CrowdBoardsApp.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css' />
    <link href="../Css/Register.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/ico" href="https://www.crowdboarders.com/Images/favicon.ico" />
    <style type="text/css">
        .div
        {
            display: inline-block;
            width: 150px;
            height: 100px;
            margin: 0;
            background: silver;
            text-align:center;
            vertical-align:middle;
        }
        #one
        {
            background: silver;
        }
        #two
        {
            background: silver;
        }
        #three
        {
            background: silver;
        }
         #four
        {
            background: silver;
        }
         #five
        {
            background: silver;
        }
         #six
        {
            background: silver;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div style="border: 0px solid; float: left; width: 100%; margin-bottom: 10px;">
        <table style="z-index: 120; margin: auto" cellspacing="3" cellpadding="0" width="849"
            border="0">
            <tr>
                <td colspan="3">
                    <div class="div">
                        <asp:LinkButton ID="lbtnUsers" runat="server" Text="All Users" PostBackUrl="~/Admin/Users.aspx"></asp:LinkButton>
                    </div>
                    <div class="div" >
                        <asp:LinkButton ID="lbtnBoards" runat="server" Text="All Boards" PostBackUrl="~/Admin/Boards.aspx"></asp:LinkButton>
                    </div>
                    <div class="div" >
                        <asp:LinkButton ID="lbtnPosts" runat="server" Text="All Posts" PostBackUrl="~/Admin/Posts.aspx"></asp:LinkButton>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="div" >
                        <asp:LinkButton ID="lbtnDistricts" runat="server" Text="Districts" PostBackUrl="~/Admin/Districts.aspx"></asp:LinkButton>
                    </div>
                    <div class="div" >
                        <asp:LinkButton ID="lbtnAreas" runat="server" Text="Areas" PostBackUrl="~/Admin/Areas.aspx"></asp:LinkButton>
                    </div>
                    <div class="div" >
                        <asp:LinkButton ID="lbtnInvestmentTypes" runat="server" Text="Investment Types" PostBackUrl="~/Admin/InvestmentTypes.aspx"></asp:LinkButton>
                    </div>
                </td>
               
            </tr>
        </table>
    </div>
</asp:Content>
