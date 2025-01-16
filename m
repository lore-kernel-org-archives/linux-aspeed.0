Return-Path: <linux-aspeed+bounces-516-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC290C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:36:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvlg3CQHz3c9l;
	Fri, 17 Jan 2025 07:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059775;
	cv=none; b=JMap2l+j/O5pNk4W/NOT0MgnLRy6icuSdGnWOJEKDckHTCzbo2cV2B5MyzLuGbvB9nsfXkhtgAdVxU5DFAE7xI6FghhQcIv+ogBWF2gbMU+9UHLf/n63BRY/TAjvADrwBqx0zkaS+AVrlI1nzCC5AmnvQ48fHmu8xc1aLBPNXQ+yWX7QN8oQQ4aCp7YiMGunDR4di4kODx14GzfUXmBZQtL84bAYPPGaMzPiXIM1YYN4lXtUvCdSEPQy/o7Vxbv4cmZoM9qcd3GAAFidGg2RooeCQba1/n9crJaDyDYiGJaXyTT1tNzsnvXzVmg+0ZPPorpMm6k6qEga+jd9U2+tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059775; c=relaxed/relaxed;
	bh=kvT1XISWemI7eWoTeyROmYKlBgLHtamPdwfYh7kIPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E04iWiV9G8kErDAn2zX49TT8xjnetBQuC6CLXlH0upguurEds9UblvgYMKCSv4GFuEdcXQFv4i4lhHcHfeMhCtzkMNvlzP7gO926yCEp7gzlh5dKRi6i/t9DISCWHkEgpQDnCiBjstyDyhMTvmrbIRLYFcmL0hiqGbgugtpTikihUlslU3KbMEY1uqKeCo9ho9uX1SJhmb7oo9xmLh0N19A6hwp8FkhwtAbVahD2Zfr877ojHZYiwYL4wmCGU3AzfaqTbQ4ZbbAD7YbvJuty2Qde02OubE5as4bIFR+Omgpf0p0HzgTeWCN0s+ZMXesRPZfPJbz36kVehReGRV3/MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PHFrdcLw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PHFrdcLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvlf5SrCz3cds
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:36:14 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE6INH024043;
	Thu, 16 Jan 2025 20:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kvT1XISWemI7eWoTe
	yROmYKlBgLHtamPdwfYh7kIPQI=; b=PHFrdcLwwbZBPIh+iGJZGADgBpq1dCc3k
	cAB2UUMJEP0QXCOfoBs6A47n8sWizDhPu/KCeuvMQIgDbdC67D1AkoOnPVq6DSvj
	lghC0o9MiJMNLttZMM5pk4F+v2YOxpPwBUMwuoeAci0R6NfWuFsq2PJ7S+iDNBYc
	+Si0LXEHq+WUSHajrR6223VXcAxCNpWOjbEuAb8Oho9IjPVTvjWdIE5FY0S3AmU9
	fJqqbOIHgNEfICq6vNff8uZSST2n+JFXH7CPvF+iEpd+KzRewdQ9xDmVvYd/2K9H
	ZpxLFhwMZzIWLLvxzsKNM1sfbCHXGp9lKjkyh4cj3qXalFsGouTqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k59uqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKVPeJ006726;
	Thu, 16 Jan 2025 20:35:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k59uqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GJBLel016498;
	Thu, 16 Jan 2025 20:35:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1y8q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZc7117236480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3955058059;
	Thu, 16 Jan 2025 20:35:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2646D58058;
	Thu, 16 Jan 2025 20:35:37 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:37 +0000 (GMT)
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
Subject: [PATCH v6 05/10] ARM: dts: aspeed: system1: Add GPIO line name
Date: Thu, 16 Jan 2025 14:35:20 -0600
Message-ID: <20250116203527.2102742-6-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: Eexmlvb7BlN6uZO2R1ESE6OHFwcSoJSf
X-Proofpoint-ORIG-GUID: GZa-wGIZvTFXMjCzUOrTKRnPRxjk16dF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=717 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160151

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


