package com.jk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jk.model.Member;
import com.jk.model.Tree;
import com.jk.service.MemberService;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;



	@RequestMapping("selectMember")
	@ResponseBody
	public String selectMember(Integer start,Integer pageSize){
		String list = memberService.selectMember(start,pageSize);
		return list;
	}
	
	@RequestMapping("toMemberDialog")
	public String toMemberDialog(Model model,Integer ids){
		if(ids == null){
			Member member = memberService.selectMemberById(ids);
			model.addAttribute("member", member);
		}
		return "memberDialog";
	}
	
	@RequestMapping("submitMember")
	@ResponseBody
	public String submitMember(Member member){
		if(member.getMemberId() != null){
			memberService.updateMember(member);
		}else{
			memberService.addMember(member);
		}
		return "";
	}
	
	@RequestMapping("deleteMember")
	@ResponseBody
	public String deleteMember(String ids){
		memberService.deleteMember(ids);
		return "";
	}
	
	
	
	//----------------------------------Boot---------------------------------------
	@RequestMapping("selectMemberBoot")
	@ResponseBody
	public String selectMemberBoot(Integer start, Integer pageSize){
		String list = memberService.selectMember(start,pageSize);
		return list;
	}

	//----------------------------tree---------------------------------------------
	@RequestMapping("findTree")
	@ResponseBody
	public List<Tree> findTree(){
		List<Tree> list = memberService.findTree(0);
		List<Tree> parentTree = parentTree(list);
		return parentTree;
	}
	//二层循环
	public List<Tree> parentTree(List<Tree> list){
		List<Tree> childList = new ArrayList<Tree>();
		for (int i = 0; i < list.size(); i++) {
			Tree tree = list.get(i);
			List<Tree> findTree = memberService.findTree(tree.getId());
			//判断有没有子节点
			if(findTree.size() > 0){
				//当前子节点的集合
				List<Tree> childMenu = getChildMenu(findTree);
				//将子节点装进封装类list
				tree.setNodes(childMenu);
				childList.add(tree);
			}else{
				childList.add(tree);
			}
		}
		return childList;
	}

	//三层循环
	public List<Tree> getChildMenu(List<Tree> list){
		List<Tree> childList = new ArrayList<Tree>();
		for (int i = 0; i < list.size(); i++) {
			Tree tree = list.get(i);
			List<Tree> findTree = memberService.findTree(tree.getId());
			//判断有没有子节点
			if(findTree.size() > 0){
				//当前子节点的集合
				List<Tree> childMenu = getChildMenu(findTree);
				//将子节点装进封装类list
				tree.setNodes(childMenu);
				childList.add(tree);
			}else{
				childList.add(tree);
			}
		}
		return childList;
	}

}
