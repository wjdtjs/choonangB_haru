package com.example.haruProject.common.utils;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.example.haruProject.dto.Member;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.Jwts.SIG;

@Component
public class JwtUtil {
		
private final SecretKey secretKey;
    
    @Value("${jwt.access-token-expiration}")
    private Long accessExpiration;

    @Value("${jwt.refresh-token-expiration}")
    private Long refreshExpiration;

    /**
     * 시크릿 키 생성
     * @param secret
     */
    public JwtUtil(@Value("${jwt.secret}") String secret) {
        this.secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8),
                SIG.HS256.key().build().getAlgorithm());
    }

    /**
     * access token 생성
     * @param member
     * @return
     */
    public String createAccessToken(Member member) {
        return Jwts.builder()
        		.claim("mno", member.getMemno())
                .claim("name", member.getMname())
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + accessExpiration))
                .signWith(secretKey)
                .compact();
    }

    /**
     * refresh token 생성
     * @param member
     * @return
     */
    public String createRefreshToken(Member member) {
        return Jwts.builder()
        		.claim("mno", member.getMemno())
                .claim("name", member.getMname())
                .expiration(new Date(System.currentTimeMillis() + refreshExpiration))
                .signWith(secretKey)
                .compact();
    }

    /**
     * token 검증
     * @param refreshToken
     * @return
     */
    public boolean isValidRefreshToken(String refreshToken) {
        try {
            getClaimsToken(refreshToken);
            return true;
        } catch (NullPointerException | JwtException e) {
            return false;
        }
    }

    /**
     * 토큰에 담긴 정보 조회
     * @param token
     * @return
     */
    private Claims getClaimsToken(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
