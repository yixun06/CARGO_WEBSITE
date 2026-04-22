using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace carGo
{
    public partial class UserProfile : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Check if user is logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // 2. CRITICAL FIX: Only load data when the page loads for the first time.
            // If we don't check !IsPostBack, the old data from the database will overwrite 
            // your new input every time you click the Update button.
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Fetch all user details
                    string query = "SELECT Username, Email, PhoneNumber, Ic, Address, CreatedDate FROM Users WHERE UserId = @UserId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Populate textboxes with data from DB
                            if (txtUsername != null) txtUsername.Text = reader["Username"] != DBNull.Value ? reader["Username"].ToString() : "";
                            if (txtEmail != null) txtEmail.Text = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : "";
                            if (txtPhone != null) txtPhone.Text = reader["PhoneNumber"] != DBNull.Value ? reader["PhoneNumber"].ToString() : "";
                            if (txtIc != null) txtIc.Text = reader["Ic"] != DBNull.Value ? reader["Ic"].ToString() : "";
                            if (txtAddress != null) txtAddress.Text = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : "";

                            // Populate Member Since (Fixes "Loading..." issue)
                            if (lblMemberSince != null)
                            {
                                if (reader["CreatedDate"] != DBNull.Value)
                                {
                                    lblMemberSince.Text = Convert.ToDateTime(reader["CreatedDate"]).ToString("dd MMM yyyy");
                                }
                                else
                                {
                                    lblMemberSince.Text = "N/A"; // Show N/A if date is missing
                                }
                            }
                        }
                        con.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading profile: " + ex.Message;
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block mb-3";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // 3. Update Query: Added Email and IC fields so they get saved
                    string updateQuery = @"UPDATE Users SET 
                                         Username = @Username, 
                                         Email = @Email,
                                         Ic = @Ic,
                                         PhoneNumber = @PhoneNumber, 
                                         Address = @Address 
                                         WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        // Bind all parameters
                        cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Ic", txtIc.Text.Trim());
                        cmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();

                        if (rowsAffected > 0)
                        {
                            // Update Session username upon success so the header updates immediately
                            Session["Username"] = txtUsername.Text.Trim();

                            lblMessage.Text = "Profile updated successfully!";
                            lblMessage.Visible = true;
                            lblMessage.CssClass = "alert alert-success d-block mb-3";
                        }
                        else
                        {
                            lblMessage.Text = "Update failed. No changes were saved.";
                            lblMessage.Visible = true;
                            lblMessage.CssClass = "alert alert-warning d-block mb-3";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating profile: " + ex.Message;
                lblMessage.Visible = true;
                lblMessage.CssClass = "alert alert-danger d-block mb-3";
            }
        }
    }
}