$(function() {
	$("#homeList").click(function(){
		console.log("Home Btn Click");
		fetchList("home");
	});
	
	$("#userList").click(function(){
		fetchList("user");
	});
	
	$("#userProfile").click(function(){
		fetchList("user/"+$("#loginUserId").val());
	});
	
	$("#addressList").click(function(){
		fetchList("address");
	});
	
	$("#userAddress").click(function(){
		fetchList("address/"+$("#loginUserId").val());
	});
	
	$("#changePassword").click(function() {
		modifyData("user/changePassword/"+$("#loginUserId").val());
	});
	
	$("#categoryList").click(function() {
		fetchList("category");
	});
	
	$("#videoList").click(function() {
		fetchList("video");
	});
	
	$("#blogList").click(function() {
		fetchList("blog");
	});
	
});

var pageConstant = "?page=1";

function addForm(type) {
	modifyData(type+"/form");
}

function editForm(type, id) {
	modifyData(type+"/edit/"+id);
}

function fetchList(type) {
	if($(".navbar-nav").hasClass("nav-link")) {
		$(".nav-link").removeClass("active");
		$("#"+type+"List").addClass("active");
	}
	modifyData(type+"/list"+pageConstant);
}

function list(type, page) {
	modifyData(type+"/list?page="+page);
}

function modifyData(suffix) {
	$.ajax({
		type : "GET",
		url : "/mightyjava/"+suffix,
		success : function(data) {
			$(".inner-jsp").html(data);
		}
	});
}

function deleteData(type, id) {
	toastr.warning("<div>Are you sure you want to delete this?</div>" +
			"<div class='btn-group pull-right'>" +
			"<button type='button' id='confirmationYes' class='btn btn-xs btn-default'><i class='glyphicon glyphicon-ok'></i> Yes</button>" +
			"<button type='button' class='btn btn-xs btn-default clear'><i class='glyphicon glyphicon-remove'></i> No</button>" +
			"</div>", "Delete Confirmation", {
		allowHtml:true,
		closeButton:true,
		onShown: function() {
			$("#confirmationYes").click(function() {
				$.ajax({
					type : "GET",
					url : "/mightyjava/"+type+"/delete/"+id,
					success : function(data) {
						if($("#loginUserRole").val() == "admin") {
							fetchList(type);
						} else {
							fetchList(type+"/"+$("#loginUserId").val());
						}
						toastr.success(data.message, "Delete Confirmation", {
							closeButton:true
						});
					}
				});
			});
		}
	});
}