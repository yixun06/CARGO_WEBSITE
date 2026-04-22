using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace carGo
{
    public partial class ContactUs : System.Web.UI.Page
    {
        string connStr =ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] !=null)
                {
                    btnSubmit.Visible =true;
                    btnGuest.Visible =false;

                    if (Session["Username"] !=null)
                    {
                        txtName.Text = Session["Username"].ToString();
                        txtEmail.Text = Session["Email"].ToString();
                    }
                }
                else
                {
                    btnSubmit.Visible = false;
                    btnGuest.Visible = true;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string messageText = txtMessage.Text.Trim();

            try
            {
                using (SqlConnection conn =new SqlConnection(connStr))
                {
                    string sql = "INSERT INTO Messages (Name, Email, Text) VALUES (@Name, @Email, @Text)";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Text", messageText);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                pnlMessage.Visible = true;
                pnlMessage.CssClass = "alert alert-success";
                lblStatus.Text = "Success! Message sent.";
                txtMessage.Text = "";
            }

            catch (Exception ex)
            {
                pnlMessage.Visible = true;
                pnlMessage.CssClass = "alert alert-danger";
                lblStatus.Text = "Error: " + ex.Message;
            }
        }
    }
}