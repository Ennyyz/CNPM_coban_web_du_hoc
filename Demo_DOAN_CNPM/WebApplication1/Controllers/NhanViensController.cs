using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class NhanViensController : Controller
    {
        // GET: NhanViens
        private CNPM_DEAN_TESTEntities db = new CNPM_DEAN_TESTEntities();
        public ActionResult Index()
        {
            return View(db.NhanViens.ToList());
        }
        public ActionResult CreateAdmin()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateAdmin(NhanVien nhanvien)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    // Lưu thông tin khách hàng vào cơ sở dữ liệu
                    db.NhanViens.Add(nhanvien);
                    db.SaveChanges();

                    // Chuyển hướng đến trang đăng nhập hoặc trang thông báo đăng ký thành công
                    return RedirectToAction("LoginAdmin"); // Thay thế "LoginCus" bằng tên action của trang đăng nhập
                }
                else
                {
                    // Trả về view với dữ liệu khách hàng và hiển thị lỗi xác thực
                    ViewBag.ErrorMessages = "Có lỗi xảy ra. Vui lòng kiểm tra lại thông tin.";
                    return View(nhanvien);
                }
            }
            catch (DbEntityValidationException ex)
            {
                // Xử lý các lỗi xác thực
                var errorMessages = ex.EntityValidationErrors
                    .SelectMany(eve => eve.ValidationErrors)
                    .Select(e => e.ErrorMessage).ToList();

                // Đưa các thông báo lỗi vào ViewBag để hiển thị trên view
                ViewBag.ErrorMessages = errorMessages;

                // Trả về view với dữ liệu khách hàng và hiển thị lỗi xác thực
                return View(nhanvien);
            }
        }
        public ActionResult LoginAdmin()
        {
            return View();
        }
        public ActionResult LoginAcountAdmin(NhanVien _ad)
        {
            // check là khách hàng cần tìm
            var check = db.NhanViens.Where(s => s.EmailNV == _ad.EmailNV && s.MatKhau == _ad.MatKhau).FirstOrDefault();

            // In giá trị của biến check để xác minh đăng nhập thành công
            // Nếu giá trị không null, tức là đăng nhập thành công
            // Bạn có thể kiểm tra thông qua cửa sổ Output trong Visual Studio
            Console.WriteLine("Check value: " + check);
            if (check == null) //không có KH
            {
                ViewBag.ErrorInfo = "Không có khách hàng này";
                return View("LoginAdmin");
            }
            else
            { // Có tồn tại KH -> chuẩn bị dữ liệu đưa về lại ShowCart.cshtml
                db.Configuration.ValidateOnSaveEnabled = false;
                Session["MaNhanVien"] = check.MaNhanVien;
                Session["MatKhau"] = check.MatKhau;
                Session["TenNhanVien"] = check.TenNhanVien;
                // Quay lại trang giỏ hàng với thông tin cần thiết
                return RedirectToAction("InfoAdmin", "Home");
            }
        }
        public ActionResult Logout()
        {
            // Xóa thông tin khách hàng trong Session khi đăng xuất
            Session["MaNhanVien"] = null;
            Session["MatKhau"] = null;
            Session["TenNhanVien"] = null;
            // Điều hướng về trang đăng nhập hoặc trang chủ tùy ý
            return RedirectToAction("InfoAdmin", "Home");
        }
    }
}