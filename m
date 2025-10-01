Return-Path: <linux-aspeed+bounces-2372-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3166CCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:45:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccHlV6r4Cz3cfm;
	Thu,  2 Oct 2025 00:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759329910;
	cv=none; b=bIndTjIVs9+QutiJDYZu9KiCMAhibbHyLRvfoNoZflNdWM9Lpm9R2t9BlF8b2kqxZChNxiIa6rsLIDZipubi2hjucPopB5Jl9DPtAG6lyrURvQIfLoBcAkpK9AQRZCXPKPqHv2q/eFttSwxL4gDJlbB/YDuh7V0y0rfARGicC8Tcg5QHdWusLl0zO8Han9F3zcOF7tn7wK9pyOMD9P4VphOAcyXobpUZW0gM8eskChyaO/BNAaIvof71c9e2ZlBelSvjV+YtXg/cDZGH1kPZ/8aAbWezYXspQvtpbE2LeFEyrF2RDjAqeR0nvKZoj2AFJUont7kb6RlrcOyEeXDpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759329910; c=relaxed/relaxed;
	bh=A9OzHSyflbyykrbW7EYr7qpVvkpsCbwn1hOnR4XSlWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=korQJALVlbL1fwaeWp+5OnaVHkGUmsMzamWgsfswHmcfqMgyXvfnIckQ/r17sb3TGcRDJBlQM697VHY7FCzaXZwdXyv6Ee7kSwFpc1GR57qECFDHnzeLCCD0wJKznn8u8FgS9gW7KSc49NRzZ5w5K7M0y+4kHEYAFGza+ye18YXYP2HuESdcgjZEbMomzheGfqB5Klj3mJGRZ34aZSRr5510rpdYw0SOxoNAL/2EZ26p59/6meuCUulLgsBs25SBwiTjPTRY/mPUcssDRV8ShD7H0dsJNdxtJZQAQvV89MXJpxJ6q2ajNjNNpBdmVWU0UntSm7njQATckL0LKw/U3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eFB9ZP7m; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eFB9ZP7m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccHlT6dLtz3cdn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:45:09 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CwGgn009676;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A9OzHSyflbyykrbW7
	EYr7qpVvkpsCbwn1hOnR4XSlWE=; b=eFB9ZP7mM68RAt+eZPx5GKx9qpH2tPpk2
	YQrgc46zym393uvjLwwV7ZequLR5nci07oJh9+KP9QH+ProowP3NXJSoucr/AAn0
	Cm5Y0m/+8tVBgAsSmJPYv68kMXs50LNhqu08D8Bn8xhsp1eAJO1suCvjkVKzq3PL
	32XVRidE43gmZqHoh29vgvuxnxX3bDudGPBL2ehqdKgVlpvgDgFoRLcTKTc4SLSP
	xZ8hq2e/jc9pxkhAhw9SzvxYpeqE5K5G5QeJSfR1IeEM4DLLNgV2uFZIn7Ok09rh
	R55h7pM5fJfO6zITUcfIr254to2ea4UjEI5p5V7sSD4pV1NdUd5OQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqyjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591CqTM9007321;
	Wed, 1 Oct 2025 14:44:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk16y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EinYK27918996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6572158043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E9758055;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785 compatibles to max31790 document
Date: Wed,  1 Oct 2025 09:44:38 -0500
Message-ID: <20251001144441.310950-5-eajames@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX1VuNlhU9hEhT
 g+GNf/vio3WH1it7r3F28rVtuzwcwjmCTX5H5XuJdpMqKneBqJTdwRoQVYAmsUYNLiB0LHnZlOJ
 dG2+z/NvLOy35wzkXG1gtPSblOPQfIkbHNz6aKjxsvBTROHckhSEziwTqf7YwxjQ2hHzgIGIhDn
 QLUxGYtUHAJdSwJH8QOjp2sVvOf5quh7NcFFl8E5VOAlGo8VWHUjtcULa5ZPkzK1Qb/UIj14eZV
 OyomVNRqSNxXICfSQE5EDiUCDntDsZkm2FCG2nSzD0y5KpSreZ1tn9chdNDU0wjs9kcYrN5arkx
 8FaSiPETjSYfny6oVOqvpopb9fq/AFEAYFw8U4rKzc5JKbxZ/32aFZgpJ4diLh728eMvA0jIeMt
 zQ3OR3OtqE2lACneKtQKk3l+Ouaz0Q==
X-Proofpoint-GUID: UdEteioiqY0HWtV7B5T9id-JXu8TddFE
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dd3e62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=brXxiGoeIixPC4QSiM8A:9 a=RWaeYqt-Cn-VcsFsiLGo:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UdEteioiqY0HWtV7B5T9id-JXu8TddFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

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


