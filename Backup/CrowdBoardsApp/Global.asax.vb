Imports System.Web.SessionState
Imports System.Web.Routing
Imports System.Net

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application is started Tls12
        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls
        'System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Ssl3
        RegisterRoutes(RouteTable.Routes)
        HttpContext.Current.Cache.Insert("Pages", DateTime.Now, Nothing, System.DateTime.MaxValue, System.TimeSpan.Zero, System.Web.Caching.CacheItemPriority.NotRemovable, _
       Nothing)
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session is started
    End Sub
    Sub RegisterRoutes(ByVal routes As RouteCollection)

        routes.Add(New Route("{resource}.axd/{*pathInfo}", New StopRoutingHandler()))
        routes.Add(New Route("{resource}.asmx/{*pathInfo}", New StopRoutingHandler()))
        routes.Add(New Route("{resource}.ashx/{*pathInfo}", New StopRoutingHandler()))
        routes.Add(New Route("route", New StopRoutingHandler()))
        routes.Add(New Route("images", New StopRoutingHandler()))
        routes.Add(New Route("upload", New StopRoutingHandler()))
        routes.Add(New Route("thumbnail", New StopRoutingHandler()))
        routes.Add(New Route("thumbs", New StopRoutingHandler()))
        routes.Add(New Route("js", New StopRoutingHandler()))
        routes.Add(New Route("css", New StopRoutingHandler()))
        routes.Add(New Route("js", New StopRoutingHandler()))


        routes.MapPageRoute("BoardPage", "{Name}", "~/Board.aspx", False)

    End Sub
    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
        'Dim originalPath As String = HttpContext.Current.Request.Path.ToLower()
        'If originalPath.ToLower().Contains(".css") OrElse originalPath.ToLower().Contains(".js") OrElse originalPath.ToLower().Contains(".png") OrElse originalPath.ToLower().Contains(".jpg") OrElse originalPath.EndsWith(".jpeg") OrElse originalPath.ToLower().Contains(".bmp") OrElse originalPath.ToLower().Contains(".htm") OrElse originalPath.ToLower().Contains(".png") OrElse originalPath.ToLower().Contains(".gif") OrElse originalPath.ToLower().Contains(".fla") OrElse originalPath.ToLower().Contains(".swf") OrElse originalPath.ToLower().Contains(".axd") OrElse originalPath.ToLower().Contains(".xml") OrElse originalPath.ToLower().Contains(".ashx") OrElse originalPath.ToLower().Contains(".asmx") Then
        '    Return
        'End If
        'If originalPath.Contains(".aspx") Then
        '    Return
        'ElseIf originalPath = "/" Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/images") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/upload") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/thumbnail") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/thumbs") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/js") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains("/css") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains(".axd") Then
        '    Return
        'ElseIf originalPath.ToLower().Contains(".asmx") Then
        '    Return
        'Else
        'Dim directoryName As String = originalPath.Replace("/", "")
        'Context.RewritePath(originalPath.Replace(originalPath, "/Board.aspx?Name=" + directoryName))

        'End If
        System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls

    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
        System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

End Class