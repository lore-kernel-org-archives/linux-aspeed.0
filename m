Return-Path: <linux-aspeed+bounces-185-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6CEE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Dec 2024 02:06:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y64wj3Fsqz2yHL;
	Mon,  9 Dec 2024 13:06:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733709989;
	cv=pass; b=BsSRuR8HJriRhrpiTyoyGRlTt1+sJh7IjEq06GZmOzYYi0Awgpvz+hAwrCkCaRIMsFzSQ+/v9VyKYOQJFWWBpMQWncgwAJ9h3U5o0Hwelxspqg9NeHTfr1CtnZqJIRgX9ZeJBKCu7YOWVg0VFKPJZ8Y1YilYjShodt1zF2AiuxR2ECTUCCGG/gvWYtFChIjMRFwUEpJQAbqaiPe+vR6qP8/9EBqFbes1az/N3SO4Xxqznn43oG7WbZk+Uo5wiTiUC3D5zQZFFJEBKrTBICBCwVGhji1u76ukTsKtR0l6jvn9l3EPzRLwcwEJOXXm2lpRW40hHsP6hkLCVyd/ac9ZzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733709989; c=relaxed/relaxed;
	bh=/eSx6viMO2+wOTWPUog+Uhz9cIh34ZqMWaLMwhyT5GY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sc51w3VYSMoXuPBXuDQegGoNFS6AihFfsnQBhiYCcnAruREDJA4nFkdCCiCu2BOySxxyw62X0+L1MHO5PqG3y/nsyTxK2F/hxhoc/vpbRf2WEOTKQEQTDUM+rdn9Spgkc5VgFRaMppsXaUAR6ur43/t/BimPUBGn7CrRAUBQD3Dane8fvh/gmW/BvYYPV7MUEexWSviHyPIh+KA3mcnlr47qtqhckpydjJqYyv9TvzxFY+wI6vKpjauJ0WZH/OSHIIgGGGjAIdDGs0hKaksIo2+MiWByF8Y3yqToUq05u8zR3MJh7L0XEf+jwjA0/iaQrHar+guE0ecoll1YLNSRoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LRyKi5u+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LRyKi5u+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y64wd1Vlcz2xtb
	for <linux-aspeed@lists.ozlabs.org>; Mon,  9 Dec 2024 13:06:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEaBvq58L9fLzYQGCqhCYCAST9FKvs3JafaFPMqT9BzgrXKHR2JK5HeXMbnvGGJrX07rBLRaLWjBzWYzcElfAgwi+M9vLnIE7eKEkAMwg4lXBjYeuQ3Zc2rzKpsaXU6LrOprWW3OjguEwi6ggogvFwjpb2HgtDj+cm5DM/yBXDPBAeX6HCBV1jEC6n1dZ52d7YOLqANBPeZCraYWGTisHDPxpAOpGmxbdGgdVwlh8i2yEsVoEEWGEzOW6i4mQdTMu8FQY6O8H5QcWWEAL/Qko/VwbysuzEBI31679LmfU5Q3cJt8giUEqF2R0jaNgLQrDgOb/WSpdF/6W8MFshxUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eSx6viMO2+wOTWPUog+Uhz9cIh34ZqMWaLMwhyT5GY=;
 b=imhEDc8ccJ1sBBJXVgPdNDHNlEcm1p82fN04x89Ych1x1m9nxRgHZozBML9bqvzQ44AGxYvIDbjugRTFpIbEVMd9dfGdruHl8sFZNRPmDzVcxhI/iZb9V+ronzcNHqWBdeI1/70pqbureebCMvZNRkGXsVvE0U1TGTcs004GxDIBhbxyTrKCfXSHKmiEyc1kCL+dXERzL9Uk9kIObRWZneIkkAiVqRJbsKyOAsazUsC3llHe1+4gAetgUWlIVYjsQd4Cnxu2CpRnxX+C3EuZggXkGNkr6KmWSys3Dd/8c/bc+PzkSi5oKNKUpx63BBqMPgSld0Niry9VQP0AV+srug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eSx6viMO2+wOTWPUog+Uhz9cIh34ZqMWaLMwhyT5GY=;
 b=LRyKi5u+9RlwEPF7c5mWO8N4gjd8eFPF/OZgjEcnzhpqXG5QurY50j5AJ+Fk24SJELcvp0wzFm1y244JcZGnMHc0KEsQUmOXq9cW1/4CfP1NadhVBYDa8okBnINS+IPsUa9q4xptPwuadmpd80apJJmxDW6LF5xjeIS8XSDHRVALN03ekLRk6bcN4W/36KlJ/NSmMkKigVzBIW7N0hf84dHo0S0ph3xsybpVqSMdwZ29z/SSVvRnJOrK6DKbg7YK1TEq21CySsdSwMNj3C9z5c44WLs/kYAmLSEW860QPCOMrvG/1fxOKla/zUMhgAFtxwf3c+eav+zKEbw6LP/TMw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6947.apcprd06.prod.outlook.com (2603:1096:400:46c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.9; Mon, 9 Dec
 2024 01:49:25 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8251.011; Mon, 9 Dec 2024
 01:49:25 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lee@kernel.org"
	<lee@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Topic: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Index:
 AQHbKPqAZq4g4km5Z0emm4JobXy2VrKfy+OAgACisNCAIhONAIAP9ruQgAR8kQCAABcpcIAC+kKAgANeBtA=
Date: Mon, 9 Dec 2024 01:49:24 +0000
Message-ID:
 <OS8PR06MB754146730BA8D31127A5452FF23C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com>
 <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
 <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org>
 <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com>
 <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org>
 <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org>
 <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <c898338622625cbfc825e8d4cc5f0fff.sboyd@kernel.org>
In-Reply-To: <c898338622625cbfc825e8d4cc5f0fff.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6947:EE_
x-ms-office365-filtering-correlation-id: 66ea5bdf-f7a4-40bc-e9b0-08dd17f3b5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2xsME9heFdzOElSd0E4ZDBObHFhNkJSd3RBL3NDV1lINmdmTktoYjBnWC83?=
 =?utf-8?B?QVJGSlhyRi82bllxb3loRlJPU2xzczh5SkVHT3FBWVBxb01Qd1NSZXIrd09z?=
 =?utf-8?B?b0xMZ1NNZlJhQkNibThZYVN0R1A4Z3lhb09YekFoK01PZjRVTUxuWjZFYndv?=
 =?utf-8?B?NzBBZDU3YTdES1dha1NlbzhYNDM5SUszTitRVjlVLzl1QWxEUjJSTU5GSFVY?=
 =?utf-8?B?ZEFFSkE0U1VvL0hFakpsbnUwRFFkUTVIN3FBSzVMVVlQdDZKLytvTC9tTGtx?=
 =?utf-8?B?UjRDd2MrNmhPZytSTWFoYmgwVkVmK1RCdmU1Ky83ZFlOdlZhdUxEQnNrTmdL?=
 =?utf-8?B?M0NzbWVDNmFsaXNSak4wTmgxcmFSTjVyTVBPZHY2RlZoRXBRQVdhSnBnR1ND?=
 =?utf-8?B?a0xCaVNYM29mZVZBY2hIZVhBS3NTZWtyaUxtdmRndGw5K25LZ1BUaXVzUEtF?=
 =?utf-8?B?YWtrdXVGQ3YvTFpDL2JWbGQ4VERmOFNpVmhjc0RMZXJTcGlSQ2M2NmNXMmRY?=
 =?utf-8?B?dkdYdGhrS2N5bUxaeTZpQkZrMWEwVjJFclEyMm9CNmhHMk1PM1gxRjBZMkVu?=
 =?utf-8?B?V3BWTGpOMFRoVXphRVVkdW8yY0xKRTF4M0pBU2Z4VXNWSmJlbW5BaVhzdExl?=
 =?utf-8?B?SUJlMGpRNjV4R2JCMWsvd0M4ODgzWFY3VTl5dGQyRVlvMlNTODJ1SWpzSHhi?=
 =?utf-8?B?TnVDR1QxR2FlZ1VkWktiOE9lRC9ZVFlwSUVielhhemlTd1ZMNUtCWVVxd2RJ?=
 =?utf-8?B?a1hURTg0Nk1qNVREc3A0U1Q2Y1RxbDNIRG5ySUIvRFFuZFZ6QzhtOExnTmtT?=
 =?utf-8?B?cWNvU3BnclRobG5WRDZmb2tWWkpFNml3QjlLQVdsRVNyZUJhajVaZzByV0c5?=
 =?utf-8?B?d25GWnJGWHJnR0ZSRTRIcVBpUVVqclorcVQ5QUpRU3JBaTZ2UTA0U1FVeEYr?=
 =?utf-8?B?clZBMXU3TWhuWk9HY01mbCt4cEdYVWFSZmlxWW9QNFpmZjhCS0Q3ZThxL2t4?=
 =?utf-8?B?YjZBZmFuUy96b3FqR0xQYnJpZGNQU045bDlxOWY5a3IrdkpoOGdia2daVk9N?=
 =?utf-8?B?L2x3VDNScHdURDBxWWJabGlNcS8yKys5Y3V4NlQzam9IendVRmdkNHVHNXBz?=
 =?utf-8?B?bWV6Wk83VG5tSlA4cjVBNFYvb2FOWHJod1hwa0Y4N3h6YmtHQmU2NDZqRTJD?=
 =?utf-8?B?cHArUHRiMkNNN0pjdUFQS250NHFqcld0WXRsWWYrUFROdlRuTU9Oa1NYc05z?=
 =?utf-8?B?NGFIRGZseUlEdjJiaTVHN1VTT3lOWVg5TG5waHgzazFKVVJlaytOQk9IZlRY?=
 =?utf-8?B?Mzd3V2cvYUdwbHlLTldsb1UzMGw2bENyUDRqRnNhV2dPUGd0L2JFS1VJZTFS?=
 =?utf-8?B?TnhORnpmYk5SWVBkTENLbWlINDRnVXJ2b3IxNS9veG5jY0E3M3JSakVmM0R0?=
 =?utf-8?B?TTg2NEtVdzdFVytRRTNlRW0zTkQwVTQ2ZjA3eW5aNU14UGM4TVFtSm5vK2F4?=
 =?utf-8?B?TFNxaVhXRWlxd3FNMzl6cG1TQTJmQ29kRFFqTGZoeHVBNzF2LzM2Q3ZWVi9Q?=
 =?utf-8?B?YS92bEFWcGN3dGZpM1diYkVJMHUwaTh3OTNsNXYxMlg3WWtxWjFTQzRxUjd4?=
 =?utf-8?B?WDNmcjBZVzBKOHVVckwyTU1ZQ3hNWEM5aUNkdFIyLzZaSzgzQ0ZzOG9ESnhD?=
 =?utf-8?B?L1hlNVZvYWUxVnhBRS9iRTdlV3VjYlBhUjFDK2F0Ykd2eVRoSDVmSmUxcFd4?=
 =?utf-8?B?MjNrOWFJMHFsNDhhSGNKZjNqS2dtK0psOHRieGRKYXFlc3V2eURPQ1luUWNL?=
 =?utf-8?B?WHZWUkxLWXhqV1lEQTlycE1Ld0RtQ2pkaHc5VnFBVUlmUkR0bE9MVnE0ZVBw?=
 =?utf-8?B?OWw4aGdzYkQvYnVJcU5DVXBnVzlDUSt0Z2V5Q3VrbWpoTFBqYUJuSHpzWURV?=
 =?utf-8?Q?uLoWvJjL5Pk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXJFY3FVT3Q2dlIxS0l1MEdreXJMdjBjOWM2MEpJZjRHT2VkU2pLOU5tOTNq?=
 =?utf-8?B?cEYwSTlWRTltZEFWbTlnSHBQZlBZaEZhOEZ0YlZSNVl5Y1RBQ1RCbExrMkY3?=
 =?utf-8?B?Lzc3SXRadVR1eE1oRjR4SlZHc0RkWEFmYUp5a1liNUdHdEVVZmRDRTA3czcz?=
 =?utf-8?B?WnJqYXQ1UjQ4SVhtMUNHQjJsajE0MDF6OUNaWkRnTVpyT0hEYU1sSmtaWHJF?=
 =?utf-8?B?UXRIaUZvZDNUaUdUb0ZPcnNCeW02ekxGcEE1bXJRMCsxU0JmSGlZRkp4amJh?=
 =?utf-8?B?bEliWWNSSEI2QVh3MkNPQzF5QjE0Ky9QVTdxUmwwQzR3TW44a1Bpd0M0N2h5?=
 =?utf-8?B?UGJyOExJVzVNOW9FdlVSTHQxR2h5SU1nYmZPUE1iTHlJQ05yZ2JMWVZDd2M2?=
 =?utf-8?B?UFJ1TjV1MjJKQmY3QW9BVjNLQTlBcFpGVmZubUtFV3lSclhoMXZMdk5HdElV?=
 =?utf-8?B?cE8xczJSR1MycWFaM0hIdFpFWHJOU3Y4NGxHM1lWTXo3d2E3MnpCOGFSUytt?=
 =?utf-8?B?bjhnbjhNS3JpMmpvVDl0ZmpEejZxZVRrMzM5Qk40b0dxUG4vNVVla01uOUMx?=
 =?utf-8?B?M3I4NFk2cWZ3SVE0bEVLSXBZdElXZ3kydkdRcVl4Zno0SE4wK1E0Y08ray9m?=
 =?utf-8?B?eTRmbk5kTWc4ZzFoeUZVN29YQklxVFZUYXV4Uk5FaXRzRS9sMnA1eTIxZkEv?=
 =?utf-8?B?RDNETFlkTE0wNzlHVDVEeDZkWElRV0xJZEFVZVNpam56T05yNjczbytCM3BH?=
 =?utf-8?B?Qjk0bUFIMExxN1Y1Q1k4R0RCRWhNNnRBTER0NWttUmkrcEdvczB6RmRnQTZN?=
 =?utf-8?B?YnQzcFoyUFUvQkpWMFRSY3dHbzNBN2pTbUU0ektqSmZ6Rk9OZ3lOM2JKYnNy?=
 =?utf-8?B?MjJtVlRHWVpUMWVVYVhCUW12L3V5TWpxUlM4bmNKWmJtRzJnWm1SWk1sUkJF?=
 =?utf-8?B?MnlxNHh1YjA4SklNTWZUTkQ4WUdldTNqYzZUVjdzQS91amFIQnVkeEh6cnRq?=
 =?utf-8?B?N1d5bG1kQ0RaaXdkSmE0NURTR2laNXZNU2dEMTZrSmJnRU4yMWZ5Kzd5NXBN?=
 =?utf-8?B?WEcrd2RMeWNmOHV4Y1Q5RE1VOUpPeVdiUzZSYTFXNzFUUmhpV3k0TWxGN1d3?=
 =?utf-8?B?eWtFSDNieHRGQzFOMmlJNGt6ZmdERGNleGJucUc5ejhrNHk0SmhpRFlpRXNm?=
 =?utf-8?B?d3NYRWdzU1ByR3IzQ2RKdko5Qjc1cXpzSTJOWkdHRXl1Mk90cjlrRE8wbThh?=
 =?utf-8?B?T3M2alc1MlJhWHc5ZHlZaW5wc3JwY0dTOEFxV3hNZ3QxMXJldEJSZXJrWE1H?=
 =?utf-8?B?UGVwZ0ZnWnVrYWVZS3FnSlkzeHRFZlBIdXRvek5pM3Y5SFBGdzhPSGdxOU1r?=
 =?utf-8?B?MEhzNHN3NUxnaHlLSXZSQWxZSDBQdXpEZ3lwVmRRZ3RER01rM21zUVZzNDlQ?=
 =?utf-8?B?YlFtUWJLdy9lV1QrSnljWTZuQk43QXhjVlVTZ1pEcmhRRkRFUUh3OHoxTFJ5?=
 =?utf-8?B?elhqRXg4c1N0ZU9hWFFvODIvSS9hVnk4TkM5SkxsRnBGTDhsTkNvWU5Pb1N3?=
 =?utf-8?B?czR6R0kzNGNjZmpZYU5la1F0NC9VaGlDZUZJY0J6UGRKMk5HcndBbUR6YlV5?=
 =?utf-8?B?WkZHRVlkaFIvdzJrSXhkbVFaekVXdzB0T28yNEZrZy9uK2xadFJjNTFqK1l1?=
 =?utf-8?B?ZkN4cXp3NE1pOVltOHJSMEFaWnVzQnZYZDR6NFIzTkdFeTMzL25KNVhLczEx?=
 =?utf-8?B?SU9NV2JRK1paVEp3MVlrMnYwMFVRZU9pVnMreFJEWWNzSFJGelFUQ2NaYnZI?=
 =?utf-8?B?b1ZLRHUvZkFYS0lUbC90cGMvREJnTStFaEoyR3p4ZUtjOER1YjhSekowYkRz?=
 =?utf-8?B?UHIrRk9Fb0ZhbU8vd1k2alMrQ3Noc1RCNXRzMXdwK0IvTGJMcm5NMjQ4N3ZL?=
 =?utf-8?B?cU9kb3RiVTF1MGovUERSZzNTb0JrekNxc1JsT0RSOTNBM245OWdWeFFDem1P?=
 =?utf-8?B?YU8vWnBFdnIwWVB1RW9ZdVZ3WWQzek1uQUdyTVB4NHJmS0dkWkd5d2RHUldi?=
 =?utf-8?B?aFRrVHdzeWJkQU1nZmEycldISWhremF2NU1PcXBraXR5VWFHTGRtamkrQldT?=
 =?utf-8?Q?F+7p125LU5YFzkcNQumz0TuPS?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ea5bdf-f7a4-40bc-e9b0-08dd17f3b5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 01:49:25.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXM32k+OO0pAA7qYEyeaFoa5HZk4hS2WhwiQ/sfAlJM9Q3V6MuDdYfWPY3OcSofCn/QDLoup6LvFrx/JHeKkgLNbxTwXufpOImMAOXpQ4fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6947

PiBTdWJqZWN0OiBSRTogW1BBVENIIHY3IDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
b2NrIGRyaXZlci4NCj4gDQo+IFF1b3RpbmcgUnlhbiBDaGVuICgyMDI0LTEyLTA0IDE2OjQ4OjQy
KQ0KPiA+ID4gPiBzdHJ1Y3QgYXN0MjcwMF9jbGtfaW5mbyB7DQo+ID4gPiA+ICAgICAgICAgY29u
c3QgY2hhciAqbmFtZTsNCj4gPiA+ID4gICAgICAgICB1OCBjbGtfaWR4Ow0KPiA+ID4gPiAgICAg
ICAgIHUzMiByZWc7DQo+ID4gPiA+ICAgICAgICAgdTMyIHR5cGU7DQo+ID4gPiA+ICAgICAgICAg
dW5pb24gew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgc3RydWN0IGFzdDI3MDBfY2xrX2ZpeGVk
X2ZhY3Rvcl9kYXRhIGZhY3RvcjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBhc3Qy
NzAwX2Nsa19maXhlZF9yYXRlX2RhdGEgcmF0ZTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHN0
cnVjdCBhc3QyNzAwX2Nsa19nYXRlX2RhdGEgZ2F0ZTsNCj4gPiA+ID4gICAgICAgICAgICAgICAg
IHN0cnVjdCBhc3QyNzAwX2Nsa19kaXZfZGF0YSBkaXY7DQo+ID4gPiA+ICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgYXN0MjcwMF9jbGtfcGxsX2RhdGEgcGxsOw0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgc3RydWN0IGFzdDI3MDBfY2xrX211eF9kYXRhIG11eDsNCj4gPiA+ID4gICAgICAgICB9IGRh
dGE7DQo+ID4gPiA+IH07DQo+ID4gPiA+DQo+ID4gPiA+IHN0cnVjdCBhc3QyNzAwX2Nsa19kaXZf
ZGF0YSB7DQo+ID4gPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGNsa19kaXZfdGFibGUgKmRpdl90
YWJsZTsNCj4gPiA+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhICpwYXJl
bnQ7DQo+ID4gPiA+ICAgICAgICAgdTggYml0X3NoaWZ0Ow0KPiA+ID4gPiAgICAgICAgIHU4IGJp
dF93aWR0aDsNCj4gPiA+ID4gICAgICAgICB1MzIgcmVnOw0KPiA+ID4gPiB9Ow0KPiA+ID4gPg0K
PiA+ID4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IGFzdDI3MDBfY2xrX2luZm8gYXN0MjcwMF9zY3Uw
X2Nsa19pbmZvW10NCj4gPiA+ID4gX19pbml0Y29uc3QgPSB7IC4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLg0KPiA+ID4gPiAgICAgICAgIERJVklERVJfQ0xLKFNDVTBfQ0xLX0FIQiwgInNvYzAt
YWhiIiwgc29jMF9haGJtdXgsDQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBhbHNvIHNob3cgd2hhdCBz
b2MwX2FoYm11eCBpcz8NCj4gPiBJdCB3aWxsIGJlIGZvbGxvd2luZy4NCj4gPg0KPiA+IHN0YXRp
YyBjb25zdCBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIHNvYzBfYWhibXV4W10gPSB7DQo+ID4gICAg
ICAgICB7IC5md19uYW1lID0gInNvYzAtYWhibXV4IiwgLm5hbWUgPSAic29jMC1haGJtdXgiIH0s
IH07DQo+IA0KPiBJbnN0ZWFkIG9mIHRoYXQsIHBsZWFzZSB1c2Ugb25seSB0aGUgaW5kZXguDQo+
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2RhdGEgc29jMF9haGJtdXhbXSA9
IHsNCj4gICAgICAgICAgeyAuaW5kZXggPSA8bnVtYmVyIGZyb20gRFQgYmluZGluZz4gfSwgIH07
DQoNClNvcnJ5LCBpZiBJIHVzZSBpbmRleCBpbnN0ZWFkLCBJdCBjYW7igJl0IGdldCBwYXJlbnQg
ZGF0YSBuYW1lIGZvciBkZXZtX2Nsa19od19yZWdpc3Rlcl9maXhlZF9mYWN0b3IgcGFyZW50X25h
bWUgcGFyYW1ldGVycy4NCkRvZXMgdGhlcmUgaGF2ZSByZWZlcmVuY2UgZHJpdmVyIHVzZSBpbmRl
eCBpbXBsZW1lbnQ/DQoNCkluIHByb2JlIGZ1bmN0aW9uIEkgaW1wbGVtZW50IGZvciBmdW5jdGlv
biBmb3IgZWFjaCBjbGsgcmVnaXN0ZXIuDQpGb3IgZXhhbXBsZSBDTEtfRElWSURFUg0KVXNlIGRp
di0+cGFyZW50LT5uYW1lIGdldCBwYXJlbnQgbmFtZSBmb3IgcGFyYW1ldGVyLg0KCQkJaHdzW2ld
ID0gZGV2bV9jbGtfaHdfcmVnaXN0ZXJfZGl2aWRlcl90YWJsZShkZXYsIGNsay0+bmFtZSwNCgkJ
CQkJCQkJICAgIGRpdi0+cGFyZW50LT5uYW1lLCAwLA0KCQkJCQkJCQkgICAgcmVnLCBkaXYtPmJp
dF9zaGlmdCwNCgkJCQkJCQkJICAgIGRpdi0+Yml0X3dpZHRoLCAwLA0KCQkJCQkJCQkgICAgZGl2
LT5kaXZfdGFibGUsDQoJCQkJCQkJCSAgICAmY2xrX2N0cmwtPmxvY2spOw0KDQpGdWxsIGltcGxl
bWVudCBpcyBmb2xsb3dpbmcuDQoNCglmb3IgKGkgPSAwOyBpIDwgY2xrX2RhdGEtPm5yX2Nsa3M7
IGkrKykgew0KCQljb25zdCBzdHJ1Y3QgYXN0MjcwMF9jbGtfaW5mbyAqY2xrID0gJmNsa19kYXRh
LT5jbGtfaW5mb1tpXTsNCgkJdm9pZCBfX2lvbWVtICpyZWcgPSBjbGtfY3RybC0+YmFzZSArIGNs
ay0+cmVnOw0KDQoJCWlmIChjbGstPnR5cGUgPT0gQ0xLX0ZJWEVEKSB7DQoJCQljb25zdCBzdHJ1
Y3QgYXN0MjcwMF9jbGtfZml4ZWRfcmF0ZV9kYXRhICpmaXhlZF9yYXRlID0gJmNsay0+ZGF0YS5y
YXRlOw0KDQoJCQlod3NbaV0gPSBkZXZtX2Nsa19od19yZWdpc3Rlcl9maXhlZF9yYXRlKGRldiwg
Y2xrLT5uYW1lLCBOVUxMLCAwLA0KCQkJCQkJCQkgZml4ZWRfcmF0ZS0+Zml4ZWRfcmF0ZSk7DQoJ
CX0gZWxzZSBpZiAoY2xrLT50eXBlID09IENMS19GSVhFRF9GQUNUT1IpIHsNCgkJCWNvbnN0IHN0
cnVjdCBhc3QyNzAwX2Nsa19maXhlZF9mYWN0b3JfZGF0YSAqZmFjdG9yID0gJmNsay0+ZGF0YS5m
YWN0b3I7DQoNCgkJCWh3c1tpXSA9IGRldm1fY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX2ZhY3Rvcihk
ZXYsIGNsay0+bmFtZSwNCgkJCQkJCQkJICAgZmFjdG9yLT5wYXJlbnQtPm5hbWUsDQoJCQkJCQkJ
CSAgIDAsIGZhY3Rvci0+bXVsdCwgZmFjdG9yLT5kaXYpOw0KCQl9IGVsc2UgaWYgKGNsay0+dHlw
ZSA9PSBEQ0xLX0ZJWEVEKSB7DQoJCQljb25zdCBzdHJ1Y3QgYXN0MjcwMF9jbGtfcGxsX2RhdGEg
KnBsbCA9ICZjbGstPmRhdGEucGxsOw0KDQoJCQlyZWcgPSBjbGtfY3RybC0+YmFzZSArIHBsbC0+
cmVnOw0KCQkJaHdzW2ldID0gYXN0MjcwMF9jbGtfaHdfcmVnaXN0ZXJfZGNsayhpLCByZWcsIGNs
ay0+bmFtZSwgY2xrX2N0cmwpOw0KCQl9IGVsc2UgaWYgKGNsay0+dHlwZSA9PSBDTEtfSFBMTCkg
ew0KCQkJY29uc3Qgc3RydWN0IGFzdDI3MDBfY2xrX3BsbF9kYXRhICpwbGwgPSAmY2xrLT5kYXRh
LnBsbDsNCg0KCQkJcmVnID0gY2xrX2N0cmwtPmJhc2UgKyBwbGwtPnJlZzsNCgkJCWh3c1tpXSA9
IGFzdDI3MDBfY2xrX2h3X3JlZ2lzdGVyX2hwbGwoaSwgcmVnLCBjbGstPm5hbWUsDQoJCQkJCQkJ
ICAgICAgcGxsLT5wYXJlbnQtPm5hbWUsIGNsa19jdHJsKTsNCgkJfSBlbHNlIGlmIChjbGstPnR5
cGUgPT0gQ0xLX1BMTCkgew0KCQkJY29uc3Qgc3RydWN0IGFzdDI3MDBfY2xrX3BsbF9kYXRhICpw
bGwgPSAmY2xrLT5kYXRhLnBsbDsNCg0KCQkJcmVnID0gY2xrX2N0cmwtPmJhc2UgKyBwbGwtPnJl
ZzsNCgkJCWh3c1tpXSA9IGFzdDI3MDBfY2xrX2h3X3JlZ2lzdGVyX3BsbChpLCByZWcsIGNsay0+
bmFtZSwNCgkJCQkJCQkgICAgIHBsbC0+cGFyZW50LT5uYW1lLCBjbGtfY3RybCk7DQoJCX0gZWxz
ZSBpZiAoY2xrLT50eXBlID09IENMS19VQVJUX1BMTCkgew0KCQkJY29uc3Qgc3RydWN0IGFzdDI3
MDBfY2xrX3BsbF9kYXRhICpwbGwgPSAmY2xrLT5kYXRhLnBsbDsNCg0KCQkJcmVnID0gY2xrX2N0
cmwtPmJhc2UgKyBwbGwtPnJlZzsNCgkJCWh3c1tpXSA9IGFzdDI3MDBfY2xrX2h3X3JlZ2lzdGVy
X3VhcnRwbGwoaSwgcmVnLCBjbGstPm5hbWUsDQoJCQkJCQkJCSBwbGwtPnBhcmVudC0+bmFtZSwg
Y2xrX2N0cmwpOw0KCQl9IGVsc2UgaWYgKGNsay0+dHlwZSA9PSBDTEtfTVVYKSB7DQoJCQljb25z
dCBzdHJ1Y3QgYXN0MjcwMF9jbGtfbXV4X2RhdGEgKm11eCA9ICZjbGstPmRhdGEubXV4Ow0KDQoJ
CQlyZWcgPSBjbGtfY3RybC0+YmFzZSArIG11eC0+cmVnOw0KCQkJaHdzW2ldID0gZGV2bV9jbGtf
aHdfcmVnaXN0ZXJfbXV4X3BhcmVudF9kYXRhX3RhYmxlKGRldiwgY2xrLT5uYW1lLA0KCQkJCQkJ
CQkJICAgIG11eC0+cGFyZW50cywNCgkJCQkJCQkJCSAgICBtdXgtPm51bV9wYXJlbnRzLCAwLA0K
CQkJCQkJCQkJICAgIHJlZywgbXV4LT5iaXRfc2hpZnQsDQoJCQkJCQkJCQkgICAgbXV4LT5iaXRf
d2lkdGgsIDAsDQoJCQkJCQkJCQkgICAgTlVMTCwgJmNsa19jdHJsLT5sb2NrKTsNCgkJfSBlbHNl
IGlmIChjbGstPnR5cGUgPT0gQ0xLX01JU0MpIHsNCgkJCWNvbnN0IHN0cnVjdCBhc3QyNzAwX2Ns
a19wbGxfZGF0YSAqbWlzYyA9ICZjbGstPmRhdGEucGxsOw0KDQoJCQlyZWcgPSBjbGtfY3RybC0+
YmFzZSArIG1pc2MtPnJlZzsNCgkJCWh3c1tpXSA9IGFzdDI3MDBfY2xrX2h3X3JlZ2lzdGVyX21p
c2MoaSwgcmVnLCBjbGstPm5hbWUsDQoJCQkJCQkJICAgICAgbWlzYy0+cGFyZW50LT5uYW1lLCBj
bGtfY3RybCk7DQoJCX0gZWxzZSBpZiAoY2xrLT50eXBlID09IENMS19ESVZJREVSKSB7DQoJCQlj
b25zdCBzdHJ1Y3QgYXN0MjcwMF9jbGtfZGl2X2RhdGEgKmRpdiA9ICZjbGstPmRhdGEuZGl2Ow0K
DQoJCQlyZWcgPSBjbGtfY3RybC0+YmFzZSArIGRpdi0+cmVnOw0KCQkJaHdzW2ldID0gZGV2bV9j
bGtfaHdfcmVnaXN0ZXJfZGl2aWRlcl90YWJsZShkZXYsIGNsay0+bmFtZSwNCgkJCQkJCQkJICAg
IGRpdi0+cGFyZW50LT5uYW1lLCAwLA0KCQkJCQkJCQkgICAgcmVnLCBkaXYtPmJpdF9zaGlmdCwN
CgkJCQkJCQkJICAgIGRpdi0+Yml0X3dpZHRoLCAwLA0KCQkJCQkJCQkgICAgZGl2LT5kaXZfdGFi
bGUsDQoJCQkJCQkJCSAgICAmY2xrX2N0cmwtPmxvY2spOw0KCQl9IGVsc2UgaWYgKGNsay0+dHlw
ZSA9PSBDTEtfR0FURV9BU1BFRUQpIHsNCgkJCWNvbnN0IHN0cnVjdCBhc3QyNzAwX2Nsa19nYXRl
X2RhdGEgKmdhdGUgPSAmY2xrLT5kYXRhLmdhdGU7DQoNCgkJCXJlZyA9IGNsa19jdHJsLT5iYXNl
ICsgZ2F0ZS0+cmVnOw0KCQkJaHdzW2ldID0gYXN0MjcwMF9jbGtfaHdfcmVnaXN0ZXJfZ2F0ZShk
ZXYsIGNsay0+bmFtZSwgZ2F0ZS0+cGFyZW50LA0KCQkJCQkJCSAgICAgIHJlZywgZ2F0ZS0+Yml0
LCBnYXRlLT5mbGFncywgMCk7DQoNCgkJfSBlbHNlIHsNCgkJCWNvbnN0IHN0cnVjdCBhc3QyNzAw
X2Nsa19nYXRlX2RhdGEgKmdhdGUgPSAmY2xrLT5kYXRhLmdhdGU7DQoNCgkJCXJlZyA9IGNsa19j
dHJsLT5iYXNlICsgZ2F0ZS0+cmVnOw0KCQkJaHdzW2ldID0gZGV2bV9jbGtfaHdfcmVnaXN0ZXJf
Z2F0ZV9wYXJlbnRfZGF0YShkZXYsIGNsay0+bmFtZSwgZ2F0ZS0+cGFyZW50LA0KCQkJCQkJCQkg
ICAgICAgMCwgcmVnLCBjbGstPmNsa19pZHgsIDAsDQoJCQkJCQkJCSAgICAgICAmY2xrX2N0cmwt
PmxvY2spOw0KCQl9DQoNCgkJaWYgKElTX0VSUihod3NbaV0pKQ0KCQkJcmV0dXJuIFBUUl9FUlIo
aHdzW2ldKTsNCgl9DQo=

