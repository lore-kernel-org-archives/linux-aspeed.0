Return-Path: <linux-aspeed+bounces-2256-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3630CCAC59D
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 14:42:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRhM11B6Tz2ytV;
	Thu, 18 Sep 2025 00:42:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758120157;
	cv=none; b=P7vRCbCsv17eVhW5I46ggijU5y5vFZsMdf+btlZ+Z6Eji+F119qXVUeioCOKWVSb6b5r3WBrzAFU83kxof3hX3U9zxzIUjJkqDX2S3CgytcupXRGWSVIlHNC08a/ihTeSqhwDHnS3QKqSEL5mK7PUTElPwFr6ORW9h1t6EaqLTkjcnsAWJmhI6wLuR2hTbQC7WF7U8MdMCpBb3j5uC5HFtt9nLu1NyVSn4nUqsPBVGx0Cv7r546IavzfA807eT6fu4hVErbBF61Ebccn0vix0ihv5cQgNK8BEssYGAAlSTekJPynJwrhnT/HgcN5e7NeLFYKR2smze5dx80UDbHvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758120157; c=relaxed/relaxed;
	bh=fKQHoEdqmTYzXWRVEjT0fGwKwqjwdeU+SYVf4y0yRLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcrO9wQeUDNC17T20EtqpvXRD+RlilHOlAF25yRCzO3QY/XZLFOPJhIfpSJU6u9v0X2KmOeWqU/j+qMz/tmDFmHKlMJruJXBFhQXCBQrymUYAxbYET5vJrYa5HJFGg1beSNAmVwdyBrKqBlsQkg4GsqJWFS+uSoTahFh0qGk/5l7IWhSPWNu6cMCW9N7+NA2NWKZl/e2XmJtTp8ZnLu4imOdPrvZcvQsCrc59wPlVauwFUqULVRjpty/WHfXdTT/hKZ8ZrSx7YS+w/en8efcfc6STeEw/eTx9kknv7LXBk3BxS8K9ZNN6uWKYQtMzAp0sgAWOTj9k/5bfDwZlwjQPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KvyhR1Fw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KvyhR1Fw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRhM02ZpSz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 00:42:36 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HADA4x023751;
	Wed, 17 Sep 2025 14:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fKQHoEdqmTYzXWRVE
	jT0fGwKwqjwdeU+SYVf4y0yRLU=; b=KvyhR1FwcbiIiZqZB/YrhjSYD8HaZmRaP
	rKgJzJVTF7dGuqAUo4pAtbU1LwZlY9c/EdYHI6FrArhQpUSJsjt2e/YYyoExHVzn
	Ek5epnT0DIc2Fd0sc1t2CZvmnUrL1gqI1+NYhMq/RSgbQaCcnifCjLczgNOcV2qZ
	BIm2bhR+7VWCd1mUOH8QkUfUnXrNv5fAST3XXOzIMIPZv9/HYzxkOdxol2ap6Ssj
	7QWYV/0MPspyUMG6Pnv9uUCf7U2jSp7WY+yILDcm/sAVPxuVIcC0am5Cb7ZRFRTn
	qHDEskxCGpFby99vwdUtjl8VkZg4UELRl1R1N3kXOybf9rG7Qev9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qm45n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBUPoN019200;
	Wed, 17 Sep 2025 14:42:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mhj41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEgLHw14877270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:42:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 682B358059;
	Wed, 17 Sep 2025 14:42:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9896158043;
	Wed, 17 Sep 2025 14:42:20 +0000 (GMT)
Received: from slate16 (unknown [9.61.98.41])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:42:20 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v5 2/6] dt-bindings: arm: aspeed: add IBM Bonnell board
Date: Wed, 17 Sep 2025 09:42:06 -0500
Message-ID: <20250917144210.160051-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917144210.160051-1-eajames@linux.ibm.com>
References: <20250917144210.160051-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: u0zsiJrciuar9u1HQ9geWzuVT-Z1WPjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXxByER1RLbKjU
 24otUztNj3QIucmHw8C8cW3usa8N108Dz9dViIqe61pGRhxIFVPSJTrVz9GoSN4Fm7PnVUSknwC
 NFCyWNDhfgzoUm46Xm6/APNQ4uCORn0TmsT9lDKJyGpf5l/5UfBFOAcHtfuermHO0AI+BI+Pbfz
 lUO52+CkaAgr8hHKmTFtZptmSjrgCt5T7PMUr+qXIMW+v6WuwUOGP7q9T5O93AksTnmU4LW8D1w
 rO9FK4S0OO2gtE4vlMfje0fMtiDsnHOjDGayFop11KFEdOahRD4XA3dom0wNqQcwYasWft64WTA
 e6ESR0VOkNOw2MWSBe2j9YVpoIf7vzmoGRXT4Tyw9RgBgBNKnxAhL2yEKfFK5VA9qgK5zyk/YYt
 B+ZalzNR
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cac8cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=3pJJXNp13jenLdaujSYA:9
X-Proofpoint-GUID: u0zsiJrciuar9u1HQ9geWzuVT-Z1WPjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Document the existing AST2600 BMC board for IBM P10 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
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


