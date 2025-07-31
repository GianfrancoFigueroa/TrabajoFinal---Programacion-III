using System;
using System.Collections.Generic;
using System.Text;

namespace dominio
{
    [Serializable]
    public class Usuarios
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int DNI { get; set; }
        public string Tel { get; set; }
        public Perfiles Perfil { get; set; }
        public Provincias Provincia { get; set; }
        public Localidades Localidad { get; set; }
        public string Domicilio { get; set; }
        public string Email { get; set; }
        public string pass { get; set; }
        public string ImagenUrl { get; set; }
        public DateTime FechaAlta { get; set; }
        public DateTime FechaBaja { get; set; }

        public string NombreCompleto
        {
            get { return $"{Id} - {Nombre} {Apellido}"; }
        }

        public bool TieneDiferenciasCon(Usuarios other)
        {
            // Comparar cada propiedad; si alguna es diferente
            if (Id != other.Id) return false;

            if (!string.Equals(Nombre, other.Nombre, StringComparison.OrdinalIgnoreCase)) return false;
            if (!string.Equals(Apellido, other.Apellido, StringComparison.OrdinalIgnoreCase)) return false;

            if (DNI != other.DNI) return false;
            if (Perfil.idPerfil != other.Perfil.idPerfil) return false;
            if (Provincia.id != other.Provincia.id) return false;
            if (Localidad.id != other.Localidad.id) return false;

            if (!string.Equals(Domicilio, other.Domicilio, StringComparison.OrdinalIgnoreCase)) return false;
            if (!string.Equals(Email, other.Email, StringComparison.OrdinalIgnoreCase)) return false;

            // Si todas las propiedades son iguales
            return true;
        }

    }
}
