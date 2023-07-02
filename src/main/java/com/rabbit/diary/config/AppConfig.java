 package com.rabbit.diary.config;
 
 import org.springframework.boot.context.properties.ConfigurationProperties;
 import org.springframework.stereotype.Component;
 
 @Component
 @ConfigurationProperties(prefix="system")
 public class AppConfig
 {
   public String filepath;
   public String urlpath;
 
   public String getFilepath()
   {
     return this.filepath;
   }
   public void setFilepath(String filepath) {
     this.filepath = filepath;
   }
   public String getUrlpath() {
     return this.urlpath;
   }
   public void setUrlpath(String urlpath) {
     this.urlpath = urlpath;
   }
 }
