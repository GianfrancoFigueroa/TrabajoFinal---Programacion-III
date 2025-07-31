<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ERROR.aspx.cs" Inherits="TP_Integrador_GF.ERROR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-container {
            width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .error-container h1 {
            font-size: 24px;
            color: #d9534f;
            margin-bottom: 10px;
        }

        .error-container p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }

        .error-container button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .error-container button:hover {
            background-color: #45a049;
        }

        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 100px;
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
</head>
<body>
    <header>InciDesk</header>
    <form id="errorForm" runat="server">
        <div class="error-container">
            <h1>ERROR WEB</h1>
            <p><strong>Descripción del error:</strong></p>
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Text="Ocurrió un error inesperado."></asp:Label>
            <br /><br />
            <asp:Button runat="server" ID="btnBack" OnClick="btnBack_Click" Text="Volver Atrás" />
        </div>
    </form>
</body>
</html>
