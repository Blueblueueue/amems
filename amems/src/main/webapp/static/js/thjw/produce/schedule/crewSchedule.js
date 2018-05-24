$(document).ready(function() {
	Navigation(menuCode);
	 loodingBase (); //初始化基地
	 setDefaultDateRangePickerValue();//初始化日期 
 	 refreshPermission();//初始化权限
 	 logModal.init({code:'B_S_010_Crew'});
});

/**
 * 初始化基地
 */
function loodingBase (){
	var dprtcode = $("#dprtcode").val();
	AjaxUtil.ajax({
		   url:basePath+"/sys/department/queryDepartmentByJd", 
		   type: "post",
		   dataType:"json",
		   async: false,
		   data:{'id':dprtcode},
		   success:function(data){
			   var htmlappend = '';
			   if(data != null && data.length > 0){
				   $.each(data,function(index,row){
					   htmlappend += "<option value='"+row.id+"'>"+row.dprtname+"</option>";
				   });
			   }else{
				   htmlappend += "<option value=''>暂无基地 No data.</option>";
			   }
			   $("#jd").empty();
			   $("#jd").html(htmlappend);
		   }
	 });
}

/**
 * 初始化排班日期
 */
function setDefaultDateRangePickerValue(){
	
	$("#scheduleDate_search").daterangepicker().prev().on("click", function() {
		$(this).next().focus();
	});
	$(".cancelBtn").hide();//去掉时间控件取消按钮
	TimeUtil.getCurrentDate(function(date) {
		var startDate = date; 
		var endDate = addDays(addMonths(date, 1), -1);
		$("#scheduleDate_search").data('daterangepicker').setStartDate(startDate);
		$("#scheduleDate_search").data('daterangepicker').setEndDate(endDate);
		$("#scheduleDate_search").val(startDate+" ~ "+endDate);
		decodePageParam(); //加载数据
	});
	function addMonths(date, months){ 
		var d=new Date(Date.parse(date.replace(/-/g, "/"))); 
		d.setMonth(d.getMonth()+months); 
		var month=d.getMonth()+1; 
		var day = d.getDate(); 
		if(month<10){ 
			month = "0"+month; 
		} 
		if(day<10){ 
			day = "0"+day; 
		} 
		var val = d.getFullYear()+"-"+month+"-"+day; 
		return val; 
	}
	
	function addDays(date, days){ 
		var d=new Date(date); 
		d.setDate(d.getDate()+days); 
		var month=d.getMonth()+1; 
		var day = d.getDate(); 
		if(month<10){ 
		month = "0"+month; 
		} 
		if(day<10){ 
		day = "0"+day; 
		} 
		var val = d.getFullYear()+"-"+month+"-"+day; 
		return val; 
	}
	  
}

var pagination = {};
/**
 * 编码页面查询条件和分页
 * @returns
 */
function encodePageParam(){
	var pageParam = {};
	var params = {};
	params.dprtcode = $.trim($("#dprtcode").val());
	params.jd = $.trim($("#jd").val());
	params.scheduleDateBegin=$.trim($("#scheduleDate_search").val()).substring(0,10);
	params.scheduleDateEnd=$.trim($("#scheduleDate_search").val()).substring(13,23);
	pageParam.params = params;
	pageParam.pagination = pagination;
	return Base64.encode(JSON.stringify(pageParam));
}

/**
 * 解码页面查询条件和分页 并加载数据
 * @returns
 */
function decodePageParam(){
	try{
		var decodeStr = Base64.decode(pageParam);
		var pageParamJson = JSON.parse(decodeStr);
		var params = pageParamJson.params;
		$("#dprtcode").val(params.dprtcode);
		$("#jd").val(params.jd);
		$("#scheduleDate_search").val(params.scheduleDateBegin+" ~ "+params.scheduleDateEnd);
		$("#scheduleDate_search").daterangepicker().prev().on("click", function() {
			$(this).next().focus();
		});
		$(".cancelBtn").hide();
		if(pageParamJson.pagination){
			goPage(pageParamJson.pagination.page, pageParamJson.pagination.sort, pageParamJson.pagination.order);
		}else{
			goPage(1,"auto","desc");
		}
	}catch(e){
		goPage(1,"auto","desc");
	}
}

