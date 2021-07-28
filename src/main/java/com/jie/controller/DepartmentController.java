package com.jie.controller;

import com.jie.entity.Department;
import com.jie.entity.Msg;
import com.jie.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 * @author jie
 */

@Controller
@RequestMapping("/depts")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/all")
    @ResponseBody
    public Msg getDepts(){

        List<Department> list = departmentService.findDepts();
        return Msg.success().add("depts",list);
    }

}
