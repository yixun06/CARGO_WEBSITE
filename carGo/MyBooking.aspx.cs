using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class MyBookings : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM Rentals WHERE UserId = @Uid ORDER BY RentalDate DESC";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Uid", Session["UserId"]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvBookings.DataSource = dt;
                gvBookings.DataBind();
            }
        }

        protected void gvBookings_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBookings.EditIndex = e.NewEditIndex;
            LoadBookings();
        }
        protected void gvBookings_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBookings.EditIndex = -1;
            LoadBookings();
        }
        protected void gvBookings_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int rentalId = Convert.ToInt32(gvBookings.DataKeys[e.RowIndex].Value);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "DELETE FROM Rentals WHERE RentalId = @Id AND UserId = @Uid";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Id", rentalId);
                cmd.Parameters.AddWithValue("@Uid", Session["UserId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            LoadBookings();
        }
        protected void gvBookings_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rentalId = Convert.ToInt32(gvBookings.DataKeys[e.RowIndex].Value);
            string plate = ((DropDownList)gvBookings.Rows[e.RowIndex].FindControl("ddlEditPlate")).SelectedValue;
            DateTime rentD = DateTime.Parse(((TextBox)gvBookings.Rows[e.RowIndex].FindControl("txtEditPickup")).Text);
            DateTime retD = DateTime.Parse(((TextBox)gvBookings.Rows[e.RowIndex].FindControl("txtEditReturn")).Text);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string priceSql = "SELECT PriceRate FROM Cars WHERE PlateNumber = @Plate";
                SqlCommand priceCmd = new SqlCommand(priceSql, conn);
                priceCmd.Parameters.AddWithValue("@Plate", plate);
                conn.Open();
                decimal rate = Convert.ToDecimal(priceCmd.ExecuteScalar());
                int days = (retD - rentD).Days;
                if (days <= 0) days = 1;
                decimal newTotal = days * rate;

                string updateSql = "UPDATE Rentals SET PlateNumber=@P, RentalDate=@Start, ReturnDate=@End, TotalFee=@Fee WHERE RentalId=@Id";
                SqlCommand cmd = new SqlCommand(updateSql, conn);
                cmd.Parameters.AddWithValue("@P", plate);
                cmd.Parameters.AddWithValue("@Start", rentD);
                cmd.Parameters.AddWithValue("@End", retD);
                cmd.Parameters.AddWithValue("@Fee", newTotal);
                cmd.Parameters.AddWithValue("@Id", rentalId);
                cmd.ExecuteNonQuery();
            }
            gvBookings.EditIndex = -1;
            LoadBookings();
        }
    }

}