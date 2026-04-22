using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace carGo
{
    public partial class BookCar : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                txtPickupDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                txtReturnDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");

                ddlPlateNumber.DataBind();
                FetchPriceRate();
            }

        }

        protected void ddlPlateNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchPriceRate();
        }

        private void FetchPriceRate()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT PriceRate FROM Cars WHERE PlateNumber = @Plate";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Plate", ddlPlateNumber.SelectedValue);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    PriceRate.Text = Convert.ToDecimal(result).ToString("F2");
                }
            }
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            try
            {
                pnlAlert.Visible = false; // Reset alerts
                DateTime pickup = DateTime.Parse(txtPickupDate.Text);
                DateTime returnD = DateTime.Parse(txtReturnDate.Text);
                DateTime today = DateTime.Today;

                // 1. Error Handling: Cannot select past dates
                if (pickup < today)
                {
                    ShowError("Pick-up date cannot be in the past.");
                    return;
                }

                // 2. Error Handling: Must be at least 1 day rental (cannot be same day)
                if (returnD <= pickup)
                {
                    ShowError("Return date must be at least one day after pick-up date.");
                    return;
                }

                decimal rate = decimal.Parse(PriceRate.Text);
                int days = (returnD - pickup).Days;

                // 3. Logic: Calculate Base Total
                decimal total = days * rate;

                // 4. Logic: Add Insurance if checked (Criteria 1h: Complex Calculation)
                if (chkInsurance.Checked)
                {
                    total += 50.00m; // Flat insurance fee
                }

                lblTotalFee.Text = total.ToString("N2");
                hfTotalFee.Value = total.ToString();
            }
            catch
            {
                ShowError("Please ensure all fields are filled correctly.");
            }
        }
        private void ShowError(string msg)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert alert-warning";
            lblAlert.Text = "<i class='fa-solid fa-triangle-exclamation me-2'></i>" + msg;
            lblTotalFee.Text = "0.00";
            hfTotalFee.Value = "0";
        }
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            btnCalculate_Click(null, null);

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {

                    string sqlInsert = @"INSERT INTO Rentals (UserId, PlateNumber, RentalDate, ReturnDate, TotalFee, Status) 
                                 VALUES (@Uid, @Plate, @RentD, @RetD, @Fee, 'Booked')";

                    using (SqlCommand cmd = new SqlCommand(sqlInsert, conn))
                    {
                        cmd.Parameters.AddWithValue("@Uid", Session["UserId"]);
                        cmd.Parameters.AddWithValue("@Plate", ddlPlateNumber.SelectedValue);
                        cmd.Parameters.AddWithValue("@RentD", txtPickupDate.Text);
                        cmd.Parameters.AddWithValue("@RetD", txtReturnDate.Text);
                        decimal fee = 0;
                        decimal.TryParse(hfTotalFee.Value, out fee);
                        cmd.Parameters.AddWithValue("@Fee", fee);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                Response.Redirect("MyBooking.aspx?status=success");
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                pnlAlert.CssClass = "alert alert-danger";
                lblAlert.Text = "Booking Error: " + ex.Message;
            }
        }
    }
}