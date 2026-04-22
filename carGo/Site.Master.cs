using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UserId"] != null)
            {
                //Show user panel
                pnlGuestLogin.Visible = false;
                pnlUser.Visible = true;
                pnlGuestNav.Visible = false;

                //Show username
                if (Session["Username"] != null)
                {
                    lblUser.Text = Session["Username"].ToString();
                }

                //Check Role: Admin or Customer
                string role = Session["Role"] != null ? Session["Role"].ToString() : "Customer";

                if (role == "Admin")
                {
                    //Show Admin Menu
                    pnlAdminNav.Visible = true;
                    pnlCustomerNav.Visible = false;
                    pnlFooter.Visible = false;
                    liUserProfile.Visible = false;
                }
                else
                {
                    //Show Customer Menu
                    pnlAdminNav.Visible = false;
                    pnlCustomerNav.Visible = true;
                    liUserProfile.Visible = true;
                }
            }
            else
            {
                //Guest Version
                pnlGuestLogin.Visible = true;
                pnlUser.Visible = false;
                pnlGuestNav.Visible = true;
                pnlCustomerNav.Visible = false;
                pnlAdminNav.Visible = false;
            }
        }

        public string SetActive(string pagename)
        {
            string path = Request.Url.AbsolutePath.ToLower();
            string checkName = pagename.ToLower().Replace(".aspx", "");

            if (path.Contains(checkName))
            {
                return "text-primary fw-bold active-link";
            }
            return "";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            string role = Convert.ToString(Session["Role"]); 

            Session.Clear();
            Session.Abandon();
            if (role == "Admin")
            {
                Response.Redirect("LoginAdmin.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}