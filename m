Return-Path: <linux-aspeed+bounces-2277-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E198CCAC5AA
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnM4JkVz30Pg;
	Fri, 19 Sep 2025 04:04:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218663;
	cv=none; b=LDIyyjOD+PHo8lZMduzQFah7q6KV4h3qNxj/zxz6fry0oWOo0scnmv4n6XIZ2kTXck5Xvjlm9GKfl3JC6k+baPdLBTQVSLIm+NKELPmo9OG9FLpPI97jyFxu++PbdKQCq2TqqQTl9iooWkd/MxooNYa+WnF0IxEB+q53177HEQzY6n55+SRBfyb0jUFXvQyHTTHdAfQi/0p2oFcLKIbEVlbclel6k4tJWba8K87RYygFQgLx+/OeT5pAnpfgO+lmHhjLPVCqfbg5X2rwG4bHND2Q+JrWB80adPrWZp6QiKMrKTB7Za0sWoSwhbHwvMzDi6EY6YhphKPIcUH6hUNy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218663; c=relaxed/relaxed;
	bh=A9OzHSyflbyykrbW7EYr7qpVvkpsCbwn1hOnR4XSlWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltp29HLr/znCLF49g7VioNuqo0JKICbgdLmCJ6Wr3Bns/z+jVf7j5dCIDheKL9HmdCGz4Bf7F8Hku8uS0Ot5uhBKL0rBAlQ0t6iSm7utIzVXiW2CtHykEeJxf1OgPzkYvv6QODfjB6mYbHft1Ot8BQ4KIBRFCWbtKOv5HcLXE6DoC5A4lFpt9BqBEQutX/WbJJqffIlIeSoferhxDzWanWnmyWZFCOgZUS0SMfVJQLxwB1z17vR5+XTSLIW6V+0Bl0wegPeB7nQqfNrlAfsMBSS9p2X6hYY2AfIyubOAheIPEICwR8FhfCQQCCF8anJiyYGcouiIw+vHyzg06vykrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CncChJQV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CncChJQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnL32MVz2xnr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEel6C032503;
	Thu, 18 Sep 2025 18:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A9OzHSyflbyykrbW7
	EYr7qpVvkpsCbwn1hOnR4XSlWE=; b=CncChJQVMZh/Os/h7Di3TZ7wts6EQd8X2
	P7u9+PUNlirOhLBr1ZjIF5GyP3EUBFKb/D9C/ehjU6ZpjdUudIy4M8pSH076ld/j
	ZXsh2Wh9Slfxt6qjG+S7vXgDAAbGyCnk3yp9DMi4FUgts59Cd4IyXaf7Tdli07d6
	/FKeifFgT6VuPh2kKHk8uXXnG6gkzrWm4oErHSTL3EVv7nt1/Xj16o0Wms+YE5nT
	9o8xoS9YOT4NfTW7D7z8l7kS+h3ElH4pBJ0m0KK6h2yXRC49tWOY/s7ShZ3xdRxd
	slb2zLvP78pGBMmONqLF1ENgFV0iCJZa17YqsdtsJdQuNRZJEw5Hg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hv0dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGIBl3005923;
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxug9m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4BTF524810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6382858060;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D57058063;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 4/7] dt-bindings: hwmon: Move max31785 compatibles to max31790 document
Date: Thu, 18 Sep 2025 13:03:59 -0500
Message-ID: <20250918180402.199373-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918180402.199373-1-eajames@linux.ibm.com>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yJzqs_b8VtvPa0SaH2pzN2IC2wFVRkTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX/sqN5goxag2c
 n8GvU8eOya+qn7LKqQ9uHclzy6CZ+XicG2lpxrkGjaWj8y3GQ8cfhSFxbR+Od5NtHGnUT1q/jE3
 EGKCJFNJtfrsiRWNgNWXNZvp7+bffIAfl1Z7lW5dMQUsU2O9ZHhcIFFBxIjVed8pikeFkPTguK4
 1TxpaIQZQYCRi/RFtapuzIIx85+t7wEudtbOTXpcGbu+QKNdI2kv+m6+hfj58KnfGGYLd1rnTLt
 MUZdeyF91LOJWbETh/zoPxy4I45fIijGqhiCTX3ZrLA3uuEgu5co1P07kvT2mEOQDK5GFcSF4gD
 MXVSyIfJP/7TQ/TMe8+YvoZC9y9rU2HQ1theDce5hBzTd/KBjJdhLhPq6u+oxI8/YdgS1cVT9xN
 YKhaglJV
X-Proofpoint-GUID: yJzqs_b8VtvPa0SaH2pzN2IC2wFVRkTc
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc499d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=brXxiGoeIixPC4QSiM8A:9 a=RWaeYqt-Cn-VcsFsiLGo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

The binding for the max31785 is the same as the max31790, so just add
some compatible strings for the max31785 chip.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../bindings/hwmon/maxim,max31790.yaml        |  6 ++++-
 2 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
deleted file mode 100644
index 106e08c56aaa9..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/max31785.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Bindings for the Maxim MAX31785 Intelligent Fan Controller
-==========================================================
-
-Reference:
-
-https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
-
-The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channel fan
-management with temperature and remote voltage sensing. Various fan control
-features are provided, including PWM frequency control, temperature hysteresis,
-dual tachometer measurements, and fan health monitoring.
-
-Required properties:
-- compatible     : One of "maxim,max31785" or "maxim,max31785a"
-- reg            : I2C address, one of 0x52, 0x53, 0x54, 0x55.
-
-Example:
-
-        fans@52 {
-                compatible = "maxim,max31785";
-                reg = <0x52>;
-        };
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b1ff496f87f95..b2dc813b1ab44 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -20,7 +20,11 @@ description: >
 
 properties:
   compatible:
-    const: maxim,max31790
+    enum:
+      - maxim,max31785
+      - maxim,max31785a
+      - maxim,max31785b
+      - maxim,max31790
 
   reg:
     maxItems: 1
-- 
2.51.0


