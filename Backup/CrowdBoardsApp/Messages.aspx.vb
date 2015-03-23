Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient


Public Class Messages
    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Public Property messageTo() As Integer
        Get
            Return Convert.ToInt32(ViewState("_messageTo"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_messageTo") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If Not Page.IsPostBack Then
            Try
                countNotification()
            Catch ex As Exception
                GlobalModule.SetMessage(messageLabel, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
        lblNewMessage.Text = ""
        messageLabel.Text = ""
    End Sub
    Protected Sub SendMessage(ByVal ToUser As String, ByVal Text As String)
        Try
            sdMessages.InsertParameters.Item("FromUser").DefaultValue = Convert.ToInt32(Session("UserID"))
            sdMessages.InsertParameters.Item("ToUser").DefaultValue = ToUser
            sdMessages.InsertParameters.Item("Text").DefaultValue = Text
            sdMessages.InsertParameters.Item("Unread").DefaultValue = True
            sdMessages.Insert()
            SendUserEmail(ToUser)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub newMessageSendRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles newMessageSendRadButton.Click
        Try
            If txtNewMessage.Text <> "" Then
                SendMessage(friendRadCombobox.SelectedValue, txtNewMessage.Text)
                txtNewMessage.Text = ""
                Me.messageTo = friendRadCombobox.SelectedValue
                newMessageDiv.Attributes.Add("class", "HideNewDiv")
                LoadMessage(Me.messageTo)
                boardersRepeater.DataBind()
                ' newMessageDiv.Visible = False
            Else
                GlobalModule.SetMessage(lblNewMessage, False, "Please enter message")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblNewMessage, False, "Error in Sending Message")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub replyRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles replyRadButton.Click
        Try
            If replyMessageRadTexBox.Text <> "" Then
                SendMessage(Me.messageTo, replyMessageRadTexBox.Text)
                LoadMessage(Me.messageTo)
                boardersRepeater.DataBind()
                replyMessageRadTexBox.Text = " "
                replyMessageRadTexBox.Focus()

            Else
                GlobalModule.SetMessage(messageLabel, False, "Please enter message")
            End If

        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Sending Message")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function isAvail(ByVal img As String) As String

        Dim path = Server.MapPath(img)
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Private Sub LoadMessage(ByVal userID As Integer)
        Try
            sdUserName.SelectParameters("nodeUserName").DefaultValue = userID
            Dim dvUserName As DataView = CType(sdUserName.Select(DataSourceSelectArguments.Empty), DataView)
            If (dvUserName.Count > 0) Then
                If (Not IsDBNull(dvUserName(0)("UserName"))) Then
                    sdMessages.SelectParameters.Item("userIDNode").DefaultValue = dvUserName(0)("UserName")
                    Dim dv As DataView = CType(sdMessages.Select(DataSourceSelectArguments.Empty), DataView)
                    If Not (dv) Is Nothing Then
                        messageRepeater.DataSource = dv
                        messageRepeater.DataBind()
                        replyDiv.Visible = True
                        msgLabel.Text = "Conversation with <a>" + dvUserName(0)("UserName") + "</a>"
                        msgLabel.Visible = True
                    End If
                    sdMessages.UpdateParameters.Item("userIDNode").DefaultValue = userID
                    sdMessages.UpdateParameters.Item("userID").DefaultValue = Convert.ToInt32(Session("UserID"))
                    sdMessages.Update()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub newMessageUploadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles newMessageUploadButton.Click
        Try
            If newMessageRadAsyncUpload.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In newMessageRadAsyncUpload.UploadedFiles
                    Dim fileName As String = GetMessageID(upFiles.FileName, txtNewMessage.Text, friendRadCombobox.SelectedValue)
                    upFiles.SaveAs(Server.MapPath("~/Upload/MessageFiles") & "\\" & fileName)
                    SendUserEmail(friendRadCombobox.SelectedValue)
                Next
                txtNewMessage.Text = ""
                Me.messageTo = friendRadCombobox.SelectedValue
                newMessageDiv.Attributes.Add("class", "HideNewDiv")
                LoadMessage(Me.messageTo)
                boardersRepeater.DataBind()

            Else
                GlobalModule.SetMessage(lblNewMessage, False, "Please Select a file")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblNewMessage, False, "Error in Uploading file")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnUploadFilePhoto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadFilePhoto.Click
        Try
            If RadUpload1.UploadedFiles.Count > 0 Then
                For Each upFiles As UploadedFile In RadUpload1.UploadedFiles
                    Dim fileName As String = GetMessageID(upFiles.FileName, replyMessageRadTexBox.Text, Me.messageTo)
                    upFiles.SaveAs(Server.MapPath("~/Upload/MessageFiles") & "\\" & fileName)
                    LoadMessage(Me.messageTo)
                    SendUserEmail(Me.messageTo)
                Next
            Else
                GlobalModule.SetMessage(lblUploadFilePhoto, False, "Please Select a file")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblNewMessage, False, "Error in Uploading file")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Function GetMessageID(ByVal fileName As String, ByVal Text As String, ByVal ToUser As String) As String

        Try
            sdsMessageFiles.SelectParameters.Item("FromUser").DefaultValue = Convert.ToInt32(Session("userID").ToString())
            sdsMessageFiles.SelectParameters.Item("ToUser").DefaultValue = ToUser
            sdsMessageFiles.SelectParameters.Item("Text").DefaultValue = IIf(Text = String.Empty, "#", Text)
            sdsMessageFiles.SelectParameters.Item("Unread").DefaultValue = True
            sdsMessageFiles.SelectParameters.Item("FileName").DefaultValue = fileName
            Dim dv As Data.DataView = CType(sdsMessageFiles.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("fileName"))) Then
                        fileName = dv(0)("fileName")
                    Else
                        fileName = ""
                    End If
                End If
            Else
                fileName = ""
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return fileName
    End Function
    Protected Sub boardersRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles boardersRepeater.ItemDataBound
        Try
            Dim userdiv As System.Web.UI.HtmlControls.HtmlGenericControl
            userdiv = TryCast(e.Item.FindControl("users"), System.Web.UI.HtmlControls.HtmlControl)
            Dim row = TryCast(e.Item.FindControl("boarderPic"), Image)
            Dim hdnFriend = TryCast(e.Item.FindControl("hdnFriend"), HiddenField)
            Dim usersLabel = TryCast(e.Item.FindControl("usersLabel"), Label)
            Dim userLink = TryCast(e.Item.FindControl("userLink"), LinkButton)

            'userdiv.Attributes("onclick") = String.Format("showMessages(" & hdnFriend.Value & ");")

            userdiv.Attributes("onclick") = String.Format("showMessages(" & hdnFriend.Value & ",'" & userdiv.ClientID & "');")
          

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnShowMesaages_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowMesaages.Click
        Try
            Me.messageTo = hdnMessagesShow.Value
            newMessageDiv.Style.Add("display", "none")
            LoadMessage(Me.messageTo)
            boardersRepeater.DataBind()

            For Each RepeaterItem In boardersRepeater.Items
                Dim userdiv As System.Web.UI.HtmlControls.HtmlGenericControl
                userdiv = TryCast(RepeaterItem.FindControl("users"), System.Web.UI.HtmlControls.HtmlControl)
                If (userdiv.ClientID = hdnSelectedDivID.Value) Then
                    userdiv.Attributes.Add("style", "background:#ededed")
                End If
            Next


        Catch ex As Exception
            GlobalModule.SetMessage(lblNewMessage, False, "Error in Loading Messages")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub messageRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)

        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim forwareMessageImageButton As New ImageButton()
            forwareMessageImageButton = DirectCast(e.Item.FindControl("forwareMessageImageButton"), ImageButton)
            Dim cancelBtn As New ImageButton()
            cancelBtn = DirectCast(e.Item.FindControl("cancelBtn"), ImageButton)
            Dim myDiv As HtmlGenericControl = TryCast(e.Item.FindControl("forwardDiv"), HtmlGenericControl)
            forwareMessageImageButton.Attributes.Add("onmouseover", "showPopup('" + myDiv.ClientID + "');")
            cancelBtn.Attributes.Add("onmouseover", "hidePopup('" + myDiv.ClientID + "');")
            Dim fileName As New Label()
            Dim downLoadLinkButton As New LinkButton()
            Dim userPic As New Image()
            userPic = DirectCast(e.Item.FindControl("userPic"), Image)
            downLoadLinkButton = DirectCast(e.Item.FindControl("downLoadLinkButton"), LinkButton)
            fileName = DirectCast(e.Item.FindControl("fileNameLabel"), Label)
            If Not (fileName.Text = String.Empty Or fileName.Text = "") Then

                If (IsGraphicsFile(fileName.Text)) Then
                    userPic.Visible = True
                Else
                    downLoadLinkButton.Visible = True
                End If

            End If

            Dim lbl As New Label()
            lbl = DirectCast(e.Item.FindControl("userNameLabel"), Label)
            If lbl.Text.Trim() = "ME" Then
                DirectCast(e.Item.FindControl("messageDiv"), HtmlGenericControl).Attributes.Add("class", "row-left")
            Else
                DirectCast(e.Item.FindControl("messageDiv"), HtmlGenericControl).Attributes.Add("class", "row-right")
            End If

            Dim btnForword As New ImageButton()
            btnForword = DirectCast(e.Item.FindControl("btnForword"), ImageButton)
            Dim hdnMessageID As HiddenField = DirectCast(e.Item.FindControl("hdnMessageID"), HiddenField)
            btnForword.Attributes.Add("onclick", "return forwardMessage('" + Session("UserID").ToString() + "','" + hdnMessageID.Value + "','" + myDiv.ClientID + "');")
        End If
    End Sub
    Protected Sub messageRepeater_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles messageRepeater.ItemCommand
        Try


            Dim messageText As New Label()
            Dim fileNameLabel As New Label()
            Dim userboardRadComboBox As New RadComboBox()
            Dim downLoadLinkButton As New LinkButton()
            Dim fileName As New Label()
            fileName = DirectCast(e.Item.FindControl("fileNameLabel"), Label)
            downLoadLinkButton = CType(e.Item.FindControl("downLoadLinkButton"), LinkButton)
            userboardRadComboBox = DirectCast(e.Item.FindControl("forwardToRadCombobox"), RadComboBox)
            messageText = DirectCast(e.Item.FindControl("messageText"), Label)
            fileNameLabel = DirectCast(e.Item.FindControl("fileNameLabel"), Label)
            If (e.CommandName = "Download") Then
                DownloadFiles(e.CommandArgument.ToString(), downLoadLinkButton.Text)
            ElseIf (e.CommandName = "IDelete") Then
                DeleteFile(e.CommandArgument, fileName.Text)
            End If

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub DeleteFile(ByVal messageID As Integer, ByVal fileName As String)
        Try
            sdsMessageFiles.DeleteParameters.Item("messageID").DefaultValue = messageID
            Dim result As Integer = sdsMessageFiles.Delete()
            If (result = 1) Then
                DeleteMessageFile(fileName)
            Else
                GlobalModule.SetMessage(messageLabel, False, "Error in Message Deleted")
            End If
            LoadMessage(Me.messageTo)
        Catch ex As Exception
            GlobalModule.SetMessage(messageLabel, False, "Error in Message Deleted")
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Public Function IsGraphicsFile(ByVal Filename As String) As Boolean
        Try
            If (Filename = "" Or Filename = Nothing) Then
                Return False
            End If
            Filename = Filename.ToLower()
            If InStr(Filename, ".jpg") Or InStr(Filename, ".jpeg") Or _
               InStr(Filename, ".gif") Or InStr(Filename, ".bmp") Or InStr(Filename, ".png") Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return False
    End Function

    Private Sub countNotification()
        Try
            Dim dv As Data.DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("MessageCount"))) Then
                        ' notificationLabel.Text = "(" & dv(0)("MessageCount") & ")"
                    Else
                        'notificationLabel.Text = "(" & 0 & ")"
                    End If
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Public Function SelectUser(ByVal selectedUser As Object) As Boolean
        If (selectedUser.ToString() = hdnMessagesShow.Value) Then
            Return True
        Else
            Return False

        End If
    End Function

    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String

        Try
            Return HttpUtility.UrlEncode(GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, FilePath, thumbsFilePath))
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Function

    Private Sub DeleteMessageFile(ByVal fileName As String)
        Try

            Dim objFileInfo As System.IO.FileInfo
            Response.Clear()
            Dim rootPath = "~/Upload/MessageFiles/" & fileName
            Dim thumbRootPath = "~/Upload/MessageFiles/Thumbnail/" & fileName
            If Not System.IO.File.Exists(Server.MapPath(rootPath)) Then Exit Sub
            objFileInfo = New System.IO.FileInfo(Server.MapPath(rootPath))
            objFileInfo.Delete()
            If Not System.IO.File.Exists(Server.MapPath(thumbRootPath)) Then Exit Sub
            objFileInfo = New System.IO.FileInfo(Server.MapPath(thumbRootPath))
            objFileInfo.Delete()
            GlobalModule.SetMessage(messageLabel, True, "Message Deleted")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Private Sub DownloadFiles(ByVal fileName As String, ByVal fileText As String)
        Try
            Session("ExportPOPath") = Nothing
            Session("fileName") = Nothing
            Dim rootPath = "~/Upload/MessageFiles/" & fileName
            Session("ExportPOPath") = Server.MapPath(rootPath)
            Session("fileName") = fileText
            Response.Redirect("~/ExportText.aspx", False)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub SendUserEmail(ByVal userID As String)

        sdsUserEmail.SelectParameters.Item("ToUser").DefaultValue = userID
        Dim dv As Data.DataView = CType(sdsUserEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("userEmail"))) Then
                    If (Not dv(0)("userEmail") = "") Then
                        GlobalModule.SendEmail(dv(0)("userEmail"), "You Have a Message!", "A fellow CrowdBoarder has sent you a message. Login to see what they said:<a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>", True)
                    End If
                End If
            End If
        End If
    End Sub
End Class