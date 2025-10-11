Return-Path: <linux-aspeed+bounces-2421-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122BCCD190
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Oct 2025 11:22:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ckLmh4RFdz2yrb;
	Sat, 11 Oct 2025 22:22:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760181732;
	cv=pass; b=UzREOSUBe71upJnTwa4SQ+V/NseuP85+gkzksIRmKTVNjJV4yE1LLnjX1OaYttXfftJEVcyBRjJPZj8qp+D7h30BFdRF6t3LYjkwXUUmyV5qv+MWhPdV1Y07clNAuq8gbc7SF6/12O3UcXXJDM0iq1wF7cY8s3CiSL9hV7aPOADsRtbO1CHnd2ehda11rY6m0PIk5jt5k01CJLygiYsucqoyCCC5kU5YCkz7O+uvX8GOGAT/24+eiv4zFghA30t53LYe90bptRe5DUq9wEHAa07sgB+hejzvxKnLE+Ou5USyD9T0j+jdop/QmF3QNd+A4vpFJAdwhn08nbkaiSgz3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760181732; c=relaxed/relaxed;
	bh=FNwuec+egzTMAt4u8OuvcYNN4ipnw/5BgqNRUShweDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZxWWbOwjzW9YtEFUQHlYkIFdmDiBzdA3c0kj3MrFhf1EyGZAE6yqfbtFOZ8kpllguO59whpMZk1Ev7Q+UY60Wo9P5gkkr4ghHKel+DyWKFYWb3eCPu4q1PXyiJm+26gzxbITUZxgfDi0VjaYqGnwJGkFFHJnO+8uO/fl+n7Hes6iWuHNnsyND5NUyYRTtY64BQmgqQzBWUL9MP3bqZ8LkOBK2Z514OD4WtYqZuJW1x83uRZpuvp9i8v4NcS4Usj4Zbt4RX2a2qxe3m8ARWSQXhj2MdWHdzgmmO+QO6Hu1uNFb/YcsddmHDAKzHr7tnChNspYgmp52BpYi3/S26/RA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ckLmh0br7z2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Oct 2025 22:22:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYpVNhAw8sLrgruFdxAghXVxsn1DKbHoP6VyabxVJB6j6I7nmprWbZDXqca1mjlHKpNZN0uFtUvLW1/aM4aEt9DtvZ4aSoyPCslqmhIexkJKYLeiMnEYlGff/r977tNvWt71H4SyaeapwphHCQIn+jGCN4pxuOAomvXhbIAiHxVwew7JNYFupMRcTqShMGuu/jlbhe+lR4YFd1rvViU2AOW47olxmV9lvyeog826UuiiVA3KmRu0/wtn/nARfKdOpPgkv1VNZjXielZ2+DzRzQSh4hWUgM5jzdgv1FsXKQNSaIX7NFwAiswsb1hgLNzEkQL4fzlEa5JIFbqekYNY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNwuec+egzTMAt4u8OuvcYNN4ipnw/5BgqNRUShweDQ=;
 b=JHOS6NwW0TJUa44UEm0nbg8vQjAWYLgi2UuUcqinogLAXLL4VhpLcBVnBEERnWOUebCQ+j8XLfixbFdZasqN/nSo6cbYtfE9ITp5/72mJWhu33FteSEsjWt07ovMToXkIsykcQxuql/z3kAI36/407Srkdq4P3e7cQsiUrCeQ9fzceYRD0ctydkIXH7eom32lSZan/E3q0QHCXeb+ANC0dTQZsEdoenJ/mb/RZPEVmKhRH9pFTm2ZU/1GeXQYJ7YYGsbj18tLheeKovdZO0KI6Lr8Ny8CRkpuAZW6bFdkZ555+rzoBY4nuLOF90XT66YMmLHk3dwxiRIlcZx2AFlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR5P281MB5421.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 11:21:49 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9%8]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:21:49 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	Zev Weiss <zev@bewilderbeest.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Date: Sat, 11 Oct 2025 13:21:20 +0200
