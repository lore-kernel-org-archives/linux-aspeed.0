Return-Path: <linux-aspeed+bounces-3493-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABF7EE6B4E
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Feb 2026 03:51:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f7H7R6dMQz2xRv;
	Sat, 07 Feb 2026 14:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770436275;
	cv=pass; b=SkuuriXHS3hB0l+zXtM3uNVA6ywjZDpppbOpKnqG3ieE/PVB0F6QqbAzdqrSOaVRG6nMNgo1+RlsERXNVLlKwRLLt/2eNItQfaKsqRBxatuh2r6SYDTFuSDMd7F1N7qnob0yAxpXETeKYmzr7/XX52rrjJZ7z3kwPrEbDtjXAEmeIoBhRK/KXnx+p85GuEGqAnWzRSb3WWs4raKEkumoP6r/8gFbBBgaI3Qhm4Yvn7OjuriknINfLJY/u/HiDUBzT+7KK98NfQQZPVr5A7+34FO3edCIw/eX4lz0A01TnH6n2tHss1aBwjkzS3fsuLUEYodKpNVUydSoeNEFEJMCVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770436275; c=relaxed/relaxed;
	bh=LvumoGd73ag9Gn2xMJtPKZZmvF9yjhFI7SAWLwkSIe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irY8dxG/6Ebhkg2Jaj4iv0e9Oy/fhKYg0XHfN4algIcf6HTt2Vkq96C4iEnoLw6cX4VgmRfA78336gxtgQT+Kl0qfWQ8GVQvfovvD0d4TJQi4pqjouNNAjzqYvuhbcK3czxtN25D4ylyjGvQL1AvTe2mB+wPRYrB+YYPS3QOd24U9bEI8ZhZMl/7GZX9FbqydwWvWbtc2zmRUnKxyaA5KgSFonA/osKpV+IzMbFdljfF7Opn4wh7HDkYRn6xS3E+mo/9qOM6Hf3HoovOP81eeftiUMVQMmMWjTNNgEFxx5vrjHZpYMGeiBnX8WIlUq97x9dynk3lkvLlf6fTPYj4bw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=gG0VN3oX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=gG0VN3oX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f7H7N6Pwjz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Feb 2026 14:51:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkMZh+hPDxINmhn/MHe5LyTc52VluSDdQFvuWVAlH47fWhvEYZeQcfLH4SY1uZWnvjoVY82a+Ayz+UgAiXrPgBypiSRRy1OKWPilMpJzRt5vSlHl+t3swD2x+lBuw5sQXhBLdC0e2TEfF5thd+1VD4oDRH0WC5z/TtqdY9o1T2PLtWxSMWt3At7Lac1HXezQL4iFrXXyQlkKJBjeHuf9karMjTa+f/kJmKY65T7aum2Jbn0N/9NoTzL4DlcTe4x09wslFMoMHxm7qC1a5AAC1ETVO5WG3UnhXY5R6+RscvuKUg8kAD/zEFATDn30ByP2k2UPk3wXMWIiDIX28tUmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvumoGd73ag9Gn2xMJtPKZZmvF9yjhFI7SAWLwkSIe4=;
 b=fMBiV9jMGzdDK5S1k8FU9QoaTO0LcF/evVdB6hy+uEoC8zgrLeoFLoo2zAQiirYc0DtsCezK4+ING7MSCAfP1yPijSmPly4Yz2xBN5rAFhSokyFnd1RbF9Wuyqugwph5oYT6Q2q0vn61aAgFEn4dNq5S8KrkiOph7dKYppYqisIJPeH3PJ+KV4iaEBt0+ODHpZ2t00VAqICNUhSRsRe5zX+Ip/GouADF7eTguc/E2RRe1H7Fr+GgHL0oVaMehUuGpkUB2QCpBgHMXRWdNDEnic1RxvRzNgNWC6omTyGcdUHiQQ497FfQS0zf143KIvBcJI4eXpQjTbBN/lI1S5YWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvumoGd73ag9Gn2xMJtPKZZmvF9yjhFI7SAWLwkSIe4=;
 b=gG0VN3oXrHaEzCsYt5ZvTBpjwdEOwT0FT8Z9rX0CmsbTrZwHmoBwfVRkRjN/zwLCMKAZn4b/Cu2VaJ1hFY+STHuAZOcAke6GdtUq1UpVQd8n1VdU34hI1WO0HR9ufxbaZmB18TS0TwDB/h/pHjqE1DSEVb5/lhC1/sB/YrN7MOflX1PKc8HOZqBD0TbvMBg2Am3szccf/ket1jionqlYYfK26njIY6hCRnLP5wpjDQ/Penxw0Z0X8ASYi5gA6+msLM7OMo7h8hIRDgeKGT0F8J42fzbCfAUXXkBKqH7qj2BDkeJshMkQ4BarubdxYx4QgS3rXqpY52OWy7+BCKXgNA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by OSNPR06MB8330.apcprd06.prod.outlook.com (2603:1096:604:472::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 03:50:45 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%7]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 03:50:45 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
 support
