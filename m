Return-Path: <linux-aspeed+bounces-3705-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27F5F33818
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 08:44:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZlql2B87z2yjm;
	Tue, 17 Mar 2026 19:44:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773737043;
	cv=pass; b=gcejznqQf+AD8K6fL0IC8jd/tF5Iv0QYy18VkJ06nKWJAOp/zCGo7L5QZ6HNXxFelG78kS7kJWVAByGAlyArvLLm8aHHT73yW3XvnGNBqx/ilSKpc3Y7efgwQ4q3+0UvFnO92CEa4yw8jqID6KiPy+gZ92Jtk0gRGd9y6x5qxa0OzqNFPvU67OHc+FJ7F0opbJ/7a+gp44X7mI96J/VTb7fYp/F0AH5TL+KajM1a/U7lDv7FgYY5OUYOupl73ODK8J+BrF+c75VQ/sz1tpe8AXRK/EN9KrynbT6NBTOxqRTDTBV4deCfCP7lIoYBX1oILSaE6dBkM8t8FkJ2GDkX3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773737043; c=relaxed/relaxed;
	bh=xs3/Yx8NcuaGMuhGpdm4akL6StNLgCGa2F/v03oEkY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWJz4LuYZng+eLQ3+iVIrXoIBC5TyH28FA5xJZbnuIk65GXIe4kbDUWdNtEntRQTiONFoZc0jCRhRONx1eXhSrM/Qmj2EXjsPZg1Op5FNBNcw0z7PS9YV9zmbZ/qPAWuY8U5Fh0/37cL4+m6lr14Wiig+xV3IFsToIz7o4cn2G5bmAn+SfI80ih5E5x1bPnGmeucIMVBq9DT+tDH+yVCoU8JrtWzSd5zEA/N0uyjSRQmuUrBCa5+d0r+G0Q2MWsBwFkaCvSlZqpdwIRnoPSmMuc4mV2NLS2qc6MrhjkiL81qwKLSIArev0iNn83dlmfVELSvPiPkgR5UCuJ7sqrUEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=XXSGkJCG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=XXSGkJCG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZlqk3sfLz2yjN;
	Tue, 17 Mar 2026 19:44:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOcqd9t+xfqfZy2d/U17UPlTAoDlBjXKDFn/TITcL6RnzrMn5jgeZ2/OEG6TWD32Ws8gzoFSMLjiDdKHBofNhq28tcNbPhtHv0ybPfwByPEQBjMCCpx3lVRSlNZnbV2DKMrTqXQWbPuEIBJfVAjlpBjHgaaCqOjL5y8GwNbG1ycKgPaxDfBZn0Dss7PPLyVKTCT1+YgJ8CU5J6G2jWd0uxQ2YLKjtjG3uaqjt6y0PZp5MQiS85bduMzrs4KfLxhQ+y6L3fic6tUvxZ/fptSyA2gLiqzGiZGBu82z2IjoDpDE5SUjjYTpMPxo6rKt2JWSo/9WAtl+uE8VUytWMqlbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs3/Yx8NcuaGMuhGpdm4akL6StNLgCGa2F/v03oEkY8=;
 b=iCiLcYAnkXZHQj7X7BCsZsFx6w0oVHqmczbp+biVjSgkSV/VQMtz5RHSsjLJMOtvxmPN9q+pgj27OjiE5+kvT3cpH7I5XhJHFG8CYmOmPoraBh6AYwFG4EZp6vb8Di/QsW0iulQfv6dhJn7x9xoUNzvArJQprRwey0G2skGtuWoY4m9xE1vww5yT7GwUaUXBdeoZwLTI9BoMX+BAlCVRPQCOwbZGm7Xt+6pROH7KChtKNd7gvbMhGtNX7Z6laqPV5sp0Fjb/WH4LQnPTATxUMU3N1A0w3naB5B8kWL631oyi3/lGxqlA/Ocr2XD5IuGHpPt151EeI5Vcg/FjUsd4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs3/Yx8NcuaGMuhGpdm4akL6StNLgCGa2F/v03oEkY8=;
 b=XXSGkJCGTDo6+XXv+svh6FCFuwwDPSnBBVkaBXBWq67svLVQ5Ia0c84h7OWzIrln8KiqnMoRcBcSSlBpJcuT4Sblp8e25yral7ChFJeXIgLLFuGGhmcyJJnyCof4VK7jEM5WbQKdKoG1br/3DuE9VCAwqy3/yOk6b381VVRMAZcmUTk65RDhb/1cWWNgdD2QoBm1ZXXfBU8RN8T7Hwvm5nTKD7y0nfKGdK7VhPEuKPkkUnaF/Si1mSarXTXYH/aujcdEkONcKFCpsq3bM3bEZkzdXtN8ewAZBUAEQ08+j/SdwW+hf892D3wjI7lCrolPBx7SbHk8FuCVu3jaE62rKQ==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by PUZPR06MB5819.apcprd06.prod.outlook.com
 (2603:1096:301:f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 08:43:33 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 08:43:33 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>
Subject: RE: [PATCH 1/7] dt-bindings: soc: aspeed: Add AST2600 eSPI controller
Thread-Topic: [PATCH 1/7] dt-bindings: soc: aspeed: Add AST2600 eSPI
 controller
Thread-Index: AQHcstFOhnecqp+8vEODwE67uQSGWLWwwXmAgAAQs4CAADF7gIABaq+w
Date: Tue, 17 Mar 2026 08:43:33 +0000
Message-ID:
 <KL1PR0601MB42761246E4C7AA6797ECEC519041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-upstream_espi-v1-1-9504428e1f43@aspeedtech.com>
 <3f2d964a-4e82-414c-b373-af0d531b0fcd@kernel.org>
 <KL1PR0601MB4276A4B81C2E2DB02BE8F2059040A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <20260316-moustache-sleep-0a355de2fc8e@spud>
In-Reply-To: <20260316-moustache-sleep-0a355de2fc8e@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|PUZPR06MB5819:EE_
x-ms-office365-filtering-correlation-id: 4103a403-b1d3-404f-9abe-08de840145ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|42112799006|376014|7416014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 MJqgP4yue1no8oP3RZyD78/gJoZlqU5NVhDpLlB+FMD2e1UgUWu7GFKO4tTjtOsg7mXyIMQSHQTlmGUcrDPFHnG0BWCBBcMpyZGQEXM4sGY0BJWGdAcgrZYIPyalORcRjLS81j3G9clu4loMPy9UbRyaJXhrWo6rz2k9P82EogWUu+e3OpCFUkHuGfS5K63zMJQ7tbbdNuZYv5EubDNspptqviUOjEyFvEcXjMeq6lx9fQaKf9f/K6W3eUxOjRHqi3JI3LL/h+moZKWXgqpk6/qeAsajjATM8rGZ7ui0z/sLqEFkcuLqB4K569kg8JVgNwCIsZKq4csbhvoCm8GYlBQfVSjqYr1ixpVmCGeYRIn1JBFtrtDNiiQeS1mEt9PZ7vOgWQzGuAIiy5PAKv+emwD9VgF1K2zShOgwX17cN+S1k2XYYP1ASIwgGRiiLqDn566TcluEKkEMKxPFwROAVydmXBJED2VMulfBCna/to4GTosIV5BEgahBWjU1xJD3sI/S0Yd/3Bxasl1yU6X2i0ByjK45R0kvoeYEfxoq83S7QMJx6Yo+OJDGfnhoF7x+hp8vOkm8LdMI/PkhG+vdjDEyjZJzdpKnEQscXixMW8jaDKdn8IamPfDGFO1eEv0WUUxrIaTrAU//fSCfeDjZaHb0UzBhzPoXgQ4DlhvcZznd+eMGymnfZSjbclDmT8wiHuCHdMVGckMFY1lLDOTePvCob9iwKqemySkMXKBNC0SjObEfxaxS14bzztGEFnSLlLlMkcHS380nP5/imPhvK3PL1UU+84pchyeqjJJKik0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dxOi+YqqVKK8pGb/ZpbgDmpxDnNu8igbqt5YWoYXnpWh8E9VCR9mus6Iu9pY?=
 =?us-ascii?Q?MnhqqNI5qWcFFL9cbQwQxQ2/phIMLOQMBZIqA4+b/x9YeS4HJTZKIA9scBO/?=
 =?us-ascii?Q?WLGrtFRXoeAxuxkxPxPT9eP+yVqDL0JU9hD4cXM4/gLcZcLQB6d2C7Jb8OC5?=
 =?us-ascii?Q?xw91PK7u8g/IpnKYmTlW977ZHZcHa+CZUff+WUqI7GQ7yCgurhQEyGEz+EeA?=
 =?us-ascii?Q?XQV/XWWsvNOBAnDwDI8Kdv2Lvbrx5zUxs/mTb1S2A51b+672jF44wtKR5Pq0?=
 =?us-ascii?Q?fe/TAm/D4PVclcQYVECuYEAZNPgdmBtDkHkBBHYG/KgipYCLXpjOsEghouUI?=
 =?us-ascii?Q?1d/hU/UUHSdgghxSdzo5MHthA1IJxMtgERPbUrdMm+ZyARedYPhX9VBemCJ5?=
 =?us-ascii?Q?0NdervSO0bcU6fylqKXSDchKzYPzJeIc58YuVTvLNzACCY92YMI6lInrQu1s?=
 =?us-ascii?Q?8j166W4WZ9Bvc7TOBcKBnSOcJ5EYYFi+hkv/XZQC1AugpWjv+NM1tSEecq3X?=
 =?us-ascii?Q?InwlnW+sVUCzXJkm+k01E6yQDfux4EKGrEHEMcL7TRV/Jg5nEJf4Kvp8ufZ0?=
 =?us-ascii?Q?/DD2tJBxY6q0tDi2fd3IadywaT1yycWmrdvx+Fxr2wBHrgYq8PFNcHV8xaxv?=
 =?us-ascii?Q?VnzbD9kc9lw0CiW7XR0ks5ditAX0DkmUpDYRoRhBB9vDHA8WduanfECB49lN?=
 =?us-ascii?Q?zIj3ajRSuL99LKOsDFOXfvjHVIBcgotAK5Od+9bNUUDAbTht4HJMIimK0kXK?=
 =?us-ascii?Q?W+91ETUiZ2awn0Eq6HH/GSkVi8iXtm8XXCd3DDh2QMA8COHH0yHVngIoCGK8?=
 =?us-ascii?Q?zpK0w/MxUTDQi3/Mf7V4kEGompdG03cEyAMpT+8xau6reF8I5ZlxZIp1pPwv?=
 =?us-ascii?Q?gn4Kmi+36TcTfnWwF0AAXhuP0xw/PP57VBG8r5g27CHxXxB97jvalmGHw7PN?=
 =?us-ascii?Q?gRB7T2sGlekU9kQOBRNpeHIh/7gQ190JDc50auecQNmZi0KrsFYzDg8l4CEY?=
 =?us-ascii?Q?gP467pL+P260vEMj2SnH+zo6risD2N0yBF9t/m0KHtoTHyA8vsFfkscczOYr?=
 =?us-ascii?Q?idnSTlrCE2bKfRFC5ETa+8CKRvcqEDYWd+GBeVHBL4dcKa2YVa+dzyrKiwHZ?=
 =?us-ascii?Q?+vr9h9gcWBxcqWNFDFjZE4WfFNkZ+hg2lCu1AcEO5OxETsettB6h4SMyKBu8?=
 =?us-ascii?Q?kcZpIqr+kXKxUgWV9jaWRAs3uRT/tFg8+wNToi+rNXqpAF/xxoonwZ4/uIFw?=
 =?us-ascii?Q?fTZI0IZmWANYiVrjs+Ch3BlPcXYk357AlXbI0ZsKMquDskN/Dta00qy4V8I1?=
 =?us-ascii?Q?pQY2egnwK/FHmOoOBqNtgmg2uH//HfKwpCAbE5QHqZfscpui/urck9affPuB?=
 =?us-ascii?Q?Yb7uSyTS4HrdWX+xfv9l5EMn7H3yVyAsqjOq/PBJiHAHFZUnEBs2XK1jzAOI?=
 =?us-ascii?Q?T7Tvm/GQQyj+cLlYQESwdl26Fp89N8RNe7jW7riq0S/P5Kw9XUGC6t2NcKVy?=
 =?us-ascii?Q?jPT3MoMw96fcsa07hJlL48ZENHYbtpGpnJDt55PgjPmWwVxDQHpHZIZ695dF?=
 =?us-ascii?Q?JkZdK6cJhw5Spdmw4CrvafaIDlPoM3ORCY1tKJnlfXK8mDlEK1LPm49Xnm9c?=
 =?us-ascii?Q?N2+Uolnir0ozNW91oU8c4hr26DIyQdU+fb3eU+NONVr22n7e0X6QbbTU2Epl?=
 =?us-ascii?Q?qs4eEU2XSYCVc1F05RenzCPqXcZOeRUONreSxBZvPjl9NRub3rSw5vSy97CS?=
 =?us-ascii?Q?6XG6SBWjHg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4103a403-b1d3-404f-9abe-08de840145ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 08:43:33.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2mSyJzh0iomS+XnfWT4RwRmz+s/zrxuVewuv3/zoJnt7x39/cjqklsWee5ZJT6iKpuQRhsHtNIKjVMJApGmYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819

Hi Conor,

>=20
> On Mon, Mar 16, 2026 at 08:17:48AM +0000, YH Chung wrote:
> > Hi Krzysztof,
> >
> > > On 13/03/2026 11:07, aspeedyh wrote:
> > > > Introduce the device-tree bindings for the Enhanced Serial
> > > > Peripheral Interface (eSPI) controller found on AST2600
> > > > BMC SoCs.
> > > >
> > > > The controller operates as the BMC-side eSPI slave and provides the
> > > > peripheral, virtual wire, out-of-band, and flash channels used for
> > > > host-BMC communication.
> > > >
> > > > Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> > >
> > > Please use your full name. Semi-anonymous contributions are not accep=
ted.
> > >
> > > Best regards,
> > > Krzysztof
> >
> > Thanks for the reminder.
> > Would you prefer that I resend this series with the corrected sign-off,=
 or would it
> be fine to update it in the next version?
>=20
> Next version, when the discussion on the cover letter concludes, please.

Got it, thanks for the guidance.

Thanks,
Yun Hsuan

