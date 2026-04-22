using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace carGo
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    Response.Redirect("CarGallery.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtLoginEmail.Text.Trim();
                string password = txtLoginPassword.Text;

                try
                {
                    using (SqlConnection con = new SqlConnection(GetConnectionString()))
                    {
                        string query = "SELECT UserID, Email, Username, Password FROM Users WHERE Email = @Email";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Email", email);
                            con.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // Verify password
                                    string storedPassword = reader["Password"].ToString();

                                    if (password == storedPassword)
                                    {
                                        // Set session variables according to your Site.master.cs structure
                                        Session["UserId"] = reader["UserID"];
                                        Session["Email"] = reader["Email"];
                                        Session["Username"] = reader["Username"];
                                        Session["Role"] = "Customer";

                                        // Redirect based on role
                                        RedirectAfterLogin();
                                    }
                                    else
                                    {
                                        ShowError("Invalid email or password.");
                                    }
                                }
                                else
                                {
                                    ShowError("Invalid email or password.");
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowError("Login failed: " + ex.Message);
                }
            }
        }

        private void RedirectAfterLogin()
        {
            // Check for return URL
            string returnUrl = Request.QueryString["ReturnUrl"];

            if (!string.IsNullOrEmpty(returnUrl))
            {
                Response.Redirect(returnUrl);
            }
            else
            {
                Response.Redirect("CarGallery.aspx");
            }
        }

        private void ShowError(string message)
        {
            pnlMessage.Visible = true;
            litMessage.Text = message;
        }

        private string GetConnectionString()
        {
            // Make sure this matches the name in your Web.config
            return ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        }
    }
}