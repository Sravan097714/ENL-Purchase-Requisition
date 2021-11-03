dotnet
{
    assembly(mscorlib)
    {
        type(System.Array; Bytes) { }
    }
    assembly("mscorlib")
    {
        type("System.Collections.Generic.List`1"; "List_Of_T")
        {
        }

        type("System.Reflection.MethodInfo"; "S4L MethodInfo")
        {
        }

        type("System.Object"; "S4L Object")
        {
        }

        type("System.Type"; "S4L Type")
        {
        }

        type("System.Array"; "S4L Array")
        {
        }

        type("System.IO.MemoryStream"; "S4L MemoryStream")
        {
        }

        type("System.Activator"; "S4L Activator")
        {
        }

        type("System.Enum"; "S4L Enum")
        {
        }

        type("System.Convert"; "S4L Convert")
        {
        }

        type("System.Environment"; "S4L Environment")
        {
        }

        type("System.Security.Cryptography.FromBase64Transform"; "FromBase64Transform")
        {
        }

        type("System.Security.Cryptography.FromBase64TransformMode"; "FromBase64TransformMode")
        {
        }

        type("System.Byte"; "Byte")
        {
        }

        type("System.Text.Encoding"; "Encoding")
        {
        }

        type("System.IO.FileStream"; "FileStream")
        {
        }

        type("System.IO.FileMode"; "FileMode")
        {
        }

        type("System.IO.FileAccess"; "FileAccess")
        {
        }

        type("System.Security.SecurityElement"; "SecurityElement")
        {
        }

        type("System.IO.Stream"; "Stream")
        {
        }

        type("System.IO.IsolatedStorage.IsolatedStorageSecurityOptions"; "IsolatedStorageSecurityOptions")
        {
        }

        type("System.IO.StreamWriter"; "StreamWriter")
        {
        }
        type("System.IO.File"; "File")
        {
        }
    }

    /*

        assembly("System")
        {
            Version = '4.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = 'b77a5c561934e089';

            type("System.Net.ServicePointManager"; "ServicePointManager")
            {
            }

            type("System.Net.SecurityProtocolType"; "SecurityProtocolType")
            {
            }

            type("System.Net.HttpWebRequest"; "HttpWebRequest")
            {
            }

            type("System.Net.HttpWebResponse"; "HttpWebResponse")
            {
            }

            type("System.Security.Cryptography.X509Certificates.X509Certificate2"; "X509Certificate2")
            {
            }

            type("System.Net.WebRequest"; "WebRequest")
            {
            }

            type("System.Net.WebResponse"; "WebResponse")
            {
            }

            type("System.Net.WebHeaderCollection"; "WebHeaderCollection")
            {
            }

            type("System.Net.NetworkCredential"; "NetworkCredential")
            {
            }

            type("System.Net.WebException"; "WebException")
            {
            }

            type("System.Net.WebExceptionStatus"; "WebExceptionStatus")
            {
            }

            type("System.Net.HttpStatusCode"; "HttpStatusCode")
            {
            }

            type("System.Collections.Specialized.NameValueCollection"; "NameValueCollection")
            {
            }

            type("System.ComponentModel.PropertyChangedEventArgs"; "PropertyChangedEventArgs")
            {
            }

            type("System.ComponentModel.PropertyChangingEventArgs"; "PropertyChangingEventArgs")
            {
            }

            type("System.ComponentModel.ListChangedEventArgs"; "ListChangedEventArgs")
            {
            }

            type("System.ComponentModel.AddingNewEventArgs"; "AddingNewEventArgs")
            {
            }

            type("System.Collections.Specialized.NotifyCollectionChangedEventArgs"; "NotifyCollectionChangedEventArgs")
            {
            }
        }

        assembly("System.Xml")
        {
            Version = '4.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = 'b77a5c561934e089';

            type("System.Xml.XmlNode"; "XmlNode")
            {
            }

            type("System.Xml.XmlElement"; "XmlElement")
            {
            }

            type("System.Xml.XmlNodeChangedEventArgs"; "XmlNodeChangedEventArgs")
            {
            }

            type("System.Xml.XmlNodeList"; "XmlNodeList")
            {
            }

            type("System.Xml.XmlAttributeCollection"; "XmlAttributeCollection")
            {
            }

            type("System.Xml.XmlNamespaceManager"; "XmlNamespaceManager")
            {
            }

            type("System.Xml.XmlAttribute"; "XmlAttribute")
            {
            }

            type("System.Xml.XmlNamedNodeMap"; "XmlNamedNodeMap")
            {
            }

            type("System.Xml.XmlNodeType"; "XmlNodeType")
            {
            }
        }
        assembly("System.Drawing")
        {
            Version = '2.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = 'b03f5f7f11d50a3a';

            type("System.Drawing.Bitmap"; "S4L Bitmap")
            {
            }

            type("System.Drawing.Graphics"; "S4L Graphics")
            {
            }

            type("System.Drawing.Pen"; "S4L Pen")
            {
            }

            type("System.Drawing.SolidBrush"; "S4L SolidBrush")
            {
            }

            type("System.Drawing.Color"; "S4L Color")
            {
            }

            type("System.Drawing.Imaging.ImageFormat"; "S4L ImageFormat")
            {
            }

            type("System.Drawing.Font"; "S4L Font")
            {
            }
        }
    */
    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Path"; "S4L Path")
        {
        }

        type("System.IO.Directory"; "S4L Directory")
        {
        }

        type("System.String"; "S4L String")
        {
        }
    }
    /*
        assembly("Microsoft.Office.Interop.Word")
        {
            Version = '15.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = '71e9bce111e9429c';

            type("Microsoft.Office.Interop.Word.ApplicationClass"; "S4L ApplicationClass")
            {
            }

            type("Microsoft.Office.Interop.Word.Document"; "S4L Document")
            {
            }

            type("Microsoft.Office.Interop.Word.WdWindowState"; "S4L WdWindowState")
            {
            }
        }
        assembly("Microsoft.Dynamics.Nav.Integration.Office")
        {
            Version = '17.0.0.0'; //Version change  '16.0.0.0' -> '17.0.0.0'
            Culture = 'neutral';
            PublicKeyToken = '31bf3856ad364e35';

            type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHelper"; "S4L WordHelper")
            {
            }

            type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler"; "S4L WordHandler")
            {
            }
        }

        assembly("System.Xml")
        {
            Version = '4.0.0.0';
            Culture = 'neutral';
            PublicKeyToken = 'b77a5c561934e089';

            type("System.Xml.XmlDocument"; "S4L XmlDocument")
            {
            }

            type("System.Xml.XmlNode"; "S4L XmlNode")
            {
            }

            type("System.Xml.XmlNodeList"; "S4L XmlNodeList")
            {
            }

            type("System.Xml.XmlAttributeCollection"; "S4L XmlAttributeCollection")
            {
            }
        }
    */
}