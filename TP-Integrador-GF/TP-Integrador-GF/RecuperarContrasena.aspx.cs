using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using conexiones;

namespace TP_Integrador_GF
{
    public partial class RecuperarContrasena : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                HttpCookie tokenCookie = Request.Cookies["TokenRecuperacion"];
                tokenCookie.Value = HttpUtility.UrlDecode(tokenCookie.Value);
                string tokenDesdeUrl = Request.QueryString["token"];
                string tokenRecibido = HttpUtility.UrlDecode(tokenDesdeUrl);

                if (tokenCookie == null || EsTokenValido(tokenRecibido) == false){
                   Session["Error"] = "ERROR LINK INVALIDO O ERROR EN COOKIES";
                   Server.Transfer("ERROR.aspx");
                }


            }
            catch (Exception ex)
            {

                throw ex;
            }
           

        }

        private bool EsTokenValido(String tokenRecibido)
        {
            try
            {
                HttpCookie tokenCookie = Request.Cookies["TokenRecuperacion"];
                tokenCookie.Value = HttpUtility.UrlDecode(tokenCookie.Value);

                if (tokenCookie.Value == tokenRecibido)
                {
                    return true;
                }
                else
                {
                    return false;
                }
              
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
                if(TxtNewPass.Text == TxtNewPass2.Text)
                {
                    string Mail = Session["MailRecuperacion"] as string;
                    DatosUsuarios usuarios = new DatosUsuarios();
                    List<Usuarios> ListUsers = usuarios.Listar();

                    Usuarios User = ListUsers.Find(u => u.Email == Mail);

                    if(usuarios.CambiarContra(TxtNewPass.Text, User.Id))
                    {
                        string script = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Contraseña cambiada con éxito!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Login.aspx';}});";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", script, true);
                    }
                    else
                    {
                        string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'ERROR DE SERVIDOR.' });";
                        ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                    }
                }
                else
                {
                    string script = "Swal.fire({icon: 'error', title: 'Éxito', text: 'LAS CONTRASEÑAS NO COINCIDEN'});";
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", script, true);
                }
            
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
 
    }
}