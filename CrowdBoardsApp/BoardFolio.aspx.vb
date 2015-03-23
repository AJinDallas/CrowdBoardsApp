Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Drawing
Public Class BoardFolio
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If Not Page.IsPostBack Then
            lbtnBoardfolio.Attributes.Add("style", "text-decoration:underline")
            LoadInvestmentDetails()
            LoadBoard()
            Dim listItem As New ListItem
            listItem.Value = 0
            listItem.Text = "Default URL"
            ddlCrowdboardlink.Items.Add(listItem)
            If (ddlCrowdboardlink.Items.Count = 1) Then
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/Default.aspx?from=" & Session("UserID")
            Else
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/" + ddlCrowdboardlink.SelectedValue + "?from=" & Session("UserID")
            End If
        End If
    End Sub
    Protected Sub LoadInvestmentDetails()
        Try
            Dim dv As Data.DataView = CType(sdInvestmentDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim dvBoardsWatching As Data.DataView = CType(sdBoardsWatching.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dvBoardsWatching) Is Nothing Then
                watchListCountLabel.Text = dvBoardsWatching.Count.ToString()
            Else
                watchListCountLabel.Text = "0"
            End If

            If dv.Count > 0 Then
                Dim dt As New DataTable
                Dim GM As New GlobalModule
                dt = dv.ToTable()
                If (dt.Rows.Count > 0) Then
                    lblTotalBoardsIn.Text = dt.Compute("sum(TotalBoards)", "").ToString()
                Else
                    lblTotalBoardsIn.Text = "0"
                End If

                Dim str As String = "0"
                Dim Rows1 As DataRow() = dt.Select("BankLocation='US'")
                Dim Rows2 As DataRow() = dt.Select("BankLocation='UK'")
                If (Rows1.Count > 0) Then
                    str = GM.GetAmountAccordingToLocation(Rows1(0)("InFor").ToString(), "US")
                End If
                If (Rows2.Count > 0) Then
                    str = str & "," & GM.GetAmountAccordingToLocation(Rows2(0)("InFor").ToString(), "UK")
                End If
                lblInFor.Text = str.Trim(",")
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub



    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String
        Dim result As String = String.Empty
        Try
            result = GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, FilePath, thumbsFilePath)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return result
    End Function
    Protected Sub boardsInvestedDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles boardsInvestedDataList.ItemDataBound
        Try
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim hdnVisibilityType = TryCast(e.Item.FindControl("hdnVisibilityType"), HiddenField)
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("covPicLineup"), HtmlGenericControl)
            If Not (hdnMaxValue.Value = "") Then
                thermometerSlider.MaximumValue = Convert.ToDouble(hdnMaxValue.Value)
            Else
                thermometerSlider.MaximumValue = 5000
            End If
            If Not (hdnValue.Value = "") Then
                thermometerSlider.Value = Convert.ToDouble(hdnValue.Value)
            Else
                thermometerSlider.Value = 0
            End If

            Dim lblPublic As Label = TryCast(e.Item.FindControl("lblPublic"), Label)
            Dim lblPrivate As Label = TryCast(e.Item.FindControl("lblPrivate"), Label)
            If Not hdnVisibilityType.Value = "" Then
                If hdnVisibilityType.Value = "Public" Then
                    lblPublic.Attributes.Add("style", "color:#99CCFF")
                    lblPrivate.Attributes.Add("style", "color:#788586")
                Else
                    lblPrivate.Attributes.Add("style", "color:#99CCFF")
                    lblPublic.Attributes.Add("style", "color:#788586")
                End If
            End If

            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
                'coverPicDiv.Attributes.Add("style", "background-color:#626262;min-height: 100px; width: 100%;")
            End If

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub boardsWatchingDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles boardsWatchingDataList.ItemDataBound
        Try
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim hdnPrivateWatch = TryCast(e.Item.FindControl("hdnPrivateWatch"), HiddenField)
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)

            If Not (hdnMaxValue.Value = "") Then
                thermometerSlider.MaximumValue = Convert.ToDouble(hdnMaxValue.Value)
            Else
                thermometerSlider.MaximumValue = 5000
            End If
            If Not (hdnValue.Value = "") Then
                thermometerSlider.Value = Convert.ToDouble(hdnValue.Value)
            Else
                thermometerSlider.Value = 0
            End If
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicWatchDiv"), HtmlGenericControl)
            Dim lblPublic As Label = TryCast(e.Item.FindControl("lblPublic"), Label)
            Dim lblPrivate As Label = TryCast(e.Item.FindControl("lblPrivate"), Label)
            If Not hdnPrivateWatch.Value = "" Then
                If hdnPrivateWatch.Value = "False" Then
                    lblPublic.Attributes.Add("style", "color:#99CCFF")
                    lblPrivate.Attributes.Add("style", "color:#788586")
                Else
                    lblPrivate.Attributes.Add("style", "color:#99CCFF")
                    lblPublic.Attributes.Add("style", "color:#788586")
                End If
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")

                'coverPicDiv.Attributes.Add("style", "background-color:#626262;min-height: 100px; width: 100%;")
            End If

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            img = img.Replace("~", "..")
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function

    Protected Sub lbtnBoardfolio_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBoardfolio.Click
        Try
            lbtnBoardfolio.Attributes.Add("style", "text-decoration:underline")
            lbtnWatchList.Attributes.Add("style", "text-decoration:none")
            lbtnReferal.Attributes.Add("style", "text-decoration:none")
            radMultiPageBoardFolio.SelectedIndex = 0
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub lbtnWatchList_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnWatchList.Click
        Try
            lbtnWatchList.Attributes.Add("style", "text-decoration:underline")
            lbtnBoardfolio.Attributes.Add("style", "text-decoration:none")
            lbtnReferal.Attributes.Add("style", "text-decoration:none")
            radMultiPageBoardFolio.SelectedIndex = 1
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnSendEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendEmail.Click

        Try
            If Not txtSendMultipleEmail.Text = "" Then
                Dim emailList As String = txtSendMultipleEmail.Text
                If (GlobalModule.ValidateEmail(emailList)) Then
                    Dim list As New ArrayList()
                    list.AddRange(emailList.Split(New Char() {","c}))
                    SendRequest(list)
                Else
                    GlobalModule.SetMessage(lblMessageSendEmail, False, "Please Enter valid Email Id")
                End If
            Else
                GlobalModule.SetMessage(lblMessageSendEmail, False, "Please enter Email Id")
            End If
            If (ddlCrowdboardlink.SelectedValue = "0") Then
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/Default.aspx?from=" & Session("UserID")
            Else
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/" + ddlCrowdboardlink.SelectedValue + "?from=" & Session("UserID")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSendEmail, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendRequest(ByVal Emails As ArrayList)
        Try
            If Not Emails Is Nothing Then
                Dim strSubject As String = "CrowdBoard Invitation"
                Dim strBody As String = "<span style='font-size:11.0pt;font-family:Calibri,sans-serif;color:#1f497d'> Your friend " & Session("userName") & " has  invited you to check out "
                Dim returnUrl As String = String.Empty
                If (ddlCrowdboardlink.SelectedValue = "0") Then
                    returnUrl = ConfigurationManager.AppSettings("site").ToString() + "/Default.aspx?from=" & Session("UserID")
                Else
                    returnUrl = ConfigurationManager.AppSettings("site").ToString() & "/" & ddlCrowdboardlink.SelectedValue & "?from=" & Session("UserID")
                End If

                Dim verificationLink As String = "<a style='text-decoration:none' href='" & returnUrl & "'>" & Request.Url.Host.ToLower() & ".&nbsp;</a>"
                strBody = strBody & verificationLink & "Click the link, sign up, and check it out!<br><br></span>"
                For Each strMailTo As String In Emails
                    GlobalModule.SendEmail(strMailTo, strSubject, strBody, True)
                Next
                GlobalModule.SetMessage(lblMessageSendEmail, True, "Request sent Successfully")
            Else
                GlobalModule.SetMessage(lblMessageSendEmail, True, "Please enter Email Addresses")
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub lbtnReferal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnReferal.Click
        Try

            lbtnReferal.Attributes.Add("style", "text-decoration:underline")
            lbtnWatchList.Attributes.Add("style", "text-decoration:none")
            lbtnBoardfolio.Attributes.Add("style", "text-decoration:none")
            radMultiPageBoardFolio.SelectedIndex = 2
            If (ddlCrowdboardlink.SelectedValue = "0") Then
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/Default.aspx?from=" & Session("UserID")
            Else
                urlTextLabel.Text = ConfigurationManager.AppSettings("site").ToString() + "/" + ddlCrowdboardlink.SelectedValue + "?from=" & Session("UserID")
            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub LoadBoard()
        ddlCrowdboardlink.DataSource = sdAllActiveBoard
        ddlCrowdboardlink.DataTextField = "BoardName"
        ddlCrowdboardlink.DataValueField = "DirectoryName"
        ddlCrowdboardlink.DataBind()

    End Sub


    Protected Sub boardersDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles boardersDataList.ItemDataBound
        Try
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("firendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            'Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width: 100%;background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%;padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

End Class