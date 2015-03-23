Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Web.HttpContext
Public Class PaypalSuccess
    Inherits Telerik.Web.UI.RadAjaxPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If
        If Request.Form("custom") IsNot Nothing Then
            Dim strCustom As String = Request.Form("custom").ToString()
            Dim list As New ArrayList()
            list.AddRange(strCustom.Split(New Char() {","c}))
            If (list.Count > 0) Then
                Dim userID As String = list(0).ToString()
                Dim boardID As String = list(1).ToString()
                Dim levelID As String = list(2).ToString()
                Dim levelAmount As String = list(3).ToString()
                Dim boardName As String = list(4).ToString()
                Dim levelName As String = list(5).ToString()
                AddInvestment(userID, boardID, levelID, levelAmount, boardName, levelName)
            End If
        End If
    End Sub
    Protected Sub AddInvestment(ByVal userId As String, ByVal boardID As String, ByVal levelID As String, ByVal levelAmount As String, ByVal boardName As String, ByVal levelName As String)

        Try
            sdConfirmedInvestorsDataSource.SelectParameters.Item("BoardID").DefaultValue = boardID
            sdConfirmedInvestorsDataSource.SelectParameters.Item("UserID").DefaultValue = userId
            sdConfirmedInvestorsDataSource.SelectParameters.Item("AmountInvested").DefaultValue = levelAmount
            sdConfirmedInvestorsDataSource.SelectParameters.Item("LevelID").DefaultValue = levelID
            Dim dv1 As Data.DataView = CType(sdConfirmedInvestorsDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv1.Count > 0 Then
                Response.Redirect("~/confirm.aspx?Name=" & boardName & "&LevelName=" & levelName & "&Invested=1", False)
            End If
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
End Class