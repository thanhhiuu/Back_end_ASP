﻿<%@ Page Title="" Language="C#" MasterPageFile="~/View/Admin/Page_Admin.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="Quan_ao.View.Admin.SanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .bg-dark{
            margin-bottom:10px;
        }
        .form-group label{
            font-weight:bold;
            color:#A55129;
        }

        div table tbody tr td  input  {
          background:#FFA500;
          border: 2px solid #FFA500;
          color:white;
          text-align:center;
          margin: 0 auto;
          
        }
        div table tbody tr td  input:hover {
             background-color:#A52A2A;
             transition:0.5s;
        }
        .form-group{
             display:flex;
        }
        div #ContentPlaceHolder1_btn_them_sp{
            background: #FFA500;
            border: 2px solid #FFA500;
            color: white;
            text-align: center;
            font-weight:bold;
        }
        div #ContentPlaceHolder1_btn_them_sp:hover{
            background-color:#A52A2A;
            transition:0.5s;
        }
    </style>
        <div class="form-horizontal">
        <div class="form-group">
            <label class="control-label col-md-2">Chọn Danh mục</label>
            <div class="col-md-4">
                <asp:DropDownList ID="ddl_danhmuc" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2">Tên sản phẩm</label>
            <div class="col-md-2">
                <asp:TextBox ID="txtTensp" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2">Giá</label>
            <div class="col-md-2">
                <asp:TextBox ID="txtgia" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2">Hình ảnh</label>
            <div class="col-md-2">
                <asp:FileUpload ID="FU_IMG" runat="server" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2">Nhận xét</label>
            <div class="col-md-2">
                <asp:TextBox ID="txtnhanxet" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2">Đánh giá</label>
            <div class="col-md-2">
                <asp:TextBox ID="txtdanhgia" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2"></label>
            <div class="col-md-4">
                <asp:Button ID="btn_them_sp" runat="server" Text="Thêm mới" OnClick="btn_them_sp_Click" />
            </div>
        </div>
    </div>
    <div>
        <asp:Label ID="lbl_canh_bao" runat="server" Text=""></asp:Label>
        <asp:GridView ID="GV_SanPham" DataKeyNames="MaSP_ID" runat="server" OnRowDeleting="GV_SanPham_RowDeleting"  OnRowCommand="GV_SanPham_RowCommand" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="GV_SanPham_PageIndexChanging" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2">
            <Columns>
                 <asp:BoundField DataField="MaSP_ID" HeaderText="Mã Sản phẩm" />
                  <asp:TemplateField HeaderText="TenDanhMuc">
                        <ItemTemplate>
                            <asp:Label ID="lbldanhmuc" runat="server" Text='<%# Bind("TenMuc") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlTenDM" runat="server"></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                 <asp:BoundField DataField="TenSP" HeaderText="Tên SP" />
                 <asp:BoundField DataField="Gia" HeaderText="Giá SP" />
                 <asp:TemplateField HeaderText="HinhAnh">
                        <ItemTemplate>
                            <asp:Image ID="IMG_sp"  Width="100" runat="server" ImageUrl='<%# ResolveUrl("~/Content/IMG/hinh_san_pham/" + Eval("URL_Hinh_Anh")) %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
        <asp:FileUpload ID="File_taihinh" runat="server" />
                        </EditItemTemplate>
                  </asp:TemplateField>
             
                    <asp:TemplateField HeaderText="Tác vụ">
                        <ItemTemplate>
                            <asp:Button ID="btXoas" runat="server" Text="Xoá" 
                                OnClientClick="return confirm('Bạn có đồng ý xoá sản phẩm này không')" 
                                CommandName="Delete" />
                        </ItemTemplate>
                        <EditItemTemplate>

                        </EditItemTemplate>
                    </asp:TemplateField>
                
                 <asp:TemplateField HeaderText="Thông tin SP">
                        <ItemTemplate>
                            <asp:Button ID="btn_xem_TT" runat="server" Text="Thông tin" CommandName="XemThongtinSP" CommandArgument='<%# Eval("MaSP_ID") %>' />  </ItemTemplate>
                        <EditItemTemplate></EditItemTemplate>
                    </asp:TemplateField>
                 <asp:TemplateField HeaderText="Xem kho hàng">
                        <ItemTemplate>
                            <asp:Button ID="btn_xem_KH" runat="server" Text="Kho hàng" CommandName="XemKhoHang" CommandArgument='<%# Eval("MaSP_ID") %>' />  </ItemTemplate>
                        <EditItemTemplate></EditItemTemplate>
                    </asp:TemplateField>
             
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>
    </div>
</asp:Content>
