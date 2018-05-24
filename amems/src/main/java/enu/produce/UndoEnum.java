package enu.produce;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public enum UndoEnum {
WHTS(1,"维护提示"),
JSZL(2,"技术指令"),
WXFA(3,"维修方案"),
FLXGD(4,"非列行工单"),
EO(6,"工程指令EO"),
MEL(7,"MEL"),
GK(8,"工卡"),
JSPGD(9,"技术评估单"),
GZBL(21,"故障保留"),
QXBL(22,"缺陷保留"),
GWSQ(41,"岗位授权"),
ZJ(42,"质检"),
ZLNSJH(43,"质量内审计划"),
NSWTZG(44,"内审问题整改"),
HCSJ(61,"航材上架"),
GJSJ(62,"工具上架"),
HCXHXJ(63,"航材销毁下架"),
GJXHXJ(64,"工具销毁下架"),
BF(65,"报废");

private Integer id;
private String name;

private UndoEnum(Integer id,String name){
	this.id=id;
	this.name=name;
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

public static String getName(Integer id) {
    for (UndoEnum c : UndoEnum.values()) {
        if (c.getId().intValue() == id.intValue()) {
            return c.name;
        }
    }
    return "";
}

public static List<Map<String, Object>> enumToListMap() {
	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	UndoEnum[] enums = UndoEnum.values();
	
	for (UndoEnum enumItem : enums) {
		Map<String, Object>map = new LinkedHashMap<String, Object>();
		map.put("id", enumItem.getId());
		map.put("name", enumItem.getName());
		list.add(map);
	}
	
	return list;
}

}
