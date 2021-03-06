package enu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author liub
 * @description 厂商类别枚举
 */
public enum FirmTypeEnum {
	MATERIAL_FIRM("1", "航材供应商"),
	OUTSOURCING_FIRM("2", "外委供应商")
	;
	
	
	private String id;
    private String name;
    
    private FirmTypeEnum(String id, String name) {
    	this.id = id;
        this.name = name;
    }
    
    public static String getName(String id) {
        for (FirmTypeEnum c : FirmTypeEnum.values()) {
            if (c.getId().equals(id)) {
                return c.name;
            }
        }
        return "";
    }
    
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
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
    	FirmTypeEnum[] enums = FirmTypeEnum.values();
    	
    	for (FirmTypeEnum enumItem : enums) {
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
