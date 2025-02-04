Return-Path: <linux-aspeed+bounces-647-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2199C02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 19:41:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnYdt37k1z2ytT;
	Wed,  5 Feb 2025 06:41:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738698098;
	cv=none; b=WcmxzgNPzwXkfh5RMWVwecA5qKLqNNDAgEWXcfUM02CT00klu/XIeJifGsXmzMFw3KoqAshKnZtYWUknMS++vta9gBxPKQ7VoA/aYXiEHrQEHnlcOpi39rwTL4If6Rimb6c/ahgc6RHOS0fKrxMNsX87ZrND6o0wZLdJ49hDht2vya9cmlDOzulKg0wHDUuWFvzJcCvKubxTlJwUCSJMZCgHzqWDsJuuYQdoYYOMZcA/8yTsQRRJocvlISMagqo/rR337ti89YQ6K9sMCaxgv9FTT8lXFvOITxJYBKl7qVhX8xskoUcochr37M7fYs80d/+p2+Wif6pXD/YXziZPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738698098; c=relaxed/relaxed;
	bh=MbUuesV7B/Hl/l+uRNAZvT3az2VOWPemnWYXP7QjbFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7KhFA5rmvLs73Oti299g+9+64U5tMqwPbDAdHyI9PpsA1bxsMb9sMXQ8o0YbDofyVjda8qM6/Xxc/kYuM75gxF/9GfrNEP900CxoHB9MgDA6EGA4mzZDhcH4KQEqyow/X7jaS5NAjp3VQ0cshmgWeGyL/h7e4WcytP6g7qTZV94QRgesr3hIpNoNw6ggxDJyUxTeOmDp7pCQqe2oD7d7oErWQvkG0Qlyz0OurfPpu5RFy6AJ3WU+co1m3peTLFOHpIN9bXDTJHwix8ApejEHLAFhxXNxOmu16/gT0h9ruMl41+ZwiKoUuuXdNnVrUwE/SuUg2Qgxh0LaeMG/syS9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mfhw66uK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mfhw66uK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnYds6GPtz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 06:41:37 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GFPFv024364;
	Tue, 4 Feb 2025 19:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MbUuesV7B/Hl/l+uR
	NAZvT3az2VOWPemnWYXP7QjbFY=; b=mfhw66uKmm8BxnsgCgJLIsdhW1vJfQscd
	mmKfUd8bZWTQZ8TGBagUh1QAbH7X7J4ByXhVJSlE/O4VRb2LmTPu4GFtyCb8bkMt
	cJVRKYVrStxVDiShjz6Hvca8ZnDaf3hqKZ1uyEr+70oXSV2ilQEMKEUWKdOeaGkV
	Uk6GKmPD3pLZ/EMdtSSgtp+CLwIBIihhzJzw5iHjqXJdjEHMNWuBWmpsPNigzxvG
	6gInvh5bwEYlu60O2hd0KGiAHceDV4LL6Eh3gE885BfC/NSbddxjE8DoHQ522rs0
	p5jFL0GOQ9Fz13ZNT/I3mHHsgVQHtenBqlXi6XsMFVdaM0yaOeN+w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62hf0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:41:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514JDKq3016276;
	Tue, 4 Feb 2025 19:41:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsdbjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:41:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514JfImn13501086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 19:41:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 963CB5805D;
	Tue,  4 Feb 2025 19:41:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DCCF58059;
	Tue,  4 Feb 2025 19:41:18 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 19:41:18 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v9 3/9] ARM: dts: aspeed: system1: Add IPMB device
Date: Tue,  4 Feb 2025 13:41:06 -0600
Message-ID: <20250204194115.3899174-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204194115.3899174-1-ninad@linux.ibm.com>
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: f2KqIpIvJv-cO3JFZ_qSlfMcUEbPYTxy
X-Proofpoint-ORIG-GUID: f2KqIpIvJv-cO3JFZ_qSlfMcUEbPYTxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=741 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040143

Add IPMB device sitting behind PCH module

Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 360b9ce3c850..53d0abece02c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -763,6 +763,15 @@ i2c3mux0chn7: i2c@7 {
 
 &i2c4 {
 	status = "okay";
+	multi-master;
+	bus-frequency = <1000000>;
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+
+		i2c-protocol;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


