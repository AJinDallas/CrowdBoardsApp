Imports System.Net
Imports System.Net.Mail
Imports System.IO
Partial Class sendMail
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim fromEmail As String = "" & Request.Form("contact[email]")
        Dim subject As String = ""
        If fromEmail <> "" Then
            subject = "New person for the interest list!"
        Else
            Response.Redirect("~/email.html")
        End If

        Dim body As String = "Email: " & fromEmail & "<br><br>Thanks"
        Try
            Dim adminEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("adminEmail")
            SendEmail(adminEmail, subject, body, True)
            Response.Redirect("~/video.html")
        Catch ex As Exception
            Response.Write(ex.Message.ToString())
        End Try
    End Sub
    Public Shared Sub SendEmail(ByVal ToAddress As String, ByVal emailsubject As String, ByVal body As String, ByVal isBodyHTML As Boolean)
        If "" & System.Configuration.ConfigurationManager.AppSettings("testmode") = "1" Then
            SendGmail(ToAddress, emailsubject, body, isBodyHTML)
        Else
            SendMail(ToAddress, "", emailsubject, body)
        End If

    End Sub

    Public Shared Sub SendMail(ByVal ToAddress As String, ByVal FromAddress As String, ByVal emailsubject As String, ByVal body As String)
        Try

            Dim userName As String = "" & System.Configuration.ConfigurationManager.AppSettings("userName")
            Dim password As String = "" & System.Configuration.ConfigurationManager.AppSettings("password")
            Dim mailFrom As String = "" & System.Configuration.ConfigurationManager.AppSettings("mailFrom")
            Dim bccAddress As String = "" & System.Configuration.ConfigurationManager.AppSettings("bccAddress")
            Dim ccAddress As String = "" & System.Configuration.ConfigurationManager.AppSettings("ccAddress")
            Dim smtpServer As String = "" & System.Configuration.ConfigurationManager.AppSettings("smtpServer")

            Dim userCredential As String = Nothing
            ToAddress = ToAddress.Trim()
            Dim smtpc As New SmtpClient()
            smtpc.UseDefaultCredentials = False
          

            ' The following will be able to send to anyone outside the domain.
            smtpc.Credentials = New NetworkCredential(userName, password)
            Dim Mail_Msg As New MailMessage()

            If ccAddress.Trim() <> "" Then
                Dim ccAddresses As String() = ccAddress.Split(","c)
                If ccAddresses.Length > 0 Then
                    For i As Integer = 0 To ccAddresses.Length - 1
                        Mail_Msg.CC.Add("" & ccAddresses(i))
                    Next
                End If
            End If

            If bccAddress.Trim() <> "" Then
                Dim bccAddresses As String() = bccAddress.Split(","c)
                If bccAddresses.Length > 0 Then
                    For i As Integer = 0 To bccAddresses.Length - 1
                        Mail_Msg.Bcc.Add("" & bccAddresses(i))
                    Next
                End If
            End If

            Dim Mail_FromAddress As New MailAddress(mailFrom)
            Mail_Msg.From = Mail_FromAddress
            Mail_Msg.[To].Add(ToAddress)
            smtpc.DeliveryMethod = SmtpDeliveryMethod.Network
            Mail_Msg.Subject = emailsubject
            Mail_Msg.Body = body
            Mail_Msg.IsBodyHtml = True
            smtpc.Host = smtpServer
            smtpc.Send(Mail_Msg)
        Catch ex As Exception

        End Try


    End Sub
    Public Shared Sub SendGmail(ByVal mailTo As String, ByVal subject As String, ByVal message As String, ByVal isBodyHtml As Boolean)
        Dim commaDelimCCs As String = ""
        Dim userName As String = "" + System.Configuration.ConfigurationManager.AppSettings("userName")
        Dim password As String = "" + System.Configuration.ConfigurationManager.AppSettings("password")
        Dim mailFrom As String = "" + System.Configuration.ConfigurationManager.AppSettings("mailFrom")
        ' string mailTo = "" + System.Configuration.ConfigurationManager.AppSettings["mailTo"];
        Dim bccAddress As String = "" + System.Configuration.ConfigurationManager.AppSettings("bccAddress")
        Dim msg As New System.Net.Mail.MailMessage(mailFrom, mailTo, subject, message)
        msg.IsBodyHtml = isBodyHtml
        If commaDelimCCs <> "" Then
            msg.CC.Add(commaDelimCCs)
        End If
        If bccAddress.Trim() <> "" Then
            Dim bccAddresses As String() = bccAddress.Split(","c)
            If bccAddresses.Length > 0 Then
                For i As Integer = 0 To bccAddresses.Length - 1
                    msg.Bcc.Add("" & bccAddresses(i))
                Next
            End If
        End If
        Dim cred As New System.Net.NetworkCredential(userName, password)
        Dim mailClient As New System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
        mailClient.EnableSsl = True
        mailClient.UseDefaultCredentials = False
        mailClient.Credentials = cred
        Try
            mailClient.Send(msg)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class
