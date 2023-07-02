package com.rabbit.diary.service;

import com.rabbit.diary.bean.User;
import org.springframework.stereotype.Service;

public interface UserService {

    User getByUserName(String userName);

    void save(User user);

    public User getByUserId(long loginIdAsLong);

    void update(User user);
}
