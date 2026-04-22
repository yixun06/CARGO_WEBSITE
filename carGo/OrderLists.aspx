<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderLists.aspx.cs" Inherits="carGo.OrderLists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body { background-color: #f8f9fa; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container py-5">
        
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">

                <div class="d-flex justify-content-between align-items-center mb-4">
                    
                    <div>
                        <h3 class="mb-0 text-dark">Rentals Management</h3>
                        <small class="text-muted">Manage active and past car rentals</small>
                        <br />
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                    </div>

                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlSearchType" runat="server" CssClass="form-select" Width="140px">
                            <asp:ListItem Value="Username">User Name</asp:ListItem>
                            <asp:ListItem Value="PlateNumber">Plate No.</asp:ListItem>
                            <asp:ListItem Value="Status">Status</asp:ListItem>
                        </asp:DropDownList>

                        <div class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                        </div>

                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                    </div>
                </div>

                <div class="alert alert-info d-flex justify-content-between align-items-center mb-3">
                    <span><i class="fas fa-chart-line"></i> <strong>Current Total Revenue:</strong></span>
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="RM 0.00" CssClass="h4 mb-0 fw-bold text-primary"></asp:Label>
                </div>

                <asp:GridView ID="gvRentals" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="RentalId" 
                    OnRowDeleting="gvRentals_RowDeleting"
                    OnRowCommand="gvRentals_RowCommand"
                    CssClass="table table-hover align-middle" 
                    GridLines="None"
                    HeaderStyle-CssClass="table-light text-muted"
                    EmptyDataText="No rentals found.">
                    
                    <Columns>
                        <asp:BoundField DataField="RentalId" HeaderText="#" ItemStyle-Width="5%" />
                        
                        <asp:TemplateField HeaderText="Car Details" ItemStyle-Width="25%">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <div style="width: 50px; height: 35px; background-color: #eee; border-radius: 4px; overflow: hidden; margin-right: 10px; display:flex; justify-content:center; align-items:center;">
                                        <i class="fas fa-car fa-lg text-secondary"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark"><%# Eval("Model") %></div>
                                        <small class="text-muted"><%# Eval("PlateNumber") %></small>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Customer" ItemStyle-Width="15%">
                            <ItemTemplate>
                                <div class="fw-bold"><%# Eval("Username") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Duration" ItemStyle-Width="20%">
                            <ItemTemplate>
                                <small class="text-muted">From:</small> <%# Eval("RentalDate", "{0:MMM dd}") %> <br />
                                <small class="text-muted">To:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</small> <%# Eval("ReturnDate", "{0:MMM dd}") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Total" ItemStyle-Width="15%">
                            <ItemTemplate>
                                <span class="text-primary fw-bold">RM <%# Eval("TotalFee") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <span class='badge rounded-pill <%# GetStatusClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnReturn" runat="server" 
                                    CommandArgument='<%# Eval("RentalId") %>' 
                                    CommandName="MarkReturned"
                                    CssClass="btn btn-sm btn-outline-success mb-1" 
                                    Visible='<%# Eval("Status").ToString() == "Booked" %>'>
                                    <i class="fas fa-check"></i> Return
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                    OnClientClick="return confirm('Delete?');"
                                    CssClass="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </div>
        </div>
    </div>

</asp:Content>