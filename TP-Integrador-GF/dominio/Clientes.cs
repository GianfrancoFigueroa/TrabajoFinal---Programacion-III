using System;
using System.Collections.Generic;
using System.Text;

namespace dominio
{
    [Serializable]
    public class Clientes
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int DNI { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Domicilio { get; set; }
        public Provincias Provincia { get; set; }
        public Localidades Localidad { get; set; }
        public string NombreCompleto
        {
            get { return $"{Id} - {Nombre} {Apellido}"; }
        }


        public bool TieneDiferenciasCon(Clientes other)
        {
            // Comparar cada propiedad; si alguna es diferente
            if (Id != other.Id) return false;
            if (Nombre != other.Nombre) return false;
            if (Apellido != other.Apellido) return false;
            if (DNI != other.DNI) return false;
            if (Telefono != other.Telefono) return false;
            if (Provincia.id != other.Provincia.id) return false;
            if (Localidad.id != other.Localidad.id) return false;
            if (Domicilio != other.Domicilio) return false;
            if (Email != other.Email) return false;


            // Si todas las propiedades son iguales
            return true;
        }

    }
}
