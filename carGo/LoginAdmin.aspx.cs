using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration; 

namespace carGo
{
    public partial class LoginAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
            {
                Response.Redirect("OrderLists.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string u = txtAdminUser.Text.Trim();
            string p = txtAdminPass.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {

                string sql = "SELECT AdminId, Username FROM Admin WHERE Username = @u AND Password = @p";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@u", u);
                cmd.Parameters.AddWithValue("@p", p);

                try
                {
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        Session["UserId"] = rdr["AdminId"].ToString();
                        Session["Username"] = rdr["Username"].ToString();
                        Session["Role"] = "Admin";
                        Response.Redirect("OrderLists.aspx");
                    }
                    else
                    {
                        lblError.Text = "Invalid Admin Username or Password.";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}