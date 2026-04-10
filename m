Return-Path: <linux-aspeed+bounces-3889-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74794F45A18
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyMy6TsMz2ynf;
	Sat, 11 Apr 2026 12:31:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775826314;
	cv=none; b=PYpSDC9Qy7/z+/nr22XMeUXgb7ZbPGD642s+Is/LlIqELZuInNol4u/9bV6EVBuvuNDT7VG8DcnSwnEf7pn/B3YuhCkaIuXDqoTXh1q8V8Zx29X8xRXeU4m74dt1lKVYfGsA+RyIfHN/3SYsiqbcbd6aQtg6XgOjtMbR1tOYSn7M+rOz3yiQpIwNkYLT01wfF+DfTgPkavCQ1NqSEC6dZnjJGWARECGwOdpMhrdL1XilVtfagmCgbqDUUb/u4yc1dj6EKtDfjl1TIMW+yvwlcvG/+5+53bs2fU2hnWSB8zMhmFeN+JhfqonF5NKgvNXhUB7HgLMGygdVkb8Tp+rBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775826314; c=relaxed/relaxed;
	bh=q7JfgNFgkKW4H7JoASIxg1ajm0fFfi1AnuywvMp+amY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhKeLqIESYy8yZz175ZBOHkomZq+iilJVNqnqMKu0lyyh5rEjBgIaKqN3Sar5MAzyXpLlr1jM+SlRPkgsINgJ4dGn4SmDQBgt+Q8ioq5N2Kj2dS3PjFxUA3H3Zy6xSvzTiUudYsXRnBAXtPPTIYoWVNWQeTdFzqwdj5RJQjmtMrg3BZ2FwZZeu5W1rTKTt8bhV275OD16WONeioPYd0dsKMdTY5o73ClAjsV4PZ+833qzheJYzu6+tR7lvQyPLA2KnnOt5FUDaGU2pGayousZ+TI0DylexL5WJj4D0xDAr9kkTp+F3YtAxRy3Uwk6HIs4epnRX1NMcdRwnwiuAHuAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HEntjq+1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QokhxzmR; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HEntjq+1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QokhxzmR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fscV13kvNz2yjx
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 23:05:12 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A8b33j115449
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7JfgNFgkKW4H7JoASIxg1ajm0fFfi1AnuywvMp+amY=; b=HEntjq+1sqbRiIcS
	uo2x/RVZFJ2YqfGBsnUEIWP67l3XfJhiqZGsdL7muNCTVJ6lM5A29m9a+PGEQMmP
	1rdh7eqYjK9gpCBkCgEseXoaTaZzU0NODe2JRYKoA3lc11wCEwGmgXl/ua5vROb1
	s0BhX5QbMGRNcSdHm+R9PkEZtymwU5GDiwPP1c3AXqouHhVvgZorcKK0mKUDClGc
	e5Abvk4u7CtA2j8tpSevsRpVSLZIzlfc56S9Rj4ppJhBmgYbokgvpiXSPU5iiOaB
	TBSe2PaDfsm1e2/kWmzhyH6WUTaYLb1poud3zEE3sfOxuJItuyMDkQ/Y1EKupPbh
	lGksOw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xbx75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:10 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbc48dd44eso2693492a34.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775826310; x=1776431110; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7JfgNFgkKW4H7JoASIxg1ajm0fFfi1AnuywvMp+amY=;
        b=QokhxzmRMlRVdoeBGHtd4DcXQMhJqXNh41IWZc0aglDRKnegsk45TWYAQ+A0UKyzWq
         judNwWuG0Q8T4aGqA+QBfoluznZBWQ6jPTqbeheh5S1hC4BC7ExVYcwKdBsN7Ge6k7JG
         5uwPEyfuQRr6TGzYP0R6b0mHhlCyvsYn8iNjMN/wfX0Soar7h19Nw4iYUUYh+2ptXd+V
         F83Yf2Usb36FnsvJu9qoQnlfHolbjVSiLF6i/82Ppw0Em0Xl/GIBuYT7h1O1mhk0QGs3
         vQytxlpqPQCtaUQ8vEgajmddd48kws94jSSl1QcNskG1L1Hcu8IiMuICyC6XvU2kPEwF
         +OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826310; x=1776431110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7JfgNFgkKW4H7JoASIxg1ajm0fFfi1AnuywvMp+amY=;
        b=ch8U20G956kDrwG5TgzDhcmMqRYY32ka7pPFEPfxVNDgUcR1uwYjkVQ7plhUWqlA7P
         gYywIvopf52Di8sKsnV8jYHPszz6Qvnv+XnOLG6oSkT3uSW9dWvVBWoZHFO+74x3kUai
         nLLc5KxEKCJc2xlpBQJ0mTLrpQycN+h7pA4S0tFnkIqQN+UCVeOOOu9M0UEdKEZW21tl
         vHMVCSpF/8C6asMifm5NEet3gV2lVEQjAsizK/snouUsNmwlhXlc5+Xr2Bmta37Rg5oP
         JtICA2IT7QQYbVf1786IzhLWcIavoTZJqhDdq8J2r6QTBQ179C/d0Xif/1CYcb+QzGCq
         KhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs+qn3+650OiHL05bEhTrLZq+YnuPyhY8dBNtRT62M46OpbwG9rCtq65OGPzG+4JzPIlpoDaq9sVAL/MA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0NGvkMcBjK+TQrYoRSyFyrNJB2h+EBCkQICQFrwA5Sd4NT/nG
	chy+5n/6d5q1srr2drBR50Egili62rMCRB+rzBzBweETsvg0Udf7BnrcbnJvR8FPajjJ0mUfKiO
	EIU9PPUTIcTpAdzkOz0iCSf2u9+gTk/fpRA/qOzT+1LbvVx26T3XK5JgtCdcWBz0G0mpo
