Return-Path: <linux-aspeed+bounces-262-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF1BE77183
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Dec 2024 02:21:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YC0t75j9rz2xl6;
	Tue, 17 Dec 2024 13:21:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734402079;
	cv=none; b=eWri8Jfk/Lp7Reg43zXfVz7VSfAs8kBqefWFJMUgBwC+LoPIbvK+mF6lBmuCqpXC+6Sq7OTKTyjY49xfNBh67jd8Z6WnVNhq5FZYh+Z24r2HffjWoAn5thy83lYcNAs1FpqnXKq4hS56hN8cVlu3YWw8LEyClYCKc0FCmIhbPQUReGGej/QiDnBNWAeQaXUk0ZryCXjq8fB22CIab6tS21X3hQN7d/GOQk9ut78/unk/bmM1dxcUU45j094J1HbLsRBM5cHU0a45qbjSDeiFlC1/AHvxCHPEAiiRjt+78LMhnXlEvEQeEfyj+OPpHs2zr8LePNClnCZis2bbHJp4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734402079; c=relaxed/relaxed;
	bh=AsDAqIMu5OeVPY661bWbJiymnpLSWD2TsLjT9CDADno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddj3eEeajpWhy5wBRNs3tovXPm1RB1IJ0Mqb5M10i85BAkdWVTDGcXi6tAvSTqx5Lz0UW1GttmAZAm4VpB3Cd996lTs/sBVgESJEMwifjrkT/WDeCyU81XdqJxrcznttM1xtU23cFgOEJvgES5V0DAE3JxZJAR4aHx+BzaFR8ZDNuTYvMGFVeqOe41m7N3UwUo4y6tccYjMZkukRzWFUYpfEMJSMEeP4XHrHSxDMNzetZJFzeRNVt7kD/Eu7wsnnry9w6xsGmJBQW4chc49XwPID8gKeyqH8bX78MWShkXUBIjn/+NHEmY/mHqi5DzlwcZE0bTu8Ag07mAnxot0Jyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dymMaBWf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dymMaBWf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YC0t61wC6z2y6G
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 13:21:17 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1RnSi019974;
	Tue, 17 Dec 2024 02:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AsDAqIMu5OeVPY661
	bWbJiymnpLSWD2TsLjT9CDADno=; b=dymMaBWfWmwziaQMM/pSxoIREzA9yZrFm
	3z4nlxy45ytc0Y8yCiybAsjNQRV8eI9hOIzz10l2Lrthf3jlyqZ988SORqQtbtsb
	Im8fiRgPfFhjfw7lX63vFtOcjSU8oLMYmrD9bmhCXZWyenOiHGa0ubw1YciCEcvP
	xU5TnxSvZ8DoaSsdKhlLWwtSJxC4LHLqzSLreAKtCkABG0ey2PeAEYuriLdntbS3
	Q31v/cJpUKAOr10MwU9XL4AYY8dPasZ8fFS0KhuPBoLkEKutiBFvAc8Y6xmU0UkC
	Ad3CfOAxLSZ92dW1CXiRuML4c/Wi7Btpcv9F1a5qJ/1raB4elyNzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgws3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 02:20:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BH2KuY2015122;
	Tue, 17 Dec 2024 02:20:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgws3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 02:20:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2DbpX005549;
	Tue, 17 Dec 2024 02:20:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn0taq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 02:20:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH2KreU15270652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 02:20:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A53E158055;
	Tue, 17 Dec 2024 02:20:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E1B85803F;
	Tue, 17 Dec 2024 02:20:51 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 02:20:51 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        eajames@linux.ibm.com, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
        Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org,
        peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
        naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
        patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 1/4] hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
Date: Mon, 16 Dec 2024 20:20:39 -0600
Message-ID: <20241217022046.113830-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217022046.113830-1-ninad@linux.ibm.com>
References: <20241217022046.113830-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: vm7WmghfJNx8qz6xWi1CMW3xXaqNVGcp
X-Proofpoint-ORIG-GUID: exCA8cDQCPjJnn5TJ4jfbuLFO_0Qf5L3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412170015

Add debugfs file for the PMBUS_REVISION command. This command provides
information about PMBus protocol revision number.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index a7000314e5ad..787683e83db6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3534,11 +3534,11 @@ static int pmbus_init_debugfs(struct i2c_client *client,
 
 	/*
 	 * Allocate the max possible entries we need.
-	 * 6 entries device-specific
+	 * 7 entries device-specific
 	 * 10 entries page-specific
 	 */
 	entries = devm_kcalloc(data->dev,
-			       6 + data->info->pages * 10, sizeof(*entries),
+			       7 + data->info->pages * 10, sizeof(*entries),
 			       GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
@@ -3551,6 +3551,15 @@ static int pmbus_init_debugfs(struct i2c_client *client,
 	 * assume that values of the following registers are the same for all
 	 * pages and report values only for page 0.
 	 */
+	if (pmbus_check_byte_register(client, 0, PMBUS_REVISION)) {
+		entries[idx].client = client;
+		entries[idx].page = 0;
+		entries[idx].reg = PMBUS_REVISION;
+		debugfs_create_file("revision", 0444, data->debugfs,
+				    &entries[idx++],
+				    &pmbus_debugfs_ops);
+	}
+
 	if (pmbus_check_block_register(client, 0, PMBUS_MFR_ID)) {
 		entries[idx].client = client;
 		entries[idx].page = 0;
-- 
2.43.0


