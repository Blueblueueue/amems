var zt=[0,1,2,3,4,5,6,7,8,9];
var zts=["未评估","已评估","已审核","已批准","中止（关闭）","审核驳回","批准驳回","","作废","指定结束"];
var no1=0;
var pgdids=[];
var nox=0;
var oldzxdxList=[];
var zxdxFjzch="";
var xlhValue="";
var tr={};

$(function() {
	$('.datepicker').datepicker({
		 autoclose: true,
		 clearBtn:true
	});
	$('#zhut').on('change', function(e) {
		$('#form').data('bootstrapValidator')  
		.updateStatus('zhut', 'NOT_VALIDATED',null)  
		.validateField('zhut');  
	});
	/*initFixedWorkContent();*/
	/*addRotatableCol();*/
	
	//加载已选择的技术评估单
	selectChoosePgd();
	//获取评估单的总条数，如果大于0，机型置灰
	var len = $("#Annunciatelist").find("tr").length;
	if(len > 0){
		$('#jx').attr("disabled",true);
	}
	
	

	//生成多选下拉框动
	$('#eolx').multiselect({
		buttonClass: 'btn btn-default',
	    buttonWidth: 'auto',
	    numberDisplayed:20,
	    includeSelectAllOption: true,
	    onChange:function(element,checked){
	    }
	});
	var engineeringEolx=$("#engineeringEolx").val();
	var Eolx=[];
	for(var i=0;i<engineeringEolx.length;i++){
		Eolx.push(engineeringEolx[i]);
	}
	$("#eolx").multiselect('select', Eolx);

	validatorForm =  $('#form').bootstrapValidator({
        message: '数据不合法',
        feedbackIcons: {
            //valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
                       
            jx: {
                validators: {
                	notEmpty: {
                        message: '机型不能为空'
                    }
                }
            },
            bb: {
                validators: {
                	regexp: {
                        regexp: /^[^\u4e00-\u9fa5]{0,}$/,
                        message: '不能输入中文'
                    }
                }
            },
            zhut: {
                validators: {
                	notEmpty: {
                        message: '主题不能为空'
                    }
                }
            },
            xggzh: {
                validators: {
                    regexp: {
                        regexp: /^[^\u4e00-\u9fa5]{0,}$/,
                        message: '不能输入中文'
                    }
                }
            }
            	            
        }
    });
	
    var dprtcode = $.trim($("#dprtcode").val());
    var jx=$("#engineeringFjjx").val();
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
	//初始化工作内容
	initFixedWorkContent();
	
	changeXXX();
	initChapter();
	fjzchOnchange();
	zxdxyz();
	//回显总计
	amount();
});


function fjzchOnchange(){
	$("[name='fjzch']").off("change");
	$("[name='fjzch']").on('change',function(){
		var bjh=$(this).parent().next().find('div input');
		var bjxlh=$(this).parent().next().next().find('div input');
		var bjName=$(this).parent().next().next().next().find('div input');
		bjh.val(""); 
		bjxlh.val(""); 
		bjName.val(""); 
	
});
}
function yanzhen(obj,status){
	if(status==2){
		//先把非数字的都替换掉，除了数字和.
		obj.value = obj.value.replace(/[^\d.]/g,"");
		//必须保证第一个为数字而不是.
		obj.value = obj.value.replace(/^\./g,"");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		
		strs=obj.value.split("."); //字符分割
		if(strs.length>1){
			if(strs[1]>99){
				obj.value=strs[0]+'.'+strs[1].substr(0, 2);
			}
		}
	}
	
    if(status==1){
    	
    	//先把非数字的都替换掉，除了数字
        obj.value = obj.value.replace(/[^\d.:]/g,"");
    	
    	if(obj.value.indexOf(".") != -1){
    		if(obj.value.indexOf(":") != -1){
    			obj.value = obj.value.substring(0,obj.value.length -1);
    		}else{
    			clearNoNumTwoDate(obj);
    		}
    	}
    	if(obj.value.indexOf(":") != -1){
    		if(obj.value.indexOf(".") != -1){
    			obj.value = obj.value.substring(0,obj.value.length -1);
    		}else{
    			clearNoNumTwoColon(obj);
    		}
    	}
    	
    	if(obj.value.length > 1 && obj.value.substring(0,1) == 0){
      		 if(obj.value.substring(1,2) != "." && obj.value.substring(1,2) != ":"){
      			obj.value = 0;
      		 }
      	 }
   
    }
}
function judge(obj,id,status){
	var $zxdx=$('#zxdx'+id);
	if($zxdx.val()=="FZJJ"){
		return
	}
	nox=id;
	var $wcrq=$('#wcrq'+id);
	$wcrq.removeAttr("disabled");
	$('#wcrq'+id).removeAttr("disabled","true");
	var wcrq=$wcrq.val();
	
	var $jssj=$('#jssj'+id);
	$jssj.removeAttr("disabled");
	var jssj=$('#jssj'+id).val();
	
	var $qlxh=$('#qlxh'+id);
	$qlxh.removeAttr("disabled");
	var qlxh=$('#qlxh'+id).val();
	
	var $jcsj=$('#jcsj'+id);
	$jcsj.removeAttr("disabled");
	var jcsj=$('#jcsj'+id).val();
	
	var $jcxh=$('#jcxh'+id);
	$jcxh.removeAttr("disabled");
	var jcxh=$('#jcxh'+id).val();
	
	var num=0;
	if(wcrq!=null && wcrq!=""){
		num++;
	}
	if(jssj!=null && jssj!=""){
		num++;
	}
	if(qlxh!=null && qlxh!=""){
		num++;
	}
	if(jcsj!=null && jcsj!=""){
		num++;
	}
	if(jcxh!=null && jcxh!=""){
		num++;
	}
	if(num>=3){
		if(wcrq == ""){
			$wcrq.attr("disabled","true");
			$wcrq.attr("disabled","true");
		}
		if(jssj == ""){
			$jssj.attr("disabled","true");
		}
		if(qlxh == ""){
			$qlxh.attr("disabled","true");
		}
		if(jcsj == ""){
			$jcsj.attr("disabled","true");
		}
		if(jcxh == ""){
			$jcxh.attr("disabled","true");
		}
	}
	
}
function changeDate(obj,id){
	var $zxdx=$('#zxdx'+id);
	if($zxdx.val()=="FZJJ"){
		return
	}
	
	var $jssj=$('#jssj'+id);
	var $qlxh=$('#qlxh'+id);
	var $jcsj=$('#jcsj'+id);
	var $jcxh=$('#jcxh'+id);
	var $wcrq=$('#wcrq'+id);
	
	var num=0;
    if($jssj.val()!=null && $jssj.val()!=""){
    	num++;
    }
    if($qlxh.val()!=null&& $qlxh.val()!=""){
    	num++;
    }
    if($jcsj.val()!=null && $jcsj.val()!=""){
    	num++;
    }
    if($jcxh.val()!=null && $jcxh.val()!=""){
    	num++;
    }
    if(num>2){
    	$wcrq.val("");
    	$wcrq.attr("disabled",true);
    }
}

//回车事件控制
document.onkeydown = function(event){
	e = event ? event :(window.event ? window.event : null); 
	judge(1,nox);
};
//只能输入数字和小数,保留两位,小数后不能超过59
function clearNoNumTwoDate(obj){
	 //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d.]/g,"");
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g,"");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g,".");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    
    var str = obj.value.split(".");
    if(str.length > 1){
   	 var value = obj.value;
   	 if(str[1].length == 2){
   		 if(str[1] > 59){
       		 value = str[0] +".59";
       	 }
   	 }
   	 if(str[1].length > 2){
   		 value = str[0] +"." + str[1].substring(0,2);
   	 }
   	 obj.value = value;
    }
}

