var zt=[0,1,2,3,4,5,6,7,8,9];
var zts=["未评估","已评估","已审核","已批准","中止（关闭）","审核驳回","批准驳回","","作废","指定结束"];
var pgdids=[];
var no=[];
var instructionContentIds=[];
var oldScwjList=[];
$(function() {
//加载已选择的技术评估单
selectChoosePgd();

//回显工作内容
appendInstructionContent();

//加载已上传的附件
selectChooseFj();

$('#fcrq').datepicker({
	 autoclose: true,
	 clearBtn:true
}).on('hide', function(e) {
	  $('#form').data('bootstrapValidator')  
   .updateStatus('fcrq', 'NOT_VALIDATED',null)  
   .validateField('fcrq');  
});

if($("#Annunciatelist tr").length>0){
	$('#jx').attr("disabled",true);
}

validatorForm =  $('#form').bootstrapValidator({
    message: '数据不合法',
    feedbackIcons: {
        //valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
                   
        zhut: {
            validators: {
            	notEmpty: {
                    message: '主题不能为空'
                }
            }
        },
        jx: {
            validators: {
                notEmpty: {
                    message: '机型不能为空'
                }
            }
        },
        jsrid: {
            validators: {
            	notEmpty: {
                    message: '接收人不能为空'
                }
            }
        },
        nr: {
            validators: {
            	notEmpty: {
                    message: '内容不能为空'
                }
            }
        }
        	            
    }
});

    var dprtcode = $("#dprtcode").val();
    var jx=$("#instructionJx").val();
	 var planeRegOption = '';
	 var planeDatas = acAndTypeUtil.getACTypeList({DPRTCODE:dprtcode});
	 if(planeDatas != null && planeDatas.length >0){
	  	$.each(planeDatas,function(i,planeData){
	  		if(jx==planeData.FJJX){
	  			planeRegOption += "<option value='"+StringUtil.escapeStr(planeData.FJJX)+"' selected='selected'>"+StringUtil.escapeStr(planeData.FJJX)+"</option>";
	  		}else{
	  			planeRegOption += "<option value='"+StringUtil.escapeStr(planeData.FJJX)+"'>"+StringUtil.escapeStr(planeData.FJJX)+"</option>";
	  		}
	  	});
	 }
	  /*if(planeRegOption == ''){
	  	planeRegOption = '<option value="">暂无飞机 No plane</option>';
	  }*/
	  $("#jx").append(planeRegOption);
    

obtainDrptment();
});
//打开评估单列表对话框
function openPgd() {
	 goPage(1,"auto","desc");
	 $("#alertModalPgd").modal("show");
}
//跳转至指定页数:三个参数依次为:当前页码,排序字段,排序规则 
function goPage(pageNumber,sortType,sequence){
	AjaxGetDatasWithSearch(pageNumber,sortType,sequence);
}
//带条件搜索的翻页
function AjaxGetDatasWithSearch(pageNumber,sortType,sequence){
	var obj ={};
	var zlid=$('zlid').val();
	if (zlid != null && zlid != "") {
		obj.zlid = zlid;					//指令id
	   	}
	var pgdsId="";
	for(var i=0;i<pgdids.length;i++){
   		//alert(pgdids[i]);
   		pgdsId+= pgdids[i]+",";
   	}
	pgdsId=pgdsId.substring(0,pgdsId.length-1);
	obj.pgdsId=pgdsId;//已选择的评估单id
	obj.isJszl=1;	//技术通告复选为1
	obj.jx=$('#jx').val();//机型
	obj.dprtcode=$('#dprtcode').val();//组织机构
	obj.keyword=$.trim($('#keyword_search').val());//关键字
	//var searchParam = gatherSearchParam();
	obj.pagination = {page:pageNumber,sort:sortType,order:sequence,rows:10};
	
	startWait();
	 AjaxUtil.ajax({
	   url:basePath+"/project/technicalfile/selectPgdList",
	   type: "post",
	   contentType:"application/json;charset=utf-8",
	   dataType:"json",
	   data:JSON.stringify(obj),
	   success:function(data){
	    finishWait();
		   if(data.total >0){
			   appendContentHtml(data.rows);
			   var page_ = new Pagination({
					renderTo : "pagination",
					data: data,
					sortColumn : sortType,
					orderType : sequence,
					extParams:{},
					goPage: function(a,b,c){
						AjaxGetDatasWithSearch(a,b,c);
					}//,
					//controller: this_
				});
				signByKeyword($("#keyword_search").val(), [ 2, 3, 8 ],"#Pgdlist tr td");
		   } else {
			  $("#Pgdlist").empty();
			  $("#pagination").empty();
			  $("#Pgdlist").append("<tr><td colspan=\"12\">暂无数据 No data.</td></tr>");
		   }
     }
   }); 
	
}
function chooesRow2(obj){
	chooesRow($(obj));
}

