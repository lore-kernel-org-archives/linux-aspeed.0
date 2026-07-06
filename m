Return-Path: <linux-aspeed+bounces-4414-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06598C44500
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 23:47:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvLcP4QrTz2yfS;
	Tue, 07 Jul 2026 09:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783360998;
	cv=none; b=n7aLfjtH5DvutiflFx8B6b6ItOTwgw4K5UNW+v4ZvH3MoK+aiHHpgt+TYyEhiQtC5klrtGBxoW4klJ85esEj6rZK08bputKVX09NzDdHFLO+BOVK2VOUVYaIbr3uosMlFZE3imkWXLniCTikFH3SeaNUP/rozrbtDsRiPAHn77hNg9cdZwtjCy1TR8//jFMhYLVq0CSR5rXYvgWn53Y7f0Kz+f3aB4cc9+G/dCvEwXZLMY4/h8sW1CTQsbmVk2Avx+6PHASpGTbRjbf206ZnOmwrp7dRuXEWb+Ydv0laWuGNn3pFyNrzCZOIp29iBl9cnN7tRsDCvjO5MRi+p0PhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783360998; c=relaxed/relaxed;
	bh=Gt1vxrCSNrq7y97Hv08uirOBPw/48mufLTobNvyzlTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHfzUMPXXH4o7/wwgu5/d6JOy8D0ciz/C+B6CPUwq/UXI0/i7GA6posaiWNoi+d+dgoOgplsJ9n1FYDj7HR7MYaofT0Ec2WFXbdRu08r+oo/cHMcr0wOKG9JNcFVuTBSKPx5DwD70Q1K+8Gv66XnHBGkiv0dLXaDnEKFiEkrCePiWOAlfSml8YDxEDS6WXz2caZGTU54MojNWKwwUL+MvmPsAEjAkpL2AFiU8VPoa1ntTcWUEyO/M0wUQsu0xRYqvLgqVYtUX+2CoGdc91S/0XLA7IAilC3Y4FcEmoumazsLKT0XXbOafUurmlKRSqa1MEDycp2KTR1bHKDS4n5VxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=giDj9PJ9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cz7aZWlF; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=giDj9PJ9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cz7aZWlF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvBzn6jlTz3bps
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jul 2026 04:03:17 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFCdZ990326
	for <linux-aspeed@lists.ozlabs.org>; Mon, 6 Jul 2026 18:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Gt1vxrCSNrq7y97Hv08uirOBPw/48mufLTo
	bNvyzlTU=; b=giDj9PJ9BabyIlHd/8JLoqHNzisAjKoD89j+xblWLHWKkuhKLfJ
	taYJtwL+pERpKqRr8B40no+92AM7AFkIePyjq04RKbNpdF1MulaR0DthtZHnA64m
	lNuwEul026dzZgo2CVW5+EUoRtL8edXYnKvPr4RQbV2+F+T10G/HqYYftbg7837m
	wbpR2XWOM/rxC0Ul+5ugVl6ITXxmrcydZhHRLNfPlOACJDoWQCNg+TxBCusv/us1
	w+Sz1M0zUqbOzYIMGCJkzrbspc0cvXMbFKK9SlKEq1mIZu4M4j3JDqCnb6GxaJAi
	2GUHFpu3bzou24UcAznr5o1atnZqiW3i6Fw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gt92d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 18:03:15 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5be3d6de82dso231916e0c.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783360994; x=1783965794; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt1vxrCSNrq7y97Hv08uirOBPw/48mufLTobNvyzlTU=;
        b=Cz7aZWlF+u1II07iFMWIPv0rss1s3ZcktiCsnR9SRyu6TkDWwOYrZRSrh+JAi5ygeO
         uxeA2S7G0fYtg8yx9/T2I1QN/sl7SvUDcKx2CJNu3nt30f49noS5nnTK9/p9abVag1MT
         ehie8vBf5BkosSaJL3iyAevL+l1AHr+SzIo6+zXsfD4ITkdKmg3hlyC7dUkcULjJ7q99
         0C048xTeXEXUS2gNui55zufqiUn/fvxa5x38umQtToYnwIRu9qNVRqa9V9tGYo1jDiSn
         j8+ryK7oWXvp2U/UoAV7isLNAsFaFdxhZKWgLnn+qD9nuRuOXc3VocW4PyJOy/cThscs
         0BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360994; x=1783965794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt1vxrCSNrq7y97Hv08uirOBPw/48mufLTobNvyzlTU=;
        b=TlWk8LSPmMG2wqnMJ7plhGAchz68sW+kWd2Chsft55qIKZDOul7w1v8DyXvdbFINmn
         B/UfRueJWM1jNv0JL2EOsWPJoMSBntZKrrEHEjcGTRQQUAsgpef+lHhmMd3qvESQH+u/
         n0xTWm17+rc+Vdu/+6m2GTK8RGxli6XiM0LuXDi6q5j3/nyMGwzX16nuSLS8h8qtICkj
         TJKsdFYMqufaMHD8IU4d2tPOs8otBmiAFyDUmsmj0LJ7/BH55ZGKAJ7TIS6LQ2a+SVGb
         GmLnGRcq2S1LfV0graxlbA+JN4rkbFme79kdxWwLXXRz6hyEJWcftCAIKnqhoBAAOuKc
         1Xgg==
