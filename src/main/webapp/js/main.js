$("#sidebar-content span").click(function() {
	$('.items').hide();
	$("#item" + this.id).show();
});

$(document).on('click', 'input.candidateRadioButton', function() {
	var id = this.name;
	id = id.replace("candidate:", "");
	$("#" + id).
		attr('class', '').
		addClass("user_decided");
});

var t = '';
Selector = {};
Selector.getSelected = function() {
	if (window.getSelection) {
		t = window.getSelection();
	} else if (document.getSelection) {
		t = document.getSelection();
	} else if (document.selection) {
		t = document.selection.createRange().text;
	}
	return t;
};

Selector.getSelectionCharOffsetsWithin = function() {
	var start = 0, end = 0;
	var sel, range, priorRange;
	var element = document.getElementById("sidebar-content");
	if (typeof window.getSelection != "undefined") {
		range = window.getSelection().getRangeAt(0);
		priorRange = range.cloneRange();
		priorRange.selectNodeContents(element);
		priorRange.setEnd(range.startContainer, range.startOffset);
		start = priorRange.toString().length;
		end = start + range.toString().length;
	} else if (typeof document.selection != "undefined"
				&& (sel = document.selection).type != "Control") {
		range = sel.createRange();
		priorRange = document.body.createTextRange();
		priorRange.moveToElementText(element);
		priorRange.setEndPoint("EndToStart", range);
		start = priorRange.text.length;
		end = start + range.text.length;
	}
	return {
		start : start,
		end : end
	};
};

Selector.mouseup = function() {
	var st = Selector.getSelected();
	var selection = Selector.getSelectionCharOffsetsWithin();
	if (st != '') {
		var containerId = encodeURIComponent(st + '');
		var $container = $('<div id="' + containerId + '"></div>');
		$('#right-sidebar .innerContainer').append($container);

		$container.append([ $('<span class="ui-icon ui-icon-circle-close" />')
		                    	.css({'display' : 'inline-block'})
		                    	.click(function() {	$container.remove();}),
		                    $('<input type="hidden" '
		                    		+'value="newLabel:' + st + '//' + selection.start + '//' + selection.end + '" '
		                    		+'name="newLabel:' + st + '//' + selection.start + '//' + selection.end + '"/>'),
		                    $('<span>' + st + '</span><br />') ]);
	}
};

var candidateNames = [];
$(document).ready(
		function() {
			var adjustHeight = function() {
				$('#outerContainer, #left-sidebar, #main-content, #right-sidebar').height($(window).height()
						- $('#title').outerHeight(true)
						- $('#footer').outerHeight(true)
						- 1);

				$('.innerContainer').height(
						$('#outerContainer').outerHeight(true)
						- $('.subtitle').outerHeight(true)
						- $('.buttonContainer').outerHeight(true)
						- ($('.innerContainer').outerHeight(true) - $('.innerContainer').height()));
			};
			adjustHeight();
			$(window).on('resize', adjustHeight);
			$("#newEntity").bind("click", Selector.mouseup);
			$('#searchForm').submit(function() {
				if ($('span[class="no_candidates_label"]').length != 0
						|| $('span[class="multiple_candidate_label"]').length != 0) {
					alert('Please annotate all labels!');
					return false;
				}
			});
			$('input[type=text], textarea').bind('keypress',function() {
				var id = this.name;
				id = "candidate:"+id.replace(",otherDesc", "")+",-2";
				document.getElementById(id).checked="checked";
				id = id.replace("candidate:", "");
				id = id.replace(",-2", "");
				$("#" + id).
					attr('class', '').
					addClass("user_decided");
			});
		});

candidateNames.push('candidate:${label.textHasLabelId}');
