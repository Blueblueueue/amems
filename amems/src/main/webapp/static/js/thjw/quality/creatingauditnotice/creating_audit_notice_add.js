
function validation(){
	  $('#form').bootstrapValidator({
	        message: '数据不合法',
	        feedbackIcons: {
	            //valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	jcdbh: {
	                validators: {
	                    regexp: {
	                    	regexp: /^[^\u4e00-\u9fa5]{0,50}$/,
	                        message: '不能输入中文且长度最多不超过50个字符'
	                    }
	                }
	            },    
	            jhShrq: {
	                validators: {
	                    notEmpty: {
	                        message: '计划审核日期不能为空'
	                    }
	                }
	            }
	        }
	    });
}
creating_audit_notice_add = {
		id : "audit_notice_alert_Modal",
		planeRegOption : '',
		attachmentSingle : {},
		attachmentsObj : {},
		isLoad:false,//是否加载
		param: {
			id:'',
			type:1,//1:新增,2:修改,
			modalHeadChina : '维护审核通知单',
			modalHeadEnglish : 'Maintenance audit notice',
			viewObj:null,
			blOption:true,
			callback:function(){},
			ndshjhid:"",
			dprtcode:userJgdm//默认登录人当前机构代码
		},
		show : function(param){
			//加载验证
			validation();
			if(param){
				$.extend(this.param, param);
			}
			//初始化信息
			this.initInfo();
			ModalUtil.showModal(this.id);
//			$("#" + this.id).modal("show");
			
			
			
		},
		initInfo : function(){
			var this_ = this;
			//初始化表单验证
			if(!this_.isLoad){
				this_.initFormValidator();
				this_.isLoad = true;
			}
			//隐藏出现异常的感叹号
			AlertUtil.hideModalFooterMessage();
			this_.attachmentSingle = {};
			this_.initModelHead();
			this_.inputEmpty();
			//初始化审核成员
			var memberObj = memberUtil.getMemberComponents('audit_audit_member');
			memberObj.shcyInit();
			if(creating_audit_notice_add.param.type == 2){
				this_.returnViewData(this_.param.viewObj,this_.param.blOption);
			}else if(this_.param.ndshjhid != null && this_.param.ndshjhid != ""){
				this_.getNdsh({id : this_.param.ndshjhid});
				//加载审核成员	
				memberObj.shcyJz(this_.param.ndshjhid);
			}else{
				//显示附件
				var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_audit');
				attachmentsObj.show({
					djid:"",
					fileHead : true,
					colOptionhead : true,
					fileType:"card"
				});
			}
			if(this_.param.viewObj != null){
				//加载审核成员	
				memberObj.shcyJz(this_.param.viewObj.id);
			}
			if(!this_.param.blOption){
				this_.inputDisabled();
			}else{
				this_.inputShow();
			}
			$("#left_column",$("#"+this_.id)).attr("class","col-sm-2 col-xs-3 text-right padding-left-0 padding-right-0");
			$("#left_column",$("#"+this_.id)).siblings("div").attr("class","col-sm-10 col-xs-9 padding-leftright-8");
		},
		initFormValidator : function(){//初始化验证
			var this_ = this;
			validation();
			//隐藏Modal时验证销毁重构
			$("#"+this_.id).on("hidden.bs.modal", function() {
				 $("#form").data('bootstrapValidator').destroy();
			     $('#form').data('bootstrapValidator', null);
			     validation();
			});
		},
		inputDisabled : function(){
			//$('.input-group-border input').attr('disabled',true);
			//$('.input-group-border textarea').attr('disabled',true);
		},
		inputShow : function(){
			//$('.input-group-border input').attr('disabled',false);
			//$('.input-group-border textarea').attr('disabled',false);
		},
		inputEmpty : function(){
			var this_ = this;
			//$('.input-group-border input').val('');
			//$('.input-group-border textarea').val('');
			$("#jcdbh",$("#"+this_.id)).val('');
			$("#jhShrq",$("#"+this_.id)).val('');
			$("#shdxmcText",$("#"+this_.id)).val('');
			$("#shdxmc",$("#"+this_.id)).val('');
			$("#shdxbh",$("#"+this_.id)).val('');
			$("#shdxid",$("#"+this_.id)).val('');
			$("#shdxmc2",$("#"+this_.id)).val('');
			$("#jcnr",$("#"+this_.id)).val('');
			$("#jcdbh",$("#"+this_.id)).attr('disabled',false);
			$('input:radio[name="shlb"]:first',$("#"+this_.id)).attr('checked', 'checked');
			$('input:radio[name="lx"]:first',$("#"+this_.id)).attr('checked', 'checked');
    		$("#shdx1",$("#"+this_.id)).show();
    		$("#shdx2",$("#"+this_.id)).hide();
		},
		initModelHead : function(){
			$("#modalHeadChina", $("#"+this.id)).html(this.param.modalHeadChina);
			$("#modalHeadEnglish", $("#"+this.id)).html(this.param.modalHeadEnglish);
		},
		returnViewData : function(obj,blOption){
			var this_ = this;
			$("#auditNoticeId",$("#"+this_.id)).val(obj.id);
			$("#jcdbh",$("#"+this_.id)).val(formatUndefine(obj.jcdbh));
			$("#jcdbh",$("#"+this_.id)).attr("disabled",true);
			$("#jhShrq",$("#"+this_.id)).val(formatUndefine(obj.jhShrq?obj.jhShrq.substring(0,10):''));
			$("input:radio[name='lx'][value="+obj.lx+"]",$("#"+this_.id)).attr('checked', 'checked');
			$("input:radio[name='shlb'][value="+obj.shlb+"]",$("#"+this_.id)).attr('checked', 'checked');
			$("#jcnr",$("#"+this_.id)).val(formatUndefine(obj.jcnr));
			if(obj.lx ==1){
				$("#shdxmcText",$("#"+this_.id)).val(formatUndefine(obj.shdxbh) +" "+formatUndefine(obj.shdxmc));
				$("#shdxmc",$("#"+this_.id)).val(formatUndefine(obj.shdxmc));
				$("#shdxbh",$("#"+this_.id)).val(formatUndefine(obj.shdxbh));
				$("#shdxid",$("#"+this_.id)).val(formatUndefine(obj.shdxid));
				$("#shdx1",$("#"+this_.id)).show();
	    		$("#shdx2",$("#"+this_.id)).hide();
			}else{
				$("#shdxmc2",$("#"+this_.id)).val(formatUndefine(obj.shdxmc));
				$("#shdx1",$("#"+this_.id)).hide();
	    		$("#shdx2",$("#"+this_.id)).show();
			}
			//显示附件
			var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_audit');
			attachmentsObj.show({
				djid:obj.id,
				fileHead : blOption,
				colOptionhead : blOption,
				fileType:"card"
			});
			
		},
		getNdsh : function(obj,blOption){
			
			var this_ = this;
			startWait($("#"+this_.id));
		   	AjaxUtil.ajax({
		 		url:basePath + "/quality/annualplan/getById",
		 		contentType:"application/json;charset=utf-8",
		 		type:"post",
		 		async: false,
		 		data:JSON.stringify(obj),
		 		dataType:"json",
		 		modal:$("#"+this_.id),
		 		success:function(data){
		 			finishWait($("#"+this_.id));
		 			if(data!=null){
		 				$("input:radio[name='lx'][value="+data.lx+"]").attr('checked', 'checked');
		 				if(data.lx ==1){
		 					$("#shdxmcText",$("#"+this_.id)).val(formatUndefine(data.shdxbh) +" "+formatUndefine(data.shdxmc));
		 					$("#shdxmc",$("#"+this_.id)).val(formatUndefine(data.shdxmc));
		 					$("#shdxbh",$("#"+this_.id)).val(formatUndefine(data.shdxbh));
		 					$("#shdxid",$("#"+this_.id)).val(formatUndefine(data.shdxid));
		 					$("#shdx1",$("#"+this_.id)).show();
		 		    		$("#shdx2",$("#"+this_.id)).hide();
		 				}else{
		 					$("#shdxmc2",$("#"+this_.id)).val(formatUndefine(data.shdxmc));
		 					$("#shdx1",$("#"+this_.id)).hide();
		 		    		$("#shdx2",$("#"+this_.id)).show();
		 				}
					};
		 		}
			});
			
			//显示附件
			var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_audit');
			attachmentsObj.show({
				djid:"",
				fileHead : true,
				colOptionhead : true,
				fileType:"card"
			});
			
		},
		//获取基本数据
		getAuditNoticeData: function (){
			var this_ = this;
			var data = {};
			data.id = $("#auditNoticeId",$("#"+this_.id)).val();
			data.jcdbh = $("#jcdbh",$("#"+this_.id)).val();
			data.jhShrq = $("#jhShrq",$("#"+this_.id)).val();
			data.lx=$("input:radio[name='lx']:checked",$("#"+this_.id)).val();
			data.shlb=$("input:radio[name='shlb']:checked",$("#"+this_.id)).val();
			data.jcnr = $("#jcnr",$("#"+this_.id)).val();
			data.ndshjhid = this_.param.ndshjhid;
			//审核对象
			if(data.lx == 1){
				data.shdxmc = $("#shdxmc",$("#"+this_.id)).val();
				data.shdxbh = $("#shdxbh",$("#"+this_.id)).val();
				data.shdxid = $("#shdxid",$("#"+this_.id)).val();
			}else{
				data.shdxmc = $("#shdxmc2",$("#"+this_.id)).val();
				data.shdxbh = "";
				data.shdxid = "";
			}
			return data;
		},
		//获取审核成员数据
		getShcyList: function (){
			var this_ = this;
			var obj = {};
			var list = [];
			var yzList = [];
			var bl = false;
			var fl = true;
			$("#dept_info_list",$("#"+this_.id)).find("tr").each(function(){
				var this_tr = this;
				var userId = $(this_tr).find("input[name='userId']").val();
				var userName = $(this_tr).find("input[name='userName']").val();
				var realName = $(this_tr).find("input[name='realName']").val();
				
				var dprtName = $(this_tr).find("input[name='dprtName']").val();
				var dprtId = $(this_tr).find("input[name='dprtId']").val();
				var dprtBh = $(this_tr).find("input[name='dprtBh']").val();
				var zw = $(this_tr).find("input[name='zw']").val();
				var js ='';
				if(fl){
					fl = false;
					js = 1;
				}else{
					js = 2;
				}
				if(userId != '' && userId != null){ 
					list.push({
						"cyid":userId,
						"cybh":userName,
						"cymc":realName,
						"bmmc":dprtName,
						"bmid":dprtId,
						"bmbh":dprtBh,
						"zw":zw,
						"js":js
					});
					yzList.push(userId);
				}
			});
			bl = ListYz(yzList);
			obj.list = list;
			obj.bl = bl;
			return obj;
		},
		/**
		 * 保存数据
		 */
		setData: function(zt){
			var this_ = this;
			//表单验证
			$('#form').data('bootstrapValidator').validate();
			if(!$('#form').data('bootstrapValidator').isValid()){
				AlertUtil.showModalFooterMessage("请根据提示输入正确的信息!");
				return false;
			}
			//获取基本信息
			var data = this_.getAuditNoticeData();
			
			if(data.lx == 1 && $("#shdxid").val()==""){
				AlertUtil.showModalFooterMessage("选择内部人员时，请选择审核对象!");
				return false;
			}
			data.zt = zt;
			//获取审核成员数据
			var map = this_.getShcyList();
			if(map.bl){
				AlertUtil.showModalFooterMessage("审核成员出现重复数据，请修改后进行操作!");
				return false;
			}
			data.shdxList = map.list;
			
			
			//获取附件信息
		    var attachmentsObj = attachmentsUtil.getAttachmentsComponents('attachments_list_audit');
		    data.attachmentList = attachmentsObj.getAttachments();
		    //回调
			this_.param.callback(data);
		}
}

function ListYz(a){
   return /(\x0f[^\x0f]+)\x0f[\s\S]*\1/.test("\x0f"+a.join("\x0f\x0f") +"\x0f");
}
