package com.yao.crud.controller;

import com.yao.crud.bean.Department;
import com.yao.crud.bean.Msg;
import com.yao.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/20 11:03
 * @Description:
 */
@Controller
@RequestMapping(value = "/department")
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    /**
     * 返回所有部门信息
     * @return
     */

    @RequestMapping(value = "/list")
    @ResponseBody
    public Msg getDepartmentList(){
        //查出所有的部门信息
        List<Department> list = departmentService.getAllDepartment();
        return Msg.success().add("depts", list);

    }
}
