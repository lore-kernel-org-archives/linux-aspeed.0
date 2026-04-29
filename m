Return-Path: <linux-aspeed+bounces-3975-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B577FF8867
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 09:44:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5C825vp7z2ySW;
	Wed, 29 Apr 2026 19:44:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777455890;
	cv=pass; b=mtqImybN2pmDKOO5I4/HjuaLIIsjJPlR0KBGO18teoFngceD8b0aRUH6VlsN4ActSrVAfLuUq1MT6qUeZAHXnhOF66mh3xkQr1GH1zegCW6TYwFiah5ZCvX7MymofeR5l/Net+EjAFuEuz/yRm43RsANY7myQ5y7VP7juJ2rmRfb3g+sE8wUCLKHjdc+MvURYkcns3yU3tO81X22jaU7rngyXINwSp2GdbuQNkwXqhYmJgjUcVJO+l4QZqVsGu/s78o7KoGZFWig8LLec7x4DPyMDoD0hPoQwXcMtbkV/2XvVaaNMF8tUDkCevWr6ASP8uxSJjRP+MYJyUdw9SyD0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777455890; c=relaxed/relaxed;
	bh=hgxvdLNq9Z4K/e7DEauf3NhDc703JvGu6mrz9dAX+DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVrnYNdEiIVXC6XgYcvQmZAijuM94TIh/r1gv8RoYAwmGCOLGejSlD30Usd8y6mHIVGpXAE4fE0q5KFC6aPP8gnM/lG2yWwrXKPJtorVw1MKttEkjD+O3sK6lWpXPWv4aMcemDppFhfuvTGDyXxHSBPHwTgOylTXZA7k22GGrxobqfqMeEFzyG1cwDJdpBOH5ZcLrFpJO3boUzw9503EzxdZ7HJnWruLGf9gC59UNklbS5DB9rXhZM0wtoNvnYvwNslm8NKvhY2ZwSbXEdXZ1yqtgWv+NhSkfr+eqJnfgX1nkE1y9CMGZfT4EQrn7HH+S1lc3Bm9ntDjXMTwzy19RQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nVlmTDRH; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nVlmTDRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5C803LKfz2xSB;
	Wed, 29 Apr 2026 19:44:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyR3pECar9/VXOaafyNMSErDimfP/N0YR5/YiTahWbprSDE8nlDNcZbGecVb5PtApifvwlMcIgPMjOuQz7xpKcDQNld5QRlY2/gnmADfHNMwP+qiolE7BgFlut+THFV2E0dJjhIcVn1gDyPhgV/2EJwsy13qkLPq3XmXrdQQN8XWaiHpAr1VSRVAfmJs9acek3EZR64xPUffNZlkcs/ZbLdtdehxipGxsBfQoqkJktT7PHzuAN10U3FTU+gTp+GKSy4CuhIZ7IE5aiNX3GnHV3mSaoPWCPBgKuH2sxmdAf2JRWOKhRdmVZTJapEXI3brNkNccH5ccnO2CuD/vSGSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgxvdLNq9Z4K/e7DEauf3NhDc703JvGu6mrz9dAX+DY=;
 b=yUwkBPzSoLX6DH9FTi+TVC4ZWUfWxKnBSt+vORH5vQ3fQH4cJbGejkNgopIuOydqWuU1hjMTJcBCbhG6T0TQrNIN6ph8Z3ZJHvclpYvUnC0fE/fxQ2ZiKEY362AIfq8fayz2cO1Qjt7jFkgcIhSV8jG/vhTW6k3x7xf9DDPi8iZgPePN0H9Zua7oUudGg674XdKihRA45oCPxuImM0k4e0olH8fkt6drf7UfI/ue32H6c5hEFBoZ6/V55dLOaR9OthVhjD4RJJ8LR7pR8WWK3Gop1XZFJ7z3dxiVBG2BcjHiyxFZyhKpTBjDtXAKt6MMq/nolPotAmowsvELkJsfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgxvdLNq9Z4K/e7DEauf3NhDc703JvGu6mrz9dAX+DY=;
 b=nVlmTDRH4nJZrWfs04Gixg0TGfnH2B/1r9JsYAPdX5Jvtndw//pPSXeR6PW7Xre8ZNRkSbA/A/UW3RrOzzvgMUIHbPN/286Zh4/NeDApxmoADO0FRJyNFkE4EnqW+DOnHwP0DCmxszNkNY3qbtGPmDfERGZVk8ZKBWy11xrpbcmC2mKv0SqD/F5x8olp+SR1P7Y2Bb0S8iM8OhcCrnKgSgmTHaN0bZ45yHvIRgR8TKYoULWT/ZzIRTBizIgspiQr+LBl7PVoG1uyqqghJ1LOJZ5E69duTHVQbO9Jc0CcjiTR0h58Hxf5hi0MK43sJ4v/d40acR3SaMEmNA4hi5l+nA==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by PUZPR06MB5588.apcprd06.prod.outlook.com (2603:1096:301:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 09:44:22 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 09:44:22 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij
	<linusw@kernel.org>, Rob Herring <robh@kernel.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
