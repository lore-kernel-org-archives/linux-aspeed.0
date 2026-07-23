Return-Path: <linux-aspeed+bounces-4546-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71442C531C7
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 06:12:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5LPs6DBrz2xrL;
	Thu, 23 Jul 2026 16:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784787153;
	cv=pass; b=mMx/BeqDkabhbK2UZTSluUbbRbcnzfqSIllzZZCoEcY6EuqMQp2ZGLn/HC9tN7E8D6j5bsGy68apoHcK4aw0Y4UZvp7WOr7yLQnv+wOP2tytjQOd4u3P6YH38tBzCj+N0kYTvHG3lhO1L7UCpWwdCv/xHR/ujPjxR3ZkMqfL0CJ4/4lP+cERJuBjwBh0B0/k+64xlrMCLobWMdi9FgXmbAXNxXh2+tX+j5Y0GdD/ceyv6xoYthIzY82Y2rK9nkzjrLdRVaeg84gccT46JZN6rub4deY+XGnaHdpln15/tLOFN7SQ1jPRXVwGbw7zCRBBf487yht3hWOra2uNjVQiBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784787153; c=relaxed/relaxed;
	bh=py0PkpOVrtAFryFHHG6/VqvQSvx0m+zmCOHtGcv+wk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmw3vi5vBSOc1Lz27KNORFfErgdoqOE8PUyUx5S0oCu1pLf09pueVto5AmvyoypJSS+D0fdxA+9ueZac/jfrN1IGR9yMuqDFmPRJqA8pFakDj9yYHyYq/wilj66DDmeHrsErCKVAuggsZ5t74sn8KnTeh4Eanv/O/ScESreJF6N22zOC7AV9LQtP9O8yqQQ6aedd3WXIVGgMTU2lkz5I1+sQgjSuxDRBBNSZJcgIIpRAovbmYtT1sZlEjPWjeVkCfTpiFBxScqoBrnrfuC/lHd4L5My4yxHfT1qOB7YD3GjJQbhccT1roewY9Cis6/DOe9ucjXp0MEVPY+l3o8vJow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=U17m7+gm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=U17m7+gm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5LPr5Wqyz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 16:12:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P97PW39dOSMxpfQm6t+1BoZQD5XXTEw2A6wl5D1LXyTCaRdI0XweKt5TOy9+gvdfHHLvBNc+6hSwNesH90pqgVs9Z3CrCfl1nxbNOy6GDZ1ROzZkZ1nPl50pnkzMUE4HQWi2xvUkrkj8bubUxCr1ciohKH0izfIgPhkuHWrXvrDmlon5A25IMKaG0bfgJ8Gq0D4g5DkA2nVgeCVI3ItqybVgvRbw3pSa0DqQMndr7o4hxNsw/Y/iJDT1JVnhqNuRLqkKmgDHTFfCRhr5+Fwl+1Oz8qvbB+NeYtMbI+K0m2jx817f+U8ZsvuQpGNVxoqwYWxlMDCFiR4PwyZFUi+hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py0PkpOVrtAFryFHHG6/VqvQSvx0m+zmCOHtGcv+wk4=;
 b=ZyvmThyfpdxvcgKwCE1pbi1lMqGImQXVe8QqtskmBKKFXcZIDIGMJtl2sPLNUGZwtM+1Mv3yRgBLTcZ3f65oLcXmq16rvm7qw9o+kqIN2nQDBbkwiPlkYNndbbZblD44sKbBmSg2Cns322t53o0Wsm9W6WnK2LC7ZK6lylJ6qCI22864KszKpOoWcToy5oB5TwygXIwEhZ8Vaa8huGrSyxbbCmFHIsb4J7xSHGm6nOR81JdptsWpAmIt9CMDePhC7rmlTheAfFDoVuIxsaHkjsK5TKmRFxw6moGWMalJmkWGQhf3APHEDEl6RkH2j250wdcjrPMHudXdWhOPXwgwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py0PkpOVrtAFryFHHG6/VqvQSvx0m+zmCOHtGcv+wk4=;
 b=U17m7+gmcN97DyYptDcQTu/5RDM/aRqewIgDPfmoMxutBFf1fjxQxfW75VYjReaQlPhHmqQqmLJ6JHZ2h3zALm6mtB0LDSngmCZnrDnX+6ca6vnVS1NTF6gzqWQ58RvY+NOTSqKzOccxA+euKgc4VEceRA/T68KoMhGmiZF69C9AYzzSYSWYT5RHWcG3TH6Y3ZRTCp3vb6OshsxcaPvVoDKaRIn7bkDJpmAdWXPVe9TXYnsG4XfYQWHbrsgtP2KAZwLR86ENLGJZEdPacuF7riHtO/ACRdeKfG+0uBPoCw7WieVdR/Bdwts4U2khILLr3LdFcz34vFnLGXObgA5rDA==
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com (2603:1096:405:13::10)
 by JH0PR06MB7125.apcprd06.prod.outlook.com (2603:1096:990:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 06:12:07 +0000
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05]) by TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:12:07 +0000
From: YC Hsieh <yc_hsieh@aspeedtech.com>
To: Jammy Huang <jammy_huang@aspeedtech.com>,
	=?iso-8859-1?Q?Gr=E9goire_Layet?= <gregoire.layet@9elements.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "corey@minyard.net" <corey@minyard.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Thread-Topic: [PATCH v2 0/2] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Thread-Index: AQHdGezQ0quMicaHf02veNXAwWBHIbZ6caMwgAAum+Y=
