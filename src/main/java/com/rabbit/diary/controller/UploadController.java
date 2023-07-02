package com.rabbit.diary.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.UUID;
import com.rabbit.diary.bean.core.BizException;
import com.rabbit.diary.bean.core.ExceptionCodeEnum;
import com.rabbit.diary.config.AppConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;

@RestController

public class UploadController {

    @Autowired
    AppConfig appConfig;

    @RequestMapping({"/upload"})
    public Map upload(@RequestParam("file") MultipartFile file) {
        String fileName = "";
        if (!file.isEmpty()){
            /**
             * 获取文件后缀名
             */
            String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));

            if(suffix.equals(".PNG") || suffix.equals(".png") || suffix.equals(".jpg") || suffix.equals(".JPG") ) {

            }else{
                throw new BizException(ExceptionCodeEnum.ERROR.setDesc("非法文件格式！"));
            }

            /**
             * 文件名
             */
            fileName = System.currentTimeMillis() + suffix;
            /**
             * 返回的文件路径
             */
            String fileNameForReturn = "/"+ StpUtil.getLoginIdAsLong()  + "/" + fileName;
            /**
             * 文件的保存路径
             */
            String saveFilePath = this.appConfig.getFilepath() + "/"+StpUtil.getLoginIdAsLong();
            /**
             * 父级目录若不存在就创建
             */
            if(!new File(saveFilePath).exists()) {
                new File(saveFilePath).mkdir();
            }
            String saveFileName = saveFilePath + "/" + fileName;
            System.out.println(saveFileName);
            File dest = new File(saveFileName);
            try {
                /**
                 * 拷贝文件
                 */
                file.transferTo(dest);
                return new HashMap(){{
                    put("file",fileNameForReturn);
                }} ;
            } catch (IOException e) {
                e.printStackTrace();
                throw new BizException(ExceptionCodeEnum.ERROR.setDesc("系统异常！"));
            }

        }

        return null;
    }

    @RequestMapping({"/editor"})
    @ResponseBody
    public Object editor(@RequestParam("file") MultipartFile file) {
        String fileName = "";
        String date = DateUtil.format(new Date(), "yyyyMMdd");
        if (!file.isEmpty())
        {
            //if (file.getSize() > 5242880L * 10) return new WangEditorResponse("1", "文件太大，请上传小于5MB的");
            String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));

            fileName = System.currentTimeMillis() + suffix;

            String fileNameForReturn = "/article/" + date + "/" + file.getOriginalFilename(); //改成原名字，上传的时候注意点就行
            String saveFilePath = this.appConfig.getFilepath() + "/article/" + DateUtil.format(new Date(), "yyyyMMdd");

            if(!new File(saveFilePath).getParentFile().exists()) {
                new File(saveFilePath).getParentFile().mkdir();
            }

            if(!new File(saveFilePath).exists()) {
                new File(saveFilePath).mkdir();
            }
            String saveFileName = saveFilePath + "/" + file.getOriginalFilename();

            //如果是复制粘贴的图片，做特殊处理
            if(file.getOriginalFilename().equals("image.png")){
                String uid = UUID.randomUUID().toString();
                saveFileName = saveFilePath + "/" + uid + ".png";
                fileName =  uid + ".png";; //文章返显
                fileNameForReturn = "/article/" + date + "/" + uid + ".png";
            }
            System.out.println(saveFileName);

            File dest = new File(saveFileName);

            System.out.println(dest.getParentFile().getPath());
            if (!dest.getParentFile().exists())
                dest.getParentFile().mkdir();
            try
            {
                file.transferTo(dest);
                if(suffix.equals(".PNG") || suffix.equals(".png") || suffix.equals(".jpg") || suffix.equals(".JPG") ) {
                    /*
                     * ImgUtil.pressText( FileUtil.file(saveFileName), FileUtil.file(saveFileName),
                     * pressText, Color.BLACK, new Font("黑体", 1, 38), 0, 0, 0.16F);
                     *
                     * System.out.println("水印添加成功！");
                     */
                }else {
                    //非图片资源
                    Map<String,Object> map = new HashMap<>();
                    map.put("saveFileName", fileNameForReturn);
                    return map;
                }

            }
            catch (Exception e) {
                e.printStackTrace();
                return new WangEditorResponse("1", "上传失败" + e.getMessage());
            }
        }
        else {
            return new WangEditorResponse("1", "上传出错");
        }
        String imgUrl = this.appConfig.getUrlpath() + "article/" + date + "/" + fileName;
        return new WangEditorResponse("0", imgUrl);
    }

    private class WangEditorResponse
    {
        String errno;
        List<String> data;

        public String getErrno()
        {
            return this.errno;
        }
        public void setErrno(String errno) {
            this.errno = errno;
        }
        public List<String> getData() {
            return this.data;
        }
        public void setData(List<String> data) {
            this.data = data;
        }
        public WangEditorResponse(String errno) {
            this.errno = errno;
            this.data = data;
        }
        public WangEditorResponse(String errno, String data) {
            this.errno = errno;
            this.data = new ArrayList();
            this.data.add(data);
        }
    }


}
