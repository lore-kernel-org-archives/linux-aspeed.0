Return-Path: <linux-aspeed+bounces-2319-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA50CAC5AA
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 17:58:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVrSh0kS9z30N8;
	Tue, 23 Sep 2025 03:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758563908;
	cv=none; b=ahqSJdkPV9Ja9vYVpNPV6pvGJ+sSDIvPREVV3CfEf4rNHJgAkhp75k1+xPaVlJp8726yIUf66ElImae5dutqarNqfj+ODBZ3jyB8KHZbsWd8Ia9nTFGkfakpqQJUPRTiBlnBn/wZ4/d5hhJEjMXOdRe/YHSyDrApnLaTBFYKQgtWix+h9JNaj+z9ETCxelJAyGTch8yWlo2W2rLPKwD/uw3bXP569gYv+yUCBDoXTAvpgs/lQBO6NYdmgMXwGcX9uys6Y1ajHw7irwtlChSpCQNV82tf5JWMQDhaMnuS1zlUFx/NlNIwColh1y4U/D4afaeEOiCIGL8+W0il+F6cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758563908; c=relaxed/relaxed;
	bh=Hokf1lue+vVbLiF9VZl0cEYqrAg1Uo/ImMJ3thEnMec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ0u0EVcXo51dQaSbjVnEvQQFjOcDqe3nEG6I9EDEQ4n9BCe4dCEd+HTF6NQMfEnmDAyudJzIhPwqDhQfavVRPgWQT7IWIJAhBW+/XlyxUOSiF+EEjoWw5R2M95JD0ad38Zj68a5AAx/WjPCVB8VT2erfMNZkEqmKHqG41cE+1fOXHSGjDZyruUBozWCBGw12ljv/Hejkj3d8esROa+4ytJeTxVXBUJR+IbYcEPE0PNBL+/Fm5fkBh+/JffbQ2DiRz8JvK907A0yXNAgeCZ+HQ0I9CMrLSHM9DOsATd6D/huoO6JOUi0m+bPmeA4Z7l3QKICXUXJem7OrInskjnY/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B26jLV2G; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B26jLV2G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVrSg2Xkrz2xPw
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 03:58:26 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8hKIk005703;
	Mon, 22 Sep 2025 17:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hokf1lue+vVbLiF9V
	Zl0cEYqrAg1Uo/ImMJ3thEnMec=; b=B26jLV2G/Ug7yWWkrxpuoDWrpoCQVQ8fa
	yamU8TM1tQYbTNEWPsmb+cLC0mNFckCWGtWM80giswtlhEDUQzgnrRP/3DcYw2D6
	ZTgX0nmygvdSmhGVv6rxYV7naCY6bCk17NpsdxI05EOvIgvjterhCI6APIrmsMHD
	WnwJtKedpAIoINCAil2S39ixL214Mo+vIILqJnLDJKlQY6x06ov1YjuXaZixurCQ
	E/Nwbj9B7PS0hmPm6LK3wXTroKGuvbX3h4DSaXZzCSbCkP/HBQe5+++KoRE9Fddp
	7LAK/hQIIyAA1aop6uKhD47LLyJOzepzRE46NfuBAFemz8iGqPhYg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyc183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGWhm2019675;
	Mon, 22 Sep 2025 17:58:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83jy9hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHwBmI32440714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:58:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C025805C;
	Mon, 22 Sep 2025 17:58:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E183F58058;
	Mon, 22 Sep 2025 17:58:10 +0000 (GMT)
Received: from slate16 (unknown [9.61.160.40])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:58:10 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 1/7] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Mon, 22 Sep 2025 12:57:58 -0500
Message-ID: <20250922175804.31679-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922175804.31679-1-eajames@linux.ibm.com>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d18e34 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AJooQMD86rzp5GWHMWgA:9
X-Proofpoint-GUID: y7dLO3GNmmBbI_P5OkOOK6-2tb4ii-xx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX9vAfq5vh/sZ4
 N1mOnStBrOrPSrqCA84CpguxmDazS9uH7S+oy9CRXQ116GP+XWSwXAqfK0aZrwmVBzu/7lFbnU8
 or3DZrBwc18GvwgJDXYKmngNiR5oWkpoSQKrxzusrW5Ycqp0Ap51chq++2MNPFa3roT5xsMuQk0
 MEpd/egSzMy5TEJ0/nHJjuXvclmg8r4L+ZwZ/zi8rOWTgVqGIhAAgXo6i4IvDz9ukoxq/HopyH3
 +/DSUj0EJij0jYvRUqKfAgmiB7Usw7cK9S31QL2P+lheD+YkA26dw3xGH16oB+/D/AXeHvg0zsH
 Q+PRyJQFMBwGa/W4jdTiTICyzCy03LN6EpV7R82oAVhN/FQcNibM0z85bpS1dTi7La+zkrsymaF
 L1Wsvyqm
X-Proofpoint-ORIG-GUID: y7dLO3GNmmBbI_P5OkOOK6-2tb4ii-xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

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


