<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" language="java" %>
<div id="">
	<div class='searchContent margin-top-0 row-height' >
					<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 padding-left-0 padding-right-0 margin-top-0 form-group" >
						<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1 pull-left" onclick="toDestroy_main.destroy()">
							<div class="font-size-12">销毁</div>
							<div class="font-size-9">Destory</div>
						</button>
						<button type="button" class="btn btn-primary padding-top-1 padding-bottom-1 pull-left margin-left-8" onclick="toDestroy_main.exportExcel()">
							<div class="font-size-12">导出</div>
							<div class="font-size-9">Export</div>
						</button>
						
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 padding-left-0 padding-right-0 margin-top-0 form-group" >
						<span class="col-lg-3 col-md-3 col-sm-3 col-xs-1  text-right padding-left-0 padding-right-0">
							<div class="font-size-12">报废日期</div>
							<div class="font-size-9">Date</div>
						</span>
						<div class="col-lg-9 col-md-9 col-sm-9 col-xs-11 padding-left-8 padding-right-0" >
							<input type='text' id='toDestroy_bfrq_search' class='form-control' name="date-range-picker"/>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 padding-left-0 padding-right-0 margin-top-0 form-group" >
						<span class="col-lg-3 col-md-3 col-sm-3 col-xs-1  text-right padding-left-0 padding-right-0">
							<div class="font-size-12">部件来源</div>
							<div class="font-size-9">Source</div>
						</span>
						<div class="col-lg-9 col-md-9 col-sm-9 col-xs-11 padding-left-8 padding-right-0" >
							<select class="form-control" id="toDestroy_hcly" name="toDestroy_hcly" onchange="toDestroy_main.changeHcly()">
							</select>
						</div>
					</div>
					<!-- 搜索框start -->
					<div class="col-lg-3 col-md-12 col-sm-12 col-xs-12 padding-left-0 padding-right-0 margin-top-0 form-group pull-right" style='padding-left:15px;'>
						<div class="col-xs-12 input-group input-group-search">
							<input type="text" placeholder='报废单号/部件号/部件名称/批次号/序列号/说明' name='keyCodeSearch' class="form-control" id="toDestroy_keyword_search" >
		                    <div class="input-group-addon btn-searchnew  destroy_click-btn" >
		                    	<button id="workCardMainSearch" type="button" class=" btn btn-primary padding-top-1 padding-bottom-1" onclick="toDestroy_main.searchRevision();" style='margin-right:0px !important;'>
								<div class="font-size-12">搜索</div>
								<div class="font-size-9">Search</div>
		                  		</button>
		                    </div>
		                    <div class="input-group-addon btn-searchnew-more">
			                    <button type="button" class="btn btn-primary dropdown-toggle padding-top-1 padding-bottom-1"  id="btn" onclick="moreSearch();">
								<div class='input-group input-group-search'>
								<div class="input-group-addon">
								<div class="font-size-12">更多</div>
								<div class="font-size-9 margin-top-5" >More</div>
								</div>
								<div class="input-group-addon">
								 &nbsp;<i class="font-size-15 icon-caret-down" id="icon"></i>
								</div>
								</div>
					   			</button>
		                	</div>
						</div>
					</div>
					<!-- 搜索框end -->
				  <div class='clearfix'></div>
			
				<div class="col-lg-12 col-sm-12 col-xs-12 triangle  padding-top-10 margin-bottom-10 display-none border-cccccc margin-top-0" id="divSearch">
					<div class="col-xs-12 col-sm-6 col-lg-3  padding-left-0 padding-right-0 margin-bottom-10 ">
						<span class="pull-left col-xs-4 col-sm-4 text-right padding-left-0 padding-right-0">
							<div class="font-size-12">组织机构</div>
							<div class="font-size-9">Organization</div>
						</span>
						<div class="col-xs-8 col-sm-8 padding-left-8 padding-right-0">
							<select id="toDestroy_zzjg" class="form-control " name="toDestroy_zzjg" onchange="toDestroy_main.changedprtcode()">
									<c:forEach items="${accessDepartment}" var="type">
										<option value="${type.id}" <c:if test="${user.jgdm eq type.id }">selected='selected'</c:if>>${erayFns:escapeStr(type.dprtname)}</option>
									</c:forEach>
								</select>
						</div>
					</div>
					
					<div class="col-lg-2  text-right padding-right-0 pull-right" style="margin-bottom: 10px;">
						<button type="button"
							class="btn btn-primary padding-top-1 padding-bottom-1"
							onclick="toDestroy_main.searchreset();">
							<div class="font-size-12">重置</div>
							<div class="font-size-9">Reset</div>
						</button>
					</div>
				</div>
				<div class='clearfix'></div>
				</div>
			<div id="" class="col-lg-12 col-md-12 padding-left-0 padding-right-0 margin-top-0 tab-table-height" style="overflow:auto;">
				<table id="packing_list_table" class="table table-thin table-bordered table-striped table-hover table-set" >
					<thead>
						<tr>
							<th  class="fixed-column selectAllImg" id="checkAll" style='text-align:center;vertical-align:middle;width:60px;'>
								<a href="#" onclick="toDestroy_main.performSelectAll()" ><img src="${ctx}/static/assets/img/d1.png" alt="全选" /></a>
								<a href="#" class="margin-left-5" onclick="toDestroy_main.performSelectClear()" ><img src="${ctx}/static/assets/img/d2.png" alt="不全选" /></a>
							</th>
							<th class="colwidth-15 sorting" onclick="toDestroy_main.orderBy('WZ')" id="WZ_order">
							    <div class="font-size-12 line-height-18">位置</div>
								<div class="font-size-9 line-height-18">Position</div>
							</th>
							<th class="colwidth-13 sorting" onclick="toDestroy_main.orderBy('BJH')" id="BJH_order" >
							<div class="important">
							    <div class="font-size-12 line-height-18">部件号</div>
								<div class="font-size-9 line-height-18">PN</div></div>
							</th>
							<th class="colwidth-15 sorting" onclick="toDestroy_main.orderBy('YWMS')" id="YWMS_order">
							<div class="important">
							    <div class="font-size-12 line-height-18">部件名称</div>
								<div class="font-size-9 line-height-18">Name</div></div>
							</th>
							<th class="colwidth-9 sorting" onclick="toDestroy_main.orderBy('PCH')" id="PCH_order">
							<div class="important">
							    <div class="font-size-12 line-height-18">批次号</div>
								<div class="font-size-9 line-height-18">BN</div></div>
							</th>
							<th class="colwidth-9 sorting" onclick="toDestroy_main.orderBy('SN')" id="SN_order">
							<div class="important">
							    <div class="font-size-12 line-height-18">序列号</div>
								<div class="font-size-9 line-height-18">SN</div></div>
							</th>
							<th class="colwidth-9 sorting" onclick="toDestroy_main.orderBy('HCLY')" id="HCLY_order">
							    <div class="font-size-12 line-height-18">部件来源</div>
								<div class="font-size-9 line-height-18">Source</div>
							</th>
							<th class="colwidth-5 sorting" onclick="toDestroy_main.orderBy('BFSL')" id="BFSL_order">
							    <div class="font-size-12 line-height-18">报废数量</div>
								<div class="font-size-9 line-height-18">No.</div>
							</th>
							<th class="colwidth-20 sorting" onclick="toDestroy_main.orderBy('SM')" id="SM_order">
							<div class="important">
							    <div class="font-size-12 line-height-18">说明</div>
								<div class="font-size-9 line-height-18">Desc</div></div>
							</th>
							<th class="colwidth-13 sorting" onclick="toDestroy_main.orderBy('BFDH')" id="BFDH_order">
							<div class="important">
							    <div class="font-size-12 line-height-18">报废单号</div>
								<div class="font-size-9 line-height-18">Scrap No.</div></div>
							</th>
							<th class="colwidth-9 sorting" onclick="toDestroy_main.orderBy('BFRQ')" id="BFRQ_order">
							    <div class="font-size-12 line-height-18">报废日期</div>
								<div class="font-size-9 line-height-18">Date</div>
							</th>
							<th class="colwidth-9 sorting" onclick="toDestroy_main.orderBy('SQR')" id="SQR_order">
							    <div class="font-size-12 line-height-18">申请人</div>
								<div class="font-size-9 line-height-18">Applicant</div>
							</th>
							
						</tr>
					</thead>
					<tbody id="toDestroyList">
					</tbody>
				</table>
			</div>
	<div class="col-xs-12 text-center padding-left-0 padding-right-0 page-height " id="pagination_list"></div>
</div>