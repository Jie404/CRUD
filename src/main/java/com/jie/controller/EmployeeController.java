package com.jie.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jie.entity.Employee;
import com.jie.entity.Msg;
import com.jie.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/emps")
//@ResponseBody
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 删除一个用户
     */
    @RequestMapping(value = "/all/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delById(@PathVariable("id") String ids){

        int i = 0;
        List<Integer> list = new ArrayList<>();
        if(ids.contains("-")){
            String[] idstr = ids.split("-");
            for (String s : idstr) {
                list.add(Integer.parseInt(s));
            }
            //-2147482646
            //-2147482646
            i = employeeService.dropMany(list);

        }else {
            int id = Integer.parseInt(ids);
            i = employeeService.dropOne(id);
        }

        if(i>0 || i == -2147482646){
            return Msg.success();
        }
        return Msg.fail();
    }


    /**
     * 更新用户
     * @param
     * @return
     */
    @RequestMapping(value = "/all/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateUser(Employee employee){

        System.out.println(employee);
        int i = employeeService.updateEmp(employee);

        return Msg.success();
    }

    /**
     * 检查新增用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/check")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName){
        //正则表达式
        String regName = "^[a-zA-Z0-9_-]{3,16}$";
        if(!empName.matches(regName)){
            System.out.println(empName+"********NO****");
            return Msg.fail().add("msg","用户名可以是3-16位英文和数字组合而成");
        }

        //查数据库重名校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("msg","此用户名已经被使用");
        }
    }

    /**
     * 保存员工
     * @param employee
     * @return json
     */
    @RequestMapping(value = "/all",method = RequestMethod.POST)
    @ResponseBody
    public Msg addEmp(Employee employee){

        int i = employeeService.addEmp(employee);
        if(i<0){
            return Msg.success();
        }
        return Msg.fail();
    }

    /**
     * 根据ID查名字
     */
    @RequestMapping(value = "/all/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer empId){

        Employee emp = employeeService.getEmp(empId);

        return Msg.success().add("emp", emp);
    }

    /**
     * 查所有emps返回json
     * @param pageNum
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/all",method = RequestMethod.GET)
    public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum){

        PageHelper.startPage(pageNum,5);
        List<Employee> list = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo(list,5);
        return Msg.success().add("pageInfo",page);
    }


//    @RequestMapping("/page")
    public String getEmps(Model model, @RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum){

        PageHelper.startPage(pageNum,5);
        List<Employee> list = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo(list,5);
        model.addAttribute("pageInfo",page);
        /*for (Employee e : list ){
            System.out.println("-----------------");
            System.out.println(e);
        }*/
        return "list";
    }


}
