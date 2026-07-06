Return-Path: <linux-aspeed+bounces-4399-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0023C43458
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 11:59:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv2w10MbZz2yVZ;
	Mon, 06 Jul 2026 21:59:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783333180;
	cv=none; b=IbncRBhsuNc69tpZ4Qy9DtIMR6wVZb6HO+vOfhK/H8+eX1oSqWPqlA6ptxOdpa4apB2bMbzJnzDeys1Y5HjTRkBrEN84XbyXI9UVWsacvqIWJT9omsjA8/I6KXzmPGaMlpkFJRNhvklRw/BSpYWGCJw0pYcxnWqY1+WnPlTPJ/xmJMQiArEQuSdMWnppmXthC50PTPjhe4PbItYU6yGk66H/bhAcngypUmA8WwhhdpXS0Id/9zr3c+Tf5JBxNDxNegv2ea5gcQiK0HAscIypsCBbG+YZE5O6Jiy4XS0Y6HL3eXcttsTCq+dl+ICxaUk/t4D8ciyWjaLp37CdtmpZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783333180; c=relaxed/relaxed;
	bh=WnYM2Khp6OMHAwZzqvl0rBtn/mMDowuM3l5URj9PLxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBuu/UqZixU2ZtpIRpsfxAGYq1wsu7ar+ixVUNdHIvqfgr7pAxqw/G9uy2hqIBf4HI5HsG2rDfu7wer/qonW2F5EBh2upmUmcU3p7zs7PkrdazVX5qwu+R4T/3DNzGCrFyQ9pBQhYo+2TEdpwR5quRITbbLlULqE+4QI0EbbFUa7UVBZbyEsvs1TUJBG5vRJCrXWWzFPdwbWKorjOU1dETwUDcZ7ZCf9aiVvU9xnB869z3qk7BpY3O+MGUfJmd4EFKcfz3S/FccA4EECwlJlhb5bHVGu4zu416gZr+v9jEEGk+PcN/2YemAqw2ovr653gs7gvlIUfaC6bSW5wwIk9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9Rzf1dz; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IoMvLFex; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9Rzf1dz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IoMvLFex;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv0hq0wylz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 20:19:38 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669p5Ve250548
	for <linux-aspeed@lists.ozlabs.org>; Mon, 6 Jul 2026 10:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WnYM2Khp6OMHAwZzqvl0rBtn/mMDowuM3l5
	URj9PLxk=; b=h9Rzf1dzATzkzVID+03XZlRJH/6EdzozbSf+FVhvyQ8mVxE9GKp
	R3RIrYl/g91EcSOZ06PUCNTGlfasdki4QNh6vjgcQKUY3mBsl9xMbuUG/+nYZmrw
	etEHIwEOQoL+x1pYAGZZPjmva1Dos8j8cHWwp/bj3giYqoI/RwBNJE5QXQXxUVa2
	OEOOCmmItOWuqGD3ZytWHua4xje9IuxAHMUS/RUSn0ppuc7pAL0M+P6aYgDKLOMl
	i9rjBCFM1an6ZP9t7HVPjlEwpeJbOF1RReL4HVwXyk1Vq+ik1Cq4dwUVedsSHk9J
	gzfgTDrXpaomzYW2sZKFaLF6CyaYwgPxQYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gr3k5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 10:19:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92da6f3cc81so352390585a.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783333176; x=1783937976; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WnYM2Khp6OMHAwZzqvl0rBtn/mMDowuM3l5URj9PLxk=;
        b=IoMvLFex0br3AbllADTh/QndM5G3U0t+rjjDnYXsJu39crEWZJoC2Dsf9DiD+LZ4QY
         D6EC5kgxPEu9ZlHKTecpPs6tNtFZiSz6ZA/GZ5/bmAgnVIdQMOla+HYSbHDWRUgoju8m
         h51tBadTd1wMl4lr4f/Y7niGR1wqkuvt3CsgY+P2obW0B4+M/A+U0Zukzs0bAyCvAzQW
         6j/PETwShYAZoiLBTKneb3SDiRJv2u4fBzWsdafcP95HczeI/iJ5UZ175nN0wL5TTygx
         d6WltDu6IrPuzPViKAu1P6gdzZmnu8gn4IYmdQNpgQTULePFxtXZ2k+Dq1VUZ1TCoN1r
         m8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333176; x=1783937976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnYM2Khp6OMHAwZzqvl0rBtn/mMDowuM3l5URj9PLxk=;
        b=dynQ9oDZMnJtxYc1kjrvyK1Or5ME+51ZO+xX4nS7rvSQSGRrK8K7LwDl9VSD0hPiEW
         m+R2rg4OFu55vTyB3BdPsV04zVWXOV829tp8EOyOpIC8E9Lf8420fwPdcvcS19l5wP3H
         PrtUZYLlBZZcmzzvXhr2PuMx3bCnXps5YTFfmS40JV03+F4uDJu0EX7tQ26JnpJGE9on
         PkucTqsM6Shhd+YicG1RczP4ClhvJrSaIjL1fXH6feYymsWUDCrbuplM/Qt3fraYM2Xj
         cWJpHt6I9bLJwzrP3rSOtEcJYdnZEU+hPiWHRLh9l8fv+5hPNzLfnGC9vvnNK72hzNlG
         czhg==
