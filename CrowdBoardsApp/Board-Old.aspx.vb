Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Partial Class BoardOld
    Inherits RadAjaxPage
    Public url As String = ""
    Public Property BoardID() As Int32

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property ownerUserID() As String

        Get
            Return CStr(ViewState("_ownerUserID"))
        End Get

        Set(ByVal value As String)
            ViewState("_ownerUserID") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If (Not Page.IsPostBack) Then
                LoadBoardDescriptionInfo()
            End If
            messageLabel.Visible = False
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Data Load"
            GlobalModule.ErrorLogFile(ex)
        End Try

    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
                If (dv.Count > 0) Then
                    If (Not IsDBNull(dv(0)("BoardID"))) Then
                        Me.BoardID = dv(0)("BoardID")
                    End If

                    If (Not IsDBNull(dv(0)("BoardName"))) Then
                        txtBoardName.Text = dv(0)("BoardName")
                    End If

                    If (Not IsDBNull(dv(0)("Description"))) Then
                        txtDescription.Text = dv(0)("Description")
                    End If

                    If (Not IsDBNull(dv(0)("URL"))) Then
                        ifUrl.Attributes.Add("src", dv(0)("URL").ToString())
                    End If
                    If (Not IsDBNull(dv(0)("DateActivated"))) Then
                        rdtdDateActivated.Text = dv(0)("DateActivated")
                    End If
                    If (Not IsDBNull(dv(0)("BoardStatus"))) Then
                        txtStatus.Text = dv(0)("BoardStatus")
                    End If
                    If (Not IsDBNull(dv(0)("InvestmentTypeName"))) Then
                        txtInvType.Text = dv(0)("InvestmentTypeName")
                    End If
                    If (Not IsDBNull(dv(0)("InvestmentTypeDescription"))) Then
                        txtInvType.ToolTip = dv(0)("InvestmentTypeDescription")
                    End If
                    If (Not IsDBNull(dv(0)("UserID"))) Then
                        Dim fileName As String = dv(0)("UserID") & ".jpg"
                        Dim iPath As String = Path.Combine(Server.MapPath("ProfilePics"), fileName)
                        If Not System.IO.File.Exists(iPath) Then
                            fileName = "noimage.jpg"
                            imgOwnedBy.Src = "~/thumbnail/" + fileName
                        Else
                            imgOwnedBy.Src = "~/ProfilePics/" + fileName
                        End If
                        Me.ownerUserID = dv(0)("UserID").ToString()
                    End If
                    If (Not IsDBNull(dv(0)("AreaName"))) Then
                        txtArea.Text = dv(0)("AreaName")
                    End If
                    If (Not IsDBNull(dv(0)("AudienceDesc"))) Then
                        txtAudience.Text = dv(0)("AudienceDesc")
                    End If
                    If (Not IsDBNull(dv(0)("UniquenessDesc"))) Then
                        txtUniqueness.Text = dv(0)("UniquenessDesc")
                    End If
                    If (Not IsDBNull(dv(0)("RevenueDesc"))) Then
                        txtRevenueGeneration.Text = dv(0)("RevenueDesc")
                    End If
                End If
            End If
            sdBoardComments.SelectParameters.Item("BoardID").DefaultValue = Me.BoardID
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Response.Redirect("~/Search.aspx")
    End Sub
    Protected Sub btnOwnedBy_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOwnedBy.Click

        Dim str As String = Me.ownerUserID
        If Not Session("userName") Is Nothing Then
            If str = Session("userName").ToString() Then
                Response.Redirect("~/Profile.aspx")
            Else
                Response.Redirect("~/Profile.aspx?User=" + Me.ownerUserID)
            End If
        Else
            Response.Redirect("~/Account/Login.aspx")
        End If
    End Sub
    Protected Sub btnInvest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInvest.Click
        Response.Redirect("~/Invest.aspx?Name=" + Request.QueryString("Name"))
    End Sub
    Protected Sub btnWatch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWatch.Click

        If (Session("userName")) IsNot Nothing Then
            Try
                sdWatchers.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                sdWatchers.InsertParameters.Item("WatchingBy").DefaultValue = Session("userName").ToString()
                sdWatchers.InsertParameters.Item("WatchDate").DefaultValue = System.DateTime.Now
                sdWatchers.Insert()
            Catch ex As Exception
                messageLabel.Visible = True
                messageLabel.Text = "Error in Request"
                GlobalModule.ErrorLogFile(ex)
            End Try
        Else
            Response.Redirect("~/Account/Login.aspx")
        End If
    End Sub
    Protected Sub rgBoardComments_InsertCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rgBoardComments.InsertCommand

        If Not Session("userName") Is Nothing Then
            If (Not String.IsNullOrEmpty(Request.QueryString("Name"))) Then
                Try
                    Dim insertedItem As GridEditFormInsertItem = DirectCast(e.Item, GridEditFormInsertItem)
                    Dim editMan As GridEditManager = insertedItem.EditManager
                    Dim addCommentRadTextBox As RadTextBox = DirectCast(insertedItem.FindControl("addCommentRadTextBox"), RadTextBox)
                    sdBoardComments.InsertParameters.Item("Text").DefaultValue = addCommentRadTextBox.Text
                    sdBoardComments.InsertParameters.Item("CommentDate").DefaultValue = System.DateTime.Now
                    sdBoardComments.InsertParameters.Item("UserID").DefaultValue = Session("userName").ToString()
                    sdBoardComments.InsertParameters.Item("BoardID").DefaultValue = Me.BoardID
                    sdBoardComments.Insert()
                Catch ex As Exception
                    messageLabel.Visible = True
                    messageLabel.Text = "Error in  Comment Post"
                    GlobalModule.ErrorLogFile(ex)
                End Try
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Else
            Response.Redirect("~/Default.aspx", False)
        End If
    End Sub
End Class
