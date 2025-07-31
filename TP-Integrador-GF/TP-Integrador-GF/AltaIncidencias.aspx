<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AltaIncidencias.aspx.cs" Inherits="TP_Integrador_GF.AltaIncidencias" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        .textBoxGrande {
            font-size: 16px;
        }

        .titulo {
            font-size: 28px; 
            font-weight: bold; 
        }

        .cuerpo {
            font-size: 16px; 
            font-weight: bold; 
            margin-bottom:20px;
        }
        
        .Cardd {
            width: 90%;
            height: auto;
            min-height: 60vh; 
            background-color: #FFFFFF; 
            margin: 10px auto; 
            font-size: 14px; 
            border-radius: 8px; 
            padding: 10px; 
            box-sizing: border-box; 
        }

        .btnn {
            padding: 10px 20px;
            font-size: 20px;
            border-radius: 8px;
        }

        .Espacio {
            margin-top:80px;
        }

        .select2-container {
            width: 100% !important; 
        }

    </style>

        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


     <div class="container mb-2">

        <div class="row justify-content-md-center">
            <%if (Request.QueryString["id"] == null){ %>
                <h1 class="titulo">Nueva Incidencia</h1>
            <%} %>
            <%else{ %>
                <h1 class="titulo">Editar Incidencia</h1>
            <%} %>

            <h5 class="cuerpo">Registre los datos del reporte de incidencia:</h5>
            
        </div>

        <br>
        <div class="row justify-content-center mb-3">
            <div class="card col-md-11">

                <br />
                <br />

                <div class="Cardd">
                        <div class="row" style="font-size:14px;">

                            <% if (Request.QueryString["id"] != null)
                               {%>

                                    <div class="col-md-3 mb-3">
                                        <div class="form-group">
                                            <label class="form-label">NºIncidencia:</label>
                                            <asp:TextBox ID="txtNincidencia" CssClass="form-control textBoxGrande" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                
                                    <div class="col-md-3 mb-3">
                                        <div class="form-group">
                                            <label  class="form-label">Fecha de Alta:</label>
                                            <asp:TextBox ID="TxtAlta" CssClass="form-control textBoxGrande"  runat="server"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <label  class="form-label">Ultima Actualizacion</label>
                                                <asp:TextBox ID="TxtAct" CssClass="form-control textBoxGrande" runat="server"></asp:TextBox>
                                            </div>
                                        </div>

                                    <div class="col-md-3 mb-3">
                                            <div class="form-group">
                                                <label  class="form-label">Fecha de cierre:</label>
                                                <asp:TextBox ID="TxtCierre" CssClass="form-control textBoxGrande" runat="server"></asp:TextBox>
                                            </div>
                                        </div>

                             <%}%>

                            <div class="col-md-3 mb-3"></div>
                            <div class="col-md-6 mb-3">

                              <div class="form-group">
                                    <label for="ddlCliente" class="control-label">Cliente:</label>
                                    <div>
                                        <asp:DropDownList ID="ddlCliente" CssClass="form-control select2 textBoxGrande" required="" runat="server" AppendDataBoundItems="true">
           
                                            <asp:ListItem Text="" Value=""></asp:ListItem> 
                                        </asp:DropDownList>
                                        </div>
                                </div>

                            </div>
                                    <script>
                                        $(document).ready(function () {
                                            
                                            $('.select2').select2({
                                                placeholder: "SELECCIONE EL CLIENTE", 
                                               
                                                
                                            });
                                        });
                                    </script>

                          <div class="col-md-3 mb-3"></div>

                            <div class="col-md-4 mb-3">
                                <div class="form-group">
                                     <label for="lblTipo" class="form-label">Tipo de incidencia:</label>
                                    <asp:DropDownList ID="DdlTipoInc" CssClass="form-control textBoxGrande"  required="" runat="server"></asp:DropDownList>
                                </div>
                            </div>

                             <div class="col-md-4 mb-3">

                                 <% if (Request.QueryString["id"] != null)
                                    {%>
                                         <div class="form-group">
                                             <label for="lblEstado" class="form-label">Estado:</label>
                                             <asp:TextBox ID="txtEstado" CssClass="form-control textBoxGrande" runat="server"></asp:TextBox>
                                         </div>  
                                 <%} %>
                             </div>

                            <div class="col-md-4 mb-3">
                                <div class="form-group">
                                    <label for="lblPrioridad" class="form-label">Prioridad:</label>
                                    <asp:DropDownList ID="DdlPrioridad" CssClass="form-control textBoxGrande"  required="" runat="server"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="lblProblem" class="form-label">Problematica:</label>
                                    <asp:TextBox ID="txtProbLem" CssClass="form-control textBoxGrande" runat="server" Rows="6" Columns="20"  required="" TextMode="MultiLine" style="height: 85px;"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6 mb-2">
                                <div class="form-group">
                                    <label for="lblComents" class="form-label">Comentarios:</label>
                                    <asp:TextBox ID="txtComents" Rows="6" Columns="20" CssClass="form-control textBoxGrande" required="" TextMode="MultiLine" runat="server" style="height: 85px;"></asp:TextBox>
                                </div>
                            </div>

                                <div class="col-md-1 mb-2"></div>
                                
                            <% if (Request.QueryString["id"] != null)
                                {%>
                                    <div class="col-md-3 mb-2">
                                        <div class="form-group">
                                            <label for="lblRegistro" class="form-label">Registrado x:</label>
                                            <asp:TextBox ID="txtRegistroUsuario" CssClass="form-control textBoxGrande" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                            <%} %>

                           <% if (Request.QueryString["id"] != null && ViewState["FechaDeCierre"] != null)
                               {%>
                                    <div class="col-md-4 mb-2">
                                        <div class="form-group">
                                            <label for="lblComentarioFinal" class="form-label">Comentario final:</label>
                                            <asp:TextBox ID="txtComentarioFinal" CssClass="form-control textBoxGrande" TextMode="MultiLine" Rows="6" Columns="20" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                            <%}
                              else
                              { %>
                                    <div class="col-md-4 mb-2"></div>
                            <%} %>

                            <%if (Session["IDPerfil"]?.ToString() == "2" || Session["IDPerfil"]?.ToString() == "3")
                                { %>
                                     <div class="col-md-3 mb-2">
                                          <div class="form-group">
                                             <label for="lblAsignado" class="form-label">Asignado a:</label>
                                             <asp:DropDownList ID="DdlAsignar" CssClass="form-control textBoxGrande" runat="server"></asp:DropDownList>
                                         </div>
                                     </div>
                                    <div class="col-md-1 mb-2"></div>
                            <%} %>
                                   

                            <div class="Espacio">
                                <div class="col-md-12 mb-3"></div>
                            </div>

                            <div class="row">

                                <div class="col-md-2 offset-md-4 mb-2">
                                    <% if (Request.QueryString["id"] == null ) { %>
                                        <asp:Button ID="btnGuardar" OnClick="btnCargar_Click" AutoPostBack="true" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Cargar" />
                                    <% } else if(ViewState["FechaDeCierre"] == null){ %>
                                        <asp:Button ID="btnEditar" OnClick="btnEditar_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="Editar" />
                                    <% } %>
                                </div>

                                <div class="col-md-2 mb-2">
                                    <a href="Historial_Incidencias.aspx" class="btn btn-danger btn-lg btnn">Cancelar</a>
                                </div>

                            </div>   

                        </div>   
                </div>

            </div>
        </div>
   </div>

</asp:Content>
