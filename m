Return-Path: <linux-aspeed+bounces-1916-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7FDC87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 18:47:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxzmx32DQz3brH;
	Thu,  7 Aug 2025 04:47:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754506049;
	cv=none; b=SEi8e0Kni8Ycib+9us42QS7xQU4jPae8vfD6aMaRl3fxDbg3EQdo7m/wNjud5ulhRhXN2cMcSgagZSeOcM6y6mDs1ELF7IQh9uZLNVd5wxhQ+X7l0STRUWSAPO7rl/D4Cbv+TLHXPJ8jurPTOmAc8ZVKmexHGe2SLxYNR4X7k0KMKELR3q5S+K2jaIp83iq1Wbu8ZqC08vcg+Czor4ks/Gw0rh6vX/2W6Bw/aqWj2UuRd0FhmZcq/V8N7o93L+VJvor+gL5ZeEohjwnj25D9r8EiwgJP9juZJyLqqc3CG+gZTcDCTPnIn74ntUFS2aRK0htbJYLzNcGzpCQw94vT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754506049; c=relaxed/relaxed;
	bh=pWGHH7b1TqEtjQnDk2nsq0mhjycRDStWpxay+XrGyGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWbrKUdQ58tUQsq+DewkZs+2wtEycVzMlluKnizd3t8BSRlFsvAOA6b35mALjp+OqLqYmCE3C0e0o61i+zQnM+FP5ER07opfBzf8Dl4kDs+jc899JTLQOdVCPa+TuC0FuV8T8xPIDU+Ff9Jpdn/ANVZAiBfbQVRj+I/Xux75gtqUSfN7lzz63Ld4DUmgLG7se7xM3qLIjTY5O/YjKJUi9GjGpSthJ858IMBlh862cLxP6U9mSnHtON9IK/hRDz40/d55HnPqQH1nEzJdwTW+Ke4++JHaJ4VCQ7tqT3JPZwZwRGSuCq1loefFx0CuW5UHgxUlJE/Dkk5GP6Oj5UGrlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cHDqIJzG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cHDqIJzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxzmw2wXZz3bqP
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 04:47:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ElSAL029069;
	Wed, 6 Aug 2025 18:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pWGHH7b1TqEtjQnDk
	2nsq0mhjycRDStWpxay+XrGyGU=; b=cHDqIJzGI9l13TaPzEDf01+dsgUc7Tce1
	FTU2eynrz8ZwOQKp6vef1Gcg1XjZumtI6qISDn6eyCHRzYYO5/15g8Tlc9YjAaSI
	I5PFkp/It/Dbm4w1XZrLIAsqCXY7u5CLg3FLyE72bTxPUg9CH1vOF8bLZ8Eo13zE
	7N92U0h3PESwmL7uvwMt/C2I/3zPB4tbfdQFVXAyZ8H+ePObKuKPkeh16z7Ju6xU
	oKjcbP6z3BpeHf0jcjEpdTtnb67/K28uOyF8RFBAufGNPY0Zon3a2KAQxZt0lNzC
	34jEKWhmKNguRbUPHMBaNovFRR1fLtAVqbUp7bV63G7Pvf0errpiQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60x222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GF4e6022640;
	Wed, 6 Aug 2025 18:47:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqd183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576IlKwF59703566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 18:47:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 196B658060;
	Wed,  6 Aug 2025 18:47:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E740358061;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
Received: from slate16 (unknown [9.61.84.78])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v3 3/4] dt-bindings: trivial-devices: Document max31785 sensors
Date: Wed,  6 Aug 2025 13:47:10 -0500
Message-ID: <20250806184711.1882725-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806184711.1882725-1-eajames@linux.ibm.com>
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
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
X-Proofpoint-GUID: eFsdpKCD6GVMs22vexZf2pwhXptPY3GL
X-Proofpoint-ORIG-GUID: eFsdpKCD6GVMs22vexZf2pwhXptPY3GL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyMSBTYWx0ZWRfX1myDQKTXODVA
 P2IwpdWg1emyzpxMa2t5M9V5H5ATKC7wpqnd0Bz7z9ch4N/+WFOvZYSQs6JCwjIJ9g4GSY6SO5h
 f30MZHdXbbxrkugwnVG4gLW5lqcyCYOWdWlxBMBoQyND7zMmKRtFLCbzPO48OIbGj17asIWP/sV
 oltJxqvm4z6nHAHpf0gDOu9x6QmoAtDs7pHn5BFKFVkp2u7UNPt0f7K2ecg9P/mVOuUr5WcYBK7
 COA2TZOxm0C5Y0XuxSqsvq0K+8ryjVNkXxCRKNLx3ni2wTxbdWj79TxgdmvNEIk6AoLXeWU0bF0
 xIzdyYaI41xyxNIVfbMQwGHH2awrN9gbIGrnGgZAJiQknImHISs8lFzjmTEujXLuO6dWOLPsP6G
 l3bT8YjVzaEOmuk4ePCq4Alq2wh0le5U+aqPYvFkiE9rpvVmdSUb62UgOjHtS+r8tbQqyXVf
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6893a33a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=jtbBNqsHAAAA:8 a=VnNF1IyMAAAA:8 a=brXxiGoeIixPC4QSiM8A:9
 a=RWaeYqt-Cn-VcsFsiLGo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060121

Remove the old .txt max31785 documentation and add the compatibles
to trivial-devices.yaml.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  4 ++++
 2 files changed, 4 insertions(+), 22 deletions(-)
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
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 3f2c5b815d0d..72ee7bad36fc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -201,6 +201,10 @@ properties:
           - maxim,max15303
             # Multiphase Master with PMBus Interface and Internal Buck Converter
           - maxim,max20751
+            # 6-Channel PWM fan controller
+          - maxim,max31785
+          - maxim,max31785a
+          - maxim,max31785b
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
             # mCube 3-axis 8-bit digital accelerometer
-- 
2.50.1


