<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.*" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    List<Product> listProduct = (List<Product>) request.getAttribute("listProductByCategory");
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart == null){
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
%>
<html>
    <head>
        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/index.css">
    </head>
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
        <nav class="nav navbar-default navbar-fixed-top nav-main">
            <div class="container">
                <div class="row">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/"><img src="image/iconHome.png" title="Trang chủ" width="200"></a>
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
                                <ul class="dropdown-menu  space-dropdown">
                                    <%
                                        if(cart != null){
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
            <img src="image/slogan.png" title="slogan">
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



        <!-- Slide -->
        <div class="mySlide container">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                    <li data-target="#myCarousel" data-slide-to="4"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img src="image/slide1.jpg" alt="Slide 1" width="1300" height="700">
                    </div>
                    <div class="item">
                        <img src="image/slide2.jpg" alt="Slide 2" width="1300" height="700">
                    </div>

                    <div class="item">
                        <img src="image/slide3.jpg" alt="Slide 3" width="1300" height="700">
                    </div>
                    <div class="item">
                        <img src="image/slide4.jpg" alt="Slide 4" width="1300" height="700">
                    </div>
                    <div class="item">
                        <img src="image/slide5.jpg" alt="Slide 5" width="1300" height="700">
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>


        <div class="container adVer">
            <div class="row">
                <a href="/product/category/11"><img class="img-thumbnail" src="image/image-introduce/top100.jpg"></a>
                <a href="/product?categoryId=9"><img class="img-thumbnail" src="image/image-introduce/10.jpg"></a>
                <a href="/product?categoryId=9"><img class="img-thumbnail" src="image/image-introduce/10.1.jpg"></a>
            </div>
        </div>

        <!-- Sách nên đọc -->
        <div class="container bg-grey book-index1">
            <div class="row">
                <b class="text-list-main">Book store khuyên đọc</b>
                <a class="more-text-r" href="/product/category/8"><b>Xem thêm</b></a>
                <hr>
                <div class="col-sm-4">
                    <div class="list-book-main">
                        <a href="/product?id=1513705050397"><img class="img-thumbnail" src="image/index-list-1/1.jpg" width="350" height="415"></a>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513705050397">
                                <img class="img-thumbnail" src="image/index-list-1/2.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513705050397" title="Tủ Sách Gõ Cửa Tương Lai - Du Học Đông Nam Á - Đi Gần Để Học Xa - Tặng Kèm Sổ Nhật Ký Thần Tượng">Tủ Sách Gõ Cửa Tương Lai - Du Họ...</a>
                            <div class="bg-price">60.000 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704991406">
                                <img class="img-thumbnail" src="image/index-list-1/3.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704991406" title="Mặc Đẹp Để Thành Công">Mặc Đẹp Để Thành Công</a>
                            <div class="bg-price">77.000 đ</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704951041">
                                <img class="img-thumbnail" src="image/index-list-1/4.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704951041" title="Harry Potter Hộp (Trọn Bộ 7 Cuốn)">Harry Potter Hộp (Trọn Bộ 7 Cuốn)</a>
                            <div class="bg-price">1.240.000 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704902125">
                                <img class="img-thumbnail" src="image/index-list-1/5.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704902125" title="Thích Là Nhích">Thích Là Nhích</a>
                            <div class="bg-price">86.400 đ</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sách giới thiệu -->
        <div class="container bg-grey book-index1">
            <div class="row book-index1-padding">
                <b class="text-list-main">Book store giới thiệu</b>
                <a class="more-text-r" href="/product?categoryId=10"><b>Xem thêm</b></a>
                <hr>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704270257">
                                <img class="img-thumbnail" src="image/index-list-2/5.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704270257" title="Tuổi Trẻ Đáng Giá Bao Nhiêu">Tuổi Trẻ Đáng Giá Bao Nhiêu</a>
                            <div class="bg-price">53.200 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704815252">
                                <img class="img-thumbnail" src="image/index-list-2/4.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704815252" title="Mặc Kệ Thiên Hạ - Sống Như Người Nhật">Mặc Kệ Thiên Hạ - Sống Như Người Nhật</a>
                            <div class="bg-price">59.290 đ</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704758848">
                                <img class="img-thumbnail" src="image/index-list-2/3.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704758848" title="Cô Dâu Pháp Sư - Tập 3">Cô Dâu Pháp Sư - Tập 3</a>
                            <div class="bg-price">26.600 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704715747">
                                <img class="img-thumbnail" src="image/index-list-2/2.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704715747" title="Cô Dâu Pháp Sư - Tập 2">Cô Dâu Pháp Sư - Tập 2</a>
                            <div class="bg-price">26.600 đ</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-book-main">
                        <a href="#"><img class="img-thumbnail" src="image/index-list-2/1.jpg" width="350" height="415"></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container bg-grey book-index1">
            <div class="row book-index1-padding">
                <b class="text-list-main">Sách nổi bật</b>
                <a class="more-text-r" href="/product?categoryId=11"><b>Xem thêm</b></a>
                <hr>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704538321">
                                <img class="img-thumbnail" src="image/index-list-3/1.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704538321" title="Chạm Tới Giấc Mơ (Bìa Cứng) - Tặng Kèm Poster A1 (Có Chữ Ký Của Sơn Tùng) + Bookmark">Chạm Tới Giấc Mơ (Bìa Cứng) - Tặng Kèm Pos...</a>
                            <div class="bg-price">101.200 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704476597">
                                <img class="img-thumbnail" src="image/index-list-3/1.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704476597" title="Chạm Tới Giấc Mơ (Bìa Mềm) - Tặng Kèm Poster A2 (Có Chữ Ký Của Sơn Tùng)">Chạm Tới Giấc Mơ (Bìa Mềm) - Tặng Kèm Pos...</a>
                            <div class="bg-price">59.290 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704815252">
                                <img class="img-thumbnail" src="image/index-list-3/6.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704815252" title="Mặc Kệ Thiên Hạ - Sống Như Người Nhật">Mặc Kệ Thiên Hạ - Sống Như Người Nhật</a>
                            <div class="bg-price">59.250 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704423667">
                                <img class="img-thumbnail" src="image/index-list-3/7.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704423667" title="Khéo Ăn Nói Sẽ Có Được Thiên Hạ">Khéo Ăn Nói Sẽ Có Được Thiên Hạ</a>
                            <div class="bg-price">75.240 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704377879">
                                <img class="img-thumbnail" src="image/index-list-3/12.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704377879" title="Đắc Nhân Tâm (Khổ Lớn) (Tái Bản 2016)">Đắc Nhân Tâm (Khổ Lớn) (Tái Bản 2016)</a>
                            <div class="bg-price">46.360 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704323184">
                                <img class="img-thumbnail" src="image/index-list-3/13.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704323184" title="Tony Buổi Sáng - Trên Đường Băng">Tony Buổi Sáng - Trên Đường Băng</a>
                            <div class="bg-price">60.000 đ</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704270257">
                                <img class="img-thumbnail" src="image/index-list-3/2.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704270257" title="Tuổi Trẻ Đáng Giá Bao Nhiêu">Tuổi Trẻ Đáng Giá Bao Nhiêu</a>
                            <div class="bg-price">53.200 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="#">
                                <img class="img-thumbnail" src="image/index-list-3/3.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="#" title="Wanna One Fanbook - Tặng Kèm Mega Poster Khổ A1">Wanna One Fanbook - Tặng Kèm Mega Poster Khổ A1</a>
                            <div class="bg-price">63.750 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704661531">
                                <img class="img-thumbnail" src="image/index-list-3/8.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704661531" title="Cô Dâu Pháp Sư - Tập 1">Cô Dâu Pháp Sư - Tập 1</a>
                            <div class="bg-price">26.600 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704606854">
                                <img class="img-thumbnail" src="image/index-list-3/9.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704606854" title="Cô Dâu Pháp Sư - Tập 4 - Tặng Kèm Bọc Sách PVC (Số Lượng Có Hạn)">Cô Dâu Pháp Sư - Tập 4 - Tặng K...</a>
                            <div class="bg-price">31.500 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704160623">
                                <img class="img-thumbnail" src="image/index-list-3/14.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704160623" title="Đọc Vị Bất Kỳ Ai Để Không Bị Lừa Dối Và Lợi Dụng">Đọc Vị Bất Kỳ Ai Để Không Bị Lừa Dố...</a>
                            <div class="bg-price">46.800 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704099910">
                                <img class="img-thumbnail" src="image/index-list-3/15.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704099910" title="Lối Sống Tối Giản Của Người Nhật">Lối Sống Tối Giản Của Người Nhật</a>
                            <div class="bg-price">68.850 đ</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513704041570">
                                <img class="img-thumbnail" src="image/index-list-3/4.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513704041570" title="Khi Hơi Thở Hóa Thinh Không">Khi Hơi Thở Hóa Thinh Không</a>
                            <div class="bg-price">76.300 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513703985801">
                                <img class="img-thumbnail" src="image/index-list-3/5.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513703985801" title="Hỏi Xoắn Đáp Cong - Luôn Luôn Lắng Nghe, Hên Xui Sẽ Hiểu - Tặng Kèm Huy Hiệu + Bookmark (Số Lượng Có Hạn)">Hỏi Xoắn Đáp Cong - Luôn Luôn Lắng Ng...</a>
                            <div class="bg-price">57.760 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513703934714">
                                <img class="img-thumbnail" src="image/index-list-3/10.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513703934714" title="Nhân Tố Enzyme - Phương Thức Sống Lành Mạnh">Nhân Tố Enzyme - Phương Thức Sống Lành Mạnh</a>
                            <div class="bg-price">56.580 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513703867516">
                                <img class="img-thumbnail" src="image/index-list-3/11.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513703867516" title="Mình Là Cá, Việc Của Mình Là Bơi">Mình Là Cá, Việc Của Mình Là Bơi</a>
                            <div class="bg-price">68.530 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513703806374">
                                <img class="img-thumbnail" src="image/index-list-3/16.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513703806374" title="Hài Hước Một Chút Thế Giới Sẽ Khác Đi">Hài Hước Một Chút Thế Giới Sẽ Khác Đi</a>
                            <div class="bg-price">45.600 đ</div>
                        </div>
                    </div>
                    <div class="list-group">
                        <div class="sub-list-group">
                            <a href="/product?id=1513703733954">
                                <img class="img-thumbnail" src="image/index-list-3/17.jpg" width="150" height="202">
                            </a>
                        </div>
                        <div class="sub-list-group"><br>
                            <a href="/product?id=1513703733954" title="Chiến Thắng Con Quỷ Trong Bạn">Chiến Thắng Con Quỷ Trong Bạn</a>
                            <div class="bg-price">62.320 đ</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container logo-nxb">
            <div class="row">
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/1.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/2.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/3.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/4.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/5.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/6.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/7.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/8.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/9.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/10.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/11.jpg" width="175" height="175"></a>
                <a href="#"><img class="img-thumbnail" src="image/logo-nxb/12.jpg" width="175" height="175"></a>
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
