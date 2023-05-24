function Menu() {
	var id,menuName, selected, menuLevel, goingBack;

	this.opened = false;

	debug = function(msg) {
		$("#ofgsErrDiv").prepend("<br />Menu Debug: " + msg);
	};

	init = function() {
		id = 0;
		menuName = "";
		menuLevel = -1;
		selected = -1;
		goingBack = false;

		buildMainMenu();
	};

	buildMainMenu = function() {
		$("body").append(
			$("<div>",{"id":"ofgs_mainMenu","class":"ofgs_mainMenu"}).css("display","none").append(
				$("<h1>",{"id":"ofgs_menuHeader","class":"ofgs_menuHeader"})
			).append(
				$("<div>",{"id":"ofgs_menuChoices","class":"ofgs_menuChoices"})
			).append(
				$("<div>",{"id":"ofgs_menuDescription","class":"ofgs_menuDescription"}).append(
					$("<div>",{"id":"ofgs_menuDescriptionContent","class":"ofgs_menuDescriptionContent"})
				)
			)
		);
	};

	getChoicesCount = function() {
		return $("#ofgs_menuChoices").find(".ofgs_menuChoice").length;
	};

	getChoiceText = function() {
		return $($("#ofgs_menuChoices").find(".ofgs_MenuChoiceSelected")[0]).text();
	};

	getChoiceDesc = function() {
		var selectedChoiceEl = $("#ofgs_menuChoices").find(".ofgs_MenuChoiceSelected")[0];

		return ($(selectedChoiceEl).attr("data-desc")) ? $(selectedChoiceEl).data("desc"):"";
	};

	scrollToMenuOption = function() {
		if($("#ofgs_menuChoices").find(".ofgs_MenuChoiceSelected").length) {
			var scrollto = $($("#ofgs_menuChoices").find(".ofgs_MenuChoiceSelected"));
			var container = $("#ofgs_menuChoices");

			if(scrollto.offset().top < container.offset().top || scrollto.offset().top + scrollto.height() >= container.offset().top+container.height()) {
				container.scrollTop(scrollto.offset().top - container.offset().top + container.scrollTop());
			}
		}
	};

	setHeaderColor = function(headerColor) {
		$("#ofgs_menuHeader").css("backgroundColor",headerColor);
	};

	this.open = function(data) {
		menuName = data.menudata.name;
		var choices = data.menudata.choices;
		var css = (data.menudata.css) ? data.menudata.css:false;
		var headerColor = (css.header_color) ? css.header_color:false;

		$("#ofgs_menuChoices").empty();
		$("#ofgs_menuHeader").html(menuName);

		setHeaderColor(headerColor);

		if(!this.opened) {
			this.opened = true;
			goingBack = false;
			menuLevel = 0;
		} else if(!goingBack) {
			++menuLevel;
		} else {
			goingBack = false;
		}

		$("#ofgs_mainMenu").show();

		$.each(choices,function(i,c) {
			$("#ofgs_menuChoices").append(
				$("<div>",{"class":"ofgs_menuChoice", "data-desc":c[1]}).html(getChoiceContents(c[0]))
			);
		});

		this.setSelected(0);
	};

	getChoiceContents = function(choice) {
		if(choice.substr(0,1) === "<") {
			var bgColor = $(choice).data("bgcolor");
			return $("<div>").html($(choice).css("background-color",bgColor));
		} else {
			return choice;
		}
	};

	this.close = function() {
		if(this.opened) {
			goingBack = true;
			--menuLevel;

			if(menuLevel < 1) {
				this.opened = false;
				$("#ofgs_mainMenu").hide();
			}

			if(this.onClose) {
				this.onClose();
			}
		}
	};

	this.setSelected = function(i) {
		selected = i;
		$(".ofgs_menuChoice").removeClass("ofgs_MenuChoiceSelected");

		if(selected < 0) {
			selected = getChoicesCount()-1;
		} else if(selected >= getChoicesCount()) {
			selected = 0;
		}

		if(selected >= 0 && (selected < getChoicesCount())) {
			$("#ofgs_menuChoices div.ofgs_menuChoice:nth-child(" + (selected + 1) + ")").addClass("ofgs_MenuChoiceSelected");
		}

		scrollToMenuOption();

		if(getChoiceDesc().length) {
			$("#ofgs_menuDescriptionContent").html(getChoiceDesc());
			$("#ofgs_menuDescription").show();
		} else {
			$("#ofgs_menuDescription").hide();
		}
	};

	this.moveUp = function() {
		if(this.opened) {
			this.setSelected(selected-1);
		}
	};

	this.moveDown = function() {
		if(this.opened) {
			this.setSelected(selected+1);
		}
	};

	this.valid = function(mod) {
		if(selected >= 0 && selected < getChoicesCount()) {
			if(this.onValid && this.opened) {
				this.onValid(getChoiceText(), mod);
			}
		}
	};

	init();
}
