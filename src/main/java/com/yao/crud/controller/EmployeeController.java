package com.yao.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yao.crud.bean.Employee;
import com.yao.crud.bean.Msg;
import com.yao.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/18 17:09
 * @Description:
 */
@Controller
@RequestMapping(value = "/employee")
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;


    /**
     * 根据id删除员工
     * 二合一既可以 单独删除 也可以 批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable(value = "ids") String  ids){
        //批量删除
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteEmpBatch(del_ids);
        }else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }
        return Msg.success();
    }

    /**
     * 更新数据 要想使用PUT请求必须配置如下
     * <filter>
     *         <filter-name>HiddenHttpMethodFilter</filter-name>
     *         <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
     *     </filter>
     *     <filter-mapping>
     *         <filter-name>HiddenHttpMethodFilter</filter-name>
     *         <url-pattern>/*</url-pattern>
     *     </filter-mapping>
     * @param employee
     * @return
     */
    @RequestMapping(value = "/save/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmpById(Employee employee){

        employeeService.updateEmpById(employee);
        return Msg.success();
    }

    /**
     * 点击编辑回显数据
     * @param empId
     * @return
     */
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@RequestBody @PathVariable(value = "id", required = false) Integer empId) {
        Employee employee = employeeService.getEmpById(empId);
        return Msg.success().add("emp", employee);
    }

    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */
    @RequestMapping(value = "/checkname")
    @ResponseBody
    public Msg checkUser(@RequestBody String empName) {
        System.out.println(empName);
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    /**
     * 1.支持JSR303校验 在实体类中加入规则
     * 2.导入hibernate-validator
     *
     * 把数据员工信息保存到数据库
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmployee(@Valid Employee employee, BindingResult result) {
        Map<String, Object> map = new HashMap<>();
        //校验信息判断
        if (result.hasErrors()) {
            FieldError fieldError = result.getFieldError();
            System.out.println("错误字段：" + fieldError.getField());
            System.out.println("错误信息：" + fieldError.getDefaultMessage());
            map.put(fieldError.getField(), fieldError.getDefaultMessage());
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmployee(employee);
            return Msg.success();
        }
    }

    /**
     * 返回json数据进行交互   员工列表查询（分页查询）
     *
     * @param pn
     * @return
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public Msg getEmployeeWithJson( @RequestParam(name = "pn", defaultValue = "1") @RequestBody Integer pn) {
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 7);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        //用PageInfo对结果进行包装 5表示是页码显示几个
        PageInfo page = new PageInfo(employees, 5);
        //return page;
        return Msg.success().add("pageInfo", page);

    }

    /**
     * 员工列表查询（分页查询）
     *
     * @param pn
     * @param model
     * @return
     */
    //@RequestMapping(value = "/list")
    public String selectAllList(@RequestParam(name = "pn", defaultValue = "1") Integer pn, Model model) {
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 7);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> employees = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        //用PageInfo对结果进行包装 5表示是页码显示几个
        PageInfo page = new PageInfo(employees, 5);
        //把封装后的数据放到域中
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