//只能输入数字和冒号,保留两位,冒号后不能超过59
function clearNoNumTwoColon(obj){
	 //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d:]/g,"");
    //必须保证第一个为数字而不是:
    obj.value = obj.value.replace(/^\:/g,"");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\:{2,}/g,":");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(":","$#$").replace(/\:/g,"").replace("$#$",":");
    
    var str = obj.value.split(":");
    if(str.length > 1){
   	 var value = obj.value;
   	 if(str[1].length == 2){
   		 if(str[1] > 59){
       		 value = str[0] +":59";
       	 }
   	 }
   	 if(str[1].length > 2){
   		 value = str[0] +":" + str[1].substring(0,2);
   	 }
   	 obj.value = value;
    }
}
function initFixedWorkContent(){
	AjaxUtil.ajax({
		async: false,
		url:basePath+"/project/engineering/queryListBymainid",
		type:"post",
		data:{mainid:$("#engineeringId").val()},
		dataType:"json",
		success:function(data){
			 initTableCol(data);
		}
	});
}
//初始化表格
function initTableCol(data){
	//$.extend(true, oldzxdxList, data);
	$.each(data,function(i,workObj){
		oldzxdxList.push(workObj.id);
		 var fjzchOption="";
		 var bjhOption="";
		 var xlhOption="";
		 var zxflOption="";
		 var bjname="";
		 var wcrq="";
		 var jssj="";
		 var qlxh="";
		 var jcsj="";
		 var jcxh="";
		 
		 //回显执行分类
		 if(DicAndEnumUtil.data.dicMap!=undefined ){
			 var dicMap = DicAndEnumUtil.data.dicMap!=undefined?DicAndEnumUtil.data.dicMap:{};
			 var items = dicMap[3]!=undefined?dicMap[3]:[];
			 var len = items.length;
			// $('#rotatable tr:last td select:first').empty(); 
			// var zxdx=$('#rotatable tr:last td select:first');
			 for(var i=0;i<len;i++){
					 if(items[i].id==workObj.zxfl){
						 zxflOption+="<option value="+items[i].id+" selected='selected'>"+StringUtil.escapeStr(items[i].name)+"</option>";
					 }else{
						 zxflOption+="<option value="+items[i].id+" >"+StringUtil.escapeStr(items[i].name)+"</option>";
					 }
			 }
		 }
		if(workObj.zxfl !="FZJJ"){
			
			
			var jx=$('#jx').val();
			bjhOption="";
			xlhOption="";
			 //回显飞机注册号
			AjaxUtil.ajax({
					type : 'post',
					cache : false,
					url : basePath+"/project/workorder/getPlaneDatas",
					data: { 'fjjx':$('#jx').val(),'dprtcode':$('#engineeringDprtcode').val()},
					dataType : 'json',
					async:false,
					success : function(data) {
						for ( var i = 0; i < data.length; i++) {
							 if(data[i].fjzch==workObj.fjzch){
								 fjzchOption+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "' selected='selected' >"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
							 }else{
								 fjzchOption+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "'>"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
							 }
						}
						
						 fjzchOption= "<option value=''>please choose</option>"+fjzchOption;
					}
			}); 
			
		}
			if(workObj.jkzF!=null && workObj.jkzF!=""){
				if(workObj.jkxmbhF=="calendar"){
					wcrq=workObj.jkzF;
				}
				if(workObj.jkxmbhF=="fuselage_flight_time"){
					jssj=workObj.jkzF;
				}
				if(workObj.jkxmbhF=="landing_gear_cycle"){
					qlxh=workObj.jkzF;
				}
				if(workObj.jkxmbhF=="winch_time"){
					jcsj=workObj.jkzF;
				}
				if(workObj.jkxmbhF=="winch_cycle"){
					jcxh=workObj.jkzF;
				}
			}
				
			if(workObj.jkzS!=null && workObj.jkzS!=""){
				if(workObj.jkxmbhS=="calendar"){
					wcrq=workObj.jkzS;
				}
				if(workObj.jkxmbhS=="fuselage_flight_time"){
					jssj=workObj.jkzS;
				}
				if(workObj.jkxmbhS=="landing_gear_cycle"){
					qlxh=workObj.jkzS;
				}
				if(workObj.jkxmbhS=="winch_time"){
					jcsj=workObj.jkzS;
				}
				if(workObj.jkxmbhS=="winch_cycle"){
					jcxh=workObj.jkzS;
				}
				
				
			}
			if(workObj.jkzT!=null && workObj.jkzT!=""){
				if(workObj.jkxmbhT=="calendar"){
					wcrq=workObj.jkzT;
				}
				if(workObj.jkxmbhT=="fuselage_flight_time"){
					jssj=workObj.jkzT;
				}
				if(workObj.jkxmbhT=="landing_gear_cycle"){
					qlxh=workObj.jkzT;
				}
				if(workObj.jkxmbhT=="winch_time"){
					jcsj=workObj.jkzT;
				}
				if(workObj.jkxmbhT=="winch_cycle"){
					jcxh=workObj.jkzT;
				}
			}
		 
	 workObj.zxflOption = zxflOption;
	 workObj.fjzchOption = fjzchOption;
	 workObj.bjname = bjname;
	 workObj.wcrq=wcrq;
	 workObj.jssj=jssj;
	 workObj.qlxh=qlxh;
	 workObj.jcsj=jcsj;
	 workObj.jcxh=jcxh;
	 //alert(JSON.stringify(workObj));
	 addRow(workObj);
	});
	zxdxyz();
}
//向table新增一行
function addRotatableCol(){
	
	//先移除暂无数据一行
	var len = $("#rotatable").length;
	if (len == 1) {
		if($("#rotatable").find("td").length == 1){
			$("#rotatable").empty();
		};
	}
	
	//角色，下拉框数据集
	var roleOptionzt ="";
	    roleOptionzt ="<option value=''>please choose</option><option value='1'>有效</option><option value='0'>无效</option>";
	var sj="";
		sj="data-date-format='yyyy-mm-dd'";
	var obj = {};
	obj.sj=sj;
	obj.id = "";
	obj.technicalfileId = "";
	obj.nbxh = "";
	obj.zjh = "";
	obj.wz = "";
	obj.scms = "";
	obj.cksc = "";
	obj.ckgk = "";
	obj.isBj = 0;
	obj.isMi = 0;
	obj.bz  = "";
	obj.ztOptionzt  = roleOptionzt;
	obj.bjname = "";
	obj.wcrq="";
	obj.jssj="";
	obj.qlxh="";
	obj.jcsj="";
	obj.jcxh="";
	obj.id="1";
	obj.zxfl="";
	addRow(obj);
/*	if(DicAndEnumUtil.data.dicMap!=undefined ){
		 
		 var dicMap = DicAndEnumUtil.data.dicMap!=undefined?DicAndEnumUtil.data.dicMap:{};
		 var items = dicMap[3]!=undefined?dicMap[3]:[];
		 var len = items.length;
		
		 var zxdx=$('#zxdxList tr:last td select:first');
		 var appd="";
		 for(var i=0;i<len;i++){
				 appd+="<option value="+items[i].id+" >"+StringUtil.escapeStr(items[i].name)+"</option>";
		 }
		 zxdx.append("<option value=''>please choose</option>"+appd);
	 }*/
	changeXXX();
}


