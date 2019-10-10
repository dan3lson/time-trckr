$(document).on('turbolinks:load', function() {
	let $autoTimerStop = $(".auto-timer-stop");

	$autoTimerStop.click(function() {
		const stopped_at = new Date();
		$('input[name="log[stopped_at]"]').val(stopped_at);
		console.log("stopped at", stopped_at);
		$autoTimerStop.remove();
		$(".auto-timer-form").css("display", "block");
		const $nameInput = $("#log_name");
		$nameInput.focus();
	});
});