/**
 * 跳转至指定页数:三个参数依次为:当前页码,排序规则 排序字段,
 * 
 * @param pageNumber
 * @param sortType
 * @param sortField
 */
function goPage(pageNumber, sortType, sortField) {
	AjaxGetDatasWithSearch(pageNumber, sortType, sortField);
}

// 带条件搜索的翻页
function AjaxGetDatasWithSearch(pageNumber, sortType, sortField) {
	var searchParam = {};
	searchParam.keyword = $.trim($("#keyword_search").val());
	var pbrq = $.trim($("#scheduleDate_search").val());
	if (pbrq != '') {
		searchParam.scheduleDateBegin = pbrq.substring(0, 10);
		searchParam.scheduleDateEnd = pbrq.substring(13, 23);
	}
	var jd = $.trim($("#jd").val());
	if (jd =='') {
		$("#list").empty();
		$("#list").append("<tr><td class='text-center' colspan=\"14\">暂无数据 No data.</td></tr>");
		return;
	}else{
		searchParam.jd = jd;
	}
	var dprtcode = $.trim($("#dprtcode").val());
	if (dprtcode != '') {
		searchParam.dprtcode = dprtcode;
	}
	pagination = {page:pageNumber,sort:sortField,order:sortType,rows:20};
	searchParam.pagination = pagination;
	if(id != ""){
		searchParam.id = id;
		id = "";
	}
	startWait();
	AjaxUtil.ajax({
		url : basePath + "/produce/scheduling/person/crewScheduleList",
		type : "post",
		data : JSON.stringify(searchParam),
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		success : function(data) {
			finishWait();
			if (data.rows.length > 0) {
				appendContentHtml(data.rows);
				// 替换null或undefined
				FormatUtil.removeNullOrUndefined();
				// 标记关键字
				signKeyword($.trim($("#keyword_search").val()), [3, 4,5, 6, 7, 8, 9, 10, 11, 12 ], "#list tr td");
			} else {
				$("#pagination").empty();
				$("#list").empty();
				$("#list").append("<tr><td class='text-center' colspan=\"14\">暂无数据 No data.</td></tr>");
			}
			new Sticky({tableId:'crewScheduling_check_list_table'});
		}
	});

}

function appendContentHtml(list) {
	var htmlContent = '';
	$.each(list,function(index, row) {
						htmlContent += [
								"<tr>",
								"<td class='fixed-column text-center' style=\"vertical-align: middle;\" ><i class='icon-edit color-blue cursor-pointer' onClick='showModal(\""
										+ row.id
										+ ','
										+ row.pbrq.toString().substr(0, 10)
										+ "\")' title='修改 Edit'></i></i>&nbsp;&nbsp;<i class='fa glyphicon glyphicon-trash color-blue cursor-pointer' onClick=\"Delete('"
										+ row.id + "')\" title='删除 Delete'></i></td>",
								"<td class='fixed-column text-center' style=\"vertical-align: middle;\" >"
										+ row.pbrq.toString().substr(0, 10)	+ "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.jxs != null ? convert(row.jxs) :'')+ "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.dzs != null ? convert(row.dzs) : '')+ "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.jxy != null ? convert(row.jxy) : '')+ "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.dzy != null ? convert(row.dzy) : '') + "</td>",				
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.jxby != null ? convert(row.jxby): '') + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.dzby != null ? convert(row.dzby): '') + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.jxyby != null ? convert(row.jxyby): '') + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.dzyby != null ? convert(row.dzyby): '') + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.mccdd != null ? convert(row.mccdd): '') + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ (row.wh != null ? convert(row.wh) : '')+ "</td>",
								"<td class='text-center' style=\"vertical-align: middle;\" >" + row.whsj + "</td>",
								"<td class='text-left' style=\"vertical-align: middle;\" >"
										+ $("#dprtcode :selected").html()
										+ "</td>", "</tr>" ].join("");
					});
	$("#list").empty();
	$("#list").html(htmlContent);
	refreshPermission();//初始化权限
}

