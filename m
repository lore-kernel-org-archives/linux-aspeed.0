Return-Path: <linux-aspeed+bounces-3885-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF88F45A12
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:25:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyFH0Rm3z2xSB;
	Sat, 11 Apr 2026 12:25:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775826316;
	cv=none; b=VyFLIhcYFbipmu6dzhr43IDqyzOC4QXG5pDckMupSyW0m03acHn26DIeE1jpgpNqOhc+O+WZd5tiz1/y+f+q4/tKTlVa/0zf2Gb3tKJ2y1a/pxugWgTURY0297Bx8/i4ZpsxB7LdLtVhP4GKTF1NcMeau9/ASaMx3jZ17l927J4bn1jsObs4JuC0q6yRiLiOJ97pYLgLDmJKNIAmz/pbPu3Dna5ryejLbCZzNzgr3RIx3K90vksjihEz4R7k6m7FJib3V7uMIbYvOKv/5XJ1+Csonk894gIA51lm725rFiElAN7GKZLabCZr5HejGHll1Vg55Azw0OpsB8Kti7AS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775826316; c=relaxed/relaxed;
	bh=Ct0X104iLElKowYrfBtaaKUBw6k//aKWwwbkwbYnMlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNcMedxJ+SVuInY7LEluz6BtvJ5zKRpl/qBij8RvJELDKrMQ+u7OaXqAsVg4+fIxlguzsqbsUDc6JtU1JEgggZoInqzZudfgKZRF8Iz48piBnWtlKkfoXAtKJaS5/WX8k8E0ZLxDuxTulypviQEvvbeeLcmDaBHDvxRUVL30zRR4OPTNflFcP69vdLXAdC1VNNaV0mya1cO82IfGu/jjvO5CkMCqU9pc0j8rB1RLdBGqGErSxMb5L6kpPZF5rko4+orCrxfQsUXIwLVHmE9jnHdLCEIFwnWP5oCF/OxSc9VVHI362gpt/Uox5EhO7L1stoU1+M84igvfemQHdbxNdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZzQizyou; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KY9STO1+; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZzQizyou;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KY9STO1+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fscV31Vthz2yjx
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 23:05:15 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A88p5R115320
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ct0X104iLElKowYrfBtaaKUBw6k//aKWwwbkwbYnMlU=; b=ZzQizyouKxOj7eUR
	TrKLsJVmCHGzlHU+ObSntif3x+mSaifPmnUzHf9gtI5VkJL8Ab1uQRzun8W2uU7o
	CzDEPHLBdxHjqtuCtBSJ1qxhJqPHk5aebf+u2gXh/cVjaGkJaB8rTJEYQ/+sXgcF
	xTdVWMlwJmSSWvm0PaGE2GuBHU2SeYv4QoZs0pZsCcReMGn9P93C/G9xsfBGVt6d
	3vw2PXX6Yss35zeWSSSVP3uJKEq46EDaexAaSnYtBbiUMEu9YssdFcIJRMwxQfXT
	4c1+GbEbBErMt6L1FSE+2vY1Oph8+2AE25sbdw8LhNSe9MVc/00cRZ8JSis3CW9x
	GD/9tw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xbx7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 13:05:13 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-68826165bc9so1649005eaf.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775826312; x=1776431112; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ct0X104iLElKowYrfBtaaKUBw6k//aKWwwbkwbYnMlU=;
        b=KY9STO1+waBxPeHMmEYQVxwWQgH7L+amJgxs9yLl5YNqSDoQ5HStX43wZPozHHeD8G
         gcQoh1qEdXpSIRJy8h66tknRUoly/WffNqPrQWRtOGGjJYBKVNs637DKV83YB5qf8vCX
         o9f6mvaTFoaWsg45lu7/Td4Yv6SkLKeSYYJSRvttWqKc4z7EcTWXLR3SPJH/v+UHia3P
         ZcjJUoo8TnZzFkg6BKHSMwD8homY4NP/zg5yjysZOZUcJkiUo3YR2/bVOF6b62Uol6QB
         22DeWSqi43uccClypwW1sw/3TuHfVBTxf7kVs+pm+aVFW7hayhUoDMPwvj0830iYr2K1
         R8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826312; x=1776431112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ct0X104iLElKowYrfBtaaKUBw6k//aKWwwbkwbYnMlU=;
        b=GcoFt8RoMnxh7QDjAWHUT/MIrdHEC6wh5kAzJws/Vv+in+1V58ZCru/LpAwLqJ/HcR
         TTNIg4RnkcCPv+NK7iDgSE8HOW4tyiIR6wgvJzF8i5eznK1pgQcVA8kNGxCkLAKpcCqX
         ibDRt9ZIWeik4aoSuhOzvh8r5jgiqPDWcoNTE7zjXSDqUmcftwTrxYoOJp1/DRLA3pkO
         Z+nQZcyVEjOn5I8cRy3PggcNGeG3XZwhcO9Tl20DP3QGk7xhMD0wvfvXeENAzWVZJq1S
         hzNt6hzic5EO7hfdLhAmDrPTEtwF/juYJ0kMu2OcrNhkW8rbPzZ8Y4DojvXowLwGw4OP
         lL9A==
