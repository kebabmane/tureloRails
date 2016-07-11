// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap-typeahead-rails
//= require turbolinks
//= require_tree .

$(function () {
  NProgress.configure({ showSpinner: false });


  // Remove Search if user Resets Form or hits Escape!
  		$('body, .navbar-collapse form[role="search"] button[type="reset"]').on('click keyup', function(event) {
  			console.log(event.currentTarget);
  			if (event.which == 27 && $('.navbar-collapse form[role="search"]').hasClass('active') ||
  				$(event.currentTarget).attr('type') == 'reset') {
  				closeSearch();
  			}
  		});

  		function closeSearch() {
              var $form = $('.navbar-collapse form[role="search"].active')
      		$form.find('input').val('');
  			$form.removeClass('active');
  		}

  		// Show Search if form is not active // event.preventDefault() is important, this prevents the form from submitting
  		$(document).on('click', '.navbar-collapse form[role="search"]:not(.active) button[type="submit"]', function(event) {
  			event.preventDefault();
  			var $form = $(this).closest('form'),
  				$input = $form.find('input');
  			$form.addClass('active');
  			$input.focus();

  		});
  		// ONLY FOR DEMO // Please use $('form').submit(function(event)) to track from submission
  		// if your form is ajax remember to call `closeSearch()` to close the search container
  		$(document).on('click', '.navbar-collapse form[role="search"].active button[type="submit"]', function(event) {
  			event.preventDefault();
  			var $form = $(this).closest('form'),
  				$input = $form.find('input');
  			$('#showSearchTerm').text($input.val());
              closeSearch()
  		});

});
