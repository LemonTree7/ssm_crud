package com.yao.crud.service.impl;

import com.yao.crud.bean.Employee;
import com.yao.crud.bean.EmployeeExample;
import com.yao.crud.dao.EmployeeMapper;
import com.yao.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/19 17:33
 * @Description:
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 获取所有员工数据列表
     *
     * @return
     */
    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工数据
     *
     * @param employee
     */
    @Override
    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /***
     * 检验用户是否可用
     *  true：代表当前姓名可用   fasle：不可用
     * @param empName
     * @return
     */
    @Override
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 数据回显
     * @param empId
     * @return
     */
    @Override
    public Employee getEmpById(Integer empId) {
        Employee employee = employeeMapper.selectByPrimaryKey(empId);
        return employee;
    }

    /**
     * 更新数据
     * @param employee
     */
    @Override
    public void updateEmpById(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);

    }

    /**
     * 删除员工 根据id
     * @param id
     */
    @Override
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteEmpBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from ** where id in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
