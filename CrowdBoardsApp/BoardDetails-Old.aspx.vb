Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Partial Class BoardDetailsOld
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim boardID As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString.Count > 0 Then
            If Request.QueryString("Name") IsNot Nothing Then
                Me.boardID = getBoardId()
                If (Me.boardID = 0) Then
                    Response.Redirect("~/Board.aspx?Name=" & Request.QueryString("Name"))
                End If

            End If
        ElseIf Session("boardID") IsNot Nothing Then
            Me.boardID = Session("boardID")
        Else
            Response.Redirect("~/Home.aspx")
        End If
        lblErrorMessageForm.Visible = False
        If (Not Page.IsPostBack) Then
            Try
                BindCountry()
                LoadBoardDescriptionInfo()
                CheckDistrictAndLevel()
            Catch ex As Exception
                lblErrorMessageForm.Visible = True
                lblErrorMessageForm.Text = "Error in Loading Data"
                lblErrorMessageForm.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try
            sdBoard.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardLevel.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdUnconfirmedInvestors.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdComboBoxBoardLevelDataSource.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("BoardName"))) Then
                    txtBoardName.Text = dv(0)("BoardName")
                    btnCreatePage.Visible = True
                Else
                    btnCreatePage.Visible = False
                End If
                If (Not IsDBNull(dv(0)("InvType"))) Then
                    rcbInvestmentType.SelectedValue = Convert.ToInt16(dv(0)("InvType"))
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    txtDescription.Text = dv(0)("Description")
                End If

                If (Not IsDBNull(dv(0)("URL"))) Then

                    txtUrl.Text = dv(0)("URL")
                End If
                If (Not IsDBNull(dv(0)("Keywords"))) Then
                    txtKeword.Text = dv(0)("Keywords")
                End If
                If (Not IsDBNull(dv(0)("DirectoryName"))) Then
                    hdnDirectoryName.Value = dv(0)("DirectoryName")
                    Dim iPath As String = Path.Combine(Server.MapPath("thumbnail"), hdnDirectoryName.Value & ".jpg")
                    If System.IO.File.Exists(iPath) Then
                        lblUploadedFile.Text = hdnDirectoryName.Value & ".jpg" & " uploaded"
                        lblUploadedFile.ForeColor = Drawing.Color.Green
                    Else
                        lblUploadedFile.Text = " No image uploaded"
                        lblUploadedFile.ForeColor = Drawing.Color.Red
                    End If
                Else
                    lblUploadedFile.Text = " No image uploaded"
                    lblUploadedFile.ForeColor = Drawing.Color.Red
                End If

                If (Not IsDBNull(dv(0)("Status"))) Then
                    txtStatus.Text = dv(0)("Status")
                End If
                If (Not IsDBNull(dv(0)("DateActivated"))) Then
                    txtDateActivated.Text = dv(0)("DateActivated")
                End If
                If (Not IsDBNull(dv(0)("Status"))) Then
                    hdnStatusID.Value = dv(0)("Status")
                Else
                    hdnStatusID.Value = "0"
                End If
                If (Not IsDBNull(dv(0)("ENGLISH"))) Then
                    txtStatus.Text = dv(0)("ENGLISH")
                End If
                If (Not IsDBNull(dv(0)("areaID"))) Then
                    rcbArea.SelectedValue = dv(0)("areaID")
                    SelectedDistrictAndArea()
                End If

                If (Not IsDBNull(dv(0)("District1"))) Then
                    rcbDistrict.SelectedValue = dv(0)("District1")

                End If
                If (Not IsDBNull(dv(0)("AudienceDesc"))) Then
                    txtAudience.Text = dv(0)("AudienceDesc")
                End If
                If (Not IsDBNull(dv(0)("UniquenessDesc"))) Then
                    txtUniqueness.Text = dv(0)("UniquenessDesc")
                End If
                If (Not IsDBNull(dv(0)("RevenueDesc"))) Then
                    txtRevenue.Text = dv(0)("RevenueDesc")
                End If
                If (Not IsDBNull(dv(0)("city"))) Then
                    txtCity.Text = dv(0)("city")
                End If
                If (Not IsDBNull(dv(0)("state"))) Then
                    txtState.Text = dv(0)("state")

                End If
                If (Not IsDBNull(dv(0)("country"))) Then
                    countryComboBox.SelectedValue = dv(0)("country")
                    BindCountry()
                End If


                rgBoardInvestorLevel.AutoGenerateEditColumn = False
                If (Convert.ToInt16("0" + dv(0)("Status")) = 0) Then
                    btnStatusChange.Text = "Activate"
                    rgBoardInvestorLevel.AutoGenerateEditColumn = True

                ElseIf (Convert.ToInt16("0" + dv(0)("Status")) = 1) Then
                    btnStatusChange.Text = "Deactivate"
                Else
                    btnStatusChange.Visible = False
                End If

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Protected Sub rgBoardInvestorLevel_InsertCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardInvestorLevel.InsertCommand
        Try
            Dim editedItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = editedItem.EditManager
            sdBoardLevel.InsertParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardLevel.InsertParameters.Item("LevelName").DefaultValue = CType(editMan.GetColumnEditor("LevelName"), GridTextBoxColumnEditor).Text
            sdBoardLevel.InsertParameters.Item("Description").DefaultValue = CType(editMan.GetColumnEditor("Description"), GridTextBoxColumnEditor).Text
            sdBoardLevel.InsertParameters.Item("NumOffered").DefaultValue = CType(editMan.GetColumnEditor("NumOffered"), GridTextBoxColumnEditor).Text
            sdBoardLevel.InsertParameters.Item("LevelAmount").DefaultValue = CType(editMan.GetColumnEditor("LevelAmount"), GridTextBoxColumnEditor).Text
            sdBoardLevel.Insert()
        Catch ex As Exception
            lblErrorMessageGrid.Visible = True
            lblErrorMessageGrid.Text = "Error in Creating Borad Investor Level"
            GlobalModule.ErrorLogFile(ex)
            Exit Sub
        End Try
    End Sub
    Protected Sub rgUnconfirmedInvestors_InsertCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgUnconfirmedInvestors.InsertCommand
        Try
            Dim editedItem As GridEditableItem = CType(e.Item, GridEditableItem)
            Dim editMan As GridEditManager = editedItem.EditManager
            sdUnconfirmedInvestors.InsertParameters.Item("BoardId").DefaultValue = Me.boardID
            sdUnconfirmedInvestors.InsertParameters.Item("EmailAddress").DefaultValue = CType(editMan.GetColumnEditor("EmailAddress"), GridTextBoxColumnEditor).Text
            sdUnconfirmedInvestors.InsertParameters.Item("Name").DefaultValue = CType(editMan.GetColumnEditor("Name"), GridTextBoxColumnEditor).Text
            sdUnconfirmedInvestors.InsertParameters.Item("BoardLevel").DefaultValue = CType(editMan.GetColumnEditor("LevelID"), GridDropDownColumnEditor).SelectedValue
            sdUnconfirmedInvestors.Insert()
        Catch ex As Exception
            lblErrorMessageGrid.Visible = True
            lblErrorMessageGrid.Text = "Error in Sending Request"
            GlobalModule.ErrorLogFile(ex)
            Exit Sub
        End Try
    End Sub
    Private Sub SaveChanges(ByVal status As String)
        Try
            Dim directoryName As String
            directoryName = txtBoardName.Text.Trim.ToLower.Replace(" ", "-")

            sdBoard.UpdateParameters.Item("BoardName").DefaultValue = txtBoardName.Text
            sdBoard.UpdateParameters.Item("Description").DefaultValue = txtDescription.Text
            sdBoard.UpdateParameters.Item("URL").DefaultValue = txtUrl.Text
            sdBoard.UpdateParameters.Item("Keywords").DefaultValue = txtKeword.Text
            sdBoard.UpdateParameters.Item("DirectoryName").DefaultValue = directoryName
            If status = "1" Then
                sdBoard.UpdateParameters.Item("Status").DefaultValue = status
                sdBoard.UpdateParameters.Item("DateActivated").DefaultValue = System.DateTime.Now
            ElseIf status = "3" Then
                sdBoard.UpdateParameters.Item("Status").DefaultValue = status
                sdBoard.UpdateParameters.Item("DateDeactivated").DefaultValue = System.DateTime.Now
            Else
                sdBoard.UpdateParameters.Item("Status").DefaultValue = status
            End If
            sdBoard.UpdateParameters.Item("InvType").DefaultValue = rcbInvestmentType.SelectedValue
            sdBoard.UpdateParameters.Item("District1").DefaultValue = rcbDistrict.SelectedValue
            sdBoard.UpdateParameters.Item("AudienceDesc").DefaultValue = txtAudience.Text
            sdBoard.UpdateParameters.Item("UniquenessDesc").DefaultValue = txtUniqueness.Text
            sdBoard.UpdateParameters.Item("RevenueDesc").DefaultValue = txtRevenue.Text
            sdBoard.UpdateParameters.Item("city").DefaultValue = txtCity.Text
            sdBoard.UpdateParameters.Item("state").DefaultValue = txtState.Text
            sdBoard.UpdateParameters.Item("country").DefaultValue = countryComboBox.SelectedValue
            '------
            sdBoard.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoard.Update()
            LoadBoardDescriptionInfo()
            lblErrorMessageForm.Visible = True
            lblErrorMessageForm.ForeColor = Drawing.Color.Green
            lblErrorMessageForm.Text = "Updated Successfully"
        Catch ex As Exception
            'we need to call popup here
            lblErrorMessageForm.Visible = True
            lblErrorMessageForm.Text = "Error in Update"
            lblErrorMessageForm.ForeColor = Drawing.Color.Red

            If (ex.Message.Contains("d_Name")) Then
                RadWindow1.NavigateUrl = "rwSaveDirectoryName.aspx"
                RadWindow1.VisibleOnPageLoad = True
            End If
            GlobalModule.ErrorLogFile(ex)
            Exit Sub

        End Try
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Response.Redirect("~/Home.aspx")
    End Sub



    Protected Sub btnStatusChange_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnStatusChange.Click
        Try
            If (hdnDirectoryName.Value <> "") Then
                sdBillingInformationDataSource.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                Dim dv As Data.DataView = CType(sdBillingInformationDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (IsDBNull(dv(0)("Address")) Or IsDBNull(dv(0)("City")) Or IsDBNull(dv(0)("State")) Or IsDBNull(dv(0)("Zip")) Or IsDBNull(dv(0)("SocialSecurityNumber"))) Then
                        Page.ClientScript.RegisterStartupScript(Me.[GetType](), "MyScript1", "javascript:confirmProfile('" & hdnDirectoryName.Value & "');", True)
                    Else
                        If (hdnStatusID.Value = "0") Then
                            SaveChanges("1")
                        ElseIf (hdnStatusID.Value = "1") Then
                            SaveChanges("3")
                        End If
                    End If
                End If
            End If
        Catch ex As Exception

            lblErrorMessageForm.ForeColor = Drawing.Color.Red
            lblErrorMessageForm.Visible = True
            lblErrorMessageForm.Text = "Error in Processing Request"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpload.Click
        Try
            If ruThumbnail.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In ruThumbnail.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/thumbnail") & "\\" & hdnDirectoryName.Value & ".jpg")
                    LoadBoardDescriptionInfo()
                    Exit Sub
                Next
            Else
                lblErrorMessageForm.Visible = True
                lblErrorMessageForm.Text = "Only JPG files are allowed"
            End If
        Catch ex As Exception
            lblErrorMessageForm.ForeColor = Drawing.Color.Red
            lblErrorMessageForm.Visible = True
            lblErrorMessageForm.Text = "Error in Upload"
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Protected Sub rgBoardInvestorLevelRadGrid_UpdateCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardInvestorLevel.UpdateCommand

        Dim dv As Data.DataView = CType(sdBoardLevel.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If (dv(0)("Status") > 0) Then
            rgBoardInvestorLevel.AutoGenerateEditColumn = False
        Else
            Try
                Dim editedItem As GridEditableItem = CType(e.Item, GridEditableItem)
                Dim editMan As GridEditManager = editedItem.EditManager
                sdBoardLevel.UpdateParameters.Item("LevelName").DefaultValue = CType(editMan.GetColumnEditor("LevelName"), GridTextBoxColumnEditor).Text
                sdBoardLevel.UpdateParameters.Item("Description").DefaultValue = CType(editMan.GetColumnEditor("Description"), GridTextBoxColumnEditor).Text
                sdBoardLevel.UpdateParameters.Item("NumOffered").DefaultValue = CType(editMan.GetColumnEditor("NumOffered"), GridTextBoxColumnEditor).Text
                sdBoardLevel.UpdateParameters.Item("LevelAmount").DefaultValue = CType(editMan.GetColumnEditor("LevelAmount"), GridTextBoxColumnEditor).Text

                sdBoardLevel.UpdateParameters.Item("LevelID").DefaultValue = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex)("LevelID")
                sdBoardLevel.UpdateParameters.Item("BoardId").DefaultValue = Me.boardID
                sdBoardLevel.Update()
            Catch ex As Exception
                lblErrorMessageGrid.Visible = True
                lblErrorMessageGrid.Text = ex.Message
                lblErrorMessageGrid.Text = "Error in Update"
                GlobalModule.ErrorLogFile(ex)
                Exit Sub
            End Try

        End If
    End Sub
    Protected Sub txtBoardName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBoardName.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtDescription_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDescription.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtUrl_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUrl.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtKeword_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtKeword.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub rcbInvestmentType_SelectedIndexChanged(ByVal sender As Object, ByVal e As RadComboBoxSelectedIndexChangedEventArgs) Handles rcbInvestmentType.SelectedIndexChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub rcbDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As RadComboBoxSelectedIndexChangedEventArgs) Handles rcbDistrict.SelectedIndexChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub rcbArea_SelectedIndexChanged(ByVal sender As Object, ByVal e As RadComboBoxSelectedIndexChangedEventArgs) Handles rcbArea.SelectedIndexChanged
        SelectedDistrictAndArea()
    End Sub
    Protected Sub txtAudience_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAudience.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtUniqueness_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUniqueness.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtRevenue_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRevenue.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtState_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtState.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub txtCity_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCity.TextChanged
        SaveChanges(hdnStatusID.Value)
    End Sub
    Protected Sub countryComboBox_SelectedIndexChanged(ByVal sender As Object, ByVal e As RadComboBoxSelectedIndexChangedEventArgs) Handles countryComboBox.SelectedIndexChanged
        SaveChanges(hdnStatusID.Value)
    End Sub


    Protected Sub btnCreatePage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreatePage.Click
        Try
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim directoryName As String = dv(0)("DirectoryName")
            Response.Redirect("~/BoardPage.aspx?Name=" + directoryName, False)
        Catch ex As Exception
            lblErrorMessageForm.Visible = True
            lblErrorMessageForm.Text = "Error in Page Creation"
            lblErrorMessageForm.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Function getBoardId() As Integer
        Dim boardId As Integer = 0
        Try
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                boardId = dv(0)("BoardID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return boardId
    End Function
    Protected Sub SelectedDistrictAndArea()
        Try
            sdComboBoxDistrict.SelectParameters.Item("AreaID").DefaultValue = rcbArea.SelectedValue
            rcbDistrict.DataTextField = "DistrictName"
            rcbDistrict.DataValueField = "DistrictID"
            rcbDistrict.DataSource = sdComboBoxDistrict()
            rcbDistrict.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub BindCountry()
        Try
            countryComboBox.DataSource = sdCountry
            countryComboBox.DataValueField = "CountryName"
            countryComboBox.DataTextField = "CountryName"
            countryComboBox.DataBind()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Protected Sub CheckDistrictAndLevel()
        Try
            sdCheckDistrictAndLevel.SelectParameters.Item("BoardId").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdCheckDistrictAndLevel.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If dv(0)("Status") = "1" Then
                    btnStatusChange.Enabled = True
                    btnStatusChange.ToolTip = ""
                Else
                    btnStatusChange.Enabled = False
                    btnStatusChange.ToolTip = "Make sure you have Area/Distirct are set and there is atleast one Investment Level exits"
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class
