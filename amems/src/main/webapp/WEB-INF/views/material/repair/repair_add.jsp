<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@ include file="/WEB-INF/views/common_new.jsp"%>
<script>
var pageParam = '${param.pageParam}';
</script>
<style type="text/css">
.bootstrap-tagsinput {
  	width: 100% !important;
}
</style>
<link rel="stylesheet" href="${ctx}/static/lib/bootstrap-tagsinput/bootstrap-tagsinput.css" type="text/css">
<script type="text/javascript" src="${ctx}/static/lib/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
</head>
<body>

	<div class="page-content ">
		<div class="panel panel-primary">
			<div class="panel-heading" id="NavigationBar"></div>	
			<div class="panel-body">
				<form id="form">
					<div class="panel-heading margin-left-16 padding-top-3 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
						<div class="font-size-16 line-height-18">基本信息</div>
						<div class="font-size-9 ">Basic Info</div>
					</div>
				
					<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 margin-bottom-10">
						<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group" >
							<label  class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">送修类型</div>
								<div class="font-size-9 line-height-18">Repair Type</div>
							</label>
							<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<select class='form-control' id='jjcd' name="jjcd" >
									<c:forEach items="${urgencyEnum}" var="item">
										<option value="${item.id}" <c:if test="${1 == item.id }">selected=true</c:if> >${item.name}</option>
									</c:forEach>
							    </select>
							</div>
						</div>
					
						<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group" >
							<label  class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">要求时限</div>
								<div class="font-size-9 line-height-18">Requested date</div>
							</label>
							<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input class="form-control date-picker" id="yqqx" name="yqqx" data-date-format="yyyy-mm-dd" type="text" />
							</div>
						</div>
						
						<div class=" col-lg-6 col-sm-12 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group" >
							<label  class="col-lg-2 col-sm-2 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">关联工单号</div>
								<div class="font-size-9 line-height-18">W/O</div>
							</label>
							<div class=" col-lg-10 col-sm-10 col-xs-8 padding-left-8 padding-right-0 input-group">
								<div class='input-group'>
									<input class="form-control" id="workOrder" readonly/>
									<span id="work_btn" class='input-group-btn'>
									  <button type="button" class="operation-work-btn col-lg-1 col-sm-6 col-xs-6 padding-left-0 padding-right-0 btn btn-primary form-control pull-right"  style=" width:40px;"data-toggle="modal" >
										<i class="icon-search cursor-pointer"></i>
									  </button>
									</span>
									<span id="work_single_btn" class='input-group-btn'>
									  <button type="button" class="col-lg-1 col-sm-6 col-xs-6 padding-left-0 padding-right-0 btn btn-primary form-control pull-right"  style=" width:40px;"data-toggle="modal" onclick="work_order_util.openWorkOrder()">
										<i class="icon-search cursor-pointer"></i>
									  </button>
									</span>
							    </div>
							</div>
						</div>
						
						<div class="clearfix"></div>
						
					 	<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-1 col-sm-2 col-xs-4 text-right padding-left-0 padding-right-0 ">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>送修原因</div>
								<div class="font-size-9 line-height-18">Repair cause</div>
							</label>
							<div class="col-lg-11 col-sm-10 col-xs-8 padding-left-8 padding-right-0 ">
								<textarea class="form-control" id="sqyy" name="sqyy" maxlength="166" ></textarea>
							</div>
						</div>
					</div>
				</form>
				
				<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0" style="margin-bottom: 10px;">
					<div class="clearfix"></div>
					
					<div class="panel-heading padding-left-16 padding-top-3 padding-bottom-10 col-xs-12 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
						<div class=" pull-left margin-right-10" >
							<div class="font-size-16 line-height-18">送修航材信息</div>
							<div class="font-size-9 ">Aircraft info</div>
						</div>	
					</div>
					
	            	<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 margin-bottom-10" style="margin-top: 10px;overflow-x: auto;">

						<!-- start:table -->
						<table class="table table-bordered table-striped table-hover table-set" style="min-width: 1400px;">
							<thead>
						   		<tr>
									<th class="colwidth-5">
										<button class="line6 " onclick="openMaterialWinAdd()">
											<i class="icon-search color-blue cursor-pointer" ></i>
										</button>
									</th>
									<th class="colwidth-3">
										<div class="font-size-12 notwrap">序号</div>
										<div class="font-size-9 notwrap">No.</div>
									</th>
									<th class="colwidth-15">
										<div class="font-size-12 notwrap">件号</div>
										<div class="font-size-9 notwrap">P/N</div>
									</th>
									<th class="colwidth-25">
										<div class="font-size-12 notwrap">英文名称</div>
										<div class="font-size-9 notwrap">F.Name</div>
									</th>
									<th class="colwidth-20">
										<div class="font-size-12 notwrap">中文名称</div>
										<div class="font-size-9 notwrap">CH.Name</div>
									</th>
									<th class="colwidth-15">
										<div class="font-size-12 notwrap">厂家件号</div>
										<div class="font-size-9 notwrap">MP/N</div>
									</th>
									<th class="colwidth-20">
										<div class="font-size-12 notwrap">序列号</div>
										<div class="font-size-9 notwrap">S/N</div>
									</th>
									<th class="colwidth-15">
										<div class="font-size-12 notwrap">ATA章节号</div>
										<div class="font-size-9 notwrap">ATA</div>
									</th>
									<th class="colwidth-10">
										<div class="font-size-12 notwrap">航材类型</div>
										<div class="font-size-9 notwrap">Airmaterial type</div>
									</th>
									<th class="colwidth-7">
										<div class="font-size-12 notwrap">单位</div>
										<div class="font-size-9 notwrap">Unit</div>
									</th>
						 		 </tr>
							</thead>
							<tbody id="repairTable">
							
							</tbody>
						</table>
						<!-- end:table -->
			     		<div class="clearfix"></div>
					 </div> 
				</div>
				
				<div class="clearfix"></div>
				<div class="text-right margin-bottom-10">
                    <button class="btn btn-primary padding-top-1 padding-bottom-1 checkPermission" permissioncode="aerialmaterial:repair:manage:03" onclick="javascript:save()">
                    	<div class="font-size-12">保存</div>
						<div class="font-size-9">Save</div>
					</button>
					<button class="btn btn-primary padding-top-1 padding-bottom-1 checkPermission" permissioncode="aerialmaterial:repair:manage:04" onclick="javascript:submit()">
                    	<div class="font-size-12">提交</div>
						<div class="font-size-9">Submit</div>
					</button>
               		<button class="btn btn-primary padding-top-1 padding-bottom-1" onclick="back()">
               			<div class="font-size-12">返回</div>
						<div class="font-size-9">Back</div>
					</button>
            	</div>
            	<div class="clearfix"></div>
			</div>
		</div>

		<!-- 基本信息 End -->

	<%@ include file="/WEB-INF/views/alert.jsp"%>
	
</div>
<script type="text/javascript" src="${ctx}/static/js/thjw/material/repair/repair_add.js"></script>
<%@ include file="/WEB-INF/views/open_win/materialRepair.jsp"%><!-------送修航材对话框 -------->
<%@ include file="/WEB-INF/views/open_win/work_order.jsp"%>
<script type="text/javascript" src="${ctx}/static/js/thjw/common/webuiPopoverUtil.js"></script><!-- 控件对话框 -->
</body>
</html>