using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.App_Code;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private dynamic LOCATION_CONFIG = null;
        private List<Person> PERSONS;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["LocationConfig"] = getData();

            if (!Page.IsPostBack)
            {
                createHeaderInfo();
            }
            //getImage();
            processStep1();

            createVisitTypeButtons();
            createImageButtons();
        }

        protected dynamic getData()
        {
            LOCATION_CONFIG = new JObject
            {
                { "name", "Fajardo Residence" },
                { "title", "Fajardo Residence Login Sheet" },
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

            LOCATION_CONFIG["visitTypes"] = arr;

            return LOCATION_CONFIG;

        }

        protected void createHeaderInfo()
        {
            litTitle.Text = LOCATION_CONFIG.title;
            litAddress.Text = LOCATION_CONFIG.address;
        }

        #region step 1

        private void processStep1()
        {
            if (!this.IsPostBack)
            {
                multiView.ActiveViewIndex = 0;
            }
        }

        private void createVisitTypeButtons()
        {
            if (LOCATION_CONFIG != null)
            {
                var divVisitTypes = FindControl("visitType");

                if (divVisitTypes != null)
                {
                    foreach (var json in LOCATION_CONFIG.visitTypes)
                    {
                        var button = new Button();
                        button.ID = "btn" + Common.UppercaseFirst(json.id.Value);
                        button.Text = json.text.Value;
                        button.Click += new EventHandler(this.btnVisit_Click);
                        divVisitTypes.Controls.Add(button);
                    }
                }
            }
        }

        protected void btnVisit_Click(object sender, EventArgs e)
        {
            multiView.ActiveViewIndex = 1;
        }
        #endregion

        #region step 2
        private void processStep2()
        { }

        protected void btnStep2Cancel_Click(object sender, EventArgs e)
        {
            multiView.ActiveViewIndex = 0;
        }

        protected void btnStep2Continue_Click(object sender, EventArgs e)
        {
            multiView.ActiveViewIndex = 2;
            processStep3();
        }
        #endregion

        #region step 3
        private void processStep3()
        {
            createResidentData();
            bindToPersonGrid();
        }

        private void createResidentData()
        {
            PERSONS = new List<Person>();

            var p = new Person
            {
                Id = 1,
                Picture = "~/images/residents/anton.jpg",
                FirstName = "peter",
                LastName = "fajardo"
            };

            PERSONS.Add(p);

            p = new Person
            {
                Id = 2,
                Picture = "~/images/residents/bea.jpg",
                FirstName = "vilma",
                LastName = "fajardo"
            };

            PERSONS.Add(p);

            p = new Person
            {
                Id = 3,
                Picture = "~/images/residents/lucas.jpg",
                FirstName = "niko",
                LastName = "fajardo"
            };

            PERSONS.Add(p);

            p = new Person
            {
                Id = 4,
                Picture = "~/images/residents/cloe.jpg",
                FirstName = "niki",
                LastName = "fajardo"
            };

            PERSONS.Add(p);

            p = new Person
            {
                Id = 5,
                Picture = "~/images/residents/kitty.jpg",
                FirstName = "nika",
                LastName = "fajardo"
            };

            PERSONS.Add(p);

            p = new Person
            {
                Id = 6,
                Picture = "~/images/residents/kiwi.jpg",
                FirstName = "kiwi",
                LastName = "fajardo"
            };

            PERSONS.Add(p);
        }

        private void bindToPersonGrid()
        {
            grpData.DataSource = PERSONS;
            grpData.DataBind();
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

        protected void btnStep3Cancel_Click(object sender, EventArgs e)
        {
            multiView.ActiveViewIndex = 0;
        }

        protected void btnStep3Continue_Click(object sender, EventArgs e)
        {
            multiView.ActiveViewIndex = 3;
        }
        #endregion

        #region step 4
        private void processStep4()
        {
           
        }

        

        #endregion
    }

    
}