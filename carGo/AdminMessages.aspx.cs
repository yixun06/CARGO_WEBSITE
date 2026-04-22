using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class AdminMessages : System.Web.UI.Page
    {
        string connStr =ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] ==null||Session["Role"].ToString() !="Admin")
            {
                Response.Redirect("LoginAdmin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ShowAllMessages();
            }
        }

        private void ShowAllMessages()
        {
            using (SqlConnection conn =new SqlConnection(connStr))
            {
                string sql ="SELECT * FROM Messages ORDER BY DateTime DESC";
                using (SqlCommand cmd =new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter sda =new SqlDataAdapter(cmd))
                    {
                        DataTable dt =new DataTable();
                        sda.Fill(dt);
                        gvMessages.DataSource = dt;
                        gvMessages.DataBind();
                    }
                }
            }
        }

        private void SearchMessages(string type, string keyword)
        {
            using (SqlConnection conn =new SqlConnection(connStr))
            {
                string sql = "";

                if (type == "MessageId")
                    sql = "SELECT * FROM Messages WHERE MessageId = @Val";
                else if (type == "Name")
                    sql = "SELECT * FROM Messages WHERE Name LIKE '%' + @Val + '%'";
                else if (type == "Email")
                    sql = "SELECT * FROM Messages WHERE Email LIKE '%' + @Val + '%'";

                using (SqlCommand cmd =new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Val", keyword);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt =new DataTable();
                        sda.Fill(dt);
                        gvMessages.DataSource =dt;
                        gvMessages.DataBind();
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchType =ddlSearchType.SelectedValue;
            string searchText = txtSearch.Text.Trim();

            if (searchText== "")
                ShowAllMessages();
            else
                SearchMessages(searchType, searchText);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text= "";
            ddlSearchType.SelectedIndex = 0;
            ShowAllMessages();
        }

        protected void gvMessages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName =="ToggleStatus")
            {
                int messageId= Convert.ToInt32(e.CommandArgument);
                ChangeStatus(messageId);

                if (txtSearch.Text.Trim() !="")
                    SearchMessages(ddlSearchType.SelectedValue, txtSearch.Text.Trim());
                else
                    ShowAllMessages();
            }
        }

        private void ChangeStatus(int id)
        {
            using (SqlConnection conn =new SqlConnection(connStr))
            {
                conn.Open();
                string getStatusSql = "SELECT Status FROM Messages WHERE MessageId = @id";
                string currentStatus = "Pending";

                using (SqlCommand cmd = new SqlCommand(getStatusSql, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    object result = cmd.ExecuteScalar();
                    if (result !=null) currentStatus =result.ToString();
                }

                string newStatus = (currentStatus=="Pending") ? "Resolved" : "Pending";

                string updateSql = "UPDATE Messages SET Status = @newStatus WHERE MessageId = @id";
                using (SqlCommand cmd =new SqlCommand(updateSql, conn))
                {
                    cmd.Parameters.AddWithValue("@newStatus", newStatus);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void gvMessages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int messageId =Convert.ToInt32(gvMessages.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn =new SqlConnection(connStr))
            {
                string sql = "DELETE FROM Messages WHERE MessageId = @MessageId";
                using (SqlCommand cmd =new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@MessageId", messageId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            lblMessage.Text ="Deleted.";

            if (txtSearch.Text.Trim() != "")
                SearchMessages(ddlSearchType.SelectedValue, txtSearch.Text.Trim());
            else
                ShowAllMessages();
        }
    }
}