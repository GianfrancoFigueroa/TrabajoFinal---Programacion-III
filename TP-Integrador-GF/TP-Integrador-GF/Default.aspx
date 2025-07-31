 <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TP_Integrador_GF._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        
        .miDiv {
           
            width: 90%;
            height: 100vh;
            background-color: #FFFFFF;
            margin: 0 auto; 
        }

    </style>


    <div class="miDiv">

        
            <div class="jumbotron">
                <h1>Bienvenido a InciDesk</h1>
                <p class="lead">Portal de incidencias.</p>
                <p><a href="AltaIncidencias.aspx" class="btn btn-primary btn-lg">Abrir incidencia &raquo;</a></p>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <p style="font-size: 20px;">
                        <strong style="text-align: center;">InciDesk</strong> <br>
                        - Registro fácil y rápido.<br>
                        - Seguimiento en tiempo real.<br>
                        - Comunicación directa con soporte técnico.
                    </p>
                </div>
                <div class="col-md-4">
                     <p style="font-size: 20px;">
                       <strong>InciDesk</strong> Gestión y seguimiento de incidencias. <br>
                        Revise sus incidencias asignadas a diario y mantente al tanto de cada actualización.
                    </p>
                </div>
                <div class="col-md-4">
                    <p style="font-size: 20px;">
                        Ante cualquier duda o inconveniente tecnico, contactarse: <strong>Incidesk@tecnica.com</strong>
                    </p>
                </div>
            </div>
            


    </div>




    

</asp:Content>
