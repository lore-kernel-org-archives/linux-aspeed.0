Return-Path: <linux-aspeed+bounces-1422-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E267C61CE8
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 02:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJNdY6gbwz2yMF;
	Fri, 13 Jun 2025 12:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749781777;
	cv=pass; b=gamS8D17GJlV0gqp3s2i15rm97PC5gvS9Ue8VInPOVlqMNlUFf0i0sWGBlv7wQ1Y8kGql8HWsRhnQug4NMNG9s1U5xTcvTa1aXAFM8ZlJEoYvLAPDuQDDXNhkN8L2blVR0dpMQZfvG6pQKB2wg7aQCivCLD+pAqoE2SZyu1Iyt7EWSl1esoKulfQ7EQNRSxfvzgFm3xb5k1Kp3ykoDFucMqCY72yFEX4aQr5UVvLNWn5b4TLn/ZkvqEYHtSwjqdgpFRYGar4v+z5c31HZhLwFNam4EOdIP15iQf0R0pE4UfcAhuurELEVecV6MjN/33kOy1ZbkpM3tPk4N1mleki/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749781777; c=relaxed/relaxed;
	bh=+sAo9cjRdoE4mY0qpNuncqPddOz3li2ySQ1XDAhBHhY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0kyTgHTB4Hve9MUe5U448KOTKb3aLD2LSoGcCRiu/QLcSkbpDuE3qlClQdzhX+oee6J4PcRgSMbCYhOwQ7fHl5kIYW5ZiezjpcjAHqcv23jQRu24x3dhZZbUA8vo2tEeQ/kGy+b5JEbpRlretF4+BeVsndiANwfRAi6iNPklMUbBefJcgOaQMH5DEUUyUraXj+ZUWN+1QdCRlkyxUCN+CzLropX1Dbn0w0kP4+R9jqDtuX5n41axjFCLqjcwoUW8dW26n4yNvpFr+Wik+f96gfAzDIL6rPKsJ3vPEQhcL6g3oYhNZxoA3xtPE5yw5NPiLZhs3qHb8SVd8XUrtbL5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=U8PoaZJS; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=U8PoaZJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJNdY1vLSz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 12:29:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXsxzy3NsCFTRYIjS+HKM51Ly+EZj8bwoqBEyegK8rM5O6aVLfTZ34KJGFNuBKKXynKn7LpmvTMPXc6e3q5+xFL4KRsss6L6hqltIonjB55Byf1Hnp0YD0Clg2Kdhyn52Pn/SVHz5+3NzEGuKyGVrOl9gSWwUACk0ObrEza/ZBrkWmgJnvi1c/G9F/nP2EznJjS4JhmR1dMRLIXBV5a0dXMYU9QUkFv2WN+Fk87cw9ZFjZPv/WGzRH8NYUfP38IH2YfNNB0iDFfoi45dyf7DNfoL3WphMO5ddKivWoHQEuIjX33ZlY/L7JSykkNs1zqe38uRNAWaN3Xqk2p5+iWxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sAo9cjRdoE4mY0qpNuncqPddOz3li2ySQ1XDAhBHhY=;
 b=kBoJVr/NmKW1Dbay31ow28cDToIy8m8MONiVjRAkS90mYc6b4c3ehM3aHtomMG884mgfcVRGbLJSrrLGtte9sj+HWY1zf5kZvP3kv0RfnzASKih0WObyJ4wD9kxeJNPJdwmhwdtfiqeUsrb+3XjPdS7zhpq02mfqVQa8qsk+brZRXfUIwgoaZJCfJy1pRO9t2AVaFnz1wnP3n/liEL08wveO0lxjcG1b1Rn7gDsnnPddkxnuR/CxuHZkYDT23ZyJeTyJ+CUbBOtXDWwFD5njwESgAZVq8/N8vgxLuT6y2hEWlx1cGEShjEaLj5XquGntfTgCNtFUUeo02ntrrF8wCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sAo9cjRdoE4mY0qpNuncqPddOz3li2ySQ1XDAhBHhY=;
 b=U8PoaZJSTB3BYf0Md901XmCQ8h2VbHA183fNGPJFybBo1luiEotpfp5t2BkQlEz90IzD9fz56GUe8K2meb8IUMTcUMnm0cZ9Fi1+2n7IAi1rWDDgJZXvhZN7YfuNi98LZNWDR3riYb209MkGDHL1Ae2NEw7bqnh1lJlEhISS8KkAzDptNnrXw/InesH4GRXeXBHFoKXoVHqg/7jMviqBi/XGVsrZu0b2djbhl6YEQBdJ1KNK3jrXiFNmYUICOMh0kp9yXAvI+0L5jtCFkXMAULniwUxjfYmDG/P4XABqudiv4eKbQ5UUjHZFYcv1akanfX3BYyOuFKIXsj86XFmm5w==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Fri, 13 Jun
 2025 02:29:12 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8813.021; Fri, 13 Jun 2025
 02:29:11 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
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
Subject: RE: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index: AQHb24IeM0HrrMksj0qjPEmThyghWrP/T4SAgAEHZPA=
Date: Fri, 13 Jun 2025 02:29:11 +0000
Message-ID:
 <OS8PR06MB7541A100B918AAA84D1ABDCAF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
