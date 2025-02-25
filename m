Return-Path: <linux-aspeed+bounces-825-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE712C021B6
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 02:21:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z21Z21hZXz30RG;
	Tue, 25 Feb 2025 13:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::730" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740450090;
	cv=pass; b=kxVYQHUmXfaeYjYOzPQQ9rzLRJCoNEBFQXvxVjLelHTC9BYeLjdZo3zgndKkCKnGJuhct4GFEtIh3Ly3wYWsESW78k1S+ySJWfu+NQyYJ8gt/8OcTPFPjy0wYuoGqcAjxd+5/XeK8XPcbb+X9XKW57BRMMk9L042n3U+FCgySZR9jeFRzK+q8urpIBDJ0k29mhuYfiEI1I3dibnl6ahb85EEDtvKDooQQceaB6rfx77UIu0wnncmSsNPteaLKRxYIIGByKxd6FiIYe9vXojOHvi13NEncbfQ993RPBXys7y56Q9KU6C05WRh4qr8Fy3hx2ClZiKT3VAPPkGyIuNcNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740450090; c=relaxed/relaxed;
	bh=yzJ3iClFvILCnOxYAiHuxuyy30BWs3SNFhxPNsPjHFQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DeFy0GKq8T1sy9bDoKJwwcrPlwXdxA5k16qAQUBcc1392S6a1JskBpvOieHQyPKH1gaTjwL1qI0lBiYoebkfyFpmBi7A+FpTTn7ZzdoDUN3yHdWjpIIKplcLzJ64VOCsl0ncazz2uK3txpc3trwcNv1da4J2ipo7tbviFUOs4I87K3oWrh0G3MusA2BP5Vd21Lb+TaCH6rXBDk+qCFn3QeOdrLkRkdxXdg1NNuQ2hiTz40mQdKRf+y18FOsN0w29+F8S09pZVCCE/69xun9ew09I8pdT3EYeSb/HDSXYb8PUKoI7zp9O43QgeEtSdgRiXMSjexxtxF6BlszIvZCh1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:2011::730; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:2011::730; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20730.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z21Yg6ZYBz30CL
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 13:20:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REAwoqTjUMD9QDHf0r0hkX6iKuP+jLaU7cmBBxNdRFu426iKFe+zcyxpQIv201kycEktkUsb8m44U11CAgaDV/OEVSTrFbVuw7UtitEJcP7bxqAYS8KALjIASygTYO5tvOwLn5T3cl7EUpa+/seCEo0grvIwdJkUl7a0jqs7esYoORu5J0lzul2bMfoQ46jJzr4o6C96gUMBc2okHPEkpby3IQ1z7EK3EVRoSUysm7X60wZsq6ouf86bRgwjjwFn7nVdZfHLP4nr3dRaEtFm/wVS7cI/d4kIjDevlyiZOuyTYBt1XdIbeDGOJAD1ymrQi3LVGrUjEecyYUo+72ktcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzJ3iClFvILCnOxYAiHuxuyy30BWs3SNFhxPNsPjHFQ=;
 b=kSlT7CHYkeJUaY2a3/qG/v4ifFChCUpvAqG/h4yI1efUDRZHdmlyFYXINy967YtUpBSW4hOeh9ECZV4ILeNkL0as1ly6pftUcIHt+u22Fw+hoym6aAzL228DDOUT5eEEWgQCtr3WkJXJCcTR13Gd81yOEVCnRN21g3LjuIWl10udgE+nCeFupCHGOOybL/WzIyHDA5bjpG+AJY0atsF8QpBVIbkbxn6q3aEXyiYRUewkFGji0RocOqmOnbMVnUYB182V1VOwjAEOTPnqPawbnuGh0vOw7JWjh0UljKVUiTYNsEr4PFkx+aPJxFaccXAmmpojOSFYYFsaepgcWJV15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzJ3iClFvILCnOxYAiHuxuyy30BWs3SNFhxPNsPjHFQ=;
 b=QFywBCwGKzgSSXwOxkQoUSv5ZvXfMtPprdrLTrJVhXz6QBudbVde04xipTlCAvvqVbWh3YVJmD0ka67uTOlTx7mX0azqF+O8Q6q7kGbioBm4QZvQIMGETW/rRubFthRKdMvX2ABem+1lcGjOKVRNnL/HQ88l7n5fXhlvMx34RzUJAvhy9B39lWOWKGFxOIj2ROHLWqhDt3SvckVPGVOfby9Ipw6YsHLjunUWumZdzG+USX2/oOd3SDcO+drvlAkFOtufgpkumSaF8djqzIXhpWAB+IeLWGs5OPYRjlBb4H6hl8oPiWvBSEnbqR27y82z4ahQU00NQ4TqJYinS/3vlA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB5174.apcprd06.prod.outlook.com (2603:1096:101:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 25 Feb
 2025 02:20:25 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:20:25 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
Thread-Topic: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
Thread-Index: AQHbhqIysbDNMgzGf0K86faa5MrsmbNWO+CAgAAA44CAAGf+gIAApJmQ
Date: Tue, 25 Feb 2025 02:20:25 +0000
Message-ID:
 <OS8PR06MB7541E77E1EA78D658E5444A6F2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
	 <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
	 <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
	 <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
 <b00aef9582e223a5770cebc714ad65168eab744b.camel@pengutronix.de>
In-Reply-To: <b00aef9582e223a5770cebc714ad65168eab744b.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB5174:EE_
x-ms-office365-filtering-correlation-id: e1314db8-5104-40b1-979d-08dd5542f6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlM2U0tpVzh3ZnE4WUVvL3ptbkN3VmNvdXB2NU5peVJiVnZDdUtxZGNlbHgz?=
 =?utf-8?B?K0kzY3kvQXJEODI2RXU0akNEV21Sa2NMRjhwanZybTZnME5rREN0ZFNlL2pa?=
 =?utf-8?B?cWJYZ1B3bzFBbGo4N3daWWNiaEwxaHNsVjhkd0JRU3JsdGFaWnNNZ2p2R3FD?=
 =?utf-8?B?OU05WjA4SVBXL0lLZllCZlpieUtLVDdSYUpRYTdRYVRXODJWemdqUFZKWlFv?=
 =?utf-8?B?U1AzZXhkZU9rNVBWTlV3VWt6OEFHNmdEZVVQRWp1N2J1amJ5bDhUVzUwRnk2?=
 =?utf-8?B?K0hxYWxIMzlvREVnWHBtWCtKQ0VtNnkwTUYyRXJTSk14WHI1cUVaWnhDWWMx?=
 =?utf-8?B?UWpXa1F0S1diWlM0Rm40Z3RHOGkxQjdpdFRYZ1hSMXluU3V1bUtsZVJzWmpP?=
 =?utf-8?B?d0VDVmw0V0MvZnNQZU9WMmt1bitmYnBpbGdCZ0xwRWdNUGN0aG0vSVcrKy9Z?=
 =?utf-8?B?N2NSVlNibXIwa3dqSGRMb21tYW8rTkVwTmQrQ3N6cldKcWJLbThYa1ZxYm85?=
 =?utf-8?B?QmkvMGpkSEMwNDczMFdVOC9pQUtKNzdBNzJHdENFNXZjSVFkbkMwdXVBc0tN?=
 =?utf-8?B?NG55YU0rWkJkTXRreXpZVFFhSW9ocXc4ZkFnVDNkNVdyV3VGbitkcEdxOG1W?=
 =?utf-8?B?QnFYRmdiREJXK0hJVFFnTHo2dkhDRmYvT25JN0ZKQXhZN0ZPeXpKbjltUjZT?=
 =?utf-8?B?bE1EdnAxNkJoUFliVklOQ1N4Wng3eE13UDBhSHMzc2x2RHNvMFA2NC9HMUlv?=
 =?utf-8?B?d1NrTVVYYlpUSUJNZXh3eFJxb0hFZzhlU1dic0lWT1RRRW1FY2NGZ0ZtSXl2?=
 =?utf-8?B?ZEJxbGptNnNrZEVBdUFZRWtHc2ZMV1J0OWlkUjVFQ1lBZDVRS09yR0RnNXNa?=
 =?utf-8?B?WFhRM3l5aHdRaDkvYTllNWNNUXIxbmNvc3lNYTBQTDQzOUJmYVUzMEV3MnNM?=
 =?utf-8?B?UUZLbzN2N1BLQVRXTTlaMUJtTXBHdVZtZFZlZzhDVkRuVEpXbWdSWENMYklr?=
 =?utf-8?B?QzlhSnBPVXcwT1MvUHY2UWZEekliKy9CVENMT1RhNVlLSDh0bjB6ZWxmTHhm?=
 =?utf-8?B?YS9FT0szYmUrV0FFK1V0YS9NTVY0TWVvblBUVDYzSDFSQTdNNDZCL0JMMlFM?=
 =?utf-8?B?eFJSekFGOUl2RE5MVkorWWpsTkRqajlrOUQrQWdLWXo1MHZyOCtzbHE5U0Rs?=
 =?utf-8?B?cXhNb0tIYmZnc3dWSC9hV2d3a0srOVhxUFNEZW16V2JYVmI4bEdXczdXSGp4?=
 =?utf-8?B?QmY2eWN1cW9zbHc0eUd5dTRRZ092clBiZnpJYU9LVjNJcWFBTlZFOG9VOEty?=
 =?utf-8?B?anNabzhOUGdiUXJJNExQVzNYYTlQZ3pBSmMra21qQ2pOQi9jM2lxUlhyZ3lh?=
 =?utf-8?B?NitBVEE1a1ZPTTZUdHo0VS8za1NiTlpsd1FnRnFhMng3S1BSUVp3YU5VSkdF?=
 =?utf-8?B?ZDRleEd2QmRVNVRsOHpYNU9xbTE0Zk5VMUpvKzdGcjVmY2UyaHVnc2FtL3Jy?=
 =?utf-8?B?R0lNKzJTOFUxVUhpSXBCVG8vNVM0UkxJaHRXWWk5emRjU0dRSDRqekVoRzFv?=
 =?utf-8?B?ZW5xdU1kU1UzNUM0c2liUjErdmR1cVdIVHNSWWM2ZHdjQ2pKWkNXQWFOU1RN?=
 =?utf-8?B?ZHhONzkva0owU2l0dUNsUDcxZUxuM0tnVDIyU3BlVDZWazcvQXFDSFVsNWlr?=
 =?utf-8?B?dnhYUHpkVDU0K09NbXBaNjlOaitGRXZaenBmR1RLY1RhY3JiamVpSUFFRXBv?=
 =?utf-8?B?L0RPTjB1U1FzcVhOWExvU0Z4dHdnaHRFbWw2S1duMzBKYW9VN2lnWWdsNHJ3?=
 =?utf-8?B?a2k0bUtVZmJoL2JBSVlRdnRFTVA3SnZ1c0xrcFpsemt6Skl2bkExK0V5eEYw?=
 =?utf-8?B?eE1BaVVzRmJHNnBtdFpQVnJqdmVIVlA3THlsUlBhd1FNQklwMFY1UVhpblFo?=
 =?utf-8?B?RTF2bklBK0dtMzloaXVwMGJDZWFoYndpK21HV2hDdEdMVElaNUNyVHVhZTYr?=
 =?utf-8?B?cmJ3TUF2d1ZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFk1ZXVqMTA3SDQrQkJ1bXJpeTlnSUt6MVVCeE0ySzQzSVJ3RkhCY0d6bnJU?=
 =?utf-8?B?eG5BL2x6bWJrbmZOakV5NC8rd1NQWWExYnZQUkFIa25FS2lZUUtmNThNWktU?=
 =?utf-8?B?WldZKzkyM0h6aXFEaW43K1hxbCtGWWFzSXRkRTNHcTNybW5pcGJHVDZWeXZz?=
 =?utf-8?B?U2dEdnArSXhveFlmK25PcFIweDlzRkR0YnR0Rk9iNS9ZNzJnOE9yczM5WXho?=
 =?utf-8?B?Q3hWbTBzYXFkQ3lST0FLUXM2cWVHRStkL3M4Y3RMbFREdkJHbmcyQzg1T2Y0?=
 =?utf-8?B?UitVWlIxOXc5VWVwZzR4UUdNVHZ5OUNldTJYckhLclpJSUd5TUdzWFFTNzJm?=
 =?utf-8?B?bVNKdHpwQjdsZ1o4NmlWbGdmMERtZEp0SjFEaFZUQ2VaRVdMeEtuaGpyeWlj?=
 =?utf-8?B?alhmcHZiSXV5Q2M0QVhQMUswY3JGMW93WFFiN3VPRzJWdHZoWC9VanBLTzk3?=
 =?utf-8?B?aE9lOFZWQXQ4cmVLZGsxVnlrV3duOUQzdmQ5RVRkT3dNTWxMdEZCdFNhQUNn?=
 =?utf-8?B?OS9SOS9PWnNSMzl0bEJ4cStDbXhXVDhuaFRGS2R1UmlBYWdEK1pTZDFaT3Bt?=
 =?utf-8?B?V3VPUjdkSEw4OU14SytqanZGZndLbzVaVlZDNDk3UzdqWC9NUUQxMHlkRzM3?=
 =?utf-8?B?emtzUmJvbUFEQS8yUWczUUxzRWQybTlpNTlkYVVadllPdnprc2VldnRwVHBR?=
 =?utf-8?B?b0Y2aGpuUllnQW5hdGNBNUc3QjFhVjlCZmFtMks4eDBmMVIrRWpTOUg1YzRR?=
 =?utf-8?B?cGx1a1UrSjd2cXN3OENZU2hYM1FqcHc0RmRMVU5mQ1l5OTNUbVRNSlJ3eTZn?=
 =?utf-8?B?SGpaZUVJUVRpRldWTU42QjYvUjFKdVpIVE5qVjhSYUp6dkVlOVRGaUtmdnoy?=
 =?utf-8?B?blpPc0M4OU1DWVFYbHBqUDdSV0xzRm9aSnJnbkM5bGM4bW5WdTJ4VmRkR2s1?=
 =?utf-8?B?emdKU1d2NTMzQklObGFOU3NuVnVWOFVDbkRVY1k0b1ZaZTJOOXc0dGMzTDlT?=
 =?utf-8?B?aTJBeWRqYlEya3NDSVl1TFR3eGcyZnRRKzcxQjFRUEtvSXJyazZPK2VxN2FW?=
 =?utf-8?B?SUp2Z3B0OFV6K0tLS1FFdC9wdExMOERWcHdVMEY5bnFFbzFlaWJOOE1iWmI2?=
 =?utf-8?B?LzRnY1Q4NkpnVUR3MVR0b0Z3OXF4OVhvWGFWS2ZxeXdGQ2JNYVB6djNDeTV2?=
 =?utf-8?B?bWxOeklnZVI5dE83Q1NGMm0xRVNoRlNvMVIrWGsxODhiQU5xbWlwZFdUWEF4?=
 =?utf-8?B?a1lwZDFrMmZiQlBpNy9CUTl5NUtrOEVUeGRnQjJ3UDdpdlR5Vk1rbURyQm05?=
 =?utf-8?B?RUZzY2RFWXVVbkwrSW1BamZzV3lpYzJCSVFoaVFNZlNUV3BnaGpBRGtDaW5W?=
 =?utf-8?B?MlNtYlZQRVhzS2xlcFQ1M1A5UFNNeTl4d2Znd1U1ay8weGNGNkcyLzJHQ1E0?=
 =?utf-8?B?b2pvcjJaQWloakNZVzZ4ODlna1NuZmhzZmpUdTM0WitoUGk3OE5hWmNzSEpN?=
 =?utf-8?B?UGdNMjlYUVFnVldXS2c4OTBOc29TbXJVQkpPZU43OThNR084K1U0ek1KTEly?=
 =?utf-8?B?bk9lSkxMNUp6VnJoUTIxeWlNUFI3ekpRVFRiTnRtQk5uUWEvTnJRR3NGd0FB?=
 =?utf-8?B?U1Qxck1xZnFkRUZXVVRZa2NCNnlqZVg4YXpacmdRQm9rWTl3cE5kc1Jidmg2?=
 =?utf-8?B?QU8xZ2ZkaGFDRmtWRWczaWhzWmpLQlNHeTRoVHAzL2kwMEVUZ1VLV3FCTXVa?=
 =?utf-8?B?dklQbTJNMFlOeUxES2g4aGRKbmh6SGY2MzJKN0dnUTM5NW9BdDBvUW1kMVpk?=
 =?utf-8?B?NEFWZEUyekFLM1o4bTUvWXMyTDFqSEFobTl0dHBpOVp4RVN5OVFjaWdLWGRx?=
 =?utf-8?B?bjZhSDlDZk5FeGFPNktoZjlCTDhNdmVJWkpLVDQ4aXpoS0dzMEgyeVFWMVR1?=
 =?utf-8?B?aVprbTdReEs1YlRPalFzQWdrLzhGYWRpNmFmTStzMDRvc1d2U00yVWN2dmRi?=
 =?utf-8?B?aHo4QnNDV2k2NGxNVldrTVBUdjU3ZXY1dWJTWVo1ekhRek5PNG5DVnpzY29C?=
 =?utf-8?B?cW5pdEZFcVpPdDhpTFBES3hscGdSTTJseWFPT0NBMmIyQy9rMnp3MEtpbUVJ?=
 =?utf-8?Q?fPVQudWCb55w/sceAnlqTzW65?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1314db8-5104-40b1-979d-08dd5542f6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 02:20:25.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbbdNG/aRv8PtS0BeugGe1kLtE1MnNzpk66/bPf2zw2P0Vp+/3ATathrt8F22OTwZa1i+C6jop6aKuhr7GMXhYxrbcIRzI9WBumnnI0HSXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5174

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDIvM10gcmVzZXQ6IGFzcGVlZDogcmVnaXN0ZXIgQVNU
MjcwMCByZXNldCBhdXhpbGlhcnkgYnVzDQo+IGRldmljZQ0KPiANCj4gT24gTW8sIDIwMjUtMDIt
MjQgYXQgMTE6MTUgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMjQv
MDIvMjAyNSAxMToxMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIDI0LzAy
LzIwMjUgMTA6NTUsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGlj
IHZvaWQgYXNwZWVkX3Jlc2V0X3VucmVnaXN0ZXJfYWRldih2b2lkICpfYWRldikgew0KPiA+ID4g
PiArCXN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphZGV2ID0gX2FkZXY7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwlhdXhpbGlhcnlfZGV2aWNlX2RlbGV0ZShhZGV2KTsNCj4gPiA+ID4gKwlhdXhpbGlh
cnlfZGV2aWNlX3VuaW5pdChhZGV2KTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
c3RhdGljIHZvaWQgYXNwZWVkX3Jlc2V0X2FkZXZfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYp
IHsNCj4gPiA+ID4gKwlzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiA9IHRvX2F1eGlsaWFy
eV9kZXYoZGV2KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWtmcmVlKGFkZXYpOw0KPiA+ID4gPiAr
fQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gRXZlcnkgZXhwb3J0ZWQgZnVuY3Rpb24gKm11c3Qq
IGhhdmUga2VybmVsZG9jLg0KPiA+ID4NCj4gPiA+ID4gK2ludCBhc3BlZWRfcmVzZXRfY29udHJv
bGxlcl9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpjbGtfZGV2LCB2b2lkDQo+IF9faW9tZW0gKmJh
c2UsDQo+ID4gPiA+ICsJCQkJICAgICBjb25zdCBjaGFyICphZGV2X25hbWUpDQo+ID4gPiA+ICt7
DQo+ID4gPiA+ICsJc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXY7DQo+ID4gPiA+ICsJaW50
IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWFkZXYgPSBremFsbG9jKHNpemVvZigqYWRldiks
IEdGUF9LRVJORUwpOw0KPiA+ID4gPiArCWlmICghYWRldikNCj4gPiA+ID4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlhZGV2LT5uYW1lID0gYWRldl9uYW1lOw0KPiA+
ID4gPiArCWFkZXYtPmRldi5wYXJlbnQgPSBjbGtfZGV2Ow0KPiA+ID4gPiArCWFkZXYtPmRldi5y
ZWxlYXNlID0gYXNwZWVkX3Jlc2V0X2FkZXZfcmVsZWFzZTsNCj4gPiA+ID4gKwlhZGV2LT5pZCA9
IDY2NnU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXQgPSBhdXhpbGlhcnlfZGV2aWNlX2luaXQo
YWRldik7DQo+ID4gPiA+ICsJaWYgKHJldCkgew0KPiA+ID4gPiArCQlrZnJlZShhZGV2KTsNCj4g
PiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwly
ZXQgPSBhdXhpbGlhcnlfZGV2aWNlX2FkZChhZGV2KTsNCj4gPiA+ID4gKwlpZiAocmV0KSB7DQo+
ID4gPiA+ICsJCWF1eGlsaWFyeV9kZXZpY2VfdW5pbml0KGFkZXYpOw0KPiA+ID4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWFkZXYtPmRldi5wbGF0
Zm9ybV9kYXRhID0gKF9fZm9yY2Ugdm9pZCAqKWJhc2U7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwly
ZXR1cm4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGNsa19kZXYsDQo+ID4gPiA+ICthc3BlZWRf
cmVzZXRfdW5yZWdpc3Rlcl9hZGV2LCBhZGV2KTsgfQ0KPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9H
UEwoYXNwZWVkX3Jlc2V0X2NvbnRyb2xsZXJfcmVnaXN0ZXIpOw0KPiA+ID4NCj4gPiA+IE5vLCB5
b3UgY2Fubm90IGV4cG9ydCBmdW5jdGlvbnMgd2l0aG91dCB1c2Vycy4gVGhlcmUgaXMgbm8gc2lu
Z2xlDQo+ID4gPiB1c2VyIG9mIHRoaXMsIHNvIHRoaXMgaXMgbm90IGp1c3RpZmllZCBhdCBhbGwu
DQo+ID4gTXkgbWlzdGFrZSwgSSBtaXNzZWQgcGF0Y2ggIzMgd2hpY2ggdXNlcyBpdC4NCj4gPg0K
PiA+IEkgZG9uJ3QgZ2V0IHdoeSBkbyB5b3UgbmVlZCB0byBleHBvcnQgdGhpcyBpbiB0aGUgZmly
c3QgcGxhY2UsIGluc3RlYWQNCj4gPiBvZiBwdXR0aW5nIGl0IGluIHRoZSBjbG9jayBkcml2ZXIs
IGFzIHVzdWFsbHkgZXhwZWN0ZWQuIEhhbmRsaW5nIGNoaWxkDQo+ID4gY3JlYXRpb24gaXMgbG9n
aWNhbGx5IHRoZSB0YXNrIG9mIHRoZSBkZXZpY2UgaGF2aW5nIGNoaWxkcmVuLCB0aGUNCj4gPiBw
YXJlbnQuIE5vdCB0aGUgY2hpbGQuDQo+IA0KPiBBbHNvLCBjb25zaWRlciBiYXNpbmcgdGhpcyBv
biB0b3Agb2Y6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAyMTgtYXV4
LWRldmljZS1jcmVhdGUtaGVscGVyLXY0LTAtYzNkN2RmZGVhDQo+IDJlNkBiYXlsaWJyZS5jb20v
DQoNCkhlbGxvLCBCYXNlIG9uIHRoaXMgc2VyaWVzLCBJIHdpbGwgdXNlIGFkZXYgPSBkZXZtX2F1
eGlsaWFyeV9kZXZpY2VfY3JlYXRlIGluc3RlYWQgYWRkZXZfYWxsb2MsIGFkZXZfcmVsZWFzLg0K
QnV0IGl0IHN0aWxsIGhhdmUgRVhQT1JUX1NZTUJPTF9HUEwoYXNwZWVkX3Jlc2V0X2NvbnRyb2xs
ZXJfcmVnaXN0ZXIpOw0KQW0gSSByaWdodD8NCg0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg==

