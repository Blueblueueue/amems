<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>维修方案差异信息</title>
<%@ include file="/WEB-INF/views/common_new.jsp"%>
<script>
var id = "${param.id}";
var pageParam = '${param.pageParam}';
</script>
<style type="text/css">
	.normal-font label {
    	font-weight: normal !important;
	}
	.form-group {
		margin-bottom: 5px;
	}
	.panel-heading {
	    border-top-right-radius: 0px;
	    border-top-left-radius: 0px;
	}
	.panel{
		-webkit-box-shadow: none;
	}
	
	#itemList li.active {
		background:#eaeaea!important;
	}
	
	#itemList li:hover {
		background: #f5f5f5;
		cursor: pointer;
	}
	
</style>
</head>
<body>
    
	<div class="page-content">
		<div class="panel panel-primary">
			<div class="panel-heading " id="NavigationBar">
			</div>
			<input type="hidden" id="wxfaid" value="${param.id}"/>
			<div class="panel-body padding-bottom-0">
				 <div class=" col-xs-12 col-md-12 col-lg-12 padding-left-0 padding-right-0  normal-font row-height">
				 	<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">机型</div>
							<div class="font-size-9">A/C Type</div>
						</label>
						<div class="col-lg-7 col-md-7 col-sm-7 col-xs-7 padding-leftright-8">
							<label class="margin-top-8" id="jx"></label>
						</div>
					</div>
					<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">维修方案</div>
							<div class="font-size-9">MP</div>
						</label>
						<div class="col-lg-7 col-md-7 col-sm-7 col-xs-7 padding-leftright-8">
							<label class="margin-top-8" id="wxfabh"></label>
						</div>
					</div>
				 	<div class="col-lg-4 col-sm-6 col-xs-12  padding-left-0 padding-right-0" id="historyDiv">
						<label class="col-lg-3 col-sm-3 col-xs-3 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">版本</div>
							<div class="font-size-9">Rev.</div>
						</label>
						<div class="col-lg-9 col-sm-9 col-xs-9 padding-leftright-8">
							<label class="margin-top-8">
								<span id="bbSpan"></span>
								<span id="lastBbSpan">
									&nbsp;&lt;--
									<span id="lastBbData"></span>
									<a href="javascript:void(0);" title="历史列表 List">
										<i class="attachment-view2 glyphicon glyphicon glyphicon-list cursor-pointer" style="font-size:15px"></i>
									</a>
								</span>
							</label>
						</div>
					</div>
					<div class="pull-right">
						<div class=" pull-right padding-left-5 padding-right-0 ">   
							<button type="button" class=" btn btn-primary padding-top-1 padding-bottom-1" onclick="viewDifference()">
								<div class="font-size-12">查看差异表</div>
								<div class="font-size-9">Difference</div>
	                   		</button>
	                   		
	                   		<button type="button" class=" btn btn-primary padding-top-1 padding-bottom-1 " onclick="outMaintenance()">
								<div class="font-size-12">导出</div>
								<div class="font-size-9">Export</div>
		                 	</button>
	                   		
	                    </div>
					</div>
				 </div>
			
			   	 <div class=" col-xs-12 col-md-12 col-lg-12 padding-left-0 padding-right-0">
			   	  <div class="col-xs-3 col-md-3 col-lg-3 padding-left-0" style="padding-right:5px;">
			   	  		 <div class="panel panel-default" id="left_panel">
				       	 <div class="panel-heading">
								<div class="font-size-14">维修项目清单</div>
								<div class="font-size-12">Maintenance Item List</div>
								
					     </div> 
				        <div class="panel-body padding-bottom-0 padding-left-0 padding-right-0" id="itemList"></div> 
			   	    </div> 
			   	   
			   	   
			   	  </div>
			   	 <div class="col-xs-9 col-md-9 col-lg-9 padding-left-0 padding-right-0">
			   	 <div class="panel panel-default" id="right_panel">
			   	 	<div class="panel-heading">
						  <div class="font-size-14">维修项目对比</div>
						  <div class="font-size-12">Maintenance Project Comparison</div>
					</div>
					
			   	 <div class="panel-body padding-bottom-0  normal-font padding-top-0">	 

			      <div class="col-lg-6 padding-left-0 padding-right-0" id="current_panel">
			        <div class="panel panel-default" style="margin-right: -1px;border:none;margin-bottom:0px;" >
				        <div class="panel-heading padding-left-0 padding-right-0" style="background-color:white;">
						  <div class="panel-subtitle">
						   <em>维修项目版本:</em>
						   <span class="col-lg-6 padding-left-0 padding-right-0" id="current_bb"></span>
						  </div>
					   </div>
				  <div class="panel-body padding-bottom-0 padding-left-0">	 	
				  <div class="describe" name="main_body"> 	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 padding-left-0 padding-right-0 text-right">
							<i validate="rii,ali,yxbs" class="icon-circle pull-left" style="display: none;"></i>
							<span id="current_wxxmlx" class="pull-right"></span>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span><label class="notPackage" style="margin-right: 20px;"><input type="checkbox" id="current_rii" disabled="disabled"/> RII</label><label class="notPackage" style="margin-right: 20px;"><input type="checkbox" id="current_ali" disabled="disabled"/> ALI</label><i id="current_yxbs"></i> </span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2"><i validate="rwh" class="icon-circle pull-left" style="display: none;"></i>任务号</div>
							<div class="font-size-9">Task No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8" id="current_rwh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="ckh" class="icon-circle pull-left" style="display: none;"></i>参考号
							</div>
							<div class="font-size-9">Ref No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_ckh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="ckwj" class="icon-circle pull-left" style="display: none;"></i>参考文件
							</div>
							<div class="font-size-9">Doc</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_ckwj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="cmph" class="icon-circle pull-left" style="display: none;"></i>CMP/CAMP号
							</div>
							<div class="font-size-9">CMP No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_cmph" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="zjh" class="icon-circle pull-left" style="display: none;"></i>ATA章节号
							</div>
							<div class="font-size-9">ATA</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_zjh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="wxxmdl" class="icon-circle pull-left" style="display: none;"></i>维修项目大类
							</div>
							<div class="font-size-9">Class</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_wxxmdl" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="ssdjb" class="icon-circle pull-left" style="display: none;"></i>所属定检包
							</div>
							<div class="font-size-9">Package</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_ssdjb" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="rwms" class="icon-circle pull-left" style="display: none;"></i>任务描述
							</div>
							<div class="font-size-9">Desc</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_rwms" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="qy" class="icon-circle pull-left" style="display: none;"></i>区域
							</div>
							<div class="font-size-9">Zone</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_qy" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="jj" class="icon-circle pull-left" style="display: none;"></i>接近
							</div>
							<div class="font-size-9">Access</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_jj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="fjzw" class="icon-circle pull-left" style="display: none;"></i>飞机站位
							</div>
							<div class="font-size-9">Aircraft Stations</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_fjzw" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="xmlx" class="icon-circle pull-left" style="display: none;"></i>项目类别
							</div>
							<div class="font-size-9">Project Type</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_xmlx" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="gzlx" class="icon-circle pull-left" style="display: none;"></i>工作类别
							</div>
							<div class="font-size-9">Work Type</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_gzlx" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="gk" class="icon-circle pull-left" style="display: none;"></i>工卡
							</div>
							<div class="font-size-9">Work Card</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_gk" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="gs" class="icon-circle pull-left" style="display: none;"></i>工时
							</div>
							<div class="font-size-9">MHRs</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_gs" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="fjzch" class="icon-circle pull-left" style="display: none;"></i>飞机注册号
							</div>
							<div class="font-size-9">A/C REG</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_fjzch" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="bj" class="icon-circle pull-left" style="display: none;"></i>部件
							</div>
							<div class="font-size-9">Component</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_bj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="eo" class="icon-circle pull-left" style="display: none;"></i>取代EO
							</div>
							<div class="font-size-9">Replace</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="current_eo" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>
				   </div>
					 <div class="panel panel-default">
				       	 <div class="panel-heading bg-panel-heading">
								<div class="font-size-12">
									<i validate="jkx,jsgs,isHdwz,wz" class="icon-circle pull-left" style="display: none;"></i>监控项
								</div>
								<div class="font-size-9">Monitor Item</div>
						  </div> 
				        <div class="panel-body padding-bottom-0" name="monitor_panel_body">
				        	<div name="monitorItemDiv" class="padding-left-0 padding-right-0 col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow-x: auto;">
					        	<table class="table table-bordered table-striped table-hover text-center table-set table-thin" style="min-width: 500px;">
					        		<thead>
								   		<tr>
										<th class="colwidth-7" id="current_maintenance_version_bj">
											<div class="font-size-12 line-height-12">部件</div>
											<div class="font-size-9 line-height-12">Component</div>
										</th>
										<th class="colwidth-9" id="current_maintenance_version_jkxm">
											<div class="font-size-12 line-height-12">监控项目</div>
											<div class="font-size-9 line-height-12">Monitor Item</div>
										</th>
										<th class="colwidth-9" id="current_maintenance_version_sj">
												<div class="font-size-12 line-height-12">首检</div>
												<div class="font-size-9 line-height-12">INTI</div>	
										</th>
										<th class="colwidth-7" id="current_maintenance_version_zq">
											<div class="font-size-12 line-height-12">周期</div>
											<div class="font-size-9 line-height-12">Cycle</div>
										</th>
										<th class="colwidth-15" id="current_maintenance_version_rc">
											<div class="font-size-12 line-height-12">容差(-/+)</div>
											<div class="font-size-9 line-height-12">Tolerance(-/+)</div>
										</th>
										 </tr>
									</thead>
					        		<tbody id="current_maintenance_version_list">
					           		</tbody>
				           		</table>
			           		</div>
			           		
			           		<div class="col-sm-12 padding-left-0 padding-right-0 form-group"  id="current_jsgs_div">
		           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
		           					<div class="font-size-12 margin-topnew-2">计算公式</div>
		           					<div class="font-size-9">Formula</div>
		           				</label>
			           			<div class="col-lg-6 col-md-6 col-sm-8 col-xs-9 padding-leftright-8 margin-top-8">
			           				<span id="current_jsgs"></span>
			           			</div>
		           				<div class="col-lg-4 col-md-6 col-sm-8 col-xs-9 padding-leftright-8 label-input-div">
		           					<label class="margin-right-5 label-input"><input id="current_isHdwz" type="checkbox" disabled="disabled">&nbsp;后到为准</label>
		           				</div>
		           				
			           		</div>
			           		
			           		<div class="col-sm-12 padding-left-0 padding-right-0" id="current_wz_div">
		           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
		           					<div class="font-size-12 margin-topnew-2">发动机分类</div>
		           					<div class="font-size-9">Engine</div>
		           				</label>
			           			<div class="col-lg-4 col-md-6 col-sm-8 col-xs-9 padding-leftright-8 margin-top-8">
			           				<span id="current_wz"></span>
			           			</div>
			           		</div>
			           		
			           		<div class="col-sm-12 padding-left-0 padding-right-0">
		           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
		           					<div class="font-size-12 margin-topnew-2">间隔描述</div>
		           					<div class="font-size-9">Remark</div>
		           				</label>
			           			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12 padding-leftright-8 margin-top-8">
			           				<span id="current_jgms"></span>
			           			</div>
			           		</div>
				        </div> 	
				      </div> 
				      	
				   	  <div class="panel panel-default">
				       	 <div class="panel-heading bg-panel-heading">
							<div class="font-size-12">
								<i validate="glwxxm" class="icon-circle pull-left" style="display: none;"></i>
								<span name="associateCnHead">维修项目关联</span>
							</div>
							<div class="font-size-9">Maintenance</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="relation_panel_body">
				        	<div name="relationDiv" class="padding-left-0 padding-right-0 col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow-x: auto;">
                                  <table class="table table-bordered table-striped table-hover text-center table-set table-thin" style="min-width: 500px;">
									<thead>
								   		<tr>
											<th class="colwidth-5">
												<div class="font-size-12 line-height-12">版本</div>
												<div class="font-size-9 line-height-12">Rev.</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-12">任务号</div>
												<div class="font-size-9 line-height-12">Task No.</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-12">参考号</div>
												<div class="font-size-9 line-height-12">Ref No.</div>
											</th>
											<th class="colwidth-10">
												<div class="font-size-12 line-height-12">适用性</div>
												<div class="font-size-9 line-height-12">Applicability</div>
											</th>
											<th class="colwidth-7">
												<div class="font-size-12 line-height-12">参考文件</div>
												<div class="font-size-9 line-height-12">Doc</div>
											</th>
											<th class="colwidth-15">
												<div class="font-size-12 line-height-12">工时</div>
												<div class="font-size-9 line-height-12">MHRs</div>
											</th>
								 		 </tr>
									</thead>
									<tbody id="current_maintenance_project_list"></tbody>
								</table>
							</div>
				        </div> 	
				      </div> 

					 <div class="panel panel-default">
				       	 <div class="panel-heading bg-panel-heading">
							<div class="font-size-12">
								<i validate="bz" class="icon-circle pull-left" style="display: none;"></i>备注
							</div>
							<div class="font-size-9">Note</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="bz_panel_body">
                          <p id="current_bz"></p>
				        </div> 	
				      </div>
				      
				      <div class="panel panel-default">
				       	 <div class="panel-heading bg-panel-heading">
							<div class="font-size-12">
								<i validate="gbyj,pgd" class="icon-circle pull-left" style="display: none;"></i>改版依据
							</div>
							<div class="font-size-9">Based On</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="gbyj_panel_body">
	                      <div class="describe"> 	
			                   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-2 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 margin-topnew-2">改版依据</div>
										<div class="font-size-9">Based On</div>
									</label>
									<div class="col-lg-10 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
										<span class="margin-top-8 " id="current_gbyj"></span>
									</div>
							   </div>
							   <div class="clearfix"></div>
							   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-2 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 margin-topnew-2">技术评估单</div>
										<div class="font-size-9">Technical Assessment</div>
									</label>
									<div class="col-lg-10 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
										<span class="margin-top-8 " id="current_pgd"></span>
									</div>
							   </div>
							   <div class="clearfix"></div>
				           </div>



				        </div> 	
				      </div>  
				      
				      <div class="clearfix"></div>
					  <div id="current_attachments_list_edit" name="attachmentDiv" style="display:none">
						
						<%@ include file="/WEB-INF/views/common/attachments/attachments_list_edit_common.jsp"%><!-- 加载附件信息 -->
					
					  </div>
				      
					</div>
			      </div>
			      </div> 
			      
			      
			      
			      <div class="col-lg-6 padding-left-0 padding-right-0" id="previous_panel">
			          <div class="panel panel-default" style="margin-right: -1px;border-right: none;border-top:none;border-bottom:none;">
				        <div class="panel-heading padding-left-0 padding-right-0" style="background-color:white;">
						  <div class="panel-subtitle">
						   <em>维修项目版本:</em>
						   <span class="col-lg-6 padding-left-0 padding-right-0" id="previous_bb"></span>
						  </div>
					   </div>
				    <div class="panel-body padding-bottom-0 padding-right-0">	
				  <div class="describe" name="main_body"> 	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 padding-left-0 padding-right-0 text-right" id="previous_wxxmlx">
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span><label class="notPackage" style="margin-right: 20px;"><input type="checkbox"  id="previous_rii" disabled="disabled"/> RII</label><label class="notPackage" style="margin-right: 20px;"><input type="checkbox"  id="previous_ali" disabled="disabled"/> ALI</label><i  id="previous_yxbs"></i> </span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">任务号</div>
							<div class="font-size-9">Task No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_rwh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">参考号</div>
							<div class="font-size-9">Ref No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_ckh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">参考文件</div>
							<div class="font-size-9">Doc</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_ckwj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								<i validate="ckwj" class="icon-circle pull-left" style="display: none;"></i>CMP/CAMP号
							</div>
							<div class="font-size-9">CMP No.</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_cmph" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								ATA章节号
							</div>
							<div class="font-size-9">ATA</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_zjh" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								维修项目大类
							</div>
							<div class="font-size-9">Class</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_wxxmdl" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">所属定检包</div>
							<div class="font-size-9">Package</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_ssdjb" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">任务描述</div>
							<div class="font-size-9">Desc</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_rwms" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">区域</div>
							<div class="font-size-9">Zone</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_qy" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">接近</div>
							<div class="font-size-9">Access</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_jj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">飞机站位</div>
							<div class="font-size-9">Aircraft Stations</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_fjzw" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">项目类别</div>
							<div class="font-size-9">Project Type</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_xmlx" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">工作类别</div>
							<div class="font-size-9">Work Type</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_gzlx" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">工卡</div>
							<div class="font-size-9">Work Card</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_gk" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">工时</div>
							<div class="font-size-9">MHRs</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_gs" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">飞机注册号</div>
							<div class="font-size-9">A/C REG</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_fjzch" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>	
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">部件</div>
							<div class="font-size-9">Component</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_bj" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>
				   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group notPackage">
						<label class="col-lg-3 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
							<div class="font-size-12 margin-topnew-2">
								取代EO
							</div>
							<div class="font-size-9">Replace</div>
						</label>
						<div class="col-lg-9 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
							<span class="margin-top-8 " id="previous_eo" style="text-align:left"></span>
						</div>
				   </div>
				   <div class="clearfix"></div>
				   </div>
				      <div class="panel panel-default">
					      <div class="panel-heading bg-panel-heading">
								<div class="font-size-12">监控项</div>
								<div class="font-size-9">Monitor Item</div>
						  </div> 
					        <div class="panel-body padding-bottom-0" name="monitor_panel_body">
					        	<div name="monitorItemDiv" class="padding-left-0 padding-right-0 col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow-x: auto;">
						        	<table class="table table-bordered table-striped table-hover text-center table-set table-thin" style="min-width: 500px;">
						        		<thead>
									   		<tr>
											<th class="colwidth-7" id="previous_maintenance_version_bj">
												<div class="font-size-12 line-height-12">部件</div>
												<div class="font-size-9 line-height-12">Component</div>
											</th>
											<th class="colwidth-9" id="previous_maintenance_version_jkxm">
												<div class="font-size-12 line-height-12">监控项目</div>
												<div class="font-size-9 line-height-12">Monitor Item</div>
											</th>
											<th class="colwidth-9" id="previous_maintenance_version_sj">
													<div class="font-size-12 line-height-12">首检</div>
													<div class="font-size-9 line-height-12">INTI</div>	
											</th>
											<th class="colwidth-7" id="previous_maintenance_version_zq">
												<div class="font-size-12 line-height-12">周期</div>
												<div class="font-size-9 line-height-12">Cycle</div>
											</th>
											<th class="colwidth-15" id="previous_maintenance_version_rc">
												<div class="font-size-12 line-height-12">容差(-/+)</div>
												<div class="font-size-9 line-height-12">Tolerance(-/+)</div>
											</th>
											 </tr>
										</thead>
						        		<tbody id="previous_maintenance_version_list">
						           		</tbody>
					           		</table>
					           	</div>
					           	<div class="col-sm-12 padding-left-0 padding-right-0 form-group" id="previous_jsgs_div">
			           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
			           					<div class="font-size-12 margin-topnew-2">计算公式</div>
			           					<div class="font-size-9">Formula</div>
			           				</label>
				           			<div class="col-lg-6 col-md-6 col-sm-8 col-xs-9 padding-leftright-8 margin-top-8">
				           				<span id="previous_jsgs"></span>
				           			</div>
			           				<div class="col-lg-4 col-md-3 col-sm-8 col-xs-9 padding-leftright-8 label-input-div">
			           					<label class="margin-right-5 label-input"><input id="previous_isHdwz" type="checkbox" disabled="disabled">&nbsp;后到为准</label>
			           				</div>
				           		</div>
				           		<div class="col-sm-12 padding-left-0 padding-right-0" id="previous_wz_div">
			           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
			           					<div class="font-size-12 margin-topnew-2">发动机分类</div>
			           					<div class="font-size-9">Engine</div>
			           				</label>
				           			<div class="col-lg-4 col-md-6 col-sm-8 col-xs-9 padding-leftright-8 margin-top-8">
				           				<span id="previous_wz"></span>
				           			</div>
				           		</div>
				           		
				           		<div class="col-sm-12 padding-left-0 padding-right-0">
			           				<label class="col-lg-2 col-md-3 col-sm-8 col-xs-12 text-right padding-left-0 padding-right-0">
			           					<div class="font-size-12 margin-topnew-2">间隔描述</div>
			           					<div class="font-size-9">Remark</div>
			           				</label>
				           			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12 padding-leftright-8 margin-top-8">
				           				<span id="previous_jgms"></span>
				           			</div>
				           		</div>
					        </div> 	
				      </div>   	
				      
				   	  <div class="panel panel-default">
				       	 <div class="panel-heading bg-panel-heading">
							<div class="font-size-12"><span name="associateCnHead">维修项目关联</span></div>
							<div class="font-size-9">Maintenance</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="relation_panel_body">
				        	<div name="relationDiv" class="padding-left-0 padding-right-0 col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow-x: auto;">
                               <table class="table table-bordered table-striped table-hover text-center table-set table-thin" style="min-width: 500px;">
									<thead>
								   		<tr>
											<th class="colwidth-5">
												<div class="font-size-12 line-height-12">版本</div>
												<div class="font-size-9 line-height-12">Rev.</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-12">任务号</div>
												<div class="font-size-9 line-height-12">Task No.</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-12">参考号</div>
												<div class="font-size-9 line-height-12">Ref No.</div>
											</th>
											<th class="colwidth-10">
												<div class="font-size-12 line-height-12">适用性</div>
												<div class="font-size-9 line-height-12">Applicability</div>
											</th>
											<th class="colwidth-7">
												<div class="font-size-12 line-height-12">参考文件</div>
												<div class="font-size-9 line-height-12">Doc</div>
											</th>
											<th class="colwidth-15">
												<div class="font-size-12 line-height-12">工时</div>
												<div class="font-size-9 line-height-12">MHRs</div>
											</th>
								 		 </tr>
									</thead>
									<tbody id="previous_maintenance_project_list"></tbody>
								</table>
							</div>
				        </div> 	
				      </div>      
				         
				      <div class="panel panel-default">
						  <div class="panel-heading bg-panel-heading">
							<div class="font-size-12">备注</div>
							<div class="font-size-9">Note</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="bz_panel_body">
                        <p id="previous_bz"></p>
				        </div> 	
				      </div>    
				      
				      <div class="panel panel-default">
					     <div class="panel-heading bg-panel-heading">
							<div class="font-size-12">改版依据</div>
							<div class="font-size-9">Based On</div>
						 </div>
				        <div class="panel-body padding-bottom-0" name="gbyj_panel_body">
                      	   <div class="describe"> 	
			                   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-2 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 margin-topnew-2">改版依据</div>
										<div class="font-size-9">Based On</div>
									</label>
									<div class="col-lg-10 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
										<span class="margin-top-8 " id="previous_gbyj"></span>
									</div>
							   </div>
							   <div class="clearfix"></div>
							   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 form-group">
									<label class="col-lg-2 col-md-4 col-sm-5 col-xs-12 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 margin-topnew-2">技术评估单</div>
										<div class="font-size-9">Technical Assessment</div>
									</label>
									<div class="col-lg-10 col-md-8 col-sm-7 col-xs-12 padding-leftright-8">
										<span class="margin-top-8" id="previous_pgd"></span>
									</div>
							   </div>
							   <div class="clearfix"></div>
			           		</div>
				        </div> 	
				      </div>    
				      
				      <div class="clearfix"></div>
					  <div id="previous_attachments_list_edit" name="attachmentDiv" style="display:none">
						
						<%@ include file="/WEB-INF/views/common/attachments/attachments_list_edit_common.jsp"%><!-- 加载附件信息 -->
					
					  </div>
				         
					</div>
			      </div>
			      </div> 
			      
			      </div> 
			      </div>
			     </div> 
			
			
			</div>
			</div>
			
			
		</div>
	</div>
	
	
	<!-------差异表对话框 Start-------->
	
