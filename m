Return-Path: <linux-aspeed+bounces-2677-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35051CCF9F1
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 02:32:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxB8t4mSKz3bf4;
	Wed, 29 Oct 2025 13:32:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761705134;
	cv=pass; b=MdENyAuas22Fsnh2lVc3HQFd7WiaRE6zCZ4pMVFMgiCAKtwBEFEvNer9GIIPJ4dqlIvNAhePiBLfMsPv8n0VZE68K4uSTiPuSJZx+aEHId5TZqypiaf7LqXLVOfMOmfBYL7xLPXKiFo5achDoYWb2hYbdczAGJp1nDV0eX++yEWe9VjlPDmR2IpFoABQOYs2z8tF9gbQhq/1bTEBE2lpS1kCAAXySBMb/z7sMKT/29SLPRp6vUpTo9jjuT+tICTMWJa+0aPdUvudc/YQo64JQ1hB81GsmBIcaoOzKGm2JTDNLzy+LTRkMoQfe1m0v92FrjRvrZjw/G2Ay1AWsMEZWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761705134; c=relaxed/relaxed;
	bh=gwO53QyMSgr7UkIlCUVYpXat+cPu2mZvnrg1Epk6fQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQa6Pf9xYGGE7vwZV8br630VCR42ep/S5o8UIYcHig74ueFkqtLWhROgnAZfBLEhHcmTXiBFGqe490Dsu2QNaGukCOdsnbFP9/aW1VkJwGStyuSf1dKW6of17IgH7ibPK8yQmMrccqXtzM65Yrg07DXSO0y0bTWfeZzRheujx4pi9K6hhkjDiYMxC6LoleHhOrD0lgNJxstPJkJrrm6UuLPLnLsxn3mENQqOdx5v0xORuM7IawrFuBBecvRR/8/bHmiFLac4gnnzN7PnMz3wYL0NuVkekgLZFNwPR8CL7I3EfbgkoWJjemUICb0Oz8tLnADOOfGb5aFkhnTaHU+VfQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=qHoMIm3J; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=qHoMIm3J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxB8s3L9mz30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 13:32:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlacy3luJwLx8pAEM6gDzVKLQS3aYHf+LDNHgadptUqWZO6gjUdKEbiCB/s9LBnMiUFhR/8Wj+Yt5JoBtmTdVOSfO52z65YrdTcoEWgQPmxuj7SjH9ujywamXJUehh6PKscxGro5Vv3I47adaGFr4jQxdGD+uQ7gMFZQFAgrGKyMMBofBQT/k96p4zfODzEgIiLPJK14G28wysgY/sSG3VjcuuxbPbID1G/hRKMXEnxIQ7qoCjTdWJhvW/DAIWBds0pKVY/ojGbuxmmWq82thoDZsOlHhogVwXRhBDjUJ2fjmKM/FgvP4889lZHac0PVEf9vf4aCks54DTwQkdjqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwO53QyMSgr7UkIlCUVYpXat+cPu2mZvnrg1Epk6fQs=;
 b=HyZgI+UD37zqCEeEXrjiNfjvJi48tBfyyJAR1EYQQRyAeFz0pzGRj4ppamd45V9pChJD4zgJvdhe4FusIvmMDsLZEhOsi+BgraGMnRjoilC8OY8a3Y5wzm0glZxOnLQTVRXRqVcrpR5y/dsElxXSfjZX3X7TdNPCyU8l8J/Vg2N1u/73ZGqAcX9UXGDc4ryvSsKj5WUcuFY5a5R+wW2yXrxWVvyrKGjMpJUDuZvuQmE+EPgaRFtxD9r6Y8KnHJjCqK2V00LrjpNiVbuJ9f3Z9/7pCoi8YRtmN3qGR7hMimYqTNMCaa/rs9Tzis6iFHc0wzSIrSLBRugAGs1ABJz2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwO53QyMSgr7UkIlCUVYpXat+cPu2mZvnrg1Epk6fQs=;
 b=qHoMIm3JP94MWvGYlKGQHWrVITxhkr0fXl8nor+G+RGP17Zd80yhOo6Dw/G8yuDLc5pHeG4UUJbdE+C7XB+2UbEwQQJRIg56bCDJioPCfXZ2/7jkL/llEXAlJz1Wi8iWENd9SwydfClt4sFHrgnE0iwBGGfX9tSXzMT7b8YEqe0GUJcitoOd+C8G79GQ380fW9XoAu+2Y519oMOLp8kZ2gijmYc0pgHOwGIp//JvmCtGJqLTNYDXg0N5vyogedTUR6g0U/Ve33w+3rGsuN9hQkVEPnLPHXxkETGKsfQQ8DXouuOIHcCZoxRPxC648TW3+HoMUy9wUVj7uvVHJXzgTg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEZPR06MB6381.apcprd06.prod.outlook.com (2603:1096:101:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 02:31:49 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:31:48 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
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
Thread-Index:
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAIADDnEAgAAO3MCAAJ3UAIACg/2g
Date: Wed, 29 Oct 2025 02:31:48 +0000
Message-ID:
 <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
