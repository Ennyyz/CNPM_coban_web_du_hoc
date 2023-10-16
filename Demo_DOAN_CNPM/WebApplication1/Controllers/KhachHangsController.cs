using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{

    public class KhachHangsController : Controller
    {
        private CNPM_DEAN_TESTEntities db = new CNPM_DEAN_TESTEntities();
        public ActionResult Index()
        {
            return View(db.KhachHangs.ToList());
        }
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang customer = db.KhachHangs.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }
        // GET: Customers/Create

        // POST: Customers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        public ActionResult CreateCustomer()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCustomer(KhachHang customer)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    // Lưu thông tin khách hàng vào cơ sở dữ liệu
                    db.KhachHangs.Add(customer);
                    db.SaveChanges();

                    // Chuyển hướng đến trang đăng nhập hoặc trang thông báo đăng ký thành công
                    return RedirectToAction("LoginCus"); // Thay thế "LoginCus" bằng tên action của trang đăng nhập
                }
                else
                {
                    // Trả về view với dữ liệu khách hàng và hiển thị lỗi xác thực
                    ViewBag.ErrorMessages = "Có lỗi xảy ra. Vui lòng kiểm tra lại thông tin.";
                    return View(customer);
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
                return View(customer);
            }
        }

        // Các action methods hiện tại và mã khác trong controller...    


        protected override void Dispose(bool disposing)
        {
            if (disposing)
                db.Dispose();
            base.Dispose(disposing);
        }
        public ActionResult LoginCus()
        {
            return View();
        }
        public ActionResult LoginAcountCus(KhachHang _cus)
        {
            // check là khách hàng cần tìm
            var check = db.KhachHangs.Where(s => s.EmailKH == _cus.EmailKH && s.MatKhau == _cus.MatKhau).FirstOrDefault();

            // In giá trị của biến check để xác minh đăng nhập thành công
            // Nếu giá trị không null, tức là đăng nhập thành công
            // Bạn có thể kiểm tra thông qua cửa sổ Output trong Visual Studio
            Console.WriteLine("Check value: " + check);
            if (check == null) //không có KH
            {
                ViewBag.ErrorInfo = "Không có khách hàng này";
                return View("LoginCus");
            }
            else
            { // Có tồn tại KH -> chuẩn bị dữ liệu đưa về lại ShowCart.cshtml
                db.Configuration.ValidateOnSaveEnabled = false;
                Session["MaKhachHang"] = check.MaKhachHang;
                Session["MatKhau"] = check.MatKhau;
                Session["TenKhachHang"] = check.TenKhachHang;
                Session["SoDienThoai"] = check.SoDienThoai;
                // Quay lại trang giỏ hàng với thông tin cần thiết
                return RedirectToAction("Info", "Home");
            }
        }
        public ActionResult Logout()
        {
            // Xóa thông tin khách hàng trong Session khi đăng xuất
            Session["MaKhachHang"] = null;
            Session["MatKhau"] = null;
            Session["TenKhachHang"] = null;
            Session["SoDienThoai"] = null;
            // Điều hướng về trang đăng nhập hoặc trang chủ tùy ý
            return RedirectToAction("Info", "Home");
        }
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang kh = db.KhachHangs.Find(id);
            if (kh == null)
            {
                return HttpNotFound();
            }
            return View(kh);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            KhachHang kh = db.KhachHangs.Find(id);
            db.KhachHangs.Remove(kh);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}