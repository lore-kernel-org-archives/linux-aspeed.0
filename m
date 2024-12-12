Return-Path: <linux-aspeed+bounces-211-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D05E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 21:50:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8R2z1Xx5z30V0;
	Fri, 13 Dec 2024 08:50:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734040203;
	cv=none; b=fLuwAKR6KDR7mongimz8Mow34EO4M9kKw1OAwcmhaig3DDQIZPwJDK4Ur0gv++cSjhNwgxU+fGXKwXvROHWVvN2NewgLkN5wGGbQ2t8tWe5N7nHZSzb1ICVjNUKi2Buz7tUUA4b5YhtNYMtz+StvknSPBJKimupEQAyMH2oR82ibCHjWF6/ed4q9diF5hPQlfZq2Qknw6Vo9JB/ppInsP4tkK52vVAPdGzcu8gAYhrKQIRL8FE+VRrEYBoteORoYoghD6zQhFFXr67H4poGknlNLE1jNwClR1QFe7CXxyK9CBbKSAfBm4eIUQR9r0HB0x2A42VH2AYiTu1vKFJhyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734040203; c=relaxed/relaxed;
	bh=D1+hsni0AagUQPovftNiRehqPHfT8siZonAxT4C2AOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbsz5jy7sfcbQ9NiVTN9G8dsge9q8xdR6Gm93bncnY9pucz4SLvwJtKa1phu2I8P236+fFlf0v30csYUhAQZ1fjXPXMWRn2t3aMgry520rVvKcPCVxMoNOlr7NgdRiMiiHsbYvX9EHgJLw/92jud2oiAl3KGLuGMpyi8gyJx2QZrK0RGlf/uPvE1JNqt/v35S6NAIoVenQIMKFWrAGIq8ALfWVi+G5bBJoqlCzhh3Jv5dZGsdGEug9xYQ3oE7o0iwK2pGkxkqo2b4RprdFkm14n1QGs+abxnuvsQRDCyb0IAHvk4mwbplJcv3I/WN/7fHcNqnVOo6yeBXpVvIB8rHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KQjzk+fc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KQjzk+fc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8R2y0tlbz30ML
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 08:50:01 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCFrbEC005478;
	Thu, 12 Dec 2024 21:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D1+hsni0AagUQPovf
	tNiRehqPHfT8siZonAxT4C2AOc=; b=KQjzk+fcC/snk8b3HdncawwyzlcH3b7Ds
	nRbR/xhQCCj1Rvu7A73Z0yR5sb+255NDUZJUyrTsuwgwxMn6f1RjERXjx7il2UdB
	F9SwBprwVHz3tQbzUXnotekKW+U+TviX/5be+fLi9zaKZo4A7+cZxb5A9NNKOiOZ
	szjwTBEAThXHHP6FpOdVB8hoCnBcsWH/ngPr8PLB/DuVLRTPXclh7z2LS0wK08st
	MiXC9cn6JbeHFNBEoGgqj1vBVRGmAgXyScoAkg4Wiytyy79LdwjcF4OrdKfBgGRq
	K2Cb2fSEGvkesuLCU2viTldvsgWV/BZAQFQ3j0eljnoJGfYadg0wA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqp0bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCLnadU025486;
	Thu, 12 Dec 2024 21:49:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsqp0bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJx9xD032724;
	Thu, 12 Dec 2024 21:49:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pstx5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCLnYNt40698430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:49:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04CB858055;
	Thu, 12 Dec 2024 21:49:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67E585803F;
	Thu, 12 Dec 2024 21:49:32 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 21:49:32 +0000 (GMT)
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
Subject: [PATCH v1 1/4] hwmon: pmbus-core: Add label for fan and temp
Date: Thu, 12 Dec 2024 15:49:00 -0600
Message-ID: <20241212214927.3586509-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212214927.3586509-1-ninad@linux.ibm.com>
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0-KDHa8H1pe7UfQWJ29Y9DTH6_3lCjMP
X-Proofpoint-GUID: 2jHY31tH_BYQ5sdwMWIySbLvH2IaACgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=963 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120156

Adding label files for fan and temperature sensors in the power supply.
The openbmc application dbus-sensor(psusensor) requires those files to
consfigure those sensors.
Note that prefix for temp label is temp[A..C] used instead of temp[1..3]
as dbus-sensor(psusensor) application calculate index based on last
digit in the name so we do not want to make index double digit after
appending page index.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index a7000314e5ad..149b3c5f3a4c 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2144,6 +2144,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 	{
 		.reg = PMBUS_READ_TEMPERATURE_1,
 		.class = PSC_TEMPERATURE,
+		.label = "tempA",
 		.paged = true,
 		.update = true,
 		.compare = true,
@@ -2156,6 +2157,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 	}, {
 		.reg = PMBUS_READ_TEMPERATURE_2,
 		.class = PSC_TEMPERATURE,
+		.label = "tempB",
 		.paged = true,
 		.update = true,
 		.compare = true,
@@ -2168,6 +2170,7 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
 	}, {
 		.reg = PMBUS_READ_TEMPERATURE_3,
 		.class = PSC_TEMPERATURE,
+		.label = "tempC",
 		.paged = true,
 		.update = true,
 		.compare = true,
@@ -2282,6 +2285,17 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 					     PSC_FAN, true, true, true) == NULL)
 				return -ENOMEM;
 
+			/*
+			 * Add fan label.
+			 * Assuming paged attributes while passing page index
+			 */
+			ret = pmbus_add_label(data, "fan", index, "fan",
+					      page + 1, 0xff);
+			if (ret) {
+				dev_err(data->dev, "Fan label add failed ret=%d\n", ret);
+				return ret;
+			}
+
 			/* Fan control */
 			if (pmbus_check_word_register(client, page,
 					pmbus_fan_command_registers[f])) {
-- 
2.43.0


