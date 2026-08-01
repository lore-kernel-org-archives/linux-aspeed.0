Return-Path: <linux-aspeed+bounces-4598-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B1C55171
	for <linux-aspeed@archiver.kernel.org>; Sun,  2 Aug 2026 03:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCPpZ66wxz2xll;
	Sun, 02 Aug 2026 13:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785618292;
	cv=none; b=H2WhfCSMHzL0C3h30tkyLzs3C82xVNNBo87KRcwc426pvF1mUygiKnc/n0bFX6ttTGdm5CaHXGdWtHFRlm3aucQX60heM0CQbrwfuLmHOeKVX6UHTjnGNoC7bHK+psFLiwOZ0XvQfsbPoPY4sUWsqWBlq/lrU/pmO8TKqJPP7CDpmbogM7jgNw4DmFe1+nLsNPwbHqFTcp239TtdYHWmg/CAY5M4dw2KvYEWVrg0di3Mk+4Eqc9DRJzOBF/xb5SsH7JAObAk28Jv1vT4HmJBsLwR3xJK9rm9kw7dCMupUHJwhlGLYzYgPkVmdt0VlAYk1HCdXvqKagCFsmkzPiNCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785618292; c=relaxed/relaxed;
	bh=qh+fdpZVSvn8T4ZHxWuDVMee6L+wS7dVCUrMiFrt4ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAxgtEt7gsWDnyvSM4HWiq6zCi2KND35rQtKwK+XfepF/MtGqhqy3Ng6NQJ5MCqynqkHetQbjX4RTSPomPYfzhxSiIWsbjqDOXPzZUtcYZhWYAjzNAv7XOUEpGqJZjkNpkT3/M8B9JtxPgjYNKFCGFCau+Rxnva7yL0y7n7s9+bpYArE6XZw+zg+ZLRBhe7u8Z2iZnHAB8qsnQresEtxtTeCoan1GpkozBR6u8BDHe8CnkltKUK3tCFI8T2t6eI+CaxKung65Iyt88Bx5x75/+gBU4e+GsyM/0g/fElLwIee9tYgHYJsapjLwYxkzjOyrM1N4MwKwWBhYmPT04XAHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YW0CPB6f; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d25aLqEj; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YW0CPB6f;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d25aLqEj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCFnH2pCwz2xll
	for <linux-aspeed@lists.ozlabs.org>; Sun, 02 Aug 2026 07:04:49 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671IxVxa3846594
	for <linux-aspeed@lists.ozlabs.org>; Sat, 1 Aug 2026 21:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qh+fdpZVSvn8T4ZHxWuDVMee6L+wS7dVCUr
	MiFrt4ws=; b=YW0CPB6fwjjIyeVPXG9q92oh10n4Dqu/rXn7bqTF9Byi6WDGJrf
	u0B3Xwh+IS2u1Kfs+mrmyb/7AyBpxLe69yRYvnP20JKMOL1gze6tNtXyaOUh9S9N
	BNPeUST0y8Z4KqR8KHz1cpjv2bPea13hoBnVrFtEX8gOoxS+GTF5CZttPUZ0UYZI
	x9RSOR2NCOgR263mSV2+iD3HHfmV9U4tRXTR8e/u21d1zJ8UIheVdlFxTctwlcEp
	03FI4V5zh1jONdOqbwyX1rzqlhJJztm047Pmpvg9cGpkX3JHUD80f2RDxYb30PbI
	29CRrdBUQlaYiC5Zu6hBxvkzv/pgN9JNNyQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vt9rru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 01 Aug 2026 21:04:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso40719991cf.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 01 Aug 2026 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785618284; x=1786223084; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qh+fdpZVSvn8T4ZHxWuDVMee6L+wS7dVCUrMiFrt4ws=;
        b=d25aLqEj1aNBpXF3hEwcJzBMTEbUGy2/Vfhixgn9WlscOkZkWNfCoxrHuVAATEpw8/
         kqzn9FFVaV9gWeiNt0vPKOKhFcxAlhKYnyo1QMV3O7pByirDAYaPQZ4/y+sdpjoYWHin
         hHRszfKrIkZWMLEuKVgkpoU5bm9uxg1Q4UeYG7l8wyBbrltPlnEb2nftnYxvk8YAJ3pC
         RNYOq17MWgkiSJgIiHFGdua3GGBRDRweGkBF8/loyhSqedA9u5gFspMZh1kTyvlsjkwt
         evoAHJ2whW1RXIXkexP+04+cV6+Gx+AcXnK4RAwM6G+Dz0Io0DrJ6QDY1c2dWn8+9qht
         rE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785618284; x=1786223084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qh+fdpZVSvn8T4ZHxWuDVMee6L+wS7dVCUrMiFrt4ws=;
        b=gajw40iqTLQkV0Tggq9nb/LdCwuvlkh8E6D1eTxU++wz14CrROHrHXvagOua+CAOYO
         +vySdpJTm+4cjdBKOGPOqyCeonPlde452d60CU6tc9JYOAk/0VoOe16fideyS3zFfyNi
         Ii4jK8Z2K6JEmpQhr+7s3XmDPuvSBnGHp9I/fTRigMwuAs7OjS5y3PBqBPygNwn55dfZ
         putH1ccA8abpxrN0uJG2D9Dwh7WdR3iXvwcKYVG4116VZTGtkA3DE4PWt+uFT3jzuApK
         gChSXcmveNgwxKCe1no5jLU15OwaNpE2hHJJJh+tS2unq9PjoIrroCTPRpcipBUyAdHa
         4Jzg==
