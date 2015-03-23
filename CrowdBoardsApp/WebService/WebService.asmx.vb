Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
 Public Class WebService
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function CheckUserNameExists(ByVal userName As String) As Integer
        Dim sdsUserName As New SqlDataSource
        sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
        sdsUserName.SelectParameters.Add("UserName", userName)
        sdsUserName.SelectCommand = "Select * from [Users] WHERE UserName=@UserName"
        Dim dv As Data.DataView = CType(sdsUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If (dv.Count > 0) Then
                Return 1
            Else
                Return 0
            End If
        Else
            Return -1
        End If
    End Function

    <WebMethod()> _
    Public Function CheckEmailExists(ByVal emailAddress As String) As String

        Dim reg As String = "^((([\w]+\.[\w]+)+)|([\w]+))@(([\w]+\.)+)([A-Za-z]{1,3})$"

        If Not Regex.IsMatch(emailAddress, reg) Then
            Return "1"
        End If

        Dim sdsUserName As New SqlDataSource
        sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
        sdsUserName.SelectParameters.Add("emailAddress", emailAddress)
        sdsUserName.SelectCommand = "  Select * from [Users] WHERE email=@emailAddress"
        Dim dv As Data.DataView = CType(sdsUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If (dv.Count > 0) Then
                Return "2"
            Else
                Return "0"
            End If
        Else
            Return ""
        End If
    End Function
    <WebMethod()> _
    Public Function CheckEmailExistence(ByVal emailAddress As String, ByVal userID As String) As String

        Dim sdsUserName As New SqlDataSource
        sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
        sdsUserName.SelectParameters.Add("emailAddress", emailAddress)
        sdsUserName.SelectParameters.Add("userID", userID)
        sdsUserName.SelectCommand = "Select * from [Users] WHERE email=@emailAddress and UserID<>@userID"
        Dim dv As Data.DataView = CType(sdsUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If (dv.Count > 0) Then
                Return "2"
            Else
                Return "0"
            End If
        Else
            Return ""
        End If
    End Function


    <WebMethod()> _
    Public Function validateLogin(ByVal userName As String, ByVal password As String) As Integer
        Dim sdsUserName As New SqlDataSource

        If Membership.ValidateUser(userName, password) Then
            sdsUserName.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
            sdsUserName.SelectParameters.Add("UserName", userName)
            sdsUserName.SelectCommand = "Select * from [Users] WHERE UserName=@UserName"
            Dim dv As Data.DataView = CType(sdsUserName.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If (dv.Count > 0) Then
                    If dv(0)("Status") = True Then
                        Return 1
                    Else
                        Return 2
                    End If
                Else
                    Return 0
                End If
            Else
                Return -1
            End If

        End If
    End Function
    <WebMethod()> _
    Public Function CheckBoarderStatus(ByVal userName As String) As Integer
        Dim isBoarder As Integer = 0
        Try
            Dim userRolesList() As String = Roles.GetRolesForUser(userName)
            If userRolesList.Length > 0 Then
                For Each item As String In userRolesList
                    If (item = "Boarder") Then
                        isBoarder = 1
                        Exit For
                    End If
                Next
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return isBoarder
    End Function
    <WebMethod()> _
    Public Function ForwardMessage(ByVal fromUser As Integer, ByVal toUser As String, ByVal messageID As Integer) As Integer
        Dim sdsMessage As New SqlDataSource
        Dim result As Integer = 0
        Try
            sdsMessage.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
            sdsMessage.SelectParameters.Add("MessageID", messageID)
            sdsMessage.SelectCommand = "SELECT MessageID,DateSent,Text,Unread,FromUser,ToUser,FileName,substring(FileName,CHARINDEX('+-',filename)+2,LEN(filename)) as FileText FROM Messages WHERE MessageID=@MessageID"
            Dim dv As Data.DataView = CType(sdsMessage.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not dv Is Nothing Then
                If dv.Count > 0 Then
                    If Not IsDBNull(dv(0)("FileText")) Then
                        Dim textMessage As String = String.Empty
                        If Not IsDBNull(dv(0)("Text")) Then
                            textMessage = dv(0)("Text")
                        End If
                        Dim sourcePath As String = "~/Upload/MessageFiles" & "\\" & dv(0)("FileName")
                        Dim newFileName As String = GetNewFileName(dv(0)("FileText"), textMessage, GetUserID(toUser), fromUser)
                        If newFileName <> "" Then
                            Dim destinationPath As String = "~/Upload/MessageFiles" & "\\" & newFileName
                            My.Computer.FileSystem.CopyFile(Server.MapPath(sourcePath), Server.MapPath(destinationPath), Microsoft.VisualBasic.FileIO.UIOption.OnlyErrorDialogs, FileIO.UICancelOption.DoNothing)
                            result = 1
                        End If
                    Else
                        Dim messageText As String = String.Empty
                        If Not IsDBNull(dv(0)("Text")) Then
                            messageText = dv(0)("Text")
                        End If
                        If (SendMessage(GetUserID(toUser), messageText, fromUser) = 1) Then
                            result = 1
                        End If
                    End If
                    SendUserEmail(toUser)

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function


    Protected Function GetNewFileName(ByVal oldFileName As String, ByVal Text As String, ByVal ToUser As String, ByVal fromUser As String) As String
        Dim fileName As String = String.Empty
        Dim sdsMessageFiles As New SqlDataSource
        Try
            sdsMessageFiles.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
            sdsMessageFiles.SelectParameters.Add("FileName", oldFileName)
            sdsMessageFiles.SelectParameters.Add("FromUser", fromUser)
            sdsMessageFiles.SelectParameters.Add("ToUser", ToUser)
            sdsMessageFiles.SelectParameters.Add("Text", IIf(Text = String.Empty, "#", Text))
            sdsMessageFiles.SelectParameters.Add("Unread", True)
            sdsMessageFiles.SelectCommand = "messagesInsert"
            sdsMessageFiles.SelectCommandType = SqlDataSourceCommandType.StoredProcedure
            Dim dv As Data.DataView = CType(sdsMessageFiles.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If Not (dv) Is Nothing Then
                If dv.Count > 0 Then
                    If (Not IsDBNull(dv(0)("fileName"))) Then
                        fileName = dv(0)("fileName")
                    Else
                        fileName = ""
                    End If
                End If
            Else
                fileName = ""
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return fileName
    End Function
    Protected Function SendMessage(ByVal toUser As String, ByVal Text As String, ByVal fromUser As String) As Integer
        Dim sdMessages As New SqlDataSource
        Dim result As Integer
        Try
            sdMessages.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
            sdMessages.InsertParameters.Add("ToUser", toUser)
            sdMessages.InsertParameters.Add("FromUser", fromUser)
            sdMessages.InsertParameters.Add("Text", Text)
            sdMessages.InsertParameters.Add("Unread", True)
            sdMessages.InsertCommand = "INSERT INTO Messages(FromUser,ToUser,DateSent,Text,Unread) VALUES(@FromUser,@ToUser,getdate(),@Text,@Unread)"
            result = sdMessages.Insert()
        Catch ex As Exception
            Throw ex
        End Try
        Return result
    End Function
    Protected Function GetUserID(ByVal UserName As String) As Integer
        Dim userID As Integer
        Dim sdGetUserId As New SqlDataSource
        Try
            sdGetUserId.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
            sdGetUserId.SelectParameters.Add("UserName", UserName)
            sdGetUserId.SelectCommand = "select UserID from Users Where UserName=@UserName"
            Dim dv As Data.DataView = CType(sdGetUserId.Select(DataSourceSelectArguments.Empty), Data.DataView)
            If (dv.Count > 0) Then
                If (Not IsDBNull(dv(0)("UserID"))) Then
                    userID = dv(0)("UserID")
                End If
            Else
                Return 0
                Exit Function
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return userID
    End Function


    Private Sub SendUserEmail(ByVal UserName As String)
        Dim sdsUserEmail As New SqlDataSource
        sdsUserEmail.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("CrowdBoardsConnectionString").ToString()
        sdsUserEmail.SelectParameters.Add("UserName", UserName)
        sdsUserEmail.SelectCommand = "SELECT Email as userEmail from Users Where UserName=@UserName"
        Dim dv As Data.DataView = CType(sdsUserEmail.Select(DataSourceSelectArguments.Empty), Data.DataView)
        If Not (dv) Is Nothing Then
            If dv.Count > 0 Then
                If (Not IsDBNull(dv(0)("userEmail"))) Then
                    If (Not dv(0)("userEmail") = "") Then
                        GlobalModule.SendEmail(dv(0)("userEmail"), "You Have a Message!", "A fellow CrowdBoarder has sent you a message. Login to see what they said:<a href=" + System.Configuration.ConfigurationManager.AppSettings("site") + "> " + System.Configuration.ConfigurationManager.AppSettings("site") + "</a>", True)
                    End If
                End If
            End If
        End If
    End Sub


End Class