Return-Path: <linux-aspeed+bounces-4692-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC81CC5DF65
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Aug 2026 20:29:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hL0Sq5TsWz3bpP;
	Thu, 13 Aug 2026 06:28:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786566539;
	cv=pass; b=TpaDF/dFl6gew0F18q/zMrf0PA033hNd8ViMHkDSJsW4TaGq5szKAWO+BpbMKlx1Dtb1zknGeTx4TB4f9DWD1wb/8intPAv8l2Ahc70GZQwRARExi83ZjsVCzMpQpCNiY8Nw8vphWlgupABGFnwzABHkpPBzCsyZ+/k4fXuwSa8C9BPO+DAwOyMB8BifzY/ffIyaTNfVj+91Vyj5828g6plfAp0O9+L9PR3TtNb996J0QdiJEckMo87ItbcnlEiPRYZQ1xEEzNYbMvBe/22ZpBRO8FcxCcJe/P08MINn8IN8Ii7T9hXjY8XWsAglU+FhPr15mJarTz4sgZUXaGhaXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786566539; c=relaxed/relaxed;
	bh=AoEJgygK8yU8wFFVJke3Dp/TaMeofAjyXN3AYGqFcQs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=huHeP65LARtcbEZd5QjobVu1pjCiof+P5Gk5EzqqUiLLXSfiHldwYo28zmEo1kYxjR5Wsl9xxWu7Tb5IXJeFxBI/piTOO1+wi+OyYwRTfIHS3cTxvbi7U76mcuYVQdQFhqnySJbdDYIqpiPj4cwuayOYbF3CiwjTMOk0nFU24yBdNgavoPRRLyewzPA8v+sNV/K2ZabIJXqKCG2jSLw8ida7grGcJWZ4MoxSdGtAWtxbXww1CjGYB6pNLo0NzSzrValJKzWIyIx36kq7fcUJSKTFG70L6yck4OzL4QllKqAotBBF50XGcvI/sLloy/MeItNhXKaOyMPVaFCwXbv2Lg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hL0Sp3MR9z302l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 06:28:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hscKR4CSjVvT5swl7F7RkiSyW0kNb5FCX1WSlXY7nNj6lee3keqZ6nOCNLY1yIgwiU4225FL3hdYW58eIEgCroWqJBBYQRBKSiFGK7s/KkRDRE6qFQJjTHCeIjxZiFl4Qc1zuE0PFWSwOWUKKG0avnnCfkGr5Ypk77lQkiy9Vy/whEyxki4P9YqjFfTxDE35c0RKCemq7WbRLwpZmQV0pBJS4ptkgxxl1dUmuzv4GZiaMkAwN7dsVgKI1527WBp5R2rq14YIlYYd7TmIAFXai/BN6R/lwioMhd8VBJW0l6Zg72YhZquRj57qfCfDqGrNStxEWdg7l20KA3BbJKn60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoEJgygK8yU8wFFVJke3Dp/TaMeofAjyXN3AYGqFcQs=;
 b=G+sA4z0xM+edND/MWbVgEhADbctRyS2tVjYJ8nXZ4KXQtM0dbdajDnbdj2uCFmM2hbzZLqZkCD9RIjPWv9Vqaq5Dn+OGRBtqHW8m0gLccikQScU1+Xf0SwuOuq4ffkGUTADGigLZwpsGBR4Pb0Dhv+h87uF5ef5H4EMHyvqIpOCmmFwYhpqEVkNNHEGDCixJuuBW2TS+Y/TBqJuHDaq2LxDSAT/gU5E3h0jb2dHljAu2VsY9BzFDiIbLnoDtmAWey+e888Ufxo0hg87sON7/yfM0VSKIEpqXaVecntMq1T6fncrXBdBL6UyqBbc4DQgNFVVUiExA1D9GbRQB2teP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BEUP281MB3788.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:28:31 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:28:31 +0000