X-Forwarded-Encrypted: i=1; AHgh+RpcooAP4b2sMGki/Mtt+vvC9sKxZAO96a4vXKe+RRJ529CLfYMLu/ca9yIfAcmJQDXBii2bnOL2Ze/Cvtk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPtICi3IBMmnpJsButsMBg0tK6w4XKAZeThvTet6nFG2RDE+Hm
	CeOBEnmLEhLzM35cLXodMOgkkPEOgmlMizP9X4YX5/zPYiuxb9t3CovGtDmBTLuwDdiTfSsf09n
	+w7n04Y1OCcXRIUPjWZshetLdfkpZDkhxUXNIzT9DhIlfhoEFJkXxnL270TPW4a2HA2CR
X-Gm-Gg: AfdE7clGnLuGCjHDw+Z8GokI6/UGMUrXKQyysu7e5AYHPqgOcc+A0QkuXc/iO1GtCwl
	65G13iNGi0J9xy9OKcZ7eoUrhPm1NW7A103gen5+QEBz3bdgA0pE/U31Ntisi+Wed1GKGRC5mpd
	3Us+uy1x3e29/bPkT7nZpVA7NDS2u9TXqZx8W8fMF9VU/e14NY5odqALQbHDekXiSJnz+9JZHuH
	QZDr03wNM6wv5bJo9ipIFFu/2sQEeeXGLz07hv5wISrLd166xScNW40SLvxvCoEnbFp1fvZy8Va
	wTkFxSGjm+Yea+ed91lF66ECcHcOMhPxoNMjGd9eg/jkif8LMbqs5+HvWGetAUjshovHfPMFYIm
	fIONQBKZR5EorQae6sU07ucdDEH0=
X-Received: by 2002:a05:620a:800c:b0:914:bb06:288 with SMTP id af79cd13be357-92e9a3af0f6mr1369659485a.22.1783333175507;
        Mon, 06 Jul 2026 03:19:35 -0700 (PDT)
X-Received: by 2002:a05:620a:800c:b0:914:bb06:288 with SMTP id af79cd13be357-92e9a3af0f6mr1369655785a.22.1783333175072;
        Mon, 06 Jul 2026 03:19:35 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm24235818f8f.5.2026.07.06.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:19:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ARM: dts: aspeed: Correct indentation
