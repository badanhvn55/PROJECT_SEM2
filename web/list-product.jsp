<%@ page import="entity.Product" %>
<%@ page import="entity.ShoppingCart" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.CartItem" %>
<%@ page import="entity.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart == null){
        cart = new ShoppingCart();
        session.setAttribute("sessionCart", cart);
    }
%>
<html>
    <head>
        <title>Thể loại</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/bootstrap.min.css"/>
        <script src="/js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="/css/index.css">
        <link href="/css/sachgiaokhoa.css" rel="stylesheet" type="text/css"/>
    </head> 
    <body  id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <nav class="nav navbar-default navbar-fixed-top nav-main">
            <div class="container">
                <div class="row">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/"><img src="/image/iconHome.png" title="Home" width="200"></a>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản của bạn
                                    <span class="caret"></span></a>
                                <ul class="dropdown-menu space-dropdown">
                                    <li></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Giỏ hàng
                                    <span class="text-danger"><%=cart.countItem()%></span>
                                    <span class="caret"></span></a>
                                <ul class="dropdown-menu space-dropdown">
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
            <img src="/image/slogan.png" title="slogan">
        </div>
        <nav class="nav navbar-default nav2">
            <div class="container">
                <div class="navbar-header dropdown">
                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">DANH MỤC SÁCH  <span class="glyphicon glyphicon-th-list"></span></button>
                    <ul class="dropdown-menu">
                        <%
                            for(Category c: Category.getListCategory()){
                        %>
                        <li><a title="<%=c.getName()%>" href="/product?categoryId=<%=c.getId()%>"><%=c.getName()%></a></li>
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


        <div class="container menu-item">
            <ul class="breadcrumb">
                <li><a href="/">Trang chủ</a></li>
                <li><a href="#"><span>Thể loại</span></a></li>
            </ul>
        </div>
        <!-- sách giáo khoa -->
        <div class="container">
            <div class="row">
                <div class="col-sm-3 menu">
                    <div class="list-group">
                        <a href="/product?categoryId=9" class="list-group-item">Kho sách giảm giá</a>
                        <a href="/product?categoryId=10" class="list-group-item">Sách bán chạy</a>
                        <a href="/product?categoryId=11" class="list-group-item">Top 100 sách hay</a>
                        <a href="/product?categoryId=1" class="list-group-item">Sách giáo khoa</a>
                        <a href="/product?categoryId=2" class="list-group-item">Sách văn học</a>
                        <a href="/product?categoryId=3" class="list-group-item">Sách thiếu nhi</a>
                        <a href="/product?categoryId=4" class="list-group-item">Sách chuyên ngành</a>
                        <a href="/product?categoryId=5" class="list-group-item">Sách Sách ngoại ngữ</a>
                        <a href="/product?categoryId=6" class="list-group-item">Sách kinh tế</a>
                        <a href="/product?categoryId=7" class="list-group-item">Sách thường thức đời sống</a>
                        <a href="/product?categoryId=8" class="list-group-item">Sách phát triển bản thân</a>
                    </div>
                </div>
                <div id="book1" class="col-sm-9">
                    <%
                        if(listProduct !=null && listProduct.size() > 0){
                            for (Product product : listProduct){
                    %>
                    <div class="list-group list">
                        <div class="sub-list-group">
                            <a href="/product?id=<%=product.getBookId()%>">
                                <img class="img-thumbnail" src = "<%=product.getBookImage()%>" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group">
                            <a href="/product?id=<%=product.getBookId()%>"><%=product.getBookName()%></a>
                            <div class="bg-price"><%=product.getUnitPrice()%> đ</div>
                            <br>
                            <a href="#" onclick="addProductToCart(<%=product.getBookId()%>)" class="btn btn-info">Thêm vào giỏ hàng <span class="glyphicon glyphicon-shopping-cart"></span></a>
                        </div>
                    </div>
                    <%
                            }
                        }else{
                    %>
                        Hiện tại chưa có sản phẩm nào trong danh mục này.
                    <%
                        }
                    %>
                </div>
            </div>
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

        <script type="text/javascript">
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
