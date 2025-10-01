Return-Path: <linux-aspeed+bounces-2369-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A993BCCA472
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:45:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccHlT1RdNz3cfL;
	Thu,  2 Oct 2025 00:45:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759329909;
	cv=none; b=N7awWXkR/9adSL3rQEeCqD+0iJonSQqUFivE5+9yOw2VJd0OiqXNYZ/mYrPvDyBu2/hB0rXkKcC4c2FurzYGifIbLx5HSp0Gr6M58ns/u9Z2miDD6ABFAStTwtlxXdBLwXqFTriQWuX77/0dVtVwxghtq3CfLvVL0QEt/8+KarJgDJcyLigEvcbjIIxUAX1VKSeHoZ8m9JUPQpknbGboCVoC/Bc/26yvKH+4bcU7qIrARvsJQYsjDo8bhMk0TCTjel3SKM1sYJXLVg/8rPuj1go7cZ+ujAvF2eEV5bmqrGDdzpHKJytXa/giumAA8gAE4f1qXtIruSSA9X5nYAujrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759329909; c=relaxed/relaxed;
	bh=KtNynSvFVjpudk4TeAKmNfR+UQ5kPia28l4BEDQM4xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbjZzfy27dSz2pNTzRbLnZhDiY16ogLlnUg6TkIFeSQZyRSerpSMzBdGq1AXtO+vBJmRZE8fAqlCrO2sbOJzMfkWyYAsxCgRwoc1gbCySFNzzIEUt0A+qPFTJiRzGpdeFJffUaQUrEjFINb0zykz8vFMehwEwNuTGc8iFx+YNeuzaHq+4OFDZLnFFXAhIU3t2N0RIsR+C/VXbgtHvhnx9gx0lY5RTBikHqlTOctFenz5IcrhP5S3gT86BltFvtXrRsp+iZaKr7xphICdqcgXzIKQnELBBiUMzIC8pksxJh+9B5skyuwaJHtN5CVuoxSs4ELYHPgSHCiT9p9DdQdR2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oy7/xgBf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oy7/xgBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccHlS4LPQz3cdn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:45:08 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CqBhu026144;
	Wed, 1 Oct 2025 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KtNynSvFVjpudk4Te
	AKmNfR+UQ5kPia28l4BEDQM4xU=; b=oy7/xgBfotnRyrKeNl0o3xdXMa5IlOJ8r
	p/v5jvtL02w2Wupq4Vf4BoRyHVVy15eSbt0L5EzSXval9+75hB5DF54RqOob4Yux
	QbgB6aqUgrqR5Z19rDjGhIhZ9PbbZAoa2TgI1k2appidlmXckCkgRlrQjJvUohVw
	07XsEb24qr/bbo1zuA0NBFiWWOBdJ9T2Cud4Qr/naN3ycGeOMgencY2R53pK2KGf
	i3hr3kQflUMckdKzwCvYc8gYbo2PpBFLMF8WsXal/vdNRFV+8NaQ1HlrpE/lhugZ
	Q+dCyZT8g1Qq+90dhsC16SG0cjN1k0YFifw4x+ASs3Yk22v7Cvf8Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7yyxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591DLRSu007313;
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk16y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EimU857868716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A91535805D;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E38C58055;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 2/7] dt-bindings: arm: aspeed: add IBM Bonnell board
Date: Wed,  1 Oct 2025 09:44:36 -0500
Message-ID: <20251001144441.310950-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uAQ83X2FDtryFV6zaca4tRqICdie8eJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX92dmH2WqoCMn
 pAmUtwkqXe7iniXCUU5C8mXka2QoCbC0fA574JDdIQZ0sNTVjfusoSPVg4tL66TYu5L65bIK1ub
 0XlkLM3Qpi7ZU7hLQLoVRfZy1OIUrQimYXzPqlHbrGODEI5StdYcsPG18KwBkPPz1NMr3uvu78t
 //FEPk4wFIj08lnB3GnQfKOMg06sjobV1r38NHxl2I9mCkpYTxOFbgLtYj3SYEgrfNK8clXDSNE
 ie6JQSvRWpa6QszX+WgpLp1y1ZzbSJTijBMwGLH+qOehGjGVYPM2jt/M3Dsio+WAmpURZA3v6ul
 tOM4WtNGGwncblDCBIP3bWn4ECpb6xxYMrQTEhVJ4b5/UuFbScIn0aojG8BWXLr3ti3ief1Fdf7
 6SlZfuV/9Ix/icP75MdswDe6SYcDRg==
X-Proofpoint-GUID: uAQ83X2FDtryFV6zaca4tRqICdie8eJ9
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68dd3e62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3pJJXNp13jenLdaujSYA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Document the existing AST2600 BMC board for IBM P10 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b2fcfcc4a3b9a..9730df98b945a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -95,6 +95,7 @@ properties:
               - facebook,yosemite4-bmc
               - ibm,balcones-bmc
               - ibm,blueridge-bmc
+              - ibm,bonnell-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
-- 
2.51.0


