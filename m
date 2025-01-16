Return-Path: <linux-aspeed+bounces-508-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E25C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:36:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvlW0Jdvz3cCJ;
	Fri, 17 Jan 2025 07:36:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059766;
	cv=none; b=ov/f1zzjYt+ysbepDgYnwsLHqPbfKsuj5B0g5PEkLoqKS3axIz7B6Ttxobl7VuT4YytVHA3VkiTI6HUtWmW9ayZXeqLccSPdAa+qCSXdFtDBdZ+vr8pq8rdP+ytR5HMuNODDup9IJlGTJuDj8l09WmOaJjkxnoK7HsF2vuPGZedzx6D21GA+db2zoeGx1pKCSquKXAy6D+HT95NKymIG25kEPv0JXIsOR2awyydwTzqsp9MDp3RpeWJGqseyDwGkAD+apQ/a7S66ua0OGM1hr6wzRBKYns3ai9qzcr4voOxsEgtU9gVLirj/z1C70YteHq5JeHSe0ggmuLNDw6wMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059766; c=relaxed/relaxed;
	bh=zcXYfq7y3Ykx9nkv3r9zTbWUpugtYvbNec4z//sgjIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckoAyf1kDX83L6rZa8yUr4QjJcxruM/QGCm6KFjKSwIjNmDHHi4Q5Smf2caYCoBBFn+4s1FDoubmieSFO5E3JNJGVfvONDxRAJQo1W70mkyIi53HBtbNIzmUH8pdKo9Lm0tuTxOUrVk4ObE8tPxBPQ0pWAh1Av8/cw/0wMy+UAq/otoYMDFmu0HBmFKP5ZydCj+rSviivlSbE7JJhMA4Mn0ZkgVuC9o9J8OczbXqCRemMc1nwg1Iu1AkKN5eCSMUaPMRAeRDJRwwIdBUWGrfJEE49Ly5tQiOGmxHcH/032u7l3J+2+RRwRceWhXxHLjiW7N4whoH2t7g2hkPijfFJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z1udj7xs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z1udj7xs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvlR5FGzz2yvs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:36:03 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GESRLC007667;
	Thu, 16 Jan 2025 20:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zcXYfq7y3Ykx9nkv3
	r9zTbWUpugtYvbNec4z//sgjIQ=; b=Z1udj7xsccEMJyAqV9xuj1MZHH+TOGL79
	cOMrg+yrPJUEUMCr1C1b1RbYRsNrXxMKTVvNUddfIxZRI+PbYlJq1bgVDQnERQuu
	U1QIgi3Zani6kzheUSk91VB2+OdvZPjNVRsa7BvI2R0/ahGhuikR+o0FSO2u0aee
	JhabYhGwjRFEF4jVrojVPbY5a261SuVVabdxCGhjIuXRXAcmuhrlH+0qEk1YhRZW
	/H0qwghVzPgZQFrVMAyaI03ZlWjqdVXyIinVP2veAVLutDv2UsTbintOTRspuEXi
	kw30Nie+V501zuxwmm2RZyOArSKcMz+62U7VfKUxnwRkaWj/+xNqw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKYF07013070;
	Thu, 16 Jan 2025 20:35:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GHOwPU007364;
	Thu, 16 Jan 2025 20:35:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynfmgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZXQr12124554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8122E58059;
	Thu, 16 Jan 2025 20:35:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D10958058;
	Thu, 16 Jan 2025 20:35:32 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:32 +0000 (GMT)
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
Subject: [PATCH v6 01/10] dt-bindings: net: faraday,ftgmac100: Add phys mode
Date: Thu, 16 Jan 2025 14:35:16 -0600
Message-ID: <20250116203527.2102742-2-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Upf2eS7rTwO2GUArfiLsvKzpNki0PdwK
X-Proofpoint-GUID: ErUzenTtv79y361SWL-C2FyTPHA6IFP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=946 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160151

Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
document them.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 9bcbacb6640d..55d6a8379025 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -44,6 +44,9 @@ properties:
   phy-mode:
     enum:
       - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
       - rmii
 
   phy-handle: true
-- 
2.43.0


