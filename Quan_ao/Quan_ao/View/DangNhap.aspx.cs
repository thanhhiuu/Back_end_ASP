﻿using Quan_ao.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quan_ao.View
{
    public partial class DangNhap : System.Web.UI.Page
    {
        private Shop_quan_ao db = new Shop_quan_ao();
        int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            // kiểm tra Session có hay chưa
            {
                if (Request.QueryString["ID"] != null)
                {
                    id = Convert.ToInt32(Request.QueryString["ID"]);
                    if (id == 10)
                        Session.Remove("ADMIN");
                }

            }
            // Phân cấp Session
        }

        protected void btDangNhap_Click(object sender, EventArgs e)
        {
            string tendangnhap = txtTenDangNhap.Text;
            string matkhau = txtMatKhau.Text;
            //truy xuat CSDL de kiem tra ton tai tai khoan can dang nhap
            var ktraTK = db.TaiKhoans.Where(x => x.TenTK == tendangnhap && x.MatKhauTk == matkhau).FirstOrDefault();

            if (ktraTK == null)
            {
                lbThongBao.Text = "Tên đăng nhập hoặc mật khẩu không đúng. Đăng nhập thất bại";
            }
            else
            {
                lbThongBao.Text = "Đăng nhập thành công";
                //luu lại trang thái đã đăng nhập thành công của người dùng vào Session
                TaiKhoan tk = (TaiKhoan)ktraTK;
                if (tk.PhanCap == true) //neu nguoi dung co vai tro la Admin
                {
                    //điều hướng người dùng đến trang dành cho đối tượng là ADMIN
                    Session["ADMIN"] = tk;
                    Response.Redirect("Admin/DanhMuc.aspx");
                }
                else if (tk.PhanCap == false)
                {
                    //điều hướng người dùng đến trang dành cho User
                    Session["USER"] = tk;
                    Response.Redirect("User/Home.aspx");
                }
            }
        }

        protected void btn_home_Click(object sender, EventArgs e)
        {
            Response.Redirect("User/Home.aspx");
        }
    }
}