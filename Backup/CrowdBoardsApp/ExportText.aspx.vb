Imports Telerik

Public Class ExportText
    Inherits Telerik.Web.UI.RadAjaxPage


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GlobalModule.RedirectToHttps()
        'provide the user the ability to save a text file to the local system.  It can be used by any program
        'to export any text file that has been saved on the server.
        Try
            Dim objFileInfo As System.IO.FileInfo
            Response.Clear()

            If Not System.IO.File.Exists(Session("ExportPOPath")) Then Exit Sub
            objFileInfo = New System.IO.FileInfo(Session("ExportPOPath"))

            'Add Headers to enable dialog display
            Response.AddHeader("Content-Disposition", "attachment; filename=" & _
             Session("fileName").ToString())
            Response.AddHeader("Content-Length", objFileInfo.Length.ToString())
            Response.ContentType = "application/octet-stream"
            Response.WriteFile(objFileInfo.FullName)

            'take this out if you want a record of exported files...
            'objFileInfo.Delete()
        Catch ex As Exception
            'if there is a file permissions problem an exception can be thrown
            'just silence it here
        End Try

    End Sub

End Class