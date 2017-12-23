<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.ShoppingCart" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.CartItem" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="entity.Customer" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ShoppingCart shoppingCart = (ShoppingCart) request.getAttribute("shoppingCart");
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart == null){
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
    UserService userService =(UserService) request.getAttribute("userService");
    User user = (User) request.getAttribute("user");
    String thisUrl = request.getRequestURI();
%>
<html>
    <head>
        <title>Thanh toán</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/bootstrap.min.css"/>
        <script src="../js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="../js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/index.css">
        <link href="../css/pay.css" rel="stylesheet" type="text/css"/>
    </head>
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <nav class="nav navbar-default navbar-fixed-top nav-main">
            <div class="container">
                <div class="row">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/"><img src="../image/iconHome.png" title="Home" width="200"></a>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản của bạn
                                    <span class="caret"></span></a>

                                <ul class="dropdown-menu space-dropdown">

                                </ul>

                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Giỏ hàng
                                    <span class="text-danger"><%=cart.countItem()%></span>
                                    <span class="caret"></span></a>
                                <ul class="dropdown-menu  space-dropdown">
                                    <%
                                        if(cart !=null){
                                            for(Map.Entry<Long, CartItem> entry : cart.getListItem().entrySet()){
                                                long key = entry.getKey();
                                                CartItem value = entry.getValue();


                                    %>
                                    <li><a href="#" onclick="removeProductToCart(<%=value.getProduct().getBookId()%>)">xóa sản phẩm này</a></li>
                                    <li>
                                        <div style="float: left; width: 30%; height: 100px;">
                                            <img class="img-thumbnail" src="<%=value.getProduct().getBookImage()%>" width="70" height="122">
                                        </div>
                                        <div style="float: right; width: 65%; height: 100px;">
                                            --- <%=value.getProduct().getBookName()%><br>
                                            --- Số lượng: <%=value.getQuantity()%><br>
                                            --- Giá bán: <%=value.getTotalPrice()%> đ
                                        </div>
                                    </li>
                                    <li>*****************************************</li>
                                    <%
                                        }
                                    %>
                                    <li><b>Tổng: <%=cart.totalCart()%> đ</b></li>
                                    <li><a href="/shoppingCart/list" class="btn btn-success">Chi tiết giỏ hàng</a></li>
                                    <%
                                    }else{
                                    %>
                                    <li>Giỏ hàng rỗng</li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container slogan">
            <img src="../image/slogan.png" title="slogan">
        </div>
        <nav class="nav navbar-default nav2">
            <div class="container">
                <div class="navbar-header dropdown">
                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">DANH MỤC SÁCH  <span class="glyphicon glyphicon-th-list"></span></button>
                    <ul class="dropdown-menu">
                        <%
                            for(Category c: Category.getListCategory()){
                        %>
                        <li><a title="<%=c.getName()%>" href="/product/category/<%=c.getId()%>"><%=c.getName()%></a></li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                <div class="navbar-right">
                    <form class="form-inline" action="/product" method="get">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" size="50" placeholder="Gõ tên cuốn sách bạn muốn tìm" required>
                            <div class="input-group-btn">
                                <button class="btn btn-danger">Tìm kiếm sách</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </nav>


        <!-- Pay -->
        <h2 class="text-center">Thanh toán sản phẩm bạn đã đặt</h2>
        <div class="container">
            <table id="cart" class="table table-hover table-condensed">
                <thead>
                    <tr>
                        <th style="width:50%">Tên sản phẩm</th>
                        <th style="width:10%">Giá</th>
                        <th style="width:8%">Số lượng</th>
                        <th style="width:22%" class="text-center">Thành tiền</th>
                        <th style="width:10%"> </th>
                    </tr>
                </thead>
                <%
                    if(shoppingCart != null){
                        for(Map.Entry<Long, CartItem> entry : shoppingCart.getListItem().entrySet()){
                            long key = entry.getKey();
                            CartItem value = entry.getValue();
                %>
                <tbody>
                <tr>
                        <td data-th="Product">
                            <div class="row">
                                <div class="col-sm-2 hidden-xs"><img src="<%=value.getProduct().getBookImage()%>" alt="<%=value.getProduct().getBookTitle()%>" class="img-responsive" width="100">
                                </div>
                                <div class="col-sm-10">
                                    <h4 class="nomargin"><%=value.getProduct().getBookName()%></h4>
                                    <p><b>Tác giả: </b><%=value.getProduct().getBookAuthor()%></p>
                                </div>
                            </div>
                        </td>
                        <td data-th="Price"><%=value.getProduct().getUnitPrice()%> đ</td>
                        <td data-th="Quantity"><input class="form-control text-center" value=<%=value.getQuantity()%> type="number">
                        </td>
                        <td data-th="Subtotal" class="text-center"><%=value.getTotalPrice()%> đ</td>
                        <td class="actions" data-th="">
                            <button class="btn btn-info btn-sm"><i class="fa fa-edit"></i>
                            </button>
                            <button class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i>
                            </button>
                            <br>
                            <a href="#" onclick="removeProductToCart(<%=value.getProduct().getBookId()%>)">xóa sản phẩm</a>
                        </td>
                    </tr>

                </tbody>
                    <%
                        }
                    %>
                <tfoot>
                    <tr class="visible-xs">
                        <td class="text-center"><strong>Tổng 200.000 đ</strong>
                        </td>
                    </tr>
                    <tr>
                        <td><a href="/" class="btn btn-warning"><i class="fa fa-angle-left"></i> Tiếp tục mua hàng</a>
                        </td>
                        <td colspan="2" class="hidden-xs"> </td>
                        <td class="hidden-xs text-center"><strong>Tổng tiền <%=shoppingCart.totalCart()%> đ</strong>
                        </td>
                        <td><a href="#" class="btn btn-success btn-block">Thanh toán <i class="fa fa-angle-right"></i></a>
                        </td>
                    </tr>
                </tfoot>
                <%
                    }
                %>
            </table>
        </div>

        <footer class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="text-footer">
                            <b>About us</b>
                            <p>Với mục tiêu tạo ra những trải nghiệm mua sắm trực tuyến tuyệt vời,
                                Book store luôn nỗ lực không ngừng nhằm nâng cao chất lượng dịch vụ.
                                Khi mua hàng qua mạng tại Book store...</p>
                        </div>
                    </div>
                    <div class="col-sm-4 footer-dot">
                        <div class="text-footer">
                            <b>Member team</b>
                            <ul>
                                <li>Nguyễn Bá Danh</li>
                                <li>Nguyễn Việt Hùng</li>
                                <li>Nguyễn Mạnh Tùng</li>
                                <li>Đỗ Việt Dũng</li>
                                <li>Bạch Ngọc Huy</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="text-footer">
                            <b>Contact</b>
                            <p>Tòa nhà Detech - Số 8 - Tôn Thất Thuyết - Phường Mỹ Đình 2 - Quận Nam Từ Liêm - Hà Nội</p>
                            <p>Nhóm 4 - Lớp C1702G</p>
                        </div>
                        <a href="#myPage" title="Lên đầu trang">
                            <span class="glyphicon glyphicon-chevron-up"></span>
                        </a>
                    </div>
                </div>
            </div>
        </footer>

        <script>
            $(document).ready(function () {
                // Add smooth scrolling to all links in navbar + footer link
                $(".navbar a, footer a[href='#myPage']").on('click', function (event) {

                    // Prevent default anchor click behavior
                    event.preventDefault();

                    // Store hash
                    var hash = this.hash;

                    // Using jQuery's animate() method to add smooth page scroll
                    // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top
                    }, 900, function () {

                        // Add hash (#) to URL when done scrolling (default click behavior)
                        window.location.hash = hash;
                    });
                });

                // Slide in elements on scroll
                $(window).scroll(function () {
                    $(".slideanim").each(function () {
                        var pos = $(this).offset().top;

                        var winTop = $(window).scrollTop();
                        if (pos < winTop + 600) {
                            $(this).addClass("slide");
                        }
                    });
                });
            });

        </script>

        <script src="/js/shop.js" type="text/javascript"></script>

        <div class="container">
            <div class="row">
                <p class="text-center">
                    Copyright © 2017 - FPT Aptech - C1702G - Group 4
                </p>
            </div>
        </div>

    </body>
</html>
