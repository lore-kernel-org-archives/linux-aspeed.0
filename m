Return-Path: <linux-aspeed+bounces-2026-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4916CA0EEB
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 22:53:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7JWP1hWwz2xc8;
	Fri, 22 Aug 2025 08:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755757104;
	cv=pass; b=ABz+l2rnZzDtCCrl3F5+JjJNCJTkjtM3bz9Ub7cPLL0Jy9f92kAZ6RHBLVI89I/DMRKOdDegrb0M5WxDGF3oQxVesmwR3WxElxOXz7cbPmRnE2KXkHVLgcwhctKpx5MfOk6GYKAXUSIh//z7SATAgOiPnZj0krD8s46ZWmgrWkq1mfQXSi55wsYRu3NYb4NU0R6+jwNG76nN+z5LMu9QjmM9jz1FzdWGccWjULl2rDzl1+nvkHX9fGME55mQxwqc/da3sllj//5TOrF0U/TF4KE2DEJDaDtxk7BdVm91sIULYCvXFeec82oYEbic7gdzWVGSVbXtnENhYNOgp1yyog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755757104; c=relaxed/relaxed;
	bh=hikl87s7nbVHqtxNl3T7mm5IlIawP+wQ1Ehje/pvpNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoR97ixyznqKgpAtGBiBASkXhctSI3akRVJixfnQkb+gOjDLiAihrWhaCiAAML7nhf0QcRc+cL21bmelkWwjjUCKO3SYyzTVbIpfGKc1HiqBWh7bFLHVlc6AEhjCamkCCkZhlRq/ehZOiNLrVOR6A7an69Em7YDUVW6s+bULx8Znl6Euhi3O0a2cpJwruxCs+4Gs8Z3JVO9v+j51Nn+cfUHXhvvjRsnz1hx0iymBwgy1kYmfh4b/yYiU3tudDVWRrZTh08iyZN3fSjno5A0parkl22yTBCHCjd5MDGffns6Xf3QLLbcgJBBytvEwzIZAHCCkdqze1XO1FIv5JREQMQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fsIFj20F; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fsIFj20F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6tRf1pWyz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 16:18:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbwqEVHUiZAN+7rnU3//1ZJPutj0frgG895I4M3BAR1vBCNJl6bnqWKoq267HkLv3uoaeOZgD7Y+SJj3N7GNAgu86sFbwPonTAGQ4R1jktf2wi0FOSMvcqeKeDS1FPJ0li6LydnvQNd17Ji7Sq30MWTGbtjaP9A9kXuodcpvnBaqblvdaVuhJSifsTOGjnbZCL2bwWjPOv9jf3PZUQnxPSkc+s0zVxVgQxPxPGZEoi6AzScpWdOrSh/QoO8099Gvlbj56wkRWvurqFS4867lfqodK3y37sgxewAWATMK7womWzdSt05lPNTbJCRkeJupnTRmkltNoZplCbCDtNTQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hikl87s7nbVHqtxNl3T7mm5IlIawP+wQ1Ehje/pvpNU=;
 b=U9ryiO7yNrvqqNtLxBs+8Po3tA2P24nrl5LngwWiI/JpzclF4USshkekCAmHk+JQzlgXYjTCMbuows30Hpv9hfjkHbiAWkSIOQxrX46aZ+e32m1DNn9DRJzXxniqZ/8WZoSeuv48rve2HHACLYvLHg2Y8DcsnYInSVQ6AMigwTvFmuVLKeQGsOsV8uDXt/BnU+1gSTx1piN+2FCc44dIHK4WqX7+MjMGzs+t9HZEVMxSsYcEjIC0OR2FkPgHo+u9zp/GcBBLcgMVexIgh5KDXiKa632csgOACVel444vXjsXUQXF1vGJuxA1SmnVdeEK2TE8TIYA0O02B/aeKsKE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hikl87s7nbVHqtxNl3T7mm5IlIawP+wQ1Ehje/pvpNU=;
 b=fsIFj20F+sc9aZi48E8RtwXMTyQy6v2XeI7Hso8AulePhas6mEXGlM4C2DBwsAnGkOqOpQYOW//I1AAAk9lWUQVaRVRY5clYCwCah38gib1aD/zIr/oJNEEcnHePBgrLk0GTwJRaT1+JuDLhZ4voNV+w1QqCCFRXCaP1mez8VWv6IMQb+VhqBylMYL/PJX0XEYlC1iwJw3MK/8ZW9ANElZd0ELv/rs22sv+drBR5bKonv2ftm5epLNc7TXxDmfgyoiXTvKCMpqei5Pf9IXzdjiDFSylHRUzj8qhVoonJIcMr5v53RPyUX6TYfAX3+jAyTH2MOFB80M0S/sB8Z9SAqA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 06:17:56 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 06:17:56 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, Z-Howard Chiu <howard_chiu@aspeedtech.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0XSBBUk06IGR0czogYXNwZWVkOiBhc3QyNjAwLWV2Yjog?=
 =?utf-8?Q?Correct_phy-mode_to_rgmii-id?=
