Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113B606A31C
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Nov 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=J53zv//N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQrq92Nvzz2xQr;
	Fri, 13 Nov 2026 20:01:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794560517;
	cv=pass; b=ZJ8t/SPThnvf4yQDXvoVdRP4HKAXETU6DeBAlisEHR0/qOV3jySpWTe8w7E8XyhFP1IDxzgPwoppMcgcyS61C/TP6j7qPcqvblivr8H7utWzT07xz53mk4u8oatMm3VIYN8vs/UAyIVf7XyCxqnAoMTK3pb7PgPbDF7BjzbFYVAY6UHGDZ1xtha3PKJOcRbHfjwOxOLy4RTHXN4i60CEefZgfNJkHmM0XVDxIpdz0I9rw9Wd+99vIwp+7gBokUpOvKcKyGe0YM8SPjrjw0tY0xJZf02IisXtkFueF2CZAXVNvOBSXbkdpQ0EAdWZ8fXr00IU52zGCkKzOGzGPS0QVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794560517; c=relaxed/relaxed;
	bh=ClOJP3Vfon+7zyTmqN+42zRtp/WiDI67PrjSerHQXgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fo6vH0V/3ycUK9t0gFmPpdYcHscTb6Xqe0ry7oZkq2iY9sFaT5nd0f/Xt4TYnYMChSYe2Fvt3aJgYOgvGVRvlfGEtuWYMQ8mGD66E2Z0HxiA1oD178mogyQfWdAnz3ihTB6fxVgrFBwNfzEjL5T2JnciSLm9H8ACPb3mTzbsTuBEZN10EV99DhBS6LwJscQ5HFwdqpZ4iVobUBME+x/SHuohQ95Ez+shF1AOLVr7/YFkB4mW/83CvDFRSD7uHjEGb8e1eEGrMLw0STh4krvSoy9IHLe9+LlAXBEkaHBx/EgaWAaZSm0R39RM2MOw0ipNWbGtDW3eLQCjV+SBLKclzA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=J53zv//N; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=J53zv//N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQrq63DRwz2xMt;
	Fri, 13 Nov 2026 20:01:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMmBDLkHQdj0RHnhfy/cVGy0lrWR9hGH7qul05sSha32n259GiVAexA9b7Tc4HmD/kJuRulb+iQayoVOVrvBk/R23ZZAeEvoKR2LwmDl/aVqCfBHK5A9WbQXH+f/5ojSMFtuByk2kveDm5kZOtvYFfo5sYm68Bd0l1AfnMF0BIOvMF4DihD10xBmwBMDyoCCf2r+G8GvxseVUd9CzWWd0yWCV0qOI/qJXa51ZDJWtaGeBMoFcGr0RRdrN79uwldhbpTubzwYzz5vx3eBAd1DsHPedGPO/Psa2+Y3eDddD/X5iv4snKOFKdvVglEesdLEryl2E5iulfNcCTA03CvOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClOJP3Vfon+7zyTmqN+42zRtp/WiDI67PrjSerHQXgg=;
 b=Zff78qnooE4+50YXHO0ppa00aoXgdLdGg/eX6lVmHdcY1Sn4z+TJZ6r2syO0mSR33BQYr9UGn4SAhT9+COJznuVK4n6+mAc4+tRBsNkiJPYx4xqcp316cat2sv75GRirGfrsSbdadF/BiO8meZQsQz7aBJ6QIFjVw1CK5Z20AkWBSS9eg3D4nO6HHXwshKe9bmE2P1wQM9e9reHAQmIaOFfKUSuN/xBQu+x6wPeKwwWPuaYNDE32gp6uz6w2WqqR6d3HrecNntpoWtWqx4nTQ6acJiEn8mKqEd4DmtjBHyMMG6qiscRGNf9oRJ0HAE4hwMOmRzJLn0XRmIc/bCw3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClOJP3Vfon+7zyTmqN+42zRtp/WiDI67PrjSerHQXgg=;
 b=J53zv//NQ1Ca7QFxOCapa4mSS10Q8ZvkGlymw+znPWLLjpOxbwvYPJGi8DdJe62cEpsACqURPpyYaeE12nmSmbiZ2BihIKBmEfmbUydQAB7QtLKPpANUGdUh55Eq7+3ttkie7s4nQFSpmxedCcU1CYuIGWmfgJEGq7zcINIG00ukpuCk6IhWSlbzOJMQxt3qhoMzgxJ8TRpEX+cbe+VBgXrmUwnX/54yxSdpm2QMTGevE2GWd4MEdwZgB0ig2MPljMN7MzcRl6yD7lbWT9n4xmjDhzDiXarlTkTD8g1EZCfSD3VBW3VG92kba4XD0fTGFHp15LUgN+Fr3mA7YrH8YA==
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9)
 by OSNPR06MB8518.apcprd06.prod.outlook.com (2603:1096:604:495::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Fri, 13 Nov
 2026 09:01:37 +0000
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f]) by KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 09:01:37 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Myeonghun Pak <mhun512@gmail.com>, Eddie James <eajames@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH v2 2/2] media: aspeed: drain IRQ work before stopping the
 engine
