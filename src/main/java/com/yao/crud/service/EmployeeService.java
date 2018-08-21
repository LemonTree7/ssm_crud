package com.yao.crud.service;

import com.yao.crud.bean.Employee;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/19 17:30
 * @Description:
 */

public interface EmployeeService {

    public List<Employee> getAll();

    public void saveEmployee(Employee employee);

    public boolean checkUser(String empName);

    public Employee getEmpById(Integer empId);

    public void updateEmpById(Employee employee);

    public void deleteEmpById(Integer id);

    public void deleteEmpBatch(List<Integer> ids);
}
