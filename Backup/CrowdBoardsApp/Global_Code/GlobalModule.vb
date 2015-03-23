Imports System.Net
Imports System.Net.Mail
Imports System.IO
Imports Telerik.Web.UI
Imports System.Drawing
Public Class GlobalModule

    Private Shared successCssClass As String = "alert-success"
    Private Shared failedCssClass As String = "alert-fail"
    Public Shared Sub RedirectToHttps()
        Try
            Dim httpsUrlSet As String = "" & System.Configuration.ConfigurationManager.AppSettings("httpsUrlSet")
            Dim xredir__ As String = String.Empty
            Dim xqstr__ As String = String.Empty
            Dim strRedi As String = String.Empty
            If (httpsUrlSet = "1") Then
                If (HttpContext.Current.Request.ServerVariables("HTTPS") = "off") Then
                    xredir__ = "https://" & HttpContext.Current.Request.ServerVariables("SERVER_NAME") & _
                               HttpContext.Current.Request.ServerVariables("SCRIPT_NAME")
                    xqstr__ = HttpContext.Current.Request.ServerVariables("QUERY_STRING")

                    If xqstr__ <> "" Then xredir__ = xredir__ & "?" & xqstr__
                    If (xredir__.ToLower().Contains("www.")) Then
                        strRedi = xredir__.Replace("www.", "")
                        xredir__ = strRedi
                    End If

                    HttpContext.Current.Response.Redirect(xredir__, False)
                Else
                    xredir__ = "https://" & HttpContext.Current.Request.ServerVariables("SERVER_NAME") & _
                               HttpContext.Current.Request.ServerVariables("SCRIPT_NAME")
                    xqstr__ = HttpContext.Current.Request.ServerVariables("QUERY_STRING")

                    If xqstr__ <> "" Then xredir__ = xredir__ & "?" & xqstr__
                    If (xredir__.ToLower().Contains("www.")) Then
                        strRedi = xredir__.Replace("www.", "")
                        xredir__ = strRedi
                        HttpContext.Current.Response.Redirect(xredir__, False)
                    End If
                End If
               

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Shared Function ValidateEmail(ByVal emailToValidate As String) As Boolean
        Dim strMessage As String = ""
        Dim regex As Regex = New Regex("([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\." + _
        ")|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})", _
        RegexOptions.IgnoreCase _
        Or RegexOptions.CultureInvariant _
        Or RegexOptions.IgnorePatternWhitespace _
        Or RegexOptions.Compiled _
        )
        Dim emails() As String = Split(emailToValidate, ",")
        For Each item As String In emails
            Dim IsMatch As Boolean = regex.IsMatch(item)
            If IsMatch = False Then
                Return False
                Exit For
            End If
        Next
        Return True
    End Function
    Public Shared Sub ErrorLogFile(ByVal appException As Exception)
        If "" & System.Configuration.ConfigurationManager.AppSettings("errorLogBy") = "WriteLog" Then
            WriteLog(appException)
        ElseIf "" & System.Configuration.ConfigurationManager.AppSettings("errorLogBy") = "SendMail" Then
            Dim adminEmail As String = "" & System.Configuration.ConfigurationManager.AppSettings("devEmail")
            Dim exceptionSubject = "" & System.Configuration.ConfigurationManager.AppSettings("subject")

            SendEmail(adminEmail, "CB Exception " & System.DateTime.Now.ToString(), appException.ToString(), False)
        End If
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
            Dim smtpServer As String = "" & System.Configuration.ConfigurationManager.AppSettings("smtpServer")

            Dim userCredential As String = Nothing
            ToAddress = ToAddress.Trim()
            Dim smtpc As New SmtpClient()
            smtpc.UseDefaultCredentials = False
            ' The following will be able to send to anyone outside the domain.
            smtpc.Credentials = New NetworkCredential(userName, password)
            Dim Mail_Msg As New MailMessage()
            Dim Mail_FromAddress As New MailAddress(mailFrom)
            Mail_Msg.From = Mail_FromAddress
            Mail_Msg.[To].Add(ToAddress)
            If bccAddress.Trim() <> "" Then
                Dim bccAddresses As String() = bccAddress.Split(","c)
                If bccAddresses.Length > 0 Then
                    For i As Integer = 0 To bccAddresses.Length - 1
                        Mail_Msg.Bcc.Add("" & bccAddresses(i))
                    Next
                End If
            End If
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
#Region "Method ErrorLogFile"
    Public Shared Sub WriteLog(ByVal appException As Exception)
        Try
            Dim fileName As String = "ErrorLog_" & System.DateTime.Now.[Date].ToShortDateString()
            fileName = fileName.Replace("/", "-")
            Dim fileExtension As String = "txt"
            Dim contents As String = vbCr & vbLf & System.DateTime.Now.ToString() & vbCr & vbLf & appException.ToString()
            Dim filePath As String = HttpContext.Current.Server.MapPath("~/ErrorLog") + "\" + fileName + "." + fileExtension
            Dim fs As FileStream
            If File.Exists(filePath) Then
                fs = New FileStream(filePath, FileMode.Append, FileAccess.Write)
            Else
                fs = New FileStream(filePath, FileMode.Create, FileAccess.Write)
            End If
            Dim sw As New StreamWriter(fs)
            sw.Write(contents)
            sw.Flush()
            sw.Close()
            fs.Close()
        Catch exx As Exception
            Throw exx
        End Try

    End Sub
