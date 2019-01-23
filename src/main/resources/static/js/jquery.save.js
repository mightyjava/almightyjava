$(function() {
	$("#moveLeftBtnId").click(function() {
		$.map($('#leftSelectionId option:selected') ,function(option) {
			$("#rightSelectionId").append('<option value="'+option.value+'" selected>'+option.text+'</option>');
		});  
		$("#leftSelectionId option:selected").remove();
	});
	
	$("#moveRightBtnId").click(function() {
		$.map($('#rightSelectionId option:selected') ,function(option) {
			$("#leftSelectionId").append('<option id="'+option.value+'">'+option.text+'</option>');
		});  
		$("#rightSelectionId option:selected").remove();
	});
	
	$("#submitUserForm").submit(function(e) {
		e.preventDefault();
		var frm = $("#submitUserForm");
		var data = {};
		$.each(this, function(i, v){
			var input = $(v);
			data[input.attr("name")] = input.val();
			delete data["undefined"];
		});
		saveRequestedData(frm, data, "user");
	});
	
	$("#submitAddressForm").submit(function(e) {
		e.preventDefault();
		var frm = $("#submitAddressForm");
		var data = {};
		$.each(this, function(i, v){
			var input = $(v);
			data[input.attr("name")] = input.val();
			delete data["undefined"];
		});
		saveRequestedData(frm, data, "address");
	});
	
	$("#submitCategoryForm").submit(function(e) {
		e.preventDefault();
		var frm = $("#submitCategoryForm");
		var data = {};
		$.each(this, function(i, v){
			var input = $(v);
			data[input.attr("name")] = input.val();
			delete data["undefined"];
		});
		saveRequestedData(frm, data, "category");
	});
	
	$("#submitVideoForm").submit(function(e) {
		e.preventDefault();
		var frm = $("#submitVideoForm");
		var data = {};
		$.each(this, function(i, v){
			var input = $(v);
			data[input.attr("name")] = input.val();
			delete data["undefined"];
		});
		saveRequestedData(frm, data, "video");
	});
});

function saveRequestedData(frm, data, type) {
	$.ajax({
		contentType:"application/json; charset=utf-8",
		type:frm.attr("method"),
		url:frm.attr("action"),
		dataType:'json',
		data:JSON.stringify(data),
		success:function(data) {
			if(data.status == "success") {
				toastr.success(data.message, data.title, {
					closeButton:true
				});
				if(data.source == "register") {
					setTimeout(function () {
						window.location.href = "/mightyjava";
					}, 2000);
				} else {
					if($("#loginUserRole").val() == "admin") {
						fetchList(type);
					} else if($("#loginUserRole").val() == "user"){
						fetchList(type+"/"+$("#loginUserId").val());
					}
				}
			} else {
				toastr.error(data.message, data.title, {
					allowHtml:true,
					closeButton:true
				});
			}
		}
	});
}