Message-ID: <20251011112124.17588-3-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251011112124.17588-1-tan@siewert.io>
References: <20251011112124.17588-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR5P281MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0546d157-6f25-48ae-bf02-08de08b85edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIzDDE9kj2GZbklrRaIKe6buikkGnvyynHuh1sEAPVX7Q2zPZY8E35/lP5Eo?=
 =?us-ascii?Q?r9EdTcY1RlnSENEzkaF3uXAFOypZxsc7ZcszmZcgqjzu9WiBuLeaUai8dwzY?=
 =?us-ascii?Q?aCqMRDlBj9nNCle/i8ZDcqJwjRI2raMEv4Q3GglrJ6txeZls+WQWE6FAJQ8k?=
 =?us-ascii?Q?xGf4WPC63b5sfbLHnPCOS+zOzDj5Q2dq2+o+N6XZdCY+CEGhQ3Y+CGdDUT1A?=
 =?us-ascii?Q?BeGD784JxF9SXBAn0WEixzrd3t1pm40SRqXAlAEOHITNgLXpiiEzrav7Hw7d?=
 =?us-ascii?Q?kEMMlL7amc3jKzzWBeYtSI1obsMQYdTLtMh5jjI7IIYoIG9C76AkE90TBDne?=
 =?us-ascii?Q?sLDoPKSr137CPB4Um8Sce2M1gmzesKtXJFvxhQlw55/Zl3ktHSC4drhWqPLL?=
 =?us-ascii?Q?Fyq6Gsr0OVNZ1XcoWkJ40hU6+yVuB3clS33A9qjCqNvKK2qMUO10EVRjmga/?=
 =?us-ascii?Q?pkw6hru8p1elb9SBQibmnm/BuRXMMK75DHERnJwjosTNKLshaDu3takI1t4y?=
 =?us-ascii?Q?t9NmwIbg91N/MsQ0aUiHNxtp6Z8SrJMp+s6nTDmUcgztSchxR/8qEgyS9nKe?=
 =?us-ascii?Q?npBSmF9AZHO9HeycLNtvI7tqYqwHcTFU9x4BMXzMBx9/uKBBioEdUqiCDpj6?=
 =?us-ascii?Q?S5ut8QBwlxZsecWJV0WGGWWvmGz3VPVlZj4PQ0SAQJ13TJEAINoB8uVVEMEc?=
 =?us-ascii?Q?KidEH9UM5H3Fzhyzg+edwbKixe0mmKsMxIlTPi/OM6gRFrY3Ykxc2YcavMsH?=
 =?us-ascii?Q?Ii3/3Jf0fRAntw6j85t/miufH9LZcXvX3t818FHauijm/Jl0K6ojmmaSMooT?=
 =?us-ascii?Q?wgJ5/hE8Bz9xTTkOU0KJhLFiFHuljFp+KJGg2A/aqg8weO6hDCgT2rPAWgz5?=
 =?us-ascii?Q?OlVDeGwF3t2KjU+GK6nQ+6jaG21Ly6qd9g9fi/2begG1WbqEnfvtM3LsGg63?=
 =?us-ascii?Q?pMVMvISCM04dyaHpH/JGFFzlsUdmlonQ4Zp0QovuHYrJo2VbsEiNJ9d4vGbs?=
 =?us-ascii?Q?xycZ6TwLqoQqYOcZYKR78jBquMr4Yhx2FjkTaARGvLuX0bDmezjRBTjL8fMP?=
 =?us-ascii?Q?UY5FLq3qLtwWECAldISNok14ss+eN+5DgJHpbAwou+ed+HvqOs26ceEJOK+z?=
 =?us-ascii?Q?MT0Tem5WPKT29G73ddtbZcpg6wGxTXOGYBvBslhfc4Z6rH104lifjsgTcg8R?=
 =?us-ascii?Q?q2LgThInxN2b5SVhtP01FmT2RRAmONoZvg6OBnKiK+TL3Sv8Hschm79IOm/f?=
 =?us-ascii?Q?63ynjonE9CUAiRdi4vng8nNVPdYVo8FO1W4mhvllTzB5jgo3Otx0pWjvcR7t?=
 =?us-ascii?Q?RxYSKmZE6QqmXjHbJmVgt8uFWzDX7sDgWhlCtjIHznpzymUirM0B27TNOrcz?=
 =?us-ascii?Q?NGDZQ99gKJ/cCuOYRUBtLPuS1JzZc4kuLsVzrlzWtOh1IcjzHifQvcP8jpBQ?=
 =?us-ascii?Q?bQrS+6rZQk7opnI/WPI7IEe+HzL77LCQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CmKx/5vKQDVx9zVizBtuWuuN7id0X2tay+8OWHwot4uIkL+ZCM1eSPAQC+4h?=
 =?us-ascii?Q?m8cJVTKRbM3vIW1X/bX+aHqC5vxr/kOsJO5/7bJX/vmFsnxYjm/9QOi95fb5?=
 =?us-ascii?Q?PsAMrhk/Z24w0vWDAY/1qBkABQ2vFwO8Uy5DBh0dCV3rleVc2/+5k3XnaklK?=
 =?us-ascii?Q?b/JbuZTlLLwNzI0qlsmG0ndRNGggV0UNl1GswUu8+YzhX3wPfJbYSKnXsp52?=
 =?us-ascii?Q?mQ/0DwVe7/En+nH6V5Ayd8uRtJwFwjIWgklv/vMYVwkx/Z3BVrSUGitxZfY7?=
 =?us-ascii?Q?CC7gsxaSiLKZ8o4YNs2F/qhrVhfHfuLptsHINWhMokJKT76UUcjldhV/UDVc?=
 =?us-ascii?Q?UByEHpGYQOc8u+X84lBvLRciEJ6KEQNdTLps8w9Ac1g5j6GZGTREjoS42V8+?=
 =?us-ascii?Q?tS5HtYCCG2zSc96kb6aSYBItV0hvVEQgR3q+vFGtO+AbA9e/Jok1P6gwvWvi?=
 =?us-ascii?Q?Twb/BuCKQScN5kpLgdwjzwmzqbFGsFj4MESkJH1PVgDJg/RSRvt1XKgXUFvn?=
 =?us-ascii?Q?pbaCukFuqEg9l/Hiu77YKRz0AYyG6YC8cswhDC0z9lvTk7JUhDYlq6xnQH78?=
 =?us-ascii?Q?rJbt/mtr7hKEcgxqHahp7K6T7n77iQv/SGtAxL90YnsXFrh5mUYkIeNkqYqv?=
 =?us-ascii?Q?BJDCebhd97DcY830tvZQR+OJcuV+r3jnWh9g90U0YdAZtjdm2dEuf0OH+dgr?=
 =?us-ascii?Q?mH/H4Crw5xRVSwbGmgRctCCF665McUmekE1VKkeTHtp9ao4UgWYQnvVRMerM?=
 =?us-ascii?Q?hhgLaSgxKpAubviMdd+4T28ev1SluI3vPcnDiNRAfYherZwCIU7z6XRePo9C?=
 =?us-ascii?Q?E41pTF9+pr+dSdpMbQzbS7ITBWIhUR4JVnPubDP9O0giDEh7xf1GYsRd8GI8?=
 =?us-ascii?Q?apnheUuMgHpb/zMlHslBXb9LLfUOa7Tm5Ico6GWWHFuc4HOqcOQ0Na0FGYzb?=
 =?us-ascii?Q?4YKbj7khLouDoxYYv10QnECQE/itqqfR2PvoxeXX5/AWMsBOvses2MdFHSvy?=
 =?us-ascii?Q?ZVda9kpMsn/86sJxOwTj1Iu4JSTt0MofwodNnms7OoKBgaPdwAFMrD88BiXs?=
 =?us-ascii?Q?hBYgfxkQy3Y9SXpGIvywO33RFYws91iA9qZI4rxXlE+hyoafmN/jIjtSCGFY?=
 =?us-ascii?Q?XfsEGOCHKJPYWI3AuA+RcGVTLRNn41p8oz8zZaoTy4C91/92xmvUsdN2C+9a?=
 =?us-ascii?Q?5AB4Wtz+bI8lvlcd2SFbS1dLouO7LDfu1SiNCLDFTGnnNmhOzndBbHPMuoja?=
 =?us-ascii?Q?kpqO+67p62OZeY0EdRPxllVhSd7YuGtl5F85gzNU5DUqhV/VQIPVYdIioVxx?=
 =?us-ascii?Q?sYJFPhN63Adc4qaETH79GZd17WnuKN/FdFwpKwmlCcS4EImuDxVd5Kx53n4B?=
 =?us-ascii?Q?+Ja0bt8W1SDuIw/3XJP97CdvJRDPt1hg8erKWDqZCxAmNxCP7KfUAqQ30MqP?=
 =?us-ascii?Q?xovrb+EGqXltYSUd/4Wf+TCSzUPphFRweICr7zhFqOGkgzOh/1K5MvVud4cC?=
 =?us-ascii?Q?FW8fImzu0+2PfzNsiNg+EmlI/JZImGqIjHsM0YC7R1DMk0ZCm00F2mHu61yP?=
 =?us-ascii?Q?2ta7K44ba0otylVk/XYPK8l0ZTeB/kc2Pbv5W8y7oEwsXLrTfWV+3iE5WfL1?=
 =?us-ascii?Q?0K8bEpTyp8McHTu/MNWk2o4=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 0546d157-6f25-48ae-bf02-08de08b85edb
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:21:49.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffleH74OOMQ0qcH8gH68c3YMqYImqaCUh2BJWxsKM8+gBwXNuxFxyT8TRgnvTxdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5421

