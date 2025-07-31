using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace conexiones
{
    public class DatosPerfiles
    {
        AccesoDatos datos = new AccesoDatos();
        List<Perfiles> lista = new List<Perfiles>();

        public List<Perfiles> Listar()
        {

            try
            {
                datos.setearQuery("SELECT ID, Perfil FROM Perfiles");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Perfiles aux = new Perfiles();
                    aux.idPerfil = (int)datos.Lector["ID"];
                    aux.Perfil = (string)datos.Lector["Perfil"];

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



    }
}
