<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="carGo.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container py-5">
        
        <div class="mb-4">
            <h2>Contact Us</h2>
            <p class="text-muted">Feel free to contact us for any questions.</p>
        </div>

        <div class="row">
            
            <div class="col-md-4 mb-4">
                <div class="p-4 bg-light rounded h-100">
                    <h4 class="mb-3">Our Office</h4>
                    
                    <p class="mb-2"><i class="fa-solid fa-location-dot me-2"></i> <strong>Address:</strong></p>
                    <p class="ms-4 text-muted">CarGo Center, 26600 Pekan, Pahang</p>

                    <p class="mb-2"><i class="fa-solid fa-phone me-2"></i> <strong>Phone:</strong></p>
                    <p class="ms-4 text-muted">+60 12-345 6789</p>

                    <p class="mb-2"><i class="fa-solid fa-envelope me-2"></i> <strong>Email:</strong></p>
                    <p class="ms-4 text-muted">info@cargo.com</p>

                    <div class="mt-4">
                        <iframe  width="100%" height="200" style="border:0; border-radius:5px;" 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d509865.48848561174!2d102.50146127412003!3d3.2695090433385103!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cf148d79ac4dfb%3A0x7189f6db57736bb6!2sPekan%2C%20Pahang!5e0!3m2!1sen!2smy!4v1766299359534!5m2!1sen!2smy">
                        </iframe>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="p-4 border rounded shadow-sm">
                    <h4 class="mb-3">Send us a Message</h4>

                    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-info">
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </asp:Panel>

                    <asp:Panel ID="pnlContactForm" runat="server">
                        
                        <div class="mb-3">
                            <label class="form-label">Your Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                                ErrorMessage="Name is required" CssClass="text-danger small" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter email" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" CssClass="text-danger small" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Type your message here..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                                ErrorMessage="Message cannot be empty" CssClass="text-danger small" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                        </div>

                        <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary px-4" 
                            OnClick="btnSubmit_Click" ValidationGroup="ContactForm" Visible="false" />

                        <button id="btnGuest" runat="server" type="button" class="btn btn-primary px-4" visible="false" 
                            onclick="alert('You must be logged in to send a message.');">
                            Send Message
                        </button>

                    </asp:Panel>

                </div>
            </div>

        </div>
    </div>

</asp:Content>