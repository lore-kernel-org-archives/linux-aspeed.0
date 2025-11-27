Return-Path: <linux-aspeed+bounces-3010-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C1FD116E1
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGyNK4hs4z2yvP;
	Thu, 27 Nov 2025 11:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764204225;
	cv=pass; b=LfZL0QboyIA7f5HGGJrjexx/nySpm9u9cJh0+wdjsKk+pmG61byCkm4jxVYDZV+TtBXEtUD2W92I2ugv+2mjT7Wd1EuS02yE6t2vqUXkyOAkew8xI5W3dEyMvcJ+Bjo611v0HLCTNI7xsTXT2ZZ87a+jghR1w3NzTBYFXahck0mTqQWhzqJSgxgUVvMxcX/o2VkV7tJi2YU1PoduenzawA3KK7fHgeoZnlRLovlCnWKEycgy9aY9qh20k3KYzOx3vaABK2UZq/5IeiT37136sxOlGPU4c0Ma94Dznsd2WFzEJplRqdjHAJp63CXIv+h4h7xmEZmsFw+X0MC2xqP5VQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764204225; c=relaxed/relaxed;
	bh=9ynIO/gsPV3Fqu+kUX9t7XebHkiTmFbUF5OQmH8TfwM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GINSKOqTkuL+ecP4WHnjsuCDAiWki52p19wiR7roK6tGU4TlkWthz6qB0l9J0oxuKxIiigCk28gMaVVdv5yJwGCKuow+ONlyzrpekS0e9falbMyXcA8TF2PqwocDVtn5pWHVrpBCG7SigOGonULAykx6BbeKsGyVzyUJZ2J8Se40FEeiv+Mw0As+xE9DqD3j49OB+DlkMe6H7KwUPZ4Wangt/dzbbOMWkE7x3z9WIg4YldB4vcDsWfZgrmoGvQyhmmb4HT/oA3+3C31lMLiiXzDl/RYj4BggphONnFdE/X1I/VB4FthxpfJWXhcTPZthxLHV2/EyJCXRbYP91m78mA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GwK3NF/1; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GwK3NF/1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGyNJ3Ps0z2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:43:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XahmF5RMsVDHDeWOhWMEuBZ5rRqBWFkJdiAuBXP4B33LVz9vulZmsNqfr7q4JsipOkSGj0+d8yVu/HZSRkz0bY6tTmjdxKb2twqnIIX0ShPw48MzwukHG8jAXVW3doj9kQ8skpB4f9NzF3mz6F8tazXN6SFiRnhfzc1RLwbTm2ysQyvf6T6H9qDZZUZffC4md7LLejTLCwzbbGWR3niAgbMdP4iXV8+Tk87W3ivHtCNXhn1CZr42ux1/IFjBS9BG0fTX2DIHSyoWhuCPGk4gMKC0w8bjmrpcVJ0CBhXJr3JfQ78SJXMuQPHnM6lJAErvtAFeCvQACix21iHCekRxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ynIO/gsPV3Fqu+kUX9t7XebHkiTmFbUF5OQmH8TfwM=;
 b=Uv0IbCV0XyWsCt1Fsc/Qtfr+R1vhYXONmVovtY1FkQbtt0aAbLnFbW6euUnXYyVgyMmDGMeGfCUUfoUqqzzlk54PmVoDazRTOr7WOlRIqbMjuQYzBRnhifCLkdRLrhl0u73t47yCTErG2UwoJJYuYRV+AI06Xzv0zojNBWWLfG0G7NS1bzGGpf/cOJ7zvLbVNCN7ve1b1P1U5V1KE7VmaXXuK65odUsAtKL++Ggia1cifae9R1lxlj8YDwhcjZezp6uqVlsdaaBk4tuCF7x40gSsgXSizHFSNQxkTiXMwCT8kjzmYVY6QAJnVrBjm2begCCnxsY8atIDpN+hU/lx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ynIO/gsPV3Fqu+kUX9t7XebHkiTmFbUF5OQmH8TfwM=;
 b=GwK3NF/1ktQKcumm5siL06cOukPGd+ZnDwTJCbh31+N7iKPzMdWzJM35Tfsy8cQSIRe8S+Z00dYkMukp9LzTXWmbvxRDMjAHtTd9AHXeKhkmRB1Q7v0vmWKw7135jF5yC8j8IjGetD57Si0+qny2fKI2uDW7WNUJdQiaINkuSg+gD6nrucW/f+cZIvXaLThyzRNOHK4joSA3VEFh0QDOTSxawMG8qpldNxkYfqEVvjp7SeX3i4kQatU1trQ2w7ln9P4QMphOPdUwGbMHAODR5VUaJzmisz4/oKi0u2+w3RyvTW9tdZbqSVcYe2X4u5YHxXkiSTTPwKDQjdB7n7wWug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB7855.namprd12.prod.outlook.com
 (2603:10b6:806:343::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 00:43:18 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 00:43:17 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Wed, 26 Nov 2025 16:43:07 -0800
Subject: [PATCH v5 2/2] ARM: dts: aspeed: Add NVIDIA MSX4 HPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-msx1_devicetree-v5-2-e508d13e2dda@nvidia.com>
References: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
In-Reply-To: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764204193; l=6124;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=UOsOwWcqiAkVpyJW+zB0afJ1MOeTNAPYgDYWt4CTId4=;
 b=+LruXktQ25tG3o3t3KcukcnfWy0VrXQKdZ22g4LqcHAzrKEjV1Ab3AkCS+tWH6UXSK7Fd9JQB
 AUKkznxYtleAr5bCkitJZ2ch5YRFKoXHc2RfDq8YeJ4Pyof7kflVIWv
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 87746ea4-38d8-45e6-5156-08de2d4df4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEY4OCtuUlA2MjRjU2Y1NXBBQStHZEppM25iOFluVUpUNWw1clJYZEFqQVp6?=
 =?utf-8?B?aGM4KzZ4MFBjeFY1cjVzSS9HN3VDZ2JuTDlobDJUcGw5MVM3azF6azROa3pD?=
 =?utf-8?B?dFRPU3BqNkpCZzc1OHhUSzlsQWlWbVZHT2pZbDdmb3Y0V1lZcWVoQUxXM01y?=
 =?utf-8?B?cjJCVHQrb1VFV3JQMUxVcklFclpSYndtS1N3a25YRmVoeTREY2xxTFFOekRj?=
 =?utf-8?B?SlJtQnhpbnlyTDhmVGRqVGQ1Y3BSZUlHSlV0V3FYVThTdnkydmNyVmo4ZlMz?=
 =?utf-8?B?QXlSUFNNaC9YNHNYWDdyU0oraG1FcHJ6cGxMM0IxVnBSVDlBWG13TFBna1BS?=
 =?utf-8?B?ZGZ4YXY4NkNzVmtvdEUvU1N1S3BCWFJPcGk4bGNOMGxZV1gzaEZ1L1ZmbS9h?=
 =?utf-8?B?RWphTEEwWU1RVTBaSzNBeEdHTFZENGVQalloek1CQXd3amNXNDFtdzJyTUdw?=
 =?utf-8?B?NVlETUpGMkgwYkZ0K1NkenRvenlqQzhQUHpGM0VVK2h5VUlvU1NKbzNYcVlZ?=
 =?utf-8?B?cVkwVE40Y3UwL2ZzMkNmWFJEbEZ5OHJHUW90V3o2WUo3eVZhOWNyMXJUaDRj?=
 =?utf-8?B?TWp4QnowM0pza1pYZ0g3ZFNpS0lNcms3bTkxZjJLc1VwUjFMTnRJU3p5WkZn?=
 =?utf-8?B?ZGl2T1NqcnhrMWhEbjU0ZXlrRENIZndMV2wwcCtNRUsvRmZMc2RPamx2UGc4?=
 =?utf-8?B?S29kSDRQR1FMY2V2dXJHdjl0UWVZSDkrc2dBVmRSZG5lRzdzV2dQOSttU0Fr?=
 =?utf-8?B?cUtsRUd0bWpLYUUrZW9lTUtIUkRacDVTVmg0eU42TzF4L0lHMFNUVmcwYStk?=
 =?utf-8?B?d3UyYUQxdDlBMXE0R3FWSnZPUEZ4UkJ2Sm1tUG5WY012NnJPSTFrU3F3UmxH?=
 =?utf-8?B?bEtNcXE4L0ZrZ2JCNm13Q2orUkZSSkE0MlJqTzFXektnOWIzeFJ1V3VJNmh0?=
 =?utf-8?B?dnRQc3hEOS9PK1A5dGs2RlFsd0lBRkdVMFF3UzkxTTRiN1JSd2lBZi9aRk4z?=
 =?utf-8?B?eHF0UVNKNFB6cjhWRkV2eEVZa2xIRFRlMHVWcUlLWFlOQXE3SU13c20yZXNJ?=
 =?utf-8?B?Q0xjclk5Yll2ZitIS3ZZcTRCKzJJL0hqVFROMk9CK25mL3Z6bi9hUUVHLzln?=
 =?utf-8?B?cUdUSnBVc0dXc2t0N21DNEloaGJPVzE2ZXJIT0R1bHJrMmNTaHd1TTZhYm1E?=
 =?utf-8?B?YStHb2tKTlVFQkhPUTRWWE83MGxJeVFNRE5YNDNiY1Q0RVVKd05LVzM1S1dH?=
 =?utf-8?B?ZEpZY3hJOWRFb0xFZnBoRVpHMFlySmYrbVR6NnpVeExzVnRxZE15a0d1U2Y0?=
 =?utf-8?B?dGdPOXdqaW5KQjFJWHhnaklrZERNOHEvVE9UTTdCNW90WUNtcXVwRHRCNm5K?=
 =?utf-8?B?TTBrd05pZTUyZ2I3QmlhbE9NSWhLc3dXVkZqRHk5WHlHSjBITWhFaTFnbkNU?=
 =?utf-8?B?UDhIMHhtVUVDNTQ4TGVKcGFHUk1VYXpRR3AwUWxrRHVqSExaaHI2UDFBQ2pV?=
 =?utf-8?B?MUtzbDZYS05lRFVKT3B1U3NtNW1pSTlLeTQvOUJXdzI5V2tjcnJUczhnME1o?=
 =?utf-8?B?UnI1VWkycGtvd0Y2ZTRWQ2NWb1pVd2tBWkpUN0Y2VTVybmdrN3QxYTh3Wllx?=
 =?utf-8?B?M09lakxTa2lTRXdKRktyYzhRdVRmTDhZaG0xdjFORlN4NEJVRCtwZUc5clZZ?=
 =?utf-8?B?TUgwWFBMR0RFVUIydXpqREU5SXY4dFUxZlFHbGtBQWFBVGU2NWg1U2grYVUw?=
 =?utf-8?B?cW9qYXc2RWdRZnYxOGhRcnNHUVdtdFFXSENBRk8yNUlzdnhmVG4xYlN3NFR4?=
 =?utf-8?B?VE1McFFmSldJM0NRQ3VhSkViWU1vTUE5SXpCT2dnRW5WTnBwclFocnFIMGRp?=
 =?utf-8?B?dTcwR3FDd1gvaXpQeUpoYnBPODc0dERIaC9yYU9zb0JRczF0cGpQL3dDdzVI?=
 =?utf-8?B?aEc5ekhpN2dGMTZIcklhOCsxbUJNRDM4RXNoNG1XQUpaVEhQWStrOW5ucGRk?=
 =?utf-8?B?NlBpNkt1REJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFlpb2ZxR0lLSWpDSnlLcE9BTnBwcmxldW84TTExOElMamRudEdYK3dBL1Nx?=
 =?utf-8?B?ampLRC8wZ240QTJvYlU3dW82S1UwcDNKSTYxdkhuaXUvVGZjNXRsV1dvS3E3?=
 =?utf-8?B?bmFTdE44K2VKcWZDZmtXdFVoL0pVdktLcnhpUTN5bmM3K1ZMeHFlcDRyWEpi?=
 =?utf-8?B?cGh0dE84SFVydDBjek1tQlpMcTIvYnd3dGxGNW52a0EvSlF0aFhoS1paNGpt?=
 =?utf-8?B?SlBLWlMyaW8vLzhMS2t3encwS1ZFUGQ2L3g0Q3BjNWU5OTlkdlVvQTFxbDNi?=
 =?utf-8?B?YTk4U2J2RUNvdnhlQzdGTmZRTkc3Slg4YTJzQ1NZd1d1TzBMWWF3MGpUdENu?=
 =?utf-8?B?YmNKWC9UYU5hSk1WZCtoTXB1UENBR3o4ZjdacTdRcUl1M3BoSlBIdkdwVVU1?=
 =?utf-8?B?VHhwY1JQeFl2RWJ2ajhkTXVwMXc0ckw4RWZQTzZFVjRncTBxMGRTclJJVStx?=
 =?utf-8?B?Nk1xSnpYc0hvMDB0cWl1eDFSVnJPaWFJM0VZMFVHeG1tcFNESWlHUmU2VGxC?=
 =?utf-8?B?eWxPZm1teUFhb1N3SXJmVVNSd2R3NXhsMFlkK3J3UDZRNWZLQThYQXROdmJ4?=
 =?utf-8?B?c1FKMDRYVlQ1MGVHVjFXaTRyMWZON0hGcUo0UFE0bDZtWHJPTnNFbi9pWjFY?=
 =?utf-8?B?R0N5a0FFdEZ0OVhQMXh1QzhJMitpa1BMdEduVjNsSnJvOWsxZnNCZTRkTDd1?=
 =?utf-8?B?VXIra0N5V3RwOTZlRk5EVVpyREdpMTd5bkNhenZLbWN0NHZyRURzOU1XMWFz?=
 =?utf-8?B?TXlQSXBIRmVhK2duRC9CUkVWci9ENXJlOUo3RmNuejJvY3NiZXYvcE16anVz?=
 =?utf-8?B?NVpHWVdYem82MjN5ZDBCV1hyVlRxQWVVRkRXZmVZaSt6L1NDZ2xCZXRmVWhi?=
 =?utf-8?B?OHk5TnQrNTY2LzQwV0YxK2cyMnRWK0FKQ1dLY0tiZW05WXBYdWRFYmF0SDJa?=
 =?utf-8?B?K1N0ZC92NG5KSmpBaDR3TlkrZklOSVJEdUppZnRtSkhpN2lRSjVoY3hnUXp3?=
 =?utf-8?B?cHpidDFMWjkyODAwRXVkeHkvK2xGVXNlcVluK3F6Q25vZHlNTDRsWHBBYkR0?=
 =?utf-8?B?UHR3b29PUUpQdE8wV2gvQzNua0xVSE5jYWJkV1NaWmlsZ3NjMklsNTFYNDVE?=
 =?utf-8?B?YU9IQmxPRjA5VWlxQUIxa0hERktkZERqRDFaWkMzOGFZc3BPdzhQZVExWEo4?=
 =?utf-8?B?VktnSmVJRXE1Q3hGNXkrTlplc0lQM24wMWs0ZFRFRkh5Y3VMT0l3SEF2U0th?=
 =?utf-8?B?cC8xeHZBR1pDZFpsZ0xIQ0lPdUdjczNGR3NJbko1Qnp3OFV5U3R6TU1YMm1T?=
 =?utf-8?B?VUJrRmdLV2NEeVVXR2daTGFjbzNJQkJubDl5VXdVT3Q1d1B2KzZHM3o5Rkwz?=
 =?utf-8?B?WUMyV29PM1JBVVpzSzgvRGhvQVhIUytGUHJMTk94dUo1UkNLNjhteGhKempB?=
 =?utf-8?B?akdhSlBSb0FHNmxPZktDT2RqbGVTdFRLTGwyb0swc2R3WjBNSmI4a0xDYUFs?=
 =?utf-8?B?NjczeXBIV29pejRjK2FvU2JwVEpKQTFYalZXd3hteEI2RmpRWHNwM0dydWRy?=
 =?utf-8?B?aWszcUxNWnl1dWFoYk93SnVYS2tWWjRETUo2dEFwRFJOZDR6NEVLeW5OZndW?=
 =?utf-8?B?Q284YzQwMmIrQmZacGg4MndQQzZQQVdZRkFBT2Fxc3AxcEcrL3JmRExyR3RO?=
 =?utf-8?B?VEwyS2pLQ2tXdDZWbkpDWnBsQ1VXcGxvUzZPU0F3QnNoRjFHUXlpVy8vR3B3?=
 =?utf-8?B?WE1kcEU4UXQwbk95TytkTnpweEhNNHZJT3FYNlYvQ29xWGF2ZXFOT0hUVzlU?=
 =?utf-8?B?OGczWEdHeDRMQiszMzJlNVo2Q1NyVGl4RFBCODIyZlRKRzh1eTkxRTlQd2xj?=
 =?utf-8?B?UFQ2ZytZZE5Jc1hucWdiSGRpRzlPYTE1N1VkTUdoUllyRnVaa0h2dE90MHF5?=
 =?utf-8?B?MU5oOUxaUy9wUW1zbjFJeTd0ZGFuQUZ6ZG1KVkpXckUxU1R5dXZaR3pqWnN2?=
 =?utf-8?B?dDlqNm1COFl1ZUNtcG13QnRhTWI5cnZSYjZHOC9uTVhUb2Roc2NsZDRnRHFm?=
 =?utf-8?B?Smd3KzRoTmxPRjBoRnIxUXpLOGxZOE92dFowSi9XbnBTMnhucVZxVzlpNDRk?=
 =?utf-8?Q?cMhPpIP937lntJxoUredIXMXD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87746ea4-38d8-45e6-5156-08de2d4df4d4
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 00:43:17.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faqB5vJFxdZV7NyseGu+YTbFQigG1Q77TaLke4nnut+ZstMXF5nlBMhyEFHZVxvxfChC5WmVDQoLVK7K5u4eBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

The NVIDIA MSX4 HPM (host platform module) is a reference
board for managing up to 8 PCIe connected NVIDIA GPU's via
ConnectX-8 (CX8) SuperNICs. The BMC manages all GPU's and CX8's
for both telemetry and firmware update via MCTP over USB.
The host CPU's are dual socket Intel Granite Rapids processors.

For more detail on this architecture:
https://developer.nvidia.com/blog/nvidia-connectx-8-supernics-advance-ai-platform-architecture-with-pcie-gen6-connectivity/

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 246 +++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b7076545e6babb2f25f302b5d70b71d8a19..c3ce0d218b53f2b4c37061cace483f5f2c6d3bf1 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-msx4-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
new file mode 100644
index 0000000000000000000000000000000000000000..44f95a3986cb9e2c6902ba9b3c1ed56e782438b3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MSX4 BMC";
+	compatible = "nvidia,msx4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "uart5:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			reusable;
+		};
+	};
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
+		compatible = "jedec,spi-nor";
+		label = "bmc";
+		status = "okay";
+		#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		label = "alt-bmc";
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		status = "okay";
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"ASSERT_BMC_READY","","","","","","","",
+	/*C0-C7*/	"MON_PWR_GOOD","","","","","","","FP_ID_LED_N",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N",
+			"","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"MON_PWR_BTN_L","ASSERT_PWR_BTN_L","MON_RST_BTN_L",
+			"ASSERT_RST_BTN_L","","ASSERT_NMI_BTN_L","","",
+	/*Q0-Q7*/	"","","MEMORY_HOT_0","MEMORY_HOT_1","","","","",
+	/*R0-R7*/	"ID_BTN","","","","","VBAT_GPIO","","",
+	/*S0-S7*/	"","","RST_PCA_MUX","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","BMC_INIT_DONE","";
+};
+
+// Devices on these busses are available after POST
+// however there isn't a great way to defer probing
+// until that point today, as the BMC doesn't
+// have direct control over when the host completes
+// POST, especially from the kernel.
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "atmel,24c256";
+		reg = <0x51>;
+		pagesize = <64>;
+		label = "sku";
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs1 {
+	aspeed,lpc-io-reg = <0xca0>;
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&lpc_reset {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <80>;
+	status = "okay";
+};
+
+&uart_routing {
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
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};

-- 
2.34.1


