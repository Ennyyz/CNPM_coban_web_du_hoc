using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class BaiVietsController : Controller
    {
        // GET: BaiViets
        private CNPM_DEAN_TESTEntities db = new CNPM_DEAN_TESTEntities();

        public ActionResult Index()
        {
            return View(db.BaiViets.ToList());
        }
        public ActionResult IndexAdmin()
        {
            return View(db.BaiViets.ToList());
        }
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BaiViet baiviet = db.BaiViets.Find(id);
            if (baiviet == null)
            {
                return HttpNotFound();
            }
            return View(baiviet);
        }
        public ActionResult Create()
        {
            ViewBag.MaNhanVien = new SelectList(db.NhanViens, "MaNhanVien", "TenNhanVien"); 
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TenBaiViet,AnhBaiViet,NoiDung,ThoiGian,MaNhanVien")] BaiViet baiviet, HttpPostedFileBase imageFile)
        {
            if (ModelState.IsValid)
            {
                if (imageFile != null && imageFile.ContentLength > 0)
                {
                    baiviet.AnhBaiViet = Path.GetFileName(imageFile.FileName);
                    string imagePath = Path.Combine(Server.MapPath("~/Content/images/BaiViet/"), baiviet.AnhBaiViet);
                    imageFile.SaveAs(imagePath);
                }
                try
                {
                    db.SaveChanges();
                    return RedirectToAction("IndexAdmin");
                }
                catch (DbEntityValidationException ex)
                {
                    foreach (var validationErrors in ex.EntityValidationErrors)
                    {
                        foreach (var validationError in validationErrors.ValidationErrors)
                        {
                            ModelState.AddModelError(validationError.PropertyName, validationError.ErrorMessage);
                        }
                    }
                }
            }
            return View(baiviet);
        }

    }
}