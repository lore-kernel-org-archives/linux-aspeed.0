Return-Path: <linux-aspeed+bounces-509-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB1BC02187
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvlW3YJlz2yvs;
	Fri, 17 Jan 2025 07:36:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059767;
	cv=none; b=FvInxdJfFeMMBV5CHWXc51aJnMY6uiPSvfJw6ot2gh+P7OKcPuUVaMWL5CYEnoq8H/BlUyEppPKxNm2Tq6mQi6g4jm5LDvwRFcDCiZk+9E7r7rCLRxLVXhaGjrL0qHYv5FHO9eImXVjx0MLkyt9hB1JSnzmRXgDaHTY5e95VPu0uRJ4FqbIYb+RLMX2tj0+F9b5HuhZ9m0mJmTFAR1/P8dnuaxAbVtwb6+NF7GnKDNxlHb7fwPCJ9PTYZFxovYY/HMxclyxPVBVvJ2S+HR2i3jGs4Ud3bbDbuUyZmRvxv6BzQcSJT5YuZ1WpKuoXQ6/C5gHcps4u1IfNBUH+wH3BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059767; c=relaxed/relaxed;
	bh=OZL4iPau+sdhd2rI414iLrHV8/fKRY51pCEXjhW/D7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkcLX3NweUz+Y+deYjXBwUfDnARceR2bTxN20nlbh42Vg0HLO53o/J2hCXiw2rJ3H8NmtYEEC/tr1HmxuXp5F1QLQW8Y/uXKA8SMEWr9iAmJDA14iG6LO1fZjbjTX+WhXuW9/xX5MTx0kCR2G+3bC4yqNYCRel7a+xGD6Ye2ks7a4107Gm+79JUEM39duzGynuEehMqhds4cl3FDgn7RipHejxpcAAPNXZ+IF/yJDijvTW8WF5l+Y4O+7I5vs3ih/qKKWsLsq4bElymijKqCQaYLF/Wb++kCQEgnOB6GkoYIc1ajBZEpgb5q5WqmvA6919XwSuSDgwh/E/+9fJhD9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/JW9jqg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/JW9jqg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvlS5cdcz3bhD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:36:04 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEDwGc005796;
	Thu, 16 Jan 2025 20:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OZL4iPau+sdhd2rI4
	14iLrHV8/fKRY51pCEXjhW/D7E=; b=j/JW9jqgJ7mdxOGWxmxnRKGM++9YiTENr
	lLhsadqhZlYEuD3ZUqHX+rPzqSlxD9iho+1y/2jsmQ2uebonBp23znZI/zfTTjcn
	RSRhvQEHCmdUytUhE22v0LFiKA5fUSc7k84fsIUDQT+3DDRZmc89QB7ewEyaHKLy
	onLjWOccoX2w09e28p0zswS7u/+YgOlWJTN/TNVflK7ePdtAlHGv+oFt0GrzIyjm
	Fyg3AMuxP8Skem7OcoQwstvwozdjC24xQ9hYF7CgkKeAzb/ytKGCHoYLoyTCWUHl
	wz/MSLu5tTkzaHy+lfwEhk+M3Y2pICKSoN/vAs5um+ZXudvkJYnag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKTcmc004469;
	Thu, 16 Jan 2025 20:35:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKUGFb004543;
	Thu, 16 Jan 2025 20:35:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ysyt5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZZ6P23396986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28725805D;
	Thu, 16 Jan 2025 20:35:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04D558058;
	Thu, 16 Jan 2025 20:35:34 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:34 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v6 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
Date: Thu, 16 Jan 2025 14:35:18 -0600
Message-ID: <20250116203527.2102742-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116203527.2102742-1-ninad@linux.ibm.com>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gYjtnMl_HE0nYvod0MqUM4Sfq-oyim9x
X-Proofpoint-GUID: YY6ihM2NP9ImwK6Fb_ttY3wmC-nb7q8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=967 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160151

Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index b9afd07a9d24..0497d19a60e9 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -46,6 +46,12 @@ properties:
     minimum: 12
     maximum: 232
 
+patternProperties:
+  "^(.+-hog(-[0-9]+)?)$":
+    type: object
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
-- 
2.43.0


