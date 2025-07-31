<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerfilUsuario.aspx.cs" Inherits="TP_Integrador_GF.PerfilUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        .form-control {
            font-size: 18px;
            width: 100%; 
            height: 40px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .profile-container {
            max-width: 900px;
            background-color: #fff;
            margin: 30px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .profile-image-container {
            display: flex;
            position: relative;
            justify-content: center;
            margin-bottom: 20px;
            margin: 0 auto;
            border-radius: 50%; 
            overflow: hidden;
            width: 250px; 
            height: 250px; 
        }

        .profile-image {
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
        }


        .upload-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%; 
            height: 100%; 
            background-color: rgba(0, 0, 0, 0.5); 
            border-radius: 50%; 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            opacity: 0; 
            transition: opacity 0.3s ease;
        }

        
        .profile-image-container:hover .upload-overlay {
            opacity: 1;
        }

 
        .upload-button {
            background-color: #ffffff;
            color: #000;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .file-upload {
            display: none; 
        }

        .titulo {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .btnn {
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 8px;
            width: 45%; 
        }

        .row {
            margin-bottom: 15px;
        }

    </style>

   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <div class="profile-container">

        <div class="profile-image-container">
            
            <asp:Image runat="server" ID="imgProfile" CssClass="profile-image" />

            <div class="upload-overlay">
                <asp:FileUpload ID="fileUploadProfile" runat="server" CssClass="file-upload" />
                <asp:Button ID="btnCargarFoto" runat="server" Text="Subir Imagen" OnClick="btnCargarFoto_Click" CssClass="upload-button" />
            </div>
        </div>

        <h1 class="titulo">Perfil de Usuario</h1>


        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="txtNombre" class="form-label">Nombre:</label>
                <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-md-6 mb-3">
                <label for="txtApellido" class="form-label">Apellido:</label>
                <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="txtDni" class="form-label">DNI:</label>
                <asp:TextBox ID="txtDni" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-md-6 mb-3">
                <label for="txtDireccion" class="form-label">Dirección:</label>
                <asp:TextBox ID="txtDireccion" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="ddlProvincia" class="form-label">Provincia:</label>
                <asp:DropDownList ID="ddlProvincia" CssClass="form-control" runat="server"></asp:DropDownList>
            </div>
            <div class="col-md-6 mb-3">
                <label for="ddlLocalidad" class="form-label">Localidad:</label>
                <asp:DropDownList ID="ddlLocalidad" CssClass="form-control" runat="server"></asp:DropDownList>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="txtEmail" class="form-label">Email:</label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-md-6 mb-3">
                <label for="txtTelefono" class="form-label">Teléfono:</label>
                <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>

        <!-- Botones -->
        <div class="btn-container">
            <a href="Default.aspx" class="btn btn-danger btn-lg btnn">Atras</a>
        </div>
    </div>

    
        <script>
          document.getElementById('<%= btnCargarFoto.ClientID %>').addEventListener('click', function(e) {
            e.preventDefault(); // Prevenir postback para abrir el selector primero
            document.getElementById('<%= fileUploadProfile.ClientID %>').click(); 
          });

          document.getElementById('<%= fileUploadProfile.ClientID %>').addEventListener('change', function() {
             __doPostBack('<%= btnCargarFoto.UniqueID %>', '');
          });
        </script>

</asp:Content>





