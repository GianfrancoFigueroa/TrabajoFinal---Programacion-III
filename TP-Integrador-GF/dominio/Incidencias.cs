using System;
using System.Collections.Generic;
using System.Text;

namespace dominio
{
    [Serializable]
    public class Incidencias
    {
        public int Id { get; set; }
        public string NumeroReclamo { get; set; }
        public int IdCliente { get; set; }
        public int Estado { get; set; }
        public string Contacto { get; set; } 
        public Prioridades Prioridad { get; set; }
        public TiposIncidencias TipoIncidencia { get; set; }
        public int IdUsuarioAsignado { get; set; }
        public string NombreCompletoUsuarioAsignado { get; set; }
        public int IdUsuarioRegistro { get; set; }
        public string NombreCompletoUsuarioRegistro { get; set; }
        public string Problematica { get; set; }
        public string Comentarios { get; set; }
        public string ComentarioF { get; set; }
        public DateTime FechaApertura { get; set; }
        public DateTime? UltimaActualizacion { get; set; }
        public DateTime? FechaCierre { get; set; } 
        public string NombreEstado
        {
            get
            {
                switch (Estado)
                {
                    case 1: return "Abierto";
                    case 2: return "Analisis";
                    case 3: return "Cerrado";
                    case 4: return "Reabierto";
                    case 5: return "Asignado";
                    case 6: return "Resuelto";
                    default: return " "; 
                }
            }
        }
    }

}