In-Reply-To: <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: 03c482cf-432f-4499-3972-08ddaa221532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azR1Q0JXZHZjTEgrVElyYXBnVzJDK3JoYjA4bVVVNE81VUV1SThoZlBrZEVL?=
 =?utf-8?B?RkRZK1h2a0VLSGlhN2tETDlEQXhZMStleUkxUmlOUEhLUXdvcHNDV09pZXJG?=
 =?utf-8?B?THlibnJKSlM3REFlZCtURC9kWGVrdHJySS83ZDdTb2tISmJER2FWU2NXeXlp?=
 =?utf-8?B?YXdjdjNteE1DSDc0cXZJQmYvYmVJWVBIVEZqNFp2akUvYmhwVXd2RDRrRFZU?=
 =?utf-8?B?U1RIQTBPNy80dzVwS0tCcVAyYlFITDlaOFNzcjljSStaSXp6OTREc1hZTTNX?=
 =?utf-8?B?SlJhQlJVVFdCY1N4ZTVKSGcvaWtPbFdFTDJHb09LMDNRMWYxbWVmQlJSc1Q2?=
 =?utf-8?B?eGpGWnZ2OVdMclNneE5NRVJITDg3UDRTQmJaNk9GYUw2OTIvUDBNbHd5RzYz?=
 =?utf-8?B?Y0hFOXJETnVsRHdwMHRvSzN5U0V4WSs5ZmQrTkR0aldJKzJZd3RoR2ZPTVBx?=
 =?utf-8?B?em9YRTBrSVlzRWdKUlA2WVFYS1lybDUwQXpZNDVDdmJIOWg5c0QwK05QdGNY?=
 =?utf-8?B?RXhNK2JnTEpvenptOGd3Ky9ac1prQXpJeXk0RlhJUEpldk9RaWxjMklSVzVW?=
 =?utf-8?B?dldEZ2dNNUl0bUI5NC9tdEh3YUh5bzJBSzYzOER3dzRlSEF5R01wUkhva2VP?=
 =?utf-8?B?aDNqWE1LVnY5OWRPWG5PTG8rU3UzdTVxenZQUzNhNG5TUFlPUE1QL0w2dDNJ?=
 =?utf-8?B?NG1ScTBJTkxGc2xHMmlrMWlONEtTM3dwVmMwb2xUWVNuYndSOUREYlB6ODg3?=
 =?utf-8?B?eFR6SjNTZXkrOFBMS0tKbEJpampSOFY4cEtyQkJEeXk5N0VKU095TWs0aTFP?=
 =?utf-8?B?TU8xUmlwRjJYWGhvNFdHdmpXdE1TNjRvT3ltOHNZMVhWYXdPUUpndVo4UXZk?=
 =?utf-8?B?aGpnTGJRazZ2Q05sajJiOE84ZC95Zkt3R1BOQ0FNaUVCdlNXTkZyNnA5ejdQ?=
 =?utf-8?B?clBhelpRZWRuWlFma0lEOVNKdWgxdmF3TGlYM0czTjZyUG1HL3h3MjJzK1FO?=
 =?utf-8?B?MjVyTS9yeGxmN2U4dnMvUUprUGE0SGVva3JENkYwazBOTE00QVBIQzhDY3FR?=
 =?utf-8?B?cDg1bXhNaXpjUjQ0dUd0bzNvL1BoOTR2dGVWeWhOZnJqMytCa2VpaFNPc3ZM?=
 =?utf-8?B?MFZ2V3IrMmYyTEIrNlJmZmkyc1h3YTV4S2t5M0NBb1gwWjBuZzU4ZU8vMlNK?=
 =?utf-8?B?VFIvVVJBaXpteU8vMUVBMXdTRHQvK0QrbmlhWE1nSytoZ2NQWDBPRnJvZnhi?=
 =?utf-8?B?dUFPdGtRYlp3RW81Mno0ZGVnSEQ2YnpBallzTUdveVZJV3dtbUx5b2JBdHJs?=
 =?utf-8?B?b09aRE1mZm45emFpaWJ1U25CTEUyTE9lUlEwa2pNVG5OcWh5Ni8xdG1zSjVR?=
 =?utf-8?B?cWgrVmZWeUkwUkNYOUpvcXVhaEtjSkhVVlhYdVdvbTZzdE1qMzAxVVdYZmJl?=
 =?utf-8?B?N0VTRG1NSG5oMVhjZjZxQXFUWkloVEhCSWo4azVmTEdDc0p3Q011Q3V5Q1pz?=
 =?utf-8?B?d0RwUk84RHF0NG1KSno5c0xPYlVhTExwLytqNlVVSklPQk1YK1ZNdm5uZlJ6?=
 =?utf-8?B?OTg1V1N6dEpkNjFvMnNIRm9rZFk2YURpNFI1QWhtZ2VUWkRZRmFIRXRwYjBq?=
 =?utf-8?B?eEVTbnhkR2lzcDZRNisyK05aRWlwd0NQWG5qd3o0eC95cnloM1d5UVZBWFZ0?=
 =?utf-8?B?cWIwcWZxMXZUT1RnR3FUd0NEbnhidmFyQkxWZGJ0SFdNRjlnRnpUanVBVFdr?=
 =?utf-8?B?K01sVWJzTHhXNFh1aEt5ZmNFMEp5Zm9PcUltVlpXc1B2UDdSZzNIbVRHcG1a?=
 =?utf-8?B?SlVoNHdWUkdQaStQcWVIYWY4cFdkZEZtNVcwWVRJS0xYUTFLNWtQWHdJd1NF?=
 =?utf-8?B?YWRkRkRuY1pNcExUVXQzSHBJUGlsQVFHUEprUkVlM0JNcWhPYWREVU94Vmhw?=
 =?utf-8?B?VUNpa0t4Wmo1QmVJNGlWYUFqUjdrMFFxWVVFNHM3QytKN0pOa3hkMTJkMXhy?=
 =?utf-8?Q?nsmTrFFyt5CLGZH3B76PlUoJ7jW1No=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFFqNGpQTjdqQXYxWUFDZWdScE9mNFdlZjVsbys3Q2RYcDU5SktGVEk0ZmRv?=
 =?utf-8?B?MS9XZmRMNjdFRXRheWVHa2Y3Q2NObkNyejRhbzNwdDhuOHNHeXhwWWlENXBS?=
 =?utf-8?B?Nmlvc0RJYzU3S3lVZ2J2bXF0MzV3YmRhQWV4UDJJQUkwQldURVdkbDBISXI3?=
 =?utf-8?B?SkppcXFyZ3RjWEQvUWNtK01mc2xQMWExN1g2V05iZExRVy9lcyt6dG9TSjhj?=
 =?utf-8?B?bzlibk1FNkprTmY5U1dpS0Rwa2dWRkM4c3c3VzJCd0lNMkYvSFZiUzkzMXV6?=
 =?utf-8?B?V2NqREpIK0VheWJCaEZnR0NWL1RkK2JZVmJUTE1xaDMwRmlxWWJTb0lDdFFt?=
 =?utf-8?B?ZUgxeDZ5M1RYU3Z3ZXVHUkZrMkFGSDVxdFhRS3B1ZDRoTTZaYlZSMTdvM3I1?=
 =?utf-8?B?OURrcjJROHJPcThQTUxoNUZaZWVXUnhJV2Q4bXR1djg3R1U4RW5VOWwyTkYy?=
 =?utf-8?B?VmFBeFNodVVjYXcvNm5sQXJUYnowU011MWNYSnhzbk9VS3k5c3FueFdsUWh4?=
 =?utf-8?B?NUxTYkNrdU1oMXBNRHNXZHZwVkN5U3pOOWw0cW5CcUxTZmNSZUJsUmwwTmY0?=
 =?utf-8?B?eEF4Y2V1cUJWcS92b0pFRWpWZ3EyMDhaVlpRMERuTko1MllITk5meVBMdkxS?=
 =?utf-8?B?bE1DbkNWV3loVEFuWVk4OEtyd09yZVZXR2t4L3pyVmpuTVpSMERDUndDb0to?=
 =?utf-8?B?K202WE5XRzh4UGt6TTF2Zy96eEZGS1JLYXFjS01GY2Y3RHdMaHJ1dWtDTmtY?=
 =?utf-8?B?Tk1SaHVraTFGMWRXUzFoWTVSQlZrd2FiZ3dkNEY2OGpFQ091aG1CV0lpdHhX?=
 =?utf-8?B?TXp1bFhNeGZEM2hnZE9vL09Gcyt0eWhhMVd2N3hPd29xbFJPMGF0Zzh6THhi?=
 =?utf-8?B?cjAvcE1YQnZpdUFBOTZ0NE5JSzYrb1NhaDVuS0M5TmZNamw4YVFmWXdIakg4?=
 =?utf-8?B?UnBGZjg3VkcxeENSNVovaFU0aHdKeHZQTGJacjNMZzRHS0xpZlUyOEhZWStn?=
 =?utf-8?B?ejJOMVJyalM3UnFuMzBOTElvZWtiUG5VS0NxUUgzL1dBRGovTnpoTExML1RY?=
 =?utf-8?B?bklCOVlQd2lzYlhCRWU0Z1BVTCsvZ0NVQnZlcWtBYVcxYmtuZmRTSkNsQjVE?=
 =?utf-8?B?eFRDVzJyV3htNkVVY1hWZzIweWROTittR0hHZFhBM1pTbkRyS2RIWi8yN3NP?=
 =?utf-8?B?VzVmU3R5eHVudDhZMzR1NVhTamZJWUZ5VmEzclpmc3JQNWFsL2hqTnM0RXJX?=
 =?utf-8?B?K1gyT3h0eFF6eUI4N0NKMFJ5eUo3dldDZzl1ZWZ3SlFwRjQ4bFg3bURYRlkw?=
 =?utf-8?B?Y2l2bXhrTFM2NG80allTR2JyQWtJaEk3RGNMbTM5THNIcjF0d2NjYXBHeG9R?=
 =?utf-8?B?UXVtNUJqeXJjWXdoQi9NZTZnZGllZ2lRK0pTYVhJbUZ4RW1pdW5OZkZJSE4x?=
 =?utf-8?B?MlhwOEcxdDFNWjBqUmdFbTlFWFNudVcvYTIvT1REZlE3TGR0cHZxekxxR1Z5?=
 =?utf-8?B?cTZ5SDYyRVF6enEyY2NCbHRoV1ZHd2JjbG1oQ2xYbUFUT2ZYSDBQQ3FXQVlS?=
 =?utf-8?B?L1FBUm92UW9yRHdVaFR2S1ltMXJaNEJkbUEzR0dlMEFFM3B5Ly9HWkUrWmNt?=
 =?utf-8?B?MzZaQ1ZsRGpISGFhQUpGaGU4aGIvaFAyWC9zZDRiclJ1QVVBUmc3U2FEK3RW?=
 =?utf-8?B?cHVNbWVKbExFaGxVcHprUStsUm85U2dxRWtmemdvOGRWR2JaNnJ1ZzRmS3RD?=
 =?utf-8?B?OFFIVkIwRVZHNU1BUjlCRnhKUkxRWXl1bXFZcXhydWxIeXlwTk5LVW5ZeXJ1?=
 =?utf-8?B?S0lucHFVamVmNDBBS1hndVc3VXkxNUF1Mm82UTVMRVdZQUtxL2drYTk1Z0x0?=
 =?utf-8?B?THAvaGVibjBpVXJKZFVNS1ZYeTd0SzBTaXl0MmUwb1oyVHdtNGNhV3RQKzBT?=
 =?utf-8?B?cGxlcFBsQk45MllEaU52SnlMdWVQaWdDdTJuak1BYlNRYkFLSmdBMVZnS01s?=
 =?utf-8?B?akRGM2RwVXNzZVBsa2xGSU1uL1ptcUxuQlRWcG83VXhFakoxUlpnSFpNV2RK?=
 =?utf-8?B?QS9vYjkrM0UxNkQycVV4Q2ZpeTdTYTcxUTYycGU1ZWJoNlgrYzNrQkRWaDNh?=
 =?utf-8?Q?00pV6LukR60s1T6WCDpu1yYhW?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c482cf-432f-4499-3972-08ddaa221532
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:29:11.7174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KphTQj/6K5nt2QLiNZr2OcTRYnY7/prGLBYZ3s6fhCeWdXO/sm7K/mH6+qJLFVqE/6A5kuuL/dpX9zmk7bfErwhkBim4cLvcH0v2izOWKfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gMTIvMDYvMjAyNSAxMjow
OSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IFRoaXMgYWRkIHRoZSBpbml0aWFsIGRldmljZSB0cmVl
IHN1cHBvcnQgZm9yIHRoZSBBU1BFRUQgQVNUMjcwMCBTb0MuDQo+ID4NCj4gPiAtIEFkZCB0b3At
bGV2ZWwgY29tcGF0aWJsZSBzdHJpbmcgImFzcGVlZCxhc3QyNzAwIiBhbmQgc2V0IHVwDQo+ID4g
YWRkcmVzcy1jZWxscy9zaXplLWNlbGxzIGZvciA2NC1iaXQgYWRkcmVzcyBzcGFjZS4NCj4gPiAt
IERlc2NyaWJlIGEgcXVhZC1jb3JlIEFSTSBDb3J0ZXgtQTM1IENQVSBjbHVzdGVyIHdpdGggTDIg
Y2FjaGUsDQo+ID4gaW5jbHVkaW5nIGNhY2hlIHByb3BlcnRpZXMgYW5kIFBTQ0kgZW5hYmxlLW1l
dGhvZC4NCj4gPiAtIEFkZCBQTVUgYW5kIEFSTXY4IHRpbWVyIG5vZGVzIHdpdGggY29ycmVjdCBQ
UEkgaW50ZXJydXB0IHdpcmluZy4NCj4gPiAtIE1vZGVsIHRoZSBkdWFsLVNvQyBhcmNoaXRlY3R1
cmUgd2l0aCB0d28gc2ltcGxlLWJ1cyBub2RlczoNCj4gPiBzb2MwIChAMHgxMDAwMDAwMCkgYW5k
IHNvYzEgKEAweDE0MDAwMDAwKS4NCj4gPiAtIEFkZCBzeXNjb24gbm9kZXMgZm9yIGJvdGggU29D
cyAoc3lzY29uMCwgc3lzY29uMSkgd2l0aCBjbG9jay9yZXNldA0KPiA+IGNlbGwgZGVmaW5pdGlv
bnMgYW5kIGFkZHJlc3MgbWFwcGluZy4NCj4gPiAtIEFkZCBHSUN2MyBpbnRlcnJ1cHQgY29udHJv
bGxlciBub2RlIHVuZGVyIHNvYzAsIHdpdGggZnVsbCByZWdpc3Rlcg0KPiA+IG1hcHBpbmcgYW5k
IGludGVycnVwdCBwcm9wZXJ0aWVzLg0KPiA+IC0gSGllcmFyY2hpY2FsIGludGVycnVwdCBjb250
cm9sbGVyIHN0cnVjdHVyZToNCj4gPiAgIC0gaW50YzAgdW5kZXIgc29jMCwgd2l0aCBjaGlsZCBp
bnRjMF8xMSBub2RlLg0KPiA+ICAgLSBpbnRjMSB1bmRlciBzb2MxLCB3aXRoIGNoaWxkIGludGMx
XzB+aW50YzFfNSBub2Rlcy4NCj4gPiAtIEFkZCBzZXJpYWw0IG5vZGUgdW5kZXIgc29jMCwgb3Ro
ZXJzIHNlcmlhbCBub2RlIHVuZGVyIHNvYzEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFu
IENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0c2kgfCAzODANCj4gPiArKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzODAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0
c2kNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3Bl
ZWQtZzcuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0
c2kNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDE5
NzE4N2JjZjlmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvYXNwZWVkL2FzcGVlZC1nNy5kdHNpDQo+ID4gQEAgLTAsMCArMSwzODAgQEANCj4gPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgI2luY2x1ZGUNCj4gPiAr
PGR0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLXNjdS5oPg0KPiA+ICsjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvcmVzZXQvYXNwZWVkLGFzdDI3MDAtc2N1Lmg+DQo+ID4gKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKw0KPiA+ICsv
IHsNCj4gPiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsJI3NpemUtY2VsbHMgPSA8MT47
DQo+ID4gKwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiA+ICsNCj4gPiArCWNwdXMgew0K
PiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0K
PiA+ICsNCj4gPiArCQljcHUwOiBjcHVAMCB7DQo+ID4gKwkJCWRldmljZV90eXBlID0gImNwdSI7
DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hMzUiOw0KPiA+ICsJCQlyZWcgPSA8
MHgwIDB4MD47DQo+ID4gKwkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gKwkJCWktY2Fj
aGUtc2l6ZSA9IDwweDgwMDA+Ow0KPiA+ICsJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+
ID4gKwkJCWktY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPiA+ICsJCQlkLWNhY2hlLXNpemUgPSA8MHg4
MDAwPjsNCj4gPiArCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KPiA+ICsJCQlkLWNhY2hl
LXNldHMgPSA8MTI4PjsNCj4gPiArCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmbDI+Ow0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICsJCWNwdTE6IGNwdUAxIHsNCj4gPiArCQkJZGV2aWNlX3R5cGUgPSAi
Y3B1IjsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWEzNSI7DQo+ID4gKwkJCWVu
YWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gKwkJCXJlZyA9IDwweDAgMHgxPjsNCj4gPiArCQkJ
aS1jYWNoZS1zaXplID0gPDB4ODAwMD47DQo+ID4gKwkJCWktY2FjaGUtbGluZS1zaXplID0gPDY0
PjsNCj4gPiArCQkJaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+ID4gKwkJCWQtY2FjaGUtc2l6ZSA9
IDwweDgwMDA+Ow0KPiA+ICsJCQlkLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4gKwkJCWQt
Y2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+ICsJCQluZXh0LWxldmVsLWNhY2hlID0gPCZsMj47DQo+
ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJY3B1MjogY3B1QDIgew0KPiA+ICsJCQlkZXZpY2VfdHlw
ZSA9ICJjcHUiOw0KPiA+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1IjsNCj4gPiAr
CQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiArCQkJcmVnID0gPDB4MCAweDI+Ow0KPiA+
ICsJCQlpLWNhY2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPiArCQkJaS1jYWNoZS1saW5lLXNpemUg
PSA8NjQ+Ow0KPiA+ICsJCQlpLWNhY2hlLXNldHMgPSA8MjU2PjsNCj4gPiArCQkJZC1jYWNoZS1z
aXplID0gPDB4ODAwMD47DQo+ID4gKwkJCWQtY2FjaGUtbGluZS1zaXplID0gPDY0PjsNCj4gPiAr
CQkJZC1jYWNoZS1zZXRzID0gPDEyOD47DQo+ID4gKwkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8Jmwy
PjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQljcHUzOiBjcHVAMyB7DQo+ID4gKwkJCWRldmlj
ZV90eXBlID0gImNwdSI7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hMzUiOw0K
PiA+ICsJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+ICsJCQlyZWcgPSA8MHgwIDB4Mz47
DQo+ID4gKwkJCWktY2FjaGUtc2l6ZSA9IDwweDgwMDA+Ow0KPiA+ICsJCQlpLWNhY2hlLWxpbmUt
c2l6ZSA9IDw2ND47DQo+ID4gKwkJCWktY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPiA+ICsJCQlkLWNh
Y2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPiArCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0K
PiA+ICsJCQlkLWNhY2hlLXNldHMgPSA8MTI4PjsNCj4gPiArCQkJbmV4dC1sZXZlbC1jYWNoZSA9
IDwmbDI+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCWwyOiBsMi1jYWNoZTAgew0KPiA+ICsJ
CQljb21wYXRpYmxlID0gImNhY2hlIjsNCj4gPiArCQkJY2FjaGUtbGV2ZWwgPSA8Mj47DQo+ID4g
KwkJCWNhY2hlLXVuaWZpZWQ7DQo+ID4gKwkJCWNhY2hlLXNpemUgPSA8MHg4MDAwMD47DQo+ID4g
KwkJCWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4gKwkJCWNhY2hlLXNldHMgPSA8MTAyND47
DQo+ID4gKwkJfTsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJYXJtLXBtdSB7DQo+ID4gKwkJY29t
cGF0aWJsZSA9ICJhcm0sY29ydGV4LWEzNS1wbXUiOw0KPiA+ICsJCWludGVycnVwdHMgPSA8R0lD
X1BQSSA3IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gSVJRX1RZUEVfTEVWRUxfSElHSCk+
Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlwc2NpIHsNCj4gPiArCQljb21wYXRpYmxlID0gImFy
bSxwc2NpLTEuMCI7DQo+ID4gKwkJbWV0aG9kID0gInNtYyI7DQo+ID4gKwl9Ow0KPiA+ICsNCj4g
PiArCXRpbWVyIHsNCj4gPiArCQljb21wYXRpYmxlID0gImFybSxhcm12OC10aW1lciI7DQo+ID4g
KwkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDEzIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4g
SVJRX1RZUEVfTEVWRUxfTE9XKT4sDQo+ID4gKwkJCSAgICAgPEdJQ19QUEkgMTQgKEdJQ19DUFVf
TUFTS19TSU1QTEUoNCkgfA0KPiBJUlFfVFlQRV9MRVZFTF9MT1cpPiwNCj4gPiArCQkJICAgICA8
R0lDX1BQSSAxMSAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0xP
Vyk+LA0KPiA+ICsJCQkgICAgIDxHSUNfUFBJIDEwIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwN
Cj4gSVJRX1RZUEVfTEVWRUxfTE9XKT47DQo+ID4gKwkJYXJtLGNwdS1yZWdpc3RlcnMtbm90LWZ3
LWNvbmZpZ3VyZWQ7DQo+ID4gKwkJYWx3YXlzLW9uOw0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlz
b2MwOiBzb2NAMTAwMDAwMDAgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+
ID4gKwkJcmVnID0gPDB4MCAweDEwMDAwMDAwIDB4MTAwMDAwMDA+Ow0KPiA+ICsJCSNhZGRyZXNz
LWNlbGxzID0gPDI+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCXJhbmdlczsN
Cj4gPiArDQo+ID4gKwkJc3lzY29uMDogc3lzY29uQDEyYzAyMDAwIHsNCj4gPiArCQkJY29tcGF0
aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1zY3UwIiwgInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4g
PiArCQkJcmVnID0gPDB4MCAweDEyYzAyMDAwIDB4MTAwMD47DQo+ID4gKwkJCXJhbmdlcyA9IDww
eDAgMHgwIDAgMHgxMmMwMjAwMCAweDEwMDA+Ow0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwy
PjsNCj4gPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCSNjbG9jay1jZWxscyA9IDwx
PjsNCj4gPiArCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJ
CWdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIyMDAwMDAgew0KPiA+ICsJCQljb21wYXRpYmxl
ID0gImFybSxnaWMtdjMiOw0KPiA+ICsJCQlyZWcgPSA8MCAweDEyMjAwMDAwIDB4MTAwMDA+LCAv
KiBHSUNEICovDQo+ID4gKwkJCSAgICAgIDwwIDB4MTIyODAwMDAgMHg4MDAwMD4sIC8qIEdJQ1Ig
Ki8NCj4gPiArCQkJICAgICAgPDAgMHg0MDQ0MDAwMCAweDEwMDA+OyAgLyogR0lDQyAqLw0KPiA+
ICsJCQkjaW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KPiA+ICsJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDkgKEdJQ19DUFVfTUFTS19TSU1QTEUo
NCkgfA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIKT47DQo+ID4gKwkJCWludGVycnVwdC1wYXJlbnQg
PSA8JmdpYz47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJc2VyaWFsNDogc2VyaWFsQDEyYzFh
MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJuczE2NTUwYSI7DQo+ID4gKwkJCXJlZyA9IDww
eDAgMHgxMmMxYTAwMCAweDEwMDA+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnN5c2NvbjAgU0NVMF9D
TEtfR0FURV9VQVJUNENMSz47DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4IElSUV9U
WVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCQlyZWctc2hpZnQgPSA8Mj47DQo+ID4gKwkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJc29jMTog
c29jQDE0MDAwMDAwIHsNCj4gPiArCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICsJ
CXJlZyA9IDwweDAgMHgxNDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gPiArCQkjYWRkcmVzcy1jZWxs
cyA9IDwyPjsNCj4gPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArCQlyYW5nZXM7DQo+ID4g
Kw0KPiA+ICsJCXN5c2NvbjE6IHN5c2NvbkAxNGMwMjAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI3MDAtc2N1MSIsICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ID4gKwkJ
CXJlZyA9IDwweDAgMHgxNGMwMjAwMCAweDEwMDA+Ow0KPiA+ICsJCQlyYW5nZXMgPSA8MHgwIDB4
MCAweDAgMHgxNGMwMjAwMCAweDEwMDA+Ow0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsN
Cj4gPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCSNjbG9jay1jZWxscyA9IDwxPjsN
Cj4gPiArCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXNl
cmlhbDEyOiBzZXJpYWxAMTRjMzNiMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gIm5zMTY1NTBh
IjsNCj4gPiArCQkJcmVnID0gPDB4MCAweDE0YzMzYjAwIDB4MTAwPjsNCj4gPiArCQkJY2xvY2tz
ID0gPCZzeXNjb24xIFNDVTFfQ0xLX0dBVEVfVUFSVDEyQ0xLPjsNCj4gPiArCQkJaW50ZXJydXB0
cy1leHRlbmRlZCA9DQo+ID4gKwkJCQk8JmludGMxXzQgMTggKEdJQ19DUFVfTUFTS19TSU1QTEUo
NCkgfA0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIKT47DQo+ID4gKwkJCXJlZy1zaGlmdCA9IDwyPjsN
Cj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4gPiAr
fTsNCj4gPiArDQo+ID4gKyZzb2MwIHsNCj4gDQo+IFRoaXMgaXMgdGhlIGJhc2UgRFRTSSwgdGhl
cmUgaXMgbm8gZXhpc3Rpbmcgbm9kZSB0byBvdmVycmlkZS4gSnVzdCBkZWZpbmUNCj4gY29tcGxl
dGUgU29DIG5vZGUgaW4gb25lIHBsYWNlIGxpa2UgZXZlcnkgb3RoZXIgdmVuZG9yLg0KDQpNeSBv
cmlnaW5hbCBpcyB1c2UgdGhpcyB3YXksIGJ1dCB3aGVuIEkgZG8gY2hlY2twYXRjaCwgZ2V0DQpD
SEVDSzogbGluZSBsZW5ndGggb2YgMTA2IGV4Y2VlZHMgMTAwIGNvbHVtbnMuDQppbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMTkyIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwgSVJRX1RZUEVfTEVWRUxf
SElHSCk+LA0KVGhhdCB0aGUgcmVhc29uIG1vZGlmeSBieSB0aGlzIHdheS4NCg0KPiANCj4gDQo+
ID4gKwlpbnRjMDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIxMDAwMDAgew0KPiA+ICsJCWNvbXBh
dGlibGUgPSAic2ltcGxlLW1mZCI7DQo+IA0KPiBOQUssIG5ldmVyIHRlc3RlZC4NCj4gDQo+IE5v
dCBhbGxvd2VkLCBzZWUgYmluZGluZ3MuIEFuZCB0ZXN0IGl0IG5leHQgdGltZS4NCg0KR290IGl0
LCB3aWxsIHVwZGF0ZSBieSBmb2xsb3dpbmcuIA0KSW50YzA6IGJ1c0AxMjEwMDAwMCB7DQogICAg
ICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQogICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCiAgICAgICAgcmVnID0gPDAgMHgxMjEw
MDAwMCAweDQwMDA+Ow0KCQlyYW5nZXMgPSA8MHgwIDB4MCAweDAgMHgxMjEwMDAwMCAweDQwMDA+
Ow0KCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQoN
CiAgICAgICAgaW50YzBfMTE6IGludGVycnVwdC1jb250cm9sbGVyQDFiMDAgew0KICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1pbnRjLWljIjsNCiAgICAgICAgICAg
ICAgIHJlZyA9IDwweDAgMHgxYjAwIDB4MTA+Ow0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQo=

