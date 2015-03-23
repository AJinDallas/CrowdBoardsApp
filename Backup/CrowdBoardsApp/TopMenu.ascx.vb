'description:topmenu
'author:Ni Laisong
'create date:04-18-2006
'adapted by:James Homant
'modify date:06-01-2006
Imports System.Drawing
Imports System.IO

Partial Class TopMenu
	Inherits System.Web.UI.UserControl

#Region " Web Form Designer Generated Code "

	'This call is required by the Web Form Designer.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

	End Sub
	Protected WithEvents Label1 As System.Web.UI.WebControls.Label
	Protected WithEvents Label2 As System.Web.UI.WebControls.Label
	Protected WithEvents Label3 As System.Web.UI.WebControls.Label
	Protected WithEvents Label4 As System.Web.UI.WebControls.Label
	Protected WithEvents LinkButton1 As System.Web.UI.WebControls.LinkButton
	Protected WithEvents LinkButton2 As System.Web.UI.WebControls.LinkButton
	Protected WithEvents LinkButton3 As System.Web.UI.WebControls.LinkButton
	Protected WithEvents LinkButton4 As System.Web.UI.WebControls.LinkButton
	Protected WithEvents LinkButton5 As System.Web.UI.WebControls.LinkButton
	Protected WithEvents hlAdmin As System.Web.UI.WebControls.HyperLink
	Protected WithEvents MainImage As System.Web.UI.WebControls.Image
	Protected WithEvents lblTitle2 As System.Web.UI.WebControls.Label
	Protected WithEvents MainDiv As System.Web.UI.HtmlControls.HtmlGenericControl
	Protected WithEvents DIV2 As System.Web.UI.HtmlControls.HtmlGenericControl
	Protected WithEvents lbView As System.Web.UI.WebControls.Label
	Protected WithEvents imgMenu As System.Web.UI.WebControls.Image
	Protected WithEvents test1 As System.Web.UI.HtmlControls.HtmlInputButton


	Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
		'CODEGEN: This method call is required by the Web Form Designer
		'Do not modify it using the code editor.
		InitializeComponent()
	End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then
            'Put user code to initialize the page here

            ' ---- set label values ---
            'lblDate.Text = Format(Now(), "dddd, MMMM d, yyyy")
            'lblTime.Text = Format(Now(), "h:mm tt")
            'lblWelcome.Text = "Welcome back " & TitleCase(CType(Session("TechName"), String))

        End If

    End Sub

	Function TitleCase(ByVal mystring As String) As String
		Dim splitarray() As String
		Dim index As Integer

		splitarray = Split(mystring, " ")

		For index = 0 To splitarray.GetUpperBound(0)
			splitarray(index) = Left(splitarray(index), 1).ToUpper() & Mid(splitarray(index), 2)
		Next
		Return Join(splitarray, " ")

	End Function

	Public Sub SetFonts()
        hlAdmin.Font.Name = "Areal"
    End Sub


    'End Sub
	' --- customer-specific static image that stretches across the entire topmenu control ----
	Public Function GetStatic() As String
        Return "Data\Generic.jpg"
	End Function


    'Private Sub BtnLogout_ServerClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnLogout.ServerClick
    '	Session("Logout") = True
    '	Response.Redirect("Login.aspx")
    'End Sub

End Class

