Return-Path: <linux-aspeed+bounces-1500-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D534AC71157
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Jun 2025 00:06:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bN19K2dbHz2yPd;
	Thu, 19 Jun 2025 10:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.141.152 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750230539;
	cv=pass; b=IS1XEbJ4M+Nnl9d0qgClMocwqkr5LfHwYHRhPhm4Ugrxd68epv1DvpA9ooE9nKrNFAH6zwFfKXI3rzWiOw3ilo5t4MtIZ8LKWlAS1Y0VOtq/bKpLsq7YLuHN/pLL+lEC5ZJO/lsN0KaexBPpq/QWjS2m76efXxxUjQUHmy7jabrusvz7di5GJzPhXvnSRK2TwE25QjnkYYUkhE6oX5fhmmZJXnO5fHYF+3hzLN3b4k1PfAH0oKwyJWM3T61WOcEPmMavm+5DGmb7LQUZjoGi3aytVX78ZGQ3piWYLtQrpBSwhUlY3ePtlNGJcQ6JkuOZRRygUt0MLQhnx2hgqaktoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750230539; c=relaxed/relaxed;
	bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K4lTdg0XepVk315KUo0QLjiVWCX2eEqDcnYt7t8V05p3pf55lalIlj9+AvLtPr7OdCyYFG5lu9hjGw6EKUBVk5lDPcPXfyd8OdRf+M/W8L2fVC7xFOsUL01HleKfxX+HyIDJ3epX1QlHy7gX6aFVA4pAIhEe/dJS6wtNFH5qp2a5RcjDoK93VWQYDHu2MsIloXn9qzDZYmBOivq1hRbdPdRKVbN1abYWOHixsUgq7Lst4/tbotlqRpv0qlGkC3l1WZu2nVNoX1GhkHj0ld06HkxSu2O6cSOnweXv3/QAl1DfMJo9UmbBS8ZZP/JQTqOOPTjXkCSDCeLsEdGQ6tgSmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=Tsqj7N1t; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=TORpedka; dkim-atps=neutral; spf=pass (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=Tsqj7N1t;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=TORpedka;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org)
Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMZbY6VWNz30RJ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 17:08:55 +1000 (AEST)
Received: from pps.filterd (m0462408.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNA6nk010207;
	Wed, 18 Jun 2025 15:08:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=IqTetl6upexAsH4ZMTdRxrm
	6z3s/zmsA9UK2sAWt5FA=; b=Tsqj7N1tLHLUyKj4gOCIHGV/bBY3vMqYqe/5a5u
	U117UGgZo3l1ov/7ghhV3ARDVse77mrArxw+rRInh2nu2UHFOx2QA+2/+/0yE12Q
	KbgshEBruFGM0izBGu1H5SgtHFz2muoD9fTlPGU9EjJ+A8nXJI42n4wlAO9yhwHE
	BWm77Qit45XBcL1KLpuQoP6ifm9UxBcMZwbq4H8H8ab5otYJYmLxiPF0mErcQ1ms
	NSttENyjpOsw05Lo5FOrnS+f34XvjKsc9bCcfqEgFI03pEIxtYyukjhXThnkBe6+
	0ryF29c4g3AK8vnaO1IEsrujJdhnZx/oif9JkPRQlFVdSaQ==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 47bhssgfpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:08:29 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP+KDz7rvIuyLRIgcMrAdvKdul8OQdawszxZM7JuGLzMJka2mwVaw5ykJAMEKcVXY1qOnbuROZ//Y68Qe6c2gX5zgCOniQUIyA4HzRXy23LQa8V4z3Sk6/tP135LpqQMJ8e7kM7oZulkV/RMhr9hXSTM8gXIheLsIluB1CpBkktUX3DB7jkXEIQqtAWW9e5gixD4fgBBSl8pJg87fnStkKIb0b6W55VRiUHApMBAtvTeN++bMGnNqezCS5CiKE8yMdun8AdIcwKKksK6gV74upt+0Xcxf6qS8yHwWCPR7ScoJYWNVW+WI+w6RXUWZPadE12hihLJoVLOKXoqLGJSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
 b=FuAa30OvcC9YbADzP6gD9fWPUOffykTY+MgnogyV0Nfiz9GPyT2Q2oufzxd2VXkM1p2sF0PUhCvBYXCbP9555Icy59Q9RzM9lF7iWJYbOYCgkn8m4Nz3V0vWDkRE98YFSTzrcOlKEyBd9qW4dwWfGHkRcgktUzpb0FWcAqqW+3GtCz4Dk2fiG9o+Md2tvTOINI+rOuPSmcK15Z4UzN5WdrCdDzTnjhQCYrp358LRpfw9pI5C69wJa5pBJI0rQwu7UKmIB2RxRPtGJ1dGcWKbzogUDZFE339pYM0uFrdH9S1jqlfSG1KJECaAHzq2nzSm8Hm07Lq2ebaVq1lab87J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
 b=TORpedkarZybDgaIA8npOZR8//ZvmBm83nJfU4aUJkAT+sQyMnljfGGLJI4XLGgLEvtc30ecsddFeyw6HD63+Kwyjoz2zPZz2uXgFM5oCRbr+TFNMEgCeEKst83zsvLgH1crocJci3K4zvv+G/SAsiuGn2i+FtPRvRRBctfitn3lg5dYSUiG8aatj+s0sGGv/3iCumQop07Bew+DDQp3f8HRB65s6eX81NSOY/rpn74tiiPdCFxkF7ytxC2WLW/3fPyRNfFsGZeQVedqnQ1jsKP+x401rkBmdUjuTjs/y0lziiqzdjZz1YGj1mrdLpWRV27IBx+lDKTk99Tt73+ZfA==
Received: from SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) by
 KL1PR04MB7209.apcprd04.prod.outlook.com (2603:1096:820:fb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Wed, 18 Jun 2025 07:08:24 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::87) by SI2P153CA0015.outlook.office365.com
 (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.5 via Frontend Transport; Wed,
 18 Jun 2025 07:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025
 07:08:23 +0000
From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Marshall Zhan <marshall_zhan@wiwynn.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel
Date: Wed, 18 Jun 2025 15:08:22 +0800
Message-Id: <20250618070823.4136687-1-marshall_zhan@wiwynn.com>
X-Mailer: git-send-email 2.25.1
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|KL1PR04MB7209:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21b7d367-1c78-4832-109b-08ddae36ea53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/xnR1LntkW9zVjmQ8ZufqXY9xVIZDdWkrT2P2Cwu2FynlQU3gGVSc82JlWO?=
 =?us-ascii?Q?RWLbr2fRptKVJZUqk6TSWiTbjhyBTnPQ9G2islc0gu/OIzsll4JBcmaAYtwi?=
 =?us-ascii?Q?xC7FX5mqWZSYfoF4zOOfpKPpaOyk+jLFD4Ezr3RgFpv9zL0qn7baPCZnCheq?=
 =?us-ascii?Q?Lh0VYfqARkkSHQ3D1ardOb5U7eU74p4sRzIum9q3THvXi6wJXdrXmEJybLZ9?=
 =?us-ascii?Q?EEUIKMudT0oFPMaPB++00JQvS5OAawuDH1gqEciHN6efD9U4kFt1f31DgNzX?=
 =?us-ascii?Q?W2teybxa2KejEn1YuSPTYnXKFiKBeoIQNkiJtGwA2nawk5T+DSyOuUbygrf8?=
 =?us-ascii?Q?cV1tCiP3Ni4AX67E4PT5DgBMlXPtG1hC3U2ZgbPgypvTPczyCFEhYcX/PKQE?=
 =?us-ascii?Q?pFKtnsQZu/AJyopf54gtxqTluqw4ZSy7xynN7f6VIeEBdRQEPMerqqE6ZDFu?=
 =?us-ascii?Q?2Hd+u1zkSCI1Ca6nSqy5nN2lxu1Zpy++30SaWtVwr/eFqXyf+xMLadZxXVsB?=
 =?us-ascii?Q?PWSmhDAtgjS/xmuC5L93/c/f56uHkfrBqEJofeGsovotPijCHQ902zub0e7k?=
 =?us-ascii?Q?fzBDafCTucsn2XNljUq4rbpE7ACcHFhtSwRBxWx4I+pXd8JHtMrVnhUtAHmw?=
 =?us-ascii?Q?tBChCABT0SxKuorhealPJ1cYKHMTsfitqEWAVEbjFuFoLL77IOREsWzlRT8V?=
 =?us-ascii?Q?GpgBkeUmvnscwDdM9H8LDws7KOEEborLUlEAIHAaLJ/cbazxlbIaO8Pa3AtR?=
 =?us-ascii?Q?WDvkGSZP+ckh+l5Qbuj5BZpyCQpF1fKbnMDfr6prJMrwQmiO+SGNXVir4X9G?=
 =?us-ascii?Q?7PzEdc9zwVAuGT4CywIX8WpeVE2+GXf3SSbMMnbpaIkVcW+uz2U6AqN2sktW?=
 =?us-ascii?Q?qT9kXyL13uL+Wbb9Jtw3+tADeaeBQoX2xNkIiWzjKNFPVV+PYePvq6VJcpp9?=
 =?us-ascii?Q?OurVaBuu8eL+wn8DjymG6rPfzaBSzFgH/NPKYhhljhBYo8fPguMLULoVOjYO?=
 =?us-ascii?Q?YSzTPkyg47yQ5jmDeh5RyxYE4wVM8LzoBvMmVMVErlClI0sqSa1ZCQ6zc+ZO?=
 =?us-ascii?Q?zxU+Q67VE7GJb+cqC6we6YlCVnzW/21WqB4zC1O+IWatvrU8BR5DmAFxGxmb?=
 =?us-ascii?Q?wYdi2IVuJG4MjhXE2yVYiR8oLHsUZ0PvYPrphhuN79sj370YGa0t73Ekl2SI?=
 =?us-ascii?Q?yN4Y838HsGre23GPkD1mgY6XX78v2HKlJhcZZxAd0HkRVV5bLOjObhAKJTbv?=
 =?us-ascii?Q?DiAfgWmzucfm0ZfMB31dcYZ8beTpIjL8WWZUN1nlxytm9fj0P2HgTTay9KRQ?=
 =?us-ascii?Q?xgQ5fjjLDoVx15wVs29Te1qTJDd1u0gxzBm92MluvVqFNdXMPwuMNsuSyja5?=
 =?us-ascii?Q?8Z4EywcI0uYRH+HJOZvizowQkV8KRBgliE1Xtjbj37DF8psbhAZFKxwyB9zH?=
 =?us-ascii?Q?cN7DUP3FzGP9qPCutRIjkLDHp76rwgPFewIYQgGx9xATCO+9iRVwUA+3j/gy?=
 =?us-ascii?Q?z3F1pCm9N2lGIrflM3Eq5pWRFH2E+99uYPFD?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TrIw56rwnMWtEnDjlXYOqX67GeFoK3fWCirIG0+gA5vnX7hK0xuuABDu6EokBUUuuR9fHzyjsZb0wi4DTcqzesxxdvRTZ9lxWvwKA0JbJsoynSn9t5C5PDgs+XBJnEafF4YJgok887uYmDhB6jBvYu1y450n4BnzRvyKovIq+ODaiOClUeqnZNf1kpQUpThIHd1jf66Tq+4UyjlSzvCEdXaCQHXXRTM5kBP8oudBAEoetJthFaKZY323Hgz9QQwJtBXEqpmc1f3APnIDx3j+6tHDN+/zhGFwllvUPRiRlRjCA+mqA2jWvSONDKs8wMwkjKEEGb9DqDWEqxm4SBw6B49+M3B7GFIymP0egUHjbaepKITCgJ/g8voBDuYHWXWq/OxaypCLxi4oyYH3necCTHYwiwezY77LEeyLedio7mW7P15blvPOy6SITqUqhNtacwWGpKeEUNagw6YfGCiqjwqyrlqGAmzYLtm0cmuNpZg4j/d7uEiLjZ/hFiNTGmHFQuQzSHAVnByH5w/use53pUgVh+NlyptoPw+yG8FbZc26br19YVdpfUsrCIUcslvkkn7JqMvzoVvP2aEbrVw7d2kZ7KwdeenE0M3zoCn7oU8DENGHnRPO7+v7nvNdDlPW
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:08:23.2743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b7d367-1c78-4832-109b-08ddae36ea53
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7209
X-Authority-Analysis: v=2.4 cv=B9e50PtM c=1 sm=1 tr=0 ts=685265ed cx=c_pps a=dsIthHTsXEBkGW0VS6idzA==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=6IFa9wvqVegA:10
 a=4AL28aEVfeMA:10 a=cPYzWk29AAAA:8 a=u2kzlEoHWhBIlCB3pKYA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-ORIG-GUID: JnxlT6wqDCj_w1DQZrvvdKl0PVcg-3z6
X-Proofpoint-GUID: JnxlT6wqDCj_w1DQZrvvdKl0PVcg-3z6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA2MCBTYWx0ZWRfX7YlxDkhfcZSK pbfEGURS7SPlg4dmgzQT60DiMchr4ssRDOWux7eSSgmrrweEVQVMS733UIcVOemrofUY1ggS3gc Z+cJHluemv1DQmeA3QFx6yZ0BopLHSAFiO+FeZWlmO4vlLBiyRRlZWkuGO3HS59NXXT/NTGgkUa
 cqsitliwk1gjf8qTRP93rxKIDcq7h4Cmvb15ziuDqC0CrBKE27JXM+GZZV4qOtpz9eug1ENV7Em x8i7YfcuE15w9QcWZ5XcRjLpVYXR8CkxsValC2ZG0h47cu56vVAyQJDZVzpEQVPueEYdGspQ9BR 4EQW5EqBiBpGw8rLckCFmcRv7nl6WETu1sTo6dQ/3UfDtVfBIbgZWYw8H6/vD/EfGFFfuSlu22p
 YHolnorY3amw8n/0oIwDvWjh7BlMwVoXyfi7Qdil40899z4koWQkimppwRrsqzjbT3ZYsarq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=799 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506180060

Add gpio line name to support multiplexed console

Signed-off-by: Marshall Zhan <marshall_zhan@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 29f224bccd63..aae789854c52 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -189,6 +189,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT1_UART_SEL0","SLOT1_UART_SEL1",
+				"SLOT1_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -235,6 +240,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT2_UART_SEL0","SLOT2_UART_SEL1",
+				"SLOT2_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -281,6 +291,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT3_UART_SEL0","SLOT3_UART_SEL1",
+				"SLOT3_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -327,6 +342,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT4_UART_SEL0","SLOT4_UART_SEL1",
+				"SLOT4_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -373,6 +393,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT5_UART_SEL0","SLOT5_UART_SEL1",
+				"SLOT5_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -419,6 +444,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT6_UART_SEL0","SLOT6_UART_SEL1",
+				"SLOT6_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -465,6 +495,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT7_UART_SEL0","SLOT7_UART_SEL1",
+				"SLOT7_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
@@ -511,6 +546,11 @@ gpio@22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-line-names = "SLOT8_UART_SEL0","SLOT8_UART_SEL1",
+				"SLOT8_UART_SEL2","","","","","",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
 	};
 
 	gpio@23 {
-- 
2.25.1


