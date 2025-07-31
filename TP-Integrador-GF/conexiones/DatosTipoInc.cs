using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;
using conexiones;

namespace conexiones
{
    public class DatosTipoInc
    {
        List<TiposIncidencias> lista = new List<TiposIncidencias>();
        AccesoDatos datos = new AccesoDatos();

        public List<TiposIncidencias> Listar()
        {
            try
            {
                datos.setearQuery("Select ID, TipoInc From TipoIncidencia");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    TiposIncidencias aux = new TiposIncidencias();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.Tipo = (string)datos.Lector["TipoInc"];

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