function chooesRow1(objradio){
	var obj = $(objradio).find("input[type='checkbox']");
	chooesRow(obj);
}

//行选
function chooesRow(obj){
	var flag = obj.is(":checked");
	if(flag){
		obj.removeAttr("checked");
	}else{
		obj.attr("checked",true);
	}
	
}
function appendContentHtml(list){
	   var htmlContent = '';
	   $.each(list,function(index,row){
		   if (index % 2 == 0) {
			   htmlContent = htmlContent + "<tr style=\"cursor:pointer\"  bgcolor=\"#f9f9f9\" onclick='chooesRow1(this)' >";
		   } else {
			   htmlContent = htmlContent + "<tr style=\"cursor:pointer\"  bgcolor=\"#fefefe\" onclick='chooesRow1(this)' >";
		   }
		   htmlContent = htmlContent + "<td><input type=\"checkbox\" name='pgd' onclick='chooesRow2(this)'><input type='hidden' value="+formatUndefine(row.id)+">" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.pgdh))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.wjzt))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.ly))+"'>" +
																		   		"<input type='hidden' value='"+formatUndefine(row.sxrq)+"'>" +
																		   		"<input type='hidden' value='"+formatUndefine(row.pgqx)+"'>" +
																		   		"<input type='hidden' value="+formatUndefine(row.zt)+">"+
																					"<input type='hidden' value="+row.pgr_user.username+">"+
																					"<input type='hidden' value="+row.pgr_user.realname+"></td>";
		   htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"' >"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"</td>";  
			htmlContent = htmlContent + "<td class='text-center'>"+StringUtil.escapeStr(formatUndefine(row.pgdh))+"</td>";  
			htmlContent = htmlContent + "<td class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.ly))+"</td>";  
			htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(formatUndefine(row.jx))+"'>"+StringUtil.escapeStr(formatUndefine(row.jx))+"</td>";  
			htmlContent = htmlContent + "<td class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.flname))+"</td>";  
			htmlContent = htmlContent + "<td class='text-right'>"+StringUtil.escapeStr(formatUndefine(row.bb))+"</td>";  
			htmlContent = htmlContent + "<td title='"+StringUtil.escapeStr(row.wjzt)+"' class='text-left'>"+StringUtil.escapeStr(row.wjzt)+"</td>";  
			htmlContent = htmlContent + "<td class='text-center'>"+(formatUndefine(row.sxrq).substring(0,10))+"</td>"; 
			htmlContent = htmlContent + "<td class='text-left'>"+formatUndefine(row.pgr_user.displayName)+"</td>";  
			htmlContent = htmlContent + "<td class='text-left'>"+(formatUndefine(row.pgqx).substring(0,10))+"</td>";  
			htmlContent = htmlContent + "<td class='text-left'>"+formatUndefine(zts[row.zt])+"</td></tr>";  
		    
	   });
	   //$("#Pgdlist").empty();
	   $("#Pgdlist").html(htmlContent);
	 
}

