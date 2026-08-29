Return-Path: <linux-aspeed+bounces-4879-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B81DC61DE2
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:47:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY8165mnpz2y2f;
	Mon, 31 Aug 2026 09:47:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788032473;
	cv=none; b=FnRRxomMA+kPxdHSwmgN84tfiJcsC925pJMIsOdgKrMcnh0mFnW/QEtbVobSGkVSpqAJ4mj0E6qfJZ16Iys2QcdD5z71h/PP4npGSEoQnXByfIg11fypFObvYMnCheWKD+7XhH0a/V2aWp82qw4Q8KQQk8leXYevEruckipmCqbb+OKpVclPpQKTs8YTFxii6nbiry1rfCZOXTMePOE9TjcKMpoCBVq/yI0nvHbZDh6br5qMrA832g+sJzCqbKfPPAVMSKzhBLflCm2exNTq3aincpltgVt2OSrelrjAdqQZZfxYFgdBguDvTxVxlerqMVO+OdJHzmY10PL8P5NaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788032473; c=relaxed/relaxed;
	bh=Q3ovaYbtyWvTPy1NCdh4shU/gvReKJ7FezthyCu9rnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcdJMwH8eZkBgygIvJf5Wfy49fvlGIlPzPcKwwXsUNryHaUp9OH5hsD39kapRMG3YWVR8gB/j7krqZPPgERQ1oQODjomKtqQNhPp23NdlhYqv0y6dqP5lvGUdSzsnm93WMoZy12mAhwpRzppJiih76i4eJ9oylyZcmd11c73hct9k1uoIaCuP7ujAZH+4e8xLyd4tWCw1YK2SQ3qvJZ0YNu0xOG/Hpq/Wdi0+uSenLlxMyPa1B7jNt+ps1xwUUPjSwYSZbcaAJgeC8G+6ZOqWfP2JLm5ImMBjSePOAxBvOnI67GM8uhE69J7xH78WxI3R6IKWbV5LDYNIy7fEe2QzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d/f/+HHK; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYTc7VQC; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d/f/+HHK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYTc7VQC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXQbr0gmgz2xq0
	for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 05:41:10 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TH05CP2423826
	for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Aug 2026 19:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Q3ovaYbtyWvTPy1NCdh4shU/gvReKJ7Fezt
	hyCu9rnE=; b=d/f/+HHKdAQBAqMLf+Af5NPzyxKS9WgTtGkYRmH+Bl5y2xV4Cm6
	ypdS3X9LxySFt6jQIPdVKvUqJEhIilzGMEJSsHiWFgNoNYzs82B4lnMsDEXRIK42
	4++oQUB9orkOmUbeDj+NAZuKtXKXhLbgfACn8ulkdT/nFuogYNGgYqyOuP+PIHjp
	Nm9kUcrKgpIfVc0xI+WoEtxhbbKGlRu/UnF8gZY4qro5eMM6DZf3ql673l5Sjcs9
	YCluBaPGMX8LDc8/AcKT/jWq5vjH0NaCy8MXBzhEf1cUxxXAL7RUWJXNuyMJxTAc
	Rd79OWFqwIK+0vD6MyQZPo6jAGuAhTTzytw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqn2hmgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Aug 2026 19:41:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ff59f2c47so24837471cf.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Aug 2026 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788032466; x=1788637266; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3ovaYbtyWvTPy1NCdh4shU/gvReKJ7FezthyCu9rnE=;
        b=gYTc7VQC0y922vmccpfTWOu3dc7FZwmjMMh6GZXHSpzeb9UZd/wXvPpn9e/sTLFzk3
         IYDgi0gnc7oAQGdtY0JvYDHwaQYMFT3vOKHEu8SPJGsfNx2fnrANDYtvF/F0H7PKaAiK
         n9XSwFy0pxXq70TRWuROl75lXj8jtkkaPvHHOUG/PHaJ5HWDPmJO6y2iFZdXRtUv/WV/
         JEgDvorhY3ounukTk3r0E2QYsStn+Nmt+q3SivE5bK6NR1FPQiFRQPl/4IPgY4kdXphI
         swbddT6I4xilyU3eA9P2SZTiXkgK80jtXfjj4UPlJCZybqpjfoW7d48BL6hkiMSjRL9c
         gFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788032466; x=1788637266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3ovaYbtyWvTPy1NCdh4shU/gvReKJ7FezthyCu9rnE=;
        b=U7R31mrPYb7Aqq7mQyBpHrEcccRwGq5J5xyJDN4e8hvtSM/vOcZIf/7IbGnEgkb3/j
         APFNTSClaUajQ+SJMkaWoQXB5O7u90YyKX2uWNp/BTX1l/nfHNAHhuBp9KeOwCvgd8Pl
         BzPR/9/UUjQP2xwU9vz4tYvQZy69bIpAvFdA8lTSALadK0IZYBQiO0hJt1g9iNfAbT/v
         wEQ3WuRmRHMWiFSbCU28GXtUwdONr8zz2QXTuwzYsqJP7ZrKdb1ekTSx8LYjq75pp5x9
         8HPUzEZLSQhVSc9gsIo1BgtDkxlScIWTk/t3g5zENiXRtubHQVE2M7fe4gqlefW7RNZr
         jLTg==