Thread-Topic: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
 support
Thread-Index: AQHclmW5rzV03X0Kg0SxRPeN+45NtrV1jEMAgAD5ciA=
Date: Sat, 7 Feb 2026 03:50:45 +0000
Message-ID:
 <TY2PPF5CB9A1BE6CC5EEC90EBF13B083D1EF267A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com> <87h5ru14xx.ffs@tglx>
In-Reply-To: <87h5ru14xx.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|OSNPR06MB8330:EE_
x-ms-office365-filtering-correlation-id: a9a666fa-130c-483d-7f13-08de65fc12e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5wgdWry5AS0TpuZ3DptSCv1lfasjzg4P6hjct6f46iRZSXWszBEKY1EeMtC+?=
 =?us-ascii?Q?ZB+wIChx1TYT8iI45QSVelgpeWaWyfuQDAa1ouTqJEnTDW87FNQwIAbCtY/e?=
 =?us-ascii?Q?VGlZKj7DjlTceQIHhm4OhCNxjb7DYlzf8/vIcjmGHsMvGshFoUmPhpS2Sqjl?=
 =?us-ascii?Q?Q4lAi3go35k91UGf2zLWkXv+jl5jdpVKOS+jTLWrSC/WIujQ4wgu6ly6Etb7?=
 =?us-ascii?Q?h6fKlZja5+r6GYdkpO4w+DSlg3Hn9Kl1zqMJlFF6pdHirj8MDTd1lEOf0+tR?=
 =?us-ascii?Q?SMzGdFJfs0aXYVTqlXST3Kpv0en4yiRH3CZEKoXkmYcJG5rqI7Kj0K3TNast?=
 =?us-ascii?Q?8cip22cZ60sD4isvCha5xmKk4FhxbK2e5/v2/BR3YB2uBnDKCw3tTQPheGk6?=
 =?us-ascii?Q?e70/EsiKQZr0Cn6DeIxpOxfyoxf2Y+kvtaJlxtb1dm0ygvadJAJpUfFGsYoY?=
 =?us-ascii?Q?V+pE1Gutz67aQ8UeWWwk1A+6j3Iv9T0b4X06FlaAKAmKx/wZ9TR6UyM3TS/l?=
 =?us-ascii?Q?Yd8uvqryHpmvPFzQRO9u6ZTV65aQ0Q+GfyHXRiC4en2jSXJdUGhkWUiqDLkH?=
 =?us-ascii?Q?Wm97fStnRkvgcitqdHQs6VRdo7vkJtMXL0hqKebNgeC8SpGVB/ANmIV64mSb?=
 =?us-ascii?Q?JJRuq8HJEu8UIxCr30d9v3SBhAd3+ZOZ+8pkoRIR897Ua6Xsq/x7fC4qNcbT?=
 =?us-ascii?Q?7/d8bf0FvA5DrSwNwHmXitqWGfwK745+ER2CObsJttNwo0sZ3mmZbNNhMtVA?=
 =?us-ascii?Q?ljtelofWmZu//orFRZN97xo1rymVGrkf+Te9aWbeB2KN3opHcbgZDvKLwq12?=
 =?us-ascii?Q?z2ZdnAb6AxaMLoNnFiSQRZaviIUcwi3VZnwWuV+WrxNch6JNuZZ9K2OYs45n?=
 =?us-ascii?Q?Uvt2MW4bkFJLIKIGs8wODxrOVr7ySe3N95CFOM2aTFdwK0TjgjaOTpoIVwR6?=
 =?us-ascii?Q?MAiFRWYYkB6rToVYyDiHJjPLJXQtOg2Si18okVMKzcJpLv13mVemHX27LhWW?=
 =?us-ascii?Q?spOA1M4OItTrSO6tVcsCUZXfLHJXvE1nz41reiC1R3VpMTltVkDJfOFrm/7o?=
 =?us-ascii?Q?4YRtSKVraOC2kJxBS06KyKFC3dbed/rlY5EtToC2KAiDusttC1P4c55L029o?=
 =?us-ascii?Q?nFiey9aeU0LMtizc4+fgS4WGdcyS77mxfmT5TfK6f8tOzKD7S3IxGCuwsqx+?=
 =?us-ascii?Q?lwMvmq62VZ10Y49Yte6kzIrbtXDtx8Anyzl/mgMpZVubhpGjHHO9xBNrIlxt?=
 =?us-ascii?Q?M3c1ImqhLyzN529Lw2cE3c1Imp8ccvIk497nV6e6obPzSVVURZKtGyFv6FmV?=
 =?us-ascii?Q?UM8h6FgYSS7Uj5gDPk8gKSQrJzHgJmFpab2sFH3yHdYg7kNJ/mEtNpHc6/ff?=
 =?us-ascii?Q?KOGkqAnMNFIioak+yAXhNGJVHfcVEVDY6NDKIuC/Or0P6pHffqoepLOXJ52v?=
 =?us-ascii?Q?Ny6Mz2rqFxnTL1BPTyN/Fdp7Gtuae+aV4j3BO/XaWMSQQEaSmOBwshRX3exc?=
 =?us-ascii?Q?dDG5c57ghXMfMRjnx1a5gHwdZdcFk2ObTOT/v54fYFyKz4uEq8X0tr+p5E3e?=
 =?us-ascii?Q?zXqaqm6vkIeEtLBW7C53ohELIUT6gA6P5HI9gaawcL10ojw6hV9aOq3p/6K+?=
 =?us-ascii?Q?G6a4pS9e7EmUuj0ttddSN2rcVocVrszuAVl7x63OMFV1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2YaMyAlsHwBWHqE6tVhTQrQAL27iROSWcB6oWfUint2VmPhCALThjweeFfgc?=
 =?us-ascii?Q?fXhNQ6tap9lyw6i/8jH/7FKO98acqZh0PJBOusiTQt+kAe1ebbc7dPfYuP4i?=
 =?us-ascii?Q?gKtca1p2ZlKNg1m0bzYDJY5P+ovs6PNXKAXDWfgkX0tUwSmtRdj0/zusuKdB?=
 =?us-ascii?Q?5A5zL9nY5K4KjDqaNUhfKXt7YcEM3wf3hroOBHks2xRkYEec2fqN5RscCmWb?=
 =?us-ascii?Q?RbF/+ZoHNSeaByeN+gh9NOZSYM3wjPllxQeOypxCagJJxAZueofZ1pqXzue+?=
 =?us-ascii?Q?gIhcQkLfeotbjoCNkfRIoELZcd/VJodv2kq66w3KGW9tBae24Sho9JnKMzNf?=
 =?us-ascii?Q?zWr/AglixFu+eNK/LtosFd7U4JznfzIp2K22gXIyqWSXx4CSB2XGfWe/UpZu?=
 =?us-ascii?Q?/4miwqzjKskPzomzlct1Bp5zoPEl3E0buQsv6CA5rX5n04EKJpv8lWhTsl5L?=
 =?us-ascii?Q?lx6p+pb5VDyCL0/BbeRh61VCYS5aoaGqjNJPoJOBeUv4E9RaFVkvFTa5NtuN?=
 =?us-ascii?Q?VZXw4RJ9BY5xu5l2r1OcsNuo1PicSXAYEubTBbTmG8A/q9QCRlnmRySJ2esq?=
 =?us-ascii?Q?JPYASN1gv4xpe6Z6v2OZdIwAFmVqdrjFc9WpHvr2NZL8mPVA7ziNVroSow7H?=
 =?us-ascii?Q?cjiV1WCH/7dwHoOnE7x8Ox871s7S8Fg/AyvcG3cDllBF6y2DrMS9S3ZtXM1m?=
 =?us-ascii?Q?7Vhk1LpIsBzUseUJpGNAH9bH+eCqMmklzWwgaId5UV78Cw+bLNPb5yBeKAwL?=
 =?us-ascii?Q?g7WU519RhowmZwLPg/Z7YhIWpd/lGSRgiGSr/Ifcf3mKEgsWrhKsfew31Jpd?=
 =?us-ascii?Q?eIrVsqvGmfFW+25SHuQLFxSqt8gTGrJIBCWKKPxY0KR5a2GanfMMJlHLNX5g?=
 =?us-ascii?Q?GIxmny0zCcQiUr3AECREVI8kC2ns2co1bdiMyvUqUPdbsaTPvnHEjnVi/rft?=
 =?us-ascii?Q?MIWgLC2sTqqxlYQY1WTaAgRmgfMsOmqU6g2n6xt1NbME+LrlIsEOdGDMNXDy?=
 =?us-ascii?Q?/v0TAmDrZPjmPF7zRjMVaMwy5J05R58oqQ8568p3MyyZsxSg+9uMNFrkhsFp?=
 =?us-ascii?Q?aETw0d2Jl4MRIFBJwU9C/L7lmPTtNovY6bkTbou9jOPeRTTDas/XaBcJASDI?=
 =?us-ascii?Q?FLYVN0PPbsmZ1c6T3FzafLdy+5+5j3TKFrq1ACG55ZD13TxUF/qzFHtYROY2?=
 =?us-ascii?Q?w7z62pC8SjNHV1rd3teZtfuB5a90zcegcbflSPqIYCzjx/UfRdrl8SkB1Al8?=
 =?us-ascii?Q?5wMkg0Bofk0jybympII+qtzQOOjgH56iB+g2cmeYSgbXSI8VZtGSrOreJBH/?=
 =?us-ascii?Q?OQ6CkEmjMnRFIZ3Ki9NDl0ioxgnNBcbkOJq9A5GhkfADDYOHiibm2fAZc2if?=
 =?us-ascii?Q?5b8esqso+v/pY20OU049d7xIBE4AGps8Kkz0TEy+nddBzub3H+W9lqVZOaPt?=
 =?us-ascii?Q?ILfP6afXVDQ1wMLJbi4iaKIfqEO4B/kDJ+BDHxnZhmU91/UjgZjEqXczvOVi?=
 =?us-ascii?Q?8zdYUI9MPEqfr36oUVSkKEiuIB2jQAQSLaD5uBOTv3sb5abQZDnbKx2N+H9S?=
 =?us-ascii?Q?nPjZCwW7dSfFPl7mzFIdWepR5Gl6J85wtcodV70hfYPOGu+94bul0GAZ15iM?=
 =?us-ascii?Q?USmOWXAedKu9Li2tRILfUPAwTejx1UTlmbG+mlwPkHF9B73r+mRR8hswHd+k?=
 =?us-ascii?Q?rJfH2g7Xg+P8fzpoh9nkN66+nq/5iG0kZvNF+M+0QS7RydpzUasup57PMuiz?=
 =?us-ascii?Q?m8rrQb+TgA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a666fa-130c-483d-7f13-08de65fc12e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2026 03:50:45.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /x6QItHwzLS++5NKa4rIsjZ/NY15nB1KwXFI/lM6MXAlJ+gva2rKXnEopfkC2mNMWdypLO0qYvpesFE1ClEmSdUF0MUAnWEIPtBb7uZxXIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8330

