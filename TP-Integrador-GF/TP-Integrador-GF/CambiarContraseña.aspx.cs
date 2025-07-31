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
    public partial class CambiarContraseña : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuarios User = (Usuarios)Session["User"];

            if (User == null)
            {   

                Session.Add("Error", "ERROR");
                Response.Redirect("ERROR.aspx");

            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            DatosUsuarios datosUsuario = new DatosUsuarios();
            Usuarios User = new Usuarios();
            User = (Usuarios) Session["User"];

            try
            {
                if(txtPassActual.Text == User.pass)
                {
                    if(txtPassNueva.Text == txtPassNueva2.Text)
                    {
                        datosUsuario.CambiarContra(txtPassNueva2.Text, User.Id);
                        string script = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Contraseña cambiada con éxito!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Default.aspx';}});";
                        ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", script, true);                       
                    }
                    else
                    {
                        string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'La nueva contraseña no coincide con la confirmación.' });";
                        ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                    }
                }
                else
                {
                    string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'La contraseña actual no es la correcta.' });";
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