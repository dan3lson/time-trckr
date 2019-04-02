$(document).on('turbolinks:load', function() {
	preFillTagsOnEditLogPage();

	$("#form-tags span").click(function() {
		$tag = $(this);
		tagId = $tag.data("id");
		$tag.toggleClass("badge-dark");
		addOrRemoveTagFromForm(tagId);
	});

	function preFillTagsOnEditLogPage() {
		$(".pre-fill").each(function(index, value) {
			$tag = $(this);
			tagId = $tag.data("id");
			$tag.addClass("badge-dark");
			addTagToForm(tagId);
		});
	}

	function addOrRemoveTagFromForm(tagId) {
		if (tagNotClicked(tagId)) {
			addTagToForm(tagId);
		} else {
			removeTagFromForm(tagId);
		}
	}

	function addTagToForm(tagId) {
		$("#form-tags").append(createHiddenInput(tagId));
	}

	function removeTagFromForm(tagId) {
		removeHiddenInput(tagId);
	}

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
