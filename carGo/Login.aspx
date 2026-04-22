<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="Login.aspx.cs" Inherits="carGo.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fa-solid fa-right-to-bracket me-2"></i>Login to CarGo</h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <i class="fa-solid fa-circle-user display-1 text-primary"></i>
                        </div>
                        
                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-danger">
                            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                        </asp:Panel>
                        
                        <div class="mb-3">
                            <label for="txtLoginEmail" class="form-label">Email Address *</label>
                            <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control" 
                                TextMode="Email" placeholder="Enter your email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLoginEmail" runat="server" 
                                ControlToValidate="txtLoginEmail" ErrorMessage="Email is required"
                                CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="mb-3">
                            <label for="txtLoginPassword" class="form-label">Password *</label>
                            <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" 
                                TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server" 
                                ControlToValidate="txtLoginPassword" ErrorMessage="Password is required"
                                CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <asp:CheckBox ID="cbRememberMe" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label" for="cbRememberMe">Remember me</label>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" 
                                CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                        </div>
                        
                        <div class="text-center mt-4">
                            <p class="text-muted">
                                Don't have an account? 
                                <asp:HyperLink ID="hlRegister" runat="server" NavigateUrl="~/Register.aspx" 
                                    CssClass="text-primary fw-bold">Register here</asp:HyperLink>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>