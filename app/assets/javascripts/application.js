// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

/* global Swiper $*/
$(document).ready(function () {
var mySwiper = new Swiper ('.swiper-container',
	{
    speed:2000,
		direction: 'horizontal',
		navigation:
		{
		  nextEl: '.swiper-button-next',
		  prevEl: '.swiper-button-prev',
		},
		pagination:
		{
			el: '.swiper-pagination',
			dynamicBullets: true,
		},
		zoom: true,
		keyboard:
		{
			enabled: true,
			onlyInViewport: false,
		},
    autoplay:
    {
      delay: 2000,
    },
    loop: true,
	});
});

// aboutスライドイン
$(function () {
  $(window).scroll(function () {
      // $(window).height();でブラウザの表示領域の高さを取得
      // $(window).scrollTop();でブラウザの表示領域をスクロールした時の位置を取得
      var wHeight = $(window).height();
      var scrollAmount = $(window).scrollTop();
      $('.scrollanime').each(function () {
          // offset().top;で要素の縦の位置を取得
          var targetPosition = $(this).offset().top;
          // スクロール位置>対象となる要素の縦位置-表示領域の高さ+60
          // +60で表示領域の真ん中あたりでアニメーションんが実行
          if(scrollAmount > targetPosition - wHeight + 60) {
              $(this).addClass("fadeInDown");
          }
      });
    });
});

// 投稿画像表示
$(document).on("turbolinks:load", function(){
  function readURL(input) {
    if(input.files && input.files[0]){
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#post_image").change(function(){
    readURL(this);
  });
});

// プロフィール画像表示
$(document).on("turbolinks:load", function(){
  function readURL(input) {
    if(input.files && input.files[0]){
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#member_profile_image").change(function(){
    readURL(this);
  });
});