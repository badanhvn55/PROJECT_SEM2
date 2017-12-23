
<%@ page import="entity.Product" %>
<%@ page import="entity.ShoppingCart" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.CartItem" %>
<%@ page import="java.util.Random" %>
<%@ page import="entity.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart == null){
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
%>
<html>
    <head>
        <title>Register</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/index.css">
        <link href="css/register.css" rel="stylesheet" type="text/css"/>
    </head> 
    <body  id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <nav class="nav navbar-default navbar-fixed-top nav-main">
            <div class="container">
                <div class="row">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="index.html"><img src="image/iconHome.png" title="Home" width="200"></a>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" id="myN" class="dropdown-toggle" data-toggle="dropdown">Tài khoản của bạn
                                    <span class="caret"></span></a>
                                <ul class="dropdown-menu space-dropdown">
                                    <li>

                                    </li>
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
                                    <li><b>Tổng: <%=cart.totalCart()%></b></li>
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
            <img src="image/slogan.png" title="slogan">
        </div>
        <nav class="nav navbar-default nav2">
            <div class="container">
                <div class="navbar-header dropdown">
                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">DANH MỤC SÁCH  <span class="glyphicon glyphicon-th-list"></span></button>
                        <ul class="dropdown-menu">
                        <li><a href="sachgiamgia.html">Kho sách giảm giá</a></li>
                        <li><a href="sachbanchay.html">Sách bán chạy</a></li>
                        <li><a href="sachmoiphathanh.html">Sách mới phát hành</a></li>
                        <li><a href="sachsapphathanh.html">Sách sắp phát hành</a></li>
                        <li><a href="sachgiaokhoa.html">Sách giáo khoa</a></li>
                        <li><a href="sachvanhoc.html">Sách văn học</a></li>
                        <li><a href="sachthieunhi.html">Sách thiếu nhi</a></li>
                        <li><a href="sachchuyennganh.html">Sách chuyên ngành</a></li>
                        <li><a href="sachngoaingu.html">Sách ngoại ngữ</a></li>
                    </ul>
                </div>
                <div class="navbar-right">
                    <form class="form-inline">
                        <div class="input-group">
                            <input type="email" class="form-control" size="50" placeholder="Gõ tên cuốn sách bạn muốn tìm" required>
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-danger">Tìm kiếm sách</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <!-- form đăng ký -->
        <div class="container">
            <div class="row">
                <form class="form-horizontal form-main" action="" method="post">
                    <fieldset>
                        <legend>Thông tin bổ sung</legend>
                        <div class="form-group">
                            <label class="control-label col-sm-2">Tên của bạn</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên của bạn">
                            </div>
                            <span id="nameMessage"></span>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2">Địa chỉ</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="address" name="address" placeholder="Nhập tên địa chỉ nơi bạn đang ở">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2">Số điện thoại</label>
                            <div class="col-sm-5">
                                <input type="number" class="form-control" id="phoneNumber" name="phone">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-5">
                                <input type="submit" class="btn btn-primary" value="Đăng ký">
                                <input type="reset" class="btn btn-default" value="Nhập lại">
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
        <script type="text/javascript">
            var username = document.getElementById('name');
            username.onkeyup = function () {
                var usernameMessage = document.getElementById('nameMessage');
                if (username.value.length < 7) {
                    usernameMessage.innerHTML = "Tên bạn quá ngắn";
                    usernameMessage.style.color = "red";
                } else {
                    usernameMessage.innerHTML = "Ok";
                    usernameMessage.style.color = "green";
                }
            };

        </script>
    
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

        <div class="container">
            <div class="row">
                <p class="text-center">
                    Copyright © 2017 - FPT Aptech - C1702G - Group 4
                </p>
            </div>
        </div>

    </body>
</html>
