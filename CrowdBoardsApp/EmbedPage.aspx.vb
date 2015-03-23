Public Class EmbedPage
    Inherits System.Web.UI.Page
    Public Property boardID() As Integer

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property DirectoryName() As String

        Get
            Return CStr(ViewState("_directoryName"))
        End Get

        Set(ByVal value As String)
            ViewState("_directoryName") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If (Not Page.IsPostBack) Then
            If Request.QueryString.Count > 0 Then
                If Request.QueryString("Name") IsNot Nothing Then
                    Try
                        Me.boardID = getBoardId()
                        Me.DirectoryName = Request.QueryString("Name")
                        LoadBoardDescriptionInfo()
                    Catch ex As Exception
                        Throw ex
                    End Try

                End If
            End If
        End If
    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try

            sdBoard.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
               
                If (Not IsDBNull(dv(0)("Investors"))) Then
                    lblBoardersInBoard.Text = dv(0)("Investors")
                End If
               
                If (Not IsDBNull(dv(0)("Amountleft"))) Then
                    lblAmountLeft.Text = dv(0)("Amountleft")

                End If
                If (Not IsDBNull(dv(0)("BoardLevel"))) Then
                    lblBoardLevel.Text = IIf(dv(0)("BoardLevel") = "Not Calculated", "1", dv(0)("BoardLevel"))
                End If
               
                If (Not IsDBNull(dv(0)("seekingAmount"))) Then
                    ThermometerSlider.MaximumValue = Convert.ToInt64(dv(0)("seekingAmount"))
                Else
                    ThermometerSlider.MaximumValue = 5000
                End If

                If (Not IsDBNull(dv(0)("RaisedTotal"))) Then
                    ThermometerSlider.Value = Convert.ToInt64(dv(0)("RaisedTotal"))
                Else
                    ThermometerSlider.Value = 0
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Private Function getBoardId() As Integer
        Dim Id As Integer = 0
        Try
            sdGetBoardIdDataSource.SelectParameters.Item("Name").DefaultValue = Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                Id = dv(0)("BoardID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return Id
    End Function

End Class