X-Forwarded-Encrypted: i=1; AHgh+RpyUKh9s6Q+mJmi45+pG+PuZ2u5U8rDf3+1O/H0xul7HN21d4bbJkjsb3RdFzu0lXbe/Xjx8XQ4F78GZrc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOZQ29elW8zrUILQEDyNn8dK2abyBtmNJKN+VhQ0KUE7/EDVRP
	3Hp9L6DpV2j6YeuFtH4RFhO6nWqTXJ/lRAL/AcxmaF+S9M3H60FuEBZY6stmUG+Nh5CY6z8HrAR
	ZqWVYe0Msl+OC5N8yDr1lKWR/XJSlUpdx7hI/M7DIg50mhUu4mhbkl48jsT4cEgztCY7A
X-Gm-Gg: AR+sD112wnw1qHgTBta3xJ8bdiYFfVF+9n4hWrF1XyDXYpu/mE12wRfkTbhbYx9wh3P
	tYxVjChO2c2Ic/qEHWU0OEIbbp5lub6YWg7MJmc7COO5lRkU9hD7hpmJJ3gfRfJoJp3xpIUeBfN
	5xLpT1g85rHit1/uwrN2vclrV5q0O0qNFiAAa8LuHfbUu36v0Gd9sY+slQfChQqMWwhwEWl0p/h
	n24bnLxo9ZZFECs1/g4ZnUZaMN2pYfLq1a4pfGEF6DYUApYOEJt6hx7t+pvZK8rwOfyhVdU2isv
	+2Tsg5TeuImcjA2DsdJR/9CloL5g+V78t9NhU0S7TDAX5KI+1s9cckyFDaMJugK7vqPx/IamaHi
	TDhs8xWpojl2sukBr
X-Received: by 2002:ac8:5ccb:0:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52b567d8750mr102080891cf.38.1785618284150;
        Sat, 01 Aug 2026 14:04:44 -0700 (PDT)
X-Received: by 2002:ac8:5ccb:0:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52b567d8750mr102080541cf.38.1785618283742;
        Sat, 01 Aug 2026 14:04:43 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfdc6sm17960617f8f.8.2026.08.01.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 14:04:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ARM: dts: aspeed: Correct white-space style
Date: Sat,  1 Aug 2026 23:04:38 +0200
Message-ID: <20260801210437.384040-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=mzQoX3FaTVFufhdy5cjSSr30a02VvRKHJ+kVUAXYnxg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqbl9leq0oNwbGaHDgxoiOOAFcXnt+3JsmUGAOM
 64VTNptbj+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCam5fZQAKCRDBN2bmhouD
 11i0D/9XPDNBCCi0S833xlthpzVxAEri51loOV7T1kVDc+cTDtb8PClIiZl/YdxwV94qwer6kq2
 Km0PMXpAv7QY6kgmhKacv39J5pbwHvBMeBVM4/k9Ksx4GVVvFsxbLlCCy/svG9lYo1SsVPPkk2K
 qcnV6A0Y3SLQj4n5sJo1t5s/vsSolJQGzyc6uA7q1TczUnDyyGxDzdXo48LuyoFIlySMlN4V8zO
 AI0ITPp92zqtgo/EtdsYiWi+yYbZ7zA2i1d8ONbcdCQ9O9EKWOr2+p2Ya4ZOiJExk/KSPqoPRj0
 oOAolMZfh5KCZoJ7HEBvIu+1LbvdSafCazkPGvzcWVY8hgdI3pI4dYQNe1i6j/yVIUmRhZCqnP/
 Gzz6bI9jCA1KJcLxb+7yuTyV1ObyOjGOehLztRM5T4dll0PawwBhxAzAnzcjHEbHoVJbDJnF3h6
 behKKc/eNMBmKIFDHVrUHA8ar9atp+qstsuza/ttVwyCNzFygyq7QU1Od3oqN3u628NGOpZfnuz
 NkAKul8eI1sjWmM0NBBND8mk9nEEhNEr2NiJtXp4ltwSYCrMkDhRXeBZ6fvVzJMx0w+ISbAjFvM
 t3Jg5xi56EhNCE3X6t3IYetuG89+Zixfd9RDga9cUMD3ZdoduG5bo7KcFTSBZTm7+IEXWsTw/PW ARdGF4yuKDV9fow==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2OSBTYWx0ZWRfXwzVgcuem2hFo
 HqdwMs8eul9TZ99uu6/t5WQ6GgQ0CUrSkNTj/dTgArnEn32PvzV3hSvp9ATlgNWuRILZP95JVc9
 L0nJwaYPp6MlaaAJKNewQ4wD2deeBho=
