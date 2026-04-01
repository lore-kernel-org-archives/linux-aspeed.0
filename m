Return-Path: <linux-aspeed+bounces-3828-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6296D35144
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Apr 2026 06:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flwZm4TlMz2ySY;
	Wed, 01 Apr 2026 17:49:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775026176;
	cv=pass; b=V0kkUT6DpB8Zc3dU65RxMMP1TcRAMWMOxb4o/rq9cqkggRPY49lnKSAz/Sd13xiD1+CnvBoCK4/ADR8Ia1igELzCcLeRbjn3X4F1ltjcP2Y8BSxnEsg6WgRlYgd+HB4E2d3H2a8RZLkaF8oUzmCbg2raqnBJxGDkCmg0RD291y6cpmkfdIaHlKjNkfD8vXJgB9KaZH7Qb7dH9qYEAX7VtrLlOc1I3YFrqqb5Yt6yraHj/mq2KwNKaa3phV5jb8kCc1Ejx7cVVCMIbakMhbTdkCuSwUTRqPtwraevViyzzIctxZuT8dp0iHJDfoqbyb7uMAlRbiCVNmaRA/ST61IE4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775026176; c=relaxed/relaxed;
	bh=xQTlYkJZaYLeHb4AmYalAOb+yzs7ZwgWqRVABUJbPxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIka/b+3onx7OCKNxGclbb0iWkrJKV/uUJMLV7n5eKbq8nANJXNo7Ue2pLHvhn35xpIvJ+iJKUd7mJKcGusU4jOMU/6yWItbXHm33a5CfjtLGVcmZmESeV+qLTE8gENAK4M4FvVccts0j9n2sJs1Vf4mWYJ/TmnasKxlgg1fM7x3ukyd2XKzmYeMMsoIPj4BHQSApUE4iXjtVjAFoEguuyZo0OrlGpuqScsQ2TpzqU5xZROurCTG2FH+Eh8Bb/1n5LxJnXb6OxMnfeTADx4o8hzYDLAb0P3UsduTDj6YfqvWl4nVhkymwEaSJNDAOaFkTdLNB3g6He5qbCPnueSQJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=M5roU7bE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=M5roU7bE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flwZk5H7bz2xb3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 17:49:34 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtxWMcYKqUIC5mlvTaftWc2Dj9QmpRzzJZfETOp6jExW4+dCRYt0je90Id7aItSElvJlC0kGattPOIqsOBorz31wK4GRSAU8oHHhzQtrulvU+qFzC5kdlZILvBi65tGFCeleAWulp2oLdvxZQU71B6XFnaa7pOYk0x2axFectPHe8kW975YXdoPI8h8nlghvhcdy5vSqe1VC7NwL5j4F0cc8WbtdSnu5DwPdasD1t7wsMrHN/d9sOBmERMpobLT9Ev3gCkAXfZHZKHMfofSWab1ZzVm/w61W406qoCIcUbk22AjlIVLjgQTPUzGqCYiED0Mzw9+AtpYl/AaW+1BAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQTlYkJZaYLeHb4AmYalAOb+yzs7ZwgWqRVABUJbPxM=;
 b=h85bJ6lnkiWkQ9BWFTG0hr+DBaHGpN9ZZ90TWMxLkpZrQwxG2hT+LMtfAF2M8Jk869+6BIETl90/T2R27+7lZr/4nMZ/kspWQUeeIiwe0/D8zCuyZV9wqvaqBwYQgAzc+mfm4BD3SBILk6KwU+HcS5rK0bJ36puao/1mHGbIy08717apAEGlyjeVSze7HTVP6D9RbIZypCdrUHiPuHzIRKYPCVoXU59c5e3K9mCYJrsb+YnLboG2bPhTp6cWClkYfwM+IMrWQCgnGLUTIVLayZZAXaupeUJBqW6JiIl+9TOoEqiFmU8+TQ6TDdXkVz8Ae6G0ANMwTM5ETPFw+TtGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQTlYkJZaYLeHb4AmYalAOb+yzs7ZwgWqRVABUJbPxM=;
 b=M5roU7bEjGUFPiJ04Is3WtRMhneAqPHVsV7oRRqdXmusKVBYQvKHtRI8kagYEUZwxM3gD8kkYWYJXbDJDVSr2kK6J9bEIWcuM7XaxeBfgSzGbua+yP38va90byeVuNpFvA1WluT7sniwmh8eFjh4U/FCDvmgiFlc3KOky+nkbL+YXlF1LpUMC83KfeM4xwHEQhxGwonxv6o7Y2lDwzBPBiuZZ01RB/xYAVo6uzihl4CxnIbcjZTgsPJuQ09dL/+beTRCF7N0xySYlbARlHsrCEzmBVJBdN4vSHhlWUeakj1WLtf/w5e1uoillP+nSuXDkZfigbqO9M8D8C/1xrTeOA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SG2PR06MB5132.apcprd06.prod.outlook.com (2603:1096:4:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 06:49:07 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 06:49:07 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: RE: [PATCH v4 2/4] irqchip/ast2700-intc: Add AST2700-A2 support
Thread-Topic: [PATCH v4 2/4] irqchip/ast2700-intc: Add AST2700-A2 support
Thread-Index: AQHcwA70j6k3wISIzESYyH2Wyy5HoLXI0ZEAgADmGgA=
Date: Wed, 1 Apr 2026 06:49:07 +0000
Message-ID:
 <TY2PPF5CB9A1BE6EE88A7A906E10D1F10E4F250A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-irqchip-v4-0-3c0f1620cc06@aspeedtech.com>
 <20260330-irqchip-v4-2-3c0f1620cc06@aspeedtech.com> <87tstw7zfj.ffs@tglx>
In-Reply-To: <87tstw7zfj.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SG2PR06MB5132:EE_
x-ms-office365-filtering-correlation-id: a931d9e8-2217-4dd8-12d3-08de8fbac58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 B4VCJg7Hkm7p4f6lxAv89j6RE3jvXiBVUJ/Z83SmjmKAxsX/cjMDK1suoa31hDbY7+v/5xBSBD7X5p5oYpQEgHn2llp3GCSVg9KDS0RSvJyaO/8Wr7Krjo5Z2ZjaFElS76Pti1NmP9M4djOKNnpcip2i2jPBppudPHGNd8ktXcG1P3d/q86vOT3w8q6x8TiSZ9veKX6CT4KRz3zSCjHEicMGsi0F3dNmQHttrMeX1vQjOcqgwgMLuCA0X9jqky4spoi5258oYdifNnhYNXUdf/WHaJXPReyMeo4FjXvVM8tkhGzttWh1T9o3KSLQw5LEpakQ46+Bt2twnpZTNWu69zKJZ94RU64Rh6h0Do6psmBSC9Cf0W2eRWRXuMg+pO3+I6kOSdhSqj3D0wyM8a/+ITIOCe41PIYpkhzAYNGeBu/OaPoMxtI/wp1pELYO3KUYSPc1aqrQ6ZsR7R8m4jMMNuQJseVjlAnWRBzBugsdHO3gZiwNjJ/rLy7T1GgfzlzBbaT+oNSqgSSR4bkIUlOp+MEQ2idDWE3uMEIKRqc3TkGyv8X7EjNKVhKuxmc08nClPBU7hUj3VGuiyXplTAcN8ovtOxTftpJNPmyXpaLbYV7y9vKTkFT1HuW9UZ8Vo7PVEkdlHjlibfv2leXyJJXLwROYfkwEh0Xe628i1YStpYV4WGdcLIboXqSKV/czck77tp4QDGhIUastQgdngPOcEB9aznun0sjkqzwQiXeru4l3Ktz5+2Zl7y8Tf0uBL3QoQ6/u1xNVIE5jzGC/zVH8RtRFlsbD5LOzTYmzbcHxPhh98ovCn6NxN7oy4OgjODj+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uQw0OYhVY7JxGZHW+C+O8QWfA3nHYT/QxYNrIDdfrOUfEXjBVeT1x9yAMZ0C?=
 =?us-ascii?Q?P097/oVdpwwgAP9LilwTxd3XDSVPS++f/Jx687hUgRW+nMl/+BN6PLWWEGAM?=
 =?us-ascii?Q?2jHQmHjqy66ia7g86Bkb9H3CJ+eci6XEhncs6a/xPQmJg3mTS+6/Lh/f6tRC?=
 =?us-ascii?Q?uTnJpi26Rhwu9Ur4EnHRvvKUCbcjuN8U2Om02DdONBHjfx89rRhgKDyPMFRw?=
 =?us-ascii?Q?MSlSpGI087bdwXpMRuT2xJCH2dT1VOrnEwUxkOBHpH0GZ2mnMIs0J0qOgtvJ?=
 =?us-ascii?Q?/8plDT4GkOVLeZmnnZ7N3NxQ4YJHn8K23XPg1nGsqjgk4l6rSgULW4DR/ZW1?=
 =?us-ascii?Q?t7ban7IWGgn1uGxr8BjRfb/lTBdW+OuaQf3/Ykca3ZR+EjaLlNrSNCtEar+d?=
 =?us-ascii?Q?x+xW/8nPWwMcLk7A2xj1aKX+S54anMm/AAY1rhW6jEIlixS2hjEbWCMMdR1S?=
 =?us-ascii?Q?GX2BS6Lg3TLdKDyxK6BuWpc7TEdZ0Xuwac47aK0Kf5Jo6mS6IxtmNXEmRJyR?=
 =?us-ascii?Q?kG5/cbuOYAo1nxLyqnIlMdyzi8PEGaveg/Gi/zNXM1Y7kYVfQVdiAS5h3jmD?=
 =?us-ascii?Q?p+d9hHuFWkTgBiZMcallJt+H0jKPfOyycGZr+9LlcQTZxOrsqoYPRdcGMQch?=
 =?us-ascii?Q?EoMv5DdvCst/LmnNIMx/Z84O9+3OtPnrfL5+aU8T8NX175XN3aB3nfMPUl/3?=
 =?us-ascii?Q?T6dw9usIdRJPCGG99Xuvp0454fOVspHO03wmbyGEC3LaNvWkSDAdWMJA6lIC?=
 =?us-ascii?Q?zdwt7H1A8PTIIOoGu0k6HEfN+diU3EIUiaGW+7J7+sdKWdRZ5jO5G7NtnL0W?=
 =?us-ascii?Q?oL4DyN1l/LzioUz9qasXxDoCCA9awqGjm4RMupIobMN2LjhJuFxfufd/WHjs?=
 =?us-ascii?Q?2gt/3bzSN2E+FSJ1F2H2Uh0U8AUBK2RE0siooPRFgMX7EDj/QXS70H2AUAkh?=
 =?us-ascii?Q?0euklANDTHhZbpFGYrbSJ88mSM54MtikBR0ZUIyD0CrqvAIuJH9fMime/Xhm?=
 =?us-ascii?Q?BfIxD7Fj3CpQL/AYHEDJ5RIF8oqVWXG3w9TisoXq4Bqowr6o0qUJBQOmQlYB?=
 =?us-ascii?Q?988wsj2QwJQvZ85GElIuFCfQFbTEZrYjy+NZ6ndvoma+IXDQaXN7G4XOx6b8?=
 =?us-ascii?Q?C84K+EZYUR+ljCI0Rkw/t5rbpH5RmhWq69YbJ14G8euFseypyY6J4NTl6xx/?=
 =?us-ascii?Q?zKxDwkd5HF9rj4+8pIx0yGxJ8jMIOj6aFCeChI/hWxLUkq9JyR6pGVYKCTZz?=
 =?us-ascii?Q?k0Ky2ndF8w9Uf70zJ8DWnvTh68QwzKlztyt6rSLyvZvJjAYy4Ib+4Gm4ZRHF?=
 =?us-ascii?Q?ryeyrTctiOxI+7Vme+oc+xAYw+KlUIv8iKHvPmnLZA0K0V62lhe6kIVJ/pjj?=
 =?us-ascii?Q?wC40VCe0o4JShEDvMttrmL4R4XHUanQeHbuKV4vjwyrFRRfyjZ1E2Ay+kzGn?=
 =?us-ascii?Q?5lp9gvTcHgUIVu36o+UeftCvKIbhhYrnDMouW1l9CkDuz7NK/CagF6YUyTfn?=
 =?us-ascii?Q?YWCGa4Myqlz1oFR7VItagRbWVSGIELlzGl5fpr70NLmNXRGM7kL1j83MH7WB?=
 =?us-ascii?Q?CYlbf82fFGCiPYdpw/7YOb2kMvavRqIS9ywBRxV5o/Ip/jx/7EkyghKTkAbJ?=
 =?us-ascii?Q?jKwGls7eNm9RMBuKiE3Xc+q5S5JWHxit5DlR5EYf9La/YEkfdbXKpV8i5ja5?=
 =?us-ascii?Q?a9VCDLieTt9OOr32MTueVKt4dKdwJvdrDSCuXDMt4DkeXdIhsRNlJvy34ga9?=
 =?us-ascii?Q?L6k+EQyQqw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a931d9e8-2217-4dd8-12d3-08de8fbac58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 06:49:07.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mmj3jziaUr2A4Y84QMLrvf/IAQi7bxetXTLCE7ZZjTe4dpIfNi7W38ov5OPiRZMnZSPAz3da2mp4ysr5o4kSKKVO4j9okNGbXn3RO9XD4cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5132

> Subject: Re: [PATCH v4 2/4] irqchip/ast2700-intc: Add AST2700-A2 support
>=20
> On Mon, Mar 30 2026 at 14:32, Ryan Chen wrote:
> > +static int resolve_parent_range_for_output(const struct aspeed_intc0
> *intc0,
> > +					   const struct fwnode_handle *parent,
> > +					   u32 output,
> > +					   struct aspeed_intc_interrupt_range *resolved)
>=20
> Please reduce the number of line breaks. You still have 100 characters.
Will update
static int resolve_parent_range_for_output(const struct aspeed_intc0 *intc0=
,
					   const struct fwnode_handle *parent, u32 output,
					   struct aspeed_intc_interrupt_range *resolved)
>=20
> > +{
> > +	for (size_t i =3D 0; i < intc0->ranges.nranges; i++) {
> > +		struct aspeed_intc_interrupt_range range =3D
> > +			intc0->ranges.ranges[i];
>=20
> No line break required.
Will update
struct aspeed_intc_interrupt_range range =3D intc0->ranges.ranges[i];
>=20
> > +static int aspeed_intc1_irq_domain_activate(struct irq_domain *domain,
> > +					    struct irq_data *data, bool reserve) {
> > +	struct aspeed_intc1 *intc1 =3D irq_data_get_irq_chip_data(data);
> > +	struct aspeed_intc_interrupt_range resolved;
> > +	int rc, bank, bit;
> > +	u32 mask;
> > +
> > +	if (WARN_ON_ONCE((data->hwirq >> INTC1_ROUTE_SHIFT) >=3D
> ARRAY_SIZE(aspeed_intc1_routes)))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * outpin may be an error if the upstream is the BootMCU APLIC node, =
or
> > +	 * anything except a valid intc0 driver instance
> > +	 */
> > +	rc =3D aspeed_intc0_resolve_route(intc1->upstream, INTC1_ROUTE_NUM,
> > +					aspeed_intc1_routes[data->hwirq >>
> INTC1_ROUTE_SHIFT],
> > +					intc1->ranges.nranges,
> > +					intc1->ranges.ranges, &resolved);
>=20
> Please test your code with CONFIG_PROVE_LOCKING=3Dy, which is mandatory
> for submission according to documentation.
>=20
> This is invoked with the interrupt descriptor lock held and interrupts di=
sabled.
>=20
>        aspeed_intc0_resolve_route()
>                 ....
>                 irq_find_matching_fwspec()
>                 	mutex_lock(&irq_domain_mutex); <---- FAIL
>=20
Thank you point out the issue.

I plan to cache the irq_domain pointer in each aspeed_intc_interrupt_range=
=20
entry at populate time.=20

Add a domain field to struct aspeed_intc_interrupt_range in irq-ast2700.h
In aspeed_intc_populate_ranges() (irq-ast2700.c), call irq_find_matching_fw=
spec()=20
once per range entry and store the result in r->domain.=20
This runs in probe context, so taking irq_domain_mutex is safe.

In aspeed_intc0_resolve_route() (irq-ast2700-intc0.c), replace the=20
irq_find_matching_fwspec() call with a direct comparison against c1r.domain=
.

In aspeed_intc1_request_interrupts() (irq-ast2700-intc1.c),=20
likewise replace irq_find_matching_fwspec() with a comparison against r->do=
main.


