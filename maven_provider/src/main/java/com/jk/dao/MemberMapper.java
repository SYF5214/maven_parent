package com.jk.dao;

import java.util.List;

import com.jk.model.Tree;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.jk.model.Member;

public interface MemberMapper {
    int deleteByPrimaryKey(Integer memberId);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(Integer memberId);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);

    @Select("select member_id as memberId,"
    		+ "member_name as memberName,"
    		+ "member_sex as memberSex,"
    		+ "member_age as memberAge,"
    		+ "member_birthday as memberBirthday,"
    		+ "member_phone as memberPhone,"
    		+ "member_level as memberLevel "
    		+ "from t_member limit #{start},#{endPos}")
	List<Member> selectMember(@Param("start") Integer start, @Param("endPos") Integer pageSize);

    @Select("select count(1) from t_member")
	long selectMemberCount();

    @Delete("delete from t_member where member_id in (${ids})")
	void deleteMember(@Param("ids") String ids);

	@Select("select * from hospital_tree where pid = #{i}")
	List<Tree> findTree(int i);
}