<div class="modal fade modal-new" id="alertDiffForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop='static' data-keyboard= false >
	<div class="modal-dialog" style="width:50%;">
		<div class="modal-content">
			<div class="modal-header modal-header-new" >
         		<h4 class="modal-title" >
             		<div id="batchReviewHead" class='pull-left'>
                 		<div class="font-size-14 ">差异表</div>
						<div class="font-size-12">Difference</div>
					</div>
	 				<div class="pull-right">
				  		<button type="button" class="icon-remove modal-close" data-dismiss="modal" aria-label="Close"></button>
				  	</div>
					<div class='clearfix'></div>
               	</h4>
          	</div>
	          	
			<div class="modal-body margin-top-0" id="alertDiffFormBody">
				<div class="col-xs-12 margin-top-8">
					<div class="input-group-border" >
						<form id="form">
							<div class="col-lg-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 margin-top-10">
								<div class="col-lg-4 col-sm-4 col-xs-4  padding-left-0 padding-right-0 form-group" >
									<label  class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">维修方案编号</div>
										<div class="font-size-9 line-height-18">MP No.</div>
									</label>
									<div id="vwxfabh" class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input class="form-control" id="modal_wxfabh" disabled="disabled" type="text">
									</div>
								</div>
								
								<div class="col-lg-4 col-sm-4 col-xs-4  padding-left-0 padding-right-0 form-group" >
									<label  class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">维修方案名称</div>
										<div class="font-size-9 line-height-18">MP Name</div>
									</label>
									<div id="vwxfazwms" class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0">
										<input class="form-control" id="modal_wxfamc" disabled="disabled" type="text">
									</div>
								</div>
								
								<div class="col-lg-4 col-sm-4 col-xs-4  padding-left-0 padding-right-0 form-group" >
									<label class="col-lg-4 col-sm-4 col-xs-4 text-right padding-left-0 padding-right-0">
										<div class="font-size-12 line-height-18">改版</div>
										<div class="font-size-9 line-height-18">Revision</div>
									</label>
									<div class="col-lg-8 col-sm-8 col-xs-8 padding-left-8 padding-right-0 padding-top-5"><span id="modal_previous_bb"></span>&nbsp;&nbsp;<i class="icon-long-arrow-right color-black"></i>&nbsp;&nbsp;<span id="modal_current_bb"></span></div>
								</div>
								
								<div class="clearfix"></div>
								
							</div>
						</form>
						<div class="col-lg-12 col-sm-12 col-xs-12  padding-leftright-8">
							
							<!-- start:table -->
							<div style="overflow-x: auto;">
								<table class="table table-bordered table-striped table-hover table-set table-thin" style="min-width: 450px;">
									<thead>
								   		<tr>
											<th class="colwidth-3">
												<div class="font-size-12 line-height-18">序号</div>
												<div class="font-size-9 line-height-18">No.</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-18">任务号</div>
												<div class="font-size-9 line-height-18">Task No.</div>
											</th>
											<th class="colwidth-20">
												<div class="font-size-12 line-height-18">任务描述</div>
												<div class="font-size-9 line-height-18">Task Description</div>
											</th>
											<th class="colwidth-9">
												<div class="font-size-12 line-height-18">修订内容项</div>
												<div class="font-size-9 line-height-18">Revise Item</div>
											</th>
											<th class="colwidth-10">
												<div class="font-size-12 line-height-18">修订类型</div>
												<div class="font-size-9 line-height-18">Revise Type</div>
											</th>
								 		 </tr>
									</thead>
									<tbody id="modal_different">
										<tr><td colspan="5" class="text-center">暂无数据 No data.</td></tr>
									</tbody>
								</table>
								</div>
							<!-- end:table -->
				     		<div class="clearfix"></div>
						</div>
						<div class='clearfix'></div>
					 </div> 
					 <div class='clearfix'></div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class='clearfix'></div>
			
			<div class="modal-footer">
				<div class="col-xs-8 alert-style">
			    </div>
			    <div class="col-xs-4">
					<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1" data-dismiss="modal">
						<div class="font-size-12">关闭</div>
						<div class="font-size-9">Close</div>
					</button>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>

<!-------差异表对话框 End-------->
	<script type="text/javascript" src="${ctx }/static/js/thjw/common/monitor/monitor_unit.js"></script>
	<script src="${ctx}/static/js/thjw/project2/maintenance/maintenance_project_different.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/thjw/common/webuiPopoverUtil.js"></script><!-- 控件对话框 -->
	<script type="text/javascript" src="${ctx}/static/js/thjw/project2/maintenance/maintenance_scheme_history.js"></script>
</body>
</html>