//保存评估单
function appendPgd(){
	var dprtcode=$("#jgdm").val();
	var htmlContent = ""; 
	$('input[name=pgd]:checked').each(function(){   
		var pgdId=$(this).next().val();
		var pgdh=$(this).next().next().val();
		var ckzl=$(this).next().next().next().val();
		var wjzt=$(this).next().next().next().next().val();
		var ly=$(this).next().next().next().next().next().val();
		var sxrq=$(this).next().next().next().next().next().next().val();
		var pgqx=$(this).next().next().next().next().next().next().next().val();
		var pgzt=$(this).next().next().next().next().next().next().next().next().val();
		var username=$(this).next().next().next().next().next().next().next().next().next().val();
		var realname=$(this).next().next().next().next().next().next().next().next().next().next().val();
		//alert(wjzt);
		htmlContent = htmlContent + "<tr   style=\"cursor:pointer\" bgcolor=\"#fefefe\" id='tr1_"+pgdId+"'>";
		htmlContent = htmlContent + "<td><button class='line6' onclick=\"lineRemove('"+pgdId+"')\" type='button'><i class='icon-minus cursor-pointer color-blue cursor-pointer' ></i></button></td>";
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'><input type='hidden' name='PgdIdAndPgdh' value="+pgdId+","+StringUtil.escapeStr(pgdh)+"><input type='hidden' name='Ckzl1' value='"+StringUtil.escapeStr(ckzl)+"'><a href=\"javascript:viewMainTechnicalfile('"+pgdId+"','"+dprtcode+"')\">"+StringUtil.escapeStr(pgdh)+"</a></td>";
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(ly)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle' title='"+StringUtil.escapeStr(ckzl)+"'>"+StringUtil.escapeStr(ckzl)+"</td>";  
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'>"+(sxrq.substring(0,10))+"</td>";
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+username+" "+realname+"</td>";
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'>"+(pgqx.substring(0,10))+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+zts[pgzt]+"</td>";
		htmlContent = htmlContent + "</tr>";
		pgdids.push(pgdId);
		
		if($('#zhut').val()=="" || $('#zhut').val()==null){
			$('#zhut').val(wjzt);
		}
		  });
		//$("#Annunciatelist").empty();
	    $("#Annunciatelist").append(htmlContent);
	    /*if($("#Annunciatelist tr").length>0){
	    	$('#jx').attr("disabled",true);
	    }*/
}
//删除行
function lineRemove(pgdid){
	pgdids.remove(pgdid);
	//alert(pgdids);
	$('#tr1_'+pgdid).remove();
	/* if($("#Annunciatelist tr").length<=0){
	    	$('#jx').attr("disabled",false);
	    }*/
}
//扩展数组方法：查找指定元素的下标  
Array.prototype.indexOf = function(val) {  
for (var i = 0; i < this.length; i++) {  
    if (this[i] == val) return i;  
}  
return -1;  
};  

//扩展数组方法:删除指定元素  
Array.prototype.remove = function(val) {  
var index = this.indexOf(val);  
while(index>-1){  
    this.splice(index, 1);  
    index = this.indexOf(val);  
}  
}; 
/*//将搜索条件封装 
function gatherSearchParam(){
	 var searchParam = {};
	 searchParam.rid = $.trim($("#rid_search").val());
	 searchParam.aircrafttailnumber = $.trim($("#aircrafttailnumber_search").val());
	 searchParam.msn = $.trim($("#msn_search").val());
	 searchParam.aircrafttype = $.trim($("#aircrafttype_search").val());
	 searchParam.description = $.trim($("#description_search").val());
	 searchParam.plannedstartdate = $.trim($("#plannedstartdate_search").val());
	 searchParam.plannedfinishdate = $.trim($("#plannedfinishdate_search").val());
	 searchParam.actualstartdate = $.trim($("#actualstartdate_search").val());
	 return searchParam;
}*/

