using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using conexiones;
using Microsoft.Ajax.Utilities;

namespace TP_Integrador_GF
{
    public partial class AltaUsuarios : System.Web.UI.Page
    {
        AccesoDatos datos = new AccesoDatos();

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuarios edit = new Usuarios();
            DatosUsuarios usuarios = new DatosUsuarios();
            List<Usuarios> idobtenido = usuarios.Listar();

            DatosProvincias provincias = new DatosProvincias();
            DatosLocalidades localidades = new DatosLocalidades();
            DatosPerfiles perfiles = new DatosPerfiles();

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
 
                    ddlProvincia.DataSource = provincias.Listar();
                    ddlProvincia.DataTextField = "provincia";
                    ddlProvincia.DataValueField = "ID";
                    ddlProvincia.DataBind();

                    ddlPerfil.DataSource = perfiles.Listar();
                    ddlPerfil.DataTextField = "Perfil";
                    ddlPerfil.DataValueField = "idPerfil";
                    ddlPerfil.DataBind();

                    if (Request.QueryString["id"] == null)
                    {
                        ddlLocalidad.Items.Insert(0, "Seleccione una localidad");
                        ddlProvincia.Items.Insert(0, "Seleccione una provincia");
                        ddlLocalidad.DataBind();
                    }
                    else
                    {
                        txtNombre.Enabled = false;
                        txtApellido.Enabled = false;
                        txtDni.Enabled = false;
                        txtEmail.Enabled = false;
                        txtDireccion.Enabled = false;
                        ddlProvincia.Enabled = false;
                        ddlLocalidad.Enabled = false;
                        ddlPerfil.Enabled = false;
                        TxtTel.Enabled = false;
                        Txtpass.Visible = false;
                        lblpass.Visible = false;

                        int id = int.Parse(Request.QueryString["id"]);
                        edit = idobtenido.FirstOrDefault(r => r.Id == id);

                        if (edit != null)
                        {

                            txtNombre.Text = edit.Nombre;
                            txtApellido.Text = edit.Apellido;
                            txtDni.Text = edit.DNI.ToString();
                            txtEmail.Text = edit.Email;
                            txtDireccion.Text = edit.Domicilio;
                            TxtTel.Text = edit.Tel;
 
                            int pp = edit.Provincia.id;

                            List<Localidades> ListaLocalidades = localidades.Listar(pp);
                            ddlLocalidad.DataSource = ListaLocalidades;
                            ddlLocalidad.DataTextField = "localidad";
                            ddlLocalidad.DataValueField = "ID";
                            ddlLocalidad.DataBind();

                            ddlProvincia.SelectedValue = edit.Provincia.id.ToString();
                            ddlLocalidad.SelectedValue = edit.Localidad.ToString();
                            ddlPerfil.SelectedValue = edit.Perfil.idPerfil.ToString();
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
            AccesoDatos datos = new AccesoDatos();
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
            Usuarios add = new Usuarios();
            DatosUsuarios usuarios = new DatosUsuarios();

            List<Usuarios> ComprobarDNI = usuarios.Listar();

            try
            {
                if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtApellido.Text) ||
                   string.IsNullOrWhiteSpace(txtDni.Text) || string.IsNullOrWhiteSpace(txtDireccion.Text) ||
                   string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    string script = "alert('Por favor complete todos los campos.');"; 
                    MostrarMensaje(script);
                    return;
                }

                add.Nombre = txtNombre.Text;
                add.Apellido = txtApellido.Text;
                add.DNI = int.Parse(txtDni.Text);
                add.Domicilio = txtDireccion.Text;
                add.Email = txtEmail.Text;
                add.Tel = TxtTel.Text;
                add.FechaAlta = DateTime.Now;
                add.pass = Txtpass.Text;

                add.Perfil = new Perfiles();
                add.Perfil.idPerfil = int.Parse(ddlPerfil.SelectedValue);
                add.Perfil.Perfil = ddlPerfil.SelectedItem.Text;

                add.Provincia = new Provincias();
                add.Provincia.id = int.Parse(ddlProvincia.SelectedValue);
                add.Provincia.provincia = ddlProvincia.SelectedItem.Text;

                add.Localidad = new Localidades();
                add.Localidad.id = int.Parse(ddlLocalidad.SelectedValue);
                add.Localidad.localidad = ddlLocalidad.SelectedItem.Text;

                Usuarios prueba = ComprobarDNI.Find(d => d.DNI == add.DNI);

                if (prueba != null)
                {
                    string script = "Swal.fire({ icon: 'error', title: 'Error', text: 'DNI YA REGISTRADO.' });";
                    MostrarMensaje(script);
                    return;
                }
                else
                {
                    if (usuarios.Agregar(add) == true)
                    {
                        string script = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Usuario Agregado!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Usuarios.aspx';}});";
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
            DatosUsuarios usuarios = new DatosUsuarios();
            Usuarios aux = new Usuarios();
            Provincias pop = new Provincias();
            Localidades lol = new Localidades();
            List<Usuarios> idEdit = usuarios.Listar();

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
                        aux.Tel = TxtTel.Text;

                        aux.Perfil = new Perfiles();
                        aux.Perfil.idPerfil = int.Parse(ddlPerfil.SelectedValue);
                        aux.Perfil.Perfil = ddlPerfil.SelectedItem.Text;

                        aux.Provincia = new Provincias();
                        aux.Provincia.id = int.Parse(ddlProvincia.SelectedValue);
                        aux.Provincia.provincia = ddlProvincia.SelectedItem.Text;

                        aux.Localidad = new Localidades();
                        aux.Localidad.id = int.Parse(ddlLocalidad.SelectedValue);
                        aux.Localidad.localidad = ddlLocalidad.SelectedItem.Text;

                        cc = false;

                        List<Usuarios> ListaUs = usuarios.Listar();
                        Usuarios quedoigual = ListaUs.Find(p => p.Id == idobtenido);

                        if (aux.TieneDiferenciasCon(quedoigual) == true)
                        {
                            string scriptError = "Swal.fire('ERROR', 'NO HAY CAMBIOS EN EL REGISTRO', 'warning');";
                            MostrarMensaje(scriptError);
                        }
                        else if (usuarios.Update(aux) == true)
                        {
                            string scriptActualizado = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Usuario actualizado!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Usuarios.aspx';}});";
                            MostrarMensaje(scriptActualizado);
                        }
                        else
                        {
                            string script = "Swal.fire({icon: 'error', title: '¡ NO Actualizado!', text: 'ERROR NO SE A PODIDO ACTUALIZAR'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                            MostrarMensaje(script);

                        }
                    }
                }
                else
                {
                    txtNombre.Enabled = true;
                    txtApellido.Enabled = true;
                    txtDni.Enabled = true;
                    txtEmail.Enabled = true;
                    TxtTel.Enabled = true;
                    txtDireccion.Enabled = true;
                    ddlProvincia.Enabled = true;
                    ddlLocalidad.Enabled = true;
                    ddlPerfil.Enabled = true;
                    cc = true;
                }
            }
            catch (Exception)
            {

                throw;
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