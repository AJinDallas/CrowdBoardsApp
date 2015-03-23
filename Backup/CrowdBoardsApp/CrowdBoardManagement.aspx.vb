Imports System.Drawing
Imports System.IO
Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System.Threading
Imports ASPSnippets.FaceBookAPI
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Net
Imports OAuth.Net.Common
Imports OAuth.Net.Components
Imports OAuth.Net.Consumer
Imports OAuth
Imports OAuthYahoo
Imports System.Text
Imports System.Xml
Imports System.Collections
Imports System.Collections.Generic
Imports System.Net.Mail
Imports System.Text.RegularExpressions
Imports LinkedInLibrary
Imports System.Linq
Imports Google.Contacts
Imports Google.GData.Contacts
Imports Google.GData.Client
Imports Google.GData.Extensions


Public Class CrowdBoardManagement
    Inherits System.Web.UI.Page
    Public appID As String = String.Empty
    Dim accessToken As String = ""
    Dim accessTokenSecret As String = ""
    Dim gettoken As String = Nothing
    Dim getotokensecret As String = Nothing
    Dim getverifier As String = Nothing
    Public linkedinkey As String = String.Empty
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
    Public Property youtubeVideoUrl() As String

        Get
            Return CStr(ViewState("_youtubeVideoUrl"))
        End Get

        Set(ByVal value As String)
            ViewState("_youtubeVideoUrl") = value
        End Set
    End Property



    Public ReadOnly Property ConsumerKey() As String
        Get
            Return System.Configuration.ConfigurationManager.AppSettings("yahooConsumerKeyInviteFromManage").ToString()
        End Get
    End Property
    Public ReadOnly Property ConsumerSecret() As String
        Get
            Return System.Configuration.ConfigurationManager.AppSettings("yahooConsumerSecretInviteFromManage").ToString()
        End Get
    End Property

    Public Property OauthVerifier() As String
        Get
            Try
                If Not String.IsNullOrEmpty(Session("Oauth_Verifier").ToString()) Then
                    Return Session("Oauth_Verifier").ToString()
                Else
                    Return String.Empty
                End If
            Catch
                Return String.Empty
            End Try
        End Get
        Set(ByVal value As String)
            Session("Oauth_Verifier") = value
        End Set
    End Property
    Public Property OauthToken() As String
        Get
            If Not String.IsNullOrEmpty(Session("Oauth_Token").ToString()) Then
                Return Session("Oauth_Token").ToString()
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Session("Oauth_Token") = value
        End Set
    End Property
    Public Property OauthTokenSecret() As String
        Get
            If Not String.IsNullOrEmpty(Session("Oauth_Token_Secret").ToString()) Then
                Return Session("Oauth_Token_Secret").ToString()
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Session("Oauth_Token_Secret") = value
        End Set
    End Property
    Public Property OauthSessionHandle() As String
        Get
            If Not String.IsNullOrEmpty(Session("Oauth_Session_Handle").ToString()) Then
                Return Session("Oauth_Session_Handle").ToString()
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            Session("Oauth_Session_Handle") = value
        End Set
    End Property
    Public Property OauthYahooGuid() As String
        Get
            Try
                If Not String.IsNullOrEmpty(Session("Oauth_Yahoo_Guid").ToString()) Then
                    Return Session("Oauth_Yahoo_Guid").ToString()
                Else
                    Return String.Empty
                End If
            Catch
                Return String.Empty
            End Try
        End Get
        Set(ByVal value As String)
            Session("Oauth_Yahoo_Guid") = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessage.Visible = False
        lblMessageSendEmail.Visible = False
        lblMessageEmbed.Visible = False
        Dim oauth_token As String = Request.QueryString("oauth_token")
        Dim oauth_verifier As String = Request.QueryString("oauth_verifier")
        If oauth_token IsNot Nothing AndAlso oauth_verifier IsNot Nothing Then
            Application("oauth_token") = oauth_token
            Application("oauth_verifier") = oauth_verifier
        End If
        If (Not Page.IsPostBack) Then

            userNameLable.Value = Session("userName").ToString()

            If Request.QueryString.Count > 0 Then
                If Request.QueryString("Name") IsNot Nothing Then
                    Me.boardID = getBoardId(Request.QueryString("Name"))
                    Me.DirectoryName = Request.QueryString("Name")
                    lblCrowdboardName.Text = Me.DirectoryName
                    LoadBoardDescriptionInfo()
                    LoadCharts()
                    performanceLinkButton.Attributes.Add("style", "text-decoration: underline;")
                Else
                    If Not (Session("queryString")) Is Nothing Then
                        Me.boardID = getBoardId(Session("queryString").ToString())
                        Me.DirectoryName = Session("queryString").ToString()
                        lblCrowdboardName.Text = Me.DirectoryName
                        LoadBoardDescriptionInfo()
                        LoadCharts()
                        performanceLinkButton.Attributes.Add("style", "text-decoration: underline;")
                    End If
                End If
            Else
                If Not (Session("queryString")) Is Nothing Then
                    Me.boardID = getBoardId(Session("queryString").ToString())
                    Me.DirectoryName = Session("queryString").ToString()
                    lblCrowdboardName.Text = Me.DirectoryName
                    LoadBoardDescriptionInfo()
                    LoadCharts()
                    performanceLinkButton.Attributes.Add("style", "text-decoration: underline;")
                End If
            End If
        End If

        RadWindow1.VisibleOnPageLoad = False
        appID = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        linkedinkey = "" & System.Configuration.ConfigurationManager.AppSettings("linkedinKeyManage")

        If Not IsPostBack Then
            oauth_token = Request("oauth_token")
            oauth_verifier = Request("oauth_verifier")
            If Not Session("isYahooInvite") Is Nothing Then
                If Not String.IsNullOrEmpty(oauth_verifier) AndAlso oauth_verifier <> "" Then
                    ' Button1.Visible = False
                    OauthToken = oauth_token
                    OauthVerifier = oauth_verifier
                    RegisterStartupScript("refresh", "<script type='text/javascript'>window.opener.location = 'CrowdBoardManagement.aspx'; self.close();</script>")

                ElseIf Not String.IsNullOrEmpty(OauthVerifier) Then
                    If String.IsNullOrEmpty(OauthYahooGuid) Then
                        GetAccessToken(OauthToken, OauthVerifier)
                    End If
                    RetriveContacts()
                    RadWindow1.Height = 500
                    RadWindow1.Width = 700
                    RadWindow1.NavigateUrl = "~/rwYahooInvite.aspx"
                    RadWindow1.VisibleOnPageLoad = True
                    Session("isYahooInvite") = Nothing
                End If
            End If
        End If

        If Not String.IsNullOrEmpty(Request.QueryString("code")) Then
            If Not (Session("googelInvite") Is Nothing) Then
                Dim code As String = Request.QueryString("code")
                GetContactsByCode(code)
            End If
        End If

    End Sub
    Private Sub LoadBoardDescriptionInfo()
        Try

            sdBoard.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
            ' sdInvestorsAddress.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName

            Dim dv As Data.DataView = CType(sdBoard.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("Boardname"))) Then
                    lblCrowdboardName.Text = dv(0)("Boardname")
                End If
                If (Not IsDBNull(dv(0)("RaisedTotal"))) Then
                    lblRaised.Text = GetAmount(dv(0)("RaisedTotal"), dv(0)("BankLocation"))
                End If
                If (Not IsDBNull(dv(0)("ViewsCount"))) Then
                    lblViews.Text = dv(0)("ViewsCount")
                Else
                    lblViews.Text = "0"
                End If

                If Not isAvail("~/Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg").Contains("noimage.jpg") Then
                    Dim pathCoverPic As String = "Upload/BoardCoverPics/" & Me.DirectoryName & ".jpg"
                    coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
                Else
                    coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/crowdboardvideopreview.png);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")

                    'coverPicDiv.Attributes.Add("style", "background-color:#626262;min-height: 100px; width: 100%;")
                End If



                If (Not IsDBNull(dv(0)("Investors"))) Then
                    lblBoardersIn.Text = dv(0)("Investors")
                    lblBoardersInBoard.Text = dv(0)("Investors")

                    If Not (String.IsNullOrEmpty(lblBoardersIn.Text)) Then
                        If (Convert.ToInt32(lblBoardersIn.Text) > 0) Then
                            lbtnBoardersIn.Enabled = True
                        Else
                            lbtnBoardersIn.Enabled = False
                        End If
                    Else
                        lbtnBoardersIn.Enabled = False
                    End If

                Else
                    lbtnBoardersIn.Enabled = False
                End If

                If (Not IsDBNull(dv(0)("Watches"))) Then
                    lblWatches.Text = dv(0)("Watches")
                    lblWatchesBoard.Text = dv(0)("Watches")
                    If Not (String.IsNullOrEmpty(lblWatches.Text)) Then
                        If (Convert.ToInt32(lblWatches.Text) > 0) Then
                            lbtnBoardersWatching.Enabled = True
                        Else
                            lbtnBoardersWatching.Enabled = False
                        End If
                    Else
                        lbtnBoardersWatching.Enabled = False
                    End If

                Else
                    lbtnBoardersWatching.Enabled = False
                End If


                sdInvestorsAddressEmpty.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
                sdInvestorsAddressAdded.SelectParameters.Item("DirectoryName").DefaultValue = Me.DirectoryName
                Dim dvInvestorsAddressEmpty As Data.DataView = CType(sdInvestorsAddressEmpty.Select(DataSourceSelectArguments.Empty), Data.DataView)
                Dim dvInvestorsAddressAdded As Data.DataView = CType(sdInvestorsAddressAdded.Select(DataSourceSelectArguments.Empty), Data.DataView)

                If Not (dvInvestorsAddressEmpty) Is Nothing Then

                    If (dvInvestorsAddressEmpty.Table.Rows.Count > 0) Then

                        lblNoEnterCount.Text = dvInvestorsAddressEmpty.Count.ToString() + " Not Entered"
                        lnkNoExportToCSV.Visible = True
                        rgInvestmentNoAddressExcel.DataSource = dvInvestorsAddressEmpty

                    Else
                        lnkNoExportToCSV.Visible = False
                        lblNoEnterCount.Text = "0 Not Entered"
                        rgInvestmentNoAddressExcel.DataSource = dvInvestorsAddressEmpty
                    End If
                Else
                    lnkNoExportToCSV.Visible = False
                    lblNoEnterCount.Text = "0 Not Entered"
                    rgInvestmentNoAddressExcel.DataSource = dvInvestorsAddressEmpty
                End If

                If Not (dvInvestorsAddressAdded) Is Nothing Then

                    If (dvInvestorsAddressAdded.Table.Rows.Count > 0) Then

                        lblEnterCount.Text = dvInvestorsAddressAdded.Count.ToString()
                        lnkExportToCSV.Visible = True
                        rgInvestmentAddressExcel.DataSource = dvInvestorsAddressAdded
                    Else
                        lblEnterCount.Text = "0 Entered"
                        lnkExportToCSV.Visible = False
                        rgInvestmentAddressExcel.DataSource = dvInvestorsAddressAdded
                    End If
                Else
                    lblEnterCount.Text = "0 Entered"
                    lnkExportToCSV.Visible = False
                    rgInvestmentAddressExcel.DataSource = dvInvestorsAddressAdded

                End If

                'lblEnterCount.Text = "0 Entered"
                'lblNoEnterCount.Text = "0 Not Entered"
                'lnkExportToCSV.Visible = False
                'lnkNoExportToCSV.Visible = False



                'Dim dv1 As Data.DataView = CType(sdInvestorsAddress.Select(DataSourceSelectArguments.Empty), Data.DataView)
                'Dim copyDataTable As DataTable
                'Dim cDataTable As DataTable
                'If (dv1.Count > 0) Then
                '    copyDataTable = dv1.Table.Copy()
                '    cDataTable = dv1.Table.Copy()
                '    For i As Integer = 0 To 2
                '        Dim columnIndex As Integer = 0
                '        cDataTable.Columns.RemoveAt(columnIndex)
                '    Next
                '    Dim filteredRows As DataTable = cDataTable.Rows.Cast(Of DataRow)().Where(Function(row) Not row.ItemArray.All(Function(field) TypeOf field Is System.DBNull OrElse String.Compare(TryCast(field, String).Trim(), String.Empty) = 0)).CopyToDataTable()

                '    If (filteredRows.Rows.Count > 0) Then
                '        lblNoEnterCount.Text = (dv1.Count - filteredRows.Rows.Count).ToString() + " Not Entered"
                '        lblEnterCount.Text = filteredRows.Rows.Count.ToString() + " Entered"

                '    Else
                '        lblEnterCount.Text = "0 Entered"
                '        lblNoEnterCount.Text = (dv1.Count).ToString() + " Not Entered"
                '    End If
                '    Dim dt1 As New DataTable
                '    dt1.Columns.Add("UserName")
                '    dt1.Columns.Add("FullName")
                '    dt1.Columns.Add("Email")
                '    dt1.Columns.Add("BoarderAddress")
                '    dt1.Columns.Add("BoarderCity")
                '    dt1.Columns.Add("BoarderState")
                '    dt1.Columns.Add("Boarderzip")
                '    Dim dt2 As New DataTable
                '    dt2.Columns.Add("UserName")
                '    dt2.Columns.Add("FullName")
                '    dt2.Columns.Add("Email")
                '    dt2.Columns.Add("BoarderAddress")
                '    dt2.Columns.Add("BoarderCity")
                '    dt2.Columns.Add("BoarderState")
                '    dt2.Columns.Add("Boarderzip")
                '    For Each dr As DataRow In copyDataTable.Rows
                '        If (String.IsNullOrEmpty(dr(3).ToString()) And String.IsNullOrEmpty(dr(4).ToString()) And String.IsNullOrEmpty(dr(5).ToString()) And String.IsNullOrEmpty(dr(6).ToString())) Then
                '            dt1.Rows.Add(dr.ItemArray)
                '            rgInvestmentNoAddressExcel.DataSource = dt1
                '        Else
                '            dt2.ImportRow(dr)
                '            rgInvestmentAddressExcel.DataSource = dt2
                '        End If

                '    Next

                'Else
                '    lblEnterCount.Text = "0 Entered"
                '    lblNoEnterCount.Text = "0 Not Entered"
                '    lnkExportToCSV.Visible = False
                '    lnkNoExportToCSV.Visible = False

                'End If



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
                    lblSeeking.Text = GetAmount(dv(0)("TotalOffer"), dv(0)("BankLocation"))
                End If
                If (Not IsDBNull(dv(0)("invType"))) Then
                    lblInvType.Text = dv(0)("invType")
                End If
                If (Not IsDBNull(dv(0)("DateActivated"))) Then
                    lblLiveSince.Text = dv(0)("DateActivated")
                End If
                If (Not IsDBNull(dv(0)("AmountRemaining"))) Then
                    lblAmountLeft.Text = GetAmount(dv(0)("AmountRemaining"), dv(0)("BankLocation"))
                End If
                If (Not IsDBNull(dv(0)("BoardLevel"))) Then
                    lblBoardLevel.Text = IIf(dv(0)("BoardLevel") = "Not Calculated", "1", dv(0)("BoardLevel"))
                End If
                If (Not IsDBNull(dv(0)("Description"))) Then
                    lblDescription.Text = dv(0)("Description")
                End If
                Dim largeChange As Integer
                If (Not IsDBNull(dv(0)("TotalOffer"))) Then
                    ThermometerSlider.MaximumValue = Convert.ToDecimal(dv(0)("TotalOffer"))
                    largeChange = Convert.ToInt32(dv(0)("TotalOffer")) / 5
                    ThermometerSlider.LargeChange = largeChange
                Else
                    ThermometerSlider.MaximumValue = 5000
                    largeChange = 5000 / 5
                    ThermometerSlider.LargeChange = largeChange
                End If
                If (Not IsDBNull(dv(0)("RaisedTotal"))) Then
                    ThermometerSlider.Value = Convert.ToInt64(dv(0)("RaisedTotal"))
                Else
                    ThermometerSlider.Value = 0
                End If
                'If (Not IsDBNull(dv(0)("FacebookSync"))) Then
                '    If Convert.ToBoolean(dv(0)("FacebookSync")) = True Then
                '        syncFacebook.Text = "Unsync"
                '    End If
                'End If
                'If (Not IsDBNull(dv(0)("LinkedInSync"))) Then
                '    If Convert.ToBoolean(dv(0)("LinkedInSync")) = True Then
                '        syncLinkedIn.Text = "Unsync"
                '    End If
                'End If
                'If (Not IsDBNull(dv(0)("TwitterSync"))) Then
                '    If Convert.ToBoolean(dv(0)("TwitterSync")) = True Then
                '        syncTwitter.Text = "Unsync"
                '    End If
                'End If
                If (Not IsDBNull(dv(0)("BoardName"))) Then
                    boardNameLink.Text = dv(0)("BoardName")
                    boardNameLink.NavigateUrl = "~/Board.aspx?Name=" & Me.DirectoryName
                    boardLink.NavigateUrl = "~/Board.aspx?Name=" & Me.DirectoryName
                    lblCrowdBoard.Text = dv(0)("BoardName").ToString()
                    boardAnchor.HRef = "~/Board.aspx?Name=" & Me.DirectoryName
                End If
                If (Not IsDBNull(dv(0)("YoutubeVideoUrl"))) Then
                    Me.youtubeVideoUrl = dv(0)("YoutubeVideoUrl")
                    ibtnPlay1.Visible = True
                Else
                    ibtnPlay1.Visible = False
                End If

                Dim GM As New GlobalModule
                Dim pathBoardPic As String = GM.GetImageURL(Me.DirectoryName & ".jpg", 150, 150, "thumbnail", "thumbs")
                imgBoard.Src = pathBoardPic

                Dim strEmbed As String = "<div style='height: 280px; width: 280px;'><iframe src='" & System.Configuration.ConfigurationManager.AppSettings("site").ToString() & "/EmbedPage.aspx?Name=" & Me.DirectoryName & "' style='height: 280px; width: 100%;' frameborder='0' scrolling='no' overflow='hidden'></iframe></div>"
                txtEmbed.Text = strEmbed
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Sub LoadCharts()
        Try
            sdComments.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdInvestments.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdViews.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdWatches.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardersWatching.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardersWatching.SelectParameters.Item("UserID").DefaultValue = Session("userID")
            sdBoardersIn.SelectParameters.Item("BoardID").DefaultValue = Me.boardID
            sdBoardersIn.SelectParameters.Item("UserID").DefaultValue = Session("userID")
            Dim dv As DataView = CType(sdComments.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv1 As DataView = CType(sdInvestments.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv2 As DataView = CType(sdViews.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dv3 As DataView = CType(sdWatches.Select(DataSourceSelectArguments.Empty), DataView)

            RadChartComments.DataSource = dv
            RadChartComments.DataBind()

            RadChartInvestors.DataSource = dv1
            RadChartInvestors.DataBind()

            RadChartViews.DataSource = dv2
            RadChartViews.DataBind()

            RadChartWatches.DataSource = dv3
            RadChartWatches.DataBind()

        Catch ex As Exception
            Throw ex
        End Try

    End Sub




    Protected Sub yahooInvite_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles yahooInvite.Click
        Try
            If Not (Request.QueryString("Name")) Is Nothing Then
                Session("queryString") = Request.QueryString("Name")
            End If

            Me.OauthToken = String.Empty
            Me.OauthTokenSecret = String.Empty
            Me.OauthVerifier = String.Empty
            Me.OauthYahooGuid = String.Empty
            Me.OauthSessionHandle = String.Empty
            Dim authorizationUrl As String = String.Empty
            authorizationUrl = GetRequestToken()
            RedirectUserForAuthorization(authorizationUrl)
            Session("isYahooInvite") = "1"
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    Public Sub GetAccessToken(ByVal oauth_token As String, ByVal oauth_verifier As String)
        Dim oauth As New OAuthYahoo.OAuthBase()


        'Uri uri = new Uri(WsLib.KP.YRt);
        Dim uri As New Uri("https://api.login.yahoo.com/oauth/v2/get_token")
        Dim nonce As String = oauth.GenerateNonce()
        Dim timeStamp As String = oauth.GenerateTimeStamp()
        Dim sig As String = ConsumerSecret + "%26" + OauthTokenSecret

        Dim sbAccessToken As New StringBuilder(uri.ToString())
        sbAccessToken.AppendFormat("?oauth_consumer_key={0}&", ConsumerKey)
        sbAccessToken.AppendFormat("oauth_signature_method={0}&", "PLAINTEXT")
        sbAccessToken.AppendFormat("oauth_signature={0}&", sig)
        sbAccessToken.AppendFormat("oauth_timestamp={0}&", timeStamp)
        sbAccessToken.AppendFormat("oauth_version={0}&", "1.0")
        sbAccessToken.AppendFormat("oauth_token={0}&", oauth_token)
        sbAccessToken.AppendFormat("oauth_nonce={0}&", nonce)
        sbAccessToken.AppendFormat("oauth_verifier={0}", oauth_verifier)

        Try
            Dim returnStr As String = String.Empty
            Dim returnData As String()

            Dim req As System.Net.HttpWebRequest = DirectCast(System.Net.WebRequest.Create(sbAccessToken.ToString()), System.Net.HttpWebRequest)
            req.Accept = "application/xml"
            Dim res As System.Net.HttpWebResponse = DirectCast(req.GetResponse(), System.Net.HttpWebResponse)
            Dim streamReader As New System.IO.StreamReader(res.GetResponseStream())
            returnStr = streamReader.ReadToEnd()
            returnData = returnStr.Split(New [Char]() {"&"c})

            Dim index As Integer
            If returnData.Length > 0 Then
                index = returnData(0).IndexOf("=")
                OauthToken = returnData(0).Substring(index + 1)

                index = returnData(1).IndexOf("=")
                Dim oauth_token_secret As String = returnData(1).Substring(index + 1)
                OauthTokenSecret = oauth_token_secret

                index = returnData(3).IndexOf("=")
                Dim oauth_session_handle As String = returnData(3).Substring(index + 1)
                OauthSessionHandle = oauth_session_handle

                index = returnData(5).IndexOf("=")
                Dim xoauth_yahoo_guid As String = returnData(5).Substring(index + 1)
                OauthYahooGuid = xoauth_yahoo_guid

            End If
        Catch ex As System.Net.WebException
            'HttpContext.Current.Session["error"] = ex.Message.ToString();
            Throw ex
        End Try
    End Sub


    Protected Sub ibtnPlay1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ibtnPlay1.Click

        RadMediaPlayer1.Sources.Clear()
        RadMediaPlayer1.StartTime = 0
        RadMediaPlayer1.Muted = False
        RadMediaPlayer1.AutoPlay = False
        RadMediaPlayer1.Title = Me.DirectoryName
        RadMediaPlayer1.Source = Me.youtubeVideoUrl
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "functionCall", "loadPopupBoxVideo();", True)
    End Sub

    Protected Sub performanceLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles performanceLinkButton.Click
        RadMultiPage1.SelectedIndex = 0
        ResetCss()
        performanceLinkButton.Attributes.Add("style", "text-decoration: underline;")
    End Sub

    Protected Sub lbtnMarketing_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnMarketing.Click
        RadMultiPage1.SelectedIndex = 1
        ResetCss()
        lbtnMarketing.Attributes.Add("style", "text-decoration: underline;")
    End Sub
    Protected Sub lbtnAnalytics_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnAnalytics.Click
        RadMultiPage1.SelectedIndex = 2
        ResetCss()
        lbtnAnalytics.Attributes.Add("style", "text-decoration: underline;")
    End Sub
    'Protected Sub lbtnBoardersIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBoardersIn.Click
    '    RadMultiPage1.SelectedIndex = 3
    '    ResetCss()
    '    lbtnBoardersIn.Attributes.Add("style", " text-decoration: underline;")
    'End Sub
    'Protected Sub lbtnBoardersWatching_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBoardersWatching.Click
    '    RadMultiPage1.SelectedIndex = 4
    '    'ResetCss()
    '    'lbtnBoardersWatching.Attributes.Add("style", "color:#99CCFF;font-size: large; text-decoration: none;")
    'End Sub
    Protected Sub lbtnViewsGraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnViewsGraph.Click
        RadMultiPageGraph.SelectedIndex = 0
    End Sub
    Protected Sub lbtnWatchesGraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnWatchesGraph.Click
        RadMultiPageGraph.SelectedIndex = 1
    End Sub
    Protected Sub lbtnCommentsGraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnCommentsGraph.Click
        RadMultiPageGraph.SelectedIndex = 2
    End Sub
    Protected Sub lbtnBoardersInGraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnBoardersInGraph.Click
        RadMultiPageGraph.SelectedIndex = 3
    End Sub
    Protected Sub lbtnConversionRateGraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnConversionRateGraph.Click
        RadMultiPageGraph.SelectedIndex = 4
    End Sub
    'Protected Sub lbtnNextMarketing_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnNextMarketing.Click
    '    RadMultiPage1.SelectedIndex = RadMultiPage1.SelectedIndex + 1
    '    'ResetCss()
    '    'lbtnAnalytics.Attributes.Add("style", "color:#99CCFF")
    'End Sub
    'Protected Sub lbtnNextAnalytics_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnNextAnalytics.Click
    '    RadMultiPage1.SelectedIndex = RadMultiPage1.SelectedIndex + 1
    'End Sub
    'Protected Sub lbtnNextBoardersIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnNextBoardersIn.Click
    '    RadMultiPage1.SelectedIndex = RadMultiPage1.SelectedIndex + 1
    '    'ResetCss()
    '    'lbtnBoardersWatching.Attributes.Add("style", "color:#99CCFF;font-size: large; text-decoration: none;")
    'End Sub
    'Protected Sub lbtnNextBoardersWatching_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnNextBoardersWatching.Click
    '    RadMultiPage1.SelectedIndex = 0
    '    'ResetCss()
    '    'lbtnMarketing.Attributes.Add("style", "color:#99CCFF")
    'End Sub
    Protected Sub ResetCss()
        Try
            performanceLinkButton.Attributes.Add("style", "font-size: large; text-decoration: none;")
            lbtnMarketing.Attributes.Add("style", "font-size: large; text-decoration: none;")
            lbtnAnalytics.Attributes.Add("style", "font-size: large; text-decoration: none;")
            lbtnBoardersIn.Attributes.Add("style", "font-size: large; text-decoration: none;")
            lbtnBoardersWatching.Attributes.Add("style", "font-size:large;text-decoration: none;")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    'Protected Sub syncFacebook_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles syncFacebook.Click
    '    Try
    '        If syncFacebook.Text = "Start" Then
    '            FacebookSync(True)
    '            syncFacebook.Text = "Unsync"
    '        Else
    '            FacebookSync(False)
    '            syncFacebook.Text = "Start"
    '        End If
    '    Catch ex As Exception
    '        GlobalModule.SetMessage(lblMessage, False, "Error in Request")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub
    'Protected Sub syncLinkedIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles syncLinkedIn.Click
    '    Try
    '        If syncLinkedIn.Text = "Start" Then
    '            LinkedInSync(True)
    '            syncLinkedIn.Text = "Unsync"
    '        Else
    '            LinkedInSync(False)
    '            syncLinkedIn.Text = "Start"
    '        End If
    '    Catch ex As Exception
    '        GlobalModule.SetMessage(lblMessage, False, "Error in Request")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub
    'Protected Sub syncTwitter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles syncTwitter.Click
    '    Try
    '        If syncTwitter.Text = "Start" Then
    '            TwitterSync(True)
    '            syncTwitter.Text = "Unsync"
    '        Else
    '            TwitterSync(False)
    '            syncTwitter.Text = "Start"
    '        End If
    '    Catch ex As Exception
    '        GlobalModule.SetMessage(lblMessage, False, "Error in Request")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub
    Protected Sub btnSendEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendEmail.Click

        Try
            If Not txtSendMultipleEmail.Text = "" Then
                Dim emailList As String = txtSendMultipleEmail.Text
                If (GlobalModule.ValidateEmail(emailList)) Then
                    Dim list As New ArrayList()
                    list.AddRange(emailList.Split(New Char() {","c}))
                    SendRequest(list)
                Else
                    GlobalModule.SetMessage(lblMessageSendEmail, False, "Please Enter valid Email Id")
                End If
            Else
                GlobalModule.SetMessage(lblMessageSendEmail, False, "Please enter Email Id")
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageSendEmail, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Private Sub SendRequest(ByVal Emails As ArrayList)
        Try
            If Not Emails Is Nothing Then
                Dim strSubject As String = "CrowdBoard Invitation"
                Dim strBody As String = "Please click the link below to Join CrowdBoard<br><br>"
                Dim returnUrl As String = ConfigurationManager.AppSettings("site").ToString() & "/" & Me.DirectoryName
                'Dim finalUrl As String = returnUrl & "&returnUrl=" & returnUrl
                Dim verificationLink As String = "<a href='" & returnUrl & "'>Click to see CrowdBoard</a>"
                strBody = strBody & verificationLink
                For Each strMailTo As String In Emails
                    GlobalModule.SendEmail(strMailTo, strSubject, strBody, True)
                Next
                GlobalModule.SetMessage(lblMessageSendEmail, True, "Request sent Successfully")
            Else
                GlobalModule.SetMessage(lblMessageSendEmail, True, "Please enter Email Addresses")
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmail.Click
        Try
            Dim dv As Data.DataView = CType(sdGetUserEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("Email"))) Then
                    Dim Email As String = dv(0)("Email")
                    If (GlobalModule.ValidateEmail(Email)) Then
                        Dim strSubject As String = "Embed Code of CrowdBoard"
                        Dim strBody As String = txtEmbed.Text
                        GlobalModule.SendEmail(Email, strSubject, strBody, False)
                        GlobalModule.SetMessage(lblMessageEmbed, True, "Code sent Successfully")
                    Else
                        GlobalModule.SetMessage(lblMessageEmbed, True, "You dont have valid Email Address")
                    End If
                Else
                    GlobalModule.SetMessage(lblMessageEmbed, True, "Please Save your Email first")
                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageEmbed, True, "Error in request")
            GlobalModule.WriteLog(ex)
        End Try
    End Sub

    'Protected Sub FacebookSync(ByVal status As Boolean)
    '    Try
    '        sdSyncFacebook.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
    '        sdSyncFacebook.UpdateParameters.Item("FacebookSync").DefaultValue = status
    '        sdSyncFacebook.Update()
    '        LoadBoardDescriptionInfo()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub
    'Protected Sub LinkedInSync(ByVal status As Boolean)
    '    Try
    '        sdSyncLinkedIn.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
    '        sdSyncLinkedIn.UpdateParameters.Item("LinkedInSync").DefaultValue = status
    '        sdSyncLinkedIn.Update()
    '        LoadBoardDescriptionInfo()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub
    'Protected Sub TwitterSync(ByVal status As Boolean)
    '    Try
    '        sdSyncTwitter.UpdateParameters.Item("BoardID").DefaultValue = Me.boardID
    '        sdSyncTwitter.UpdateParameters.Item("TwitterSync").DefaultValue = status
    '        sdSyncTwitter.Update()
    '        LoadBoardDescriptionInfo()
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub
    Protected Sub boardersInDataList_ItemCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs) Handles boardersInDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                SendBoarderRequest(userID2)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub boardersWatchingDataList_ItemCommand(ByVal source As Object, ByVal e As DataListCommandEventArgs) Handles boardersWatchingDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                SendBoarderRequest(userID2)
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessage, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub
    Protected Sub SendBoarderRequest(ByVal userID2 As Integer)
        Try
            Dim requestStatus As Integer = CheckRequest(userID2)
            If (requestStatus = 3) Then
                sdBoarders.InsertParameters.Item("userID2").DefaultValue = userID2
                sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdBoarders.Insert()
                GlobalModule.SetMessage(lblMessage, True, "Request Sent Successfully")
                boardersInDataList.DataBind()
            Else
                If requestStatus = 0 Then
                    GlobalModule.SetMessage(lblMessage, False, "You have already send request")
                ElseIf requestStatus = 1 Then
                    GlobalModule.SetMessage(lblMessage, False, "You are already friend")
                Else
                    sdBoarders.UpdateParameters.Item("userID2").DefaultValue = userID2
                    sdBoarders.UpdateParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.Update()
                    GlobalModule.SetMessage(lblMessage, True, "Request Sent Successfully")
                    boardersInDataList.DataBind()
                End If

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Function getBoardId(ByVal name As String) As Integer
        Dim boardId As Integer = 0
        Try
            sdGetBoardIdDataSource.SelectParameters.Item("Name").DefaultValue = name 'Request.QueryString("Name")
            Dim dv As Data.DataView = CType(sdGetBoardIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                boardId = dv(0)("BoardID")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return boardId
    End Function
    Protected Function CheckRequest(ByVal UserID2 As Integer) As Integer
        Dim status As Integer
        Try
            sdCheckRequest.SelectParameters.Item("UserID2").DefaultValue = UserID2
            sdCheckRequest.SelectParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("userID").ToString())
            Dim dv As Data.DataView = CType(sdCheckRequest.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If dv.Count > 0 Then
                status = dv(0)("status")
            Else
                status = 3
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return status
    End Function
    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function

    Private Sub RedirectUserForAuthorization(ByVal authorizationUrl As String)
        'Response.Redirect(authorizationUrl);
        RegisterStartupScript("openwin", (Convert.ToString("<script type='text/javascript'>window.open('") & authorizationUrl) + "','mywindow', 'left=250,top=50,menubar=0,resizable=0,location=1,toolbar=0,status=1,scrollbars=0,width=500,height=455');</script>")
    End Sub

    Public Function GetRequestToken() As String
        Dim authorizationUrl As String = String.Empty
        Dim oauth__1 As New OAuthYahoo.OAuthBase()

        '  Dim uri As New Uri(callbackYahoo)
        Dim uri = New Uri("https://api.login.yahoo.com/oauth/v2/get_request_token")
        Dim nonce As String = oauth__1.GenerateNonce()
        Dim timeStamp As String = oauth__1.GenerateTimeStamp()
        Dim normalizedUrl As String = ""
        Dim normalizedRequestParameters As String = ""
        Dim sig As String = oauth__1.GenerateSignature(uri, ConsumerKey, ConsumerSecret, String.Empty, String.Empty, "GET", _
         timeStamp, nonce, OAuthYahoo.OAuthBase.SignatureTypes.PLAINTEXT, normalizedUrl, normalizedRequestParameters)
        'OAuthBase.SignatureTypes.HMACSHA1
        Dim sbRequestToken As New StringBuilder(uri.ToString())
        sbRequestToken.AppendFormat("?oauth_nonce={0}&", nonce)
        sbRequestToken.AppendFormat("oauth_timestamp={0}&", timeStamp)
        sbRequestToken.AppendFormat("oauth_consumer_key={0}&", ConsumerKey)
        sbRequestToken.AppendFormat("oauth_signature_method={0}&", "PLAINTEXT")
        sbRequestToken.AppendFormat("oauth_signature={0}&", sig)
        sbRequestToken.AppendFormat("oauth_version={0}&", "1.0")
        sbRequestToken.AppendFormat("oauth_callback={0}", System.Web.HttpUtility.UrlEncode("" & System.Configuration.ConfigurationManager.AppSettings("yahooCallbackInviteFromManage")))
        'sbRequestToken.AppendFormat("oauth_callback={0}", System.Web.HttpUtility.UrlEncode(WsLib.KP.YCBc))

        Try
            Dim returnStr As String = String.Empty
            Dim returnData As String()

            Dim req As System.Net.HttpWebRequest = DirectCast(System.Net.WebRequest.Create(sbRequestToken.ToString()), System.Net.HttpWebRequest)
            Dim res As System.Net.HttpWebResponse = DirectCast(req.GetResponse(), System.Net.HttpWebResponse)
            Dim streamReader As New System.IO.StreamReader(res.GetResponseStream())
            returnStr = streamReader.ReadToEnd()
            returnData = returnStr.Split(New [Char]() {"&"c})

            Dim index As Integer
            If returnData.Length > 0 Then
                index = returnData(1).IndexOf("=")
                Dim oauth_token_secret As String = returnData(1).Substring(index + 1)
                OauthTokenSecret = oauth_token_secret
                index = returnData(3).IndexOf("=")
                Dim oauth_request_auth_url As String = returnData(3).Substring(index + 1)
                authorizationUrl = System.Web.HttpUtility.UrlDecode(oauth_request_auth_url)
            End If
        Catch ex As System.Net.WebException

            HttpContext.Current.Response.Write(ex.Message)
        End Try
        Return authorizationUrl
    End Function

    Private Sub RetriveContacts()
        Dim oauth As New OAuthYahoo.OAuthBase()

        Dim uri As New Uri("https://social.yahooapis.com/v1/user/" + OauthYahooGuid + "/contacts?format=XML")
        Dim nonce As String = oauth.GenerateNonce()
        Dim timeStamp As String = oauth.GenerateTimeStamp()
        Dim normalizedUrl As String
        Dim normalizedRequestParameters As String
        Dim sig As String = oauth.GenerateSignature(uri, ConsumerKey, ConsumerSecret, OauthToken, OauthTokenSecret, "GET", _
         timeStamp, nonce, OAuthYahoo.OAuthBase.SignatureTypes.HMACSHA1, normalizedUrl, normalizedRequestParameters)

        Dim sbGetContacts As New StringBuilder(uri.ToString())

        'Response.Write("URL: " + sbGetContacts.ToString());
        'Response.End();

        Try
            Dim returnStr As String = String.Empty
            Dim req As HttpWebRequest = DirectCast(WebRequest.Create(sbGetContacts.ToString()), HttpWebRequest)
            req.Method = "GET"
            req.Accept = "application/xml"
            Dim authHeader As String = (Convert.ToString((Convert.ToString("Authorization: OAuth " + "realm=""yahooapis.com""" + ",oauth_consumer_key=""" + ConsumerKey + """" + ",oauth_nonce=""") & nonce) + """" + ",oauth_signature_method=""HMAC-SHA1""" + ",oauth_timestamp=""") & timeStamp) + """" + ",oauth_token=""" + OauthToken + """" + ",oauth_version=""1.0""" + ",oauth_signature=""" + System.Web.HttpUtility.UrlEncode(sig) + """"

            'Response.Write("</br>Headers: " + authHeader);

            req.Headers.Add(authHeader)

            Dim res As HttpWebResponse = DirectCast(req.GetResponse(), HttpWebResponse)
            Dim streamReader As New StreamReader(res.GetResponseStream())
            returnStr = streamReader.ReadToEnd()
            Dim xmldoc As New XmlDocument()
            xmldoc.LoadXml(returnStr)
            'xml start
            ' Response.Write(returnStr)
            ' xml end
            Dim elemList As XmlNodeList = xmldoc.DocumentElement.GetElementsByTagName("fields")
            Dim eml As String
            Dim resultTable As New DataTable
            resultTable.Columns.Add("EmailAddress", GetType(String))
            Dim emails As New ArrayList()
            For i As Integer = 0 To elemList.Count - 1
                Dim rowResult As DataRow
                rowResult = resultTable.NewRow()
                If elemList(i).ChildNodes(1).InnerText = "email" Then
                    emails.Add(elemList(i).ChildNodes(2).InnerText)
                    rowResult("EmailAddress") = elemList(i).ChildNodes(2).InnerText
                    resultTable.Rows.Add(rowResult)
                End If
            Next
            Session("yahooContactList") = emails

            '#Region "error"
        Catch ex As WebException

            GlobalModule.SetMessage(lblMessageSendEmail, False, "Error in loding Data")
            'Response.Write(ex.Message)
            'Response.Write("<br/>" + ex.Message + "</br>xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
            'Response.Write("<br/>length: " + ex.Source.Length.ToString())
            'Response.Write("<br/>stack trace: " + ex.StackTrace)
            'Response.Write("<br/>status: " + ex.Status.ToString())
            'Dim res As HttpWebResponse = DirectCast(ex.Response, HttpWebResponse)
            'Dim code As Integer = Convert.ToInt32(res.StatusCode)

            'Response.Write("<br/>Status Code: (" + code.ToString() + ") " + res.StatusCode.ToString())
            'Response.Write("<br/>Status Description: " + res.StatusDescription)

            'If ex.InnerException IsNot Nothing Then
            '    Response.Write("<br/>innerexception: " + ex.InnerException.Message)
            'End If

            'If ex.Source.Length > 0 Then
            '    Response.Write("<br/>source: " + ex.Source.ToString())
            'End If

            'If res IsNot Nothing Then
            '    For i As Integer = 0 To res.Headers.Count - 1
            '        Response.Write("<br/>headers: " + i.ToString() + ": " + res.Headers(i))
            '    Next
            'End If

        End Try
        '#End Region
    End Sub


    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function


    Protected Sub lbtnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnEdit.Click

        Response.Redirect("BoardDetails.aspx?Name=" + Me.DirectoryName)
    End Sub
    Protected Sub lbtnManage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnManage.Click

        Response.Redirect("CrowdBoardManagement.aspx?Name=" + Me.DirectoryName)
    End Sub
    Protected Sub lbtnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnUpdate.Click

        Response.Redirect("UpdateBoarders.aspx?Name=" + Me.DirectoryName)
    End Sub

    Protected Sub lnkExportToCSV_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkExportToCSV.Click
        rgInvestmentAddressExcel.AllowSorting = False
        rgInvestmentAddressExcel.ExportSettings.FileName = "BoardersAddress" + Me.DirectoryName
        rgInvestmentAddressExcel.MasterTableView.ExportToCSV()
    End Sub
    Protected Sub lnkNoExportToCSV_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNoExportToCSV.Click
        rgInvestmentNoAddressExcel.AllowSorting = False
        rgInvestmentNoAddressExcel.ExportSettings.FileName = "BoardersWithoutAddress" + Me.DirectoryName
        rgInvestmentNoAddressExcel.MasterTableView.ExportToCSV()
    End Sub



    Public Function GetContactsByCode(ByVal code As String) As List(Of String)
        '  Dim mglst As New List(Of MasterGuestList)()

        Dim para As New Google.GData.Client.OAuth2Parameters()


        para.RedirectUri = ConfigurationManager.AppSettings("GCBcManagePage").ToString() ' & "?Name=" & Me.DirectoryName  'WsLib.KP.GCBc
        para.ClientId = ConfigurationManager.AppSettings("GCIdManagePage").ToString() 'WsLib.KP.GCId
        para.ClientSecret = ConfigurationManager.AppSettings("GCSManagePage").ToString() ' WsLib.KP.GCS
        para.AuthUri = ConfigurationManager.AppSettings("GCAUri").ToString() ' WsLib.KP.GCAUri
        para.TokenUri = ConfigurationManager.AppSettings("GCTUri").ToString() ' WsLib.KP.GCTUri
        para.Scope = ConfigurationManager.AppSettings("GCSc").ToString() ' WsLib.KP.GCSc

        para.AccessCode = code

        OAuthUtil.GetAccessToken(para)

        Dim req As New Google.GData.Client.RequestSettings("CrowdboardLocal", para)
        Dim creq As New ContactsRequest(req)
        Dim feed As Feed(Of Google.Contacts.Contact) = creq.GetContacts()

        Dim dtResult As New DataTable
        dtResult.Columns.Add("Email", GetType(String))
        dtResult.Columns.Add("Name", GetType(String))
        dtResult.Columns.Add("PhotoUrl", GetType(String))

        For Each entry As Google.Contacts.Contact In feed.Entries

            Dim drResult As DataRow
            drResult = dtResult.NewRow
            '    Dim mgl As New MasterGuestList()

            Dim name As Name = entry.Name

            If name Is Nothing Then
                Continue For
            End If


            If Not String.IsNullOrEmpty(name.FullName) Then
                drResult("Name") = name.GivenName
            Else
                If Not String.IsNullOrEmpty(name.GivenName) Then
                    drResult("Name") = name.GivenName
                End If
            End If

            Dim primaryemail As String = If((entry.PrimaryEmail IsNot Nothing AndAlso Not String.IsNullOrEmpty(entry.PrimaryEmail.Address)), entry.PrimaryEmail.Address, String.Empty)
            If Not String.IsNullOrEmpty(primaryemail) Then
                drResult("Email") = primaryemail
            Else
                Dim mails = entry.Emails
                If mails IsNot Nothing AndAlso mails.Count() > 0 Then
                    Dim fe As String = mails.FirstOrDefault().Address
                    If Not String.IsNullOrEmpty(fe) Then
                        drResult("Email") = fe
                    End If
                End If
            End If
            If Not String.IsNullOrEmpty(entry.PhotoEtag) Then
                Dim img As System.Drawing.Image
                img = System.Drawing.Image.FromStream(creq.Service.Query(entry.PhotoUri))
                Dim picUrl As String = DownloadPhoto(img, entry.PhotoUri.Segments(6))
                drResult("PhotoUrl") = picUrl
            Else
                drResult("PhotoUrl") = "Images/user_m.jpg"
            End If
            dtResult.Rows.Add(drResult)
        Next
        Session("googleContact") = dtResult
        RadWindow1.Height = 600
        RadWindow1.Width = 900
        RadWindow1.NavigateUrl = "~/rwGoogle.aspx"
        RadWindow1.VisibleOnPageLoad = True

        Session("googelInvite") = Nothing
        'Return mglst
    End Function



    Public Function DownloadPhoto(ByVal img As System.Drawing.Image, ByVal fileName As String) As String


        Dim localPath As String = HttpContext.Current.Server.MapPath("~/Upload/GmailContactPics/" + Session("userID").ToString())
        If Not Directory.Exists(localPath) Then
            Directory.CreateDirectory(localPath)
        End If
        Dim fullPath As String = (Convert.ToString(localPath & Convert.ToString("/")) & fileName) + ".jpg"

        img.Save(fullPath)
        img.Dispose()
        Dim urlToSave As String = (Convert.ToString("" + ConfigurationSettings.AppSettings("site").ToString() + "/Upload/GmailContactPics/" + Session("userID").ToString() + "/") & fileName) + ".jpg"
        Return urlToSave
    End Function


    Protected Sub gooleInviteButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles gooleInviteButton.Click
        Try
            Session("googelInvite") = True
            'GoogleConnect.Authorize(Server.UrlEncode("https://www.google.com/m8/feeds/"))
            If Not (Request.QueryString("Name")) Is Nothing Then
                Session("queryString") = Request.QueryString("Name")
            Else

            End If

            Dim para As New Google.GData.Client.OAuth2Parameters()

            'para.RedirectUri = "" + ConfigurationSettings.AppSettings["site"].ToString() + "/Wedding/ImportGmailStep2/";

            'GoogleConnect.ClientId =

            para.RedirectUri = ConfigurationManager.AppSettings("GCBcManagePage").ToString() ' & "?Name=" & Me.DirectoryName  'WsLib.KP.GCBc
            para.ClientId = ConfigurationManager.AppSettings("GCIdManagePage").ToString() 'WsLib.KP.GCId
            para.ClientSecret = ConfigurationManager.AppSettings("GCSManagePage").ToString() ' WsLib.KP.GCS
            para.AuthUri = ConfigurationManager.AppSettings("GCAUri").ToString() ' WsLib.KP.GCAUri
            para.TokenUri = ConfigurationManager.AppSettings("GCTUri").ToString() ' WsLib.KP.GCTUri
            para.Scope = ConfigurationManager.AppSettings("GCSc").ToString() ' WsLib.KP.GCSc
            para.ApprovalPrompt = "auto"
            para.AccessType = "offline"

            Dim auth2 As New Google.GData.Client.OAuth2Authenticator("CrowdboardLocal", para)

            Dim url As String = Google.GData.Client.OAuthUtil.CreateOAuth2AuthorizationUrl(para)
            HttpContext.Current.Response.Redirect(url)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub


End Class