Date: Mon,  6 Jul 2026 12:19:31 +0200
Message-ID: <20260706101930.341635-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10398; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=wd87wCk7Lo7YBoaYTCwSFGdDxSW/IhGXexaZrkSW02k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqS4Ey7mYvVUNogR/yoIJnYevou5t+jFyQwPPXI
 svkZ7TevaaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakuBMgAKCRDBN2bmhouD
 1xkZD/97bMDPwUqVYOtzzEefvUZkfdTtp3OU8gOXAMbAeR0VL/PXVPjdMPwIrwOKoaHyUQ6H8qN
 aEE2dpKSrWk2vNjSBE8z0xDCPUAAiYTaJ9h7wDzti4hkI/v+GZW3srTzNM1MdE49FmqWyDN6o+u
 clo4FzC4GdsBv6yHwBHcNA4eeYX5ThFuFcD8jCKKCUwuZ3rQZ/pZN4nZwfp9dZUIrzN/iTwkHHj
 NPuuq616+2CihjGVNhvKzMJx5sbBNMZhU0/t8r2lOFSg+4DSvIP/NUJeLjnKHdUR0S5ILKy5wsB
 lxOHdJWzsHx5rWu+eGJdnX3CvuffQLr1rIqIyrhGpVWZjUTx1WO44Ch3T7e4kd3TEjKbCYoKCXU
 Dn43LVU7L2t/Uki0lGfFHP8BSr7A4pZEe3wWsoxk0GR/mA/Yb5OmuBwojds6v6My9Tl1ahz4UKG
 bdsqi+Ey9oyMPZU34pjGs8d0AFKY0xapPb8tMZwZW/J3g0MYkpR3edqy9QodWJKfYhu0yyeqVcZ
 Q/Yh6+L81vhiuUtzJcayj5O/S827nugMvXRh7ziBwyu8QVoDXhkCBC/aAoOnW9EZpjM2bSf1ZRm
 whtRzEbpfeKzzGLG4YxwpaEkkV70OubUW2DMq+oQUIbtD0WAJDqbqSOVTyOg3cYuyxM/nvwsr6U 8UwYaEdf3fsbLuQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wuMb3yAtJYjVywnxuD686fL_r7J7ixtW
X-Proofpoint-ORIG-GUID: wuMb3yAtJYjVywnxuD686fL_r7J7ixtW
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4b8138 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=1noj3m8NxD8BY0cqL3kA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNCBTYWx0ZWRfX4rXlXeHFmYZb
 J6f6Nu/knBeTAwNQ/wltEyUnI8XmDzFf8HaE/nuLQBjo3+jDqDet8VVKLaqMIqCayENLtsqnP8o
 EkCgyBVz79pVBTEtoMoZ0y0VSjSoFGYatbJ81sgL5XFxfiFmX0klMCMJ8EXe2ZWrmJ9CSumHZFw
 Kfp8nMbS95HZ/kV70PP+7y3gopq+Rywm2dADmxLJi1Jfo1kFnADXlVqzKD/3x+lu1HXkoeA2Fp+
 H+ZkrD/GLMhjhMPKeK9BlfbYPlh7PmMdNPbQmT9aNYcr1NS5Zx4b+mAZgxW/YrbI3h1hw1nsG5v
 6PgLKekMrfsA5gxRBXuX2LlhCxEs8ruPXjS2ku18I6+akKh+bFyjvQ39QvkO+lsR95+bNFcps54
 9YZo+6Vq99ATTL7JiwLohYn94J8WKbol/Xeu2b2aEqJmK6y/LMxPpYeOWyfYa3ACUVfOC6PSLfe
 nqCUTQ2DtmVuTOwHm6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNCBTYWx0ZWRfX0AOk42cvE+ce
 zET7tw1tBhBpvCwhe3unGQR8UlP6fiAMlIm2FDSNfg05ltLZHZfBaLptcp4qxfL5gPJvsbhcrBR
 XETDVYzBF7dKADmHH2HwWXJCqKuOJ84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060104

