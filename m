Return-Path: <linux-aspeed+bounces-633-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5122BC02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMT66cPz2yn4;
	Wed,  5 Feb 2025 05:44:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694645;
	cv=none; b=LP8krIOhp5fz7alX7NltiA5dQoOdLWXqqg8PMT26AK+Sl0WLVutDKLGcHsZycWqWzc5X+rMr9+kgLwHb+a+4aB/9Y2cF0K8ub4V9SjELAPFwLv/j7EnK+LuuT6/XGnV019s6F4+JLdnMYEMi515Hsf0zC4eVLXbyMHbjr1vOT2Wmc2+nnqHQEzr69YPBS+5Md15RNtEWkKORX0xu18wNMVvd4o+iCueZU9H02I9AtueNlXFYTvpg86Ssh+/UTqmQBfgweJb7zo1lD6rfzixkfoBMHlZUDFOsB7MQG8uVFKf4NY3tknARajTRMmedmZ17jgEW+lM4ZK+OGGjVw35sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694645; c=relaxed/relaxed;
	bh=M2Jh7wxBPDIMXjM/IX68myxQ1J5TffG1POfQiRFYLQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwsWsCckYY3oGxDnblE173fMD6AKsTSKOmoDC2BKT7mL6wUJZ376iwvnXydvpPM+28MyHstQ4cFtLir4uYoOIXVD2+Ayg5uBbIalgGSXuYNnirrLY4ho53Yft+voemE76gV06JSs79hvlkZIdY9jhojgNJhSxUgfxkJ5ov3asTB9hpcClUyJoymIUxdAbsKx/mgZyj+8uaClF3TS98MtmXc7r1bEoju3RTKj34GKEnkaFWe1WqA0rMjuxz1hPs6f7J5fYkXx67jdacmGVAI/kr0n7OL7PRKJE0tTm8RMcpd0VfmfcaK+6SQW+upeXM17QXb58SbbS6jIapHKT6WYdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AjfjFydK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AjfjFydK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMT0MLPz2yXd
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:04 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEn4I029264;
	Tue, 4 Feb 2025 18:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M2Jh7wxBPDIMXjM/I
	X68myxQ1J5TffG1POfQiRFYLQc=; b=AjfjFydKDff+c5wYGZVU00441Ey86z3xy
	JvIrQoy771i5MuCgRoOBfzZoYSjHzFzfw7jwuXKBufAKs16EfKB9vg4X/GRB8xji
	f9mgQwfU5tFkhunYzYPr4a0HL7/F4VdeS4ADKRS7ngFJzRtbdAN0SY/lK/e7f+PY
	XGbGnO6S2N0XMejAb2mrMaro+Uh80hdkvPvDLW7/V1X7I0LF7Df02GB5dM6Kt/Xn
	WcMSgoSYqMmnyhldVj/BajvEAQ9m2DvIFncf5mgc8Uj3SJWcIDS96b7pyivgfYaD
	WZbARgefIgP0UFbG1r8q5rTQ2ss9W53a59nXcDy/jn4Quf/SWwgHw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9mt42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514Fm5IB007139;
	Tue, 4 Feb 2025 18:43:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayn23g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514IhhEI58655220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 178775805F;
	Tue,  4 Feb 2025 18:43:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FAFB58059;
	Tue,  4 Feb 2025 18:43:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
Date: Tue,  4 Feb 2025 12:43:28 -0600
Message-ID: <20250204184337.3896834-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204184337.3896834-1-ninad@linux.ibm.com>
References: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sFc-oVvFKXRrELVI6Ibr7bLQ7FVj8kiA
X-Proofpoint-ORIG-GUID: sFc-oVvFKXRrELVI6Ibr7bLQ7FVj8kiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

Allow parsing GPIO controller children nodes with GPIO hogs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index b9afd07a9d24..b16273e69dfe 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -46,6 +46,12 @@ properties:
     minimum: 12
     maximum: 232
 
+patternProperties:
+  "-hog(-[0-9]+)?$":
+    type: object
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
-- 
2.43.0


