package com.jie.service;

import com.jie.dao.EmployeeMapper;
import com.jie.entity.Employee;
import com.jie.entity.EmployeeExample;
import com.jie.entity.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;


    /**
     * 查询所有emps
     * @return list:所有emp
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     *  增加员工
     * @param employee
     * @return int
     */
    public int addEmp(Employee employee) {

        int i = employeeMapper.insertSelective(employee);

        return i;
    }

    /**
     * 检验用户是否可用
     * @return true:代表可用 false:不可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer empId) {

        Employee employee = employeeMapper.selectByPrimaryKey(empId);

        return employee;
    }

    /**
     * 通过主键更新
     * @param employee
     * @return
     */
    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 通过ID删除
     * @param id
     * @return
     */
    public int dropOne(Integer id) {
        int i = employeeMapper.deleteByPrimaryKey(id);
        return i;
    }

    /**
     * 批量批量删除
     * @param list
     * @return
     */
    public int dropMany(List<Integer> list) {

        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria c = example.createCriteria();
        c.andEmpIdIn(list);
        int i = employeeMapper.deleteByExample(example);
        System.out.println("*************"+i);
        return i;
    }
}