Hello Thomas,
	Thanks your feedback.

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, February 6, 2026 7:34 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
> <andrew@codeconstruct.com.au>; Paul Walmsley <pjw@kernel.org>; Palmer
> Dabbelt <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>;
> Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-riscv@lists.infradead.org; Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
> support
>=20
> On Thu, Feb 05 2026 at 14:07, Ryan Chen wrote:
> > @@ -88,6 +88,7 @@ obj-$(CONFIG_MVEBU_PIC)			+=3D
> irq-mvebu-pic.o
> >  obj-$(CONFIG_MVEBU_SEI)			+=3D irq-mvebu-sei.o
> >  obj-$(CONFIG_LS_EXTIRQ)			+=3D irq-ls-extirq.o
> >  obj-$(CONFIG_LS_SCFG_MSI)		+=3D irq-ls-scfg-msi.o
> > +obj-$(CONFIG_ASPEED_AST2700_INTC)	+=3D irq-ast2700.o
> irq-ast2700-intc0.o irq-ast2700-intc1.o
> >  obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> irq-aspeed-scu-ic.o
> >  obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-intc.o
> >  obj-$(CONFIG_STM32MP_EXTI)		+=3D irq-stm32mp-exti.o
> > diff --git a/drivers/irqchip/irq-ast2700-intc0-test.c
> > b/drivers/irqchip/irq-ast2700-intc0-test.c
>=20
> How is this kunit test supposed to be built?
Sorry, do you mean split it with Makefile?
obj-$(CONFIG_ASPEED_AST2700_INTC_TEST)	+=3D irq-ast2700-intc0-test.o
>=20
> Also split this kunit thing out into a separate patch. It is not relevant=
 for the
