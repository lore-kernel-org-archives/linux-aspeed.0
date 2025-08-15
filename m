Return-Path: <linux-aspeed+bounces-1977-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD86CA0EEB
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 19:47:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3XhR02TLz3cjm;
	Sat, 16 Aug 2025 05:47:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287270;
	cv=none; b=KdBOz1iivJ184PaurwrV2brRHV5FqwbTCKkBRNsQdcvHEw+SDfP3/7ZTElwaQkm6ORtNcFTuJpfCRVcHxxFkIc07J9Zdajbob+Dl31ZZwE3JfcP34FPZ/jklnjHtS+zDXQXJGA1ZeG9yXfhMcx26oYj4v29o4aeCZt7waNL2h4bt34/KueyoP+3dt75exxAVuHvfoShADc1ocuHKUhkxMe4zfzEIwi/L5vgWcA9fUqQ/GnrVQXxVbTQKjGSqy+s1TzYAuBkQTtP+7k/kI0KIpA48csjWlp2f7znwU4qN0HuW3QV41fY1b5zkDltdmWnRiUASqwvpZTZzCZQPcewsww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287270; c=relaxed/relaxed;
	bh=SgXO4GuP4pM84YqJe+nMDp5l9TIf7+20xqnPvNTPGkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Idw2M/4487k2Hpv65tv59UxYfMGTN/ar5kbbjtSqdh0+ZKSF4+NXz4MQQ9/r6a0daW1cYBwAMN2YK+OIQ3qASpVIiYdUc26E5xYEsD7uyPn9OLKHcOrnhK9lzr5BbpSDZWzOGbsA2O3f+ZJc3OmUqgJ0Caafp1tDpilBy7x4puHIXk4hGRMDMJGLBNv7UAB5vYHACdOmm9r439ERMbp+hjw1hg26BucNzgczh5JdvmnI8imE9Tz+zZVfMti9B5LdAnNEgQf2kTJ9Bof9IlHOMuP2abheEYpXIQSX+Jv1OErG3VulReh8ng1Iaxt5jFrjdeVzz7kBa8TcAgIDLRZS5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CqHLysV2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CqHLysV2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3XhQ1HlQz3cjX
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:49 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHU88M004503;
	Fri, 15 Aug 2025 19:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SgXO4GuP4pM84YqJe
	+nMDp5l9TIf7+20xqnPvNTPGkM=; b=CqHLysV2Tgr316elRbfhXiL7iE5OU1hd9
	XdgXyWw08pfndY6UD9QAO+mQOnZLLI/29xWGIgIs5vQ1YlfZ/WGlnb3KKWKWwY8l
	V1xQYoxUe77PiKsvaEnGMs/MXutRHFibb0TbIoGVksA9HB0qR/e0bIpCkrdBOmzo
	i1zD+HQMChf6zCIEkz0qEPaxKlzV3/Sjq1wfZQBKCuV89kQv3AVhv/ziUw/r3TQ5
	/cv9AzjpbIvXQFbuzxgSa4UfLMX2zaJaqeGp1nWo/sS/AoIX42aGM9vo3R3t46SP
	v5xmsD1dMYuseK5qaPvN3VzR8Sqae3ehwbxMG2h3qA+7iRRqGFSJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaanakf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FG6NOb028629;
	Fri, 15 Aug 2025 19:47:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5njcp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FJlc5f15991544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:47:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE4658059;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6802958064;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from slate16 (unknown [9.61.135.91])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v4 3/4] dt-bindings: hwmon: Move max31785 compatibles to max31790 document
Date: Fri, 15 Aug 2025 14:47:29 -0500
Message-ID: <20250815194730.41695-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194730.41695-1-eajames@linux.ibm.com>
References: <20250815194730.41695-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689f8edc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=brXxiGoeIixPC4QSiM8A:9
 a=RWaeYqt-Cn-VcsFsiLGo:22
X-Proofpoint-ORIG-GUID: IRpreSSmECmEYUfV-ucfL5ArBnLad5A4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX4Jysth3Nmc2k
 VzPVmjDslTztGejOFtjuFb4zwi8x0WNxVKfBUqfdOqhzpdNnTR76xOFXjrL4zabRzsUtSgxVEX4
 rVSLShb1CWN3vxN+QC+ABG95PO+uCbGqrvwK88qLL3kd6fSXc12IF1PoXDJhwDsOqOPaoKsijnV
 QrLZmDQDQG1oCH7K4J8fmraSLETtOutTMTEcGNw4sz/uDSdKwIST16SzWz/Mk9HEObPXjQj9HAC
 sCfnSI/FNABAQ/MrxjqoGvUenFDsFQDIDvQ9NBNUN4HG4iL0HkvE3TDyKs+M/Quo/8+KsYQleoi
 IWAp5YoWrNUElRU/rKcuG4Eh6EmBaB96blofLv0AfSLCD/+99ogWIT7Kj/NifCf7Pfdt607KFii
 /X5AaZwL
X-Proofpoint-GUID: IRpreSSmECmEYUfV-ucfL5ArBnLad5A4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

The binding for the max31785 is the same as the max31790, so just add
some compatible strings for the max31785 chip.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../bindings/hwmon/maxim,max31790.yaml        |  6 ++++-
 2 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
deleted file mode 100644
index 106e08c56aaa..000000000000
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
index b1ff496f87f9..b2dc813b1ab4 100644
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
2.50.1


