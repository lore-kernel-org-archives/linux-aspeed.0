Return-Path: <linux-aspeed+bounces-793-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E5EC021B2
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Feb 2025 21:00:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzQd16qdPz2yD8;
	Fri, 21 Feb 2025 08:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740085205;
	cv=none; b=A+lWH/naXoUjaKYxp2LDtj6fDM9/KuB4rZhAKTeV6KPh5P6gcXar62SBQKTG84Cx3h4sAEWg0gvYFdHH2xel9EyGVLClwGwaOaKhUPxrMwoQvcCAEir6hNATtc3bROSrirIPhEF2bezdscs6daNobLJRqx+d0b6CsyBI3yXrbi1k9pBdKn/aXbrl4wNFIRHzvp6iA4yfQyS1NTRTOCctTF0f588MKJ3X9trcNXcRwzc0NRCpptbzzf04prv7bTLrW6vLhm0BL8LTv8sDFsKs72vDsRDS/E0D4bBtq9iHZoLWB4+p84wmMHlrUXvyw/Xi0wpzlIsz+a/gXhkPpsk4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740085205; c=relaxed/relaxed;
	bh=9skSuSBhxMS0RphnV1vdpHayKiPUeqSzMe0K0ptk9pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juKQUeiRqHDtkJWWb8UEE/PLYHGT17QKN6U1KMlJvVDT2anTRUtdUz/3FKJj/05NU1UVYygEnWqm1JXGKfs+Gm4G+l/zbkj+rwLuLXQFywo4aaOrpV1AG5oCBvkPgIl3mYA7qDT/d2ANunsIGvta8Q/eJgwxXjdemlcHGwcFznkJEidp6lBxxnsywzlT0KuDu+YH+usA/gfSJukJaycysqABlMiMBkmJ/vvudx9BOaLCkqmNsUZrsnRoytBAVV90xf2RglpwuyIC97UAA8BP1obyFSBgBt8W1KldRf2KszFsJKSv1wyPF21585z7rGCnR+9ghI5zl5B2/6B8g3vB0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nK413YDj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nK413YDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzQcz3HYgz2y92
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 08:00:03 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1i3s014279;
	Thu, 20 Feb 2025 20:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9skSuSBhxMS0RphnV
	1vdpHayKiPUeqSzMe0K0ptk9pI=; b=nK413YDjqLajKFwSM3prQkZUPqyGUEBew
	seymsXWhK7ewqrPtb6tLKksPd1kfUBQR7X+cNj8U43OhOHOfI1pd3qH0WT6EgeZK
	QoSVlY6xCj9VtYBjSXpuhd+cjIKhEJO+cy2FLKWaMPb3mpeVN9VlMH1IZKdpXRQH
	P16RGmtVF0tDCIkz2zw7g8LJnMgpkJmLjORmht34PE/ENIsOgsz/FfsZGW5ofGl+
	SVXsDtGo/e56Kiu1Kf6L0UAlOGm1MsuS+Y3GKjXu+EgM2Te/pVrce6T+3utQ5wW3
	1k3mtO8hozGwFjeC+yWPUtwPTaXv8L+ReuMFwPjyQWrjGzwVh8Gcw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreadx0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KKvA3p030262;
	Thu, 20 Feb 2025 20:59:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xc8kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KKxoSh28836358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 20:59:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 296D158055;
	Thu, 20 Feb 2025 20:59:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACF875804E;
	Thu, 20 Feb 2025 20:59:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.129.233])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 20:59:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v2 1/3] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Thu, 20 Feb 2025 14:59:46 -0600
Message-ID: <20250220205948.1777200-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250220205948.1777200-1-eajames@linux.ibm.com>
References: <20250220205948.1777200-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PAC8lExq7VaedVSsfiDuuHMWQN5b9LzM
X-Proofpoint-GUID: PAC8lExq7VaedVSsfiDuuHMWQN5b9LzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb..e80286ff92cc1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -88,6 +88,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,yosemite4-bmc
+              - ibm,balcones-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.43.5