X-Gm-Gg: AeBDietrUVsVzRQajRlJh1jicq2B1VEbqI9MGKVBmhGQQKvZwJ80hTA2E9+xWmtePjv
	VzwaIHItVh6acr6QphV9o6+Me3gsQPMjyN3+QtvDn2p+H1QJIXAuHDbXl8L/jIuUTefhAvDluaB
	nIyEiaV598raTlXJkfZ4ktSgph+RhR0YE0lEK326+CqwAzcsUuWq237AiRUFDNwW/4QONoXEc4v
	ze1RV3gxvL0JFzUkOS2Wi3dJEZfLw3VlDVmO698siUcd3G5HifsYGt7lt0DvEunfIps4C2WLSNb
	ABz7h2lMDjk1otYuwkeAhmwftp+pYVAJmbBmKQ2QCBJgErEmjDghDh8ahDlEaErdZL9N/T2ga3b
	CHOntlgHrQlGqnH+gtvIP9Sf+VsMT4/g/2WuZ89iyK4Ae
X-Received: by 2002:a05:6808:1405:b0:468:bfe3:17b1 with SMTP id 5614622812f47-4772c8a4eddmr3232821b6e.23.1775826309270;
        Fri, 10 Apr 2026 06:05:09 -0700 (PDT)
X-Received: by 2002:a05:6808:1405:b0:468:bfe3:17b1 with SMTP id 5614622812f47-4772c8a4eddmr3232786b6e.23.1775826308625;
        Fri, 10 Apr 2026 06:05:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec07esm7694865f8f.13.2026.04.10.06.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:05:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 15:04:57 +0200
