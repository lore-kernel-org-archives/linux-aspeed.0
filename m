Return-Path: <linux-aspeed+bounces-1485-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53129C71136
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Jun 2025 00:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLn8V58TKz2xKh;
	Tue, 17 Jun 2025 10:01:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=148.163.141.152 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750066837;
	cv=pass; b=Bgp7DvPjxW0yeUJz//H7HSlikNZ+Gk38oPq+ZozRusHx5KDQHi1XUBb1MYNvp1NmVok3/sj5kNxyWGGyUYeEWJr07CmZWeIz3R05btXlgs++vncSbE80hphqMK14Srv10ayUtrmCFz7vt6NsF/D+CE3i4H7mwi66YDTuFiftdJuV2LWpWm0S6C8maHdepRTtKztV+uS2WyDs4i0XgRagZT1UGyMI9pGU1pM5LQ+Wi/Z1X8Kx6pM8q1SG7Kbv5SILFDGviqY4TkD2VbOMEHAl9JMCktMt1sSfN34ZIP9smeUUrgS4jNf+6/0eHWulUFGjAqO8ZgNpcWXR7e7TuClv/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750066837; c=relaxed/relaxed;
	bh=lY4tRoNk/eY68a+Ymm8sqTpoYioW7Yn2xvhNPhPrCAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nq0mOd4WUgt3hrycFPVYpUEYPjtfoqCL6lJxNyq6AsUnbkHryh8SN5Eexp7bOoo7ycek1iMrwXUcP0jl0Dnb04c7BMkSZTjMc4sFKCZ/IOo5v+8htQ2UZTCmGA2yo5a8wLcmNkUraHgG0mV+SrE08DKR2b3qHf/1rwYeZ52P6lcAEfNDtwJGmgRkeSNCTXn7O4XVkwdjV5No3fXCCQJvk/91Yt5We0r1pGigPcMYF15HduKZgB2Jt4piX53REzSFQ7TCpTlYE510NTp/Z2N3q/Nnq+bAVSMWMokHkpR9K1pMB8D0IaTjoTf8hsE7hHqB2tyhUAhd5ZcpCTSb/RfXUA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=DONpaDgS; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=Dc3SFebG; dkim-atps=neutral; spf=pass (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=20250420 header.b=DONpaDgS;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=Dc3SFebG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=148.163.141.152; helo=mx0b-009a6c02.pphosted.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1465 seconds by postgrey-1.37 at boromir; Mon, 16 Jun 2025 19:40:33 AEST
Received: from mx0b-009a6c02.pphosted.com (mx0b-009a6c02.pphosted.com [148.163.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLQ3P0pNNz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 19:40:31 +1000 (AEST)
Received: from pps.filterd (m0462408.ppops.net [127.0.0.1])
	by mx0b-009a6c02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNA2vA029271;
	Mon, 16 Jun 2025 17:15:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=20250420; bh=lY4tRoNk/eY68a+Ymm8sqTp
	oYioW7Yn2xvhNPhPrCAE=; b=DONpaDgSQD1m5qHUhPNBheu76bNf9FvLsj8rF9m
	FuDrshgt3aJBXOt53Wsq62CJLlmtFUCHNk3C9Z34jvBWRlgcCIUBOz++7QKQbkpO
	dkTwDsqtUlqXAvVW4JwbOXh+UbyOkbnwUIh/L5EKFyNxJtO0k37vBWy1087h85T4
	Lwp3FJoRCFNO3J8wwJHl6Q1nS4GsBUAuLT29PcSZQOMYEyuWkLfOR2fwLgI1eItJ
	4UMV8B8PDSyJeTKAJcy8GV08UqOinrJToAQOM+QwcfSyAlkBopmZ1ZnjfGTTSFVF
	o7A52lrUY5gMx8sUJwJrN5XnDeMHdA7yE7spPT/SbfYI3Zg==
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	by mx0b-009a6c02.pphosted.com (PPS) with ESMTPS id 479c8p9cwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:15:06 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUyaKnP9zfwPIL6ZO4HFOIOQd5pTPW37etg2m77GBaw6vuVK1UD1g/tnQyujxCC2Kc9QXsfR8gYkohumks4rE4ycoWQ4MFZkpB0lwk9wsv8w8HPRMAE2KzlGUhPJytzqIh0ji0Xoqq/GErzo+Rwy6CLdlPSG/eJs6sswiiuC0IowioiGmZ4H7FA9fPTC8lqcs3oRTF3qk0JGM8+tA7dXuNAhlvi/4FycrFO6iFjijhKU/crhM5QO8aXm/GLkZka52eJtMWNY66C7Q4JqZXDxMf0E707ePO8uJ+gl6gKYXDrL/uDKmpqL1M1XrAfml5j4XMYTtk42fvRht89cWBweXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY4tRoNk/eY68a+Ymm8sqTpoYioW7Yn2xvhNPhPrCAE=;
 b=TY6WIItIs1BrnXtoJdW6OBLGiND4GLJGgFvq5kxFBjqvqHH5TDj1NzeODnxBO1wVQdKcvpoNkMuH8HtRo7lR/e5x643qJ0n8w2tSn4A7OV3GgHR7amZMeAcxlai7iI7QYxRYzEMONL9v9N69h8dnHkkuEMS2e7+Vn7m4QjK06xpBRBxcunGtWjBxVXgIJaj1bSHg2XHzc7cDR00F7U5/On6KacuOPY+oHhR8ENeDiJwTtY9bvM2Gtravuw9S3McswgSiTNdxKtUFDra2g1yKzfDYR0goTA5Pl8Id34VgBO5wNXVX1zuYmS1g3pgcIipdf+RNTM9I1Q3jQ4N7ihyBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY4tRoNk/eY68a+Ymm8sqTpoYioW7Yn2xvhNPhPrCAE=;
 b=Dc3SFebG8wdfTNVF3wHdeaPB0jiZzHuVpTeq6rvotwmKw9kWyI63UVyeVqLMd49i6IwOknY4KDRqEm1DaHu4gG2f/KWABF45GZCkfq3jMerImSHLuZT6E6RJSTTjVIPwVaMptw3EsIPzsp6YvQmzfiNY95O1RGgD/GVoQpZU8bM90ZUE1cKi/crAb3W94i7AMG5JvlV5j28eV05vr3Gqh5huleLcrP4zmxI3grgY9oHVU3spvTEKsQQDCN8OEmes4ApHnoF36F4BO4MFPtVn51sNMXq0d4Y1hgJeCxc9u3QWFM5tZC/PW7U7ySQOcGmSupJfj+aoAArjcDXTLsqAwQ==
Received: from TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29c::17)
 by TYZPR04MB7728.apcprd04.prod.outlook.com (2603:1096:405:77::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 09:15:00 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:400:29c:cafe::48) by TYCP286CA0110.outlook.office365.com
 (2603:1096:400:29c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Mon,
 16 Jun 2025 09:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server id 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025
 09:14:58 +0000
From: Marshall Zhan <Marshall_Zhan@wiwynn.com>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Marshall Zhan <marshall_zhan@wiwynn.com>,
        Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm: dts: aspeed: yosemite4: add gpio name for uart mux sel
Date: Mon, 16 Jun 2025 17:14:55 +0800
Message-Id: <20250616091456.360388-1-Marshall_Zhan@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|TYZPR04MB7728:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 884a3514-4189-4bb7-ffc4-08ddacb644b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avmVhPjBM41LPKqd1SB27mc25gGMVZUObjijWsp62f6k3f0CQHKYtk7X589f?=
 =?us-ascii?Q?ONQn6YeDu03h7D2lzvRewOCAPW7GUnK2Ok3CcKBZj82UkBJei0IdFvA+tMr5?=
 =?us-ascii?Q?c6fM6AzQMFyA9WADGOHx7yadSHbQXLdNFve8wdCVua6NI1XGsH/mDY8jvmRH?=
 =?us-ascii?Q?HnPQ6aRceo4+1c0jp5PEiVP2EWppJ9APX9roPdDgxrSeSubvp3VHUKo9fQUj?=
 =?us-ascii?Q?wgEYGBDLAWEmpi2U6Wylga1/xyZZPzrpqmiKWPZB0x6bVM/zekjBBHpD53d9?=
 =?us-ascii?Q?nQfdfEtyQhh/HxozN6EouwDrTMYDDC+hCiiNwjs1EWL7zoW8N3ehZTPNzDdJ?=
 =?us-ascii?Q?Emg+dh3RfD6WtPYoaJRUV2CFoK8zKwNA+EynwPDE2o4SPeeE2XzFj5FjMJpQ?=
 =?us-ascii?Q?M+ATo1cBNvAK+wyVBrzw/RgNMIwJ5FapsKWl16uyP6IQIsePpJw5oac7+Rdr?=
 =?us-ascii?Q?a3uB7KEN3Udlb3w7LAI5UX0BwtdNMKBfmtOLov0ePr8bpRglyAf7U50Dmb9d?=
 =?us-ascii?Q?KEw/uChMzlx9e2PJBuXzBrkiMuzjOAuOtEsZWgis+kgrLIGx9cUh3iUMsgfQ?=
 =?us-ascii?Q?rqlWSD1hcHBj3JviC7aqTmeLJm8TuHc3W7s1vAZUlP7pWMdAxYYviGCrVy5h?=
 =?us-ascii?Q?3/QtahSTFI6Wn64J3wLUZc/2ymScgZK+BQUPQiHkGeo8J1jpWWNXtQGbEgVr?=
 =?us-ascii?Q?e+AgNIuxa/n925ltqfEH2QobmCnHAVGGKhm9hX77Bug/pK641DTRrISJqiHt?=
 =?us-ascii?Q?SQLpKBZkIELGdtE6crStmEZWEOXSJBiV0df4mWS5zU3/QC79qU+Yn8cE9raj?=
 =?us-ascii?Q?1ZGp3urJjtFlYC6mFgX1XPHo1pmR+eQlOwhqOR56piWxChgqjlcZRU5LnmIv?=
 =?us-ascii?Q?0i2/YXJNI4SIygMJMTAuTeeDbI1gOJCJxW70rzo01zjAgZePzZNmjloiI7Hf?=
 =?us-ascii?Q?EfTjrBmoXRyoogsAIhYMatokC2h+hd3xzP3c1jGKpTGdeVec9fdvR54k5tz+?=
 =?us-ascii?Q?TJlO7NUzsWyTPTiR0YRgQot4xUOVQls28rONLZoAOlm4UJPCpeIEjj9CL24q?=
 =?us-ascii?Q?wNCoq1Iv9FxcrEIs+9M/17gs5nT8eDv2mqabFMarzfkT5Y3tWweHxKQ1Fjgr?=
 =?us-ascii?Q?336WF08mVyNt4JqbTvmJHC/4yQh4aTOHmohxO5+8grw2dPLOZQQ2LiTJM6pz?=
 =?us-ascii?Q?RHN4hV7yBHtR0+lzYdd9DyfhmetvliaFHLJGq3LDXMuUMKjcMRxQLOFxeH1q?=
 =?us-ascii?Q?kal3K/d1y/CIGsnZ3DwDAWV1KRBZ5qXFCLU+UGnocZa3apmgv+2bm7fZCSWC?=
 =?us-ascii?Q?s3/Y49KDh/IZr0WCQoSG5dvyePahtuopP/WRlhaZPfF0UpbPWy/HZr/H4vXH?=
 =?us-ascii?Q?iRyAKrbaVRof6BppokBfeXG1OC17ZWkRK0oJOwUP7b3xZNmV0icUD4mzjuV6?=
 =?us-ascii?Q?pmfqOhy0jO164g3MVN74+gDbjuGbCQfKmESkZ1K7tIiLP7F1Z/kzEhJa3vmH?=
 =?us-ascii?Q?1N4Yg5LslkkFEdQaKyDgnmJsyZxx/GDzj5Ap?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	II/jeTvi59zmuYu5XCgvoogfLxb7nEFet4ShZA7i98XLWnsQ+IWtcT5mVyLjEiBoigWmtrAzgiQJi+oGwRXQ7jk8OqqHy4hYhmrt+vOIWYmXh37e2B6lvs5bi8eEQlFJfJa/iqUo9l8C74ZKTZv3/pknFoC7mcwtEJ/DY83yVFEmSx/S/3NJbcrH/uWtk0MJQzApLFaYTzpVhU0zHKDDaQboYv7xHQ8RLX/YCCVQApeOSlDEPCBVq6nsHz/KBhHuYdgzsurjwg4OkSXh6ii6BuXBTABrMyJn6VA584+tPKK755gu2mDGRS/wh9Ihyq1oNrcXeVnLwpxn+6JQXb+k1MPlwRMRS1z1bRu7REvwWakhR1eugHh07Tft/oM2GyBOSUOAKMDoenLhAv17Bl/J/W4vuFfSd4wNh9tDsK3YDcxAhnLe3BEBvsThJXxa60GlgjQj+SOl/CxB4wO/S8YypGy5dPqOwjen6gQ+TBBDKwcrr45jwNL8rD2gf0e7eop0H3gGYJCIh7qd0dY1melW5H2DeX+8OQJ+4E8NX93QP7nBAJcaf2qKVjOdLifx4UDcNdZgJjJRa1B4QkCrh191ssyxZWHKo0e38L9VV5H7T4O7UBRXBtUNC1L27Ee4ZDYO
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:14:58.8105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884a3514-4189-4bb7-ffc4-08ddacb644b1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7728
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2MCBTYWx0ZWRfX5TBu+/3lWU7z RLatCViGaRzuRIxQuRNsBJSDIwXxmQ9Q2hLnSxlg7eeZl3I8Y7dc8sljljGYzuWCKHx/P+NinFJ zErlKsnlxsRBPJpEbF95KFypomzd1ZZU+LZOesbcs5Cfels9hFRXGsLBF1hehdhXggUC5HduXRD
 RtpLocOEtB5TBUfRh2P/UQSTU8Ws8lSVlX+AnXLbO0kAPdvKqGMfv9Ho8uV8xN0bZ+4UtfgspsR 1fZoXWTsPMJ0rAcUPAKYh27A5lIGvWbTIIflZOcvPXVxs4s6nLpTy20zOPUXTp3jiz158vWFRqY wR8QlQESOpo9IJOa3QyitCjt1fTDa6OGbPT91CEx8Xj3tX/raGweFXPoGMKxoSOcmSCs6Qq7pgo
 y6pSVZio8V1cULbu7AQUtfkAlNQdwY/RRFsHLpfLJSAXn8us50ejdv4m0HlK+nVodFvwj4wb
X-Proofpoint-GUID: ib88x8QJK4XdhIr5Q6t9LP24inT_YULf
X-Proofpoint-ORIG-GUID: ib88x8QJK4XdhIr5Q6t9LP24inT_YULf
X-Authority-Analysis: v=2.4 cv=f5tIBPyM c=1 sm=1 tr=0 ts=684fe09a cx=c_pps a=MMwkVYOn1OVg/tRQMohirg==:117 a=6rDDh2uRNVCE5HFPCIqeAA==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=6IFa9wvqVegA:10
 a=4AL28aEVfeMA:10 a=cPYzWk29AAAA:8 a=wO5IlNbkM71fJ84Eo3gA:9 a=oSR2DF9YFqZEN4IGatwP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=923 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506160060

From: Marshall Zhan <marshall_zhan@wiwynn.com>

Add gpio line name to support multiplexed console

Signed-off-by: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
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


