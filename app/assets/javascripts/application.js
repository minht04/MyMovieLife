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

/* global $*/
$(document).ready(function () {
  $("#theTarget").skippr({
    // スライドショーの変化
    transition : 'slide',
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    // ナビゲーションの矢印の表示
    arrows : true,
    autoplay : true,
    autoPlayDuration : 3000,
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか
    hidePrevious : false
  });
});