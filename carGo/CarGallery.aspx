<%@ Page Title="Car Gallery" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CarGallery.aspx.cs" Inherits="carGo.CarGallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Tema warna biru #0d6efd */
        .bg-brand { background-color: #0d6efd !important; }
        .text-brand { color: #0d6efd !important; }
        .btn-brand { background-color: #0d6efd; color: white; border-radius: 20px; border: none; padding: 8px 20px; }
        .btn-brand:hover { background-color: #0b5ed7; color: white; }
        
        /* Butang kiraan warna biru */
        .btn-calc { background-color: #0d6efd; color: white; border: none; font-weight: bold; width: 30px; }
        .btn-calc:hover { background-color: #0b5ed7; color: white; }
        
        .car-card { border-radius: 15px; border: none; transition: 0.3s; height: 100%; }
        .car-header { background-color: #0d6efd; border-radius: 15px 15px 0 0; padding: 25px; text-align: center; }
        
        /* Styling untuk butang kategori */
        .btn-filter { border: 1px solid #0d6efd; color: #0d6efd; border-radius: 50px; padding: 8px 25px; text-decoration: none; transition: 0.2s; }
        .btn-filter:hover, .btn-filter.active { background-color: #0d6efd; color: white; }
    </style>

    <div class="container mt-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Our Car Models</h2>
            <p class="text-muted">Our student car collection is designed with you in mind!</p>
        </div>

        <div class="d-flex justify-content-center gap-3 mb-5">
            <a href="CarGallery.aspx" class="btn btn-filter <%= string.IsNullOrEmpty(Request.QueryString["cat"]) ? "active" : "" %>">All</a>
            <a href="CarGallery.aspx?cat=Compact" class="btn btn-filter <%= Request.QueryString["cat"] == "Compact" ? "active" : "" %>">Compact</a>
            <a href="CarGallery.aspx?cat=Sedan" class="btn btn-filter <%= Request.QueryString["cat"] == "Sedan" ? "active" : "" %>">Sedan</a>
            <a href="CarGallery.aspx?cat=MPV" class="btn btn-filter <%= Request.QueryString["cat"] == "MPV" ? "active" : "" %>">MPV</a>
        </div>

        <div class="row">
            <asp:Repeater ID="rptCars" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4 car-item-container">
                        <div class="card car-card shadow-sm">
                            <div class="car-header">
                                <img src='<%# "Images/Cars/" + Eval("CarImage") %>' class="img-fluid" style="max-height: 120px;" alt="Car Image">
                            </div>
                            <div class="card-body text-center">
                                <h5 class="fw-bold"><%# Eval("Model") %></h5>
                                <div class="d-flex justify-content-around text-muted mb-3 small">
                                    <span><i class="fa fa-users"></i> 5</span>
                                    <span><i class="fa fa-suitcase"></i> 1</span>
                                    <span><i class="fa fa-cog"></i> Auto</span>
                                </div>

                                <div class="d-flex align-items-center justify-content-between mb-3 border rounded p-2">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-calc" onclick="updateQty(this, 1)">+</button>
                                        <button type="button" class="btn btn-sm btn-calc" onclick="updateQty(this, -1)">-</button>
                                    </div>
                                    
                                    <span class="fw-bold qty-display">1</span> 

                                    <span class="badge bg-light text-dark border">
                                        RM <span class="price-display" data-base-price='<%# Eval("PriceRate") %>'><%# Eval("PriceRate") %></span>
                                    </span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div class="text-start">
                                        <small class="text-muted d-block">Price per Day</small>
                                        <span class="text-brand fw-bold">MYR <%# Eval("PriceRate") %>/day</span>
                                    </div>
                                    <a href='BookCar.aspx?plate=<%# Eval("PlateNumber") %>' class="btn btn-brand">BOOK NOW</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
        function updateQty(element, change) {
            // Cari container kad yang sedang ditekan
            const cardBody = element.closest('.card-body');
            const qtyDisplay = cardBody.querySelector('.qty-display');
            const priceDisplay = cardBody.querySelector('.price-display');

            // Ambil harga asas (base price) dari attribute data
            const basePrice = parseFloat(priceDisplay.getAttribute('data-base-price'));

            // Dapatkan qty semasa
            let currentQty = parseInt(qtyDisplay.innerText);

            // Kira qty baru (jangan bagi kurang dari 1)
            let newQty = currentQty + change;
            if (newQty < 1) newQty = 1;

            // Update paparan qty
            qtyDisplay.innerText = newQty;

            // Kira jumlah harga baru (Qty * Harga Asal)
            let newTotal = (newQty * basePrice).toFixed(2);

            // Update paparan harga
            priceDisplay.innerText = newTotal;
        }
    </script>
</asp:Content>