var workId=1;
//向table新增一行
function addRow(obj){
		no1++;
	var no=no1;
	
	var tr = "";
	if(obj.technicalfileId!="" && obj.technicalfileId!=null){
		tr += "<tr id='"+obj.technicalfileId+"'>";
	}else{
		tr += "<tr>";
	}
		tr += "<td>";
		tr += "<button class='line6' onclick='removeCol(this)'><i class='icon-minus cursor-pointer color-blue cursor-pointer'></i></button>";
		tr += "</td>";
		
		tr += "<td><input id='noum' name='noum' value='"+no+"' type='hidden'/>";
		tr += "<input id='syxid' name='syxid' value='"+obj.id+"' type='hidden'/>";
		tr += "<div name='workId'>"+workId+"</div></td>";
		
		tr += "<td>";
		tr += "		<select class='form-control'  name='zxdx'  id='zxdx"+no+"' onchange='updatezxdx("+no+")' >";
		tr +="<option value='' >please choose</option>";
		if(obj.zxfl=="FJ"){
			tr +="<option value='FJ' selected='selected' >机身</option>";
		}else{
			tr +="<option value='FJ'>机身</option>";
		}
		if(obj.zxfl=="ZJJ"){
			tr +="<option value='ZJJ' selected='selected' >飞机部件</option>";
		}else{
			tr +="<option value='ZJJ' >飞机部件</option>";
		}
		if(obj.zxfl=="FZJJ"){
			tr +="<option value='FZJJ' selected='selected' >非装机件</option>";
		}else{
			tr +="<option value='FZJJ' >非装机件</option>";
		}
		
		
		tr += "		</select>";
		tr += "</td>";
		
		if(obj.zxfl=="FZJJ"){
			tr += "<td>";
			tr += "		<select class='form-control' name='fjzch'  disabled='disabled' >";
			tr += obj.fjzchOption;
			tr += "		</select>";
			tr += "</td>";
			
		}else{
			tr += "<td>";
			tr += "		<select class='form-control' name='fjzch' >";
			tr += obj.fjzchOption;
			tr += "		</select>";
			tr += "</td>";
		}
		
		tr += "<td>";
		tr += "	<div class='input-group'> ";
		tr +="<span class='input-group-btn'><button class='btn btn-primary' onclick='chooseFl(this)'><i class='icon-search' ></i></button></span>";
		tr += "		<input class='form-control' name='zt' readonly='readonly' onmouseover='this.title=this.value' value='"+StringUtil.escapeStr(formatUndefine(obj.bjms))+"'>";
		tr += "	</div>";
		tr += "</td>";
	
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "<input readonly='readonly' type='text' class='form-control'  onmouseover='this.title=this.value' id='bjh' name='bjh' style='width:150px;' value='"+StringUtil.escapeStr(formatUndefine(obj.bjh))+"'>"
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "<input readonly='readonly' type='text' class='form-control'  onmouseover='this.title=this.value' id='bjxlh' name='bjxlh' style='width:150px;' value='"+StringUtil.escapeStr(formatUndefine(obj.bjxlh))+"'>"
		tr += "<input type='hidden' class='form-control'  id='zjqdid' name='zjqdid' value="+formatUndefine(obj.zjqdid)+">"
		tr += "	</div>";
		tr += "</td>";
			
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "		<input type='text'  class='form-control datepicker' name='wcrq"+no+"' id='wcrq"+no+"' data-date-format='yyyy-mm-dd' placeholder='please choose Date'  maxlength='10'  onchange='changeDate(1,"+no+")' onmouseout='judge(this,"+no+")' onkeyup='yanzhen(this,0)' value="+obj.wcrq+" >";
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "		<input class='form-control date-picker'  name='jssj"+no+"' id='jssj"+no+"' maxlength='20' onmouseout='judge(this,"+no+")' onkeyup='yanzhen(this,1)' value="+obj.jssj+"  >";
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "		<input class='form-control date-picker' name='qlxh"+no+"' id='qlxh"+no+"' maxlength='20' onmouseout='judge(this,"+no+")' onkeyup='yanzhen(this,2)' value="+obj.qlxh+"  >";
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "		<input class='form-control date-picker' name='jcsj"+no+"' id='jcsj"+no+"' maxlength='20' onmouseout='judge(this,"+no+")' onkeyup='yanzhen(this,1)' value="+obj.jcsj+"  >";
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	<div class='col-xs-12 padding-left-8 padding-right-0'>";
		tr += "		<input class='form-control date-picker' name='jcxh"+no+"' id='jcxh"+no+"' maxlength='20' onmouseout='judge(this,"+no+")'  onkeyup='yanzhen(this,2)' value="+obj.jcxh+"  >";
		tr += "	</div>";
		tr += "</td>";
		
		tr += "<td>";
		tr += "	 <div class='col-xs-3 padding-left-8 padding-right-0' >";
		tr += "<input maxlength='5'  type='text' class='form-control'  id='jhgsRs"+no+"' name='jhgsRs"+no+"' onkeyup='clearNoNum1(this,"+no+")' value="+formatUndefine(obj.jhgsRs)+" >"
		tr += "	</div>";
		tr += " <div class='pull-left padding-left-0 padding-right-0' style='padding:6px 0; height:34px; line-height:24px;' value=obj.jhgsRs> 人x</div>";
		tr += "<div class='col-xs-3 padding-left-8 padding-right-0' >";
		tr += "<input maxlength='5'  type='text' class='form-control' id='jhgsXss"+no+"' name='jhgsXss"+no+"' onkeyup='clearNoNum(this,"+no+")' value="+formatUndefine(obj.jhgsXss)+" >";
		tr += "</div> ";
		tr += "<div class='pull-left padding-left-0 padding-right-0' style='padding:6px 0; height:34px; line-height:24px;' value=obj.jhgsXss>时=</div>";
		tr += "<div class='col-xs-3 padding-left-8 padding-right-0' >";
		if(obj.jhgsXss!=null && obj.jhgsXss!=""){
			tr += "<input maxlength='5'  type='text' class='form-control '  id='time' name='time"+no+"' readOnly='true' value="+formatUndefine((obj.jhgsXss*obj.jhgsRs).toFixed(2))+">";
		}else{
			tr += "<input maxlength='5'  type='text' class='form-control '  id='time' name='time"+no+"' readOnly='true' >";
		}
		tr += "</div>";
		tr += "</td>";
		
		tr += "</tr>";
	
	$("#zxdxList").append(tr);
	judge(1,no);
	updatezxdx(no);
	$('.datepicker').datepicker({
		 autoclose: true,
		 clearBtn:true
	});
	
	workId++;
}
function chooseFl(e){
	tr=$(e).parent().parent().parent().parent();
var zxdx=tr.find('select[name=zxdx]').val();
var bjh=tr.find('input[name=bjh]');
var xlh=tr.find('input[name=bjxlh]');
 xlhValue=xlh.val();
if(zxdx=="FZJJ"){
	zxdxFjzch="";
	//非装机件方法的调用
	openZjj();
	
}else if(zxdx=="FJ"){
	AlertUtil.showErrorMessage("选择机身时，无需选择序列号");
}else if(zxdx=="ZJJ"){
	var fjzch=tr.find('select[name=fjzch]').val();
		zxdxFjzch=fjzch
	if(fjzch=="" || fjzch==null){
		AlertUtil.showErrorMessage("请先选择飞机注册号");
	}else{
		//装机件方法的调用
		openZjj();
	}
}else{
	AlertUtil.showErrorMessage("请先选择执行对象");
}
}
//装机件方法的调用
function openZjj(){
goPageBjh(1,"auto","desc");
$("#bjhModal").modal("show");
}
//跳转至指定页数:三个参数依次为:当前页码,排序字段,排序规则 
function goPageBjh(pageNumber,sortType,sequence){
AjaxGetDatasWithSearchBjh(pageNumber,sortType,sequence);
}
//带条件搜索的翻页
function AjaxGetDatasWithSearchBjh(pageNumber,sortType,sequence){
var obj={};
obj.dprtcode=$("#dprtcode").val();
obj.keyword=$.trim($("#keyword_search_alert").val());
obj.pagination = {page:pageNumber,sort:sortType,order:sequence,rows:10};
var fjzch=zxdxFjzch;
var url="";
if(fjzch!=null && fjzch!=""){
	url=basePath+"/project/workorder/getLoadingList";
	ord="jh"
	obj.fjzch=fjzch;
	obj.wz = $.trim($("#wz").val());
	searchBjh(obj,url,ord);
	$("#bjh_pagination").empty();
}else{
	url=basePath+"/project/workorder/getSpareStore";
	ord="bjh"
	searchBjh(obj,url,ord);
	$("#jh_pagination").empty();
}
}
function searchBjh(obj,url,ord){
startWait();
 AjaxUtil.ajax({
   url:url,
   type: "post",
   contentType:"application/json;charset=utf-8",
   dataType:"json",
   data:JSON.stringify(obj),
   success:function(data){
    finishWait();
	   if(data.total >0){
		   appendContentHtmlBjh(data.rows);
		   if(ord=="bjh"){
			   $("td[name='wzstyle']").each(function(){
				   $(this).css("display","none");
			   })
			   $("th[name='wzstyle']").eq(0).css("display","none");
			   $("#wzsele").css("display","none");
		   }else{
			   $("th[name='wzstyle']").eq(0).css("display","table-cell");
			   $("#wzsele").css("display","block");
		   }
		   new Pagination({
				renderTo : ord+"_pagination",
				data: data,
				sortColumn : ord,
				orderType : "desc",
				goPage:function(a,b,c){
					AjaxGetDatasWithSearchBjh(a,b,c);
				}
			});
			// 标记关键字
		   signByKeyword($("#keyword_search_alert").val(),[2,3,4,5,6,7,8],"#userlist tr td");
	   } else {
		  $("#userlist").empty();
		  $("#jh_pagination").empty();
		  $("#bjh_pagination").empty();
		   if(ord=="bjh"){
			   $("td[name='wzstyle']").each(function(){
				   $(this).css("display","none");
			   })
			   $("th[name='wzstyle']").eq(0).css("display","none");
			   $("#wzsele").css("display","none");
			   $("#userlist").append("<tr class='text-center'><td colspan=\"7\">暂无数据 No data.</td></tr>");
		    }else{
		    	$("th[name='wzstyle']").eq(0).css("display","table-cell");
				$("#wzsele").css("display","block");
		    	$("#userlist").append("<tr class='text-center'><td colspan=\"8\">暂无数据 No data.</td></tr>");
		    }
	   }
    },	   
});	
}