In-Reply-To: <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEZPR06MB6381:EE_
x-ms-office365-filtering-correlation-id: 62929f45-7f9c-4aa3-1e91-08de16934fa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tC525m4H4YSSheOPZ1HybdVTt9yjRpa2meyrRmEEz1kOqMI+nr+n+ioJQT?=
 =?iso-8859-1?Q?cc9AxE5SxyKJmVNVAOBJULXLxHY8Um2PuBTn5dTc8ZPz2AuLAAfCfRvZrC?=
 =?iso-8859-1?Q?AgKrJWU9zGlRQ6A8yvSTIRb7thGGgaHjSoHxQAkVDPasW/8pqRJDqoFv3I?=
 =?iso-8859-1?Q?HyJcuT2r7UfBfUDt11R4qU1JY0+0ybrWkTXm+1chSASGuCIACUZZE0AAiK?=
 =?iso-8859-1?Q?oXMGhyeby8DtB5p8rhwYJL4vrdrt7jLTcdyhrfZhgkzOCul1SRpjUij3/d?=
 =?iso-8859-1?Q?OCnOyiObaJSyWzopHf8yoCxttD14WxI9+A9R0Vig5P15iTrn0VOzXuXRqg?=
 =?iso-8859-1?Q?ZHut4AmqH3gdpDtMlumARmwh3DrSfek0B4e+bLecHZqzIi5ro40XZ0Vhzi?=
 =?iso-8859-1?Q?tnrSVlv4m3P7hCZ+O4HBIbbnXLCUwa5UWcnZKpsosx+zai3ehuSddvS6YD?=
 =?iso-8859-1?Q?dYCACANtUUHpcxvQelElOkyd5LlAFqskTtAQoqUJt/nQLYt7Q0jse42XJF?=
 =?iso-8859-1?Q?jy4jdRfutOe+/hAIAzkixfZL6QIrWtMyrZNFHT3FUlxBb1X3bc1GalGQj4?=
 =?iso-8859-1?Q?Kua8XZ9F0DdRMjXQ038iz7KNjGXAnWCEbYaFyhcMtNEm6dhuw3xm81+Jnf?=
 =?iso-8859-1?Q?0W87AWnc4p5gBaDxh7ypjuBJNpnAEKhdcUXbXoT/g5AVa92Rx9NR6syiqI?=
 =?iso-8859-1?Q?L/V7Mhsy/g0ZmXlIO+IsF3TSrb8ws8VDb3vwTeNRFiFq7kM9AawtqD5j2S?=
 =?iso-8859-1?Q?KePBh9xfCruN8KqJRwbRt/7OgcxBcKUwd0VlatQiA4NmTGr6spLGbS4Ok2?=
 =?iso-8859-1?Q?8Q3xwLeQBSmdv2X7m6XfthfahAyZzma2iCnPbe6TP3wROjOkPTGxZPJuhJ?=
 =?iso-8859-1?Q?X3bRZLbhUsN6p1Nai46i4wp8QRMB/2d8/ieMQShtfIHLbMpq/YSEyiJtKg?=
 =?iso-8859-1?Q?qqn5uLArZW37sIzSlDXJCmTW3mZnCGF2xNOBtaKfW72n6+0kohCt5UIi6D?=
 =?iso-8859-1?Q?T5rWpocmmdOTkWof7i01POEfUBvcI0SG6tsuv/mWByatUt80EaihxhQ8d3?=
 =?iso-8859-1?Q?rsU0mgHmSYEGsgxVZmJEy8DIGVh5QmHoB5i+AeuUKdxZ2Jdvf8yJeLapKo?=
 =?iso-8859-1?Q?btVtxTWnHGwsLq/RJgFl1AGgeGiebRgjjLK+8cqYuFvY2skNpinKem2puE?=
 =?iso-8859-1?Q?yX4pS4QpD/KdwJCCapXwBr3fxrddGAaQY2JC6n/3+ZTZaPk2+wK6kuyHEK?=
 =?iso-8859-1?Q?WJDUs+Rd2RXeFgqSxuFJNrfFTRO28wOMp7nRa7dstCzUJlS0MlIyrwAE7F?=
 =?iso-8859-1?Q?xh2/0UbWeL6SyccdGVmkBTwbzvz+08yNkxlIhAhHSlQZ1OOAndU9zlDmNA?=
 =?iso-8859-1?Q?Y9G+x9cU8kWLDsgAvjEx0sbZRrSougfrQo6WfcO2Crvhv/3mXBBYxXT6pO?=
 =?iso-8859-1?Q?qywAvAQKwAgr9Ch0IJJgR8zMHK2GfRLk2tG47zFmPC2mceFz3BAZsUDswk?=
 =?iso-8859-1?Q?1QTx5nQGvaV/NB5zExh4jiYMLvcAAhZJHEwSxXotoIg5NO9wZq8AnTrYIK?=
 =?iso-8859-1?Q?IWVSvPU8HJn1lz/Ku0JonUhaXKjc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SQb3PS7NUJ6S1d78+Avt6D977X6uCSidL9PSqOGiJGnuFTB3zNzyagO63i?=
 =?iso-8859-1?Q?IUxdCAmfsVAVb/BEjec7MkTjrpRn8MEsyBItU1WZUhibhSMeIrCnvhl6aw?=
 =?iso-8859-1?Q?6PrhB1T9eOllxfyXRsqYYQBANDV/vJGNCNcYtB2lvT/CwlTn0yr50M8Lff?=
 =?iso-8859-1?Q?YwtcLfhXNKjCIDtjVJsgzH8sC+WpG1kBk/XcR6Fgs9i8kWOu3BY2X4lJvA?=
 =?iso-8859-1?Q?3JDJ7Sf7zgnq0Y5/P3VB0SKGxpdt6ZyAQMF9j01GzjJOLw8531CeW4RjuJ?=
 =?iso-8859-1?Q?C8bkhKL54OJ/Tf1H3TrzJ00R1Z44O9oGjqbW97SiMmifvtUm6x5IT4UVoJ?=
 =?iso-8859-1?Q?Rf+/6b36G2Y0OP8VduDRv7ws0I/RGgW4TdBlKGFOxDWeWlILleqg10OAX3?=
 =?iso-8859-1?Q?4CTe5bC+kOu8JXij6aWDXYTk0L6TjdcMTzmgXhf6gy8AGUb8tqhGpHodat?=
 =?iso-8859-1?Q?0KO4+7eKFWD8WU49Mb4yLldn6e6KFNpqcAfhFDhgwCZEaiomkGYfsfI198?=
 =?iso-8859-1?Q?NerhQ48TRgspnLPuns9wjoCCHQg1m0buTvRX/3GOGW9mtgeqECneUVSfnt?=
 =?iso-8859-1?Q?qeC0p4o/VU4xpl1cZuRkp1NStMGAp8mjXZnNt4nft/bkIg84nLOkEst2ip?=
 =?iso-8859-1?Q?oxaZvTwCmzU+pVdocrzCuV8nTGZBAACPeUhBqBok6wxKxuYyVm6Vq/8gqC?=
 =?iso-8859-1?Q?pAPxNtNnYoMjnIyvi//P05UoMPiPT+CIFjsY1p3yom0MI16g8i+DtxO8a8?=
 =?iso-8859-1?Q?A0aJ0wgAFm9UJyR6OTNw7MWCfNZGrphDS/fcQj+OExHD9QdECfXVWyFqIM?=
 =?iso-8859-1?Q?hlmOXFHhrRg0GXF4ZntNWiZhKVgAPseKwwGiCuonbOHGSR/pwXY+ZzY6on?=
 =?iso-8859-1?Q?UvzvMrU2EHAUWjjd9EYtPSzMQweMRW8gmBPvAWi94GM7/kfBo2tFBiLSy+?=
 =?iso-8859-1?Q?3RfpSQIf2Dn7wiY7FBwT4CDWJULsAR5uXnyexGlsLbE6l6yjZ9z7FIhSei?=
 =?iso-8859-1?Q?Ov+47AGDkLMeLJVLhuldCNpSgh7bvpwgue7Urzp6QwPH6CMHByrOOHGn8+?=
 =?iso-8859-1?Q?FU0YrtsFYFLb12B2trrhqthcCda8s6Q0b2NNeYrBXLiU3yVzLSF9WSYueA?=
 =?iso-8859-1?Q?B1P+ZNbx3JhQG7R+kuF5PO8jiELS8MYjZZiB7F1HIylaaHm4arZUxD7vqz?=
 =?iso-8859-1?Q?R1BDQ/1ap/mvxZUOE+todkYlZhQJlFVJboAUZhkJnS0xk/KVazdDRkez7a?=
 =?iso-8859-1?Q?DL/LEiBIrGzC95WJjrbGAxpCAKcosn1GkPXEDKfLjY3Q8W/bfwpnNh4WDp?=
 =?iso-8859-1?Q?qJPmhhWo0CNnI4iXixhgS+sX94V+aymBikfaWlBU7dJD0q7Rd+JA55XZ7t?=
 =?iso-8859-1?Q?kwo642gGwVgU7iMZ3Rn/SGmls1IJuRUmPIzYs2MBwbAjOOJkml0MMmdjLq?=
 =?iso-8859-1?Q?puxtAyb+t52TSB3anhWB3zLkDbIKrZG3OW3RP8hwAQHC85OASMmhlt63r9?=
 =?iso-8859-1?Q?RQGL/NYM8/70jRWHON0U1Uemq8WyRFf3BzBd31D8xVSAmeMvl24+m9W9VF?=
 =?iso-8859-1?Q?mdzC71vzB+iug1jEUb4Kh/lCqEUSJazgI4awJY0gOybUS4H28vxnBCVzmC?=
 =?iso-8859-1?Q?64atKAiYxd1ujbl1WIbTHPYWCGbMlcR+JX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62929f45-7f9c-4aa3-1e91-08de16934fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 02:31:48.5137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtM89TDT/YCWFk/HTSTAxVbnHaaGlww/JJ6c5j8xydAWD+XQMQuU8xxlE41TsQMqyC66tJSx+x3IKpeAfGxUgXucTttV4p1QWGqqYrTcMXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6381

> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC d=
evice
> tree
>=20
> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700
> > > SoC device tree
> > >
> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
> > > > domains and high-speed peripheral set.
> > >
> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
> > > > own clock/reset domains and low-speed peripheral set, and is
> > > > responsible for system boot and control functions.
> > >
> > > So is the same .dtsi file shared by both systems?
> >
> > This .dtsi represents the Cortex-A35 view only and is not shared with
> > the Cortex-M4 or the Boot MCU side, since they are separate 32-bit and
> > 64-bit systems running independent firmware.
>=20
> DT describes the hardware. The .dtsi file could be shared, you just need
> different status =3D <>; lines in the dtb blob.

Could you please share an example of a .dtsi that is shared between
different CPU architectures?
In the AST2700 design, even though we have both Cortex-A35 (64-bit)
and Cortex-M4 (32-bit) cores, each runs in a distinct address space
and sees a different memory map.

Therefore, the dtsi view for each side needs to be separate rather than
shared.

>=20
> > > How do you partition devices
> > > so each CPU cluster knows it has exclusive access to which peripheral=
s?
> >
> > Before the system is fully brought up, Boot MCU configure hardware
> > controllers handle the resource partitioning to ensure exclusive access=
.
>=20
> Are you saying it modifies the .dtb blob and changes some status =3D "oka=
y"; to
> "disabled";?

no, the Boot MCU does not modify the .dtb blob.=20
During early boot, it only configures the SCU and property
bus controllers to partition peripheral access, ensuring exclusive
ownership before others system bring up.

>=20
> 	Andrew

