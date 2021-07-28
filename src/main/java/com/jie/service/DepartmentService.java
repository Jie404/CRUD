package com.jie.service;

import com.jie.dao.DepartmentMapper;
import com.jie.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> findDepts(){
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }

}