X-Forwarded-Encrypted: i=1; AHgh+RobIwD00yccSRJJc9EqFh4DQ/yn7bFTRHCbdu1AGenwMUaC8ZgDg66qZfPHHmJJWctItUBYwPiYRriLf5U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9nEbggCyyN+3ZRsyfU0MX162nD4MEI7X1g3z1fgVm91q08zco
	7vF7cb3N6cYdO8FyW6pD3MelYxAI1gHOvrj2euyOUoxzLy3fgPeV+PG/qNteeHTVcmFXfADZY5a
	WSpxtMn0sTWe2x51pXcFKlpMUOQKPkYOJuYbvw5VqC87+C/ZnthLHHm7gPC3L+4qclKdD
X-Gm-Gg: AfdE7clYtQe1AMFSm63n5jJAI9l2/UjeLSohbsp38qJOfGK7bzstlUhKAK4dHvjoXJt
	ow9Q0OvHCVjvkqOJo+xov9X0rHJMvV2kKyVK0cgs3oyjI/wF3ys0/6clC8U/vFymvZSvV498Pm7
	VustY2Tpcx9IVO42q7RxZi+CDelXPYYYR72TpLjxwZ0r+O6GaSFFxOzI/GLemapbCHLlQ3RLPyY
	0wWIvFeHBZB9oyF25A6qNDBe5AxVrR8q1LWffyjGaggO+iOXIrwKgDZqY/ngfCzVjlnZ515UmOA
	B7dwr5kPQZ/a+Xy1NO9stgHvRZcRYrKDfbSDeUYxr/C/wuH43McKhUojRPGhXyEwms/kUe97Qlj
	eNpDwY9mBUGOWA/tC+KY7zeSFn3U=
X-Received: by 2002:a05:6122:e44a:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5be89e1543amr904416e0c.3.1783360993854;
        Mon, 06 Jul 2026 11:03:13 -0700 (PDT)
X-Received: by 2002:a05:6122:e44a:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5be89e1543amr904332e0c.3.1783360992942;
        Mon, 06 Jul 2026 11:03:12 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm27356538f8f.11.2026.07.06.11.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:03:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2] ARM: dts: aspeed: Correct indentation
