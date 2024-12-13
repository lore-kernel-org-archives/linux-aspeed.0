Return-Path: <linux-aspeed+bounces-232-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F68E77184
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8sj35xhSz30hC;
	Sat, 14 Dec 2024 01:51:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734101463;
	cv=none; b=XCyd9WBjSoe2mloQX9KCkDRjXqFCy7yFC5CTajs6EtUv7OQc96yrkFDCqfjWYnYODOgkKN1oufdVqHST9Yk6/miksl4Z0dgQHcJPozImBqgrz//iraKjkpIcoKCAa8vdKssotOuGMFDyczX0U8pIhwmyekwxP3+bHQvFTlSx30nckda4WGoOa0NXqnvy1zZ3D00BSv76yHPugdTPoTml/k7kw2ZPIDgGzB1ly3FDim8/5HuTfgLDxwxkJaCssrozsGjLPM9yst6pXN2tDFJdyxt19MFR9v69ybZMpG2ojDiLQrTwIQdmqxtJubrZJiccWNSxO8JmDHT8IPjyhuGwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734101463; c=relaxed/relaxed;
	bh=UocTi7oRN+iOYa+MQvxKvfZM/TJSV5HA8KqxvwB2eoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZhroIOfHn74wXG8Ky6RToyyk9GpyCoHhCMJxeLA/9aPDtw68RYB5Ieik202TKKmhjc6WKPyWu2qkmXF4V4knQN4fEVhasihKz6CF3/obPWTW5rDIJzt7sjS9mpL23rmBpyopa/Z0iU9u0RvmZFAhbMh2M6apgK7Is1feorx5b0ufZCwdDWxlz7iIzFqvj+jZutFGhYFYMkjLp4cqQiEAB5OOeXzxJ4kFAHB93ioIu5X1EHdCaZYOC8Fs+R77oSx+RVyDUnHrADNVJJdMNB2xgEEXWGnppRk5WmAY+UNyuiato+lIEgDpJxZBapth/Zg5fza6YwMD42ejHFVVbXOIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aJjhF4v7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aJjhF4v7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8sj253Ffz3bTs
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 01:51:02 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIutU006394;
	Fri, 13 Dec 2024 14:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UocTi7oRN+iOYa+MQ
	vxKvfZM/TJSV5HA8KqxvwB2eoI=; b=aJjhF4v7Fexfc0jPABeRUTBgaQH3Lpa7m
	RYPsXKVyTVNjhFwokMgw/NPIgLYV3HTByYENNV6SaDWkfIlGroOD5tOr50buyEPa
	v30cIUuOfyWMwEo/r5Z4UHtfjJXL8aDQzg0WdbtSXyVwFbJ1WeJD8BsaYZAvdv/p
	jN44cV1SahpxugaPYNW/6RWR7cXj+dB1/ss/AACmbUmxgMqdcspAJDyuxxieMrfK
	/Zs0OM/z+IUmpn/0hiHhPo1P2y0dMTMQIEpPPpDTs/Y/ulVOP0z9eoSPQK8UrFrg
	Xxr0qh1t9qv+qUtBFBLvArDCbWaNC4KQXsBH+0Uus0TkXjnZalZOA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9nbbg7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBx6KW007781;
	Fri, 13 Dec 2024 14:50:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11ysfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEof9p28902002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F32F258054;
	Fri, 13 Dec 2024 14:50:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7D05805F;
	Fri, 13 Dec 2024 14:50:41 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:41 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 2/8] ARM: dts: aspeed: system1: Add GPIO line name
Date: Fri, 13 Dec 2024 08:50:28 -0600
Message-ID: <20241213145037.3784931-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: EHRW2FeXuzv9kxVR8eFjUwD7fhBMogCV
X-Proofpoint-ORIG-GUID: EHRW2FeXuzv9kxVR8eFjUwD7fhBMogCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=731 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

Add following GPIO line name so that userspace can control them
    - Flash write override
    - pch-reset

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 51a116d7041a..db4b9fb674fe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -370,7 +370,7 @@ &gpio0 {
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","","","","","bmc-ready",
 	/*M0-M7*/	"","","","","","","","",
-	/*N0-N7*/	"fpga-debug-enable","","","","","","","",
+	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","bmc-hb",
 	/*Q0-Q7*/	"","","","","","","pch-ready","",
-- 
2.43.0


