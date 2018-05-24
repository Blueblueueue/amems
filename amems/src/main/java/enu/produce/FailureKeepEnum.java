package enu.produce;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @Description 故障保留来源类型
 * @CreateTime 2017年9月25日 下午2:55:26
 * @CreateBy 林龙
 */
public enum FailureKeepEnum {
	FLB(1, "FLB"),
	NRC(2, "NRC"),
	NA(9, "N/A"),
	;
	
	private Integer id;
    private String name;
    
    private FailureKeepEnum(Integer id, String name) {
    	this.id = id;
        this.name = name;
    }
    
    public static String getName(Integer id) {
        for (FailureKeepEnum c : FailureKeepEnum.values()) {
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
	 * @Description 枚举转listmap
	 * @CreateTime 2017-9-13 下午2:19:21
	 * @CreateBy 刘兵
	 * @return
	 */
    public static List<Map<String, Object>> enumToListMap() {
    	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	FailureKeepEnum[] enums = FailureKeepEnum.values();
    	
    	for (FailureKeepEnum enumItem : enums) {
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
