package com.rabbit.diary.util;

import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

import java.util.Scanner;

public class AutoGeneratorConfig {

    /**
     * <p>
     * 读取控制台内容
     * </p>
     */
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (StringUtils.isNotBlank(ipt)) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }

    public static <FileOutConfig> void main2(String[] args) {
        String projectPath = System.getProperty("user.dir");

        // 全局配置
        GlobalConfig gc = new GlobalConfig.Builder()
                .author("别来无恙")
                .outputDir(projectPath + "/src/main/java")
                .openDir(false).build();


        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig.Builder("jdbc:mysql://localhost:3306/diary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC","root","").build();
        // 代码生成器
        AutoGenerator mpg = new AutoGenerator(dsc);
        mpg.global(gc);
        // 包配置
        PackageConfig pc = new PackageConfig.Builder()
                .controller("web")
                .entity("bean")
                .mapper("dao")
                .service("service")
                .serviceImpl("service.impl")
                .parent("com.rabbit.diary").build();

        mpg.packageInfo(pc);

        // 5、策略配置
        StrategyConfig strategy = new StrategyConfig.Builder()
                .addInclude(scanner("数据表名"))
                .addTablePrefix("")
                .entityBuilder()
                // 数据库表映射到实体的命名策略,驼峰命名法
                .naming(NamingStrategy.underline_to_camel)
                //数据库表字段映射到实体的命名策略
                .columnNaming(NamingStrategy.underline_to_camel)
                // lombok 模型 @Accessors(chain = true) setter链式操作
                .enableLombok()
                .controllerBuilder()
                //restful api风格控制器
                .enableRestStyle()
                //url中驼峰转连字符
                .enableHyphenStyle().build();
        mpg.strategy(strategy);
        mpg.execute();
    }

}