X-Forwarded-Encrypted: i=1; AHgh+RrzXbZh77QgAaeYPtWhJupWyI0uz1jx+1thL57NLrXz7enoQjcyseZcVjfm6RlRshaLZ9bI+WBvsG8qrh4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l9vHX99R8P5O9nZUUccAUSuByX2Z9JGshGoveCJuW1T+fk4So+
	k7tFJt9uwDxREEt4S2zGgCexfEIoyehhq5hZrFEHbONeOOnQEs+RS7VLvTh411ByrwZbing1T9W
	5WWoKKohSC9fH4AeixVWWDn22EE4GE6XlLLV4NUUBZh1lsCXl26cG62RGNxUWQq1o3Bte
X-Gm-Gg: AR+sD13YPVaq4SBNgzJ4O/J+RniDT+TkXaSerJCQCWJE3QzJLeutUOO64FC4MAC/TND
	apnX31q/IEg16LZ+6msNjcCTI8mThSZ2eyh8QZ8/lsOEv+llV+O0k38LshgRPyZveBtA2/sT84q
	3r8miGrRD4MpeLpyF1Hpk3st2hUkE92DWpfVXaFZqlAtFwY7AhwO5XBdWCtwTYMbE26f7TGLo87
	fHnLwW+K/PulbjJngAc6qCpyTzAOvEgI6MS1mPtmX3YKzwMlLHVZ8LEJZ94uEbCjV8Qwx967ezf
	XVkqjEGNdJ3OA2vpwPU0lOSF3DQqFkK/qbr0riqN6+stbtV4YZsw1FPw4z58FSP+17zXNznvJya
	jVg9hHILDvFdWfGM=
X-Received: by 2002:ac8:6906:0:b0:50e:474a:47e1 with SMTP id d75a77b69052e-52fa1bb79c7mr304455481cf.10.1788032465982;
        Sat, 29 Aug 2026 12:41:05 -0700 (PDT)
X-Received: by 2002:ac8:6906:0:b0:50e:474a:47e1 with SMTP id d75a77b69052e-52fa1bb79c7mr304455121cf.10.1788032465612;
        Sat, 29 Aug 2026 12:41:05 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm243390275e9.15.2026.08.29.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 12:41:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ARM: dts: aspeed: Replace spaces indentation with tabs
