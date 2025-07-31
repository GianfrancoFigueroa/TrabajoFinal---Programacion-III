using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace TP_Integrador_GF
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void BtnSalir_onclick(object sender, EventArgs e)
        {
            Session.Clear(); 
            Session.Abandon();
            Response.Redirect("Login.aspx");

        }
    }
}