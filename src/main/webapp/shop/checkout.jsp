<%@ page import="com.example.online_electronics_store.model.User" %>
<%@ page import="com.example.online_electronics_store.model.Cart" %>
<%@ page import="com.example.online_electronics_store.dao.impl.CartDAO" %>
<%@ page import="com.example.online_electronics_store.dao.impl.CartDetailsDAO" %>
<%@ page import="com.example.online_electronics_store.model.CartDetails" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Norda - Minimal eCommerce HTML Template</title>
    <meta name="robots" content="noindex, follow"/>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png">

    <!-- All CSS is here
	============================================ -->

    <link rel="stylesheet" href="assets/css/vendor/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/vendor/signericafat.css">
    <link rel="stylesheet" href="assets/css/vendor/cerebrisans.css">
    <link rel="stylesheet" href="assets/css/vendor/simple-line-icons.css">
    <link rel="stylesheet" href="assets/css/vendor/elegant.css">
    <link rel="stylesheet" href="assets/css/vendor/linear-icon.css">
    <link rel="stylesheet" href="assets/css/plugins/nice-select.css">
    <link rel="stylesheet" href="assets/css/plugins/easyzoom.css">
    <link rel="stylesheet" href="assets/css/plugins/slick.css">
    <link rel="stylesheet" href="assets/css/plugins/animate.css">
    <link rel="stylesheet" href="assets/css/plugins/magnific-popup.css">
    <link rel="stylesheet" href="assets/css/plugins/jquery-ui.css">
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body>

