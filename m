Return-Path: <linux-aspeed+bounces-3413-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EF9D26295
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 19:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwclQ4swYz2xS2;
	Wed, 21 Jan 2026 06:26:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768937218;
	cv=pass; b=AmVfLI50thATR9FQS09FEETdS4D6AK1jDxgEigaX7JXxA+1LmxitGP8WtzpefbtgMVNvssI41MQ2H6cvAgEdLx9yq3z1NoGMJhzE0F8rpMmhc65ddLk9KCaKHda1GD5C681Xon2RGpsNbFTZW6pybstsgniwBfAkx7Mga8F0R63yhsdi3y0qZz37wKvqZGh+i51n6JFj5AmasjAvkHH8N0+Lyruk5V9lEDvvhY78mC37uR9gjiWiDBUYbjSkLh3n/Nn6ExufrOi8YN+5Rlx25+ja6s8xESOTmAOqUhOSf+5tze0HYnKbaW86XiuDKHYmqC6lLbz/OlHjE1Shwu7ajw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768937218; c=relaxed/relaxed;
	bh=vY+8CGq7eOaoY3JYDVpaW/NTMXh5CLbovHTANyUKOE0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eFvzWpDeNTERpjbqvtZxG6jxn/BxBsNM1kXWF8Egj3b9kfLfEMbYSLVHyia9ADVzzItddb0HAPGpDaKB4TBD4UKNzT97GQqWT9gfoGGAIKDLEnNp5CuIlwvSv5bryotu3XQXlX+0BQfbdXnXHZHAea4H6R1vIRoY+0bdI5xrZgcHtA0FScndwuuF+bbMrVBmhHE5fE+n8USAxMuF7zxczTR6MNyFhvhweu9pfSsaEiQxLGiQ4jo27x2yezjY5nEf/mbCnWQtOxq4Nu3sxjmHR/2VS++DUxiec9vYagVH9YBEtCm1zKfHcYzvIVMQSqSkzfnMoWKkgeXZvt/wQ5Fx9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VyosqNbK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VyosqNbK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwclQ0tMbz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 06:26:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut8ng4lRRhNKem3HdKEb1RhDFbrfKs4Z1I0XMo2I19PhIUhlEakzmwtKci07dfz/dgPJFttHg8t6Myvybt1LBIrX1knGGiko6bfNwDCFVUhhM/p0hOuvfIOARk1+N5oGC3fMVdnVywO6h06y2eg1zPPzaqlLbiU3D9lS/XLI6WGq/221zZ7sWtQ32X6h4sVuT+s/p6ch5Wvm3SizwHfFlDE0K3MowQU11eTTeSN9TWE1Db5VTAM3DZQtEqDeTNN9ziwayZII8lWVJVNjC9540PlB1Mt/iXP81HSucX1+K5wHXIigtXqAmMLZEVCZCY+2an5knOAJMU7/3/TIUfhWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY+8CGq7eOaoY3JYDVpaW/NTMXh5CLbovHTANyUKOE0=;
 b=JBTyrgoPiFKMEEoarlG8detAw/K9Ig46F1eVyC9co9HSES9ZMuPW3gLNJ5vHH3tq7++TUXUPtDDxTpgKPOJlDhsgOQtTs+tP5hHUYuLt5N2nUgIOHtb4dthzjTRG6PL5zS16klMytDDWGZzi6mTDmFD3atf6bMlvzdF78NWienPzSk6N7pIE5Q6LQjx+gkHc9YXo2cT96BPK+8Z/Y/j8tUyagVwc+6K4mM93a37K3OT6Xs3H0sx5cwpfrTGenktXeK7J2+ahC4WtmL+PRxau6CSOyAMYQcAtmFXsp2Q/OzNtQO9w5oLzJoLoUoio1eNDHj5Ii3bNxwng1XksNYfeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY+8CGq7eOaoY3JYDVpaW/NTMXh5CLbovHTANyUKOE0=;
 b=VyosqNbKJdK/2h4c/ZXjwePSZxoQWxheUh5t829t3W9BrBp39824yoaJVKiDkZxXHU4hXHM01xKCTvxwqGQo7dE6fLKlfsht82HuG1m+ndvTGwztMDwAvyKk4zoNSRtXacOcjbMeLDL0RYxZgkMM50giP81mKBhG9SLAyhAuo0cPMPDXjUGNitSWkv+xCvzXefUcFzDO8NZMD6KTTun3QRxLgjbjfQo91VbclWCMqy8jJIY7nXRYOA8xgXJ17WpVh4XtWPnL+peaKAq+19Ap2elm0QW85eNAH8j94Zh3zP979dlDccEDXYGkivY2NM8zpvRU0iKdosXwc3zPZ7sLjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DS0PR12MB8296.namprd12.prod.outlook.com
 (2603:10b6:8:f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 19:26:32 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 19:26:32 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Tue, 20 Jan 2026 11:26:16 -0800
Subject: [PATCH v3 1/2] ARM: dts: aspeed: add an alt 128M flash layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-alt-128-v3-1-a81bdafc00a7@nvidia.com>
References: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
In-Reply-To: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768937188; l=2331;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=TNpIy81LQHrIx/NbjKfXunvLDohcuExXo/vA1w+RCTM=;
 b=DGv+a8+/fB9ZRP/kJwpSc5IRcRWKGENQ6nDHEntOe8WIDrX61c3j1+zq/I+MV5Di1tyfTurar
 62ExZwvgwmcCojrq0IPKZPE0yOXyGZLsHfMt47iA1U9+FvFqvc0Deqw
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eca60ba-2fe8-49ca-7a06-08de5859d127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enBDQWhQYzh6THp4S1RpYmFTSVVuSkNzVGhBek40dndvY2hqOW1lcXJnSitk?=
 =?utf-8?B?aGxRRm4xYUpwVTc0VkVsMC9BUktxeEdSdlhZN0MxRU5POHg3KzhURVU2YXhk?=
 =?utf-8?B?YjBnYjZsOEoxMmVPc25wUFBmQkRHSCtHdHkwMC9rNyt5Q1dEQjhzNkY4RVFp?=
 =?utf-8?B?Y1lBcHRwdG5GdFg1QUUydWUvOElRUFpOcE15TWpsQ1lzVHo3YXZTSWV0WkVS?=
 =?utf-8?B?UGZhNFNxMU9qQnF4cDFVcDhxWHVFZHorTFZVWGRSQXpaL0FmN0hWekwvS0th?=
 =?utf-8?B?aTBGQ3RwNUlraGI3clVZZWQ1b0VZS2tkbU1lSTNpOW1LNVJUTmJxS0E1Rkdj?=
 =?utf-8?B?cmZTeXdMNy9XekZJQ3l4OVVvdkp2SDI1VmwxaDAxcUtzY1ozRWdYazB5bzhr?=
 =?utf-8?B?WlhkV09yWEpuRkJHcFNmUWliNWZlSU9tdFVGMHliR0lOYTVpS1hsUHRjVnpU?=
 =?utf-8?B?TzlQWGthTGdzdnE4aStnY1FRUjB2SnAwWm9rRzM1S0NIMTVOS0VnRVZzRUxs?=
 =?utf-8?B?enFycTR5TjZrZ2pJQTVWSDNmSy80VHBzOEl1QTVuRi9RSWVPTlI3REgzTm00?=
 =?utf-8?B?eUZuZWV2RWtuY3RibWxIbm0wMzZiQnB0aVpLRlBmbmN6RTZMZStEdnYwOUxj?=
 =?utf-8?B?NjMxNWN1cWJNS3JXaFBZMjZyQWdkdFdDdDJjS3dTMVllZytvSndENDc1SFR4?=
 =?utf-8?B?Sy94bDJCSjlQSWFQREtyT2ZvbTAreXowRTVVRnFWVjdIaWswaXkvcTBNWUkx?=
 =?utf-8?B?MzI0YmZzTXltUkZ4Y05wTllhYVZKalpUZXNRSnc4V1p2bnVwMi9TSXZwemd5?=
 =?utf-8?B?Tld3VHJEYzNHa1JQblRKT0EzSnRjM0JrODI4NFgrQjRtMkhhaE9FMHlHSnZm?=
 =?utf-8?B?M2JGRjBhWVkxeU16Nm9XN21YVHlJanBieW1rdzV0VlFLVHpDeWZJN0FzTHBC?=
 =?utf-8?B?QTdiSUpkNk0yelhreWZ5dy9kTkFSR0NhaGZjREMwODllVEc4ZVgyak9xc1JT?=
 =?utf-8?B?R3JvbFdidWlMcHIzWXpQelM5eEw5aHVrVnZ2MkxDMWNrVU10SmVzdXF0SWh4?=
 =?utf-8?B?ZVdMSk43dE1ubmJCaDc5MHlCbHFwR1gyeTZ3NzJVWm8xOEgrMEIzbmd1a2lJ?=
 =?utf-8?B?QmVhOXBKUnNJc1lFNGNDUEhXODNsN1hkSmYxNm04d0E4aWRUWG1RbWxoRGtj?=
 =?utf-8?B?SmRFb3FsZHFSbWNkeEViOGxDYkg4elhvdFhROU0zcjVRYVZVbXJDZUd0MWp0?=
 =?utf-8?B?a3lML3d2SS9CK2Y1N3FDN053bXlWUy9FZGhqdklzYjFpejRlekw3SzFJSVlj?=
 =?utf-8?B?S0VwcGJZNGVENmNZdkp3WlJjUmVBTFBoQUJKd0prUlpNNFMwTTBmdWFRc05P?=
 =?utf-8?B?VFAzTFA2MGV6MDcvdFE1M0lmL2tFOXdIUU5XdWtjVCtBWFF1ay9PVWZqZDdJ?=
 =?utf-8?B?UncwRGRNUVdDSTd1MHJ6UGxMN3hRd0hHc2Ztcmd4TzBOQzNPL0xNZFRrenY1?=
 =?utf-8?B?Q0tGek1oVS9yYUhNVGRXNG5SMDRTTFkxQmNoS0ZRc24vVmVWTWlzbzVQNXNM?=
 =?utf-8?B?QlRTV0dVWEtBWUpZcWJSQlJBblFjV0EyM05tL21la3ozQVkwMXk3b2ZEellE?=
 =?utf-8?B?MVh4dEtWa1luNnc1RVBwaDVQelhHQVljNG9DNkZNOFA4OTFwSzNJcFV0d05s?=
 =?utf-8?B?dTRieVZ6V1BxdjlsS3NvNmdYaVd5SkhwS3BjMTZiWmpPMmxpNFBPR1FUclgz?=
 =?utf-8?B?QXUwOHFYd3lHdGZYeWNhYTBvd0RkWS9SZFNUSHN3NDVqNzRYeStXeGg0bVRK?=
 =?utf-8?B?aDdKQmlUM04zL1N4aUk3YnJvL2hWaEQwN1hVemo3WjlVVXo1NGtJVjdrakg3?=
 =?utf-8?B?RnA3Tnp4djJRNVZKR0o0YVhEbDdSai9FQTM2bm9obnBZSER3NWhjZkxtQThx?=
 =?utf-8?B?elZ3dmF6VzNSRVVoZmdGWURqa0ZHWFVJdk5mV3hQN0tvTGs5QVZMNCtIb1NQ?=
 =?utf-8?B?SUN4d0MwRjlBQ1BIWTNtcGt1Vjl2YnE2SHg3QnRXb09OZkpPM2kvczRpdUNK?=
 =?utf-8?B?VkRrNzZZWGNibGY3YTVWMzRvMkg4eVZqVTQvMmJuQW1SVnM0R3FnRmhKR3gr?=
 =?utf-8?Q?tZuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklMQ0V0RU9qWVg4QncxTDFIUDk2Yy84dloxUERTMkYzMk9YNm1tS3QrNy9C?=
 =?utf-8?B?SjlkeHpmaFk0VHJFVDI2S3d3empXRTJJN2NnK1pFL0Vwem9FVDZSeGpKRng2?=
 =?utf-8?B?czJOc2tNclN2Z0RQNXVmWmRVaWZBeWN0UmF2SXRXQWNxbFZGRUtRRzhFZnNI?=
 =?utf-8?B?MXFtclozTCt0VlphV2xXRkV5dG4yeTdQNk5HNjZRU2U0VVJYMVM3eHl1c2hQ?=
 =?utf-8?B?eFZJM001elBIaFFTY0lRb1dmNVRZU0pGYk0yK2NZdkJZSHdoeUt6QTBDQVR6?=
 =?utf-8?B?S1FXSjdqYWxsd1k2ODZEbnV6WEt2ZlE0aFQxalRodk9wZ25kZFl3TDlTdFpk?=
 =?utf-8?B?Y2RUNFVCU3Q0Rk40TGZlUEZMV2UxSUZjSHdobmF2RXZZSW12eVZtNVFZV1Z3?=
 =?utf-8?B?bXdFQzM0aXladjJNNDFWQ3RySE90QmNXTWdEMnZ1cUZCNHJFTHJYY2x6UUoy?=
 =?utf-8?B?dFIzekpETUVEci9rSEZYeFJtUmhkTW5JUFdIV29laERuWlVhRExPcjdxZkdL?=
 =?utf-8?B?bWF0bXBvaGJzUWd2WFlWeWZDYUloMVZuVXpFWTBmUHZ6Y1RUOGdXYXk0RjAy?=
 =?utf-8?B?UXhCZVdjTWNaRU0xb0d0QVVZVkNkTmU5THgxRXdsS3F3cGxnclJTWTdvUFpm?=
 =?utf-8?B?STdublE1ZkVCaUZXNldYcmFPZUdmM1V3ZENUbFRQWExwQW9BeHpnN093RU9a?=
 =?utf-8?B?U054cFVjTUI5OXFSeXQzdHgrcmNzdVBZcHJhTVg0SkU3cS93MENGT0JxREsr?=
 =?utf-8?B?b3pQZTB1cHNHdUljalRiSWZaWlRzRHdTcEg5eWlKVTlDVUFIMzR1bGZSdkhX?=
 =?utf-8?B?aHZValpzaEk5OWF1NVBNa2FXcTU0ZGN4KzF5NWhmY1VNODdNWHBsbWpwN25z?=
 =?utf-8?B?eTI4WWVhdkxOTDdoUm1hMWRQN2pKUVc4LzI2Z2w0Wm4yME5MTGJPUDRIQUcr?=
 =?utf-8?B?QklpM2JwUHA4YnpDczZyM0FjbUxQSFBQbUNYM2NVRDNlVGZtSytXaXBmL1J4?=
 =?utf-8?B?SjFZWU1NdS9ESDNzNUM3OERsUW0xYnpieHcvSHBUWU8xMG9YYy9SeUY0TXBn?=
 =?utf-8?B?OFEwckxFTExQeXQ2V2c5YXk0V2k2YjVsOGxwZlhzaHRzOUUxQTA2UjNNNG5K?=
 =?utf-8?B?a3NVL2taUkp2c2lsNU82U1VWUXFlNS9qQ0xLUTNiL0tyRkF0UytHMk8zUWpH?=
 =?utf-8?B?YXZmVnNNNGxzVEtsL1Vpb0ZOTTY3YWdZQXlvekpTNGtQM2VHL01QK25vUkNr?=
 =?utf-8?B?QkFJV210RlpvSzRVbmdnMHJrM3hDVDFkTWRaRmRvNktpQWYxajhoVlk2RXp4?=
 =?utf-8?B?RE1ody9ESUFJM0puVm5hNGw4amNxMlZaa1FLUGtVN0xlaHpzRU9MUlNBQnJw?=
 =?utf-8?B?eGRFSXl1YXJPRDdQYTh1MXpGNVZqREdURks4UHJaZlA2a2tsNFNEcVpZcVpZ?=
 =?utf-8?B?cWpJTjJ0QnYvZmlLSkRoOFZhWENTU1dhS3FkaTJIWUEza3R6bE1TcmwxSmFC?=
 =?utf-8?B?RkdvYStJbDc4NXVPTkNpcGdJSDhSTkdFTEtzUmM0NWNKdUh0YkFGREUwT1FJ?=
 =?utf-8?B?RGw5Z3pEUytSRFFvV1dwOTNFNDRhcmNDNFVFekljS1NaM211aVdTbWFFQkEw?=
 =?utf-8?B?UWVlSkFhNTd3bVpmNUhtclN1c01sYkt2RTdZNE1lMlc1T2FBczBRQjB0NGdW?=
 =?utf-8?B?SFhQUk9GU3dRTWNOdmVnTS9LcTJmZWxhSmlab2pqSTZCVWE1bCs0MnJlM1ox?=
 =?utf-8?B?aGdmTzEyRW0wZUlaSDIwNi82dGJvQUhWMlc2YnNyRWlxcWo3ZlI2c29wRjNu?=
 =?utf-8?B?T3M3dVVGemlpVXhIdS9zWnJlU3RSTzZ5RzFCUmNTNk05SGxJbG5RQjFCY085?=
 =?utf-8?B?b0xHWldYRkd4dG5QMzh1RlhlREpYK3FYdG9ibUNzUUNnK2orV2w1M29VdGZz?=
 =?utf-8?B?bjlBOUJ6ZFA4MXpLb2l3dHBUbSs5dk9adDQ5RThyei9vNmtwUVU2MWUyYU54?=
 =?utf-8?B?R3NPa3RqL1JrMG0vcXdrS0lUWGFicmJsL2VQeXlDMGVJNHMvNUpjQy9CemZL?=
 =?utf-8?B?elhwbkl2bXY2dG5aZzBUK0JwOTRGVHpBRWVYRmNvWHFwbDNQV2RJejZveTBt?=
 =?utf-8?B?VEt2NlpwVUNsYVprRVdYNnZWN1pMazJPMFBDVUNzV1pPL1BXMDVDdTdoT1ZL?=
 =?utf-8?B?Nm9oTDF0T2owVUppL1Uwamw3cW1tbklZTW1tQVRuZ2JkMm9FQnJ6NjRtRW9J?=
 =?utf-8?B?QWxHdWh4MXR2dEYrdmlQZi82Yng4ckJCa1RGdXNrVlZsRUZkaXBQQ3N0U1Rs?=
 =?utf-8?B?UWF4NnB4WVdRdXQ2VWJYby9DWDg4bFJZeCtTMFVjL012aVA2OVptUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eca60ba-2fe8-49ca-7a06-08de5859d127
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:26:32.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19cdOT9PrRwy7bHIgo3Fho4kJpqNRefmhY/CgsfbS4VIIrAgOzWhgVSPxcFxKCEjHfECCus3aVodBSa9dQzZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Add a 128M layout for the BMC flash chip we didn't boot from. Including
this allows the user to write to each partition on the alternate spi
chip. This dtsi follows the existing standard of using the same layout
as non alt version and prepending `alt` to each partition's name.

Tested by running on target and catting sysfs nodes
    for devdir in /sys/class/mtd/mtd*; do
         [[ -d $devdir && -r $devdir/name ]] || continue
         name=$(<"$devdir/name")
         [[ $name == alt* ]] || continue

         size=$(<"$devdir/size")
         offset=0
         [[ -r $devdir/offset ]] && offset=$(<"$devdir/offset")

         dev=$(basename "$devdir")
         printf "%s name=%s offset=0x%X size=0x%X\n" "$dev" "$name" \
            "$offset" "$size"
    done

    mtd10 name=alt-rofs offset=0xA00000 size=0x5600000
    mtd11 name=alt-rwfs offset=0x6000000 size=0x2000000
    mtd7 name=alt-u-boot offset=0x0 size=0xE0000
    mtd8 name=alt-u-boot-env offset=0xE0000 size=0x20000
    mtd9 name=alt-kernel offset=0x100000 size=0x900000

Ran dtbs check, no errors from the msx4 dts

running diff between the main and alt flash layouts shows that the only
diff is alt prepended to the partition labels, as expected.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 .../dts/aspeed/openbmc-flash-layout-128-alt.dtsi   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi
new file mode 100644
index 000000000000..08ce2eab472c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot@0 {
+		reg = <0x0 0xe0000>; // 896KB
+		label = "alt-u-boot";
+	};
+
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x20000>; // 128KB
+		label = "alt-u-boot-env";
+	};
+
+	kernel@100000 {
+		reg = <0x100000 0x900000>; // 9MB
+		label = "alt-kernel";
+	};
+
+	rofs@a00000 {
+		reg = <0xa00000 0x5600000>; // 86MB
+		label = "alt-rofs";
+	};
+
+	rwfs@6000000 {
+		reg = <0x6000000 0x2000000>; // 32MB
+		label = "alt-rwfs";
+	};
+};

-- 
2.34.1


