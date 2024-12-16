Return-Path: <linux-aspeed+bounces-242-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B2BE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 03:50:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBQvq1QqSz2xjK;
	Mon, 16 Dec 2024 14:50:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::731" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734321047;
	cv=pass; b=SEbb7/OIM6gpdfYiFwJSLaTW+vvyLy7Jwp3yTh3NuV7nluEtwVzurCP66C/Hi4QyKPStsTGNX5IVWFogOemJbQwDVMdCu9Q37KGTlsureCUGUWluyTIQVjtSODC36UjqeHDuyhsYp/+suKmVKyaEDV8ImdJliyvjPTDHfu36hDiNLbcwNF2lLwTvSe5cAeNIAFHjamv+AbNO1KUtoJzxiMrnjt/pd7hbnXtfApEP70R1d3i482aWSJS0p+yVwK7A5iGZhEmFnLvqVELr4pLWHAUzyWhptXof/fHGG3sjqA11AmsdhzToPCogaoso1rLglZXgEF6WNGfh2TxM3E+L9w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734321047; c=relaxed/relaxed;
	bh=vk735xrshIJzBVZuOFT9BUeMPuG5pJ6QI6rg4WcABPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAis3FI1tMZNLDTxuJKr1D1jcRy58fRvZB07bnZ5hNa2HNCc/L2Wx++rCzfLg1NoLfjG30McANNicXE9wvw/CUVwnS54rRCQcVWg03w7n6MzH/aPkw9qUevUMZjmlSwf3zyK1/3Q0jD+gkHknhLD+hVSmH0wLVjps7bceAJIBrPvnj7SDDTmXKxfGNgAa8LJVadPTPewNoewi680cihJO/zbZ9sOnL3ibZpbJ1u5MNjHMPdv8PfXHIwXFycpxqJS+HSbXKW3d8T8zewJP2L/oxJLESIGY7iIFPL3UBvh4LonyzyA00eU4ZhSsTQgJ3+QtUhOOZUKI3wCF2YYHmVSvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=EEcSpylC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::731; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=EEcSpylC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::731; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::731])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBQvk4wRYz2xbS
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 14:50:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/xh+UpgQVWklSRb5ujJyVYySM59BTCiHbqKNk9IINs3DMkgogSK9rEcoeNs9y7jhh4dE2eOjaG+zkBM82kEeZCm9PhklNKFXMai6alGdgjTJvPviamTP4X9igeZ9Aorit1TMIyuqPs+pj/3A048fxg/FzcjSmXTSmK8YKtaYxl5TljQBo5llrTzl4XPuPe7ZIfzBV6bihYPIe6Fr/+AkK4eBRZi3k1hUG9qGCpLuC8ZR3Y7MSUfryBBR6NHdlyrJ9Ffey55m1HlTNuXBYxIMWcBg1qCkYpSnKfJCrAm5tRFWk+bu/pSMgX9MLKqyFO/7k9SE/GIhUmmRQX+16lI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk735xrshIJzBVZuOFT9BUeMPuG5pJ6QI6rg4WcABPI=;
 b=KG+1QB+TA9kYQPfBASzw1erX5vLRRhEoZhtfrI9mCsH4R21PqgVDuKssBIqwbZB0Qp5QeWumj76/yubklX+OCSozIMiUivmdbU/mLJ3PsOXGFJg5YXMuFtPt+57Opbc+qzVr5Vr/XP/DoV+VoWaLQUJNykNBtMcxxTveIsW2IsK0Nm+LltcX9a0SecTLdrmeCF77kiH+0Y4CR8mAgR8zg63e/Nh4mM9CrzQmo8nJDvaY/Xvn/ApA+FhbjGueahBNA6SGRCFRA0z6G1RNbsN0EUy1DE+r+9SbZiKMgIDx9BJHaxx37iCZqKp1kqBwXCopy4PbbmhsYjyfqv9bIRILSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk735xrshIJzBVZuOFT9BUeMPuG5pJ6QI6rg4WcABPI=;
 b=EEcSpylCYNG2i/VL+T70FwLeYyTDGl4WXz9E99RsFM0fYSuVCMq9U7TBz+pm+FBjMWUvgukHZz/ibUeFWUlPzNNrCUNXeeb0EgZoJAM3UPAcMiohX3szAN7BlLH5UJpNoeEs63WQY/wPdjlC/RJudI5R+lKe6AI0YPBg6CKVcaU3iRCsqhsGqzRNRUUN+L0aEi/TBxq27305sKfDrxvW07+dLKQSglQ7UsrK7OdzvvM267anFKdkHJx7i91nEQRzkcpeQq9IdPa3haXfiH8Kwc7LAMXK4c1qaVbgnZt37m9g8bpq6WpfFSrZAnXVdBbE4ZE8tPMb3T+JRZncBiHzlw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.10; Mon, 16 Dec
 2024 03:50:24 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 03:50:24 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"konradybcio@kernel.org" <konradybcio@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Thread-Topic: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Thread-Index: AQHbTK3kC5Kg7l8oJUKHP7lHHpriK7Lj5HcAgARcskA=
