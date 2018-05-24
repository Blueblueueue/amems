package com.eray.pbs.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.eray.pbs.po.EhrPbs;

public interface EhrPbsDao extends PagingAndSortingRepository<EhrPbs,Long>, JpaSpecificationExecutor<EhrPbs>{
}
