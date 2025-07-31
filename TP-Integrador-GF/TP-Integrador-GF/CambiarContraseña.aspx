<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CambiarContraseña.aspx.cs" Inherits="TP_Integrador_GF.CambiarContraseña" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Enlace a Font Awesome para los íconos -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />

    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .modalPopupOscuro {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .Cardd {
            background-color: #fff;
            max-width: 500px;
            width: 90%;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-size: 14px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .input-group {
            position: relative;
        }

        .form-control {
            font-size: 16px;
            padding: 10px;
            padding-right: 40px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            position: relative; 
        }

        .form-control:focus {
            outline: none;
            border-color: #007bff;
        }

        .btn-eye {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background-color: transparent;
            border: none;
            cursor: pointer;
            font-size: 18px;
            z-index: 10; 
        }

        .btn-eye i {
            pointer-events: none;
        }

        .btnGuardar,
        .btnCancelar {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            width: 48%;
            margin-top: 20px;
        }

        .btnGuardar {
            background-color: darkgreen;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btnGuardar:hover {
            background-color: green;
        }

        .btnCancelar {
            background-color: crimson;
            color: white;
            text-decoration: none;
        }

        .btnCancelar:hover {
            background-color: darkred;
        }

        @media (max-width: 768px) {
            .Cardd {
                width: 95%;
                font-size: 14px;
            }

        }

    </style>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function toggleVisibility(clientId) {
            var textBox = document.getElementById(clientId);
            var buttonIcon = event.target.tagName === 'I' ? event.target : event.target.querySelector('i');

            if (textBox.type === "password") {
                textBox.type = "text";
                buttonIcon.classList.remove("fa-eye");
                buttonIcon.classList.add("fa-eye-slash");
            } else {
                textBox.type = "password";
                buttonIcon.classList.remove("fa-eye-slash");
                buttonIcon.classList.add("fa-eye");
            }
        }
    </script>

    <div class="modalPopupOscuro">
        <div class="Cardd">
            <h1>CAMBIAR CONTRASEÑA</h1>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>

            <div class="form-group">
                <label for="txtPassActual">Contraseña Actual:</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassActual" CssClass="form-control" TextMode="Password" runat="server" />
                    <button type="button" class="btn-eye" onclick="toggleVisibility('<%= txtPassActual.ClientID %>')">
                        <i class="fa fa-eye"></i>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="txtPassNueva">Contraseña Nueva:</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassNueva" CssClass="form-control" TextMode="Password" runat="server" />
                    <button type="button" class="btn-eye" onclick="toggleVisibility('<%= txtPassNueva.ClientID %>')">
                        <i class="fa fa-eye"></i>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="txtPassNueva2">Repita la Contraseña Nueva:</label>
                <div class="input-group">
                    <asp:TextBox ID="txtPassNueva2" CssClass="form-control" TextMode="Password" runat="server" />
                    <button type="button" class="btn-eye" onclick="toggleVisibility('<%= txtPassNueva2.ClientID %>')">
                        <i class="fa fa-eye"></i>
                    </button>
                </div>
            </div>

            <div style="display: flex; justify-content: space-between;">
                <asp:Button ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btnGuardar" runat="server" Text="Guardar" />
                <a href="Default.aspx" class="btnCancelar">Cancelar</a>
            </div>
        </div>
        
    </div>
</asp:Content>






