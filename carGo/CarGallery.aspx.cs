using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace carGo
{
    public partial class CarGallery : System.Web.UI.Page
    {
        // Menggunakan connection string dari Web.config anda
        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ambil nilai kategori dari URL (contoh: ?cat=Sedan)
                string selectedCategory = Request.QueryString["cat"];
                LoadCars(selectedCategory);
            }
        }

        private void LoadCars(string category)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Cars";

                // Jika ada kategori dipilih, tapis SQL query
                if (!string.IsNullOrEmpty(category))
                {
                    query += " WHERE Category = @cat";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(category))
                    {
                        cmd.Parameters.AddWithValue("@cat", category);
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    // Masukkan data ke dalam Repeater
                    rptCars.DataSource = dt;
                    rptCars.DataBind();
                }
            }
        }
    }
}