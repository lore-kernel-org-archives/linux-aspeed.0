Return-Path: <linux-aspeed+bounces-4731-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B6C5DF66
	for <linux-aspeed@archiver.kernel.org>; Sun, 16 Aug 2026 11:07:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNCpm1zp9z2y83;
	Sun, 16 Aug 2026 21:07:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786878432;
	cv=pass; b=XsFYLQ8IaremN+bvRru+dTZnO1E8YdBZ7AUpqy4Uz/6Q5skUEDDEKVpxZGlYNOdDkJuUs3GT4Xq1e+YRSkp+jYk02kJJ18KPIWg5b/FuDfB4y0Wnpkggu7n4LShp12XsAnfA0F1vVT1FEQ2rwTUE6XNjHEKLRPuxbVg1UnV0rZyKKnGTUQvPujPp+DC+QnleMQeXGNlsE984aq8HErDwyGRr4tvfXoRpMPacM3kL6U3/aly7vCem9qk1D3iDOPfk0Y8lAFWStMYjVJwwKt8BdgSx00nRHUv8ukVneC4QMjJplTXOVKGQnKnQL9j/afAzYYtV3UqdGPezqmpLqo91yg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786878432; c=relaxed/relaxed;
	bh=vSac2XBQAxf8ixE87e1Y6iOrzpCEtjMWFsouG/QzWEA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bsmwWwznBw07rbtUvs9PRbBVF2vseHVHWONlEVdU7f4XZA/Z2ptEOSv9GpB1guZCdkx2Uw2tvrtjnHul3BG9Bg1l9yMN4xiJ62XQ616ske3NUGvqMEZ4KjpTFKQ+Y54W95Uos0aib5IqT9kJ6NjyodjKSG0UlA/QTkn7j3zFzXOvSjc6kCPO4PJ/BWNSpRpbPPkUeRUB7StrivV9TKpxy6bGMSLNcuDPmShMSDlvI7rS6gc3jxEjBtvJnSojgnAI9NtE09G8HzoTE35sV1wV9BqT4aaobUuJ4wNpbzOCvKBJ/YAq5LWojd8O2R2GWJBSn+Pbauc5ysUyOL4N31xj1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::4; helo=fr5p281cu006.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNCpl0rsPz2xft
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Aug 2026 21:07:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFwWkSy+hvee5HavnQEls8C5u6ao1nwazld1vaE8hXB2JH0yjl+rh4Q8ab8Gb/G1ItwVi6gHhGugCZTneobPtP/ZLM6KUtSQztH0ANj+dQlNAng/5WYCa9dy4wZK5Qf7QOIrJUgNe83BIOwIszeGvzx40cNOnaM/vZObFgKrFtciXXKvB8ToyWgbcoVGdxGoUmVikpQeBeLOEt0qsA2ouWt99Y9oEMU+Y8Y0T3pdrfCjhLdWUFZqg7drrPPZXB14tbmK+UIZdphNxj+oNBNYAnghxnJt++EFn2W2Tdp0l+3A9L+lf5bpNWJUAVjPiC8Iuf0F8QG0hCthncmvwiADGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSac2XBQAxf8ixE87e1Y6iOrzpCEtjMWFsouG/QzWEA=;
 b=HT4zkTf1uh7tzz0c4GEyma4E5h5VrJ1yS4aLmgXBFh/XcEVSj1I1f1hG+1rZ53jIckh/tae4yoYJIynYqp/VzJK+VDirvGf0IPqFyEP55srtIUqihHwOKu4pKxawWSg++BQ5aIiPzzJ+8YCNxNvZ/uUa5S49IXJsVefMeqemIayx81Q56gAhJTSmzHdFxQBEWoo24kW2dDLJTz4J4tOvOd6+xh1sB2YLbQezQrfYQVXrP3NCJIsrUghosLMn/PHxcTSOwuNz6a7lmqQvoY+pCJUsTxX9GnumLi06BMaD3SSRTdQ9uNiyhWEph/EnY1meUIKue+4F0iMc7j/jD0EbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BE1P281MB1794.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:16::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 11:06:46 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 11:06:46 +0000
