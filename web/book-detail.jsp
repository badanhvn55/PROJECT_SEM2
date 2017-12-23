<%@ page import="entity.Product" %>
<%@ page import="entity.ShoppingCart" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.CartItem" %>
<%@ page import="java.util.Random" %>
<%@ page import="entity.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Product product = (Product) request.getAttribute("productById");
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart == null){
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }

    Random randomGenerator = new Random();
    int random = randomGenerator.nextInt(10000);
%>
<html>
    <head>
        <title><%=product.getBookName()%></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/css/bootstrap.min.css"/>
        <script src="/js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="/js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="/css/index.css">
        <link href="/css/bookdetail.css" rel="stylesheet" type="text/css"/>
        <script src="/js/bookdetail.js" type="text/javascript"></script>


    </head> 
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <nav class="nav navbar-default navbar-fixed-top nav-main">
            <div class="container">
                <div class="row">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/"><img src="/image/iconHome.png" title="Trang chủ" width="200"></a>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản của bạn
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
                        <li><a title="<%=c.getName()%>" href="/product/<%=c.getId()%>"><%=c.getName()%></a></li>
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



        <%
            if(product != null){
        %>
        <div class="container menu-item">
            <ul class="breadcrumb">
                <li><a href="/">Trang chủ</a></li>
                <li><a href="#"><span><%=product.getCategoryId()%></span></a></li>
                <li><a href="#" style="color: #337ab7"><span><%=product.getBookName()%></span></a></li>
            </ul>
        </div>

        <div class="container-fluid">
            <div class="content-wrapper">	
                <div class="item-container">	
                    <div class="container">	
                        <div class="col-md-12">
                            <div class="product col-md-5 service-image-left">
                                <center>
                                    <img id="item-display" src="<%=product.getBookImage()%>" alt=""></img>
                                </center>
                            </div>

                            <div class="col-md-7">
                                <div class="product-title"><%=product.getBookTitle()%></div>
                                <h5 style="color:#337ab7"><%=product.getBookPublisher()%> · <small style="color:#337ab7">(<%=random%> lượt mua)</small></h5>
                                <div class="product-desc">When you want something, all the universe conspires in helping you to achieve it. (Khi bạn thực sự mong muốn một điều gì, cả vũ trụ hợp lại giúp bạn đạt được nó.)</div>
                                <div class="product-rating"><i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star-o"></i> </div>
                                <hr>
                                <div class="product-price"><%=product.getUnitPrice()%> <u>đ</u></div>
                                <div class="product-stock">Còn hàng</div>
                                <hr>
                                <div class="section" style="padding-bottom:20px;">
                                    <h6 class="title-attr"><small>Số lượng</small></h6>                    
                                    <div>
                                        <div class="btn-minus"><span class="glyphicon glyphicon-minus"></span></div>
                                        <input type="number" value="1" min="1" max="12" disabled/>
                                        <div class="btn-plus"><span class="glyphicon glyphicon-plus"></span></div>
                                    </div>
                                </div>     
                                <div class="btn-group cart">
                                    <a onclick="buyProductToCart(<%=product.getBookId()%>)" href="/shoppingCart/list" type="button" class="btn btn-success">
                                        Mua ngay 
                                    </a>
                                </div>
                                <div class="btn-group wishlist">
                                    <a href="#" onclick="addProductToCart(<%=product.getBookId()%>)" type="button" class="btn btn-danger">
                                        Thêm vào giỏ hàng 
                                    </a>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <div class="container-fluid">		
                    <div class="col-md-12 product-info">
                        <ul id="myTab" class="nav nav-tabs nav_tabs">

                            <li class="active"><a href="#service-one" data-toggle="tab">Nội Dung</a></li>
                            <li><a href="#service-two" data-toggle="tab">Thông tin nhà xuất bản</a></li>
                            <li><a href="#service-three" data-toggle="tab">Tác phẩm liên quan</a></li>

                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade in active" id="service-one">

                                <section class="container product-info">
                                    <li><%=product.getBookDescription()%></li>
                                </section>

                            </div>
                            <div class="tab-pane fade" id="service-two">

                                <section class="container product-info">

                                    <li>Tác già: <%=product.getBookAuthor()%></li>
                                    <li>Nhà xuất bản: <%=product.getBookPublisher()%></li>
                                </section>

                            </div>
                            <div class="tab-pane fade" id="service-three">
                                <section class="container product-info">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-3 col-sm-6">
                                                <span class="thumbnail">
                                                    <img class="img-lienquan" src="/image/biasachvanhoc/chamtoigiacmo.jpg" alt=""/>
                                                    <h4>Chạm tới giấc mơ</h4>
                                                    <hr class="line">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <p class="price">150.000<u>đ</u></p>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <a href="" target="_blank" >	<button class="btn btn-infor right" >Mua ngay</button></a>
                                                            <a href="" target="_blank" >	<button class="btn btn-giohang right" >Giỏ hàng</button></a>
                                                        </div>
                                                    </div>
                                                </span>
                                            </div>
                                            <div class="col-md-3 col-sm-6">
                                                <span class="thumbnail">
                                                    <img class="img-lienquan" src="/image/biasachvanhoc/khihoithohoathingkhong.jpg" alt=""/>
                                                    <h4>Hơi thở hoá thinh không</h4>
                                                    <hr class="line">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <p class="price">199.000<u>đ</u></p>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <a href="" target="_blank" >	<button class="btn btn-infor right" >Mua ngay</button></a>
                                                            <a href="" target="_blank" >	<button class="btn btn-giohang right" >Giỏ hàng</button></a>
                                                        </div>
                                                    </div>
                                                </span>
                                            </div>
                                            <div class="col-md-3 col-sm-6">
                                                <span class="thumbnail">
                                                    <img class="img-lienquan" src="/image/biasachvanhoc/gietconchimnhai.jpg" alt=""/>
                                                    <h4>Giết con chim nhại</h4>
                                                    <hr class="line">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <p class="price">170.000<u>đ</u></p>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <a href="" target="_blank" >	<button class="btn btn-infor right" >Mua ngay</button></a>
                                                            <a href="" target="_blank" >	<button class="btn btn-giohang right" >Giỏ hàng</button></a>
                                                        </div>
                                                    </div>
                                                </span>
                                            </div>
                                            <div class="col-md-3 col-sm-6">
                                                <span class="thumbnail">
                                                    <img class="img-lienquan" src="/image/biasachvanhoc/thatitnhkhongsao.jpg" alt=""/>
                                                    <h4>Thất tình không sao</h4>
                                                    <hr class="line">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <p class="price">139.000<u>đ</u></p>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <a href="" target="_blank" >	<button class="btn btn-infor right" >Mua ngay</button></a>
                                                            <a href="" target="_blank" >	<button class="btn btn-giohang right" >Giỏ hàng</button></a>
                                                        </div>
                                                    </div>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
        </div>


                <div class="fb-comments" data-href="/product/category/<%=product.getCategoryId()%>/<%=product.getBookId()%>" data-width="750" data-numposts="5"></div>

        <%
            }
        %>


        <div class="container logo-nxb">
            <div class="row">
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/1.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/2.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/3.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/4.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/5.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/6.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/7.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/8.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/9.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/10.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/11.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="/image/logo-nxb/12.jpg" width="175" height="175"></a>
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


            function buyProductToCart(bookId) {
                $.ajax({
                    url: "/shoppingCart?command=plus&productId=" + bookId,
                    type: "GET",
                    success: function (resp) {
                        return;
                    },
                    error: function (resp) {
                        console.log(resp);
                    }
                });
                location.reload();
            }

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
