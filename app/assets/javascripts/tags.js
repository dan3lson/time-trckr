$(document).on('turbolinks:load', function() {
	$(".form-tags span").click(function() {
		$tag = $(this);
		tagId = $tag.data("id");
		$tag.toggleClass("badge-dark");

		if (tagNotClicked(tagId)) {
			$(".form-tags").append(createHiddenInput(tagId));
		} else {
			removeHiddenInput(tagId);
		}
	});

	function createHiddenInput(tagId) {
		$i = $("<input/>", { type: "hidden", name: "log[tag_ids][]", value: tagId })
		return $i;
	}

	function removeHiddenInput(tagId) {
		findInput(tagId).remove();
	}

	function tagNotClicked(tagId) {
		return !findInput(tagId).length;
	}

	function findInput(tagId) {
		return $("input[value='" + tagId + "']");
	}
});
