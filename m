Return-Path: <linux-aspeed+bounces-1561-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDCC77B7F
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 00:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRjWJ4dVKz2xKh;
	Wed, 25 Jun 2025 10:34:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750811676;
	cv=pass; b=gzDcxArM0mGRTOksrSFgaNChcEC+GOJTXNF0zyeshQ/JhZspk5i+paiH98Tak+fXgkN64bHyj7FDRe5yj/bu0WnCFvBYhpV5asngrZTzLCMINBVB8JTu+R3r03moeHYmCX4ERUcftDTRqk8TxM0eYFXUGspB+vqjiYWDW8mEp75zkgWDW5nkVTbKzmjfScv4I0WDhnhJwNwVmC6qM12eVN0vy8VZQyBo7zf4XRQvA5OMDw37/xVK/fqxjuh6VYuX4ixzLOm5cshTf5oAJs+U1cOIfzg943OgBKt8yxLaw7beE+LRbery87iK66/QxLDNSTeBY2VWh3s8siUyEop0RA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750811676; c=relaxed/relaxed;
	bh=6DgE6Qwc7Y/PE03VIETqTscqqpgPn66REvhvEVMndwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FhbW8I1cgWbt+b1EOPS6wxF543MiiV9XWE5YYLzK+sCGu08Tsj4GJTpEkzI7/u3uXpXHwaSuFXbXPaFh1UATJKnUveoBMzLWSEYZTZWHzAOQcq/z30hWaZ0vOkcUFkY/RxF5jA7ad1O1ng1bNNfAz6xJmF5ogtwx6AUOAXHihVMe4n1CAR9CasTNmdmjPghuw0uPjCfjfEzlUd+jcmuqdTegIZEokYpCV9YUGpbINHfJDXOmkzAZiptzHanKlQ0VAGhSDJxJrIjYJYoh+ePVA27LXdEBAvqVu6w8UB0cEde6g8m2XbEK0cRp8J5SbMDC4sAss8+kkDSU9vnPw7ct1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=JhpZlFsG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=JhpZlFsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRjWH6Hqkz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 10:34:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMHcby3f3eGRNcF8+mNPmT9sf0p9JGtzpzSit+towAl3pQYy0G5kmeJWfm4viSCPemFMEjUQA/Uc7kXwK/r/i2AVlI9PNufKcu9GRskKGIidIv5fLVxfgnJfFcMvwdF6Ejql4QErlpt+oeULHp7f4QrRQ/1Pty/P155xMqIXziMoMmWQFkdLU7xfiTbEdTW7AMO/MArWCRMWMeyBr47bGY3/RgiEoELpG4bYRfbmdLZAxVzz4NiXuOqdCdRI0WYic69klP0T9qU8xI02Sk8Wl9IT0DCAmxFCi0N8q+2l+lboW/zVMS0xTCi8FUYcI2psJU76iTwWH+jC3ttN/5bbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DgE6Qwc7Y/PE03VIETqTscqqpgPn66REvhvEVMndwE=;
 b=mQTAVvtxWX8Vb+1YwTV47ngh/mT1gBuiRXegTGJPzeBhGLkLidp0AdfOQQaYn3/uAAJGRdPrsqcUNG9m9S2/8wrHEUjXzPtua0OKVJHZRuyIblM5Y+hyc2w333cexU9P7y1PAfIlAUrsJ38oFuqwJTGRGLdUPezJjCgTemx6VRHsghq801W9zcPzbXBDnjottUT0+GPsw0MN+7mHpr9PIsUZNe1k1c7Xm89r6j8XddVIHFghmYjwb9KwBpfGk8ibhZtOKXMXuVxWT7/4N5LBdJHa5RHUFCHwdU6Qk9LswJzNIbNdin54+erAwxUabwlYnH1Lcnmawy9wizfaP8DaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DgE6Qwc7Y/PE03VIETqTscqqpgPn66REvhvEVMndwE=;
 b=JhpZlFsGig4EwJpTCUurn52vPbLCTj4KDM9f4MjEKhXJIWsrkDD93R33QqGzOAFm8Tf3JQMXsUXZ8NF+oN2AHZHJC2gbnFpThDSQwTGtn7vtRrI3Ez6RhMkm6I6u06MBZopp2XNgevpvrZzMeH+kqoEWVC2xsDmP3Oppa59vRvA2h+UxKe2HhFVHoLeVAQKY3b6ZUTJblGxsXExmy7qnMy69eu8k8GOPi6tXRoPrs3sZ+FgDsvX3hhdTfRdN4Dkp0RLJJS8KWz++W3S3widGoS2qdKzTNzvv0VHV061oskM8BrgT6D3sFtDmJVOqBx/iREfnnDDNiyUfmtEJ4vF5vg==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYZPR06MB6378.apcprd06.prod.outlook.com (2603:1096:400:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 00:34:11 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 00:34:10 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb5WgJ8CgI69GCtkOTNM5MVQqgrrQTBbfA
Date: Wed, 25 Jun 2025 00:34:09 +0000
Message-ID:
 <TYZPR06MB656893C53B13B2D288BCDEA1F17BA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
	 <20250623024456.2068370-2-jammy_huang@aspeedtech.com>
 <0ba565ac9444503be954161a8d79fa0476bd78a0.camel@codeconstruct.com.au>
In-Reply-To:
 <0ba565ac9444503be954161a8d79fa0476bd78a0.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYZPR06MB6378:EE_
x-ms-office365-filtering-correlation-id: 38296857-d003-4c9c-d249-08ddb380003d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjRSSDYrR2dQZi9MNExsUzB6SXd2R0JtV3g0N0RVZGNVeHZObWJDNGlmZTNS?=
 =?utf-8?B?dUJaLys5MHdDUzl1bnd0cmpHNHdnNUYzQ0tBdnpZbVp3Y29VMW56Zng5UXdB?=
 =?utf-8?B?bTdneUdSZGdodEk2NmJPL2NLbGQ5V2Iwd2dFbnZyejFCZXk1SzI3MnFKZFNC?=
 =?utf-8?B?MTZjM3MyMlMrQlNlODU2Y0xsK2dsT1hhNVJ4b0l1dGJSbHVlemdBNSt5aDd2?=
 =?utf-8?B?WUgwcFd1Z1dWSTB4RitRN0hpcVRFcnl0SnpETW1acXIyd0JpMGhsVy9PY2Rr?=
 =?utf-8?B?SzRwWWJqWk8xWnpUa3hDOHM4N2VnUTlDajR5Ni9nVmM2eU1raUpzMlVHUXNN?=
 =?utf-8?B?UUhhM2pqbkg3UHhlaDA1Z1lpZ3Jna1c0SUZzRm1zZDF2NStYc1Z0RWZYUUkv?=
 =?utf-8?B?YlJiZWpCbDV3M09Ib2JycWRzbERDRDlCZUl3c3VqK0hUOGVLcHVmUit6eXlD?=
 =?utf-8?B?ZnFIRDJYc0tUQTlNbUdtVUdqZjBYQkl2M1ZZMXVsVC94c0w0YVY5aXZGMkdy?=
 =?utf-8?B?ZnFtTVZ0cjZBZk43S0EwZU1OTzFkb1ZLTlQxNkVUK1FFcFpKRlpNZC9WUFpx?=
 =?utf-8?B?bWJDWnFjMTFrUjA5SW1UZmZjcGMvTXZ4ZkRsZ214cjM3Rk4zQ1p5N0VOdzBa?=
 =?utf-8?B?M2tvN0VPU0NlMkduQmNudVpzOUc2eWtzRDN2RERKY2RVWE1zQ2p2Uyt5RGJN?=
 =?utf-8?B?RHBFTmJWOVFNN20zSnFTVGtzZFRObzl4cVVheURWU2crNk5kUVdMd0VnTGFw?=
 =?utf-8?B?RWhYTkZ3TFp3NDE1d01EajZPUjFENXlVNWxMZ3Q4aGdnbGQzYkVSS3VyYkhD?=
 =?utf-8?B?M09nU2hmYTU5blB6ZzFhcWJFQ0M1Q1c2Mk1pc1YzYzVjQ2MybkN6ZytnS2Rh?=
 =?utf-8?B?cXVCT0s3SFBJV002NEREczRoWXJ5OFllYkF3anNjcExjVllVNy9STTErNnJl?=
 =?utf-8?B?SENNSVZEeGxjYWUzRUJQa2RtQkVSR1kwM1UzdUgwRkZUN2lSbWN5ZVpCeklQ?=
 =?utf-8?B?N3pKNGE0b2ZNazFQRU5DcHJRWVdyYVQ0bEdPWmMzUUFYUUpZWFdwTHc5Q284?=
 =?utf-8?B?NVFBU28zdC92WlNvY1NDOXNlYURwUit2MzRjN3BLVmxXaUJscFJMb1hrS1lW?=
 =?utf-8?B?MThwek8rK3pFMVpkT3VJSHVtTmZJbzZGbVNESk91WURHWW9IRi80dVc5WGVQ?=
 =?utf-8?B?dk9HcWl2TzloMVlZcUJ5VHRIcWlySndod0xGTXBRQitsTDB1UFREM21xQWh2?=
 =?utf-8?B?SWhzNDdVU3VMVGFtUEJWeWJlZmZySU4vS2dBaHYvSHNpY3hhdDNvV09Qd3Zy?=
 =?utf-8?B?eDBCU0FuOUxuVlp6anRWbkZnSHlBWGlNam1WWUZFblNEWU0xdFZEQzVVMmFH?=
 =?utf-8?B?T0sySEtlR3QxTGlVOXZBc01DUXpQNGtaa1R6MnZYZWJZREYxQXMvaG9RTUNH?=
 =?utf-8?B?SHY5blplWnVRZlVZeEI0TkgzV3dNYzFHRVpkZWpkQjRpMXc1eDFQenlSVGpZ?=
 =?utf-8?B?VHpEMEtvc3E1Q1dsSzc4SVMyQTVVaGx2N1c1VWpyT0ZJWVBFUW5VdURNa0lF?=
 =?utf-8?B?OGgvL2MzZlV6c2Zmd2JHSTgwZUt6bjJhVmt1cjVnZC9VWXhGRlNNRmZNMldR?=
 =?utf-8?B?UXpBc3dUeEwzY056eGp6eVlicmplV0RWaEsweHRLYlBWMjBpYk05cjB1TzVZ?=
 =?utf-8?B?K1Q3WFhsRXZJU1lBemhVVkRSYnlUV01pQ1lLSHZ1Ri9XK09GOU9GK0FzM1Bh?=
 =?utf-8?B?RnJGVFMzYjRsNWw3N2FwbjQ1RHRsanF6ZlNHOHEwZ2NMdWNmelAyRWZqbkpu?=
 =?utf-8?B?M0pDM2x3VEVBcXhYcGZKRDBQa3pQaSsyMGdDR2tmcnRXT0dlU1NKc01WcTNZ?=
 =?utf-8?B?TFNZZmJ4OVJVWEpGRW1oK0hweWIvSzFsNTh0elJuUUxyOWl4eGJ3ODdNblc4?=
 =?utf-8?Q?itCHtsL8VfQy7YYFi1FuG+q4yFah5otW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVVrbXNQMGoycHpOSDUyZ2NTR3pkYVQvdTB3czJwWlBmcEhaaG9aQWRkQzRB?=
 =?utf-8?B?R21yMFl2cC9WUlJRZzlwSUVGWlFwdXBZVm96TXJxVW5ab3d3NTdOa0VVRDVK?=
 =?utf-8?B?RU5aMWlYUk4rSXl4RmtKb3huQ0lCMUhFNEJvTDI1MjN5WUFudEZkT1ozdTBu?=
 =?utf-8?B?dDM3dUwzUThCK3RZZmkzYStxZ2ZWd0Mwdjc2V3ZEZXdKQzJlVGFxdXVaNlM2?=
 =?utf-8?B?V2FUWk5uRThYQzFFK1IvYnplSUx2YWNVSFZUYVNZNmZnUjFqckpmUnIzVzhh?=
 =?utf-8?B?UHZ0MUQ3S05BUW1ZLzBzQUVsZGJFanMwMXZ2aUtQS2NwOEVKTGpDNjhRa200?=
 =?utf-8?B?ZDFiVnFHOUpVajR6NTVFdEZlWVQyNklXZHM0ZER6TEg4V1ArOGRuUUdqTW5o?=
 =?utf-8?B?R1ZMbWVjRS9sUmVnYjlYcFNDUmJncEtCTzc5cmlJVmxGcUdIS1p0ejI3RHA1?=
 =?utf-8?B?UVlSMGRnak5GR1lDMjZDb3BQQ1diN3dqc1lBSDVZSklnUUV6Y3JmU3duZTh4?=
 =?utf-8?B?aDk0SW1MQkROT1VJN2cyOUE0dXBXdXVEaWN0eWRaMWhnaEd3WnRPaDRwazNY?=
 =?utf-8?B?RllsRzhQRXFic3JDNkdqanR1Mlh6NVptb1p4SHY4OTczRTBrK1U5SERkNG82?=
 =?utf-8?B?WUFNWTg2cDdXTGsralYyVERYZmlZU2pHVUh0OUdFQnA3SzAxdkg1TnFKb29Q?=
 =?utf-8?B?QU13Y3VQUGJhVCtSaHM3MWNiOFRia0RKRGpYZUUxelpjb0F0TnRPUWtJUnBl?=
 =?utf-8?B?VStLNmI5ZVVyejJoMmFBRWJQVDcrZWtleEdsaWx2OUtjK28yWXk3aVdFL3Br?=
 =?utf-8?B?U1hIMjNwcmY3SytwNlI3clcvRmpObWtubUVnYmVaNHBBcXFtTGhabm9xell3?=
 =?utf-8?B?cUw5TmZ6RHVkUk9QOHdVNDMrOXVYVmU3Yks1dDJEdDNMMllKeUdmZEF6UU56?=
 =?utf-8?B?Um1oR1Rva25RdjNMU1F3SVpMN1RSdXd3V1pSOFAwcmEyRFFUcEw0a2RHSmU2?=
 =?utf-8?B?Z25TTnNHc0h0TmEyRGpxbTlRWnRyTzdrYWpNVHlEcitVQ000bjUzemVzbmh3?=
 =?utf-8?B?T085UHh0U3kvdDJRTDhBUEtqVUJKb0R1VW5iNHJCQzczVnRONzhyYm5JYVhQ?=
 =?utf-8?B?N3BHaTJmNmVHWDQ2aVRDUlM5VDFFOXM4NUVoMWxrK0VtY3p6b2xhKzNuTkJp?=
 =?utf-8?B?QTQ1R1Q3RkEyUXo2dmJka2dUaXZRWG04RUFaUXhVRFBURTJHcm5jUXFyYjhM?=
 =?utf-8?B?ZHlhL3Iwb0JkS3EwUlJuKytiTk9iNm5RSHU4b1p2c1hXbFdUbUdudW9pV0RM?=
 =?utf-8?B?ektOb0VtL2NTVGV0L2Q5dVZaQ2ZZWXpYVWcybWFjb25lY1ZCSXgwZlJxeXl2?=
 =?utf-8?B?aTgvcW0xbnlqS054L1VXZUdoZGZYWGxQTldFbzQxL0dzRHpzZ1U5WWFXTStu?=
 =?utf-8?B?U0liK1d3MmtZTkVDWURJZFVZWElXVko5eVMwSFRRbGJ0aU9LeEUxcjAzdkJq?=
 =?utf-8?B?ZHBUcUliamdoRGg0Uk1TQ0Q1dVNtQTlZdlo5bE5YNHppUnlZZGpJbFh6Mkh2?=
 =?utf-8?B?VEU2RVQvSVpOWWk2bEhGSER0bTFQMTEwQVpGeTRVY1B5KzJrckZETzdrNnAv?=
 =?utf-8?B?SSt6ZHY0VGg3aFMzNTBLbjJpMmwrcmtUaHBPbUQwcldQcmVSa3hJcUt1Q2NH?=
 =?utf-8?B?V2ZqYVM3QkhrcWV3aWNHMlduL3ZPVHVsOGpVS09tb25mTFpzNkNwUStHaWhZ?=
 =?utf-8?B?V1VIUDV6MHFIVERjWk12ckkvYUhhUS9nTHU3SCtrQ1VyNndORnc4elRvZmtI?=
 =?utf-8?B?cXNHUllYMFg0bmVYZXZJVmVIZDMwRFBLYW1NYUliUmt3dEtIU1h3WlNHRHRz?=
 =?utf-8?B?amlYU2RDTWFleXYzVGFmcVFmdk1aSmRFNkd0aWwwT2NTeVBDY0U0VHE0R1Rm?=
 =?utf-8?B?NHRGWEE0cjRNaGpRVjZHVkpWRWlMOGJGaTJpQzd6K29wM0FqMHpkVVcxbmFF?=
 =?utf-8?B?S3A3NDhabWV0eXdMY1g2c1I0T1ZWMUV4MktRSnZVczROZXlhTzFxZVMvMkhY?=
 =?utf-8?B?MVhSamZtNW4wVE9FMExXZTF2empUVmVselBvR3I1U0lTa3NxcHBLclA1c29X?=
 =?utf-8?B?ZytXcFVyQ2MwWkN5SjdqMnhoRGpGYkNxME1BV0wzVy9EdVJVeHVOcHl1Q2RO?=
 =?utf-8?B?Z0E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38296857-d003-4c9c-d249-08ddb380003d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 00:34:09.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Fo91O/o22RKnpM1UKDFtyOgi2BzHQ6GlK6rhLsh8W5v8oEYzwibfTONWoRM1+vWwWlhmlvpt4XVCjhAzA7qTpfOQbv+DGZYKxs9GEkpFtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6378

PiANCj4gT24gTW9uLCAyMDI1LTA2LTIzIGF0IDEwOjQ0ICswODAwLCBKYW1teSBIdWFuZyB3cm90
ZToNCj4gPiBJbnRyb2R1Y2UgdGhlIG1haWxib3ggbW9kdWxlIGZvciBBU1QyN1hYIHNlcmllcyBT
b0MsIHdoaWNoIGlzDQo+ID4gcmVzcG9uc2libGUgZm9yIGludGVyY2hhbmdpbmcgbWVzc2FnZXMg
YmV0d2VlbiBhc3ltbWV0cmljIHByb2Nlc3NvcnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW1teSBIdWFuZyA8amFtbXlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
PiAtLS0NCj4gPiDCoC4uLi9tYWlsYm94L2FzcGVlZCxhc3QyNzAwLW1haWxib3gueWFtbMKgwqDC
oMKgwqDCoCB8IDU3DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDU3IGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FzcGVlZCxhc3QyNzAwLW1haWxi
b3gueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvYXNwZWVkLGFzdDI3MDAtbWFpbGJveC55YW0NCj4gPiBsDQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9hc3BlZWQsYXN0
MjcwMC1tYWlsYm94LnlhbQ0KPiA+IGwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uOWM1ZDcwMjhlMTE2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FzcGVlZCxhc3Qy
NzAwLW1haWxib3gNCj4gPiArKysgLnlhbWwNCj4gPiBAQCAtMCwwICsxLDU3IEBADQo+ID4gKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwg
MS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+ID4gK2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL21haWxib3gvYXNwZWVkLGFzdDI3MDAtbWFpbGJveC55YW1sIw0KPiA+ICskc2NoZW1hOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4g
K3RpdGxlOiBBU1BFRUQgQVNUMjcwMCBtYWlsYm94IGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICvCoCAtIEphbW15IEh1YW5nIDxqYW1teV9odWFuZ0Bhc3BlZWR0ZWNo
LmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICvCoCBBU1BFRUQgQVNUMjcwMCBo
YXMgbXVsdGlwbGUgcHJvY2Vzc29ycyB0aGF0IG5lZWQgdG8gY29tbXVuaWNhdGUNCj4gPiArd2l0
aCBlYWNoDQo+ID4gK8KgIG90aGVyLiBUaGUgbWFpbGJveCBjb250cm9sbGVyIHByb3ZpZGVzIGEg
d2F5IGZvciB0aGVzZSBwcm9jZXNzb3JzDQo+ID4gK3RvIHNlbmQNCj4gPiArwqAgbWVzc2FnZXMg
dG8gZWFjaCBvdGhlci4gSXQgaXMgYSBoYXJkd2FyZS1iYXNlZCBpbnRlci1wcm9jZXNzb3INCj4g
PiArY29tbXVuaWNhdGlvbg0KPiA+ICvCoCBtZWNoYW5pc20gdGhhdCBhbGxvd3MgcHJvY2Vzc29y
cyB0byBzZW5kIGFuZCByZWNlaXZlIG1lc3NhZ2VzDQo+ID4gK3Rocm91Z2gNCj4gPiArwqAgZGVk
aWNhdGVkIGNoYW5uZWxzLg0KPiA+ICvCoCBUaGUgbWFpbGJveCdzIHR4L3J4IGFyZSBpbmRlcGVu
ZGVudCwgbWVhbmluZyB0aGF0IG9uZSBwcm9jZXNzb3IgY2FuDQo+ID4gK3NlbmQgYQ0KPiA+ICvC
oCBtZXNzYWdlIHdoaWxlIGFub3RoZXIgcHJvY2Vzc29yIGlzIHJlY2VpdmluZyBhIG1lc3NhZ2Ug
c2ltdWx0YW5lb3VzbHkuDQo+ID4gK8KgIFRoZXJlIGFyZSA0IGNoYW5uZWxzIGF2YWlsYWJsZSBm
b3IgYm90aCB0eCBhbmQgcnggb3BlcmF0aW9ucy4gRWFjaA0KPiA+ICtjaGFubmVsDQo+ID4gK8Kg
IGhhcyBhIEZJRk8gYnVmZmVyIHRoYXQgY2FuIGhvbGQgbWVzc2FnZXMgb2YgYSBmaXhlZCBzaXpl
ICgzMiBieXRlcw0KPiA+ICtpbiB0aGlzDQo+ID4gK8KgIGNhc2UpLg0KPiA+ICvCoCBUaGUgbWFp
bGJveCBjb250cm9sbGVyIGFsc28gc3VwcG9ydHMgaW50ZXJydXB0IGdlbmVyYXRpb24sIGFsbG93
aW5nDQo+ID4gK8KgIHByb2Nlc3NvcnMgdG8gbm90aWZ5IGVhY2ggb3RoZXIgd2hlbiBhIG1lc3Nh
Z2UgaXMgYXZhaWxhYmxlIG9yIHdoZW4NCj4gPiArYW4gZXZlbnQNCj4gPiArwqAgb2NjdXJzLg0K
PiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArwqAgY29tcGF0aWJsZToNCj4gPiArwqDCoMKg
IGNvbnN0OiBhc3BlZWQsYXN0MjcwMC1tYWlsYm94DQo+ID4gKw0KPiA+ICvCoCByZWc6DQo+ID4g
K8KgwqDCoCBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArwqAgaW50ZXJydXB0czoNCj4gPiArwqDC
oMKgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoCAiI21ib3gtY2VsbHMiOg0KPiA+ICvCoMKg
wqAgY29uc3Q6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICvCoCAtIGNvbXBhdGlibGUN
Cj4gPiArwqAgLSByZWcNCj4gPiArwqAgLSBpbnRlcnJ1cHRzDQo+ID4gK8KgIC0gIiNtYm94LWNl
bGxzIg0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArwqAgLSB8DQo+ID4gK8KgwqDCoCAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsNCj4gPiArwqDCoMKgIG1h
aWxib3hAMTJjMWMyMDAgew0KPiA+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNzAwLW1haWxib3giOw0KPiA+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxMmMxYzIw
MCAweDIwMD47DQo+IA0KPiBJIHJlYWxpc2UgdGhpcyBpcyBqdXN0IGFuIGV4YW1wbGUsIGJ1dCB3
aXRoIHJlc3BlY3QgdG8gdGhlIGRhdGFzaGVldCwgc2hvdWxkbid0DQo+IHRoaXMgYmUgc2l6ZWQg
YXMgMHgxMDA/DQo+IA0KSSB1c2UgMHgyMDAgaGVyZSBiZWNhdXNlIEkgd2FudCB0byBpbmNsdWRl
IHR4L3J4IHRvZ2V0aGVyIGluIG9uZSBtYWlsYm94IGNvbnRyb2xsZXINCmluc3RhbmNlLg0KRXgu
IDB4MTJjMWMyMDAgaXMgYSBJUEMgd2hvc2UgVFggaXMgTlMtQ0EzNSBhbmQgUlggaXMgU1NQLg0K
MHgxMmMxYzMwMCBpcyBhIElQQyB3aG9zZSBUWCBpcyBTU1AgYW5kIFJYIGlzIE5TLUNBMzUuDQoN
Cj4gT3RoZXJ3aXNlLA0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+DQoNCkJlc3QgUmVnYXJkcw0KSmFtbXkNCg==