Date: Thu, 23 Jul 2026 06:12:07 +0000
Message-ID:
 <TY0PR06MB6855DF99AEBD19C2CA2CE98093C02@TY0PR06MB6855.apcprd06.prod.outlook.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
 <TYZPR06MB65685CF6F0969A3F400AEA2BF1C02@TYZPR06MB6568.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYZPR06MB65685CF6F0969A3F400AEA2BF1C02@TYZPR06MB6568.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB6855:EE_|JH0PR06MB7125:EE_
x-ms-office365-filtering-correlation-id: 1c675693-e992-4092-dc98-08dee881531c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KhswXOFidl30Tj/rnE5K8+CFgial/SmL2DalRLXy6cRRVAhgM9NBvxjzF1PqzpZ7PB5Kb/gGHGz4RBj4eQyhuUIIqgKui0VaSDGr8QUBK4KlL/TLC7XUMiOz7cqSEmHX4X8nQ5z8+2OG6LY2wVm5PenBtm8fOCKViSEPGBVFP0tzC+VHx2K8zi48wR1MURjw3JVCTO7BUE4B43Mw5+N+KkjrkrcODB5I5H3ppzhQ7YDGNIrvudHwlYMuCOH/H9a10Z6KYyHSDqL2DZJpAicKNCH9waC+f74NFhWIPz8yqV8+xY+pHHFYgPvZnCYxQk6FRNxcxFG2eKYza9FLPNBnwNMl45bnMzPVMPMxLmNDpkRonj2l3aJ3S2damVVz67syiXVG45J5X+oj6v490MRW7HDTZ0r8eRIqkgmU2EK3KYJP3DxXzAembKKoJR66P/Yvb7aDV/i1OqxknVtQ3l5EydpyU0IG31IKJ/ZtNfsMAJ5ccmolNDFrkr5+qu8nR/fzsn8Yz5lA0m6I4l5WhMlJpqYAxQTUU/hlWKhC+xru2k2ywSs/Owd8JlBD3Z+e1YhsaDYvIB7EtBcua0vSmqnnnlpVqX07QnM09+HZnIxaYuTLpmsMevgch/Xe+C8VRSuhfmf4+cRM6Gk6VeDA1AV658UZhZYEn/+vWMIi8cElOO8MHtr7kgSspGbzZxaIiWvH1ASmAJaLW9oKubNTS33SfAU2zA+wmi1h7WqHSk+ZIC0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB6855.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?n08wWIb0JQV5KjOQISaudLDAhunIGmQXnyrAteKowP22vxNUp0EWI0Oemc?=
 =?iso-8859-1?Q?3RsZMIHLWjieiAoduSYuMZDdfZnVsALFmmHKudBcAETkhRfFrhbq9gBmhg?=
 =?iso-8859-1?Q?NNugF1S2Pa42H+G3U+7Wna3JhKeVxAUvkMZJepJNdbAUFv5lpEBxCFmbT9?=
 =?iso-8859-1?Q?9u52Wa9SoX6y25ZLm0XwU4ggEdGnXSHqo5VoecX8PeE1077vInvdCdKXf7?=
 =?iso-8859-1?Q?PvojUQuHfkd2g0kXBkqqWOFTwbQRAyprBmVKv0d5JfPu3mO6KTSghB9Z67?=
 =?iso-8859-1?Q?xEuSx4oig7nnFZw7ZO53cu8+EKnQ1aUBoRNh/9IFqRCNBZ1n4dp29n+7wq?=
 =?iso-8859-1?Q?+nzylJ/wfnYoDdI2qr7XETKWOCt241H+sjOtUQVwsXI01jwu6tSJZUaVCl?=
 =?iso-8859-1?Q?jjzIsxkC1ywI9bbvkAxndHEIwBNy+vlRmt7hetKg2eEOoakas7/yFKjrgp?=
 =?iso-8859-1?Q?GoW/C4pAyfPFmzeJ0ETgNlhWKudd7qhsEyRMLhNQy5ukKY4iu6wZ9C6n8T?=
 =?iso-8859-1?Q?ZS8Yv2ZifgSXO980ZyepX+Ppu2p3tr5yJcGA2/2b0TpKJUPMoWAEPS3X/9?=
 =?iso-8859-1?Q?FfJrHm1C8cyA6ulPEM1zqd0ZqMEdgUn2nDI76AvO4HCQZIhxHtSO2i5EiV?=
 =?iso-8859-1?Q?8tocbwLy439VPWbTMqJsoX2kK0QUwcjMVSoJurNqW96SBEm3Cf+Ix2V78X?=
 =?iso-8859-1?Q?rlfXW3VUuvqOMD6ssmRBOUkhvabo/5XLnAvuc+VvMLPVKIs8qg26s3ud33?=
 =?iso-8859-1?Q?I9ZF6ihByxLu6HZi9wbujdQHERq9SUOsN+j3N0+myu4t8XoMlqqK7ZlfT+?=
 =?iso-8859-1?Q?l7/OPQerWRZWZZPVDEzng1MXTx1co+Axj493KQyhgaJ/ktZdZfvQEmww4m?=
 =?iso-8859-1?Q?Mx5M+N9tN193W3FpGuySUxifVImKoJ0r3r+tO+vJmla2A3neRbTGvGTYf0?=
 =?iso-8859-1?Q?eTVvGFS1BMutkVUlOB1QReQjSpj2s6YGdLXSetz60e15+bVgby7Xer/KU5?=
 =?iso-8859-1?Q?ikX0yS33OejSqe26C5sgwcAJ+ZRTifhm85jc/mspx5IhhQypzsaJ/rNmj6?=
 =?iso-8859-1?Q?uiI/pc667njhSDbNTWEdSjg8OsuJG7WDhOazep9VnGWl+ZCxtOLS8unEHq?=
 =?iso-8859-1?Q?pK4gRqI68Ym0cTVw+2ZAm/9RNW9UJLZJURb0ecyV3jUvk+L/uRsuI++l2O?=
 =?iso-8859-1?Q?oMlJd9jNWFWQIstTky9ntJNJy216YQeesBIW0fccVDqvrbWF7/9yw/NMx1?=
 =?iso-8859-1?Q?myWpye/gZCzUyd2fGq9L/tAN44nqq+DT47E4w75VwgVyf0UUHQEeYQ8MuD?=
 =?iso-8859-1?Q?UW8L4ByLBMuwrzliY8z5mrFk5hMQm9Xy5YTL6qHEXnFZUuPV85cLly5D0N?=
 =?iso-8859-1?Q?BiPBxfY3zKWgG6LgO4GMksUtXl7u3n5MmRNwlUM56wDhU2RQ31j5nQg+6c?=
 =?iso-8859-1?Q?wSXUklSQA3XF4s45uk16GSEb4yhIipTDBcXQQ7/87L87g5Ho+Rp/UVGiYH?=
 =?iso-8859-1?Q?L59xtO+cx97EYzanSvZCdAILgkeqTMDPk45sv5hQUwZR3iVBe6ucCohXq9?=
 =?iso-8859-1?Q?3sSVW5LozNm1+40HASKzH4wGpN08Y9BICtl0802yiZkIYPSVimfdNraVjn?=
 =?iso-8859-1?Q?Wo1UVH1RGfToh5q1lXDeBWFivPj0CeJMk11NZ30BuIh9QkKAJvcuPYOFwj?=
 =?iso-8859-1?Q?vdwmWCbloHpZMBJKLSURYf4ClUZ6/R7WBgpIS/sb6titoLwDBXOKWKTivF?=
 =?iso-8859-1?Q?e2EZHYnePpC7BR06q6lQHwUXqWgb1fZTOlC5W76KEHjx4AV9eNaZHPY844?=
 =?iso-8859-1?Q?19kRastJnw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB6855.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c675693-e992-4092-dc98-08dee881531c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 06:12:07.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWVg5g7FxTBZoaC6A6Kx5N0isglJWO5Ghttsso3/Z5u6XDJIU4VU7l5GGhAqOrzgzoMVKd9a21y4iQPIXVJvmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7125

