using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;

namespace conexiones
{
    public class ServiceMail
    {
        private MailMessage email;
        private SmtpClient server;

        public ServiceMail()
        {
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("incidesktester@gmail.com", "nbvc edyi mxrb huui");
            server.EnableSsl = true;
            server.Port = 587;
            server.Host = "smtp.gmail.com";

        }


        public void ArmarMail(String mailDestino, String Asunto, String Mensaje)
        {
            email = new MailMessage();
            email.From = new MailAddress("noresponder@incidesk.com", "Soporte INCIDESK");
            email.To.Add(mailDestino);
            email.Subject = Asunto;
            email.IsBodyHtml = true;
            email.Body = Mensaje;
        }


        public void EnviarMail()
        {
            try
            {
                server.Send(email);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
