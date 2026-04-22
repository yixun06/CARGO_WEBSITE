using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

namespace carGo
{
    public partial class ManageCars : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Cars", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCars.DataSource = dt;
                gvCars.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string fileName = "default_car.png";
            if (fileUploadImage.HasFile)
            {
                fileName = Path.GetFileName(fileUploadImage.FileName);
                // Simpan ke folder Images/
                fileUploadImage.SaveAs(Server.MapPath("~/Images/Cars/") + fileName);
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Ikut susunan column database anda
                string sql = "INSERT INTO Cars (PlateNumber, Model, Category, PriceRate, CarImage, Status) VALUES (@Plate, @Model, @Cat, @Price, @Img, 'Available')";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Plate", txtPlate.Text);
                cmd.Parameters.AddWithValue("@Model", txtModel.Text);
                cmd.Parameters.AddWithValue("@Cat", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice.Text));
                cmd.Parameters.AddWithValue("@Img", fileName);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
            lblMessage.Text = "Success!";
        }

        protected void gvCars_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCars.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvCars_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCars.EditIndex = -1;
            BindGrid();
        }

        protected void gvCars_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Ambil PlateNumber sebagai ID unik (DataKey)
            string plate = gvCars.DataKeys[e.RowIndex].Value.ToString();

            // Ambil nilai baru dari GridView
            string model = ((TextBox)gvCars.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            string category = ((TextBox)gvCars.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
            string price = ((TextBox)gvCars.Rows[e.RowIndex].Cells[4].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "UPDATE Cars SET Model=@Model, Category=@Cat, PriceRate=@Price WHERE PlateNumber=@Plate";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Model", model);
                cmd.Parameters.AddWithValue("@Cat", category);
                cmd.Parameters.AddWithValue("@Price", decimal.Parse(price));
                cmd.Parameters.AddWithValue("@Plate", plate);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            gvCars.EditIndex = -1;
            BindGrid();
        }

        protected void gvCars_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string plate = gvCars.DataKeys[e.RowIndex].Value.ToString();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Cars WHERE PlateNumber=@Plate", con);
                cmd.Parameters.AddWithValue("@Plate", plate);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
