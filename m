Return-Path: <linux-aspeed+bounces-515-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF37EC0218A
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:36:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvlg0p4hz3cdy;
	Fri, 17 Jan 2025 07:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059775;
	cv=none; b=He8maLp+cuRUyjqIONNreM00QJYF5aZeMMv3rft71f4tT/i3W2p+q+nlgPDbCNNIN2sTs+IBDBo8evqVB3Bf2UZILTycRyIxQ73AkxL1RExMFz+3HEAGsJyvn2VGhAC1Ekv1f4vFYbzZJ2BQvfOsDTh+IJ/y8tR5Q8rsq5QYvwmo4q8h4eaMKQyXXPPmSLTljJIWO9iAkfo04xbfXaP8v3uEZWtzA/xoUfXg1dtX9z/fkaPCWh+j81CXgmMGrtGQQKhXuiI64Lg5sTxLVXpHWaZe/l8zG9QkLDlLjhl5ajMuqOh+X1VZ1gUxT/095TvCqhYmRWi4maFOe3yajwG/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059775; c=relaxed/relaxed;
	bh=QMbi0p6QzsDqbBe7Zuf2uC7AQIslfGBnquGb7Q0ssVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrB7M1GWloajLoZwZglOLgIE2dxfKV9LE3ISEJ4B7z4OzJ/4STCU0yUMsmbFdWcNjpG3G2UIyY0UGENnzZiqM5T48CzHQcqKXX6fgtGioFdMEKiHuaW2d5Tr1cX+wljXJaQZ8+yXg8RS1fVCIiOeMtHgkKZq0tux1vt6U1DwaABnpkhwO7BG5eamq+ucz0X2JoCLyssyrQtEse1/CP+x+ImM1SxdjhtErW3QuWfvLKkQ0fDdXGXelf/CfZfwJnLestzZ091BxWzSnTVkTwKdq2b6i+bUvlGDkouStLULSv99jiyrxeMfLvGD2dsEhfrXr6ZuOn1pN+5pTEbohKvqlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jJmmKEG0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jJmmKEG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvlf2F1vz3c9l
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:36:13 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBb7fW022769;
	Thu, 16 Jan 2025 20:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QMbi0p6QzsDqbBe7Z
	uf2uC7AQIslfGBnquGb7Q0ssVQ=; b=jJmmKEG0zYCETQ1t424fLPuQNv7bIsl8k
	Gwlz4B6+jZhCuqB5ixvtC4ycQJ5qvHxjAReVDzxsNsu5j+vZc8ccjr8MyZV4u1lJ
	bXthGzSO45l8O9ahZTsTBryxfrcnPtRVAPGxyrh3QPXpkfos09ov8Af6x0GoLvZw
	nGmbstaM5uWGB3jFXhrwLZalMn5Velm4NC40MDUJrz4xQ/Ks9LpLEQSbt0jzbQNt
	6UPRAlgdjnJz3I31py8W6LFCjicNuXrBg0r3GKGZw+8/b54RGDLK9OpjQDoHa2oe
	HZsNjMwYYF6wUWq+YOhVD70gIjkFRFKk8rHKJN0CE7CcL8+RYzQEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub5a0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKQd0P025472;
	Thu, 16 Jan 2025 20:35:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub5a0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GITC4Y001110;
	Thu, 16 Jan 2025 20:35:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k7chx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZd5r32572108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6709C58059;
	Thu, 16 Jan 2025 20:35:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5418F58058;
	Thu, 16 Jan 2025 20:35:38 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:38 +0000 (GMT)
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
Subject: [PATCH v6 06/10] ARM: dts: aspeed: system1: Reduce sgpio speed
Date: Thu, 16 Jan 2025 14:35:21 -0600
Message-ID: <20250116203527.2102742-7-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: B4yN4wMuoKxqRGVVt4_qzXPJ_WwV1oPP
X-Proofpoint-ORIG-GUID: eToGYtnTNmr0TMtLi_rizuPLeMfXx2JD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=495 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160151

Reduce sgpio speed to improve stability with the current PCB layout.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 973169679c8d..ca55a4fb6dff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -401,7 +401,7 @@ &emmc {
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
-	bus-frequency = <1000000>;
+	bus-frequency = <500000>;
 };
 
 &ibt {
-- 
2.43.0