Thread-Topic: [net] ARM: dts: aspeed: ast2600-evb: Correct phy-mode to
 rgmii-id
Thread-Index: AQHcElwUrGwcYi9MjEiGcSHwQ2D4GrRsn52AgAAAn5A=
Date: Thu, 21 Aug 2025 06:17:56 +0000
Message-ID:
 <SEYPR06MB5134106F024EB9EC32472A329D32A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
 <80723310-97e6-45ea-8154-c48de40e14aa@kernel.org>
In-Reply-To: <80723310-97e6-45ea-8154-c48de40e14aa@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5936:EE_
x-ms-office365-filtering-correlation-id: ac460aeb-bf25-4da3-d96c-08dde07a7835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0VPZG52YWtaVVVkRC9temZHYkNUMktIZmY1TnF4SjcvOWdRTTdZTDdFZVF1?=
 =?utf-8?B?WEJUNmFUOU9Zc1pDTWoyVHc2aXBiWEI1c0dpa3dhSGF4U2NiaXFNbE43b1VK?=
 =?utf-8?B?VE9iUWRWVUlkNzY2WWM0ekhjNm9SeVMxNzZzYWdlVlVEbHIxbzdQYmtFSFFD?=
 =?utf-8?B?YXFQcE9BMWwxNFJoZlFXWnFsZEl6UzVhMkRDVys0RS9FenNuLzJIU2tpM0pR?=
 =?utf-8?B?dis3TUF3dnhPSm5hTHAvaGRjYUtQQmJvYzVVd2tQTE5BTkRaT0o5WXlRYzRl?=
 =?utf-8?B?RFdOMmttVHk0em15Z3d1NUg4aFVwTDRPRUNTYzZsVnlFT3BqRzU3R3Fzdmx0?=
 =?utf-8?B?Q0lxdmZuckJpOWJJbGF3Rytyb1RlL2EzTm1na1A1NGJva3QvTGlid0RsclVD?=
 =?utf-8?B?cXd2eE9kOUtuazB4dTVScmtlQUFsS0VzZldYTTJ3UGlEVU00WGo3cmE2V2c3?=
 =?utf-8?B?ZU5OUmwxbEtHanA2M3dmM25XNjNHTnRPUGpNeTdZQmNIUmh1Q1plby9tUUY5?=
 =?utf-8?B?R0pwQktkZEZWeXIvWDRqM3NBektLdmtYb2xTcVNiSEhIdk5sN3lNUGdHK2sv?=
 =?utf-8?B?azVIUFJxcVJRNWQ2QlFDTER0RHY1Z1RBZWVZYm43TDZTWEFWeHdhZ3FWU2lB?=
 =?utf-8?B?UnZldDBOYjJFTkpyK3NTSlprSlE4MlZrWldVTnJnQnpSSm0yUFY5Y1k0ZDYr?=
 =?utf-8?B?NFhZNGlvb1psd1lpb205c2d2Z1haejRWTUJ0VXZYY2pqSHZBaHZXR0JPSER1?=
 =?utf-8?B?RzVmTGtpQThzNkZTUWRjd2w5NTdPMVo4SnJqTk9aSUdkbG53S2xYUE91eWZO?=
 =?utf-8?B?UFRmRTBqcEV4OTRxT2xGdmFmdXlzQVNLZHNlMkhpQVZ0bVJXSHJQVnJ1bFky?=
 =?utf-8?B?TXVGVGh0dXVsQkZvVkdLZ09DTUUwOGMwaXoxeGRVOGlEcG13Zm9XVFFOdXdH?=
 =?utf-8?B?eVRlZHdsVDBZU082Mkk0TXVKSzBVSVNUVkJxN2wrc2drV1RIeUx6aThtOWE1?=
 =?utf-8?B?c1ZiRmhWVlE4Y1pjMlF3dDAzem11OFlzYzVnSjdvVVMzbTBnY2FiUVpIOXRJ?=
 =?utf-8?B?T1g1OXg5RloycTg0RFgxSDhSTlBRdGxxdGtsSW1SZUdVNUFlb1ZHazFNc0pr?=
 =?utf-8?B?MllPOWFLaG9OZ1Q4bi9mNEM1NERXclZHMjBrUFZrYUg2dDB4SXJXWk9FOHhO?=
 =?utf-8?B?UVZ5bm9tbVpPSUNSbkxGbE9rUHJVcy9BbkxhR2F0azRWV3ZSaE1kTFk2emlq?=
 =?utf-8?B?TFFEWVRQeHpPcWFMM3pJOUVqekR5czhWQmQvNVZRbitzZWpIWEM4N2VwWTZL?=
 =?utf-8?B?NlZyZ1NwR0JUT0FEOGEwOVdKSmpzczdGQVBMbUdTcXZmcnlCOFZEcXFiRGI0?=
 =?utf-8?B?dmJvWjJwaUg5Y3lPMkFtR2liYjVwQnFONm8rTlpjZFkxSWFndXBuOWdRbFhJ?=
 =?utf-8?B?eVRrMkRZOGJEQWxZRlJGVnhOS2t1Zy9iNThvZmpzWnQ5SktVKzgweUJwY2FN?=
 =?utf-8?B?U3VkdVM2MFlZcDVSYzVNQVdPaUlsYlhWSXZvMHNMYXZxSjVtNnlTR3VnaHEx?=
 =?utf-8?B?Z1lzWFhXeXJ6RXpSQmRSbXphSU13eDNTYm1wbnBDMmdmQngxM2UzQmJ0elor?=
 =?utf-8?B?NEdhQ05XK043UThXMHNjWFcwUkduNWRuT1pmTlZWVDhtSm5ScUdsbVRjOWhO?=
 =?utf-8?B?dkl5bGMvOGRwTjJ3emJIeFBEQnVvWS9nWmlNTWZwU01ZM1I1ZkUzL2dOTThW?=
 =?utf-8?B?Vm1uSzlZNWc2QnlZVUZQWmUzYnJkL3p4UmJsSU80SXp1M2NHTXBZdWx0TlVH?=
 =?utf-8?B?MjI1YkpleUVzeXdpbzhaSW1vMzRleXNlQVVMNlZKZGtjSHRRQkdNd1NIbjZx?=
 =?utf-8?B?T3Y5MkNsUzJuL1lmU1VWM1ZicVFXVWRJY0VYakhtdGxBR3p0MTZrZHpvNGlU?=
 =?utf-8?B?TnovZzV4OXYrWW1CVzhjTmtiMEFzY3I3c0NQQkJtcFZheFVEaVpJVXpmSzF2?=
 =?utf-8?B?bStvbUdzdjJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2JIcFRVdVV5ZkZVckR0TUlrTU5KcG9yVXJFZmk0cXBSeXBYQ2gyM0hXeVVz?=
 =?utf-8?B?Tmc5azZLeGhkMGp2cjd4cmt3Vy9VaXA3RFNtT3dkYXZTT2VTZHZzbVFrK1dn?=
 =?utf-8?B?eGN2cmN2U1o2S3dKOWhRbURNdXY2MEZ3dTZtcitjNDhYOVI2SlRzejZIKzlG?=
 =?utf-8?B?UGExZjNXUy9PK2QrVlZyS3YzS1Y5bURyVmk4WEJYUmp0NWlxcDFtcDJkbHhT?=
 =?utf-8?B?QlFGRGJxc05tVTF6ZzZYY0VFUTd4aVY4MnFJcitvRmFCTzdXaWhuLy95dVdJ?=
 =?utf-8?B?UjVqQ2FyejljOStNVzZSSUM2L0pOdTdrSlBUWDhKdFd4MDMxSEd2Qk9JQ1Na?=
 =?utf-8?B?SVlDb3JQM0F0MGxXMUo1NXBOWEVZMFNObFB1aE1ta25ldVk3aTZ3Y0hOY3Nk?=
 =?utf-8?B?ZHJMT1NESldLL3RnNmdqUEFRYkY1eWNtaGJsOEpMNnU3VUlvWjlkRHpNRWRl?=
 =?utf-8?B?NHBXRkY0QWhlWVV6dXMxa2dyYy9mOHM1bXhxd0Zqc3FPcFY4NzRBQUF2TmJi?=
 =?utf-8?B?RTY2ME9VdzhIZ0pSdE41YWdtdzlWUm15S1F3eERxM2cybjc4d0FBYTlVY0My?=
 =?utf-8?B?ZkJ4MGFtMGZsR3JxNjlQclZyOTFTQ1lsNzJUVC9QWlpBcktuUEFPczBiUjVi?=
 =?utf-8?B?T2ppZUhGcFVXNFpuUGhZSFFOMWU1OHU2R0lrdmsyd29oNEVVRlo1UndCRmJP?=
 =?utf-8?B?UllDTUJGdjZ6TzNPeVhCODFYdmhKQSt2OG91TzkvcGF6SkV5bnBxbDMxNlZB?=
 =?utf-8?B?YUNkbURwMWlDY09EUXI5cVVRR0FJZ0RQKzhVRDM3UCtXMDhsVEVZUGpFaTJi?=
 =?utf-8?B?bVB5OFMvQlBGS2RTL1hFdldVV3A4M1VRZUl0bDh2Zk9BeGRxSHExaEV4elVN?=
 =?utf-8?B?SU5uQURxa0k5NncwS0k1NzJOSWpqbmlpNWd0WnAwK0VkMlpsemE3VXcrbVRi?=
 =?utf-8?B?bnhPVzNRQnFpZHNBM0p6b1Z5c0pwK1E2R1BhRXFTbUM3MGs0SW9EQWtLb2Z1?=
 =?utf-8?B?VXROazVDR0ZtckMxS1paQzM0c1VGQ3ZGZG9kTHZwQVRXOXNaRlQzRCs3OWQ2?=
 =?utf-8?B?VFQwVkNMMmZPZVo3bE9iZWk3V2s4a1pESXZDbnhJYVhHdVNPUjFHRU9jbC9q?=
 =?utf-8?B?UVVOZ0tHektzc1RIMmFrOE9EQjZDclRPNW1sK2RLVkNtSDdNUkJhZk1PanFX?=
 =?utf-8?B?akY4VTc1K1BkcnJjNzloSU1aMGxXUTJqS0pydVg0c3gwQ2RvRzFCN0VRUWlM?=
 =?utf-8?B?citZVktDaE9mUWpnVllmWlYzR1ZITlh2T0tGblFKMUdRaTZPdEtFSjN4QlA5?=
 =?utf-8?B?QTJEOUZBYVVBRWhxMWdWa1l6WFNzdGRDS0hnNy9qc3g0U0g1dFcxajRFeGxu?=
 =?utf-8?B?M2hrZEVqb3poSFpvT2xuM3NFaHpHTEdYclFFcEk2NXNLaWxtOG9wbGpIck9t?=
 =?utf-8?B?bUVLOW9ZQTF0Ykw5K3Q4QXlOa25kcEc0cDRQY2Nub0N1V0ZuZHNLam4zRERj?=
 =?utf-8?B?MjVIZWZtNjllaXRwZ2JDR1drdENmRkxEUGpWemFTY2tQcDBiVnVGNk5RWlpF?=
 =?utf-8?B?c1JWRForZ3o4U1NlZHBDZkFxVTd6ZUhZSzJKSFZsVml0bEtqZkkvU3pTS0Y5?=
 =?utf-8?B?WFJ0aEVjMERzTWUvS0dtU3JPL01kYUhyR0VlMk13bHNFNGplYk5vcE5MY3NO?=
 =?utf-8?B?OXB6SHN0REVnZjVHbExCczhvWVY5Q0hnRXY5Y3pDTGxoeWphV1VRRkNUb1Y5?=
 =?utf-8?B?cHp6SGIzdTRDUUxKSXVCS3ZJcHVMaG5JYTVndnVpeDBqK3B6bnphS0R5SVc3?=
 =?utf-8?B?S09YaVE0ZG9HSWU1Z0ozOWszcllRZzR3SEZZRUE4KzExUzN1VVVIbjE1enRZ?=
 =?utf-8?B?S1NTbVNEeERzTWlOb1B0NVJsR1BSeTRIL3F3eHFaZEUweTlVdExmUFNyY04z?=
 =?utf-8?B?b3hDY3crUEQrUGU4VW1sYStUaXZONU51eFp5NFJHRkFWbWRlWEhraUNRWjhT?=
 =?utf-8?B?UjdRdk9pam04Z0JJNCtlTEMzVnlSMWtWYklzMnFjMGJVeDI0SWk3cy9WekM5?=
 =?utf-8?B?MVFnczM3dC9hOFBnakNlQzVPaFd5NzUvdEptcW5Wc1NLZ21ZMW9YWEJWMjBp?=
 =?utf-8?Q?Dif6hs72Ed9JZerULXiAAlQRF?=
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
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac460aeb-bf25-4da3-d96c-08dde07a7835
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 06:17:56.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/DIQVnmLMecqcCiwS27sSLk/2JQBq18LaM1WLxSCRRWp3KiME1qbpKmd61D5+WsUlX+WRwxSpfgEzx2USdQpodHGurrmb1ILRpp3vsi9hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5936

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBBY2NvcmRp
bmcgdG8gdGhlIGxhdGVzdCBldGhlcm5ldC1jb250cm9sbGVyLnlhbWwuDQo+ID4gU2luY2UgdGhl
cmUgaXMgbm8gUkdNSUkgZGVsYXkgb24gQVNUMjYwMCBFVkIsIHRoZSBwaHktbW9kZSBwcm9wZXJ0
eSBvZg0KPiA+IGFsbCBNQUNzIGNoYW5nZSB0byAicmdtaWktaWQiIG1vZGUuDQo+ID4NCj4gPiBG
aXhlczogNGQzMzhlZTQwYmE4ICgiQVJNOiBkdHM6IGFzcGVlZDogYXN0MjYwMC1ldmI6IEVuYWJs
ZSBSWCBkZWxheQ0KPiA+IGZvciBNQUMwL01BQzEiKQ0KPiA+IEZpeGVzOiAyY2E1NjQ2YjVjMmYg
KCJBUk06IGR0czogYXNwZWVkOiBBZGQgQVNUMjYwMCBhbmQgRVZCIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKYWNreSBDaG91IDxqYWNreV9jaG91QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWFzdDI2MDAtZXZiLmR0cyB8IDggKysr
Ky0tLS0NCj4gDQo+IE5vLCBEVFMgY2Fubm90IGdvIHRvIG5ldC4gV2h5IGRvIHlvdSBwcm9wb3Nl
IHRoYXQ/DQo+IA0KDQpJZiB0aGVyZSBpcyBhIHNlcmllcyBvZiBwYXRjaGVzIHRvIGFkZCBvciBm
aXggYWJvdXQgbmV0d29ya2luZyBhbmQgdGhpcyBzZXJpZXMNCkluY2x1ZGVzIGR0cyBvciBkdC1i
aW5kaW5nLCBJIHNlbmQgaXQgdG8gbmV0IG9yIG5ldC1uZXh0Lg0KU28sIHRoaXMgaXMganVzdCBj
aGFuZ2luZyB0aGUgRFRTIHNldHRpbmdzLCBldmVuIGlmIGl0IGlzIGZvciBNQUMsDQp3b3VsZG4n
dCBpdCBiZSBzZW50IHRvIG5ldD8NCg0KVGhhbmtzLA0KSmFja3kNCg==

