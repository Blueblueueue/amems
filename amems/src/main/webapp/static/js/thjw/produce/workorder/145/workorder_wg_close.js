/**
 * 145工单完工关闭
 */
Workorder145WGCloseWin = {
	id:'workorder145_wgclose_Modal', //窗口ID
	tbodyId:'wo145wgclose_list', //列表ID
	colOptionheadClass : "colOptionhead",
	param: {
		modalHeadCN : '',//窗口中文名称
		modalHeadENG : '',//窗口英文名称
		parentWinId : '',//父窗口ID
		colOptionhead : true,
		isShowReplacementRecord : true,//是否显示拆换件记录列表
		viewObj:{},
		dprtcode:userJgdm,//默认登录人当前机构代码
		callback:function(){},//回调函数
	},
	isValid : true,//验证是否通过,isValid:true表示验证通过,isValid:false表示验证未通过
	/**显示窗口*/
	show : function(param){
		if(param){
			$.extend(this.param, param);
		}
		
		$('.date-picker').datepicker({
			autoclose : true,
			clearBtn : true
		});
		$(".time-masked").mask("99:99");
		
		$("#"+this.id+" input[type='text']").val("");
		$("#"+this.id+" input[type='hidden']").val("");
		$("#"+this.id+" textarea").val("");
		/**控制操作  */
		this.doOption();
		this.initInfo();
		$('#workorder145_wgclose_Modal .date-picker').datepicker('update');
	},
	/**控制操作  */
	doOption :function(){
		var this_ = this;
		if(this_.param.colOptionhead){
			$("#"+this_.id+"_optionDiv input[type='text']").attr("disabled",false);
			$("#"+this_.id+"_optionDiv input:checkbox").attr("disabled",false);
			$("#"+this_.id+"_optionDiv textarea").attr("disabled",false);
			$("#"+this_.id+"_save").show();
			$("#"+this_.id+"_sjwcrq_remark").show();
			$("#wo145wgclose_sjgzz_btn").show();
			$("#wo145wgclose_sjjcz_btn").show();
			$("#wo145wgclose_sjgzz").addClass("readonly-style");
		}else{
			$("#"+this_.id+"_optionDiv input[type='text']").attr("disabled",true);
			$("#"+this_.id+"_optionDiv input:checkbox").attr("disabled",true);
			$("#"+this_.id+"_optionDiv textarea").attr("disabled",true);
			$("#"+this_.id+"_save").hide();
			$("#"+this_.id+"_sjwcrq_remark").hide();
			$("#wo145wgclose_sjgzz_btn").hide();
			$("#wo145wgclose_sjjcz_btn").hide();
			$("#wo145wgclose_sjgzz").removeClass("readonly-style");
		}
		
	},
	/**初始数据*/
	initInfo : function(){
		var this_ = this;
		
		this_.formValidator();
		//隐藏Modal时验证销毁重构
		$("#"+this_.id).on("hidden.bs.modal", function() {
			 $("#wo145wgclose_from").data('bootstrapValidator').destroy();
		     $('#wo145wgclose_from').data('bootstrapValidator', null);
		     this_.formValidator();
		});
		//实际完成日期
		$('#wo145wgclose_sjJsrq').datepicker({
			autoclose : true,
			clearBtn : true
		}).on('hide',function(e) {
			$('#wo145wgclose_from').data('bootstrapValidator').updateStatus('wo145wgclose_sjJsrq','NOT_VALIDATED', null).validateField('wo145wgclose_sjJsrq');
		});
		
		//初始窗口标题信息
		this.initModelHead();
		
		//显示窗口
		ModalUtil.showModal(this.id);
		AlertUtil.hideModalFooterMessage();
		
		if(!this.param.viewObj.fjzch || this.param.viewObj.fjzch == "-"){
			this.param.isShowReplacementRecord = false;
		}
		//显示拆换件列表
		if(this.param.isShowReplacementRecord){
			$("#replacementRecord_wo145wgclose_div").show();
			this.showReplacementRecord();
		}else{
			$("#replacementRecord_wo145wgclose_div").hide();
		}
		//显示附件列表
		this.showAttachments();
		
		//加载数据
		this.loadeBaseData();
	},
	/**加载基础数据*/
	loadeBaseData : function(){
		var this_ = this;
		if(this_.param.viewObj.gdlx == 3){
			$("#workorder145_wgclose_title").html("缺陷描述");
			$("#workorder145_wgclose_Etitle").html("Desc");
		}else{
			$("#workorder145_wgclose_title").html("工单标题");
			$("#workorder145_wgclose_Etitle").html("WO Title");
		}
		var total = 0;
		var jhgsRs = this_.param.viewObj.jhgsRs;
		var jhgsXss = this_.param.viewObj.jhgsXss;
		total = jhgsRs*jhgsXss;
		if(total == ''){
			total = 0;
		}
		if(String(total).indexOf(".") >= 0){
			total = total.toFixed(2);
		}
		
		var bjh = "";
		var xlh = "";
		if(null != this_.param.viewObj.monitoringObject){
			bjh = this_.param.viewObj.monitoringObject.bjh;//部件号
			xlh = this_.param.viewObj.monitoringObject.xlh;//序列号
		}
		
		var zjh = "";
		if(null != this_.param.viewObj.fixChapter){
			zjh = this_.param.viewObj.fixChapter.displayName;//ATA章节号Name
		}
		
		var htmlContent = "<tr class='text-center'>";
		    htmlContent += "<td title='"+formatUndefine(DicAndEnumUtil.getEnumName('workorderTypeEnum', StringUtil.escapeStr(this_.param.viewObj.gdlx)))+"'>"+formatUndefine(DicAndEnumUtil.getEnumName('workorderTypeEnum', StringUtil.escapeStr(this_.param.viewObj.gdlx)))+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(this_.param.viewObj.gdbh)+"'>"+StringUtil.escapeStr(this_.param.viewObj.gdbh)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(zjh)+"'>"+StringUtil.escapeStr(zjh)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(this_.param.viewObj.gdbt)+"'>"+StringUtil.escapeStr(this_.param.viewObj.gdbt)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(total)+"'>"+StringUtil.escapeStr(total)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(bjh)+"'>"+StringUtil.escapeStr(bjh)+"</td>";
		    htmlContent += "<td title='"+StringUtil.escapeStr(xlh)+"'>"+StringUtil.escapeStr(xlh)+"</td>";
		    htmlContent += "</tr>";
		
		$("#wo145wgclose_list").html(htmlContent);
		
		$("#wo145wgclose_gdlx").val("正常完工"); //工单类型
		if(null != this_.param.viewObj.xfrDepartment){
			$("#wo145wgclose_xfdw").val(StringUtil.escapeStr(this_.param.viewObj.xfrDepartment.dprtname)); //下发单位
		}
		if(null != this_.param.viewObj.jhKsrq){
			$("#wo145wgclose_jhksrq").val(StringUtil.escapeStr(this_.param.viewObj.jhKsrq).substring(0, 10)); //计划开始日期
		}
		if(null != this_.param.viewObj.jhJsrq){
			$("#wo145wgclose_jhjsrq").val(StringUtil.escapeStr(this_.param.viewObj.jhJsrq).substring(0, 10)); //计划结束日期
		}
		if(null != this_.param.viewObj.paramsMap.gbrname && " " != this_.param.viewObj.paramsMap.gbrname){
			$("#wo145wgclose_gbr").val(this_.param.viewObj.paramsMap.gbrname);
		}else{
			$("#wo145wgclose_gbr").val(StringUtil.escapeStr(currentUser.displayName)); //关闭人	
		}
		if(null != this_.param.viewObj.gbrq){
			$("#wo145wgclose_gbrq").val(StringUtil.escapeStr(this_.param.viewObj.gbrq).substring(0, 10));
		}else{
			TimeUtil.getCurrentDate("#wo145wgclose_gbrq");//关闭日期
		}
		

		$("#wo145wgclose_sjJsrq").val(StringUtil.escapeStr(this_.param.viewObj.sjJsrq).substring(0, 10)); //实际完成日期
		$("#wo145wgclose_sjJssj").val(StringUtil.escapeStr(this_.param.viewObj.sjJsrq).substring(11, 16));//实际完成时间
//		$("#wo145wgclose_sjgzz").val(this_.param.viewObj.sjGzz);//实际工作者
//		$("#wo145wgclose_sjjcz").val(this_.param.viewObj.sjJcz);//实际检查者
		
		var gzzList = '';
		var gzzidList = '';
		$.each(this_.param.viewObj.workers || [], function(i, row){
			gzzList += formatUndefine(row.gzz) + ",";
			gzzidList += formatUndefine(row.gzzid) + ",";
		});
		if(gzzList != ''){
			gzzList = gzzList.substring(0,gzzList.length - 1);
		}
		if(gzzidList != ''){
			gzzidList = gzzidList.substring(0,gzzidList.length - 1);
		}
		$("#wo145wgclose_sjgzz").val(gzzList);
		$("#wo145wgclose_sjgzzid").val(gzzidList);
		$("#wo145wgclose_sjjcz").val(this_.param.viewObj.sjJcz);
		$("#wo145wgclose_sjjczid").val(this_.param.viewObj.sjJczid);
		this_.disableUser("wo145wgclose_sjjcz");
		
		$("#wo145wgclose_sjgs").val(this_.param.viewObj.sjGs);//实际工时
		$("#wo145wgclose_sjzd").val(this_.param.viewObj.sjZd);//工作站点
		$("#wo145wgclose_sjksrq").val(StringUtil.escapeStr(this_.param.viewObj.sjKsrq).substring(0, 10));//实际开始日期
		$("#wo145wgclose_gzxx").val(this_.param.viewObj.gzxx);//故障信息
		$("#wo145wgclose_clcs").val(this_.param.viewObj.clcs);//处理措施
		$("#wo145wgclose_gbyy").val(this_.param.viewObj.gbyy);//关闭原因
		//拆换件暂缺......
		
	},
	/**初始化对话框头部*/
	initModelHead : function(){
		if('' != this.param.modalHeadCN){
			$("#modalHeadCN", $("#"+this.id)).html(this.param.modalHeadCN);
			$("#modalHeadENG", $("#"+this.id)).html(this.param.modalHeadENG);
		}
	},
	/**显示拆换件记录列表*/
	showReplacementRecord : function(){
		replacementRecord.init({
			back:this.param.viewObj.woIORecordList,
			fdjsl:this.param.viewObj.paramsMap.fdjsl,
			fjjx:this.param.viewObj.paramsMap.fjjx,
			fjzch:this.param.viewObj.fjzch,
			dprtcode:this.param.viewObj.dprtcode,
			parent:this.id,
			isShowed:this.param.colOptionhead,
			wbbs:this.param.viewObj.workpackage145.wbbs,
			defaultCzrq:function(){
				var sjjsrq = $.trim($("#wo145wgclose_sjJsrq").val());
				var sjjssj = $.trim($("#wo145wgclose_sjJssj").val());
				var czrq = "";
				if(sjjsrq){
					czrq = sjjsrq + " " + (sjjssj||"00:00") + ":00";
				}
				return czrq;
			}
		});
	},
	/**显示附件*/
	showAttachments : function(){
		var this_ = this;
		var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_workorderedit_wo145wgclose');
		attachmentsObj.show({
			djid:this_.param.viewObj.id,
			fileHead : true,
			colOptionhead : this.param.colOptionhead,
			fileType:"WO"
		});
	},
	/**获取数据*/
	getData : function(){
		var this_ = this;
		
		var param = {};
		param.id = this_.param.viewObj.id; //工单ID
		param.gdsbid = this_.param.viewObj.gdsbid;//工单识别id
		var sjJsrq = $("#wo145wgclose_sjJsrq").val() + " "+$("#wo145wgclose_sjJssj").val();
		param.sjJsrq = new Date(Date.parse(sjJsrq.replace(/-/g, "/"))); ;//实际完成日期
//		param.sjGzz = $("#wo145wgclose_sjgzz").val();//实际工作者
//		param.sjJcz = $("#wo145wgclose_sjjcz").val();//实际检查者
		
		var userList = [];
		var gzzidList = $("#wo145wgclose_sjgzzid").val();
		var gzzList = $("#wo145wgclose_sjgzz").val();
		for (var i = 0; i < gzzidList.split(",").length; i++) {
			var p = {
				gzzid : gzzidList.split(",")[i],
				gzz : gzzList.split(",")[i]
			};
			userList.push(p);
		}
		if (gzzidList == "") {
			userList = [];
		}
		param.workers = userList;
		param.sjJcz = $("#wo145wgclose_sjjcz").val();
		param.sjJczid = $("#wo145wgclose_sjjczid").val();
		
		param.sjGs = $("#wo145wgclose_sjgs").val();//实际工时
		param.sjZd = $("#wo145wgclose_sjzd").val();//工作站点
		param.sjKsrq = $("#wo145wgclose_sjksrq").val();//实际开始日期
		param.gzxx = $("#wo145wgclose_gzxx").val();//故障信息
		param.clcs = $("#wo145wgclose_clcs").val();//处理措施
		param.gbyy = $("#wo145wgclose_gbyy").val();//关闭详情
		param.zt = 10;//状态10完成
		//拆换件
		var woIORecordList = replacementRecord.getData();
		if(woIORecordList != null &&woIORecordList.length>0){
			param.woIORecordList=woIORecordList;			
		}
		var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_workorderedit_wo145wgclose');
		param.attachments = attachmentsObj.getAttachments();//附件列表
		
		return param;
	},
	/**工单关闭*/
	submitFeedback :  function(){
		var this_ = this;
		
		$('#wo145wgclose_from').data('bootstrapValidator').validate();
		if(!$('#wo145wgclose_from').data('bootstrapValidator').isValid()){
			AlertUtil.showModalFooterMessage("请根据提示输入正确的信息!");
			$("#"+this_.id+" .modal-body").prop('scrollTop','0');
			return false;
		}
		
		var sjjssj=$("#wo145wgclose_sjJssj").val();
		if(sjjssj != ''){
			if(sjjssj.split(":")[0]>=24){
				AlertUtil.showModalFooterMessage("实际完成时间格式不正确!");
				return false;
			}
			if(sjjssj.split(":")[1]>=60){
				AlertUtil.showModalFooterMessage("实际完成时间格式不正确!");
				return false;
			}			
		}
		if($("#wo145wgclose_sjksrq").val() != '' && $("#wo145wgclose_sjJsrq").val() != '' && $("#wo145wgclose_sjksrq").val()>$("#wo145wgclose_sjJsrq").val()){
			AlertUtil.showModalFooterMessage("实际开始日期不能晚于实际完成日期!");
			return false;
		}
		var sjgs = $("#wo145wgclose_sjgs").val();//实际工时
		var reg = /^[0-9]{1,10}(\.[0-9]{0,2})?$/;
		if(sjgs !=='' && reg.test(sjgs)==false){
			AlertUtil.showModalFooterMessage("实际工时输入不正确，只能输入数值，精确到两位小数!");
			return false;
		}
		//获取数据
		var reqData = this_.getData(); 
		
		AlertUtil.showConfirmMessage("您确定要提交吗？", {callback: function(){
			this_.param.callback(reqData);
		}});
	},
	formValidator : function(){//加载验证
		validatorForm =  $('#wo145wgclose_from').bootstrapValidator({
	        message: '数据不合法',
	        feedbackIcons: {
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	wo145wgclose_sjJsrq: {
	            	validators: {
	            		notEmpty: {
	            			message: '实际完成日期不能为空'
	            		}
	            	}
	            },
	           /* wo145wgclose_sjJssj: {
	            	validators: {
	            		notEmpty: {
	            			message: '实际完成时间不能为空'
	            		}
	            	}
	            },*/
	        }
	    });	 
	},
	
	// 打开工作者弹窗
	openGzzWin : function(){
		var this_ = this;
		var userList = [];
		var gzzidList = $("#wo145wgclose_sjgzzid").val();
		var gzzList = $("#wo145wgclose_sjgzz").val();
		for (var i = 0; i < gzzidList.split(",").length; i++) {
			var p = {
				id : gzzidList.split(",")[i],
				displayName : gzzList.split(",")[i]
			};
			userList.push(p);
		}
		if (gzzidList == "") {
			userList = [];
		}
		Personel_Tree_Multi_Modal.show({
			checkUserList:userList,//原值，在弹窗中回显
			dprtcode:this_.param.dprtcode,
			multi:true,
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
				$("#wo145wgclose_sjgzz").val(displayName);
				$("#wo145wgclose_sjgzzid").val(mjsrid);
			}
		});
		AlertUtil.hideModalFooterMessage();
	},
	
	// 打开检查者弹窗
	openJczWin : function(){
		var this_ = this;
		Personel_Tree_Multi_Modal.show({
			checkUserList:[{id:$("#wo145wgclose_sjjczid").val(),displayName:$("#wo145wgclose_sjjcz").val()}],//原值，在弹窗中回显
			dprtcode:this_.param.dprtcode,
			multi:false,
			callback: function(data){//回调函数
				var user = $.isArray(data)?data[0]:{id:'',displayName:''};
				$("#wo145wgclose_sjjczid").val(user.id);
				$("#wo145wgclose_sjjcz").val(user.displayName);
				this_.disableUser("wo145wgclose_sjjcz");
			}
		});
		AlertUtil.hideModalFooterMessage();
	},
	
	// 禁止输入用户
	disableUser : function(id){
		var user = $("#"+id+"id").val();
		if(user && this.param.colOptionhead){
			$("#"+id).attr("readonly","readonly").addClass("readonly-style");
		}else{
			$("#"+id).removeAttr("readonly").removeClass("readonly-style");
		}
	},
};