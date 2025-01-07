Return-Path: <linux-aspeed+bounces-333-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A538BE77199
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 16:24:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSGbP2RVGz3bVW;
	Wed,  8 Jan 2025 03:24:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736267073;
	cv=none; b=YU/CJpEhj7gzKjDA1WRqWVWY2bnYTcIEHq2yrtdVIgSWkiKuZ1hq2q/WXu4KSFAeIJiXNRCAJQVJDRpojwAN3W2xLVkiOMy1I9TJ47fgbDQHZBk5m7vHxoOTqFQ0r3A+EmsjbXrSd1H1XVSxxIjJ62V/d+hqx3fkp1zmIyxfsJwdtCaJ/sumOMRdlaY6AddH9OuZIH7w0PV3sseZ77guY1IJQyxVNdFwP9lRTSGdNRG0lHSR09Y/0CFJVswoa6MHldO2nJ84Vl0wJDU+Atbu3r/VdGhSrxVPmA8a1mtrwt6r/rK+wdYcLRmSMLpGFrbKDjC7ChdHOTJHSuOjyM0+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736267073; c=relaxed/relaxed;
	bh=WH+uKcwDLru4i84yVcDK6Dsm8M/CrAvcndmIvrw40gU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzB7YKC6bURP/Dg/RHC5ioTzxVb5Bj1mjcz3TdVDoeQO67Pe4AIXtCLt8DJx01IrVlO3vnY3zjobwdek7oRnsXAw66KzamQmkbRjdhD8sT3A/ySzpDMQva4FEF0XWYrE680K8dXaGJR954+yp173pSFqCqREmKYysn94gv655mZNPfeK3waPelrRTPLqPcMor3g84Y3AnTDfUvx8HjadrfyfYcedx8GoukCLSAJ7QI9/mSZy8tDNlTPYciZWXvqNmThTIVUiBWQdihM/CYtkUW0grSyLgfDkVmVmi48yzgFEQlpH2cko5Q/TwfhQPzaM5jpAmhWIIK+kEMYyXT4kmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V1a1ZQCW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V1a1ZQCW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSGbN1Jb9z3bPR
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 03:24:31 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785l5J018139;
	Tue, 7 Jan 2025 16:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WH+uKcwDLru4i84yV
	cDK6Dsm8M/CrAvcndmIvrw40gU=; b=V1a1ZQCWMRo5FgPprJPc61lBbJbUCD+cC
	DHR7v1tllcikn1r5T4hVaC+ccf86n3tMNtTAkvDtOc7MargTg7bLOHTdSRHkRSsl
	ZzWvdAz7XDxd8DZxadzG3Snid0+W4PrazAlC4fkU2eld3knmwu+AH9My9M5RxmPi
	tlsmd00teR1AljODwDft92uPTLFjGE4BsoHbDgb97rJIwO2y15Qukzg/NL3XNwlN
	DK7FOlBcnnmmaPz0dODYqe4JyKAPv5Ym/YyffuGum2w9QCuhdG6Zw6niJ/BYTiG4
	HYXwCN0Pm/0j4O0NBSEbFgfe7VQusyzdm3eCPc3hWGk0YQELTiMYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3a7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507GJsWS006918;
	Tue, 7 Jan 2025 16:23:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3a7f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507GH1El003572;
	Tue, 7 Jan 2025 16:23:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat3gy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507GNqj827984432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 16:23:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0EE58059;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6B658057;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ninad@linux.ibm.com,
        ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: net: faraday,ftgmac100: Add phys mode
Date: Tue,  7 Jan 2025 10:23:38 -0600
Message-ID: <20250107162350.1281165-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107162350.1281165-1-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: g-ldmg8YlgFXWnKJv1w0nQKF-sOhvBJV
X-Proofpoint-ORIG-GUID: NmjbsbguvddWjCNGyhOjEcThy4N-U7HU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=893
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070133

Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
document them.

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