//获取选择后的所有评估单id
function getPgdIdAndPgdh(){
	var pgdIdAndPgdh=[];
	$("#Annunciatelist").find("tr input[name='PgdIdAndPgdh']").each(function(){
	var ordersource={};
		//alert($(this).val());
		//alert("2");
		ordersource.pgdid=$(this).val().split(',')[0]; 
		ordersource.pgdh=$(this).val().split(',')[1]; 
		pgdIdAndPgdh.push(ordersource);
	});
	return pgdIdAndPgdh;
}
//保存
function save(){
	//评估单id
	var orderSourceList=getPgdIdAndPgdh();
	//工作内容
	var instructionContentList=getinstructionContent();
	//基本信息
	
	var id=$.trim($("#instructionId").val());
	var jszlh=$.trim($("#jszlh").val());
	var zhut=$.trim($("#zhut").val());
	var nr=$.trim($("#nr").val());
	var jsrid=$.trim($("#jsrid").val());
	var fcrid=$.trim($("#fcrid").val());
	var fcrq=$.trim($("#fcrq").val());
	var bflyyj=$.trim($("#bflyyj").val());
	var bz=$.trim($("#bz").val());
	var jx=$.trim($("#jx").val());
	var zxsx=$.trim($("#zxsx").val());
	var dprtcode=$.trim($("#dprtcode").val());
	var oldInstructionContentIds=instructionContentIds;
	var obj={
			"orderSourceList":orderSourceList,
			"instructionContentList":instructionContentList,
			"oldInstructionContentIds":oldInstructionContentIds,
			"id":id,
			"jszlh":jszlh,
			"zhut":zhut,
			"fcrid":fcrid,
			"fcrq":fcrq,
			"bflyyj":bflyyj,
			"nr":nr,
			"ckzl":getShzlh(),
			"jsrid":jsrid,//接收人ID
			"bz":bz,//备注
			"dprtcode":dprtcode,//组织机构
			"zxsx":zxsx,//执行时限
			"jx":jx//机型
	};
	//alert(JSON.stringify(obj));
	saveMaininstruction(obj);
}
//获取所有的适航指令号并拼接
function getShzlh(){
	var ckzl="";
	$("#Annunciatelist").find("tr input[name='Ckzl1']").each(function(){
		//alert($(this).val());
		//alert(1);
		ckzl+=$(this).val()+",";
	});
	//alert(ckzl);
	ckzl=ckzl.substring(0,ckzl.length-1);
	//alert(ckzl);
	
	return ckzl;
}
//提交
function save1(){
	//评估单id
	var orderSourceList=getPgdIdAndPgdh();
	//工作内容
	var instructionContentList=getinstructionContent();
	var id=$.trim($("#instructionId").val());
	var jszlh=$.trim($("#jszlh").val());
	var zhut=$.trim($("#zhut").val());
	var nr=$.trim($("#nr").val());
	var jsrid=$.trim($("#jsrid").val());
	var fcrid=$.trim($("#fcrid").val());
	var fcrq=$.trim($("#fcrq").val());
	var bflyyj=$.trim($("#bflyyj").val());
	var bz=$.trim($("#bz").val());
	var jx=$.trim($("#jx").val());
	var zxsx=$.trim($("#zxsx").val());
	var dprtcode=$.trim($("#dprtcode").val());
	var oldInstructionContentIds=instructionContentIds;
	var obj={
			"orderSourceList":orderSourceList,
			"instructionContentList":instructionContentList,
			"oldInstructionContentIds":oldInstructionContentIds,
			"id":id,
			"jszlh":jszlh,
			"zhut":zhut,
			"fcrid":fcrid,
			"fcrq":fcrq,
			"bflyyj":bflyyj,
			"nr":nr,
			"ckzl":getShzlh(),
			"jsrid":jsrid,//接收人ID
			"bz":bz,//备注
			"dprtcode":dprtcode,//组织机构
			"zxsx":zxsx,//执行时限
			"jx":jx//机型
	};
	//alert(JSON.stringify(obj));
	saveMaininstruction(obj);
}
//提交后台
function saveMaininstruction(obj){
	
	var len = $("#Annunciatelist").find("tr").length;
	if(len<=0){
		 AlertUtil.showErrorMessage("请先选择评估单");
		return false;
	}
	 $('#form').data('bootstrapValidator').validate();
	  if(!$('#form').data('bootstrapValidator').isValid()){
		  AlertUtil.showErrorMessage("请根据提示输入正确的信息");
		return false;
	  }
	
	// 提交数据
	AjaxUtil.ajax({
		url:basePath+"/project/instruction/editMainInstruction",
		type: "post",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(obj),
		dataType:"json",
		success:function(data){
				AlertUtil.showMessage('提交成功!','/project/instruction/main?id='+data+'&pageParam='+pageParam);
		}
	});
}
//加载已选择的关联评估单
function selectChoosePgd(){
	var id=$('#instructionId').val();
	AjaxUtil.ajax({
		url:basePath + "/project/technicalfile/selectChoosePgd",
		type:"post",
		async: false,
		data:{
			'id' : id
		},
		dataType:"json",
		success:function(data){
			//拼接内容
			appendSelectChoosePgd(data);
		}
	});
}
//拼接已选择的评估单
function appendSelectChoosePgd(dataList){
	var param = dataList.tchnicalFileList; //页面数据
	var htmlContent = "";
	$.each(param,function(index,data){
		pgdids.push(data.id); 
		//alert(data.id);
		htmlContent += "<tr bgcolor=\"#f9f9f9\" id='tr1_"+data.id+"'>";
		/*htmlContent += "<td align='center'><a href=\"javascript:lineRemove('"+data.id+"')\"><i class='icon-minus cursor-pointer' ></i></a></td>";*/
		htmlContent = htmlContent + "<td><button class='line6' onclick=\"lineRemove('"+data.id+"')\" type='button'><i class='icon-minus cursor-pointer color-blue cursor-pointer' ></i></button></td>";
		htmlContent += "<td class='text-center' style='vertical-align:middle'>" +
				"<input type='hidden' name='PgdIdAndPgdh' value="+data.id+","+data.pgdh+"><input type='hidden' name='Ckzl1' value='"+StringUtil.escapeStr(data.shzltgh)+"'>"+
				"<a href=\"javascript:viewMainTechnicalfile('"+data.id+"','"+data.dprtcode+"')\">"
				+data.pgdh+"</td></a>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(data.ly)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle' title='"+StringUtil.escapeStr(data.shzltgh)+"' >"+StringUtil.escapeStr(data.shzltgh)+"</td>";
		htmlContent = htmlContent +"<td class='text-center' style='vertical-align:middle'>"+indexOfTime(data.sxrq)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+data.pgr_user.displayName+"</td>";
		htmlContent = htmlContent +"<td class='text-center' style='vertical-align:middle'>"+indexOfTime(data.pgqx)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+zts[data.zt]+"</td>";
		htmlContent = htmlContent + "</tr>";
	});
	
	$("#Annunciatelist").empty();
	$("#Annunciatelist").html(htmlContent);
}
function viewMainTechnicalfile(id,dprtcode){
	window.open(basePath+"/project/technicalfile/findApprovalFileUpload/"+$.trim(id)+"/"+$.trim(dprtcode)+"");
}
//异步删除评估单
function deleteOrderSource(pgdId){
	alert(pgdId);
	pgdids.remove(pgdId);
	var id=$('#instructionzlbh').val();
	AjaxUtil.ajax({
		url:basePath + "/project/instruction/deleteOrderSource",
		type:"post",
		data:{
			'pgdid' : pgdId,
			'zlbh' : id,
		},
		dataType:"json",
		success:function(data){
			if(data.state=="success"){
				//alert(data.massage);
				$('#tr1_'+pgdId).remove();
			}
			
		}
	});
	
}
//根据选择的接收人回显相应的接收人部门
function obtainDrptment(){
	var id=$('#jsrid').val();
	
	if(id=="" || id==null){
		$('#jsrbmid').val("");
		return;
	}
	AjaxUtil.ajax({
		url:basePath+"/project/instruction/obtainDrptment",
		type: "post",
		data:{
			"id" : id
		},
		dataType:"json",
		success:function(data){
			if(data.user.department==null || data.user.department==""){
				$('#jsrbmid').val("");
			}else{
				$('#jsrbmid').val(data.user.department.dprtname);
			}
		}
	});
	
}
//回显工作内容
function appendInstructionContent(){
	var id=$('#instructionId').val();
	AjaxUtil.ajax({
		url:basePath + "/project/instruction/appendInstructionContent",
		type:"post",
		async: false,
		data:{
			'id' : id
		},
		dataType:"json",
		success:function(data){
			
			//拼接内容
			appendContent(data);
		}
	});
}
//拼接内容
function appendContent(dataList){
	var param = dataList.instructionContentList; //页面数据
	var htmlContent = "";
	$.each(param,function(index,data){
		instructionContentIds.push(data.id);
		//alert(data.id);
		no++;
		htmlContent =htmlContent +"<tr id='gznr"+no+"'>"
		/*htmlContent =htmlContent +"<td><button class='line6' onclick=\"deleteGznr('"+no+"')\" type='button'><i class='icon-minus cursor-pointer color-blue cursor-pointer' ></i></button></td>"*/
		htmlContent =htmlContent +"<td><textarea class='col-lg-12 col-sm-12 col-xs-12' style='height:40px' name='gznr' disabled='disabled' >"+StringUtil.escapeStr(data.gznr)+"</textarea></td>"
		htmlContent =htmlContent +"<td ><input type='hidden' name='gznrId' id='gznrId' value="+data.id+"></td>"
		htmlContent =htmlContent +"<td></td>"
		htmlContent =htmlContent +"</tr>"
	});
	
	$("#GznrList").empty();
	$("#GznrList").html(htmlContent);
}
//添加一行工作内容
function appendGznr(){
	var htmlContent ="";
	no++;
	htmlContent =htmlContent +"<tr id='gznr"+no+"'>"
	htmlContent =htmlContent +"<td><button class='line6' onclick=\"deleteGznr('"+no+"')\" type='button'><i class='icon-minus cursor-pointer color-blue cursor-pointer' ></i></button></td>"
	htmlContent =htmlContent +"<td><textarea class='col-lg-12' style='height:40px' name='gznr' maxlength='300'></textarea></td>"
	htmlContent =htmlContent +"<td ><input type='hidden' name='gznrId' id='gznrId' value=1 ></td>"
	htmlContent =htmlContent +"<td></td>"
	htmlContent =htmlContent +"</tr>"
	$("#GznrList").append(htmlContent);
}
//删除工作内容
function deleteGznr(no){
	$('#gznr'+no).remove();
}
//获取工作内容列表
function getinstructionContent(){
	var instructionContentList=[];
	$("#GznrList").find("tr").each(function(){
		var index=$(this).index(); //当前行
		var instructionContent={};
		instructionContent.gznr=$("textarea[name='gznr']").eq(index).val();
		instructionContent.id=$("input[name='gznrId']").eq(index).val();
		if(instructionContent.gznr !="" && instructionContent.gznr!=null){
			instructionContentList.push(instructionContent);
		}
	});
	return instructionContentList;
	}
