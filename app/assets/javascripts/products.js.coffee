# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$("li").mouseover(->
	  $(".hover-buttons", this).css "display", "block"
	).mouseout ->
	  $(".hover-buttons", this).css "display", "none"	

	$(".product-item").wookmark
	  container: $(".wookmark")
	  offset: 10
	  itemWidth: 226
	  autoResize: true	  