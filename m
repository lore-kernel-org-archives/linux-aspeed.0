Return-Path: <linux-aspeed+bounces-475-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DFC02183
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 22:02:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXjmC32ccz3bN8;
	Wed, 15 Jan 2025 09:02:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736892155;
	cv=none; b=IcJVGmdxdQ3cjVRWMHDDz8HCnh3+0DpSc9FV2eWWx4W92LzR4VCCraLR9YwTcmpDbu1NrkNErf/0tBXpGLDXI5d614YtKzNcxuLHOkq1B7/oduOtWjvwCdPDQSYdAi54x3S9kyoRLx+cfDcBi3mgFZQw3CNGSpFdBeVp+eGoqgNK2PNg3oNZYYusiTZko8Y4jyloxO3kA+ZZeJ10ikOIr1wThYOVIoPqn3O4UQLDzMfgWIhaT5bzu/SjyiCcgG9l3fIGPEMW7YJyy56Wy3Bg+nMnleGVUgi5UwS+T43ybo/m38berbQ7yK/u9a4hfr/wCRFru7fvXbZIVmK6DU8hYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736892155; c=relaxed/relaxed;
	bh=kvT1XISWemI7eWoTeyROmYKlBgLHtamPdwfYh7kIPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpQcgO8XyUrIAvz+a4LvpcZk95u5JjYsoBWmvdwJQQw298hM92W7AQ21bxx04gdQC4HDqA3rij37NEQ8pySKrNL/RsDOkKqU9yJ14ocFxaa1CvqGcz2R62RBUvhPuFTBI6oq68rG54BDt6YU2NkuT8B8+9lgzcDNrN3f7mmDjZ5WWI6Rd+YtYo4JHCUaS5P4AnT1WR+72Xli/z9AJ38X4XPnHoealu6Ct7mpuJGk2QmryltJ91pCR/Di+K2QhCJW0r3T8Us5/DNwO++WhRtUrGFWyNlnZCT8BqyM6lUG9KA6W76QedAuKSQlP7B2kP4Y7qXzWEnRecsXYwJ3UHF9Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VcKAV7mn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VcKAV7mn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXjmB1BPdz30j0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 09:02:33 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EClxMW029143;
	Tue, 14 Jan 2025 22:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kvT1XISWemI7eWoTe
	yROmYKlBgLHtamPdwfYh7kIPQI=; b=VcKAV7mng3f4FRKBTOaeKmdJ6y2pqVEdo
	hW1Ef8EelcvAxpMD6blqPG+v4W0xpHb7v2wodtq0mzMYax+auAPshl9HAD3LV0mx
	jqMfQ/Kv7v3ap7yOQVeaylrxnDOqSY8c7CY+x7/VsU4ukA0WZBvIOpEm5CQgqGbk
	UfcTNjSdwHhqd6a+pa9hSHSl+fNNxD++1koo78zEtVDRcYUIOqVqn8W/ctfLzHe5
	m2qw5MiKegoF0YwmCTjK9US3f9exGe2YEeYGIe7naL4a8uQwKwIMhg7mDhlgXcej
	JI9U1ICj+PaPChmenKi1yqEvGY70Dbsh8NqsrPzrcbuydIL7CKCgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb4y8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50ELvFHm013472;
	Tue, 14 Jan 2025 22:01:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb4y8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELHmIw002734;
	Tue, 14 Jan 2025 22:01:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by5dj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EM1pQJ13238874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 22:01:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353365805D;
	Tue, 14 Jan 2025 22:01:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A5D5805F;
	Tue, 14 Jan 2025 22:01:50 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 22:01:50 +0000 (GMT)
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
Subject: [PATCH v5 05/10] ARM: dts: aspeed: system1: Add GPIO line name
Date: Tue, 14 Jan 2025 16:01:39 -0600
Message-ID: <20250114220147.757075-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114220147.757075-1-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: i06E3VT6US5i_cBUUY4GI9y965_73AMM
X-Proofpoint-GUID: pkP5LmZoVsdNYoo5vwWMTKY97bEVmui0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=720 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166

Add following GPIO line name so that userspace can control them
    - Flash write override
    - pch-reset

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 0d16987cfc80..973169679c8d 100644
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


