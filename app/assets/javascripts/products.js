// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
    affixFix();
});

function affixFix(){
    if($("#affixPane").hasClass('affix')) {
        $("#everything_else").css('visibility', 'visible');
    } else {
        setTimeout(affixFix, 10);
    }
}