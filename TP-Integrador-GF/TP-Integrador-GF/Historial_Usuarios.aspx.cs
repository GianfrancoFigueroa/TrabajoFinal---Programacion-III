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
    public partial class Historial_Usuarios : System.Web.UI.Page
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

                if (!IsPostBack)
                {
                    CargarDdl();
                    CargarDatosGridView();

                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void CargarDdl()
        {
            try
            {
                ddlOrden.Items.Clear();
                ddlOrden.Items.Add(new ListItem("Seleccione una opción", "0"));
                ddlOrden.Items.Add(new ListItem("Orden Alfabetico: A - Z", "AZ"));
                ddlOrden.Items.Add(new ListItem("Orden Alfabetico: Z - A", "ZA"));
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void CargarDatosGridView()
        {
            try
            {
                DatosUsuarios usuarios = new DatosUsuarios();
                List<Usuarios> listaUsuarios = usuarios.Listar();

                ViewState["ListaUsuarios"] = listaUsuarios;

                var datosGrid = listaUsuarios.Select(u => new
                {
                    u.Id,
                    u.Nombre,
                    u.Apellido,
                    u.DNI,
                    u.Email,
                    Perfil = u.Perfil != null ? u.Perfil.Perfil : "N/A",
                    u.Domicilio,

                    Provincia = u.Provincia != null ? u.Provincia.provincia : "N/A",
                    Localidad = u.Localidad != null ? u.Localidad.localidad : "N/A"
                }).ToList();


                GridUsuarios.DataSource = datosGrid;
                GridUsuarios.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void CargarDatosGridView(List<Usuarios> listaUsuarios)
        {
            try
            {
                ViewState["ListaUsuarios"] = listaUsuarios;
                DatosUsuarios usuarios = new DatosUsuarios();

                var datosGrid = listaUsuarios.Select(u => new
                {
                    u.Id,
                    u.Nombre,
                    u.Apellido,
                    u.DNI,
                    u.Email,
                    Perfil = u.Perfil != null ? u.Perfil.Perfil : "N/A",
                    u.Domicilio,

                    Provincia = u.Provincia != null ? u.Provincia.provincia : "N/A",
                    Localidad = u.Localidad != null ? u.Localidad.localidad : "N/A"
                }).ToList();


                GridUsuarios.DataSource = datosGrid;
                GridUsuarios.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void GridUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                var id = GridUsuarios.SelectedDataKey.Value.ToString();
                Response.Redirect("AltaUsuarios?id=" + id, false);

            }
            catch (Exception ex)
            {

                throw ex;
            }


        }

        protected void GridUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridUsuarios.PageIndex = e.NewPageIndex;

                if (ViewState["ListaUsuarios"] != null)
                {
                    List<Usuarios> lista = (List<Usuarios>)ViewState["ListaUsuarios"];
                    CargarDatosGridView(lista); 
                }
                else
                {
                    CargarDatosGridView();  
                }

                GridUsuarios.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void GridUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                DatosUsuarios datos = new DatosUsuarios();
                int id = (int)GridUsuarios.DataKeys[e.RowIndex].Value;

                if (datos.Baja(id)){

                    string scriptBaja = "Swal.fire('Exito', 'Usuario eliminado con exito', 'success').then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Usuarios.aspx'; }});";
                    MostrarMensaje(scriptBaja);
                }
                else
                {
                    string scriptFalloBaja = "Swal.fire('Atención', 'No se pudo eliminar el usuario.', 'warning');";
                    MostrarMensaje(scriptFalloBaja);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void txtChange(object sender, EventArgs e)
        {
            try
            {
                Usuarios usuarios = new Usuarios();
                DatosUsuarios datosUsuarios = new DatosUsuarios();
                string DropDown = ddlOrden.SelectedValue;

                List<Usuarios> ListaUsers = datosUsuarios.Listar();

                if (DropDown != "0")
                {
                    if (DropDown == "AZ")
                    {
                        ListaUsers = datosUsuarios.ListaOrdenadaASC();
                    }
                    else if (DropDown == "ZA")
                    {
                        ListaUsers = datosUsuarios.ListaOrdenadaDESC();
                    }
                }

                if (!string.IsNullOrEmpty(txtBusqueda.Text))
                {
                    ListaUsers = ListaUsers.Where(u => u.DNI.ToString().Contains(txtBusqueda.Text) || u.Email.Contains(txtBusqueda.Text)).ToList();
                }
                CargarDatosGridView(ListaUsers);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }


        protected void ddlOrden_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DatosUsuarios datosUsuarios = new DatosUsuarios();
                List<Usuarios> Usuarios = new List<Usuarios>();

                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();
                string DropDown = ddlOrden.SelectedValue;

                if (DropDown == "AZ")
                {
                    Usuarios = datosUsuarios.ListaOrdenadaASC();
                }
                else if (DropDown == "ZA")
                {
                    Usuarios = datosUsuarios.ListaOrdenadaDESC();   
                }
                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                    Usuarios = Usuarios.Where(x => (x.DNI.ToString().ToLower().Contains(textoBusqueda))).ToList();

                }

                CargarDatosGridView(Usuarios);
               
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }

        protected void btnCargar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AltaUsuarios.aspx");
        }

        public void MostrarMensaje(string Script)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "MessageBox", Script, true);
        }
    }
}