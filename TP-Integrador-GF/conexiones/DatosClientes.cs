using System;
using System.Collections.Generic;
using System.Text;
using dominio;

namespace conexiones
{
    public class DatosClientes
    {
        AccesoDatos datos = new AccesoDatos();
        public List<Clientes> Listar()
        {
            try
            {
                List<Clientes> lista = new List<Clientes>();
                datos.setearQuery("Select c.ID as Id,c.NomClien as Nombre,c.ApellClien as Apellido,c.DNIClien as DNI,c.Tel as Tel,c.Email as Email,c.Domicilio as Domicilio, c.Provincias AS idprovincia, p.provincia as provincia, c.localidad as idlocalidad, l.localidad as localidad From Clientes c, provincias p, localidades l where p.id = l.idprovincia and c.Provincias = p.id and c.localidad = l.id and c.Estado = 1");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Clientes aux = new Clientes();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Telefono = (string)datos.Lector["Tel"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
                    aux.Provincia = new Provincias();
                    aux.Provincia.id = (int)datos.Lector["idprovincia"];
                    aux.Provincia.provincia = (string)datos.Lector["provincia"];
                    aux.Localidad = new Localidades();
                    aux.Localidad.id = (int)datos.Lector["idlocalidad"];
                    aux.Localidad.localidad = (string)datos.Lector["localidad"];

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

        public bool Agregar(Clientes add)
        {
            try
            {
                datos.setearQuery("INSERT INTO Clientes(NomClien, ApellClien, DNIClien, Tel, Email, Domicilio, Provincias, localidad, Estado) VALUES (@Nombre, @Apellido, @DNI, @Tel, @Mail, @Direccion, @Provincia, @Localidad, 1)");

                datos.SetearPARAMETROS("@Nombre", add.Nombre);
                datos.SetearPARAMETROS("@Apellido", add.Apellido);
                datos.SetearPARAMETROS("@DNI", add.DNI);
                datos.SetearPARAMETROS("@Tel", add.Telefono);
                datos.SetearPARAMETROS("@Mail", add.Email);
                datos.SetearPARAMETROS("@Direccion", add.Domicilio);
                datos.SetearPARAMETROS("@Provincia", add.Provincia.id);
                datos.SetearPARAMETROS("@Localidad", add.Localidad.id);

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



        public bool Update(Clientes cliente)
        {
            try
            {
                datos.setearQuery("UPDATE Clientes SET NomClien = @Nombre, ApellClien = @Apellido, DNIClien = @DNI, Tel = @Tel, Email = @Mail, Domicilio = @Direccion, Provincias = @Provincia, localidad = @Localidad WHERE id = @IDupdate");

                datos.SetearPARAMETROS("@IDupdate", cliente.Id);
                datos.SetearPARAMETROS("@Nombre", cliente.Nombre);
                datos.SetearPARAMETROS("@Apellido", cliente.Apellido);
                datos.SetearPARAMETROS("@Tel", cliente.Telefono);
                datos.SetearPARAMETROS("@DNI", cliente.DNI);
                datos.SetearPARAMETROS("@Mail", cliente.Email);
                datos.SetearPARAMETROS("@Direccion", cliente.Domicilio);
                datos.SetearPARAMETROS("@Provincia", cliente.Provincia.id);
                datos.SetearPARAMETROS("@Localidad", cliente.Localidad.id);

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


        public List<Clientes> ListarOrdenadoASC()
        {
            try
            {
                List<Clientes> lista = new List<Clientes>();
                datos.setearQuery("Select c.ID as Id,c.NomClien as Nombre,c.ApellClien as Apellido,c.DNIClien as DNI,c.Tel as Tel,c.Email as Email,c.Domicilio as Domicilio, c.Provincias AS idprovincia, p.provincia as provincia, c.localidad as idlocalidad, l.localidad as localidad From Clientes c, provincias p, localidades l where p.id = l.idprovincia and c.Provincias = p.id and c.localidad = l.id and c.Estado = 1 ORDER BY c.NomClien ASC, c.ApellClien ASC");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Clientes aux = new Clientes();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Telefono = (string)datos.Lector["Tel"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
                    aux.Provincia = new Provincias();
                    aux.Provincia.id = (int)datos.Lector["idprovincia"];
                    aux.Provincia.provincia = (string)datos.Lector["provincia"];
                    aux.Localidad = new Localidades();
                    aux.Localidad.id = (int)datos.Lector["idlocalidad"];
                    aux.Localidad.localidad = (string)datos.Lector["localidad"];

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


        public List<Clientes> ListarOrdenadoDESC()
        {
            try
            {
                List<Clientes> lista = new List<Clientes>();
                datos.setearQuery("Select c.ID as Id,c.NomClien as Nombre,c.ApellClien as Apellido,c.DNIClien as DNI,c.Tel as Tel,c.Email as Email,c.Domicilio as Domicilio, c.Provincias AS idprovincia, p.provincia as provincia, c.localidad as idlocalidad, l.localidad as localidad From Clientes c, provincias p, localidades l where p.id = l.idprovincia and c.Provincias = p.id and c.localidad = l.id and c.Estado = 1 ORDER BY c.NomClien DESC, c.ApellClien DESC");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Clientes aux = new Clientes();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (int)datos.Lector["DNI"];
                    aux.Telefono = (string)datos.Lector["Tel"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
                    aux.Provincia = new Provincias();
                    aux.Provincia.id = (int)datos.Lector["idprovincia"];
                    aux.Provincia.provincia = (string)datos.Lector["provincia"];
                    aux.Localidad = new Localidades();
                    aux.Localidad.id = (int)datos.Lector["idlocalidad"];
                    aux.Localidad.localidad = (string)datos.Lector["localidad"];

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

        public bool Baja(int id)
        {
            try
            {
                datos.setearQuery("UPDATE Clientes SET Estado = 0 WHERE id = @ID");
                datos.SetearPARAMETROS("@ID", id);
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
