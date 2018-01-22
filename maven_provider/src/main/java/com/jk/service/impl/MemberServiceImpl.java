package com.jk.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jk.model.Tree;
import com.jk.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.jk.dao.MemberMapper;
import com.jk.model.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public String selectMember(Integer start, Integer pageSize) {
		long count = memberMapper.selectMemberCount();
		List<Member> list = memberMapper.selectMember(start,pageSize);
		Map<String, Object> map = new HashMap<>();
		map.put("total", count);
		map.put("rows", list);
		String jsonStr = JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
		return jsonStr;
	}

	@Override
	public Member selectMemberById(Integer memberId) {
		return memberMapper.selectByPrimaryKey(memberId);
	}

	@Override
	public void updateMember(Member member) {
		memberMapper.updateByPrimaryKeySelective(member);
	}

	@Override
	public void addMember(Member member) {
		memberMapper.insertSelective(member);
	}

	@Override
	public void deleteMember(String ids) {
		memberMapper.deleteMember(ids);
	}

	@Override
	public List<Tree> findTree(Integer i) {
		return memberMapper.findTree(i);
	}


}
