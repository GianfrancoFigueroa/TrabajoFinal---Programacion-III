using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using conexiones;
using dominio;

namespace TP_Integrador_GF
{
    public partial class Historial_Clientes : System.Web.UI.Page
    {

        AccesoDatos datos = new AccesoDatos();
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuarios UsuarioSesion = (Usuarios)Session["User"];
            try
            {
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
            finally
            {
                datos.cerrarConexion();
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
                DatosClientes clientes = new DatosClientes();
                List<Clientes> listaClientes = clientes.Listar();
                ViewState["ListaClientes"] = listaClientes;

                var datosGrid = listaClientes.Select(u => new
                {
                    u.Id,
                    u.Nombre,
                    u.Apellido,
                    u.DNI,
                    u.Email,
                    u.Telefono,
                    u.Domicilio,

                    Provincia = u.Provincia != null ? u.Provincia.provincia : "N/A",
                    Localidad = u.Localidad != null ? u.Localidad.localidad : "N/A"
                }).ToList();


                GridClientes.DataSource = datosGrid;
                GridClientes.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
       
        }

        protected void CargarDatosGridView(List<Clientes> listaClientes)
        {
            try
            {

                DatosClientes clientes = new DatosClientes();
                ViewState["ListaClientes"] = listaClientes;

                var datosGrid = listaClientes.Select(u => new
                {
                    u.Id,
                    u.Nombre,
                    u.Apellido,
                    u.DNI,
                    u.Email,
                    u.Telefono,
                    u.Domicilio,

                    Provincia = u.Provincia != null ? u.Provincia.provincia : "N/A",
                    Localidad = u.Localidad != null ? u.Localidad.localidad : "N/A"
                }).ToList();

                GridClientes.DataSource = datosGrid;
                GridClientes.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void GridClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridClientes.PageIndex = e.NewPageIndex;

                if (ViewState["ListaClientes"] != null)
                {
                    List<Clientes> lista = (List<Clientes>)ViewState["ListaClientes"];
                    CargarDatosGridView(lista);
                }
                else
                {
                    CargarDatosGridView();
                }

                GridClientes.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void GridClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var id = GridClientes.SelectedDataKey.Value.ToString();
                Response.Redirect("AltaClientes?id=" + id, false);

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        protected void GridClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                DatosClientes datos = new DatosClientes();
                int id = (int)GridClientes.DataKeys[e.RowIndex].Value;

                if (datos.Baja(id))
                {
                    string scriptBaja = "Swal.fire('Exito', 'Cliente eliminado con exito', 'success').then(function() {window.location.href = 'Historial_Clientes.aspx';});;";
                    MostrarMensaje(scriptBaja);
                }
                else
                {
                    string scriptFalloBaja = "Swal.fire('Atención', 'No se pudo eliminar el cliente.', 'warning');";
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
                DatosClientes datosClientes = new DatosClientes();

                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();

                List<Clientes> clientes = datosClientes.Listar();


                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                   clientes = clientes.Where(x => (x.DNI.ToString().ToLower().Contains(textoBusqueda)) || x.Email.Contains(txtBusqueda.Text)).ToList();
                }

                CargarDatosGridView(clientes);  

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
                DatosClientes datosClientes = new DatosClientes();
                List<Clientes> clientes = new List<Clientes>();

                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();
                string DropDown = ddlOrden.SelectedValue;

                if (DropDown == "AZ")
                {
                    clientes = datosClientes.ListarOrdenadoASC();
                }
                else if (DropDown == "ZA")
                {
                    clientes = datosClientes.ListarOrdenadoDESC();
                }

                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                    clientes = clientes.Where(x => (x.DNI.ToString().ToLower().Contains(textoBusqueda))).ToList();
                }

                CargarDatosGridView(clientes);

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnCargar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AltaClientes.aspx");
        }
        public void MostrarMensaje(string Script)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", Script, true);
        }
    }
}