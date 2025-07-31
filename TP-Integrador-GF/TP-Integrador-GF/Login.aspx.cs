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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
 
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            DatosUsuarios datosUsuarios = new DatosUsuarios();
            Usuarios user = new Usuarios();

            try
            {
                user.Email = TxtMail.Text;
                user.pass = TxtPass.Text;

                if(datosUsuarios.Logueo(user)==true)
                {
                    List<Usuarios> ListaUsuarios = datosUsuarios.Listar();
                    user = ListaUsuarios.Find(u => u.Email == user.Email);

                    if(user != null)
                    {
                        Session.Add("User", user);
                        Session.Add("IDPerfil", user.Perfil.idPerfil);
                        Response.Redirect("Default.aspx", true);
                    }
                    else
                    {
                        Session.Add("Error", "ERROR DE LOGUEO EN SERVIDOR");
                        Response.Redirect("ERROR.aspx");
                    }
                }
                else
                {
                    string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'CREDENCIALES INCORRECTAS' });";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}