function appendContentHtmlBjh(list){
   var htmlContent = '';
   var sn=xlhValue;
   $.each(list,function(index,row){
	   if (index % 2 == 0) {
		   htmlContent = htmlContent + "<tr style=\"cursor:pointer\"  bgcolor=\"#f9f9f9\" onclick='chooesRow4(this)' >";
	   } else {
		   htmlContent = htmlContent + "<tr  style=\"cursor:pointer\" bgcolor=\"#fefefe\" onclick='chooesRow4(this)'>";
	   }
	   if(sn==row.xlh){
		   htmlContent = htmlContent + "<td class='text-center'><input type=\"radio\" name='pgd' checked='checked' onclick='chooesRow5(this)' ><input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.jh))+"'>" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.xlh))+"'>" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.zwmc))+"'>" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.ywmc))+"'>" +
		   "<input type='hidden' value='"+formatUndefine(row.id)+"'></td>";
	   }else{
		   htmlContent = htmlContent + "<td class='text-center'><input type=\"radio\" name='pgd'  onclick='chooesRow5(this)' ><input type='hidden' value="+StringUtil.escapeStr(formatUndefine(row.jh))+">" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.xlh))+"'>" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.zwmc))+"'>" +
		   "<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.ywmc))+"'>" +
		   "<input type='hidden' value='"+formatUndefine(row.id)+"'></td>";
	   }
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.zjhms)+"'>"+StringUtil.escapeStr(row.zjhms)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.jh)+"'>"+StringUtil.escapeStr(row.jh)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.xlh)+"'>"+StringUtil.escapeStr(row.xlh)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.zwmc)+"'>"+StringUtil.escapeStr(row.zwmc)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.ywmc)+"'>"+StringUtil.escapeStr(row.ywmc)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(row.cjjh)+"'>"+StringUtil.escapeStr(row.cjjh)+"</td>";  
		htmlContent = htmlContent + "<td name='wzstyle' class='text-left' title='"+DicAndEnumUtil.getEnumName('partsPositionEnum',row.wz)+"'>"+DicAndEnumUtil.getEnumName('partsPositionEnum',row.wz)+"</td>";
		htmlContent = htmlContent + "</tr>";   
	    
   });
   $("#userlist").html(htmlContent);
 
}
//保存部件号和序列号
function getBjhAndXlh(){
$('input[name=pgd]:checked').each(function(){   
	var jh=$(this).next().val();
	var xlh=$(this).next().next().val();
	var zwmc=$(this).next().next().next().val();
	var ywmc=$(this).next().next().next().next().val();
	var id=$(this).next().next().next().next().next().val();
	
	tr.find('input[name=bjh]').val(jh);
	tr.find('input[name=bjxlh]').val(xlh);
	tr.find('input[name=zt]').val(ywmc+" "+zwmc);
	var zxdx=tr.find('select[name=zxdx]').val();
	if(zxdx=="ZJJ"){
		tr.find('input[name=zjqdid]').val(id);
	}else{
		tr.find('input[name=zjqdid]').val("");
	}
	//$("#zjqdid").val(id);
});
}
//按钮选择
function chooesRow5(obj){
	if(obj.type=='radio'){
		var flag = $(obj).is(":checked");
		if(!flag){
			$(obj).attr("checked",true);
		}
	}else{
		var flag = $(obj).is(":checked");
		if(flag){
			$(obj).removeAttr("checked");
		}else{
			$(obj).attr("checked",true);
		}
	}
}
//单选行选
function chooesRow4(objradio){
	var obj = $(objradio).find("input[type='radio']");
	var flag = obj.is(":checked");
	if(!flag){
		obj.attr("checked",true);
	}
}




function changeXXX(){
	//$(this).parent().parent().next().find('div select').attr('name')
	$("[name='zxdx']").off("change");
	$("[name='zxdx']").on('change',function(){
		var apps="";
		var no5=0
		if($('#jx').val()=="" || $('#jx').val()==null){
			 AlertUtil.showErrorMessage("请先选择机型");
			 $(this).val("");
			 return
		}
		var bjh=$(this).parent().next().next().find('div input');
		var bjxlh=$(this).parent().next().next().next().find('div input');
		var bjName=$(this).parent().next().next().next().next().find('div input');
		bjh.val("");
		bjxlh.val("");
		bjName.val("");
		
		zxdxyz();	
		var fjzch=$(this).parent().next().find('select');
		var fjzchValue = fjzch.val();
	if($(this).val()=="ZJJ"){
		
		/*if($('#jx').val()==null ||$('#jx').val()==""){
			AlertUtil.showErrorMessage("请先选择机型");
			$(this).val()=="";
			return;
		}*/
		
			AjaxUtil.ajax({
				type : 'post',
				cache : false,
				url : basePath+"/project/workorder/getPlaneDatas",
				dataType : 'json',
				data: { 'fjjx':$('#jx').val(),'dprtcode':$('#engineeringDprtcode').val()},
				success : function(data) {
					fjzch.attr("disabled",false);
					fjzch.empty(); 
					for ( var i = 0; i < data.length; i++) {
						
						apps+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "'>"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
					}
					
					fjzch.append("<option value=''>please choose</option>"+apps);//
					fjzch.val(fjzchValue);
					$("[name='fjzch']").off("change");
					$("[name='fjzch']").on('change',function(){
						var bjh=$(this).parent().next().find('div input');
						var bjxlh=$(this).parent().next().next().find('div input');
						var bjName=$(this).parent().next().next().next().find('div input');
						bjh.val(""); 
						bjxlh.val(""); 
						bjName.val(""); 
						
					});
				}
			});
			zxdxyz();
	}else if($(this).val()=="FJ"){
		
			var bjh=$(this).parent().next().next().find('div input');
			var bjxlh=$(this).parent().next().next().next().find('div input');
			var bjm=$(this).parent().next().next().next().next().find('div input');
			bjh.val("");
			bjxlh.val("");
			bjm.val("");
			AjaxUtil.ajax({
				type : 'post',
				cache : false,
				url : basePath+"/project/workorder/getPlaneDatas",
				data: { 'fjjx':$('#jx').val(),'dprtcode':$('#engineeringDprtcode').val()},
				dataType : 'json',
				success : function(data) {
					fjzch.empty(); 
					fjzch.attr("disabled",false);
					for ( var i = 0; i < data.length; i++) {
						apps+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "'>"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
					}
					fjzch.append("<option value=''>please choose</option>"+apps);
					fjzch.val(fjzchValue);
				}
			});
			zxdxyz();
	}else if($(this).val()=="FZJJ"){
		fjzch.empty(); 
		fjzch.attr({"disabled":"disabled"});
		zxdxyz();
	}

	});
	
	
	zxdxyz();
}




//移除一行
function removeCol(obj){
	$(obj).parent().parent().remove();
	workId--;
	var len = $("#zxdxList").find("tr").length;
	$("#zxdxList", $("#addtr")).find("tr").each(function(index){
		$(this).find("div[name='workId']").html(index+1);
	});
	if(len < 1){
		addRotatableCol();
	}
	zxdxyz();
	amount();
}

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
	obj.isGczl=1;	//技术通告复选为1
	obj.jx=$('#jx').val();//机型
	obj.dprtcode=$("#dprtcode").val();
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
				// 标记关键字
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
	chooesRowPGD($(obj));
}

function chooesRow1(objradio){
	var obj = $(objradio).find("input[type='checkbox']");
	chooesRowPGD(obj);
}

