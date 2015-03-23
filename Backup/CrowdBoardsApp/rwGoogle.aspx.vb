Imports Telerik.Web.UI

Public Class rwGoogle
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If

        If Not (Page.IsPostBack) Then

            If Not (Session("googleContact")) Is Nothing Then
                grIntrestList.DataSource = CType(Session("googleContact"), DataTable)
                grIntrestList.DataBind()
            Else
                GlobalModule.SetMessage(lblMessage, False, "No Data Found")
            End If
        End If
    End Sub


    Protected Sub sendMailButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles sendMailButton.Click
        Try
            Dim isSelected = False
            For Each item As GridDataItem In grIntrestList.SelectedItems
                '"Hi John, your friend Jane has invited you to connect with them on CrowdBoarders"Click here to join.

                Dim emailAddress As String = item("Email").Text
                Dim name As String = item("Name").Text
                If Not (emailAddress = "") Then
                    isSelected = True
                    Dim strSubject As String = "CrowdBoarders Invitation"
                    Dim strBody As String = """Hi " & name & ", your friend " & Session("userName").ToString() & " has invited you to connect with them on CrowdBoarders""<br>"
                    Dim verificationLink As String
                    If Not (Session("queryString")) Is Nothing Then
                        verificationLink = "Click  <a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Board.aspx?Name=" & Session("queryString").ToString() & "'>here</a>  to join"
                    Else
                        verificationLink = "Click  <a href='" & ConfigurationManager.AppSettings("site").ToString() & "/Default.aspx'>here</a>  to join"
                    End If


                    strBody = strBody & verificationLink

                    GlobalModule.SendEmail(emailAddress, strSubject, strBody, True)

                Else
                    GlobalModule.SetMessage(lblMessage, False, "Please select User")
                End If
            Next
            If (isSelected = False) Then
                GlobalModule.SetMessage(lblMessage, False, "Please select User")
            Else

                GlobalModule.SetMessage(lblMessage, True, "Request sent Successfully")

                RadAjaxManager1.ResponseScripts.Add(" Ok();")
                ' Response.Redirect("CrowdBoardManaement.aspx?Name=" & Session("queryString").ToString(), False) ' Session("queryString")

            End If

        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class