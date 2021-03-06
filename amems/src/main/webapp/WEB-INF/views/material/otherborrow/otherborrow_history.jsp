<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@ include file="/WEB-INF/views/common_new.jsp"%>
<script type="text/javascript">
	var pageParam = '${param.pageParam}';
</script>
</head>
<body >
	<input type="hidden" id="userId" value="${user.id}" />
	<input type="hidden" id="otheraerocadeid" value="${otheraerocade.id}" />

	<div class="page-content">
		<div class="panel panel-primary">
	<div class="panel-heading" id="NavigationBar"></div>		
			<div class="panel-body padding-bottom-0">

				<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0">
					<div class="panel-heading margin-left-16 padding-top-3 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
							<div class="font-size-16 line-height-18">基本信息</div>
							<div class="font-size-9 ">Basic Info</div>
						</div>
						<form id="form">
						
						<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">申请单号</div>
								<div class="font-size-9 line-height-18">Application No. </div>
							</label>
							<div class="col-lg-7 col-sm-7 col-xs-7 padding-left-8 padding-right-0">
								<input type="text" class="form-control" name="sqdh" value="${otheraerocade.sqdh}" id="sqdh"  readonly />
							</div>
						</div>
						
							<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">飞行队名称</div>
								<div class="font-size-9 line-height-18">Flying Team Name</div>
							</label>
							<div class="col-lg-7 col-sm-7 col-xs-7 padding-left-8 padding-right-0">
							<input type="hidden"   id="dprtCode1" value="${otheraerocade.dprtcode}" />
								<select  id="fxd" name="fxd"  class="form-control "  disabled="disabled">
							<option value="">请选择</option>
									<c:choose>
											<c:when test="${departments!=null && fn:length(departments) > 0}">
											<c:forEach items="${departments}" var="type">
												<option value="${type.id}">${erayFns:escapeStr(type.dprtname)}
												</option>
											</c:forEach>
											</c:when>
											<c:otherwise>
												<option value="">暂无飞行队 No Organization</option>
											</c:otherwise>
										</c:choose>
						    </select>
								
							</div>
						</div>
						
						<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">申请人</div>
								<div class="font-size-9 line-height-18">Applicant</div>
							</label>
							
							<div class=" col-xs-7 padding-left-8 padding-right-0 input-group">
									<div class='input-group'>
								<input type="text" class="form-control" name="username" id="username"  readonly />
								<input type="hidden" name="ckbmid" id="ckbmid" />
								<input type="hidden"  name="userid" id="userid" />
										<span class='input-group-btn'>
										  <button type="button" onclick='selectUser()' class='btn btn-primary'><i class='icon-search'></i>
										</button>
										</span>
								    </div>
							</div>
							
							
						</div>
						<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">申请日期</div>
								<div class="font-size-9 line-height-18">Application Date </div>
							</label>
							<div class="col-lg-7 col-sm-7 col-xs-7 padding-left-8 padding-right-0">
								<input type="text" class="form-control date-picker"  name="sqsj" id="sqsj"  data-date-format="yyyy-mm-dd" readonly />
							</div>
						</div>
					<div class="clearfix"></div>
						<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>出库人</div>
								<div class="font-size-9 line-height-18">Outstock Operator</div>
							</label>
							<div class=" col-xs-7 padding-left-8 padding-right-0 input-group">
									<div class='input-group'>
										<input type="text" class="form-control" name="inventoryckr" id="inventoryckr" value="${erayFns:escapeStr(user.username)} ${erayFns:escapeStr(user.realname)}" readonly />
								<input type="hidden" name="inventorymckmid" id="inventorymckmid" value="${user.bmdm}"/>
								<input type="hidden"  name="inventoryckrid" id="inventoryckrid" value="${user.id}"/>
										<span class='input-group-btn'>
										  <button type="button" onclick='selectUser1()' class='btn btn-primary'><i class='icon-search'></i>
										</button>
										</span>
								    </div>
							</div>
						</div>
						<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>出库日期</div>
								<div class="font-size-9 line-height-18">Outstock Date</div>
							</label>
							<div class="col-lg-7 col-sm-7 col-xs-7 padding-left-8 padding-right-0">
								<input type="text" class="form-control date-picker" name="inventoryckrq" id="inventoryckrq" data-date-format="yyyy-mm-dd" readonly />
							</div>
						</div>
						
					
					<div class="col-lg-3 col-sm-3 col-xs-12  padding-left-0 padding-right-0 margin-bottom-10 form-group">
							<label class="col-lg-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">借调负责人</div>
								<div class="font-size-9 line-height-18">Seconded Operator</div>
							</label>
							<div class="col-lg-7 col-sm-7 col-xs-7 padding-left-8 padding-right-0">
								<input type="text" class="form-control" name="jdfzr" id="jdfzr"  placeholder='长度最大为10' maxlength="10"  />
							</div>
						</div>
					<div class="clearfix"></div>
						<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-38 padding-right-0 ">
							<label class="col-lg-1 col-sm-1 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">备注</div>
								<div class="font-size-9 line-height-18">Remark</div>
							</label>
							<div class="col-lg-11 col-sm-11 col-xs-8 padding-left-25 padding-right-0">
								<textarea class="form-control" id="bz" name="bz" placeholder='长度最大为300' maxlength="300" ></textarea>
							</div>
						</div>
						</form>
					</div>
					
				<div class="col-sm-6 padding-left-0 border-r">
						<div class="panel-heading margin-left-16 padding-top-3 margin-bottom-10 margin-top-10" style="border-bottom: 1px solid #ccc;">
							<div class="font-size-16 line-height-18">申请航材</div>
							<div class="font-size-9 ">Application Material</div>
						</div>
			      		<div class="col-lg-12 col-md-12 padding-left-0 padding-right-0" style="margin-top: 10px;overflow-x: scroll;">
						<table class="table table-thin table-bordered table-striped table-hover table-set" style="min-width: 1200px;">
							<thead>
								<tr>
								
									<th class="colwidth-5" style="vertical-align: middle;" >
										<div class="font-size-12 line-height-18">操作</div>
										<div class="font-size-9 line-height-18">Operation</div>
									</th>
									<th class="colwidth-5">
										<div class="font-size-12 line-height-18">序号</div>
										<div class="font-size-9 line-height-18">NO.</div>
									</th>
									<th class="colwidth-7">
											<div class="font-size-12 line-height-18">件号</div>
											<div class="font-size-9 line-height-18">P/N</div>
									</th>
									<th class="colwidth-20">
											<div class="font-size-12 line-height-18">中文名称</div>
											<div class="font-size-9 line-height-18">CH.Name</div>
									</th>
									<th class="colwidth-15" >
											<div class="font-size-12 line-height-18">英文名称</div>
											<div class="font-size-9 line-height-18">F.Name</div>
									</th>
									<th class="colwidth-13" >
										<div class="font-size-12 line-height-18">航材类型</div>
										<div class="font-size-9 line-height-18">Airmaterial Type</div>
									</th>
									<th class="colwidth-7">
											<div class="font-size-12 line-height-18">序列号</div>
											<div class="font-size-9 line-height-18">S/N</div>
									</th>
									<th class="colwidth-7" >
										<div class="font-size-12 line-height-18">借入数量</div>
										<div class="font-size-9 line-height-18">Stock Count</div>
									</th>
									<th class="colwidth-5" >
										<div class="font-size-12 line-height-18">单位</div>
										<div class="font-size-9 line-height-18">Unit</div>
									</th>
									<th class="colwidth-20" >
										<div class="font-size-12 line-height-18">用途</div>
										<div class="font-size-9 line-height-18">Differ</div>
									</th>
								</tr>
							</thead>
							<tbody id="takeStockDetailList">
								<c:forEach items="${otheraerocadeDetail}" var="item" varStatus="status">
										<tr id="${item.id}">
										<td style="vertical-align: middle;" class="text-center">
										<i class="icon-trello color-blue cursor-pointer" onClick="openStockAdd('${erayFns:escapeStr(item.bjh)}')" title="选择库存  Remove"></i>
										</td>
										<td style="vertical-align: middle;" class="text-center">
										${ status.index + 1}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="id" value="${item.id}"><input  type="hidden" name="bjh" value="${erayFns:escapeStr(item.bjh)}">${erayFns:escapeStr(item.bjh)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="zwms" value="${erayFns:escapeStr(item.hcMainData.zwms)}">${erayFns:escapeStr(item.hcMainData.zwms)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="ywms" value="${erayFns:escapeStr(item.hcMainData.ywms)}">${erayFns:escapeStr(item.hcMainData.ywms)}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="hclx" value="${item.hcMainData.hclx}">
										 <c:if test="${item.hcMainData.hclx==0}">其他</c:if>
										 <c:if test="${item.hcMainData.hclx==1}">航材</c:if>
										 <c:if test="${item.hcMainData.hclx==2}">工具设备</c:if>
										 <c:if test="${item.hcMainData.hclx==4}">化工品</c:if>
										 <c:if test="${item.hcMainData.hclx==5}">低值易耗品</c:if>
										 <c:if test="${item.hcMainData.hclx==6}">松散件</c:if>
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="sn" value="${erayFns:escapeStr(item.sn)}">${erayFns:escapeStr(item.sn)}
										</td>
										<td style="vertical-align: middle;" class="text-right">
										<input  type="hidden" name="sqsl" value="${item.sqsl}">${item.sqsl}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="jldw" value="${item.hcMainData.jldw}">${item.hcMainData.jldw}
										</td>
										<td style="vertical-align: middle;" class="text-left">
										<input  type="hidden" name="yt" value="${erayFns:escapeStr(item.yt)}">${erayFns:escapeStr(item.yt)}
										</td>
							 		 </tr>		
									</c:forEach>
							</tbody>
						</table>
						<div class=" col-xs-12  text-center " style="margin-top: 0px; margin-bottom: 0px;" id="takeStockDetailPagination"></div>
					</div>
				</div>
				
				<div class="col-sm-6">
					<div class="panel-heading margin-left-16 padding-top-3 margin-bottom-10 margin-top-10" style="border-bottom: 1px solid #ccc;">
							<div class="font-size-16 line-height-18">出库清单</div>
							<div class="font-size-9 ">Outstock List</div>
						</div>
					<div class="col-lg-12 col-md-12 padding-left-0 padding-right-0" style="margin-top: 10px;overflow-x: scroll;">
						<table class="table table-thin table-bordered table-striped table-hover table-set" style="min-width: 1400px;">
							<thead>
									<tr>
									<th class="colwidth-7" style="vertical-align: middle;">
											<div class="font-size-12 line-height-18">操作</div>
											<div class="font-size-9 line-height-18">Operation</div>
									</th>
									<th class="colwidth-5" >
										<div class="font-size-12 line-height-18">序号</div>
										<div class="font-size-9 line-height-18">NO.</div>
									</th>
									<th class="colwidth-10" >
											<div class="font-size-12 line-height-18">件号</div>
											<div class="font-size-9 line-height-18">P/N</div>
									</th>
									<th class="colwidth-15" >
											<div class="font-size-12 line-height-18">中文名称</div>
											<div class="font-size-9 line-height-18">CH.Name</div>
									</th>
									<th class="colwidth-15">
											<div class="font-size-12 line-height-18">英文名称</div>
											<div class="font-size-9 line-height-18">F.Name</div>
									</th>
									<th class="colwidth-13" >
										<div class="font-size-12 line-height-18">航材类型</div>
										<div class="font-size-9 line-height-18">Airmaterial Type</div>
									</th>
									<th class="colwidth-9" >
										<div class="font-size-12 line-height-18">管理级别</div>
										<div class="font-size-9 line-height-18">Level</div>
									</th>
									<th class="colwidth-10" >
											<div class="font-size-12 line-height-18">序列号/批次号</div>
											<div class="font-size-9 line-height-18">S/N</div>
									</th>
									<th class="colwidth-9" >
										<div class="font-size-12 line-height-18">库存数量</div>
										<div class="font-size-9 line-height-18">Stock Count</div>
									</th>
									<th class="colwidth-9" >
										<div class="font-size-12 line-height-18">出库数量</div>
										<div class="font-size-9 line-height-18">Stock Count</div>
									</th>
									<th class="colwidth-9" >
										<div class="font-size-12 line-height-18">单位</div>
										<div class="font-size-9 line-height-18">Unit</div>
									</th>
									
								</tr>
							</thead>
							<tbody id="reserveTable"></tbody>
						</table>
						<div class=" col-xs-12  text-center " style="margin-top: 0px; margin-bottom: 0px;" id="takeStockDetailPagination"></div>
					</div>
				</div>
				<div class="text-right margin-top-10 margin-bottom-0">
			<button onclick="putoutstorage()"
				class="btn btn-primary padding-top-1 padding-bottom-1 margin-top-10">
				<div class="font-size-12">出库</div>
				<div class="font-size-9">Outstock</div>
			</button>
			<button onclick="go()"
				class="btn btn-primary padding-top-1 padding-bottom-1 margin-top-10">
				<div class="font-size-12">返回</div>
				<div class="font-size-9">Outstock</div>
			</button>
		</div>
			</div>
		</div>
	</div>
	
	<!-------库存对话框 Start-------->
	<div class="modal fade" id="alertModalStockAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:1200px;">
			<div class="modal-content">	
				<div class="modal-body padding-bottom-0" id="alertModalUserBody">
					<div class="panel panel-primary">
						<div class="panel-heading  padding-top-3 padding-bottom-1">
							<div class="font-size-16 line-height-18" >库存选择</div>
							<div class="font-size-9 ">Stock Option</div>
						</div>
						<div class="panel-body padding-top-0 padding-bottom-0">
			            	<div class="col-lg-12 col-xs-12 padding-left-0 padding-right-0">
			            	<div class=" pull-right padding-left-0 padding-right-0 margin-top-10">
							
								<div class=" pull-left padding-left-5 padding-right-0" style="width: 260px;">
									<span class="pull-left col-xs-4 col-sm-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12">航材类型</div>
										<div class="font-size-9">Airmaterial Type</div>
									</span>
									<div class=" col-xs-8 col-sm-8 padding-left-8 padding-right-10">
											<select class='form-control' id='other_hclx_search' onchange="searchStockAdd()">
												<option value="" >显示全部</option>
												<c:forEach items="${materialTypeEnum}" var="item">
													<option value="${item.id}" <c:if test="${100 == item.id }">selected=true</c:if> >${erayFns:escapeStr(item.name)}</option>
												</c:forEach>
										    </select>
									</div>
								</div>	
								<!-- 搜索框start -->
								<div class=" pull-right padding-left-0 padding-right-0">
									<div class=" pull-left padding-left-0 padding-right-0" style="width: 250px;">
										<input type="text" placeholder='件号/中英文' id="keyword_otherStock_search" class="form-control ">
									</div>
				                    <div class=" pull-right padding-left-5 padding-right-0 ">   
										<button type="button" class=" btn btn-primary padding-top-1 padding-bottom-1 " onclick="searchStockAdd()">
											<div class="font-size-12">搜索</div>
											<div class="font-size-9">Search</div>
				                   		</button>
				                    </div> 
								</div>
								<!-- 搜索框end -->		
				         		</div>
			            	
	<div class="clearfix"></div>
				                
							<!-- start:table -->
							<div class="margin-top-10 ">
								<div class="overflow-auto">
									<table class="table table-bordered table-striped table-hover table-set" style="min-width:800px">
										<thead>
									   		<tr>
												<th class="colwidth-5" style="vertical-align: middle;">
													<div class="font-size-12 notwrap">操作</div>
													<div class="font-size-9 notwrap">Operation</div>
												</th>
												<th class="colwidth-5">
													<div class="font-size-12 notwrap">序号</div>
													<div class="font-size-9 notwrap">P/N</div>
												</th>
												<th class="colwidth-15">	<div class="important">
													<div class="font-size-12 notwrap">件号</div>
													<div class="font-size-9 notwrap">P/N</div></div>
												</th>
												<th class="colwidth-15">	<div class="important">
													<div class="font-size-12 notwrap">英文名称</div>
													<div class="font-size-9 notwrap">F.Name</div></div>
												</th>
												<th class="colwidth-20">	<div class="important">
													<div class="font-size-12 notwrap">中文名称</div>
													<div class="font-size-9 notwrap">CH.Name</div></div>
												</th>
												<th class="colwidth-7">
													<div class="font-size-12 notwrap">航材类型</div>
													<div class="font-size-9 notwrap">Airmaterial type</div>
												</th>
												<th class="colwidth-7">
													<div class="font-size-12 notwrap">航材管理级别</div>
													<div class="font-size-9 notwrap">ATA</div>
												</th>
												<th class="colwidth-15">
													<div class="font-size-12 notwrap">序列号/批次号</div>
													<div class="font-size-9 notwrap">Aircraft Type</div>
												</th>
												<th class="colwidth-7">
													<div class="font-size-12 notwrap">货架寿命</div>
													<div class="font-size-9 notwrap">Stock Num</div>
												</th>
												<th class="colwidth-5">
													<div class="font-size-12 notwrap">单位</div>
													<div class="font-size-9 notwrap">Unit</div>
												</th>
									 		 </tr>
										</thead>
										<tbody id="StockAdd">
										
										</tbody>
									</table>
									</div>
									<div class="col-xs-12 text-center" id="StockAddPagination">
									
									</div>
								</div>
								<!-- end:table -->
			                	<div class="text-right margin-top-10 margin-bottom-10">
									<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1" data-dismiss="modal">
										<div class="font-size-12">关闭</div>
										<div class="font-size-9">Close</div>
									</button>
				                </div>
					     		<div class="clearfix"></div>
						 	 </div>
						 </div> 
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-------库存对话框 End-------->   
<script type="text/javascript" src="${ctx}/static/js/thjw/material/otherborrow/otherborrow_history.js"></script>
<script type="text/javascript" src="${ctx}/static/js/thjw/common/openStockAdd.js"></script>
<%@ include file="/WEB-INF/views/open_win/user.jsp"%>
</body>
</html>