<div class="main-wrapper">
    <header class="header-area">
        <div class="container">
            <div class="header-large-device">
                <div class="header-top header-top-ptb-1 border-bottom-1">
                    <div class="row">
                        <div class="col-xl-4 col-lg-5">
                            <div class="header-offer-wrap">
                                <p><i class="icon-paper-plane"></i> FREE SHIPPING world wide for all orders over <span>$199</span></p>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-7 d-flex justify-content-end">
                            <%
                                Object userObj = session.getAttribute("user");
                                User user = (User) userObj;
                                if (user != null) { %>
                            <p style="color: red; margin: auto; display: inline-block">
                                <%= "Welcome " + user.getUsername() + "!" %>
                            </p>
                            <% } %>
                            <div class="header-top-right d-flex align-items-center">
                                <div class="social-style-1 social-style-1-mrg ms-3 d-flex align-items-center">
                                    <a href="#"><i class="icon-social-twitter"></i></a>
                                    <a href="#"><i class="icon-social-facebook"></i></a>
                                    <a href="#"><i class="icon-social-instagram"></i></a>
                                    <a href="#"><i class="icon-social-youtube"></i></a>
                                    <a href="#"><i class="icon-social-pinterest"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="header-bottom">
                    <div class="row align-items-center">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo">
                                <a href="${pageContext.request.contextPath}/product?action=home"><img src="${pageContext.request.contextPath}/shop/assets/images/group-one-logo/group-one-logo-ver-7-edited.png" alt="logo"></a>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-7">
                            <div class="main-menu main-menu-padding-1 main-menu-lh-1">
                                <nav>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/product?action=home">HOME </a>
                                        </li>
                                        <li><a href="${pageContext.request.contextPath}/product">SHOP </a>
                                        </li>
                                        </li>
                                        <li><a href="#aboutUs">ABOUT US </a>
                                        </li>
                                        <li><a href="#contacInfo">CONTACT </a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="col-xl-2 col-lg-3">
                            <div class="header-action header-action-flex header-action-mrg-right">
                                <div class="same-style-2 header-search-1">
                                    <a class="search-toggle" href="#">
                                        <i class="icon-magnifier s-open"></i>
                                        <i class="icon_close s-close"></i>
                                    </a>
                                    <div class="search-wrap-1">
                                        <form action="${pageContext.request.contextPath}/product?action=search" method="post">
                                            <input placeholder="Search product" type="text" name="search">
                                            <button class="button-search"><i class="icon-magnifier"></i></button>
                                        </form>
                                    </div>
                                </div>
                                <div class="same-style-2">
                                    <% if (user == null) { %>
                                    <a href="${pageContext.request.contextPath}/user"><i class="icon-user"></i></a>
                                    <% } else if (user.getRole().equals("user")) { %>
                                    <a href="${pageContext.request.contextPath}/user?action=account"><i class="icon-user"></i></a>
                                    <% } else if (user.getRole().equals("admin")) { %>
                                    <a href="${pageContext.request.contextPath}/user?action=admin"><i class="icon-user"></i></a>
                                    <% } %>
                                </div>
                                <div class="same-style-2 header-cart">
                                    <% if (user != null) { %>
                                    <a href="/cart">
                                        <i class="icon-basket-loaded"></i>
                                        <%
                                            Cart cart = CartDAO.getInstance().findByUser(user);
                                            List<CartDetails> cartDetailsList = CartDetailsDAO.getInstance().findByItemId(cart);
                                            int count = CartDetailsDAO.getInstance().getProductQuantity(cartDetailsList);
                                            if (count > 0) {
                                        %>
                                        <span class="pro-count red"><%= count%></span>
                                        <% } %>
                                    </a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="breadcrumb-area bg-gray">
        <div class="container">
            <div class="breadcrumb-content text-center">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/product?action=home">Home</a>
                    </li>
                    <li class="active">Checkout</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="checkout-main-area pt-120 pb-120">
        <div class="container">
            <div class="your-order-area col-lg-8 offset-2">
                <h3>Your order</h3>
                <div class="your-order-wrap gray-bg-4">
                    <div class="your-order-info-wrap">
                        <div class="your-order-info">
                            <ul>
                                <li>Product <span>Total</span></li>
                            </ul>
                        </div>
                        <div class="your-order-middle">
                            <ul>
                                <li>Product Name X 1 <span>$329 </span></li>
                            </ul>
                        </div>
                        <div class="your-order-info order-subtotal">
                            <ul>
                                <li>Subtotal <span>$329 </span></li>
                            </ul>
                        </div>
                        <div class="your-order-info order-shipping">
                            <ul>
                                <li>Shipping <p>Enter your full address </p>
                                </li>
                            </ul>
                        </div>
                        <div class="your-order-info order-total">
                            <ul>
                                <li>Total <span>$273.00 </span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="Place-order">
                    <a href="#">Place Order</a>
                </div>
            </div>
        </div>
    </div>
    <div class="about-us-area pt-85">
        <div class="container">
            <div class="border-bottom-1 about-content-pb">
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <div class="about-us-logo">
                            <img src="assets/images/group-one-logo/group-one-logo-ver-7.png" alt="logo">
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-9">
                        <div class="about-us-content" id="aboutUs">
                            <h3>Introduce</h3>
                            <p>GrOne store is a business concept is to offer fashion and quality at the best price.
                                It has since it was founded in 2022 grown into one of the best WooCommerce Fashion
                                Theme. The shop was built and developed by Dien, Hung, Truong from C0822I1.</p>
                            <div class="signature">
                                <h2>Dien Hung Truong</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="subscribe-area bg-gray pt-115 pb-115">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-5">
                    <div class="section-title">
                        <h2>keep connected</h2>
                        <p>Get updates by subscribe our weekly newsletter</p>
                    </div>
                </div>
                <div class="col-lg-7 col-md-7">
                    <div id="mc_embed_signup" class="subscribe-form">
                        <form id="mc-embedded-subscribe-form" class="validate subscribe-form-style" novalidate="" target="_blank" name="mc-embedded-subscribe-form" method="post" action="https://devitems.us11.list-manage.com/subscribe/post?u=6bbb9b6f5827bd842d9640c82&amp;id=05d85f18ef">
                            <div id="mc_embed_signup_scroll" class="mc-form">
                                <input class="email" type="email" required="" placeholder="Enter your email address" name="EMAIL" value="">
                                <div class="mc-news" aria-hidden="true">
                                    <input type="text" value="" tabindex="-1" name="b_6bbb9b6f5827bd842d9640c82_05d85f18ef">
                                </div>
                                <div class="clear">
                                    <input id="mc-embedded-subscribe" class="button" type="submit" name="subscribe" value="Subscribe">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="footer-area bg-gray pb-30">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="contact-info-wrap" id="contacInfo">
                        <div class="footer-logo">
                            <a href="#"><img src="assets/images/group-one-logo/group-one-logo-ver-7-edited.png" alt="logo"></a>
                        </div>
                        <div class="single-contact-info">
                            <span>Our Location</span>
                            <p>Kent Class, Code Gym My Dinh, HD Mon City</p>
                        </div>
                        <div class="single-contact-info">
                            <span>24/7 hotline:</span>
                            <p>(+84) 966778899</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="footer-right-wrap">
                        <div class="footer-menu">
                            <nav>
                                <ul>
                                    <li><a href="#">home</a></li>
                                    <li><a href="#">Shop</a></li>
                                    <li><a href="#">Contact</a></li>
                                    <li><a href="#">Blog</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="social-style-2 social-style-2-mrg">
                            <a href="#"><i class="social_twitter"></i></a>
                            <a href="#"><i class="social_facebook"></i></a>
                            <a href="#"><i class="social_googleplus"></i></a>
                            <a href="#"><i class="social_instagram"></i></a>
                            <a href="#"><i class="social_youtube"></i></a>
                        </div>
                        <div class="copyright">
                            <p>Copyright © 2022 HasThemes | <a href="https://hasthemes.com/">Built with <span>Norda</span> by HasThemes</a>.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- All JS is here
============================================ -->

<script src="assets/js/vendor/modernizr-3.11.7.min.js"></script>
<script src="assets/js/vendor/jquery-v3.6.0.min.js"></script>
<script src="assets/js/vendor/jquery-migrate-v3.3.2.min.js"></script>
<script src="assets/js/vendor/popper.min.js"></script>
<script src="assets/js/vendor/bootstrap.min.js"></script>
<script src="assets/js/plugins/slick.js"></script>
<script src="assets/js/plugins/jquery.syotimer.min.js"></script>
<script src="assets/js/plugins/jquery.nice-select.min.js"></script>
<script src="assets/js/plugins/wow.js"></script>
<script src="assets/js/plugins/jquery-ui.js"></script>
<script src="assets/js/plugins/magnific-popup.js"></script>
<script src="assets/js/plugins/sticky-sidebar.js"></script>
<script src="assets/js/plugins/easyzoom.js"></script>
<script src="assets/js/plugins/scrollup.js"></script>
<script src="assets/js/plugins/ajax-mail.js"></script>
<!-- Main JS -->
<script src="assets/js/main.js"></script>

</body>

</html>