#End Region
    Public Shared Function GetAdress(ByVal strJobStreetAddress As String, ByVal strJobCity As String, ByVal strJobState As String, ByVal strCountry As String) As String
        Dim strAdress As String = strJobStreetAddress
        Try

            If Not (String.IsNullOrEmpty(strAdress)) Then
                strAdress += " " + strJobCity
            Else
                strAdress = strJobCity
            End If

            If Not (String.IsNullOrEmpty(strAdress)) Then
                strAdress += "," + strJobState
            Else
                strAdress = strJobState
            End If
            If Not (String.IsNullOrEmpty(strAdress)) Then
                strAdress += " " + strCountry
            Else
                strAdress = strCountry
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return strAdress
    End Function

    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String
        Dim fileName As String = fileNameObject.ToString()
        Try
            If (fileName = "") Then
                Return ""
            End If
            Dim iPath As String = Path.Combine(HttpContext.Current.Server.MapPath(FilePath), fileName)
            If Not System.IO.File.Exists(iPath) Then
                fileName = "noimage.jpg"
                iPath = Path.Combine(HttpContext.Current.Server.MapPath(FilePath), fileName)
            End If

            Dim NewPath As String = Path.Combine(HttpContext.Current.Server.MapPath(thumbsFilePath), fileName)
            If Not System.IO.File.Exists(NewPath) Then
                Using img As Bitmap = New Bitmap(iPath)
                    Dim OriginalSize As Size = img.Size
                    Dim NewSize As Size
                    NewSize.Height = desiredHeight 'Maximum desired height
                    NewSize.Width = desiredWidth 'Maximum desired width
                    Dim FinalSize As Size = ProportionalSize(OriginalSize, NewSize)
                    Using img2 As Bitmap = img.GetThumbnailImage(FinalSize.Width, FinalSize.Height, New Bitmap.GetThumbnailImageAbort(AddressOf Abort), IntPtr.Zero)
                        img2.Save(NewPath)
                    End Using
                End Using
            End If

        Catch ex As Exception
            'GlobalModule.ErrorLogFile(ex)
        End Try
        Return thumbsFilePath & "/" & HttpUtility.UrlPathEncode(fileName)
    End Function
    Function ProportionalSize(ByVal imageSize As Size, ByVal MaxW_MaxH As Size) As Size
        Try
            Dim ratio = Math.Max(imageSize.Width / MaxW_MaxH.Width, imageSize.Height / MaxW_MaxH.Height)
            imageSize.Width = CInt(imageSize.Width / ratio)
            imageSize.Height = CInt(imageSize.Height / ratio)
            Return imageSize
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Function Abort() As Boolean
        Return False
    End Function



    Public Shared Sub SetMessage(ByVal label As Label, ByVal isSuccess As Boolean, ByVal message As String)
        Try
            label.Visible = True
            label.CssClass = If(isSuccess, GlobalModule.successCssClass, GlobalModule.failedCssClass)
            label.Text = message
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Shared Sub SetMessage(ByVal label As Label, ByVal isSuccess As Boolean, ByVal message As String, ByVal divControl As HtmlGenericControl)
        Try
            divControl.Visible = True
            divControl.Attributes.Add("class", If(isSuccess, GlobalModule.successCssClass, GlobalModule.failedCssClass))
            label.Text = message
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Function GetAmountAccordingToLocation(ByVal amount As String, ByVal location As String) As String
        Dim res As String = String.Empty
        Try
            If (location = "UK") Then
                res = String.Format(System.Globalization.CultureInfo.GetCultureInfo("en-GB").NumberFormat, "{0:c0}", Convert.ToDouble(amount))
            Else
                res = String.Format(System.Globalization.CultureInfo.GetCultureInfo("en-US").NumberFormat, "{0:c0}", Convert.ToDouble(amount))
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return res
    End Function

    Public Function GetAmountAccordingToLocationForAPICall(ByVal amount As String, ByVal location As String) As String
        Dim res As String = String.Empty
        Try
            If (location = "UK") Then

                res = "£" & Convert.ToDecimal(amount).ToString("c").Replace("$", "")
            Else
                res = Convert.ToDecimal(amount).ToString("c")
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return res
    End Function

End Class
