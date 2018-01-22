package com.jk.service;

import com.jk.model.Member;
import com.jk.model.Tree;

import java.util.List;

public interface MemberService {
	
	String selectMember(Integer start, Integer pageSize);
	
	Member selectMemberById(Integer memberId);
	
	void updateMember(Member member);
	
	void addMember(Member member);
	
	void deleteMember(String ids);

	List<Tree> findTree(Integer i);
    
}
