using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Integrador_GF
{
    public partial class ERROR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Error"] != null)
            {
                lblErrorMessage.Text = Session["Error"].ToString();
                Session["Error"] = null;
            }
            else
            {
                lblErrorMessage.Text = "Ocurrió un error inesperado. Intente nuevamente más tarde.";
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx", true);
        }
    }
}