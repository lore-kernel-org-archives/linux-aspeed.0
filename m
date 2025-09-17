Return-Path: <linux-aspeed+bounces-2251-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D75CAC59A
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 14:42:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRhLx0vYcz2yMh;
	Thu, 18 Sep 2025 00:42:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758120153;
	cv=none; b=QP06cvzwasTMkPb3b6D97o3yXuqW4wc7qCfEHi/TlWtg1aSz56ytNt1vzsGQh0Q4W1FZB75aYgpvGEzhkFUcbKKGWGdkhgQ+D/ex23yP3sS6J9Q1Se4oVLg30BiPJq0F+YyuX6mv4W2amm4ZhIjXaMthZrd+A6KKW7a4G2DqhnapQr7FfcydKPckCGmo8oBvR3sN9LJvsFpw22NxTkxwleao16VJ4YfbGz6RPzIs8UJpOeNbd4TpqfM9wzfJNFf6QffmJ5VQXWHvOeAYlwLP7ytaj/2igOPqHQG+lToq0WegxS9Cw59OkhsSUB3Tdjzxl+Aqs+hjtW4J7VrurQpU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758120153; c=relaxed/relaxed;
	bh=Hokf1lue+vVbLiF9VZl0cEYqrAg1Uo/ImMJ3thEnMec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on+sBFdpM2QksA/knEwJ0i8WAtrs+NF/6ili2torcErYqrIj2uSLtC4TIjJ9WQzxA7xECtYep9SgR8R+GLnj86uRzolYFRrk1oen+yFVNZKHF9YlIiFxsdg1B3xCSWqgq0AJXnnqTwwZMiVvVYJ0Lm8xKctqBR4Zrc6/SG9SPT8SwTBRM057milHvOMoPdeGwsuogSc4ryko/Qf0plXQrgce1y1U2h7fGZOB12P2R78maJKAO3GRORQm58U8pDGfkG1BOOnQoWKxmU43dACo77svfiVxtQnESJFktp1HO0x8yik+c8aORdI2ZWODD1bAoAcMC+yKzJdAJl+PhgGLEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SdvZvkv3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SdvZvkv3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRhLt349Bz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 00:42:29 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9GhQb011514;
	Wed, 17 Sep 2025 14:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hokf1lue+vVbLiF9V
	Zl0cEYqrAg1Uo/ImMJ3thEnMec=; b=SdvZvkv3F2/S5qtvw6ZUMr3CqMXIitERW
	lyxSKo9/E/ZgaWhfGPM8lNt81xyttofkF4YmQzkxCsrMb79W5XLjPhUMKESZEovu
	y9yBHKIHEwafyMIJVEfU5Wa6b9R6AE6g3PQIqxXqpk2maCAtE7Ak7o9ffxMh415u
	4Gu3hlwRhnTO8c1TawpNeSug7ry+5eJbFoktVQa+AfRgVmyOvR5qOeMlN8vTcAD+
	V2hVNecQY1IvZGaQxJLQg9qLbhtQevJTrQwHMltLo0Smv56fdiFmhgxnpAp1HFtg
	+kuW1k3CPl3DpwCPQM7SRoJepdKdpZClcQvdQocz8Bv3Jjd+3GZ7Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j4cjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDGvxM005981;
	Wed, 17 Sep 2025 14:42:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu9ycm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEgKCn35520970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:42:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7304458059;
	Wed, 17 Sep 2025 14:42:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9F058043;
	Wed, 17 Sep 2025 14:42:19 +0000 (GMT)
Received: from slate16 (unknown [9.61.98.41])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:42:19 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v5 1/6] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Wed, 17 Sep 2025 09:42:05 -0500
Message-ID: <20250917144210.160051-2-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cac8ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AJooQMD86rzp5GWHMWgA:9
X-Proofpoint-ORIG-GUID: zOhMBF_tH8rZek8_1ThYqL6D8-A92dHC
X-Proofpoint-GUID: zOhMBF_tH8rZek8_1ThYqL6D8-A92dHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5RBlNXMhCXWc
 LS8ClWBrYid6R/zstQq/H455sKUvDu0R4xUdtjLqMthxxkmPbVpKIeGxfK57i/qszQJCDC8xvrh
 62g3lAI/iX6VWlhqK1iPc80VYRUTxpF3t2hjTtZJvPIKzrs6NJ6VI+X02K0nfwDQLJkms0a+BqX
 hkapzCyUVh2hiX3TiH53D8DorbFuiIPQDZNbV8i9/FfRcdei6MrjvtP+GGPgGb8iGTLSEs+rOoE
 RkBhRaIEFj2cK5tg2xHQh0h0IJnuRc1ZB2sAYbUp+6WQdyHGwb0pDZ7L6FiT1MlOhe5ZfkaSzg9
 LT9d5oOuBSZXk35pSBewUwKmHxFxr9OhjlkYjtZmSC6/kV3EASllrjmzCwl0ONIHxebZwHg0h36
 yv0lf7Vv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
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


