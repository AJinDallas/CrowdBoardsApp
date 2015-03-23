Imports ASPSnippets.FaceBookAPI
Imports System.Web.Script.Serialization
Imports System.Web.Security
Imports System.Collections.Generic
Imports Facebook

Public Class Success
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        lblMessage.Text = ""
        If Request.QueryString("code") IsNot Nothing Then
            Session("Code") = Request.QueryString("code")
        End If
        If Not Session("IsFbShare") Is Nothing Then
            If Session("IsFbShare").ToString().Contains("FromBoard") Then
                FacebookShareFromBoard(Session("IsFbShare").ToString())
            Else
                FacebookShare(Session("IsFbShare").ToString())
            End If

        Else
            RegisterFacebookUser()
        End If
    End Sub
    Protected Sub RegisterFacebookUser()
        Try
            Dim code As String = Request.QueryString("code")
            If Not String.IsNullOrEmpty(code) Then

                Dim fb = New FacebookClient()
                Dim result = fb.Post("oauth/access_token", New With { _
                 Key .client_id = "" & System.Configuration.ConfigurationManager.AppSettings("appID"), _
                 Key .client_secret = "" & System.Configuration.ConfigurationManager.AppSettings("secretKey"), _
                 Key .redirect_uri = System.Configuration.ConfigurationManager.AppSettings("returnURL"), _
                 Key .code = code _
                })
                Dim accessToken = result.access_token
                fb.AccessToken = accessToken
                ' Get the user's information
                Dim data = fb.[Get]("me")

                '  Dim faceBookUser As RootObject = JsonConvert.DeserializeObject(Of RootObject)(data)
                '  Dim result1 As obJson = JsonConvert.DeserializeObject(Of obJson)(data.ToString())

                Dim faceBookUser As FacebookUser = New JavaScriptSerializer().Deserialize(Of FacebookUser)(data.ToString())


                ' Dim data As String = FaceBookConnect.Fetch(code, "me")
                'Dim faceBookUser As FacebookUser = New JavaScriptSerializer().Deserialize(Of FacebookUser)(data)
                sdUsers.SelectParameters.Item("FacebookUserID").DefaultValue = faceBookUser.Id
                Dim dv As DataView = CType(sdUsers.Select(DataSourceSelectArguments.Empty), DataView)


                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("status"))) Then
                        If dv(0)("status").ToString().ToLower() = "notexist" Then

                            If Not (Session("returnURL")) Is Nothing Then
                                If Not (Session("returnURL") = "") Then
                                    Response.Redirect("~/InvestSignup.aspx?FacebookId=" & faceBookUser.Id & "&FirstName=" & faceBookUser.First_Name & "&LastName=" & faceBookUser.Last_Name & "&Email=" & faceBookUser.Email, False)
                                Else
                                    Response.Redirect("~/Default.aspx?FacebookId=" & faceBookUser.Id & "&FirstName=" & faceBookUser.First_Name & "&LastName=" & faceBookUser.Last_Name & "&Email=" & faceBookUser.Email, False)
                                End If
                            Else
                                Response.Redirect("~/Default.aspx?FacebookId=" & faceBookUser.Id & "&FirstName=" & faceBookUser.First_Name & "&LastName=" & faceBookUser.Last_Name & "&Email=" & faceBookUser.Email, False)
                            End If
                        Else
                            If dv(0)("userStatus") = True Then
                                sdUsers.UpdateParameters.Item("UserName").DefaultValue = dv(0)("UserName")
                                sdUsers.Update()
                                If (Not IsDBNull(dv(0)("DateLastLoggedIn"))) Then
                                    Session("DateLastLoggedIn") = dv(0)("DateLastLoggedIn")
                                Else
                                    Session("DateLastLoggedIn") = System.DateTime.Now
                                End If

                                Session("userName") = dv(0)("UserName")
                                Session("UserID") = dv(0)("status")
                                If Not (Session("returnURL")) Is Nothing Then
                                    If Not (Session("returnURL") = "") Then
                                        Dim returnURL As String = System.Configuration.ConfigurationManager.AppSettings("site")
                                        Response.Redirect(returnURL + "/" + Session("returnURL").ToString() & "#investDiv", False)
                                    Else
                                        Response.Redirect("~/Home.aspx", False)
                                    End If
                                Else
                                    Response.Redirect("~/Home.aspx", False)
                                End If
                                ' Response.Redirect("~/Home.aspx", False)
                            Else
                                lblMessage.Text = "Your Account has been Deactivated.Please contact Administrator to Reactivate your Account"
                                lblMessage.ForeColor = Drawing.Color.Red
                            End If
                        End If
                    End If
                End If
            Else
                Response.Redirect("~/Default.aspx", False)
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub UpdateUserProfile(ByVal UserName As String, ByVal FirstName As String, ByVal LastName As String, ByVal Email As String, ByVal id As String)
        Try
            sdUsers.InsertParameters.Item("UserName").DefaultValue = UserName
            sdUsers.InsertParameters.Item("FirstName").DefaultValue = FirstName
            sdUsers.InsertParameters.Item("LastName").DefaultValue = LastName
            sdUsers.InsertParameters.Item("Email").DefaultValue = Email
            sdUsers.InsertParameters.Item("FacebookUserID").DefaultValue = id
            Dim ReferalURL As String = ""
            Dim ReferalValue As String = ""
            Dim ReferalUserID As Integer = 0
            If Not (Session("returnURL")) Is Nothing Then
                ReferalValue = Session("returnURL")
            End If
            If Not (Session("uID")) Is Nothing Then

                ReferalUserID = Session("uID")
            End If
            sdUsers.InsertParameters.Item("ReferalValue").DefaultValue = ReferalValue
            sdUsers.InsertParameters.Item("ReferalUserID").DefaultValue = ReferalUserID
            sdUsers.Insert()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Try
            sdGetUserIdDataSource.SelectParameters.Item("UserName").DefaultValue = UserName
            Dim dv As Data.DataView = CType(sdGetUserIdDataSource.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    userID = dv(0)("UserID")
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function
    Protected Sub FacebookShare(ByVal postID As String)

        Dim text As String = String.Empty
        Dim attachedFileName As String = String.Empty
        sdUserPosts.SelectParameters.Item("PostID").DefaultValue = postID
        Dim dv As Data.DataView = CType(sdUserPosts.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not dv Is Nothing Then
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("Text"))) Then
                    text = dv(0)("Text")
                End If
                If (Not IsDBNull(dv(0)("AttachedFileName"))) Then
                    attachedFileName = dv(0)("AttachedFileName")
                End If
                SharePost(text, attachedFileName)
            End If
        End If

    End Sub
    Protected Sub FacebookShareFromBoard(ByVal content As String)
        Try
            Dim callbackUrl As String = String.Empty
            Dim textToShare As String = String.Empty
            Dim link As String = String.Empty
            Dim list As New ArrayList()
            Dim directoryName As String = String.Empty
            list.AddRange(content.Split(New Char() {","c}))
            If (list.Count > 0) Then
                callbackUrl = list(0).ToString()
                textToShare = list(1).ToString()
                link = list(2).ToString()
                directoryName = list(3).ToString().Replace("FromBoard=", "").Trim()
            End If
            Dim data As Dictionary(Of String, String) = New Dictionary(Of String, String)
            data.Add("link", link)
            Dim picturePath As String = Server.MapPath("~/thumbs/" & directoryName & ".jpg")
            If System.IO.File.Exists(picturePath) Then
                data.Add("picture", ConfigurationManager.AppSettings("site") & "/thumbs/" & directoryName & ".jpg")
            Else
                data.Add("picture", ConfigurationManager.AppSettings("site") & "/Images/blankBoardImage.png")
            End If

            data.Add("caption", directoryName.ToUpper().Replace("-", " "))
            data.Add("name", directoryName.ToUpper().Replace("-", " "))
            data.Add("message", textToShare)

            FaceBookConnect.Post(Session("Code").ToString(), "me/feed", data)
            Session("IsFbShare") = Nothing
            Response.Redirect(callbackUrl, False)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Protected Sub SharePost(ByVal text As String, ByVal attachedFileName As String)
        Dim imageUrl As String = String.Empty
        Dim data As New Dictionary(Of String, String)()

        Try
            If attachedFileName <> "" Then
                imageUrl = Server.MapPath("~\Upload\UserPostsFiles\" & attachedFileName)
                data.Add("link", imageUrl)
                data.Add("picture", imageUrl)
                data.Add("message", text)
            Else
                data.Add("message", text)
            End If
            FaceBookConnect.Post(Session("Code").ToString(), "me/feed", data)
            SaveBoostEntry()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub SaveBoostEntry()
        Try
            sdFacebookBoost.SelectParameters.Item("UserID").DefaultValue = Session("UserID")
            sdFacebookBoost.SelectParameters.Item("PostID").DefaultValue = Session("IsFbShare").ToString()
            Dim dv As Data.DataView = CType(sdFacebookBoost.Select(DataSourceSelectArguments.Empty), Data.DataView)
            Session("IsFbShare") = Nothing
            Response.Redirect("~/Home.aspx", False)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Class School
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Year
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Education
        Public Property school() As School
            Get
                Return m_school
            End Get
            Set(ByVal value As School)
                m_school = value
            End Set
        End Property
        Private m_school As School
        Public Property type() As String
            Get
                Return m_type
            End Get
            Set(ByVal value As String)
                m_type = value
            End Set
        End Property
        Private m_type As String
        Public Property year() As Year
            Get
                Return m_year
            End Get
            Set(ByVal value As Year)
                m_year = value
            End Set
        End Property
        Private m_year As Year
    End Class

    Public Class Hometown
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Location
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Employer
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Position
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
    End Class

    Public Class Work
        Public Property description() As String
            Get
                Return m_description
            End Get
            Set(ByVal value As String)
                m_description = value
            End Set
        End Property
        Private m_description As String
        Public Property employer() As Employer
            Get
                Return m_employer
            End Get
            Set(ByVal value As Employer)
                m_employer = value
            End Set
        End Property
        Private m_employer As Employer
        Public Property position() As Position
            Get
                Return m_position
            End Get
            Set(ByVal value As Position)
                m_position = value
            End Set
        End Property
        Private m_position As Position
        Public Property start_date() As String
            Get
                Return m_start_date
            End Get
            Set(ByVal value As String)
                m_start_date = value
            End Set
        End Property
        Private m_start_date As String
    End Class

    Public Class RootObject
        Public Property id() As String
            Get
                Return m_id
            End Get
            Set(ByVal value As String)
                m_id = value
            End Set
        End Property
        Private m_id As String
        Public Property education() As List(Of Education)
            Get
                Return m_education
            End Get
            Set(ByVal value As List(Of Education))
                m_education = value
            End Set
        End Property
        Private m_education As List(Of Education)
        Public Property email() As String
            Get
                Return m_email
            End Get
            Set(ByVal value As String)
                m_email = value
            End Set
        End Property
        Private m_email As String
        Public Property first_name() As String
            Get
                Return m_first_name
            End Get
            Set(ByVal value As String)
                m_first_name = value
            End Set
        End Property
        Private m_first_name As String
        Public Property gender() As String
            Get
                Return m_gender
            End Get
            Set(ByVal value As String)
                m_gender = value
            End Set
        End Property
        Private m_gender As String
        Public Property hometown() As Hometown
            Get
                Return m_hometown
            End Get
            Set(ByVal value As Hometown)
                m_hometown = value
            End Set
        End Property
        Private m_hometown As Hometown
        Public Property last_name() As String
            Get
                Return m_last_name
            End Get
            Set(ByVal value As String)
                m_last_name = value
            End Set
        End Property
        Private m_last_name As String
        Public Property link() As String
            Get
                Return m_link
            End Get
            Set(ByVal value As String)
                m_link = value
            End Set
        End Property
        Private m_link As String
        Public Property location() As Location
            Get
                Return m_location
            End Get
            Set(ByVal value As Location)
                m_location = value
            End Set
        End Property
        Private m_location As Location
        Public Property locale() As String
            Get
                Return m_locale
            End Get
            Set(ByVal value As String)
                m_locale = value
            End Set
        End Property
        Private m_locale As String
        Public Property name() As String
            Get
                Return m_name
            End Get
            Set(ByVal value As String)
                m_name = value
            End Set
        End Property
        Private m_name As String
        Public Property timezone() As Double
            Get
                Return m_timezone
            End Get
            Set(ByVal value As Double)
                m_timezone = value
            End Set
        End Property
        Private m_timezone As Double
        Public Property updated_time() As String
            Get
                Return m_updated_time
            End Get
            Set(ByVal value As String)
                m_updated_time = value
            End Set
        End Property
        Private m_updated_time As String
        Public Property username() As String
            Get
                Return m_username
            End Get
            Set(ByVal value As String)
                m_username = value
            End Set
        End Property
        Private m_username As String
        Public Property verified() As Boolean
            Get
                Return m_verified
            End Get
            Set(ByVal value As Boolean)
                m_verified = value
            End Set
        End Property
        Private m_verified As Boolean
        Public Property work() As List(Of Work)
            Get
                Return m_work
            End Get
            Set(ByVal value As List(Of Work))
                m_work = value
            End Set
        End Property
        Private m_work As List(Of Work)
    End Class

    Public Class obJson
        Public Property searchResults() As List(Of RootObject)
            Get
                Return m_searchResults
            End Get
            Set(ByVal value As List(Of RootObject))
                m_searchResults = value
            End Set
        End Property
        Private m_searchResults As List(Of RootObject)
    End Class
End Class