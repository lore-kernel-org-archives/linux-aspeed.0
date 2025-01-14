Return-Path: <linux-aspeed+bounces-477-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29162E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 22:02:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXjmC6jJKz30hL;
	Wed, 15 Jan 2025 09:02:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736892155;
	cv=none; b=CUZTo/2keA3QNNU+Wr9Y+gL49MtZckov5hwIqrFkVddMLGrjy1pWGmYHVynu1Yf68HY8VvfbPIldyXz77vXar1j1lkL0uH98nNFgW3yHwfow0WxN1exQl5XF6R9paWe4TK0iFQa5GV/FEr9a7cqOQZKwiRdKaxLPMk4svBHzanmr+gYa5CasWe2IuznlZWu7b4tpDSChtokkKZb8KaOn7e8dnVXl1sv4JYc2XT2I6iGZet9fXH07X/LfjqxM0vurLI/H28d3qnW64/ZePrMukX5oK9L+g2mZMZLNAljxi09+KY1JePXvnUOZPolMdDVHnSIpLjNq2b3gxcYTC3wmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736892155; c=relaxed/relaxed;
	bh=qeJJEFyKAvbHEqepFpecDthD3TD7ZnTk6U2zKb548cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwmaIwZPYTnFva3UyCXhwxeyx6UdWjxJvBPzmvCG4oTWaDc8eDltTF2c3K5wd2CX6PSA3AiktmAF3hr/xW+A75F/Z9Ekqbjt8MRdjG5lWYU53+grGoq08VHU2Mr5OIdSEfT6BaXC7UhAnN1kjBqbpRQS+z6CnKji2KDKUXeRAXcKXL/7xHEqcf2AobERm1h1ttkeFnvlnkKo4HhZ1hq1CTez4cEQPs3HLvYsWa2pvvjNHQitbULRz3AW8HbVZNsB1LPTuXLw+8WrhHFkYDTN94sK7mQc686TCO2NNhjxJumQHDYmf/0iWkvVwO5GuEYL2f37SIRJCwVkVteq86daCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IrWY7763; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IrWY7763;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXjmB5RWyz3Wtr
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 09:02:34 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EJ2ZIT022229;
	Tue, 14 Jan 2025 22:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qeJJEFyKAvbHEqepF
	pecDthD3TD7ZnTk6U2zKb548cA=; b=IrWY7763OZqmvNBkq/0PSk88Z3e8LpRKi
	jrZwoI6njzVwepswdve0kt/jrw5haKvSjUiGXf9py2J7ez3Y0Z+9oXmFM/RtzHPg
	+qfzaCWlMkn52qgZuyvNCGmKWyi8PJ6vMnkrvGFnKsSCkqU6IZT8YbITiXdfJhZA
	kqQfBDNkt9BM803kea1JiTmOc9Rl5aZAMM0+L8181z5SBzCs2qPgrw3bVjz3vKjD
	4m+kQWIcZDgLizv/jV4jPnhzLxtyZhEHcl1p2/c4CBKbufjQYP1eHmj3DKFNmsaM
	btqFjK4j1/QFCHwF1rk0yDEuGlRLp9igQOeEDQoPuZ3F7f7+X86uA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445m433cpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EM1rBo018799;
	Tue, 14 Jan 2025 22:01:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445m433cpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EJ2S8H000881;
	Tue, 14 Jan 2025 22:01:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jw1x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EM1oV327918776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 22:01:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932C658043;
	Tue, 14 Jan 2025 22:01:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E5D658059;
	Tue, 14 Jan 2025 22:01:50 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 22:01:50 +0000 (GMT)
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
Subject: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
Date: Tue, 14 Jan 2025 16:01:37 -0600
Message-ID: <20250114220147.757075-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114220147.757075-1-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nwrassjNnPob0JSvsIxR9LpFIMmpVa-w
X-Proofpoint-GUID: JAZu7hIcQSil0fco3pOwZzUqsWkZA4DE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=963 phishscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166

Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index b9afd07a9d24..b9bc4fe4d5a6 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -46,6 +46,12 @@ properties:
     minimum: 12
     maximum: 232
 
+patternProperties:
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
+    type: object
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
-- 
2.43.0


