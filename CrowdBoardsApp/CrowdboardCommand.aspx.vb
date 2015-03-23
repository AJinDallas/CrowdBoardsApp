Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Imports System.Threading

Public Class CrowdboardCommand
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageSetOne.Text = ""

        RadWindow1.VisibleOnPageLoad = False
        If (Not Page.IsPostBack) Then
            Try
                LoadAllBoardsRepeater()
            Catch ex As Exception
                GlobalModule.SetMessage(lblMessage, False, "Error in Loading Data")
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If

    End Sub

    Public Sub LoadAllBoardsRepeater()
        Try
            Dim dv As Data.DataView = CType(sdAllBoards.Select(DataSourceSelectArguments.Empty), Data.DataView)
            surfBoardsRepeater.DataSource = dv
            surfBoardsRepeater.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub surfBoardsRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles surfBoardsRepeater.ItemDataBound
        Try
            '-----------
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim hdnBoardName = TryCast(e.Item.FindControl("hdnBoardName"), HiddenField)
            Dim ibtnPlay As ImageButton = TryCast(e.Item.FindControl("ibtnPlay"), ImageButton)
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("coverPicWatchDiv"), HtmlGenericControl)

            Dim largeChange As Integer
            If Not (hdnMaxValue.Value = "") Then
                thermometerSlider.MaximumValue = Convert.ToDecimal(hdnMaxValue.Value)
                largeChange = Convert.ToInt32(hdnMaxValue.Value) / 5
                thermometerSlider.LargeChange = largeChange
            Else
                thermometerSlider.MaximumValue = 5000
                largeChange = 5000 / 5
                thermometerSlider.LargeChange = largeChange
            End If
            If Not (hdnValue.Value = "") Then
                thermometerSlider.Value = Convert.ToDouble(hdnValue.Value)
            Else
                thermometerSlider.Value = 0
            End If
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/profilebanner.jpeg);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")

                'coverPicDiv.Attributes.Add("style", "background-color:#626262;min-height: 100px; width: 100%;")
            End If
            '------------
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub surfBoardsRepeater_ItemCommand(ByVal source As Object, ByVal e As RepeaterCommandEventArgs) Handles surfBoardsRepeater.ItemCommand
        Try
            If e.CommandName = "SetBoardPost" Then
                Dim hdnDirectoryName As HiddenField = e.Item.FindControl("hdnDirectoryName")
                LoadAllBoardsRepeater()
                If CheckBoarderStatus() = 1 Then
                    Response.Redirect("UpdateBoarders.aspx?Name=" + hdnDirectoryName.Value, False)
                    ' ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "openRadWindow('" & hdnDirectoryName.Value & "');", True)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "openRadWindow();", True)

                End If
            End If

            If (e.CommandName.ToString() = "ToBoard") Then
                Dim directoryName As String = e.CommandArgument.ToString()
                Response.Redirect("~/" & directoryName, False)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSetOne, False, "Error in Loading Data")
            GlobalModule.ErrorLogFile(ex)
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
            'Dim NewPath As String = Path.Combine(Server.MapPath("thumbs"), fileName)
            Dim NewPath As String = Path.Combine(Server.MapPath("thumbnail"), fileName)
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
            'Return "thumbs/" & fileName
            Return "thumbnail/" & fileName
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
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
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

    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function

End Class