Correct spaces or mix of tabs+spaces into proper tab-indented lines.
No functional impact (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Ongoing bigger work for all bindings and DTS with built-in checker (dt-check-style).
---
 .../aspeed-bmc-inventec-transformers.dts      | 200 +++++++++---------
 .../boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts |   2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   2 +-
 3 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
index c713cb7a6187..e51c726b4a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
@@ -13,33 +13,33 @@ / {
        compatible = "inventec,transformer-bmc", "aspeed,ast2600";
 
        aliases {
-               serial4 = &uart5;
+	       serial4 = &uart5;
        };
 
        chosen {
-               stdout-path = &uart5;
-               bootargs = "console=ttyS4,115200n8";
+	       stdout-path = &uart5;
+	       bootargs = "console=ttyS4,115200n8";
        };
 
        memory@80000000 {
-               device_type = "memory";
-               reg = <0x80000000 0x80000000>;
+	       device_type = "memory";
+	       reg = <0x80000000 0x80000000>;
        };
 
        leds {
-               compatible = "gpio-leds";
+	       compatible = "gpio-leds";
 
-               // UID led
-               uid {
-                       label = "UID_LED";
-                       gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
-               };
+	       // UID led
+	       uid {
+		       label = "UID_LED";
+		       gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+	       };
 
-               // Heart beat led
-               heartbeat {
-                       label = "HB_LED";
-                       gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
-               };
+	       // Heart beat led
+	       heartbeat {
+		       label = "HB_LED";
+		       gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+	       };
        };
 };
 
@@ -47,8 +47,8 @@ &mdio0 {
        status = "okay";
 
        ethphy0: ethernet-phy@0 {
-               compatible = "ethernet-phy-ieee802.3-c22";
-               reg = <1>;
+	       compatible = "ethernet-phy-ieee802.3-c22";
+	       reg = <1>;
        };
 };
 
@@ -64,22 +64,22 @@ &fmc {
        status = "okay";
 
        flash@0 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bmc";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <2>;
-               spi-rx-bus-width = <2>;
+	       status = "okay";
+	       m25p,fast-read;
+	       label = "bmc";
+	       spi-max-frequency = <33000000>;
+	       spi-tx-bus-width = <2>;
+	       spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout.dtsi"
        };
 
        flash@1 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bmc2";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <2>;
-               spi-rx-bus-width = <2>;
+	       status = "okay";
+	       m25p,fast-read;
+	       label = "bmc2";
+	       spi-max-frequency = <33000000>;
+	       spi-tx-bus-width = <2>;
+	       spi-rx-bus-width = <2>;
        };
 };
 
@@ -89,12 +89,12 @@ &spi1 {
        pinctrl-0 = <&pinctrl_spi1_default>;
 
        flash@0 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bios";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <1>;
-               spi-rx-bus-width = <1>;
+	       status = "okay";
+	       m25p,fast-read;
+	       label = "bios";
+	       spi-max-frequency = <33000000>;
+	       spi-tx-bus-width = <1>;
+	       spi-rx-bus-width = <1>;
        };
 };
 
@@ -115,9 +115,9 @@ &i2c0 {
 
        //Set bmc' slave address;
        bmc_slave@10 {
-               compatible = "ipmb-dev";
-               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
-               i2c-protocol;
+	       compatible = "ipmb-dev";
+	       reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	       i2c-protocol;
        };
 };
 
@@ -129,9 +129,9 @@ &i2c3 {
        // FRU AT24C512C-SSHM-T
        status = "okay";
        eeprom@50 {
-               compatible = "atmel,24c512";
-               reg = <0x50>;
-               pagesize = <128>;
+	       compatible = "atmel,24c512";
+	       reg = <0x50>;
+	       pagesize = <128>;
        };
 };
 