The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
64MB SPI flash.

This mainboard exists in three known "flavors" which only differ in the
used host NIC, the BMC SPI size and some parts that may be un-populated.

To keep the complexity low with the BMC SPI, use the 32MB layout
regardless of the used SPI or mainboard flavor.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
v2:
  - fix led node names [robh]
  - fix missing gfx memory region and other offenses [Tan]
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 350 ++++++++++++++++++
 2 files changed, 351 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b707654..c601af36915e 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-e3c256d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
+	aspeed-bmc-asrock-x470d4u.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
new file mode 100644
index 000000000000..e9804b0ace9f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Asrock Rack X470D4U-series BMC";
+	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
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
+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			<&adc 10>, <&adc 11>, <&adc 12>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			/* led-heartbeat-n */
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "timer";
+		};
+
+		led-systemfault {
+			/* led-fault-n */
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_FAULT;
+			panic-indicator;
+		};
+
+		led-identify {
+			/* led-identify-n */
+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pci_memory: region@9a000000 {
+			no-map;
+			reg = <0x9a000000 0x00010000>; /* 64K */
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02800000>;	/* 40M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default		/* 3VSB */
+			&pinctrl_adc1_default		/* 5VSB */
+			&pinctrl_adc2_default		/* VCPU */
+			&pinctrl_adc3_default		/* VSOC */
+			&pinctrl_adc4_default		/* VCCM */
+			&pinctrl_adc5_default		/* APU-VDDP */
+			&pinctrl_adc6_default		/* 1V05-PROM-S5 */
+			&pinctrl_adc7_default		/* 2V5-PROM */
+			&pinctrl_adc8_default		/* 1V05-PROM-RUN */
+			&pinctrl_adc9_default		/* VBAT */
+			&pinctrl_adc10_default		/* 3V */
+			&pinctrl_adc11_default		/* 5V */
+			&pinctrl_adc12_default>;	/* 12V */
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+/*
+ * Although some board flavors have a 64MB SPI, use the
+ * 32MB SPI layout to be compatible with all boards.
+ */
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <10000000>;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&gpio {
+	status = "okay";
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
+		compatible = "st,24c128", "atmel,24c128";
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
+&i2c8 {
+	/* SMBus on intelligent platform management bus header (IPMB_1) */
+	status = "okay";
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii2_default &pinctrl_mdio2_default>;
+	use-ncsi;
+
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+				&pinctrl_pwm1_default
+				&pinctrl_pwm2_default
+				&pinctrl_pwm3_default
+				&pinctrl_pwm4_default
+				&pinctrl_pwm5_default>;
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
+	status = "okay";
+	memory-region = <&pci_memory>;
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		/* Frequency extracted from original ROM */
+		spi-max-frequency = <24000000>; /* 24 MHz */
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
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x2f8>;
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.50.1


