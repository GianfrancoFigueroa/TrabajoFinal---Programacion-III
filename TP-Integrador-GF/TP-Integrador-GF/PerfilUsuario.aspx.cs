using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using conexiones;

namespace TP_Integrador_GF
{
    public partial class PerfilUsuario : System.Web.UI.Page
    {
       AccesoDatos datos = new AccesoDatos();

        protected void Page_Load(object sender, EventArgs e)
        {
            DatosProvincias provincias = new DatosProvincias();
            DatosLocalidades localidades = new DatosLocalidades();

            try
            {
                Usuarios User = (Usuarios)Session["User"];

                if (User == null)
                {
                    Session.Add("Error", "LOGUEARSE");
                    Response.Redirect("ERROR.aspx");
                }
                else
                {
                    ddlLocalidad.DataSource = localidades.Listar(User.Provincia.id);
                    ddlLocalidad.DataTextField = "localidad";
                    ddlLocalidad.DataValueField = "ID";
                    ddlLocalidad.DataBind();

                    ddlProvincia.DataSource = provincias.Listar();
                    ddlProvincia.DataTextField = "provincia";
                    ddlProvincia.DataValueField = "ID";
                    ddlProvincia.DataBind();

                    txtNombre.Text = User.Nombre;
                    txtApellido.Text = User.Apellido;
                    txtDni.Text = User.DNI.ToString();
                    txtTelefono.Text = User.Tel;
                    txtEmail.Text = User.Email;
                    txtDireccion.Text = User.Domicilio;

                    ddlProvincia.SelectedValue = User.Provincia.id.ToString();
                    ddlLocalidad.SelectedValue = User.Localidad.id.ToString();

                    if (!string.IsNullOrEmpty(User.ImagenUrl))
                    {
                        imgProfile.ImageUrl = ResolveUrl("~/Images/" + User.ImagenUrl);
                        imgProfile.Visible = true;
                    }
                    else
                    {
                        imgProfile.ImageUrl = "https://definicion.de/wp-content/uploads/2019/07/perfil-de-usuario.png";
                    }
                    imgProfile.Visible = true;
                    

                    txtNombre.Enabled = false;
                    txtApellido.Enabled = false;
                    txtDireccion.Enabled = false;
                    txtDni.Enabled = false;
                    txtEmail.Enabled = false;
                    txtTelefono.Enabled = false;
                    ddlProvincia.Enabled = false;
                    ddlLocalidad.Enabled = false;
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DatosLocalidades localidades = new DatosLocalidades();

            try
            {
                int idp = ddlProvincia.SelectedIndex;

                idp += 1;

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

        protected void btnCargarFoto_Click(object sender, EventArgs e)
        {
            DatosUsuarios datosUsuarios = new DatosUsuarios();
            Usuarios User = (Usuarios)Session["User"];

            if (fileUploadProfile.HasFile)
            {
                string extension = System.IO.Path.GetExtension(fileUploadProfile.FileName).ToLower();
                string[] extensionesPermitidas = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };

                if (Array.IndexOf(extensionesPermitidas, extension) < 0)
                {
                    // Mostrar error
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Solo se permiten imágenes jpg, png, gif, bmp.');", true);
                    return;
                }

                string carpeta = Server.MapPath("~/Images/");

                if (!System.IO.Directory.Exists(carpeta))
                    System.IO.Directory.CreateDirectory(carpeta);

                string nombreArchivo = fileUploadProfile.FileName.ToLower();
                string rutaArchivo = System.IO.Path.Combine(carpeta, nombreArchivo);

                fileUploadProfile.SaveAs(rutaArchivo);

                int idUser = User.Id;
                string ImgUrl = nombreArchivo;
                if(datosUsuarios.CargaFoto(idUser, ImgUrl)){

                    List<Usuarios> BuscarxId = datosUsuarios.Listar();
                    Usuarios UserActualizado = BuscarxId.Find(d => d.Id == idUser);
                    Session["User"] = UserActualizado;

                    string script = "Swal.fire({icon: 'success', title: 'Éxito', text: '¡Imagen cargada exitosamente!'}).then((result) => {if (result.isConfirmed) {window.location.href = 'PerfilUsuario.aspx';}});";
                    MostrarMensaje(script);
                }
            }
            else
            {
                string script = "Swal.fire({icon: 'error', title: 'Error', text: 'ERROR EN CARGA'}).then((result) => {if (result.isConfirmed) {window.location.href = 'PerfilUsuario.aspx';}});";
                MostrarMensaje(script);
            }
        }

        public void MostrarMensaje(string Script)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "MessageBox", Script, true);
        }


    }
}