Thread-Topic: [PATCH v2 2/2] media: aspeed: drain IRQ work before stopping the
 engine
Thread-Index: AQHdcNAacPW34AflK0GKSOOWj4eNn7cqF/JA
Date: Fri, 13 Nov 2026 09:01:37 +0000
Message-ID:
 <KL1PR06MB6942FDCF4F29809B40AF0AD6F17F2@KL1PR06MB6942.apcprd06.prod.outlook.com>
References: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
 <20261109235731-aspeed-v2-2-mhun512@gmail.com>
In-Reply-To: <20261109235731-aspeed-v2-2-mhun512@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6942:EE_|OSNPR06MB8518:EE_
x-ms-office365-filtering-correlation-id: 6283b2f1-8b53-49e9-baaa-08df4164b986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|56012099006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|4143699003|261028144727099003|261102123227099003|10067099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 i3nvAWnyv6eX5A9LDIkDzPvZh1VRRAEESxaZbftgRZp/922RwT0/9DkdIwhZA1jKeXTChtVAoSflZRVhsEhQOiRVJw43AW1+o38g42gpp9aF4LhDjR6C1k5XEmrkKmCnMAqrgwyGRc6+BmrG3dBnHDmkfIkco2ZVjkY0eNEMaIX3Ri+Do7lTc7i20skR3gCenzfum1kUvrJHLtU2O1yqIc9r26z6gyTCFBKxwo0BmL0pKyswguO2FJYRoI1Akts5LTarDv3MCrsA40TQl4Ex0o9lvay9AoOoorYqw3u5nwzJZleb5qwFjtQpRkvtZjKTggs1qwljvBhuxD+6I/6xspWQYaOGEC8PEo/HU3cpkqU0edqro2Klu1STtoOZS0YqwHn1d/usX9Od8lCZoYvi36yXFlGI1zw6mtJmJ3e3N7XYW2z4iciO7uTNyiwpV7Es4258yLRnl8rx0aw7CrbpNzGpLG9jWZmUQsM6eC0qFOFVnl5V0ojoXtWtzgRPa8lmdQNJr+sUECaBwzBfd/msc4/zxjmgBg1K/4a4GQQsC5l4KQZfUwO5czS9EgwfSsAzXjuaeg+A9l32i0x+A278TsgjrM25ruxVI+l6omyDqDN3AfsWN2KHoU6m8uKCOe9yAqxktQXNnRktCBbXTORvSD9Xqssr4fHVVtjDm+yHKPhoIUvECHWcwYoZMY1D5TrBJDAF7PiqqtVVf7oaPE3cRl1cig5Sx28TO0I1BeutHdk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(4143699003)(261028144727099003)(261102123227099003)(10067099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fxJF/GBecuGZXxXivnZyIB0QZCxrR914UWYIR9auL5lTWAyIAvq7zzJCip1p?=
 =?us-ascii?Q?krM23FDpsKmhEJa+TQLnmgBRKAsxKSnsuI3Y57b/Mg4GHL7vlZE/WperLJuw?=
 =?us-ascii?Q?qXxwJReM5KtlgL0QjaWR3VtD3GBAP3Nm4QMxqkr7KLnzbfHWdPEgsLmo7MPX?=
 =?us-ascii?Q?rTwd6nuM/kUtwvJHNbdvDB7fSQsXpLG1i5iOCXbcoBUdH9ETAgvfrrKfTjvR?=
 =?us-ascii?Q?2iNKUcIYe9zRstn6/AhcGlMX7ghssrZLnj5cL2TbCALlyUtFcO5D4AASMYrt?=
 =?us-ascii?Q?ErwgU/GyG9S906oq3SZZOK65zpw8XzUfD9CWR80OVFz/ysvOmdU3/2fAFPdy?=
 =?us-ascii?Q?IvLyF6pan3qaoPstR6rA3F7DtJYx+S7KisLR1JlMRP64MaiABl3OrMTct9B1?=
 =?us-ascii?Q?obn01aVIazUJ0R8Kre+9jtsDvc50JUzLRPBNuKA1TAVauJHd/dNraCPeucfY?=
 =?us-ascii?Q?fmnIyN9pxh68tMW1nzFxxt8DRLDX1lUURY3RBxyxgW3EVIXenuHqQKdBDlXi?=
 =?us-ascii?Q?a/IuhbhwF1UQBJSisOn4XPxLadBGpq/dMFqPKIOTXNSBNtPPDEVuA2sYau9l?=
 =?us-ascii?Q?Gqe3bHQe6q2AXoHt6NJaUNAX5m9Udz4E0S6dV0sSJ7DNFTYt8RuJowVu+6/T?=
 =?us-ascii?Q?hObZXR+KadM+rKbPrBxR0UaVji4Qe5gZ9lYWYtrKbKj5nTX0GLZTfzrTIkog?=
 =?us-ascii?Q?PtU7ttFuRvIlweZH6mVh+JmxKDsUyJz0+70XJiatNnCZUyxn03jp1tii6GTf?=
 =?us-ascii?Q?lu71S/WxyB7GGFQU5KehYahswe7wk+rxCbHaqgXiUcox3OvXp7A1qeRrSSIM?=
 =?us-ascii?Q?DT9qiC7t5xOkyUHMvBVl9biKzrXL2LRN6vHX9Mtmhg9CkESFTYPEJxrGiXnM?=
 =?us-ascii?Q?tBG6Q04ggRTkv2CsRyemmQUtEeo5FEjuEFKa+2bDxyb4F22tUsxkdeQ08FK+?=
 =?us-ascii?Q?1ZQrIBrHgUD576ApDfrzzrbORu2qxxOgVnmDtAqqNZm3PZzYR6egZWD+a0hd?=
 =?us-ascii?Q?BQEoZzGOxP+clwjOufnLEhOMjhc59aMNAHnFm77kh0TuWN04acj9JgpbkAgn?=
 =?us-ascii?Q?T0fq4RSHncMINlVe2RTpts6a8OPt6ROhMYNmKfDyfa6UMaH/YgOD9m6J4BfY?=
 =?us-ascii?Q?mbEmKcAUK9M0Od8NhR6mb1z29oiJc/AYlmyl1ntRS474YWJk/2NDpDmJp5fP?=
 =?us-ascii?Q?zX2rXR6Ka1NfodfNYPOnpwxogwfpyS1aS4tj8D/1zEMhkH+nls9dliBbTXay?=
 =?us-ascii?Q?vWAL7B1z45FNw8SEyv1jDzEy7c/j69ypuaGe7YhwpSfR2WRsq6obvCxs+RRD?=
 =?us-ascii?Q?nLIaJm1XnQKTuZ/3aXmUHMIAoqrxsSKwA2CGVm+YHnL18+1YqTBOajesNg2Y?=
 =?us-ascii?Q?b/FCt/sQb/7komXm4xghiYllFLeLYgN7mSeoJx5mVhtq4KpFJwVWjAyt4M/W?=
 =?us-ascii?Q?k4PKvxoNP3QgEaSgKOc41DNpeN1HGk2HbCUo6ONEZKusBLOUo1tuSHe3F1qR?=
 =?us-ascii?Q?rPvvKeXkmcgo5UwT3m+iEkyQAxmZrXAJthcHgIQpJTRaFw3f/syejr2wPEy2?=
 =?us-ascii?Q?cALQLQK0TvMjm++6inh7G9vovuphuSE7dE9Zj1uoLFaBntkwxDD8PKBP6N81?=
 =?us-ascii?Q?JxNvihBZNufxjcnQQxKk5vR93duY48GHREQL6z9i2++zhZiCaq9kYV9dtJ7Z?=
 =?us-ascii?Q?CZOrEHTs/UII48dp3HcN8PMJDrCrb/H6HBygQbYWewCZjQR0aHDnxLqks2TB?=
 =?us-ascii?Q?hPO4TSJFcA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	yQk9adyvWBLhXCuYkuZhjKHRQHpJcyD8d3MEo5WuBSqohuD2xaRc1FU2hguDzeGQR3elT+mpkOQnxHPvA9z1RsXj6N7I64zwGfYHZN2EptP4cWEqoFHsoMPWdM9iTqAJJ0iji1GYNn0xQTb9Fo8UETmocEIpCtuvsTWobCfrODRaB/oGBLxYNWk42X80nTAkhMmtefosjBtasy8Zdy0dmL+FPwZnmN+X0xRKdUalXetpDgKNXqoLrHlQJKFUimClq/1VOhsycti+C/iTxbIZzTNiE6DMxG75IpUSV+HITi5bJ1xhq65urkUrM9VnYAs8UZrD91q2hhKYFzrRG/VhiA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6283b2f1-8b53-49e9-baaa-08df4164b986
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 09:01:37.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lo02Ek88oihxVsh7xmf7CYwoQvpxNIz+L8YEPQPVPlOvnLc8hoAbNHXrARxkAQTwgCa/18Sfl5VPc9dEL4gZK8Gk2p+oTtE3l0rGnZS4mZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8518
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Myeonghun,

>=20
> Last close cancels resolution work while its IRQ producer is still live.
> A handler can queue work after cancellation and buffer cleanup. The worke=
r
> can then turn clocks back on after stop has cleared VIDEO_STOPPED.
The stop() and worker changes look right to me. The release reorder
doesn't seem needed; details below.

Series structure: this patch fixes a real race, while 1/2 is hardening
for a probe path that can't currently hit the problem. Please add the
irq field here and put this patch first, so it can be backported on
its own with the Fixes: tag, independent of how 1/2 changes.

>=20
> Release the VB2 queue before shutting down the engine, since streamoff ca=
n
> need capture and mode-detect interrupts. Disable and join the IRQ, drain =
work,
> stop the engine and free its buffers before re-enabling the IRQ. Check
> VIDEO_STOPPED before enabling clocks in the worker.
>=20
> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> No hardware testing.
>=20
> Changes in v2:
> - Split normal last-close ordering into a separate patch.
> - Balance IRQ disable/enable within stop; add no reopen state.
>=20
>  drivers/media/platform/aspeed/aspeed-video.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c
> b/drivers/media/platform/aspeed/aspeed-video.c
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1423,6 +1423,7 @@
>  static void aspeed_video_stop(struct aspeed_video *video)  {
>  	set_bit(VIDEO_STOPPED, &video->flags);
> +	disable_irq(video->irq);
>  	cancel_delayed_work_sync(&video->res_work);
OK. One side effect: if res_work is already in
aspeed_video_get_resolution(), it waits for a mode-detect IRQ that
can't arrive, so close may block for about MODE_DETECT_TIMEOUT while
holding video_lock. That's acceptable around a mode change, but please
add a comment here and mention it in the commit message.

>=20
>  	aspeed_video_off(video);
> @@ -1438,6 +1439,7 @@
>=20
>  	video->v4l2_input_status =3D V4L2_IN_ST_NO_SIGNAL;
>  	video->flags =3D 0;
> +	enable_irq(video->irq);
>  }

>=20
>  static int aspeed_video_querycap(struct file *file, void *fh, @@ -1847,1=
1
> +1849,11 @@
>  	struct aspeed_video *video =3D container_of(dwork, struct aspeed_video,
>  						  res_work);
>=20
> -	aspeed_video_on(video);
> -
>  	/* Exit early in case no clients remain */
>  	if (test_bit(VIDEO_STOPPED, &video->flags))
>  		goto done;
> +
> +	aspeed_video_on(video);
Looks fine for me.

>=20
>  	aspeed_video_init_regs(video);
>=20
> @@ -1901,15 +1903,17 @@
>=20
>  static int aspeed_video_release(struct file *file)  {
> +	bool last;
>  	int rc;
>  	struct aspeed_video *video =3D video_drvdata(file);
>=20
>  	mutex_lock(&video->video_lock);
>=20
> -	if (v4l2_fh_is_singular_file(file))
> +	last =3D v4l2_fh_is_singular_file(file);
> +	rc =3D _vb2_fop_release(file, NULL);
> +
> +	if (last)
>  		aspeed_video_stop(video);
> -
> -	rc =3D _vb2_fop_release(file, NULL);
I don't see what this fixes. In the original order, stop() gates the
clocks, which halts the engine, and clears VIDEO_FRAME_INPRG, so
stop_streaming() returns the buffers right away without needing any
interrupt.

With the new order, closing while streaming can wait up to
STOP_TIMEOUT, then reset and re-run mode detect (another
MODE_DETECT_TIMEOUT), only for stop() to shut everything down.

Please drop this hunk and update the commit message and changelog to
match.

Thanks,
Jammy>=20
>  	mutex_unlock(&video->video_lock);
>=20