X-Forwarded-Encrypted: i=1; AJvYcCWEQaVt2qBUFwzytgwwktlbLMG+S2QDwkSJN4louEfbTTlZmJKaLnhpMckTXIak9plKmVvz1VmamlnbeiQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLboru1B/c2rMe/VeSJARYF1DAR4JFt2M1FcE6/Y+wwDsDpkuj
	jSRY+QeZZBB6QE/sL92HUPMhAUIoxfmInJ4/AR3CWVS/geqESE3m+AbrGwWUkIehv1LL1s3Myi5
	KHI9Zk2QIfLFe8Un3Zf59HPzH+to9L7EsF3d8ZGk1pziLkRXyCGytkfoVyTRGi719avxo
X-Gm-Gg: AeBDieueUSsOXorhFyQ/PuE3mp3h1VqP4m6FEXEgtxF0MGen/tJwyq+E9qPoJOYb3ft
	twpbbRTy6PTRrX0sw1wEK3ugWDqU2v9TdXLjmoxCwepuiU0dBrMRn0iGDeZ6COnOulRQiSG/8DI
	A6HGVG0swcnMLm+SW9DXhCfJL15iNsxpr0ZtN9W9M+EFc9nFTlxg63Cqf970W2rAQ6yUR9++mLz
	9o2PTjJd/bCV5skTwJkxol1I/83HxiNVOQtuVfAeHsGsoIB+nskS7A+0R+UPdL+X2S03/YIxpGj
	cPeZLnHiN/HMZOA6Zc/6AafFFmjc5mNVi0Gp8l/p7xlODk2Wo+B2a7E910KuTIspPBivvkSKulC
	QJ7HxSH0p0b0msaQSKS68/YAF8kK6+wnJNE3N7Q5CJ+fo
X-Received: by 2002:a05:6820:f031:b0:687:6b:9bf0 with SMTP id 006d021491bc7-68be596a68fmr1446325eaf.2.1775826312175;
        Fri, 10 Apr 2026 06:05:12 -0700 (PDT)
X-Received: by 2002:a05:6820:f031:b0:687:6b:9bf0 with SMTP id 006d021491bc7-68be596a68fmr1446257eaf.2.1775826311405;
        Fri, 10 Apr 2026 06:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec07esm7694865f8f.13.2026.04.10.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:05:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 15:04:58 +0200
Subject: [PATCH 3/4] pinctrl: vt8500: Enable compile testing
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
Message-Id: <20260410-pinctrl-testing-v1-3-6f708c855867@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=v1WKkbTNzuGJnWXiDHEXgh523eXI61Yj4tEY2tsMGp8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp2PV7euszaR8Gmdeu5++cpU5XJM5Syz0Pg715P
 yY26qxUHTeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadj1ewAKCRDBN2bmhouD
 18LwD/9YC/NRlFpzIIOUW2EStYSQlD9cd/XeuabDzqY1gNQA8T17aTwNbQq0OH14Z1WMLxlw4Yp
 rsp6yQJuF9mktdynv+cNkpC25n89c4j67EtZPKLwaXxrc33sj5xJwvJyFG3WZvat+oBvT0cR8aN
 NAsQuKLXJq0+wwfHSscLf1an7safGGAV2YtpWFrmnQp01MYGhyLPa5xqieGQkl+sRlahFsHclvL
 fuxNm4+goyCx/WHPto5DeRzq0+qOjcnrHwKKlcc2yQm4BDzCBDv5S5IcwtpONq+RayvW6OH/mJ5
 qcKTv6yh2e5+uD4vjJERFPBeTfCb+pPaRvjaUo0LoiC3vhPOru14i4icXJPDkS0NukIQ/nn0UXl
 ljLdinOe92uAj+qPJlSTPJ7Dthgq04026rrtHNc7iOOKSI2UdBPOL9XR1v3F1KYXCe0pjHQQgXt
 BOyuyO27scgSZu0cr4UyIr5nCaBq7uyvbOtsP+n0Jxi/rq8YNL2+ExePu+aGxDPZmL9H73xgG9v
 tt/OnXPOR1KE371DPwvUXZbzlSNG99fkHTPnmtudI7Q0txM1x75FUkEXoPAdpmQZPcPwnBltiAj
 ONnypah+0Xgn8JpjmGCieqbU/2OyfXEDHs3/fEzwqZjpqxa9gh+Voz3oHvMDG0qjWpQD80BV4Nd
 4NWItbY3Vlp8e0g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEyMiBTYWx0ZWRfX0/4dsn3baChh
 i8is+J3pD2Ia8SItDI+jP7vD1hrw6LPeycdgcWkazQpBzuOq8wcnd3GDJ5IcnJsu1SQE0jtklgx
 IYGOiVjU8WePrdbmcqmILT8En+CWVwEwZ5IAlKMPkQ/GmhHJdU/LvMmucyEizxI9VxGHr6yalHY
 q/jwbs6Cj9MsXNeFzZU0pLXEabSF5QNe8k1ojsIhRRO8P3TZHf3hQ80JPnhMkPNARZT1yYCmhZq
 NTJladCh3hVhBW66e328SvsBnwMyUbrkssF6Q700Kgh9Gh5OQbdFy2bbd1Cxfo3Z6i5Q2J1nJUF
 7oaicToYl+8BLvWQPDQxTCv1KmJqHFp48CjMnrmlXpqqqwuVXiuQOfGlV0IKmuWVGlinbNybMu/
 K111vxjscZHX+h0tqGPmW92fwso3u3CR+v1WJ4TJx58RYuv2pmkGuDX4PEu2FfaXup1dAHcH2Nm
 kW6f43LzNLGTKygf68A==
