Return-Path: <linux-aspeed+bounces-2989-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0570CCFD360
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 23:15:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFhVt4fT8z2yvN;
	Tue, 25 Nov 2025 10:15:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764026102;
	cv=pass; b=N+ZJ68Ey1qoYi+w8sV7znW5ia4G6jRQ1XVbiS+HskaIHGcUfgy0Ok59kTJl8J7c5pV0yLsYdmoM7Db/13nPs7FaBhyYn3VA0HrYxzjB6tylP1K8WkAboaeKgu/IBXaQ9elT49f6Pt9RTwcv4J08gY1jOxGRgXG8Sv5O6jR+4uU9mSkNgOGKtsokk2jRZ1CvzmXTtC+vxpn15BD/p8vD59abWAyU452+NFGRqZoB0s1gfafthqj/HvNpey7yZjpCFpWWRPUKJQ5eWEWQ9cYJBK1Ge2SWKuUkbRf0KO/dPTpOlmdWD3BDhL5D4FcG6sDsgoa8xcDrNWTn/qF6u3FQPfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764026102; c=relaxed/relaxed;
	bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SkoA5+1oCGg1eOeH21IdLd+7vz09AgwhEaw0QnYt0HkSqrk4vVnoG4gY7Bt8gWTkNubhYwHO1/l9YYixpuzrn2lVKrK4MRR8RyDGIOlD5MbboH0m9CpBk2fHPXWX1fqhkkW+OzOxcZUZvS6l4z7qkfO8AuA0+Ay5eL1HLMp+KKXjup6A6esXOI9V6d6ZaI18UogfKX0mcKi6B6GaD+1JVdmTI82CAOKJWfiIENu6K23jInlnQla2zZXl9K+4nNkUGBhWjgDhxlOaZ38Kd4LMI33WHKbmlhjkWc2y9oeMRtTpnPZSYeA2iMr984nHoYu6fyfcflkHR8CRZsM/4jXPrA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nSPpsWrF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nSPpsWrF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFhVt0mrkz2yvB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 10:15:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/RAiads6zkni0j0179OgfNwl/yDaWsfzc6OOECT6Qx+r7wCTVOXa5HxdHU2e+6+WH6gFhkASZ2qjNwv9C4YLM1OxylFO19KAEYwq5ZcHNu0ZusPJyp0a4QS26/y1me9bqc40h4X/73IOZGW+XFQHw0lM+Gq71P3k2UvRw3tm4G9uFwMggcOktdkBcSZWczwDmHyLj8fzVzp9aHtRnpL1T8oKcixshp4PSoNoUVm9TvNDWWZWvOZFzWi2F7xDGPAtmkyVIPmA9KhRTG20vcazEkIHsHPhgAquuv8zlVnUBPlnMwxH+3VjGfe7KWCCp22Mwj/pnBF4svxa+xoxAqtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=qD6jNY7D1xrNiQ1F1yCi0f2zMezCkn5WZgzwzjVQ/ssNhvI0NiIC4Q36aZETtyQJNBTuG9dI1V6kRzcS2j5yyocVvPpa6pqZnB/vHTTnc8Z3uBuUervB+EJgacm3mu65ROXM0zY1brmqapgGEdVMDy7D8RTd6xr6iJGOSGp0JGDKcgFeqNNZKrDjvkA1HVPyLRdmVLPqbG3XJlafHgKyp+hawn8QTT4Ttbh427HdLAaK4eCraFzYBxHFETprTAOKIhdRwRuGKQw4vMD7tw6aXhXIMJCqW/4ccXnqMbqa7mOPvxnMoE6R7BTnQQlNPtWjuMDLS9iqfJZGHVprGeWQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=nSPpsWrFyJ2L/A5KMdTO9P9tLwMWebSZxIa+g2ZfIw/biIRDMmt5LljbMdmzR7TcQULJG5sCyqsJyhxjhonC3TUMlogJHap2mFqMjAuKujLpoAKFC9hTspPJYjEfDUnC+0hVoPsWQ5IgsNX6elm5G51emUVq3OUCx0CsSIOWlITZ56wfpq2Lc9cah7nZeU8XDC7DfE2qdUlFsZlo7w7+lmQXLBWiImUqs2ZzCd57wADuKLkv+2kg+JraPtaO9u4CYJs/G4Zs+PZjiammWKgyb4W2Ek4roxS46due1DItkxTjrQfyWnhiebE3vouSguH4M4iwkaeLeCgiqQRtMf4NSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DM4PR12MB7598.namprd12.prod.outlook.com
 (2603:10b6:8:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:14:37 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 23:14:37 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Mon, 24 Nov 2025 15:14:17 -0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-msx1_devicetree-v4-1-a3ebe3110a67@nvidia.com>
References: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
In-Reply-To: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764026074; l=928;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
 b=wpv7TxM/Jhn7mI61QJLml1Fh2w8gJ+JZp8plVjKGUhfbNPdDI4HagBcsX4m7w+kbAE/9J2cIz
 pDwVpl34AGvBwqTlABP69NDm0/tPvl/44G9FH4zEaeHcexsvkO2Y91z
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9777b6bb-4f65-4fc0-5984-08de2baf3c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW1sakM1aG92Wjg1OTU4NkFYZHh3OFp5bDNKMm1PWVNpZlN4SDZ4RElNYmVZ?=
 =?utf-8?B?eVlqSE1vZXV1bDBTbDJRY25BQXhBYXlZcVFnSm5HdUtVbGVyTGVrMHV4cEFZ?=
 =?utf-8?B?K1BmMzVvcit4WVBLdG13SHB2UTc1NElpWVFTVE1yNHpDSDUyM3RmMVMrK3dw?=
 =?utf-8?B?bXFVeFA0MG41aUp5VDJ0MUFmU3JkR1d4N3JvUlpWdWJqSElQWnZkeWNQSUMy?=
 =?utf-8?B?OVptVDd0VEpCWnZRRUIvWEM4WTZ3RUg5V1puZGUvb0FraXRnN0luZmgwVnJW?=
 =?utf-8?B?S2p3MjJ2Q2JVSnNGM2t0ZUN5bWRyOUNzT2RoUU1kUmpNVml1MjdENG1sTjVv?=
 =?utf-8?B?VmtnNytBNUpWbjlaTFpCWGl1TmRvV0lKaUlVZG5obmFEdDdMRktaMURYaGt2?=
 =?utf-8?B?d0RJNlVmTkZOYlFlcG9zenJodjRESlBNWkVQN0lVSHVPM0lQU2VzNmZGS2dN?=
 =?utf-8?B?N3BwOXFsS2xkbnYvN3dBa21tSHB0V1EweTRqMXB3RDdia1ppUWdqN0QyNGsy?=
 =?utf-8?B?b29XNzg5VTgvVEgrWmQ5SjNSc0crc3BuRHpyQzAzTFc4dllqSDFVUStSelp5?=
 =?utf-8?B?MnVYdkhvUCswekhXbDh3S0Q1aUdSb3hKSGhET1U5eTltMDJjOFhSQzRNV084?=
 =?utf-8?B?ZlU5Tm44V3RpNnVoaUlGU0QxeFNQQ2FsZkxGN1p5QVFKOTFiYWpXWm5qRE9h?=
 =?utf-8?B?NUx4SFFCWjRXWUpmZ2lmSkRXeTIxUENYN3pZNnVRcFRkdGNST1kyU3IxRjNr?=
 =?utf-8?B?Qno5c252L2Ruc3FKUDlRUG9hUGZuQndyZUZZOE1yMmN6OFBYZkhMQmpTeGpP?=
 =?utf-8?B?QW1RNVVJTjF3LzZNZExxUTdUYysrZ3pLdFNIQytXc0NjK1JxajdvQ2x3YXp4?=
 =?utf-8?B?dmV6N0lXaVFGcjVOeDlqa2libEtCbU1TT0o4bkdwRzdHUm4wcjNWTUZuVnor?=
 =?utf-8?B?aTBhVkFQZm9NZjBhMitLL1BJaXdOd2JYOFcvckErNHp1OGN2QzJGMkxSQmhB?=
 =?utf-8?B?TFpBeHRlMlBhbDhMUFVCZUQvbEk1QnBhZHJLcHExY0N6K0kyTXZUd2t2VFR5?=
 =?utf-8?B?bUg0M0ZlKzZtclhwa1U1U2pEbmZWajc1VEZJeW1wdmNkRE4zUyt1a2pWMTc4?=
 =?utf-8?B?U1VCWlloRytqZS9aTlFUZExFRmFxMGNvZUwvT0NOZWJpUXEyQ1p5MHZFempE?=
 =?utf-8?B?aEJ5eWp1b3FTZW53bmpYbnVhMDFEamd3Y1ZWTFJUaWVUc0tTR1NqdEtIOWc2?=
 =?utf-8?B?RFE2azNWUVdpR1RiNHQ3RklRcGtLZEp0UkhDNVAybEo5ZzRYRnQ3K1NWWWtF?=
 =?utf-8?B?WEpmS2JMejRwTWFUK2dOdWs3Q0djMnZrZVR2TWRvNEZ6ZjVXQ3hoOFAyMC8v?=
 =?utf-8?B?QmgxWkw4SnIrbmN3aGNQclJmNVU2STgrUm5DNzlvaTV1MUhtTU9UdjJKOXZo?=
 =?utf-8?B?RzR6dVRrMWZjOFRONmxZL3JHMDYrSWFaV1M1VWlCcTBZVWxBc244WmttS0tT?=
 =?utf-8?B?OEJqL2VaeFk0U3ZGUVNNcVFESEw5eHFIN3ZYQXBYdGZjYlcrcnM3eDNUeHBz?=
 =?utf-8?B?dkM1aU1xb21BL2RtQVcxN25PdmhhbjZ4YmRtV2tWa0w5WGhWbHkza1o4M3NL?=
 =?utf-8?B?eHdFaFc1WFQvWmFrbjBsRjM1QjB0bVRKcVpsbXdUTGNXV2drUHl0SmgrWlcx?=
 =?utf-8?B?V0hmeGFGY3FOdG5CNk9XZVF5cExLT3VKWTFwazBJaDk3cFRkRUdhQ0lnNGEr?=
 =?utf-8?B?MHNVS3ZoQzh3RnJnRkV2VWg2d3JZYUg3ZkdTVUxoT3ZOWGkzaGFTUnF3UFoy?=
 =?utf-8?B?bkZ5eFYrOUVWQlZiZjI4VjkyaXRDcHZlR3RzajhBRnlIR1YxUDhyekZxaXA2?=
 =?utf-8?B?TjFRdWRxemFLb09WcmxPcExOU0FqSDNtTDdYZ3BwT3o4c3U1cXB2Vmljajkr?=
 =?utf-8?Q?gVKtaG2x6wcSmZ/0abeBT0ZI5o1zdh5x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azVnaVpWN0dxYXBOOHJLVFVNN3NCVHN4VGlXY0tqODN5SXFNTzRNN0RLRnZC?=
 =?utf-8?B?U3VxS3V5N2krdmIwcGZqSjRqbkIzQS85bWcvb3U4RE0vdURORExIWlNGMXVS?=
 =?utf-8?B?d0tmNytTTVc2STU4amdVaWlFRVNUUFljWFd0S2M0K1ZDcWxoS25KTVA1QXh0?=
 =?utf-8?B?ck8rK0RYZGxiSnNWVXhGYVc2YWc2d0tSbWdodjUyRkw5T3NMMVpnTDBwR0lB?=
 =?utf-8?B?eWIzeitXd0gxY2RNcmVNTkZyaFhKV0JLbVYwT01lYTA5YmxudGdxZWJBSFlR?=
 =?utf-8?B?d20zS3ZjTHgyeFArTk9wQWloaSt1OCtuYkFDWlV4WFZGN2ZJSWs5ZlFMRkNI?=
 =?utf-8?B?dWZ3bnNnS3M5TnVtK2g0RFhueGlCekE1bWFhelVLVVZvejA0QlFVeGIzVitu?=
 =?utf-8?B?NThWZkpsV1FJSmQrWVRNTS9VMXZMK0E1Tzg3L1ljZUZOOWNnY0tGTVMwaGZx?=
 =?utf-8?B?VXdMejYyK3FMWHEzcVZya3RvazhiQmovcThaMVJNN1dCdk5Wd1BjNENzdlZm?=
 =?utf-8?B?MGRuaUlRMndEMGNVNjQySklzMUY4QzFNNVZ2bGc1Z1ArVEJpTFp3UWVHT2tZ?=
 =?utf-8?B?ODdvd2l1QzRPaUZ5MytSdTlCdUJnV0YwaTFxalJoMkM4SEJXbCtYV0NhS3Qw?=
 =?utf-8?B?Q1RITGF5ZkRCWUdSYytHYmpPWjBPLzlENEZkcDlJN1V5Q2N6TExrMFR1QnNx?=
 =?utf-8?B?YTkwekpnQ1NuQTQxZXpac0JEUk5sZHZvb00vWjdDZ0daTkpCbWs3YzlwUldV?=
 =?utf-8?B?TW1QaHU2MDlBNXBWaU9udDhRQjZHUFBISUhZWExUUXlYc3h6MnZ6U0FZblp3?=
 =?utf-8?B?WHowTklXWGlwTTRYcW0wcTh6MEtBeGFOOS9DNGx1OGRiVEtBaGtzOThjYVF3?=
 =?utf-8?B?cVdRYTlRd24rK1lXbmZ4dkxrT1dIRUhpM3pKT25BYkd1SWozemVnU2tUMGx2?=
 =?utf-8?B?b25YaGd0NzVoaHF3OENnOEl5aUF3KytsY29ad05XOTJsNTh2UDlXM2lscnZJ?=
 =?utf-8?B?NnloV1pOaWF5UFo3Z3pPWUpGcTMwRHlHQzZPY3lSMk1wNXpRbUhVKzdBTm1F?=
 =?utf-8?B?TEx1LzdSazdRd1puN29mZHBma21iUjA5dDlLSk5rYXVMY0pRTkE2UFZIaXhG?=
 =?utf-8?B?OEtweWJ3WTZnUy9FNkpTWitKTEp5TmlVUGNVdGVaV0V1cmRlYXVHVXBSb3hJ?=
 =?utf-8?B?OXpEQXA0aFAyVHVwQ3Z3OWpuc294VS9JQ25hZERiaTR3eTFyZ0lJYXQwYXRD?=
 =?utf-8?B?akFtT2xlMUVscTRVWjV5MG9kOUZBakU3RjRqcHJNWjFTcmxJS1FOaHc4eHd4?=
 =?utf-8?B?eXdLL1czbWtWcXF2VGdDRDY1dHV3MThyOUE0RHZJSitnYmRPVmErOVhHQXZ0?=
 =?utf-8?B?ZVlvR2lxRHpwRlUvTzVTWVJHcjFlYlMyNTYzemdkbDdqeG9NaVNLZENyYzhT?=
 =?utf-8?B?NjBNL0pZV3VVTGV0WVowOVdmbWd3K2krcTBGV2w2bitmMS9uWGtzbW9pZzNQ?=
 =?utf-8?B?UHdZWHRodldsTGl0ZjEyVEZDbGFnQ09Xd2hvMkVZTjZ2MVBsUGxPVXFGNlF6?=
 =?utf-8?B?Wm51TWExRFNqOVh4M2FWbkhBNXRuVTA2Lzd1VU44YUU4ODZhWmlBZUcwdG9p?=
 =?utf-8?B?RTJCaTg1Wm1VWUxnRGdieWMxYjg5ZW9Wc3ZMSm5yTmNzN3V6ZkR6VDJ2Y1V3?=
 =?utf-8?B?ZGJrakRGMnc5VHZnT1BycUE2Y2ZTM2RSdXZjUUl6bFVQTVFoVzU0S1NjOWtk?=
 =?utf-8?B?MWFZdmROaEJ4QXZFQnBqLzlsS2ZrQURNN0h4aDYvOHF4NUM2NTdySk5IT0tq?=
 =?utf-8?B?SG5sY01uckFtZHFRVHAwejBicG5QOVRwTmZkK2ZkV0ZHWXR2MGdPTzM4QytC?=
 =?utf-8?B?UVJKTHJKYXRuL2VqWGptZmxYNUxLWjBrMHlLSDdoTFNZNHJIYlI2eXNqcmVT?=
 =?utf-8?B?UmRBN0NJbHBsLy9Vc2taQytnUHJTV0JsZWhZb2d3RUN1U0c3TTZlOHVPS1dr?=
 =?utf-8?B?L0E4ekhubnFtRndFZURubGxpb1o4RTlEdWJxRXdydnIxSXhOcEVSUFZNZDUy?=
 =?utf-8?B?c21ZS1IxRTZ3YnV4MkVwWFNhSmNWQitoWG9NeUxCSFlQL0xSSTZoVVovSXZW?=
 =?utf-8?Q?AoKwhFGvx/QsUdkDhm0AkhnOP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9777b6bb-4f65-4fc0-5984-08de2baf3c89
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:14:37.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHJ1i1qKeiRvvVhlH9U82ueDPAusSaApndkEhn0OFO5u3+1OlmLuI1qWgYGfItxMhB525BwJIaZk9HolvdZnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Adds a compatible string for NVIDIAs msx4 BMC board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a80b5c9d14098b60ce277391fcdcb..5933eda3371b33f16a1129cbb84933c1393c9b2a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -104,6 +104,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,msx4-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