CC: Andrew Jeffery <andrew@aj.id.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
Thread-Topic: [PATCH v8 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
Thread-Index: AQHc1vUMkrNoLamkbkSyXt0W9ccsybX1SNUAgACBiqc=
Date: Wed, 29 Apr 2026 09:44:22 +0000
Message-ID:
 <OSQPR06MB7252D2B3558B5714887600ED8B342@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
 <177742778029.5403.7247019083523002317@localhost.localdomain>
In-Reply-To: <177742778029.5403.7247019083523002317@localhost.localdomain>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|PUZPR06MB5588:EE_
x-ms-office365-filtering-correlation-id: 1827c2f6-1993-42ec-a227-08dea5d3e479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|38070700021|921020|56012099003;
x-microsoft-antispam-message-info:
 szaGG2+tGVi4k3gJuNzy6KKxPuR7o+tuASQ5R85+kQ0uDc03cX6Tv/FowuV4eNt3f60mFEOakCBP/tVf9tUBbBbcvkMY8a+fB5rOCzQDOtBgsIIVUYhUU/rdlMDp+BMC6d52N22lTbblfF3oFb18tXrjgHNW5LHsp4Zfvts/CBNEFiYX9eFcgsyopDY3Zi+tDKBLQam/m44Yp3qun3YfORjbiCs6VCjCd8sp6xGlaozCDNQ37JWghDY17Atsvw+RdR7Igipg7YIZuO6vCeFMLSq1yjzsYnNQ1LkCUczX2inGM8O9kd88/eqOE5rm3EDtBqLICes7RlTEqNQ//7ngOBwd6VzfNzd0w8Hedg0x78af8qOXSnP8HBGKGVoa4Ff1O1E1OhSPZTfjnn94fmgqmXDmbLseWSNR99DNQHKyPCf+LdmT4baqWNTrrX16FvHBJQMOmzDQQ6fKomdg/VfY/dmcqvMRwXOBISQ0ANwFjPS0cilL1g4j8n+hCmUvU6McCsN/YIPqBxwMcyXSEdPS93tsUkU2/AJ9svZ9X7A5GLCXNxKyaXw5z4n0BSjF/8IkV6MN5o+1qnqKURUJ+/QAgvfvFRLZpVLndjPOzb+ob5z9b3L3zpxO9ECd/0u/SBniyR7pTSlWRpXiHTpmUc+ibD7PgYIiEgMe25pmpNe1m5OFEEra37aBlOIxuEm+qZkFDVMED6KSuzykSRUaNVOZY2AZugA8rMWsx1DfsIGzzJUBaLkKcXSMcXwTbrT25gSvJZnbl8gsfv6NBP+fsJcfc5RErostwQY0/RPxqc8wpSTuhGk0GnjuiIpjEiLxoOnC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(38070700021)(921020)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KPwNKiwzgNdy5tenHGylz/8pzbmr2OwdV5PvEC7TqU+UZZ9hPp9pJO9CDJ?=
 =?iso-8859-1?Q?WoWp1WiFrublL1QUQz9OA0npHwQ0z69zXFIUzaXByWCCdM/sQMtf80wBXZ?=
 =?iso-8859-1?Q?/LMuNqJrPk44J629ENmNbObDWgFY+EHw0MbGLtVa5w4wx3pWmsGUCrk89y?=
 =?iso-8859-1?Q?To7dNpfX0n5a4EgP/8Srb/2tIu3+CyjI04wDUjZAGcPuziZJUNBmZuXkKN?=
 =?iso-8859-1?Q?o7rJ9S4HQa7sdmjde3xRR5tclBc+WAufTmNIVWqFxzPdI7i3bK4BADj4Xo?=
 =?iso-8859-1?Q?IehQsHfKpbcVnfZakA2i2XLMUDK4gfR567qS5w8BnCktyo2qFApSP8s7ee?=
 =?iso-8859-1?Q?pbYfrJnf+jjDrFVoCEI+r3RQwVm5wKEexd7dCniFOaEhdwmKm5lJs4H9XN?=
 =?iso-8859-1?Q?CSC0/qf4bwg5hfa/cRHX9vY86S1sSPtgJnYE1ba45SAOFQgFXurNOqOKKv?=
 =?iso-8859-1?Q?hR8DEF/lMmVVOpcoMSr7gOOopuh0F/10MCJVGqXMAVRdPCyV0C952Q1JVr?=
 =?iso-8859-1?Q?QE6f4+HNfgXyuyxEzW/YXc8VfWgjl/+WeTkp4BPHQko5NVu3gvw5z5o3nR?=
 =?iso-8859-1?Q?QmRS0sXq4Wl/WVzBzZbjqqb26ZnCE9N4UpQgpeJqZPa/R62n4oUvEk/GTP?=
 =?iso-8859-1?Q?K7J9Ltn3TmgNcVF7HYotOsZMttp6eSP6BZHHGlxLYcYeC/n2reSIcV66qc?=
 =?iso-8859-1?Q?ZUInSOMoBTIJK/FPUsZlrzXMFv7lcOJo5QJn1zZGh2OsU1CyHa3BES1vvK?=
 =?iso-8859-1?Q?Gi9AnyKH6Z/zz24NyIVgrHWFaQN88uonDnx6jA9Olz5gi7YnNNSq2tmicO?=
 =?iso-8859-1?Q?byjETgNDvIxfvxctS9VTE+zVP2DBlmjd/aIJK55LlRaUCIblotZWBgBaMF?=
 =?iso-8859-1?Q?td19lOdsJSHYZZ04PYzfKQqX3glTfapoyDe8vreFl7Wm6x2I1a2zlx1hcr?=
 =?iso-8859-1?Q?5jOXsae80IWxG5VlxVfyY8QP+qP+kx8xxdJs7UcdeOOeEqR56OaCvFu0z6?=
 =?iso-8859-1?Q?AXaqZbZ2wMWmh04tOOr2VjaYckOuzhdUTTzLwZ3wHDW7gnBpEpKLs5P26e?=
 =?iso-8859-1?Q?BMRbKqhUrvdxEGMi1sggrfRDz/Lnr9+Of5/Fn3rkZ6mRXkjhYsjvX74cvK?=
 =?iso-8859-1?Q?MbWj5FPEJ5TxCqI4lGnfX2GxexSPrb/PxmwPXvHf8qNH2/Hhrfa01f+B1Z?=
 =?iso-8859-1?Q?K8sJbnrH7xqOKkerpLOcyU4TjG/KOU7A2TUPl85KCBLqa7RXBMrNjbDqST?=
 =?iso-8859-1?Q?/IPVwKGKF1onTIzZfLY04omERzRjlTQ9TfuJX2K7DctrX8RIIEnwQSp1A5?=
 =?iso-8859-1?Q?eVCChB1g8EexzPBpt4TMwsTXmbKeHWuDLjcZeLpscKF9snWuxUQYAC+DIp?=
 =?iso-8859-1?Q?t788EB/W3VpbQFSKPj7im7S7a/jKDvaIDf3t3oVkFCCJ7ciFh8BLWg/jSS?=
 =?iso-8859-1?Q?VNGzVr5RSBHkND5adsWBHEWdrKdG6UgDnAf6DfWhoi9y8VZEjggOVRokgh?=
 =?iso-8859-1?Q?IacPmn71H1YTesDND9I0TQ/VAToJpLvia5wy+Ekbs8O/mI5gI7jVH40Fco?=
 =?iso-8859-1?Q?qX5R6AaZx3rIzQEzCcxrsYhTb4LYTWEDhuWUUcuyUXG44ztwmLsjanlEoj?=
 =?iso-8859-1?Q?nmuTGcVQGp665YzFGeY9N2v5wxmqah++6avscriTWD/UCO63auOnzSa7u3?=
 =?iso-8859-1?Q?c8i159H/mzBr3a5+/jI0ykvhUvu5SiW2a8aLYd45d7ZoEQBbAZ2kgsqX9k?=
 =?iso-8859-1?Q?D0Owqz2EXfQk3FPYhkAZkzeTUffQxO3vVfXOjYUGZcbn6isizMur63QDWi?=
 =?iso-8859-1?Q?rmM+ewbPig=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1827c2f6-1993-42ec-a227-08dea5d3e479
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:44:22.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9lgqfvG1PYjI3Ve6PHfIBGz9OZ6F8ZblS14SQhaljfcXLTLuKw5s9L6wcMUUFPQqiQP92jltu+LqK0drmhfPkWqL4vpHSNPg3kh8EvdTTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5588

> > AST2700 is composed of two interconnected SoC instances, each providing=
=0A=
> > its own pin control hardware. This series introduces bindings describin=
g=0A=
> > the AST2700 pinctrl architecture and adds pinctrl driver support for th=
e=0A=
> > SoC0 instance.=0A=
> >=0A=
> > The bindings document the AST2700 dual-SoC design and follow common=0A=
> > pinctrl conventions, while the SoC0 driver implementation builds upon=
=0A=
> > the existing ASPEED pinctrl infrastructure.=0A=
> >=0A=
> > ---=0A=
=0A=
> Why is this being Cc'ed to linux-clk? I'm hoping it's a manual typo and=
=0A=
> not some sort of misconfiguration in ./scripts/get_maintainer.pl,=0A=
> please?=0A=
=0A=
This was automatically added by b4 prep --auto-to-cc. According to the=0A=
output of ./scripts/get_maintainer.pl for the patch `[PATCH 2/3]=0A=
dt-bindings: mfd: aspeed,ast2x00-scu: Describe AST2700 SCU0`,=0A=
linux-clk@vger.kernel.org is included in the Cc list.=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=0A=

