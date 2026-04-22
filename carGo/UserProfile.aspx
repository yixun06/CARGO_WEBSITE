<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="carGo.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4 text-primary"><i class="fa-solid fa-user me-2"></i>My Profile</h2>
                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="alert d-block mb-3"></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 text-dark"><i class="fa-solid fa-circle-info me-2"></i>Personal Information</h5>
                    </div>
                    <div class="card-body">
                        
                        <div class="mb-3">
                            <label class="form-label">Full Name / Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                                ErrorMessage="Name is required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">IC Number</label>
                            <asp:TextBox ID="txtIc" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Phone Number *</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="e.g., 012-3456789"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                                ErrorMessage="Phone is required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your address"></asp:TextBox>
                        </div>

                        <div class="d-grid">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 text-dark"><i class="fa-solid fa-chart-line me-2"></i>Account Overview</h5>
                    </div>
                    <div class="card-body text-center">
                         <div class="mb-3">
                            <small class="text-muted d-block">Member Since</small>
                            <asp:Label ID="lblMemberSince" runat="server" CssClass="h5 text-dark font-weight-bold">Loading...</asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>