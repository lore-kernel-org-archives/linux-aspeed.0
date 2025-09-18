Return-Path: <linux-aspeed+bounces-2286-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00ECAC597
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 23:12:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWcg6yBbz30Kg;
	Fri, 19 Sep 2025 09:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758237139;
	cv=pass; b=LCofuPgZFzWEE1qQV0ZgHyYIAxvpa7mezjgew0glDNXCG9a4eI8U1bBakitrH14JJZImWBIXrYJRiaUaDJ2sPVHq4l5z1FYdI6ZY/GK7X23rUhlZ9XuMoEyYiRqLwfk7J303ZSgiW+Zx4sMReLJiLhKXdNjHYpan7F50Jl2Uch5Tt54GxUNK0DmYDqb2kM3lYDAc+ofMKfSMUd/gPjjkAMf9GDc34pFG8KX4qZfehZrsv9CA/EA9F3/PCR1ItJ5apkpHHImd4m32ySZiHuPG9q2Y7nPUTrwiNnfKVBCTvKbUL9gZkuoNDE0QYpka1N+hzn2SJGmiUTXFlfFdaE3qwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758237139; c=relaxed/relaxed;
	bh=w9bwIM5n/XCOVnSMs4eCYVSz/6kGdaN7Ig84w9heCqs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GXiJuqAPPYbAx59HtlMkszsIgNjh+t4Yp3Jnm9rh7Ehe186UHc7uDorHr/GxwKDEYxVAArbhlwIiq7sa5FMksyT9rXofI6nVD64d6w+e0O60IZo5dATeM4CXe/SWNvKi5EzfZcl200Yuem9D14BxzRr3ZGPR/LWTwdQdNKd6mxUP/Gm/WIUSEwqlcURwfYGh9QBMKd5HlxphNdr4ciOUgfG+/5gvvgg3/cN07OFef+gTfi1ToGR4dd6qdca3m522OLFqHNrlOnLtyIaN+18ObTcnH1eO547Ng7m+Eofn5WPy7ES2SEFRhmfasxASwClEyywqbtXEQFhwOckWe0nPcA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nfM1FCm7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nfM1FCm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSWcg3XmPz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 09:12:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcOymWW3yrCBe1tJB2vUoOhJl3pOgVni1MzwjmMzlPHZlZWLcG70l/9+q9cLghC8FyYC/9xe+TIxa4+NLgI1t+E8smq9rrhdoTA+e4o+JPbxmQ2maZqJpW6POyOEkCPOffg3sNx6rE/hSdbgDLWalvRH/C2P9krTojnIel13ZIHlbAdtmnBdvoZPMOX34L8WBSDvY+AW4QsIhh9t7FxMzhrQcE+CnuLOX1nvawcw+UiCI+1l8igPpwy71CJTMKdNYFHyTLWkCRzsNm1yiljA8dx48WHNAfavej5oS1IMCIoszmfxrgm8N/phOR1Gw7f8feFP4zTwenHJznYZICuZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9bwIM5n/XCOVnSMs4eCYVSz/6kGdaN7Ig84w9heCqs=;
 b=XfdzF5WDaQldGiqRlJiVImxEv0F1Bnuzl87YNdq2AWduws++cJ39hXn6G1LJgdGxax8JSLbTPfJEmjLZeJWP0RhQmmANC65C/ug3aJx7YRczyftz8dtnW5DmvnXv6xGZzy501/c+UzlK1lm+ZJrEdh0M3yJm7+8t4fxsUoiGUQza6Aal8XX5+rpzQ6qd+y6ueuhruhpzW4fK/gufoVf4GY941Yz6yLdCgcExZKiZ6dY0H72IYbBeNKCi0J3dDwbdEtjL7mu7CEp5SjCk0S+2ZNQtjvkcxW080VMdxOjIpk92Dfur56A7IMHD/WT9Ponzr5hXc7M/dajmS/fa0EDdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9bwIM5n/XCOVnSMs4eCYVSz/6kGdaN7Ig84w9heCqs=;
 b=nfM1FCm7msMl9ms/mBq2GIUQvPDKi53zKarsPif12h3po3gJzL1VXiEP2P8a5RhbofKO8JSjUxTue30g5NPdAbdjKt6d/EvlmmN8kA5JdQtFzyXr4cJwU+J5dUZZ55d0gWThqFF4kWyLx6wQfKnAFewdZB07i+ua2eNV2u1SGSdf5+FluYG4fXXz19KiFsDYFaHr1zEYw6wFRiBrPlQ1zsFGuZvqtUWioZygpWjUkJRgEq307Lw8ST6Sdwptq4BXrEFXFXJCiSCs5PdnncK67qWFQFLb00LAMeJxE+1DUSNTkj6xjbfqo2ml+qWfqFapjaLjt4WfendeWFFexHSRtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by IA1PR12MB6483.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 23:11:53 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 23:11:53 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Thu, 18 Sep 2025 16:11:37 -0700
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
In-Reply-To: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758237110; l=875;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=ZJJFIGMFRHHgtSGTby4K+R6JfVS7gZB49YWFVBNLhm0=;
 b=kjeg/eJtSnOlIfr/83B5OecfGQBVh/iU3jcEGSBTmFObn1zFfL6EXOuhiiog5TjVtDoLbCKHS
 ijzDFXriq4XA6wDJZxGYCr554KbpuiXrlD8/cZWQZvIKa16Hd/n+2vq
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:303:6a::22) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: d338dfa0-0269-4c24-72d2-08ddf708c1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnArckFHQTNNVVFxakdFYlZXY0RkelFDa0I4dm9PbS92UlZVNSsvbGljVmEv?=
 =?utf-8?B?QVRDM1ZHelpydTFMTkdFblgxMGVJbGdYaGVySGx5NUdUclB0a1hibWMrSDFy?=
 =?utf-8?B?Vy96UkNTVThJMENhcys0TnU3bVRHcUNrbVlOUGtkbmFhMFZESWh2amgxNVdO?=
 =?utf-8?B?VEVvNVUzWXRIajdrMXNzaW5HL25OdXdDUGhJV0c2OUFhRDg5ditrNmhZdVpy?=
 =?utf-8?B?RU9QSTdVWkhKd2ZvSmVVQTVER0xXTTZvMSsyUVBqWGhZU0RkNVUwNTVNTGFV?=
 =?utf-8?B?Ti9lU3RZTDRRblhUNUlaU2xhR2tvS0lnYm1odVIzQXZLSWJoVjV2TTFmSW5s?=
 =?utf-8?B?S2t3MlA4enk3UjMzdFJLeHp6NFB4LzVoTGlQOW1KNXJTY2lTTW5CQkFPaDA1?=
 =?utf-8?B?RXpkRDdYelZyeXNpVEhiaDFLcmEvRnlESWVKNjAxYmJOTEdBa0UrTVppZTdB?=
 =?utf-8?B?OVRXeDdjYnVHMnpRY1dMWW1ITmdRbFZiMWdEdUZneGNjRVhnOFU1VlNHSG5L?=
 =?utf-8?B?V0VUS2tXeG0zNC9haStEOWdrV1JKTEpoZkxQN1l1dmljbEM3RVpNT24vSGps?=
 =?utf-8?B?c3BnRlFlYjRaWlFySWVWUVhXTlFpUThESjh5dmpjcHZxcUdhaUJNMjU5NjRE?=
 =?utf-8?B?dU5HbEhvN2xmQW9uSlFFcElsL2l2SWRRY0Y3aXdraE42VFFjZHFtUC9Ic0Ez?=
 =?utf-8?B?V0kvQ05mQVg4ZjdJTFBxQ00zZmxkSmhOMytsVXlvMnZmOWZTWWpKS2V3dXhE?=
 =?utf-8?B?N0JjdzdOTFNCbmpxMWpmb054UEFkOFovSm5SRVp2N1JDdnd3NlpsR0RkeVhw?=
 =?utf-8?B?TmV0MTB1amNlaXZnOVhDcHFmTUJQWVY0SWtlVkc4cUFaN0krTk80Vk80ZFht?=
 =?utf-8?B?dDVoaWowbWYrWFZkNFZ2QVRHWEV4cVJPaUlQOWtyeW44R3Qya0tsR3NuMUl3?=
 =?utf-8?B?aUQ0cjlqTTZCWVM3UkphbWg0Q2JRTzdNNEkvdysrZ1NQakFLZW5DQzlBRSs5?=
 =?utf-8?B?NGNLdVpPa04zc3hIOXFWQjRxV3hoL0xYM2JyZzZkY01kWitLaGZiTUlPQVhH?=
 =?utf-8?B?Y1NpR0RJdnpYcDRpd2E4QTRHTU1pOHdKeWlqYVRYUVQvczQ0aVpUZmVSYlVB?=
 =?utf-8?B?WHFRVXQ1bU5kVTFkZnFSZFFpdWNONVBRV2c2a25wYmZPUzl3VjkwcHNNTnFy?=
 =?utf-8?B?dWlVZTBMbjArQitVQ2VlQ09OdEZGODIxcmJKZUsvL3hTeGVRUXMvTWowZHhE?=
 =?utf-8?B?RWhNWTAydTZRZXAxYVZYWmJHTVRGSHR1QjZERFVZUitoZ0NuRDMzS1l1UWJV?=
 =?utf-8?B?NzczekljbGhnUzZNQTZQODJ1dWt3bjdwQ0IvR3kvT3pNTXpYUUxnL3JhMjIr?=
 =?utf-8?B?dWFraWZvWUFPb0RVRk0zRGx2SEZHUjdpM3BXdUsyZXRKNFpLZ0VVcWd5QlNF?=
 =?utf-8?B?c3Q5N1I1YllDL1hXUFptZkhrUm9DTm9URHlBV0svejdNMjRhdi9KWUZNUFZt?=
 =?utf-8?B?eitXWkZ4NGJVMzFUcERJdVdrNVJCSjJjeS91OEgzMEJ1SnE4S05ybTE5c1Yv?=
 =?utf-8?B?WDRsbGpDMnMrWm9uM3BPeGE4WGM1YXpURCtMVktSVDY0SDJiQTV6aGtlSHZ2?=
 =?utf-8?B?cUdSbGVibFJ0VElEMGhKdnRua0JrMVBOb0pvaTBEeUJIZ2R6RHU1aDZJMlZ2?=
 =?utf-8?B?d3Ixbk9nZkF2bzJXaFJ2WFlOTXVsaGRpNjd5Z3ZmVGpUV2ZZQ0tMNlNqT3RL?=
 =?utf-8?B?L2huY1djbUZTZ3JPNHlPdndYNTYraFI5aisxNVM4VGNFRC9zbk15c0poWHlZ?=
 =?utf-8?B?YkxST2lteWlZMGg4R3FzSHFxZG9LbE5NUEVTaXcydFlWN283YjhiaWhGdG5y?=
 =?utf-8?B?M0g0cHpSb1RzYTVjcFdaYUNJZXNlV1hwS2wzdlRCZEFwTmZsZU9ZUFJIdnFQ?=
 =?utf-8?Q?nbjWj7KeWaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3VqaGJiRlUrU0hrN1ZCemZXZUpLMmI2dGlYL1F0NHNQd1g0SkFYd2RPck9E?=
 =?utf-8?B?Z3NEMjVlS1BnZjdjYW9uNythTFU0N3B5cmpmUmVpOFpuSHYxTFEwb0RMV2l2?=
 =?utf-8?B?cmpSdTNEdW1MdFpndW1ITThsL25BaDJGK0dhc2hvVEFmMklQcjJ5ZUNid0Nr?=
 =?utf-8?B?SnkyeXRDTys1bFBuUDR2R1cwcnE3VVlVQjFmU29qMldnaHRtTnY5TzM4UlRS?=
 =?utf-8?B?L3BVOW8xTFlOM21OU0NTRytYS2FySTYxQWRTTEhWTG9nWm96VktuQXRDMDhF?=
 =?utf-8?B?SVdRTVc2SWxjSnVabk9LQStyN3NURDd2MndDdG5hMm5IdnlRUS9KNkdPSEJt?=
 =?utf-8?B?L0FndXQ2bzN1dEtQMzNoSG9Od0M1bFJ1NDF0WVZMck5QMG94TUo0WFhyM3Vs?=
 =?utf-8?B?bHhndE1HSzZ2MW81SVB3eWJvUTd3TElNNEFCM2hPQVNjaXlDK1RBYkV3QmZp?=
 =?utf-8?B?WHl2c3hCZXl4THV6S3g4N2x1d1pVNmk2K2pXWUpNQ0tSRXlqd01Ld1Q2MjBG?=
 =?utf-8?B?WjFMNU9jWi9KdHk4blRSRHl1dTNxUlp6WlJPQ09iNUp4UVpJSW0xRnEra0Rs?=
 =?utf-8?B?bkdlQmoxSUsya0xLNXBKWTZHTXVzZkw0YzJCOGhKRGpFWVpjL3o4UUVPV3R2?=
 =?utf-8?B?QWpNQlJGbHpha0hONnVtakJxUTZJVGRUVUJyWXNuSEJJWG04bnJnLy9lT3Z4?=
 =?utf-8?B?bnhjUE05d09mQ0FGMnVnZkl2RkNpMjZzM0ppSFIrckQrRHNxWkJEazlsN0xT?=
 =?utf-8?B?SVZ3SEhjVEgzTTRGZDVMbW4wS3kzYjJqMXc1Z1ZsSXNIV0ZZem1aNXp5dVNJ?=
 =?utf-8?B?NW1BVzJlMFp4MjBHejlsalZsTklORDhIcE5KUXI0bmhSbGpKazg0UFU0akh4?=
 =?utf-8?B?UDRzTTVOZVhYa1BRc3NJQkVXcE0zTkNWQkQ0eVJXMmwrVkZUa3h1OUo5OFpq?=
 =?utf-8?B?YUw4d09CK1VXQ0RsU0l2YjN4cW4xT2tJZVJSQm44ZUc0aStiRTFMa3JvT3JV?=
 =?utf-8?B?OFl4OUVvcUpDMXdnSzNHZERaVnlZbGNTY3BhQUptZnRRSVoxUVQ0aXpRSXFS?=
 =?utf-8?B?ZUJ6bUNhRXVIMUp5YWVXWkczTXpTMTloVUc5aFFtTWZyV0dlOW80eW13bHYr?=
 =?utf-8?B?aDlKSmdOYTlDOER2MFVWV2l3cmtkb3ZyeGQxc1JMenFKVElxVGNubCtCcTdq?=
 =?utf-8?B?YmxMVTI5RTJySU04SUdDcStGUGpyWjBiU255ZmZlMG1BSk9lSFFMZXg2N0V4?=
 =?utf-8?B?M1ZvVUlVNExHOTdtTkFpZlRaV012VmNLbHBXWjRmSE1nZzZaUmF6OGhMYzJS?=
 =?utf-8?B?UmE5UVAxWllHeHgzL3Y2eXRJWmpZWFZDVVc5eXF1S1pOTjZWQ2NWR2tuMUVD?=
 =?utf-8?B?ZFcycnpmZDN5UDcwSnhMcmxXVTNndmt3dVU1bFB5b2QwR3A3SG41YmFES3FQ?=
 =?utf-8?B?YzdxY1grQzNTb2NITE9jUWpIRlVJY1lId3RjYUdFbURDcmU3SDFpUDlOVWQz?=
 =?utf-8?B?M1Rsem50Q3IwSjBJZ1JzYldYckIyamE0MVNiVXJrMXU1cDg0d09MSXdHTUln?=
 =?utf-8?B?aWNJTm5XY2h1NTJ1TzYrY2JjUERsazlBd09sSEhBZDNVR25SeXhIYUVIMzRR?=
 =?utf-8?B?SjU3MFR1YTlrTUkwUWc5K1Y1ajVzVk5OdTNONlhBZG5ISW9UKzl4d2FBaTVQ?=
 =?utf-8?B?OGJEN2ErUHRmcGtRN0UzbG5vc0FxVEhGbFN3RHBrNkpYZFgzQXhzRWhlb3kx?=
 =?utf-8?B?N2RZdldlRys2M2JKZXU2OHRDRXhLSkp5d1hNQ2ltL3NBbUZLdTlxeEJIdDU0?=
 =?utf-8?B?RVNBbDBad0p4TlpDaTVXMzZpcis1OVV2NkIvaFI2MjZFbUovOFdjQmpDR1Ry?=
 =?utf-8?B?a0J1RFNVV2xUekt5VU5HbTNDdnFQTm1SVjI5WGtoUXcrOVFDMjlTREhTdlNV?=
 =?utf-8?B?TkhubjJYcW00aUQxdElFaEtBTHZBSzcwZm9SRDdaSFlmMkFJc2pYTDBpZWtO?=
 =?utf-8?B?cGFJOTh6enJpdU1GZ1R0aGxOekp4cUlTdzVxNUZpVERyVVlpZXVBdjQzTHBW?=
 =?utf-8?B?Sk5vUW5wVW9pTVZBbWkyaGpyYUlTMUFZK1BReTBLV1ArZCsweXhib1NrTFpU?=
 =?utf-8?Q?Z4WAr68HwUWL8/ehdpPQYqA2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d338dfa0-0269-4c24-72d2-08ddf708c1a8
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 23:11:53.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmHPkkxag9NPOUTEUWK2jRPBKwCT7W2TRGk7Xi8mbgC0+at5c2zWgZS00cVaOl0yvXk9I7uLJjuUZ29Vm5oaNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

Adds a compatible string for NVIDIAs msx4 BMC board.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8f4442be815284e1ad085287dc443..cf963d8aa475d08bb383f3ba63b72f98f23af54f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -100,6 +100,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,msx4-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


