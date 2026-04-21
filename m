Return-Path: <linux-aspeed+bounces-3946-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C949F94CB3
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 22:46:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0csW2hk1z2yxk;
	Wed, 22 Apr 2026 08:46:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776811583;
	cv=none; b=aXxKQgWIccUtZlKh0tn15JLxoW6g6Q0KwemVKYhdSHg4kJyVo7uT4+80CWrP42CcKosqw/C3WjjAinpKHgIAn1FGZwp4HF5SVtdyYTxkWCgVaetPRBG+RPDzoVDXTpVZn4afkpcxdeUHmF8PUSsEYb5mNQZpkfn7cg3t/QkMGB5dzl3NP1YbDlfkdjW5fcnzwiE9hP9uaSGpDxFDQlc/kvE9RZvw6+CrxqmsEksU+8sCghvY/czhX1DtqN62eegZwpueDoWk9LDt/423pURUsw48pbboTqp5JLuVEQt84re4QJ//GQtiT26kfHoNFfV/GjtjP1Uzth8HmpUd4MXiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776811583; c=relaxed/relaxed;
	bh=DDWz+P6GH5r8rHmoXevBBS4CqD5JryiS1r07nfz5lJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMTmUQ6/2pj16TpH/rk66PGlrI4Bke/2LnV+LzhoVYFPUU0VexGgPKAVfpr5mpltDcwhkyVLvWSw+dDPG9Z8MVdGo5d7IPM/PqyMsVkGXuqA6u3pZLHUxot+b67GXGgm9UpyNG2UwyL+wjyMZtio6mHUmoPkLapjykEOZL82SGzd0WXYJ0OvEF+DhEW6emIBBW1W/I2hpz+wHbR955lRmFsDZv4IY8ydmjOwnjVOgye6BLN+emK3gBlIpKxLrBhGZU10GaUhZ9/kif58DiJN7GuBkQ+SyGWIPMT/jh8sCc+wrI9ESrLxfXrds8vKXYM6TxiNFjDb/MYbW4w2vBZfRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qMDTQkwr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qMDTQkwr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0csT5wGxz30Gm
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Apr 2026 08:46:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LImN8L177198;
	Tue, 21 Apr 2026 22:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DDWz+P6GH5r8rHmoX
	evBBS4CqD5JryiS1r07nfz5lJY=; b=qMDTQkwr03Jici3f50aRYn0V9hqXPJhNz
	mSzfWkSOQ6ucu4ljnGLmTnDRnesEslyL+a1cLoSefOSKUyrbVCmn8afe1BoPTAJN
	iBU+QHcWAQt1lSaG3TSSkrx26fDNWCJwOpcw6b38h5j2ub1rZjRvJ9hryrR1Lv0b
	ial/vywow7bJwdPvuiNA096v+iEeTw4RsCPtVOU/qDu6ZhmHcPC3lcVwaX6jKooA
	YZRbTsi3skhgsLf0lUDkHyC00Cuar5ipmjk8H+dG6SDvAsRLGpKrO9PyEGfqJtZX
	Zyuz8gIlV2mCCpwKZktbKTcuyJs0iWTPfL6NQ2cGaP1A6vxz/0URg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu68pcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 22:46:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LMZIdg026427;
	Tue, 21 Apr 2026 22:46:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k2kvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 22:46:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LMk0LA62456090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 22:46:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5BC58055;
	Tue, 21 Apr 2026 22:45:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 417415805D;
	Tue, 21 Apr 2026 22:45:59 +0000 (GMT)
Received: from pfw153.pfw.tadn.ibm.com (unknown [9.5.7.52])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 22:45:59 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: eajames@linux.ibm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Manojkiran Eda <manojkiran.eda@gmail.com>, ninad@linux.ibm.com
Subject: [PATCH v1 2/7] ARM: dts: aspeed: system1: Enable video engine
Date: Tue, 21 Apr 2026 17:45:39 -0500
Message-ID: <20260421224551.1611818-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421224551.1611818-1-ninad@linux.ibm.com>
References: <20260421224551.1611818-1-ninad@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyMiBTYWx0ZWRfXz63q7SEIVUvu
 ZgpuXMz0ATcqY+Njhinywkwp/HQpWfE87cvF+CS7qo8RKHnScmPFvfztf6CovvxZUjanraazxxu
 fwn0R276go1dK9gytsbiaZ1O8jJtaPBd/kIduKj4vSxL+BAWMP/pMQp0KARvtMQrkY4Yoj1CUY/
 aJn1FIlFHkIDqmyeRlWN9wnj6tP9wChT9Qb4XzU7dZV99FQwwLp7kI+MfAn6baPMdc397FXH4YU
 Yq4LoPTaBboYUQm3nPiW3Aa2+OtliHrn+puw3iHhxJU8C4z+zl4ZbE8nQb+0ateOMzQhW8C5zOb
 8NUjkZ1CwFyz1h5qm6gcrzo7wiGto1V/gsDCBFkc8IQXg82lIU8+UxVI8bg1AtqT1z+xuFD/+kH
 O0RYFbx/6Tuup/uCOdMk1UDEE93+hKx11ueE87mYEDDrcwO4no8ouUoQdYBtx3B9i4rHjiL22a6
 +233rgq/j3XrH/SjWFw==
X-Proofpoint-ORIG-GUID: 7UHNpH-fZV6Ra7jx-Cs5cveJSOOnkz8H
X-Proofpoint-GUID: iFhVbWu8b3FQJfxzSl7thmXDwlSG4DVD
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e7fe2a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=fhILFVcUSx_aPX8XqTsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210222

From: Manojkiran Eda <manojkiran.eda@gmail.com>

This patch enables the aspeed video engine support in ASPEED BMC for
IBM System1. It is crucial for facilitating the BMC's video capture
and redirection capabilities, which are integral to remote management
and KVM (Keyboard-Video-Mouse) over IP functionality.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 488d0b3916a1..0ca799893791 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -531,6 +531,10 @@ &lpc_snoop {
 	snoop-ports = <0x80>, <0x81>;
 };
 
+&video {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.51.0