/**
 * 切换组织机构
 */
function onchangeDprtcode(){
	loodingBase ();
	decodePageParam();
}

function searchSchedule() {
	decodePageParam();
}

/**
 * 删除
 */
function Delete(id) {
	AlertUtil.showConfirmMessage("您确定要删除吗？",{callback: function(){
		var searchParam={};
		searchParam.id=id;
		AjaxUtil.ajax({
			url : basePath+ "/produce/scheduling/person/delete",
			type : "post",
			data : JSON.stringify(searchParam),
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			success : function(data) {
				finishWait();
				refreshPermission();
				clearId();
				decodePageParam(); //加载数据
			}
		});
 	}});
}


function saveCrewScheduleData() {
	startWait($("#xlhExistModal"));
	var searchParam={};
	searchParam.pbrq = $("#pbrq").val();
	searchParam.dprtcode = $("#dprtcodeid").val();
	searchParam.jd = $("#base").val();
	searchParam.jxs = $("#jxsid").val();
	searchParam.jxby = $("#jxbyid").val();
	searchParam.jxy = $("#jxyid").val();
	searchParam.jxyby = $("#jxybyid").val();
	searchParam.dzs = $("#dzsid").val();
	searchParam.dzby = $("#dzbyid").val();
	searchParam.dzy = $("#dzyid").val();
	searchParam.dzyby = $("#dzybyid").val();
	searchParam.mccdd = $("#mccddid").val();
	searchParam.zt = $(' input[name="zt"]:checked ').val();
	searchParam.id = $("#id").val();
	searchParam.whrid = $("#userid").val();
	AjaxUtil.ajax({
		url : basePath+ "/produce/scheduling/person/update",
		type : "post",
		data : JSON.stringify(searchParam),
		contentType : "application/json;charset=utf-8",
		dataType : "json",
		modal:$("#xlhExistModal"),
		success : function(data) {
			 finishWait($("#xlhExistModal"));
			$("#xlhExistModal").modal("hide");			
			finishWait();
			refreshPermission();
			clearId();
			id = data;	
			pageParam=encodePageParam();
			decodePageParam(); //加载数据
		}
	});
}

function showModal(param) {
	clearId();
	var dp = $("#dprtcode").val();
	var basejd = $("#jd").val();
	var id = param.split(",")[0];
	var pbrq = param.split(",")[1];
	var jdname = $("#jd :selected").html();
	var dpname = $("#dprtcode :selected").html();
	var searchParam={};
	searchParam.id=id;
	AjaxUtil.ajax({
		url : basePath + "/produce/scheduling/person/edit",
		type : "post",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(searchParam),
		dataType : "json",
		success : function(data) {
			if (data == null) {
				$("#pbrq").val(pbrq);
				$("#basename").val(jdname);
				$("#base").val(basejd);
				$("#dprtcodename").val(dpname);
				$("#dprtcodeid").val(dp);
				$("#id").val(id);
				$("#oldInfo").val("");
				$("#jxs").val("");
				$("#jxby").val("");
				$("#jxy").val("");
				$("#jxyby").val("");
				$("#dzs").val("");
				$("#dzby").val("");
				$("#dzy").val("");
				$("#dzyby").val("");
				$("#mccdd").val("");
			} else {
				$("#pbrq").val(data.pbrq.toString().substr(0, 10));
				$("#id").val(data.id);
				$("#oldInfo").val(data.wh+" "+data.whsj);
				$("#dprtcodename").val(dpname);
				$("#dprtcodeid").val(dp);
				$("#basename").val(jdname);
				$("#base").val(basejd);
				$("#jxs").val(data.jxs);
				$("#jxsid").val(data.jxsid);
				$("#jxby").val(data.jxby);
				$("#jxbyid").val(data.jxbyid);
				$("#jxy").val(data.jxy);
				$("#jxyid").val(data.jxyid);
				$("#jxyby").val(data.jxyby);
				$("#jxybyid").val(data.jxybyid);
				$("#dzs").val(data.dzs);
				$("#dzsid").val(data.dzsid);
				$("#dzby").val(data.dzby);
				$("#dzbyid").val(data.dzbyid);
				$("#dzy").val(data.dzy);
				$("#dzyid").val(data.dzyid);
				$("#dzyby").val(data.dzyby);
				$("#dzybyid").val(data.dzybyid);
				$("#mccdd").val(data.mccdd);
				$("#mccddid").val(data.mccddid);
			}
		}
	});
	AlertUtil.hideModalFooterMessage();    	   //初始化错误信息 
	$("#xlhExistModal").modal("show");

}
function closeUserMultiModal() {
	$("#UserMultiModal").modal("hide")
}
function closeCrewScheduleData(){
	$("#xlhExistModal").modal("hide");
	clearId();
}
$('#xlhExistModal').on('hide.bs.modal', function (e) {
	clearId();
});

