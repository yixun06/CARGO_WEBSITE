<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyBookings.aspx.cs" Inherits="carGo.MyBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">My Booking History</h2>
            <a href="BookCar.aspx" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>New Booking</a>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="table-responsive">
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover mb-0" GridLines="None"
                    DataKeyNames="RentalId"
                    OnRowEditing="gvBookings_RowEditing" 
                    OnRowUpdating="gvBookings_RowUpdating" 
                    OnRowCancelingEdit="gvBookings_RowCancelingEdit" 
                    OnRowDeleting="gvBookings_RowDeleting" 
                    EmptyDataText="You have no bookings yet.">
                    <Columns>
                        <asp:BoundField DataField="RentalId" HeaderText="ID" ReadOnly="true" HeaderStyle-CssClass="bg-light px-4 py-3" ItemStyle-CssClass="px-4 py-3" />
                       
                        <asp:TemplateField HeaderText="Vehicle" HeaderStyle-CssClass="bg-light">
                            <ItemTemplate><%# Eval("PlateNumber") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditPlate" runat="server" CssClass="form-select form-select-sm" DataSourceID="sdsCars"  DataTextField="PlateNumber" DataValueField="PlateNumber" SelectedValue='<%# Bind("PlateNumber") %>'></asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCars" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT PlateNumber FROM Cars"></asp:SqlDataSource>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Pick-up" HeaderStyle-CssClass="bg-light">
                            <ItemTemplate><%# Eval("RentalDate", "{0:dd MMM yyyy}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPickup" runat="server" Text='<%# Bind("RentalDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Return" HeaderStyle-CssClass="bg-light">
                            <ItemTemplate><%# Eval("ReturnDate", "{0:dd MMM yyyy}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditReturn" runat="server" Text='<%# Bind("ReturnDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Total Fee" HeaderStyle-CssClass="bg-light">
                            <ItemTemplate>
                                <span class="fw-bold text-primary">RM <%# Eval("TotalFee", "{0:N2}") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="bg-light">
                            <ItemTemplate>
                                <span class='badge <%# Eval("Status").ToString() == "Booked" ? "bg-info" : "bg-success" %>'>
                                    <%# Eval("Status") %> 
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                            ButtonType="Button" 
                            ControlStyle-CssClass="btn btn-sm btn-outline-secondary me-1"
                            DeleteText="Cancel Booking" />
                    </Columns>
                    <HeaderStyle CssClass="table-light" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>