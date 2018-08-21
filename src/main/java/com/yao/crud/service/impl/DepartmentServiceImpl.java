package com.yao.crud.service.impl;

import com.yao.crud.bean.Department;
import com.yao.crud.dao.DepartmentMapper;
import com.yao.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/20 11:07
 * @Description:
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAllDepartment() {
        return departmentMapper.selectByExample(null);
    }
}
