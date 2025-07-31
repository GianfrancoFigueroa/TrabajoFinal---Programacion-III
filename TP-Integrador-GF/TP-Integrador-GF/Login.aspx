<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TP_Integrador_GF.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Logueo Callcenter</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
     
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
            box-sizing: border-box;
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



    </style>

        <script>
            function PasswordVisibility() {
                var passwordField = document.getElementById("TxtPass");
                var icon = document.getElementById("eyeIcon");
               
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
        <h2>Ingrese sus credenciales</h2>
        <form id="loginForm" runat="server">
            <asp:TextBox runat="server" CssClass="text" type="email" id="TxtMail" name="username" placeholder="email@example.com" required=""></asp:TextBox>

            <div style="position: relative;">
                <asp:TextBox runat="server" CssClass="text" type="password" id="TxtPass" name="password" placeholder="password" required=""></asp:TextBox>
                <button type="button" class="btn-eye" onclick="PasswordVisibility()">
                    <i id="eyeIcon" class="fa fa-eye"></i>
                </button>
            </div>

            <br />
            <a href="OlvideContraseña.aspx" style="display: flex; justify-content: center; text-decoration: none;"> 
                <label runat="server" id="lblOlvidePass" onclick="lblOlvidePass" style="font-size: 14px; color: #007bff; cursor: pointer;">Olvide mi contraseña...</label>
            </a>  
            <br />

            <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Login" />

            <footer>Diseñado por: <a>InciDesk</a></footer>
        </form>
    </div>

</body>

</html>
