$(document).on('turbolinks:load', function() {
	$playIcon = $("#timer-control").find(".fa-play");
	$playBtn  = $playIcon.parent();

	$playIcon.click(function() {
		started_at = new Date();
		$('input[name="log[started_at]"]').val(started_at);
		console.log("started", started_at);
		$playIcon.remove();
		$stopBtn = $("<i>", { class: "fa fa-stop timer-btn" });
		$playBtn.append($stopBtn);
		$(".fa-stop").css("animation", "none");
	});

	$("#timer-control").on("click", ".fa-stop", function() {
		stopped_at = new Date();
		$('input[name="log[stopped_at]"]').val(stopped_at);
		console.log("stopped", stopped_at);
		$stopIcon = $("#timer-control").remove();
		$(".logs-section").removeClass("d-none");
		$nameInput = $("#log_name");
		$nameInput.focus();
	});
});
