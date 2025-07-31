using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Integrador_GF
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Usuarios UsuarioSesion = (Usuarios)Session["User"];

                if (UsuarioSesion == null)
                {
                    Session.Add("Error", "LOGUEARSE");
                    Response.Redirect("ERROR.aspx");
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
    }
}