<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" %>
<div class="modal fade in modal-new" id="audit_notice_alert_Modal" tabindex="-1" role="dialog"  aria-labelledby="audit_notice_alert_Modal" aria-hidden="true" data-backdrop='static' data-keyboard= false>
      <div class="modal-dialog" style='width:50%;'>
            <div class="modal-content">
				<div class="modal-header modal-header-new" >
					<h4 class="modal-title" >
                       	<div class='pull-left'>
                      		<div class="font-size-12" id="modalHeadCN">查看审核通知单</div>
							<div class="font-size-9" id="modalHeadENG">Check audit notice</div>
				  		</div>
				  		<div class='pull-right' >
						  	<button type="button" class="icon-remove modal-close" data-dismiss="modal" aria-label="Close"></button>
						</div>
				  		<div class='clearfix'></div>
                	</h4>
        		</div>
            <div class="modal-body" >
              	<div class="col-xs-12 margin-top-8 ">
              	<div class="input-group-border">
              	 <div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">检查单号</div>
								<div class="font-size-9 ">Check No.</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							<input type="text" class="form-control" maxlength="10" placeholder='不填写时系统生成编号' readonly/>
						</div>
				  </div>
				  <div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">计划审核日期</div>
								<div class="font-size-9 ">Date</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							<input type="text" class="form-control" maxlength="10" data-date-format="yyyy-mm-dd" readonly/>
						</div>
					</div>
				  <div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">类型</div>
								<div class="font-size-9 ">Type</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							<label  style='margin-top:6px;font-weight:normal;'>
								&nbsp;内部&nbsp;&nbsp;
							</label>
						</div>
					</div>
					
					<div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">审核类别</div>
								<div class="font-size-9 ">Category</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							<label  style='margin-top:6px;font-weight:normal;'>
								&nbsp;初次审核&nbsp;&nbsp;
							</label>
							
						</div>
					</div>
					<div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">审核对象</div>
								<div class="font-size-9 ">Object</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							 <input type="text"  class="form-control"  maxlength="20"  readonly/>
						</div>
					</div>
					
					<div class="col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-4 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">状态</div>
								<div class="font-size-9 ">Status</div>
						</label>
						<div class="col-sm-8 col-xs-9 padding-leftright-8">
							<input type="text" class="form-control" maxlength="10" readonly/>
						</div>
					</div>
					<div class="col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-2 col-xs-3 text-right padding-left-0 padding-right-0">
							<div class="font-size-12">审核成员</div>
							<div class="font-size-9">Audit member</div>
						</label>
						<div class="col-sm-10 col-xs-9 padding-leftright-8">
							<%@ include file="/WEB-INF/views/quality/auditnotice/audit_member.jsp"%>
						</div>	
					</div>
					<div class="col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label  class="col-sm-2 col-xs-3 text-right padding-left-0 padding-right-0">
								<div class="font-size-12  margin-topnew-2">审核检查内容</div>
								<div class="font-size-9 ">Content</div>
						</label>
						<div class="col-sm-10 col-xs-9 padding-leftright-8">
							<textarea class="form-control"  rows="3" cols="34" maxlength="100" readonly></textarea>
						</div>
					</div>
					
				  <div class="clearfix"></div>
				 
				</div>
				<div id="attachments_list_edit" >
					<%@ include file="/WEB-INF/views/common/attachments/attachments_list_edit_common.jsp"%><!-- 加载附件信息 -->
				</div>
				 <%@ include file="/WEB-INF/views/quality/auditnotice/acceptance_info.jsp"%>
				</div>
				<div class="clearfix"></div>
            </div>
			<div class="modal-footer">
	           	<div class="col-xs-12 padding-leftright-8" >
					<div class="input-group">
						<span class="input-group-addon modalfootertip" >
							<i class='glyphicon glyphicon-info-sign alert-info'></i><p class="alert-info-message"></p>
						</span>
	                    <span class="input-group-addon modalfooterbtn">
	                    	<button id="save_btn" type="button" onclick="javascript:work_card_edit_alert_Modal.setData('');" class="operation-btn btn btn-primary padding-top-1 padding-bottom-1">
								<div class="font-size-12">确认接收</div>
								<div class="font-size-9">Confirm</div>
							</button>
	                    </span>
	               	</div>
				</div>
			</div>
		</div>
	</div>
</div>
