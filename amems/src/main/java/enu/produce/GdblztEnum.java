package enu.produce;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @Description 工单保留状态枚举
 * @CreateTime 2017年11月20日 下午4:59:53
 * @CreateBy 林龙
 */
public enum GdblztEnum {
	Bl(1, "保留"),
	SF(2, "释放"),
	;
	
	private Integer id;
    private String name;
    
    private GdblztEnum(Integer id, String name) {
    	this.id = id;
        this.name = name;
    }
    
    public static String getName(Integer id) {
        for (GdblztEnum c : GdblztEnum.values()) {
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
    	GdblztEnum[] enums = GdblztEnum.values();
    	
    	for (GdblztEnum enumItem : enums) {
    		Map<String, Object>map = new HashMap<String, Object>();
    		map.put("id", enumItem.getId());
    		map.put("name", enumItem.getName());
    		list.add(map);
		}
    	
    	 Collections.sort(list, new Comparator<Map<String, Object>>() {
    	        public int compare(Map<String, Object> o1, Map<String, Object> o2) {
    	            return o2.get("id").toString().compareTo(o1.get("id").toString()) ;
    	        }
    	    });
    	
    	return list;
	}
     
}
