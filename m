Return-Path: <linux-aspeed+bounces-639-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A6DC02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMc2z2mz2yXd;
	Wed,  5 Feb 2025 05:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694652;
	cv=none; b=PoMCEoMFb+C0emlRuFg6CgycNqnmB8/aNqztRe3Rcxm9JlVouNc4UMijl4UJyRtPinWuA6TgwX7vSeM3TkNicH3e00xIQRPow4uYFtwCXgCcQPn/4mGb2o/r382+k++rp9/l5n3e0G8Lc+q2FnfNJJwQigXUdTd4wNTf4mOx1YoRpAoeKgYwffiTG1Z66s6Ms3VtAoU+m5qIqXR8mtGOSdGU3RqgziHObkMV9dgG7cz2v/m/CBYCF2UfFovZABcafwn7vfsvK/mAasDi3Amd3/11RKAPciujQGL6dmY3+eearYTDbsGsUmloG6zjJ7MBU8QYGC8f+aIH7uIr+q/2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694652; c=relaxed/relaxed;
	bh=MbUuesV7B/Hl/l+uRNAZvT3az2VOWPemnWYXP7QjbFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fS/bLdaGdYNe2abJtYF6OlmreW2T+XKmhJc1Ig4GYC7yH/Oe5zMLNjiny8ZBKu1d1k3twfyEvCjfinMhsoMhkYPaM5UDa6fxntULgD/DZ60s2Pk+EmOtFayZ64pkvx5G3V6U4B7MgjgisGeQiYjXfaW1u3umWcCK94TYMOtXgMnEmeBzoiuZ0wtfdQ8DY062tpO8sN0lt0hnLQ2sz96AswBHWjIbkxAmRYhyiAH28rJSsewdajb1Zlt53zgia9Vz+vXEgwn2n+BeiKm5QcNv64hdZI9TTubWzyBxzwM3fO0apBIWWM38+gXcnhNUqGSQewaXtJUxwMPpXctlHxiRuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T0ASFqi2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T0ASFqi2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMb2JFyz2ytT
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:10 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GF2N1023992;
	Tue, 4 Feb 2025 18:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MbUuesV7B/Hl/l+uR
	NAZvT3az2VOWPemnWYXP7QjbFY=; b=T0ASFqi2vmq+5EKbyZXOLNNjD7/Rc2EO7
	LSJDcJ842dy0z+Jfuv1bqiPbfyN6GcuLy/5cwI/oQVuodGrmQXQvq/jjYtVCVhT9
	jMJln6O7x3FCItK5P/PpI1OaBqZepAPTppyoKR47eL3dnkveC8fC4qOS6mbu1Wm1
	WhimzaIqyheen4k1BJPlYEHPrP9+FoHimApYRjbbAhkoNeQNkk1rz86JcrF2H16+
	DO19hQKB1vfm87joQAZq+rA/IjeYDqiR7CEgomYzjbxNmRo0d/KIo35+6Sdz8qA4
	D6bAjjVueuxiBmCu3DnzTg+/F883EWg0LFwPPH66z1G9ow8spaRIA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62h6gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514HcvDZ021477;
	Tue, 4 Feb 2025 18:43:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1cm0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Ihi3U28377654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 320C358058;
	Tue,  4 Feb 2025 18:43:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322D158059;
	Tue,  4 Feb 2025 18:43:43 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:43 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 3/9] ARM: dts: aspeed: system1: Add IPMB device
Date: Tue,  4 Feb 2025 12:43:29 -0600
Message-ID: <20250204184337.3896834-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204184337.3896834-1-ninad@linux.ibm.com>
References: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: zX__D1y23W2WH65VpvXGv7-CqEu1kyjP
X-Proofpoint-ORIG-GUID: zX__D1y23W2WH65VpvXGv7-CqEu1kyjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=741 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

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


