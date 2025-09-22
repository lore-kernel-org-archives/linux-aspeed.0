Return-Path: <linux-aspeed+bounces-2316-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349E0CAC5AD
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 17:58:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVrSY6wy0z2yr1;
	Tue, 23 Sep 2025 03:58:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758563901;
	cv=none; b=K/ywR6PQrJiHQxWwLM1HPLVmZuJXghXo2U0yOXNjFhFpAfQ7GJFIxd10kM4ehDPgWT6R5CvtWy4GeyuzJhyEeFRMHy8Zp8uZ1Rm3BKepj6yxQEYDwdn1inx1hv0oTj42E4MctpD3eVz6qTpdagY6aFtDeL3d3b3YnMzNkLooP0MGYrrKeL13UBJvzZLbjrMc+MXQZ+Y/hMGntLAnIDTYg6V0r847e8iTZNv5yy2E4M02yuaDo3DnwFYWlh7BnA4VYWbUbXM8XgnVdveiJsL1Q0lbcwMiJ4CWdzcIiUjMdhp5mDKvxs8l6uyuNlo6w6D7ZUk9gKYEN/8NJr+Zd+KTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758563901; c=relaxed/relaxed;
	bh=A9OzHSyflbyykrbW7EYr7qpVvkpsCbwn1hOnR4XSlWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3DEWdO99W5SE2vhhsd3+ieZQ1vzibhY3eNzTBNxWoP3ouPLId+7yLBhzkLSwiP4bPEFNlr6y9uCgnOS/GSgLaSpF6CcZv0B8sX4w5UvY3BIfjeBLBBwkyABOx7AAUna7dqPUbTUCx9Wqn56nsIJ5FXMtrAZgzMzt36IQhL06lPXD3rlP+u+M1RA2GXulwTGo+fIzh326k4PEiGbzyvL+E5XgpAlcE80AfD6OnG1hoBtbEis+pAFUb7GHmdHWj71sudtJYkEOiyiBcuAz7yqXL+6hI1TY5nUfdyI4+Ku7QzAk/HQV4nM2Ba9E0XgXSOn97OGgBHMulkhQ/eNuhsjFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F2kfSTUN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F2kfSTUN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVrSX6y67z2yrQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 03:58:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MA2RSr001792;
	Mon, 22 Sep 2025 17:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A9OzHSyflbyykrbW7
	EYr7qpVvkpsCbwn1hOnR4XSlWE=; b=F2kfSTUNuJjUwTznwsmjzq6kH8FBz/Lcr
	eMP1kH8iWZhz4VWUZevnB5WosQjANYMHJ/pOuYS9AXVvjrKk373kxTRGYIh1ABei
	zHu0xNw9KcG0bjphCpuCiCweXdLnoREfTuEVFH5MmWQysKBYfD8nujhh+hLIuhX9
	WtbcDtJd7inaSSR5zXzA9pek3WpM3Hx+WyxHWraVsF1LPLr9GXZQk4R6umcct4rG
	w5mOILSBsxDLPEpF4gi60hZCEzE8oOXn96uOXLBhzHqhy8r4cqwUw6vRmDn2oDgC
	Q0Ukkt2VbDt7QWwduE7tfnwWRMIBXObKEwEG/vdppFFMO/WlyPvHw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbmkv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MFqNhl008826;
	Mon, 22 Sep 2025 17:58:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxqh0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHw2LI41615822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:58:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47A1A58059;
	Mon, 22 Sep 2025 17:58:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D244158058;
	Mon, 22 Sep 2025 17:58:12 +0000 (GMT)
Received: from slate16 (unknown [9.61.160.40])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:58:12 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 4/7] dt-bindings: hwmon: Move max31785 compatibles to max31790 document
Date: Mon, 22 Sep 2025 12:58:01 -0500
Message-ID: <20250922175804.31679-5-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: z8WySIgRpz1WfRr9ck_x1Cy1gXTeukHQ
X-Proofpoint-GUID: z8WySIgRpz1WfRr9ck_x1Cy1gXTeukHQ
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d18e37 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=brXxiGoeIixPC4QSiM8A:9 a=RWaeYqt-Cn-VcsFsiLGo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXzFjC0wvao3ou
 fWe9s1e46TAvy42aU4SPtu17IsZGgPqn2HIF3w9eLvHllsZBagdnJ/XLYnKJsIUk8B55qsZsNbJ
 Mi3bznDi9WtUr/g8RqHvStitenkQ+1vz5kQHbWTV5qecMKRdJgCMIzBEMSS0d8aOZnQ4fJb+7iG
 c0znCh58pcBDZtLvBYYLFh+4uVRyc6JPfIpQ0iII0kW/Dr7wq2qnPhy0c7d69Z1rXzziLdiYiPk
 +oIH/ji1jKqrW5Yufg1K4BkjGOTzM26xA2OP6lRTry1jKiDWFuqi9p9bldD87Hx2NxiL5AbBRy8
 QucpNq+OPhG/zfQHbW8P6/D93QnTDh395yBJyqw+X3YQ1I6Z6XXNnqwNzI7f+GQcThgPmM0Nm00
 PuQ07VEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

The binding for the max31785 is the same as the max31790, so just add
some compatible strings for the max31785 chip.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../bindings/hwmon/maxim,max31790.yaml        |  6 ++++-
 2 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
deleted file mode 100644
index 106e08c56aaa9..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/max31785.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Bindings for the Maxim MAX31785 Intelligent Fan Controller
-==========================================================
-
-Reference:
-
-https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
-
-The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channel fan
-management with temperature and remote voltage sensing. Various fan control
-features are provided, including PWM frequency control, temperature hysteresis,
-dual tachometer measurements, and fan health monitoring.
-
-Required properties:
-- compatible     : One of "maxim,max31785" or "maxim,max31785a"
-- reg            : I2C address, one of 0x52, 0x53, 0x54, 0x55.
-
-Example:
-
-        fans@52 {
-                compatible = "maxim,max31785";
-                reg = <0x52>;
-        };
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b1ff496f87f95..b2dc813b1ab44 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -20,7 +20,11 @@ description: >
 
 properties:
   compatible:
-    const: maxim,max31790
+    enum:
+      - maxim,max31785
+      - maxim,max31785a
+      - maxim,max31785b
+      - maxim,max31790
 
   reg:
     maxItems: 1
-- 
2.51.0


