Return-Path: <linux-aspeed+bounces-2589-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0C9CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Oct 2025 03:55:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ct8F73TB9z301K;
	Fri, 24 Oct 2025 14:55:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761278123;
	cv=pass; b=f+aXhG57pVqyUgJuaNGI6s9VFUCsVY9SaaYubPh33C819M4Of4klkBBcMVLWU6djvYRtf6SE/CsH6A1IeYN56GeV6OZ0bybskMlJJoh+sl5eEjSkl1t9Y6aDNegch17KE2fTkjCi/QynV10TNhstyZBat7tDNGJ9FR7wfQN0uOarYBL0ku7C5lfC5zoKnxu4k+7TUNBShkv/swW5A8Wp4TsCRBqupdB/U5RTfYIWCfPJdqbdu2C8XM3wXVMMXIHP9fXpFp2I4jQMBZnIGmJrmE5cjjHnwFzB0G91QAg8912T8sZy1ciofn66eB95rKEYdcer9mv2G3MNUBhX1jZKTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761278123; c=relaxed/relaxed;
	bh=U30u3fnqAkWRz7sM/tFWQXrcvsFbHIwUMNYsgDz34to=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XX8EIQjySrTpbNYoon2pp8xQd6YzMLXcrArjxRyvxTpp/DUUCz2p1apZcIRZYN7/2+TXEVZS2VNEf10/XazpVFZ3lU8m69uZEicV+lMT/IB44bPoEI0+fOQ09rcg5z83FcsfoPDkXvGsR+HBRNJwO1qDWnQj+xyZ5wmmSgBu6IbNpEfj+2R+LPqD4Nz3eIVb02ac7w3T4o/l0TJj6QnscomXLexdBtCq09zl6uvH9WlB0t6LREnnfgSFA1+iZG6rHrLhdsEwnPZ+0lSuVzC0iLsIZOKjdB4vuX2H7hyKkIvEy7CPyrwCv6wT0HZdCv4dpMvVqJXA9e+Hj/1OPSEiPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cj5fyM6e; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cj5fyM6e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ct8F60Prkz2yx8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 14:55:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J64LXWuhS12HAgwlVmzMCOOTXOkDL3vdqQw4TUy7vYuEzSn4B67yCZR9U8XqFF3+aEghTE/vdwitsY26Z7utLQtTe4edEjrOI41H1rG4s7UrnUQwRbuuYsT7qQo6O/Mt2PIlcA+2KDWVY7cLMtznwh4gFeLxXuL9GFdLJqGeDr17dSW0HNQQsnvxxNehr36quvEwE2FtJQQNQXJl2+SWBzeSzFs8ek5rUvW5506UbmCfcZfDjsLfPRQh+7UXk2Zy70LULbis0jujpSaXU8iy9Eiv/oUSkqEHbVYnNk7y+mDyitldksYQj4mOXvzHqh2mhL9aurMT2cFi25xorBIAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U30u3fnqAkWRz7sM/tFWQXrcvsFbHIwUMNYsgDz34to=;
 b=wRDH7nShAgKrY2h7SEym/HskIqF344lEKl0jOqdJsrNMSyeYFefVq3jjVw8PsTSmaL1/IcgBfHB4K0++NYc0n5+B6bFAg/rLjlxNTH2+KIHztEJe/kVZ1TD47WXG96VSkIlr685PtIIAgANjxMY9227YZoyAtHBlk2HWqhEZmyPNFX42XYjbNuZ/8v6UrpQtjnJncd2P9OkA2/jd5Cr2v6XarVETxQiIzK349pL43Skz3c8mDCM3dWZbDSDH0cLGBucwAG8s7P9z1UnEPms5D6t6orGtetPPYsKi6wYwNgNKOYVxJxikStofKcGdNlAzr9l0BBvuTmzhNEfOuD9qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U30u3fnqAkWRz7sM/tFWQXrcvsFbHIwUMNYsgDz34to=;
 b=cj5fyM6e6oNWdMwSjkfVMToJutzf2AkK9xZcoXNGzpxanPM5+Y6ZuwmqgfB2sWc5GTFRiTo6iypxiJaAGwId3hZxCeXRDwBGLAv/Jw0Nahj0P1j34gPI9w7WBMk2pgXsIOuLpc/OsfIhdchSyDF4l4J4/sT3JfO2vXZExMDh/ZboB1oTC6gBgzcIeSDpeyTPkd8iXKvrJOT9QVm5cGM7C8tRBL/9V3y4S0ugWJCsWDdkaGc8ah9JDSS4ErL7A5pmE17moQCuebl4BhyUTbhDSc5a8AYj/yDD5NFIiydm8OadxQXspvzK+z9mYgh4Am2X8PhM30zFGq9Qgz14v/go5w==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:54:56 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:54:56 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, Lee
 Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>, "Lad, Prabhakar"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index: AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6A
