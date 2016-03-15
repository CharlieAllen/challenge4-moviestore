# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

handle_cart_submit = (e) ->
	e.preventDefault()
	url = this.action
	type = this.method
	data = $(this).serialize()
	$.ajax url: url, type: type, data: data, success: cart_submit_callback, error: cart_submit_error


cart_submit_error = (data) ->
	alert('Things be broke, yo')

cart_submit_callback = (data) ->
	console.log(data)
	alert("I'm back (from outer space)")

$ ->
	form_cart_button = $('form.cart-button')
	form_cart_button.on "submit", handle_cart_submit
    # $this = $(this).closest('a')
    # url = $this.data('targeturl')
    # $.ajax url: url, type: 'put', success: (data) ->
    #   $('.cart-count').html(data)
    #   $this.closest('.cart-movie').slideUp()