@@ -143,26 +143,26 @@ &i2c6 {
        status = "okay";
 
        tmp75@49 {
-               compatible = "ti,tmp75";
-               reg = <0x49>;
+	       compatible = "ti,tmp75";
+	       reg = <0x49>;
        };
 
        tmp75@4f {
-               compatible = "ti,tmp75";
-               reg = <0x4f>;
+	       compatible = "ti,tmp75";
+	       reg = <0x4f>;
        };
 
        tmp468@48 {
-               compatible = "ti,tmp468";
-               reg = <0x48>;
+	       compatible = "ti,tmp468";
+	       reg = <0x48>;
        };
 };
 
 &i2c7 {
        status = "okay";
        adm1278@40 {
-               compatible = "adi,adm1278";
-               reg = <0x40>;
+	       compatible = "adi,adm1278";
+	       reg = <0x40>;
        };
 };
 
@@ -172,15 +172,15 @@ &i2c8 {
        status = "okay";
 
        eeprom@51 {
-               compatible = "atmel,24c512";
-               reg = <0x51>;
-               pagesize = <128>;
+	       compatible = "atmel,24c512";
+	       reg = <0x51>;
+	       pagesize = <128>;
        };
 
        eeprom@53 {
-               compatible = "atmel,24c512";
-               reg = <0x53>;
-               pagesize = <128>;
+	       compatible = "atmel,24c512";
+	       reg = <0x53>;
+	       pagesize = <128>;
        };
 };
 
@@ -194,17 +194,17 @@ &i2c10 {
        status = "okay";
 
        i2c-mux@71 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x71>;
+	       compatible = "nxp,pca9544";
+	       #address-cells = <1>;
+	       #size-cells = <0>;
+	       reg = <0x71>;
        };
 
        i2c-mux@73 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x73>;
+	       compatible = "nxp,pca9544";
+	       #address-cells = <1>;
+	       #size-cells = <0>;
+	       reg = <0x73>;
        };
 };
 
@@ -213,46 +213,46 @@ &i2c11 {
        status = "okay";
 
        i2c-mux@70 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x70>;
+	       compatible = "nxp,pca9544";
+	       #address-cells = <1>;
+	       #size-cells = <0>;
+	       reg = <0x70>;
 
-               pcie_eeprom_riser1: i2c@0 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <0>;
+	       pcie_eeprom_riser1: i2c@0 {
+		       #address-cells = <1>;
+		       #size-cells = <0>;
+		       reg = <0>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
+		       eeprom@55 {
+			       compatible = "atmel,24c512";
+			       reg = <0x55>;
+			       pagesize = <128>;
+		       };
+	       };
 
-               pcie_eeprom_riser2: i2c@1 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <1>;
+	       pcie_eeprom_riser2: i2c@1 {
+		       #address-cells = <1>;
+		       #size-cells = <0>;
+		       reg = <1>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
+		       eeprom@55 {
+			       compatible = "atmel,24c512";
+			       reg = <0x55>;
+			       pagesize = <128>;
+		       };
+	       };
 
-               pcie_eeprom_riser3: i2c@2 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <2>;
+	       pcie_eeprom_riser3: i2c@2 {
+		       #address-cells = <1>;
+		       #size-cells = <0>;
+		       reg = <2>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
+		       eeprom@55 {
+			       compatible = "atmel,24c512";
+			       reg = <0x55>;
+			       pagesize = <128>;
+		       };
+	       };
        };
 };
 
@@ -260,8 +260,8 @@ &i2c12 {
        status = "okay";
 
        psu0:psu0@58 {
-               compatible = "pmbus";
-               reg = <0x58>;
+	       compatible = "pmbus";
+	       reg = <0x58>;
        };
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
index 8a7fb55ab489..5a3e8a3941d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
@@ -82,7 +82,7 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
-        label = "bmc";
+		label = "bmc";
 #include "openbmc-flash-layout.dtsi"
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..edf4b74f5aba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -517,7 +517,7 @@ timer: timer@1e782000 {
 				clocks = <&syscon ASPEED_CLK_APB1>;
 				clock-names = "PCLK";
 				status = "disabled";
-                        };
+			};
 
 			uart1: serial@1e783000 {
 				compatible = "ns16550a";
-- 
2.53.0


