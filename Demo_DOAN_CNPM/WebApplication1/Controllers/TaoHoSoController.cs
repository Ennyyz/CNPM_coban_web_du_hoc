using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class TaoHoSoController : Controller
    {
        // GET: TaoHoSo
        private CNPM_DEAN_TESTEntities db = new CNPM_DEAN_TESTEntities();
        public ActionResult Index()
        {
            return View(db.HoSoDuHocs.ToList());
        }
        public ActionResult HoSo()
        {
            // Lấy MaKhachHang từ biến Session (đảm bảo rằng khách hàng đã đăng nhập)
            int? maKhachHang = (int?)Session["MaKhachHang"];

            if (maKhachHang == null)
            {
                // Không tìm thấy MaKhachHang trong Session, có thể điều hướng đến trang thông báo hoặc trang đăng nhập.
                return RedirectToAction("LoginCus", "KhachHangs"); // Ví dụ điều hướng đến trang đăng nhập.
            }

            // Truy vấn hồ sơ của khách hàng dựa trên MaKhachHang
            var hoSoDuHoc = db.HoSoDuHocs.SingleOrDefault(h => h.MaKhachHang == maKhachHang);

            if (hoSoDuHoc == null)
            {
                // Không tìm thấy hồ sơ cho khách hàng, có thể điều hướng đến trang thông báo hoặc trang tạo hồ sơ.
                return RedirectToAction("Create", "TaoHoSo"); // Ví dụ điều hướng đến trang tạo hồ sơ.
            }

            // Khách hàng đã có hồ sơ, hiển thị trang hồ sơ
            return View(hoSoDuHoc);
        }
        public ActionResult HoSoDaCo()
        {
            // Hiển thị trang thông báo "Bạn đã có hồ sơ. Vui lòng đến Trang Hồ sơ cá nhân"
            return View();
        }

        public ActionResult Create()
        {
            int? maKhachHang = (int?)Session["MaKhachHang"];

            if (maKhachHang == null)
            {
                // Handle not logged in user
                return RedirectToAction("LoginCus", "KhachHangs");
            }

            var hoSoDuHoc = db.HoSoDuHocs.SingleOrDefault(h => h.MaKhachHang == maKhachHang);
            var sdt = db.KhachHangs.Where(h => h.MaKhachHang == maKhachHang).Select(h=>h.SoDienThoai).FirstOrDefault();
            var email = db.KhachHangs.Where(h => h.MaKhachHang == maKhachHang).Select(h=>h.EmailKH).FirstOrDefault();
            if (hoSoDuHoc != null)
            {
                return RedirectToAction("HoSoDaCo", "TaoHoSo");
            }

            var khachHang = db.KhachHangs.SingleOrDefault(kh => kh.MaKhachHang == maKhachHang);

            if (khachHang != null)
            {
                var newHoSoDuHoc = new HoSoDuHoc
                {
                    MaKhachHang = maKhachHang,
                    TrangThai = "Nộp hồ sơ"
                };
                DateTime ngaynop = DateTime.Now;
                ViewBag.TenKhachHang = khachHang.TenKhachHang;
                ViewBag.SDT = sdt;
                ViewBag.EmailKH = email;
                ViewBag.NgayNop = ngaynop;
                return View(newHoSoDuHoc);
            }

            return RedirectToAction("LoginCus", "KhachHangs"); // Handle the case where MaKhachHang is not found in KhachHangs table.
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(HoSoDuHoc hoSoDuHoc)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    int? maKhachHang = (int?)Session["MaKhachHang"];

                    if (maKhachHang != null)
                    {
                        hoSoDuHoc.MaKhachHang = maKhachHang;

                        // Lưu thông tin hồ sơ vào cơ sở dữ liệu
                        hoSoDuHoc.NgayNop = DateTime.Now;
                        db.HoSoDuHocs.Add(hoSoDuHoc);
                       
                        db.SaveChanges();

                        // Lấy thông tin tên khách hàng từ cơ sở dữ liệu
                        string tenKhachHang = db.KhachHangs
                                               .Where(kh => kh.MaKhachHang == maKhachHang)
                                               .Select(kh => kh.TenKhachHang)
                                               .FirstOrDefault();

                        ViewBag.TenKH = tenKhachHang;
                        return RedirectToAction("Info", "Home");
                        // Chuyển hướng đến trang thông báo đăng ký thành công                       
                    }
                    return RedirectToAction("Create", "TaoHoSo");
                }
                else
                {
                    // Trả về view với dữ liệu khách hàng và hiển thị lỗi xác thực
                    ViewBag.ErrorMessages = "Có lỗi xảy ra. Vui lòng kiểm tra lại thông tin.";
                    return View(hoSoDuHoc);
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
                return View(hoSoDuHoc);
            }
        }
        public ActionResult CreateFile()
        {
            return View();
        }

        // POST: Customers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateFile([Bind(Include = "MaHoSo,HocLuc,TiengAnh,NgayNop,TrangThai,MaBacHoc,MaKhachHang")] HoSoDuHoc hoso)
        {
            if (ModelState.IsValid)
            {
                db.HoSoDuHocs.Add(hoso);
                db.SaveChanges();
                return RedirectToAction("LoginCus");
            }
            return View(hoso);
        }
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoSoDuHoc hoso = db.HoSoDuHocs.Find(id);
            if (hoso == null)
            {
                return HttpNotFound();
            }
            return View(hoso);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            HoSoDuHoc hoso = db.HoSoDuHocs.Find(id);
            db.HoSoDuHocs.Remove(hoso);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            //HoSoDuHoc hoSo = db.HoSoDuHocs.Find(id);
            HoSoDuHoc hoSo = db.HoSoDuHocs.Include("KhachHang").SingleOrDefault(h => h.MaHoSo == id);
            if (hoSo == null)
            {
                return HttpNotFound();
            }

            ViewBag.MaBacHocList = new SelectList(new[]
            {
                new SelectListItem { Value = "tien-si", Text = "Tiến sĩ" },
                new SelectListItem { Value = "sau-dai-hoc", Text = "Sau Đại học" },
                new SelectListItem { Value = "dai-hoc", Text = "Đại học" },
                new SelectListItem { Value = "du-bi-dai-hoc", Text = "Dự bị Đại học" }
            }, "Value", "Text", hoSo.MaBacHoc); 
            ViewBag.TrangThaiList = new SelectList(new[]
            {
                new SelectListItem { Value = "Nộp hồ sơ", Text = "Nộp hồ sơ" },
                new SelectListItem { Value = "Tư vấn", Text = "Tư vấn" },
                new SelectListItem { Value = "Nhận hồ sơ và Thanh toán", Text = "Nhận hồ sơ và Thanh toán" },
                new SelectListItem { Value = "Đã gửi", Text = "Đã gửi" },
                new SelectListItem { Value = "Đã nhận", Text = "Đã nhận" },
                new SelectListItem { Value = "Kết quả", Text = "Kết quả" }
            }, "Value", "Text", hoSo.TrangThai);

            var khachHang = db.KhachHangs.FirstOrDefault(kh => kh.MaKhachHang == hoSo.MaKhachHang);
            if (khachHang != null)
            {
                ViewBag.MaKhachHang = khachHang.MaKhachHang;
                ViewBag.TenKhachHang = khachHang.TenKhachHang;
            }

            return View(hoSo);
        }
        // POST: TaoHoSo/Edit/5
        [HttpPost]
        public ActionResult Edit(HoSoDuHoc hoSo)
        {
            if (ModelState.IsValid)
            {
                var existingHoSo = db.HoSoDuHocs.Find(hoSo.MaHoSo); 
                if (existingHoSo != null)
                {
                    existingHoSo.HocLuc = hoSo.HocLuc;
                    existingHoSo.TiengAnh = hoSo.TiengAnh;
                    existingHoSo.NgayNop = hoSo.NgayNop;
                    existingHoSo.TrangThai = hoSo.TrangThai;
                    existingHoSo.MaBacHoc = hoSo.MaBacHoc;
                    db.Entry(existingHoSo).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(hoSo);
        }

    }
}