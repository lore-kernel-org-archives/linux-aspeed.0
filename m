Return-Path: <linux-aspeed+bounces-3995-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B4CCFA13
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 May 2026 14:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6YNk6Cy6z2y8d;
	Sat, 02 May 2026 00:30:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777645830;
	cv=pass; b=L36vckl1umv5leyUiyO23wwXSF6tHuPJoNRQMo8DAHhTCZxkj7fJ9cVC6yFspCkTH1kf1ykGMgz2ZOtmCbkpSZhvpvrjbunqgmEW0h2mqydRnMgus+/c7gf+moFlgeyIAUr/qUp5aYzWCaJ/2ruHB3WIliunUGIjsU4LennYr/ezjslzNKaatM7GOiBBLfW2PBZ6Hfr2C6TOlvh3ojHGKNBQPyaXekElSnbP1Cyp77zmLco6IDaGR+xAy+X2+Q/iy4QZQnCKxBltXDsyhGqu2jN+xxCjw9coKiaCpzb6bjtdfjLeenGBdcMX3eU1rvbWMeUMIo7RzhblEfK45rIU9g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777645830; c=relaxed/relaxed;
	bh=wSvu8mxYBqF4pXhcBcOC6SQX1fb06X5g4ujm6KyLJ/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efEFaLlFCHy9V8gy/r02x2Cfqj4lUuBPrZTtyvXsN6DSWs8C0AI+WH9tvzgeT0ggm2nQJKsTLt3lqMt8i8gH368/fylaRpbKYe9YdDDlKzAdFAkrugEfArJyL/IE2OtvGr/0ujznTM10lumoIRQiVzjt63ct1oPYaDY718cpQiY9++OLKm8kDdvki/AubKl2gf0E6Zce0GuEcD1ttc6+UZxYDHgw3vuMTMeMSyxVtq4x7YTjGR8I3LOZwTeD17GMCfl5hCey3uvncqN+owUFLTHtJmVumb2z2xlyWmi1UrooErXmwNRI18/dnhGhnt5NqUP3rmGTBKxMR0AZTS5xSw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=GT/48lNd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=GT/48lNd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6YNg0VYKz2xWY;
	Sat, 02 May 2026 00:30:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIcF2DLnqb0ltnefOLrCW3c6EpHLb3TFJquKerIh6zBUIrpp0xufjM1WfMqPWTibYdXwKkJiqm5v7NEOhKHbtMK1X+CZvz6ohl03gzFcyi4LKEEXamn8XPhHB+biz4M+sC2ivke+l1mAVX9GnpuNfd9S5a/fP7LY2BGv22/iCPLjCzqJRX+2JUF8P1NPc3EWppULb7b5VBPIs0F9sTJMh2IVDqXypwOc3QTVkQ7PoMTOsjWyWmsAbeDpeu9byYRigvRgtHl7JqtbdJlOyrdIeq+xCggoKGSemL/pFfY2tnkJibJk4MS1MCqT7Um7AshWbG1lnK6jbv24Q0txXATq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSvu8mxYBqF4pXhcBcOC6SQX1fb06X5g4ujm6KyLJ/E=;
 b=qVk1BCy1zssfT/Q5ISpWT+lhYD5sX3e0SCkPBppR49s0DJn/xX7cxAwcd3Ft08F7C+jUahX8E6h1RThw0lfcVzc96+Lm/OQdF8Wcm+2QGy7O5I2jbxiI2HE/mSdHVbGcbc1Kv7mKROcQxVlitfZYwJNM45HGMTlWYARU5STqfRv3y+p7xxDRo8fGmoPmDmAea7r8SSdtKLMu/eYLKkpXE2xtxGRv06K5EfZmAzH0L8OODPQXNVYZr31f/PzZ2ACsRXBA4ZmbtkaOaRPSgD0JtW/HLybYvj5eoitPy3w/3dCFRF0e7Pi3s8iWGoz5AlFnz9uyKCdfz5JKkGuVYdCShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSvu8mxYBqF4pXhcBcOC6SQX1fb06X5g4ujm6KyLJ/E=;
 b=GT/48lNd29UJOiei87xH+/pzndcjqxXwQ5qN636HCBVABT4OppAA5YM9OkzRrYcjmDR3RtiDvSSXyhjXB0YlHj+uZxtanN0vixUREscYDkWIZTYCbyhtKYuETnOgmXnkEEXbVKwCbb1BfV/yuHZ+YE3fT7JRELRrhaX8UVEEWWzresH9++z7MjrKrL8ti4MhdBFAtTEwvlhMasjzhGrCC5KcAUxCJ0bSbVKBNAH1ZVFvY3VUS1dtI09V3Erl/56IgS3B6WJcGtes6NX4WeEd8VvjXenqsiKdKQOxKKLaR0duVpDFrjcKwWaMGAAlm3MGLk32k7GcM/gcMqvj2AccNg==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYZPR06MB7095.apcprd06.prod.outlook.com
 (2603:1096:405:b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 14:29:55 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.20.9846.025; Fri, 1 May 2026
 14:29:55 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@intel.com>
CC: "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lawniczak, Maciej"
	<maciej.lawniczak@intel.com>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
Subject: RE: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
Thread-Topic: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
Thread-Index: AdzX4O5gznii2OlWTEOwzGmIksiJdwBlO+Qw
Date: Fri, 1 May 2026 14:29:55 +0000
Message-ID:
 <KL1PR0601MB4276206DD65D3D665785C77890322@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References:
 <IA1PR11MB8152D824BEBEBDD4668F97EC99342@IA1PR11MB8152.namprd11.prod.outlook.com>
In-Reply-To:
 <IA1PR11MB8152D824BEBEBDD4668F97EC99342@IA1PR11MB8152.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYZPR06MB7095:EE_
x-ms-office365-filtering-correlation-id: 5bcfde27-28a8-4af6-46fd-08dea78e1d5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|42112799006|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 4XejT+tIVy2mMbkXFyOP0khT4hFdMax1TqF6CMUZtCXCmT67jX3gO/5ie53cfAluReELkwhW2q9yx8LPM3JwgDh8NqSwTdiLtX4Zomxhp3KizU11DK8LgSpdRtk+raRu9USUxHcJfn9rbcGJibebV1xJ4Cv5Gg5o+i0Ccdq7ZDvj5YJe4S7WjCqPGLXa9Y9ccNawohYo86sROa1l/YBVpP1Vi5CMwcSwSQWuVHlWNFNH7WQx50egk0cM24sCUw/K6aNaSJigTkoWGmiTB9yXNdkSpHfPnb9zSjjUexnRoGs6XxAT1+MmIpPbjeOm3hCAu4XVcji4Pv2C5q0+GEUOJ4gvaaDeo4xkIJ9fO9EK7zcM4tYVyMwGuArzgzbTZD/DcuuSz7WQIb8xSWw8VSF0kLxCuCVAXE5sYFB1PpKIEnVM/cozcwm7IMjMSSSFS52ybYxDNnNRXp78eMQAGRuetY09Jpz/yqT/sT5kfKg+dycGR6JKdkwinl4IeAKx7gj8GI0m4RZb5XWTj075ZxN24wLPAwtDR5OA7ZMs/873jX/FtPCcK8sEWSVPBsPNDnm+Mm4vDae3ZeNvsBKQLnYbquRx0XrqQmevvZ69rYQVy1HJiVqH3+S60ne2P4UgCan2vMm/d0T3TUAYzVc/A4ydDUjSWFzBzVuvMWC3OtnAQsUALkbRKJBL/SXqJz11Aldn20aks6sgM6WY8KIOWnNyluqFq9cQCur04PtVS+0pABfoUClUmiGN8l6q5PVZzAx4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(42112799006)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?szYOiT6/Lnh7KdugszivmC0qDkqX6R2BXhgnk4qGafdka8n3jIebED9+6Gub?=
 =?us-ascii?Q?iu8Pt5ckNl2qZqdu0P33IbzdnNtJ6l27isXp7uIM16X3RzVgFOq4Q4oyfGIc?=
 =?us-ascii?Q?7RpTRtsaCSMaOnn8zfXE40Vu22YPkletSMs5LWrR5ma4EA03uqentCETCcqu?=
 =?us-ascii?Q?TiCPXkur2nKiqA3bh5PaU4sN03EFDaUJAJ02STlE/U2z6Pmd/4j80tQgNGh9?=
 =?us-ascii?Q?u23P4KVR1o9fO8ougmUDIV/EQOTm9PWsSRZ/d0j2zFdVWgZEbc0ByuNSEUhT?=
 =?us-ascii?Q?wSXRL80dsJmLl5Bt4IUWbKyA7Eg6VqAp5dhaNxWntrIBxthXukxzFv56ZvV2?=
 =?us-ascii?Q?THmUm/Q6v3HTH/hDhgVuqC5AkGFaUbZd/5Ct+tM+vb7RvKdA1i/D5wKrtDQ3?=
 =?us-ascii?Q?+h3XSKwR3lhs3NbZqNW0Dpe75k2YdacCgA2Gh0078gOOQuXar+w8weL2KlIe?=
 =?us-ascii?Q?uk1Tf+yg5qlZtbFrpNnErbyBwh+kbSf6b6F2qiY2Q6O7QnOZttrRPrvNQGVY?=
 =?us-ascii?Q?BQtQY5J9EGT/xg3FT1GemXXGzUzDtOcFJMYl5T3m0yWmhn8782hUEzOF1ONU?=
 =?us-ascii?Q?AQe9c7t/UqyNXo7MMmSgwEAXaS6DrGFaPkOgiMvReavFw/xEeN5OQf/WwWyP?=
 =?us-ascii?Q?9bunWy9baD/mEvYLWouchDrdMcgv3sgBhDf2GRnDBzFAr3klGDZTqujvulqa?=
 =?us-ascii?Q?bAjrVEuYdHxO+/Z8nYFG+giXT3mkt4+50y7N4IDA9YwkKfiJH11CcRZAnLas?=
 =?us-ascii?Q?vwOnTnmRcA8tMckEA/TvjiX72DkCJi8ibXh2NKZNDs1SkyGLtpimM64EdvO1?=
 =?us-ascii?Q?xanFNgPJ4EZ9y/tYipgmgduPhzrzgQ7BTVQqfJdT7iWzQrgdN+suyZhjKnAV?=
 =?us-ascii?Q?TQCA331pvqEs7PbKvCLPgl19q32ufmpsl1OU1xWrGOaZ/gMSg2DL9wOTG0Dh?=
 =?us-ascii?Q?vLTy/o6OdpMRuewjtxoTAwltC6E0ND5whFS+JxyIlWj1iUdly/1rTQsbkSFD?=
 =?us-ascii?Q?TxliqupLuUhUBRRhkR4c13e232o+L/04rLo52mtNGBolsdrUnOiN5CffzwkM?=
 =?us-ascii?Q?J0aNDL9/QkyT2kk+GK1CBkBcmI0ctm40X5bROlKNqpEUBQWzGygVYGChZxmj?=
 =?us-ascii?Q?zmUciyZhYuPLQZr5oTpR3IkFAE1NAFAz9YPqcszHZKW21X1mxAYo0TJ3wusT?=
 =?us-ascii?Q?pK3b7nI1Tfg/sJqwhl2ziycoyoWd62NsxRAx//SWS5QhPAtc5St838tVjA79?=
 =?us-ascii?Q?dcVDigLvxQC21dk1U7zcsddkqLmbw9cWQqUvlf5gAm4AO3pAWVMiJHqGjd6d?=
 =?us-ascii?Q?MkHFz/SsYcL9u55L0w2i221pfSpDleqZuMPUgFxygz5IiA6R08l72QBj+ime?=
 =?us-ascii?Q?/gmou4Jql5VDxqgjfEuRpZTV/x1uoQFjK7jQN9ELkLLY+whV8+IqTMAmPEDt?=
 =?us-ascii?Q?uMyQPpNkercCECJAJddBcoT+HpaaFmAfxSFZwDu/PBfjfY+tRwF194fIXXuD?=
 =?us-ascii?Q?e+wCFaIN/rckGlGO61Xb1FR0vTNCOPXCbS4JVRiEzt9jkFjld9geRY+SKrwm?=
 =?us-ascii?Q?lM8QArxJP5wD9ssdsTd5+V9lXkufxw2mCDrhozdKcFWnm/o8PO4CGJCZGekK?=
 =?us-ascii?Q?UhzWLNDq2Rg120tZ0aFI79OTKHoJY97w8gCPJA+7VgdgAQRDnVDPRYslN9fh?=
 =?us-ascii?Q?B22pRGClCaFw7pNSXH/NSfb0hPJtxRuKh+qQj4IKEVRpU7yNGt9HVgotf1dz?=
 =?us-ascii?Q?oes5wLyplA=3D=3D?=
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcfde27-28a8-4af6-46fd-08dea78e1d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 14:29:55.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylRGwNW7T7deyPDGm25FS4L/BHWGeePi3IspHiu3HfKvWTn7qmOaNSmxRAPR5k8u3CaRnm/B6YnLGe2pwDnoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7095

Hi Oleksandr,

> > +     if (espi->ops->espi_pre_init)
> > +             espi->ops->espi_pre_init(espi);
> is there a chance ops are unitialized? In any place you do this check

It should be properly initialized when adding support for a new SoC. We wil=
l remove this check in the next revision.

> > +     if (!espi)
> > +             return;
> espi pointer is unlikely to be null here, I suggest removing the NULL che=
ck

Got it. We will also address this in the next revision.

Thanks for your review and comments.