X-Proofpoint-GUID: wwQNoYYkKDmEPBlApeHUqK5j7la7WLXv
X-Proofpoint-ORIG-GUID: wwQNoYYkKDmEPBlApeHUqK5j7la7WLXv
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8f589 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2GgY1jd2P1PdBW9LpxUA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100122

Enable compile testing for Realtek pin controller drivers for increased
build and static checkers coverage.  PINCTRL_WMT uses
gpiochip_get_data(), thus needs GPIOLIB.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/Makefile       |  2 +-
 drivers/pinctrl/vt8500/Kconfig | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 9320ffae5f31..78135ee963db 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -97,4 +97,4 @@ obj-y				+= tegra/
 obj-y				+= ti/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_PINCTRL_VISCONTI)	+= visconti/
-obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
+obj-$(CONFIG_PINCTRL_WMT)	+= vt8500/
diff --git a/drivers/pinctrl/vt8500/Kconfig b/drivers/pinctrl/vt8500/Kconfig
index 2ca00b54b7a8..1a40c153a82a 100644
--- a/drivers/pinctrl/vt8500/Kconfig
+++ b/drivers/pinctrl/vt8500/Kconfig
@@ -3,16 +3,17 @@
 # VIA/Wondermedia PINCTRL drivers
 #
 
-if ARCH_VT8500
+if ARCH_VT8500 || COMPILE_TEST
 
 config PINCTRL_WMT
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
+	select GPIOLIB
 
 config PINCTRL_VT8500
 	bool "VIA VT8500 pin controller driver"
-	depends on ARCH_WM8505
+	depends on ARCH_WM8505 || COMPILE_TEST
 	select PINCTRL_WMT
 	help
 	  Say yes here to support the gpio/pin control module on
@@ -20,7 +21,7 @@ config PINCTRL_VT8500
 
 config PINCTRL_WM8505
 	bool "Wondermedia WM8505 pin controller driver"
-	depends on ARCH_WM8505
+	depends on ARCH_WM8505 || COMPILE_TEST
 	select PINCTRL_WMT
 	help
 	  Say yes here to support the gpio/pin control module on
@@ -28,7 +29,7 @@ config PINCTRL_WM8505
 
 config PINCTRL_WM8650
 	bool "Wondermedia WM8650 pin controller driver"
-	depends on ARCH_WM8505
+	depends on ARCH_WM8505 || COMPILE_TEST
 	select PINCTRL_WMT
 	help
 	  Say yes here to support the gpio/pin control module on
@@ -36,7 +37,7 @@ config PINCTRL_WM8650
 
 config PINCTRL_WM8750
 	bool "Wondermedia WM8750 pin controller driver"
-	depends on ARCH_WM8750
+	depends on ARCH_WM8750 || COMPILE_TEST
 	select PINCTRL_WMT
 	help
 	  Say yes here to support the gpio/pin control module on
@@ -44,7 +45,7 @@ config PINCTRL_WM8750
 
 config PINCTRL_WM8850
 	bool "Wondermedia WM8850 pin controller driver"
-	depends on ARCH_WM8850
+	depends on ARCH_WM8850 || COMPILE_TEST
 	select PINCTRL_WMT
 	help
 	  Say yes here to support the gpio/pin control module on

-- 
2.51.0