> functional part.
Will update to separate patch

>=20
> > new file mode 100644
> > index 000000000000..d6bc19676b2e
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-ast2700-intc0-test.c
> > @@ -0,0 +1,474 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  Copyright (C) 2026 Code Construct  */ #include <kunit/test.h>
> > +#include "irq-ast2700.h"
> > +
> > +static void aspeed_intc0_resolve_route_bad_args(struct kunit *test) {
> > +	static const struct aspeed_intc_interrupt_range c1ranges[] =3D { 0 };
> > +	static const aspeed_intc_output_t c1outs[] =3D { 0 };
> > +	struct aspeed_intc_interrupt_range resolved;
> > +	const struct irq_domain c0domain =3D { 0 };
> > +
>=20
> Pointless newline
Will update.

>=20
> > +	int rc;
> > +
> > +	rc =3D aspeed_intc0_resolve_route(NULL, 0, c1outs, 0, c1ranges, NULL)=
;
> > +	KUNIT_EXPECT_EQ(test, rc, -EINVAL);
> > +
> > +	rc =3D aspeed_intc0_resolve_route(&c0domain, 0, c1outs,
> > +					ARRAY_SIZE(c1ranges), c1ranges,
> > +					&resolved);
> > +	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
> > +
> > +	rc =3D aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1ou=
ts,
> > +					0, c1ranges, &resolved);
> > +	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
> > +}
> > +
> > +static int
> > +arm_gicv3_fwnode_read_string_array(const struct fwnode_handle
> *fwnode_handle,
> > +				   const char *propname, const char **val,
> > +				   size_t nval)
>=20
> Please use the full 100 character you have available and avoid extra line=
 breaks.
