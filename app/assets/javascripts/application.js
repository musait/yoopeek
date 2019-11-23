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
//
//= require jquery3
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require popper
//= require toastr_rails
//= require link_to_add_fields
//= require select2
//= require dropzone
//= require_tree .


toastr.options = ({
 "closeButton": true,
 "debug": false,
 "positionClass": "toast-bottom-right",
 "onclick": null,
 "showDuration": "300",
 "hideDuration": "1500",
 "timeOut": "0",
 "extendedTimeOut": "0",
 "showEasing": "swing",
 "hideEasing": "linear",
 "showMethod": "fadeIn",
 "hideMethod": "fadeOut"
 });
