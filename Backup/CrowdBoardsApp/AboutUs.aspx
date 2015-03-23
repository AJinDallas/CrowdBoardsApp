<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AboutUs.aspx.vb" Inherits="CrowdBoardsApp.AboutUs" 
Title="About Us" MasterPageFile="~/MasterPage/SiteMaster.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>About Us</title>
    </asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">  
	<!--        Main Body     -->
   	<div class = "main-body">
		<center><h1>About</h1></center><br/>
       <p> Allow us to introduce ourselves we are CrowdBoarders: people who make a difference.<p><br>
       We have built the worlds first social network with a purpose: to change things for the better. We do this by creating and investing in CrowdBoards as a community making this planet a better place to live.
       
       <center> <img src="../WebContent/Theme/images/a1.png" alt="" /></center>
       
       <h5> CrowdBoarders share a set of beliefs which we call the seven laws if these resonate with you, and you believe what we believe sign up! </h5><br />
       <center> <img src="../WebContent/Theme/images/a2.png" alt="" /></center>
		</div>

    <!--        Right Column      -->
    <div class="right-column fixedElement">
        <h4>
            More Info</h4>
        <div class="blue-link">
            <a href="MoreInfo/howitworks.html">How it Works</a></div>
        <div class="blue-link">
            <a href="MoreInfo/youareacrowdboarder.html">You are a CrowdBoarder</a></div>
        <div class="blue-link">
            <a href="MoreInfo/crowdfundinggoessocial.html">Crowdfunding goes Social</a></div>
        <div class="blue-link">
            <a href="MoreInfo/industrycomparison.html">Industry Comparison</a></div>
        <div class="blue-link">
            <a href="MoreInfo/howdoesyourprofilelook.html">How does your profile look? </a>
        </div>
        <div class="blue-link">
            <a href="MoreInfo/quotes.html">CrowdBoarder Quotes </a>
        </div>
    </div>
  </asp:Content>
