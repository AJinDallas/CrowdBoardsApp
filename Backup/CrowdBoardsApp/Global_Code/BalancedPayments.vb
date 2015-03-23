Imports System.Net
Imports System.IO
Imports System.Configuration
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Public Class BalancedPayments
    Public Shared key As String = "" & ConfigurationManager.AppSettings("ApiKey")
    Public Shared apiMarketplace As String = "" & ConfigurationManager.AppSettings("ApiMarketplace")
    Public Shared balancedMerchantAccountID As String = "" & ConfigurationManager.AppSettings("balancedMerchantAccountID")

    Public Shared Function CreateCustomer(ByVal name As String, ByVal email As String) As String

        Try
            Dim result As String = ""
            Dim customerUri As String = ""
            Dim id As String = ""
            Dim url As String = "https://api.balancedpayments.com/v1/customers"
            Dim data As String = "{""name"":""" & name & """,""email"":""" & email & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "id" Then
                    id = item.Value
                ElseIf item.Name = "uri" Then
                    customerUri = item.Value
                End If
            Next
            If id.Length > 0 Then
                result = "succeeded"
            Else
                result = "error"
            End If
            If result = "succeeded" Then
                Return result & "," & customerUri & "," & id
            Else
                Return result
            End If

            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function AddingCardToCustomer(ByVal customerID As String, ByVal card_uri As String) As String
        Try
            Dim result As String = ""
            Dim uri As String = ""

            Dim url As String = "https://api.balancedpayments.com/v1/customers/" & customerID
            Dim data As String = "{""card_uri"":""" & card_uri & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "PUT"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "uri" Then
                    uri = item.Value
                End If
            Next
            If uri.Length > 0 Then
                result = "succeeded"
            Else
                result = "error"
            End If

            If result = "succeeded" Then
                Return result & "," & uri
            Else
                Return result
            End If
            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function AddingAccountToCustomer(ByVal customerID As String, ByVal bank_account_uri As String) As String
        Try
            Dim result As String = ""
            Dim uri As String = ""
            Dim url As String = "https://api.balancedpayments.com/v1/customers/" & customerID
            Dim data As String = "{""bank_account_uri"":""" & bank_account_uri & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "PUT"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "uri" Then
                    uri = item.Value
                End If
            Next
            If uri.Length > 0 Then
                result = "succeeded"
            Else
                result = "error"
            End If

            If result = "succeeded" Then
                Return result & "," & uri
            Else
                Return result
            End If

            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function CreateNewDebit(ByVal customerID As String, ByVal appears_on_statement_as As String, ByVal amount As String, ByVal description As String) As String
        Try
            Dim result As String = ""
            Dim debitUri As String = ""
            Dim url As String = "https://api.balancedpayments.com/v1/customers/" & customerID & "/debits"
            Dim data As String = "{""appears_on_statement_as"":""" & appears_on_statement_as & """,""amount"":" & amount & ",""description"":""" & description & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()



            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "status" Then
                    result = item.Value
                ElseIf item.Name = "uri" Then
                    debitUri = item.Value
                End If
            Next

            If result = "succeeded" Then
                Return result & "," & debitUri
            Else
                Return result
            End If
            streamRead.Close()
            streamResponse.Close()
            wr.Close()

        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function CreateNewCreditForCustomer(ByVal customerID As String, ByVal amount As String) As String
        Try
            Dim result As String = ""
            Dim creditUri As String = ""
            Dim url As String = "https://api.balancedpayments.com/v1/customers/" & customerID & "/credits"
            Dim data As String = "{""amount"":" & amount & "}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "status" Then
                    result = item.Value
                ElseIf item.Name = "uri" Then
                    creditUri = item.Value
                End If
            Next

            If result = "paid" Then
                Return result & "," & creditUri
            ElseIf result = "pending" Then
                Return result & "," & creditUri
            Else
                Return result
            End If

            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function CreateNewCreditForMarketPlace(ByVal amount As String) As String
        Try
            Dim result As String = ""
            Dim creditUri As String = ""
            Dim url As String = "https://api.balancedpayments.com/v1/bank_accounts/" & balancedMerchantAccountID & "/credits"
            Dim data As String = "{""amount"":" & amount & "}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "status" Then
                    result = item.Value
                ElseIf item.Name = "uri" Then
                    creditUri = item.Value
                End If
            Next

            If result = "paid" Then
                Return result & "," & creditUri
            ElseIf result = "pending" Then
                Return result & "," & creditUri
            Else
                Return result
            End If

            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function CreateHoldForCard(ByVal amount As String, ByVal cardUriOfInvestor As String, ByVal description As String) As String
        Try
            Dim result As String = ""
            Dim holdsUri As String = ""

            Dim url As String = "https://api.balancedpayments.com" & apiMarketplace & "/holds"
            Dim data As String = "{""source_uri"":""" & cardUriOfInvestor & """,""amount"":""" & amount & """,""description"":""" & description & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()
            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "uri" Then
                    holdsUri = item.Value
                End If
            Next
            If holdsUri <> "" Then
                Return "succeeded," & holdsUri
            Else
                Return "failed"
            End If

            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function

    Public Shared Function CaptureHoldForCard(ByVal appears_on_statement_as As String, ByVal amount As String, ByVal description As String, ByVal holdUri As String) As String

        Try
            Dim result As String = ""
            Dim debitUri As String = ""
            Dim url As String = "https://api.balancedpayments.com" & apiMarketplace & "/debits"
            Dim data As String = "{""hold_uri"":""" & holdUri & """,""appears_on_statement_as"":""" & appears_on_statement_as & """,""amount"":" & amount & ",""description"":""" & description & """}"

            Dim myReq As WebRequest = WebRequest.Create(url)
            myReq.Method = "POST"
            myReq.ContentLength = data.Length
            myReq.ContentType = "application/json; charset=UTF-8"

            Dim usernamePassword As String = key + ":" + "x"
            Dim enc As New UTF8Encoding()
            myReq.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(enc.GetBytes(usernamePassword)))
            Using ds As Stream = myReq.GetRequestStream()
                ds.Write(enc.GetBytes(data), 0, data.Length)
            End Using

            Dim wr As WebResponse = myReq.GetResponse()



            Dim streamResponse As Stream = wr.GetResponseStream()
            Dim streamRead As New StreamReader(streamResponse)

            Dim readBuff As [Char]() = New [Char](255) {}
            Dim count As Integer = streamRead.Read(readBuff, 0, 256)
            Dim jsonstring As String = String.Empty
            While count > 0
                Dim outputData As New [String](readBuff, 0, count)
                jsonstring += outputData.ToString()
                count = streamRead.Read(readBuff, 0, 256)
            End While

            Dim ser As JObject = JObject.Parse(jsonstring)
            Dim Jdata As List(Of JToken) = ser.Children().ToList

            For Each item As JProperty In Jdata
                item.CreateReader()
                If item.Name = "status" Then
                    result = item.Value
                ElseIf item.Name = "uri" Then
                    debitUri = item.Value
                End If
            Next

            If result = "succeeded" Then
                Return result & "," & debitUri
            Else
                Return result
            End If
            streamRead.Close()
            streamResponse.Close()
            wr.Close()
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
            Return "error"
        End Try
    End Function
End Class
