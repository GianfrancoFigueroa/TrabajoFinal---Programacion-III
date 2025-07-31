<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TP_Integrador_GF.Contact" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head>

        <style>
          
            html, body {
                height: 100%;
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh; 
            }

            main {
                flex: 1; 
                display: flex;
                justify-content: center;
                align-items: stretch; 
                padding: 30px;
                padding-top: 0px;
                gap: 20px; 
            }

            .about-container, .info-and-map-container {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                flex: 1;
            }

            .info-and-map-container {
                display: flex;
                flex-direction: column;
                gap: 10px; 
                justify-content: center;
            }

            .info-container, .map-container {
                flex: 1;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 10px;
                text-align: center;
            }

            .about-container {
                margin: 11px;
                max-width: 850px;
                max-height: 950px;
                background-color: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .about-container h2 {
                color: #2c3e50;
                font-size: 28px;
                font-weight: bold;
            }

            .about-container p {
                color: #34495e;
                line-height: 1.8;
                font-size: 20px;
                margin-bottom: 10px;
            }

            button {
                background-color: #3498db;
                color: white;
                font-size: 16px;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #217dbb;
            }

            a {
                color: #3498db;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

        </style>
    </head>

    <body>
        <main>
         
            <div class="about-container">
               <h2>InciDesk</h2>
                <p>
                    En InciDesk, nos dedicamos a ofrecer soluciones tecnológicas innovadoras 
                    para optimizar la gestión empresarial. Nuestra misión es proporcionar herramientas 
                    de calidad que permitan a nuestros clientes alcanzar sus objetivos con eficiencia y confianza.
                </p>
                <p>
                    Con un equipo altamente capacitado y años de experiencia en la industria, 
                    trabajamos para garantizar que cada solución esté diseñada a la medida de tus necesidades. 
                </p>
                <p>
                    Nuestro objetivo es que cada cliente cuente con la información precisa y actualizada en todo momento. 
                    Por eso, desarrollamos soluciones que priorizan los datos, procesos y la accesibilidad de la información.
                </p>
                <p>
                    <a href="mailto:comercial@incidesk.com">Contáctanos</a> para más información.
                </p>
            </div>

            <div class="info-and-map-container">
              
                <div class="info-container">
                    <h3 style="color: #2c3e50;">Información de InciDesk</h3>
                    <p style="color: #34495e;"><strong>Dirección:</strong>Av. Hipólito Yrigoyen 288, B1617 Gral. Pacheco, Provincia de Buenos Aires, Argentina</p>
                    <p style="color: #34495e;"><strong>Horario de Atención:</strong> Lunes a Viernes, de 9:00 a 18:00</p>
                    <p style="color: #34495e;"><strong>Teléfono:</strong> 02320-628928</p>
                    <p style="color: #34495e;"><strong>Email:</strong> <a href="mailto:comercial@incidesk.com">comercial@incidesk.com</a></p>        
                   <p style="color: #34495e;"><strong>CUIT:</strong>30-12345678-9</p> 
                </div>

   
                <div class="map-container">
                    <h3 style="color: #2c3e50;">Ubicación</h3>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3289.8760470651987!2d-58.62676152353671!3d-34.45529424967607!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x95bca48d22673f87%3A0x8775d1ae9173ba5c!2sSecretar%C3%ADa%20de%20Extensi%C3%B3n%20Universitaria%20U.T.N.%20F.R.G.P!5e0!3m2!1ses!2sar!4v1747879683762!5m2!1ses!2sar" 
                        width="600" 
                        height="450" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                    <p>
                        <a href="https://maps.app.goo.gl/d4mCH4r8rJLVsK16A" target="_blank">Ver en Google Maps</a>
                    </p>
                </div>
            </div>

        </main>
    </body>

    </html>

</asp:Content>

