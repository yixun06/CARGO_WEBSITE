<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookCar.aspx.cs" Inherits="carGo.BookCar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .booking-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            background: #fff;
            transition: transform 0.3s ease;
        }
        .form-label {
            font-size: 0.9rem;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            transition: all 0.2s ease-in-out;
        }
        .form-control:focus {
           border-color: #0d6efd;
           box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
    </style>

    <div class="container">
        <div class="card booking-card">
            <div class="card-body p-5">
                <h2 class="text-center mb-4 text-primary fw-bold">Car Booking</h2>
                
                <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-dismissible fade show" role="alert">
                    <asp:Label ID="lblAlert" runat="server"></asp:Label>
                </asp:Panel>

                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label">Select Car</label>
    
                        <asp:SqlDataSource ID="sdsCars" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            SelectCommand="SELECT PlateNumber, Model + ' - ' + PlateNumber AS DisplayName FROM Cars WHERE Status = 'Available'">
                        </asp:SqlDataSource>

                        <asp:DropDownList ID="ddlPlateNumber" runat="server" CssClass="form-select" 
                            DataSourceID="sdsCars" 
                            DataTextField="DisplayName" 
                            DataValueField="PlateNumber"
                            AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlPlateNumber_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                   <div class="col-md-6">
                       <label class="form-label">Pick-up Date</label>
                       <asp:TextBox ID="txtPickupDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="rfvPickup" runat="server" ControlToValidate="txtPickupDate" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                  </div>

                    <div class="col-md-6">
                        <label class="form-label">Return Date</label>
                        <asp:TextBox ID="txtReturnDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvReturn" runat="server" ControlToValidate="txtReturnDate" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">Daily Rate (RM)</label>
                        <asp:TextBox ID="PriceRate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="col-md-12">
                         <div class="form-check p-3 border rounded" style="background-color: #f8f9fa;">
                         <asp:CheckBox ID="chkInsurance" runat="server" CssClass="form-check-input" AutoPostBack="true" OnCheckedChanged="btnCalculate_Click" />
                        <label class="form-check-label fw-bold" for="chkInsurance">
                         Add Basic Insurance (RM 50.00 flat rate)
                       </label>
                      <small class="d-block text-muted">Protect your journey against unexpected accidents.</small>
                    </div>
                </div>

                    <div class="col-md-12 my-3">
                        <asp:Button ID="btnCalculate" runat="server" Text="Calculate Total Fee" CssClass="btn btn-outline-primary w-100 fw-bold" OnClick="btnCalculate_Click" CausesValidation="true" />
                    </div>

                    <div class="col-md-12">
                        <div class="fee-display">
                            <span class="text-muted small d-block">Estimated Total</span>
                            <h3 class="mb-0 text-dark">RM <asp:Label ID="lblTotalFee" runat="server" Text="0.00"></asp:Label></h3>
                            <asp:HiddenField ID="hfTotalFee" runat="server" Value="0" />
                        </div>
                    </div>

                    <div class="col-md-12 mt-4">
                        <asp:Button ID="btnConfirm" runat="server" Text="Confirm Booking Now" CssClass="btn btn-primary btn-lg w-100 shadow-sm" OnClick="btnConfirm_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>