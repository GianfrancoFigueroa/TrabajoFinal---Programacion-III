<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OlvideContraseña.aspx.cs" Inherits="TP_Integrador_GF.OlvideContraseña" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Logueo Callcenter</title>


    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            width: 300px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin: 100px auto 0 auto;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .text {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        .container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .container input[type="submit"]:hover {
            background-color: #45a049;
        }

        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
        }

    </style>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" />
   </head>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <body>

          <header>InciDesk</header>

        <%bool cc = (bool)ViewState["cc"]; %>
            <div class="container">
        <%if (cc == true){ %> 
                <h2>RECUPERAR CONTRASEÑA</h2>
                <label style="text-align: center; font-size: 14px; color: #555; display: block; margin: 10px auto;">A CONTINUACION, ESTA A PUNTO DE REESTABLECER SU CONTRASEÑA</label>
                <br />
                <form id="Form1" runat="server">
                     <asp:Button runat="server" ID="btnContinuar" OnClick="btnContinuar_Click" Text="CAMBIAR CONTRASEÑA" />
                </form>
        
        <%}%>
        <%else{ %>
                <h2>Ingrese sus datos</h2>
                <label style="text-align: center; font-size: 14px; color: #555; display: block; margin: 10px auto;">Verificaremos los datos ingresados y enviaremos un correo al mail detallado para recuperar su clave de ingreso...</label>
                <br />
                <form id="OlvideContraseñaForm" runat="server">

                    <asp:TextBox runat="server" CssClass="text" type="email" id="TxtEmail" name="password" placeholder="email@example.com" required=""></asp:TextBox>
                    <asp:Button runat="server" ID="btnEnviar" OnClick="btnEnviar_Click" Text="Enviar" />
                    <footer>Diseñado por: <a>InciDesk</a></footer>

                </form>
        <%}%>
            </div>
    </body>

</html>