//加载已上传的附件
function selectChooseFj(){
	var mainid=$('#instructionId').val();
	AjaxUtil.ajax({
	   url:basePath+"/project/annunciate/selectedScwjList",
	   type: "post",
	   dataType:"json",
	   data:{
		   'mainid' : mainid
	   },
	   success:function(data){
		   //oldScwjList=data.rows;
		   appendSelecedScwj(data.rows);
   }
 });
	
	
}
//拼接上传附件
function appendSelecedScwj(list){
	//alert(JSON.stringify(list));
	var htmlContent="";
	 $.each(list,function(index,row){ 
		 oldScwjList.push(row.id);
		 htmlContent = htmlContent+'<tr style="cursor: pointer" bgcolor="#f9f9f9" id=\''+row.id+'\'>';
		/* htmlContent = htmlContent+'<td><div>';
		 htmlContent = htmlContent+'<i class="icon-trash color-blue cursor-pointer" onclick="delfile(\''+row.id+ '\')" title="删除附件">  ';
		 htmlContent = htmlContent+'</div></td>';*/
		/* htmlContent = htmlContent+'<td>'+row.yswjm+'</td>';
		 htmlContent = htmlContent+'<td>'+row.nbwjm+'</td>';*/
		 htmlContent = htmlContent+"<td  class='text-left'><a href=\"javascript:downloadfile('"+row.id+"')\">"+StringUtil.escapeStr(formatUndefine(row.wbwjm))+"</td>";
		 htmlContent = htmlContent+"<td  class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.wjdxStr))+'</td>';
		 htmlContent = htmlContent+"<td  class='text-left'>"+formatUndefine(row.czr_user.displayName)+'</td>';
		 htmlContent = htmlContent+"<td  class='text-center'>"+formatUndefine(row.czsj)+'</td>';
		/* htmlContent = htmlContent+'<td>'+row.cflj+'</td>';*/
		 	 htmlContent = htmlContent+'<input type="hidden" name="fjid" value=\''+row.id+'\'/>';
			 htmlContent = htmlContent+'<input type="hidden" name="nbwjm" value=\''+StringUtil.escapeStr(row.nbwjm)+'\'/>';
			 htmlContent = htmlContent+'<input type="hidden" name="yswjm" value=\''+StringUtil.escapeStr(row.yswjm)+'\'/>';
			 htmlContent = htmlContent+'<input type="hidden" name="wjdx" value=\''+StringUtil.escapeStr(row.wjdx)+'\'/>';
			 htmlContent = htmlContent+'<input type="hidden" name="wbwjm1" value=\''+StringUtil.escapeStr(row.wbwjm)+'\'/>';
			 htmlContent = htmlContent+'<input type="hidden" name="cflj" value=\''+row.cflj+'\'/>';
		 
		 htmlContent = htmlContent+'</tr>';
	 });
	 $('#filelist').append(htmlContent);
	
}
//附件下载
function downloadfile(id){
	//window.open(basePath + "/common/orderDownfile/" + id);
	PreViewUtil.handle(id, PreViewUtil.Table.D_011)
}
//获取附件上传信息
function getOrderAttachment(){
	var orderAttachment=[];
	/*var responses = uploadObj.responses;
	  var len = uploadObj.responses.length;
	  if(len != undefined && len>0){
		  for(var i =0;i<len;i++){
			  orderAttachment.push({
						'yswjm':responses[i].attachments[0].yswjm
						,'wbwjm':responses[i].attachments[0].wbwjm
						,'nbwjm':responses[i].attachments[0].nbwjm
						,'cflj':responses[i].attachments[0].cflj
						,'wjdx':responses[i].attachments[0].wjdx
					});
			}
	  }
	 return orderAttachment;*/
	$("#filelist").find("tr").each(function(){
		  var infos ={};
			var index=$(this).index(); //当前行
			var id =$("input[name='fjid']").eq(index).val();
			var nbwjm =$("input[name='nbwjm']").eq(index).val();
			var yswjm =$("input[name='yswjm']").eq(index).val(); 
			var wbwjm =$("input[name='wbwjm1']").eq(index).val(); 
			var cflj =$("input[name='cflj']").eq(index).val();
			var wjdx =$("input[name='wjdx']").eq(index).val();
			infos.id=id;
			infos.nbwjm=nbwjm;
			infos.yswjm=yswjm;
			infos.wbwjm=wbwjm;
			infos.cflj=cflj;
			infos.wjdx=wjdx;
			orderAttachment.push(infos);
		});
	  
	 return orderAttachment;
}
function back(){
	window.location.href =basePath+"/project/instruction/main?pageParam="+pageParam;
}
//选择评估单
function searchRevision(){
	
	goPage(1,"auto","desc");
}