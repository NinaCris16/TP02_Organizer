<%@page import="br.cefetmg.inf.organizer.model.service.impl.KeepTag"%>
<%@page import="br.cefetmg.inf.organizer.model.service.impl.KeepItem"%>
<%@page import="br.cefetmg.inf.organizer.model.domain.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id='listItem' class='java.util.ArrayList' scope="page"/>
<jsp:useBean id='listTag' class='java.util.ArrayList' scope="page"/>

<html>
    <head>
        <title>Organizer</title>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" type="text/css" href="css/theme-default.css"/>
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <div class="page-container">
            <!-- Menu lateral -->
            <div class="page-sidebar">
                <ul class="x-navigation">
                    <li class="xn-logo">
                        <a href="#">Organizer</a>
                        <a href="#" class="x-navigation-control"></a>
                    </li>
                    <li class="xn-profile">
                        <a href="#" class="profile-mini">
                            <img src="imgs/icon.jpg" />
                        </a>
                        <div class="profile">
                            <div class="profile-image">
                                <img src="imgs/icon.jpg"/>
                            </div>
                            <div class="profile-data">
                                <div class="profile-data-name">Nome do UsuÃ¡rio</div>
                                <div class="profile-data-title">email_usuario@gmail.com</div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <a href="#"><span class="fa fa-comments"></span> <span class="xn-text">Falar com o MAX</span></a>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-adjust"></span> <span class="xn-text">Temas</span></a>
                        <ul>
                            <li><a href="#">
                              <label class="container">Tema 1
                                <input type="radio" name="tema" value="tema1">
                                <span class="checkmark"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tema 2
                                <input type="radio" name="tema" value="tema2">
                                <span class="checkmark"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tema 3
                                <input type="radio" name="tema" value="tema3">
                                <span class="checkmark"></span>
                              </label>
                            </a></li>
                        </ul>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-file-text-o"></span> <span class="xn-text">Tipos</span></a>
                        <ul>
                            <li><a href="#">
                              <label class="container">Simples
                                <input type="checkbox" name="tipo" value="simples">
                                <span class="checkmarkSimples"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tarefa
                                <input type="checkbox" name="tipo" value="tarefa">
                                <span class="checkmarkTarefa"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Lembrete
                                <input type="checkbox" name="tipo" value="lembrete">
                                <span class="checkmarkLembrete"></span>
                              </label>
                            </a></li>
                        </ul>
                    </li>
                    <li class="xn-openable">
                        <a href="#"><span class="fa fa-tag"></span> <span class="xn-text">Tags</span></a>
                        <ul id="ulTagMenu">
                            <li><a href="#" id="novaTag">
                              <span class="fa fa-plus-square-o"></span> <span class="xn-text">Nova Tag</span>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tag 1
                                <input type="checkbox" name="tag" value="Tag 1">
                                <span class="checkmarkTarefa"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tag 2
                                <input type="checkbox" name="tag" value="Tag 2">
                                <span class="checkmarkTarefa"></span>
                              </label>
                            </a></li>
                            <li><a href="#">
                              <label class="container">Tag 3
                                <input type="checkbox" name="tag" value="Tag 3">
                                <span class="checkmarkTarefa"></span>
                              </label>
                            </a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="configuracoes.html"><span class="fa fa-cogs"></span> <span class="xn-text">ConfiguraÃ§Ãµes</span></a>
                    </li>
                    <li>
                        <a href="#" id="logout"><span class="fa fa-sign-out"></span> <span class="xn-text">Sair</span></a>
                    </li>
                </ul>
            </div>

            <!-- Menu Horizontal -->
            <div class="page-content">
                <ul class="x-navigation x-navigation-horizontal x-navigation-panel">
                    <li class="xn-icon-button">
                        <a href="#" class="x-navigation-minimize"><span class="fa fa-dedent"></span></a>
                    </li>

                    <!-- Pesquisa -->
                    <li class="xn-search">
                        <form role="form">
                            <input type="text" name="pesquisar" placeholder="Perquisar..."/>
                        </form>
                    </li>
                </ul>

                <!-- Botão de visualização de lista -->
                <div class="page-title">
                  <button class="button">
                    <img id="asc" class="imgSeta" src="imgs/seta1.png">
                    <img id="dsc" class="imgSeta" style="display: none" src="imgs/seta2.png">
                  </button>
                  <select id="modoLista">
                    <option value="dataDeCriacao">Data de Criação</option>
                    <option value="nome">Nome</option>
                  </select>
                </div>

                <div class="page-content-wrap">

                    <div class="row">
                        <div class="col-md-12">

                            <div class="panel panel-default">

                                <dihv class="panel-body accordion-menu">

                                    
                                        <li>
                                            <a href="createItem.jsp">Criar Item</a>
					</li>
                                        <% 
                                            User user = new User();

                                            user.setCodEmail("ninanerd15@gmail.com");
                                            user.setUserName("Aline Cristina");

                                            KeepItem keepItem = new KeepItem();
                                            listItem = keepItem.listAllItem(user);
                                                                                        
                                            pageContext.setAttribute("listItemUser", listItem);
                                        %>
                                    
                                        <c:forEach items='${listItemUser}' var='list'>
                                            <c:choose>
                                                <c:when test = "${list.identifierItem == 'TAR'}">
                                                    <li id="${list.identifierItem}" class="open">
                                                        <label class="container" style="float:left">
                                                            <input id="${list.seqItem}" class="checkTar" type="checkbox" name="tarefa" value="${list.nameItem}">
                                                            <span class="checkmark"></span>
                                                        </label>
                                                        <button id="${list.seqItem}" class="opcoesItem btOption" value="${list.identifierItem}" data-toggle="modal" data-target="#btaoOpcaoModal"><i class="fa fa-ellipsis-v"></i></button>
                                                        <div class="dropdownlink">${list.nameItem}</div>
                                                            <ul class="submenuItems" style="display: none;">
                                                                <c:if test = "${list.descriptionItem != ''}">
                                                                    <li id="subItem" class="liDescricao">${list.descriptionItem}</li>
                                                                </c:if>                                                                
                                                                <!-- tag <li class="liDescricao"></li>-->
                                                                <c:if test = "${list.dateItem != null}">
                                                                    <li class="liDescricao" style="text-align: right">${list.dateItem}</li>
                                                                </c:if>                                                                
                                                            </ul>
                                                    </li>                                            
                                                </c:when>
                                                <c:otherwise>
                                                    <li id="${list.identifierItem}" class="open">
                                                        <button id="${list.seqItem}" value="${list.identifierItem}" class="opcoesItem btOption" data-toggle="modal" data-target="#btaoOpcaoModal"><i class="fa fa-ellipsis-v"></i></button>
                                                        <div class="dropdownlink">${list.nameItem}</div>
                                                            <ul class="submenuItems" style="display: none;">
                                                                <c:if test = "${list.descriptionItem != ''}">
                                                                    <li id="subItem" class="liDescricao">${list.descriptionItem}</li>
                                                                </c:if>                                                                
                                                                <!-- tag <li class="liDescricao"></li>-->
                                                                <c:if test = "${list.dateItem != null}">
                                                                    <li class="liDescricao" style="text-align: right">${list.dateItem}</li>
                                                                </c:if> 
                                                            </ul>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach> 
                                    

                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal de Inserir Tags no menu-->
        <div class="modal fade" id="tagsMenu" role="dialog">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Adicionar Tags:</h4>
              </div>
              <div class="modal-body">
                <div class="form-group">
                      <label>Nome: </label>
                          <div class="input-group">
                              <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                              <input type="text" class="form-control">
                          </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" >Cancelar</button>
                  <button type="button" class="btn btn-primary">OK</button>
                </div>
                </div>
              </div>
            </div>

          </div>

          <!-- Modal de logout-->
          <div class="modal fade" id="logoutModal" role="dialog">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Logout:</h4>
                </div>
                <div class="modal-body">
                  <p>AtÃ© logo! Deseja sair da sua conta? </p>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" >Cancelar</button>
                    <button type="button" class="btn btn-primary">Sair</button>
                  </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Modal de botão de opção de item -->
            <div class="modal fade" id="btaoOpcaoModal" role="dialog">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Opções de Item</h4>
                  </div>
                  <div class="modal-body">
                    <form id="updateItem" method="post">
                        <input type="hidden" id="takeIdU" name="takeIdU">
                        <input type="hidden" id="takeTypeU" name="takeTypeU">
                        <a class="opItemModal edit">
                          <span class="fa fa-edit"></span> Editar</span>
                        </a>
                    </form>
                    <hr>
                    <form id="deleteItem" method="post">
                        <input type="hidden" id="takeId" name="takeId">
                        <a href="#" class="opItemModal delItem">                        
                          <span class="fa fa-trash-o"></span> Excluir</span>
                        </a>
                    </form>
                    </div>
                  </div>
                </div>
              </div>

        <!-- Importação dos Scripts -->
        <script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/plugins/bootstrap/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/plugins.js"></script>
        <script type="text/javascript" src="js/actions.js"></script>
        <script type="text/javascript" src="js/script.js"></script>
        <script type="text/javascript" src="js/tagMenu.js"></script>
        <script type="text/javascript" src="js/configuracoes.js"></script>
        <script type="text/javascript" src="js/modalOptions.js"></script>

    </body>
</html>
