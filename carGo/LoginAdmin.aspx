<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="carGo.LoginAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 text-center">
        <div class="card shadow-lg p-5 mx-auto border-0" style="max-width: 450px;">
            <div class="mb-4">
                <i class="fa-solid fa-user-shield text-primary fa-3x"></i>
                <h3 class="mt-3 fw-bold">Admin Portal</h3>
            </div>
            
            <div class="mb-3 text-start">
                <label class="form-label fw-bold">Admin Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-user"></i></span>
                    <asp:TextBox ID="txtAdminUser" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                </div>
            </div>
            
            <div class="mb-4 text-start">
                <label class="form-label fw-bold">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-lock"></i></span>
                    <asp:TextBox ID="txtAdminPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                </div>
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="text-danger d-block mb-3 fw-bold"></asp:Label>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login Access" CssClass="btn btn-primary w-100 py-2 fw-bold" OnClick="btnLogin_Click" />
            
            <div class="mt-3">
                <a href="CarGallery.aspx" class="text-muted small text-decoration-none">Back to Home</a>
            </div>
        </div>
    </div>
</asp:Content>