Date: Mon,  6 Jul 2026 20:03:08 +0200
Message-ID: <20260706180307.635369-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15384; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=LdhjOdTRiwYN1T2j9SwCfs17Qi6jkgIysZsTMSeCB6I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqS+3bzaoCGnhqEtDlbcaXCaGjDv3ej/HylA87L
 9qGEpCaeeyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakvt2wAKCRDBN2bmhouD
 1wVXD/0XwHSBVLnre+wUfDtHq73rhECaCtvpphs+di9tMlTnHNoGaUK79LZ6cyNfpeE7YlQ/hfV
 SS8yDulpkOmnV9EE8nDp3tfgFWmmjFcQWpOc2yS2DCd7FieT/VH1+AzY7fOuRyyfyjXshWQaGuK
 r+aziQbxvNlSAc124vLbX44DvsN9dVomyNIFc2llisb03yALRgm9w/K+ZT8jKfIxfneZou5r7IV
 0h4yEXV4jfAzmicPci4wfbu/DTmTcYPZxanYa0FGSr45tXT/irdL72murxQRLkPbYl9yk+Hiamh
 +yxlj23yk0YJKHEzMSBYebr4Ay7SUpcsz+Nb/eCKAxNu5Y7nP2d9CH2yCcV7sHZJJ26Kwd6S1p0
 yPfWSSec7kHMElqFmbBGmvcdKYV4ZtoHFwUW5Ip0qJYHjxPsa73IMg1lwuTvgkPT5WIgH9C7G/y
 4VsCktVQuNrLZERzhn1gqYYdYzr+kSv6DuuZj3zkGn4m55avw8B4aGREe6O8Mr22eqdkkWU1MDu
 +ftCZVUo5krjQopsXQWOEsF5+OHQrI/45qyrnpa2INwukNzYkYFj0OkkUlC4ylbFyT/IO7XkULQ
 +Xdu7Y/1j4QONfFjhcLvzbmgYqQYeWuPEDePg8/qkP/ePIln2vAU8VkRuUVYRAhRGlcuwGCfSAh sRDD2WMu6Cgnpwg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uCX9uJJk51n45TIczfep5ztgRS1_AYuc
X-Proofpoint-ORIG-GUID: uCX9uJJk51n45TIczfep5ztgRS1_AYuc
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bede3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EdFd9dCIzGFzXepkhT4A:9 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4MiBTYWx0ZWRfX78t+rqVLO+1e
 KlhEDO1It1O4mSBXxFvofbVAHa6dlg2SoHcWOzXXPKWCrzoRL/gTBL6X56aTnjx2KJJ5Udqwo3O
 MPya2/l3GeAbuuYUYlpJnNW0SdNmCPyikFHqVLzWPOab6kt/a8psutLlwvvTR4AS4qE9GTvRhIv
 RsNW0+mt/wDtlQetaEXQURGNOuWbRDzaW4tNKPmaPaDqeTWqwgseK/NiDEjVXe2AAS9S1BjfqIE
 sfw0wi0a7VrPNLWP8iu7lQwGmtbxffK2TCgbyUxvp1VxVZYzabsXhhUxUVbHKRRnRhtGYRQknSN
 kPSlNAsgqSGKqoPmLJsQtImSlxB6dMqPVyq2MxMfFwZ+UJnsR1gN00nB/YpB1fYe9eFB3bBYz1V
 H2RfUsB5y0LXSpVEMTkPuzDNV57iSHXFx7/5/9xYTR4c5Gsnlv0oENWwzadO9f5cKVTeyR1yO3h
 k8jfALY9v8wR0Lf33RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4MiBTYWx0ZWRfX029QfVfFPpke
 ZNLL7dHGC6/es5K1pb/3o1pfs/VoRUpakrxAlpKWmMnIu/bxfWqxCo78DlAnfGpzBr8OGEyhjkN
 34UoH8OtrxHqd7JWbShrpxZE/ELpp9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060182

