using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using conexiones;
using dominio;

namespace conexiones
{
    public class DatosPrioridad
    {
        List<Prioridades> lista = new List<Prioridades>();
        AccesoDatos datos = new AccesoDatos();

        public List<Prioridades> Listar()
        {
            try
            {
                datos.setearQuery("Select ID, Prioridad From prioridad");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Prioridades aux = new Prioridades();
                    aux.Id = (int)datos.Lector["ID"];
                    aux.Prioridad = (string)datos.Lector["Prioridad"];
                 
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
