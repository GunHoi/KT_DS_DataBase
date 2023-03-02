package com.ktdsuniversity.edu.goodgag.member.vo;

public class MemberVO {

	private String email;
	private String nickname;
	private String verifiedYn;
	private String password;
	private String joinDate;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getVerifiedYn() {
		return verifiedYn;
	}

	public void setVerifiedYn(String verifiedYn) {
		this.verifiedYn = verifiedYn;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
}
