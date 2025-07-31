using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using conexiones;
using dominio;

namespace conexiones
{
    public class DatosLocalidades
    {
        List<Localidades> lista = new List<Localidades>();
        AccesoDatos datos = new AccesoDatos();

        public List<Localidades> Listar(int IdProv)
        {
            try
            {
                datos.setearQuery("SELECT ID, localidad, idprovincia FROM localidades WHERE idprovincia = @IdProv");
                datos.SetearPARAMETROS("@IdProv", IdProv);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Localidades aux = new Localidades();
                    aux.id = (int)datos.Lector["ID"];
                    aux.localidad = (string)datos.Lector["localidad"];
                    
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

