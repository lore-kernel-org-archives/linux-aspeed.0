Return-Path: <linux-aspeed+bounces-794-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0161C021B4
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Feb 2025 21:00:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzQd20FLDz30WD;
	Fri, 21 Feb 2025 08:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740085205;
	cv=none; b=Nb5L2VC18m6KgzY9sAyUZweqD1ydyME1YkPLxwfXYNvQ5KCFU25ptysGl0CD1F4Qz/K2wO2efv7I974/uzKQAeKwWShUYZb6NEf/DzPuIJX0FCi9qjy+IuifH1tCTalxeLtkHqynWQ2IngwyYpGKyFJzzM7G1rRir98BqYDOyS8cuBqGiDSfvG2u/sMv8WinSETf8MOczkzKZjcOXNC+8zyN85J1u1ILQe2nTh8blUDCRGGkAirhPdn16ONJ2IrjmX4mDEGvVJoI5veJdNX6jsY72eXDxHA5I98phJGYETS3wE13OvGQh4uvKyGamAWLtG4/QrKxWHqR1uQAu3x4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740085205; c=relaxed/relaxed;
	bh=cuFiwwxYOU2KJouJPZ3D03ZvkJfbqog32n8lF5wRZag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+Kyx/6qdPQBlWLNW7LX1VT05alppKnEqrm3r+7EAfsjquqtwQxuBNVglEMpDCsA0uv6sF+V8/n4M6gjeFiErBPhfn6XND91xev3JAza+1QcDm86Wgbc6Mnwz7SW0PUYS1QGEWgHWaI0xE2bNtZLnLUOUeTtFW+DcV4gMeweyZcDhLk0LA0wav1RNg81UgQqozSz9Y+7LQegWrL1vlJ2LbktMp4/TplwaA0CNHibhIS+47rLJP6BMQSzgXZguENfroInaYdRK8znJnH0IdfYYsj2SkWXNAHoJx4a64DZ9ffLQGLSVWI4fzBVA1lAbVggRyKxouQIFZa25qSLnCzwig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hzfoGi1/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hzfoGi1/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzQcz43JDz3089
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 08:00:03 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1eIu007899;
	Thu, 20 Feb 2025 20:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cuFiwwxYOU2KJouJP
	Z3D03ZvkJfbqog32n8lF5wRZag=; b=hzfoGi1/ZaD0EviHYLHOgIhSdR2jlciZi
	9F8nrb5URLq0lrcx9qVF/KpUVC+TdzeloGG9/oWdsTDLSLPYvGW3E5YzddpNqxen
	tjeDRK125/B3gImuprQsvlKdnVJNcg/iZmkLQ7u9Rh1n+9yonrDyql//OSy4tKUE
	OePKr+sc5rZgVJ3W3OpVIefWqdSPNhKOqDlcVE7Waswvn8xHAv30R/BRf2G6FZtw
	AoZSM93AvcFU593j/UkH3OOhDuAjZO8m7Gu1ZqalqN+WQmqVqiVtJgolANZxNpY3
	/FYrgZ5piEZ2kU/cXCu8fKVvQNXJic7lbfU6bG1CzoUVD+SKiv+Eg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5d63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI5lTV005776;
	Thu, 20 Feb 2025 20:59:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xm6rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KKxoAZ852714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 20:59:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD9A65803F;
	Thu, 20 Feb 2025 20:59:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E10A5804E;
	Thu, 20 Feb 2025 20:59:50 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.129.233])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 20:59:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v2 2/3] dt-bindings: hwmon: ucd90320: Add additional compatible strings
Date: Thu, 20 Feb 2025 14:59:47 -0600
Message-ID: <20250220205948.1777200-3-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lUZKpfrjo9V4tQdGjwJBz84n879xGKni
X-Proofpoint-GUID: lUZKpfrjo9V4tQdGjwJBz84n879xGKni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=981
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140

The device driver for the UCD90XXX chips supports several more chips
than just the 90320, so document them.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Add all supported devices

 .../devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
index e8feee38c76c8..3cfcbf6b58f2e 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
@@ -23,7 +23,13 @@ description: |
 properties:
   compatible:
     enum:
+      - ti,ucd90000
+      - ti,ucd90120
+      - ti,ucd90124
+      - ti,ucd90160
       - ti,ucd90320
+      - ti,ucd90910
+      - ti,ucd9090
 
   reg:
     maxItems: 1
-- 
2.43.5


