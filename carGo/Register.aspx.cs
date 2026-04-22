using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialization code if needed
            }
        }

        // Server-side validation for Terms checkbox
        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Validate that the Terms checkbox is checked
            args.IsValid = cbTerms.Checked;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // First, validate the page
            if (Page.IsValid)
            {
                try
                {
                    // Check if email already exists
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        // Check for existing email
                        string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                        using (SqlCommand cmd = new SqlCommand(checkEmailQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            con.Open();
                            int emailCount = (int)cmd.ExecuteScalar();
                            con.Close();

                            if (emailCount > 0)
                            {
                                lblEmailError.Text = "This email is already registered.";
                                lblEmailError.Visible = true;
                                return;
                            }
                        }

                        // Insert new user
                        string insertQuery = @"INSERT INTO Users (Username, Password, Email, PhoneNumber, Ic, Address, CreatedDate, AgreedToTerms) 
                                               VALUES (@Username, @Password, @Email, @PhoneNumber, @Ic, @Address, @CreatedDate, @AgreedToTerms)";

                        using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                        {
                     
                            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim()); 
                            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            cmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text.Trim());
                            cmd.Parameters.AddWithValue("@Ic", txtICNumber.Text.Trim());
                            cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                            cmd.Parameters.AddWithValue("@AgreedToTerms", cbTerms.Checked);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }

                    // Registration successful - Redirect to Login
                    Response.Redirect("Login.aspx");
                }
                catch (Exception ex)
                {
                    // Log error
                    lblEmailError.Text = "Registration failed. Please try again. Error: " + ex.Message;
                    lblEmailError.Visible = true;
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Clear all form fields
            txtUsername.Text = "";
            txtICNumber.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            cbTerms.Checked = false;

            // Clear error messages
            lblEmailError.Visible = false;

            // Clear age display
            ClientScript.RegisterStartupScript(this.GetType(), "ClearAge",
                "document.getElementById('ageResult').style.display = 'none';", true);
        }
    }
}