package com.eray.thjw.produce.control;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eray.thjw.annotation.Privilege;
import com.eray.thjw.control.BaseController;
import com.eray.thjw.exception.BusinessException;
import com.eray.thjw.produce.po.PlaneBasic;
import com.eray.thjw.produce.po.Workorder145;
import com.eray.thjw.produce.service.PlaneBasicService;
import com.eray.thjw.produce.service.WorkOrderNew145Service;
import com.eray.thjw.util.ThreadVarUtil;

import enu.produce.FeedbackStatusEnum;
import enu.produce.WorkorderStatusEnum;
import enu.produce.WorkorderTypeEnum;

/**
 * 
 * @Description NRC145
 * @CreateTime 2017年12月9日 下午2:37:12
 * @CreateBy 岳彬彬
 */
@Controller
@RequestMapping("/produce/nrc145")
public class Nrc145Controller extends BaseController {
	@Resource
	private WorkOrderNew145Service workOrderNew145Service;
	@Resource
	private PlaneBasicService planeBasicService;

	
	/**
	 * @Description 工单列表加载
	 * @CreateTime 2017年10月9日 下午9:10:27
	 * @CreateBy 林龙
	 * @param workorder
	 * @return
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "queryAllList", method = RequestMethod.POST)
	public Map<String, Object> queryAllList(@RequestBody Workorder145 workorder)throws BusinessException {
		try {
			return workOrderNew145Service.queryAllList(workorder);
		} catch (Exception e) {
			throw new BusinessException("工单列表加载失败!", e);
		}
	}
	/**
	 * 
	 * @Description 处理附件
	 * @CreateTime 2017年10月20日 上午10:50:40
	 * @CreateBy 岳彬彬
	 * @param record
	 * @param request
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "doAttachment", method = RequestMethod.POST)
	public void doAttachment(@RequestBody Workorder145 record, HttpServletRequest request) throws BusinessException {
		try {
			workOrderNew145Service.doAttachment(record);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("添加附件失败", e);
		}
	}
	/**
	 * 
	 * @Description 选择工单弹窗
	 * @CreateTime 2017年10月20日 上午11:07:40
	 * @CreateBy 岳彬彬
	 * @param record
	 * @param request
	 * @return
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "getWorkorderList", method = RequestMethod.POST)
	public Map<String, Object> getWorkorderList(@RequestBody Workorder145 record, HttpServletRequest request)
			throws BusinessException {
		try {
			return workOrderNew145Service.getWorkorderList(record);
		} catch (Exception e) {
			throw new BusinessException("获取工单失败失败", e);
		}
	}
	/**
	 * 
	 * @Description 工包添加工单
	 * @CreateTime 2017年10月20日 上午11:24:51
	 * @CreateBy 岳彬彬
	 * @param record
	 * @param request
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "updateGbid", method = RequestMethod.POST)
	public void  updateGbid(@RequestBody Workorder145 record, HttpServletRequest request)
			throws BusinessException {
		try {
			workOrderNew145Service.updateGbid(record);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("添加工单失败失败", e);
		}
	}
	
	
	/**
	 * @Description 145工单管理
	 * @CreateTime 2017-9-15 上午9:32:08
	 * @CreateBy 雷伟
	 * @param request
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main")
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main145(HttpServletRequest request,Model model) throws BusinessException {
		try {
			model.addAttribute("workorderStatusEnum", WorkorderStatusEnum.enumToListMap());//工单状态枚举
			model.addAttribute("workorderTypeEnum", WorkorderTypeEnum.enumToListMap());//工单类型枚举
			model.addAttribute("feedbackStatusEnum", FeedbackStatusEnum.enumToListMap());//反馈枚举
			model.addAttribute("mainidParam", request.getParameter("mainidParam"));
			PlaneBasic plane = new PlaneBasic();
			plane.setDprtcode(ThreadVarUtil.getUser().getJgdm());
			model.addAttribute("fjList", planeBasicService.getFjList(plane));
			return "produce/nrc/145/nrc145_main";
		} catch (Exception e) {
			throw new BusinessException("工单管理列表跳转失败!", e);
		}
	}
	
	/**
	 * @Description 工单145列表查询
	 * @CreateTime 2017-9-30 下午1:34:06
	 * @CreateBy 雷伟
	 * @param workorder
	 * @return
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "queryAllPageList", method = RequestMethod.POST)
	public Map<String, Object> queryAllPageList(@RequestBody Workorder145 workorder)
			throws BusinessException {
		try {
			return workOrderNew145Service.queryAllPageList(workorder);
		} catch (Exception e) {
			throw new BusinessException("工单列表加载失败!", e);
		}
	}
	
	/**
	 * @Description 新增工单145
	 * @CreateTime 2017-10-10 下午8:50:14
	 * @CreateBy 雷伟
	 * @param workorder 工单145
	 * @return
	 * @throws BusinessException
	 */	@Privilege(code = "produce:nrc145:main:01,produce:workpackage145:main:10")
	@ResponseBody
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String save(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.save(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单保存失败!", e);
		}
	}
	
