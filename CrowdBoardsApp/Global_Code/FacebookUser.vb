Imports Microsoft.VisualBasic
Public Class FacebookUser
    Public Property Id() As String
        Get
            Return m_Id
        End Get
        Set(ByVal value As String)
            m_Id = value
        End Set
    End Property
    Private m_Id As String
    Public Property Name() As String
        Get
            Return m_Name
        End Get
        Set(ByVal value As String)
            m_Name = value
        End Set
    End Property
    Private m_Name As String
    Public Property UserName() As String
        Get
            Return m_UserName
        End Get
        Set(ByVal value As String)
            m_UserName = value
        End Set
    End Property
    Private m_UserName As String
    Public Property PictureUrl() As String
        Get
            Return m_PictureUrl
        End Get
        Set(ByVal value As String)
            m_PictureUrl = value
        End Set
    End Property
    Private m_PictureUrl As String
    Public Property Email() As String
        Get
            Return m_Email
        End Get
        Set(ByVal value As String)
            m_Email = value
        End Set
    End Property
    Private m_Email As String
    Public Property First_Name() As String
        Get
            Return m_First_Name
        End Get
        Set(ByVal value As String)
            m_First_Name = value
        End Set
    End Property
    Private m_First_Name As String
    Public Property Last_Name() As String
        Get
            Return m_Last_Name
        End Get
        Set(ByVal value As String)
            m_Last_Name = value
        End Set
    End Property
    Private m_Last_Name As String
End Class
