Return-Path: <linux-aspeed+bounces-2614-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5212FCCF9E9
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 02:42:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cvyTb61fPz2yyx;
	Mon, 27 Oct 2025 13:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761532947;
	cv=pass; b=l9Jqmfi5alDqUeR9V9vGKC3vc8jy1K68blHa4x+mCJUZi3JHJgYZn/GJ31R+KRK3RL5A+ROF1+HAvGOevniMFXjzJS/oHw1WxswGINJlUxHkMrRRKVQg55yOuzjMGpRu79cCG6rahfeUuvHubgjTKTEbkZH80gTib/5vy+QiMLWsmchgEOxaMPoAAzKF+eHyA33UfrWlNUl+DB2jHYLofz1KUH8EUe2CiAgeeCVfqx/NyKnJdjStJRyERL+zumqsXToUG66Arj9QvFGNv6jcOuLxmP6Z5pX/dvdSfWO5pKAIaPKzFmlPif7zWk2/o5Wx+UZl4srCoKC9UfYKgUI85g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761532947; c=relaxed/relaxed;
	bh=y8RgaXGdrWb3i5yVy1EbV3V726G4vTwIPPqIqMKmyGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qmgo360WVqEgwPrsvQh3Ppi1xcPTYawN0aPY4V5AQc0nXTrbQItwI5QNyB/s9XZiM+O54fJzk5hgiXTUO43a4K9miH6U1+AzbCEtVa6+REfIm7g3KdSoIIBOpEYUeIIvVZ9ZSBZrykwNBzSaEO8KRrggLByg80a0OPl7yaJqY1FLduWbkZ+71+nALxQg//ouj47JT3dIgtlXi5AKw6x7IQroWnxi+Q8+Y7dJScgttFoJm8wBc4QnPWjd04hDB80LsQGoKkCgyI8g1jSyQJN/sUiGI5vNQvvbjnM50u/vOqPDQxF7W3XLtH0iwuDuAtNesYQUiTqvEJIJKdVwxXi5Zg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=aLirn0An; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=aLirn0An;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cvyTZ4bdBz2yw7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 13:42:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR4SGxq4BoCbIN3QR8maDdluuxd2RsgfvfrH4gROBXydFSNURhCdusXV3Jg5jsLlJM0d18GMuNvept6AEEXWe9aP7KeAFgGappvtgS/nLmuqfbtK7P6PWFBndtEi2qV5OOP0it2odrO9bS6ZYrRvMBruHKUgsl3X3pP6wADXh3Wt0HoH7L2MSEW0r0dPk1cFPVyparvK73dmnSdDp3aC/WDReyUK0zY955sTcr6WfAnrcRu8+6KQwHVcT/efaFbJQ37ZfXrWPBbWCWlTJW6GB8ScT6hB1yYpNqLls+uvXfxVSfYc6w4sKIG7ONLJI3r/xkaWNuGGibdlJTqh1f18/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8RgaXGdrWb3i5yVy1EbV3V726G4vTwIPPqIqMKmyGw=;
 b=ELtZiMJnICVp9tO5CqlYxKNjSHUdvp3nVVe5qlIXmY+x//yyxVOiT42vz92rl+QMa4BX1NGst27vMYFUp9L75NFylnt9P1xEY4DWLkgVGzhRyt/trfZrMrKUM8ZXrUj88mwr5eGqusaVXIkwXD9B1Q1C6XZVChSZ8/bdpuf26bXCRLzNoONE2EHu7AMkQKy29Xv7h1+NNQ2QGQdruJdsReYkZ62bnCjHAJmyjv6+rIotMcdKAcTfvpN5V2n5dcl2iBGTmHEAyW2piNBtFaQAXzoDnJ8LfEsalnE6jjG5CDKf5+BlMq6d/fTmkOcVo3eT2m8ROk5sTM7Bh7Z6JXpr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8RgaXGdrWb3i5yVy1EbV3V726G4vTwIPPqIqMKmyGw=;
 b=aLirn0AnBBzFFE9+iEkVwEQwq3plua89WadCTIpgiz8QB+42wlUp7DFT25RPomsIAbvfjDuaQmydqcCMTa/YTLqEVrUYUCciN7qVuN+dw46PGJ74NqgPFEvdDC3eB1RlsNSCYYHGiIoRXwtiuielm1ykSS4tM4oA3xwtxcq7yldw+tMHkosrNkpfUuKGoO0wYTr5FulU3uDnu1/ZPesjjACvmHYQhC3rnDSx1b6V61UdLCBz1hzvZYxHX1oGrEzfMCBOdEJLdBe/yNM+b2h+7j+QWp7P3+iPynmJfLL6vkwFgMfkfN9kv+I4W+1mFUq3VlPhtevpEyeKyKFElydWOQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:42:01 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Mon, 27 Oct 2025
 02:42:01 +0000
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
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAIADDnEAgAAO3MA=
Date: Mon, 27 Oct 2025 02:42:01 +0000
Message-ID:
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
In-Reply-To: <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6935:EE_
x-ms-office365-filtering-correlation-id: 0fddbe53-4761-4d7c-39fe-08de15026821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bsxe2v947W3PrfMVwNshkA9HIMZPLvxCYBBgU0J1BAJ9p0a0Ai+srxGByx?=
 =?iso-8859-1?Q?2OeVUfEfAjBoW+zxAMCPODnCfr5ILwLzcJG2JOy4igWA5TLxW9oEVHytUh?=
 =?iso-8859-1?Q?90EMbU625HpwRwC94Vk6zpjyURqbPbOrrXvVHIqufHHG0dtSp6VZhu/ikU?=
 =?iso-8859-1?Q?nF+Tn0tG6NDT7cz9KkU79vBDPK9VkU9/j4pAmn/iVZF6OOYpiW/WQTzIfI?=
 =?iso-8859-1?Q?FR1ihuKHRpH9BzRLaPbLlwgUY7p4+y9+FVqzwx0sQJPOXex8WSQhTLBagX?=
 =?iso-8859-1?Q?J8mtjO4vxOe7XN4qjhOh6HohlGNDclp/KKww0WjYbNZk70rQNIs9HeZbLE?=
 =?iso-8859-1?Q?adRijK8AUscJggg1EgpUz/paX8zfXnV+X247SO7vBBiEydgkjeJxYWexs8?=
 =?iso-8859-1?Q?I6Nwfms2gZT+3ndkgxkWaflqYYROsydPqfYME4Gbd4KNNrnNwA/yWtJwbh?=
 =?iso-8859-1?Q?ZWinLARFj+F7A8RsIvLl9SGGCMQtIRWowMZb8FOVarGUWFXbh+/9jFiHaB?=
 =?iso-8859-1?Q?qmOw/mNl3+OBOTzDrs7lGD4JhB5uLX2e6wyxBbfv3qs6XaBGn89bW+Ho3m?=
 =?iso-8859-1?Q?yZBeB0CW2eXRA/SdTVMtJQbNlEvkezdoNRnYXV+smJndRdatg9TRSC569T?=
 =?iso-8859-1?Q?tgpusmQOkc6/1CtTft2UmfrReAI91mlRUGJt0raq4XTCDnDi4pchL7NBTw?=
 =?iso-8859-1?Q?6ZJxrZtsnLwMxWRiTaaJV3d+yEg6CKseOdKW5juaG3OEcMw7BaL3plpz0C?=
 =?iso-8859-1?Q?i7NXgzOjuXyElZeAKErnH4aJEcuuKLWFHpZsQbQPklZlzKEmRkpG75m1Rz?=
 =?iso-8859-1?Q?wYtvWjei101KXC0P5bcEsgZEqr1sn3nYYo6REvB1TfG1AlZeMSYHBlx9YJ?=
 =?iso-8859-1?Q?1t1yJ2nJJFIZb6WqbiahZc6HBnLH6F813g1wVGN40Ba391zLcWViHJ1Saf?=
 =?iso-8859-1?Q?Nh85nPVl9Sby6NHLdHTeHGJ3azMP9r7OLGkiRLR/tzCgoL9cEyn5qKvLSg?=
 =?iso-8859-1?Q?qhyMhFSgV/UjADGKFgc4GkCdHe95F9wBdwv1L6lkST/bNJMGsW2htssnRf?=
 =?iso-8859-1?Q?oJrwxBS+92QFQxFd7dhxomz9UHVzihgLhkejpJyfXDHSDh9NWQXGSPaiVJ?=
 =?iso-8859-1?Q?01QA9iWhmq2bfbm5rC4NxvN2WCvL58FlqKeFQp0fsSEasKc8mB97VY5wln?=
 =?iso-8859-1?Q?ZxIz2NKLCBXvi0LOcHBwEjdyTAOODX/elJZEL6TcsGR8txvROpMKGM+JSR?=
 =?iso-8859-1?Q?wm4ynMbIMz7PhdwdeMVRmLliOYT1M171uHKYDY/Yi0CC5Mj2CgZ3hyHHK2?=
 =?iso-8859-1?Q?IjQW1iCht+0ieHFCMTP+BMrugkE42bjM8OEaxU+Djd/77AA7hSRiDME/CB?=
 =?iso-8859-1?Q?k2pYkh7LXQxRzOIwqDl48YYjCYsxRzP4TY4epKZ6SFTrUkqZLFG14W1A2z?=
 =?iso-8859-1?Q?nMuwyH46jUMjgn3xcWR5IoqznMgWjSDKaT4bVAKffkyz6Ys30REPgyn7aO?=
 =?iso-8859-1?Q?bHiILQXt9pYCaX56XC0o9HP7CKq48cyyTw2rmG66z2hlWR0opY30saBVuK?=
 =?iso-8859-1?Q?SJ7UlOWntPfSbtyikyi4vQPaqMyO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?znt69szmm8RHPpp0AwuQ7m/16vJJ60zxTQTY1/zEPpqwnpoKcj3jGqFeVF?=
 =?iso-8859-1?Q?o6em3WGtdkWhgid87KxmMqoC+sy9JLGK6Oba+zzRQl+XZVZvUMhUi/4C2R?=
 =?iso-8859-1?Q?UY7AY8CjCTGj6kJw2Ql5UZbjVktX4M9DbaE0z91pzM4oEy4edjqHO691r7?=
 =?iso-8859-1?Q?bYXtmIEztGgHaaLV1xD9ODT8zMQhLcqMMW0pE1AyGV6LhrvIp5QNBDb3nA?=
 =?iso-8859-1?Q?ov4iBVDtwOOGlN7+6/04Kf845spE23oWSk+vN26kzQ2CcnVmURRW1UyAtx?=
 =?iso-8859-1?Q?tM2+CUeJeq/ZzbHq1wXPcmTnXjxoB52PPw+wemztuVTBgYMdKVhym0UoC/?=
 =?iso-8859-1?Q?2Sd+mySla6luEvuKegO8XfrFVGs2fibEFjRh/SOLpomLpahrG/ZYTmG116?=
 =?iso-8859-1?Q?apM7YdN6FFU25eg27HUUjtBAvlxUBCF7wiuSupYTNdmb8NBNqIlzabQCYy?=
 =?iso-8859-1?Q?nia6ysRCV7sjpb1PLaV53RqmGyhzGxfxF+u/Nis2qGt8bIUHbBPZHXviJb?=
 =?iso-8859-1?Q?FANHEFG03gkyX2z84YhSOZ7ZZkPPsty8+TxAfcKhItJaPlAuho6FYaRV09?=
 =?iso-8859-1?Q?yzr97znmlVUePEg3NI9+F07SIKneQozh8gyai9RH/7pcHMf8FKYPPeCCKp?=
 =?iso-8859-1?Q?3u9Ul41YmWWU1LZE8/DJQ9CfsexwjKLvy1k3nw6a31v0hTXOdYcOnl6FgF?=
 =?iso-8859-1?Q?zM1XiOeCw1a6UH0fPLzbTegKSIdmNnJWtNJl/eBlr0JnM+LDTCn6liPlJH?=
 =?iso-8859-1?Q?czxeB+6FliU4WIbJOilkv7/xz2331Cx8Um5zs0Ac9URAh2PcQFscqJisiV?=
 =?iso-8859-1?Q?Z4C1oqTcKoyrNyMfa3ZuCefz7UPCIW4SJQLRQcegyOYcqC9ufGl0JszbYk?=
 =?iso-8859-1?Q?+asg/P3bRbAkSVADTlwFkMqTOoQ2jKdA+6rjC0tdo9UdaAf2q+HsoaVjnx?=
 =?iso-8859-1?Q?hb+GzcuvG+YPyFqUv1e63BDtvNWw7tvJQfQ2H3RPv84C8ZU9VmKAa9/n/t?=
 =?iso-8859-1?Q?ZNK+LFu/UqZmFMwZUPa53kHIsRI0iP5my68pSG5M1LsiyQawhjc+0/uOfl?=
 =?iso-8859-1?Q?EopbHjQecT3uXhQaVBi2XB+HjWJU+sWbWIoRUt9kOmy4kjIpKnLSFU9NDr?=
 =?iso-8859-1?Q?bD8L4U43f2DMjtMt4NhKv5CfUHzTte15HKqYAKMIjDcg/YOJ6AX7VBIVkK?=
 =?iso-8859-1?Q?74fri5QJw7hhqq0/OdWCCoHbKS3cqCFBttdfJOC5amWJDHOrHJh0l1qxmU?=
 =?iso-8859-1?Q?5DYyjRyM1MpYh3nCcid5CiW5aIwRD7yuSi05D3SUj29l0qeqG/MbomfQjp?=
 =?iso-8859-1?Q?VuNPJ8/3dY0bAXljmUnrLMwbTw8Grx3y6gap5wOKOi2rwLwwNrKNN6NyM7?=
 =?iso-8859-1?Q?KVq5dQQjlmsorpl3PkElSpDPw5PtDwT7bRqEklP2MObSxt86gKFbldx/YP?=
 =?iso-8859-1?Q?bmEiqxCM8M5W1KDVCecac4VB5bn+sL6GZQ2Qi8b6I6fpV1q7AxnNGUEfxq?=
 =?iso-8859-1?Q?PppIHbOCfIqyF/D+e+UnQ2wwQ0X/snvZo2RXPPnAxD5b4kEhgOs80XRY6K?=
 =?iso-8859-1?Q?sb3idSlh6Ke96anYsnsJ8BHa/wEqZUCfdNd89+Zxf6eB4kipUa9RbQQRDH?=
 =?iso-8859-1?Q?iw9HaB5maoPmhqhPHp7HCWovaVjCvQyVAc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fddbe53-4761-4d7c-39fe-08de15026821
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 02:42:01.3751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OsCS7zsmfJgLEffcJZBkbTkYUKJiEchrcb/EBgQRN8X/hk+ROAMz74KqBJB7YmIj44VEv1nzCCNj8ZKFHe5JJNC5LuMJ4tVr5ncP4p60eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6935

> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC d=
evice
> tree
>=20
> > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > cluster and two Cortex-M4 cores, along with its own clock/reset
> > domains and high-speed peripheral set.
>=20
> > SoC1, referred to as the I/O die, contains the Boot MCU and its own
> > clock/reset domains and low-speed peripheral set, and is responsible
> > for system boot and control functions.
>=20
> So is the same .dtsi file shared by both systems?=20

This .dtsi represents the Cortex-A35 view only and is not shared
with the Cortex-M4 or the Boot MCU side, since they are separate
32-bit and 64-bit systems running independent firmware.

> How do you partition devices
> so each CPU cluster knows it has exclusive access to which peripherals?

Before the system is fully brought up, Boot MCU configure hardware=20
controllers handle the resource partitioning to ensure exclusive access.

>=20
> Seems like a fun system to play core wars on.
>=20
> 	Andrew

