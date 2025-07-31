<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Historial_Incidencias.aspx.cs" Inherits="TP_Integrador_GF.Historial_Incidencias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
     .mi-gridview {
        border-collapse: collapse;
        width: 100%;
     }

    .mi-gridview th, .mi-gridview td {
        border: 1px solid #dddddd;
        font-size: 16px;
        text-align: left;
        padding: 12px;
    }

    .mi-gridview th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    .not-found-label {
        display: inline-block;
        padding: 20px; 
        font-size: 24px; 
        background-color: #f44336; 
        color: #fff; 
        font-weight: bold;
        border-radius: 10px; 
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); 
        text-align: center; 
    }

    .centered {
        width: 20%; 
        margin: 0 auto; 
    }
    .miDiv {

        width: 90%;
        min-height: 73vh;
        padding: 20px;
        box-sizing:border-box;
        background-color: #FFFFFF ;
        margin: 0 auto; 
    }
   
    .titulo {
         font-size: 28px; 
         font-weight: bold; 
    }

    .filter-container {
        display: flex;
        flex-wrap: nowrap; 
        align-items: flex-end;
        gap: 15px;
        margin-bottom:20px;
        justify-content: space-between;
    }

    .filter-item {
         display: flex;
         flex-direction: column;
         flex-basis: calc(30% - 10px);
         margin-bottom: 10px;
         align-items: center;
    }

    .filter-item label {
       text-align: left;
       margin-bottom: 4px;

    }

    .filter-inner {
        display: flex;
        flex-direction: column;
        align-items: flex-start; 
    }

    .cuerpo {
        font-size: 14px;
        margin-bottom: 5px;
        text-align:left;
    }

    .ampliado {
        width: 600px;
        height: 34px;
        font-size: 14px;
        box-sizing: border-box;
    }

    .chico {
        width: 150px;
        height: 34px;
        font-size: 14px;
        box-sizing: border-box;
    }

    .btnn {
        padding: 4px 8px;
        width: 50px;
        height: 40px;
        font-size: 20px;
        font-weight:bold;
        box-sizing: border-box;
    }

    .btn-container {
        display: flex;
        justify-content: flex-end;
        flex-basis: 8%;
        margin-bottom: 8px;
        margin-top: 8px;
    }
    </style>
 
    <div class="miDiv">

        <div>
            <asp:Label runat="server" CssClass="titulo" >Historial de Incidencias</asp:Label>
            <hr />
        </div>

             <div class="filter-container">
                <div class="filter-item">
                    <div class="filter-inner">
                        <asp:Label runat="server" CssClass="cuerpo">Buscar:</asp:Label>
                        <asp:TextBox runat="server" ID="txtBusqueda" OnTextChanged="txtChange" AutoPostBack="true" CssClass="ampliado" Placeholder="Busqueda por NRO RECLAMO"></asp:TextBox>
                            </div>
                </div>

                <div class="filter-item">
                        <div class="filter-inner">
                        <asp:Label runat="server" CssClass="cuerpo">Estado:</asp:Label>
                        <asp:DropDownList runat="server" ID="ddlEstado" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged" CssClass="chico"></asp:DropDownList>
                        </div>
                </div>

            <% if (Session["IDPerfil"]?.ToString() == "2" || Session["IDPerfil"]?.ToString() == "3")
                {%>
                    <div class="filter-item">
                        <div class="filter-inner">
                            <asp:Label runat="server" CssClass="cuerpo">Asignado a:</asp:Label>
                            <asp:DropDownList runat="server" ID="ddlAsignadoFiltro" OnSelectedIndexChanged="ddlAsignadoFiltro_SelectedIndexChanged" AutoPostBack="true" CssClass="chico"></asp:DropDownList>
                        </div>
                    </div>
             <%}%>

                <div class="btn-container">
                    <asp:Button ID="btnCargar" OnClick="btnCargar_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="+" />
                </div>
            </div>


        <% if (GridIncidencias.Rows.Count == 0)
           {%>
                <div style="text-align: center; margin-top: 30vh; transform: translateY(-50%);">
                    <asp:Label runat="server" CssClass="not-found-label">No hay registros</asp:Label>
                </div>
         <%}
           else{%>

             <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>

                <asp:GridView ID="GridIncidencias" runat="server" AllowPaging="true" PageSize="8" Visible="true"
                    OnRowEditing="GridIncidencias_RowEditing"
                    OnRowDeleting="GridIncidencias_RowDeleting"
                    OnSelectedIndexChanged="GridIncidencias_SelectedIndexChanged"
                    OnPageIndexChanging="GridIncidencias_PageIndexChanging"
                    AutoGenerateColumns="false" CssClass="mi-gridview" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID Incidencia" Visible="false" />
                        <asp:BoundField DataField="NumeroReclamo" HeaderText="N° Reclamo" />
                        <asp:BoundField DataField="IdCliente" HeaderText="ID Cliente" />
                        <asp:BoundField DataField="NombreEstado" HeaderText="Estado" />
                        <asp:BoundField DataField="Prioridad.Prioridad" HeaderText="Prioridad" />
                        <asp:BoundField DataField="TipoIncidencia.Tipo" HeaderText="Tipo Incidencia" />

                        <asp:BoundField DataField="NombreCompletoUsuarioAsignado" HeaderText="Asignado A" />
                        <asp:BoundField DataField="NombreCompletoUsuarioRegistro" HeaderText="Registrado Por" />

                        <asp:BoundField DataField="FechaApertura" HeaderText="Fecha Apertura" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="UltimaActualizacion" HeaderText="Última Actualización" DataFormatString="{0:dd/MM/yyyy}" NullDisplayText="N/A" />
                        <asp:BoundField DataField="FechaCierre" HeaderText="Fecha Cierre" DataFormatString="{0:dd/MM/yyyy}" NullDisplayText="N/A" />

                        <asp:CommandField ShowSelectButton="true" SelectText="Ver Detalle" HeaderText=" " ControlStyle-CssClass="btn-grid btn-ver" />

                          <asp:TemplateField ShowHeader="False" HeaderText=" ">
                              <ItemTemplate>
                                  <asp:LinkButton ID="btnResolver" runat="server" CausesValidation="False"
                                      CommandName="Edit" Text="Resolver" CssClass="btn-grid btn-resolver"
                                      OnClientClick="return confirmSweetAlert(this);" />
                              </ItemTemplate>
                          </asp:TemplateField>
                        
                        <asp:TemplateField ShowHeader="False" HeaderText=" ">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False"
                                    CommandName="Delete" Text="Cerrar"
                                    OnClientClick="return confirmSweetAlert(this);" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                
                </asp:GridView>
              </ContentTemplate>
               </asp:UpdatePanel>

        <%  } %>
           </div>

             <script type="text/javascript">

                   var originalDoPostBack = typeof __doPostBack === 'function' ? __doPostBack : null;

                   function confirmSweetAlert(sourceButton) {
                       let texto = '', titulo = '';
                       const btnId = sourceButton.id;

                       if (btnId.includes('btnDelete')) {
                           titulo = '¿Estás seguro que querés cerrar?';
                           texto = '¡No se podrá revertir!';
                       } else if (btnId.includes('btnResolver')) {
                           titulo = '¿Estás seguro que querés resolver?';
                           texto = 'Esta acción marcará el reclamo como resuelto.';
                       }

                       Swal.fire({
                           title: titulo,
                           text: texto,
                           icon: 'warning',
                           showCancelButton: true,
                           confirmButtonColor: '#28a745',
                           cancelButtonColor: '#dc3545',
                           confirmButtonText: 'Continuar',
                           cancelButtonText: 'Cancelar'
                       }).then((result) => {
                           if (result.isConfirmed) {
                               showCommentSweetAlert(sourceButton);
                           } else {
                               console.log('Eliminación cancelada por el usuario.');
                           }
                       });
                       return false;
                   }

                   function showCommentSweetAlert(sourceButton) {
                       Swal.fire({
                           title: 'Ingrese un comentario final',
                           input: 'textarea',
                           inputPlaceholder: 'Escriba su comentario aquí...',
                           inputAttributes: {
                               'aria-label': 'Comentario final'
                           },
                           showCancelButton: true,
                           confirmButtonColor: '#28a745',
                           cancelButtonColor: '#dc3545',
                           confirmButtonText: 'Confirmar',
                           cancelButtonText: 'Cancelar',
                           preConfirm: (comment) => {
                               const trimmedComment = comment ? comment.trim() : '';
                               if (trimmedComment === '') {
                                   Swal.showValidationMessage('El comentario es obligatorio.');
                                   return false;
                               }
                               return trimmedComment;
                           }
                       }).then((commentResult) => {
                           if (commentResult.isConfirmed) {
                               var comment = commentResult.value || "";
                               firePostbackWithComment(sourceButton, comment);
                           } else {
                               console.log('Ingreso de comentario cancelado');
                           }
                       });
                   }

                   function firePostbackWithComment(sourceButton, comment) {
                       
                       var hiddenFieldName = 'hdnComment';
                       var hiddenField = document.getElementById(hiddenFieldName);

                       if (!hiddenField) {
                           hiddenField = document.createElement('input');
                           hiddenField.type = 'hidden';
                           hiddenField.id = hiddenFieldName;
                           hiddenField.name = hiddenFieldName;
                           document.forms[0].appendChild(hiddenField); 
                       }
                       var id = sourceButton.id;
                       hiddenField.value = comment;

                       var hrefAttr = sourceButton.getAttribute('href');

                       if (!hrefAttr) {
                           console.error("No se encontró el atributo href en el botón.");
                           Swal.fire('Error', 'No se pudo procesar la acción. Intente nuevamente.', 'error');
                           return;
                       }

                       var match = /__doPostBack\('([^']*)','([^']*)'\)/.exec(hrefAttr);
                       if (!match || match.length < 2) {
                           console.error("No se pudo extraer el __doPostBack.");
                           Swal.fire('Error', 'No se pudo determinar el destino del postback.', 'error');
                           return;
                       }

                       var eventTarget = match[1]; 
                       var eventArgument = match[2]; 

                       if (id === 'btnResolver') {
                           eventTarget = "GridIncidencias"
                           eventArgument = "Edit$" + índice; 
                       }
                       else if (id === 'btnDelete') {
                           eventTarget = "GridIncidencias";
                           eventArgument = "Delete$" + índice;
                       }

                       console.log("🔁 Ejecutando __doPostBack a:", eventTarget);

                       __doPostBack(eventTarget, eventArgument);
                   }
             </script>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> 

</asp:Content>