package com.myportfolio.web.domain;

import java.util.Date;
import java.util.Objects;

public class CommentDto {
    private int cno;
    private int bno;
    private int pcno;
    private String comment;
    private String commenter;
    private Date up_date;
    private Date reg_date;

    public CommentDto() {}

    public CommentDto(int bno, int pcno, String comment, String commenter) {
        this.bno = bno;
        this.pcno = pcno;
        this.comment = comment;
        this.commenter = commenter;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommentDto that = (CommentDto) o;
        return cno == that.cno && bno == that.bno && pcno == that.pcno && Objects.equals(comment, that.comment) && Objects.equals(commenter, that.commenter);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cno, bno, pcno, comment, commenter);
    }

    @Override
    public String toString() {
        return "CommentDto{" +
                "cno=" + cno +
                ", bno=" + bno +
                ", pcno=" + pcno +
                ", comment='" + comment + '\'' +
                ", commenter='" + commenter + '\'' +
                ", up_date=" + up_date +
                ", reg_date=" + reg_date +
                '}';
    }

    public int getCno() {
        return cno;
    }

    public void setCno(int cno) {
        this.cno = cno;
    }

    public int getBno() {
        return bno;
    }

    public void setBno(int bno) {
        this.bno = bno;
    }

    public int getPcno() {
        return pcno;
    }

    public void setPcno(int pcno) {
        this.pcno = pcno;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public Date getUp_date() {
        return up_date;
    }

    public void setUp_date(Date up_date) {
        this.up_date = up_date;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }
}
