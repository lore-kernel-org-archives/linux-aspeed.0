Return-Path: <linux-aspeed+bounces-2279-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40330CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnN4HX0z2yqR;
	Fri, 19 Sep 2025 04:04:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218664;
	cv=none; b=W5BeqqkGRdbhuM/PpTsyNzaQ7ziACPB0IoPxTkFjxHRODGMm5T4QmK+wWVa+WLLDc2GTIyq3W+WvUV/NOCOLDS0oMAIrzKqxD1KS+chiQqjgzOgeilxU6l1qQYBFZYhVJHbRiQbWqPK67afxfhK7ZeDCkWAluqUhksVV8ewHS/ulwPKO5tf19HzKPYl21fEKzqE/4K1YTBBM/ISMdRXktc9OZXctLjLM03eOTpb+N1wfeOOA8gpAJSn4h0w+nTABkM0mB/jvd6SKr4evras2GU8NDc9CjfqkC0Z6aCYKDnMQxYEk1sBMpYX8cEXbRijsGSNJhjzjhGS04gtHBTNjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218664; c=relaxed/relaxed;
	bh=aGCEUE9JIhEEuusrDraGAVEPG67gpaf8g7C5M/rBytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQYVSvfTjuXpDKbv5W/ElfoNS9YjpRxZgNNeRVXfl8DgQT+Bf7xYqd2kabx75rHcBKsQp99uxPpDtjOQ+XgFpVswZlhmGVdWJMSAHAmCusURfixb0YJhEMxlmJ5Xj9x9xVSHZxASookYu0pUaVHH5pALRfhvautJG8p6my+/HPrzArGVbgxppINxHHUk2SOasyE9+uVIu/kvyd1ExPuJCjMpR/jjI3Ja0BiAFjebvM1mowcs1GgNt+piFGYTKeDWbYeh1r86BHpfD9oPJeyrS4jmsioU/Lg6N5qRSBunyKTwrlnumyxLNrHtlY20H2/YWfu4o/CqQzFNGcwtlbUn3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=adYK00kn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=adYK00kn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnM6s8Fz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:23 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDD6OD003223;
	Thu, 18 Sep 2025 18:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aGCEUE9JIhEEuusrD
	raGAVEPG67gpaf8g7C5M/rBytI=; b=adYK00kn9g+FJziVPWpRSx6yfp661Zp9m
	fviv0VIzcAFQa6YwMqt1Vtoc1N4ZR7rY2wGm4smBK71KI1Bo3VzIRsgds8bhmCWv
	z76uiuPJxx//XQ1kTLmbmNCDNwfMF/alxpSTNZwD5+Qq1xqDmEbKIJHZqU9ydmkD
	ayT3Rs3WViOnF1Q4Rn+QCbLRNDgfvUi0ZZk5oRvetgkhyBAJ4DujDZsNbwoQUdfa
	zvnCDVNvGmhT2/UUmpGL4wnEE9qp/ApQ3wM6G4ho0a2o9RWOKPl5vBe2Vxi5QrYo
	NrElTIUsd2QvtYoQsKzGDPSN8+b7FFodldd4xBcwrONqebPaNJw6w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hv0dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHcvu8018649;
	Thu, 18 Sep 2025 18:04:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mqvqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4B4V8454754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACDE58056;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A4AA58064;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 5/7] dt-bindings: hwmon: max31790: Document address and size cells
Date: Thu, 18 Sep 2025 13:04:00 -0500
Message-ID: <20250918180402.199373-6-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hFP4vXeo6w10QxI7Pm7pyHTLPSsjuur5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX42b6wWgKUoyF
 ofq0UB5MTsr03RhXIMZH1DFkrDJMshONk29YvHB3/tbFFw1oo9kE52NKhuldFjWybUAjff05oWp
 UgWBuS+DNvTPhN7X+2tT1zLQhf4kyepmz0iIxBOPsQlfLqjAWVB+IPXwVG3ed8PMjip/p72BVpu
 OGUoFqXH6aTcJ8DSrcD5+/jPRgZLj4x97WR8YNeCMIdilWDc5vNl9ZtiIxhU0JMhTdxvrwUPubn
 Yo2Q/D5ITEU5suMEoflPc8KuSTWgWKDU9f7UmwBod2VXCEUufmmaxrUSirzOMU69LG76RlY0nOD
 gaoCiklMCi/reyGT4kd3/LrNI3zQ+r/WyqoKUuGPa8dumQ2Uof0z2yYCaZjI9rpPR4f21vWK5Yg
 ZUZ1Eu7i
X-Proofpoint-GUID: hFP4vXeo6w10QxI7Pm7pyHTLPSsjuur5
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc499e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=qeiQR4ZBQHcxPOEz8WgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

Since fan properties can include reg, the fan controller should be
able to specify address-cells and size-cells properties.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b2dc813b1ab44..42e7030360f1c 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -35,6 +35,12 @@ properties:
   resets:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   "#pwm-cells":
     const: 1
 
-- 
2.51.0


