Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.IO
Imports ASPSnippets.FaceBookAPI
Imports ASPSnippets.TwitterAPI
Imports System.Net
Imports System.Web.Services
Imports LinqToTwitter
Imports System.Linq
Imports System.Threading.Tasks
Imports System.Xml
Imports Google.Contacts
Imports Google.GData.Contacts
Imports Google.GData.Client
Imports Google.GData.Extensions
'Imports ASPSnippets.GoogleAPI
Imports System.Web.Script.Serialization




Public Class BoarderLineup
    Inherits System.Web.UI.Page
    Public appID As String = String.Empty
    Public linkedinkey As String = String.Empty
    Dim accessToken As String = ""
    Dim accessTokenSecret As String = ""
    Dim callbackYahoo As String = ""



    Public ReadOnly Property ConsumerKey() As String
        Get
            Return "" & System.Configuration.ConfigurationManager.AppSettings("yahooConsumerKeyInviteFromLineup")
        End Get
    End Property

    Public ReadOnly Property ConsumerSecret() As String
        Get
            Return "" & System.Configuration.ConfigurationManager.AppSettings("yahooConsumerSecretInviteFromLineup")
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
        If (Session("userName") Is Nothing) Or (Session("userID") Is Nothing) Then
            Response.Redirect("~/Default.aspx", False)
            Exit Sub
        End If
        RadWindow1.VisibleOnPageLoad = False
        If Not Page.IsPostBack Then

            LoadAllBoarders()
            addFriendLinkButton.Attributes.Add("style", "text-decoration:underline")
        End If
        appID = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Key = "" & System.Configuration.ConfigurationManager.AppSettings("appID")
        FaceBookConnect.API_Secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey")
        linkedinkey = "" & System.Configuration.ConfigurationManager.AppSettings("linkedinKey")
        Session("queryString") = Nothing
        If Not IsPostBack Then
            Dim oauth_token As String = Request("oauth_token")
            Dim oauth_verifier As String = Request("oauth_verifier")
            If Not Session("isYahooInvite") Is Nothing Then
                If Not String.IsNullOrEmpty(oauth_verifier) AndAlso oauth_verifier <> "" Then
                    ' Button1.Visible = False
                    OauthToken = oauth_token
                    OauthVerifier = oauth_verifier
                    RegisterStartupScript("refresh", "<script type='text/javascript'>window.opener.location = 'BoarderLineup.aspx'; self.close();</script>")

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

        'GoogleConnect.ClientId = ConfigurationManager.AppSettings("GCId").ToString()
        'GoogleConnect.ClientSecret = ConfigurationManager.AppSettings("GCS").ToString()

        'GoogleConnect.RedirectUri = ConfigurationManager.AppSettings("GCBc").ToString() 'Request.Url.AbsoluteUri.Split("?"c)(0)
        'GoogleConnect.API = EnumAPI.Contacts
        'If Not String.IsNullOrEmpty(Request.QueryString("code")) Then
        '    If Not (Session("googelInvite") Is Nothing) Then

        '        Dim code As String = Request.QueryString("code")
        '        Dim json As String = GoogleConnect.Fetch("me", code, 50)
        '        Dim profile As GoogleContacts = New JavaScriptSerializer().Deserialize(Of GoogleContacts)(json)
        '        Dim dt As New DataTable()
        '        dt.Columns.AddRange(New DataColumn(2) {New DataColumn("Name", GetType(String)), New DataColumn("Email", GetType(String)), New DataColumn("PhotoUrl", GetType(String))})

        '        For Each contact As Contact In profile.Feed.Entry
        '            If Not (contact.GdEmail()) Is Nothing Then


        '                If Not (contact.GdEmail(0).Address) Is Nothing Then
        '                    Dim name As String = contact.Title.T
        '                    Dim email As String = contact.GdEmail(0).Address
        '                    Dim photo As Link = contact.Link.Find(Function(p) p.Rel.EndsWith("#photo"))
        '                    Dim photoUrl As String = GoogleConnect.GetPhotoUrl(If(photo IsNot Nothing, photo.Href, "~/Default.png"))
        '                    dt.Rows.Add(name, email, photoUrl)
        '                End If
        '            End If
        '        Next
        '        Session("googleContact") = dt
        '        RadWindow1.Height = 600
        '        RadWindow1.Width = 900
        '        RadWindow1.NavigateUrl = "~/rwGoogle.aspx"
        '        RadWindow1.VisibleOnPageLoad = True

        '        Session("googelInvite") = Nothing
        '    End If


        'End If
        'If Request.QueryString("error") = "access_denied" Then
        '    ClientScript.RegisterClientScriptBlock(Me.[GetType](), "alert", "alert('Access denied.')", True)
        'End If

    End Sub

    Protected Sub LoadAllBoarders()
        Try
            Dim dv As Data.DataView = CType(sdAllBoardersList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            dv.RowFilter = "friendStatus =2 or friendStatus=3"
            addFriendDataList.DataSource = dv
            addFriendDataList.DataBind()

            dv = CType(sdAllBoardersList.Select(DataSourceSelectArguments.Empty), Data.DataView)
            dv.RowFilter = "friendStatus=1"
            removeFriendDataList.DataSource = dv
            removeFriendDataList.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub addFriendLinkButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles addFriendLinkButton.Click
        Try
            MultiViewFriendList.ActiveViewIndex = 0
            headPanel.Visible = True
            lblMessageAddBoarder.Text = ""
            ResetCss()
            addFriendLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub removeFriendLinkButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles removeFriendLinkButton.Click
        Try
            MultiViewFriendList.ActiveViewIndex = 1
            headPanel.Visible = True
            lblMessageAddBoarder.Text = ""
            ResetCss()
            removeFriendLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub mediaLinkLinkButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles mediaLinkLinkButton.Click
        Try
            MultiViewFriendList.ActiveViewIndex = 2
            headPanel.Visible = False
            lblMessageAddBoarder.Text = ""
            ResetCss()
            mediaLinkLinkButton.Attributes.Add("style", "text-decoration:underline")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub





    Protected Sub removeFriendDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles removeFriendDataList.ItemDataBound
        Try

            Dim hdnFriend = TryCast(e.Item.FindControl("hdnRemFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("remfirendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width:100%; background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%; padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub addFriendDataList_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs) Handles addFriendDataList.ItemDataBound
        Try

            Dim hdnFriend = TryCast(e.Item.FindControl("hdnAddFriend"), HiddenField)
            Dim firendDiv As HtmlGenericControl = TryCast(e.Item.FindControl("addfirendDiv"), HtmlGenericControl)
            Dim GM As New GlobalModule
            Dim path As String = GM.GetImageURL(hdnFriend.Value & ".jpg", "130", "130", "Upload/ProfilePics", "Upload/ProfilePics/thumbnail")

            Dim attributeValue As String = "background-image:url(" & path & ");height:100%; width:100%; background-repeat:no-repeat; overflow: hidden;  background-size: 100% 100%; padding:5px;"

            firendDiv.Attributes.Add("style", attributeValue)

        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub
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

    Protected Sub addFriendDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles addFriendDataList.ItemCommand
        Try
            If (e.CommandName = "IAddBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                Dim requestStatus As Integer = CheckRequest(userID2)
                If (requestStatus = 3) Then
                    sdBoarders.InsertParameters.Item("userID2").DefaultValue = userID2
                    sdBoarders.InsertParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                    sdBoarders.Insert()
                    GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                    LoadAllBoarders()
                    MultiViewFriendList.ActiveViewIndex = 1
                Else
                    If requestStatus = 0 Then
                        GlobalModule.SetMessage(lblMessageAddBoarder, False, "You have already send request")
                    ElseIf requestStatus = 1 Then
                        GlobalModule.SetMessage(lblMessageAddBoarder, False, "You are already friend")
                    Else
                        sdBoarders.UpdateParameters.Item("userID2").DefaultValue = userID2
                        sdBoarders.UpdateParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                        sdBoarders.Update()
                        GlobalModule.SetMessage(lblMessageAddBoarder, True, "Request Sent Successfully")
                        LoadAllBoarders()
                        MultiViewFriendList.ActiveViewIndex = 1
                    End If

                End If
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub removeFriendDataList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles removeFriendDataList.ItemCommand
        Try
            If (e.CommandName = "IRemoveBoarder") Then
                Dim userID2 As Int32 = Convert.ToInt32(e.CommandArgument())
                sdAllBoardersList.DeleteParameters.Item("userID2").DefaultValue = userID2
                sdAllBoardersList.DeleteParameters.Item("UserID1").DefaultValue = Convert.ToInt32(Session("UserID").ToString())
                sdAllBoardersList.Delete()
                GlobalModule.SetMessage(lblMessageAddBoarder, True, "Boarder Removed")
                LoadAllBoarders()
                MultiViewFriendList.ActiveViewIndex = 0
            End If
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Sending Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub

    Protected Sub ResetCss()
        Try
            mediaLinkLinkButton.Attributes.Add("style", "text-decoration:none")
            removeFriendLinkButton.Attributes.Add("style", "text-decoration:none")
            addFriendLinkButton.Attributes.Add("style", "text-decoration:none")
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub lbtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSearch.Click
        Try
            lblMessageAddBoarder.Text = ""
            Session("searchKeyWord") = searchBoardsTextBox.Text
            LoadAllBoarders()
        Catch ex As Exception
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)

        End Try
    End Sub


    Protected Sub btnSendEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendEmail.Click

        Try
            If Not txtSendMultipleEmail.Text = "" Then
                Dim emailList As String = txtSendMultipleEmail.Text
                If (GlobalModule.ValidateEmail(emailList)) Then
                    Dim list As New ArrayList()
                    list.AddRange(emailList.Split(New Char() {","c}))
                    SendRequest(list)
                Else
                    GlobalModule.SetMessage(lblMessageSendEmail, False, "Please Enter valid Emails")
                End If
            Else
                GlobalModule.SetMessage(lblMessageSendEmail, False, "Please enter Emails")
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
                Dim returnUrl As String = ConfigurationManager.AppSettings("site").ToString()
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
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub


    'Dim authUrl As WebAuthorizer
    '<System.Web.Services.WebMethod()>
    'Public Shared Sub sendTwitterInvite()
    '    Try

    '        Dim callback As New Uri("https://crowd-boarders.com/BoarderLineup.aspx/sendTwitterInvite")

    '        Dim credentials As IOAuthCredentials = New SessionStateCredentials()
    '        If credentials.ConsumerKey Is Nothing OrElse credentials.ConsumerSecret Is Nothing Then
    '            credentials.ConsumerKey = "IAqemeN4AH26EWIROvJZ01s9W"
    '            credentials.ConsumerSecret = "5AaGMDUQTBi09cldEV8lv9YMCKRCiuLyltgDiV2ajQoRCfjIvA"
    '        End If
    '        Dim auth = New WebAuthorizer() With {.Credentials = credentials, .PerformRedirect = Sub(authUrl) HttpContext.Current.Response.Redirect(authUrl)}
    '        If Not auth.IsAuthorized Then
    '            auth.CompleteAuthorization(callback)
    '        End If
    '        If String.IsNullOrWhiteSpace(credentials.ConsumerKey) OrElse String.IsNullOrWhiteSpace(credentials.ConsumerSecret) Then

    '        ElseIf Not auth.IsAuthorized Then
    '            auth.BeginAuthorization(HttpContext.Current.Request.Url)
    '            Dim twitterCtx = New TwitterContext(auth)
    '            Const dmCount As Integer = 3
    '            Dim directMessagesResults = From tweet In twitterCtx.DirectMessage Where tweet.Type = DirectMessageType.SentTo AndAlso tweet.Count = dmCount Select tweet
    '            Dim directMessages = directMessagesResults.ToList()
    '            For Each item In directMessages
    '                HttpContext.Current.Response.Write("<script>alert('" + item.ToString() + "')</script>")

    '                'Dim label As Label
    '                'label.Text = item.ToString()

    '            Next


    '        ElseIf auth.IsAuthorized Then
    '            Dim twitterCtx = New TwitterContext(auth)
    '            Const dmCount As Integer = 3
    '            Dim directMessagesResults = From tweet In twitterCtx.DirectMessage Where tweet.Type = DirectMessageType.SentTo AndAlso tweet.Count = dmCount Select tweet
    '            Dim directMessages = directMessagesResults.ToList()

    '            For Each item In directMessages
    '                HttpContext.Current.Response.Write("<script>alert('" + item.ToString() + "')</script>")



    '            Next
    '        End If
    '    Catch ex As Exception
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try

    'End Sub



    'Protected Sub twitterInvite_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles twitterInvite.Click
    '    Try
    '        ' sendTwitterInvite()

    '    Catch ex As Exception
    '        GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
    '        GlobalModule.ErrorLogFile(ex)
    '    End Try
    'End Sub


    Protected Sub yahooInvite_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles yahooInvite.Click
        Try

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
            GlobalModule.SetMessage(lblMessageAddBoarder, False, "Error in Request")
            GlobalModule.ErrorLogFile(ex)
        End Try
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
        sbRequestToken.AppendFormat("oauth_callback={0}", System.Web.HttpUtility.UrlEncode("" & System.Configuration.ConfigurationManager.AppSettings("yahooCallbackInviteFromLineup")))
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
            Dim authHeader As String = (Convert.ToString((Convert.ToString("Authorization: OAuth " + "realm=""yahooapis.com""" + ",oauth_consumer_key=""" + ConsumerKey + """" + ",oauth_nonce=""") & nonce) + """" + ",oauth_signature_method=""HMAC-SHA1""" + ",oauth_timestamp=""") & timeStamp) + """" + ",oauth_token=""" + OauthToken + """" + ",oauth_version=""1.0""" + ",oauth_signature=""" + HttpUtility.UrlEncode(sig) + """"

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
            'Response.Write(ex.Message);
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


    Private Sub RedirectUserForAuthorization(ByVal authorizationUrl As String)
        'Response.Redirect(authorizationUrl);
        RegisterStartupScript("openwin", (Convert.ToString("<script type='text/javascript'>window.open('") & authorizationUrl) + "','mywindow', 'left=250,top=50,menubar=0,resizable=0,location=1,toolbar=0,status=1,scrollbars=0,width=500,height=455');</script>")
    End Sub


    Protected Sub gooleInviteButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles gooleInviteButton.Click
        Try
            Session("googelInvite") = True
            'GoogleConnect.Authorize(Server.UrlEncode("https://www.google.com/m8/feeds/"))




            Dim para As New Google.GData.Client.OAuth2Parameters()

            'para.RedirectUri = "" + ConfigurationSettings.AppSettings["site"].ToString() + "/Wedding/ImportGmailStep2/";

            'GoogleConnect.ClientId =
            para.RedirectUri = ConfigurationManager.AppSettings("GCBc").ToString() 'WsLib.KP.GCBc
            para.ClientId = ConfigurationManager.AppSettings("GCId").ToString() 'WsLib.KP.GCId
            para.ClientSecret = ConfigurationManager.AppSettings("GCS").ToString() ' WsLib.KP.GCS
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



    Public Function GetContactsByCode(ByVal code As String) As List(Of String)
        '  Dim mglst As New List(Of MasterGuestList)()

        Dim para As New Google.GData.Client.OAuth2Parameters()


        para.RedirectUri = ConfigurationManager.AppSettings("GCBc").ToString() 'WsLib.KP.GCBc
        para.ClientId = ConfigurationManager.AppSettings("GCId").ToString() 'WsLib.KP.GCId
        para.ClientSecret = ConfigurationManager.AppSettings("GCS").ToString() ' WsLib.KP.GCS
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
                Dim img As Image
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


    Public Class GoogleContacts
        Public Property Feed() As Feed
            Get
                Return m_Feed
            End Get
            Set(ByVal value As Feed)
                m_Feed = value
            End Set
        End Property
        Private m_Feed As Feed
    End Class

    Public Class Feed
        Public Property Title() As GoogleTitle
            Get
                Return m_Title
            End Get
            Set(ByVal value As GoogleTitle)
                m_Title = value
            End Set
        End Property
        Private m_Title As GoogleTitle
        Public Property Entry() As List(Of Contact)
            Get
                Return m_Entry
            End Get
            Set(ByVal value As List(Of Contact))
                m_Entry = value
            End Set
        End Property
        Private m_Entry As List(Of Contact)
    End Class

    Public Class GoogleTitle
        Public Property T() As String
            Get
                Return m_T
            End Get
            Set(ByVal value As String)
                m_T = value
            End Set
        End Property
        Private m_T As String
    End Class

    Public Class Contact
        Public Property Title() As GoogleTitle
            Get
                Return m_Title
            End Get
            Set(ByVal value As GoogleTitle)
                m_Title = value
            End Set
        End Property
        Private m_Title As GoogleTitle
        Public Property GdEmail() As List(Of Email)
            Get
                Return m_GdEmail
            End Get
            Set(ByVal value As List(Of Email))
                m_GdEmail = value
            End Set
        End Property
        Private m_GdEmail As List(Of Email)
        Public Property Link() As List(Of Link)
            Get
                Return m_Link
            End Get
            Set(ByVal value As List(Of Link))
                m_Link = value
            End Set
        End Property
        Private m_Link As List(Of Link)
    End Class

    Public Class Email
        Public Property Address() As String
            Get
                Return m_Address
            End Get
            Set(ByVal value As String)
                m_Address = value
            End Set
        End Property
        Private m_Address As String
        Public Property Primary() As Boolean
            Get
                Return m_Primary
            End Get
            Set(ByVal value As Boolean)
                m_Primary = value
            End Set
        End Property
        Private m_Primary As Boolean
    End Class

    Public Class Link
        Public Property Rel() As String
            Get
                Return m_Rel
            End Get
            Set(ByVal value As String)
                m_Rel = value
            End Set
        End Property
        Private m_Rel As String
        Public Property Type() As String
            Get
                Return m_Type
            End Get
            Set(ByVal value As String)
                m_Type = value
            End Set
        End Property
        Private m_Type As String
        Public Property Href() As String
            Get
                Return m_Href
            End Get
            Set(ByVal value As String)
                m_Href = value
            End Set
        End Property
        Private m_Href As String
    End Class



    Public Function DownloadPhoto(ByVal img As Image, ByVal fileName As String) As String


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
   
End Class