Return-Path: <linux-aspeed+bounces-4732-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605BBC5DF6E
	for <linux-aspeed@archiver.kernel.org>; Sun, 16 Aug 2026 11:07:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNCpp4GzMz2yD8;
	Sun, 16 Aug 2026 21:07:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786878434;
	cv=pass; b=E36cBBKbmIRs94wyoGm9NLLDF8JfZaPKaO4BPTrBAa8IY9v7VX2K3rleSK/kix+mMSd3RPpOjdmYuSdD8KPXGAefWStNMtGxpHJkPws0xoe231EC+fsPpTyQkTQjbNVU0SPMWs78lUhjPyjQ0yuXmnkYuLA7KSDJbdPeknETc6SOky67fdLGlRkC67RyG4s/6IsMLYPk/t0+H+22Lm1kJpxlhSWRfhRSH9Y23j7f3RbcBjGhth2DVIM9IvX2Jw4x+nHF9fW0cOyqu5U/zYDze1me50CkcBuMP8/IpOlC+uOwVvM3lOXBAxipCorgqSdar7B8r1rJ5DdxJft1tMtEjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786878434; c=relaxed/relaxed;
	bh=8nTzb4a6Ym0DD96RIY4xaDB/17m23qZj1NTEzOOUPnI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HwvJBhQGVZ9Q31I4+yR3CaSHZkM5AA14P3Z1S4B4aBPPL9d63R3PvI69hnFMCfAugoxHlH4YqCN82Vheb0U+y7rGCN9M0YL4LKMFxyXPYAyCZEzxo4zzK8i95+WjOJSwnaBtvRuUPdFiCOsTh0uasLl/KMyz6Cdjgy3fiuJQhScJ3NG/YfvDjKB95ZibDfaswhixSLE0Rp+VO89Y3MfsjCmvBbOFPTspLrd6m03aRVVv5VrlHE9Z1u8L+1g36tmdWvVT0LoMvXOKAqM6j14UQwSjYWHud/Dba9Iehs3CV+Zc5sBe+DbDWL/LYXCQD5kaRoC8FFSjrYVy1SJ/ydOjRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNCpm4577z2xft
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Aug 2026 21:07:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O28q6zrlcXRZh6vyWTOSY1grrt+XNQRhXDIDM6N35FEyYsnLD7AyDcXZTPN8gUzOVkb/LNw+yn3qwzgeKXfUswQQes9Llw9ouiv8ycSlStdF8IJkSXsypzTAHeTop5EBDvsBwxv8sIhZNTmn37PZ/F2QgoI9bbZrocN/7XKb+HBpt71MtQmyISI7/kzR2XtoDR41irzB+2m7r1bKl8nFnRu9OtTpDj0HxY4Hp1hXpmY5suzm+zSfEl+6KDnpQPYJyEqlj8VK0CrS46NEaCSyY1ceWXIyaniVgdJOSf32fHrjmTvh7FF/hLrn02rtsMpKmpHTJK/q01oRx+T1xEL0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nTzb4a6Ym0DD96RIY4xaDB/17m23qZj1NTEzOOUPnI=;
 b=Gzglnof+8GiQmrzQ2WxLhC7dt6TVYhcgken4pvCYty+xOJAbIqEPDWcHpA+OXP6wYI5VhY3Ktq8MyNRdobTC1noFWG1Q00IpAN0wJIFJFa3yyz+1tw5DXqZ5i/Z1ECGQaibjz0n6Tx+wsbAz7jM2jMnDH7majaTYQox+XbD0PJTyfnCWKWGbVGinIKQHf6l3GTXEycF5dxhcT0uv1IRaod/iBkEcgNez7TsJbukz90l0pBWPwAhxODD+TsDGVkFD4V4cYRbVTdnIm7kA3Wb5HOl0uZTbU1t60InmyjxV3GKukFnKYD3wUZsvXL0hD7sVImdvgDAFX1iiDq4TopBfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BE1P281MB1794.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:16::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 11:06:44 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 11:06:44 +0000
