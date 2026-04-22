<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminMessages.aspx.cs" Inherits="carGo.AdminMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="AdminMessages.css" rel="stylesheet" type="text/css" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container py-5">
        
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">

                <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
                    
                    <div>
                        <h3 class="mb-0 text-dark">Inbox</h3>
                        <small class="text-muted">Customer inquiries management</small>
                        <br />
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
                    </div>

                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlSearchType" runat="server" CssClass="form-select" Width="110px">
                            <asp:ListItem Value="Name">Name</asp:ListItem>
                            <asp:ListItem Value="Email">Email</asp:ListItem>
                            <asp:ListItem Value="MessageId">ID</asp:ListItem>
                        </asp:DropDownList>

                        <div class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                        </div>

                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="MessageId" 
                        OnRowDeleting="gvMessages_RowDeleting"
                        OnRowCommand="gvMessages_RowCommand"
                        CssClass="table table-hover align-middle custom-table" 
                        GridLines="Horizontal"
                        HeaderStyle-CssClass="table-light text-muted"
                        EmptyDataText="No messages found.">
                        
                        <Columns>
                            <asp:BoundField DataField="MessageId" HeaderText="#" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" />
                            
                            <asp:BoundField DataField="DateTime" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-Width="12%" />

                            <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Font-Bold="true" ItemStyle-Width="13%" />

                            <asp:TemplateField HeaderText="Email" ItemStyle-Width="18%">
                                <ItemTemplate>
                                    <div class="text-muted" style="word-wrap: break-word;"><%# Eval("Email") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Message" ItemStyle-Width="32%">
                                <ItemTemplate>
                                    <div class="message-cell">
                                        <%# Eval("Text") %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span class='badge <%# Eval("Status").ToString() == "Resolved" ? "bg-success" : "bg-warning text-dark" %> rounded-pill'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm actions-cell">
                                        <asp:LinkButton ID="btnStatus" runat="server" 
                                            CommandArgument='<%# Eval("MessageId") %>' 
                                            CommandName="ToggleStatus"
                                            Text='<%# Eval("Status").ToString() == "Pending" ? "Done" : "Undo" %>'
                                            CssClass="btn btn-outline-primary" />

                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                            OnClientClick="return confirm('Delete?');"
                                            CssClass="btn btn-outline-danger">
                                            <i class="fas fa-trash"></i> Del
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </div>
    </div>

</asp:Content>