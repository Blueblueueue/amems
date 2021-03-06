package enu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author meizhiliang
 * @description 工单类型枚举
 * @develop date 2016.09.12
 */
public enum WorkOrderTypeEnum {
	 TIMECONTORL_WO(1, "时控件工单"),
	 ENCLOSURE_WO(2, "附加工单"),
	TROUBLESHOOTING_WO(3, "排故工单"),
	NONROUTINE_WO(4, "非例行工单"),
	CHECKED_WO(5, "定检工单"),
	EO_WO(6, "EO工单"),
	;
	
	private Integer id;
    private String name;
    
    private WorkOrderTypeEnum(Integer id, String name) {
    	this.id = id;
        this.name = name;
    }
    
    public static String getName(Integer id) {
        for (WorkOrderTypeEnum c : WorkOrderTypeEnum.values()) {
            if (c.getId().intValue() == id.intValue()) {
                return c.name;
            }
        }
        return "";
    }
    
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	 /**
     * 枚举转listmap
     * @return
     */
    public static List<Map<String, Object>> enumToListMap() {
    	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	WorkOrderTypeEnum[] enums = WorkOrderTypeEnum.values();
    	
    	for (WorkOrderTypeEnum enumItem : enums) {
    		Map<String, Object>map = new HashMap<String, Object>();
    		map.put("id", enumItem.getId());
    		map.put("name", enumItem.getName());
    		list.add(map);
		}
    	
    	 Collections.sort(list, new Comparator<Map<String, Object>>() {
    	        public int compare(Map<String, Object> o1, Map<String, Object> o2) {
    	            return o1.get("name").toString().compareTo(o2.get("name").toString()) ;
    	        }
    	    });
    	
    	return list;
	}
     
}
