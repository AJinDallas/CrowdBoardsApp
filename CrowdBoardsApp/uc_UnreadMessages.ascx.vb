Public Class uc_UnreadMessages
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If
        lblMessage.Text = ""
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub
    Private Sub LoadData()
        Try
            
            Dim dv4 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)
            
            If Not (dv4 Is Nothing) Then
                If dv4.Count > 0 Then
                    If (Not IsDBNull(dv4(0)("MessageCount"))) Then
                        lblUpdates.Text = "(" & dv4(0)("MessageCount").ToString() & ")"
                    End If

                End If
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
End Class