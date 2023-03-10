package com.myportfolio.web.controller;

import com.myportfolio.web.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SimpleRestController {
    @GetMapping("/ajax")
    public String ajax() {
        return "ajax";
    }

    @GetMapping("/test")
    public String test() {
        return "test";
    }

    @PostMapping("/send")
    @ResponseBody
    public Person test(@RequestBody Person p) {
        System.out.println("p = " + p);
        p.setName("ABC");
        p.setAge(p.getAge() + 10);

        return p;
    }
}
