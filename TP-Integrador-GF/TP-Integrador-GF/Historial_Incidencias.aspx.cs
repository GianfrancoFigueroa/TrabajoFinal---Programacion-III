using conexiones;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TP_Integrador_GF
{
    public partial class Historial_Incidencias : System.Web.UI.Page
    {
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
                    int IdUserSesion = UsuarioSesion.Id; 
                    CargarDdl();
                    if (UsuarioSesion.Perfil.idPerfil == 1 || UsuarioSesion.Perfil.idPerfil == 2)
                    {
                        DatosIncidencias incidencias = new DatosIncidencias();
                        List<Incidencias> listaIncidenciasXusuario = incidencias.IncidenciasXUsuarios(IdUserSesion);
                        CargarDatosGridView(listaIncidenciasXusuario);
                    }
                    else if (UsuarioSesion.Perfil.idPerfil == 3)
                    {
                        CargarDatosGridView();
                    }
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
                DatosEstados datosEstados = new DatosEstados();
                ddlEstado.DataSource = datosEstados.Listar();
                ddlEstado.DataTextField = "estado";
                ddlEstado.DataValueField = "id";
                ddlEstado.DataBind();
                ddlEstado.Items.Insert(0, new ListItem("Seleccione...", "0"));

                DatosUsuarios usuarios = new DatosUsuarios();   
                ddlAsignadoFiltro.DataSource = usuarios.Listar();
                ddlAsignadoFiltro.DataTextField = "NombreCompleto";
                ddlAsignadoFiltro.DataValueField = "ID";
                ddlAsignadoFiltro.DataBind();
                ddlAsignadoFiltro.Items.Insert(0, new ListItem("Seleccione...", "0"));
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
                DatosIncidencias incidencias = new DatosIncidencias();
                List<Incidencias> listaIncidencias = incidencias.Listar();
                ViewState["ListaIncidencias"] = listaIncidencias;
                GridIncidencias.DataSource = listaIncidencias;
                GridIncidencias.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void CargarDatosGridView(List<Incidencias> listaIncidencias)
        {
            try
            {
                ViewState["ListaIncidencias"] = listaIncidencias;
                GridIncidencias.DataSource = listaIncidencias;
                GridIncidencias.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void GridIncidencias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridIncidencias.PageIndex = e.NewPageIndex;

                if (ViewState["ListaIncidencias"] != null)
                {
                    List<Incidencias> lista = (List<Incidencias>)ViewState["ListaIncidencias"];
                    CargarDatosGridView(lista);
                }
                else
                {
                    CargarDatosGridView();
                }

                GridIncidencias.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void GridIncidencias_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var id = GridIncidencias.SelectedDataKey.Value.ToString();
                Response.Redirect("AltaIncidencias?id=" + id, false);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void GridIncidencias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                DatosIncidencias datos = new DatosIncidencias();
                int id = (int)GridIncidencias.DataKeys[e.RowIndex].Value;
                List<Incidencias> IncidenciaID = datos.Listar();
                Incidencias inc = IncidenciaID.Find(d => d.Id == id);

                DatosClientes datosClientes = new DatosClientes();
                List<Clientes> ClientexID = datosClientes.Listar();

                string comentario = Request.Form["hdnComment"];
                if (inc.FechaCierre == null)
                { 
                    if (datos.Cerrar(id, comentario))
                    {
                        Clientes aux = ClientexID.Find(d => d.Id == inc.IdCliente);

                        if (aux != null && !string.IsNullOrEmpty(aux.Email))
                        {
                            if (EnviarMail(aux.Email, inc, comentario, false))
                            {
                                string scriptEnvioOk = "Swal.fire({icon: 'success', title: '¡Incidencia CERRADA!', text: 'Incidencia CERRADA y correo enviado correctamente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                                MostrarMensaje(scriptEnvioOk);
                            }
                            else
                            {
                                string scriptEnvioError = "Swal.fire({icon: 'warning', title: 'Incidencia CERRADA PERO...', text: 'La incidencia fue cerrada pero no se pudo enviar el correo al cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                                MostrarMensaje(scriptEnvioError);
                            }
                        }
                        else
                        {
                            string scriptSinEmail = "Swal.fire({icon: 'warning', title: 'Incidencia CERRADA PERO...', text: 'No se encontró un correo válido para el cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                            MostrarMensaje(scriptSinEmail);
                        }
                    }
                    else 
                    {
                        string scriptError = "Swal.fire({icon: 'error', title: '¡ERROR!', text: 'La incidencia no pudo ser cerrada'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                        MostrarMensaje(scriptError);
                    }
                }
                else
                {
                    string scriptError = "Swal.fire({icon: 'error', title: '¡ERROR!', text: 'INCIDENCIA YA CERRADA O RESUELTA'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                    MostrarMensaje(scriptError);
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void GridIncidencias_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                DatosIncidencias datos = new DatosIncidencias();
                int id = (int)GridIncidencias.DataKeys[e.NewEditIndex].Value;
                List<Incidencias> IncidenciaID = datos.Listar();
                Incidencias inc = IncidenciaID.Find(d => d.Id == id);   

                DatosClientes datosClientes = new DatosClientes();
                List<Clientes> ClientexID = datosClientes.Listar();

                string comentario = Request.Form["hdnComment"];
                if (inc.FechaCierre == null) {
                
                    if (datos.Resolver(id, comentario))
                    {

                        Clientes aux = ClientexID.Find(d => d.Id == inc.IdCliente);

                        if (aux != null && !string.IsNullOrEmpty(aux.Email))
                        {
                            if (EnviarMail(aux.Email, inc, comentario, true))
                            {
                                string scriptEnvioOk = "Swal.fire({icon: 'success', title: '¡Incidencia RESUELTA!', text: 'Incidencia RESUELTA y correo enviado correctamente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                                MostrarMensaje(scriptEnvioOk);
                            }
                            else
                            {
                                string scriptEnvioError = "Swal.fire({icon: 'warning', title: 'Incidencia RESUELTA PERO...', text: 'La incidencia fue resuelta pero no se pudo enviar el correo al cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                                MostrarMensaje(scriptEnvioError);
                            }
                        }
                        else
                        {
                            string scriptSinEmail = "Swal.fire({icon: 'warning', title: 'Incidencia RESUELTA PERO...', text: 'No se encontró un correo válido para el cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                            MostrarMensaje(scriptSinEmail);
                        }

                    }
                    else
                    {
                        string scriptError = "Swal.fire({icon: 'error', title: '¡ERROR!', text: 'La incidencia no pudo ser resuelta'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                        MostrarMensaje(scriptError);
                    }
                }
                else
                {
                    string scriptError = "Swal.fire({icon: 'error', title: '¡ERROR!', text: 'INCIDENCIA YA CERRADA O RESUELTA'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                    MostrarMensaje(scriptError);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Usuarios User = (Usuarios)Session["User"];
                DatosIncidencias datosIncidencias = new DatosIncidencias();
                int estadoSeleccionado = int.Parse(ddlEstado.SelectedValue);
                int asignadoFSeleccionado = int.Parse(ddlAsignadoFiltro.SelectedValue);
                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();
                List<Incidencias> Incidencias = new List<Incidencias>();
                List<Incidencias> ListaFiltrada = new List<Incidencias>();

                if (User.Perfil.idPerfil == 1) {

                    Incidencias = datosIncidencias.IncidenciasXUsuarios(User.Id);
                }
                else if(User.Perfil.idPerfil == 2 || User.Perfil.idPerfil == 3)
                {
                    if(asignadoFSeleccionado == 0) { 
                        Incidencias = datosIncidencias.Listar();
                    }
                    else
                    {
                        Incidencias = datosIncidencias.IncidenciasXUsuariosAsignado(asignadoFSeleccionado);
                    }
                }

                if (estadoSeleccionado != 0)
                {
                    Incidencias = Incidencias.Where(x => x.Estado == estadoSeleccionado).ToList();
                }
                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                    Incidencias = Incidencias.Where(x => (x.NumeroReclamo != null && x.NumeroReclamo.ToLower().Contains(textoBusqueda))).ToList();
                }

                CargarDatosGridView(Incidencias);

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        protected void ddlAsignadoFiltro_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Usuarios User = (Usuarios)Session["User"];
                DatosIncidencias datosIncidencias = new DatosIncidencias();
                int estadoSeleccionado = int.Parse(ddlEstado.SelectedValue);
                int asignadoFSeleccionado = int.Parse(ddlAsignadoFiltro.SelectedValue);
                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();
                List<Incidencias> incidencias = new List<Incidencias>();

                if (asignadoFSeleccionado != 0 && (User.Perfil.idPerfil == 2 || User.Perfil.idPerfil == 3))
                {
                    incidencias = datosIncidencias.IncidenciasXUsuariosAsignado(asignadoFSeleccionado);
                }                 
                else
                {
                    incidencias = datosIncidencias.Listar();
                }
                if (estadoSeleccionado != 0)
                {
                    incidencias = incidencias.Where(x => x.Estado == estadoSeleccionado).ToList();
                }
                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                    incidencias = incidencias.Where(x => (x.NumeroReclamo != null && x.NumeroReclamo.ToLower().Contains(textoBusqueda))).ToList();
                }
                CargarDatosGridView(incidencias);
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
                Usuarios User = (Usuarios)Session["User"];
                DatosIncidencias datosIncidencias = new DatosIncidencias();
                DatosClientes datosClientes = new DatosClientes();

                int estadoSeleccionado = int.Parse(ddlEstado.SelectedValue);
                int asignadoFSeleccionado= int.Parse(ddlAsignadoFiltro.SelectedValue);
                string textoBusqueda = txtBusqueda.Text.Trim().ToLower();

                List<Incidencias> incidencias = new List<Incidencias>();

                if (User.Perfil.idPerfil == 1)
                {
                    incidencias = datosIncidencias.IncidenciasXUsuarios(User.Id);
                }
                else if (User.Perfil.idPerfil == 2 || User.Perfil.idPerfil == 3)
                {
                    if (asignadoFSeleccionado == 0)
                        incidencias = datosIncidencias.Listar();
                    else
                        incidencias = datosIncidencias.IncidenciasXUsuariosAsignado(asignadoFSeleccionado);
                }

                if (estadoSeleccionado != 0)
                {
                    incidencias = incidencias.Where(x => x.Estado == estadoSeleccionado).ToList();
                }

                if (!string.IsNullOrEmpty(textoBusqueda))
                {
                    incidencias = incidencias.Where(x => (x.NumeroReclamo != null && x.NumeroReclamo.ToLower().Contains(textoBusqueda))).ToList();

                }
                CargarDatosGridView(incidencias);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool EnviarMail(string emailCliente, Incidencias add, string comentarioFinal, bool cerrarOresolver)
        {
            try
            {
                string mensaje, titulo;
                string numeroIncidencia = add.NumeroReclamo;
        
                DateTime fechaApertura = add.FechaApertura;
                DateTime? fechaCierre = add.FechaCierre;

                if(cerrarOresolver == true) 
                {
                    titulo = "Incidencia RESUELTA";
                    mensaje = $@"
                    <!DOCTYPE html>
                    <html lang='es'>
                    <head>
                        <meta charset='UTF-8'>
                        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                        <title>Incidencia Registrada</title>
                        <style>
                            body {{ font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; margin: 0; padding: 0; }}
                            .email-container {{ 
                                max-width: 600px; 
                                margin: 20px auto; 
                                background-color: #fff; 
                                padding: 20px; 
                                border-radius: 10px; 
                                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
                                border: 1px solid #ddd;
                            }}
                            .header {{ 
                                text-align: center; 
                                background-color: #d3d3d3; 
                                color: #333; 
                                padding: 10px 0; 
                                border-radius: 10px 10px 0 0; 
                            }}
                            .footer {{ font-size: 12px; color: #666; text-align: center; margin-top: 20px; }}
                        </style>
                    </head>
                    <body>
                        <div class='email-container'>
                            <div class='header'>
                                <h1>Incidencia RESUELTA</h1>
                            </div>
                            <p>Hola,</p>
                            <p>Se ha registrado la resolucion de su incidencia en el sistema:</p>
                            <ul>
                                <li><strong>Número de Incidencia:</strong> {numeroIncidencia}</li>
                                <li><strong>Fecha de Apertura:</strong> {fechaApertura}</li>
                                <li><strong>Fecha de Resolucion:</strong> {fechaCierre}</li>
                                <li><strong>Comentario de resolucion:</strong> {comentarioFinal}</li>
                            </ul>
                            <p>Esperamos que su resolucion sea adecuada. No dude en contactarnos</p>
                            <div class='footer'>
                                <p>&copy; 2025 InciDesk. Todos los derechos reservados.</p>
                            </div>
                        </div>
                    </body>
                    </html>";
                }
                else 
                {
                    titulo = "Incidencia CERRADA";
                    mensaje = $@"
                    <!DOCTYPE html>
                    <html lang='es'>
                    <head>
                        <meta charset='UTF-8'>
                        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                        <title>Incidencia Registrada</title>
                        <style>
                            body {{ font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; margin: 0; padding: 0; }}
                            .email-container {{ 
                                max-width: 600px; 
                                margin: 20px auto; 
                                background-color: #fff; 
                                padding: 20px; 
                                border-radius: 10px; 
                                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
                                border: 1px solid #ddd;
                            }}
                            .header {{ 
                                text-align: center; 
                                background-color: #d3d3d3; 
                                color: #333; 
                                padding: 10px 0; 
                                border-radius: 10px 10px 0 0; 
                            }}
                            .footer {{ font-size: 12px; color: #666; text-align: center; margin-top: 20px; }}
                        </style>
                    </head>
                    <body>
                        <div class='email-container'>
                            <div class='header'>
                                <h1>Incidencia CERRADA</h1>
                            </div>
                            <p>Hola,</p>
                            <p>Se ha registrado el cierre de su incidencia en el sistema:</p>
                            <ul>
                                <li><strong>Número de Incidencia:</strong> {numeroIncidencia}</li>
                                <li><strong>Fecha de Apertura:</strong> {fechaApertura}</li>
                                <li><strong>Fecha de Resolucion:</strong> {fechaCierre}</li>
                                <li><strong>Comentario de cierre:</strong> {comentarioFinal}</li>
                            </ul>
                            <p>Contactarse ante cualquier duda.</p>
                            <div class='footer'>
                                <p>&copy; 2025 InciDesk. Todos los derechos reservados.</p>
                            </div>
                        </div>
                    </body>
                    </html>";
                }

                ServiceMail servicio = new ServiceMail();
                servicio.ArmarMail(emailCliente, titulo, mensaje);
                servicio.EnviarMail();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw ex;
            }
        }


        protected void btnCargar_Click(object sender, EventArgs e)
        {
            Response.Redirect("AltaIncidencias.aspx");
        }

        public void MostrarMensaje(string Script)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", Script, true);
        }

    }
}