function clearId(){
	$("#jxsid").val("");
	$("#jxbyid").val("");
	$("#jxyid").val("");
	$("#jxybyid").val("");
	$("#dzsid").val("");
	$("#dzbyid").val("");
	$("#dzyid").val("");
	$("#dzybyid").val("");
	$("#mccddid").val("");
	 var selects = document.getElementsByName("zt");  
	    for (var i=0; i<selects.length; i++){  
	        if (selects[i].value=="1") {  
	            selects[i].checked= true;  
	            break;  
	        }  
	    }  
}



function signKeyword(keyword, columns, path){
	
	 var defaultPath = "tbody tr td";
	
	 if(keyword){
		 
		 $.each(columns, function(i, obj){
			 
			 $((path||defaultPath)+":nth-child("+obj+")").each(function(){
				 var content = $(this);
				 var value = content.html();
				 if(content.find("[name='keyword']").length >= 1){
					 content = content.find("[name='keyword']");
					 value  = content.html();
				 } else {
				 	 // 当td里面包含的不直接是文本内容，而是html代码嵌套，则取最里面一层的内容作为文本内容
					 while(content.children().length >= 1){
						 content = content.children().first();
						 value  = content.html();
					 }
				 }
				 
					value=value.replace(/<br\>/g,',');
				 
				 var startIndex = value.indexOf(keyword);
				 
				 if(startIndex != -1){
					 var show=[value.substr(0,startIndex),
				               "<font style='color:red'>",
				               value.substr(startIndex, keyword.length),
				               "</font>",
				               value.substr(parseInt(startIndex) + parseInt(keyword.length))
				               ].join("");
					 show=show.replace(/,/g, '<br>');
					 content.html(show);
					 
				 }
			 });
			 
		 });
	 }
}

function convert(obj){
	var str=obj.split(",");
	var s='';
	var name='<span name="keyword">';
	for(var i=0;i<str.length;i++){
		s+=StringUtil.escapeStr(str[i])+"<br>";
	}
	name=name.concat(s).concat("</span>");
	return name;
}


/**
 * 打开人员
 * @param obj
 */
function openUser(obj){
	var userList = [];
	var a = $("#"+obj+"id").val();
	var b = $("#"+obj).val();
	for (var i = 0; i < a.split(",").length; i++) {
		var p = {
			id : a.split(",")[i],
			displayName : b.split(",")[i]
		};
		userList.push(p);
	}
	if (a == "") {
		userList = [];
	}
	Personel_Tree_Multi_Modal.show({
		checkUserList:userList,//原值，在弹窗中回显
		dprtcode:$("#dprtcode").val(),//
		parentWinId : "xlhExistModal",
		callback: function(data){//回调函数
			var displayName = '';
			var mjsrid = '';
			if(data != null && data != ""){
				$.each(data, function(i, row){
					displayName += formatUndefine(row.displayName) + ",";
					mjsrid += formatUndefine(row.id) + ",";
				});
			}
			if(displayName != ''){
				displayName = displayName.substring(0,displayName.length - 1);
			}
			if(mjsrid != ''){
				mjsrid = mjsrid.substring(0,mjsrid.length - 1);
			}
			$("#"+obj).val(displayName);
			$("#"+obj+"id").val(mjsrid);
		}
	});
}