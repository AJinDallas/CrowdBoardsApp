Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports System.Collections.Generic
Imports Telerik.Web.UI
Imports System.Drawing

Public Class scrollPage
    Inherits System.Web.UI.Page
    Public Property sqlCommand() As String
        Get
            Return CStr(ViewState("_sqlCommand"))
        End Get
        Set(ByVal value As String)
            ViewState("_sqlCommand") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadRequestedCandidates()
        End If
    End Sub

    Public Shared Function GetCustomersData(ByVal pageIndex As Integer) As DataSet
        Dim query As String = "[GetCustomersPageWise]"
        Dim cmd As SqlCommand = New SqlCommand(query)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex)
        cmd.Parameters.AddWithValue("@PageSize", 10)
        cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output
        Return GetData(cmd)
    End Function

    Private Shared Function GetData(ByVal cmd As SqlCommand) As DataSet
        Dim strConnString As String = ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(strConnString)
        Dim sda As SqlDataAdapter = New SqlDataAdapter
        cmd.Connection = con
        sda.SelectCommand = cmd
        Dim ds As DataSet = New DataSet
        sda.Fill(ds, "Customers")
        Dim dt As DataTable = New DataTable("PageCount")
        dt.Columns.Add("PageCount")
        dt.Rows.Add()
        dt.Rows(0)(0) = cmd.Parameters("@PageCount").Value
        ds.Tables.Add(dt)
        Return ds
    End Function
    <WebMethod()> _
    Public Shared Function GetCustomers(ByVal pageIndex As Integer) As String
        Return GetCustomersData(pageIndex).GetXml
    End Function
    Protected Sub LoadRequestedCandidates()
        'Try
        '    sddatasource.SelectParameters.Item("BoardID").DefaultValue = 100035
        '    sddatasource.SelectCommand = "SELECT * From(Select top 100 percent  B.BoardID,B.BoardName,B.DirectoryName,BC.Text,BC.userID As userID,(SELECT UserName From Users where UserID=BC.UserID) AS UserName,'c' as ResultType,BC.CommentDate as ActivityDate from Boards B INNER JOIN BoardComments BC ON B.BoardId=BC.BoardID WHERE B.BoardID=@BoardID ORDER BY BC.CommentDate desc)Main"
        '    Me.sqlCommand = sddatasource.SelectCommand
        '    grInterviws.DataSourceID = sddatasource.ID
        '    grInterviws.DataBind()

        'Catch ex As Exception
        '    Throw ex
        'End Try
    End Sub
    'Protected Sub RadAjaxManager1_AjaxRequest(ByVal sender As Object, ByVal e As AjaxRequestEventArgs) Handles RadAjaxManager1.AjaxRequest
    'grInterviws.PageSize += 10
    'sddatasource.SelectCommand = Me.sqlCommand
    'grInterviws.DataSourceID = sddatasource.ID
    'grInterviws.Rebind()

    ' End Sub
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    Protected Sub RadAjaxManager1_AjaxSettingCreated(ByVal sender As Object, ByVal e As AjaxSettingCreatedEventArgs)

    End Sub

End Class