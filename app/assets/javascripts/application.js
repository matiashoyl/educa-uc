// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require chosen-jquery
//= require jquery-ui
//= require evaluations
//= require highcharts
//= require_tree .


function click_radio_button(item_id, column_id, subscale_id, primera_columna){
	var radio_class = "item-"+item_id+"-columna-"+column_id;
	var bool = true;
	var value = '';
	$('.'+radio_class).each(function() {
		value = $("input[name='"+this.name+"']:checked").val();
		if(primera_columna == true)
		{
			if(value == 'true')
			{
				bool = false;

			}
			else if(! value)
			{
				bool = false;
			}
		}
		else
		{
			if(value == 'false')
			{
				bool = false;
			}
			else if(! value)
			{
				bool = false;
			}
		}
	});

	if(bool == true)
	{
		var new_column = column_id + 1;
		var selector = '#tab-'+subscale_id+'-'+item_id+' a[href="#'+subscale_id+'-'+item_id+'-'+new_column+'"]';
		activateTab(selector);
		var selector2 = '#tab-'+subscale_id+'-'+item_id+' a[href="#'+subscale_id+'-'+item_id+'-'+column_id+'"]';
		activateTab(selector2);
	}
}

function activateTab(selector) {
    $(selector).on('click.twbstab',function() { $(this).tab('show'); })
        .closest('.disabled').removeClass('disabled');
}



