 <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AltaClientes.aspx.cs" Inherits="TP_Integrador_GF.AltaClientes" %>




<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <style>

        .textBoxGrande {
            font-size: 16px;
        }

        .titulo {
            font-size: 28px; 
            font-weight: bold; 
            
        }

        .cuerpo {
            font-size: 16px; 
            font-weight: bold; 
            margin-bottom:20px;
        }

        
        .miDiv {
           
            width: 90%; 
            height: 100vh;
            background-color: #FFFFFF;
            margin: 0 auto; 
        }

        .Cardd {
            width: 90%; 
            max-width: 1200px; 
            height: auto; 
            min-height: 60vh; 
            background-color: #FFFFFF; 
            margin: 10px auto; 
            font-size: 14px; 
           
            border-radius: 8px; 
            padding: 10px; 
            box-sizing: border-box; 
        }

        .btnn {
            padding: 10px 20px;
            font-size: 20px;
            border-radius: 8px;
        }


    </style>

     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   
     <div class="container mb-2">

        <div class="row"  style="justify-content: flex-start;">
            <%if (Request.QueryString["id"] == null){ %>
                <h1 class="titulo">Nuevo Cliente</h1>
                <h5 class="cuerpo">Por favor complete los datos del nuevo cliente a dar de alta:</h5>  
            <%} %>
            <%else{ %>
                <h1 class="titulo">Editar Cliente</h1>
                <h5 class="cuerpo">Por favor complete los datos del cliente a editar:</h5>  
            <%} %>
                 
        </div>
      
         <br />
        <div class="row justify-content-center mb-3">
            <div class="card col-md-11">
                <div class="card-body align-content-center">
                      
                        <div class="Cardd">
                              
                        <br />
                        <br />

                       

                            <div class="row" style="font-size:14px;">
                              <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtNombre" class="form-label">Nombre:</label>
                                        <asp:TextBox ID="txtNombre" CssClass="form-control textBoxGrande" runat="server" required=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtApellido" class="form-label">Apellido:</label>
                                        <asp:TextBox ID="txtApellido" CssClass="form-control textBoxGrande" runat="server" required=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtDNI" class="form-label">DNI:</label>
                                        <asp:TextBox ID="txtDni" CssClass="form-control textBoxGrande" runat="server" TextMode="Number" required=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtDirecc" class="form-label">Dirección:</label>
                                        <asp:TextBox ID="txtDireccion" CssClass="form-control textBoxGrande" runat="server" required=""></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtProvincia" class="form-label">Provincia:</label>
                                        <asp:DropDownList ID="ddlProvincia" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control textBoxGrande" runat="server"></asp:DropDownList>
                                    </div>
                                </div>


                                <div class="col-md-4 mb-3">
                                    <div class="form-group">
                                        <label for="txtLocalidad" class="form-label">Localidad:</label>
                                        <asp:DropDownList ID="ddlLocalidad" CssClass="form-control textBoxGrande" runat="server"></asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-md-2 mb-2"></div>

                                <div class="col-md-4 mb-2">
                                    <div class="form-group">
                                        <label for="txtEmail" class="form-label">Email:</label>
                                        <asp:TextBox ID="txtEmail" CssClass="form-control textBoxGrande" runat="server" TextMode="Email" required=""></asp:TextBox>
                                        <br />
                                    </div>
                                </div>

                                <div class="col-md-4 mb-2">
                                    <div>
                                        <label for="txtTelefono" class="form-label">Teléfono:</label>
                                        <asp:TextBox ID="txtTelefono" CssClass="form-control textBoxGrande" runat="server" TextMode="phone" required=""></asp:TextBox>
                                        <br />
                                    </div>
                                </div>

                                <div class="col-md-2 mb-2"></div>

                                <div class="row my-3">
                                    <div class="col-12"></div>
                                </div>

                                <div class="row">
                                    <div class="col-md-2 offset-md-4 mb-2">
                                        <% if (Request.QueryString["id"] == null) { %>
                                            <asp:Button ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Cargar" />
                                        <% } else { %>
                                            <asp:Button ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Editar" />
                                        <% } %>
                                    </div>
                                    <div class="col-md-2 mb-2">
                                        <a href="Historial_Clientes.aspx" class="btn btn-danger btn-lg btnn">Cancelar</a>
                                    </div>
                                </div>

                                <h1 class="col-md-4 mb-2"></h1>

                        </div>
                    </div>
                    
                </div>
            </div>
        </div>

    </div>
      
</asp:Content>
