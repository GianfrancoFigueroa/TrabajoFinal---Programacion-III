<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Historial_Usuarios.aspx.cs" Inherits="TP_Integrador_GF.Historial_Usuarios" %>

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
            flex-wrap: wrap;
            margin-bottom: 20px;
            gap: 15px;
            align-items:flex-end;
            justify-content: space-between;
        }

        .filter-item {
            display: flex;
            flex-direction: column;
            flex-basis: calc(30% - 10px);
            margin-bottom: 10px;
        }

        .filter-item2 {
            display: flex;
            flex-direction: column;
            flex-basis: 40%;
            margin-bottom: 10px;
        }

        .cuerpo {
            font-size: 14px; 
            margin-bottom: 5px; 
        }

        .ampliado {
            width: 100%; 
            height: 34px;
            font-size: 14px;
            box-sizing:border-box;
        }

        #ddlOrden {
            width: 100%; 
            height: 34px;
            font-size: 14px;
            box-sizing:border-box;
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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <div class="miDiv">
        <div>
            <asp:Label runat="server" CssClass="titulo">Historial de Usuarios</asp:Label>
            <hr />
        </div>

            <div class="filter-container">
                <div class="filter-item2">
                    <asp:Label runat="server" CssClass="cuerpo">Buscar:</asp:Label>
                    <asp:TextBox runat="server" ID="txtBusqueda" OnTextChanged="txtChange" CssClass="ampliado" AutoPostBack="true" placeHolder="Busqueda por DNI o Mail"></asp:TextBox>
                </div>
                <div class="filter-item" >
                    <asp:Label runat="server" CssClass="cuerpo">Ordenar:</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlOrden" OnSelectedIndexChanged="ddlOrden_SelectedIndexChanged" AutoPostBack="true" CssClass="ampliado"></asp:DropDownList>
                </div>
                <div class="btn-container">
                    <asp:Button ID="btnCargar" OnClick="btnCargar_Click" CssClass="btn btn-success btn-lg btnn" runat="server" Text="+" />
                </div>
            </div>

        <% if (GridUsuarios.Rows.Count == 0) { %>
            <div style="text-align: center; margin-top: 30vh; transform: translateY(-50%);">
                <asp:Label runat="server" CssClass="not-found-label">No hay registros</asp:Label>
            </div>
        <% } else { %>

            <asp:GridView ID="GridUsuarios" runat="server" AutoGenerateColumns="false" AllowPaging="true" PageSize="8" OnSelectedIndexChanged="GridUsuarios_SelectedIndexChanged" OnRowDeleting="GridUsuarios_RowDeleting" OnPageIndexChanging="GridUsuarios_PageIndexChanging" CssClass="mi-gridview" DataKeyNames="id">
                <Columns>
                    <asp:BoundField DataField="Nombre" HeaderText="Cliente" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="DNI" HeaderText="CUIT" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Perfil" HeaderText="Tipo de Usuario" />
                    <asp:BoundField DataField="Domicilio" HeaderText="Domicilio" />
                    <asp:BoundField DataField="Provincia" HeaderText="Provincia" />
                    <asp:BoundField DataField="Localidad" HeaderText="Localidad" />
                    <asp:CommandField ShowSelectButton="true" SelectText="👁️" HeaderText=" " />

                    <asp:TemplateField ShowHeader="False" HeaderText=" ">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False"
                                CommandName="Delete" Text="🗑️"
                                OnClientClick="return confirmDeleteSweetAlert(this);" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        <% } %>
    </div>

    <script type="text/javascript">
       
        var originalDoPostBack = typeof __doPostBack === 'function' ? __doPostBack : null;

        function confirmDeleteSweetAlert(sourceButton) {
            Swal.fire({
                title: '¿Estás seguro que quieres eliminar?', 
                text: '¡No se podrá revertir!', 
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#28a745', 
                cancelButtonColor: '#dc3545', 
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'No, cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                   
                    var onclick = sourceButton.getAttribute('onclick');

                
                    if (typeof WebForm_DoPostBackWithOptions === 'function') {
                        sourceButton.removeAttribute('onclick');
                        sourceButton.click(); 
                    } else if (originalDoPostBack) {
                      
                        var match = /javascript:\s*__doPostBack\s*\(\s*'([^']*)'\s*,\s*'([^']*)'\s*\)/.exec(onclick);

                        if (match && match.length === 3) {
                            sourceButton.removeAttribute('onclick');
                            originalDoPostBack(match[1], match[2]);
                        } else {
                            console.error("Error: Patrón de __doPostBack no encontrado en onclickAttr.");
                            console.error("onclickAttr: " + onclick); 
                            Swal.fire('Error', 'No se pudo procesar la solicitud (Causa: patrón de postback).', 'error');
                        }
                    } else {
                        
                        console.error("Error: Ni WebForm_DoPostBackWithOptions ni __doPostBack están disponibles.");
                        Swal.fire('Error', 'No se pudo procesar la solicitud (Causa: funciones de postback).', 'error');
                    }
                } else {
                    console.log('Eliminación cancelada');
                }
            });
            return false; 
        }
    </script>

</asp:Content>
