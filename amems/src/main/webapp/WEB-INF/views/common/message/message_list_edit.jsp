<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""%>
	
	<input type="hidden" id="dprtId" value="${user.jgdm}" />
	<input type="hidden" id="userId" value="${user.id}" />
	<div id="MessageListUtil" style="display:none">		
		<div id="messageHeadEdit" class="panel-heading padding-left-16 padding-top-3 padding-bottom-10 col-xs-12 margin-bottom-10 " style="border-bottom: 1px solid #ccc;">
			<div class=" pull-left margin-right-10" >
				<div class="font-size-16 line-height-18">留言</div>
				<div class="font-size-9 ">Message</div>
			</div>	
		</div>
					
	   	<div class="col-lg-12 col-xs-12 padding-left-0 padding-right-0">
			<div style="overflow-x:auto;">
				<!-- start:table -->
				<table class="table table-bordered table-striped table-hover text-center table-set" style="min-width: 950px;">
					<thead>
				   		<tr>
				   			<th class="colwidth-5">
								<div class="text-center">
									<button class="line6 " onclick="MessageListUtil.openMessageWinAdd()">
										<i class="icon-plus cursor-pointer color-blue cursor-pointer" ></i>
									</button>
								</div>
							</th>
							<th class="colwidth-3">
								<div class="font-size-12 notwrap">序号</div>
								<div class="font-size-9 notwrap">No.</div>
							</th>
							<th class="colwidth-13">
								<div class="font-size-12 notwrap">留言时间</div>
								<div class="font-size-9 notwrap">Message time</div>
							</th>
							<th class="colwidth-10">
								<div class="font-size-12 notwrap">留言人</div>
								<div class="font-size-9 notwrap">Message people</div>
							</th>
							<th class="colwidth-30">
								<div class="font-size-12 notwrap">留言内容</div>
								<div class="font-size-9 notwrap">Message</div>
							</th>
							<th class="colwidth-30">
								<div class="font-size-12 notwrap">提醒人</div>
								<div class="font-size-9 notwrap">Remind people</div>
							</th>
				 		 </tr>
					</thead>
					<tbody id="messageListTable">
					
					</tbody>
				</table>
				<!-- end:table -->
			</div>
			<div class="clearfix"></div>
		</div>
	</div>	
<script type="text/javascript" src="${ctx}/static/js/thjw/common/message/message_list_edit.js"></script>
<%@ include file="/WEB-INF/views/open_win/message.jsp"%><!-------留言对话框 -------->
