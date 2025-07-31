using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using conexiones;
using dominio;

namespace conexiones
{
    public class DatosProvincias
    {
        List<Provincias> lista = new List<Provincias>();
        AccesoDatos datos = new AccesoDatos();

        public List<Provincias> Listar()
        {
            try
            {
                datos.setearQuery("Select ID, provincia From provincias");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Provincias aux = new Provincias();
                    aux.id = (int)datos.Lector["ID"];
                    aux.provincia = (string)datos.Lector["provincia"];

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
