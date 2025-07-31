using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace conexiones
{
    public class DatosUsuarios
    {
        AccesoDatos datos = new AccesoDatos();

        public bool Logueo(Usuarios Usuario)
        {
            Usuarios aux = new Usuarios();
            try
            {
                datos.setearQuery("select U.ID as Id, U.Nombre as Nombre, U.Apellido as Apellido, U.DNI as DNI, U.IDPerf as IDPerfil, E.Perfil as Perfil, U.Pass as pass, U.Email as Email, U.Domicilio as Domicilio, U.Provincia as IDProvincia, P.provincia as Provinciaa, U.ImgUrl as ImgUrl, U.Localidad as ID_Local, L.localidad as localidad FROM Usuarios U, Perfiles E, Localidades L, Provincias P where U.Email = @mail and U.Pass = @pass and U.Estado = 1");
                datos.SetearPARAMETROS("@mail", Usuario.Email);
                datos.SetearPARAMETROS("@pass", Usuario.pass);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    return true;
                }
                return false;
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

        public List<Usuarios> Listar()
        {
            try
            {
                List<Usuarios> lista = new List<Usuarios>();
                datos.setearQuery("SELECT U.ID AS Id, U.Nombre AS Nombre, U.Apellido AS Apellido, U.DNI AS DNI, U.IDPerf AS IDPerfil, U.Tel as Tel, U.ImgUrl as ImgUrl, E.Perfil AS Perfil, U.Pass AS pass, U.Email AS Email, U.Domicilio AS Domicilio, U.Provincia AS IDProvincia, P.provincia AS Provincia, U.Localidad AS ID_Local, L.localidad AS Localidad FROM Usuarios U INNER JOIN Perfiles E ON U.IDPerf = E.ID INNER JOIN Localidades L ON U.Localidad = L.ID INNER JOIN Provincias P ON U.Provincia = P.ID WHERE U.Estado = 1;");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuarios aux = new Usuarios();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.pass = (string)datos.Lector["pass"];

                    aux.Perfil = new Perfiles();
                    aux.Perfil.idPerfil = (int)datos.Lector["IDPerfil"];
                    aux.Perfil.Perfil = (string)datos.Lector["Perfil"];

                    aux.Localidad = new Localidades();
                    aux.Localidad.id = (int)datos.Lector["ID_Local"];
                    aux.Localidad.localidad = (string)datos.Lector["localidad"];

                    aux.Provincia = new Provincias();
                    aux.Provincia.id = (int)datos.Lector["IDProvincia"];
                    aux.Provincia.provincia = (string)datos.Lector["Provincia"];

                    aux.Tel = datos.Lector["Tel"] != DBNull.Value ? (string)datos.Lector["Tel"] : string.Empty;
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
                    aux.ImagenUrl = datos.Lector["ImgUrl"] != DBNull.Value ? (string)datos.Lector["ImgUrl"] : string.Empty;

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

        public bool Agregar(Usuarios add)
        {
            try
            {
                datos.setearQuery("INSERT INTO Usuarios (Nombre, Apellido, DNI, IDPerf, Pass, Tel, Email, Domicilio, Provincia, Localidad, FechaAlta, Estado) VALUES (@Nombre, @Apellido, @DNI, @Perfil, @Pass, @Tel, @Mail, @Direccion, @Provincia, @Localidad, @FAlta, @Estado)");
                
                datos.SetearPARAMETROS("@Nombre", add.Nombre);
                datos.SetearPARAMETROS("@Apellido", add.Apellido);
                datos.SetearPARAMETROS("@DNI", add.DNI);
                datos.SetearPARAMETROS("@Perfil", add.Perfil.idPerfil);
                datos.SetearPARAMETROS("@Pass", add.pass);
                datos.SetearPARAMETROS("@Tel", add.Tel);
                datos.SetearPARAMETROS("@Mail", add.Email);
                datos.SetearPARAMETROS("@FAlta", add.FechaAlta);
                datos.SetearPARAMETROS("@Direccion", add.Domicilio);
                datos.SetearPARAMETROS("@Provincia", add.Provincia.id);
                datos.SetearPARAMETROS("@Localidad", add.Localidad.id);
                datos.SetearPARAMETROS("@Estado", 1);
                datos.ejecutarAccion();

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al agregar el usuario: " + ex.Message);  
                return false;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }


        public bool Update(Usuarios usuario)
        {
            try
            {
                datos.setearQuery("UPDATE Usuarios SET Nombre = @Nombre, Apellido = @Apellido, DNI = @DNI, Email = @Mail, Tel = @Tel, IDPerf = @Perfil, Domicilio = @Direccion, Provincia = @Provincia, Localidad = @Localidad WHERE id = @IDupdate");

                datos.SetearPARAMETROS("@IDupdate", usuario.Id);
                datos.SetearPARAMETROS("@Nombre", usuario.Nombre);
                datos.SetearPARAMETROS("@Apellido", usuario.Apellido);
                datos.SetearPARAMETROS("@DNI", usuario.DNI);
                datos.SetearPARAMETROS("@Perfil", usuario.Perfil.idPerfil);
                datos.SetearPARAMETROS("@Mail", usuario.Email);
                datos.SetearPARAMETROS("@Tel", usuario.Tel);
                datos.SetearPARAMETROS("@Direccion", usuario.Domicilio);
                datos.SetearPARAMETROS("@Provincia", usuario.Provincia.id);
                datos.SetearPARAMETROS("@Localidad", usuario.Localidad.id);

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

        public List<Usuarios> ListaOrdenadaASC()
        {
            try
            {
                List<Usuarios> lista = new List<Usuarios>();
                datos.setearQuery("SELECT U.ID AS Id, U.Nombre AS Nombre, U.Apellido AS Apellido, U.DNI AS DNI, U.IDPerf AS IDPerfil, U.Tel as Tel, U.ImgUrl as ImgUrl, E.Perfil AS Perfil, U.Pass AS pass, U.Email AS Email, U.Domicilio AS Domicilio, U.Provincia AS IDProvincia, P.provincia AS Provincia, U.Localidad AS ID_Local, L.localidad AS Localidad FROM Usuarios U INNER JOIN Perfiles E ON U.IDPerf = E.ID INNER JOIN Localidades L ON U.Localidad = L.ID INNER JOIN Provincias P ON U.Provincia = P.ID WHERE U.Estado = 1 ORDER BY U.Nombre ASC, U.Apellido ASC;");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuarios aux = new Usuarios();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.pass = (string)datos.Lector["pass"];

                    aux.Perfil = new Perfiles();
                    aux.Perfil.idPerfil = datos.Lector["IDPerfil"] != DBNull.Value ? (int)datos.Lector["IDPerfil"] : 0;
                    aux.Perfil.Perfil = datos.Lector["Perfil"] != DBNull.Value ? (string)datos.Lector["Perfil"] : string.Empty;

                    aux.Localidad = new Localidades();
                    aux.Localidad.id = datos.Lector["ID_Local"] != DBNull.Value ? (int)datos.Lector["ID_Local"] : 0;
                    aux.Localidad.localidad = datos.Lector["localidad"] != DBNull.Value ? (string)datos.Lector["localidad"] : string.Empty;

                    aux.Provincia = new Provincias();
                    aux.Provincia.id = datos.Lector["IDProvincia"] != DBNull.Value ? (int)datos.Lector["IDProvincia"] : 0;
                    aux.Provincia.provincia = datos.Lector["Provincia"] != DBNull.Value ? (string)datos.Lector["Provincia"] : string.Empty;

                    aux.Tel = datos.Lector["Tel"] != DBNull.Value ? (string)datos.Lector["Tel"] : string.Empty;
                    aux.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : string.Empty;
                    aux.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : string.Empty;
                    aux.ImagenUrl = datos.Lector["ImgUrl"] != DBNull.Value ? (string)datos.Lector["ImgUrl"] : string.Empty;

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


        public List<Usuarios> ListaOrdenadaDESC()
        {
            try
            {
                List<Usuarios> lista = new List<Usuarios>();
                datos.setearQuery("SELECT U.ID AS Id, U.Nombre AS Nombre, U.Apellido AS Apellido, U.DNI AS DNI, U.IDPerf AS IDPerfil, U.Tel as Tel, U.ImgUrl as ImgUrl, E.Perfil AS Perfil, U.Pass AS pass, U.Email AS Email, U.Domicilio AS Domicilio, U.Provincia AS IDProvincia, P.provincia AS Provincia, U.Localidad AS ID_Local, L.localidad AS Localidad FROM Usuarios U INNER JOIN Perfiles E ON U.IDPerf = E.ID INNER JOIN Localidades L ON U.Localidad = L.ID INNER JOIN Provincias P ON U.Provincia = P.ID WHERE U.Estado = 1 ORDER BY U.Nombre DESC, U.Apellido DESC;");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuarios aux = new Usuarios();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.pass = (string)datos.Lector["pass"];

                    aux.Perfil = new Perfiles();
                    aux.Perfil.idPerfil = datos.Lector["IDPerfil"] != DBNull.Value ? (int)datos.Lector["IDPerfil"] : 0;
                    aux.Perfil.Perfil = datos.Lector["Perfil"] != DBNull.Value ? (string)datos.Lector["Perfil"] : string.Empty;

                    aux.Localidad = new Localidades();
                    aux.Localidad.id = datos.Lector["ID_Local"] != DBNull.Value ? (int)datos.Lector["ID_Local"] : 0;
                    aux.Localidad.localidad = datos.Lector["localidad"] != DBNull.Value ? (string)datos.Lector["localidad"] : string.Empty;

                    aux.Provincia = new Provincias();
                    aux.Provincia.id = datos.Lector["IDProvincia"] != DBNull.Value ? (int)datos.Lector["IDProvincia"] : 0;
                    aux.Provincia.provincia = datos.Lector["Provincia"] != DBNull.Value ? (string)datos.Lector["Provincia"] : string.Empty;

                    aux.Tel = datos.Lector["Tel"] != DBNull.Value ? (string)datos.Lector["Tel"] : string.Empty;
                    aux.Email = datos.Lector["Email"] != DBNull.Value ? (string)datos.Lector["Email"] : string.Empty;
                    aux.Domicilio = datos.Lector["Domicilio"] != DBNull.Value ? (string)datos.Lector["Domicilio"] : string.Empty;
                    aux.ImagenUrl = datos.Lector["ImgUrl"] != DBNull.Value ? (string)datos.Lector["ImgUrl"] : string.Empty;

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

        public bool CambiarContra(String password, int idPassChange)
        {
            try
            {
                datos.setearQuery("UPDATE Usuarios SET Pass = @Pass WHERE id = @IDupdate");

                datos.SetearPARAMETROS("@Pass", password);
                datos.SetearPARAMETROS("@IDupdate", idPassChange);
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



        public bool Baja(int id)
        {
            try
            {
                datos.setearQuery("UPDATE Usuarios SET Estado = 0 WHERE id = @ID");
                datos.SetearPARAMETROS("@ID", id);
                datos.ejecutarLectura();

                return true ;
            }
            catch (Exception ex)
            {
                return false ;
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool CargaFoto(int id, string Url)
        {
            try
            {
                datos.setearQuery("UPDATE Usuarios SET ImgUrl = @Url WHERE id = @ID");
                datos.SetearPARAMETROS("@ID", id);
                datos.SetearPARAMETROS("@Url", Url);
                datos.ejecutarLectura();

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
