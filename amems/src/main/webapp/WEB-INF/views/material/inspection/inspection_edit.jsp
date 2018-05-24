<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>检验航材信息</title>
<%@ include file="/WEB-INF/views/common_new.jsp"%>

<script>
var pageParam = '${param.pageParam}';
</script>
</head>
<body>
<div class="page-content ">
			<!-- from start -->
	<div class="panel panel-primary">
	<div class="panel-heading" id="NavigationBar"></div>
		<div class="panel-body" id="open_win_installationlist_replace">
			   <input type="hidden" id="id" value="${queryQuality.id}">
 			   <input type="hidden" id="zdbmid" value="${user.bmdm}" />
 			   <input type="hidden" id="zdbmid" value="${user.bmdm}" />
			   <input type="hidden" id="zdrid" value="${sessionScope.user.id}" />
			   <input type="hidden" id="kwid" value="${queryQuality.storage.id}" />
			   <input type="hidden" id="ckid" value="${queryQuality.store.id}" />
			   <input type="hidden" id="gg" value="${queryQuality.hcMainData.gg}" />
			   <input type="hidden" id="xh" value="${queryQuality.hcMainData.xh}" />
			   <input type="hidden" id="ckh" value="${queryQuality.store.ckh}" />
			   <input type="hidden" id="bjid" value="${queryQuality.receiptSheetDetail.bjid}" />
			   <input type="hidden" id="cklb" value="${queryQuality.store.cklb}" />
			   <input type="hidden" id="xgdjid" value="${queryQuality.receiptSheetDetail.xgdjid}" />
			   <input type="hidden" id="shdid" value="${queryQuality.shdid}" />
			   <input type="hidden" id="shdmxid" value="${queryQuality.shdmxid}" />
			   <input type="hidden" id="shlx" value="${queryQuality.receiptSheet.shlx}" />
			   <input type="hidden" id="kcid" value="${queryQuality.materialHistory.kcid}" />
			   <input type="hidden" id="hclynoe" value="${queryQuality.hcly}" />
			  <div class="panel panel-default">
				        <div class="panel-heading">
						 <h3 class="panel-title">基本信息  Basic Information</h3>
					    </div>
				<div class="panel-body">	
					
					
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 " >
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">检验单号</div>
								<div class="font-size-9 line-height-18">Check No.</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" value="${erayFns:escapeStr(queryQuality.jydh)}" id="jydh" class="form-control " readonly />
								<input type="hidden" value="${queryQuality.dprtcode}" id="dprtcode" class="form-control " readonly />
							</div>
						</div>
						<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								    <div class="font-size-12 line-height-18">部件号</div>
									<div class="font-size-9 line-height-18">P/N</div></label>
							<div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
							    <input type="text" id="bjh"  class="form-control" value="${erayFns:escapeStr(queryQuality.hcMainData.bjh)}"  disabled="disabled"/>
							</div>
						</div>
					   	<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 ">
								<label class="col-lg-4 col-sm-4 col-xs-4  text-right padding-left-0 padding-right-0">
							    <div class="font-size-12 line-height-18">管理级别</div>
								<div class="font-size-9 line-height-18"> level</div></label>
								<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
									   <select id="gljb" class="form-control"  disabled="disabled">
											<c:forEach items="${supervisoryLevelEnum}" var="item">
											  <option value="${item.id}" <c:if test="${queryQuality.hcMainData.gljb == item.id }">selected="true"</c:if> >${item.name}</option>
											</c:forEach>
									   </select>
							   </div>
					    </div>
					  	<div class=" col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 ">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
							    <div class="font-size-12 line-height-18">序列号</div>
								<div class="font-size-9 line-height-18">S/N</div></label>
							   <div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
									<input type="text"  class="form-control"  value="${erayFns:escapeStr(queryQuality.receiptSheetDetail.sn)}" disabled="disabled"/>
									<input type="hidden" id="pch" value="${erayFns:escapeStr(queryQuality.receiptSheetDetail.pch)}">
									<input type="hidden" id="xlh" value="${erayFns:escapeStr(queryQuality.receiptSheetDetail.sn)}">
								</div>
				    	</div>
				    	<div class="clearfix">
					    	<div class=" col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 ">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
							    <div class="font-size-12 line-height-18">批次号</div>
								<div class="font-size-9 line-height-18">B/N</div></label>
							   <div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
									<input type="text"  class="form-control"  value="${erayFns:escapeStr(queryQuality.receiptSheetDetail.pch)} " disabled="disabled"/>									
								</div>
					    	</div>
					   		 <div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
									    <div class="font-size-12 line-height-18">中文名称</div>
										<div class="font-size-9 line-height-18">CH.Name</div></label>
								<div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
								    <input type="text" id="zwms" class="form-control" value="${erayFns:escapeStr(queryQuality.hcMainData.zwms)}"  disabled="disabled"/>
								</div>
							</div>
					   		<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
							    <div class="font-size-12 line-height-18">英文名称</div>
								<div class="font-size-9 line-height-18">F.Name</div></label>
							   <div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
								 <input type="text" class="form-control" id="ywms"  value="${erayFns:escapeStr(queryQuality.hcMainData.ywms)}" disabled="disabled"/>
							   </div>
					    	</div>					     	
						  	<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0">
									<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								    <div class="font-size-12 line-height-18">数量</div>
									<div class="font-size-9 line-height-18">Num</div></label>
								   <div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 form-group">
										<input type="text"  class="form-control"  id="sl" value="${queryQuality.receiptSheetDetail.sl}" disabled="disabled"/>
								 </div>
						    </div>
						  <div class="clearfix"></div>
						    <div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class=" col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">计量单位</div>
										<div class="font-size-9 line-height-18">Unit</div>
									</label>
									<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input type="text" value="${erayFns:escapeStr(queryQuality.hcMainData.jldw)}" id="jldw" class="form-control " readonly />
									</div>
						    </div>						    
							<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
									<div class="font-size-12 line-height-18">仓库名称</div>
									<div class="font-size-9 line-height-18"> Store Name</div>
								</label>
								<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
									<input type="text" value="${erayFns:escapeStr(queryQuality.store.ckmc)}" id="ckmc" class="form-control " readonly />
								</div>
							</div>
							<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">库位号</div>
										<div class="font-size-9 line-height-18">Storage </div>
									</label>
									<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input type="text" value="${erayFns:escapeStr(queryQuality.storage.kwh)}" id="kwh" class="form-control " readonly />
									</div>
							</div>
							<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
									<div class="font-size-12 line-height-18">航材类型</div>
									<div class="font-size-9 line-height-18"> Type</div>
								</label>
								<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
									 <select id="hclx" class="form-control"  disabled="disabled">
										<c:forEach items="${materialTypeEnum}" var="item">
										  <option value="${item.id}" <c:if test="${queryQuality.hcMainData.hclx == item.id }">selected="true"</c:if> >${item.name}</option>
										</c:forEach>
								     </select>
								</div>
							</div>
							<div class="clearfix">
							<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">收货单号</div>
										<div class="font-size-9 line-height-18">Receipt No.</div>
									</label>
									<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input type="text" value="${erayFns:escapeStr(queryQuality.receiptSheet.shdh)}" id="shdh" class="form-control " readonly />
									</div>
							</div>						
							<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">发货单位</div>
										<div class="font-size-9 line-height-18">Delivery</div>
									</label>
									<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input type="text" value="${erayFns:escapeStr(queryQuality.receiptSheet.fhdw)}" id="fhdw" class="form-control " readonly />
									</div>
							</div>
					</div>
			    
			 </div>
			 
			  <div class="panel panel-default">
				        <div class="panel-heading">
						  <h3 class="panel-title">航材检验  Material Checking</h3>
					    </div>
				<div class="panel-body">
				   <form id="form">			   
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4  text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">航材来源</div>
								<div class="font-size-9 line-height-18">Aircraft Source</div>
							</label>
							<div id="hclyDiv" class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								 <select id="hcly" class="form-control" name="hcly" >
							     </select>
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">货架寿命</div>
								<div class="font-size-9 line-height-18">Shelf-Life</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" id="hjsm" maxlength="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${queryQuality.hjsm}"/>" name="hjsm" class='form-control datepicker'  data-date-format="yyyy-mm-dd"/>
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">TSN</div>
								<div class="font-size-9 line-height-18">TSN</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 ">
								<input type="text" value="${erayFns:escapeStr(queryQuality.tsn)}" id="tsn"  name="tsn" maxlength="50" class="form-control " />
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">TSO</div>
								<div class="font-size-9 line-height-18">TSO</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 ">
								<input type="text" value="${erayFns:escapeStr(queryQuality.tso)}" id="tso"  name="tso"  maxlength="50" class="form-control "  />
							</div>
						</div>
						<div class=" col-lg-3 col-sm-6 col-xs-12  padding-left-0 padding-right-0 form-group">
								<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
							    <div class="font-size-12 line-height-18">制造厂商</div>
								<div class="font-size-9 line-height-18">Manufacturer</div></label>
							   <div class="col-lg-8 col-sm-8 col-xs-8  padding-left-8 padding-right-0 ">
								 <input type="text" id="zzcs" class="form-control" maxlength="16" value="${erayFns:escapeStr(queryQuality.zzcs)}" />
							   </div>
					    	</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">生产日期</div>
								<div class="font-size-9 line-height-18">Shelf-Life</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" id="scrq" maxlength="10" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${queryQuality.scrq}"/>" name="scrq" class='form-control datepicker'  data-date-format="yyyy-mm-dd"/>
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">GRN</div>
								<div class="font-size-9 line-height-18">GRN</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 ">
								<input type="text" value="${erayFns:escapeStr(queryQuality.grn)}" id="grn"  name="grn" maxlength="50" class="form-control " />
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">CSN</div>
								<div class="font-size-9 line-height-18">CSN</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 ">
								<input type="text" value="${erayFns:escapeStr(queryQuality.csn)}" id="csn"  name="csn" maxlength="50" class="form-control " />
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18">CSO</div>
								<div class="font-size-9 line-height-18">CSO</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 ">
								<input type="text" value="${erayFns:escapeStr(queryQuality.cso)}" id="cso"  name=""cso"" maxlength="50" class="form-control " />
							</div>
						</div>
				     <div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-1 col-sm-2 col-xs-4 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 line-height-18">存放要求</div>
							<div class="font-size-9 line-height-18">Storage Must</div>
						</label>
						<div class="col-lg-11 col-sm-10 col-xs-8  padding-left-8 padding-right-0 ">
							<textarea class="form-control"  id="cfyq" name="cfyq" maxlength="150" placeholder="最大长度不超过150">${erayFns:escapeStr(queryQuality.cfyq)}</textarea>
						</div>
					</div>
					<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-1 col-sm-2 col-xs-4 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 line-height-18">备注</div>
							<div class="font-size-9 line-height-18">Remark</div>
						</label>
						<div class="col-lg-11 col-sm-10 col-xs-8  padding-left-8 padding-right-0 ">
							<textarea class="form-control" id="bz" name="bz" maxlength="300" placeholder="最大长度不超过300" >${erayFns:escapeStr(queryQuality.bz)}</textarea>
						</div>
					</div>
				         <div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>检验人</div>
								<div class="font-size-9 line-height-18">Inspection</div>
							</label>
							 <div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 input-group">
								<div class='input-group'>
								<input type="text" id="checker" disabled="disabled"  value="${queryQuality.jyr.username} ${queryQuality.jyr.realname}" class="form-control "  onchange="ChangeJyr()"/>							 	
							 	<input type="hidden" class="form-control" id="jyrid" value="${queryQuality.jyrid}" name="jyrid"/>
							 	<input type="hidden" class="form-control" id="dlrname" value="${sessionScope.user.username} ${sessionScope.user.realname}" />							 						
									<span class='input-group-btn'>
									  <button onclick='openUserList()' type="button" class='btn btn-primary'><i class='icon-search'></i>
									</button></span>
							    </div>
							</div>
							 
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>检验日期</div>
								<div class="font-size-9 line-height-18">Date</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" class='form-control datepicker' maxlength="10" id="jyrq" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${queryQuality.jyrq}"/>"    data-date-format="yyyy-mm-dd" 
			         		       placeholder="请选择日期"   />
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>可用数</div>
								<div class="font-size-9 line-height-18">Available No.</div>
							</label>
							<div class=" col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
								<input type="text" id="kysl" class='form-control' value="${queryQuality.kysl}"   name="kysl" />
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
							<label class="col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color: red">*</span>检验结果</div>
								<div class="font-size-9 line-height-18">Result</div>
							</label>
							<div class=" col-xs-8 padding-left-8 padding-right-0">
									<select class='form-control' id='jyjg' >
										<option value="1" <c:if test="${queryQuality.jyjg=='1'}">selected</c:if> >合格Qualified</option>
										<option value="2" <c:if test="${queryQuality.jyjg=='2'}">selected</c:if> >不合格Unqualified</option>
										<option value="3" <c:if test="${queryQuality.jyjg=='3'}">selected</c:if> >让步接收Compromise</option>
								    </select>
							</div>
						</div>
						<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group" >
							<label class="col-lg-1 col-sm-2 col-xs-4 text-right padding-left-0 padding-right-0">
								<div class="font-size-12 line-height-18"><span style="color:red">*</span>结果说明</div>
								<div class="font-size-9 line-height-18">Checked desc</div>
							</label>
							<div class="col-lg-11 col-sm-10 col-xs-8  padding-left-8 padding-right-0">
								<textarea class="form-control" id="jgsm" name="jgsm" maxlength="30">${erayFns:escapeStr(queryQuality.jgsm)}</textarea>
							</div>
					   </div>
					   </form>
					</div>	
				</div> 
				
				<%@ include file="/WEB-INF/views/quality/testing/maintenance_project_view.jsp"%><!-- 适用维修项目  Maintenance Item -->
				
			 	<div class="panel panel-default">
			        <div class="panel-heading">
					  <h3 class="panel-title">证书信息  Certificate Info</h3>
				    </div>
					<div class="panel-body">	
				      	<div  class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0" style="overflow: auto;" >
							<table class="table table-thin table-bordered table-striped table-hover table-set" name="installationlist_certificate_table">
								<thead>
									<tr>
										<th class="colwidth-7" name="common_certificate_addTh">
											<button class="line6 line6-btn" name="common_certificate_addBtn" type="button">
												<i class="icon-plus cursor-pointer color-blue cursor-pointer"></i>
											</button>
									    </th>
										<th class="colwidth-20">
										   <div class="font-size-12 line-height-12">证书类型</div>
									        <div class="font-size-9 line-height-12">Certificate Type</div>
										</th>
										<th class="colwidth-10">
										   <div class="font-size-12 line-height-12">证书编号</div>
									        <div class="font-size-9 line-height-12">Certificate No.</div>
										</th>
										<th class="colwidth-10">
										   <div class="font-size-12 line-height-12">存放位置</div>
									        <div class="font-size-9 line-height-12">Certificate Location</div>
										</th>
										<th class="colwidth-10">
										   <div class="font-size-12 line-height-12">签署日期</div>
									        <div class="font-size-9 line-height-12">Sign Date</div>
										</th>
										<th class="colwidth-7">
										   <div class="font-size-12 line-height-12">附件</div>
									        <div class="font-size-9 line-height-12">Attachment</div>
										</th>
									</tr>
								</thead>
										
								<tbody id="replace_certificate_list"><tr><td class="text-center" colspan="6">暂无数据 No data.</td></tr></tbody>
							</table>
						</div>
					</div>	
				</div>	
		  
			 <div class="panel panel-default">
			        <div class="panel-heading">
					  <h3 class="panel-title">检验附件  Attachments Files</h3>
				    </div>
				<div class="panel-body">	
				   <div class=" col-lg-4 col-sm-6 col-xs-8  padding-left-0 padding-right-0 margin-bottom-10 form-group" >
						<label class="col-lg-3 col-sm-4 col-xs-6 text-right padding-left-0 padding-right-0"><div
								class="font-size-12 line-height-18"><span style="color: red"></span>文件说明</div>
							<div class="font-size-9 line-height-18">File desc</div></label>
						 <div class="col-lg-9 col-sm-8 col-xs-6 padding-left-8 padding-right-0" >
							<input type="text" id="wbwjm" name="wbwjm" maxlength="90" class="form-control "  >
						</div>
					</div>
				     <div class=" col-lg-4 col-sm-1 col-xs-4  padding-left-0 padding-right-0 margin-bottom-10 form-group" >
						<div id="fileuploader" class="col-lg-2 col-sm-2 col-xs-12 "  style="margin-left: 5px ;padding-left: 0"></div>
					</div> 
				      <div  class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0" style="overflow: auto;" >
						<table class="table table-thin table-bordered table-striped table-hover text-center" style="min-width:900px">
							<thead>
								<tr>
									<th style="width:110px;"><div class="font-size-12 line-height-18 " >操作</div>
										<div class="font-size-9 line-height-18">Operation</div></th>
								   <th>
								       <div class="font-size-12 line-height-18">文件说明</div>
										<div class="font-size-9 line-height-18">File desc</div>
									</th>
									<th>
									<div class="font-size-12 line-height-18">文件大小</div>
										<div class="font-size-9 line-height-18">File size</div>
									</th>
									<th><div class="font-size-12 line-height-18">上传人</div>
										<div class="font-size-9 line-height-18">Operator</div></th>
									<th><div class="font-size-12 line-height-18">上传时间</div>
										<div class="font-size-9 line-height-18">Operate Time</div></th>					
								</tr>
							</thead>
							    <tbody id="filelist">
									 
								</tbody>
						</table>
					</div>
				</div>	
			</div>	
				
				<div class="text-right" style="margin-top: 10px;margin-bottom: 0px;">
                    <button type="button" class="btn btn-primary padding-top-1 padding-bottom-1"  onclick="checkSave()">
                    	<div class="font-size-12">保存</div>
						<div class="font-size-9">Save</div></button>
						
						<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1" onclick="submitSave()">
                    	<div class="font-size-12">提交</div>
						<div class="font-size-9">Submit</div></button>
						
					<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1" onclick="back();">
                   	<div class="font-size-12">返回</div>
					<div class="font-size-9">Back</div></button>
                 </div>
				</div>
			</div>
		</div>
		</div>
		</div>
			
<!-- 基本信息 End -->
	<%@ include file="/WEB-INF/views/open_win/user.jsp"%>
	<script src="${ctx}/static/js/thjw/common/preview.js"></script>
<link href="${ctx }/static//js/tool/jquery-upload-file-master/css/uploadfile.css" rel="stylesheet">
<script src="${ctx }/static//js/tool/jquery-upload-file-master/jquery.uploadfile.min.js"></script>	 	
<script type="text/javascript" src="${ctx}/static/js/thjw/material/inspection/inspection_edit.js"></script>
<%@ include file="/WEB-INF/views/produce/installationlist/installationlist_certificate.jsp"%>
<script type="text/javascript" src="${ctx}/static/js/Math.uuid.js"></script>
<%@ include file="/WEB-INF/views/open_win/history_attach_win.jsp"%><!------附件对话框 -------->
<script type="text/javascript" src="${ctx}/static/js/thjw/common/webuiPopoverUtil.js"></script><!-- 控件对话框 -->
</body>
</html>