From: Tan Siewert <tan@siewert.io>
Subject: [PATCH v4 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC support
Date: Sun, 16 Aug 2026 13:05:48 +0200
Message-Id: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyZgWoC/02Nyw6CMBBFf4XM2pq+KMWV/2FYCAwyG5C2VAzh3
 y240OU5yT13BY+O0MMlW8FhJE/jkECfMmj6+/BARm1ikFzmgouCBc8WXfBWzyzXdYmlRa2UgjR
 4OuxoOWK36ssOpzk1w0/25MPo3sdhVLvd24ZbIf/bUTHOGovSmE4Yo+qrJ3yhC2caodq27QOqe
 lPHugAAAA==
X-Change-ID: 20251017-ts-x470d4u-54b9e98e4333
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Zev Weiss <zev@bewilderbeest.net>
Cc: Tan Siewert <tan@siewert.io>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786878402; l=2616;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=NQ+9ONJgdnW7/y5q6Q4TsMU3yhWWdtILO4jBrPJ8LXE=;
 b=Cz/MN7vBUpxayO3+BI5YUcFdqNNn8oh0MOBtxgY56Ky8bbMdgI8VoPa2wQebdNqWBz0qCq0CL
 Mfam3yM/ZmXCn9sxK6Uy/nths6HqHa2yzvzPcSVxNLsrnMf++g2+Cat
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 9191ebfd-b2ac-48e8-9bb1-08defb867547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|7416014|366016|1800799024|10070799003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	KJwqIL7zTxQPwLchVdzx1yg5Bh6nWNwyBrs24xfLrJ01CZdTHHPVvQ0b5QQJoSCDNaTffj200V/2x+g3++mZ3aGmGKpAf38tgB3araPbYF9zWEUxcdo7dIrNRVXrNyOzDVOtAn4qn3jYyRN1Oj9r3YbLZAFfqInuQrWtmUz2kBcXDXWYConUO9r1aXCaABZ8+4eZX30c71KbqIrOIQQ6kGn9IbUsKKYlkD+SA9nA5gEIa0V/TxP5exQXnplohhZJQT1rYipvqSlaRaJOa/bAwmRluVqgYk88U8FJ2KzOThCG5yU8Bol8sfay2yIjHXcsEN3l3DLAAQmSmjuBefbdMihJxUa+C628z909E49X1RSuHYVviJjGIuQyG6qHMg8VQuSixv/udsfJdXVg31Z3X5rStlKgbbEzbAET/Vh2CaBtGQIzkcfbzxYnLOV4Wjd0rUj3S2lI6BzSLhLClsi1ztLLFLFDmAn1W046Kc2DYQcSWPmjj6+BpyecMFo5MTMBVA6sRf6XBLmNPaGlQhDgUGio1XgCz431jlTfKtCnqEMWN+YPyNv7bLmyL1r+DRtJ8IqFWveHN3PQPLZfYCEDrNUxG5PHQfNJRblc7QTpOFIECEbHnOAJ0knQVzYsVbpI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmpnZ2pFdTNIR2pDYWIrNkNBdlpHVEdmM3BYMEZhYm1KUDFsaElyMHc1akkx?=
 =?utf-8?B?Z3B6cW11dFNWQWxqUXRoR2tranQxa0hYMWNHNzRhV2Q5VzdacU96dE0rYlky?=
 =?utf-8?B?SXhvazhTWXVLeGVaU0F3U041MERSRSs0MlYzbi8yYklDS1hlOEkxV3lhbW52?=
 =?utf-8?B?OW9zMTRadmNjOS82Wnk3OTFHR3lqS2JjMlhjU0lydkJDM1BlWVlSTG5remRp?=
 =?utf-8?B?U2QyZkxuNk9TYkpEdTdWSlZUZEJKSnkxUHQyUWJRcU9qbU5oWkxTSWQ4T2Vw?=
 =?utf-8?B?NEg3SUNlZDN5Y3VST1Q5WFN3ZmJQbCtwVngvMjdickdSeWZ1NUdPZFcxQkJO?=
 =?utf-8?B?WUxnL0pyUEQwTjgrSzNPdG55dmhnQVBIcW4xbTJQZzJLL2dJYUhqaXVtKzRz?=
 =?utf-8?B?UU85Z3o0OFpnSTRqUnJzb01GYUZiZ1NMblU2czNPL0lvRldPZStzTzZTT2Zz?=
 =?utf-8?B?VDNvL3Axc0xZeEtpRVptUGtBTGgxbnV3TFhSbFVOUFkyNk5KVkNtSmdZMXBF?=
 =?utf-8?B?Vm5iTmxGME9kYW1KeEd0TU9GbWdNZHVWNlhlbFhnbVYxQVNSeU5PYmwzempK?=
 =?utf-8?B?Sjg2T1dydjhEN0p2QURTYlIyVXZlSXJIdXpNQUhLall6NnJONFYxeEJqUkJj?=
 =?utf-8?B?eG5QNDJRZXh4RWhYT2RUcXpCMGxHWmM5V242ZWVlS2ViTU94UmwyUEtzK0Jz?=
 =?utf-8?B?bjJrN01Ia2ZQYmV6M083ckdGUGxUckR3OVNHMFF2ZVJqQVhqTE4xeElPVDVm?=
 =?utf-8?B?NGt1TTVBMmRQN21zTU1FRjk5L3I5ZmFoY1RsTXBmdWhtdEpod1BTOWt1NU5h?=
 =?utf-8?B?Ym0rRVNNSk45Skx1dFM1czZBY3JYU3pSSHpLYkl0cXBuZDhUT0tmdVpCNkdo?=
 =?utf-8?B?ZlJxbVgxa214REh6d21xVksyQk9HZkxsWVFxN2U4RE4yMTgxK01JMWVVWkZz?=
 =?utf-8?B?U2s0aHZHbTRlRWlpckJxQ29sZ0puUnhwV0lmVDZRcWVmNVlrcVFwdWV2YUhX?=
 =?utf-8?B?SkRRSCtSaHZiMnN2dFhFTGdqd2hYUjFLOFNuUmluUzNrUEJLdXpQd0M5Mjdh?=
 =?utf-8?B?TEp5TWIreHlCMG1PTkFpeHhlOXNVSzNtcHF0NTRBT1E0dmo2aFJ4NlhXMzdj?=
 =?utf-8?B?dUxUS1o4Q2Z5NC95QzZPdXhFU0Y1RHRyeXVLMnptZW5jdjQ0cnIrWlpxd3pu?=
 =?utf-8?B?UjEyQXMyK3J5MUtjRnE2NktJYUhRMG1MRzVSenpJTzhCdUtTMmYraUd5Zjdx?=
 =?utf-8?B?UmNRQkpyTDRVcUlnMXZzZVpMNWJwU1B5cmlsQmROQnZ4QkxCc3FVUHZlVWVT?=
 =?utf-8?B?VUFTMTE3eUl0OERpWGNyTC9XQVIwZ3BHL1BPVnRXM3N1UlNPcUI0MFJoZzQz?=
 =?utf-8?B?Yjl1MVV6YkZURTVKczdNRmpOaDNuMW5kUEtLeHlJZ01lZ2hqU1pQc2ZjV09l?=
 =?utf-8?B?NkZ6UHo4ZkJ6YWZLNUcwYlNtZmRhMmNyVXdCUzFXQy80eVRXNFdUYkR2aWRl?=
 =?utf-8?B?d2NqOWJWT0VIOGgzSnlGOGZ5OVNCM0pNaU9FK1p3a0lRQ05WamlMYVV5dlFU?=
 =?utf-8?B?OFN3VXlOZDlYREtuZFdWTWRhZDAvR3Nyd3NzNmxzL1MveVE0VnMxM01HalEv?=
 =?utf-8?B?NFhWNzg2VUJHTmtOaEhrOXlTNHhPZVlmTkRJWUtDa3FYNHkrREM1UDgvNHlz?=
 =?utf-8?B?S3pyLzZJd1dnMlcwbnFjVzJINU15Y3pjd2h5eUdUb1lNN1ZBc2Urc0RMZGF4?=
 =?utf-8?B?cjBBTzU5UlBtOEVnbmJITXJibEpEQXZEajZUUXNwTFpkdmRLODlCZFlwNFFr?=
 =?utf-8?B?ZjhwTmVLMmFNenBUUHZwSVpDL2NkOHNkMm5OWGdENlNCdDFRSmlSL2NSNW9k?=
 =?utf-8?B?WW9UcWlvN0lhQkEzVnJUYXpBU3RjZE04TmZ5c1VoOEFxTEc0aVZrRzA3eEpl?=
 =?utf-8?B?UVNiZHBFWVlLZ2NjRmQzUzk1WVIvaDZGcFN1d1psZERpcEd0SDc0bElDQTFh?=
 =?utf-8?B?dmFOTElldkxQQlcrMlFMRFVrclprVGFTT2dibFlxRWY1a1NwRU93K1hFbWRz?=
 =?utf-8?B?Y3FjUHJrcGZoMjQvdUk0Wk9XV2RJb2xRYUJpRUJnL21kM1lScGlzTk1xZlNk?=
 =?utf-8?B?L2NlNHdhbnZYT1g5a0MrSnBSb29ScXVYQkxLRU9XV2VOQU9kcVRkSlNvV2M5?=
 =?utf-8?B?cGR5MXVWNFBCR09hMGNkdEE0aytxZjk3NFZpWk92cDNyQ1hjVzVzRFpYMlpK?=
 =?utf-8?B?YUVRaFJHYkR5VFppajZZRU9QYndmNTJib25YTG5qcis1L3lrOGJ6M2g4M1ZL?=
 =?utf-8?B?RlliVFhROC9ZS2xPWHFob0tkd0c0T0ZqM1RyOWMwQnN2VUtuc1I4cWxrTkR2?=
 =?utf-8?Q?15xTmSQnUiDtPopGxXebBgVYgJfGxaWEkzw6H?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9191ebfd-b2ac-48e8-9bb1-08defb867547
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 11:06:44.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ote3RJVg8a5UiI1xXePoG4djUoecIu5H1aaYd2juJVKTOCTCCQJGnSYM3fuR6gZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1794

This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
which uses an ASPEED AST2500.

The mainboard exists in three known flavors, the "normal" X470D4U, the
X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
BMC SPI by default, but they are all swappable.

There are two device trees, one that has all the config and uses a 32MB
flash layout, and another one called "data64" (similar to facebook-fuji)
that uses the 64MB flash layout.

Please note that this board has been fully reverse-engineered.

Thanks,
Tan

Signed-off-by: Tan Siewert <tan@siewert.io>
---
Changes in v4:
- use plural wording in commit message for dt-bindings [Sashiko-bot]
- Correct model name to be ASRock instead of Asrock, and use flash instead
  of store in name [Zev]
- Link to v3: https://patch.msgid.link/20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io

Changes in v3:
- remove mdio pinctrl from mac1 nc-si interface [Andrew Jeffrey]
- remove "st,24c128" compatibility from fru eeprom [Tan]
- enable uart1-4 [Tan]
- add a data64 tree as alternative for boards with a 64M SPI [Zev]
- add hog to bmc-ready GPIO pin as required by the host BIOS [Tan]
- fix offenses reported by scripts/dtc/dt-check-style --mode strict [Tan]
- Link to v2: https://lore.kernel.org/all/20251011112124.17588-1-tan@siewert.io/

Changes in v2:
- fix led node names [robh]
- fix missing gfx memory region and other fixable dtbs_check issues [Tan]
- Link to v1: https://lore.kernel.org/all/20250919185621.6647-1-tan@siewert.io/

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Zev Weiss <zev@bewilderbeest.net>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org

---
Tan Siewert (2):
      dt-bindings: arm: aspeed: add ASRock X470D4U BMC
      ARM: dts: aspeed: add asrock x470d4u bmc

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +
 arch/arm/boot/dts/aspeed/Makefile                  |   2 +
 .../aspeed/aspeed-bmc-asrock-x470d4u-data64.dts    |  15 +
 .../boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 381 +++++++++++++++++++++
 4 files changed, 400 insertions(+)
---
base-commit: cd7d1ef7d74ed5f5a1790a40389bc38382924556
change-id: 20251017-ts-x470d4u-54b9e98e4333

Best regards,
--  
Tan Siewert <tan@siewert.io>


