Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Web.UI.WebControls
Imports System.IO
Public Class MyProfileOld
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)

        End If
        If (Not Page.IsPostBack) Then
            Try
                LoadUserInfo()
            Catch ex As Exception
                lblMessage.Visible = True
                lblMessage.Text = "Error in Loading Data"
                lblMessage.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
        If Not Request.QueryString("Name") Is Nothing Then
            btnClose.Visible = True
        End If

    End Sub

    Private Sub SaveChanges()
        Try
            sdBillingInformation.UpdateParameters.Item("Address").DefaultValue = txtAddress.Text
            sdBillingInformation.UpdateParameters.Item("City").DefaultValue = txtCity.Text
            sdBillingInformation.UpdateParameters.Item("State").DefaultValue = txtState.Text
            sdBillingInformation.UpdateParameters.Item("Zip").DefaultValue = txtZip.Text
            sdBillingInformation.UpdateParameters.Item("SocialSecuritynumber").DefaultValue = txtSsn.Text
            sdBillingInformation.UpdateParameters.Item("FirstName").DefaultValue = txtFirstName.Text
            sdBillingInformation.UpdateParameters.Item("LastName").DefaultValue = txtLastName.Text
            sdBillingInformation.UpdateParameters.Item("Job").DefaultValue = txtJob.Text
            sdBillingInformation.UpdateParameters.Item("Birthdate").DefaultValue = txtBirthdate.Text
            sdBillingInformation.UpdateParameters.Item("AboutMe").DefaultValue = txtAboutMe.Text
            sdBillingInformation.UpdateParameters.Item("MyDreams").DefaultValue = txtMyDreams.Text
            sdBillingInformation.UpdateParameters.Item("userID").DefaultValue = Session("userName")
            sdBillingInformation.Update()
            LoadUserInfo()
            lblMessage.Visible = True
            lblMessage.Text = "Successfully Saved"
            lblMessage.ForeColor = Drawing.Color.Green
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Error in Update"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Private Sub LoadUserInfo()
        Try


            Dim dv As Data.DataView = CType(sdBillingInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then

                If (Not IsDBNull(dv(0)("FirstName"))) Then
                    txtFirstName.Text = dv(0)("FirstName")
                End If

                If (Not IsDBNull(dv(0)("LastName"))) Then
                    txtLastName.Text = dv(0)("LastName")
                End If

                If (Not IsDBNull(dv(0)("Job"))) Then
                    txtJob.Text = dv(0)("Job")
                End If

                If (Not IsDBNull(dv(0)("Birthdate"))) Then
                    txtBirthdate.Text = dv(0)("Birthdate")
                End If

                If (Not IsDBNull(dv(0)("AboutMe"))) Then
                    txtAboutMe.Text = dv(0)("AboutMe")
                End If

                If (Not IsDBNull(dv(0)("MyDreams"))) Then
                    txtMyDreams.Text = dv(0)("MyDreams")
                End If

                If (Not IsDBNull(dv(0)("Address"))) Then
                    txtAddress.Text = dv(0)("Address")
                End If

                If (Not IsDBNull(dv(0)("City"))) Then
                    txtCity.Text = dv(0)("City")
                End If

                If (Not IsDBNull(dv(0)("State"))) Then

                    txtState.Text = dv(0)("State")
                End If
                If (Not IsDBNull(dv(0)("Zip"))) Then
                    txtZip.Text = dv(0)("Zip")
                End If


                If (Not IsDBNull(dv(0)("SocialSecurityNumber"))) Then
                    txtSsn.Text = dv(0)("SocialSecurityNumber")
                End If
            End If
            PictureUploadMessage(lblUploadProfilePic, "Upload/ProfilePics")
            PictureUploadMessage(lblUploadBackgroundPicture, "Upload/BackgroundPics")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub txtAddress_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAddress.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtCity_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCity.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtState_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtState.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtZip_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtZip.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtSsn_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSsn.TextChanged
        SaveChanges()
    End Sub

    Protected Sub txtFirstName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFirstName.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtLastName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtLastName.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtJob_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtJob.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtBirthdate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBirthdate.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtAboutMe_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAboutMe.TextChanged
        SaveChanges()
    End Sub
    Protected Sub txtMyDreams_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtMyDreams.TextChanged
        SaveChanges()
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Response.Redirect("~/BoardDetails.aspx?Name=" & Request.QueryString("Name"))
    End Sub

    Protected Sub btnUploadProfilePic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadProfilePic.Click
        Try
            If ruProfilePic.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In ruProfilePic.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/Upload/ProfilePics") & "\\" & Session("userName").ToString() & ".jpg")
                    LoadUserInfo()
                    Exit Sub
                Next
            Else
                lblUploadProfilePic.Visible = True
                lblUploadProfilePic.Text = "Only JPG files are allowed"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Error in Uploading Profile Image"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnUploadBackgroundPicture_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadBackgroundPicture.Click
        Try
            If ruBackgroundPicture.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In ruBackgroundPicture.UploadedFiles
                    upFiles.SaveAs(Server.MapPath("~/Upload/BackgroundPics") & "\\" & Session("userName").ToString() & ".jpg")
                    LoadUserInfo()
                    Exit Sub
                Next

            Else
                lblUploadBackgroundPicture.Visible = True
                lblUploadBackgroundPicture.Text = "Only JPG files are allowed"
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Error in Uploading Background Image"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub PictureUploadMessage(ByVal LabelID As Label, ByVal FolderName As String)
        Try
            If Not Session("userName").ToString() Is Nothing Then
                Dim iPath As String = Path.Combine(Server.MapPath(FolderName), Session("userName").ToString() & ".jpg")
                If System.IO.File.Exists(iPath) Then
                    LabelID.Text = Session("userName").ToString() & ".jpg" & " uploaded"
                    LabelID.ForeColor = Drawing.Color.Green
                Else
                    LabelID.Text = " No image uploaded"
                    LabelID.ForeColor = Drawing.Color.Red
                End If
            Else
                LabelID.Text = " No image uploaded"
                LabelID.ForeColor = Drawing.Color.Red
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub rgUserDistricts_InsertCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgUserDistricts.InsertCommand
        Try
            Dim insertedItem As GridEditFormInsertItem = TryCast(e.Item, GridEditFormInsertItem)
            Dim editMan As GridEditManager = insertedItem.EditManager
            sdUserDistricts.InsertParameters.Item("UserID").DefaultValue = Session("userName")
            sdUserDistricts.InsertParameters.Item("DistrictID").DefaultValue = DirectCast(editMan.GetColumnEditor("DistrictName"), GridDropDownColumnEditor).SelectedValue
            sdUserDistricts.Insert()
            rgUserDistricts.Rebind()
        Catch ex As Exception
            lblMessage.Text = "Error in Saving"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub rgUserDistricts_DeleteCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgUserDistricts.DeleteCommand
        Try
            Dim item As GridDataItem = DirectCast(e.Item, GridDataItem)
            Dim districtsID As Int32 = Convert.ToInt32(item.OwnerTableView.DataKeyValues(item.ItemIndex)("DistrictID"))
            sdUserDistricts.DeleteParameters.Item("DistrictID").DefaultValue = districtsID
            sdUserDistricts.DeleteParameters.Item("UserID").DefaultValue = Session("userName")
            sdUserDistricts.Delete()
        Catch ex As Exception

            lblMessage.Text = "Error in Deletion"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class