X-Proofpoint-ORIG-GUID: yDxERJ0KXte3aZOi38XUD_EaoT30ZG44
X-Proofpoint-GUID: yDxERJ0KXte3aZOi38XUD_EaoT30ZG44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2OSBTYWx0ZWRfX2diUs7tY/mBd
 kQH9r2+uTDBswzAE4vleqdgu67a6cXvGzot6hBW44hh/osdQqCly3JsvoSaYlbfYGWJsg19gJQp
 ZXkltdTUi7G0TfBVp3stBO+bwYgWy7v2TovR7YT90JV6Y9BT77J1iUQufcRrzvIi25AKAgqR2kT
 OARmKlYKxfExQ5fZeLgNN/lxUfN0b5lqrMkkOC261yJTxLJT+n4ZKtzEatMawLup3pvmQ77KVe9
 MR40pOCFlvCdiXvobEBfMdI/VoaLJx5Ejfgl4c450rfwmeyBi4D5WhOfYZsr1zWlLFha0GXMLsx
 8Xa2ByaVONy9bnNKW7z9S/bYFSiov1UEBzisYefcdHBKMi5hMs9d82H4a/CHv0Fw0DsX8GGlkK7
 bjf2fesqOp19VoMXDkWeKDUsHuiRQLbeFPA3Hm7PR7zo/HQRzHtYknQinVdhJGftFfmoOA8057g
 ix3fi4269zq1tETc8WA==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6e5f6c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Sc2Gg_jFPfLOXhiJGNQA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010169

Correct a few white-space issues, like missing space before bracket '{'
character or spurious space, which will be flagged by dt-check-style
("redundant-whitespace" warning).  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts         | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 8 ++++----
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts | 2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
index 64f4ed07c7d2..fe48397c2a6e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
@@ -244,7 +244,7 @@ pca9555_5_24: gpio@24 {
 		#gpio-cells = <2>;
 	};
 
-	i2c-mux@70  {
+	i2c-mux@70 {
 		compatible = "nxp,pca9546";
 		status = "okay";
 		reg = <0x70 >;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 820d39a92974..1898093b1550 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -673,25 +673,25 @@ power-monitor@14 {
 	};
 
 	// Module 0
-	fanctl0: fan-controller@20{
+	fanctl0: fan-controller@20 {
 		compatible = "maxim,max31790";
 		reg = <0x20>;
 	};
 
 	// Module 0
-	fanctl1: fan-controller@23{
+	fanctl1: fan-controller@23 {
 		compatible = "maxim,max31790";
 		reg = <0x23>;
 	};
 
 	// Module 1
-	fanctl2: fan-controller@2c{
+	fanctl2: fan-controller@2c {
 		compatible = "maxim,max31790";
 		reg = <0x2c>;
 	};
 
 	// Module 1
-	fanctl3: fan-controller@2f{
+	fanctl3: fan-controller@2f {
 		compatible = "maxim,max31790";
 		reg = <0x2f>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
index b29e08cea254..041809c161a2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
@@ -513,7 +513,7 @@ psu@5c {
 		reg = <0x5c>;
 	};
 
-	fan-controller@5e{
+	fan-controller@5e {
 		compatible = "maxim,max31790";
 		reg = <0x5e>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 6287f80d70d9..383955cc2702 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -484,7 +484,7 @@ psu@5c {
 		reg = <0x5c>;
 	};
 
-	fan-controller@5e{
+	fan-controller@5e {
 		compatible = "maxim,max31790";
 		reg = <0x5e>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
index 5143f85fbd70..61735d828d07 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
@@ -24,7 +24,7 @@ iio-hwmon {
 		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
 		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
 		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
-		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
+		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15>;
 	};
 };
 
-- 
2.53.0


