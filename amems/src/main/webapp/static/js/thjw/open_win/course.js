/**
 * 课程弹窗
 */
open_win_course_modal = {
	id:'open_win_course_modal',
	loaded: false,//是否已加载
	data:[],
	param: {
		multi:false, //是否多选 默认单选
		selected:null, //已经选择的
		existsIdList:null,//已经选择的集合
		dprtcode:userJgdm,//默认登录人当前机构代码
		callback:function(){}//回调函数
	},
	//显示弹窗 isReload = true 表示强制加载
	show : function(param, isReload){
		var this_ = this;
		$("#"+this_.id).modal("show");
		if(param){
			$.extend(this_.param, param);
		}
		this_.initPlaneModelSearch(function(){
			this_.initParam();
			this_.load();
			if(!this_.loaded || isReload === true){
			}
		});
	},
	//初始化参数
	initParam: function(){
		$("#"+this.id+"_keyword_search").val('');
		if(this.param.multi){
			$("#checkAll", $("#"+this.id)).show();
			$("#checkSingle", $("#"+this.id)).hide();
		}else{
			$("#checkAll", $("#"+this.id)).hide();
			$("#checkSingle", $("#"+this.id)).show();
		}
	},
	/**
	 * 初始化机型
	 */
	initPlaneModelSearch : function(obj){
		var this_ = this;
		this_.selectFjjxByDprtcode(this_.param.dprtcode, function(data){
	 	 	var option = '<option value="-" selected="true">显示全部All</option>';
	 	 	if(data != null && data.length >0){
	 			$.each(data,function(i,fjjx){
	 				option += "<option value='"+StringUtil.escapeStr(fjjx)+"' >"+StringUtil.escapeStr(fjjx)+"</option>";
	 			});
	 	  	}
	 	 	option += '<option value="">N/A</option>';
	 	 	$("#fjjx_win_search", $("#"+this_.id)).empty();
		 	$("#fjjx_win_search", $("#"+this_.id)).append(option);
		 	if(typeof(obj)=="function"){
				obj(); 
		 	}
		});
	},
	/**
	 * 根据机构代码获取机型
	 */
	selectFjjxByDprtcode : function(dprtcode, obj){
		AjaxUtil.ajax({
		 	   url:basePath+"/project/planemodeldata/findAllType",
		 	   async: false,
		 	   type: "post",
		 	   dataType:"json",
		 	   data:{dprtcode:dprtcode},
		 	   success:function(data){
		 		  if(typeof(obj)=="function"){
						obj(data); 
		 		  }
		 	   }
		    }); 
	},
	//加载数据
	load : 	function(pageNumber, sortColumn, orderType){
		if(typeof(pageNumber) == "undefined"){
			pageNumber = 1;
		}
		if(typeof(sortColumn) == "undefined"){
			sortColumn = "auto";
		} 
		if(typeof(orderType) == "undefined"){
			orderType = "desc";
		} 
		
		var obj ={};
		obj.pagination = {page:pageNumber, sort:sortColumn, order:orderType, rows:10};
		$.extend(obj, this.getParams());
		startWait();
		var this_ = this;
		AjaxUtil.ajax({
			url: basePath+"/training/course/queryAllPageList",
			type: "post",
			contentType:"application/json;charset=utf-8",
			dataType:"json",
			data:JSON.stringify(obj),
			success:function(data){
				SelectUtil.selectNode('selectAllId',this_.id+"_list");
				if(data.total >0){
					this_.data = data.rows;
					this_.appendContentHtml(data.rows);
					new Pagination({
						renderTo : this_.id+"_pagination",
						data: data,
						sortColumn : sortColumn,
						orderType : orderType,
						controller: this_
					}); 
					// 标记关键字
					signByKeyword($("#"+this_.id+"_keyword_search").val(),[2,3,4,6,8,9,13,14,15], "#"+this_.id+"_list tr td");
				} else {
					$("#"+this_.id+"_list").empty();
					$("#"+this_.id+"_pagination").empty();
					$("#"+this_.id+"_list").append("<tr><td class='text-center' colspan=\"15\">暂无数据 No data.</td></tr>");
				}
				this_.loaded = true;
				finishWait();
		    }
		}); 
	},	
	getParams : function(){
		var searchParam = {};
		 var paramsMap = {};
		 var keyword = $.trim($("#"+this.id+"_keyword_search").val());
		 var fjjx = $.trim($("#fjjx_win_search").val());
		 if(fjjx != "-"){
			 paramsMap.qjx = "qjx";
			 searchParam.fjjx = fjjx;
		 }
		 searchParam.dprtcode = this.param.dprtcode;
		 if('' != keyword){
			 searchParam.keyword = keyword;
		 }
		 var existsIdList = this.param.existsIdList;
		 if(existsIdList != null && existsIdList.length > 0){
			 paramsMap.codeList = existsIdList;
		 }
		 searchParam.paramsMap = paramsMap;
		 return searchParam;
	},
	appendContentHtml: function(list){
		var htmlContent = '';
		var this_ = this;
		$.each(list,function(index,row){
			
			if (index % 2 == 0) {
				htmlContent += "<tr style=\"cursor:pointer\" bgcolor=\"#f9f9f9\" onclick='"+this_.id+".rowonclick(event);' >";
			} else {
				htmlContent += "<tr style=\"cursor:pointer\" bgcolor=\"#fefefe\" onclick='"+this_.id+".rowonclick(event);' >";
			}
		   
			htmlContent += "<td style='text-align:center;vertical-align:middle;'>"; 
			if(this_.param.multi){
				htmlContent += "<input type='checkbox' name='"+this_.id+"_list_radio' value='"+index+"' onclick=\"SelectUtil.checkRow(this,'selectAllId','"+this_.id+"_list')\" >"; 
			}else{
				var checked = "";
				if(this_.param.selected && this_.param.selected == row.id){
					checked = "checked";
				}
				htmlContent += "<input type='radio' name='"+this_.id+"_list_radio' value='"+index+"' "+checked+" >"; 
			}
			htmlContent += "</td>";
		   
			htmlContent += "<td title='"+StringUtil.escapeStr(row.kclb)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.kclb)+"</td>"; 
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.kcbh)+"' style='text-align:left;vertical-align:middle;'>";
		    htmlContent += ""+StringUtil.escapeStr(row.kcbh)+"";
		    htmlContent += "</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.kcmc)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.kcmc)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.fjjx)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.fjjx)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.pxmb)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.pxmb)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.ks)+"' style='text-align:right;vertical-align:middle;'>"+StringUtil.escapeStr(row.ks)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.pxxs)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.pxxs)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.ksxs)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.ksxs)+"</td>";
		    htmlContent += "<td style='text-align:center;vertical-align:middle;'>"+(row.isFx == 1?"是":"否")+"</td>";
		    var fxjg = formatUndefine(row.zqz) + DicAndEnumUtil.getEnumName('cycleEnum',row.zqdw);
		    htmlContent += "<td title='"+fxjg+"' style='text-align:left;vertical-align:middle;'>"+fxjg+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.fxks)+"' style='text-align:right;vertical-align:middle;'>"+StringUtil.escapeStr(row.fxks)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.fxpxxs)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.fxpxxs)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.fxksxs)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.fxksxs)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(row.bz)+"' style='text-align:left;vertical-align:middle;'>"+StringUtil.escapeStr(row.bz)+"</td>";
		   
		   	htmlContent += "</tr>";
	   });
	   $("#"+this_.id+"_list").html(htmlContent);
	   SelectUtil.selectNode('selectAllId',this_.id+"_list");
	},
	//搜索
	search: function(){
		this.load();
	},
	//确认
	rowonclick: function(e){
		if(!this.param.multi){
			$(e.target).parent().find("input[type='radio']").attr("checked",true);
		}else{
			SelectUtil.checkRow($(e.target).parent().find("input[type='checkbox']"),'selectAllId',this.id+"_list");
		}
	},
	save: function(){
		
		if(this.param.callback && typeof(this.param.callback) == "function"){
			if(this.param.multi){
				var this_ = this;
				var data = [];
				$("#"+this_.id+"_list", $("#"+this_.id)).find("tr input:checked").each(function(){
					var index = $(this).attr("value");	
					data.push(this_.data[index]);
				});
				this.param.callback(data);
			}else{
				var $checkedRadio = $("#"+this.id+"_list").find("input:checked");
				this.param.callback(this.data[$checkedRadio.attr("value")]);
			}
		}
	}
};