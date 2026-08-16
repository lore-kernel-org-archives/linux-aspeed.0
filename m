Return-Path: <linux-aspeed+bounces-4730-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CBEC5B572
	for <linux-aspeed@archiver.kernel.org>; Sun, 16 Aug 2026 11:07:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNCpk66bYz2xwM;
	Sun, 16 Aug 2026 21:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786878430;
	cv=pass; b=SeMPgkl+EP1J1QOiOfJuu9Vj5GsjyZHEYYzG1wDF7YLvkzas7FqIqGLoI5q9Ej3Sql9TpOXw2i5SDRA97dmjXPzuXrts+nVgo3pKMAo9ykLWrye99ruk0U+rfjAVSWLLGqn4pBSgDW8JK1O/VI6tT7n5HhIibzbBhkpPtMiuuWaIvuHv+8fDPXeSMEvnnB33I0nISnrT7aSOEtSTGFwAjIA5AwDvQs4hHFYXQHA78FurqBcFW7HM7nQkGF79c3qU2gKN7qUEqTSV0GNrr0R+SbUIs/fowJGR7BCFSS7KYWAlxToPyUxaZaIAvBy4PuVdRgViiWi3Ccugn5natldwxg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786878430; c=relaxed/relaxed;
	bh=4MpBqoEeUfjwKyRAnaSUkKB6xiV4E/bMzlb+3W4sPiI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=htl/G00K5z+qV36JG3CZvm2lCPxK/TI1MY457bhSHBhqvUDdqNWugNC7BS6Tks5OvJrHESXv96EQBXNY4zFth3vOBlH0Lq+TXvFPuyQR9P40CYvdqyBRKMm+FDF3ikD8vinKEIzzSFrftxJ6UP+m5OZrLZfN/0zdtiV1BITDIL+W1+WNA36uge9/awdr+U/RMeu05/YxPrlrXrHer/XfTRYnhZQpkYe1z5XtoM0wcwbQqDK0tDOSKoqhmNIWCDhmP+lOQRfpo7xMQopq3a4klFNfNnxAjWxvZ6ugdG3qufVKB0L2iMTqYA8LxYJOKvebjTk2CIhY/Jg04o5hKTooig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNCpj6L2yz2xft
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Aug 2026 21:07:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGbYuVSaSVCVCUn/klnlBKMzfMirPNN+MGlR9DoUe+LjxMwddIWVPSn2zDWGw+FzmBSMj29LqovMsTkHBc4hXhYFLH63lhqTO4otVS5MpeLnreOGs8CiGOLL/W2AUhh9A/ol8ax9DVWtQCCL8EA0+DUEZPeEAQ3AgUa5FSjOjAeue//EacIzizh61j1jrK+8bfKiNb702e6FI/Rj2pvICAXeOCO6Y0RTIe/PGRBUMwUk1smKAS7KXv4jMA697krdU4pifFeOBNNdzvIVVab2HJH/31wuL992zqyEteHynVYUxXj80vgHMqipIyRVv4QHN/LTKIdC8XYzBcqfDEX9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MpBqoEeUfjwKyRAnaSUkKB6xiV4E/bMzlb+3W4sPiI=;
 b=O9ax/KM6Fy3392IdnIOcchnZ6ZWuQUqXQP/kGHdIvT+vlcKtszO5T/ls4/TVpvFYudiWsv/lwYmCPiytuIaFpyFk8b3VPEuNCbpt/ujeIaHg/vO+qHXfvoBqMMlDJg3baqQs2nWiNGlyBmQA5+4woMA+MX9ATyxV0BuUBUIQSmsHBzhIwnULB08/l1aIgspGpYYO/cJNUED+TWSyjMxduC0F39JqTII3OtS53cUPES2wiFck115r+YMU0c/Vizh8vY4QAdqRphsY9k7G27gY0nMdTclfWqsoOwGWhNYyBMonGPiEE+bko7XE6K/hLaE/L6OTTcxR+bndlX2NAV5gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BE1P281MB1794.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:16::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 11:06:45 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 11:06:45 +0000
