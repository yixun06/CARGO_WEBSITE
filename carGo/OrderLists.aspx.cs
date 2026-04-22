using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class OrderLists : System.Web.UI.Page
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
                ShowAllRentals();
            }
        }

        private void ShowAllRentals()
        {
            using (SqlConnection conn =new SqlConnection(connStr))
            {
                string sql =@"SELECT r.RentalId, r.PlateNumber, r.RentalDate, r.ReturnDate, r.TotalFee, r.Status,u.Username,c.Model, c.CarImage FROM Rentals r
                    INNER JOIN Users u ON r.UserId = u.UserId INNER JOIN Cars c ON r.PlateNumber = c.PlateNumber ORDER BY r.RentalId DESC";

                using (SqlCommand cmd = new SqlCommand(sql,conn))
                {
                    using(SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        CalculateSum(dt);
                        gvRentals.DataSource = dt;
                        gvRentals.DataBind();
                    }
                }
            }
        }

        private void SearchRentals(string type,string keyword)
        {
            using (SqlConnection conn =new SqlConnection(connStr))
            {
                string sql = @" SELECT r.RentalId, r.PlateNumber, r.RentalDate, r.ReturnDate, r.TotalFee, r.Status, u.Username, c.Model, c.CarImage FROM Rentals r
                    INNER JOIN Users u ON r.UserId = u.UserId INNER JOIN Cars c ON r.PlateNumber = c.PlateNumber WHERE ";

                if (type =="Username")
                    sql +="u.Username LIKE '%' + @Val + '%'";
                else if (type =="PlateNumber")
                    sql +="r.PlateNumber LIKE '%' + @Val + '%'";
                else if (type== "Status")
                    sql +="r.Status LIKE '%' + @Val + '%'";

                using (SqlCommand cmd =new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Val", keyword);
                    using (SqlDataAdapter sda =new SqlDataAdapter(cmd))
                    {
                        DataTable dt =new DataTable();
                        sda.Fill(dt);
                        CalculateSum(dt);
                        gvRentals.DataSource = dt;
                        gvRentals.DataBind();
                    }
                }
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchType =ddlSearchType.SelectedValue;
            string searchText =txtSearch.Text.Trim();

            if (searchText =="") ShowAllRentals();
            else SearchRentals(searchType, searchText);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text ="";
            ddlSearchType.SelectedIndex = 0;
            ShowAllRentals();
        }

        protected void gvRentals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MarkReturned")
            {
                int rentalId = Convert.ToInt32(e.CommandArgument);
                UpdateStatus(rentalId,"Returned");
                ShowAllRentals();
            }
        }

        private void UpdateStatus(int id, string newStatus)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "UPDATE Rentals SET Status = @Status WHERE RentalId = @Id";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Status",newStatus);
                    cmd.Parameters.AddWithValue("@Id",id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void gvRentals_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rentalId = Convert.ToInt32(gvRentals.DataKeys[e.RowIndex].Value);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql ="DELETE FROM Rentals WHERE RentalId = @Id";
                using (SqlCommand cmd = new SqlCommand(sql,conn))
                {
                    cmd.Parameters.AddWithValue("@Id",rentalId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            lblMessage.Text ="Deleted.";
            ShowAllRentals();
        }

        public string GetStatusClass(string status)
        {
            if (status =="Booked") return "bg-warning text-dark";
            if (status =="Returned") return "bg-success";
            if (status =="Cancelled") return "bg-danger";
            return "bg-secondary";
        }

        private void CalculateSum(DataTable dt)
        {
            decimal sum = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["TotalFee"] != DBNull.Value)
                    {
                        sum +=Convert.ToDecimal(row["TotalFee"]);
                    }
                }
            }
            lblTotalRevenue.Text = "RM " + sum.ToString("N2");
        }
    }
}