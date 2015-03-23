Imports System.Web
Imports System.Web.Services
Imports Telerik.Web.UI


Public Class CustomHandler
    Inherits AsyncUploadHandler

    Protected Overrides Function Process(ByVal file As UploadedFile, ByVal context As HttpContext, ByVal configuration As IAsyncUploadConfiguration, ByVal tempFileName As String) As IAsyncUploadResult
        configuration.TimeToLive = TimeSpan.FromHours(4)
        Return MyBase.Process(file, context, configuration, tempFileName)
    End Function


End Class