> It fits nicely into two lines:
>=20
> static int arm_gicv3_fwnode_read_string_array(const struct fwnode_handle
> *fwnode_handle,
> 			                      const char *propname, const char
> **val, size_t nval)
>=20
> There is also no real point to have these overly long function and argume=
nt
> names.

Will update
static int gicv3_fwnode_read_string_array(const struct fwnode_handle *fwnod=
e,
					  const char *propname, const char **val, size_t nval)
>=20
> > +#include <asm-generic/errno.h>
>=20
> That's wrong. Include <linux/errno.h>
Will update.
>=20
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#include "irq-ast2700.h"
>=20
> Missing newline
Will update
>=20
> > +#define INT_NUM 480
> > +#define INTM_NUM 50
> > +#define SWINT_NUM 16
> > +
> > +#define INTM_BASE (INT_NUM)
> > +#define SWINT_BASE (INT_NUM + INTM_NUM) #define INT0_NUM
> (INT_NUM +
> > +INTM_NUM + SWINT_NUM)
> > +
> > +#define GIC_P2P_SPI_END 128
> > +
> > +#define INTC0_SWINT_IER 0x10
> > +#define INTC0_SWINT_ISR 0x14
> > +#define INTC0_INTBANKX_IER 0x1000
> > +#define INTC0_INTBANK_GROUPS 11
> > +#define INTC0_INTBANKS_PER_GRP 3
> > +#define INTC0_INTMX_IER 0x1b00
> > +#define INTC0_INTMX_ISR 0x1b04
> > +#define INTC0_INTM_BANK_NUM 3
> > +#define INTM_IRQS_PER_BANK 10
>=20
> If you make these defines tabular and they become readable:

Will update
>=20
> #define INT_NUM			480
> #define INTM_NUM		50
> ...
> #define INTM_BASE 		(INT_NUM)
> ...
> #define GIC_P2P_SPI_END		128
> ...
> #define INTC0_SWINT_IER		0x10
>=20
> See?
Sorry, do you mean tab?=20
If yes, I will update all with tab

#define INT_NUM         480
#define INTM_NUM        50
#define SWINT_NUM       16

#define INTM_BASE       (INT_NUM)
#define SWINT_BASE      (INT_NUM + INTM_NUM)
#define INT0_NUM        (INT_NUM + INTM_NUM + SWINT_NUM)

#define GIC_P2P_SPI_END         128

#define INTC0_SWINT_IER         0x10
#define INTC0_SWINT_ISR         0x14
#define INTC0_INTBANKX_IER      0x1000
#define INTC0_INTBANK_GROUPS    11
#define INTC0_INTBANKS_PER_GRP  3
#define INTC0_INTMX_IER         0x1b00
#define INTC0_INTMX_ISR         0x1b04
#define INTC0_INTM_BANK_NUM     3
#define INTM_IRQS_PER_BANK      10