Correct spaces or mix of tabs+spaces into proper tab-indented lines.
No functional impact (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Ongoing bigger work for all bindings and DTS with built-in checker (dt-check-style).

Changes in v2:
1. Fix also arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
---
 .../aspeed-bmc-inventec-transformers.dts      | 432 +++++++++---------
 .../boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts |   2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   2 +-
 3 files changed, 218 insertions(+), 218 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
index c713cb7a6187..45ee0f2cc2bb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
@@ -9,320 +9,320 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
-       model = "TRANSFORMERS BMC";
-       compatible = "inventec,transformer-bmc", "aspeed,ast2600";
+	model = "TRANSFORMERS BMC";
+	compatible = "inventec,transformer-bmc", "aspeed,ast2600";
 
-       aliases {
-               serial4 = &uart5;
-       };
+	aliases {
+		serial4 = &uart5;
+	};
 
-       chosen {
-               stdout-path = &uart5;
-               bootargs = "console=ttyS4,115200n8";
-       };
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8";
+	};
 
-       memory@80000000 {
-               device_type = "memory";
-               reg = <0x80000000 0x80000000>;
-       };
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
 
-       leds {
-               compatible = "gpio-leds";
+	leds {
+		compatible = "gpio-leds";
 
-               // UID led
-               uid {
-                       label = "UID_LED";
-                       gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
-               };
+		// UID led
+		uid {
+			label = "UID_LED";
+			gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+		};
 
-               // Heart beat led
-               heartbeat {
-                       label = "HB_LED";
-                       gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
-               };
-       };
+		// Heart beat led
+		heartbeat {
+			label = "HB_LED";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &mdio0 {
-       status = "okay";
+	status = "okay";
 
-       ethphy0: ethernet-phy@0 {
-               compatible = "ethernet-phy-ieee802.3-c22";
-               reg = <1>;
-       };
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
 
 &mac3 {
-       status = "okay";
-       phy-mode = "rgmii";
-       phy-handle = <&ethphy0>;
-       pinctrl-names = "default";
-       pinctrl-0 = <&pinctrl_rgmii4_default>;
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
 
 &fmc {
-       status = "okay";
+	status = "okay";
 
-       flash@0 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bmc";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <2>;
-               spi-rx-bus-width = <2>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <33000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout.dtsi"
-       };
+	};
 
-       flash@1 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bmc2";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <2>;
-               spi-rx-bus-width = <2>;
-       };
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-max-frequency = <33000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
 };
 
 &spi1 {
-       status = "okay";
-       pinctrl-names = "default";
-       pinctrl-0 = <&pinctrl_spi1_default>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
 
-       flash@0 {
-               status = "okay";
-               m25p,fast-read;
-               label = "bios";
-               spi-max-frequency = <33000000>;
-               spi-tx-bus-width = <1>;
-               spi-rx-bus-width = <1>;
-       };
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <33000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
 };
 
 &wdt1 {
-       status = "okay";
+	status = "okay";
 };
 
 &uart1 {
-       status = "okay";
+	status = "okay";
 };
 
 &uart5 {
-       status = "okay";
+	status = "okay";
 };
 
 &i2c0 {
-       status = "okay";
+	status = "okay";
 
-       //Set bmc' slave address;
-       bmc_slave@10 {
-               compatible = "ipmb-dev";
-               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
-               i2c-protocol;
-       };
+	//Set bmc' slave address;
+	bmc_slave@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c2 {
-       status = "okay";
+	status = "okay";
 };
 
 &i2c3 {
-       // FRU AT24C512C-SSHM-T
-       status = "okay";
-       eeprom@50 {
-               compatible = "atmel,24c512";
-               reg = <0x50>;
-               pagesize = <128>;
-       };
+	// FRU AT24C512C-SSHM-T
+	status = "okay";
+	eeprom@50 {
+		compatible = "atmel,24c512";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
 };
 
 &i2c5 {
-       status = "okay";
+	status = "okay";
 };
 
 &i2c6 {
-       status = "okay";
+	status = "okay";
 
-       tmp75@49 {
-               compatible = "ti,tmp75";
-               reg = <0x49>;
-       };
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 
-       tmp75@4f {
-               compatible = "ti,tmp75";
-               reg = <0x4f>;
-       };
+	tmp75@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
 
-       tmp468@48 {
-               compatible = "ti,tmp468";
-               reg = <0x48>;
-       };
+	tmp468@48 {
+		compatible = "ti,tmp468";
+		reg = <0x48>;
+	};
 };
 
 &i2c7 {
-       status = "okay";
-       adm1278@40 {
-               compatible = "adi,adm1278";
-               reg = <0x40>;
-       };
+	status = "okay";
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
 };
 
 
 &i2c8 {
-       // FRU AT24C512C-SSHM-T
-       status = "okay";
+	// FRU AT24C512C-SSHM-T
+	status = "okay";
 
-       eeprom@51 {
-               compatible = "atmel,24c512";
-               reg = <0x51>;
-               pagesize = <128>;
-       };
+	eeprom@51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+		pagesize = <128>;
+	};
 
-       eeprom@53 {
-               compatible = "atmel,24c512";
-               reg = <0x53>;
-               pagesize = <128>;
-       };
+	eeprom@53 {
+		compatible = "atmel,24c512";
+		reg = <0x53>;
+		pagesize = <128>;
+	};
 };
 
 &i2c9 {
-       // M.2
-       status = "okay";
+	// M.2
+	status = "okay";
 };
 
 &i2c10 {
-       // I2C EXPANDER
-       status = "okay";
+	// I2C EXPANDER
+	status = "okay";
 
-       i2c-mux@71 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x71>;
-       };
+	i2c-mux@71 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+	};
 
-       i2c-mux@73 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x73>;
-       };
+	i2c-mux@73 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x73>;
+	};
 };
 
 &i2c11 {
-       // I2C EXPANDER
-       status = "okay";
+	// I2C EXPANDER
+	status = "okay";
 
-       i2c-mux@70 {
-               compatible = "nxp,pca9544";
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x70>;
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
 
-               pcie_eeprom_riser1: i2c@0 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <0>;
+		pcie_eeprom_riser1: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
+			eeprom@55 {
+				compatible = "atmel,24c512";
+				reg = <0x55>;
+				pagesize = <128>;
+			};
+		};
 
-               pcie_eeprom_riser2: i2c@1 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <1>;
+		pcie_eeprom_riser2: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
+			eeprom@55 {
+				compatible = "atmel,24c512";
+				reg = <0x55>;
+				pagesize = <128>;
+			};
+		};
 
