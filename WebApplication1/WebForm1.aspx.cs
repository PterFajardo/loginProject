using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private dynamic LOCATION_OBJ = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            getData();
            createVisitTypeButtons();
            createImageButtons();


            if (!this.IsPostBack)
            {
                getImage();
            }
        }

        private void getImage()
        {
            if (Request.InputStream.Length > 0)
            {
                using (StreamReader reader = new StreamReader(Request.InputStream))
                {
                    string hexString = Server.UrlEncode(reader.ReadToEnd());
                    string imageName = DateTime.Now.ToString("dd-MM-yy hh-mm-ss");
                    string imagePath = string.Format("~/Captures/{0}.png", imageName);
                    File.WriteAllBytes(Server.MapPath(imagePath), ConvertHexToBytes(hexString));
                    Session["CapturedImage"] = ResolveUrl(imagePath);
                }
            }
        }

        private static byte[] ConvertHexToBytes(string hex)
        {
            byte[] bytes = new byte[hex.Length / 2];
            for (int i = 0; i < hex.Length; i += 2)
            {
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bytes;
        }

        [WebMethod(EnableSession = true)]
        public static string GetCapturedImage()
        {
            string url = HttpContext.Current.Session["CapturedImage"].ToString();
            HttpContext.Current.Session["CapturedImage"] = null;
            return url;
        }

        private void createImageButtons()
        {
            var divMyButtons = FindControl("divResidents");

            if (divMyButtons != null)
            {
                var imageLocation = "~/images/residents/";
                string[] fileEntries = Directory.GetFiles(Server.MapPath(imageLocation));
                foreach (string fileName in fileEntries)
                {
                    FileInfo info = new FileInfo(fileName);
                    var name = info.Name;
                    var imageButton = new ImageButton();
                    imageButton.ID = "btn" + Common.UppercaseFirst(name.Substring(0, name.IndexOf('.')));
                    imageButton.ImageUrl = imageLocation + name;
                    imageButton.Click += new ImageClickEventHandler(this.imgButton_Click);
                    imageButton.AlternateText = name;
                    imageButton.ToolTip = name;
                    divMyButtons.Controls.Add(imageButton);
                }
            }
        }

        protected void imgButton_Click(object sender, ImageClickEventArgs e)
        {
            var imgButton = (ImageButton)sender;
            if (string.IsNullOrEmpty(imgButton.CssClass))
            {
                imgButton.CssClass = "inactive";
            }
            else
            {
                imgButton.CssClass = string.Empty;
            }


        }

        protected void getData()
        {
             LOCATION_OBJ = new JObject
            {
                { "name", "Fajardo Residence" },
                { "address", "1051 West Inca St  Mesa, AZ  85201"},
            };

            JArray arr = new JArray();
            arr.Add(new JObject
            {
                { "id", "family"},
                { "text", "Family"},
                { "requireRegistration", false}
            });

            arr.Add(new JObject
            {
                { "id", "healthServices"},
                { "text", "Health Services"},
                { "requireRegistration", true}
            });

            arr.Add(new JObject
            {
                { "id", "other"},
                { "text", "Other"},
                { "requireRegistration", false}
            });

            LOCATION_OBJ["visitTypes"] = arr;

        }

        private void createVisitTypeButtons()
        {
            //< asp:Button ID = "btnFamily" Text = "Family" Font - Size = "XX-Large" runat = "server" OnClick = "btnVisit_Click" />
            var divVisitTypes = FindControl("visitType");

            if (divVisitTypes != null)
            {
                foreach (var json in LOCATION_OBJ.visitTypes)
                {
                    var button = new Button();
                    button.ID = "btn" + Common.UppercaseFirst(json.id.Value);
                    button.Text = json.text.Value;
                    button.Click += new EventHandler(this.btnVisit_Click);
                    divVisitTypes.Controls.Add(button);
                }
            }
        }

        protected void btnVisit_Click(object sender, EventArgs e)
        {
            var x = string.Empty;
        }
    }
}