Date: Fri, 24 Oct 2025 03:54:55 +0000
Message-ID:
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
In-Reply-To: <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6463:EE_
x-ms-office365-filtering-correlation-id: 2c07fdd1-48b4-463f-3b0c-08de12b11857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xmYGqASTRKsk7VXyA62NVMWcXdLQdWAY4CbPGyZ9SNJIgs3iFfTlfORwHx?=
 =?iso-8859-1?Q?6QAh7zYtOODYOaGLgC+B3Tv5Q8v+P7OSZaFD+2QpJZJY84fpYCuPB1npAh?=
 =?iso-8859-1?Q?pN+AGXSBIYEAHLrJb2jDqE7Ewi0um/hdYe+/p6RBDafMpuodmOFEF/ylKh?=
 =?iso-8859-1?Q?9uEECYshhMyhLJUzHTKR4b7MzyJJ4zz4F14GILNtuaH9EwXrAjpzZ6FwlB?=
 =?iso-8859-1?Q?M2Yt80OOsGmV8hy7xqOEjFCDVBqpoO7oA/i0xltfg4VAdg9HSV0LmExnyA?=
 =?iso-8859-1?Q?5jeAQ4QMcDIgxF14On0ZATIuqsDY6JiOyKBhoRyhXyOOmy9DHA4TKill7z?=
 =?iso-8859-1?Q?HRmSKDZWvyCv+KuqM2rS+hL7FxInEbJRthFaVtNLdDm8bs1Eps3KNrdUXZ?=
 =?iso-8859-1?Q?THHFyKgwMUm4+0WNDntMdZf3eULw996U91gg4hfCcifzvQntwJZoe3ryui?=
 =?iso-8859-1?Q?KLSwin8lxGD0qMCzUjo7+0jTB8qfjaOfBim/6jCuwCi2+iohRE7swLU0iT?=
 =?iso-8859-1?Q?QQID458mFEBdY1789WMaw3im+LKeemK89r9HdVYfXlbU5ruLnWsUXQbLbG?=
 =?iso-8859-1?Q?TcKCHbjDfX4Ml6xP+zkTGmVpS8z5v9LzX2mcpdXaVBQ9EAbWUrREvT1bYr?=
 =?iso-8859-1?Q?WhkrERqT67ldiRg5PJfyQImcoY1qKMU7BxpPYQX4AhmGz5/G28+hoAGt4s?=
 =?iso-8859-1?Q?c0nJ850piwzt+VPHDPMxw3k6THXAwor8gq9ChVlsje5/ysIobnGdx0L+Oh?=
 =?iso-8859-1?Q?vE5Zc/PpezHRbaPasxNYIshsyC+PPVY5pQoQa8Pgpp2oOzVKZFoDbo2PLV?=
 =?iso-8859-1?Q?TYSfKNA4O+cJDG1BV1f9O9six19TIeDDpwo893+WDvN20RnuxnA5gUQ0JH?=
 =?iso-8859-1?Q?G9HCS0itZnbsPRs1ks2olExFGMWCCaFBR8m1MsTzM8b10iSADNgJd4BCMx?=
 =?iso-8859-1?Q?xwvs1MdyaKuYs0TKnLvbTsh7gt0u7OsG9PMpbHDlgmAZ2a6Av4MXJAdroM?=
 =?iso-8859-1?Q?EOCJ3BwpeoPZkSeIBP9SAG5nmOOnGSkACeCaAOaJnwgNXYs9ZSzMH8gN1W?=
 =?iso-8859-1?Q?mmaxaIy0WAENH52xHRQlT+1f59GdzkR2kq62x535vwJJeS/wohA3+8lkAw?=
 =?iso-8859-1?Q?fbvuCNVDKkcyDduMCZE6cPDWHZVqb9shcJf5MEtuUhV3pKEJrltAEC23VB?=
 =?iso-8859-1?Q?k+T6JWaDXjYSRYfdjaYA0o4LNK4twnMYE/7H0kaW4TFYsMleRpZA9ycQ/t?=
 =?iso-8859-1?Q?3xj2MxcTHaH6XDuvuUifK2W0ZC95HiBvSDzzyLqRshUZP/uHTkPSkx1Hap?=
 =?iso-8859-1?Q?JtnjS7K4YRx7NKhi+yRz5OB3SNm5M18/4NoHpNRkaYCI3aMlFT4XEB57wd?=
 =?iso-8859-1?Q?xVM4PqGaaiOMWjyR21d2pkwBbvwViqd8tPrynhv48klI3FBTgtNiJvvYYT?=
 =?iso-8859-1?Q?ukgBXSs04BrYL6G045FqRrhd6VJY6s1Xd1vTSiKqZmA/5t0gwfe2rPqMbH?=
 =?iso-8859-1?Q?wUzZGPKsDJZentGtf9KjXXKngy5jdnl5y0MjpigUOwn2mwe2u1BoeCM6ES?=
 =?iso-8859-1?Q?ZfloCJlXc2zT7wCGeqIBw1gsz5EBjzxnP+0KJNtN9KjKS9pklA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YJZsilyEH9uNxB70TPvLpHENUktQQ4WpGl42k2QI+FNKq1pUowTSDIitHM?=
 =?iso-8859-1?Q?b66SqFGiywZsgwHnXvFe7VbAjiXKR3+qM2h02GTU+uq6eJYwpgoCOV+gKT?=
 =?iso-8859-1?Q?18IIZoOaCzZ+be2Y2Go/agwTWgPcU70vR/OwRcEb1AtQkvbRruIiUGvCSw?=
 =?iso-8859-1?Q?oMRbtCJ5y5q578wurrM84Oo+qH0u6ZFaEHS/INiQaVhKpazkxlyH9S46ij?=
 =?iso-8859-1?Q?IpWh4eL7qkZTZ8h+M70ZaC2NKZ4502uxaEBCe1nDlivA+38pcejlXzYI0Q?=
 =?iso-8859-1?Q?NJyiT7w1H+QXjLQpWrQWHDdOasRGg7rfJDHrMyWVbuXspU1eR8vQxuds7D?=
 =?iso-8859-1?Q?VvstHiYZfVt+OwTIJGAcTW1ZPeMKg9mYi1PleusFcrTJQOv7IaoA8/2cmX?=
 =?iso-8859-1?Q?Ak8UoyLf0eRlcmtNqbsX32jMvo/kLcdSRq5XDRTTkCEbWoR0X2UxWTzOVg?=
 =?iso-8859-1?Q?YPKaHRXZs1FXj3C1oXd16bf09o9rrFQTQzjPtm5CLorCkZaCRGv//pMJqW?=
 =?iso-8859-1?Q?ilSnm097BBgVk4wmyTxhaGsfuUJhG6+47TvjXCDtqdMAKGk/R/7TEY0O8w?=
 =?iso-8859-1?Q?La3SoOwNEpjHkDd/hpLLTvLY4JBU64Gnzwry36XSJVDy+n1RYzrYKXVYZW?=
 =?iso-8859-1?Q?Ap/yuh10pFwG0Yd3dy25iwSPKl75E5khSXgsfIYHlXYt5SA7RMWTaifyOq?=
 =?iso-8859-1?Q?LJS1naWwWWSOdiV+BCv4PQ7EE/kPP4r7rqLsKQeDArFwonY/WaqqF77/xv?=
 =?iso-8859-1?Q?Nt9tW3wQm/INMJcC8n8Q37xYt+5hwHsYZXAk8mXNi5uZFp+Wv6Obl4T2NX?=
 =?iso-8859-1?Q?m5RX+OiPc0JBB1ElO3+0w1sH+wq2F2XrR1AE+EHRvYNxLMgHeBCx327UFx?=
 =?iso-8859-1?Q?KWMF5X5eBWph7FDsHx0OIlE6OkBtbUWujowCO8J/6SEU/iGDt47dlzBnxO?=
 =?iso-8859-1?Q?lW1BZDkMYNoqEQg6MjTOXv8UMuyF85EjOH7qhGryQQk9awUtq1VRXD3YMZ?=
 =?iso-8859-1?Q?C0TSeyi5IlHh1L9ASn5DIih8fRYPIbLLptUvkrVTkO4YsSDgMCeiprUMHe?=
 =?iso-8859-1?Q?qmjKzOP0ICH6bTfMfkDithg83Et73yn6zXlvrCwITWxENIfX/1toQPPtdG?=
 =?iso-8859-1?Q?4dM+MePs6XMmswvSF2im1BxCJ2vPYoJc7r6LYA7ennaqZp+FMJHJXai+dX?=
 =?iso-8859-1?Q?UomodTPHnNGUnX27YFqdRMF8TUFDKRicbtT0SuOrFdw3TUCO5YVaFWuFWs?=
 =?iso-8859-1?Q?n8eKgdouHYgCqRbHUh2dBofR/YI076Lk+QTgNMs5kSkMZ5XhkFDaJ947Kt?=
 =?iso-8859-1?Q?GC4eGeneJ8t2SXhAppa56ViQSDtL7iHPD67VlKCA1yhUxMopX6vpRYV/oE?=
 =?iso-8859-1?Q?/2Y5WxjoL9OVsHAgb3by4fx6LtkzDtvaTLE8Q2ZrQZpj7eMBls8pAMQDdr?=
 =?iso-8859-1?Q?VeFanOYi3b27uYQE1b1O87XIkOI0d7mSrkFdBXCNB+kNufVrLydEA6FMkR?=
 =?iso-8859-1?Q?14r6wbNyMh2rm0r59/Iw5cDB68MLY8lE8OB/4MP9ZbG8sa7acfRRPUH8Vo?=
 =?iso-8859-1?Q?6sjbiYE6OAzEi+6yAg3phYhnPCMZqlwVk8BgOzm+ykm5G/LpjLKEKCX0Bq?=
 =?iso-8859-1?Q?7Z2r0608Y4ymG+s+c4BOa2296AHEE4oNc+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c07fdd1-48b4-463f-3b0c-08de12b11857
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 03:54:56.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCsGyAhuQSvlQZLWRUQ4Tdr/Ksqwbdb8ob3Hsz1wUebxtud0lj9m2memr1b9VQ51xYtR4KrLiTvMNydeo2/hs1XD60QewP2YeAtD3vo7jcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC d=
evice
> tree
>=20
> On Thu, Oct 23, 2025, at 09:37, Ryan Chen wrote:
> >
> >> > +	aliases {
> >> > +		serial0 =3D &uart0;
> >> > +		serial1 =3D &uart1;
> >> > +		serial2 =3D &uart2;
> >> > +		serial3 =3D &uart3;
> >> > +		serial4 =3D &uart4;
> >> > +		serial5 =3D &uart5;
> >> > +		serial6 =3D &uart6;
> >> > +		serial7 =3D &uart7;
> >> > +		serial8 =3D &uart8;
> >> > +		serial9 =3D &uart9;
> >> > +		serial10 =3D &uart10;
> >> > +		serial11 =3D &uart11;
> >> > +		serial12 =3D &uart12;
> >> > +		serial13 =3D &uart13;
> >> > +		serial14 =3D &uart14;
> >> > +	};
> >>
> >> This looks like you just list all the uarts that are present on the
> >> chip, which is not how the aliases are meant to be used. Move this
> >> block into the board specific file and only list the ones that are
> >> actually enabled on that particular board.
> >>
> >> In particular, the alias names are meant to be local to the board and
> >> don't usually correspond to the numbering inside of the chip. In the
> >> defconfig, we currently set CONFIG_SERIAL_8250_NR_UARTS=3D8, which is
> >> enough for any board we support so far, but that means only the first
> >> 8 aliases in the list will actually work.
> >
> > Understood. I'll move the aliases block from the SoC dtsi into the EVB
> > board dts. For the EVB, UART12 is used as the default console, and the
> > board labels match the SoC numbering, so I plan to keep:
> >
> > Does that look acceptable?
> > ast2700-evb.dts
> > 	aliases {
> > 		serial0 =3D &uart0;
> > 		serial1 =3D &uart1;
> > 		serial2 =3D &uart2;
> > 		serial3 =3D &uart3;
> > 		serial4 =3D &uart4;
> > 		serial5 =3D &uart5;
> > 		serial6 =3D &uart6;
> > 		serial7 =3D &uart7;
> > 		serial8 =3D &uart8;
> > 		serial9 =3D &uart9;
> > 		serial10 =3D &uart10;
> > 		serial11 =3D &uart11;
> > 		serial12 =3D &uart12;
> > 		serial13 =3D &uart13;
> > 		serial14 =3D &uart14;
> > }
>=20
> I think this would be broken for the defconfig if the consol is on serial=
12. I
> would recommend using serial0 as the console, like
>=20
> aliases {
>        serial0 =3D &uart12;
> }
>=20
> in this case. If additional uarts are enabled, add those as further alias=
es.

