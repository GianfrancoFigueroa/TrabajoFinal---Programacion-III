using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using dominio;
using conexiones;

namespace TP_Integrador_GF
{
    public partial class OlvideContraseña : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                bool cc;
                if(Request.QueryString["token"] != null)
                {
                    cc = true;
                }
                else
                {
                    cc = false;
                }               
                
                ViewState["cc"] = cc;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            try
            {
                string MailDeclarado = TxtEmail.Text;
                DatosUsuarios datosUsuarios = new DatosUsuarios();
                List<Usuarios> ListUsers = datosUsuarios.Listar();
                Usuarios Usuario =  ListUsers.Find(U => U.Email == MailDeclarado);

                if (Usuario != null && Usuario.Email == MailDeclarado)
                {
                    EnviarMailRecuperacion(MailDeclarado);
                    Session["MailRecuperacion"] = MailDeclarado;
                    string script = "Swal.fire({icon: 'success', title: 'ENVIO DE EMAIL EXITOSO', text: 'REVISE SU CASILLA PARA RESTAURAR LA CONTRASEÑA.'}) ;";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorMailAlert", script, true);
                }
                else
                {
                    string script = "Swal.fire({icon: 'error', title: 'ERROR', text: 'MAIL NO REGISTRADO'}) ;";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorMailAlert", script, true);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnContinuar_Click(object sender, EventArgs e)
        {
            try
            {
                ViewState["cc"] = true;
                string TokenUrl = Request.QueryString["token"];
                Response.Redirect("RecuperarContrasena.aspx?token=" + TokenUrl);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string GenerarTokenRecuperacion()
        {
            try
            {
                string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
                HttpCookie tokenCookie = new HttpCookie("TokenRecuperacion")
                {
                    Value = token,
                    Expires = DateTime.Now.AddHours(1), 
                    HttpOnly = true, 
                    Secure = true, 
                };
                tokenCookie.SameSite = System.Web.SameSiteMode.Strict;
                Response.Cookies.Add(tokenCookie);

                return token;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public void EnviarMailRecuperacion(string emailUsuario)
        {
            try
            {
                string token = GenerarTokenRecuperacion();
                string enlaceRecuperacion = $"https://localhost:44328/OlvideContrase%C3%B1a?token={HttpUtility.UrlEncode(token)}";
                string mensaje = $@"
                    <!DOCTYPE html>
                    <html lang='es'>
                    <head>
                        <meta charset='UTF-8'>
                        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                        <title>Recuperar Contraseña</title>
                        <style>
                            body {{ font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; margin: 0; padding: 0; }}
                            .email-container {{ 
                                max-width: 600px; 
                                margin: 20px auto; 
                                background-color: #fff; 
                                padding: 20px; 
                                border-radius: 10px; 
                                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
                                border: 1px solid #ddd; /* Agrega bordes al contenido */
                            }}
                            .header {{ 
                                text-align: center; 
                                background-color: #d3d3d3; /* Cambiado a gris claro */
                                color: #333; /* Texto en un color oscuro */
                                padding: 10px 0; 
                                border-radius: 10px 10px 0 0; 
                            }}
                            .button {{ 
                                display: inline-block; 
                                margin: 20px 0; 
                                padding: 10px 20px; 
                                background-color: #d3d3d3; /* Cambiado a gris claro */
                                color: #333; /* Texto en un color oscuro */
                                text-decoration: none; 
                                font-size: 16px; 
                                border-radius: 5px; 
                                border: 1px solid #bbb; /* Bordes del botón */
                            }}
                            .footer {{ font-size: 12px; color: #666; text-align: center; margin-top: 20px; }}
                        </style>
                    </head>
                    <body>
                        <div class='email-container'>
                            <div class='header'>
                                <h1>Recuperación de Contraseña</h1>
                            </div>
                            <p>Hola,</p>
                            <p>Hemos recibido una solicitud para recuperar tu contraseña.</p>
                            <p>Por favor, haz clic en el siguiente botón para restablecerla:</p>
                            <p style='text-align: center;'>
                                <a href='{enlaceRecuperacion}' class='button'>RECUPERAR CONTRASEÑA</a>
                            </p>
                            <p>Este enlace es válido por <strong>1 hora</strong>.</p>
                            <p>Si no solicitaste este cambio, puedes ignorar este mensaje.</p>
                            <div class='footer'>
                                <p>&copy; 2025 InciDesk. Todos los derechos reservados.</p>
                            </div>
                        </div>
                    </body>
                    </html>";

                ServiceMail servicio = new ServiceMail();
                servicio.ArmarMail(emailUsuario, "Recuperación de contraseña", mensaje);
                servicio.EnviarMail();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }

}