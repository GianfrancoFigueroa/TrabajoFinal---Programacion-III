<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContrasena.aspx.cs" Inherits="TP_Integrador_GF.RecuperarContrasena" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet"/>
    <title>Logueo Callcenter</title>


    <style>

    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0; /* para que el header y footer se vean bien */
        padding-top: 60px; /* espacio para el header fijo */
        padding-bottom: 40px; /* espacio para el footer fijo */
    }

    header, footer {
        background-color: #333;
        color: #fff;
        text-align: center;
        padding: 10px;
        position: fixed;
        left: 0;
        right: 0;
        z-index: 999;
    }

    header {
        top: 0;
    }

    footer {
        bottom: 0;
    }

    .container {
        width: 300px;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        margin: 0 auto;
    }

    .container h2 {
        text-align: center;
        margin-bottom: 10px;
    }

    .text {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        margin-bottom: 10px;
        padding-right: 35px; /* espacio para el botón del ojito */
    }

    .btn-eye {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        color: #007bff; 
        font-size: 16px;
    }

    .ContenedorPass {
        position: relative;
        margin-bottom: 15px;
    }

    
    #Button1 {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    #Button1:hover {
        background-color: #45a049;
    }

    </style>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            function PasswordVisibility(inputId, iconId) {
                var passwordField = document.getElementById(inputId);
                var icon = document.getElementById(iconId);

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>
</head>

<body>

      <header>InciDesk</header>

        <div class="container">
            <h2>RECUPERAR CONTRASEÑA</h2>
            <label style="text-align: center; font-size: 14px; color: #555; display: block; margin: 10px auto;">A CONTINUACION, INGRESE SU NUEVA CONTRASEÑA</label>
            <br />
            <form id="Form1" runat="server">

            <div class="ContenedorPass">
                <asp:TextBox runat="server" CssClass="text" type="password" id="TxtNewPass" name="password" placeholder="INGRESE LA NUEVA CONTRASEÑA" required=""></asp:TextBox>
                <button type="button" class="btn-eye" onclick="PasswordVisibility('TxtNewPass', 'eyeIcon1')">
                    <i id="eyeIcon1" class="fa fa-eye"></i>
                </button>
            </div>

            <div class="ContenedorPass">
                <asp:TextBox runat="server" CssClass="text" type="password" id="TxtNewPass2" name="password" placeholder="REPITA LA CONTRASEÑA" required=""></asp:TextBox>
                <button type="button" class="btn-eye" onclick="PasswordVisibility('TxtNewPass2', 'eyeIcon2')">
                    <i id="eyeIcon2" class="fa fa-eye"></i>
                </button>
            </div>

                 <asp:Button runat="server" ID="Button1" OnClick="btnEnviar_Click" Text="Enviar" />

            </form>
        </div>
  
     <footer>Diseñado por: <a>InciDesk</a></footer>

</body>

</html>

