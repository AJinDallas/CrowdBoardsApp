Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Public Class HomeOld
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

       

        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If Not Page.IsPostBack Then
            Try
                btnAdmin.Visible = checkIfAdmin()
                LoadData()
                btnAdmin.Visible = True
            Catch ex As Exception
                messageLabel.Visible = True
                messageLabel.Text = "Error in Loading Data"
                messageLabel.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try
        End If
    End Sub

    Private Function checkIfAdmin() As Boolean
        Try
            Dim roles() As String = System.Web.Security.Roles.GetRolesForUser(HttpContext.Current.User.Identity.Name)
            For Each Item As String In roles
                If Item = "Admin" Then
                    Return True
                End If
            Next
        Catch ex As Exception
            Throw ex
        End Try
        Return False
    End Function

    Private Sub LoadData()
        Try
            Dim dv1 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)
            msgCountLabel.Text = "(" & dv1(0)("MessageCount") & ")"

            Dim dv2 As DataView = CType(sdCrowdBoardsCount.Select(DataSourceSelectArguments.Empty), DataView)
            crowdBoardsCount.Text = "(" & dv2(0)("BoardsCount") & ")"

            Dim dv3 As DataView = CType(sdPendingRequests.Select(DataSourceSelectArguments.Empty), DataView)
            pendingRequestsCount.Text = "(" & dv3(0)("PendingRequestCount") & ")"
            profilePic.ImageUrl = "~/ProfilePics/" & Session("userName").ToString() & ".jpg"

        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub btnCreateBoard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateBoard.Click
        Try
            sdCreateNewBoardDataSource.SelectParameters.Item("UserID").DefaultValue = Session("userName").ToString()
            Dim dv As Data.DataView = CType(sdCreateNewBoardDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Dim boardID As Integer
            boardID = dv(0)("boardID")
            Session("boardID") = boardID
            Response.Redirect("~/BoardDetails.aspx", False)
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Board Creation"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
        Response.Redirect("~/Default.aspx", False)
        Session.Abandon()
    End Sub
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Response.Redirect("~/Search.aspx")
    End Sub
    Protected Sub btnAdmin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdmin.Click
        Response.Redirect("~/Admin/Admin.aspx")
    End Sub
    Protected Sub postRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles postRadButton.Click
        Try
            sdPosts.InsertParameters.Item("Text").DefaultValue = txtPost.Text
            sdPosts.InsertParameters.Item("DatePosted").DefaultValue = System.DateTime.Now
            sdPosts.InsertParameters.Item("UserID").DefaultValue = Session("userName").ToString()
            sdPosts.Insert()
            txtPost.Text = ""
            txtPost.Focus()
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Writing Post"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

End Class