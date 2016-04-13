# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# this callback function will run if anything other than a 2xx status code is returned to our ajax request
cart_submit_error = (data, status, jqXHR) ->
	alert('Things be broke, yo')

# this callback function is run if the ajax request is successful
cart_submit_callback = (data, status, jqXHR) ->
	# assigns the variable 'the_form' the the current object
	the_form = this
	# takes the form element and gives it to jquery so that we can call jquery methods on it
	$the_form = $(the_form)
	# calling a method called find, on a css selector [name=commit], which looks for a dom element which has a property called name, of which the value is commit. this returns the jquery object
	$the_button = $the_form.find('[name=commit]')
	# the jquery method .val is called on the button, which gets the value of the button. the text in the button is the value we're passed back from the ajax request.
	$the_button.val(data.button_label)
	# 
	the_form.action = data.cart_action
	alert("#{data.movie_name} #{data.movie_cart_status}")

handle_cart_submit = (e) ->
	# prevents the default action, in this case prevents the page from reloading
	e.preventDefault()
	# assigns our object to a variable name called 'the_form'
	the_form = this
	# the action of the form is the place the form data will be sent to
	url = the_form.action
	#  method is the post/put/get etc, type is the variable we're calling that method
	type = the_form.method
	# serialze turns data into a particular format, in this context we are turning the contents of the form into a string format which jquery uses. this is assigned to a variable called 'data'
	data = $(the_form).serialize()
	# a set of key/value pairs which configure the ajax request, all of the settings are optional. 
	$.ajax {
		# 
		url: url,
		# type is the particular http method we're using
		type: type,
		# data is what we're sending to the server
		data: data,
		# this is the function we run if the request is successful
		success: cart_submit_callback.bind(the_form),
		# this is the error which is returned if the request fails
		error: cart_submit_error.bind(the_form),
		# telling the server the format in which we want the response to be passed back to us
		headers: { Accept: "application/json; charset=utf-8" }
	}

#  using jquery to run the anonymous function when the document has loaded
$ ->
	form_cart_button = $('form.cart-button')
	#  when the form is submitted, the handle_cart_submit callback function is then called
	form_cart_button.on "submit", handle_cart_submit