> The PCIe-to-LPC bridge on the AST2600 exposes 4 channels, matching the LP=
C=0A=
> controller's own KCS1-4, not just channel 4.=0A=
> It would be better If you can provide a way to handle multiple LPC contro=
ller for=0A=
> kcs channels.=0A=
=0A=
I raised an RFC to discuss support for multiple LPC controllers in [1].=0A=
=0A=
Perhaps we should first take other people's opinions into consideration=0A=
before moving forward.=0A=
=0A=
[1] https://lkml.org/lkml/2026/7/23/429=0A=
=0A=
> >=0A=
> > The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS inte=
rface=0A=
> > on channel 4. This is a fully KCS-compatible interface that is exposed =
over=0A=
> > PCIe.=0A=
> >=0A=
> > Add pcie_kcs4 to existing LPC bus in aspeed-g6.dtsi.=0A=
> > Modify kcs_bmc_aspeed driver to detect the PCIe over LPC channel.=0A=
> >=0A=
> > In the driver, this PCIe over LPC channel will be detected as Channel 5=
.=0A=
> > In the datasheet this is defined as Channel 4 over PCIe.=0A=
> >=0A=
> > The Channel 4 name is still referenced in the offsets macros.=0A=
> >=0A=
> > The host need a driver to activate the MSI interrupts with the PCIe BMC=
=0A=
> > Device.=0A=
> >=0A=
> > Tests:=0A=
> > With the patch [2] adding PCIe BMC device for Virtual UART, the MSI=0A=
> > interrupts are correctly setups. The Host driver is build and side load=
ed on the=0A=
> > host. The ipmi_si driver on the host is loaded manually with the KCS ad=
dress=0A=
> > given by hand. 'ipmitool mc info' is run to confirm it's working.=0A=
> >=0A=
> > Tested on : Asus IPMI Expansion Card, AST2600.=0A=
> > ```=0A=
> > # insmod aspeed-host-bmc-dev.ko=0A=
> > # lspci -vvv -d 1a03:2402=0A=
> > 02:01.0 Unassigned class [ff00]: ASPEED Technology, Inc. Device 2402=0A=
> >        Subsystem: ASPEED Technology, Inc. Device 2402=0A=
> >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=0A=
> > ParErr- Stepping- SERR- FastB2B- DisINTx+=0A=
> >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium > >TAb=
ort-=0A=
> > <TAbort- <MAbort- > >SERR- <PERR- INTx-=0A=
> >        Latency: 0=0A=
> >        Interrupt: pin A routed to IRQ 154=0A=
> >        IOMMU group: 12=0A=
> >        Region 0: Memory at 82080000 (32-bit, non-prefetchable) [size=3D=
4K]=0A=
> >        Region 1: Memory at 82040000 (32-bit, non-prefetchable) [size=3D=
256K]=0A=
> >        Capabilities: [40] Power Management version 3=0A=
> >                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=0A=
> > PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
> >                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-=0A=
> >        Capabilities: [50] MSI: Enable+ Count=3D32/32 Maskable- 64bit+=
=0A=
> >                Address: 00000000fee00818  Data: 0000=0A=
> >        Kernel driver in use: aspeed-host-bmc-dev=0A=
> >=0A=
> > # modprobe ipmi_si type=3Dkcs addrs=3D0x82040E88 regspacings=3D4 regsiz=
es=3D1=0A=
> > regshifts=3D0=0A=
> >=0A=
> > # ipmitool mc info=0A=
> > Device ID                 : 32=0A=
> > Device Revision           : 1=0A=
> > Firmware Revision         : 26.04=0A=
> > IPMI Version              : 2.0=0A=
> > Manufacturer ID           : 2623=0A=
> > Manufacturer Name         : ASUSTek Computer Inc.=0A=
> > ...=0A=
> > ```=0A=
> >=0A=
> > The original patch [1] review set to use the existing LPC bus and modif=
y the=0A=
> > kcs_bmc_aspeed driver.=0A=
> >=0A=
> > [1]=0A=
> > https://lore.kernel.org/linux-aspeed/de49f2032f5b1f170161dcd6191c0daa48=
f0=0A=
> > b0c2.1784117715.git.gregoire.layet@9elements.com/=0A=
> > [2]=0A=
> > https://lore.kernel.org/linux-aspeed/51e455417bdcfe608270c6cb2806b1fd97=
1f=0A=
> > b998.1783524645.git.gregoire.layet@9elements.com/=0A=
> >=0A=
> > Gr=E9goire Layet (2):=0A=
> >   ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe=0A=
> >   ARM: dts: aspeed-g6: add pcie-kcs4=0A=
> >=0A=
> >  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  7 +++++=0A=
> >  drivers/char/ipmi/kcs_bmc_aspeed.c      | 39=0A=
> > +++++++++++++++++++++++--=0A=
> >  2 files changed, 44 insertions(+), 2 deletions(-)=0A=
> >=0A=
> >=0A=
> > base-commit: 03f906d8f5541e8bb741035981304feceed5993d=0A=
> > --=0A=
> > 2.54.0=

