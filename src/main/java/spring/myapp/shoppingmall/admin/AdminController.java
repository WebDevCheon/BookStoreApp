package spring.myapp.shoppingmall.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import spring.myapp.shoppingmall.dto.Goods;
import spring.myapp.shoppingmall.dto.Refund;
import spring.myapp.shoppingmall.paging.Paging;
import spring.myapp.shoppingmall.service.AdminService;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private AdminService adminService;

	@Autowired
	private Paging paging;

	@RequestMapping(value = "/registerGoods", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String registerGoods(HttpServletRequest request, @Valid Goods goods, BindingResult result, Model model) {
		String originalStr = goods.getTcontent();
		String[] charSet = { "utf-8", "euc-kr", "ksc5601", "iso-8859-1", "x-windows-949" };
		if (result.hasErrors()) {
			for (int i = 0; i < charSet.length; i++) {
				for (int j = 0; j < charSet.length; j++) {
					try {
						logger.info("[" + charSet[i] + "," + charSet[j] + "] = "
								+ new String(originalStr.getBytes(charSet[i]), charSet[j]));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			try {
				goods.setName(new String(goods.getName().getBytes("iso-8859-1"), "utf-8"));
				goods.setWriter(new String(goods.getWriter().getBytes("iso-8859-1"), "utf-8"));
				goods.setGoodscontent(new String(goods.getGoodscontent().getBytes("iso-8859-1"), "utf-8"));
				goods.setGoodsprofile(new String(goods.getGoodsprofile().getBytes("iso-8859-1"), "utf-8"));
				goods.setReview(new String(goods.getReview().getBytes("iso-8859-1"), "utf-8"));
				goods.setCover(new String(goods.getCover().getBytes("iso-8859-1"), "utf-8"));
				goods.setTcontent((new String(goods.getTcontent().getBytes("iso-8859-1"), "utf-8")));
				goods.setSummary(new String(goods.getSummary().getBytes("iso-8859-1"), "utf-8"));
				goods.setTrastlationer(new String(goods.getTrastlationer().getBytes("iso-8859-1"), "utf-8"));
				goods.setWriterintroduction(
						(new String(goods.getWriterintroduction().getBytes("iso-8859-1"), "utf-8")));
				goods.setWcompany((new String(goods.getWcompany().getBytes("iso-8859-1"), "utf-8")));
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<ObjectError> errors = result.getAllErrors();
			for (ObjectError error : errors)
				logger.info("���� ���� -> {}", error);
			model.addAttribute("bigclass", goods.getBigclass());
			return "/admin/adminregister";
		}

		try {
			goods.setName(new String(goods.getName().getBytes("iso-8859-1"), "utf-8"));
			goods.setWriter((new String(goods.getWriter().getBytes("iso-8859-1"), "utf-8")));
			goods.setGoodscontent((new String(goods.getGoodscontent().getBytes("iso-8859-1"), "utf-8")));
			goods.setGoodsprofile((new String(goods.getGoodsprofile().getBytes("iso-8859-1"), "utf-8")));
			goods.setReview((new String(goods.getReview().getBytes("iso-8859-1"), "utf-8")));
			goods.setCover((new String(goods.getCover().getBytes("iso-8859-1"), "utf-8")));
			goods.setSummary((new String(goods.getSummary().getBytes("iso-8859-1"), "utf-8")));
			goods.setTcontent((new String(goods.getTcontent().getBytes("iso-8859-1"), "utf-8")));
			goods.setTrastlationer((new String(goods.getTrastlationer().getBytes("iso-8859-1"), "utf-8")));
			goods.setWriterintroduction(((new String(goods.getWriterintroduction().getBytes("iso-8859-1"), "utf-8"))));
			goods.setWcompany(((new String(goods.getWcompany().getBytes("iso-8859-1"), "utf-8"))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		adminService.register(goods);
		return "redirect:/admin/registerForm";
	}

	@RequestMapping("/monthbookselect")
	public String monthbookselect(HttpServletRequest request, Model model) {
		pagingModelAdmin(model, request);
		return "/admin/monthbookselect";
	}

	@RequestMapping("/downmonthbooklist")
	@ResponseBody
	public void downmonthbooklist() {
		adminService.downMonthBookList();
	}

	@RequestMapping(value = "/findbook", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject findbook(@RequestParam String name) {
		Goods goods = adminService.findBook(name);
		JSONObject json = new JSONObject();
		json.put("id", goods.getId());
		json.put("name", goods.getName());
		json.put("price", goods.getPrice());
		json.put("qty", goods.getRemain());
		json.put("purchase", goods.getPurchase());
		json.put("goodsprofile", goods.getGoodsprofile());
		return json;
	}

	@RequestMapping(value = "/settodaybookselect", method = RequestMethod.POST)
	@ResponseBody
	public void settodaybookselect(@RequestParam String id) {
		int bookid = Integer.valueOf(id);
		adminService.setTodayBookSelect(bookid);
	}

	private Model pagingModelAdmin(Model model, HttpServletRequest request) { 	// �̴��� �α⼭�� ��� ������(������ ������)���� �����ڰ� ���ŷ��� ������ å��
																				// �� �� �ֵ��� ���ִ� ����¡ ó��
		int curPageNum = 0;
		curPageNum = pagingRefactoringForAdmin(curPageNum, request, model);
		logger.info("curPageNum Model Admin : " + curPageNum);
		List<Goods> monthbooklist = adminService.getMonthBookList(curPageNum);
		logger.info("monthbooklist : " + monthbooklist);
		model.addAttribute("list", monthbooklist);
		return model;
	}

	private int pagingRefactoringForAdmin(int curPageNum, HttpServletRequest request, Model model) {
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // ó�� �������� ���� ���(����¡ ó���� �������� ������ �ʾ��� ���)
		paging.pagingforAdmin(curPageNum, model);
		return curPageNum;
	}

	@RequestMapping("/setmonthbooklist")
	@ResponseBody
	public void setmonthbooklist(@RequestBody HashMap<String, Object> map) {
		List<String> selectedbooklist = (ArrayList<String>) map.get("selectedbooklist");
		adminService.setMonthBookList(selectedbooklist);
	}

	@RequestMapping("/todaybookselect")
	public String todaybookselect() {
		return "/admin/todaybookselect";
	}

	@RequestMapping("/registerForm") // �����ڰ� å�� ����ϴ� ������ ��з��� Ŭ���� �ٸ� ��з��� �̵�
	public String registerForm(@RequestParam(value = "bigclass", required = false) String bigclass, Model model) {
		Goods goods = new Goods();
		model.addAttribute("goods", goods);

		if (bigclass == null || bigclass.equals("novel")) {
			model.addAttribute("bigclass", "novel");
		} else if (bigclass.equals("economy")) {
			model.addAttribute("bigclass", "economy");
		} else if (bigclass.equals("humanity")) {
			model.addAttribute("bigclass", "humanity");
		} else if (bigclass.equals("religion")) {
			model.addAttribute("bigclass", "religion");
		} else if (bigclass.equals("science")) {
			model.addAttribute("bigclass", "science");
		} else if (bigclass.equals("politics")) {
			model.addAttribute("bigclass", "politics");
		} else if (bigclass.equals("children")) {
			model.addAttribute("bigclass", "children");
		} else if (bigclass.equals("computer")) {
			model.addAttribute("bigclass", "computer");
		} else if (bigclass.equals("cook")) {
			model.addAttribute("bigclass", "cook");
		} else if (bigclass.equals("textbook")) {
			model.addAttribute("bigclass", "textbook");
		} else if (bigclass.equals("foreign")) {
			model.addAttribute("bigclass", "foreign");
		} else if (bigclass.equals("cartoon")) {
			model.addAttribute("bigclass", "cartoon");
		} else if (bigclass.equals("magazine")) {
			model.addAttribute("bigclass", "magazine");
		}

		return "/admin/adminregister";
	}

	@RequestMapping("/adminrefund") // �����ڰ� ���� ȯ�� ��û�� ���ִ� �������� �̵�
	public String adminrefund(HttpServletRequest request, Model model) {
		pagingModelRefund(model, request);
		return "/admin/adminrefund";
	}

	@RequestMapping(value = "/findrefund", method = RequestMethod.POST) // ���� ȯ�� ��û�� DB���� ��ȸ
	@ResponseBody
	public JSONObject findrefund(@RequestBody HashMap<String, Object> map) {
		Refund refund = adminService.getRefund((String) map.get("orderid")); // ���� ȯ�� �����͸� ������
		if (refund != null) {
			Integer amount = refund.getAmount();
			String refundholder = refund.getRefundholder();
			String refundbank = refund.getRefundbank();
			String refundaccount = refund.getRefundaccount();
			JSONObject json = new JSONObject();
			json.put("amount", amount);
			json.put("holder", refundholder);
			json.put("bank", refundbank);
			json.put("account", refundaccount);
			return json;
		} else {
			return new JSONObject();
		}
	}

	private Model pagingModelRefund(Model model, HttpServletRequest request) { // ���� ������ ����¡ ó��
		int curPageNum = 0; // ���� ����ڰ� ���� ������
		curPageNum = pagingrefactoringforRefund(curPageNum, request, model);
		List<Refund> requestlist = paging.refundlist(curPageNum);
		model.addAttribute("list", requestlist);
		return model;
	}

	private int pagingrefactoringforRefund(int curPageNum, HttpServletRequest request, Model model) {
		String page = request.getParameter("page");
		if (page != null)
			curPageNum = Integer.valueOf(page);
		else
			curPageNum = 1; // ó�� �������� ���� ���(����¡ ó���� �������� ������ �ʾ��� ���)
		paging.pagingforRefund(curPageNum, model);
		return curPageNum;
	}
}