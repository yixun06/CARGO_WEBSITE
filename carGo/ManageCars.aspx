<%@ Page Title="Car Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageCars.aspx.cs" Inherits="carGo.ManageCars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Car Management</h2>

        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-primary text-white">Add New Car</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <label>Plate Number:</label>
                        <asp:TextBox ID="txtPlate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label>Model Name:</label>
                        <asp:TextBox ID="txtModel" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label>Category:</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                            <asp:ListItem>Compact</asp:ListItem>
                            <asp:ListItem>Sedan</asp:ListItem>
                            <asp:ListItem>MPV</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Price Rate (RM/Day):</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label>Car Image:</label>
                        <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <asp:Button ID="btnAdd" runat="server" Text="Register Car" CssClass="btn btn-success" OnClick="btnAdd_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="ms-3"></asp:Label>
            </div>
        </div>

        <asp:GridView ID="gvCars" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="PlateNumber" CssClass="table table-bordered table-hover"
            OnRowEditing="gvCars_RowEditing" 
            OnRowCancelingEdit="gvCars_RowCancelingEdit" 
            OnRowUpdating="gvCars_RowUpdating" 
            OnRowDeleting="gvCars_RowDeleting">
            <Columns>
                <asp:BoundField DataField="PlateNumber" HeaderText="Plate No" ReadOnly="True" />
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" ImageUrl='<%# "~/Images/Cars/" + Eval("CarImage") %>' Width="80px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Model" HeaderText="Model" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="PriceRate" HeaderText="Rate (RM)" DataFormatString="{0:F2}" />
                <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-primary" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>