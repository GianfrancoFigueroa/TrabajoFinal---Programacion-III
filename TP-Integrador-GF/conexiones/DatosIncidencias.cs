using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace conexiones
{
    public class DatosIncidencias
    {
        
        AccesoDatos datos = new AccesoDatos();

        public List<Incidencias> Listar()
        {
            try
            {
                List<Incidencias> lista = new List<Incidencias>();
                datos.setearQuery("SELECT I.[ID], I.[IDcliente], I.[IDestado], I.[Problematica], I.[Comentarios], I.[ComentarioFinal], P.[ID] AS PrioridadId, P.[Prioridad] AS PrioridadNombre, T.[ID] AS TipoIncidenciaId, T.[TipoInc] AS TipoIncidenciaNombre, I.[FechaApertura], I.[UltimaActualizacion], I.[FechaCierre], I.[NroReclamo], U_Registro.[ID] AS IDUsuarioRegistro, U_Registro.[Nombre] AS NombreUsuarioRegistro, U_Registro.[Apellido] AS ApellidoUsuarioRegistro, U_Asignado.[ID] AS IDUsuarioAsignado, U_Asignado.[Nombre] AS NombreUsuarioAsignado, U_Asignado.[Apellido] AS ApellidoUsuarioAsignado FROM [CallCenter].[dbo].[Incidencia] AS I INNER JOIN [CallCenter].[dbo].[prioridad] AS P ON I.[Prioridad] = P.[ID] INNER JOIN [CallCenter].[dbo].[TipoIncidencia] AS T ON I.[TipoIncidencia] = T.[ID] INNER JOIN [CallCenter].[dbo].[Usuarios] AS U_Registro ON I.[IDusuario] = U_Registro.[ID] LEFT JOIN [CallCenter].[dbo].[Usuarios] AS U_Asignado ON I.[AsignadoA] = U_Asignado.[ID];");
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Incidencias aux = new Incidencias();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.NumeroReclamo = (string)datos.Lector["NroReclamo"];
                    aux.IdCliente = (int)datos.Lector["IDcliente"];
                    aux.Estado = (int)datos.Lector["IDestado"];
                    aux.Problematica = (string)datos.Lector["Problematica"];
                    aux.Comentarios = (string)datos.Lector["Comentarios"];
                    aux.ComentarioF = datos.Lector["ComentarioFinal"] == DBNull.Value ? (string)null : (string)datos.Lector["ComentarioFinal"];

                    aux.Prioridad = new Prioridades();
                    aux.Prioridad.Id = (int)datos.Lector["PrioridadId"];
                    aux.Prioridad.Prioridad = (string)datos.Lector["PrioridadNombre"]; 

                    aux.TipoIncidencia = new TiposIncidencias();
                    aux.TipoIncidencia.Id = (int)datos.Lector["TipoIncidenciaId"];
                    aux.TipoIncidencia.Tipo = (string)datos.Lector["TipoIncidenciaNombre"];

                    aux.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    aux.UltimaActualizacion = datos.Lector["UltimaActualizacion"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["UltimaActualizacion"];
                    aux.FechaCierre = datos.Lector["FechaCierre"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["FechaCierre"];

                    aux.IdUsuarioRegistro = (int)datos.Lector["IDUsuarioRegistro"];
                    aux.IdUsuarioAsignado = (int)datos.Lector["IDUsuarioAsignado"];

                    string nombreReg = datos.Lector["NombreUsuarioRegistro"].ToString();
                    string apellidoReg = datos.Lector["ApellidoUsuarioRegistro"].ToString();
                    aux.NombreCompletoUsuarioRegistro = $"{nombreReg} {apellidoReg}";

                    if (datos.Lector["NombreUsuarioAsignado"] != DBNull.Value && datos.Lector["ApellidoUsuarioAsignado"] != DBNull.Value)
                    {
                        string nombreAsig = datos.Lector["NombreUsuarioAsignado"].ToString();
                        string apellidoAsig = datos.Lector["ApellidoUsuarioAsignado"].ToString();
                        aux.NombreCompletoUsuarioAsignado = $"{nombreAsig} {apellidoAsig}";
                    }
                    else
                    {
                        aux.NombreCompletoUsuarioAsignado = "No Asignado"; 
                    }

                    lista.Add(aux);
                }
                return lista;
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

        public List<Incidencias> IncidenciasXUsuarios(int idUser)
        {
            try
            {
                List<Incidencias> lista = new List<Incidencias>();
                datos.setearQuery("SELECT I.[ID], I.[IDcliente], I.[IDestado], I.[Problematica], I.[Comentarios], I.[ComentarioFinal], P.[ID] AS PrioridadId, P.[Prioridad] AS PrioridadNombre, T.[ID] AS TipoIncidenciaId, T.[TipoInc] AS TipoIncidenciaNombre, I.[FechaApertura], I.[UltimaActualizacion], I.[FechaCierre], I.[NroReclamo], U_Registro.[ID] AS IDUsuarioRegistro, U_Registro.[Nombre] AS NombreUsuarioRegistro, U_Registro.[Apellido] AS ApellidoUsuarioRegistro, U_Asignado.[ID] AS IDUsuarioAsignado, U_Asignado.[Nombre] AS NombreUsuarioAsignado, U_Asignado.[Apellido] AS ApellidoUsuarioAsignado FROM [CallCenter].[dbo].[Incidencia] AS I INNER JOIN [CallCenter].[dbo].[prioridad] AS P ON I.[Prioridad] = P.[ID] INNER JOIN [CallCenter].[dbo].[TipoIncidencia] AS T ON I.[TipoIncidencia] = T.[ID] INNER JOIN [CallCenter].[dbo].[Usuarios] AS U_Registro ON I.[IDusuario] = U_Registro.[ID] LEFT JOIN [CallCenter].[dbo].[Usuarios] AS U_Asignado ON I.[AsignadoA] = U_Asignado.[ID] WHERE I.[IDusuario] = @id;");
                datos.SetearPARAMETROS("@id", idUser);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Incidencias aux = new Incidencias();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.NumeroReclamo = (string)datos.Lector["NroReclamo"];
                    aux.IdCliente = (int)datos.Lector["IDcliente"];
                    aux.Estado = (int)datos.Lector["IDestado"];
                    aux.Problematica = (string)datos.Lector["Problematica"];
                    aux.Comentarios = (string)datos.Lector["Comentarios"];
                    aux.ComentarioF = datos.Lector["ComentarioFinal"] == DBNull.Value ? (string)null : (string)datos.Lector["ComentarioFinal"];

                    aux.Prioridad = new Prioridades();
                    aux.Prioridad.Id = (int)datos.Lector["PrioridadId"];
                    aux.Prioridad.Prioridad = (string)datos.Lector["PrioridadNombre"];

                    aux.TipoIncidencia = new TiposIncidencias();
                    aux.TipoIncidencia.Id = (int)datos.Lector["TipoIncidenciaId"];
                    aux.TipoIncidencia.Tipo = (string)datos.Lector["TipoIncidenciaNombre"];

                    aux.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    aux.UltimaActualizacion = datos.Lector["UltimaActualizacion"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["UltimaActualizacion"];
                    aux.FechaCierre = datos.Lector["FechaCierre"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["FechaCierre"];

                    aux.IdUsuarioRegistro = (int)datos.Lector["IDUsuarioRegistro"];
                    aux.IdUsuarioAsignado = (int)datos.Lector["IDUsuarioAsignado"];

                    string nombreReg = datos.Lector["NombreUsuarioRegistro"].ToString();
                    string apellidoReg = datos.Lector["ApellidoUsuarioRegistro"].ToString();
                    aux.NombreCompletoUsuarioRegistro = $"{nombreReg} {apellidoReg}";

                    if (datos.Lector["NombreUsuarioAsignado"] != DBNull.Value && datos.Lector["ApellidoUsuarioAsignado"] != DBNull.Value)
                    {
                        string nombreAsig = datos.Lector["NombreUsuarioAsignado"].ToString();
                        string apellidoAsig = datos.Lector["ApellidoUsuarioAsignado"].ToString();
                        aux.NombreCompletoUsuarioAsignado = $"{nombreAsig} {apellidoAsig}";
                    }
                    else
                    {
                        aux.NombreCompletoUsuarioAsignado = "No Asignado";
                    }

                    lista.Add(aux);
                }
                return lista;
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

        public List<Incidencias> IncidenciasXUsuariosAsignado(int idUser)
        {
            try
            {
                List<Incidencias> lista = new List<Incidencias>();
                datos.setearQuery("SELECT I.[ID], I.[IDcliente], I.[IDestado], I.[Problematica], I.[Comentarios], I.[ComentarioFinal], P.[ID] AS PrioridadId, P.[Prioridad] AS PrioridadNombre, T.[ID] AS TipoIncidenciaId, T.[TipoInc] AS TipoIncidenciaNombre, I.[FechaApertura], I.[UltimaActualizacion], I.[FechaCierre], I.[NroReclamo], U_Registro.[ID] AS IDUsuarioRegistro, U_Registro.[Nombre] AS NombreUsuarioRegistro, U_Registro.[Apellido] AS ApellidoUsuarioRegistro, U_Asignado.[ID] AS IDUsuarioAsignado, U_Asignado.[Nombre] AS NombreUsuarioAsignado, U_Asignado.[Apellido] AS ApellidoUsuarioAsignado FROM [CallCenter].[dbo].[Incidencia] AS I INNER JOIN [CallCenter].[dbo].[prioridad] AS P ON I.[Prioridad] = P.[ID] INNER JOIN [CallCenter].[dbo].[TipoIncidencia] AS T ON I.[TipoIncidencia] = T.[ID] INNER JOIN [CallCenter].[dbo].[Usuarios] AS U_Registro ON I.[IDusuario] = U_Registro.[ID] LEFT JOIN [CallCenter].[dbo].[Usuarios] AS U_Asignado ON I.[AsignadoA] = U_Asignado.[ID] WHERE I.[AsignadoA] = @Asignado;");
                datos.SetearPARAMETROS("@Asignado", idUser);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Incidencias aux = new Incidencias();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.NumeroReclamo = (string)datos.Lector["NroReclamo"];
                    aux.IdCliente = (int)datos.Lector["IDcliente"];
                    aux.Estado = (int)datos.Lector["IDestado"];
                    aux.Problematica = (string)datos.Lector["Problematica"];
                    aux.Comentarios = (string)datos.Lector["Comentarios"];
                    aux.ComentarioF = datos.Lector["ComentarioFinal"] == DBNull.Value ? (string)null : (string)datos.Lector["ComentarioFinal"];

                    aux.Prioridad = new Prioridades();
                    aux.Prioridad.Id = (int)datos.Lector["PrioridadId"];
                    aux.Prioridad.Prioridad = (string)datos.Lector["PrioridadNombre"];

                    aux.TipoIncidencia = new TiposIncidencias();
                    aux.TipoIncidencia.Id = (int)datos.Lector["TipoIncidenciaId"];
                    aux.TipoIncidencia.Tipo = (string)datos.Lector["TipoIncidenciaNombre"];

                    aux.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    aux.UltimaActualizacion = datos.Lector["UltimaActualizacion"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["UltimaActualizacion"];
                    aux.FechaCierre = datos.Lector["FechaCierre"] == DBNull.Value ? (DateTime?)null : (DateTime)datos.Lector["FechaCierre"];

                    aux.IdUsuarioRegistro = (int)datos.Lector["IDUsuarioRegistro"];
                    aux.IdUsuarioAsignado = (int)datos.Lector["IDUsuarioAsignado"];

                    string nombreReg = datos.Lector["NombreUsuarioRegistro"].ToString();
                    string apellidoReg = datos.Lector["ApellidoUsuarioRegistro"].ToString();
                    aux.NombreCompletoUsuarioRegistro = $"{nombreReg} {apellidoReg}";

                    if (datos.Lector["NombreUsuarioAsignado"] != DBNull.Value && datos.Lector["ApellidoUsuarioAsignado"] != DBNull.Value)
                    {
                        string nombreAsig = datos.Lector["NombreUsuarioAsignado"].ToString();
                        string apellidoAsig = datos.Lector["ApellidoUsuarioAsignado"].ToString();
                        aux.NombreCompletoUsuarioAsignado = $"{nombreAsig} {apellidoAsig}";
                    }
                    else
                    {
                        aux.NombreCompletoUsuarioAsignado = "No Asignado";
                    }

                    lista.Add(aux);
                }
                return lista;
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

        public bool Cerrar(int id, string comentarioFinal)
        {
            try
            {
                datos.setearQuery("update Incidencia set IDestado = 3, ComentarioFinal = @comentario, FechaCierre = @FechaC where id = @id");
                datos.SetearPARAMETROS("@comentario", comentarioFinal);
                datos.SetearPARAMETROS("@id", id);
                datos.SetearPARAMETROS("@FechaC", DateTime.Now);
                datos.ejecutarAccion();

                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw ex; 
            }
            finally  
            {
                datos.cerrarConexion();
            }
        }

        public bool Resolver(int id, string comentarioFinal)
        {
            try
            {
                datos.setearQuery("update Incidencia set IDestado = 6, ComentarioFinal = @comentario, FechaCierre = @FechaC where id = @id");
                datos.SetearPARAMETROS("@comentario", comentarioFinal);
                datos.SetearPARAMETROS("@id", id);
                datos.SetearPARAMETROS("@FechaC", DateTime.Now);
                datos.ejecutarAccion();

                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool Agregar(Incidencias aux)
        {
            try
            {
                datos.setearQuery("INSERT INTO Incidencia ([IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion]) VALUES (@IDcliente, @IDestado, @IDusuario, @Problematica, @Comentarios, @Prioridad, @TipoIncidencia, @AsignadoA, @FechaApertura, @FechaAct); SELECT CAST(SCOPE_IDENTITY() AS INT);");

 
                datos.SetearPARAMETROS("@IDcliente", aux.IdCliente);
                datos.SetearPARAMETROS("@IDestado", aux.Estado);
                datos.SetearPARAMETROS("@IDusuario", aux.IdUsuarioRegistro);
                datos.SetearPARAMETROS("@Problematica", aux.Problematica);
                datos.SetearPARAMETROS("@Prioridad", aux.Prioridad.Id);
                datos.SetearPARAMETROS("@TipoIncidencia", aux.TipoIncidencia.Id);
                datos.SetearPARAMETROS("@Comentarios", aux.Comentarios);
                datos.SetearPARAMETROS("@AsignadoA", aux.IdUsuarioAsignado);
                datos.SetearPARAMETROS("@FechaApertura", aux.FechaApertura);
                datos.SetearPARAMETROS("@FechaAct", aux.UltimaActualizacion);

                int idGenerado = (int)datos.ejecutarScalar();
                aux.Id = idGenerado;

                return true;
            }
            catch (Exception ex)
            {
                return false;
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool Update(Incidencias aux)
        {
            try
            {
                datos.setearQuery("UPDATE Incidencia SET [IDestado] = 2, [Problematica] = @Problematica, [Comentarios] = @Comentarios, [AsignadoA] = @AsignadoA, [UltimaActualizacion] = @UltimaActualizacion, [Prioridad] = @Prioridad, [TipoIncidencia] = @TipoIncidencia WHERE [ID] = @ID;");

                datos.SetearPARAMETROS("@ID", aux.Id);
                datos.SetearPARAMETROS("@Problematica", aux.Problematica);
                datos.SetearPARAMETROS("@Prioridad", aux.Prioridad.Id);
                datos.SetearPARAMETROS("@TipoIncidencia", aux.TipoIncidencia.Id);
                datos.SetearPARAMETROS("@Comentarios", aux.Comentarios); 
                datos.SetearPARAMETROS("@AsignadoA", aux.IdUsuarioAsignado);
                datos.SetearPARAMETROS("@UltimaActualizacion", aux.UltimaActualizacion);

                datos.ejecutarAccion();
                return true; 

            }
            catch (Exception ex)
            {
                return false;
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
