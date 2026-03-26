Return-Path: <linux-aspeed+bounces-3771-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C300109E53D
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 02:19:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fh6t53XVlz2xS3;
	Thu, 26 Mar 2026 13:19:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774491581;
	cv=pass; b=RrVyxO4OAqzcIEX8nzpF280Gnn9zVfC7FPAHRDfAn6K8ejeqHe4291EIZp/4QPIooszCjB9ahKYR8/Q6xry66UW0JkWnA60M7hwnJJt62U9wiaOuynHU7Okucuy0I4JV4pWM/dNSrcFG8xDMOH+P9Kj8QWvAFEcfZvkJYSJsdHWXD9SJO8JqynVXgJeLEOw2/klXocTSTNEMxsrK9iMyUKkzNMb0as8KO/njLaTrtEM3QE0+1TmCgMimm2wluceKa5ic1QyySp7Po5yZWi1pDZbzl+irJfZqW2cEgIKO6j0t2gKu9zBWFdJCCiKoV1sVHAawwlQ2NR2iCnnCz/qafQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774491581; c=relaxed/relaxed;
	bh=XeicnQENM80sgLS00GECVF/Zy5AYCc1s70sNJVVQwsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h41R4wRU7h+uf8qC+DqD6Wa/RIRz0sLKJrOf+EyZ51WTkDs/7t4Ck7Sa1onuNFgsx8qxcumFa8SkafDfE/JTzhwVV6a1AXd8bCFIhJOXIaXLPwYb4ya2HKuVVfoHUVbv6dEXuVehy37o6VZWilE32Ru/IXZ1QImidlWuNrL7VPDmgc69HGMGl/cCwa2Vb7zRYPVXkk4R+emPa5n4BWM7TwpDENSltmk+DyXufmTQqMPNIsnksSNBHk1Mgr4JUsClnWRmj6tAZz7Jc6W+IeH5y2CAnUIwOCQY98++kMd6AMHgb3NaNVcSgH4Y2rmfSLeOplmoNO5k6B5DitiajR8Cag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kmglUccl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kmglUccl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fh6t44ZSHz2xPL;
	Thu, 26 Mar 2026 13:19:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKOzxK2D6fYiu76UKUGNzKQzV4ugbpXceuQ5iRXSNAvoZby2JBJr1ffGE9S1ydWqM8K5XXfkpYLbQUm8pL0tLTeYbJ1GnkHmA2ZCcnDOmh4sNn5CKQZd2yPf7L2vJKs0REXa6S/ftHW5alklyIpmLS81mFwDp8A73m9EWh4HZQBbptIEEilVm6KPrCtwyPSMf92/HOGCXvoBLma2X5wM0jMAFDhGxC5ZuczYexLfVflHmDb+KMhxJePCtfnPzySQ9Dq06EMoEZqiInMMtfixpVTEK0iE9/W55jcjNu+lNnLJ8sp5vHVutb5rrZgAPft0KGie9JtV/J1TkBah2NGiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeicnQENM80sgLS00GECVF/Zy5AYCc1s70sNJVVQwsk=;
 b=OW8K+HUfU/dlOPQpxtMG293nrTF4XlRWCvw9Epkcd34xbU0BYG/+asJGTh48TDCGkomb2HBGPIiCEszg/pW74+Jc1vAXCoeLUFfg2AsDlgLXJdjDGUgN9sPGN48+zYDY7xJvaobFvruZ/l1UWhzqhsn8r87dbKKv1glnBDmADXTwfgPdUyCNnPy1SODntvdLzd+ximjFhgax8n2pP1Tmav7nqMG90aOvI37clw8gIbKNSLhuo9Bp2+5ShtgpUss2CFDuRFmyqNzV8KJrd8z39f77uYZfoNg6VcLu1GWIaZMEP6sfh3ZqEFFSVItFhD/CCuEU1X95hTOm/cSXH73nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeicnQENM80sgLS00GECVF/Zy5AYCc1s70sNJVVQwsk=;
 b=kmglUcclCVOymJF0gwoZABzolq15hYoztFdNg0yyODNhGN7PXZDQ2TXKq4MRAiaJ0taOHkboOfqyDBvpWVaf9tiXFep4/mdXTDNa0N6+eT5wqvOq1RuGJUu8gI7cebH4jZuzrDeEmOI+EcdqGlGTWTxVXpEyB9WnNLx+PLdzIm0H8+8llo3liSZLpwXImsJjI/7v/XhmprS9UkQrKZPOXY7Akk/Us9pLRcLNILb+/djmAQ+jELaWZ2qzy5ivg/KFU7onXlxcMkjyYPpUr86xaJ0Db6lg6AJTZgyYTqUfvMtQsrtiZfJopEV3B2jDjaRYHysNMNVyc4T/hESfu7sOtQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYQPR06MB8264.apcprd06.prod.outlook.com (2603:1096:405:377::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 02:19:16 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9723.018; Thu, 26 Mar 2026
 02:19:16 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Jeremy Kerr <jk@codeconstruct.com.au>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index: AQHcuzs4qjzU97MMJUicgXu5EEZ27bW9AWUAgAHaG5CAAJ2WgIAAnbqQ
Date: Thu, 26 Mar 2026 02:19:16 +0000
Message-ID:
 <TY2PPF5CB9A1BE6B84773925372254CEBB6F256A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
 <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260325165233.GA3782899-robh@kernel.org>
In-Reply-To: <20260325165233.GA3782899-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYQPR06MB8264:EE_
x-ms-office365-filtering-correlation-id: ff12cf9a-4431-4ff3-9f54-08de8ade1471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 maGe8q5YvTJ/ammVRmMBgO3WMVq9KUBw/mEggk6XjuUMJIabjqtYkRDsLzMVszMUd3xRRlOgIBXbOuxQazfE7T1F/axTQN2j9nDyQ0oh8fd7iNnveWHj6arwNv+T5UxTLKV2dZEHQwbF5E/5KUJWkg1AMP2+Iag94f0TADpzPf0/wiJToMdlSTqIl9VF/bakua0irVNCpVZuSwXhtY6NMS5AMiZ7TwbpE9cxl4zzq3Hf9iaTTDV8voFl2Xhf6iRzgVuvfhR02uPPymwK8yndc26HEtxDhNMP1uptu9vslOpyss8pGn/E1frez21xGTXUiVCjjaO4wHSTk6ypbl1f5Yd3CzAP7EYa45+WGgckulg9oh1aX3HRJLMxwd+F15BqoJoIRW7HaAunJnjI/Uu+5egYHNlYgPbcTpMjhbeaUmjzHw+CqXKkAIrTZWg7wZKBjsD+cKItNFTcHdCUMD0C6P3vqOm+fneqv9v5OcvtvJ6i3U895/0xaj4EQ+WTYCVfmprPkFd20UVZQtK6+5e5rkwl0Vplr8bboHJER8gxSLdsC1jMfzomrHoChU9Tjp/S2cz08vnbgffpfQ88U4ym6avDCUt/njzcbNLb4q8uOY0puaa6nj1SboVZNdDcmiJBtr3J+hWir5LwcY98WE0VpSnBPbG7DNpU1AQRCT30WEOvR+VM51v0SMavwW46xttJHhy76sHTwIATjG6q86XHekqenaRK3memTxsSbQojCVmJK+cy7FIU/5L6VZ+GF+htsYLAFB4V8/h85k864hEzpRJNYl+CWAkpU9qlBse1K90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dCyMx0YUPI6bcHeh0M04m+65KAVZLKYo9SDf978ELus2Ks6YnZWJyV7c2Q?=
 =?iso-8859-1?Q?UuTxgtI9SNHCq+gE5VhEF2ewQgXSpW1KoOCZ0lpRtP+/VeeD01DxAxnMj7?=
 =?iso-8859-1?Q?AuYVSHOyZfCCuC2nKAYnUleoaB5/b2WeqO375b97ip0l5IsDZ+z2JiAvoi?=
 =?iso-8859-1?Q?S9ZpPTn9nUGZ3r5Gm2f1vxTx0RLKgyYEMAkuVZdSF9KjU6wWs81xkffEQC?=
 =?iso-8859-1?Q?9RewKmdokO9A1NL5HSjPwn30ak5+sGtqENaQ0Qz0Lc1wAS5JACypEGECze?=
 =?iso-8859-1?Q?Gz/Kd44NvEma2GMDn/gk9GmITOrlXwmTRc+krIx50Hv+IAjCLcDC06S2Af?=
 =?iso-8859-1?Q?Olh3HqYC10AdulioCR8Q/z4Bi6imPalpqNfzfagQ46/On00BeIm5y5qxG4?=
 =?iso-8859-1?Q?QisLZbW9FgXT4k/URxL/Suf5qgTKmM1u+Nc6cgPTAmdVulGtvvZEFiU12K?=
 =?iso-8859-1?Q?ucez8eoIAimlWsDrPMJ+su7EHxJPcnTEt6IIeU3U5C9QNWumNqHywm8Z2Y?=
 =?iso-8859-1?Q?sNpvqGM7WiabfTS/1dSWV7CCZtaz89Xi/3cl1gCjxs/CHshKae7SXQ7mAE?=
 =?iso-8859-1?Q?J5ojckEQVeDseni0QUf7wNl6xOk59f3Z9tzOEQg1Q+mfsJfPZUSzxa029T?=
 =?iso-8859-1?Q?BAa5gXmk9fUd3AyEaL1MCI3+0tQqaPDO7PpSnv3MwV7/rBgGGqVmYb7a/O?=
 =?iso-8859-1?Q?dLTpJqlg7HNfvk+bAfgvyiX38M6jxScF/kqsG3ZAp70i6qCx6fQwvxebgK?=
 =?iso-8859-1?Q?QOycAZ09pl22kiQ4YmtaRQJTIyty6cdyZgmYKWmA85ivd7wNwEhKlxPTQX?=
 =?iso-8859-1?Q?zzFkhXje3SnuPbuvq89d7y/lC4TbrH+a9EYwPLzih9Qd4oUVhknzVaEvy2?=
 =?iso-8859-1?Q?ZjhK5n/lFzXGNNp73Ah20yfCY7BQj3twePQRAD6BCpXfuovKRacd5zQseb?=
 =?iso-8859-1?Q?enmgOHTVCZn2h5nJrhZ8Xbek0g3VWVfP4JJiM3UJA21asUFN0LB9rpwjsw?=
 =?iso-8859-1?Q?S6fkWvuxe0vXTblkMeiMA51hvFA3i8zSor05s/RGlGxG0WLOAmmm5qqUN+?=
 =?iso-8859-1?Q?VilBiJBm1S72Wua5zi4EqLG+aL5Q1tbcftFegOeeu0nqk3iR2V6wfK5yF4?=
 =?iso-8859-1?Q?SLao+uzgBBqQuasLAi6dFb9lLt+FYCzvK6p0Dk2kElAR/wBf+LOfAEN/u3?=
 =?iso-8859-1?Q?3zfDszW/EQXDYh9XQlIQ182sv6Scl/2t8itSLurC+GiN6CSAEG2zU02LZ+?=
 =?iso-8859-1?Q?LgxZBGFk6UVz5WqPL1ZFil0SsswaRggdyVzbdJ1HYC9f+Pna07u7db96SN?=
 =?iso-8859-1?Q?ZcuswP1U1ctFoEn/mU+vpqqZjR2pbQfpxMWoK9jFG3xLU2lbn1i7AKcXpR?=
 =?iso-8859-1?Q?5j6Y3Ab8GBkAZ7qnmRJwMugNQYw3OCNxCIzjmurRCodps96rDodcC5sypW?=
 =?iso-8859-1?Q?2iDakgxE4gb+lavC5tfr8qFqSSG6EFBuLMbJT2a/0y7OyveBiW75/63Rj5?=
 =?iso-8859-1?Q?8xd5G8Q7aptQc2/z+OYQL0iKWgthyVKhsOz+cfZUSPaBo4FmEBkCQh47Mh?=
 =?iso-8859-1?Q?7qsYZdFBmH1JM2n8lQHrH2dK4+KFqVD/+1wFr6k69kD37yw7B+M0ic3dhc?=
 =?iso-8859-1?Q?iLd35c8aEkrs9lcacXzs6BhLJmRTHbwR8qplmRZd9CEeCEKdg8SmSuExPm?=
 =?iso-8859-1?Q?F1xVFEkHNO+vioGUnLOv8ED3u3uDJIFpUh1KENi1Ob7td13GNm+AkwMROd?=
 =?iso-8859-1?Q?c0mXKNDNm7q7XwxXBVsy4OjD2J/rWOypueL/KIjzrokf7rfWj57m1cl3oF?=
 =?iso-8859-1?Q?077ieuiMMg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff12cf9a-4431-4ff3-9f54-08de8ade1471
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 02:19:16.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbi2RQJDuIwL4yz4Ym+0A4/yLNhugOOa2Tygr4d2IFswPbQBKkLmFc+MK+6wZM0CcSqE8NY9WS/OPBWQgM/aWgiFh3zY9x1kKdjx8dlvcWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8264


> Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add glob=
al-regs
> and transfer-mode properties
>=20
> On Wed, Mar 25, 2026 at 08:11:54AM +0000, Ryan Chen wrote:
> > Hello Jeremy,
> > 	Thanks the review.
> >
> > > Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
> > > global-regs and transfer-mode properties
> > >
> > > Hi Ryan,
> > >
> > > > The AST2600 I2C controller supports three transfer modes (byte,
> > > > buffer, DMA). Add "aspeed,transfer-mode" so DT can select the
> > > > preferred transfer method per controller instance.
> > >
> > > This patch does not add an aspeed,transfer-mode property.
> > Will update use aspeed,enable-dma
>=20
> [...]
>=20
> > > > +=A0 aspeed,enable-dma:
> > > > +=A0=A0=A0 type: boolean
> > > > +=A0=A0=A0 description: |
> > > > +=A0=A0=A0=A0=A0 I2C bus enable dma mode transfer.
> > > > +
> > > > +=A0=A0=A0=A0=A0 ASPEED ast2600 platform equipped with 16 I2C contr=
ollers
> > > > +that share a
> > > > +=A0=A0=A0=A0=A0 single DMA engine. DTS files can specify the data =
transfer
> > > > +mode to/from
> > > > +=A0=A0=A0=A0=A0 the device, either DMA or programmed I/O.
> > >
> > > As we had discussed: this does not define the transfer mode, only
> > > whether DMA is available to the peripheral.
> > >
> > > Why mention the 16 i2c controllers here?
> > >
> > > Please keep this description simple and relevant to the specific
> > > purpose of the property.
> >
> > Will update with following.
> > description: Enable DMA for transfers on this I2C bus.
>=20
> You still don't understand the distinction. It's not enable, but that the=
 h/w
> instance *has* DMA capability or not. It is still up to the OS what to do=
 with
> that information.
>=20
Thanks=20
Will update
description: Indicates this I2C controller instance has DMA capability.