Subject: [PATCH 2/4] pinctrl: aspeed: Enable compile testing outside of
 ARCH_ASPEED
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-pinctrl-testing-v1-2-6f708c855867@oss.qualcomm.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
In-Reply-To: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
        linux-realtek-soc@lists.infradead.org,
        James Tai <james.tai@realtek.com>,
        Yu-Chun Lin <eleanor.lin@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6r2aSZnVyktxNXguIsqv8rbhG8kjpenHo3yDdPaubfQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp2PV61KfuhzaqJkBRUg6EXADQNZG73hNSQCFms
 G4w2C0D/qmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadj1egAKCRDBN2bmhouD
 17b3D/9PWcOZ2o477Ut8BBdIYGaAxfj58fvHa+GCDp7OubNgeUWJVxzn99NDUAqMjjLSBqmhwuo
 d6ZiQgytlRcZH6OIyBhZB18jyPYHVGAt2ObEd4z8pb17YWwjQF0tBfGf2aHhXkAB1wrqnzVz8Aa
 2prJ+T6UCeKlDGqCSoWlSeKuZPI3vtWTsC5L/YmzAk83zY6jnIs/D2SKwnpKn/LhRiTOybAl/W5
 8PfuM9nIY2oAjBNGVik4v6zy1urWdB+3S0SYVNpBgGUXfL51BE1KSauL0Q6HPMq7Bmipk9azf/N
 SUBY82ia4Kv6SUsnSGhu+S93l+KsuQKefpkhPCIilL1THCLFvf7HmevNYLqnlQqL1OyjDhCvQOW
 Tv0FAuN4F8bT0D+71c0+4dKwZolTgqDlWpYGi7jiUSLKXl/Sb2mpc4vNnEoW2bBz37gyZkSGCdB
 0GK4+eOWsq71afa4qJejJdkQHZq58l7rnFA/UD4uPaHpXGbOUwjp26eDho2l+SiYEZMB5qbqjtc
 EHw3x/t5zEJLS56fKaUU4TxwRLNImBc4Dy8vmlQyWYXdO3z80dzAfob8h4n9s88dNON79/oITKL
 tCB0DUtIsLZq78Kb0UB6Rr8u/oGJJQTD+/ibJblif3FGMZF1+nqR6cFIuX4Lppc0Sc2799NZ4pQ
 Pt3C4Hf7rccooGA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyMiBTYWx0ZWRfX8+XWJ9OGJ5rT
 if5QV3CJ4ymZNcolzQ/9upuyKENu1x5FR4NRqB9l5dg3glWTFFj4/Z7UtQ0+y7MiP7TZMoXhKfC
 1Qad/ZDJLBoNqPm7K6ZiQSC6edMGdq6Pl5fF+8aWczZrsVzO/ADBiMB825cK09C6VLQ6sNa6BOV
 33iIR84ffAzEx2nqRMSfOXjt7dJmuepkBr4jTzyNkozGSiePUYO6AET5LSweVL5jOu+xUFJqVuI
 XZyezNm422cP3eXldYD2piyCu83qdvSYWFB2NIRJNW9KgbfyrL5BsnGrZfyiolLOm9sn7yR6zyh
 e5S01KWxtNyzkJnVqMrnw3gzfZ6CICjGAVd1V7xtRpglla5mIhg487fjl+xVnVaP8JNlDzrbFiU
 625evsBpQKT1TBgd0pu+wtRCWdHs/yyzHOmErAvo1cJK5GMJt4i6Rjox3ruZVjwFdVScNVraLzn
 3OkjBq5mZHjSOUSXPug==
X-Proofpoint-GUID: ke7g6Pkdn52V9ic5vBmqb7SNgMFcRY3A
X-Proofpoint-ORIG-GUID: ke7g6Pkdn52V9ic5vBmqb7SNgMFcRY3A
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8f586 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=7VIysbvwOnJS610hwA8A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100122

Since inception in commit 4d3d0e4272d8 ("pinctrl: Add core support for
Aspeed SoCs"), the Aspeed pin controller drivers cannot be compile
tested, unless ARCH_ASPEED is selected.  .  That partially defeats the
purpose of compile testing, since ARCH_ASPEED is pulled when building
platform kernels.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index b054cfb99348..9320ffae5f31 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -66,7 +66,7 @@ obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
 obj-y				+= actions/
-obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
+obj-$(CONFIG_PINCTRL_ASPEED)	+= aspeed/
 obj-y				+= bcm/
 obj-$(CONFIG_PINCTRL_BERLIN)	+= berlin/
 obj-y				+= cirrus/

-- 
2.51.0


