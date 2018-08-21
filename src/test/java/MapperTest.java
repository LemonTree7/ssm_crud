import com.yao.crud.bean.DepartmentExample;
import com.yao.crud.bean.Employee;
import com.yao.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @Auther: 柠檬CC
 * @Date: 2018/8/19 15:54
 * @Description:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void test(){

        //System.out.println(employeeMapper.selectByExampleWithDept(null));
        //System.out.println(employeeMapper.selectByPrimaryKeyWithDept(8));

        //3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。

//		for(){
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<20;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null, uid, uid+"@163.com", "男", 4));
        }
        System.out.println("批量完成");


    }

}