From: Tan Siewert <tan@siewert.io>
Date: Sun, 16 Aug 2026 13:05:49 +0200
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add ASRock X470D4U BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-ts-x470d4u-v4-1-cd08e78287ec@siewert.io>
References: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
In-Reply-To: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Zev Weiss <zev@bewilderbeest.net>
Cc: Tan Siewert <tan@siewert.io>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786878402; l=923;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=hY2/VsXArbUzX3L/xwhgLoRl4oZaSMosCGn1653JRN0=;
 b=bE12Wmc0e8aoXlb65rqijVCtrhusJicpTG4WUQuzFTVAlmgNaqgFKip51DsYNMswt1K1aBsx0
 KFip9/9p4ejBTrePGspJHdKLZTJN7pzHmmu826TSuIwykSLHVjxJiYA
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|BE1P281MB1794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a067002-4f7c-4f05-d0f6-08defb8675db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|7416014|366016|1800799024|10070799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	G+iqe0DLVgcukgO3tyzeOD3rgVDb4qtjt5VHp7q5BNjXS3IlZ8clKZbgWLrSpw55jQGfKYokS+UbiiS4MFZJcuUOD0AX3xL9Bvt01MW4sr9uTHj98BXYUhxquRALLMZ0tUnWswzKwE3yqtpdDqYAg1GSokP+QsoucOTZ9zYVZP5qU3COAdGR3AU42ugdPR0oYz1tcJ8sIbYHOXUm7DXYBPglmTbTGVEId5oDCds7J3XDj2EW60222bQRBBwxopTd3C7AHOEuOfSX2Mu7g9BbEvbfoARu80Lx6zBtFH71I6LpUGBBonadZVNgu5UVeJFE8sSzPH7MHPWj1WV0xAaOhu2ZMeAiCcgMRGad+BLht32XLQDbmeAG5zoS2gYk8agM9tzCJPaM9LuA54CNaODiQfrSMIAx/RS1ft+twSxltTbQSXu2OhumpT8MqDKYU3+EvGGkmhk5AZRnfcihvRhXwcjrCBl5FtRCZPAJC0dNvEFwJ92qyH7Y1Pxx85aSrDmoLnoRDegheHYRGQcemjQ2pIPh0qEQcNXB/99Z6f4Gi67SfoPrzT93dxY/x45cKAktR/D5zsgeSfC42mQbK6SA5nIc13XKyRgTLkf4L8pBYYWOTWsMucI92sSCeN1Tb4j+aSW5fMdvja0kthC1ELllt0VRETIK5zTK+u7re2VvN54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elhIUVhveXM5TEhqOWRXTWRqbHdQTkZLNUJ0OGk4TFpReFplTDRtN3hRR1R0?=
 =?utf-8?B?SktwMTdDZU16MU5Qa053d1JIWGkyZGFnYmwrckVobHdFNW1YWWVkaDI0bFRY?=
 =?utf-8?B?bUE5MEVJZmxJR0RrVTJVWUVsNWR6R0pzMkVnQWRiNGhkZVQ2cmRybnJuanZD?=
 =?utf-8?B?VjFURW54V3NsdXV0dkhORk9qM0RrTldndlZjRFhoalA1THBKR2YxbWtoaFBH?=
 =?utf-8?B?Q1ByejVNbjA0OHhOUzFOVGl0bE1PWjdadnpkUGt4V0JhWFJ4RjdOSVB5Mnhs?=
 =?utf-8?B?VnpwZUJ3R0l4dzA0VWoxdk15ZDVPY082bWRwTk9EUzIySUlvSFVOTXUzK00v?=
 =?utf-8?B?aDZqaExmaXNqdzk4WXEwMitOQ0ljUVJHc3NIRXIrKy83eEtSbUJVYm9vdTE0?=
 =?utf-8?B?WHRmVWtqL3RKemd5SlROUk5SVktoOXlQbXFaaWJOa1hmRmdxVm45dUc5Uy96?=
 =?utf-8?B?bmY0a0g3S0JUM2tid21JcEM4MUYrQ3BnQ25EbE83TVZPM0JIanhmdjd4TDZP?=
 =?utf-8?B?c2M1Mk5aa3pGR0ZVNEFXYUovWHExWUlHcGJuYlMwYk1DNmFXNFYrUS9qOFJo?=
 =?utf-8?B?ZEFsOGxsOUZ4dWRuWms1dG5QK2ZIYURXVzhyaERWL1BzaVNJS0l3YjF1OXY4?=
 =?utf-8?B?VHVFL1NqM1BqbDlsY3N0SDdDV0d5OXh1WDFaTzJwVERmZkF1WFZnckFvMTkx?=
 =?utf-8?B?ZXloRVluQUVqSUtydldkOHZ1UW9jWmFES3RYSkdVYXV4NDBqMDdvM21oYmJQ?=
 =?utf-8?B?U3MxYUNOZUpxZXFoWDRUbXFjamZJeURPQjJyeW1Rd1liMUM5NnZNMWVJRUV2?=
 =?utf-8?B?R2pXZXlqWTRsY2Y3elBSbHUvYVJ2UmV2cEtBVlZwVjZaT1FMbWY5ZzFZV2JQ?=
 =?utf-8?B?c2t6SzRTbVowSm1XMVFJK0ZNTURLNEh4T29RRHZxTVE0U3Q5T3B3NUZnc0N3?=
 =?utf-8?B?MUdkMDdWRjEyWkl5S1VqQ245V2lybFh3ejJ4NkQ2L04zZnljWHdaa1ZSdTYz?=
 =?utf-8?B?Nys5RFVSZWRadW43WjFkV3VyVGhZTGQ1dGNxTzM2ZUtmSUk3ZjN4aEVHOXhr?=
 =?utf-8?B?K09rZE5kNVlsMkI1NlI2ai8rdFFrRElkb3cwL3J2aFF2SGNqWWxmMWlLQUhy?=
 =?utf-8?B?WTh5K0VWQzJiU01XQTY4dTloRmhXczZlTWRML2N3dDcyaGh0RWU0VnV4aTBy?=
 =?utf-8?B?enlxSTdCZ1hkejAxSGFTa0FGU1k4Mjk4Rkc0TTZtM3krdmsxYmU2NEdEMWtJ?=
 =?utf-8?B?M0o1ZmljbWFYZlZIK25SMTkzVVVCZHRwWXZKWWhXMTZXRzZGOGRUd0poREU2?=
 =?utf-8?B?dVBKRU8rbmlsR2FOUnhMSXdKWEpHWGZwTnNWWHFrMWE5ODl0NXNIM3BwNGYx?=
 =?utf-8?B?bFpOU0g4Yy9QV1U2OWc5N2N5aHZ4d2IvQ09YRVlHN3dJUVhrWkJ3MG4ySFNa?=
 =?utf-8?B?WkQvbTNYdysvR1prYi9YT0tjc0VuY25tRFlLczE0TFAxd2hSZStpVDNlQnA5?=
 =?utf-8?B?a3pGOEhnd0lZb29WcTk3Wk52bXlNOG13WFE0OHNVUmNTb1VRVENMenhlNm5E?=
 =?utf-8?B?SWd1MUQwcnpwUmxrcS9CRWNVUXJFdURWWkpibXA1ZVZ2TWxYSUJEQUVCR0hH?=
 =?utf-8?B?UnU3ZGFHbDdDVDMyS1lnL2VBNlFTY1lQVWd6dzAzcWxoRVhEVnRjcUR1U2x5?=
 =?utf-8?B?dDY0Y0kyUjhTWmxDUTRkUUhPbnhMWEFXVHJGMmIwZTBqeXFIQzFQdE5VYjBO?=
 =?utf-8?B?ZFo0MklxdUlGZnRkVGFJTkJpSVZwc2xZbkNZZmpXeS9pRVhhcU5iYlRmRzZD?=
 =?utf-8?B?SlNPTFZYKzlUNzQ2UTMyeXphMUdqZVZQNXZmNFNrV3FMOEZwN21pZFQ3ME05?=
 =?utf-8?B?OEFEaUJNUGRqRnFBOHBnQ2xWS3kyR3E1ZGtKZ0Q5MUkyWXFvMXgxRXI5U2g2?=
 =?utf-8?B?ZkhHTGF0dERTWUtOenRVUGNCZU1NVGd0UG0xVEJXY0F4SUppVlZyODRua0Fh?=
 =?utf-8?B?emlaQ04zSVFJZ0UwOXhjRkhnUURObUxwYUtUZ0FsaWh2Mm5NaStpbWJPTmk4?=
 =?utf-8?B?MFBKVTE5V3JvVkVJK2Z2TWVpZDloUit4R2Jrb3NreHpscFY5WXpRTXlvSm53?=
 =?utf-8?B?SWNpL1RPM0ZYVDNQVUtlbzR0Y0hZbUw5NytQS21hZVF5MDRkWWd6QUgzVTdD?=
 =?utf-8?B?V2dSODZPSElBVFlxc0NmQ3J0UkltZXR1NEZqWExOUzhqYjY5UU1wdVI4cUto?=
 =?utf-8?B?NWdJMHBoekEvdE54YjhmVk1SOHRkclFEQ0NEK2o2ZVlMS2lmWG5NdU8xT3lZ?=
 =?utf-8?B?bnpNTGxFWExvK2Q2SjV1dU5GS1VFSEVKZUJXVWNEUVgwdHY4V2VPZzRoWVlh?=
 =?utf-8?Q?+IN5PoYFzTqlAnEwUq+EKE5YEyL2hvkcA3FFn?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a067002-4f7c-4f05-d0f6-08defb8675db
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 11:06:45.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY/6kaw884oxIURxmn46AzfFKmUKSW71wBNHyJQ28uPe4v7o8qhM76b0+Q6dwcEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1794

Document ASRock's X470D4U BMC board compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tan Siewert <tan@siewert.io>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..277c0e03cf48 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -40,6 +40,8 @@ properties:
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - asrock,spc621d8hm3-bmc
+              - asrock,x470d4u-bmc
+              - asrock,x470d4u-data64-bmc
               - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc

-- 
2.54.0


