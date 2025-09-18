Return-Path: <linux-aspeed+bounces-2273-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9201ACAC5A7
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnL1wq1z2ypV;
	Fri, 19 Sep 2025 04:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218662;
	cv=none; b=ElybmqvUJbPwG4Dlc+LrUPrO18Xez8Vwu2IYh2S1pinomyl7b9cUaJhccgqX4SkYKKEPNwAZjaH+LbHCbwE8/tD2+BMXZMGriNcDPBW3yldm1FFgLlBKO1jIF6tlPka24K9JJvBcFjtiL64zkd5cZnvrtMvA9zCBk7mCYmjtLOyBwHs0bWTrrTnG1H4J/fy5NOjWn0vzC0eeXgyxxq/Igud6UsapT80pdcmeAQ6gNkeon+wrpYAS6Y7cesKll5fAufb2VlQsR9hjINhN5Py0Rala7RgfCY2VPeGmc7caREVQqSSLCoaPPQ+8q13cYLrgeml/1tWZblAiZG/9B7yrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218662; c=relaxed/relaxed;
	bh=Hokf1lue+vVbLiF9VZl0cEYqrAg1Uo/ImMJ3thEnMec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV2E4gWadZp5K+raWpHQbvYUXPat5qgfd9pPpwlGTMNKd3vMHnsrqc+MwXJtCO9ph4kJZESb9RpQI0GpT+8U0l1Ik1n+FzIap7vGaBVjKBpYHRGdEivrMRAOG++o3mrVVAuOLZBsySaoNLuU7qa+7AIN1wQUpmgU4WIiWor5GUqvCsA3JfzzKDmxHdnXd60kOXUEYzwppHxk6TsBoNuavVHmrt6rd9Lz+ccxZlvCqhNbISFYXtChHIPCYVrFbX1ZzLocnevJZqt7SJ9rxGS53yfXoALQXkyIn/Wk63Gjh+l6JQKpWgE3OTqjXexGYiogqDFMr4CLdjidkQwdBy90Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4w/xNLd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4w/xNLd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnK091wz2xnr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF40VZ013993;
	Thu, 18 Sep 2025 18:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hokf1lue+vVbLiF9V
	Zl0cEYqrAg1Uo/ImMJ3thEnMec=; b=D4w/xNLdh3Z0nDFx2JFahDgFgXwYK3V18
	azRHg386pnlGNtMtS/qMRjfrK7Xd3hhEdl3Iri6ACBPrqFhljvwdkPkt6zx1K5/S
	+LPHoy3rl2ZsAdTEHwNzDCb935lYokbYZYsf9OALhE+R35brjUjqJOr+TvHcGpMJ
	3DuCSO/5Mk5fGY4rzuXhb0NbhXFsLuet5yIwBw1o3H9UQRXagksLhaHC5dlL6m7i
	640IDoq+MJRxJ87atgNrikXv0YkId97/CjQA0PiKLsqkTSvkKlHYiznGleblDA3+
	wUHFIRlfkTymE6pxXyk5+BhWqmp07PNhx1HS6eQbND/r3iKrYjEvg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nkhpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGA1Qn029484;
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb1891c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4AAQ11731630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71ED5805A;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B1C58056;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 1/7] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Thu, 18 Sep 2025 13:03:56 -0500
Message-ID: <20250918180402.199373-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918180402.199373-1-eajames@linux.ibm.com>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cc499c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AJooQMD86rzp5GWHMWgA:9
X-Proofpoint-GUID: fHhlNWH7oBudInLofjwxg_5i_8oVTfsP
X-Proofpoint-ORIG-GUID: fHhlNWH7oBudInLofjwxg_5i_8oVTfsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX3w8OuXa+KyF4
 51D9RqBKwNXF9S7f3Xf4uIDqYQrkcnJGqPMbb/yoEkyixQ1TUMyA8kFYmFaUoACHh9ofcGTrH3k
 MtYXmk2ZHXB/DJWRwIlTSwYzcDY6ed+1kuliFYA1rpc0mlHn2g+ky2onmhPLZ5rRxA14Fz9/fDN
 i6yxx7ruOOkU2SWIsQrsvDwQtsH9GdKX7vqCZ7c2VtubzNBn680wCG9t9lsR8h+6O6dUgYlb0km
 3R8vb3FZ0LXvTEI3kkH7roK0l9bwYXfq8vroMVbhqkt8o8ueW2DeM6vCzhz7teF6DOYELMgvZcO
 3VbeDCE90hpbm4liS4CzkR7ZstDPQPMERP/3qHluETlud9c+J5h/dwTV3QzaC2fflqhUv+dEG/y
 UFXKVeYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a8..b2fcfcc4a3b9a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -93,6 +93,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - ibm,balcones-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.51.0


