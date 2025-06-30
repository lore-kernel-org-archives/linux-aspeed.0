Return-Path: <linux-aspeed+bounces-1600-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4A2C83030
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Jun 2025 23:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWNGR0dGjz2yZ6;
	Tue,  1 Jul 2025 09:51:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.145.158 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751269964;
	cv=pass; b=GJuvk87iJRWDB6OcJ9kYCd1PHKU5rvWvkexugP/6BaxO/EMV3rH6mrbpCiVVLkd+kR26DOoxWlOhihu96vusDhmudGTdfJA0lNGYi5dAdRaakAMUd3S21sGnKFy8jobQFh60pyKJdfv7D9pH9ffQ/85IYP8WCKG33ZwaRCWfJg8GG4+cV1DCyZT7gaEu6Dj7Aa2SOtHIi3bar7QAiVisLjVnAUocyaabOluH0jSSvEGW5yMCJsHuShIvUlMzuYrQ1QrfhB4rw/Bg2LY0eN8MNMcJtQLOzogodfbBsCq1z41AHf5QaynMlkNkUAJD8niYBY/MHatHQM4Bqcyt7KAAoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751269964; c=relaxed/relaxed;
	bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=USGYzBEUYP4ZsN1mP8GY/bukvNrZTiRMA8Qy3d1JG/GsvSJ6p30gocBqSM9cttWSUv+wOoNpyaNr0NNlUN6NrxbjY2vYmzZzzRTTEbEFxYi9fKNib1QNsTuej3lbyTX8twe7X4uabyguF5edbV0bESEEouufIkQXkq/uHQSugZuDEMdTihMH20h2vPcvqVyiIlZsFoM/jQkxwPZ2B+CAICXQkWhEJo+47O1cKDfXkEjzfsfdN25rycX5LpIh+ZAOWlYSGTgGZqg08aJtzjmb+jBi5tYlzqqx5lN0po0sO/A2LXBf3ih3S8PM80ixrwnycL+wMDOgkFVrO+MTzA+7NA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=Bc2sAaPP; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=czqeF7Jt; dkim-atps=neutral; spf=pass (client-ip=148.163.145.158; helo=mx0a-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=Bc2sAaPP;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=czqeF7Jt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=148.163.145.158; helo=mx0a-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1230 seconds by postgrey-1.37 at boromir; Mon, 30 Jun 2025 17:52:43 AEST
Received: from mx0a-009a6c02.pphosted.com (mx0a-009a6c02.pphosted.com [148.163.145.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bVz0W0RLgz2y06
	for <linux-aspeed@lists.ozlabs.org>; Mon, 30 Jun 2025 17:52:40 +1000 (AEST)
Received: from pps.filterd (m0462404.ppops.net [127.0.0.1])
	by mx0a-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMBBgM000992;
	Mon, 30 Jun 2025 15:31:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=IqTetl6upexAsH4ZMTdRxrm
	6z3s/zmsA9UK2sAWt5FA=; b=Bc2sAaPPqrWcYDDdeupjgifVPby7DgiYr9TnJHj
	WevAxsWa1ZjhFvt17dvO8h4nlcWZS+aerb82CB/vVOyWnu4V2S1tJv3QkRWZp3UM
	syF8BR1/6apVqjAtLE/iMbLf3jsCJRbvI7xpgo44ogvlGVd24CCShRUw+V/Bs8uf
	EmqhiJXKnNqr8Qp+AonG3yn2T0pBDRuDYEImhxpDxCiu19yhBQ0jn+S+OfOfyVHu
	yFle1T+eLgK1IuIeyuE0Igyc34GdeSV3kWJhmV+RGKG6Ja476ip5pxlEsp+eHWFx
	89oEEOqFG8R+p9G5klnLG7LFXHzrtdBF3qhyP5l+/7pUxmQ==
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012036.outbound.protection.outlook.com [52.101.126.36])
	by mx0a-009a6c02.pphosted.com (PPS) with ESMTPS id 47jpyvs6rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 15:31:42 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccDU7Nr5EeU3/k9QUnetJWE/AEzSdqMfS5XW9FGEDOcZoMzTrxD/YR/m+IgnJEknUA74wJwBXSRJDWZ17Wl+QByK20PJfPONrTOfbnaP07ZK5bmsxPy+/zAx1sVwewEWd8X3X5yWf5WUD1+K0N6ToovHDqdyd4HRxK6KrkspcSEFv6GTiGXD61HhrE4TmCt2Q7xlfmALtP6tLH4RoMn02zU8niToKZZtEQ2UkraGLuvsF5qKyWJX1PmihomxAQA/1uINnwzPaW1H0PEjF8pxJJ5AaAxvCvdMn8LSBYj978Bbhnu6OPsYbsHVbc9bfce2Azoe2po0Pq6rm/Bu9HT04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
 b=Cap5f1R3hEk4vjFydNVxyAkshaPFGY3qPjpSs5kvh7E5PNQf4ub/VtWmoI2jpN01uLZrugH+t8cWY+R9eUEvDePV6cErfk5bi9Lfx9X6XB5eyCF7dJSnBmTEk0teCjIO6zNiASrl67DH2wuwAdwEqhgVs2pR1kHzIAUksieZYPoZLgfbAnod7jjGo2HdZGmlyOQAEcdlfuy5cMXtbuPsdg8faXs+Jtq6j3tyT+tvQRpH2rhDk6J62B9hPti1xkwboHOKhCXq70oIywGZdsSO2vXwvfDHgHlx4R6dFnfmmUp6nG+yn2lQdSnLLpPs+peJZNVaJ+2dQtCU9tsadJeURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqTetl6upexAsH4ZMTdRxrm6z3s/zmsA9UK2sAWt5FA=;
 b=czqeF7Jt2j17XzdNlRzkKdr20tfwVhHAbJms+Ja/J/xcY8Gl76IGEcJxxAVJLA+5+CCrcS73eWAYj01pEY373/n2kD5vj5bwoLKTyf8iWp5gnJYV1mQybWcagaMoTdh7UnCeqawi/GeUwVt3Rbzy3HIq/rjmsxowE4rADvoOVgUFlmQW3PjPa0T37Gb4eeUlOZUUAplVxFQGv8K1MVyql2PnvMif5UbFUZAsAVXVbNIKdGpv3o3sRwXBS4wvmRej50wk5ui6OvhtDncNrqqBN6Eg8N4cOKv1zidm9ZrHyG1R18drmW01bYfcgrezKAh5ZUMQ+drLbA9Xf+lXEFReNA==
Received: from SG2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:4:188::15)
 by KUXPR04MB8950.apcprd04.prod.outlook.com (2603:1096:d10:50::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 07:31:39 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::8a) by SG2PR02CA0132.outlook.office365.com
 (2603:1096:4:188::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 07:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025
 07:31:38 +0000
From: Marshall Zhan <marshall_zhan@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] ARM: dts: aspeed: yosemite4: add gpio name for uart mux sel
Date: Mon, 30 Jun 2025 15:31:37 +0800
Message-Id: <20250630073138.3315947-1-marshall_zhan@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|KUXPR04MB8950:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 017047d2-c2a6-4125-1e8b-08ddb7a826de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tb6YRECxFAdgp+qIAyMCCNEMy0WziS5ESDizt5A6+rDKZDCHMoI0cnlZ+uCh?=
 =?us-ascii?Q?d/LYhdD0J3f3hLlIVTV8eHRKCgDH7nktHfYmdJ/PwejwARCnbhUGw/zj2VUL?=
 =?us-ascii?Q?WO1TrivFpb8RcAjliJJA1UVucEYoYZtltTEU8jMk9Edur82NECfGqYGc2BHj?=
 =?us-ascii?Q?eEh5YJx07gmdPqoUYT8mutzP2qfaUkUR1gpQYTMFFKpcjF9dNZpeq/i5zC7x?=
 =?us-ascii?Q?NWo3GeCv9YVlTuGTTJUpivhFzAhmxKN74Ju+/udEEGsl+pQheOL78Bm+kzKI?=
 =?us-ascii?Q?maIoAHJ3VoT4jTyJFB8fo25eBBuq+HSOLPR4Oyen9wn9GtEj2CrDQ4Oy1iuE?=
 =?us-ascii?Q?UYve7kxoGF6IxebjJsp3C5/dD0XuT7mccE2dPg/0TGMDnt508pRXupS1IgVP?=
 =?us-ascii?Q?TGzPqYRWKPFbWYLAK4K7kkjwhoL71ooPW6lABDuLmNXApCkS5lK6ZPa5pw7d?=
 =?us-ascii?Q?AqOphoC8/HTl+1aj0kQuYA9Mnp2hQ5NfO6bljQ2P5EQmHRV9hRASPeYY2g1O?=
 =?us-ascii?Q?pqaCe3m6g86/CySqSei1yqltbvRUJCoFsUSiUPVsh+3Q9Jh7K+On0/wBFd26?=
 =?us-ascii?Q?yfROHNbpuCI2bEja7cwQn+vi8PBKUpsbx1+8WJwzHEx8bCJ05kcxFqFG8QcR?=
 =?us-ascii?Q?WNVpY0/Fh26mBU5nLWauzZnPMvt9Re+VC3UlPwpyuSygarYTBQ0G5HBM1xL5?=
 =?us-ascii?Q?c9MTUp7Cu+2GcTVPHuvxvkpwMjcQCj7p9ohRHd/B8lTJrPC4XMJ5V0aQarXD?=
 =?us-ascii?Q?95RQe3fQNlChH57eCmiyPC9K1f0FYtQUPEebZFOL+90rKF0IXIhDTMurmELZ?=
 =?us-ascii?Q?+7pR18IMAxOj9e4PLxmCU1QLbJd7ciaYmr7uefgwKR7Vt5fHx0HiYe7pB9+B?=
 =?us-ascii?Q?VBD8GdGDGHHaKtyCvISsw8sBsOBcNttm33qbjbTUG/VeRs6Nj5yXSOjvd2l5?=
 =?us-ascii?Q?r7vl5S7Fxe504ZzLbawMT6Qt+rH5tOgefcmVQBRERoKNLThk8jJ0+xh+j/E8?=
 =?us-ascii?Q?3f9TREf6hlZ0glMMj6gxjf/yakpe6X5TOTCQDcXI5i5gTRp6qmyIZ7EJMY82?=
 =?us-ascii?Q?gpnKPb9CS7mVZD5ArvmouF6SLHT+EJNbHKDOH1hb/8V3jqqITqyHLrYhSsQw?=
 =?us-ascii?Q?5wOqjb1vj8oHQDu/vr8oysDqEsSKHY6f6obL59VM1N3V1qLRBZlB2M5aI8Za?=
 =?us-ascii?Q?/oyntPPXKUU5Hr4TdVHCHTPTYYGkGhrCRKc/T+Ys3pLvk/2KfkY8u88sIjOj?=
 =?us-ascii?Q?Lu5cKtunXNpCJ5CzJqsPRiBpAkpLjrtzFtO7etGJylLp6916xDRUqKBK8pNK?=
 =?us-ascii?Q?KFQoy7aaGuLWoa8f+EuvFfU0g8Ysx+D1A6f0RMH/TG6XEOvUMaGRjAGF+ozm?=
 =?us-ascii?Q?FWpERxnv+CsaLFVxPQPeUOyr8KMtfHpanD7HQ1hTSsXJXMr4/bnzEx38PELK?=
 =?us-ascii?Q?lOyFfEXcn5ljOoe/cVBMiQ/oFJwv+RC5X696enP7WHXNVQ+TYHFNeHSDMQY3?=
 =?us-ascii?Q?4I+mwFSHlnEKfnxg9HPa52t7TVQsh8+eShXs?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eQj2AgwbAPOf3Rnv1J/Wf8ZMYLKvdZhDr1elFw8QRd6fPi0KDAcZqMhbWjscxBSJwfemya2wohTQpTXjtJcWtfqPk8YueMJ4lALCpxGSqNaT+nJagP37/6BkwxP/LBIq5LekIhA33y3J0v5DNXjQWFbVNvK4B91JSiKOxjFZXPU7hjt5TaMxnxQqR54E+7lNeCi0z1Nuil/SO5FaueK6w9ov4/46+Kuq/VBtFTkhU0MQbansffOFg647UQuE0P5fkLqSFU2PHAj2kY+fGLLkM6762f/TTg+mABs9D+DoUJ/Y6AH9lD1xQwurLkimo7CnoGqV3EZHb1CWU2kmT5LdPnTs4TeNj3mO5jC0kNOFkpXI4GUo3pfOkqp4CpsJQQpx3gX9LTT2b117XnDfFs6TRMLTgLawQoxnK5hE4cvi/E6lLDUEArTQrQEUqjPBaFTRMAfUFcDDHDrWup12+bQWdKZ+UqJVPmwfIwigSruVygVlgR7icn8+P3yafQgJ5YjE2exMYNk4ggh4OfOpG7Ca3xBELk8suI+Cb162S6quxmk5Osh6G40BEedg4+WeP3iYqxd42xPDusedAFJcT9nlr6Tfw7UByb0TD8IrhqFZQNA6KKtkxBJKNz9kUEvH6amt
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 07:31:38.4841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017047d2-c2a6-4125-1e8b-08ddb7a826de
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR04MB8950
X-Proofpoint-ORIG-GUID: W6Q8rJrQ_Tcx9zFXYOBbzBLGtcnpKjjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2MSBTYWx0ZWRfX4w1oEPw0hYWR afo2xulobcV1KqZ6d7RRYFUfiTajtLObwZqVWiO8xSilVC00WYoqlE9akj9WSnOj+EuF/pPs76E BhtDj6p9d32n09MIzRsPInb/h+9IuBduvcdJHtNNbdD1mj7dh22VQO6CV+wmk2mQE7MucbZ2RUK
 WQKRMCgYIcOzPYbXsznpK/lADmhXXrMkocWruGsMcSpHDmkTn3S8cmH4k3QszmUjLY08le5+idD HqdQK8ZH+TT9rjuSWhASzI8IoOJqDdlA108gztzwqYoV7sNN42FFpuG/fuPDHwoSvA57CKV86KB 2O5a5OZD4Kz61QH9x0c34xhg5Bw7giPtszPrbfQQA7LQ/v+UKwjNoTbvoCBrNumOWVJ/LI2fTIo
 vDykXTwuPdNJsdgbGlAX2vDBgzPx8+XOsFg8HfqjQC4Q9Pc3WsuUnL1juFpRtTwsvjvfVjvY
X-Proofpoint-GUID: W6Q8rJrQ_Tcx9zFXYOBbzBLGtcnpKjjF
X-Authority-Analysis: v=2.4 cv=fJ853Yae c=1 sm=1 tr=0 ts=68623d5e cx=c_pps a=riyPWYh4HAMCiMlNrdWGFg==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=6IFa9wvqVegA:10
 a=4AL28aEVfeMA:10 a=cPYzWk29AAAA:8 a=u2kzlEoHWhBIlCB3pKYA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxlogscore=802 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506300061

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


