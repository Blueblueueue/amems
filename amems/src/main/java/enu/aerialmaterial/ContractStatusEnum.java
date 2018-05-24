package enu.aerialmaterial;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author liub
 * @description 合同状态枚举
 * @develop date 2016.11.08
 */
public enum ContractStatusEnum {
	SAVE(1, "保存"),
	SUBMIT(2, "提交"),
	HEISHI(3, "核实"),
	CANCEL(8, "作废"),
	CLOSE(9, "关闭"),
	FINISH(10, "完成"),
	REVOKE(11, "撤销")
	;
	
	
	private Integer id;
    private String name;
    
    private ContractStatusEnum(Integer id, String name) {
    	this.id = id;
        this.name = name;
    }
    
    public static String getName(Integer id) {
        for (ContractStatusEnum c : ContractStatusEnum.values()) {
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
    	ContractStatusEnum[] enums = ContractStatusEnum.values();
    	
    	for (ContractStatusEnum enumItem : enums) {
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