	/**
	 * @Description 根据工单Id查询工单信息
	 * @CreateTime 2017-8-24 上午10:59:42
	 * @CreateBy 雷伟
	 * @param gdid 工单id
	 * @return WorkOrder
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "selectWOById", method = { RequestMethod.POST })
	public Workorder145 selectWOById(String gdid) throws BusinessException {
		try {
		    return workOrderNew145Service.selectWOById(gdid);
		} catch (Exception e) {
			throw new BusinessException("查询工单失败!", e);
		}
	}
	
	/**
	 * @Description 编辑工单
	 * @CreateTime 2017-8-22 上午9:19:41
	 * @CreateBy 雷伟
	 * @param workorder 工单
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:02")
	@ResponseBody
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.update(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单编辑失败!", e);
		}
	}
	
	/**
	 * @Description 工单航材明细
	 * @CreateTime 2017年9月29日 下午2:21:37
	 * @CreateBy 雷伟
	 * @param workorder 145工单
	 * @return
	 * @throws BusinessException
	 */
	@ResponseBody
	@RequestMapping(value = "getGDHCToolDetail", method = RequestMethod.POST)
	public Map<String, Object> getGDHCToolDetail(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.getGDHCToolDetail(workorder);
		} catch (Exception e) {
			throw new BusinessException("获取工单航材数据失败", e);
		}
	}
	
	/**
	 * @Description 删除工单
	 * @CreateTime 2017-10-12 下午2:54:11
	 * @CreateBy 雷伟
	 * @param woId 工单ID
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:03")
	@ResponseBody
	@RequestMapping(value = "doDelete", method = RequestMethod.POST)
	public void doDelete(String woId) throws BusinessException{
		try {
			workOrderNew145Service.doDelete(woId);
		} catch (Exception e) {
			throw new BusinessException("删除失败!",e);
		}
	}
	
	/**
	 * @Description 工单关闭
	 * @CreateTime 2017-8-22 上午9:19:41
	 * @CreateBy 雷伟
	 * @param workorder 工单
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:05")
	@ResponseBody
	@RequestMapping(value = "doWGClose", method = RequestMethod.POST)
	public String doWGClose(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.doWGClose(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单关闭失败!", e);
		}
	}
	
	/**
	 * @Description 工单关闭,指定结束
	 * @CreateTime 2017-8-22 上午9:19:41
	 * @CreateBy 雷伟
	 * @param workorder 工单
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:06")
	@ResponseBody
	@RequestMapping(value = "doZDClose", method = RequestMethod.POST)
	public String doZDClose(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.doZDClose(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单指定结束失败!", e);
		}
	}
	
	/**
	 * 
	 * @Description 修订工单
	 * @CreateTime 2017年11月24日 下午2:52:36
	 * @CreateBy 林龙
	 * @param workorder
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:07")
	@ResponseBody
	@RequestMapping(value = "doXDClose", method = RequestMethod.POST)
	public String doXDClose(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.doXDClose(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单修订失败!", e);
		}
	}
	/**
	 * @Description 工单反馈
	 * @CreateTime 2017-8-22 上午9:19:41
	 * @CreateBy 雷伟
	 * @param workorder 工单
	 * @return
	 * @throws BusinessException
	 */
	@Privilege(code = "produce:nrc145:main:04")
	@ResponseBody
	@RequestMapping(value = "doFeedback", method = RequestMethod.POST)
	public String doFeedback(@RequestBody Workorder145 workorder) throws BusinessException {
		try {
			return workOrderNew145Service.doFeedback(workorder);
		} catch (BusinessException e) {
			throw e;
		} catch (Exception e) {
			throw new BusinessException("工单反馈失败!", e);
		}
	}
	
	/**
	 * @Description 工单查看页面
	 * @CreateTime 2017-10-16 上午8:59:02
	 * @CreateBy 雷伟
	 * @param gdid
	 * @return
	 */
	@RequestMapping(value = "woView", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView woView(String gdid) {
		Map<String, Object> model = new HashMap<String, Object>();
		Workorder145 wo145 = workOrderNew145Service.selectWOById(gdid);
		model.put("gdid", gdid);
		if(wo145==null){
			return new ModelAndView("/produce/workorder/135/workorder_view", model);
		}
		return new ModelAndView("/produce/workorder/145/workorder_view", model);
	}
}
