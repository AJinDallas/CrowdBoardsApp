Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Imports System.Threading

Public Class BoardDetails
    Inherits Telerik.Web.UI.RadAjaxPage
    Public index As Integer = 0
    Public apiMarketplace As String = "" & ConfigurationManager.AppSettings("ApiMarketplace")
    Public Property LevelID() As Integer
        Get
            Return CStr(ViewState("_levelID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_levelID") = value
        End Set
    End Property
    Public Property boardID() As Integer

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property DirectoryName() As String

        Get
            Return CStr(ViewState("_directoryName"))
        End Get

        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property

    Public Property status() As Integer
        Get
            Return CInt(ViewState("_status"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_status") = value
        End Set
    End Property
    Public Property BoardPicUrl() As String
        Get
            Return CStr(ViewState("_boardPicUrl"))
        End Get
        Set(ByVal value As String)
            ViewState("_boardPicUrl") = value
        End Set
    End Property
    Public Property dtBoardLevels() As DataTable
        Get
            Return CType(ViewState("_dtBoardLevels"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("_dtBoardLevels") = value
        End Set
    End Property
    Public Property TopFive() As Integer

        Get
            Return CInt(ViewState("_TopFive"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_TopFive") = value
        End Set
    End Property

    Public Property levelCount() As Integer

        Get
            Return CInt(ViewState("_levelCount"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_levelCount") = value
        End Set
    End Property
    Public Property areaID() As Integer
        Get
            Return CInt(ViewState("_areaID"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_areaID") = value
        End Set
    End Property
    Public Property totalOffer() As Integer
        Get
            Return CInt(ViewState("_totalOffer"))
        End Get
        Set(ByVal value As Integer)
            ViewState("_totalOffer") = value
        End Set
    End Property
    Public Property CustomerIdOfOwner() As String
        Get
            Return CStr(ViewState("_customerIdOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerIdOfOwner") = value
        End Set
    End Property
    Public Property CustomerUriOfOwner() As String
        Get
            Return CStr(ViewState("_customerUriOfOwner"))
        End Get
        Set(ByVal value As String)
            ViewState("_customerUriOfOwner") = value
        End Set
    End Property
    Public Property MediaLinkId() As String
        Get
            Return CStr(ViewState("_mediaLinkId"))
        End Get
        Set(ByVal value As String)
            ViewState("_mediaLinkId") = value
        End Set
    End Property
    Public Property BoardName() As String

        Get
            Return CStr(ViewState("_BoardName"))
        End Get

        Set(ByVal value As String)
            ViewState("_BoardName") = value
        End Set
    End Property
    Public Property BankLocation() As String

        Get
            Return CStr(ViewState("_bankLocation"))
        End Get

        Set(ByVal value As String)
            ViewState("_bankLocation") = value
        End Set
    End Property
    Public Property StripeAccountStatus() As String
        Get
            Return CStr(ViewState("_stripeAccountStatus"))
        End Get
        Set(ByVal value As String)
            ViewState("_stripeAccountStatus") = value
        End Set
    End Property

    Dim viewImages As String()
    Dim uploadImages As String()
    Dim deleteImages As String()




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageStepTwo.Text = ""
        lblMessageStep3.Text = ""
        lblMessage.Text = ""
        lblSuccessBalanced.Text = ""
        lblErrorBalanced.Text = ""
        lblMessageStep2.Text = ""
        lblMessageDesign.Text = ""

        RadWindow1.VisibleOnPageLoad = False
        RadWindow3.VisibleOnPageLoad = False

        If (Not Page.IsPostBack) Then

            Try
                If Request.QueryString.Count > 0 Then
                    If Request.QueryString("Name") IsNot Nothing Then
                        SetBankLocation()
                        Me.boardID = getBoardId()
                        Me.DirectoryName = Request.QueryString("Name")
                        lblCrowdboardName.Text = Me.DirectoryName



                        GetStatus(Me.boardID)
                        If Me.status = 3 Or Me.status = 0 Then
                            btnActivateBoard.Visible = True
                            btnDeActivateBoard.Visible = False
                        Else
                            btnActivateBoard.Visible = False
                            btnDeActivateBoard.Visible = True
                        End If

                        RadMultiPage2.SelectedIndex = 0
                        LoadBoardDescriptionInfo()
                        ResetCss()
                        lbtnEditCrowdBoard.Attributes.Add("style", "text-decoration:underline")

                        SetBackgroundCoverProfilePic()
                        LoadBoardFiles()
                        LoadBoardMediaLinks()
                        removeTools()
                        Dim filePath As String
                        filePath = CreateDirectory()
                        reCreatePage.Content = ReadFile(filePath + "\Index.html")
                        If Request.QueryString("IsCreated") IsNot Nothing Then
                            GlobalModule.SetMessage(lblMessageStep2, True, "Account configured successfully! Please submit Board for approval again.")
                        End If
                    End If
                End If
                Dim editorFileName = "~/Upload/BoardDirectory/" & Me.DirectoryName
                If Not Directory.Exists(System.IO.Path.Combine(Server.MapPath(editorFileName))) Then
                    Directory.CreateDirectory(System.IO.Path.Combine(Server.MapPath(editorFileName)))
                End If

                viewImages = New String() {editorFileName}
                uploadImages = New String() {editorFileName}
                deleteImages = New String() {editorFileName, "~/Upload/DeleteFiles"}

                reCreatePage.ImageManager.ViewPaths = viewImages
                reCreatePage.ImageManager.UploadPaths = uploadImages
                reCreatePage.ImageManager.DeletePaths = deleteImages
                'to change the View mode to Grid use the below syntax
                reCreatePage.ImageManager.ViewMode = Telerik.Web.UI.Editor.DialogControls.ImageManagerViewMode.Grid


            Catch ex As Exception
                GlobalModule.SetMessage(lblMessage, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If

    End Sub
    Public Sub removeTools()
        Try
            reCreatePage.EnsureToolsFileLoaded()
            'reCreatePage.FindTool("FindAndReplace").Visible = False
            RemoveButton("FindAndReplace")
            RemoveButton("Print")
            RemoveButton("FlashManager")
            RemoveButton("MediaManager")
            RemoveButton("Superscript")
            RemoveButton("Subscript")
            RemoveButton("XhtmlValidator")
            RemoveButton("ApplyClass")
            RemoveButton("FormatStripper")
            RemoveButton("InsertSymbol")
            RemoveButton("InsertTable")
            RemoveButton("InsertTime")
            RemoveButton("InsertFormElement")
            RemoveButton("InsertSnippet")
            RemoveButton("ConvertToLower")
            RemoveButton("ConvertToUpper")
            RemoveButton("Zoom")
            RemoveButton("ModuleManager")
            RemoveButton("ToggleScreenMode")
            RemoveButton("LinkManager")
            RemoveButton("Unlink")
            RemoveButton("InsertGroupbox")
            RemoveButton("AboutDialog")
            RemoveButton("InsertCustomLink")
            RemoveButton("AjaxSpellCheck")
            RemoveButton("SelectAll")
            RemoveButton("DocumentManager")
            RemoveButton("TemplateManager")
            RemoveButton("InsertParagraph")
            RemoveButton("InsertHorizontalRule")
            RemoveButton("FormatCodeBlock")
            RemoveButton("AbsolutePosition")
            RemoveButton("ToggleTableBorder")
            RemoveButton("ImageMapDialog")
            'RemoveButton("reMode_design reMode_selected")
            'RemoveButton("reMode_html")
            'RemoveButton("reEditorModesCell")

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub RemoveButton(ByVal name As String)
        Try
            For Each group As Telerik.Web.UI.EditorToolGroup In reCreatePage.Tools
                Dim tool As EditorTool = group.FindTool(name)
                If tool IsNot Nothing Then
                    group.Tools.Remove(tool)
                End If
            Next
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Private Sub GetStatus(ByVal boardID As Integer)
        Try
            sdBoardInfo.SelectParameters.Item("BoardID").DefaultValue = boardID
            Dim dvStatus As Data.DataView = CType(sdBoardInfo.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dvStatus.Count > 0 Then
                If (Not IsDBNull(dvStatus(0)("Status"))) Then
                    Me.status = Convert.ToInt16(dvStatus(0)("Status"))
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Private Sub SetBankLocation()
        Try
            sdGetBankLocation.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            Dim dv As Data.DataView = CType(sdGetBankLocation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = dv(0)("BankLocation").ToString()
                    Me.BankLocation = dv(0)("BankLocation").ToString()
                Else
                    sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = "US"
                    Me.BankLocation = "US"
                End If
            Else
                sdInvestmentLevelsAmount.SelectParameters.Item("BankLocation").DefaultValue = "US"
                Me.BankLocation = "US"
            End If
            If Me.BankLocation = "US" Then
                lblAmtType.Text = "$"
                txtSeeking.Attributes.Add("placeholder", "100")
            Else
                lblAmtType.Text = "£"
                txtSeeking.Attributes.Add("placeholder", "100")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Protected Sub btnActivateBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnActivateBoard.Click
        Try
            If Me.boardID = 0 Then
                GlobalModule.SetMessage(lblMessage, False, "Please Select Board First")
                Exit Sub
            ElseIf Not checkType() Then
                Exit Sub
            ElseIf hdnSelectedArea.Value = "" Then
                GlobalModule.SetMessage(lblMessageStepTwo, False, "Please Select District and Area")

                Exit Sub
            Else
                If (CheckEmailExists() = False) Then
                    RadWindow3.Height = 400
                    RadWindow3.Width = 600
                    RadWindow3.NavigateUrl = "~/rwValidateEmail.aspx?vEmail=" & True
                    RadWindow3.VisibleOnPageLoad = True
                    Exit Sub
                Else
                    SaveBoardDetails()
                End If
            End If
            If Me.BankLocation = "US" Then
                BalancedAccountCheck()
            Else
                StripeAccountCheck()
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Activating Board")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function CheckEmailExists() As Boolean
        Dim result As Boolean = False
        sdIsValidEmail.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
        Dim dv As Data.DataView = CType(sdIsValidEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not dv Is Nothing Then
            If (dv.Count > 0) Then
                If (dv(0)("EmailVerified").ToString() = "Check" Or dv(0)("EmailVerified").ToString() = "N/A") Then
                    If (Not IsDBNull(dv(0)("Email"))) Then
                        result = True
                    Else
                        result = False
                    End If
                Else
                    result = False
                End If
            End If
        End If
        Return result

    End Function

    Protected Sub btnCreateStripeAccount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateStripeAccount.Click
        Try
            Dim stripeClientID As String = "" & ConfigurationManager.AppSettings("StripeClientID")
            Response.Redirect("https://connect.stripe.com/oauth/authorize?response_type=code&client_id=" & stripeClientID & "&scope=read_write&state=" & Me.DirectoryName, False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub BalancedAccountCheck()
        Try
            If (IsBalancedAccountConfigured()) Then

                If (Me.totalOffer = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "Your Target Amount is low")
                    Return
                End If
                If (Me.levelCount = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "There needs to be at least one investment level")
                    Return
                End If
                If (Me.areaID = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "Please Select Area and District")
                    Return
                End If
                SubmitForApproval()
                GlobalModule.SetMessage(lblMessageStep2, True, "Board Submitted for Approval")
                lblMessageStep2.Attributes.Add("style=", "color:#00FF00;")

                btnActivateBoard.Visible = False
                btnDeActivateBoard.Visible = True
            Else
                If txtName.Text.Trim() = "" Or txtEmailForBankAccount.Text.Trim() = "" Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "Please update Name and valid email in your profile first")
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupcreateBalacedAccount();", True)
                End If

            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Throw ex
        End Try
    End Sub
    Protected Sub StripeAccountCheck()
        Try
            If (IsStripeAccountConfigured()) Then

                If (Me.totalOffer = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "Your Target Amount is low")
                    Return
                End If
                If (Me.levelCount = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "There needs to be at least one investment level")
                    Return
                End If
                If (Me.areaID = 0) Then
                    GlobalModule.SetMessage(lblMessageStep2, False, "Please Select Area and District")
                    Return
                End If
                SubmitForApproval()
                GlobalModule.SetMessage(lblMessageStep2, True, "Board Submitted for Approval")
                lblMessageStep2.Attributes.Add("style=", "color:#00FF00;")

                btnActivateBoard.Visible = False
                btnDeActivateBoard.Visible = True
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "ConfirmStripeAccount();", True)
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Throw ex
        End Try
    End Sub
    Protected Sub SubmitForApproval()
        Try
            sdSubmitForApproval.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim res As Integer = sdSubmitForApproval.Update()
            If res = 1 Then
                SendBoardApprovalEmail()
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Throw ex
        End Try
    End Sub
    Protected Sub SendBoardApprovalEmail()
        Try
            Try
                Dim managerEmail As String = GetDistrictManagerEmail()
                Dim sp As String = "" & System.Configuration.ConfigurationManager.AppSettings("site")
                Dim adminEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("adminEmail")
                Dim toAddress As String
                Dim strBody As String
                Dim strSubject As String = "CrowdBoard Submitted for Approval"
                If managerEmail = "" Then
                    toAddress = adminEmail
                Else
                    toAddress = adminEmail & "," & managerEmail
                End If

                Dim userLink As String = "<a style='color:#99CCFF;' href='" + sp + "/Profile.aspx?User=" + Session("UserName").ToString() + "'>@" + Session("UserName").ToString() + "</a>" & " has submitted "
                Dim boardLink As String = "<a style='color:#99CCFF;' href='" + sp + "/Board.aspx?Name=" + Me.DirectoryName + "'>" + "@" + Me.BoardName + "@</a>" & " for Approval"

                strBody = userLink & boardLink
                GlobalModule.SendEmail(toAddress, strSubject, strBody, True)
            Catch ex As Exception
                Throw ex
            End Try
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Function GetDistrictManagerEmail() As String
        Dim email As String = ""
        Try
            sdGetDistrictManagerEmail.SelectParameters.Item("AreaID").DefaultValue = getAreaID()
            Dim dv As Data.DataView = CType(sdGetDistrictManagerEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                email = dv(0)("Email")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return email
    End Function
    Private Function IsBalancedAccountConfigured() As Boolean
        Dim result As Boolean = False
        Try
            sdBalancedOwnerDetails.SelectParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
            Dim dv As Data.DataView = CType(sdBalancedOwnerDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("UserBankAccountUri"))) Then
                        result = True
                    Else
                        Me.CustomerIdOfOwner = dv(0)("CustomerID").ToString()
                        Me.CustomerUriOfOwner = dv(0)("UserAccountUri").ToString()
                    End If

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function

    Private Function IsStripeAccountConfigured() As Boolean
        Dim result As Boolean = False
        Try
            sdStripeOwnerDetails.SelectParameters.Item("UserID").DefaultValue = Session("UserID").ToString()
            Dim dv As Data.DataView = CType(sdStripeOwnerDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("StripeUserID"))) Then
                    Me.StripeAccountStatus = "Exist"
                    result = True
                Else
                    Me.StripeAccountStatus = "IsUpdate"
                    result = False
                End If
            Else
                Me.StripeAccountStatus = "IsNew"
                result = False
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Sub btnDeActivateBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeActivateBoard.Click
        Try
            UpdateStatusOfBoard(3)
            GlobalModule.SetMessage(lblMessageStepTwo, True, "Board Deactivated Successfully")
            btnActivateBoard.Visible = True
            btnDeActivateBoard.Visible = False

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Activating Board")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub UpdateStatusOfBoard(ByVal status As Integer)
        Try
            If status = 1 Then
                sdActivateBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
                sdActivateBoard.UpdateParameters.Item("Status").DefaultValue = status
                sdActivateBoard.Update()
            Else
                sdChangeBoardStatus.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
                sdChangeBoardStatus.UpdateParameters.Item("Status").DefaultValue = status
                Dim res As Integer = sdChangeBoardStatus.Update()
                If res = 1 Then
                    sdChangeBoardStatus.DeleteParameters.Item("BoardID").DefaultValue = Me.boardID
                    sdChangeBoardStatus.Delete()
                End If
            End If


            LoadBoardDescriptionInfo()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub LoadBoardDescriptionInfo()
        Try

            sdBoardLevels.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dvBoardLevel As Data.DataView = CType(sdBoardLevels.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dvBoardLevel.Count > 0) Then
                rgBoardLevels.DataSource = dvBoardLevel
                rgBoardLevels.DataBind()
            End If
            sdBoard.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("BoardName"))) Then
                    txtBoardName.Text = dv(0)("BoardName")
                    lblCrowdboardName.Text = dv(0)("BoardName")
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    txtDescription.Text = dv(0)("Description")
                End If
                If (Not IsDBNull(dv(0)("Name"))) Then
                    txtName.Text = dv(0)("Name")
                End If
                If (Not IsDBNull(dv(0)("Email"))) Then
                    txtEmailForBankAccount.Text = dv(0)("Email")
                End If
                If (Not IsDBNull(dv(0)("areaID"))) Then
                    If (dv(0)("areaID") = 0) Then
                        Me.areaID = 0
                    Else
                        Me.areaID = dv(0)("areaID")
                    End If
                    hdnSelectedArea.Value = dv(0)("areaName")
                    districtLabel.Text = dv(0)("District") + " District"
                    areaLabel.Text = "Your have Selected the " + dv(0)("areaName") + "  Area in the "
                Else
                    districtLabel.Text = ""
                    areaLabel.Text = ""
                    Me.areaID = 0
                End If
                '------------Add new Fields------


                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("BoardName"))) Then
                        txtBoardName.Text = dv(0)("BoardName")
                        Me.BoardName = dv(0)("BoardName")
                    End If
                    If (Not IsDBNull(dv(0)("Description"))) Then
                        txtDescription.Text = dv(0)("Description")
                    End If
                    If (Not IsDBNull(dv(0)("TotalOffer"))) Then
                        txtSeeking.Text = dv(0)("TotalOffer")
                        If (dv(0)("TotalOffer") = 0) Then
                            Me.totalOffer = 0
                        Else
                            Me.totalOffer = dv(0)("TotalOffer")
                        End If
                    Else
                        Me.totalOffer = 0
                    End If

                    ' levelCount
                    If (Not IsDBNull(dv(0)("levelCount"))) Then
                        If (dv(0)("levelCount") = 0) Then
                            Me.levelCount = 0
                        Else
                            Me.levelCount = Convert.ToInt32(dv(0)("levelCount"))
                        End If
                    Else
                        Me.levelCount = 0
                    End If

                    If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                        hdnDirectoryName.Value = dv(0)("DirectoryName")
                    End If

                    If (Not IsDBNull(dv(0)("InvType"))) Then
                        rddlBoardType.SelectedText = dv(0)("InvType").ToString().Trim()

                        If (dv(0)("InvType").ToString() = "Equity") Then
                            If (Not IsDBNull(dv(0)("EquityID"))) Then
                                EquityTypesDropDownList.SelectedValue = dv(0)("EquityID").ToString().Trim()
                            Else
                                EquityTypesDropDownList.SelectedValue = 0
                            End If
                            equityLocationTR.Visible = True
                        Else
                            equityLocationTR.Visible = False

                        End If


                        If dv(0)("InvType").ToString().Trim().ToLower() = "donation" Then

                            taxIDTable.Visible = True
                            If Me.BankLocation = "UK" Then
                                lblFederalTaxID.Text = "Charity Gift Registry ID"
                                txtFederalTaxID.Attributes.Add("placeholder", "Charity Gift Registry ID")
                            Else
                                lblFederalTaxID.Text = "Federal Tax ID"
                                txtFederalTaxID.Attributes.Add("placeholder", "Federal Tax ID")
                            End If
                            If (Not IsDBNull(dv(0)("FederalTaxID"))) Then
                                txtFederalTaxID.Text = dv(0)("FederalTaxID").ToString()
                            End If
                        Else
                            taxIDTable.Visible = False
                            txtFederalTaxID.Text = ""
                            txtFederalTaxID.Attributes.Add("placeholder", "")
                        End If

                    End If
                    If (Not IsDBNull(dv(0)("Location"))) Then
                        '' lblLocation.Text = dv(0)("Location").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("city"))) Then
                        txtCity.Text = dv(0)("city").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("Country"))) Then
                        txtCounty.Text = dv(0)("Country").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("YoutubeVideoUrl"))) Then
                        txtYoutubeVideoUrl.Text = dv(0)("YoutubeVideoUrl").ToString()
                    End If

                End If
                imgProfile.ImageUrl = "~/thumbnail/" & hdnDirectoryName.Value & ".jpg"               '-----------end---------------
                Me.BoardPicUrl = "~/thumbnail/" & hdnDirectoryName.Value & ".jpg"
                'imgProfile.ImageUrl = "~/Images/blankBoardImage.png"

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Protected Sub rddlBoardType_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.DropDownListEventArgs) Handles rddlBoardType.SelectedIndexChanged
        Try
            If rddlBoardType.SelectedText.ToLower() = "donation" Then
                taxIDTable.Visible = True
                If Me.BankLocation = "UK" Then
                    lblFederalTaxID.Text = "Charity Gift Registry ID"
                Else
                    lblFederalTaxID.Text = "Federal Tax ID"
                End If
            Else
                taxIDTable.Visible = False
                txtFederalTaxID.Text = ""
                txtFederalTaxID.Attributes.Add("placeholder", "")
            End If

            If (rddlBoardType.SelectedText.ToLower() = "equity") Then
                equityLocationTR.Visible = True
            Else
                equityLocationTR.Visible = False

            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error In Updating")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SaveChanges()
        Try
            Dim directoryName As String
            directoryName = txtBoardName.Text.Trim.ToLower.Replace(" ", "-")
            sdBoard.UpdateParameters.Item("BoardName").DefaultValue = txtBoardName.Text
            sdBoard.UpdateParameters.Item("Description").DefaultValue = txtDescription.Text
            sdBoard.UpdateParameters.Item("DirectoryName").DefaultValue = directoryName
            sdBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoard.Update()

            LoadBoardDescriptionInfo()

            GlobalModule.SetMessage(lblMessageStepTwo, True, "Updated Successfully")
            lblMessageStepTwo.ForeColor = Color.Green

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error In Updating")
            GlobalModule.ErrorLogFile(ex)
            Exit Sub
        End Try
    End Sub

    Protected Sub SaveTaxID()
        Try
            sdInvestmentType.UpdateParameters.Item("FederalTaxID").DefaultValue = txtFederalTaxID.Text
            sdInvestmentType.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdInvestmentType.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16) As String
        Try
            Dim fileName As String = fileNameObject.ToString()
            Dim iPath As String = Path.Combine(Server.MapPath("thumbnail"), fileName)
            If Not System.IO.File.Exists(iPath) Then
                fileName = "noimage.jpg"
                iPath = Path.Combine(Server.MapPath("thumbnail"), fileName)
            End If
            Dim NewPath As String = Path.Combine(Server.MapPath("thumbs"), fileName)
            If Not System.IO.File.Exists(NewPath) Then
                Using img As Image = New Bitmap(iPath)

                    Dim OriginalSize As Size = img.Size
                    Dim NewSize As Size
                    NewSize.Height = desiredHeight 'Maximum desired height
                    NewSize.Width = desiredWidth 'Maximum desired width
                    Dim FinalSize As Size = ProportionalSize(OriginalSize, NewSize)

                    Using img2 As Image = img.GetThumbnailImage(FinalSize.Width, FinalSize.Height, New Image.GetThumbnailImageAbort(AddressOf Abort), IntPtr.Zero)
                        img2.Save(NewPath)
                    End Using
                End Using
            End If
            Return "thumbs/" & fileName
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Function
    Function ProportionalSize(ByVal imageSize As Size, ByVal MaxW_MaxH As Size) As Size
        Try
            Dim ratio = Math.Max(imageSize.Width / MaxW_MaxH.Width, imageSize.Height / MaxW_MaxH.Height)
            imageSize.Width = CInt(imageSize.Width / ratio)
            imageSize.Height = CInt(imageSize.Height / ratio)
            Return imageSize
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Function Abort() As Boolean
        Return False
    End Function

    Private Function getBoardId() As Integer
        Dim boardId As Integer = 0
        Try
            sdGetBoardIdDataSource.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                boardId = dv(0)("BoardID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return boardId
    End Function
    Public Function CheckBoarderStatus() As Integer
        Dim isBoarder As Integer = 0
        Try
            Dim username As String = Session("userName")
            Dim userRolesList() As String = Roles.GetRolesForUser(username)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    If (item = "Boarder") Then
                        isBoarder = 1
                        Exit For
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isBoarder
    End Function

    Protected Sub districtDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles districtDataList.ItemDataBound
        Try

            Dim hdnDistrictID As HiddenField = e.Item.FindControl("hdnDistrictID")
            Dim areaDataList As DataList = CType(e.Item.FindControl("areaDataList"), DataList)
            sdAreasLoad.SelectParameters.Item("districtID").DefaultValue = hdnDistrictID.Value
            Dim dvArea As Data.DataView = CType(sdAreasLoad.Select(DataSourceSelectArguments.Empty), Data.DataView)
            areaDataList.DataSource = dvArea
            areaDataList.DataBind()
            areaDataList.RepeatColumns = 2
            areaDataList.RepeatLayout = RepeatLayout.Table

            Dim hdnDistrictName As HiddenField = CType(e.Item.FindControl("hdnDistrictName"), HiddenField)
            Dim districtNameLinkButton As LinkButton = CType(e.Item.FindControl("DistrictNameLinkButton"), LinkButton)
            districtNameLinkButton.Attributes.Add("onclick", "return loadPopupBoxArea(" + hdnDistrictID.Value + ",'" + hdnDistrictName.Value + "');")
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Protected Sub btnProfilePicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProfilePicture.Click
        Try
            If rauProfilePicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauProfilePicture.UploadedFiles

                    Dim image As System.Drawing.Image
                    image = Drawing.Image.FromStream(upFiles.InputStream)

                    'If (image.Height <> 350) And (image.Width <> 350) Then
                    '    GlobalModule.SetMessage(lblMessageStepTwo, False, "Please Upload Image of Size 350 x 350 pixels")

                    '    image.Dispose()
                    '    Exit Sub
                    'End If
                    If Not (upFiles.GetExtension().ToLower() = ".jpg") Then
                        GlobalModule.SetMessage(lblMessageStepTwo, False, "Only JPG files are allowed")

                        Exit Sub
                    End If

                    Dim imagePath As String = Server.MapPath("~/thumbnail/")
                    image.Save(imagePath & Me.DirectoryName & ".jpg")
                    Me.BoardPicUrl = "~/thumbnail/" & Me.DirectoryName & ".jpg"
                    imgProfile.ImageUrl = Me.BoardPicUrl
                    GlobalModule.SetMessage(lblMessageStepTwo, True, "Successfully Uploaded")

                    Exit Sub
                Next

                LoadBoardDescriptionInfo()
            Else
                GlobalModule.SetMessage(lblMessageStepTwo, False, "Only JPG files are allowed")

            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub addLevelButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles addLevelButton.Click
        Try
            If Not (txtSeeking.Text = "") Then
                Dim maxoffred As Int64 = (Convert.ToInt64(txtSeeking.Text)) / Convert.ToInt64(ddlInvestmentLevels.SelectedValue)
                If (Convert.ToInt64(txtMaximumOffered.Text) > maxoffred) Then
                    GlobalModule.SetMessage(lblMessageStep3, False, "Please enter value in Maximum Offered between 1 and " & maxoffred.ToString())
                    Exit Sub
                Else
                    If addLevelButton.Text = "Add Level" Then
                        SaveBoardLevels()
                    ElseIf addLevelButton.Text = "Update Level" Then
                        UpdateBoardLevels()
                    End If

                    LoadBoardDescriptionInfo()

                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub SaveBoardLevels()
        Dim resutl As Integer
        Try

            If Not (txtLevelName.Text = "") Then

                If (CheckNumericValue(ddlInvestmentLevels.SelectedValue) = 1) Then
                    If (Convert.ToDouble(txtSeeking.Text) >= Convert.ToDouble(ddlInvestmentLevels.SelectedValue)) Then
                        sdBoardLevels.InsertParameters.Item("LevelAmount").DefaultValue = Convert.ToDouble(ddlInvestmentLevels.SelectedValue)
                    Else
                        Dim levelMessage As String = String.Empty
                        If Me.BankLocation = "US" Then
                            levelMessage = "Your InvestmentLevel Amount  $"
                        Else
                            levelMessage = "Your InvestmentLevel Amount  £"
                        End If

                        GlobalModule.SetMessage(lblMessageStep3, False, levelMessage + ddlInvestmentLevels.SelectedValue + " must be less than the total seeking")
                        Exit Sub
                    End If
                Else
                    sdBoardLevels.InsertParameters.Item("LevelAmount").DefaultValue = 0
                End If
                sdBoardLevels.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
                sdBoardLevels.InsertParameters.Item("LevelName").DefaultValue = txtLevelName.Text
                sdBoardLevels.InsertParameters.Item("Description").DefaultValue = txtLevelDescription.Text
                sdBoardLevels.InsertParameters.Item("NumOffered").DefaultValue = txtMaximumOffered.Text
                resutl = sdBoardLevels.Insert()
                If resutl = 1 Then
                    txtLevelName.Text = ""
                    txtLevelDescription.Text = ""
                    ddlInvestmentLevels.SelectedValue = 0
                    txtMaximumOffered.Text = ""
                    GlobalModule.SetMessage(lblMessageStep3, True, "Level added successfully")
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub UpdateBoardLevels()
        Dim resutl As Integer
        Try

            If Not (txtLevelName.Text = "") Then

                If (CheckNumericValue(ddlInvestmentLevels.SelectedValue) = 1) Then
                    If (Convert.ToDouble(txtSeeking.Text) >= Convert.ToDouble(ddlInvestmentLevels.SelectedValue)) Then
                        sdBoardLevels.UpdateParameters.Item("LevelAmount").DefaultValue = Convert.ToDouble(ddlInvestmentLevels.SelectedValue)
                    Else
                        Dim levelMessage As String = String.Empty
                        If Me.BankLocation = "US" Then
                            levelMessage = "Your InvestmentLevel Amount  $"
                        Else
                            levelMessage = "Your InvestmentLevel Amount  £"
                        End If
                        GlobalModule.SetMessage(lblMessageStep3, False, levelMessage + ddlInvestmentLevels.SelectedValue + " must be less than the total seeking")
                        Exit Sub
                    End If
                Else
                    sdBoardLevels.UpdateParameters.Item("LevelAmount").DefaultValue = 0
                End If
                sdBoardLevels.UpdateParameters.Item("LevelID").DefaultValue = Me.LevelID
                sdBoardLevels.UpdateParameters.Item("LevelName").DefaultValue = txtLevelName.Text
                sdBoardLevels.UpdateParameters.Item("Description").DefaultValue = txtLevelDescription.Text
                sdBoardLevels.UpdateParameters.Item("NumOffered").DefaultValue = txtMaximumOffered.Text
                resutl = sdBoardLevels.Update()
                If resutl = 1 Then
                    txtLevelName.Text = ""
                    txtLevelDescription.Text = ""
                    ddlInvestmentLevels.SelectedValue = 0
                    addLevelButton.Text = "Add Level"
                    txtMaximumOffered.Text = ""
                    GlobalModule.SetMessage(lblMessageStep3, True, "Level Updated successfully")
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub DeleteBoardLevels()
        Dim resutl As Integer
        Try

            If Not (Me.LevelID = 0) Then

                sdBoardLevels.DeleteParameters.Item("LevelID").DefaultValue = Me.LevelID
                resutl = sdBoardLevels.Delete()
                If resutl = 1 Then
                    GlobalModule.SetMessage(lblMessageStep3, True, "Level Deleted successfully")
                End If
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function CheckNumericValue(ByVal value As String) As Integer
        Dim restul As Integer = 0
        Try
            If IsNumeric(value) Then
                restul = 1
            ElseIf (value = "") Then
                restul = 0
            Else
                restul = 0
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return restul
    End Function

    Protected Sub SaveBoardDetails()
        Try
            Dim directoryName As String
            directoryName = txtBoardName.Text.Trim.ToLower.Replace(" ", "-")
            sdBoard.UpdateParameters.Item("DirectoryName").DefaultValue = directoryName
            sdBoard.UpdateParameters.Item("BoardName").DefaultValue = txtBoardName.Text
            sdBoard.UpdateParameters.Item("Description").DefaultValue = txtDescription.Text
            sdBoard.UpdateParameters.Item("city").DefaultValue = txtCity.Text
            sdBoard.UpdateParameters.Item("InvType").DefaultValue = rddlBoardType.SelectedValue
            sdBoard.UpdateParameters.Item("country").DefaultValue = txtCounty.Text
            sdBoard.UpdateParameters.Item("AreaID").DefaultValue = getAreaID()
            sdBoard.UpdateParameters.Item("Status").DefaultValue = Me.status
            sdBoard.UpdateParameters.Item("TotalOffer").DefaultValue = txtSeeking.Text
            sdBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID

            If (rddlBoardType.SelectedText.ToLower() = "equity") Then
                sdBoard.UpdateParameters.Item("EquityID").DefaultValue = EquityTypesDropDownList.SelectedValue
            Else
                sdBoard.UpdateParameters.Item("EquityID").DefaultValue = ""

            End If

            sdBoard.Update()
            If (rddlBoardType.SelectedText.ToLower() = "donation") Then
                SaveTaxID()
            End If
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function getAreaID() As Integer
        Dim areaid As Integer = 0
        Try
            sdGetAreaID.SelectParameters.Item("AreaName").DefaultValue = hdnSelectedArea.Value
            Dim dv As Data.DataView = CType(sdGetAreaID.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                areaid = dv(0)("areaID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return areaid
    End Function

    Protected Sub btnSaveBasicInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveBasicInfo.Click
        Try

            If Me.boardID = 0 Then


                GlobalModule.SetMessage(lblMessage, False, "Please Select Board First")
                Exit Sub
            End If
            If Not checkType() Then
                Exit Sub
            ElseIf hdnSelectedArea.Value = "" Then
                GlobalModule.SetMessage(lblMessageStepTwo, False, "Please Select District and Area")

                Exit Sub
            End If
            SaveBoardDetails()
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Protected Function checkType() As Boolean
        Dim result As Boolean = True
        Try
            If rddlBoardType.SelectedValue = "0" Then
                GlobalModule.SetMessage(lblMessageStepTwo, False, "Please Select type of CrowdBoard")

                result = False
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function

    Protected Sub MoveProfilePic()
        Dim fileExtention As String = String.Empty
        Try
            If (Me.BoardPicUrl <> "") Then
                Dim sourcePath As String = Server.MapPath(Me.BoardPicUrl)
                Dim tempPath As String = Server.MapPath("~/thumbnail/temp/")
                Dim dir As DirectoryInfo = New DirectoryInfo(tempPath)
                Dim files As FileInfo() = dir.GetFiles()
                If files.Length > 0 Then
                    For Each File In files
                        fileExtention = File.Extension
                    Next
                    Dim destinationPath As String = Server.MapPath("~/thumbnail/" & hdnDirectoryName.Value & fileExtention)
                    My.Computer.FileSystem.MoveFile(sourcePath, destinationPath, True)
                    EmptyTemp(tempPath)
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub EmptyTemp(ByVal tempPath As String)
        Try
            Dim filePaths As String() = Directory.GetFiles(tempPath)
            For Each filePath As String In filePaths
                File.Delete(filePath)
            Next
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub rgBoardLevels_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardLevels.ItemCommand
        Try
            If (e.CommandName = "IEdit") Then
                addLevelButton.Text = "Update Level"
                Me.LevelID = e.CommandArgument.ToString()
                Dim hdnLevelName As HiddenField = CType(e.Item.FindControl("hdnLevelName"), HiddenField)
                Dim hdnDescription As HiddenField = CType(e.Item.FindControl("hdnDescription"), HiddenField)
                Dim hdnLevelAmount As HiddenField = CType(e.Item.FindControl("hdnLevelAmount"), HiddenField)
                Dim hdnMaximumOffered As HiddenField = CType(e.Item.FindControl("hdnMaximumOffered"), HiddenField)
                txtLevelName.Text = hdnLevelName.Value
                txtLevelDescription.Text = hdnDescription.Value
                ddlInvestmentLevels.SelectedValue = hdnLevelAmount.Value
                txtMaximumOffered.Text = hdnMaximumOffered.Value
            End If
            If (e.CommandName = "IDelete") Then
                Me.LevelID = e.CommandArgument.ToString()
                DeleteBoardLevels()
                LoadBoardDescriptionInfo()
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub ddlInvestmentLevels_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlInvestmentLevels.SelectedIndexChanged
        Try
            If Not (txtSeeking.Text = "") Then
                If Not (ddlInvestmentLevels.SelectedValue = 0) Then
                    If (Convert.ToDouble(ddlInvestmentLevels.SelectedValue) > Convert.ToDouble(txtSeeking.Text)) Then
                        Dim levelMessage As String = String.Empty
                        If Me.BankLocation = "US" Then
                            levelMessage = "Your InvestmentLevel Amount  $"
                        Else
                            levelMessage = "Your InvestmentLevel Amount  £"
                        End If

                        GlobalModule.SetMessage(lblMessageStep3, False, levelMessage + ddlInvestmentLevels.SelectedValue + " must be less than the total seeking")
                    Else
                        Dim maxOfferd As Int64 = (Convert.ToInt64(txtSeeking.Text)) / Convert.ToInt64(ddlInvestmentLevels.SelectedValue)
                        txtMaximumOffered.Text = maxOfferd.ToString()
                    End If
                Else
                    GlobalModule.SetMessage(lblMessageStep3, False, "Please select level amount")
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStep3, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCreateAccount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateAccount.Click
        Try

            Dim userBankAccountUri As String = balancedBankAccountURI.Value
            If (txtName.Text <> "") AndAlso (txtEmailForBankAccount.Text <> "") Then
                If Not userBankAccountUri = "" Then
                    If Not (Me.CustomerIdOfOwner = "" Or Me.CustomerUriOfOwner = "") Then
                        Dim r As String = BalancedPayments.AddingAccountToCustomer(Me.CustomerIdOfOwner, userBankAccountUri)
                        If r.Contains("succeeded") Then
                            sdBalancedUserAccountInsert.UpdateParameters.Item("UserID").DefaultValue = Session("UserID")
                            sdBalancedUserAccountInsert.UpdateParameters.Item("UserBankAccountUri").DefaultValue = userBankAccountUri
                            sdBalancedUserAccountInsert.Update()

                            GlobalModule.SetMessage(lblMessageStepTwo, True, "Account configured successfully.Please submit Board for Approval again.")
                        End If
                    Else
                        Dim result As String = BalancedPayments.CreateCustomer(txtName.Text, txtEmailForBankAccount.Text)
                        If result.Contains("succeeded") Then
                            Dim codes As String() = result.Split(","c)
                            If codes.Length = 3 Then
                                Dim customerUri As String = codes(1)
                                Dim customerID As String = codes(2)
                                Dim r As String = BalancedPayments.AddingAccountToCustomer(customerID, userBankAccountUri)
                                If r.Contains("succeeded") Then
                                    SaveCardDetails(customerUri, userBankAccountUri, customerID)

                                    GlobalModule.SetMessage(lblMessageStepTwo, True, "Account configured successfully.Please submit Board for Approval again.")
                                End If
                            End If
                        Else
                            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error in Request")
                        End If
                    End If

                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub SaveCardDetails(ByVal accountUri As String, ByVal userBankAccountUri As String, ByVal customerID As String)
        Try
            sdBalancedUserAccountInsert.InsertParameters.Item("UserID").DefaultValue = Session("UserID")
            sdBalancedUserAccountInsert.InsertParameters.Item("UserAccountUri").DefaultValue = accountUri
            sdBalancedUserAccountInsert.InsertParameters.Item("UserBankAccountUri").DefaultValue = userBankAccountUri
            sdBalancedUserAccountInsert.InsertParameters.Item("CustomerID").DefaultValue = customerID
            Dim res As Integer = sdBalancedUserAccountInsert.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub ResetCss()
        Try
            lbtnEditCrowdBoard.Attributes.Add("style", "text-decoration:none")
            lbtnDesign.Attributes.Add("style", "text-decoration:none")
            lbtnMoreInfo.Attributes.Add("style", "text-decoration:none")
            lbtnMediaLinks.Attributes.Add("style", "text-decoration:none")
            ' lbtnUploadFiles.Attributes.Add("style", "text-decoration:none")
            ' lbtnCrowdBoardTeam.Attributes.Add("style", "text-decoration:none")
            ' lbtnPreview.Attributes.Add("style", "text-decoration:none")
            lbtnLevels.Attributes.Add("style", "text-decoration:none")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub lbtnEditCrowdBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnEditCrowdBoard.Click
        RadMultiPage2.SelectedIndex = 0
        ResetCss()
        lbtnEditCrowdBoard.Attributes.Add("style", "text-decoration:underline")

    End Sub
    Protected Sub lbtnDesign_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnDesign.Click
        RadMultiPage2.SelectedIndex = 2
        ResetCss()
        lbtnDesign.Attributes.Add("style", "text-decoration:underline")

    End Sub
    Protected Sub lbtnMoreInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMoreInfo.Click
        RadMultiPage2.SelectedIndex = 3
        ResetCss()
        lbtnMoreInfo.Attributes.Add("style", "text-decoration:underline")

    End Sub
    Protected Sub lbtnMediaLinks_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMediaLinks.Click
        RadMultiPage2.SelectedIndex = 4
        ResetCss()
        lbtnMediaLinks.Attributes.Add("style", "text-decoration:underline")

    End Sub
    Protected Sub lbtnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnEdit.Click

        Response.Redirect("BoardDetails.aspx?Name=" + Me.DirectoryName)
    End Sub
    Protected Sub lbtnManage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnManage.Click

        Response.Redirect("CrowdBoardManagement.aspx?Name=" + Me.DirectoryName)
    End Sub
    Protected Sub lbtnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnUpdate.Click

        Response.Redirect("UpdateBoarders.aspx?Name=" + Me.DirectoryName)
    End Sub
    Protected Sub lbtnLevels_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnLevels.Click
        RadMultiPage2.SelectedIndex = 1
        ResetCss()
        lbtnLevels.Attributes.Add("style", "text-decoration:underline")

    End Sub


    Protected Sub btnBackgroungPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBackgroungPicture.Click
        Try
            If rauBackgroundPicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauBackgroundPicture.UploadedFiles
                    Context.Cache.Remove("~/Upload/BoardBackgroundPics" & "\\" & Me.DirectoryName & ".jpg")
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardBackgroundPics") & "\\" & Me.DirectoryName & ".jpg", True)

                    Dim image1 As Bitmap
                    image1 = ResizeImage(Server.MapPath("~/Upload/BoardBackgroundPics") & "\\" & Me.DirectoryName & ".jpg", 800, 425)

                    image1.Save(Server.MapPath("~/Upload/BoardBackgroundPics") & "\\" & Me.DirectoryName & ".jpg")

                    SetBackgroundCoverProfilePic()
                    GlobalModule.SetMessage(lblMessageDesign, True, "Video Image Uploaded Successfully")
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMessageDesign, False, "Only JPG,GIF,PNG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub

    Private Function ResizeImage(ByVal streamImage As String, ByVal maxWidth As Integer, ByVal maxHeight As Integer) As Bitmap
        Dim originalImage As New Bitmap(streamImage)
        Dim newWidth As Integer = originalImage.Width
        Dim newHeight As Integer = originalImage.Height

        Dim newImage As New Bitmap(originalImage, maxWidth, maxHeight)

        Dim g As Graphics = Graphics.FromImage(newImage)
        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear
        g.DrawImage(originalImage, 0, 0, newImage.Width, newImage.Height)

        originalImage.Dispose()

        Return newImage
    End Function

    Protected Sub btnCoverPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCoverPicture.Click
        'Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.Cache.SetNoStore()
        Try
            If rauCoverPicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauCoverPicture.UploadedFiles
                    Context.Cache.Remove("~/Upload/BoardCoverPics" & "\\" & Me.DirectoryName & ".jpg")
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardCoverPics") & "\\" & Me.DirectoryName & ".jpg", True)
                    Dim image1 As Bitmap
                    image1 = ResizeImage(Server.MapPath("~/Upload/BoardCoverPics") & "\\" & Me.DirectoryName & ".jpg", 500, 250)

                    image1.Save(Server.MapPath("~/Upload/BoardCoverPics") & "\\" & Me.DirectoryName & ".jpg")

                    SetBackgroundCoverProfilePic()
                    GlobalModule.SetMessage(lblMessageDesign, True, "Cover Image Uploaded Successfully")
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMessageDesign, False, "Only JPG,GIF,PNG files are allowed")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try


    End Sub
    Protected Sub SetBackgroundCoverProfilePic()
        Try
            If Not isAvail("~/Upload/BoardBackgroundPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathBackgroundImage As String = "Upload/BoardBackgroundPics/" & Me.DirectoryName & ".jpg"
                ' backgroundDiv.Attributes.Add("style", "background-image:url(" & pathBackgroundImage & "); background-repeat:no-repeat; overflow: hidden; background-size: 100% 100%;width: 95%; height: 400px;border-color: #99CCFF;border-style: solid; border-width: 1;")
                rieBackgroundPic.ImageUrl = "~/Upload/BoardBackgroundPics/" & Me.DirectoryName & ".jpg"
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg"
                ' coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");width: 100%; height: 30%; border-bottom-color: #99CCFF; border-bottom-style: solid;border-bottom-width: thin;")
                rieCoverPic.ImageUrl = "~/Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg"
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Protected Sub btnAddToCrowdboardDesign_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddToCrowdboardDesign.Click
        Try
            If txtYoutubeVideoUrl.Text <> "" Then
                AddYoutubeVideoUrl()
            Else
                GlobalModule.SetMessage(lblMessageDesign, False, "Video Url is required")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageDesign, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub AddYoutubeVideoUrl()
        Try
            sdUpdateUrlDataSource.UpdateParameters.Item("YoutubeVideoUrl").DefaultValue = txtYoutubeVideoUrl.Text
            sdUpdateUrlDataSource.UpdateParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            sdUpdateUrlDataSource.Update()

            SetBackgroundCoverProfilePic()
            LoadBoardDescriptionInfo()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardFiles()
        Try
            sdBoardFiles.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoardFiles.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                rgBoardFiles.DataSource = dv
                rgBoardFiles.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnBoardFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBoardFiles.Click
        Try
            If rauBoardFiles.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In rauBoardFiles.UploadedFiles

                    Dim imagePath As String = "Upload/BoardDirectory/" & Me.DirectoryName & "/" & upFiles.GetName()
                    If Not Directory.Exists(System.IO.Path.Combine(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName))) Then
                        Directory.CreateDirectory(System.IO.Path.Combine(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName)))
                    End If
                    upFiles.SaveAs(Server.MapPath("~/Upload/BoardDirectory/" & Me.DirectoryName) & "\\" & upFiles.GetName(), True)
                    SaveBoardFile(upFiles.GetName(), imagePath)
                    Exit Sub
                Next
            Else
                GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Please select file")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Error in Upload")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SaveBoardFile(ByVal fileName As String, ByVal filePath As String)
        Try
            sdBoardFiles.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardFiles.InsertParameters.Item("FileName").DefaultValue = fileName
            sdBoardFiles.InsertParameters.Item("FilePath").DefaultValue = filePath
            sdBoardFiles.Insert()
            LoadBoardFiles()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub rgBoardFiles_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardFiles.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim id As String = e.CommandArgument.ToString()
                Dim hdnFileName = TryCast(e.Item.FindControl("hdnFileName"), HiddenField)
                sdBoardFiles.DeleteParameters.Item("ID").DefaultValue = id
                Dim res As Integer = sdBoardFiles.Delete()
                If (res = 1) Then
                    DeleteBoardFile(hdnFileName.Value)
                    LoadBoardFiles()
                End If
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMesaageUploadFiles, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub DeleteBoardFile(ByVal fileName As String)
        Try
            Dim objFileInfo As System.IO.FileInfo
            Response.Clear()
            Dim rootPath = "~/Upload/BoardDirectory/" & Me.DirectoryName & "/" & fileName
            If Not System.IO.File.Exists(Server.MapPath(rootPath)) Then Exit Sub
            objFileInfo = New System.IO.FileInfo(Server.MapPath(rootPath))
            objFileInfo.Delete()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub rgBoardMediaLinks_ItemCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardMediaLinks.ItemCommand
        Try
            If (e.CommandName = "IDelete") Then
                Dim id As String = e.CommandArgument.ToString()
                sdBoardMediaLinks.DeleteParameters.Item("ID").DefaultValue = id
                Dim res As Integer = sdBoardMediaLinks.Delete()
                If (res = 1) Then
                    LoadBoardMediaLinks()
                Else
                    GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
                End If
            ElseIf (e.CommandName = "IEdit") Then
                btnAddMediaLink.Text = "UPDATE"
                Me.MediaLinkId = e.CommandArgument.ToString()
                Dim hdnName As HiddenField = CType(e.Item.FindControl("hdnName"), HiddenField)
                Dim hdnUrl As HiddenField = CType(e.Item.FindControl("hdnUrl"), HiddenField)
                txtMediaLinkName.Text = hdnName.Value
                txtMediaLinkUrl.Text = hdnUrl.Value
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub LoadBoardMediaLinks()
        Try
            sdBoardMediaLinks.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoardMediaLinks.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                rgBoardMediaLinks.DataSource = dv
                rgBoardMediaLinks.DataBind()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub





    Protected Sub btnAddMediaLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddMediaLink.Click
        Try
            If (btnAddMediaLink.Text.ToLower() = "add") Then
                AddMediaLink()
            ElseIf (btnAddMediaLink.Text.ToLower() = "update") Then
                UpdateMediaLink(Me.MediaLinkId)
            End If
            LoadBoardMediaLinks()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMediaLinks, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub AddMediaLink()
        Try
            sdBoardMediaLinks.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardMediaLinks.InsertParameters.Item("Name").DefaultValue = txtMediaLinkName.Text
            sdBoardMediaLinks.InsertParameters.Item("Url").DefaultValue = txtMediaLinkUrl.Text
            sdBoardMediaLinks.Insert()
            txtMediaLinkName.Text = ""
            txtMediaLinkUrl.Text = ""
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub UpdateMediaLink(ByVal id As String)
        Try
            sdBoardMediaLinks.UpdateParameters.Item("ID").DefaultValue = id
            sdBoardMediaLinks.UpdateParameters.Item("Name").DefaultValue = txtMediaLinkName.Text
            sdBoardMediaLinks.UpdateParameters.Item("Url").DefaultValue = txtMediaLinkUrl.Text
            Dim res As Integer = sdBoardMediaLinks.Update()
            If (res = 1) Then
                txtMediaLinkName.Text = ""
                txtMediaLinkUrl.Text = ""
                btnAddMediaLink.Text = "ADD"
                Me.MediaLinkId = ""
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnSendrRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendrRequest.Click
        Try
            Dim boarder As String = cbAllBoardersList.SelectedValue
            Dim requestStatus As Integer = CheckRequest(boarder)
            If (requestStatus = 0) Then
                UpdateRequest(boarder, 0)
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, False, "Request is already pending")
            ElseIf (requestStatus = 1) Then
                UpdateRequest(boarder, 1)

                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Boarder has already accepted your request")
            ElseIf requestStatus = 2 Then
                UpdateRequest(boarder, 2)
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Request sent successfully")
            ElseIf (requestStatus = 3) Then
                sdCrowdBoardTeam.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
                sdCrowdBoardTeam.InsertParameters.Item("MemberID").DefaultValue = boarder
                sdCrowdBoardTeam.InsertParameters.Item("RequestTitle").DefaultValue = txtRequestTitle.Text
                sdCrowdBoardTeam.InsertParameters.Item("Description").DefaultValue = txtRequestDescription.Text
                sdCrowdBoardTeam.InsertParameters.Item("status").DefaultValue = 0
                sdCrowdBoardTeam.Insert()
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Request sent successfully")
                cbAllBoardersList.SelectedValue = 0
                txtRequestTitle.Text = ""
                txtRequestDescription.Text = ""
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageCrowdboardTeam, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub UpdateRequest(ByVal boarder As Integer, ByVal requestStatus As Integer)
        Try
            sdCrowdBoardTeam.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdCrowdBoardTeam.UpdateParameters.Item("MemberID").DefaultValue = boarder
            sdCrowdBoardTeam.UpdateParameters.Item("RequestTitle").DefaultValue = txtRequestTitle.Text
            sdCrowdBoardTeam.UpdateParameters.Item("Description").DefaultValue = txtRequestDescription.Text
            sdCrowdBoardTeam.UpdateParameters.Item("status").DefaultValue = requestStatus
            sdCrowdBoardTeam.Update()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageCrowdboardTeam, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnRequestDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRequestDelete.Click
        Try
            sdCrowdBoardTeam.DeleteParameters.Item("BoardID").DefaultValue = Me.boardID
            sdCrowdBoardTeam.DeleteParameters.Item("MemberID").DefaultValue = cbAllBoardersList.SelectedValue
            Dim result = sdCrowdBoardTeam.Delete()
            If (result = 1) Then
                GlobalModule.SetMessage(lblMessageCrowdboardTeam, True, "Request deleted")
                cbAllBoardersList.SelectedValue = 0
                txtRequestTitle.Text = ""
                txtRequestDescription.Text = ""
                btnSendrRequest.Text = "Send Request"
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub LoadBoaderLineupRequest()
        Try
            sdCrowdBoardTeam.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdCrowdBoardTeam.SelectParameters.Item("MemberID").DefaultValue = cbAllBoardersList.SelectedValue
            Dim dv As Data.DataView = CType(sdCrowdBoardTeam.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If (dv.Count > 0) Then
                    txtRequestTitle.Text = dv(0)("RequestTitle").ToString()
                    txtRequestDescription.Text = dv(0)("Description").ToString()
                    btnSendrRequest.Text = "Update Request"
                    btnRequestDelete.Visible = True
                Else
                    txtRequestTitle.Text = ""
                    txtRequestDescription.Text = ""
                    btnRequestDelete.Visible = False
                    btnSendrRequest.Text = "Send Request"
                End If
            Else
                txtRequestTitle.Text = ""
                txtRequestDescription.Text = ""
                btnRequestDelete.Visible = False
                btnSendrRequest.Text = "Send Request"
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub cbAllBoardersList_SelectedIndexChanged(ByVal sender As Object, ByVal e As Telerik.Web.UI.DropDownListEventArgs) Handles cbAllBoardersList.SelectedIndexChanged
        Try
            LoadBoaderLineupRequest()

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageStepTwo, False, "Error In Updating")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Function CheckRequest(ByVal memberID As String) As Integer
        Dim status As Integer
        Try
            sdCrowdBoardTeam.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdCrowdBoardTeam.SelectParameters.Item("MemberID").DefaultValue = memberID
            Dim dv As Data.DataView = CType(sdCrowdBoardTeam.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                status = dv(0)("status")
            Else
                status = 3
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
    Protected Sub btnSaveMoreInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveMoreInfo.Click
        Try
            Dim moreInfo As String = String.Empty


            If Not Me.DirectoryName = "" Then
                Dim filePath As String
                filePath = CreateDirectory()
                Using externalFile As New StreamWriter(filePath + "\Index.html", False)
                    externalFile.Write(reCreatePage.Content)
                    externalFile.Flush()
                    externalFile.Close()
                End Using
                Dim directoryName As String = Me.DirectoryName
                moreInfo = reCreatePage.Content
                sdUpdateCreatePageUrl.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
                sdUpdateCreatePageUrl.UpdateParameters.Item("MoreInfo").DefaultValue = moreInfo
                sdUpdateCreatePageUrl.UpdateParameters.Item("Url").DefaultValue = directoryName & "/" & "Index.html"
                sdUpdateCreatePageUrl.Update()
                LoadBoardDescriptionInfo()
                GlobalModule.SetMessage(lblMessageMoreInfo, True, "Data Saved Successfully")
            Else
                GlobalModule.SetMessage(lblMessageMoreInfo, False, "Please create board First")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageMoreInfo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Function CreateDirectory() As String
        Dim mainDirectoryPath As String
        mainDirectoryPath = ""
        Dim filePath As String
        filePath = ""
        Try
            mainDirectoryPath = "~/Upload/BoardDirectory/" & Me.DirectoryName
            filePath = HttpContext.Current.Server.MapPath(mainDirectoryPath)
            If Not Directory.Exists(filePath) Then
                Dim info As DirectoryInfo = Directory.CreateDirectory(filePath)
                If Not File.Exists(filePath + "\" + "Index.html") Then
                    Using stramWrite As New System.IO.StreamWriter(filePath + "\" + "Index.html", False)
                        stramWrite.Close()
                    End Using
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return filePath
    End Function
    Protected Function ReadFile(ByVal path As String) As String
        Dim content As String = ""
        Try
            Using sr As New System.IO.StreamReader(path)
                content = sr.ReadToEnd()
                sr.Close()
            End Using
        Catch ex As Exception
            Throw ex
        End Try
        Return content
    End Function

    Public Function GetAmount(ByVal amount As String) As String
        'LevelAmount String.Format("{0:C0}",Convert.ToDouble(Eval("LevelAmount")))
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, Me.BankLocation)
    End Function


End Class