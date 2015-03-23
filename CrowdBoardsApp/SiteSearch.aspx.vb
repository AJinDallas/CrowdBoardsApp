Imports Telerik.Web.UI

Public Class SiteSearch
    Inherits System.Web.UI.Page
    Dim GM As New GlobalModule
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GlobalModule.RedirectToHttps()
        If Session("userName") Is Nothing Then
            Response.Redirect("~/Default.aspx", False)
        End If
        lblMessageSearch.Text = ""
        If Not Page.IsPostBack Then
            lnkbtnCrowdBoards.Attributes.Add("style", "text-decoration:underline")
            If Not Request.QueryString("searchValue") Is Nothing Then
                Session("searchKeyWord") = Request.QueryString("searchValue").ToString()
                If (Request.QueryString("searchValue") = "") Then
                    Session("searchKeyWord") = "#"
                    GlobalModule.SetMessage(lblMessageSearch, False, "Enter Text to Search for and Click Search")
                End If
            Else
                Session("searchKeyWord") = "#"
                GlobalModule.SetMessage(lblMessageSearch, False, "Enter Text to Search for and Click Search")
            End If
            nonFriendRepater.DataBind()
            surfBoardsRepeater.DataBind()
            newsRepeater.DataBind()
            'lblUpdates.Text = "(0)"
        End If
    End Sub

    Public Function isAvail(ByVal img As String) As String
        If System.IO.File.Exists(Server.MapPath(img)) Then
            Return (img)
        Else
            Return ("/thumbnail/noimage.jpg")
        End If
    End Function
    
    Public Function GetImageURL(ByVal fileNameObject As Object, ByVal desiredHeight As Int16, ByVal desiredWidth As Int16, ByVal FilePath As String, ByVal thumbsFilePath As String) As String
        Dim result As String = String.Empty
        Try
            result = GM.GetImageURL(fileNameObject, desiredHeight, desiredWidth, FilePath, thumbsFilePath)
        Catch ex As Exception
            GlobalModule.ErrorLogFile(ex)
        End Try
        Return result
    End Function

    Protected Sub surfBoardsRepeater_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles surfBoardsRepeater.ItemDataBound
        Try
            Dim hdnDirectoryName = TryCast(e.Item.FindControl("hdnDirectoryName"), HiddenField)
            Dim coverPicDiv As HtmlGenericControl = TryCast(e.Item.FindControl("covPicLineup"), HtmlGenericControl)
            If Not isAvail("~/Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg").Contains("noimage.jpg") Then
                Dim pathCoverPic As String = "Upload/BoardCoverPics/" & hdnDirectoryName.Value & ".jpg"
                coverPicDiv.Attributes.Add("style", "background-image:url(" & pathCoverPic & ");min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            Else
                coverPicDiv.Attributes.Add("style", "background-image:url(WebContent/Theme/images/crowdboardvideopreview.png);min-height: 100px; width: 100%;background-repeat:no-repeat; background-size: 100% 100%; overflow:hidden;")
            End If
            Dim thermometerSlider = TryCast(e.Item.FindControl("ThermometerSlider"), RadSlider)
            Dim hdnMaxValue = TryCast(e.Item.FindControl("hdnMaxValue"), HiddenField)
            Dim hdnValue = TryCast(e.Item.FindControl("hdnValue"), HiddenField)
            Dim largeChange As Integer
            If Not (hdnMaxValue.Value = "") Then
                thermometerSlider.MaximumValue = Convert.ToDecimal(hdnMaxValue.Value)
                largeChange = Convert.ToInt32(hdnMaxValue.Value) / 5
                thermometerSlider.LargeChange = largeChange
            Else
                thermometerSlider.MaximumValue = 5000
                largeChange = 5000 / 5
                thermometerSlider.LargeChange = largeChange
            End If
            If Not (hdnValue.Value = "") Then
                thermometerSlider.Value = Convert.ToDouble(hdnValue.Value)
            Else
                thermometerSlider.Value = 0
            End If
        Catch ex As Exception
            Throw ex
            GlobalModule.ErrorLogFile(ex)
        End Try
    End Sub

    Public Function GetAmount(ByVal amount As String, ByVal bankLocation As String) As String
        Dim GM As New GlobalModule
        Return GM.GetAmountAccordingToLocation(amount, bankLocation)
    End Function


    Protected Sub lnkbtnCrowdBoards_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnCrowdBoards.Click
        lnkbtnCrowdBoards.Attributes.Add("style", "text-decoration:underline")
        lnkbtnCrowdBoarders.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdNews.Attributes.Add("style", "text-decoration:none")
        MultiViewSearchResult.ActiveViewIndex = 0
    End Sub

    Protected Sub lnkbtnCrowdBoarders_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnCrowdBoarders.Click
        lnkbtnCrowdBoards.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdBoarders.Attributes.Add("style", "text-decoration:underline")
        lnkbtnCrowdNews.Attributes.Add("style", "text-decoration:none")
        MultiViewSearchResult.ActiveViewIndex = 1
    End Sub

    Protected Sub lnkbtnCrowdNews_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkbtnCrowdNews.Click
        lnkbtnCrowdBoards.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdBoarders.Attributes.Add("style", "text-decoration:none")
        lnkbtnCrowdNews.Attributes.Add("style", "text-decoration:underline")
        MultiViewSearchResult.ActiveViewIndex = 2
    End Sub
End Class