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
    public partial class AltaClientes : System.Web.UI.Page
    {
        AccesoDatos datos = new AccesoDatos();


        protected void Page_Load(object sender, EventArgs e)
        {
            Usuarios UsuarioSesion = (Usuarios)Session["User"];

            Clientes edit = new Clientes();
            DatosClientes clientes = new DatosClientes();
            List<Clientes> idObtenido = clientes.Listar();

            DatosProvincias provincias = new DatosProvincias();
            DatosLocalidades localidades = new DatosLocalidades();

            try
            {
                if (UsuarioSesion == null)
                {
                    Session.Add("Error", "LOGUEARSE");
                    Response.Redirect("ERROR.aspx");
                }
                if (!IsPostBack)
                {
                        ddlProvincia.DataSource = provincias.Listar();
                        ddlProvincia.DataTextField = "provincia";
                        ddlProvincia.DataValueField = "ID";
                        ListItem itemProv = new ListItem("Seleccione una provincia", ""); 
                        ddlProvincia.DataBind();

                    if (Request.QueryString["id"] == null)
                    {
                        ListItem itemLocalidad = new ListItem("Seleccione una provincia", "");
                        ddlLocalidad.Items.Insert(0, itemLocalidad);
                        ddlProvincia.Items.Insert(0, itemProv);
                        ddlLocalidad.DataBind();
                    }
                    else
                    {
                        txtNombre.Enabled = false;
                        txtApellido.Enabled = false;
                        txtDni.Enabled = false;
                        txtEmail.Enabled = false;
                        txtTelefono.Enabled = false;
                        txtDireccion.Enabled = false;
                        ddlProvincia.Enabled = false;
                        ddlLocalidad.Enabled = false;

                        int id = int.Parse(Request.QueryString["id"]);
                        edit = idObtenido.FirstOrDefault(r => r.Id == id);

                        if (edit != null)
                        {
                            txtNombre.Text = edit.Nombre;
                            txtApellido.Text = edit.Apellido;
                            txtDni.Text = edit.DNI.ToString();
                            txtEmail.Text = edit.Email;
                            txtTelefono.Text = edit.Telefono;
                            txtDireccion.Text = edit.Domicilio;

                            ddlProvincia.SelectedValue = edit.Provincia.id.ToString();
                            ddlLocalidad.SelectedValue = edit.Localidad.id.ToString();

                            int pp = edit.Provincia.id;

                            ddlLocalidad.DataSource = localidades.Listar(pp);
                            ddlLocalidad.DataTextField = "localidad";
                            ddlLocalidad.DataValueField = "ID";
                            ddlLocalidad.DataBind();

                        }
                    
                    }
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

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DatosLocalidades localidades = new DatosLocalidades();
           
            try
            {
                int idp = int.Parse(ddlProvincia.SelectedValue);
                ddlLocalidad.DataSource = localidades.Listar(idp);
                ddlLocalidad.DataTextField = "localidad";
                ddlLocalidad.DataValueField = "ID";
                ddlLocalidad.DataBind();
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Clientes add = new Clientes();
            DatosClientes clientes = new DatosClientes();
            List<Clientes> ComprobarDNI = clientes.Listar();

            try
            {    
                    add.Nombre = txtNombre.Text;
                    add.Apellido = txtApellido.Text;
                    add.DNI = int.Parse(txtDni.Text);
                    add.Email = txtEmail.Text;
                    add.Telefono = txtTelefono.Text;
                    add.Domicilio = txtDireccion.Text;

                    add.Provincia = new Provincias();
                    add.Provincia.id = int.Parse(ddlProvincia.SelectedValue);
                    add.Provincia.provincia = ddlProvincia.SelectedItem.Text;

                    add.Localidad = new Localidades();
                    add.Localidad.id = int.Parse(ddlLocalidad.SelectedValue);
                    add.Localidad.localidad = ddlLocalidad.SelectedItem.Text;

                    Clientes prueba = ComprobarDNI.Find(d => d.DNI == add.DNI);

                    if (prueba != null)
                    {
                        string scriptError = "Swal.fire({ icon: 'error', title: 'Error', text: 'DNI YA REGISTRADO.' });";
                        MostrarMensaje(scriptError);
                        return;
                    }
                    else
                    {
                        if (clientes.Agregar(add) == true)
                        {
                            string script = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Cliente Agregado!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Usuarios.aspx';}});";
                            MostrarMensaje(script);
                        }
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

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            DatosClientes Cliente = new DatosClientes();
            Clientes aux = new Clientes();
            Provincias pop = new Provincias();
            Localidades lol = new Localidades();
            List<Clientes> idEdit = Cliente.Listar();
        
            try
            {
                int idobtenido = int.Parse(Request.QueryString["id"]);
                aux = idEdit.FirstOrDefault(r => r.Id == idobtenido);
                if (cc == true)
                {
                    if (aux != null)
                    {
                        aux.Nombre = txtNombre.Text;
                        aux.Apellido = txtApellido.Text;
                        aux.DNI = int.Parse(txtDni.Text);
                        aux.Domicilio = txtDireccion.Text;
                        aux.Email = txtEmail.Text;
                        aux.Telefono = txtTelefono.Text;

                        aux.Provincia = new Provincias();
                        aux.Provincia.id = int.Parse(ddlProvincia.SelectedValue);
                        aux.Provincia.provincia = ddlProvincia.SelectedItem.Text;

                        aux.Localidad = new Localidades();
                        aux.Localidad.id = int.Parse(ddlLocalidad.SelectedValue);
                        aux.Localidad.localidad = ddlLocalidad.SelectedItem.Text;

                        cc = false;

                        List<Clientes> ListaUs = Cliente.Listar();
                        Clientes quedoigual = ListaUs.Find(p => p.Id == idobtenido);

                        if (aux.TieneDiferenciasCon(quedoigual) == true)
                        {
                            string scriptError = "Swal.fire('ERROR', 'NO HAY CAMBIOS EN EL REGISTRO', 'warning');";
                            MostrarMensaje(scriptError);
                        }
                        else if (Cliente.Update(aux) == true)
                        {
                            string scriptActualizado = "Swal.fire('Exito', 'Cliente actualizado con exito', 'success').then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Clientes.aspx';}});";
                            MostrarMensaje(scriptActualizado);
                        }
                        else
                        {
                            string script = "Swal.fire({icon: 'error', title: '¡Cliente NO Actualizado!', text: 'ERROR NO SE A PODIDO ACTUALIZAR'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                            MostrarMensaje(script);
                        }
                    }
                }
                else { 
                    txtNombre.Enabled = true;
                    txtApellido.Enabled = true;
                    txtDireccion.Enabled = true;
                    txtDni.Enabled = true;  
                    txtEmail.Enabled = true;
                    txtTelefono.Enabled = true;
                    ddlLocalidad.Enabled = true;
                    ddlProvincia.Enabled = true;
                    cc = true;
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


        public void MostrarMensaje(string Script)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "MessageBox", Script, true);
        }

        public bool cc
        {
            get
            {
                return ViewState["cc"] != null && (bool)ViewState["cc"];
            }
            set
            {
                ViewState["cc"] = value;
            }
        }

    }
}