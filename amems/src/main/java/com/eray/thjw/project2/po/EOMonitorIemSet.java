package com.eray.thjw.project2.po;

import java.math.BigDecimal;
import java.util.Date;

import com.eray.thjw.po.BizEntity;

/**
 * 
 * @Description b_g2_01002  EO-监控项设置
 * @CreateTime 2017-8-21 下午3:44:08
 * @CreateBy 雷伟
 */
public class EOMonitorIemSet extends BizEntity {
    private String id;

    private String mainid;

    private BigDecimal xc;

    private String jklbh;

    private String jkflbh;

    private String scz;

    private BigDecimal dwScz;

    private String zqz;

    private BigDecimal dwZqz;

    private String ydzQ;

    private BigDecimal ydzQdw;

    private String ydzH;

    private BigDecimal ydzHdw;

    private Integer zt;

    private String whbmid;

    private String whrid;

    private Date whsj;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getMainid() {
        return mainid;
    }

    public void setMainid(String mainid) {
        this.mainid = mainid == null ? null : mainid.trim();
    }

    public BigDecimal getXc() {
        return xc;
    }

    public void setXc(BigDecimal xc) {
        this.xc = xc;
    }

    public String getJklbh() {
        return jklbh;
    }

    public void setJklbh(String jklbh) {
        this.jklbh = jklbh == null ? null : jklbh.trim();
    }

    public String getJkflbh() {
        return jkflbh;
    }

    public void setJkflbh(String jkflbh) {
        this.jkflbh = jkflbh == null ? null : jkflbh.trim();
    }

    public String getScz() {
        return scz;
    }

    public void setScz(String scz) {
        this.scz = scz == null ? null : scz.trim();
    }

    public BigDecimal getDwScz() {
        return dwScz;
    }

    public void setDwScz(BigDecimal dwScz) {
        this.dwScz = dwScz;
    }

    public String getZqz() {
        return zqz;
    }

    public void setZqz(String zqz) {
        this.zqz = zqz == null ? null : zqz.trim();
    }

    public BigDecimal getDwZqz() {
        return dwZqz;
    }

    public void setDwZqz(BigDecimal dwZqz) {
        this.dwZqz = dwZqz;
    }

    public String getYdzQ() {
        return ydzQ;
    }

    public void setYdzQ(String ydzQ) {
        this.ydzQ = ydzQ == null ? null : ydzQ.trim();
    }

    public BigDecimal getYdzQdw() {
        return ydzQdw;
    }

    public void setYdzQdw(BigDecimal ydzQdw) {
        this.ydzQdw = ydzQdw;
    }

    public String getYdzH() {
        return ydzH;
    }

    public void setYdzH(String ydzH) {
        this.ydzH = ydzH == null ? null : ydzH.trim();
    }

    public BigDecimal getYdzHdw() {
        return ydzHdw;
    }

    public void setYdzHdw(BigDecimal ydzHdw) {
        this.ydzHdw = ydzHdw;
    }

    public Integer getZt() {
        return zt;
    }

    public void setZt(Integer zt) {
        this.zt = zt;
    }

    public String getWhbmid() {
        return whbmid;
    }

    public void setWhbmid(String whbmid) {
        this.whbmid = whbmid == null ? null : whbmid.trim();
    }

    public String getWhrid() {
        return whrid;
    }

    public void setWhrid(String whrid) {
        this.whrid = whrid == null ? null : whrid.trim();
    }

    public Date getWhsj() {
        return whsj;
    }

    public void setWhsj(Date whsj) {
        this.whsj = whsj;
    }
}