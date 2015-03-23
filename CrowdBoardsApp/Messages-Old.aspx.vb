Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Public Class MessagesOld
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        If Not Page.IsPostBack Then
            Try
                LoadRootNodes()
                LoadData()
            Catch ex As Exception
                messageLabel.Visible = True
                messageLabel.Text = "Error in Loading Data"
                messageLabel.ForeColor = Drawing.Color.Red
                GlobalModule.ErrorLogFile(ex)
            End Try

        End If
    End Sub
    Private Sub LoadRootNodes()
        Try
            Dim dv As DataView = CType(userNameDataSource.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dr As DataRow
            If (dv.Count > 0) Then
                For Each dr In dv.Table.Rows
                    sdMessageCount.SelectParameters.Item("countUserIDNode").DefaultValue = Convert.ToInt32(dr("userID"))
                    Dim dv1 As DataView = CType(sdMessageCount.Select(DataSourceSelectArguments.Empty), DataView)
                    Dim dr1 As DataRow
                    If (dv1.Count > 0) Then
                        For Each dr1 In dv1.Table.Rows
                            Dim node As New RadTreeNode
                            node.Text = dr("Users") & " " & "(" & dr1("MessageCount") & ")"
                            node.Value = dr("userID")
                            RadTreeView1.Nodes.Add(node)
                        Next
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub RadTreeView1_NodeClick(ByVal sender As Object, ByVal e As Telerik.Web.UI.RadTreeNodeEventArgs) Handles RadTreeView1.NodeClick
        LoadData()
    End Sub
    Private Sub LoadData()
        Try
            If (RadTreeView1.Nodes.Count > 0) Then
                If (RadTreeView1.SelectedNodes.Count > 0) Then
                    If (RadTreeView1.SelectedNode.Level = 0) Then
                        sdUserName.SelectParameters("nodeUserName").DefaultValue = RadTreeView1.SelectedNode.Value
                        Dim dvUserName As DataView = CType(sdUserName.Select(DataSourceSelectArguments.Empty), DataView)
                        If (dvUserName.Count > 0) Then
                            sdMessages.SelectParameters.Item("userIDNode").DefaultValue = dvUserName(0)("UserName")
                            Dim dv As DataView = CType(sdMessages.Select(DataSourceSelectArguments.Empty), DataView)
                            If (dv.Count > 0) Then
                                rgMessages.Visible = True
                                rgMessages.DataSource = dv
                                rgMessages.DataBind()
                                replyDiv.Visible = True
                                Session("ParentUserSelectNode") = RadTreeView1.SelectedNode
                            Else
                                rgMessages.Visible = False
                                replyDiv.Visible = True
                            End If
                            sdMessages.UpdateParameters.Item("userIDNode").DefaultValue = Convert.ToInt32(RadTreeView1.SelectedNode.Value)
                            sdMessages.UpdateParameters.Item("userID").DefaultValue = Session("UserID").ToString()
                            sdMessages.Update()
                        End If
                    End If
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub replyRadButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles replyRadButton.Click
        Try
            sdMessages.InsertParameters.Item("FromUser").DefaultValue = Convert.ToInt32(Session("UserID"))
            sdMessages.InsertParameters.Item("ToUser").DefaultValue = Convert.ToInt32(RadTreeView1.SelectedNode.Value)
            sdMessages.InsertParameters.Item("DateSent").DefaultValue = System.DateTime.Now
            sdMessages.InsertParameters.Item("Text").DefaultValue = replyMessageRadTexBox.Text
            sdMessages.InsertParameters.Item("Unread").DefaultValue = True
            sdMessages.Insert()
            LoadData()
            replyMessageRadTexBox.Text = " "
            replyMessageRadTexBox.Focus()
        Catch ex As Exception
            messageLabel.Visible = True
            messageLabel.Text = "Error in Sending Message"
            messageLabel.ForeColor = Drawing.Color.Red
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class