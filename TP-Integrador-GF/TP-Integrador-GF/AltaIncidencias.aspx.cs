using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using conexiones;
using dominio;

namespace TP_Integrador_GF
{
    public partial class AltaIncidencias : System.Web.UI.Page
    {
        AccesoDatos datos = new AccesoDatos();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            Incidencias edit = new Incidencias();
            DatosIncidencias Incidencias = new DatosIncidencias();
            List<Incidencias> ListaIncidencia = Incidencias.Listar();
            DatosUsuarios usuarios = new DatosUsuarios();
            Usuarios UserSession = (Usuarios)Session["User"];

            try
            {
                if (UserSession == null)
                {
                    Session.Add("Error", "LOGUEARSE");
                    Response.Redirect("ERROR.aspx");
                }

                if (!IsPostBack)
                {
                    CargarDropDowns();

                    if (Request.QueryString["id"] != null)
                    {
                        txtNincidencia.Enabled = false;
                        txtRegistroUsuario.Enabled = false;
                        txtEstado.Enabled = false;
                        TxtAct.Enabled = false;
                        TxtAlta.Enabled = false;
                        TxtCierre.Enabled = false;
                        txtComentarioFinal.Enabled = false;

                        txtComents.Enabled = false;
                        txtProbLem.Enabled = false;

                        ddlCliente.Enabled = false;
                        DdlAsignar.Enabled = false;
                        DdlPrioridad.Enabled = false;
                        DdlTipoInc.Enabled = false;

                        int id = int.Parse(Request.QueryString["id"]);
                        edit = ListaIncidencia.FirstOrDefault(r => r.Id == id);
                        List<Usuarios> ListaUsuarios = usuarios.Listar();

                        if (edit != null)
                        {
                            ddlCliente.Text = edit.IdCliente.ToString();
                            txtEstado.Text = edit.NombreEstado;
                            txtComents.Text = edit.Comentarios;
                            txtNincidencia.Text = edit.NumeroReclamo;
                            txtProbLem.Text = edit.Problematica;
                            TxtAlta.Text = edit.FechaApertura.ToString();
                            TxtAct.Text = edit.UltimaActualizacion.ToString();
                            txtComentarioFinal.Text = edit.ComentarioF;
                            ViewState["FechaDeCierre"] = null;

                            Usuarios User = ListaUsuarios.Find(d => d.Id == edit.IdUsuarioRegistro);
                            if (User != null)
                            {
                                txtRegistroUsuario.Text = User.NombreCompleto;
                            }
                            Usuarios User2 = ListaUsuarios.Find(d => d.Id == edit.IdUsuarioAsignado);
                            if (User2 != null)
                            {
                                DdlAsignar.SelectedValue = User2.Id.ToString();

                            }
                            if (edit.FechaCierre != null)
                            {
                                ViewState["FechaDeCierre"] = edit.FechaCierre.ToString();
                                TxtCierre.Text = edit.FechaCierre.ToString();
                            }
                            else
                            {
                                TxtCierre.Text = "EN CURSO";
                            }
                            DdlPrioridad.SelectedValue = edit.Prioridad.Id.ToString();
                            DdlTipoInc.Text = edit.TipoIncidencia.Id.ToString();
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

        protected void btnCargar_Click(object sender, EventArgs e)
        {
            Incidencias add = new Incidencias();
            DatosIncidencias datosIncidencias = new DatosIncidencias();

            try
            {
                if (string.IsNullOrWhiteSpace(txtProbLem.Text) || string.IsNullOrWhiteSpace(txtComents.Text))
                {
                    string script = "alert('Por favor complete todos los campos.');";
                    MostrarMensaje(script);
                    return;
                }

                int idDdlCliente;
                if (!int.TryParse(ddlCliente.SelectedValue, out idDdlCliente) || idDdlCliente <= 0)
                {
                    MostrarMensaje("alert('Por favor, seleccione un cliente válido.');");
                    return;
                }
                add.IdCliente = idDdlCliente; 
                add.Estado = 1; 
              
                int idPrioridad;
                if (!int.TryParse(DdlPrioridad.SelectedValue, out idPrioridad) || idPrioridad <= 0) 
                {
                    MostrarMensaje("alert('Por favor, seleccione una prioridad válida.');");
                    return;
                }
                add.Prioridad = new Prioridades();
                add.Prioridad.Id = idPrioridad;
                add.Prioridad.Prioridad = DdlPrioridad.SelectedItem.Text; 

               
                int idTipoIncidencia;
                if (!int.TryParse(DdlTipoInc.SelectedValue, out idTipoIncidencia) || idTipoIncidencia <= 0) 
                {
                    MostrarMensaje("alert('Por favor, seleccione un tipo de incidencia válido.');");
                    return;
                }
                add.TipoIncidencia = new TiposIncidencias();
                add.TipoIncidencia.Id = idTipoIncidencia;
                add.TipoIncidencia.Tipo = DdlTipoInc.SelectedItem.Text;

                add.FechaApertura = DateTime.Now;
                add.UltimaActualizacion = DateTime.Now;
                Usuarios usuarioSesion = (Usuarios)Session["User"];
                add.IdUsuarioRegistro = usuarioSesion.Id;


                if (usuarioSesion.Perfil.idPerfil == 1)
                {
                   add.IdUsuarioAsignado = usuarioSesion.Id;
                }
                else if(usuarioSesion.Perfil.idPerfil == 2 || usuarioSesion.Perfil.idPerfil == 3) 
                {
                    int idAsignar;
                    if (!int.TryParse(DdlAsignar.SelectedValue, out idAsignar) || idAsignar <=0)
                    {
                        MostrarMensaje("alert('Por favor, seleccione un Operador valido");
                        return;
                    }
                    add.IdUsuarioAsignado = idAsignar; 
                }

                add.Problematica = txtProbLem.Text; 
                add.Comentarios = txtComents.Text;


                if (datosIncidencias.Agregar(add))
                {
                    int idInc = add.Id;
                    List<Incidencias> ListIncidenciaID = datosIncidencias.Listar();
                    Incidencias inc = ListIncidenciaID.Find(x => x.Id == idInc);

                    DatosClientes datosClientes = new DatosClientes();
                    List<Clientes> ClientexID = datosClientes.Listar();
                    Clientes aux = ClientexID.Find(d => d.Id == idDdlCliente);

                    if (aux != null && !string.IsNullOrEmpty(aux.Email))
                    {
                        if (EnviarMail(aux.Email, inc))
                        {
                            string scriptEnvioOk = "Swal.fire({icon: 'success', title: '¡Registro Agregado!', text: 'Incidencia dada de alta y correo enviado correctamente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                            MostrarMensaje(scriptEnvioOk);
                        }
                        else
                        {
                            string scriptEnvioError = "Swal.fire({icon: 'warning', title: 'Incidencia registrada', text: 'La incidencia fue dada de alta pero no se pudo enviar el correo al cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                            MostrarMensaje(scriptEnvioError);
                        }
                    }
                    else
                    {
                        string scriptSinEmail = "Swal.fire({icon: 'warning', title: 'Incidencia registrada', text: 'No se encontró un correo válido para el cliente'}).then((result) => { if (result.isConfirmed) { window.location.href = 'Historial_Incidencias.aspx'; }});";
                        MostrarMensaje(scriptSinEmail);
                    }
                }
                else
                {
                    string scriptError = "Swal.fire({icon: 'error', title: 'Error', text: 'No se pudo registrar la incidencia'});";
                    MostrarMensaje(scriptError);
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

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            Incidencias edit = new Incidencias();
            DatosIncidencias Incidencias = new DatosIncidencias();
            List<Incidencias> idEdit = Incidencias.Listar();

            try
            {
                int idobtenido = int.Parse(Request.QueryString["id"]);
                Incidencias IncEdit = idEdit.FirstOrDefault(r => r.Id == idobtenido);

                if (cc == true)
                { 
                    if(IncEdit != null)
                    {
                        edit.Id = idobtenido;
                        edit.Estado = 2; 
                        edit.Prioridad = new Prioridades();
                        edit.Prioridad.Id = int.Parse(DdlPrioridad.SelectedValue);
                        edit.Prioridad.Prioridad = DdlPrioridad.SelectedItem.Text;
                        edit.TipoIncidencia = new TiposIncidencias();
                        edit.TipoIncidencia.Id = int.Parse(DdlTipoInc.SelectedValue);
                        edit.TipoIncidencia.Tipo = DdlTipoInc.SelectedItem.Text;
                        edit.UltimaActualizacion = DateTime.Now;
                        Usuarios usuarioSesion = (Usuarios)Session["User"];

                        if(usuarioSesion.Perfil.idPerfil == 2 || usuarioSesion.Perfil.idPerfil == 3)
                        {
                           edit.IdUsuarioAsignado = int.Parse(DdlAsignar.SelectedValue); 
                        }
                        edit.Problematica = txtProbLem.Text;
                        edit.Comentarios = txtComents.Text;
                        cc = false;
                    
                        if (Incidencias.Update(edit) == true)
                        {
                            string script = "Swal.fire({icon: 'success', title: '¡Registro Actualizado!', text: 'Incidencia ACTUALIZADA'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                            MostrarMensaje(script);
                        }
                        else
                        {
                            string script = "Swal.fire({icon: 'error', title: '¡Registro NO Actualizado!', text: 'ERROR NO SE A PODIDO ACTUALIZAR'}).then((result) => {if (result.isConfirmed) {window.location.href = 'Historial_Incidencias.aspx';}});";
                            MostrarMensaje(script);
                        }
                    }

                }
                else
                {
                    txtComents.Enabled = true;
                    txtProbLem.Enabled = true;

                    DdlAsignar.Enabled = true;
                    DdlPrioridad.Enabled = true;
                    DdlTipoInc.Enabled = true;
                    cc = true;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void MostrarMensaje(string Script)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", Script, true);
        }

        private void CargarDropDowns()
        {
            DatosClientes clientes = new DatosClientes();
            DatosUsuarios usuarios = new DatosUsuarios();
            DatosPrioridad prioridad = new DatosPrioridad();
            DatosTipoInc tiposI = new DatosTipoInc();

            ListItem item = new ListItem("Seleccione un cliente", ""); 
            ddlCliente.Items.Insert(0, item);
            ddlCliente.DataSource = clientes.Listar();
            ddlCliente.DataTextField = "NombreCompleto";
            ddlCliente.DataValueField = "ID";
            ddlCliente.DataBind();

            DdlAsignar.DataSource = usuarios.Listar();
            DdlAsignar.DataTextField = "NombreCompleto";
            DdlAsignar.DataValueField = "ID";
            DdlAsignar.DataBind();

            DdlPrioridad.DataSource = prioridad.Listar();
            DdlPrioridad.DataTextField = "Prioridad";
            DdlPrioridad.DataValueField = "ID";
            DdlPrioridad.DataBind();

            DdlTipoInc.DataSource = tiposI.Listar();
            DdlTipoInc.DataTextField = "Tipo";
            DdlTipoInc.DataValueField = "ID";
            DdlTipoInc.DataBind();
        }

        public bool EnviarMail(string emailCliente, Incidencias add)
        {
            try
            {
                string numeroIncidencia = add.NumeroReclamo;
                DateTime fechaApertura = add.FechaApertura;

                string mensaje = $@"
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
                                <h1>Incidencia Registrada</h1>
                            </div>
                            <p>Hola,</p>
                            <p>Se ha registrado una nueva incidencia en el sistema con los siguientes datos:</p>
                            <ul>
                                <li><strong>Número de Incidencia:</strong> {numeroIncidencia}</li>
                                <li><strong>Fecha de Apertura:</strong> {fechaApertura}</li>
                            </ul>
                            <p>Nos pondremos en contacto a la brevedad para dar seguimiento.</p>
                            <div class='footer'>
                                <p>&copy; 2025 InciDesk. Todos los derechos reservados.</p>
                            </div>
                        </div>
                    </body>
                    </html>";


                ServiceMail servicio = new ServiceMail();
                servicio.ArmarMail(emailCliente, "Registramos tu incidencia", mensaje);
                servicio.EnviarMail();
                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw ex;
            }
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