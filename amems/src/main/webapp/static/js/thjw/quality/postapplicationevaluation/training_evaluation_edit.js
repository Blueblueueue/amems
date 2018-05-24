
training_evaluation_edit = {
	id:'training_evaluation_edit',
	tbodyId:'training_evaluation_edit_tbody',
	param: {
		id : '',
		gwid : '',
		dprtcode:userJgdm//默认登录人当前机构代码
	},
	isValid : true,//验证是否通过,isValid:true表示验证通过,isValid:false表示验证未通过
	init : function(param){
		if(param){
			$.extend(this.param, param);
		}
		this.initInfo();
	},
	initInfo : function(){
		var this_ = this;
		if(this.param.wxrydaid && this.param.id && this.param.gwid){
			this.initDataList();
		}else{
			this.setNoData();
		}
	},
	initDataList : function(){
		var this_ = this;
		var searchParam = {};
		var paramsMap = {};
		paramsMap.sqid = this.param.id;
		searchParam.mainid = this.param.gwid;
		searchParam.paramsMap = paramsMap;
		AjaxUtil.ajax({
			async: false,
			url:basePath+"/quality/post/evaluation/queryWorkRequireEval",
			contentType:"application/json;charset=utf-8",
			type:"post",
			data:JSON.stringify(searchParam),
			dataType:"json",
			success:function(data){
				if(data != null && data.length > 0){
					this_.appendHtml(data);
				}else{
					this_.setNoData();
				}
			}
		});
	},
	appendHtml : function(list){
		var this_ = this;
		// 先移除暂无数据一行
		$("#"+this_.tbodyId, $("#"+this_.id)).empty();
		var count = 0;
		$.each(list, function(i, row) {
			count++;
			row.count = count;
			this_.addRow(row);
		});
	},
	addRow : function(obj){
		
		var paramsMap = obj.paramsMap?obj.paramsMap:{};
		
		var hg = '';
		var bhg = '';
		if(paramsMap.pgjg != null && paramsMap.pgjg == 0){
			bhg = "checked='checked'";
		}else{
			hg = "checked='checked'";
		}
		var this_ = this;
		var tr = "";
		tr += "<tr>";
		
		tr += "<td style='text-align:center;vertical-align:middle;'>";
		tr += (obj.count);
		tr += 	  "<input type='hidden' name='hiddenid' value='"+obj.id+"'/>";
		tr += "</td>";
		var pgnr = StringUtil.escapeStr(paramsMap.pgnr);
		if(pgnr == null || pgnr == ''){
			pgnr = obj.gwyq;
		}
		tr += "<td><input class='form-control' name='pgnr' type='text' value='"+pgnr+"' maxlength='1000' /></td>";
		
		tr += "<td style='text-align:center;vertical-align:middle;'>";
		tr += "<label style='margin-top:6px;font-weight:normal;' >";
		tr += "<input type='radio' name='pgjg"+obj.count+"rypg' value='1' style='vertical-align:text-bottom' "+hg+" />&nbsp;合格";
		tr += "</label>";
		tr += "<label style='margin-top:6px;font-weight:normal;margin-left:6px' >";
		tr += "<input type='radio' name='pgjg"+obj.count+"rypg' value='0' style='vertical-align:text-bottom' "+bhg+" />&nbsp;不合格";
		tr += "</label>";
		tr += "</td>";
		
		tr += "<td><input class='form-control' name='pgyj' type='text' value='"+StringUtil.escapeStr(paramsMap.pgyj)+"' maxlength='1000' /></td>";
		
		tr += "</tr>";
		$("#"+this_.tbodyId,$("#"+this_.id)).append(tr);
	},
	setNoData : function(){
		$("#"+this.tbodyId, $("#"+this.id)).empty();
		$("#"+this.tbodyId, $("#"+this.id)).append("<tr ><td colspan='4' style='text-align:center;vertical-align:middle;' >暂无数据 No data.</td></tr>");
	},
	getData : function(){
		var this_ = this;
		this_.isValid = true;
		var param = [];
		var len = $("#"+this.tbodyId,$("#"+this.id)).find("tr").length;
		if (len == 1) {
			if($("#"+this.tbodyId,$("#"+this.id)).find("td").length ==1){
				return param;
			}
		}
		if (len > 0){
			$("#"+this.tbodyId,$("#"+this.id)).find("tr").each(function(){
				var tr_this = this;
				var infos ={};
				var index=$(this).index(); //当前行
				var hiddenid = $(this).find("input[name='hiddenid']").val(); //当前行，隐藏id的值
				var pgnr = $(this).find("input[name='pgnr']").val();
				var pgjg = $(this).find("input[type='radio']:checked").val();
				var pgyj = $(this).find("input[name='pgyj']").val();
				infos.gwyqid = hiddenid;
				infos.kcid  = pgnr;
				infos.pgjg = pgjg;
				infos.pgyj  = pgyj;
				param.push(infos);
			});
		}
		return param;
	}
	
}
