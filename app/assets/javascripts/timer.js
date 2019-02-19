$(document).on('turbolinks:load', function() {
	$playIcon = $("#timerControl").find(".fa-play");
	$playBtn  = $playIcon.parent();

	$playIcon.click(function() {
		started_at = new Date();
		$('input[name="log[started_at]"]').val(started_at);
		console.log("started", started_at);
		$playIcon.remove();
		$stopBtn = $("<i>", { class: "fa fa-stop timer-btn" });
		$playBtn.append($stopBtn);
	});

	$("#timerControl").on("click", ".fa-stop", function() {
		stopped_at = new Date();
		$('input[name="log[stopped_at]"]').val(stopped_at);
		console.log("stopped", stopped_at);
		$stopIcon = $("#timerControl").remove();
		$(".log-name-sec").removeClass("d-none");
		$nameInput = $("#log_name");
		$nameInput.focus();
	});
});