Date: Sat, 29 Aug 2026 21:40:55 +0200
Message-ID: <20260829194054.107929-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=lCD2rnWylJ/gXC+S6T2sric6v3SvqHkmqg2cRrHiHMo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkzXGQUFLSmG7+ry21ITbphcniWDbQTny9DzW/
 uj6+C8Bx02JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapM1xgAKCRDBN2bmhouD
 11eKD/9r3+XtKocDcW+pxNJI51m+1e71/pIgJBXGflKkNxHvdYF5/H1EBW9204QVUbOlY8LHAeo
 12dvJa2Sj/Yggm6H3VzfBRbGYXsGV905x2qHmiuUeY7SxrM63MydbAmvSSzVm2z5jV46TTOR0hU
 Ed/GK0kBcFijqgjvbmaBBbij3jrqnaXMZYTvmB9IHi0CWTO8Ss4JfyJVSXnKsroc7EaUJJaQ3uV
 7D4WmDfsAhLi3ux484loF+I6pFnEdkSjQFO/NJIXT5X4vDFymZWDqyd6+zhxQSJor3r2fyp5PnC
 rxB79bTY4vn4so9xauyXexMs9vTkOCas8Nqfqlsfalk6Iibbv63MRGBaSUg/2MDHkd3KPtTaMeR
 yyqtmGj8TjVD2HQbQWKjdsipL91niG7Rdijqq7wdPDAGfczgERm6PqGBJKAqPBAYMY9MODHjwlN
 gOMakH04wqABfZsnu3lvwped9hwDwdfr+qwWPb8y1/oR+s5GGE28iohdQ3QryuQrGU6XV3J7uXR
 KVL4mNUZwyMJfQTPFYOIaFOmwVhL3YwDL1wfYEVTZNdZciWYgm8SUttXDiPBKxAsvAh9jYIHcqA
 aHNuGC9yJewTxdTALu9Rnvoinn57ZKyB++Eys+gK11mu6WjfN6dbZtCKqBqFl/6vDIh0ihWz+iE 29hKMHMetH3UXMg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qCX1fjtHcc46ytWJ1lYTgLQvS8YgrNiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDE3MCBTYWx0ZWRfX6dKI+4qmlEIy
 oJPYEHzqv5rMXFerRExCgMxjUFQl79QO/4E7T5h0NUeWjkPjj9pc9bKBnvTMX3YKJwBSw2GruNk
 NqSi231psaLWI5N5DXfSonks6R349RxFdsN4Csr6hZglF/Pa/cM/MZQurfh28dopbgFHb54jbci
 OpkW5/gBKYfnOg1bFR6DS5XfTtV+JFtMQuS/CqLjPBj2L6Lv6x9AXgOtv0o/Sh8JiXz0/BHp7pa
 aAILUkJKG8IFwCFN/UTc/Ot+d12subaSqJWu31Hqt6ivfHI1E1ZbwyEVPBzV4+e0OIE0+n5eEZa
 FD6NQ/p87zYF8IE5+n52la3b5te/UQ4R2+lkmN2eNGgxAqJpjDVLlrKYFII1mcdEqlSpxucP7Ag
 4eOdI8S91/B0A3SeIazLKs6/ytNvSVtX0kifsSwoYygMSetUEW4YmcPYoLg9XZcombx8IHl8UPd
 /ZYDzRKL30IDuGQXCsg==
X-Proofpoint-GUID: qCX1fjtHcc46ytWJ1lYTgLQvS8YgrNiZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDE3MCBTYWx0ZWRfXw2gwZ0CzJcrP
 ozU0EIwvQYFMJSJXxjHlnNGvqZAyXTB958mqswCZR85bt/IXoPzbwfga5hrx7QBSDFuH1V+c0r+
 th2afjsD9jV8B8ZfJtSlhnW8JZZjHVY=
X-Authority-Analysis: v=2.4 cv=a5kAM0SF c=1 sm=1 tr=0 ts=6a9335d2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ta6ShJ3tCWu1s0TIFCkA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290170

Replace excessive spaces for aligning indentation into tabs.  This will
be reported by dt-style-check ("[mixed-indent-chars] too many space
characters in indent (more than 7)").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts   | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index 89907b628b65..d235ebc3022a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -213,7 +213,7 @@ &gpio {
 	/*L0-L7*/	"","","","","","","","",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"presence-ps1","","led-rear-fault","led-rear-power",
-		        "led-rear-id","","","",
+			"led-rear-id","","","",
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","presence-ps0",
 	/*Q0-Q7*/	"","","","","","","","",
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
index b961dff388d1..154a2eaf8596 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
@@ -75,7 +75,7 @@ &mac0 {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_rmii1_default>;
     clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
-           <&syscon ASPEED_CLK_MAC1RCLK>;
+	     <&syscon ASPEED_CLK_MAC1RCLK>;
     clock-names = "MACCLK", "RCLK";
     use-ncsi;
 };
-- 
2.53.0