//行选
function chooesRowPGD(obj){
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
		      
		   htmlContent = htmlContent + "<td><input type=\"checkbox\" name='pgd1' onclick='chooesRow2(this)' ><input type='hidden' value="+formatUndefine(row.id)+">" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.pgdh))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.wjzt))+"'>" +
																		   		"<input type='hidden' value='"+StringUtil.escapeStr(formatUndefine(row.ly))+"'>" +
																		   		"<input type='hidden' value='"+formatUndefine(row.sxrq)+"'>" +
																		   		"<input type='hidden' value='"+formatUndefine(row.pgqx)+"'>" +
																		   		"<input type='hidden' value="+formatUndefine(row.zt)+">"+
																					"<input type='hidden' value="+StringUtil.escapeStr(row.pgr_user.username)+">"+
																					"<input type='hidden' value="+StringUtil.escapeStr(row.pgr_user.realname)+"></td>";
								htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"'>"+StringUtil.escapeStr(formatUndefine(row.shzltgh))+"</td>";  
								htmlContent = htmlContent + "<td class='text-center'>"+StringUtil.escapeStr(formatUndefine(row.pgdh))+"</td>";  
								htmlContent = htmlContent + "<td class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.ly))+"</td>";  
								htmlContent = htmlContent + "<td class='text-left' title='"+StringUtil.escapeStr(formatUndefine(row.jx))+"'>"+StringUtil.escapeStr(formatUndefine(row.jx))+"</td>";  
								htmlContent = htmlContent + "<td class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.fl))+"</td>";  
								htmlContent = htmlContent + "<td class='text-right'>"+StringUtil.escapeStr(formatUndefine(row.bb))+"</td>";  
								htmlContent = htmlContent + "<td title='"+StringUtil.escapeStr(formatUndefine(row.wjzt))+"' class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.wjzt))+"</td>";  
								htmlContent = htmlContent + "<td class='text-center'>"+(formatUndefine(row.sxrq).substring(0,10))+"</td>"; 
								htmlContent = htmlContent + "<td class='text-left'>"+StringUtil.escapeStr(formatUndefine(row.pgr_user.displayName))+"</td>";  
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
	$('input[name=pgd1]:checked').each(function(){   
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
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'><input type='hidden' name='PgdIdAndPgdh' value="+pgdId+","+pgdh+"><input type='hidden' name='Ckzl' value='"+ckzl+"'><a href=\"javascript:viewMainTechnicalfile('"+pgdId+"','"+dprtcode+"')\">"+StringUtil.escapeStr(pgdh)+"</a></td>";
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(ly)+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle' title='"+StringUtil.escapeStr(ckzl)+"'>"+StringUtil.escapeStr(ckzl)+"</td>";  
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'>"+(sxrq.substring(0,10))+"</td>";
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(username)+" "+StringUtil.escapeStr(realname)+"</td>";
		htmlContent = htmlContent + "<td class='text-center' style='vertical-align:middle'>"+(pgqx.substring(0,10))+"</td>";  
		htmlContent = htmlContent + "<td class='text-left' style='vertical-align:middle'>"+zts[pgzt]+"</td>";
		htmlContent = htmlContent + "</tr>";
		pgdids.push(pgdId);
		
		if($('#zhut').val()=="" || $('#zhut').val()==null){
			$('#zhut').val(wjzt);
			
			$('#zhut').change();
		}
		  });
		//$("#Annunciatelist").empty();
	    $("#Annunciatelist").append(htmlContent);
	    if($("#Annunciatelist tr").length>0){
	    	$('#jx').attr("disabled",true);
	    }
}

