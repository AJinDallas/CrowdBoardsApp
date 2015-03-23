Public Class InsiderDetails

    Inherits Telerik.Web.UI.RadAjaxPage
    Dim GM As New GlobalModule
    Public Property boardID() As Integer

        Get
            Return CInt(ViewState("_boardID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_boardID") = value
        End Set
    End Property
    Public Property levelID() As Integer

        Get
            Return CInt(ViewState("_levelID"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_levelID") = value
        End Set
    End Property
    Public Property levelNumber() As Integer

        Get
            Return CInt(ViewState("_levelNumber"))
        End Get

        Set(ByVal value As Integer)
            ViewState("_levelNumber") = value
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
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageRating.Visible = False
        lblmessage.Visible = False
        lblMessageBoarderNotes.Visible = False
        lblMessageShippingInfo.Visible = False
        If (Not Page.IsPostBack) Then
            If Request.QueryString.Count > 0 Then
                If Request.QueryString("Name") IsNot Nothing Then
                    Try
                        Me.boardID = getBoardId()
                        Me.DirectoryName = Request.QueryString("Name")
                        'lblCrowdboardName.Text = Me.DirectoryName
                        LoadBoardDescriptionInfo()
                        LoadInvestmentDetails()
                        LoadInvestmentLevelDetails()
                        LoadShippingInformation()

                    Catch ex As Exception
                        GlobalModule.SetMessage(lblmessage, False, "Error in Loading Data")
                        GlobalModule.ErrorLogFile(ex)
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
                If (Not IsDBNull(dv(0)("Watches"))) Then
                    lblWatchesBoard.Text = dv(0)("Watches")
                End If
                If (Not IsDBNull(dv(0)("Comments"))) Then
                    lblCommentsBoard.Text = dv(0)("Comments")
                End If
                If (Not IsDBNull(dv(0)("Location"))) Then
                    lblLocation.Text = dv(0)("Location")
                End If
                If (Not IsDBNull(dv(0)("District"))) Then
                    lblDistrict.Text = dv(0)("District")
                End If
                If (Not IsDBNull(dv(0)("AreaName"))) Then
                    lblArea.Text = dv(0)("AreaName")
                End If
                If (Not IsDBNull(dv(0)("TotalOffer"))) Then
                    lblSeeking.Text = GM.GetAmountAccordingToLocation(dv(0)("TotalOffer").ToString(), dv(0)("BankLocation").ToString())
                End If
                'If (Not IsDBNull(dv(0)("invType"))) Then
                '    lblInvType.Text = dv(0)("invType")
                'End If
                If (Not IsDBNull(dv(0)("DateActivated"))) Then
                    lblLiveSince.Text = dv(0)("DateActivated")
                End If
                If (Not IsDBNull(dv(0)("BoardLevel"))) Then
                    lblBoardLevel.Text = IIf(dv(0)("BoardLevel") = "Not Calculated", "1", dv(0)("BoardLevel"))
                End If

                If (Not IsDBNull(dv(0)("AmountRemaining"))) Then
                    lblAmountLeft.Text = GM.GetAmountAccordingToLocation(dv(0)("AmountRemaining").ToString(), dv(0)("BankLocation").ToString())
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    lblDescription.Text = dv(0)("Description")
                End If
                If (Not IsDBNull(dv(0)("TotalOffer"))) Then
                    ThermometerSlider.MaximumValue = Convert.ToInt64(dv(0)("TotalOffer"))
                Else
                    ThermometerSlider.MaximumValue = 5000
                End If
                If (Not IsDBNull(dv(0)("RaisedTotal"))) Then
                    ThermometerSlider.Value = Convert.ToInt64(dv(0)("RaisedTotal"))
                Else
                    ThermometerSlider.Value = 0
                End If
                If (Not IsDBNull(dv(0)("BoardName"))) Then
                    boardNameLink.Text = dv(0)("BoardName")
                    boardNameLink.NavigateUrl = "~/Board.aspx?Name=" & Me.DirectoryName
                    viewbutton.PostBackUrl = "~/Board.aspx?Name=" & Me.DirectoryName
                    lblCrowdBoard.Text = dv(0)("BoardName").ToString()
                End If
                If (Not IsDBNull(dv(0)("RaisedTotalText"))) Then
                    lblCrowdBoardRaised.Text = dv(0)("RaisedTotalText")
                End If
                If (Not IsDBNull(dv(0)("AmountRemaining"))) Then
                    If (dv(0)("AmountRemaining") = 0) Then
                        lblCrowdBoardFullyFunded.Text = "Yes"
                    Else
                        lblCrowdBoardFullyFunded.Text = "No"
                    End If
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    lblDescription.Text = dv(0)("Description")
                End If
                Dim pathBoardPic As String = GM.GetImageURL(Me.DirectoryName & ".jpg", 150, 150, "thumbnail", "thumbs")
                imgBoard.Src = pathBoardPic

                If Not isAvail("~/Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                    Dim pathCoverPic As String = "Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg"
                    covPicLineup.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
                Else
                    covPicLineup.Attributes.Add("style", "background-image:url(WebContent/Theme/images/crowdboardvideopreview.png);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
                    'coverPicDiv.Attributes.Add("style", "background-color:#626262;min-height: 100px; width: 100%;")
                End If

            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Protected Sub LoadInvestmentDetails()
        Try
            sdBoardComments.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdInvestmentDetails.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            Dim dv As Data.DataView = CType(sdInvestmentDetails.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("AmountInvestedText"))) Then
                    lblAmountInvested.Text = dv(0)("AmountInvestedText")
                End If
                If (Not IsDBNull(dv(0)("AmountInvestedText"))) Then
                    lblPurchasedFor.Text = dv(0)("AmountInvestedText")
                End If
                If (Not IsDBNull(dv(0)("DateInvested"))) Then
                    lblDatePurchased.Text = Convert.ToDateTime(dv(0)("DateInvested")).ToString("MM/dd/yyyy")
                End If
                If (Not IsDBNull(dv(0)("Rating"))) Then
                    lblInvestmentRating.Text = dv(0)("Rating")
                End If
                If (Not IsDBNull(dv(0)("BoarderNotes"))) Then
                    txtBoarderNotes.Text = dv(0)("BoarderNotes")
                End If
                If (Not IsDBNull(dv(0)("LevelID"))) Then
                    Me.levelID = dv(0)("LevelID")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadShippingInformation()
        Try
            sdShippingInformation.SelectParameters.Item("Userid").DefaultValue = Session("userID")
            Dim dv As Data.DataView = CType(sdShippingInformation.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("Address"))) Then
                    txtStreetAddress.Text = dv(0)("Address")
                End If
                If (Not IsDBNull(dv(0)("City"))) Then
                    txtCity.Text = dv(0)("City")
                End If
                If (Not IsDBNull(dv(0)("Zip"))) Then
                    txtZipOrPostCode.Text = dv(0)("Zip")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadInvestmentLevelDetails()
        Try
            sdInvstmentLevelDetail.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdInvstmentLevelDetail.SelectParameters.Item("LevelID").DefaultValue = Me.levelID
            Dim dv As Data.DataView = CType(sdInvstmentLevelDetail.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("LevelNumber"))) Then
                    lblLevelBought.Text = dv(0)("LevelNumber")
                    Me.levelNumber = dv(0)("LevelNumber")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub LoadBoardLevels()
        Try
            sdBoardLevels.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardLevels.SelectParameters.Item("LevelNumber").DefaultValue = Me.levelNumber
            Dim dv As Data.DataView = CType(sdBoardLevels.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 1) Then
                rcbBoardLevels.DataSource = dv
                rcbBoardLevels.DataBind()
                lbtnChangeLevelBought.Visible = False
                boardLevelDiv.Visible = True
            Else
                GlobalModule.SetMessage(lblmessage, False, "You have already Invested in Highest Level")
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Protected Function ChangeInvestment() As Integer
        Dim result As Integer = 0
        Try
            sdUpdateInvestment.UpdateParameters.Item("AmountInvested").DefaultValue = GetNewInvestmentAmount()
            sdUpdateInvestment.UpdateParameters.Item("NewLevelID").DefaultValue = rcbBoardLevels.SelectedValue
            sdUpdateInvestment.UpdateParameters.Item("UserID").DefaultValue = Session("userID")
            sdUpdateInvestment.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdUpdateInvestment.UpdateParameters.Item("OldLevelID").DefaultValue = Me.levelID
            result = sdUpdateInvestment.Update()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Function GetNewInvestmentAmount() As Integer
        Dim levelAmount As Integer = 0
        Try
            sdUpdateInvestment.SelectParameters.Item("NewLevelID").DefaultValue = rcbBoardLevels.SelectedValue
            Dim dv As Data.DataView = CType(sdUpdateInvestment.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("LevelAmount"))) Then
                    levelAmount = dv(0)("LevelAmount")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return levelAmount
    End Function
    Protected Sub lbtnChangeLevelBought_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnChangeLevelBought.Click
        Try
            LoadBoardLevels()
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtInsiderNews_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtInsiderNews.Click
        Try
            Response.Redirect("~/InsiderNews.aspx?Name=" & Me.DirectoryName, False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtInsiderDetails_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtInsiderDetails.Click
        Try
            Response.Redirect("~/InsiderDetails.aspx?Name=" & Me.DirectoryName, False)
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub



    Protected Sub btnInvest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInvest.Click
        Try
            If (ChangeInvestment() = 1) Then
                lbtnChangeLevelBought.Visible = True
                boardLevelDiv.Visible = False
                LoadBoardDescriptionInfo()
                LoadInvestmentDetails()
                LoadInvestmentLevelDetails()
                GlobalModule.SetMessage(lblmessage, True, "Investment Level Changed Successfully")
            Else
                GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Try
            lbtnChangeLevelBought.Visible = True
            boardLevelDiv.Visible = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblmessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnChangerating_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnChangerating.Click
        Try
            lbtnSaveRating.Visible = True
            lbtnChangerating.Visible = False
            lblInvestmentRating.Visible = False
            txtRating.Visible = True
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageRating, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnSaveRating_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSaveRating.Click
        Try
            If Not (Page.IsValid) Then
                Exit Sub
            End If
            If (SaveRating() = 1) Then
                lbtnSaveRating.Visible = False
                lbtnChangerating.Visible = True
                lblInvestmentRating.Visible = True
                txtRating.Text = ""
                txtRating.Visible = False
                LoadInvestmentDetails()
            Else
                GlobalModule.SetMessage(lblMessageRating, False, "Error in Request")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageRating, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnChangeBoarderNotes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnChangeBoarderNotes.Click
        Try
            lbtnChangeBoarderNotes.Enabled = False
            lbtnSaveBoarderNotes.Enabled = True
            txtBoarderNotes.ReadOnly = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageBoarderNotes, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnSaveBoarderNotes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSaveBoarderNotes.Click
        Try
            If Not (Page.IsValid) Then
                Exit Sub
            End If
            If (SaveBoarderNotes() = 1) Then
                lbtnSaveBoarderNotes.Enabled = False
                lbtnChangeBoarderNotes.Enabled = True
                txtBoarderNotes.ReadOnly = True
                GlobalModule.SetMessage(lblMessageBoarderNotes, True, "Notes Saved Successfully")
                LoadInvestmentDetails()
            Else
                GlobalModule.SetMessage(lblMessageBoarderNotes, False, "Error in Request")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageBoarderNotes, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Function SaveRating() As Integer
        Dim result As Integer = 0
        Try
            sdRating.UpdateParameters.Item("Userid").DefaultValue = Session("userID")
            sdRating.UpdateParameters.Item("Rating").DefaultValue = txtRating.Text
            sdRating.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdRating.UpdateParameters.Item("LevelID").DefaultValue = Me.levelID
            result = sdRating.Update()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Function SaveBoarderNotes() As Integer
        Dim result As Integer = 0
        Try
            sdBoarderNotes.UpdateParameters.Item("Userid").DefaultValue = Session("userID")
            sdBoarderNotes.UpdateParameters.Item("BoarderNotes").DefaultValue = txtBoarderNotes.Text
            sdBoarderNotes.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoarderNotes.UpdateParameters.Item("LevelID").DefaultValue = Me.levelID
            result = sdBoarderNotes.Update()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Sub lbtnChangeShippingInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnChangeShippingInfo.Click
        Try
            lbtnChangeShippingInfo.Enabled = False
            lbtnSaveShippingInfo.Enabled = True
            txtStreetAddress.ReadOnly = False
            txtCity.ReadOnly = False
            txtZipOrPostCode.ReadOnly = False
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageShippingInfo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub lbtnSaveShippingInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSaveShippingInfo.Click
        Try
            If Not (Page.IsValid) Then
                Exit Sub
            End If
            If (SaveShippingInformation() = 1) Then
                lbtnChangeShippingInfo.Enabled = True
                lbtnSaveShippingInfo.Enabled = False
                txtStreetAddress.ReadOnly = True
                txtCity.ReadOnly = True
                txtZipOrPostCode.ReadOnly = True
                GlobalModule.SetMessage(lblMessageShippingInfo, True, "Shipping Information Saved Successfully")
                LoadShippingInformation()
            Else
                GlobalModule.SetMessage(lblMessageShippingInfo, False, "Error in Request")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageShippingInfo, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Function SaveShippingInformation() As Integer
        Dim result As Integer = 0
        Try
            sdShippingInformation.UpdateParameters.Item("Userid").DefaultValue = Session("userID")
            sdShippingInformation.UpdateParameters.Item("Address").DefaultValue = txtStreetAddress.Text
            sdShippingInformation.UpdateParameters.Item("City").DefaultValue = txtCity.Text
            sdShippingInformation.UpdateParameters.Item("zip").DefaultValue = txtZipOrPostCode.Text
            result = sdShippingInformation.Update()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
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
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
End Class