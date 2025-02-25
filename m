Return-Path: <linux-aspeed+bounces-830-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC04CC021B2
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 09:49:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2CWF0T8zz30Gq;
	Tue, 25 Feb 2025 20:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::717" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740476984;
	cv=pass; b=Nqa0L/0YrtVAg+mELkH4nsO4NpES+H5khZF5RVWKSTmKcFvMYJT0t1ptjsekz6iFZp4HA0izoIb6qxw0AXkG9d3AOst8cm258Q7ogEtImcSSG67a6HGlOGlbDsDhP2yhKj8aFgPKFOrx0kEODtPbZJ5g+uDZHtdBmlE6l0broYlXIEKmLfmrIxgh+djnMoyvVHxYw/a4JQ8OrRldi7sLJtwZ93vrCRQSof2MikvqRBsdXIfQf++D7kukHRfaeTsjNCBt8c9rGTTXdZmc/CsrNZpBlLqyWzeWVCvNP+ZoEnQlNKzV+VS+DqYmNQl+ZJh8xJwm+JLNjPGanrkSeFpPBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740476984; c=relaxed/relaxed;
	bh=Pw1rKAtvjCj1C3NE99f0WO/YOM+Ixy8qHZ2neY9l2Dg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLFyJrACLvxwolU8AOeDCzDUWEhq1rviLgpihqOMxjVXuK8+nrkO690uLOXOYKikZc4x0HBCuWgcm0xmqRXV6PBvkcr7IrxkwDel1nSAqCLl35xO9AlLscc/Eovou/45Z+TCGux9gEPucGgAbXeW84T5MF8G1kOAQYaKZyp0MgR+BVuvqvNBT8mK8UJN08ynB0U944yZ4lY3wPK9LBbFnz3zj8VLC+43/xh4nQFJmATRGjghoS8jJxYT7KBiKaHxYCwkF5sGAmV+GO/yoOR/e/0VUOvOPGcMlnRSK+3fyn+u6YK8Q8PSyDBRT8iqByzYaRSfHccNQaKCkbr9HqkP9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gWITsOtL; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::717; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gWITsOtL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::717; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20717.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::717])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2CWC0ylgz2ykX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 20:49:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvrg+x9FA72u4Bd8jKrpzr1iS/48cF484yRYlp1xtgfeLq9QHTSpePjQW1aQlaWqzJx8xwcH94bCMB/hztoxxO5gdI5ZkqA9TbYjBZtlAILEcGa5LtvPE5dXFF40Zflpl8zQ8Ae3kQLoc0pkoac/m3g2Mfyf9bfZq0j7LqywU3UFl1Y7y2nfoxGlH12sRysegJpba6NYt+hGGtQxuox2YYcnLmtOxuuaoJNoBxlWQOp/OD26eGRxCXj4ExTr5vMHGCQSi9mcyvYapJ1BU4l1Bgd4p0Nrj8oE4oYXPBd7Opx11IiLDhQsjreSUGglZs+Vva/JDaUEjLrcvQpEq9UaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw1rKAtvjCj1C3NE99f0WO/YOM+Ixy8qHZ2neY9l2Dg=;
 b=f7xAPTbWrjKpL3MYOEjMjjkUZz0hHZ6cvdqMN+iDMwnIUkUsfNMn+AcbAOPTscQSxy8KOcnX9psdjeyCTIQeBpNmYmBxjExxNPxGFyn1vFw0FcFZ7RmPz4MTqhBiDSLvRdH4kMJni6rz/ciZ7/2byDlrq3UfJbKe68/2oowdNOfXUYxfdVEnX1f6oOL+r2TWQRhp94iUhDTFt/9oHOig6UXixfQ05rAUAazE+46RhBe5k387+cgmyMe9m/SbPf3KoU/Ahri+L6jatQVd62HztfzWwVgUQC9kuAMu1ZlQvDFkYIEvRFi9JCMAeKoJtUSNOWnUanC1DUnXaOcGxImQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw1rKAtvjCj1C3NE99f0WO/YOM+Ixy8qHZ2neY9l2Dg=;
 b=gWITsOtLD7+nK3Dp95Z/7a7fYPbrtJ81yUV7wv77+9P/NP7yq1e6DZ2K5qQwa6sgYd2wMOnSjJh5PUtxdQu0BlgWhh5wv8T5SEW2gDqZKEIMAHxQVBepO9D51pW2I0S4ztOVfSVul3RBHBh3Kciu30gzdVtBPGSTDycLwFEpIMwhibsWk6SVBiy8sJOakDDBV9iShN6YZ3KvSx1j5aWl/mvUhsyZYkbx61PdTGGyEadXuE6GylA6niH57BWmg9SqSp1RCB80N69BU6LejPPrlqzl3IQtpl31ZUpU629qsEbtKOjjo8OH1OSQgHxr6rhH8cjWzgBWP7ijuIvnSi+JMA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6996.apcprd06.prod.outlook.com (2603:1096:405:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Tue, 25 Feb
 2025 09:49:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:49:18 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index: AQHbhqIygZnvzo4Bt0Wa/Nj5P77JfbNWO12AgADwbfCAAHvmgIAAHaSg
Date: Tue, 25 Feb 2025 09:49:18 +0000
Message-ID:
 <OS8PR06MB75411AE082C9630314966F2AF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
 <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
 <OS8PR06MB7541D685A626D300AC730A5BF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <2b64a9d7-7048-4842-9cc1-fe23f5abdd00@kernel.org>
In-Reply-To: <2b64a9d7-7048-4842-9cc1-fe23f5abdd00@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6996:EE_
x-ms-office365-filtering-correlation-id: 67aa8074-9700-4c88-e8e9-08dd5581abfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3FqQ09mWWp6SWh0c2dDdXRLeHpKN2szQVBRaVZ4eWtrMUgwbFloSFdFak5q?=
 =?utf-8?B?THBFbUQ3c09OZHF4ZmxFemRWZDN1VXRYcW9HaWVnOFZUVlh5dlE0L3Yrb1pi?=
 =?utf-8?B?TVIvOGdiRmZ6eGhxblQveU1LZTFJMUlDZk9XR2c4Snd4MzF4eDBla2piQmpW?=
 =?utf-8?B?eVg0WGxINEN2dW5oZ2JBLzNzM3FrU0RwUGdJanNPbyt5Nk9qTTJIdXNnYWtr?=
 =?utf-8?B?OWxEdFhtNE42Rk5lVVIvTnZsS0QrblJCK3JkSzc5SzhnZThWK0tORHVVY21N?=
 =?utf-8?B?dXpxbUh4dEhFOUU4UFBDUFFhT09vbjVlOFR5QzR6bFhHTC96SWFUQ1pBMUlj?=
 =?utf-8?B?ZHZvNXNic011bEZGalp4OUQrRzNkQmlLYTJuQjJiZjZGd1F2RC9Ib1VKUk5I?=
 =?utf-8?B?dGphdDZlM29TaEc1bWs1M1VwYklxTkJzMXdpNlNsN2RqMGtNRUdUK1lnc3hJ?=
 =?utf-8?B?dGJZSUtlWGtjUjNXUHVxSDM1a1RUbE9XcVBSNkZnTi9PcVFDYyt0UklCemhF?=
 =?utf-8?B?MjNGbHVTVy9STUNsbTRrTEdNWDUwKzFkNTEwRy82SlJhQnZNdUNPcGYxU2c3?=
 =?utf-8?B?NFRHczZNSERSUVFhcHRoNEhlL3F3TVk1TndXdlBjazFVZ050ZkFra2Y5R0ow?=
 =?utf-8?B?WXQ4OEowZlgramNBUEdlQTExQ21JRWoyWWJud3F4emV1RFpLc3JoTHM5OHZr?=
 =?utf-8?B?MlQ2Q2Jwc2h6UWRvNVB2Z202VWpDMnNkNm9NbnF6czk5UlU5RXIxNjF4OXBV?=
 =?utf-8?B?aGFZbWN0RkRTWTNXSlh1aG1pMi90b2E1b3lxRENSeUJVSGJhU0U1ZGNOVEdO?=
 =?utf-8?B?L3RVbHdPeTFvUkRYbXZQdEFidEEyQ2tnVjRIcFR3aFJGRVNMVnpyUXQyams0?=
 =?utf-8?B?ekNpMzJsWEFJVE9JN0U1TUMyNlVYS3ZoSncvT3kwMGRJMm1JRStNM2NCUlJ4?=
 =?utf-8?B?QmI3dC9ZMEI4ajlRRk96NlVhWjFhTXdXQTliemVaWHFpZ0Z3K2ZHUnNTUk53?=
 =?utf-8?B?dlZEVHFCYzhsdlZ6M29CeUdDOVI2dlo2dWxGc3ZybFp6clpxSjJYTHBsbmd0?=
 =?utf-8?B?c1M4SmthbEowK2xDODliNWFKZlJDOHVEQitiTFVTdEVad2lTUXdDUmRJS1pL?=
 =?utf-8?B?cWlHSXpxbFVDczRRL3ZleE9mL1dJTjBvZ1FRY1RmREc0QTVnMGZydjdJeFV5?=
 =?utf-8?B?WVlyeU1hVmUzRVlRMThWcVFTZzNLUVFUUkdDTGZtVHdiQ3oxM29WSUYwZmx1?=
 =?utf-8?B?WGpZQmhJYU9JK05XQzhwcEVKeWY3bXYxVmNNK0NmYU1pcEVkSVQvTncvUmpR?=
 =?utf-8?B?eUJnVVZ5VFZpMVpHOTFaZUJEWlZMOUdjcGl0dmlxdFhEazBpcEMzblZZZHpT?=
 =?utf-8?B?YkJIVVRHRXFueDVtT2swK1VLQXJZVy90NDhkMEdPNzdpa3pjS0p1V1hpY04x?=
 =?utf-8?B?K28yWFJJUVhsQnVjYUlEWFdiYTdBdklKSlZzclBIQ3lEOWhrVWRyWXovaWpU?=
 =?utf-8?B?YTJGYlMxTlZGRjJDNTVwNGRiaTJnbmFuSmExaC80RG84LzRpTkE5QlRJb2NM?=
 =?utf-8?B?anV6QnNkQmhjQUc0bG0zWWpPd2xBN2hWRUpJTEs5WjFKeWVEUmtwRWd4Rmhw?=
 =?utf-8?B?Qng3dWZvalVWL1NHYjFib2cwcU5jdnhXMlJaeS8xTkRDNUVrY3NFZkoxOUZl?=
 =?utf-8?B?dFdGWmtXczBZcXErK1cweDBYQnY4Zk1tRC9ZeENuV0p5VVZBeWJHaXYvY2p1?=
 =?utf-8?B?eFlUell4cjgrWlkwWXJrbHp0bmt3MEpZK3MxdmdFaGR6a29yRXZLNXlRZ3VU?=
 =?utf-8?B?aytQZnZtSmxqMGhwUkpvRXJ5VkY1UzNKRDNXL0I1dUYzWnlHYTFNL0NvMWZT?=
 =?utf-8?B?YWMvUThhbzYzUVJjdVpIMzdWdkkrQWNsK0hqRHlTVHo0eFJQMlJuby84OElr?=
 =?utf-8?B?WW5NZHEwdlROYlV2RldvOUlPS2lSNlp6c01yMFFjdElTNHNKRVM1ZVMrMUls?=
 =?utf-8?B?QkdFNmxoOThRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUxYUG5SNlJJMUg3TWp2UEN4Vk1GRldGM0JoUS91ekhkNjdDY0MzaVU3dDhC?=
 =?utf-8?B?QmIvUVdrY28yL3doRDZVdFV4WnpZZGtPMCt4V3h5b2Y1d1YveUFaVTdFTExH?=
 =?utf-8?B?ZEFqQS8xRldldkFMMlZ3ckY5L3k2L2JWU0luNjMvQmh2eHBVOURIUHhrUjhl?=
 =?utf-8?B?dGJrMXNySkNlV0tRaTQ5ejkyZ1g5K3VDN01TVWdOMXJsZ2ZodXJkM3RzOWt1?=
 =?utf-8?B?NyswODd2L29GRWZYanpEdEtYRXNOc3BNbXFvZlJQNXRtK3FCYzhjL29Meno0?=
 =?utf-8?B?MCtWU2tYU1hXQmV0c0Z0eHFROUdWT2MxVk9obDQwekNRN3BDYnhhak1yZTFI?=
 =?utf-8?B?WVZ5V3hxQTFadzVvd3YrdE5uNmlZU2duaEtrb1l3K0tpYTBCY2ZVZkdrNDlL?=
 =?utf-8?B?MFlwMUUzYy9Vb0M3RXNPNXVaekFVWVo2VVAwQnpSU0tzQy9BT09aRWkySVF3?=
 =?utf-8?B?UkR1ejF1MzZuZ3RCdTNFOXhrS3BCMnZKK25tRm5yVWxIY3RZTGh4NExMa1do?=
 =?utf-8?B?RGtpOCtld2p6UXMvWDFuVExDdzFueFFZWFMzamxjbXpHTDJsMjR6KzIza0hi?=
 =?utf-8?B?YXdPWTBmZlNkZHMxRTdzUmlPeUdCSlZoVzIxMDVQT1kwNEtGZVpPbjBXVmUy?=
 =?utf-8?B?bUdqYnRmYzVTT2Y1TjdWOG9PY0s2ZHR2NW5WYUcxUHpCb3krbytwQXZ4V0hD?=
 =?utf-8?B?RGRUMVVWT2d2UlFQazl4MFg1NjJEMkxhN09wTE1BMXJCdk12eTZVZ0pXWGY1?=
 =?utf-8?B?czdxOE94OVFSV1ZCTUV0QkxQK0hPTFhBT2tSbVlJMnBXTjdHOGpoWGFxTEpz?=
 =?utf-8?B?TGVZQ3RvdzFvMDE0RWNzdDlmckpuOElOYXQ3ZU8yc3lqNkp0NlFySzNGeEow?=
 =?utf-8?B?US9Eeng0T1BHL2hoVGYyRHlBTGJaaGJtajI3UWNBSGZ6V3N0V2FlSEpCVUhz?=
 =?utf-8?B?QnRjVlFGc1p6Yld2WnhUeXJuV0llWCswc1dqQTlNdDVBS2tVM0I4MFQ3MXgy?=
 =?utf-8?B?Wjc3SlhSd3I0OFFPRko3ajMvVGgzcjJHOEo0Wmk2MDUyR0FOMDQxQmt6bGxy?=
 =?utf-8?B?YlJ4OHlqS1dXTndMN2tqRWxxZjlXQk5XUjh4Qy9UeXNlWVQrRFJUb3Z6OXJa?=
 =?utf-8?B?V2ZJTXdZNFlSNnRjWEl5Rm53RkpUdEZ0UHdVMHRsOTlNSG43THE3dElHSGVS?=
 =?utf-8?B?MVlQQzNDMkkrSW1MaUU0UWpaNHp2NlBaYkp6NUpJYUV4REpCK0NrSCtQRkJD?=
 =?utf-8?B?V1VSZFBzMlQ3bklnMUFHUlhocWViUjBEVEFnbTRVREN5Y2VrRS9qa3VKaktM?=
 =?utf-8?B?d1pwcHZWbVBEaXY0aCtnK0ZEL2cwNzBQcU0rcW1vZU9LT1ZITnAwejMySHF3?=
 =?utf-8?B?TlRYQkV0WWw0QnliT3hURllxU2p1TU1xeVViNWV5MlUvVEpxclhtaDRqYXFk?=
 =?utf-8?B?cHROUyswaHkwU2JGQ3NmZWplbTRYWThyREdBcllON2dNNHo4ZE55anFMK2Fu?=
 =?utf-8?B?Y3YvVldydERDeHpHMlQ0Vm1XNTBMTU5NZDE3RllNYk9wZzM5cEZaT0luUkRG?=
 =?utf-8?B?VGFRVlhwOWVmTEV2b3RhQXVGTm9qS3U4RHhlOE84SHAzN043MXRoZEIxeEx6?=
 =?utf-8?B?RDR5QmhDdUpQSDlBVDgwdGJwYzZtQjlGbmhZZ0d2OHJCWTNKOGhNOEtZL2pQ?=
 =?utf-8?B?bnFxUC9UZTd4VWNUNDMwR2hUbTZiSnQ0MXloTWdxekh6ZjRtbVpUNXpFQmYr?=
 =?utf-8?B?TTBveTJSbjRqMEI0RlZUbVBUbkZTbm9WN1VvU3daMkVnb3dhaUx2T05XeVB4?=
 =?utf-8?B?VzVmb0ZpWVFmaW1ZVUhMVUR0di9lU2dHd0J4dUNOVnhJODBJTUJobW5zNTBZ?=
 =?utf-8?B?c0lKSnRGbk5uTEhxVnp5djdhYTRSS2tGaHR2bkx2eHJDT1RiMXVqc3R0dDE3?=
 =?utf-8?B?QVZRdTI1elFNRXBQeXhKdXFBVHFiYXBNMURZOFhyNndhdThocnFuWFc4ckxr?=
 =?utf-8?B?YlBnSHhYeWdFVTlML1A4VHYybkRuaGxDaHdmbnBXK01SL2M0RGIrNkxSU2hI?=
 =?utf-8?B?bnZmeG9OQ214VFQ2OGxMM3VmUDFXYUtsdUcvcmJ0MFlvV3doT0M4V0YyZVdh?=
 =?utf-8?Q?wmyib4iIVWUkFCbpoMTAXrhT8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aa8074-9700-4c88-e8e9-08dd5581abfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:49:18.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xU2CalzfpeGJjbdZJAkQ8UlishmtOLZWt6ZdAFcqbsQ94wqatDw7ipAu3AfYjFzvOwITDLGyKtGYv6P/fPZgOFpiqcJmAyrHsZdDcjrh4Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6996

PiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDEvM10gZHQtYmluZGluZzogY2xvY2s6IGFzdDI3
MDA6IG1vZGlmeSBzb2MwLzENCj4gPj4gY2xvY2sgZGVmaW5lDQo+ID4+DQo+ID4+IE9uIDI0LzAy
LzIwMjUgMTA6NTUsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPj4+IC1yZW1vdmUgcmVkdW5kYW50IFNP
QzBfQ0xLX1VBUlRfRElWMTM6DQo+ID4+PiBTT0MwX0NMS19VQVJUX0RJVjEzIGlzIG5vdCB1c2Ug
YXQgY2xrLWFzdDI3MDAuYywgdGhlIGNsb2NrIHNvdXJjZQ0KPiA+Pj4gdHJlZSBpcyB1YXJ0IGNs
ayBzcmMgLT4gdWFydF9kaXZfdGFibGUgLT4gdWFydCBjbGsuDQo+ID4+Pg0KPiA+Pj4gLUNoYW5n
ZSBTT0MwX0NMS19IUExMX0RJVl9BSEIgdG8gU09DMF9DTEtfQUhCTVVYOg0KPiA+Pj4gbW9kaWZ5
IGNsb2NrIHRyZWUgaW1wbGVtZW50Lg0KPiA+Pj4gb2xkZXIgQ0xLX0FIQiB1c2UgbXBsbF9kaXZf
YWhiL2hwbGxfZGl2X2FoYiB0byBiZSBhaGIgY2xvY2sgc291cmNlLg0KPiA+Pj4gbXBsbC0+bXBs
bF9kaXZfYWhiDQo+ID4+PiAgICAgICAgICAgICAgICAgICAtPiBjbGtfYWhiDQo+ID4+PiBocGxs
LT5ocGxsX2Rpdl9haGINCj4gPj4NCj4gPj4NCj4gPj4gSSBjYW4gYmFyZWx5IHVuZGVyc3RhbmQg
aXQgYW5kIGZyb20gdGhlIHBpZWNlcyBJIGdvdCwgaXQgZG9lcyBub3QNCj4gPj4gZXhwbGFpbiBu
ZWVkIGZvciBBQkkgYnJlYWsuDQo+ID4+DQo+ID4NCj4gPiAjMS4gU0NVMF9DTEtfVUFSVF9ESVYx
MyBpcyByZWR1bmRhbnQsIGl0IGRvZXMgbm90IGltcGFjdCBBQkkgYnJlYWsNCj4gDQo+IFlvdSBk
aWQgbm90IGV4cGxhaW4gaG93IGl0IGRvZXMgbm90IGltcGFjdC4gQ2xvY2sgd2FzIGV4cG9ydGVk
LCB0aGVyZSB3YXMgYQ0KPiB1c2VyIGFuZCBub3cgdGhlcmUgaXMgbm8gY2xvY2suIFVzZXIgc3Rv
cHMgd29ya2luZy4gQUJJIGJyZWFrLg0KPiANCg0KU29ycnksIFNDVTBfQ0xLX1VBUlRfRElWMTMg
d2FzIGRlZmluZWQsIGJ1dCB3YXMgbmV2ZXIgcmVmZXJlbmNlZCBpbiBhbnkgdXBzdHJlYW0gZGV2
aWNlIHRyZWVzLg0KU2luY2UgdGhlcmUgaXMgbm8gaW4tdHJlZSB1c2FnZSBvZiBgU0NVMF9DTEtf
VUFSVF9ESVYxM2AsIGl0cyByZW1vdmFsIGRvZXMgbm90IGNhdXNlIGFuIEFCSSBicmVhay4NCg0K
PiA+ICMyLiBDaGFuZ2UgU09DMF9DTEtfSFBMTF9ESVZfQUhCIHRvIFNPQzBfQ0xLX0FIQk1VWCBP
bGRlcg0KPiBpbXBsZW1lbnQNCj4gPiB3aGVyZSBgbXBsbF9kaXZfYWhiYCBhbmQgYGhwbGxfZGl2
X2FoYmAgd2VyZSAqKmhhcmRjb2RlZCBkaXZpZGVycyoqIGZvcg0KPiBBSEIuDQo+ID4gSW4gKip0
aGUgbmV3IGFwcHJvYWNoICh2OCkqKiwgSSByZWZhY3RvcmVkIHRoZSBjbG9jayB0cmVlIHRvIGNs
b2NrIHRyZWUuDQo+IA0KPiBJIHN0aWxsIGNhbm5vdCBwYXJzZSBzZW50ZW5jZXMgbGlrZSAicmVm
YWN0b3JpbmcgQSB0byBBIi4gSXQncyBtZWFuaW5nbGVzcyB0byBtZS4NCj4gDQo+ID4gSXQgc2hv
dWxkIGJlIEFCSS1zYWZlIGNoYW5nZQ0KPiANCj4gTm8sIHlvdSBkbyBub3QgdW5kZXJzdGFuZCB0
aGUgQUJJLiBZb3UgcmVtb3ZlZCBhIGNsb2NrIElELCB0aGF0J3MgdGhlIEFCSQ0KPiBjaGFuZ2Uu
DQo+IA0KPiBPdGhlcndpc2UgZXhwbGFpbiBob3cgdGhpcyBpcyBub3QgY2hhbmdpbmcgQUJJLg0K
PiANCj4gDQo+ID4NCj4gPiBPciB5b3Ugd2FudCB0byBrZWVwIG9yaWdpbmFsIFNPQzBfQ0xLX0hQ
TExfRElWX0FIQiBkZWZpbmUgYW5kIHRoZW4gYWRkDQo+IFNPQzBfQ0xLX0FIQk1VWC4NCj4gPiBU
byBiZSAxc3QgcGF0Y2gsIHRoZW4gMm4gcGF0Y2ggcmVtb3ZlIHJlZHVuZGFudA0KPiBTT0MwX0NM
S19IUExMX0RJVl9BSEI/DQo+IA0KPiBJZiB5b3UgYnJlYWsgdGhlIEFCSSB5b3UgbmVlZCB0byBj
bGVhcmx5IGV4cGxhaW4gd2h5LiBXZSBoYXZlIGxvbmcNCj4gY29udmVyc2F0aW9ucyBhbmQgeW91
IHN0aWxsIGRpZCBub3Qgc2F5IHdoeS4NCj4gDQpTb3JyeSwgbXkgcG9pbnQgd2lsbCBiZSBmb2xs
b3dpbmcgc3RlcHMgdG8gYXZvaWQgcG90ZW50aWFsIEFCSSBpc3N1ZXMsIA0KSSBjYW4gbW9kaWZ5
IHRoZSBwYXRjaCBzZXJpZXMgYXMgZm9sbG93czoNCjEuICoqUGF0Y2ggMToqKiBBZGQgYFNPQzBf
Q0xLX0FIQk1VWGAgd2l0aG91dCByZW1vdmluZyBgU09DMF9DTEtfSFBMTF9ESVZfQUhCYC4NCjIu
ICoqUGF0Y2ggMjoqKiBGaW5hbGx5IHJlbW92ZSBgU09DMF9DTEtfSFBMTF9ESVZfQUhCYC4NCg0K
TGV0IG1lIGtub3cgaWYgeW91IHByZWZlciB0aGlzIGFwcHJvYWNoLg0KDQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

