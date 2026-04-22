<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
    CodeBehind="Register.aspx.cs" Inherits="carGo.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fa-solid fa-user-plus me-2"></i>Create New Account</h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtUsername" class="form-label">Username *</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" 
                                    placeholder="Enter your name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                                    ControlToValidate="txtUsername" ErrorMessage="Username is required"
                                    CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="txtICNumber" class="form-label">IC Number *</label>
                                <asp:TextBox ID="txtICNumber" runat="server" CssClass="form-control" 
                                    placeholder="e.g., 900101-01-1234" MaxLength="14"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvICNumber" runat="server" 
                                    ControlToValidate="txtICNumber" ErrorMessage="IC Number is required"
                                    CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revICNumber" runat="server" 
                                    ControlToValidate="txtICNumber" ErrorMessage="Invalid IC format"
                                    ValidationExpression="^\d{6}-\d{2}-\d{4}$" CssClass="text-danger small" 
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                                
                                <!-- Age display -->
                                <div class="mt-2" id="ageResult" style="display: none;">
                                    <span class="badge bg-info text-white" id="calculatedAge">Age: </span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="txtEmail" class="form-label">Email Address *</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                TextMode="Email" placeholder="example@email.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" ErrorMessage="Email is required"
                                CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                ControlToValidate="txtEmail" ErrorMessage="Invalid email format"
                                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" 
                                CssClass="text-danger small" Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:Label ID="lblEmailError" runat="server" CssClass="text-danger small" 
                                Visible="false"></asp:Label>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtPhone" class="form-label">Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" 
                                    placeholder="e.g., 012-3456789"></asp:TextBox>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="txtAddress" class="form-label">Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" 
                                    TextMode="MultiLine" Rows="2" placeholder="Enter your address"></asp:TextBox>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtPassword" class="form-label">Password *</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                                    TextMode="Password" placeholder="Minimum 6 characters"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                    ControlToValidate="txtPassword" ErrorMessage="Password is required"
                                    CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPassword" runat="server" 
                                    ControlToValidate="txtPassword" ErrorMessage="Minimum 6 characters"
                                    ValidationExpression="^.{6,}$" CssClass="text-danger small" 
                                    Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="txtConfirmPassword" class="form-label">Confirm Password *</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" 
                                    TextMode="Password" placeholder="Re-enter your password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                                    ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm password"
                                    CssClass="text-danger small" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvPassword" runat="server" 
                                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                                    ErrorMessage="Passwords do not match" CssClass="text-danger small" 
                                    Display="Dynamic"></asp:CompareValidator>
                            </div>
                        </div>
                        
                        <!-- Terms & Conditions Section -->
                        <div class="mb-3">
                            <div class="form-check">
                                <asp:CheckBox ID="cbTerms" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label" for="<%= cbTerms.ClientID %>">
                                    I agree to the Terms & Conditions
                                </label>
                            </div>
                            <!-- CustomValidator for Terms checkbox -->
                            <asp:CustomValidator ID="cvTerms" runat="server" 
                                ErrorMessage="You must agree to the terms and conditions"
                                OnServerValidate="cvTerms_ServerValidate" 
                                CssClass="text-danger small d-block"
                                Display="Dynamic"
                                ClientValidationFunction="validateTermsClient">
                            </asp:CustomValidator>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnRegister" runat="server" Text="Create Account" 
                                CssClass="btn btn-primary btn-lg" OnClick="btnRegister_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset Form" 
                                CssClass="btn btn-outline-secondary" CausesValidation="false" 
                                OnClick="btnReset_Click" />
                        </div>
                        
                        <div class="text-center mt-4">
                            <p class="text-muted">
                                Already have an account? 
                                <a href="Login.aspx" class="text-primary fw-bold">Login here</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        // Client-side validation for Terms checkbox
        function validateTermsClient(source, args) {
            var cbTerms = document.getElementById('<%= cbTerms.ClientID %>');
            args.IsValid = cbTerms.checked;
        }

        // Simple age calculation from IC
        function calculateAgeFromIC() {
            var icNumber = document.getElementById('<%= txtICNumber.ClientID %>').value;
            var ageResult = document.getElementById('ageResult');
            var calculatedAgeSpan = document.getElementById('calculatedAge');

            // Clear previous results
            ageResult.style.display = 'none';

            // Validate IC format
            var icPattern = /^(\d{6})-(\d{2})-(\d{4})$/;
            if (!icPattern.test(icNumber)) {
                return false;
            }

            // Extract year from IC (first 2 digits)
            var yearPart = parseInt(icNumber.substring(0, 2));

            // Determine century
            var currentYear = new Date().getFullYear();
            var currentShortYear = currentYear % 100;
            var century = (yearPart <= currentShortYear) ? 2000 : 1900;
            var birthYear = century + yearPart;

            // Calculate age
            var age = currentYear - birthYear;

            // Adjust if birthday hasn't occurred this year
            var currentMonth = new Date().getMonth() + 1; // JavaScript months are 0-indexed
            var birthMonth = parseInt(icNumber.substring(2, 4));
            var birthDay = parseInt(icNumber.substring(4, 6));
            var currentDay = new Date().getDate();

            if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
                age--;
            }

            // Display results
            calculatedAgeSpan.textContent = "Age: " + age + " years";
            ageResult.style.display = 'block';

            return true;
        }

        // Auto-format IC number
        document.getElementById('<%= txtICNumber.ClientID %>').addEventListener('input', function (e) {
            var value = e.target.value.replace(/\D/g, '');
            if (value.length > 6) {
                value = value.substring(0, 6) + '-' + value.substring(6, 8) + '-' + value.substring(8, 12);
            }
            e.target.value = value;
        });
        
        // Calculate age when IC field loses focus
        document.getElementById('<%= txtICNumber.ClientID %>').addEventListener('blur', calculateAgeFromIC);
    </script>
</asp:Content>