Date: Mon, 16 Dec 2024 03:50:24 +0000
Message-ID:
 <PSAPR06MB494997E9578D2E2E745AC90B893B2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-3-kevin_chen@aspeedtech.com>
 <k7jftzlih6ss4yaxrv7r4dudhcu43iyu2qvkl2thb5wiaszto7@evzmwfxxzzt6>
In-Reply-To: <k7jftzlih6ss4yaxrv7r4dudhcu43iyu2qvkl2thb5wiaszto7@evzmwfxxzzt6>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 5c0ef7d8-0bda-4e2c-da79-08dd1d84c579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a01vdFVmdjFGTzJpQ0JTWVp5UnVFZTRyR0NiY3pvaU5LWFhJRE9MWU1VUlM2?=
 =?utf-8?B?bmdRMkFTRURaczNDbENyc0lmdzUycVBsNHJhUTZyWDgvQUNQc09hVmtqR3N4?=
 =?utf-8?B?YklyL25PMmMxQndFZGJ2WVVDY015ZkZlUWloRkJ6cThZSG1tK2RiLzduMWZV?=
 =?utf-8?B?MHl1a2MvdTBEblpPcXNiN2lPb1ZFTVpGblNDb1hnczh0RGorNTZSL3RGU2dO?=
 =?utf-8?B?UXZRU1k1dE83Z2lhM1J0L2ZCUTdyelBET0xoSjFqMGw1NDdyc21nQ0JMRkFy?=
 =?utf-8?B?RXVsV2JoTko4bVBnU2lCcDA0aGdYdTFPbHdvS3lxd01zREhSeHFRL0dQdXlX?=
 =?utf-8?B?djBoUzdoQlhvbWlIK1J5c1VkT1A2U0xQRG90VGFjeHFod1c4dlltQWlnY2tn?=
 =?utf-8?B?NnVWRTJCN3hyMXpDWVpaeU45cTdxbHM0dlVBYm9JanloWnRZM2NHcW9XcEVr?=
 =?utf-8?B?Sjc2ckhDUWxQUDNNODJVbksrUE40M3lJSDM5dG1VYlFHcklwMk5Pd0VXS2l5?=
 =?utf-8?B?VmVxVnlCRzZNV1JESUJWL0ttcmJnL2xkRVRhZFlzVnNJNko4dnFoVjF6cXVo?=
 =?utf-8?B?YmcvK1V1cGd0WHdVNU9lQVZTeVhORnI4UUMxREpzbEtGWVplWnZ1ZVdRRU9Y?=
 =?utf-8?B?VUswTmlkSXBnV0ZZdEtkZHV6cWFDaUxzU3VxR2ZWZCtPVmx1bXNaZGx6Umc1?=
 =?utf-8?B?QWJDN3ZnWXFoNml6MmdIdUtlNlN6OTl5dVN2aGg4TmMyT214N1FKVFRWbWZG?=
 =?utf-8?B?M2lldjhZT1hxWUY1UE84dGJRTnhnTEsrU2wxZi91ZXF1Nm94ZUUrWWFwMm1N?=
 =?utf-8?B?dlM2VkFiSHkyRzdSTFMwOVFkSi85MCthU1JOOEJTU09xdnYrd3c4Z1F1SnVC?=
 =?utf-8?B?bUFhZi9Pc1l6VGtrNnJaR3QrcXozUGV1UnluWEI5VkVUU0tvSXhJSkt4T1E0?=
 =?utf-8?B?NUpkb0Vla1l2M2w4T1dIQ2RndEFoM1NybXVobWxvWGY5Z2l3QmJFODByWFFK?=
 =?utf-8?B?TGFzbmlRRi85MFd4b2k0SWprTytoNjd0SDhWVjRTd0pWU2VSaDFBcFNhcHl2?=
 =?utf-8?B?K2tiWFFGSExmY2dXajBxbjZNNVpVbk9SZTl0clZNRlBOT3lhRE1jcGU2R0tM?=
 =?utf-8?B?M1hEUGNGRkZJODlYZ2VFZ3BZbDNGa3dWMXh1Qmd1ZkVaYkNjWHh5TnAvbmhO?=
 =?utf-8?B?WFJ4V2o5aXEyaTV3YTR4YTJlQlA5NlZvQkhwNHREdUYxejZFcjlrMEt0aFBt?=
 =?utf-8?B?Ym44M0QwbGlDQkFLV0xVTHk3dmRreitiZWpYN1prUStUOXVKT3I5RWVyWnd2?=
 =?utf-8?B?NTQ1MlBLWmIvUnFIc0pBcUFkbW9JRGtZZTNjb2tVSE5nMXRUVW9ISm1vOVdX?=
 =?utf-8?B?QXZCanJ1SXptL2J6TU93RjJBczdNU1pya1FlNXYyeVUvWXdnSjNjSU9ZYnl0?=
 =?utf-8?B?L0REcFpuemZtUXhkcWZyK2NVYVpSNTNGWElrRmtSYTNtMVRVWTQ5dUh2bnZM?=
 =?utf-8?B?YkVTc1ZMaGh3d1J0Vks5UnhzczV4K3luN0MyT3IyWk82a1BGOEVNVlU4KzZr?=
 =?utf-8?B?Qlc3OUdOU3RwdHhRK0hySXJxSi9pTmxOSWlld3VHRVozZzBmcTRnd3hNSjJ5?=
 =?utf-8?B?TEUrcEVxMC9xM1VDN3I2WUlMcE96NGV4bUgrOGdudUtzaWUvSXV4UHAxSlhw?=
 =?utf-8?B?ekVwZjVlaWppQUNFSzh3OVpVanh2YmdSUVE4d1VqNUZFM0t4Rmt4T2N6L2tt?=
 =?utf-8?B?TjVQTWx3LzRsV1hIdFhESC83bk53RTltTXhLSGdYdDRFSVVWS2pzUDFZdjAr?=
 =?utf-8?B?QnpiUTA0a21aYzRnN212dXVreHpObzZyWXBQaW9nZTFiZ2FWYTNXcjI5Q3JQ?=
 =?utf-8?B?YWhuLzhqK0R3WTJKNXFUMXBIeTJwclNKdkdsemJsNVN4T2N5MENRa1lJOHdt?=
 =?utf-8?Q?dCcRgb0AvH6Ul64QXXc35WLE3r8awu5/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0lUNzMyTGJsWEt3RGZ2bHRTVVJmUWMvL25PdXFnUTM5Yk1QekdyS0ZyWlli?=
 =?utf-8?B?Uk51SjFzYlFZWnhXL1g5aS9Gb1BEWlhhYWF3RnRaVDZUc29SUEdzSHNxZ045?=
 =?utf-8?B?bXhpTXlFMDlJNk1nSldEMlZSZkovN1B3VDVnVjVJNk9kWitQaS9Wc0lPZUhE?=
 =?utf-8?B?dFVGQndId2JmdFNGdWdNUlFqODlXZExFUGpmOFp5eGtjSmlaV2trVm1XT2tt?=
 =?utf-8?B?Q0VQa3BBek9KWWFIMWM5ajdjaEIzVk5FdXowaytnMlMyYjFBRkEzdFlaMktD?=
 =?utf-8?B?UmZTb0FnY1RjZWhPdlpEY3AzUWJucWlORTY0YmxCVHFtYWwxMXoxK0MyMDRr?=
 =?utf-8?B?a2I0WEJXUHAzN0l2Z1hma29WTkRzV3IzZk5ROENocFA2M0VJbmNOaDNIRk1l?=
 =?utf-8?B?d0YrUnRIOUhFbG8xU3BIQVJVU0lWQWJ1QVlSTTJHOFFlSkJrNEE0N0xPaWww?=
 =?utf-8?B?SDM2Z3BpZ1R4eDZDRFdleDkyejk0djEwUzQvU3dIaW9FSTZRVUU2UmlYMWpn?=
 =?utf-8?B?RTJIQ1h1SjJ2azRPd3pMYnVTVUkzT2o5U3dHdk5KMVBYL2tLNTB3bC91eEVx?=
 =?utf-8?B?K2p5QUVVQ1FMMU1ielZta0U2Vkk3QXNxS3pkV1h5Qkk0aGNFamlKNzh5cFV2?=
 =?utf-8?B?M1pCeEVCbHNyK2cxa3RadW9KblplTmhNZHNzMGNvQjllK3ZVck9KU0VsNmxY?=
 =?utf-8?B?MWltcWtPanl3aHh0QTNBZ2VxVUlCYXlmSWVIUC9JdUMyUEtrdUlTZmlMSkZB?=
 =?utf-8?B?Q2R3MGR3UTU3UEZvVU42R1A0OUh2bEJpZ0lpQ0lqVGFBNUMwU0c0bHFMeTVz?=
 =?utf-8?B?QWc1RXl5YXBwWDBLVkd3YXI4NGpNZk9WcjA3L1hHdVB0OFd3dTJoNzl4RUx5?=
 =?utf-8?B?cUIzN0xoOTRkbHBCUDN3RTIxSDRFMGNjMGdsd1IydFhCN2tTVm1xMTdSL2ZC?=
 =?utf-8?B?WWtiTndWQ3RmS0pFTE1JQmtKY0w1UmFPU2VKQUJGS2t6MHJQcG1nam5Ublkw?=
 =?utf-8?B?NlV0TmJpd0R4VEtPNE9PWm5LZ1ZOakZyM3Zpd0RTR0c1VElNbzVDak9hdXhx?=
 =?utf-8?B?aVQwOVZSeE5SMXVEUzF0ZHdPa3doQWY1a3BZZnNYMUg0a2U4YnlEbmdhM1Bp?=
 =?utf-8?B?WmJjRDlPYXNCVXBKM2lPWEM4eWRPQ1VhY3A3LzU2WEdkdkpZU091NjBzTk9s?=
 =?utf-8?B?WFlUdldQT05oM0tRRWhqd0ZsNHVzbGk0NXhvbjdrcUtXdXJNNEp3UmU2RXJ5?=
 =?utf-8?B?dmNZZlFkMGYwbmtKQWVCSVgrb0toUldCeFBMMXFSdkRPbEZXeW5ya2dOMjZv?=
 =?utf-8?B?ZEdmNDkyMW1vbEhpOXNRV1VoenhTQTluOXgzcHRvN3FITGFrSER2czY2Mm0x?=
 =?utf-8?B?WDZZMUFLeXIxNStNb2lCdUFpZUpQUHJpZXdoQlhUMnNGNkVQVzFsUGNpUXc5?=
 =?utf-8?B?dDV2Q1ZRaEQxdDJuaWZQWTB1NzJiL3M3c3MvZ2dSc0J5N3N2dzFmSjFTQjRR?=
 =?utf-8?B?eWhESjNiV3c2ZlV4RU1wMm1sQ0JwUklLSlBDSTl5NVVxcmp4WDBBaFlxYi9M?=
 =?utf-8?B?ZUh2WTRTaFJKS1c1VWZJOUQ1RlVnVFI5aC90cFFNRk5rZkJaaTJCTjArc0xp?=
 =?utf-8?B?OHNFcHFNdWRuZkI0UXRsMlZHU09PeHgrcEMyblhtZFk2blJMZ3UzcGlMV1Jt?=
 =?utf-8?B?aXFicFI2Mnc4L2FUQWZkNk1MenRWTlpNUUw4QnZqeldLZ1Y4aHFlNkdjQUEz?=
 =?utf-8?B?ekpZQmtXRVlKZEdvRkl2YmV4eWlHdCsrSVJoYis4UGt0L0Jsek9jN1AxdTFM?=
 =?utf-8?B?dkxlTWVvRXU0eWZzMzZlcXF6eGUxdDNIczJDSE1qTUdhV01pVGZoYVA2eHF6?=
 =?utf-8?B?Z28xa01WNW9yZWRjS2FIMkQxTjcxb3dYWW5yQ1pGSXlZYi85dWZFd25nZkhy?=
 =?utf-8?B?cWJMNUJleW9DT1hCOWJCejhGOTFOalV4bGJKZmp2Y243U3lCdDhFc0lraHZU?=
 =?utf-8?B?bndHaWpHd0pIK3lGcWtzRDZtSnJyb01Bd0R0b2VWRWVJcnJ6c2tER2c1QzlZ?=
 =?utf-8?B?NFVPcEpZZWdDMDdSS0pZL1hFWTdjelRTWHRJWk8rWUpyM2dVMVJKa0ltcVlL?=
 =?utf-8?Q?u+yzua5QtbPOjsxpHiuccVJxH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0ef7d8-0bda-4e2c-da79-08dd1d84c579
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 03:50:24.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoSoBDMm38jxGx+uZZM/nbEyoI8cTmpL2eiWMa7rC2q2Iytj+n6nBk0yn+xS5/LxfXyLPXB2LrHRshExMOfvoR4/4IKV6KTZEkgMxNP4uLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459