From: Tan Siewert <tan@siewert.io>
Date: Wed, 12 Aug 2026 22:28:27 +0200
Subject: [PATCH v3 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ts-x470d4u-v3-2-c8e266f1663b@siewert.io>
References: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
In-Reply-To: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>, Zev Weiss <zev@bewilderbeest.net>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566507; l=10196;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=VtQ62DNDyMeOoREdXelZesfWzcZ2BG537Cf8t5aQ44c=;
 b=biSI/kUbxec69dhXk+Smnxz4S+CzJDqBE5X8exi/OB9w1VAmlAI5hKjkrMqcWRbVBnYtBARcW
 uY3HxFymQSrCdfNPMguIkjZA2CLVpdjR8SXT8MX6Odps4v7QuLArlmq
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|BEUP281MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 962792f0-5aca-4183-c949-08def8b04642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|52116014|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kUNl3K3z8A4OXj2YxbBWuEMIfA2jGMHsNew9MXZ0rMKh5pAcX4f3yc7uwjeWhd1HrDLcjXi5jmSUI9B3g9upEC1ipKOMAHulnbTiu7KprC9pbolPqsiBVlEX+FIk0ZFtZLRyZDQ7yhmfZy+JfOjm2aB29JxnrPM+/mkYFKmAqhDUjQ0HdBVZYIvT0LPGYv7RmoxGKi8KQIkK8/r37C1uzf0WJ9yaORKXpw6AJgd1eEzsl45Lvttb2D4kFhXPvFeei6h6pfBRFa6SOKTvYi3aX0vN5FP3703BO/sb2zAWLIHj64L3/LJpPmBUwh7I2Ut4GFqIlj4bLm0l87UGOiurOzwooqLZo4xyZ6xLdyIa/Xqm6dNqqMabGZZ8klaozKLGIfk7037rOk+kLeCPDmVV8JHF1mp3bimIlcoaiBr4MQYR/AwqkHx0BeWviZb0tMUY72ChmVR2nXtYUcvmh0o0UyF3MoMd3fnig7Ot45XOV3L/N/1F+WMrLkq5PGzL5xDCXINXc6n2qrMNUGK8hSnqtH2WGx+qyuoeFm9AKvy5tSnkfv6mrmzSscJ0N8AEgcyJrJ1miiaDaZvow0xXhxJc8yrBuKQcMv40NirWtrkIo1PqRkZ/fLW0SfC3AEIRkV1n60f6QOEOLFpTEJJfd+0OQ/UHd9WpIjt8RDtQSMameC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(52116014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBnaFRKOFJNTkk2ZjRsaVAreFdLdlNpWUJOVkxsaFBzVkVUVFFQTkJLQkxm?=
 =?utf-8?B?M2orN1g5NTJ1S2tMQlJId0dPK0tBYkV3STd3Tm5iaklZeVFEL0o2dXVxbEtj?=
 =?utf-8?B?N2ZWNVZpUmxROUdwbHpJRHV5S3BQaE82aXZxYjJSQXBJL2xwYW9jd3RXbi82?=
 =?utf-8?B?azJudDhmM2lMdHE3SHRXK0IrL2R2VmM5eEhOSUxSVzRBOTVLU0xBWSt3N1BJ?=
 =?utf-8?B?UHBydlcxZVdQR09lb1Z0eXNuQzRGc1N4WWtQTVJzQm1yMzJ2d211VGY5V2RJ?=
 =?utf-8?B?RXVTWWdHYnF4c2Y3bHRWSFZxd2dqZXpRWVF4WDJFVmhFQk0rb005bnMvMFg5?=
 =?utf-8?B?eDJhMDg4bytncEtva3ptZUNWVS9SNmdBWWdMQkhUclVNT3ltQTN4TEk2OWwr?=
 =?utf-8?B?OHpKeWVHeTBvaGV1L2pBNWJKbjI2VUFsSnlETDMrazdwY2JFZE5mZ0krdloz?=
 =?utf-8?B?V0dOU3AyTTlZbUkxak1DY3NoS3d3UVhKVXVsNFR0TFRjZGpkUUVGMVV0VmRv?=
 =?utf-8?B?RGl4YWhwYU9hRkt5WWloemhNakp4WUdWNnJVNExkZmdid2xTY3h0OXFiZ0w4?=
 =?utf-8?B?TERTYXVOYjFtK3BuK2J0dk43a1ZRd1NsUG5RbmwweWszeWhRSnR2em4vZitK?=
 =?utf-8?B?RUZuV1lPaGVpRUUyVG5TSkRuWDlwREpjRXlHMmthZnlxTXVkZy9lcTcrdkIv?=
 =?utf-8?B?REE0WWZXNHYvYkVKOXQ2Qi9HWWRLT29pVWpERDFhUDU0WCs0b2NoUG15cElq?=
 =?utf-8?B?TTdMSFZqaGUxTlM1UFVkOWhiRmRnbEw0TXd6QlY5c3BwZXYxTnJBUFBPczRh?=
 =?utf-8?B?ekpKL2UwdWJnV3MvdEIrRUJseER2OVR6RXdGTEkwMVZHS3VlMmxJRU1RNmNW?=
 =?utf-8?B?YXlzVEQ2dmJkVU1pZEJqK21DUGE5SW9YdkFSMmdzQks0R0J6OUZWN3hBdkJm?=
 =?utf-8?B?VGJ1Um1wci9rbUVxTm9NYWdBQlgwYVBHWmtoYTB5eHdmaHFrTHVjMUp4S0tD?=
 =?utf-8?B?Rk80U3RieDhlUU9rWFNZUmFkekdSUGtwY3V0VWNrUG90dUxoaW9NMFdyNFQx?=
 =?utf-8?B?azFMWW5scUhQd0o1SG1ZUVB5QW8wNWR6RUFGSTBiT3prZ29MbjBVMjF0b015?=
 =?utf-8?B?MUJlWCtjZHRnY3hpcEVRRjYvVnJrbmtsejk5UjNDR0pMYnhTU0NGdFAvNzV3?=
 =?utf-8?B?eGVZVmd6Q21IZHc2aVhGdCtvU29UNFh3eVV6TXgyemZMRDdmbDRkR2R4d0tS?=
 =?utf-8?B?S0xwakd5bkNNUWxSWEd6U2ZqRVVTeTNGOWljb3oxZk56NFNFb3dNb095WlIz?=
 =?utf-8?B?UDJNL3Fhb29rUUhqRVBaTGtITFpuS3RjQjYvZ0h4cVVSbG1xNXZZNHN4MXRa?=
 =?utf-8?B?L1BjTHVJdVFFeW44R3pyQWF0cmQrNlFDaGppQnZkSU9oUGdMWmtVR2tJSVB3?=
 =?utf-8?B?V0NSQlBjcHBXeERhRnJUUlFtUXMyWW95RWlkaXRNMUlQb0VybjBjcUdsVlpv?=
 =?utf-8?B?emo0aURPZlRhUmNZWWdyalB0MFo5UHJudzBEck80WTI3OGY2bEdnTktwY0Zv?=
 =?utf-8?B?c2o0MEpGRlpuaHV0SEszTy92UkEyUDVTWlhLN0tTaHVSdXA5OVB2dHIvbk5R?=
 =?utf-8?B?dWY4T3ZQWWF5NkVFZWZ6a29DenVlaGRobUFHRllRdkF3UU1VZ3M5elZxazQy?=
 =?utf-8?B?OEU4V2U4Q3pSenNNbStRcEJFeC9sOHRSNm1jUEd0U3Z4eTNGMXB3U255SmNk?=
 =?utf-8?B?aUxjcFNPbzIwNzM5R2VvTHN5NWIyemlKWVNmdkppdnh0anJVQU5LVFA2MS9z?=
 =?utf-8?B?SjRQL2dwajBQNXRKckMxM0ZvU2lZSnJ3blc2TjNSNmJreGVwOWtkM1ZHbDVE?=
 =?utf-8?B?TVpzUjBMOThSUFNVdEljcVFNOVBRYnpxSXBoY1JZaXp6cHpQMjlJWkF6dTM5?=
 =?utf-8?B?STVBN1YxWnVKZ1hjck56VzlRSHVtQ0kxeTI2UkN1VWVWL1pLdmcybFNId0J2?=
 =?utf-8?B?QitnMkthb3MvMmZoaHQrdGlMN01nWDhWQUhHSWRPV2pGbTdMN21NcEQ1Wld2?=
 =?utf-8?B?YlBHZHZ1eElxV1MxN2tYbFhVbFZBR25STVNoYTFZaXZhOGJRelJkNUdMWDRi?=
 =?utf-8?B?UEdISHVBb016U2g5ZjZyRC9rZ2I5LzFYSG5ZY012TEpteXRvYUtNUFYxeUpO?=
 =?utf-8?B?Ly9nd3R0UUk5Yi9SODMrVDVtUWRFRU9kTmVUMVNVelV5ck9JVElkWDlFWENG?=
 =?utf-8?B?S2xENTJkdXhBOUVUQjFmdDBWSHp6cm5BQ3lqeHVYRTR4cjJQRU51a0lSYldO?=
 =?utf-8?B?YytsVEJBRlcyNS9rczBZRmVkZVVobnVuMVRqUkMzM3ZNVTl3V01LTXJpUHI4?=
 =?utf-8?Q?0j0oFzOre+uaJQjXMLORduSl+O/ds9J4DxegD?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 962792f0-5aca-4183-c949-08def8b04642
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:28:31.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOhnAWwVqVCI1FZ7j+o6DF0hAGTz1njHyoCZYByAOPossFUbr+mbQRxYAZoU6Azw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3788

The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
64MB SPI flash.

This mainboard exists in three known "flavors" which only differ in the
used host NIC, the BMC SPI size and some parts that may be un-populated.

To allow the use of the full SPI flash, add two trees, one of which has
the 32M layout with the base config, and a 64M tree that includes the
base tree.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   2 +
 .../aspeed/aspeed-bmc-asrock-x470d4u-data64.dts    |  15 +
 .../boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 381 +++++++++++++++++++++
 3 files changed, 398 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6b68671f9379..e27d33e85fb2 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -15,6 +15,8 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-paul-ipmi-card.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
+	aspeed-bmc-asrock-x470d4u.dtb \
+	aspeed-bmc-asrock-x470d4u-data64.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
 	aspeed-bmc-asus-kommando-ipmi-card.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts
new file mode 100644
index 000000000000..6f11aeab087c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "aspeed-bmc-asrock-x470d4u.dts"
+
+/ {
+	compatible = "asrock,x470d4u-data64-bmc", "aspeed,ast2500";
+	model = "Asrock Rack X470D4U-series BMC (64MB store)";
+};
+
+&fmc {
+	flash@0 {
+		/delete-node/partitions;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
new file mode 100644
index 000000000000..80fb2b7c1e0c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
+	model = "Asrock Rack X470D4U-series BMC";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			      <&adc 10>, <&adc 11>, <&adc 12>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			/* led-heartbeat-n */
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			label = "platform:heartbeat";
+			linux,default-trigger = "timer";
+		};
+
+		led-identify {
+			/* led-identify-n */
+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
+			label = "platform:identify";
+		};
+
+		led-systemfault {
+			/* led-fault-n */
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			label = "platform:systemfault";
+			panic-indicator;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		pci_memory: region@9a000000 {
+			reg = <0x9a000000 0x00010000>; /* 64K */
+			no-map;
+		};
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x01000000>;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x02800000>;	/* 40M */
+		};
+	};
+};
+
+&adc {
+	pinctrl-0 = <&pinctrl_adc0_default	/* 3VSB */
+		    &pinctrl_adc1_default	/* 5VSB */
+		    &pinctrl_adc2_default	/* VCPU */
+		    &pinctrl_adc3_default	/* VSOC */
+		    &pinctrl_adc4_default	/* VCCM */
+		    &pinctrl_adc5_default	/* APU-VDDP */
+		    &pinctrl_adc6_default	/* 1V05-PROM-S5 */
+		    &pinctrl_adc7_default	/* 2V5-PROM */
+		    &pinctrl_adc8_default	/* 1V05-PROM-RUN */
+		    &pinctrl_adc9_default	/* VBAT */
+		    &pinctrl_adc10_default	/* 3V */
+		    &pinctrl_adc11_default	/* 5V */
+		    &pinctrl_adc12_default>;	/* 12V */
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		spi-max-frequency = <10000000>;
+		m25p,fast-read;
+
+		status = "okay";
+
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+
+	status = "okay";
+};
+
+&gpio {
+	gpio-line-names =
+	/*  A */ "input-locatorled-n", "", "", "", "", "", "", "",
+	/*  B */ "input-bios-post-cmplt-n", "", "", "", "", "", "", "",
+	/*  C */ "", "", "", "", "", "", "", "",
+	/*  D */ "button-power-n", "control-power-n", "button-reset-n",
+		 "control-reset-n", "", "", "", "",
+	/*  E */ "", "", "", "", "", "", "", "",
+	/*  F */ "", "", "", "", "", "", "", "",
+	/*  G */ "output-hwm-vbat-enable", "input-id0-n", "input-id1-n",
+		 "input-id2-n", "input-aux-smb-alert-n", "",
+		 "input-psu-smb-alert-n", "",
+	/*  H */ "", "", "", "", "input-mfg-mode-n", "",
+		 "led-heartbeat-n", "input-case-open-n",
+	/*  I */ "", "", "", "", "", "", "", "",
+	/*  J */ "output-bmc-ready-n", "output-bios-cs-n", "", "", "", "",
+		 "", "",
+	/*  K */ "", "", "", "", "", "", "", "",
+	/*  L */ "", "", "", "", "", "", "", "",
+	/*  M */ "", "", "", "", "", "", "", "",
+	/*  N */ "", "", "", "", "", "", "", "",
+	/*  O */ "", "", "", "", "", "", "", "",
+	/*  P */ "", "", "", "", "", "", "", "",
+	/*  Q */ "", "", "", "", "input-bmc-smb-present-n", "", "",
+		 "input-pcie-wake-n",
+	/*  R */ "", "", "", "", "", "", "", "",
+	/*  S */ "input-bmc-pchhot-n", "", "", "", "", "", "", "",
+	/*  T */ "", "", "", "", "", "", "", "",
+	/*  U */ "", "", "", "", "", "", "", "",
+	/*  V */ "", "", "", "", "", "", "", "",
+	/*  W */ "", "", "", "", "", "", "", "",
+	/*  X */ "", "", "", "", "", "", "", "",
+	/*  Y */ "input-sleep-s3-n", "input-sleep-s5-n", "", "", "", "",
+		 "", "",
+	/*  Z */ "", "", "led-fault-n", "output-bmc-throttle-n", "", "",
+		 "", "",
+	/* AA */ "input-cpu1-thermtrip-latch-n", "",
+		 "input-cpu1-prochot-n", "", "", "", "", "",
+	/* AB */ "", "input-power-good", "", "hard-power-off", "", "", "", "",
+	/* AC */ "", "", "", "", "", "", "", "";
+
+	bmc-ready-hog {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
+		output-high;
+	};
+};
+
+&i2c0 {
+	/* SMBus on auxiliary panel header (AUX_PANEL1) */
+	status = "okay";
+};
+
+&i2c1 {
+	/* Hardware monitoring SMBus */
+	status = "okay";
+
+	w83773g@4c {
+		compatible = "nuvoton,w83773g";
+		reg = <0x4c>;
+	};
+};
+
+&i2c2 {
+	/* PSU SMBus (PSU_SMB1) */
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c6 {
+	/* SMBus on BMC connector (BMC_SMB_1) */
+	status = "okay";
+};
+
+&i2c7 {
+	/* FRU EEPROM */
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <16>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
+
+			eth1_macaddress: macaddress@3f88 {
+				reg = <0x3f88 6>;
+			};
+		};
+	};
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	snoop-ports = <0x80>;
+
+	status = "okay";
+};
+
+&mac0 {
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mac1 {
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+
+	pinctrl-0 = <&pinctrl_rmii2_default>;
+	pinctrl-names = "default";
+	use-ncsi;
+
+	status = "okay";
+};
+
+&pwm_tacho {
+	pinctrl-0 = <&pinctrl_pwm0_default
+		    &pinctrl_pwm1_default
+		    &pinctrl_pwm2_default
+		    &pinctrl_pwm3_default
+		    &pinctrl_pwm4_default
+		    &pinctrl_pwm5_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	fan@0 {
+		/* FAN1 (4-pin) */
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		/* FAN2 (4-pin) */
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan@2 {
+		/* FAN3 (4-pin) */
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		/* FAN4 (6-pin) */
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
+	};
+
+	fan@4 {
+		/* FAN5 (6-pin) */
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0d>;
+	};
+
+	fan@5 {
+		/* FAN6 (6-pin) */
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0e>;
+	};
+};
+
+&p2a {
+	memory-region = <&pci_memory>;
+
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash@0 {
+		label = "bios";
+		/* Frequency extracted from original ROM */
+		spi-max-frequency = <24000000>; /* 24 MHz */
+		m25p,fast-read;
+
+		status = "okay";
+	};
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+
+	status = "okay";
+};
+
+&vuart {
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+	aspeed,lpc-io-reg = <0x2f8>;
+
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};

-- 
2.54.0


