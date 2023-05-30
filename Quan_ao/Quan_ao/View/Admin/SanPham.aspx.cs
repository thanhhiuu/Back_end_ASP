﻿using Quan_ao.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quan_ao.View.Admin
{
    public partial class SanPham : System.Web.UI.Page
    {
        private Shop_quan_ao db = new Shop_quan_ao();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var result = from sp in db.SANPHAMs
                             join dm in db.DanhMuc_SP on sp.MaDMSP equals dm.MaDMSP
                             select new
                             {
                                 sp.MaSP_ID,
                                 dm.TenMuc,
                                 sp.TenSP,
                                 sp.Gia,
                                 sp.URL_Hinh_Anh,
                                 sp.LuotMua,
                             };
                result = result.OrderByDescending(x => x.MaSP_ID);
                GV_SanPham.DataSource = result.ToList();
                GV_SanPham.DataBind();

                // phần thêm
                ddl_danhmuc.DataSource = db.DanhMucs.ToList();
                ddl_danhmuc.DataTextField = "TenDanhMuc";
                ddl_danhmuc.DataValueField = "MaDanhMuc";
                ddl_danhmuc.DataBind();
            }
        }

        protected void GV_SanPham_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maSP_ID = Convert.ToInt32(GV_SanPham.DataKeys[e.RowIndex].Values["MaSP_ID"]);
            if (maSP_ID != null)
            {
                var sp = db.SANPHAMs.Find(maSP_ID);
                try
                {
                    db.SANPHAMs.Remove(sp);
                    db.SaveChanges();
                }
                catch (Exception)
                {
                    lbl_canh_bao.Text = "không thể xoá được do có dữ liệu liên quan";
                    return;
                }
            }
            Response.Redirect("SanPham.aspx");
        }
        protected void GV_SanPham_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "XemThongtinSP")
            {
                int maSP = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"XemThongtinSP.aspx?ID={maSP}");
            }
            if (e.CommandName == "XemKhoHang")
            {
                int maSP = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"XemKhoHang.aspx?ID={maSP}");
            }
        }

        protected void btn_them_sp_Click(object sender, EventArgs e)
        {
            SANPHAM db_add = new SANPHAM();
            db_add.MaDMSP = int.Parse(ddl_danhmuc.SelectedValue.ToString());
            db_add.TenSP = txtTensp.Text;
            db_add.Gia = int.Parse(txtgia.Text);

            db_add.URL_Hinh_Anh = FU_IMG.FileName.ToString();
            string filePath = Path.Combine(Server.MapPath("~/Content/IMG/hinh_san_pham/"), FU_IMG.FileName);
            FU_IMG.SaveAs(filePath);

            db_add.NhanXet = txtnhanxet.Text;
            db_add.DanhGia = int.Parse(txtdanhgia.Text);
            db_add.TinhTrang = true;
            db_add.LuotMua = 0;
            db.SANPHAMs.Add(db_add);
            db.SaveChanges();
            Response.Redirect("SanPham.aspx");
        }

        protected void GV_SanPham_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            int pageCount = GV_SanPham.PageCount;
            GV_SanPham.PageIndex = e.NewPageIndex;
            var result = from sp in db.SANPHAMs
                         join dm in db.DanhMuc_SP on sp.MaDMSP equals dm.MaDMSP
                         select new
                         {
                             sp.MaSP_ID,
                             dm.TenMuc,
                             sp.TenSP,
                             sp.Gia,
                             sp.TinhTrang,
                             sp.URL_Hinh_Anh,
                             sp.LuotMua,
                         };
            result = result.OrderByDescending(x => x.MaSP_ID);
            // var row = GV_SanPham.Rows[e.NewPageIndex];
            // var data = (DropDownList)row.FindControl("TenMuc");
            GV_SanPham.DataSource = result.ToList();
            GV_SanPham.DataBind();
        }
    }
}