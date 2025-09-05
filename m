Return-Path: <linux-aspeed+bounces-2151-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29199CA0FED
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Sep 2025 05:56:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ5FF3r62z30Vr;
	Fri,  5 Sep 2025 15:56:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757051777;
	cv=pass; b=HVUaUd5YoqDMdtnwyRVHoWPJRHApOADBaWcM8o4ZlY8GYYGTvrkoqj5LLeUb0wJbwIbD3Lln4p0eOYydQAIKkgpmCUvLXUAAcvAaufYnybgdvvYOqZMTnyAQF+xnipapRCCn98PIgdhne4ooZFYZR2Vgj82xWQxrMUckpZpFnzXcqOmyWLWPKpOk+Et2C2I6xa66O6344kIxpn5uGUQ7nTsdrbMfQOTwp21xO9rsE45tA8waUscjUuvMM3tXgWGbWkWQ39J85bdOfMBBlavjOBoliuYo1TSzEjsnCX6ucitzWK2wXXJmGKFIUTxy4m84C4oyCbNb7HypRxd9beGkIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757051777; c=relaxed/relaxed;
	bh=K16rJq70k8N4iGe6InYmrZNs4ntaAMbO0Q5y4pW/zJ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hy4T/xrOt6gN69iYoY3BVQ5T0x/lxBW615NW2aptwKLUL21wvSflhWnWHCpUeVYBPeSe7CghG/1P90I/52hJ5eYcPMjeAKNg5PqPL1uVnG42EyAYiH7TNPC3dTWc0z+rpY77BaaaJ28IybbxnuLEkw2WkN9UKoo/aOtEXHIbVOG+i6Yqnqrvt7pVfJ6ZekiZzDc2w49eMMt4HKmSoSrYy5wUQ+xBHqJz5MoDlHPvPDDupdWDtoVWId8zZainhxVLV0WXEzo9YcbwI/696N9z81fgmnXG1n0EzanOJl+c5TvoQqxy2VS/yzq4BG6lFiZe5tVMAemMvJnNDafBeM1PYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oVt7UuR0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oVt7UuR0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ5FD1Jdwz30RT
	for <linux-aspeed@lists.ozlabs.org>; Fri,  5 Sep 2025 15:56:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC4T6msUm/EcbX7Io6e+9fp4awtCKc2stuPqa5TTpiQBAlgFUdO2oaSh3opH0A9HD11hIpCqaZnP45Ft7ABIJXYSkti2QRPNM8xpJZdh/xZLzllwQ2Bpue9dLDEUYSOQHpzQm+qqXARTa0iRu+lenF6YLNUzh0WaNa9wvkJkD1qYds31S6IbrMfDekww48meIxtpl5YJOBfr4SSyZKjzmik8stAnTrOu2rndAwWEQqbv5Hp4S9x6mF9eRtCkh1nlmcYfFyUEzcBFabrm2xkWPMiLQ1jTre3zxt/ecNbtmLxjlBiOmqvZZRTGBQG02zeu33deO0GNv/cbBkEMO1Q7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K16rJq70k8N4iGe6InYmrZNs4ntaAMbO0Q5y4pW/zJ8=;
 b=Cr9ePfoFX1vR4vf0In3ZkYHUb1NKTjciMpj33YEkididMfFPubF1DWtU9JT6NQbRMK0jBPXLa0rh7eC+YCmPjksdrO7vlOuSQYa2vawlOsA9XoS5jAhjjMFdy7tDhIattX3QEQDUsXin6+XxPtDOy925LQXBM9FxFpJ09BY8JAPkxBTQdfYsSJAMQuIRXEnq/kllcPm7pQoWFWo3s/vdAVflr+lcOv/3CFzv67bpxxGvYnOgrOXaEhUP3AqIC0P3fplUooWKb9i1DnbEuDK1bMgoBosq/geyPyYRQji9Jpjo1YusNt0cEO0fdiZyNzESYPoOf6u8WlJk1hKesF3clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K16rJq70k8N4iGe6InYmrZNs4ntaAMbO0Q5y4pW/zJ8=;
 b=oVt7UuR0Qj6KLS14YE86MZDs0PhqpxbuLnQgCcZTpVwyY+KuyRDQ3rN74wDdk39QS0XxayF8st+ViKodY+Awpi64pzBWm4lC5AZPhBra/Ri4hT8NvDIBFqfwo/+lCptjG/B8yb/nuu98VPwZKjcSZ0skG9rVUEwINBqWpBANAD2jLj9dOtvbi407REv6EmqvTbYjH1Q2YMw8+jMicpPtQMXbtt1DRadpp0TglfODJ1eTIJicPub8EwX0+TvhNYKdaEm6CrLPy+/lA+jFPmvkC9KpUJgAAKMZSFklPeoSSelhe50Kb5ia5pM+ukAnOuVhv+gN56pM4BWUrPYpgJ8fVw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB5507.apcprd06.prod.outlook.com (2603:1096:400:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 05:55:50 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 05:55:50 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Thread-Topic: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Thread-Index: AQHcGh0GPU6Ub5O2HU61CmoAvkdS+LR/4M6AgAJX8wA=
Date: Fri, 5 Sep 2025 05:55:49 +0000
Message-ID:
 <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com> <87y0qx0zqu.ffs@tglx>
In-Reply-To: <87y0qx0zqu.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB5507:EE_
x-ms-office365-filtering-correlation-id: c9b83b17-b016-4d40-100b-08ddec40ddd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e4AJKcVdiDpgRasa9pmoftdZ3KAFjt8bMD1zLOCRJvbdyCz+rsAxjm62+nNC?=
 =?us-ascii?Q?ndjcCfx6EDSZgAppuV8yEEOsm8AoDAqPBxikv0EwSGl3eBoS90j8yERYnhDV?=
 =?us-ascii?Q?7oK7XFtapHyF3dVTP2M0A9yKl8r/tc1be/ipQ2z+7eXYE9X4zAJ1zNCMxIUU?=
 =?us-ascii?Q?QoOwUxLn3KIeDGaL2CTGuZrv+aiFYT835GcyN9eCyfOmMCsPZmQMMXNH4NjV?=
 =?us-ascii?Q?o8fSTM7quiiwqZ1UkW7eTKRf1w2WmhbRu+Eh1DEkQtsVORUf9OmCdxAWZzEE?=
 =?us-ascii?Q?uHe6dfLz4XdmBODMPgaF4kOp9vXcfSE5tG6Ja0VS6yfhPXsTDrNoeJgLjqaZ?=
 =?us-ascii?Q?/GXGu4DPME68n8NR35namCJZVX4f9wyyp1gn5vK9Thho6g6PZm15SEENxti5?=
 =?us-ascii?Q?ZmJBH4kLyVH5Ly4SQEexzScp7WaVx0yI69DB67BkkmoWU/XK6WiTYhcbz3t2?=
 =?us-ascii?Q?RMnP5e6xJHB8Md41rnVatwpZbIprYgdJhm5+qFdhUWPnNxt2lkGIRW61oY24?=
 =?us-ascii?Q?biHcLOx+s5C9FTe+zcBv5Ef13Zb8tx0ClgWD7nRIbvbmk3GVv+PLcw/MFu99?=
 =?us-ascii?Q?/NV8HymoOeQSr6BtCs5dlCB+mD77Qh7/pG8her4dIG/Xzge2phR+svwAl/oZ?=
 =?us-ascii?Q?G6cpBXHL8Yzjovsv9QJzIdtpioJuFXo++fSRudfZ4Re1nSBctDdu96Zv1cN+?=
 =?us-ascii?Q?ngUqy2QWv7cGte/RfBjsd648CjfaHwEGz+FgSzRFiZTSaanS8Rlovx+R0iih?=
 =?us-ascii?Q?gJWsdqdL8+Eg65gJ117hxPEvFAtnReV9WlRAkpGZYJI8TxP7JpavkL85aumj?=
 =?us-ascii?Q?sL9kZ/TpI6gd8J9/vOSCb1DINp/UWohfFYh27aRYjT6UybTg/zztz5TgabRo?=
 =?us-ascii?Q?AECPf+O9A99Mxzj+KVsQN3SmfSmGoLNiKoWrigfqJiXQBk+gHonhieBoxoqQ?=
 =?us-ascii?Q?wiUGa07OE63CDnjGwuWyK7fkehUl3Q3v+pGxt4tKMoZC57mSK40Db8A8iekM?=
 =?us-ascii?Q?23I7mVlP2XQVYNGshEpCAgY0XXdSNUzw4QR4E7PcwybfN56M0Q29UtL/L7j3?=
 =?us-ascii?Q?oNBwDxIdYRSgShpCuRbRY9Iy+1CqVHPVhLcd4AIEthXbfBuAGU+pACAvgxzm?=
 =?us-ascii?Q?YbvZkbd25Quwy5+hbAyTvwhlrsukFd3qFGRSy0G0ghGyyEtQkxsCpsGsNG62?=
 =?us-ascii?Q?MyNTBq8+BMFjYsKNWG3VbjU77P0F5SvmKu9dTTznESJDjetfCigps724kPF2?=
 =?us-ascii?Q?Gh0fjrPkhYIqWK/tVjs+lTQCrVREa3PcDcKINYAeFSBp5X6tmOq8/Uqez72I?=
 =?us-ascii?Q?Un+drsDxBy7haIhtQI5XprUIZIk6z9JtMy63jLy0oV8B9akLV41jCi1CTIDe?=
 =?us-ascii?Q?fMLEOqHAOBybKN49ngt9VASEmhnZcifi9xcouhZStJNVg43N2mp+Txd5Z/Ab?=
 =?us-ascii?Q?VfO5V9SYR9u0UH6v/HmYWHpToAr2VIXsijDrouSXX61caaZX5RglMahQlwoa?=
 =?us-ascii?Q?C859468/Y6ew700=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5ryovjTy9IGrrsfArXqQkIir6gl9cp3Yfj9uf7hriWW/DPU5sG/dsEhrvx7e?=
 =?us-ascii?Q?ez2bIBzF8J8g2rrU5EAJSVf1ltd64W4BqVyqLf4smagkV67GodzEk+SqFAP/?=
 =?us-ascii?Q?ii4xJkGmS/+ceFR9es/ZhAhExT/wudIsIWW86i94fgocfVGSZQgIwkjGjx9e?=
 =?us-ascii?Q?CtDmlx5nQ0qVlubj+gGETLMwDImcunDVws5J8ANx6uuxF6bm87ACwazZKa3q?=
 =?us-ascii?Q?IY+FXH+/Lzi12BgvDsNtCU6wxrH8hms3w6S/RHm8aIdzyuR/2AN0/KcwuqX0?=
 =?us-ascii?Q?EQ/ISi1Hgcioeyy9sGgc4r2fOi21H0wNz+npL2FS2tb0ycJ56ToWXY00a4P0?=
 =?us-ascii?Q?wXodOhfKCxTgliP4RveqQ25N/9nOxgzFRRiQCeh3g3jS75OU1OkGxW6XdeuG?=
 =?us-ascii?Q?HMzLzilUcs1EYf179fg50xAFnSw/nhXDLSocTgJBf1ig6P83/T6qia5NkqfZ?=
 =?us-ascii?Q?nPAh8HnDPHFiswXVTZqx0tnjWGG9pT8oL8O8jHwSuo7tRSHhwNkxC0ZePSja?=
 =?us-ascii?Q?GuAL1JD3F8tJ8gZXkhlDNsfPQblv/NL0JNew+9GES0OKQ2ewnfvdlh7E/krp?=
 =?us-ascii?Q?1znoGdijoM9e8qViBM05pi8ZN+Rr/AfTDwvGhjaTWK8RBga3rUbRmqfrbVxO?=
 =?us-ascii?Q?fOFbZvyMnXX1CD3R/8EZ+/J1nfWxgkigU77dZstN9nnLVxMt/3HNyVBGeVDi?=
 =?us-ascii?Q?lX36Le1LSpbi00X2sNxafa83dX0E+wZeztLDWPw5eAwcmLHuy6JPAQfaOcJc?=
 =?us-ascii?Q?/PE41tioSCqbhkuz0N1G2ZCsDVtYlrVxEooaf1naGr9IS2YTBqMEOllFIsDJ?=
 =?us-ascii?Q?DkU7jhkYdJehTJTjFhB67WSLXIw0VNB4UfeCzL0VXIxP+/6eFtXSxkKJ82JP?=
 =?us-ascii?Q?3OafVMJD+gAIAUQuA+73ioMiBZwr+5Ehwjn6hZrl7E7pCZH3garCMnaUAz5B?=
 =?us-ascii?Q?7gHRcaMjbRpRdTi1ynQQvqL5rUxuHOmn+WcGV5FDSmMcTm/oZWurxR8FFKdo?=
 =?us-ascii?Q?FL2RKXnl1qu+zUpfJZH6Sre80mWyfREZJB2K5vctEZWBoqVpz14N4X+4/S7Y?=
 =?us-ascii?Q?S+Q74nJ2t63Z36D8Y+ytvylV/1+KkYn+K+0VClhq7oXCnrwYZwh0L04BVnHn?=
 =?us-ascii?Q?r27iv64c7fhQiJqgYgWNRiwpvDQ1y+hUYrsvbLI3gXkXIUey6UOQLJkQfrYT?=
 =?us-ascii?Q?Besx2GygRgUGb9B+lCZvPUZpngUP+CjUmalxJfrvlfVz3+HzHhU1/dCknqrU?=
 =?us-ascii?Q?DCnzb1r+GTdDGgHAcA/MqmLopvtdWZXT5Z1QLtN435wZ92QeSY5wIy58JG4w?=
 =?us-ascii?Q?d8KYOzsUYrB1nZ3UQm3qTSjVRqmQJoY0wrNpBKcEpNVMpQ7tzCvOT7nB1SEe?=
 =?us-ascii?Q?pyNz1vKIF5+EiF6k1D5hxbFjQe+llxGGzUwh1Y36lm+5covy6nH2az1MayI6?=
 =?us-ascii?Q?lE5tymIRVC46RF/uHi3rpXACU7NJIsPQ49f/HVlt91HTH6qz+hGDKsvrjCAF?=
 =?us-ascii?Q?MOAwfAm+KDuqK5hP4709br6yS9NS+xSdTk0JkZ04cf1idYnLuTilbTQqanIV?=
 =?us-ascii?Q?UCZe+ebqruy1Wz8s8DK9yX7bVjit0hPDtp39+DBg?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b83b17-b016-4d40-100b-08ddec40ddd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 05:55:49.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQ3KC2hdVDfnBJsUR3pbLvKSk8A/VoLiGP+SL1JL0R/ZN6b+q8tifDj24WT0G0K8df+Yqa9XQXcBSYsaOCcQjTIOfqe/JOZgmmEgPtk3cpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5507

> Subject: Re: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SC=
U
> interrupt controllers
>=20
> On Sun, Aug 31 2025 at 10:14, Ryan Chen wrote:
>=20
> > The AST2700 continues the multi-instance SCU interrupt controller
> > model introduced in the AST2600, with four independent interrupt
> > domains
> > (scu-ic0 to 3).
> >
> > Unlike earlier generations that combine interrupt enable and status
> > bits into a single register, the AST2700 separates these into distinct
> > IER and ISR registers. Support for this layout is implemented by using
> > register offsets and separate chained IRQ handlers.
> >
> > The variant table is extended to cover AST2700 IC instances, enabling
> > shared initialization logic while preserving support for previous SoCs.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/irqchip/irq-aspeed-scu-ic.c | 123
> > +++++++++++++++++++++-------
> >  1 file changed, 95 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c
> > b/drivers/irqchip/irq-aspeed-scu-ic.c
> > index cbfc35919281..ffdd9b4e44c1 100644
> > --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> > +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> > @@ -17,12 +17,16 @@
> >
> >  #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
> >  #define ASPEED_SCU_IC_STATUS_SHIFT	16
> > +#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
> >
> >  struct aspeed_scu_ic_variant {
> >  	const char		*compatible;
> >  	unsigned long	irq_enable;
> >  	unsigned long	irq_shift;
> >  	unsigned int	num_irqs;
> > +	bool			split_ier_isr;
>=20
> How does that end up aligned?

Will update with Tab.
>=20
> > +	unsigned long	ier;
> > +	unsigned long	isr;
> >  };
> >
> >  #define SCU_VARIANT(_compat, _shift, _enable, _num) { \ @@ -30,13
> > +34,20 @@ struct aspeed_scu_ic_variant {
> >  	.irq_shift		=3D	_shift,		\
> >  	.irq_enable		=3D	_enable,	\
> >  	.num_irqs		=3D	_num,		\
> > +	.split_ier_isr	=3D	_split,		\
>=20
> Ditto.
Will update
>=20
> > +	.ier			=3D	_ier,		\
> > +	.isr			=3D	_isr,		\
>=20
> But what's worse is that '_split, _ier and _isr' come out of thin air as
> SCU_VARIANT does not have corresponding arguments. So how is that
> supposed to work?

Mistake, will update.
>=20
> >  }
> >
> >  struct aspeed_scu_ic {
> > @@ -45,9 +56,12 @@ struct aspeed_scu_ic {
> >  	unsigned int		num_irqs;
> >  	void __iomem		*base;
> >  	struct irq_domain	*irq_domain;
> > +	bool				split_ier_isr;
>=20
> Sigh...
Will update.
>=20
> > +	unsigned long		ier;
> > +	unsigned long		isr;
> >  };
> >
> > -static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> > +static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
> >  {
> >  	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc); @@ -84,33 +98,69 @=
@
> > static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> >  	chained_irq_exit(chip, desc);
> >  }
> >
> > +static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc) {
>=20
> ...
>=20
> >  static void aspeed_scu_ic_irq_mask(struct irq_data *data)  {
> >  	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
> > -	unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift) |
> > -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> >
> > -	/*
> > -	 * Status bits are cleared by writing 1. In order to prevent the mask
> > -	 * operation from clearing the status bits, they should be under the
> > -	 * mask and written with 0.
> > -	 */
> > -	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> > +	if (scu_ic->split_ier_isr) {
> > +		writel(readl(scu_ic->base) & ~BIT(data->hwirq + scu_ic->irq_shift),
> > +		       scu_ic->base + scu_ic->ier);
> > +	} else {
> > +		unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift) |
> > +			(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> > +
> > +		/*
> > +		 * Status bits are cleared by writing 1. In order to prevent the mas=
k
> > +		 * operation from clearing the status bits, they should be under the
> > +		 * mask and written with 0.
> > +		 */
> > +		writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> > +	}
>=20
> So you have two different handlers. Why can't you provide two different
> mask/unmask/ functions along with a seperate irq chip instead of clutteri=
ng
> the code with conditionals. Thes two variants share no code at all.

I will add irq_chip in SCU_VARIANT, like following.

struct aspeed_scu_ic_variant {
..
+	struct irq_chip	*irq_chip;=09
};

#define SCU_VARIANT(_compat, _shift, _enable, _num,  +_irq_chip, _split, _i=
er, _isr) { \
+	.irq_chip		=3D	_irq_chip,	\
.....
}