From: Tan Siewert <tan@siewert.io>
Date: Sun, 16 Aug 2026 13:05:50 +0200
Subject: [PATCH v4 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-ts-x470d4u-v4-2-cd08e78287ec@siewert.io>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786878402; l=10196;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=AgufxX40YdcqmwSoBfqyr9x832T8fGY6Rq4iT5JC38A=;
 b=yTSY8ni3wgjOxd7xr7BJkrQtk33O3zeCGFf2X4qd1GWCgcT3LqP5ArLgaVxY+aV0UmBfXaJmH
 Zwrd+XWFcyZDVpwMF472ZEQ7qGJoffhoaGXx/VtrUV/z4gl3r3PbSj2
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 32d717a9-54d4-4c02-65fc-08defb86766c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|7416014|366016|1800799024|10070799003|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	g87yu+5TXbS3HG1eG/pdCX+LYpdrW2BIeUKSfVtAHQKT/Yd0Jym/KdpIr/FQVjzN1ZTbRI0L/zi3ycGKH5FG46W/wpwbQx6+TrVQQFAeoHpfgbfMFQJR6HVxt3BldMI9UO6cC6zxIt7EXcPXx2g9nped6M34d4eeIDFAD6p8s8va4HzG9trTRAhhaBR+VpcFM0F68r9yacU7gedpCkXzRyWA9OZA7UFgIVxNi6pugEdxUNd6eDtSxcM+1TPUR1J0IeEr6RBAFgt/hoiMi0qrmTFkBULDSox+JNVMVFMnqAiksA0+hNoPIG3gkmTqT6jDpKXxq8SLuSfgwB9BEf8w0gFn1yYdoWWPER5//4Z7k6qgqKWDZSLgl/3/JN23W19G4ewV0Fa/cRQuaf5VmTNp6lk+KZjRjF3Z6xQ1Mh5uqdOCiEDVQxRdIVuFUvG87E4JdiALU4BvAQWNbgpEfO2uJi9d+l2WlwpLvZPZcl+xs/hv1IoDEPYfIb5HW6JgSHkxMYQTpFn2m7B1Lw0JiAJXy5Bi4WGTgldQWP5Fy8YppjahV3Xt76Z15RqfKlUJwwoc6DNc1RGlEbMUgkIY1EUXq8OcRlFbG6MXikHhOLNkGo3qvc3MDDO4Bdag8GitLgev+Jwz1cjoa2lnJu2s9Yli7bJuXztlbQR+b/ggGY3orVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHp3Q1hrL08waSt4TnZSK1ZWQjdHWERYZEsxOFoxRlFMem8veUdmVHpLR3Nl?=
 =?utf-8?B?OWM4dE15R08wMlExSXZDR3JKcVIrWjB5d0NVK3R3bVIrYlBvY0xwYXE1YUJm?=
 =?utf-8?B?QTNjbXppcWxZTHhXOFV3eGlDVjdRQnRRK1ZrczBUenAzMmxhL0JNc2JqaGYw?=
 =?utf-8?B?NUhxVU0yYjM0MHkyaUduYnpVazRWVWk4TXRZTjNjUHc3NHZOVDJjSmZ2dldY?=
 =?utf-8?B?aG96dkgvT2UrTEhFSDBmOHoyaFI4QlpGK3NRNy9ocnkzT1FJemZkVEN3RmVs?=
 =?utf-8?B?Zkh2ZlZzVWVITmtDVHZ6NWdyeEhOWnR5dWJJMTNwTEZENCs2aHVnOEpvZVRO?=
 =?utf-8?B?cmdaSm54ZHhGcXFoWFQwUGUyWFcwYjJrNzZ3UFNDNWY3VE1JbjRlNnhJSU5W?=
 =?utf-8?B?NDVld0Z1TzE0SldqMEFPckMzQVlGeTRFSUxuOGU0Z3VMc3VyRXhoL3Vic0dQ?=
 =?utf-8?B?U01hei80YlE0TmVGcWhiZkNBQzFvTGtHaVE5Sm1OTHUrRFZnUGdqanREdHcw?=
 =?utf-8?B?MVpHQ1UzZjhYcThyN3g3YVVURnVHRUVXeEpCdS9EUGtVaWtpNFB0Nk1PTkJM?=
 =?utf-8?B?d2ZSSkZySGxmUEVldTEyWGZRcnZsY3hsa1NiWWlibjVqUlBqQWRDNXBTT3BZ?=
 =?utf-8?B?YldnK0Z2ZUJsbDVvYlNIejZRakkwbHU1d3JQZXZwRjRKRWVGV09OYXNRWjJq?=
 =?utf-8?B?VW5YcWcwME93V2crT3BwZmNRaW5HYW9ldmN0YldrZ21oRVgyeDVYSFVZeVZq?=
 =?utf-8?B?dFVEWE1jeVdLNWx1K0NOUVczYlNoZm5PVmtWbEU2NlVoSk91NDZjR2RPUHcy?=
 =?utf-8?B?V2lLQ3ZpTDFXSkNwU0tPVnFxS1BIRlY0WXloZWNsTXlkRVAzSDErU0xBS3dL?=
 =?utf-8?B?a2lMRTJ2WDR1QWJaWldJaHFWdkFTNURmUTQ2Ry8zVzVGemxIZGdxUWJQVnhU?=
 =?utf-8?B?Mm9KU2VPZDJaMUp3cFJsTXFEYmIyWXBrRk52alAxc3NzY2xPeGI5cC9Vd0da?=
 =?utf-8?B?ZnRBRStlMVZhbEphaTQ5MzhkYmNMT01NTUUxRVBNbXNiVld2OHlaemtNZjdL?=
 =?utf-8?B?SEp1WFo2NWM4NEFVQytKMjQwdEcrN2NJbG5FSU1oNThiSnczOHo1cWIrVzFM?=
 =?utf-8?B?NjhweXlraHI1aE5FM2pVT0Y3SEVsUkdsN1V1ZC9vNDZMTUhWQzZRZE1uN2tm?=
 =?utf-8?B?ZmpHZFRlaTZnWGQ5cTZLWVhsakpVOW8yZnk1WWdOYmdLRDhnUFBBMmRuU0Vn?=
 =?utf-8?B?bHliQ3ZibkExS3Aya00rMER4enQwaVM1UU9YdnQ2Y0Jwa3lHWnpVd3RwQkpR?=
 =?utf-8?B?OVEweUdjaEVDY2orcjRNOFk4Y1EvN3paMUc4RTZjNnJ0Z0tXT21MUkQvUjQ0?=
 =?utf-8?B?eVRucFFMdTJ1U0JEemdnR3VkVS9LRnFsRVRWVDUySkFJcys0T2NsOUU4cXU0?=
 =?utf-8?B?RjZXQmxES2xUaUlLQjlwRzMxa25sVzJ2ajhLWEJ2RFNQbyt2bG1vMEVKSTZQ?=
 =?utf-8?B?UEtNbkFsbk5EYVNkOTRUM2ZlcXpneHpUbnRlN2lReEx1K05kdytlQUZ4RjB4?=
 =?utf-8?B?dWlUUDhMRUdSdkpkWndXOGRhTDBSRUM0cWZFV0tjcFFNc1JVbkxicXlDQ2Q4?=
 =?utf-8?B?RkF1UGsvV1JUaCtEelpDK2FHS0RHRnNoQU1ZRDRQb3p4NnJ2UzVXVlBJMExC?=
 =?utf-8?B?cFJ2M2FuNWY5WTc1aDZYcTBySGxUSk9xYmtNRnBBVis0VWQxNWdDbGFHU09I?=
 =?utf-8?B?RlRyTVEvcUZrdVBaV2N6VERhcmNONlA0TGU4TWN0WVlIYzBzZkFoYWdFWnE2?=
 =?utf-8?B?YjNOSzdTb21OWHpnSEhlUHEyam9PL2ZVVEFHUVNaL1B0RExGaUxFdS8waFQy?=
 =?utf-8?B?RnovcWZYc3hOSXE2Zk9oVEp6blVzdlV6bkRZMzZqaW9vb1BCSmJCQWhsQXhZ?=
 =?utf-8?B?VHNuUVBiUDlyVS9WNENhd0QzNzYrQllQMFdmUDJUcmNXNEQyaU1SL0M1N2w0?=
 =?utf-8?B?Z2kvOWRKMmdYZHlmdzlDelJ2RldERm1wSkwvVzBWK2IydnY2YUJ1bnNqMkZv?=
 =?utf-8?B?ZTZ4NEVDdmd4bFhTY1BGdnpvODBlR3Fab0dRSGdxR0cxbXdZVm12aDZhYkhv?=
 =?utf-8?B?Z2xnYlBGdThoMjF1RlBzemJoZEV3SWJYM1c3V2tIZ01kMHpXRkNIYk1VdEJ1?=
 =?utf-8?B?VjJ2V1Q2bWxHbDdXZFdDemdvblZoSk1wWXFEYTc0TFVCR0VoY0xTdDFaQjFV?=
 =?utf-8?B?Wm1DUnN1bEU1L0lvanN1dGl6Y1FwVTU5cEpqaW4yS0FtRXhHZEcwaWd3ZVh2?=
 =?utf-8?B?Yk0wa0tFQ1V5c05hOFZVcmg3ajR5dzIwaGVjRGhZOTVMMG5qbUhObnA5emIr?=
 =?utf-8?Q?99zvL4vKfBFrrl7QVUMPICRxZaLl0rgRUtaFD?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d717a9-54d4-4c02-65fc-08defb86766c
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 11:06:46.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBDfqLc/EuuiM91oYh25unD8Glf0sXOEx4d8nJsSdsL/p/bfOeE1lSiQ8apBpzVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1794

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
index 000000000000..fb7102db1004
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "aspeed-bmc-asrock-x470d4u.dts"
+
+/ {
+	compatible = "asrock,x470d4u-data64-bmc", "aspeed,ast2500";
+	model = "ASRock Rack X470D4U-series BMC (64MB flash)";
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
index 000000000000..73bda64e1fa8
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
+	model = "ASRock Rack X470D4U-series BMC";
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


