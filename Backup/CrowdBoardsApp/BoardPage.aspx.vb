Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Partial Class BoardPage
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        Try
            If Not Page.IsPostBack Then

                If Request.QueryString("Name") IsNot Nothing Then
                    Dim filePath As String
                    filePath = CreateDirectory()
                    reCreatePage.Content = ReadFile(filePath + "\Index.html")
                Else
                    Response.Redirect("~/Home.aspx", False)
                    Exit Sub
                End If
            End If
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Error in Loading Data"
            lblMessage.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("~/CreateCrowdboard.aspx?Name=" + Request.QueryString("Name"), False)
    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            Dim filePath As String
            filePath = CreateDirectory()
            Using externalFile As New StreamWriter(filePath + "\Index.html", False)
                externalFile.Write(reCreatePage.Content)
                externalFile.Flush()
                externalFile.Close()
            End Using
            Dim directoryName As String = Request.QueryString("Name")
            sdUpdateUrlDataSource.UpdateParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            sdUpdateUrlDataSource.UpdateParameters.Item("URL").DefaultValue = directoryName & "/" & "Index.html"
            sdUpdateUrlDataSource.Update()
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
    Function CreateDirectory() As String
        Dim mainDirectoryPath As String
        mainDirectoryPath = ""
        Dim filePath As String
        filePath = ""
        Try
            mainDirectoryPath = "~/Upload/BoardDirectory/" & Request.QueryString("Name")
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
End Class
