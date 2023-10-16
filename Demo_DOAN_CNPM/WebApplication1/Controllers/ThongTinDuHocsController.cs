using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class ThongTinDuHocsController : Controller
    {
        // GET: ThongTinDuHocs
        private CNPM_DEAN_TESTEntities db = new CNPM_DEAN_TESTEntities();

        public ActionResult Index()
        {
            return View(db.ThongTinDuHocs.ToList());
        }
        public ActionResult IndexS(string searchString)
        {
            var thongTinDuHocs = from t in db.ThongTinDuHocs select t;

            if (!String.IsNullOrEmpty(searchString))
            {
                thongTinDuHocs = thongTinDuHocs.Where(t => t.TenThongTinDuHoc.Contains(searchString));
            }

            ViewBag.CurrentFilter = searchString;
            return View(thongTinDuHocs.ToList());
        }



        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ThongTinDuHoc ttdh = db.ThongTinDuHocs.Find(id);
            if (ttdh == null)
            {
                return HttpNotFound();
            }
            return View(ttdh);
        }
    }
}