static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst =3D=
 {
	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_=
chip_combined,	false,	0,	0),
	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_=
chip_combined,	false,	0,	0),
	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, &aspeed_scu_ic_=
chip_combined,	false,	0,	0),
	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, &aspeed_scu_ic_=
chip_combined,	false,	0,	0),
	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_=
chip_split,	true,	0x00, 0x04),
	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_=
chip_split,	true,	0x00, 0x04),
	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_=
chip_split,	true,	0x04, 0x00),
	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, &aspeed_scu_ic_=
chip_split,	true,	0x04, 0x00),
};

Is this ok?

>=20
> > -	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
> > -					 scu_ic);
> > +	if (scu_ic->split_ier_isr)
> > +		irq_set_chained_handler_and_data(irq,
> aspeed_scu_ic_irq_handler_split,
> > +						 scu_ic);
> > +	else
> > +		irq_set_chained_handler_and_data(irq,
> aspeed_scu_ic_irq_handler_combined,
> > +						 scu_ic);
> >
>=20
> Please get rid of the line break. You have 100 characters....

I will update by following. Is it ok?
       irq_set_chained_handler_and_data(irq, scu_ic->split_ier_isr ?
                                         aspeed_scu_ic_irq_handler_split :
                                         aspeed_scu_ic_irq_handler_combined=
,
                                         scu_ic);


>=20
> Thanks,
>=20
>         tglx


