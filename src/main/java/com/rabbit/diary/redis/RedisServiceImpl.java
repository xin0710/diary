package com.rabbit.diary.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.support.atomic.RedisAtomicLong;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class RedisServiceImpl implements IRedisService {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * @Description: 获取自增长值 (每调用1次，ID自增1)
     * @param key key
     * @return
     */
    public  Long getIncr(String key) {
        RedisAtomicLong entityIdCounter = new RedisAtomicLong(key, redisTemplate.getConnectionFactory());
        Long increment = entityIdCounter.getAndIncrement();
        //entityIdCounter.expire(0, TimeUnit.SECONDS);
        return increment;
    }

    /**
     * @Description: 初始化自增长值
     * @param key key
     * @param value 当前值
     */
    public void setIncr(String key, int value) {
        RedisAtomicLong counter = new RedisAtomicLong(key, redisTemplate.getConnectionFactory());
        counter.set(value);
        //counter.expire(0, TimeUnit.SECONDS);
    }

    @Override
    public void setValue(String key, Map<String, Object> value) {
        ValueOperations<String, Object> vo = redisTemplate.opsForValue();
        vo.set(key, value);
        redisTemplate.expire(key, 1, TimeUnit.HOURS); // 这里指的是1小时后失效
    }

    @Override
    public Object getValue(String key) {
        ValueOperations<String, String> vo = redisTemplate.opsForValue();
        return vo.get(key);
    }


    @Override
    public void setValue(String key, String value) {
        ValueOperations<String, Object> vo = redisTemplate.opsForValue();
        vo.set(key, value);
        redisTemplate.expire(key, 1, TimeUnit.HOURS); // 这里指的是1小时后失效
    }

    @Override
    public void setValue(String key, Object value) {
        ValueOperations<String, Object> vo = redisTemplate.opsForValue();
        vo.set(key, value);
        redisTemplate.expire(key, 1, TimeUnit.HOURS); // 这里指的是1小时后失效
    }

    @Override
    public Object getMapValue(String key) {
        ValueOperations<String, String> vo = redisTemplate.opsForValue();
        return vo.get(key);
    }


}