//删除行
function lineRemove(pgdid){
	$('#tr1_'+pgdid).remove();
	pgdids.remove(pgdid);
	zxdxyz();
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
//提交
function submit(){
	startWait();
	/*var len = $("#Annunciatelist").find("tr").length;
	if(len<=0){
		AlertUtil.showErrorMessage("请先选择评估单");
		return false;
	}*/
	$('#form').data('bootstrapValidator').validate();
	  if(!$('#form').data('bootstrapValidator').isValid()){
		  AlertUtil.showErrorMessage("请根据提示输入正确的信息");
		  finishWait();
		return false;
	  }
	//获取执行对象
	var zxddList=zxdxList();
	var isZlphyx=$("input:radio[name='isZlphyx']:checked").val(); 
	var isCfzxsx=$("input:radio[name='isCfzxsx']:checked").val(); 
	var isYxfjdqfzsj=$("input:radio[name='isYxfjdqfzsj']:checked").val(); 
	var isYxcbw=$("input:radio[name='isYxcbw']:checked").val(); 
	var isSp=$("input:radio[name='isSp']:checked").val(); 
	var isXytsqc=$("input:radio[name='isXytsqc']:checked").val(); 
	var isXytsgjsb=$("input:radio[name='isXytsgjsb']:checked").val(); 
	var isXybfqcbhtzd=$("input:radio[name='isXybfqcbhtzd']:checked").val(); 
	obj = {
			id: $('#engineeringId').val(),
			gczlbh: $('#engineeringGczlbh').val(),
			fjjx:$.trim( $('#jx').val()),
			zjh:$.trim( $('#zjh').val()),
			eolx:getEolx(),
			cj:$.trim( $('#cj').val()),
			zhut:$.trim( $('#zhut').val()),
			xggzh:$.trim( $('#xggzh').val()),
			bb:$.trim( $('#bb').val()),
			txyj:$.trim( $('#txyj').val()),
			bbly:$.trim( $('#bbly').val()),
			
			isCfzxsx:$.trim(isCfzxsx),
			isZlphyx:$.trim(isZlphyx),
			isYxfjdqfzsj:$.trim(isYxfjdqfzsj),
			isYxcbw:$.trim(isYxcbw),
			isSp:$.trim(isSp),
			isXytsqc:$.trim(isXytsqc),
			isXytsgjsb:$.trim(isXytsgjsb),
			isXybfqcbhtzd:$.trim(isXybfqcbhtzd),
			
			syxcbw:$.trim( $('#syxcbw').val()),
			dprtcode:$.trim( $('#engineeringDprtcode').val()),
			tcsj:$.trim( $('#tcsj').val()),
			zt:1,
			detailEngineeringList:zxddList,
			ckzl:getShzlh(),
			orderSourceList:getPgdIdAndPgdh(),
			olddetailEngineeringListId:oldzxdxList
	};
	if(obj.detailEngineeringList.folg==false){
		AlertUtil.showErrorMessage(obj.detailEngineeringList.tc);
		finishWait();
		return ;
	}
	//alert(JSON.stringify(obj.olddetailEngineeringList));
	//对比是否有重复
	var fol=contrast(zxddList);
	if(fol){
		 AlertUtil.showConfirmMessage("飞机注册号或件号,序列号存在重复数据,是否继续", {callback: function(){
			 submitHT(obj);
		 }});
		 
	}else{
		submitHT(obj);
	}

	
}

function submitHT(obj){
	AjaxUtil.ajax({
		url:basePath+"/project/engineering/updateMainEngineeringBc",
		type: "post",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(obj),
		dataType:"json",
		success:function(data){
				AlertUtil.showMessage('提交成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
				finishWait();
		}
	});
}



//保存
function save(){
	startWait();
	/*var len = $("#Annunciatelist").find("tr").length;
	if(len<=0){
		AlertUtil.showErrorMessage("请先选择评估单");
		return false;
	}*/
	$('#form').data('bootstrapValidator').validate();
	  if(!$('#form').data('bootstrapValidator').isValid()){
		  AlertUtil.showErrorMessage("请根据提示输入正确的信息");
		  finishWait();
		return false;
	  }
	//获取执行对象
	var zxddList=zxdxList();
	var isZlphyx=$("input:radio[name='isZlphyx']:checked").val(); 
	var isCfzxsx=$("input:radio[name='isCfzxsx']:checked").val(); 
	var isYxfjdqfzsj=$("input:radio[name='isYxfjdqfzsj']:checked").val(); 
	var isYxcbw=$("input:radio[name='isYxcbw']:checked").val(); 
	var isSp=$("input:radio[name='isSp']:checked").val(); 
	var isXytsqc=$("input:radio[name='isXytsqc']:checked").val(); 
	var isXytsgjsb=$("input:radio[name='isXytsgjsb']:checked").val(); 
	var isXybfqcbhtzd=$("input:radio[name='isXybfqcbhtzd']:checked").val(); 
	
	obj = {
			id: $('#engineeringId').val(),
			gczlbh: $('#engineeringGczlbh').val(),
			fjjx:$.trim( $('#jx').val()),
			zjh:$.trim( $('#zjh').val()),
			eolx:getEolx(),
			cj:$.trim( $('#cj').val()),
			zhut:$.trim( $('#zhut').val()),
			xggzh:$.trim( $('#xggzh').val()),
			bb:$.trim( $('#bb').val()),
			txyj:$.trim( $('#txyj').val()),
			bbly:$.trim( $('#bbly').val()),
			
			isCfzxsx:$.trim(isCfzxsx),
			isZlphyx:$.trim(isZlphyx),
			isYxfjdqfzsj:$.trim(isYxfjdqfzsj),
			isYxcbw:$.trim(isYxcbw),
			isSp:$.trim(isSp),
			isXytsqc:$.trim(isXytsqc),
			isXytsgjsb:$.trim(isXytsgjsb),
			isXybfqcbhtzd:$.trim(isXybfqcbhtzd),
			
			syxcbw:$.trim( $('#syxcbw').val()),
			tcsj:$.trim( $('#tcsj').val()),
			dprtcode:$.trim( $('#engineeringDprtcode').val()),
			zt:0,
			detailEngineeringList:zxddList,
			ckzl:getShzlh(),
			orderSourceList:getPgdIdAndPgdh(),
			olddetailEngineeringListId:oldzxdxList
			
	};
	
	if(obj.detailEngineeringList.folg==false){
		AlertUtil.showErrorMessage(obj.detailEngineeringList.tc);
		finishWait();
		return ;
	}
	//alert(obj.detailEngineeringList);
	
	//对比是否有重复
	var fol=contrast(zxddList);
	if(fol){
		 AlertUtil.showConfirmMessage("飞机注册号或件号,序列号存在重复数据,是否继续", {callback: function(){
			 saveHT(obj);
		 }});
		 
	}else{
		saveHT(obj);
	}
	
}

function saveHT(obj){
	AjaxUtil.ajax({
		url:basePath+"/project/engineering/updateMainEngineeringBc",
		type: "post",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(obj),
		dataType:"json",
		success:function(data){
				AlertUtil.showMessage('保存成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
				finishWait();
		}
	});
}
//获取选择后的所有评估单id
function getPgdIdAndPgdh(){
	var orderSourceList=[];
	$("#Annunciatelist").find("tr input[name='PgdIdAndPgdh']").each(function(){
		var value=$(this).val();
		var pgdid=value.split(",")[0];
		var pgdh=value.split(",")[1];
		 var ordersour={};
		ordersour.pgdid=pgdid;
		ordersour.pgdh=pgdh;
		orderSourceList.push(ordersour);
	});
	return orderSourceList;
}
//获取所有的适航指令号并拼接
function getShzlh(){
	var ckzl="";
	$("#Annunciatelist").find("tr input[name='Ckzl']").each(function(){
		//alert($(this).val());
		//alert(1);
		ckzl+=$(this).val()+",";
	});
	//alert(ckzl);
	ckzl=ckzl.substring(0,ckzl.length-1);
	//alert(ckzl);
	
	return ckzl;
}

//执行对象
function zxdxList(){
	var zxdxx=[];
	zxdxx.folg=true;
	zxdxx.tc="";
	$("#zxdxList").find("tr").each(function(){
		var zxdx ={};
		var index=$(this).index(); //当前行
		var zxfl =$("select[name='zxdx']").eq(index).val(); //执行对象
		var id =$("input[name='syxid']").eq(index).val(); //当前行，隐藏id的值
		var fjzch =$("select[name='fjzch']").eq(index).val(); //飞机注册号
		var bjh =$("input[name='bjh']").eq(index).val(); //部件号
		var bjxlh =$("input[name='bjxlh']").eq(index).val(); //序列号
		var zjqdid =$("input[name='zjqdid']").eq(index).val(); //装机清单id
		var xh=$("input[name='noum']").eq(index).val();//当行序号
		zxdx.bjxlh  = bjxlh;
		zxdx.zjqdid=zjqdid;
		zxdx.id=id;
		zxdx.zxfl=zxfl;
		zxdx.fjzch=fjzch;
		zxdx.bjh=bjh;
		//zxdx.bjxlh=bjxlh;
		zxdx.xh=xh;
		jhgsRs=$("#jhgsRs"+xh).val();
		jhgsXss=$("#jhgsXss"+xh).val();
		zxdx.jhgsRs=jhgsRs;//计划工时 人数
		zxdx.jhgsXss=jhgsXss;//计划工时 小时数
		var wcrq =$("#wcrq"+xh).val(); //完成日期
		var jssj  =$("#jssj"+xh).val(); //机身时间
		var qlxh =$("#qlxh"+xh).val(); //起落循环 
		var jcsj =$("#jcsj"+xh).val(); //绞车时间 
		var jcxh =$("#jcxh"+xh).val(); //绞车循环 
		
		if(zxfl==null || zxfl==""){
			zxdxx.tc="请选择执行分类";
			zxdxx.folg=false;
			return false;
		}
		if(zxfl=="ZJJ"){
			//var syxid =$("input[name='syxid']").eq(index).val(); //当前行，隐藏id的值
			if(fjzch==null || fjzch==""){
				zxdxx.tc="请选择飞机注册号";
				zxdxx.folg=false;
				return false;
			}else{
				if(bjh==null || bjh==""){
					zxdxx.tc="请选择部件";
					zxdxx.folg=false;
					return false;
				}else{
					if(bjxlh==null || bjxlh==""){
						zxdxx.tc="请选择部件序列号";
						zxdxx.folg=false;
						return false;
					}
				}
			}
			
		}
		if(zxfl=="FJ"){
			//var syxid =$("input[name='syxid']").eq(index).val(); //当前行，隐藏id的值
			if(fjzch==null || fjzch==""){
				zxdxx.tc="请选择飞机注册号";
				zxdxx.folg=false;
				return false;
				}
		}
		if(zxfl=="FZJJ"){
			if(bjh==null || bjh==""){
				zxdxx.tc="请选择部件";
				zxdxx.folg=false;
				return false;
			}else{
				if(bjxlh==null || bjxlh==""){
					zxdxx.tc="请选择部件序列号";
					zxdxx.folg=false;
					return false;
				}
			}
		}
		if(isNaN(jhgsRs)){
			zxdxx.tc="计划工时只能输入数字";
			zxdxx.folg=false;
			return false;
		}
		if(isNaN(jhgsXss)){
			zxdxx.tc="计划工时只能输入数字";
			zxdxx.folg=false;
			return false;
		}
		var str=[wcrq,jssj,qlxh,jcsj,jcxh];
		//alert(str.length);
		var stx=[];
		for(var i=0;i<str.length;i++){
			if(str[i]!=null && str[i]!=""){
				stx.push(str[i]);
			}
		}
		if(zxfl=="FZJJ"){
			if(wcrq==null || wcrq=="" || stx.length>1 ){
				zxdxx.tc="执行对象选择非装机件时，监控项只能输入完成日期";
				zxdxx.folg=false;
			}
		}
		//alert(stx);
		if(stx.length<=0){
			zxdxx.tc="至少输入一项计划完成时限";
			zxdxx.folg=false;
		}else if(stx.length>3){
			zxdxx.tc="最多只能输入三项计划完成时限";
			zxdxx.folg=false;
		}
		for(var i=1;i<=stx.length;i++){
			if(1==i){
				if(wcrq!=null && wcrq!=""){
					zxdx.jkflbhF="calendar";
					zxdx.jkxmbhF="calendar";
					zxdx.jkzF=wcrq;
					wcrq="";
					continue;
				}
				if(jssj!=null && jssj!=""){
					zxdx.jkflbhF="flight_time";
					zxdx.jkxmbhF="fuselage_flight_time";
					zxdx.jkzF=jssj;
					jssj="";
					continue;
				}
				if(qlxh!=null && qlxh!=""){
					zxdx.jkflbhF="loop";
					zxdx.jkxmbhF="landing_gear_cycle";
					zxdx.jkzF=qlxh;
					qlxh="";
					continue;
				}
				if(jcsj!=null && jcsj!=""){
					zxdx.jkflbhF="flight_time";
					zxdx.jkxmbhF="winch_time";
					zxdx.jkzF=jcsj;
					jcsj="";
					continue;
				}
				if(jcxh!=null && jcxh!=""){
					zxdx.jkflbhF="loop";
					zxdx.jkxmbhF="winch_cycle";
					zxdx.jkzF=jcxh;
					jcxh="";
					continue;
				}
				
			}
			if(2==i){
				if(wcrq!=null && wcrq!=""){
					zxdx.jkflbhS="calendar";
					zxdx.jkxmbhS="calendar";
					zxdx.jkzS=wcrq;
					wcrq="";
					continue;
				}
				if(jssj!=null && jssj!=""){
					zxdx.jkflbhS="flight_time";
					zxdx.jkxmbhS="fuselage_flight_time";
					zxdx.jkzS=jssj;
					jssj="";
					continue;
				}
				if(qlxh!=null && qlxh!=""){
					zxdx.jkflbhS="loop";
					zxdx.jkxmbhS="landing_gear_cycle";
					zxdx.jkzS=qlxh;
					qlxh="";
					continue;
				}
				if(jcsj!=null && jcsj!=""){
					zxdx.jkflbhS="flight_time";
					zxdx.jkxmbhS="winch_time";
					zxdx.jkzS=jcsj;
					jcsj="";
					continue;
				}
				if(jcxh!=null && jcxh!=""){
					zxdx.jkflbhS="loop";
					zxdx.jkxmbhS="winch_cycle";
					zxdx.jkzS=jcxh;
					jcxh="";
					continue;
				}
				
			}
			if(3==i){
				if(wcrq!=null && wcrq!=""){
					zxdx.jkflbhT="calendar";
					zxdx.jkxmbhT="calendar";
					zxdx.jkzT=wcrq;
					wcrq="";
					continue;
				}
				if(jssj!=null && jssj!=""){
					zxdx.jkflbhT="flight_time";
					zxdx.jkxmbhT="fuselage_flight_time";
					zxdx.jkzT=jssj;
					jssj="";
					continue;
				}
				if(qlxh!=null && qlxh!=""){
					zxdx.jkflbhT="loop";
					zxdx.jkxmbhT="landing_gear_cycle";
					zxdx.jkzT=qlxh;
					qlxh="";
					continue;
				}
				if(jcsj!=null && jcsj!=""){
					zxdx.jkflbhT="flight_time";
					zxdx.jkxmbhT="winch_time";
					zxdx.jkzT=jcsj;
					jcsj="";
					continue;
				}
				if(jcxh!=null && jcxh!=""){
					zxdx.jkflbhT="loop";
					zxdx.jkxmbhT="winch_cycle";
					zxdx.jkzT=jcxh;
					jcxh="";
					continue;
				}
				
			}
		}
		//AlertUtil.showErrorMessage(JSON.stringify(zxdx));
		zxdxx.push(zxdx);
		//AlertUtil.showErrorMessage(JSON.stringify(zxdxx));
	});
	return zxdxx;
}
//加载已选择的关联评估单
function selectChoosePgd(){
	var id=$('#engineeringId').val();
	//alert(id);
	AjaxUtil.ajax({
		url:basePath + "/project/engineering/selectChoosePgd",
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
				"<input type='hidden' name='PgdIdAndPgdh' value="+data.id+","+StringUtil.escapeStr(data.pgdh)+"><input type='hidden' name='Ckzl' value='"+StringUtil.escapeStr(data.shzltgh)+"'>"+
				"<a href=\"javascript:viewMainTechnicalfile('"+data.id+"','"+data.dprtcode+"')\">"
				+data.pgdh+"</a></td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(data.ly)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle' title='"+data.shzltgh+"' >"+data.shzltgh+"</td>";
		htmlContent = htmlContent +"<td class='text-center' style='vertical-align:middle'>"+indexOfTime(data.sxrq)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+StringUtil.escapeStr(data.pgr_user.displayName)+"</td>";
		htmlContent = htmlContent +"<td class='text-center' style='vertical-align:middle'>"+indexOfTime(data.pgqx)+"</td>";
		htmlContent = htmlContent +"<td class='text-left' style='vertical-align:middle'>"+zts[data.zt]+"</td>";
		htmlContent = htmlContent + "</tr>";
	});
	
	$("#Annunciatelist").empty();
	$("#Annunciatelist").html(htmlContent);
}
//审核（同意）
function agreedMain(){
	obj={
			'id':$('#engineeringId').val(),
			'shyj':$('#shyj').val(),
			'zt':2
	}
	submitMainEngineering(obj);
}
//审核（驳回）
function rejectedMain(){
	obj={
			'id':$('#engineeringId').val(),
			'shyj':$('#shyj').val(),
			'zt':5
	}
	submitMainEngineering(obj);
}
//批准（同意）
function agreedMain1(){
	obj={
			'id':$('#engineeringId').val(),
			'pfyj':$('#pfyj').val(),
			'zt':3
	}
	submitMain(obj);
}
//批准（驳回）
function rejectedMain1(){
	obj={
			'id':$('#engineeringId').val(),
			'pfyj':$('#pfyj').val(),
			'zt':6
	}
	submitMain(obj);
}
//批准（中止）
function suspendMain(){
	obj={
			'id':$('#engineeringId').val(),
			'pfyj':$('#pfyj').val(),
			'zt':4
	}
	submitMain(obj);
}
//审核提交
function submitMainEngineering(obj){
	//alert(JSON.stringify(obj));
	// 提交数据
	AjaxUtil.ajax({
		url:basePath + "/project/engineering/submitshenheMainEngineering",
		type: "post",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(obj),
		dataType:"json",
		success:function(data){
			if(obj.zt==2){
				AlertUtil.showMessage('审核成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}else if(obj.zt==5){
				AlertUtil.showMessage('驳回成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}else{
				AlertUtil.showMessage('操作成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
				
			}
			
		}
	});

}
//提交
function submitMain(obj){
	obj.dprtcode=$("#engineeringDprtcode").val();
	//alert(JSON.stringify(obj));
	// 提交数据
	AjaxUtil.ajax({
		url:basePath + "/project/engineering/submitpifuMainEngineering",
		type: "post",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(obj),
		dataType:"json",
		success:function(data){
			if(obj.zt==3){
				AlertUtil.showMessage('批准成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}else if(obj.zt==6){
				AlertUtil.showMessage('驳回成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}else if(obj.zt==4){
				AlertUtil.showMessage('中止成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}else{
				AlertUtil.showMessage('操作成功!','/project/engineering/main?id='+data+'&pageParam='+pageParam);
			}
		}
	});

}
//初始化ATA章节号信息
function initChapter(){
 	var zjh = $.trim($("#zjh").val());
 	var dprtcode = $.trim($("#engineeringDprtcode").val());
 	AjaxUtil.ajax({
		async: false,
		url:basePath+"/project/fixchapter/getFixChapterByZjh",
		type:"post",
		data:{zjh:zjh,dprtcode:dprtcode},
		dataType:"json",
		success:function(data){
			if(null != data){
				$("#zjhName").val(formatUndefine(data.zjh)+" "+formatUndefine(data.zwms));
			}
		}
	});
}

//只能输入数字和小数
function clearNoNum(obj,no){
     //先把非数字的都替换掉，除了数字和.
     obj.value = obj.value.replace(/[^\d.]/g,"");
     //必须保证第一个为数字而不是.
     obj.value = obj.value.replace(/^\./g,"");
     //保证只有出现一个.而没有多个.
     obj.value = obj.value.replace(/\.{2,}/g,".");
     //保证.只出现一次，而不能出现两次以上
     obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
     
     sumTotal(no);
}
//只能输入数字和小数
function clearNoNum1(obj,no){
     //先把非数字的都替换掉，除了数字和.
     obj.value = obj.value.replace(/[^\d]/g,'');
     sumTotal(no);
}
function sumTotal(no){
	var jhgsRs = $("[name='jhgsRs"+no+"'] ").val();
	var jhgsXss = $("[name='jhgsXss"+no+"'] ").val();
	if((jhgsRs!=null ||jhgsRs!="")&&(jhgsXss!=null || jhgsXss!="")){
		$("[name='time"+no+"'] ").val((jhgsRs*jhgsXss).toFixed(2));
	}
	amount();
	
}
/*function intoGznrAndPgd(){
	no1=0;
	$('#zxdxList').empty();
	$('#Annunciatelist').empty();
	addRotatableCol();
}*/
function amount(){
	var zj=0;
	$('input[id=time]').each(function(){
		if($(this).val()==null || $(this).val()==""){
		}else{
			zj=zj+parseFloat($(this).val());
		}
	});
	$('#zj').val(zj.toFixed(2));
}
function getEolx(){
	var eolxList = $('#eolx').val();
	var eolx="";
	if(eolxList != null){
		for(var i = 0 ; i < eolxList.length ; i++){
			if('multiselect-all' != eolxList[i]){
				eolx=eolx+eolxList[i];
			}
		}
	}
	return eolx;
}
function viewMainTechnicalfile(id,dprtcode){
	window.open(basePath+"/project/technicalfile/findApprovalFileUpload/"+$.trim(id)+"/"+$.trim(dprtcode)+"");
}
//打开ATA章节号对话框
function openChapterWin(){
	var zjh = $.trim($("#zjh").val());
	var dprtcode = $.trim($("#dprtcode").val());
	FixChapterModal.show({
		selected:zjh,//原值，在弹窗中默认勾选
		dprtcode:dprtcode,
		callback: function(data){//回调函数
			var wczjh = '';
			var wczjhName = '';
			var dprtcode=dprtcode;
			if(data != null){
				wczjh = data.zjh;
				wczjhName = data.zwms;
				wczjhName = formatUndefine(wczjh) + " " + formatUndefine(wczjhName);
			}
			$("#zjh").val(formatUndefine(wczjh));
			$("#zjhName").val(formatUndefine(wczjhName));
		}
	})
}
function selectByEoid (id){
	 window.open(basePath+"/project/workorder/LookedWo?id=" + id+"&gddlx="+3);
}
function addEogd(gczlzxdxid,gczlid){
	window.open(basePath+"/project/workorder/intoEO?gczlid=" + gczlid+"&gczlzxdxid="+gczlzxdxid);
}
function vieworhideWorkContent(id) {
	var flag = $("#" + id).is(":hidden");
	if (flag) {
		$("#" + id).fadeIn(500);
		$("#" + id + 'icon').removeClass("icon-caret-down");
		$("#" + id + 'icon').addClass("icon-caret-up");
	} else {
		$("#" + id).hide();
		$("#" + id + 'icon').removeClass("icon-caret-up");
		$("#" + id + 'icon').addClass("icon-caret-down");
	}

}
function back(){
	window.location.href =basePath+"/project/engineering/main?pageParam="+pageParam;
}

//根据执行对象是否可以改变机型
function zxdxyz(){
	var flag = true;
	var len = $("#Annunciatelist").find("tr").length;
	$("#zxdxList").find("tr").each(function(){
		var index=$(this).index(); //当前行
		var zxdx =$("select[name='zxdx']").eq(index).val(); //当前行，隐藏id的值
		if(zxdx=="ZJJ" || zxdx=="FJ" || len > 0){
			$('#jx').attr("disabled",true);
			flag = false;
		}
		
	});
	if(flag){
		$('#jx').attr("disabled",false);
	}
}
function contrast(zxddList){
	var fol=false;
	var len=zxddList.length;
	for(var i=0;i<len;i++){
		for(var a=i+1;a<len;a++){
			if(zxddList[i].fjzch==zxddList[a].fjzch && zxddList[i].zxfl!="FZJJ"  && zxddList[a].zxfl!="FZJJ"){
				if(zxddList[i].zxfl==zxddList[a].zxfl ){
					if(zxddList[i].zxfl=="ZJJ"){
						if(zxddList[i].bjh==zxddList[a].bjh){
							if(zxddList[i].bjxlh==zxddList[a].bjxlh){
								fol=true;
							}
						}
					}else{
						fol=true;
					}
					
				}
			}
			if(zxddList[i].bjh==zxddList[a].bjh && zxddList[i].bjh!=null && zxddList[a].bjh!=null && zxddList[i].bjh!="" && zxddList[a].bjh!=""){
				if(zxddList[i].bjxlh==zxddList[a].bjxlh){
					fol=true;
				}
			}
		}
	}
	return fol;
}
//选择评估单
function searchRevision(){
	
	goPage(1,"auto","desc");
}
//执行对象的改变事件
function updatezxdx(id){
	var $zxdx=$('#zxdx'+id);
	if($zxdx.val()=="FZJJ"){
		var $jssj=$('#jssj'+id);
		var $qlxh=$('#qlxh'+id);
		var $jcsj=$('#jcsj'+id);
		var $jcxh=$('#jcxh'+id);
		var $wcrq=$('#wcrq'+id);
		
		$jssj.val("");
		$qlxh.val("");
		$jcsj.val("");
		$jcxh.val("");
		
		$jssj.attr("disabled","true");
		$qlxh.attr("disabled","true");
		$jcsj.attr("disabled","true");
		$jcxh.attr("disabled","true");
		$wcrq.removeAttr("disabled");
	}
}
function changeDate(obj,id){
	var $zxdx=$('#zxdx'+id);
	if($zxdx.val()=="FZJJ"){
		return
	}
	
	var $jssj=$('#jssj'+id);
	var $qlxh=$('#qlxh'+id);
	var $jcsj=$('#jcsj'+id);
	var $jcxh=$('#jcxh'+id);
	var $wcrq=$('#wcrq'+id);
	
	var num=0;
    if($jssj.val()!=null && $jssj.val()!=""){
    	num++;
    }
    if($qlxh.val()!=null&& $qlxh.val()!=""){
    	num++;
    }
    if($jcsj.val()!=null && $jcsj.val()!=""){
    	num++;
    }
    if($jcxh.val()!=null && $jcxh.val()!=""){
    	num++;
    }
    if(num>2){
    	$wcrq.val("");
    	$wcrq.attr("disabled",true);
    }
}
//复制评估单的执行对象
function copyTechncialfilezxdx(){
	var techncialfileIds=getpgdid();
	
	if(techncialfileIds.length<=0){
		AlertUtil.showErrorMessage("请先选择评估单");
		return;
	}
	
	AjaxUtil.ajax({
		url:basePath+"/project/technicalfile/queryListByTechnicalfileids",
		type:"post",
		data:{"techncialfileIds":techncialfileIds},
		dataType:"json",
		success:function(data){
			if(data.length>0){
				initTableColTechnicalfile(data);
			}else{
				AlertUtil.showErrorMessage("当前评估单没有可引用的执行对象");
			}
			
			
		}
	});
}
//获取选择后的所有评估单id
function getpgdid(){
	var techncialfileIds=[];
	$("#Annunciatelist").find("tr input[name='PgdIdAndPgdh']").each(function(){
		var value=$(this).val();
		var pgdid=value.split(",")[0];
		techncialfileIds.push(pgdid);
	});
	return techncialfileIds;
}
//初始化表格
function initTableColTechnicalfile(data){
	//查看是否有填写执行对象
	var len = $("#zxdxList").find("tr").length;
	if(len<=1 &&　$("select[name='zxdx']")[0].value==""){
		alert("s");
		no1=0;
		workId=1;
		$("#zxdxList").empty();
	}
	
	$.each(data,function(i,workObj){
		removeColTechnicalfileId(workObj.id);
		 var fjzchOption="";
		 var bjhOption="";
		 var xlhOption="";
		 var zxflOption="";
		 var bjname="";
		 var wcrq="";
		 var jssj="";
		 var qlxh="";
		 var jcsj="";
		 var jcxh="";
		if(workObj.zxfl !="FZJJ"){
			
			
			var jx=$('#jx').val();
			bjhOption="";
			xlhOption="";
			 //回显飞机注册号
			AjaxUtil.ajax({
					type : 'post',
					cache : false,
					url : basePath+"/project/workorder/getPlaneDatas",
					data: { 'fjjx':$('#jx').val(),'dprtcode':$('#jgdm').val()},
					dataType : 'json',
					async:false,
					success : function(data) {
						for ( var i = 0; i < data.length; i++) {
							 if(data[i].fjzch==workObj.fjzch){
								 fjzchOption+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "' selected='selected' >"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
							 }else{
								 fjzchOption+="<option value='" + StringUtil.escapeStr(data[i].fjzch) + "'>"+ StringUtil.escapeStr(data[i].fjzch) + "</option>";
							 }
						}
						
						fjzchOption= "<option value=''>please choose</option>"+fjzchOption;
					}
			}); 
			
		}
	 workObj.zxflOption = zxflOption;
	 workObj.fjzchOption = fjzchOption;
	 workObj.bjname = bjname;
	 workObj.wcrq="";
	 workObj.jssj="";
	 workObj.qlxh="";
	 workObj.jcsj="";
	 workObj.jcxh="";
	 workObj.technicalfileId=workObj.id;
	 workObj.id=1;
	 addRow(workObj);
	 changeXXX();
	});
	zxdxyz();
}
//当有该id时删除
function removeColTechnicalfileId(id){
	var $id=$("#"+id);
	if($id.length>0){
		$id.remove();
		workId--;
		var len = $("#zxdxList").find("tr").length;
		$("#zxdxList", $("#addtr")).find("tr").each(function(index){
			$(this).find("div[name='workId']").html(index+1);
		});
		zxdxyz();
		amount();
	}
}