-               pcie_eeprom_riser3: i2c@2 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       reg = <2>;
+		pcie_eeprom_riser3: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
 
-                       eeprom@55 {
-                               compatible = "atmel,24c512";
-                               reg = <0x55>;
-                               pagesize = <128>;
-                       };
-               };
-       };
+			eeprom@55 {
+				compatible = "atmel,24c512";
+				reg = <0x55>;
+				pagesize = <128>;
+			};
+		};
+	};
 };
 
 &i2c12 {
-       status = "okay";
+	status = "okay";
 
-       psu0:psu0@58 {
-               compatible = "pmbus";
-               reg = <0x58>;
-       };
+	psu0:psu0@58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
 };
 
 &gpio0 {
-       status = "okay";
-       gpio-line-names =
-       /*A0-A7*/   "","","","","","","","",
-       /*B0-B7*/   "presence-ps0","power-chassis-good","","","","","presence-ps1","",
-       /*C0-C7*/   "","","","","","","","",
-       /*D0-D7*/   "","","","","","","","",
-       /*E0-E7*/   "","","","","","","","",
-       /*F0-F7*/   "","","","","power-chassis-control","","","",
-       /*G0-G7*/   "","","jtag-mux","","","","","",
-       /*H0-H7*/   "","","","","reset-button","power-button","","",
-       /*I0-I7*/   "","","","","","","","",
-       /*J0-J7*/   "","","","","","","","",
-       /*K0-K7*/   "","","","","","","","",
-       /*L0-L7*/   "","","","","","","","",
-       /*M0-M7*/   "","","","","","","","",
-       /*N0-N7*/   "","","","","","","","",
-       /*O0-O7*/   "","","","","","","","",
-       /*P0-P7*/   "","","","tck-mux","","","","",
-       /*Q0-Q7*/   "","","","","","","","",
-       /*R0-R7*/   "","","","","","","","",
-       /*S0-S7*/   "","","","","","","","",
-       /*T0-T7*/   "","","","","","","","",
-       /*U0-U7*/   "","nmi-button","","","","","","",
-       /*V0-V7*/   "","","","","power-config-full-load","","","",
-       /*W0-W7*/   "","","","","","","","",
-       /*X0-X7*/   "","","","","","","","",
-       /*Y0-Y7*/   "","","","","","","","",
-       /*Z0-Z7*/   "","","","","","","","",
-       /*AA0-AA7*/ "","","","","","","","",
-       /*AB0-AB7*/ "","","","","","","","",
-       /*AC0-AC7*/ "","","","","","","","";
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/   "","","","","","","","",
+	/*B0-B7*/   "presence-ps0","power-chassis-good","","","","","presence-ps1","",
+	/*C0-C7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","","",
+	/*E0-E7*/   "","","","","","","","",
+	/*F0-F7*/   "","","","","power-chassis-control","","","",
+	/*G0-G7*/   "","","jtag-mux","","","","","",
+	/*H0-H7*/   "","","","","reset-button","power-button","","",
+	/*I0-I7*/   "","","","","","","","",
+	/*J0-J7*/   "","","","","","","","",
+	/*K0-K7*/   "","","","","","","","",
+	/*L0-L7*/   "","","","","","","","",
+	/*M0-M7*/   "","","","","","","","",
+	/*N0-N7*/   "","","","","","","","",
+	/*O0-O7*/   "","","","","","","","",
+	/*P0-P7*/   "","","","tck-mux","","","","",
+	/*Q0-Q7*/   "","","","","","","","",
+	/*R0-R7*/   "","","","","","","","",
+	/*S0-S7*/   "","","","","","","","",
+	/*T0-T7*/   "","","","","","","","",
+	/*U0-U7*/   "","nmi-button","","","","","","",
+	/*V0-V7*/   "","","","","power-config-full-load","","","",
+	/*W0-W7*/   "","","","","","","","",
+	/*X0-X7*/   "","","","","","","","",
+	/*Y0-Y7*/   "","","","","","","","",
+	/*Z0-Z7*/   "","","","","","","","",
+	/*AA0-AA7*/ "","","","","","","","",
+	/*AB0-AB7*/ "","","","","","","","",
+	/*AC0-AC7*/ "","","","","","","","";
 };
 
 &lpc_snoop {
-       status = "okay";
-       snoop-ports = <0x80>;
+	status = "okay";
+	snoop-ports = <0x80>;
 };
 
 &emmc_controller {
-       status = "okay";
+	status = "okay";
 };
 
 &emmc {
-       status = "okay";
-       non-removable;
-       max-frequency = <52000000>;
-       bus-width = <8>;
+	status = "okay";
+	non-removable;
+	max-frequency = <52000000>;
+	bus-width = <8>;
 };
 
 &vhub {
-       status = "okay";
-       aspeed,vhub-downstream-ports = <7>;
-       aspeed,vhub-generic-endpoints = <21>;
-       pinctrl-names = "default";
-       pinctrl-0 = <&pinctrl_usb2ad_default>;
+	status = "okay";
+	aspeed,vhub-downstream-ports = <7>;
+	aspeed,vhub-generic-endpoints = <21>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2ad_default>;
 };
 
 &rtc {
-       status = "okay";
+	status = "okay";
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