>=20
> > +struct aspeed_intc0 {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	raw_spinlock_t intc_lock;
> > +	struct irq_domain *local;
> > +	struct device_node *parent;
> > +	struct aspeed_intc_interrupt_ranges ranges; };
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct=
-de
> clarations-and-initializers
>=20
> I pointed you to that documentation before. Do I really have to remind yo=
u
> every couple of week?
Sorry, my fault, will update.
>=20
> > +
> > +static void aspeed_swint_irq_mask(struct irq_data *data) {
> > +	struct aspeed_intc0 *intc0 =3D irq_data_get_irq_chip_data(data);
> > +	int bit =3D data->hwirq - SWINT_BASE;
> > +	unsigned int mask;
> > +
> > +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
>=20
> s/_irqsave// Interrupts are disabled when this is invoked.
Sorry, do you mean when this function been call.
Ther have desc->lock to do the raw_spin_lock_irqsave.
Am I right?

>=20
> > +	mask =3D readl(intc0->base + INTC0_SWINT_IER) & ~BIT(bit);
> > +	writel(mask, intc0->base + INTC0_SWINT_IER);
> > +	irq_chip_mask_parent(data);
> > +}
> > +
> > +static void aspeed_swint_irq_unmask(struct irq_data *data) {
> > +	struct aspeed_intc0 *intc0 =3D irq_data_get_irq_chip_data(data);
> > +	int bit =3D data->hwirq - SWINT_BASE;
> > +	unsigned int unmask;
> > +
> > +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
> > +	unmask =3D readl(intc0->base + INTC0_SWINT_IER) | BIT(bit);
>=20
> These unmask/mask variable are simply not helpful. What's wrong with
> naming them 'ier' because that's what this is about. And while at it the =
data
> type for hardware related variables is u32 not unsigned int to make it cl=
ear.
>=20
Thanks, Will use
u32 ier;

> > +static struct irq_chip aspeed_swint_chip =3D {
> > +	.name =3D "ast2700-swint",
> > +	.irq_eoi =3D aspeed_swint_irq_eoi,
> > +	.irq_mask =3D aspeed_swint_irq_mask,
> > +	.irq_unmask =3D aspeed_swint_irq_unmask,
> > +	.irq_set_affinity =3D irq_chip_set_affinity_parent,
> > +	.flags =3D IRQCHIP_SET_TYPE_MASKED,
>=20
> See above
All those will review it again. Thanks.=20
>=20
> > +
> > +#define INTC0_IN_NUM 480
> > +#define INTC0_ROUTE_NUM 5
>=20
> Those should be at the top of the file next to the other constants.
Will update.

>=20
> > +static const aspeed_intc_output_t aspeed_intc0_routes[INTC0_IN_NUM /
> 32][INTC0_ROUTE_NUM] =3D {
> > +	[0] =3D {
> > +		[0b000] =3D 0,
> > +		[0b001] =3D 256,
> > +		[0b010] =3D 426,
> > +		[0b011] =3D AST2700_INTC_INVALID_ROUTE,
> > +		[0b100] =3D AST2700_INTC_INVALID_ROUTE,
>=20
> Seriously? What's the point of this binary notation and the insane amount=
 of
> space this table occupies?
>=20
> 	[0] =3D {   0, 256, 426, AST2700_INTC_INVALID_ROUTE,
> AST2700_INTC_INVALID_ROUTE },
> 	[1] =3D {  32, 288, 458, AST2700_INTC_INVALID_ROUTE,
> AST2700_INTC_INVALID_ROUTE },
> 	[4] =3D { 128, 384, 554, 160, 176 },
>         ...
>=20
Thanks, will update.
>=20
> > +
> > +#define INTC0_INTM_NUM 50
> > +
> > +static const aspeed_intc_output_t
> > +	aspeed_intc0_intm_routes[INTC0_INTM_NUM / 10] =3D {
>=20
> pointless line break
>=20
> > +		[0] =3D 192, /* INTM00 ~ INTM09 */
> > +		[1] =3D 416, /* INTM10 ~ INTM19 */
> > +		[2] =3D 586, /* INTM20 ~ INTM29 */
> > +		[3] =3D 208, /* INTM30 ~ INTM39 */
> > +		[4] =3D 224, /* INTM40 ~ INTM49 */
> > +	};
> > +
> > +static bool range_contains_element(u32 start, u32 count, u32 value)
>=20
> in_range32() provides that already
Will update.

>=20
> > +{
> > +	if (WARN_ON_ONCE((U32_MAX - count) < start))
> > +		return false;
> > +
> > +	return value >=3D start && value < start + count; }
> > +
> > +static int
> > +resolve_input_from_child_ranges(const struct aspeed_intc0 *intc0,
> > +				const struct aspeed_intc_interrupt_range *range,
> > +				u32 outpin, u32 *input)
> > +{
> > +	u32 offset;
> > +	u32 base;
>=20
> One line
Will update
>=20
> > +
> > +	if (!range_contains_element(range->start, range->count, outpin))
> > +		return -ENOENT;
> > +
> > +	if (range->upstream.param_count =3D=3D 0)
> > +		return -EINVAL;
> > +
> > +	base =3D range->upstream.param[0];
> > +	offset =3D outpin - range->start;
> > +	if ((U32_MAX - offset) < base) {
>=20
>         if (!in_range32(...)
Will update
	if (offset && !in_range32(base, 0, U32_MAX - offset + 1)) {
>=20
>=20
> > +		dev_warn(intc0->dev,
> > +			 "%s: Arithmetic overflow for input derivation: %u + %u\n",
>=20
> Pointless line break. Please fix them all over the place.
Will update
		dev_warn(intc0->dev, "%s: Arithmetic overflow for input derivation: %u + =
%u\n",
			 __func__, base, offset);

>=20
> > +			 __func__, base, offset);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*input =3D base + offset;
> > +	return 0;
> > +static int resolve_parent_route_for_input(const struct aspeed_intc0 *i=
ntc0,
> > +					  const struct fwnode_handle *parent, u32 input,
> > +					  struct aspeed_intc_interrupt_range *resolved) {
> > +	aspeed_intc_output_t c0o;
> > +	int rc =3D -ENOENT;
> > +
> > +	if (input < INT_NUM) {
> > +		bool found;
> > +
> > +		dev_dbg(intc0->dev, "%s: Resolving parent route for linear input
> %u\n",
> > +			__func__, input);
>=20
> Do you really still need all those debug prints or are you trusting your =
code by
> now?
>=20
> If they still are considered valuable then shorten them in a sensible way=
 so they
> nicely hide in the code instead of cluttering it to the point of making i=
t
> unreadable.

Will try to remove dev_dbg.
>=20
> > +{
> > +	struct aspeed_intc0 *intc0;
> > +	struct fwnode_handle *parent_fwnode;
> > +	int ret;
>=20
> See Documentation about variable declarations...

Will update
	struct fwnode_handle *parent_fwnode;
	struct aspeed_intc0 *intc0;
	int ret;

>=20
> > +	for (size_t i =3D 0; i < nc1outs; i++) {
> > +		aspeed_intc_output_t c1o =3D c1outs[i];
> > +
> > +		if (c1o =3D=3D AST2700_INTC_INVALID_ROUTE) {
> > +			dev_dbg(intc0->dev, "%s: Invalid output at route index %zu\n",
> > +				__func__, i);
> > +			continue;
> > +		}
> > +
> > +		dev_dbg(intc0->dev, "%s: Have output %u for route index %zu\n",
> > +			__func__, c1o, i);
> > +
> > +		for (size_t j =3D 0; j < nc1ranges; j++) {
> > +			struct aspeed_intc_interrupt_range c1r =3D c1ranges[j];
> > +			u32 input;
> > +
> > +			dev_dbg(intc0->dev,
> > +				"%s: Inspecting candidate range %zu starting at %u for
> %u\n",
> > +				__func__, j, c1r.start, c1r.count);
> > +
> > +			/*
> > +			 * Range match for intc1 output pin
> > +			 *
> > +			 * Assume a failed match is still a match for the purpose of
> testing,
> > +			 * saves a bunch of mess in the test fixtures
> > +			 */
> > +			if (!(c0domain =3D=3D irq_find_matching_fwspec(&c1r.upstream,
> > +								   c0domain->bus_token) ||
> > +			      IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST))) {
> > +				dev_dbg(intc0->dev, "%s: Parent mismatch for candidate
> range %zu\n",
> > +					__func__, j);
> > +				continue;
> > +			}
> > +
> > +			ret =3D resolve_input_from_child_ranges(intc0, &c1r, c1o, &input);
> > +			if (ret) {
> > +				if (ret =3D=3D -ENOENT)
> > +					dev_dbg(intc0->dev,
> > +						"%s: Output %u not in candidate range %zu
> starting at %u for %u\n",
> > +						__func__, c1o, j, c1r.start, c1r.count);
> > +				continue;
>=20
> All of this is unreadable and I told you about the bracket rules before, =
no?

Will remove dev_dbg with following
			ret =3D resolve_input_from_child_ranges(intc0, &c1r, c1o, &input);
			if (ret)
				continue;

>=20
> > +			}
> > +			dev_dbg(intc0->dev,
> > +				"%s: Resolved INTC0 input to %u using candidate range %zu:
> [%u, %u)\n",
> > +				__func__, input, j, c1r.start, c1r.start + c1r.count);
> > +
> > +			/*
> > +			 * INTC1 should never request routes for peripheral interrupt
> sources
> > +			 * directly attached to INTC0.
> > +			 */
> > +			if (input < GIC_P2P_SPI_END) {
> > +				dev_dbg(intc0->dev,
> > +					"%s: Invalid range specification at index %zu routed
> INTC1 output to unreachable INTC0 input\n",
> > +					__func__, j);
> > +				continue;
> > +			}
> > +
> > +			ret =3D resolve_parent_route_for_input(intc0, parent_fwnode,
> input, NULL);
> > +			if (ret < 0)
> > +				continue;
> > +
> > +			/* Route resolution succeeded */
> > +			resolved->start =3D c1o;
> > +			resolved->count =3D 1;
> > +			resolved->upstream =3D c1r.upstream;
> > +			resolved->upstream.param[0] =3D input;
> > +			dev_dbg(intc0->dev,
> > +				"%s: Route resolution selected INTC1 output %u via index
> %zu\n",
> > +				__func__, c1o, i);
> > +			/* Cast protected by prior test against nc1outs */
> > +			return (int)i;
> > +		}
> > +	}
> > +
> > +	ret =3D -EHOSTUNREACH;
> > +	return ret;
>=20
> Impressive.
Will try to improve this function.=20

>=20
> > +}
> > +EXPORT_SYMBOL_GPL(aspeed_intc0_resolve_route);
>=20
> What is this export for? All usage sites are built in, no?
Will remove this.

>=20
> > +static int aspeed_intc0_irq_domain_map(struct irq_domain *domain,
> > +				       unsigned int irq, irq_hw_number_t hwirq) {
> > +	if (hwirq < GIC_P2P_SPI_END)
> > +		irq_set_chip_and_handler(irq, &linear_intr_irq_chip,
> > +					 handle_level_irq);
>=20
> Make this one line. Otherwise you need brackets.
Will update all
	if (hwirq < GIC_P2P_SPI_END)
		irq_set_chip_and_handler(irq, &linear_intr_irq_chip, handle_level_irq);
	else if (hwirq < INTM_BASE)
		return -EINVAL;
	else if (hwirq < SWINT_BASE)
		irq_set_chip_and_handler(irq, &aspeed_intm_chip, handle_level_irq);
	else if (hwirq < INT0_NUM)
		irq_set_chip_and_handler(irq, &aspeed_swint_chip, handle_level_irq);
	else
		return -EINVAL;
>=20
> > +	else if (hwirq < INTM_BASE)
> > +		return -EINVAL;
> > +	else if (hwirq < SWINT_BASE)
> > +		irq_set_chip_and_handler(irq, &aspeed_intm_chip,
> > +					 handle_level_irq);
> > +	else if (hwirq < INT0_NUM)
> > +		irq_set_chip_and_handler(irq, &aspeed_swint_chip,
> > +					 handle_level_irq);
> > +	else
> > +		return -EINVAL;
> > +
> > +	irq_set_chip_data(irq, domain->host_data);
> > +	return 0;
> > +}
>=20
> > +static int aspeed_intc0_irq_domain_activate(struct irq_domain *domain,
> > +					    struct irq_data *data, bool reserve) {
> > +	struct aspeed_intc0 *intc0 =3D irq_data_get_irq_chip_data(data);
> > +
> > +	if (data->hwirq < INT_NUM) {
> > +		int bank =3D data->hwirq / 32;
> > +		int bit =3D data->hwirq % 32;
> > +		u32 mask =3D BIT(bit);
> > +		int route;
> > +
> > +		route =3D resolve_parent_route_for_input(intc0,
> > +						       intc0->local->parent->fwnode,
> > +						       data->hwirq, NULL);
> > +		if (route < 0)
> > +			return route;
> > +
> > +		guard(raw_spinlock_irqsave)(&intc0->intc_lock);
> > +		for (int i =3D 0; i < 3; i++) {
> > +			void __iomem *sel =3D intc0->base + 0x200 + bank * 4 + 0x100 *
> i;
>=20
> Magic constants 0x200 4 and 0x100. Use proper defines and a macro/inline =
to
> calculate the register address and not this incomprehensible garbage.

Will update with #define
>=20
> > +			u32 reg =3D readl(sel);
> > +
> > +			if (route & BIT(i))
> > +				reg |=3D mask;
> > +			else
> > +				reg &=3D ~mask;
> > +
> > +			writel(reg, sel);
> > +			if (readl(sel) !=3D reg)
> > +				return -EACCES;
> > +		}
> > +	} else if (data->hwirq < INT0_NUM) {
> > +		return 0;
> > +	} else {
> > +		return -EINVAL;
> > +	}
>=20
> If you rearrange those conditions you can avoid the indentation all toget=
her
>=20
>         if (in_range32(data->hwirq, INTM_BASE, INTM_NUM +
> SWINT_NUM))
>         	return 0;
>         if (data->hwirq >=3D INT_NUM)
>         	return -EINVAL;
>=20
> No?
Got it will update

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static void aspeed_intc0_disable_intbank(struct aspeed_intc0 *intc0)
> > +{
> > +	int i, j;
> > +
> > +	for (i =3D 0; i < INTC0_INTBANK_GROUPS; i++) {
> > +		for (j =3D 0; j < INTC0_INTBANKS_PER_GRP; j++) {
>=20
> Both i and j should be declared in the for () statement. Your coding styl=
e is so
> inconsistent it's not even funny anymore.
Will update.
>=20
> > +			u32 base =3D INTC0_INTBANKX_IER + (0x100 * i) + (0x10 * j);
> > +
> > +			writel(0, intc0->base + base);
> > +		}
> > +	}
> > +}
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc0)
> > +IRQCHIP_MATCH("aspeed,ast2700-intc0-ic", aspeed_intc0_ic_probe)
> > +IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc0)
> > +
> > +#ifdef CONFIG_ASPEED_AST2700_INTC_TEST #include
> > +"irq-ast2700-intc0-test.c"
> > +#endif
>=20
> Yikes. What's wrong with Makefile?

Will remove it.=20
And add it in Makefile
obj-$(CONFIG_ASPEED_AST2700_INTC_TEST)	+=3D irq-ast2700-intc0-test.o
>=20
> > diff --git a/drivers/irqchip/irq-ast2700-intc1.c
> > b/drivers/irqchip/irq-ast2700-intc1.c
> > +static void aspeed_intc1_ic_irq_handler(struct irq_desc *desc) {
> > +	struct aspeed_intc1 *intc1 =3D irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long bit, status;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	for (int bank =3D 0; bank < INTC1_BANK_NUM; bank++) {
> > +		status =3D readl(intc1->base + INTC1_ISR + (0x10 * bank));
> > +		if (!status)
> > +			continue;
> > +
> > +		for_each_set_bit(bit, &status, INTC1_IRQS_PER_BANK) {
> > +			generic_handle_domain_irq(intc1->local,
> > +						  (bank * INTC1_IRQS_PER_BANK) +
> > +							  bit);
> > +			writel(BIT(bit),
> > +			       intc1->base + INTC1_ISR + (0x10 * bank));
>=20
> My eyes bleed by now.
I will modify the some input in intc1.c=20

Thanks your review.
>=20
> Thanks,
>=20
>         tglx

