<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@ include file="/WEB-INF/views/common_new.jsp"%>
<script type="text/javascript">
	var pageParam = '${param.pageParam1}';
</script>
</head>
<body>
	<div class="page-content">
		<!-- 页面操作区 Start -->
		<div class="panel panel-primary">
		<div class="panel-heading" id="NavigationBar"></div>
		
			<input type="hidden" id="operateType" value="${operateType}">
			<input type="hidden" id="dprtcodeNum" value="${dprtcodeNum}">
			<input type="hidden" value="${user.jgdm}" id="dprtcode">
			<input type="hidden" id="id" value="${id}">
			
			<div class="panel-body">
				<form id="form">
					<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0">
						<div class="panel-heading margin-left-16 padding-top-3 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
							<div class="font-size-16 line-height-18">基本信息</div>
							<div class="font-size-9 ">Basic Info</div>
						</div>
						<form id="form">
							<div class="col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">申请人</div>
								<div class="font-size-9 line-height-18">Applicant</div>
							</label>
							
					<div class=" col-xs-8 padding-left-8 padding-right-0 input-group">
							<div class='input-group'>
							<input type="text" class="form-control" name="inventorysqr" id="inventorysqr"  readonly />
								<input type="hidden" name="inventorysqbmid" id="inventorysqbmid" />
								<input type="hidden"  name="inventorysqrid" id="inventorysqrid" />
							
								<span class='input-group-btn'>
								  <button type="button" onclick='selectUser()' class='btn btn-primary'><i class='icon-search'></i>
								</button>
								</span>
						    </div>
					</div>
							
						</div>
						
					<div class="col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">申请日期</div>
								<div class="font-size-9 line-height-18">Application Date</div>
							</label>
							<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" class="form-control date-picker" name="inventorysqrq" id="inventorysqrq" data-date-format="yyyy-mm-dd" readonly />
							</div>
						</div>
					
						<div class="col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">出库人</div>
								<div class="font-size-9 line-height-18">Operator </div>
							</label>
						<div class=" col-xs-8 padding-left-8 padding-right-0 input-group">
							<div class='input-group'>
					<input type="text" class="form-control" name="inventoryckr" id="inventoryckr" value="${erayFns:escapeStr(user.username)} ${erayFns:escapeStr(user.realname)}" readonly />
								<input type="hidden" name="inventorymckmid" id="inventoryckbmid" value="${user.bmdm}"/>
								<input type="hidden"  name="inventoryckrid" id="inventoryckrid" value="${user.id}"/>
							
								<span class='input-group-btn'>
								  <button type="button" onclick='selectUser1()' class='btn btn-primary'><i class='icon-search'></i>
								</button>
								</span>
						    </div>
					</div>
							
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">出库日期</div>
								<div class="font-size-9 line-height-18">Outstock Date</div>
							</label>
							<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" class="form-control date-picker" name="inventoryckrq" id="inventoryckrq" data-date-format="yyyy-mm-dd" readonly />
							</div>
						</div>
						<div class="clearfix"></div>
					<div class="col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>飞机注册号</div>
								<div class="font-size-9 line-height-18">A/C REG</div>
							</label>
							<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
							<select class='form-control' id='fjzch_search' name="fjzch_search" >
									
							</select>
							</div>
						</div>
					
						<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-1 col-sm-2 col-xs-1 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">备注</div>
								<div class="font-size-9 line-height-18">Remark</div>
							</label>
							<div class="col-lg-11 col-sm-10 col-xs-11 padding-left-8 padding-right-0">
								<textarea class="form-control" id="inventorybz" name="inventorybz" placeholder='长度最大为300' maxlength="300"></textarea>
							</div>
						</div>
						</form>
					</div>
				</form>
				
				<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0" style="margin-bottom: 10px;">
					<div class="clearfix"></div>
					
					<div class="panel-heading padding-left-16 padding-top-3 padding-bottom-10 col-xs-12 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
						<div class=" pull-left margin-right-10" >
							<div class="font-size-16 line-height-18">出库清单</div>
							<div class="font-size-9 ">Outstock List</div>
						</div>	
			          		<div class="pull-left margin-bottom-10">
							<button id="btnGoAdd"  class="btn btn-primary " onclick="javascript:changerepertory()">
								<i class="icon-plus cursor-pointer"></i>
							</button>
			          	</div>
					</div>
				
	            	<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 margin-bottom-10">

						<!-- start:table -->
						<div class="margin-top-0 ">
						<div class="col-xs-12 text-center margin-bottom-0 padding-left-0 padding-right-0 padding-top-0"  style="overflow-x:scroll">
							<table id="detailTable" class="table table-bordered table-striped table-set" style="min-width:1400px">
								<thead>
							   		<tr>
										<th class="colwidth-5" style="vertical-align: middle;">
											<div class="font-size-12 notwrap">操作</div>
											<div class="font-size-9 notwrap">Operation</div>
										</th>
										<th class="colwidth-5">
											<div class="font-size-12 notwrap">序号</div>
											<div class="font-size-9 notwrap">No.</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">件号</div>
											<div class="font-size-9 notwrap">P/N</div>
										</th>
										<th class="colwidth-20">
											<div class="font-size-12 notwrap">英文名称</div>
											<div class="font-size-9 notwrap">F.Name</div>
										</th>
										<th class="colwidth-20">
											<div class="font-size-12 notwrap">中文名称</div>
											<div class="font-size-9 notwrap">CH.Name</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">厂家件号</div>
											<div class="font-size-9 notwrap">MP/N</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">航材类型</div>
											<div class="font-size-9 notwrap">Airmaterial type</div>
										</th>
										<th class="colwidth-10">
											<div class="font-size-12 notwrap">序列号/批次号</div>
											<div class="font-size-9 notwrap">S/N</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">适航证号</div>
											<div class="font-size-9 notwrap">Certificate</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">仓库</div>
											<div class="font-size-9 notwrap">Store</div>
										</th>
										<th class="colwidth-8">
											<div class="font-size-12 notwrap">库位</div>
											<div class="font-size-9 notwrap">Storage location</div>
										</th>
										<th class="colwidth-5">
											<div class="font-size-12 notwrap">库存数</div>
											<div class="font-size-9 notwrap">Stock Num</div>
										</th>
										<th class="colwidth-5">
											<div class="font-size-12 notwrap">单位</div>
											<div class="font-size-9 notwrap">Unit</div>
										</th>
										<th class="">
											<div class="font-size-12 notwrap">出库数</div>
											<div class="font-size-9 notwrap">Outstock Num</div>
										</th>
							 		 </tr>
								</thead>
								<tbody id="detailTBody">
									<c:forEach items="${stocklist}" var="item" varStatus="status">
										<tr id="${item.id}">
										<td style="vertical-align: middle;" class="text-center">
										<i class="icon-trash color-blue cursor-pointer" onClick="deleteinventory('${item.id}')" title="移除  Remove"></i>
										</td>
										<td style="vertical-align: middle;" class="text-center">
										${ status.index + 1}
										</td>
										<td style="vertical-align: middle;" class="text-left" title="${erayFns:escapeStr(item.bjh)}">
									<input  type="hidden" name="id" value="${item.id}"><input  type="hidden" name="bjh" value="${erayFns:escapeStr(item.bjh)}">${erayFns:escapeStr(item.bjh)}
										</td>
										<td style="vertical-align: middle;" class="text-left" title="${erayFns:escapeStr(item.ywms)}">
										<input  type="hidden" name="ywms" value="${erayFns:escapeStr(item.ywms)}">${erayFns:escapeStr(item.ywms)}
										</td>
										<td style="vertical-align: middle;" class="text-left" title="${erayFns:escapeStr(item.zwms)}">
										<input  type="hidden" name="zwms" value="${erayFns:escapeStr(item.zwms)}">${erayFns:escapeStr(item.zwms)}
										</td>
									
										<td style="vertical-align: middle;" class="text-left" title="${erayFns:escapeStr(item.cjjh)}">
										<input  type="hidden" name="cjjh" value="${erayFns:escapeStr(item.cjjh)}">${erayFns:escapeStr(item.cjjh)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="hclx" value="${item.hclx}">
										<c:if test="${item.hclx==0}">其他</c:if>
										 <c:if test="${item.hclx==1}">航材</c:if>
										 <c:if test="${item.hclx==2}">工具设备</c:if>
										 <c:if test="${item.hclx==4}">化工品</c:if>
										 <c:if test="${item.hclx==5}">低值易耗品</c:if>
										 <c:if test="${item.hclx==6}">松散件</c:if>
										</td>
										<td style="vertical-align: middle;" class="text-left">
										 <c:if test="${erayFns:escapeStr(item.sn)!=''}"><input  type="hidden" name="sn" value="${erayFns:escapeStr(item.sn)}">${erayFns:escapeStr(item.sn)}</c:if>
										 <c:if test="${erayFns:escapeStr(item.pch)!=''}"><input  type="hidden" name="pch" value="${erayFns:escapeStr(item.pch)}">${erayFns:escapeStr(item.pch)}</c:if>
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="shzh" value="${erayFns:escapeStr(item.shzh)}">${erayFns:escapeStr(item.shzh)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="ckh" value="${erayFns:escapeStr(item.ckh)}">${erayFns:escapeStr(item.ckmc)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="kwh" value="${erayFns:escapeStr(item.kwh)}">${erayFns:escapeStr(item.kwh)}
										</td>
										<td style="vertical-align: middle;" class="text-right">
										<input  type="hidden" name="kcsl" value="${item.kcsl}">${item.kcsl}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="jldw" value="${item.jldw}">${item.jldw}</script>
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input class="form-control" type="text" name="cksl" onkeyup="clearNoNum(this)" placeholder="长度最大为10"   maxlength="10">
										</td>
							 		 </tr>		
									</c:forEach>
								</tbody>
							</table>
							</div>
						</div>
						<!-- end:table -->
			     		<div class="clearfix"></div>
					 </div> 
				</div>
				<div class="clearfix"></div>
				<div class="text-right">
					<button id="btnSubmit"  class="btn btn-primary padding-top-1 padding-bottom-1" onclick="javascript:putoutstorage()">
                    	<div class="font-size-12">出库</div>
						<div class="font-size-9">Outstock</div>
					</button>
					&nbsp;
               		<button class="btn btn-primary padding-top-1 padding-bottom-1" onclick="javascript:go()">
               			<div class="font-size-12">返回</div>
						<div class="font-size-9">Back</div>
					</button>
					
            	</div>
			</div>
		</div>
		<!-- 页面操作区 End -->
	</div>
	
		<!-------alert对话框 Start-------->
<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria- hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body padding-bottom-0" id="alertModalBody"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1" data-dismiss="modal">
					<div class="font-size-12">关闭</div>
					<div class="font-size-9">Close</div>
				</button>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript" src="${ctx}/static/js/thjw/material/outstock/warehouse_history.js"></script>
	<%@ include file="/WEB-INF/views/open_win/user.jsp"%>
	
</body>
</html>
