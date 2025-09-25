Return-Path: <linux-aspeed+bounces-2346-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24078CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Thu, 25 Sep 2025 08:00:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXR3X5t4Rz2yrm;
	Thu, 25 Sep 2025 18:00:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758787240;
	cv=pass; b=S0VJJwIxGP7Ql67/eTgzT/FWH2OoHq6IftVaxlY2rz5DaYCC2DKGmeKuy2Ri9iIeVL+PHc5m6SXldVs4C6gaCLLqiEcVWqxs9bzRtKtRM7ortTAxFIN/3+2v8uvvH4hUMNBUNJ/tn6AXWXT+mUrLKFpw9oyBgFncwSonD50ljTkPR5Bqq1TN4xXfiykL7aI8duoi6oIyeUFS2WuzH/JcRa+tB3dokmh3bZ0nM2CmJPCHVrlQn8vJ30Iju3cEK48ZPm0NiAr1ZP9N1M4oIQWTmHTgF9dwoZ8jV+/TkBxtQ4Bl9HD5KeAmyECx6Ewep/29ZBTaLDekGtcAVrVEvrilyA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758787240; c=relaxed/relaxed;
	bh=cGqjohm0bV3HXj3emhVMFmYPkiuL7/aGmVr3kyYBmX8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9kr96UKlTm9R/e1rNA+albSwhkl/fKVphE4107xZYFqWD5QXu0u5wVbFYAqLRNUlucPt1mCj32POeUdEBNJuvyX1g/pJHOO5qneNgYGGs+MgHfrzASySirdA7u4L/CADYAkRFY5GkxrxXOMZFuiCd3B/a0r1UnmFgulfuUoPdy80xDzd7sYFyrpPHjttW235uGOj2kDL2IKcUmjfJ4tliR3SiV18/1WjZRHy+aGD7VDig26jGvRsc/04K8fGBi1imorrQ5F5GVD0+s2bPxx1r58CRNH+817ZTSmbwheJXWwbDcLCUBJAPeuQhZLIWMw+5faFHMLL6fZe3l3GwiOTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=jLVMPnVZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=jLVMPnVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXR3X1Xxpz2yrP
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Sep 2025 18:00:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXQtM8lJXgoTDtBXTFX4w4kLGsBN36+mBAhsQnzrljH145hyRFyDKjOwdW2Fu7T7i7WYqXrm5IPmEsigJsShigTS8Y8cjz5PzeB4MH9VPHVFF8eu9eP3kiCPqvib6aLzTwGL66d7UWGiU1bxs9lT4lLPRJDe20ligZrNUIrC8HQjsrn4frrIeVHrQr/FUON73f1yQn/QcYrjMj1K0O4vniiH+k30caPb+17TjJXBhoC5LXhX/Xd0MccbE4Uqx9fOg74MbY6eK8rHwtYpWBYSRbo/Oz2DKKk+4NY81mLNrIhWDA5LZ+ymErH3iBD0Mbvv6/DTYkA4JoMY7ImfOvOXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGqjohm0bV3HXj3emhVMFmYPkiuL7/aGmVr3kyYBmX8=;
 b=UYBHQc3/icmic/V2cl7N/IPaE0yLqeKUmDtEmg5bfBSvFe8FQlnFe/o6qlPN2Y47Qj4XoTonf1PWGSL86MfoMKVO+4+NtWfsLopVAlfadopazxRWbJQ45eok70uTZVhTWjZ4g5eNMHS5f0nXvoEp7UsJpDyDDq3ov1jJ4i57pP6oce3AbeOeCPJcW2AcDOgGIe2CjnfCSrYAGojewJ2JIkuIuOfK8zsK3HJR4I5BBYzfnGFuuXNhBL4IImeiC48aJAE27PEivGMnMoKJg3Ftkck4eW84UOwYHRwOneygj6XaGj8k0N4nFwV/mfrQE9ZMIvwA5ZuHFboTiAlXxgPgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGqjohm0bV3HXj3emhVMFmYPkiuL7/aGmVr3kyYBmX8=;
 b=jLVMPnVZTftPPJURQoN7m3DeUP+93h4NfK9aV6O4G/3/5Ry3Tc+0cwgR2oExlKLEK19kG82S8kkBJAbzoTOqE1q+Zaz+xk6pjd4fbCwqOm9r+U01kjB4Xfpbe9grmoqAgviuK16F1hdrpP7YO/ZPPWVmqFn5tKVddOWlrPdqq+BhOoGY23ZEOz4IaRp03a4/pujFag6ZYLal81elJzCwL8lbbsWTIIemPcXaRTyvJ9npPIJRQwWiJxWn980Ba18ZB5JJXFoLlaEd9nQDa9U6T9kQaKwwobLp4ioS9tSxGBanUsx33dJPiSlRkWqpiAPrr+7UI/jYncqAOGQa0D7f8w==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB7149.apcprd06.prod.outlook.com (2603:1096:990:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Thu, 25 Sep
 2025 08:00:15 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:00:15 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>, "Lad, Prabhakar"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>,
	Mo Elbadry <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>, William
 Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>, "spuranik@nvidia.com"
	<spuranik@nvidia.com>
Subject: RE: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
Thread-Topic: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
Thread-Index: AQHcGu5cAuQ4pOHn0Emk78rKDKJ76LSjrCwAgAACnMA=
Date: Thu, 25 Sep 2025 08:00:14 +0000
Message-ID:
 <OS8PR06MB7541AEC5560E3445C33009BEF21FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
 <41705e13-c61d-4249-9492-b83f1371d3f9@app.fastmail.com>
In-Reply-To: <41705e13-c61d-4249-9492-b83f1371d3f9@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB7149:EE_
x-ms-office365-filtering-correlation-id: 1b16072a-80f9-4887-a51c-08ddfc098f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?J/OCNQqZV6Bc9zEsSxIcpcTa1F1qmkMLln3/lWBPTVLnNQy1Uca3AQBRBe?=
 =?iso-8859-1?Q?MXe/1YHV/ezgYWoV6kDAMYiwIlciQGQjJAzvZEC9WmzDJgZZUcpSNlUwqz?=
 =?iso-8859-1?Q?CxL9tJe7qx+AFrZxLzXFhmflP0SB13FtPDTQExjZ/Ek/HDIaDn25NQn5sv?=
 =?iso-8859-1?Q?Y4XfzYGxHAzC+m6oHRvKnlfFd4hq10VVIYhkFFHngrDlWDKfS2GjyqP9cQ?=
 =?iso-8859-1?Q?nTLFh+8A4+VJxFTpQFVUpZuB7/YR5IeUM2AQbJ2W99P3AReqrSWEFdhSAC?=
 =?iso-8859-1?Q?Wioq6L5Xl5cnLlAmkbQIQCA8q4XXd0QhpWOlr46ronpVt0bWf2C/gqxy0L?=
 =?iso-8859-1?Q?T/YME3QHZKIue5KgFMSfkTImPFSV+YqzRBAfWuoIJp6ZUYqsO+938ZvoQd?=
 =?iso-8859-1?Q?NAwU/0WePyrjJ0DsNsVxERyi9zP4bwIDWBwkArAPKgcqKNzXBWb7a/pBXc?=
 =?iso-8859-1?Q?ZfxybvbucHtT+IUMwCFZ8lzB6GuIKsfUV66u+R+bYuSnqecYsejzHJxL8K?=
 =?iso-8859-1?Q?jVO7QR9c8+fK7debwiJgU7AXUcVe5dw06tvjlhrU2Zb/nUY3PBJItHGbTK?=
 =?iso-8859-1?Q?UyXNKFTJfcoQOxNN3S3dYvFMBZN+6f2K/pOaathuUKyb2e7MJdWDFeyUm7?=
 =?iso-8859-1?Q?4wt69cIu1g1UZ8l7Mf4W6sbXE41oRcCGyykBxFijFdxNsGb2gbNvG++oXs?=
 =?iso-8859-1?Q?KeEKdWs1CaYvVGuxwldQggg6z7YfKZjDyU6UO1Ykib0WeL+iUhnXjwBa/U?=
 =?iso-8859-1?Q?WPNtblNyQVvLcWcl9GeLdORH3uI4DadWh5PVvTxEeKWGhB6YQjVBcgMztl?=
 =?iso-8859-1?Q?qsOJfNnGYs9DEIIhnSKzs0QOMDva/6YnD+OggaHjMWHuVHNp+XX6DG7mTI?=
 =?iso-8859-1?Q?Hv6EsR6u7Ch+spZFq4aqhn4dxHiWiPyee6x+nkO3Wx0B0iFXLjBbdCvGBn?=
 =?iso-8859-1?Q?b2sQHMlG2FpWTyHt1L0u57a+61oVQa8MwtKmyuJ5MGmEuL+lzDVKgMGyvu?=
 =?iso-8859-1?Q?uZwYB2RENEd9yEVfNs5A28ncL5kVdF+SXsQ7YgE3g1GQHctksYFICVc3Uy?=
 =?iso-8859-1?Q?AIIdiqKddcqwMHZbze8CnxM06RznejxEOOmAANYgkN3Rlf2Bhub4OJ9IM2?=
 =?iso-8859-1?Q?r0772vRjAgMWD3d0OFmGh2dJTp/wbr1KWai52GHBmofKNqhmF4kE9/DRR5?=
 =?iso-8859-1?Q?GIv/PLPtsZb1HHJVeNsLJENJi65qhjjYOyQbQumVGjfsrnpy5iFUQ6rPx5?=
 =?iso-8859-1?Q?F65vnDRwDbzk3qVsXHpSuoAc/2NWMNtm02VwDT1p5EeVKR1BQxowYXiZnP?=
 =?iso-8859-1?Q?3EKJiL+EtS0q/FCqL9VT2rW7n5i+OqrYy7DR04KFvuANtMURdL6NA3VGem?=
 =?iso-8859-1?Q?cK6pPCDmKnQ3raj4ofCYV60lDDRaVieBOfUeRxC03EWg5DA8352t5WD9KW?=
 =?iso-8859-1?Q?TfKnWbHyP6zYxuCpa/k+JiZxg6UrAPv9HH0j1qv0Pr+SQBhtlFheGSRGo6?=
 =?iso-8859-1?Q?h+TuPDSjtqfMxPoj6oF+F2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HCs9GTS5PrnDkuphhrOmEqoVfSB9iMLP8Xg7yVnA5QvHsng2ipWhgLvZbe?=
 =?iso-8859-1?Q?Yf425w84Lp3TIDVuGyRcSzXD8gWOVIFucVoUmuKAGGCJY5ZWoZrpuA6/wd?=
 =?iso-8859-1?Q?2oZv7iNZNlyzCrfKcy4z70iKwPD4kxeScvUGKtacyfJl58jyfEgr9HZanZ?=
 =?iso-8859-1?Q?umre0sbvGGWW35F048CnpVqpwmW/zRqVS5uBGqPNHC4UoWZVcXzHl9LlWe?=
 =?iso-8859-1?Q?dVUuVWhhwoX7PRuNVf6V7IwsrT4ayaWRPmpODplIMZlcgZJuSICc2Wfe/4?=
 =?iso-8859-1?Q?FxCScrI4iD8qYv4W2rcvafeR0N/AuRLZXdjpNQbtQgotGdw8m1emstoOd5?=
 =?iso-8859-1?Q?amG7AMWcvf1oWQq1r6MXMnE6qXgoJsy30FnAnBpJI+Xk/XOO0Rv4PTysHn?=
 =?iso-8859-1?Q?mgU3hP+VKgTQ5tt93U/SAbKF/KgaFU66Z+HPB3Yc6+20/2CxhCj7ru8Zxj?=
 =?iso-8859-1?Q?O9SjFkkAM79O0k24x88u0kyn/RR8JblUPlWixySITc834+fWwWC5j5Ical?=
 =?iso-8859-1?Q?baO4iZZoSYixuSrb+rjQE7/Z7sMtoBZYniVQO28kTZdODhL30zO6whl0ck?=
 =?iso-8859-1?Q?Fve4y9EdhN19Rzbs+SvAsqk0bkx9l4/miJ1DBdPSNUx1mAtXkCsz6u2y7/?=
 =?iso-8859-1?Q?W4x5Mlwy1UyAm94MuUNp0wzd4DSskRhYuncQ5fJqx2X/IBGEuQ33yykxWo?=
 =?iso-8859-1?Q?ZoSFPcRLkahItZAJOKCrXrsbxORovdyx4aC8cgpDzetaBtdIHlVcJEDfa8?=
 =?iso-8859-1?Q?I7quxE9Omh0ykVKrjbgSJq2fV8MhCB95pj6Uz2yS7IL4cwR033YmP9yPnH?=
 =?iso-8859-1?Q?gWSKGdcDYmYdPTt5kkoNQ58RVyBb7Y1gpGJtkbSaoCGg5zzvUGwHMxVchh?=
 =?iso-8859-1?Q?Uq9ebr+FhP3cFpUlbHGv/cYhFnsHSkC4PcC04T+MwLjHKPkER6UdCLTrYy?=
 =?iso-8859-1?Q?/WsiRPEzJ3vX2w/M9MGG4Rweshv4yb1bY/FbAbdcvtiD2B895WJDkZYh1O?=
 =?iso-8859-1?Q?o/+VU9u4z+9rd6e4rVpjiQICAk3x3IphqaQjp9OWTiDNSFz+7I7hu6bhnr?=
 =?iso-8859-1?Q?5KTSHX7zA45mmc1T/3/sYbKVY3bJmJIiJWFEOG1Vp/eP8AY7kkR1xdTYwT?=
 =?iso-8859-1?Q?4gyAnjf6QRPndE/wV/71nNs/jKQNP40yelKZnoKESp2DBVb0IYI1z1q0hG?=
 =?iso-8859-1?Q?09ZmUIoGISFrpF0raYQiaflCQ62ksWVUAhAV4ZQ6YpkshBI1ngufimNIdI?=
 =?iso-8859-1?Q?uLgHErshf22tbjpWxguDDY2pGo0UkD7Wcai0E7a7Wz6E2jsC4UW/dGjKo4?=
 =?iso-8859-1?Q?cyWCZi1Xmja2Z7mNhN4r3pbX6AsUpo/0Ougkmvz4X72r7M9EknP/CgFifw?=
 =?iso-8859-1?Q?EGdwaF0TGaUKySf4dAdq7NJdf9HkQacTXBsN29LST2kcWA2Xz37lbWI+Bp?=
 =?iso-8859-1?Q?vICWFALc5tm1ds2Fg1b16S61Xm4vN5j+DuD2nIgLc4u2LgS8SgGmap9vax?=
 =?iso-8859-1?Q?FKQDt8MHC5Bsz35azOnwA6KNeun0BcBPKJVGgIkjXyPLyF0R6M3l4lCHda?=
 =?iso-8859-1?Q?QjP2p8b9koas1dlN19GRC3TEVsgR54X1tOEACOEpW6oeiX9F9As+spYri4?=
 =?iso-8859-1?Q?IrnvcNd8jgYpr7wC7U4PWACOLwayRzH+ci?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16072a-80f9-4887-a51c-08ddfc098f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:00:14.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiJ4pq2UqnwKQ5tMAHFvelEs+IuV4CXNgNDqXaSmkuF/dpXcRWQL4yVDRUonMe7uYEq5yoBIMkbrKf2k+9ezmMqgGeGQmjg+gEzLlht+aV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7149

> Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
>=20
> On Mon, Sep 1, 2025, at 05:13, Ryan Chen wrote:
> > This introduces initial support for the Aspeed AST2700 SoC and the
> > AST2700 Evaluation Board (EVB) to the Linux kernel. The AST27XX is the
> > 8th generation Baseboard Management Controller (BMC) SoC from Aspeed,
> > featuring improved performance, enhanced security, and expanded I/O
> > capabilities compared to previous generations.
> >
> > AST27XX SOC Family
> >  - https://www.aspeedtech.com/server_ast2700/
> >  - https://www.aspeedtech.com/server_ast2720/
> >  - https://www.aspeedtech.com/server_ast2750/
>=20
> Hi Ryan,
>=20
> Thanks for you submission earlier. I see that you had sent the series to =
several
> lists including soc@lists.linux.dev, which is what I use to keep track of=
 patches
> that have been successfully reviewed and that are ready to be merged thro=
ugh
> the soc tree.
>=20
> Unless you have been told to send it here by Joel and Andrew, I assume th=
at
> they will pick up the series through the "bmc"
> tree once they are happy with it like they do with the 32-bit Aspeed SoC
> (ast24xx/25xx/26xx) patches, and I have dropped the series from
> https://patchwork.kernel.org/project/linux-soc
> now.
>=20
> For future submission, please send the patches only "to"
> them, with the other people in the "cc" field to avoid this confusion, an=
d leave
> out the "soc@lists.linux.dev"
> recipient. You can add me as arnd@arndb.de to the Cc list for reviews tho=
ugh.
>=20
> Please also add a patch that changes the MAINTAINERS entry to reflect the
> added arch/arm64 contents.
>=20
>      Arnd

Hello Arnd,
	Thanks your notify. I will remove soc@lists.linux.dev, in next patch.
Ryan

