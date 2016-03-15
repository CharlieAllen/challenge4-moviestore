# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

cart_submit_error = (data, status, jqXHR) ->
	alert('Things be broke, yo')

cart_submit_callback = (data, status, jqXHR) ->
	the_form = this
	$the_form = $(the_form)
	$the_button = $the_form.find('[name=commit]')
	$the_button.val(data.button_label)
	the_form.action = data.cart_action
	alert("#{data.movie_name} #{data.movie_cart_status}")

handle_cart_submit = (e) ->
	e.preventDefault()
	the_form = this
	url = the_form.action
	type = the_form.method
	data = $(the_form).serialize()
	$.ajax url: url, type: type, data: data, success: cart_submit_callback.bind(the_form), error: cart_submit_error.bind(the_form), headers: { Accept: "application/json; charset=utf-8" }


$ ->
	form_cart_button = $('form.cart-button')
	form_cart_button.on "submit", handle_cart_submit
