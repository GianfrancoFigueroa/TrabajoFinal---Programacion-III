<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AltaUsuarios.aspx.cs" Inherits="TP_Integrador_GF.AltaUsuarios" %>


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
            margin-bottom: 20px;
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
        <div class="row justify-content-md-center">
            <h1 class="titulo">Nuevo Usuario</h1>
            <h5 class="cuerpo">Por favor complete los datos del nuevo colaborador a dar de alta:</h5>
        </div>
        <br>
        <div class="row justify-content-center mb-3">
            <div class="card col-md-11">
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
                                <asp:DropDownList ID="ddlProvincia" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" required="" AutoPostBack="true" CssClass="form-control textBoxGrande" runat="server"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-4 mb-3">
                            <div class="form-group">
                                <label for="txtLocalidad" class="form-label">Localidad:</label>
                                <asp:DropDownList ID="ddlLocalidad" CssClass="form-control textBoxGrande" runat="server" required=""></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-4 mb-2">
                            <div class="form-group">
                                <label for="ddlPerfil" class="form-label">Perfil de usuario:</label>
                                <asp:DropDownList ID="ddlPerfil" CssClass="form-control textBoxGrande" runat="server" required=""></asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-4 mb-2">
                            <div class="form-group">
                                <label for="txtEmail" class="form-label">Email:</label>
                                <asp:TextBox ID="txtEmail" CssClass="form-control textBoxGrande" runat="server" TextMode="Email" required=""></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-4 mb-2">
                            <div class="form-group">
                                <Label for="TxtTel" runat="server" class="form-label"> Teléfono:  </Label>
                                <asp:TextBox ID="TxtTel" CssClass="form-control textBoxGrande" TextMode="phone" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-12 mb-4"></div>

                        <div class="col-md-3 mb-4"></div>

                        <div class="col-md-6 mb-4">
                            <div class="form-group">
                                <asp:Label ID="lblpass" runat="server" class="form-label"> Contraseña:  </asp:Label>
                                <asp:TextBox ID="Txtpass" CssClass="form-control textBoxGrande" runat="server" required=""></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-3 mb-4"></div>

                        <div class="col-md-12 mb-4"></div>
  
                            <div class="row">
                                <div class="col-md-2 offset-md-4 mb-2">
                                    <% if (Request.QueryString["id"] == null) { %>
                                            <asp:Button ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Cargar" />
                                    <% } else { %>
                                            <asp:Button ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Editar" />
                                    <% } %>
                                </div>
                                <div class="col-md-2 mb-2">
                                    <a href="Historial_Usuarios.aspx" class="btn btn-danger btn-lg btnn">Cancelar</a>
                                </div>
                            </div>

                        <h1 class="col-md-4 mb-2"></h1>

                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>