SGksDQoNCj4gPiAxLiBCZWNhdXNlIHNpemUtY2VsbHMgaXMgbm8gbmVlZCB0byB1c2UgMiwgbW9k
aWZ5IHRvIDEgZm9yIHVzZS4NCj4gPiAyLiBBZGQgbWluSXRlbXMgdG8gMSBmb3IgaW50ZXJydXB0
cyBmb3IgaW50YzEuDQo+ID4gMy4gQWRkIDEgaW50ZXJydXB0IG9mIGludGMxIGV4YW1wbGUgaW50
byB5YW1sIGZpbGUuDQo+ID4gNC4gQWRkIGludGMxIHN1Yi1tb2R1bGUgb2YgdWFydDEyIGFzIGV4
YW1wbGUgdXNpbmcgdGhlIGludGMwIGFuZCBpbnRjMS4NCj4gPiAtLS0NCj4gPiAgLi4uL2FzcGVl
ZCxhc3QyNzAwLWludGMueWFtbCAgICAgICAgICAgICAgICAgIHwgNjANCj4gKysrKysrKysrKysr
KysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQo+ID4NCj4gDQo+IEFzIHdpdGggYWxsIHlvdXIgcGF0Y2hlcywgcmVwZWF0aW5nIHNp
bmNlIHYxIHRoZSBzYW1lIGNvbW1lbnQsIHNvIG9uZSBtb3JlDQo+IGxhc3QgdGltZToNCj4gDQo+
IFBsZWFzZSBydW4gc2NyaXB0cy9jaGVja3BhdGNoLnBsIGFuZCBmaXggcmVwb3J0ZWQgd2Fybmlu
Z3MuIFRoZW4gcGxlYXNlIHJ1bg0KPiAnc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0JyBh
bmQgKHByb2JhYmx5KSBmaXggbW9yZSB3YXJuaW5ncy4NCj4gU29tZSB3YXJuaW5ncyBjYW4gYmUg
aWdub3JlZCwgZXNwZWNpYWxseSBmcm9tIC0tc3RyaWN0IHJ1biwgYnV0IHRoZSBjb2RlIGhlcmUN
Cj4gbG9va3MgbGlrZSBpdCBuZWVkcyBhIGZpeC4gRmVlbCBmcmVlIHRvIGdldCBpbiB0b3VjaCBp
ZiB0aGUgd2FybmluZyBpcyBub3QgY2xlYXIuDQpPSy4NCkkgbmVlZCB0byB3YWl0IHRoZSBSeWFu
J3Mgc2VyaWVzIG9mICIgIkFkZCBzdXBwb3J0IGZvciBBU1QyNzAwIGNsayBkcml2ZXIiIiBmb3Ig
Y2xrIGFuZCByZXNldCBkcml2ZXJzLg0KSSB3aWxsIHdhaXQgZm9yIGhpcyBjb21taXRzIHRvIGJl
IG1lcmdlZCB3aXRoIHRoZSB3YXJuaW5ncyBmaXhlZC4NCg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQo=

