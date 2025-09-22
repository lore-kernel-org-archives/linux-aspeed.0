Return-Path: <linux-aspeed+bounces-2320-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836D7CA100F
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 17:58:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVrSh1Yt1z2xPw;
	Tue, 23 Sep 2025 03:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758563908;
	cv=none; b=UQAGPz1k/Gs1ZMun4QRHmuxKLP1ojOn+N1LyyTuZiz4N7ZiS9IPtLk4rLBkz8//BMBL6sIfdemFTVKCEpKsM61wvZVk9vZ5s0y+d+wXDPD4jyWQ4osG2p7PMnz4R1XHEGmY2t48QrB+3ZPTLPuAAQMh7gVB3ZmjColrMlS0th60YLwFCsFiZnD8RsVdmtyfzfQDxAyHVMgU0PAUSBxc5p0oRdJNSpyei1viWSmONFiC40eoW6t0S84lfGCEhj+m4z6vtKlLlX6XVwBigpwcWEa1ATG43mAqfpqzlmNargIMo2Ct4oBRXiEOzbBJ4wQF9ITpmlIPnFTz8tldLfFQx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758563908; c=relaxed/relaxed;
	bh=KtNynSvFVjpudk4TeAKmNfR+UQ5kPia28l4BEDQM4xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBsBXBylmDrrERVggDu4fkDh4S+mPqWssvvzkoAuFZOT7V1yBJ2kg1Vk7jF2HyoiadV6NDyn1o2+nagjyGf5vlp3bs7NCy7jk6wTi3Hy7Otg4P0RoG1nK4hW8y0jOoYW9nbXQLS6M1wiBP+Ql00zYHIcOoRypYdWdS6ClWTLm44vcP2fnTk1NXRK95Xnr/cAQrEU945zCZAAZGtHxYlygVGtghXO4P3v+6ZFw+pIyU1yzV6qG9ui3tGqik2UXUoCZ64HEajqWsndgebrL9EVvNj0c0bLyzULMTvsT9b671e6BEvii5VjxLCBgX0YCOEEoPCsOrVB6ZlffvfZB6MoLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R7Mq/hiR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R7Mq/hiR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVrSg3CrSz30HB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 03:58:27 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGOQTp030517;
	Mon, 22 Sep 2025 17:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KtNynSvFVjpudk4Te
	AKmNfR+UQ5kPia28l4BEDQM4xU=; b=R7Mq/hiRNAWCZSH1MkCPhOcpun35GjD+w
	WgI7ci+Kega4jp0BYI5ZKAsiKukEcJ0rajboX+QeWNv3vV2yO4L3s12zzin7bZ1l
	EDtU0XmkgFR8c72fIJc4LW/AqDBah//H6/tRYkUgsZT8acSjxme+XzXjUUjPuyBZ
	8xa9bUlBg61mpEXMqLUGfZlHY/Ebm0vKxfGGZ4Q87ptoNT32RuWCZgzqU/eTRjVU
	nRPRR/DlQ1hWVek+EWFG6FdYHB6fZz6ZzWrhlTFqRs7rSK5frdeTvHF1tvOvEp57
	bYfmZWDRMh/V01JZyOqa5OGDIxB2Af+HsB7l6f09QcHooUIhNiI1A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyc185-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGlNHi020197;
	Mon, 22 Sep 2025 17:58:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83jy9hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHwCr312976654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:58:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DE155805C;
	Mon, 22 Sep 2025 17:58:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEDC758058;
	Mon, 22 Sep 2025 17:58:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.160.40])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:58:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 2/7] dt-bindings: arm: aspeed: add IBM Bonnell board
Date: Mon, 22 Sep 2025 12:57:59 -0500
Message-ID: <20250922175804.31679-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922175804.31679-1-eajames@linux.ibm.com>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d18e35 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3pJJXNp13jenLdaujSYA:9
X-Proofpoint-GUID: cc4u8cekI3HlVkBNK0yYlAxIqUshS6yi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX+d61AHEdIuV/
 wgmbemiRhL8I2smtQz7PfJo3ld5SxJY6OC+bi0+HNoDyXto80p81aSBMvtkY0KQ1BGgueEwwpsX
 tex8yZR8Nke7BSOdxMLa7xXUYEP/1suryJiPn5h9MutYKpvKhj1RaQT2LwJTdWys/Ybz7DBgVto
 RHYcm/xc2/DIetavWFfITrHXVoeLVqfT//Emz3e/vMTPoZuywsmTuNnOAQeMhVUJX5Dpgd+W5xo
 2brUbU7dLxle4Pd3WJAjXmnyR6AWi6zyWIQDsV15XqKMUWggq1Pw7c2oCe4yNVfXrLzFGBFtVoy
 INFHy2kXDQGqFS+kVCfYbKNFFgW28yd8vKonYNfWD2vOlYWDmGPPSGccRFFwryo7tKPVsjWot/R
 uixxBwYE
X-Proofpoint-ORIG-GUID: cc4u8cekI3HlVkBNK0yYlAxIqUshS6yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

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


