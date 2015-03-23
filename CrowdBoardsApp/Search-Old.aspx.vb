Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Imports System.Drawing
Partial Class SearchOld
    Inherits RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            If (Request.QueryString.Count > 0) Then
                If (Request.QueryString("Logout").ToString() = "yes") Then
                    FormsAuthentication.SignOut()
                    Session.Abandon()
                End If
            End If
            Session("BoardName") = "%"
        End If

    End Sub

    Protected Sub searchBoardButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles searchBoardButton.Click
        Session("BoardName") = searchBoardTextBox.Text
    End Sub


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
    Private Function Abort() As Boolean
        Return False
    End Function

End Class
