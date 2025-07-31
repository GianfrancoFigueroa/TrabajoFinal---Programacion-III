using dominio;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace conexiones
{
    public class DatosEstados
    {
        List<Estado> lista = new List<Estado>();
        AccesoDatos datos = new AccesoDatos();

        public List<Estado> Listar()
        {
            try
            {
                datos.setearQuery("Select ID, Estados From Estados");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Estado aux = new Estado();
                    aux.id = (int)datos.Lector["ID"];
                    aux.estado = (string)datos.Lector["Estados"];

                    lista.Add(aux);
                }
                return lista;

            }
            catch (Exception ex)
            {


                throw ex;

            }
        }

    }
}