Understood, I will update.

>=20
> >>
> >> > +	soc1: soc@14000000 {
> >> > +		compatible =3D "simple-bus";
> >> > +		#address-cells =3D <2>;
> >> > +		#size-cells =3D <2>;
> >> > +		ranges =3D <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;
> >>
> >> This probably needs some explanation: why are there two 'soc@...'
> >> devices? Is this literally two chips in the system, or are you
> >> describing two buses inside of the same SoC?
> >
> > The AST2700 is two soc connection with a property bus.
> > Sharing some decode registers. Each have it own ahb bus.
>=20
> I don't understand your explanation,

Let me clarify more clearly:
The AST2700 is a dual-SoC architecture, consisting of two interconnected So=
Cs,
referred to as SoC0 and SoC1. Each SoC has its own clock/reset domains.=20
They are connected through an internal "property bus",=20
which is Aspeed's internal interconnect providing shared
address decoding and communication between the two SoCs.


>=20
> >>
> >> > +
> >> > +		mdio0: mdio@14040000 {
> >> > +			compatible =3D "aspeed,ast2600-mdio";
> >> > +			reg =3D <0 0x14040000 0 0x8>;
> >> > +			resets =3D <&syscon1 SCU1_RESET_MII>;
> >> > +			status =3D "disabled";
> >> > +		};
> >>
> >> I see that you use the old compatible=3D"aspeed,ast2600-mdio" string
> >> exclusively here. While this works, I would suggest you list both a
> >> more specific "aspeed,ast2700-mdio" string to refer to the version in
> >> this chip as well as the fallback "aspeed,ast2600-mdio" string as the =
generic
> identifier.
> >>
> >> The binding obviously has to describe both in that case, but the
> >> driver does not need to be modified as long as both behave the same wa=
y.
> >
> > Thanks, will submit ast2700-mdio.
> > Question, should I add in here patch series?
> > Or go for another patch thread?
>=20
> Since there is no corresponding driver change, I would keep the binding c=
hange
> as a patch in this series.

Sorry, I am wondering, I will follow Andrew advice.=20
Submit ast2700-mdio to net-next go out another thread.
And put submit link in cover-letter in next version.
Is it ok?

>=20
> >> > +
> >> > +		syscon1: syscon@14c02000 {
> >> > +			compatible =3D "aspeed,ast2700-scu1", "syscon",
> "simple-mfd";
> >> > +			reg =3D <0x0 0x14c02000 0x0 0x1000>;
> >> > +			ranges =3D <0x0 0x0 0x14c02000 0x1000>;
> >> > +			#address-cells =3D <1>;
> >> > +			#size-cells =3D <1>;
> >> > +			#clock-cells =3D <1>;
> >> > +			#reset-cells =3D <1>;
> >> > +
> >> > +			scu_ic2: interrupt-controller@100 {
> >> > +				compatible =3D "aspeed,ast2700-scu-ic2";
> >> > +				reg =3D <0x100 0x8>;
> >> > +				#interrupt-cells =3D <1>;
> >> > +				interrupts-extended =3D <&intc1_5 0>;
> >> > +				interrupt-controller;
> >> > +			};
> >> > +
> >> > +			scu_ic3: interrupt-controller@108 {
> >> > +				compatible =3D "aspeed,ast2700-scu-ic3";
> >> > +				reg =3D <0x108 0x8>;
> >> > +				#interrupt-cells =3D <1>;
> >> > +				interrupts-extended =3D <&intc1_5 26>;
> >> > +				interrupt-controller;
> >> > +			};
> >>
> >> This looks a bit silly to be honest: you have two separate devices
> >> that each have a single register and a different compatible string?
> >
> > Yes, it have difference register define in each scu-ic#. That is
> > compatible with design.
> > https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-aspe
> > ed-scu-ic.c#L45-L48
>=20
> Right, if the driver already has this design, it does make sense to not c=
hange it
> for the new generation. For a newly added driver I would probably do it
> differently.

Thanks
>=20
> >> Also you claim to be compatible with "syscon" but nothing actually
> >> refers to the syscon node in that form?
> >
> > There is another submit ongoing in pinctrl which will use syscon.
> > https://lwn.net/ml/all/20250829073030.2749482-2-billy_tsai@aspeedtech.
> > com/
> >
> > Could I keep it? or I should remove it?
>=20
> The version of the driver you are linking does not appear to use syscon, =
maybe
> this is an artifact from a previous version?
>=20
> If so, you can drop it. On the other hand, this does seem to be a classic=
 syscon
> device and keeping it marked that way is not harmful, just redundant if y=
ou
> actually use the more specific compatible string.

Sorry, I may not point right link
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20250829073030.2749=
482-4-billy_tsai@aspeedtech.com/
aspeed_g7_soc0_pinctrl_probe -> aspeed_pinctrl_probe
https://github.com/torvalds/linux/blob/master/drivers/pinctrl/aspeed/pinctr=
l-aspeed.c#L456

That will use syscon to regmap.
>=20
>=20
>      Arnd

