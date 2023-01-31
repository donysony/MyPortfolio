package com.myportfolio.web.controller;

import com.myportfolio.web.domain.CommentDto;
import com.myportfolio.web.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

//@Controller
//@ResponseBody 이 두개를 묶은게 @RestController
@RestController
public class CommentController {


    @Autowired
    CommentService service;
    // 지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments") //comments?bno=1080 GET
   public ResponseEntity<List<CommentDto>> list(Integer bno) {
        List<CommentDto> list = null;
        try {
            list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK); //200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); //400
        }
    }

    //지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}") // /comments/1?bno=1089 <--삭제할 댓글 번호 쿼리스트링에 있는 것은 @PathVariable를 붙일 필요없음
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";
        try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt !=1)
                throw new Exception("Delete Failed");
            return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //댓글을 등록하는 메서드

    @PostMapping("/comments") // /ch4/comments?bno=1085  POST
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session) {
        String commenter = "asdf";
        dto.setCommenter(commenter);
        dto.setBno(bno);
        System.out.println("controller dto = " + dto);

        try {
            if (service.write(dto) != 1)
                throw new Exception("Write failed");
            return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
        }

    }

    //댓글을 수정하는 메서드

    @PatchMapping("/comments/{cno}") // /ch4/comments/30 PATCH
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";
        dto.setCommenter(commenter);
        dto.setCno(cno);
        System.out.println("dto = " + dto);

        try {
            if (service.modify(dto) != 1)
                throw new Exception("Write failed");
            return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }

    }
}
