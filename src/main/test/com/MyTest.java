package com;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mysql.cj.exceptions.WrongArgumentException;
import com.rabbit.diary.DiaryApplication;
import com.rabbit.diary.bean.Customer;
import com.rabbit.diary.dao.CustomerMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Objects;

@Slf4j
@SpringBootTest(classes = {DiaryApplication.class})
@RunWith(SpringJUnit4ClassRunner.class)
public class MyTest {

    @Resource
    CustomerMapper customerMapper;

    @Test
    public void tt(){
        customerMapper.insert(Customer.builder().name("小火龙").idno("1").build());
        customerMapper.insert(Customer.builder().name("杰尼龟").idno("2").build());
        customerMapper.insert(Customer.builder().name("妙蛙种子").idno("3").build());
    }

    /**
     * 测试新增
     */
    @Test
    public void insert(){
        //模拟前台传过来的Req
        Customer customerReq = Customer.builder().name("火球鼠").idno("1").build();
        //先检查身份证号是否存在于数据库中
        checkIdnoNew(customerReq);
        //正常入库
        customerMapper.insert(customerReq);
    }

    /**
     * 修改
     */
    public void edit(Customer customerReq){

        //根据id查询数据库是否有这条数据
        Customer customer = customerMapper.selectById(customerReq.getId());
        //如果不存在或者跟原来的idno不一致，才进行校验
        Boolean isNeedCheck = true;
        if(customer != null && customer.getIdno().equals(customerReq.getIdno())){
            isNeedCheck = false;
        }

        //检查身份证号是否存在于数据库中
        if(isNeedCheck) {
            checkIdno(customerReq.getIdno());
        }
        //根据id查询数据库的数据
        Customer customerDto = getById(customerReq.getId());
        //更新name
        customerDto.setName(customerReq.getName());
        //更新idno
        customerDto.setIdno(customerReq.getIdno());
        //入库
        customerMapper.updateById(customerDto);
    }

    public void edit2(Customer customerReq){

        checkIdnoNew(customerReq);

        //根据id查询数据库的数据
        Customer customerDto = getById(customerReq.getId());
        //更新name
        customerDto.setName(customerReq.getName());
        //更新idno
        customerDto.setIdno(customerReq.getIdno());
        //入库
        customerMapper.updateById(customerDto);
    }

    private void checkIdnoNew(Customer customerReq) {
        /**
         * 直接根据idno查询，无非有两种情况
         *  1.查出来为null，说明没有这个idno，安全
         *  2.查出来有一条数据，又分两种情况
         *      2.1 这条数据就是要编辑的原数据：说明我们修改这条记录并且没改idno，安全
         *      2.2 这条数据不是要编辑的元数据：说明我们修改这条记录并且改了idno，还和别的记录的idno重复了，不安全
         *  总结：如果查出来有数据并且id和要编辑数据的id不同，才不安全
         */
        LambdaQueryWrapper<Customer> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        Customer one = customerMapper.selectOne(lambdaQueryWrapper.eq(Customer::getIdno, customerReq.getIdno()));
        if(Objects.nonNull(one) && !Objects.equals(one.getId(),customerReq.getId())){
            throw new WrongArgumentException("身份证重复！");
        }
    }

    //测试编辑功能，修改其他字段但idno不变
    @Test
    public void testEdit01() throws Exception {
        //模拟前台传过来的Req => 只改姓名不改身份证
        Customer customerReq = Customer.builder().id(1).name("喷火龙").idno("1").build();
        edit2(customerReq);

    }

    //测试编辑功能，修改idno但是和其他数据的idno一样
    @Test
    public void testEdit02() throws Exception {
        try {
            Customer customerReq = Customer.builder().id(1).name("喷火龙").idno("2").build();
            edit2(customerReq);
        }catch(Exception e){
            return; //如果报错就对了
        }

        throw new Exception("测试失败！");
    }

    //测试编辑功能，修改idno但是和其他数据的idno都不一样
    @Test
    public void testEdit03(){
        Customer customerReq = Customer.builder().id(1).name("喷火龙").idno("5").build();
        edit2(customerReq);
    }

    private Customer getById(Integer id) {
        return customerMapper.selectById(id);
    }

    private void checkIdno(String idno) {
        LambdaQueryWrapper<Customer> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        Customer one = customerMapper.selectOne(lambdaQueryWrapper.eq(Customer::getIdno, idno));
        //不是空，说明有这个idno的数据
        if(one != null){
            throw new WrongArgumentException("身份证重复！");
        }
    }
}
