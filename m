Return-Path: <linux-aspeed+bounces-1423-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1055BC61CE8
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 02:54:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJPBR4v6Fz2yMF;
	Fri, 13 Jun 2025 12:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749783279;
	cv=pass; b=WHxp6WuKBHkAIIvCCp4gztD0nTHro2VwHhUBVNcEA3ql6/C2XDRSckI3oJBfSucdYbQ6yJXo8WPswKSCT0GAm8QMvQE6VGFC8NU7kXi9jX9msfCWgXLkauqmxlex7cw144Y8cp+Ni4gPLK/kpYfLD2LTIjvfsTvOrmVls9iawX/LBg2rpgujUqdnCIzVdqHkmbd9zw+Bxm29eHAPSQ7ksgKoA7Py+IqegrXgeAjzTIJ5qE2uFMfe6J/3uInFwB9hBg5PAC5zIVj9GEGnvwVcD2vl22BsStqnB+8h7uPC97V9VNfHYVdjPQQ9VCsP5KUSfCF7Q9tROa4GdoTtZq9jWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749783279; c=relaxed/relaxed;
	bh=lIHTlTSpqv+MfVUz+bgyNh4ZpGqJsqQN1NRBxMV5IjQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhleOAbwBkNi138urNf5yv6+AiEGprd8m5mXakdDFKyMgqrVOC8TWoFvaXkG9JJMlG0Fwp8OG55A1Kthcpn2uncwZdDKsp4ZiiBz+oa7JGNTT9tw4v7NyD+i+ec9n5UepfPLhSZPOXPc3538eClcAcmnWQYMSAaphhJeEOlpRAmCpE9AwR82yUCVQGG8tuQ7GpIpgqlTG8wubY+P6gBEEaHICXIeMY0Q2ePPqi2XXt2RiI3414qmKAb1Zp5ze+9yIKYOnR68j4p/kRoT0ox6dmLSiZIH9bwFXu6DuT0mD2Cvcn8yUcvXl3f2F78e0n4FxsAnWBZ+KXDnGZK4kY6zYQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=BsOTSe0F; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=BsOTSe0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJPBQ73swz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 12:54:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMY7n4lYC80ZXfFccMRyYJcVs1fGQ66vwMR3i13b7fyovh7l1tMU/UjcRKNMl1W+zyrkCA8FlcJHHuAjv7Kz9Q5ZSPfA10EP0J98u5G7ORhm5AwsVdwGnzxGDXdoVgy+3ZyAKnF6G3ywdHvQatdzcm5+EzZCp7XS5KL8efPHjtV+xwXqj9rRkcDmLtO1VZAJTIenGqzivz/rT2IjeAPVVr528dQobRssRubuTkH5e2ExDvSTd04L6aM9WU+IK/JN4LKFZVkA0ljXGFIoVO6UN/H1QvWllhydhXDkly+/3REV8YrkHlj+TMt4rmeCUA/3M20e9BhVk5hHGpx2PNo9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIHTlTSpqv+MfVUz+bgyNh4ZpGqJsqQN1NRBxMV5IjQ=;
 b=nfBBfmxcyHHWp7TYW5N0/EU9OMhAuGBgVNRNnO2BKBCa+oSJf9YHAeCJD1Hp9EuiDv328cB7K2UaFIfS2B2jyWPxIEuFPcyPDDKukcwb6amWSPmoKtWWON27P4XoKnCj0QcnjQpj/5edzJnbGxgPUVhOwtywisQOhKJjVjM/5P6uR4c9mh5+gnMjopVkGNYLIMecx1AZiWAHnyqqhz5nYdl7Ec9rfHXm6nEdG0L3zeKjFqhgv1gxzdGRHO6L/T8qSaqi2CVab4hivBvnjBt1DwwcWzIxTxezscZbFydbSK01VTMHv7ZK4dLlzP3RyG2Q/pivJiwdXcNqn3jVMaQtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIHTlTSpqv+MfVUz+bgyNh4ZpGqJsqQN1NRBxMV5IjQ=;
 b=BsOTSe0FV2hgEVEMatIj5m4Omu7ygKV02UYN0kHFWQ2jz/L6koSo9T88Av/iC0ZeCRoqGWxCsfmJs4Xrc35jkh9WTE3ALrVOtL9GHmixZrWYzNOPjr7zN0KP/vlMQ3fCa1iuedkkDX7x60vDfHPAC6IixAHVB0TH3pO7szi0v+ICTqV6wklvs2vGibTLl0Fw6iCeetJxYH394OaeoAMpxvCrwpyY7ETjxA1i4FkTAS0S6n4zN+iU1cGDVWjxY8OzQAlzE/05nMr23u4iqb/LiWBV78oRxZjl+pXOes4nZiwsEjOI7avatZ0Cto0c5NwFBReyZhr7cy+KeO0jftSL5Q==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SE1PPFF9F12DF7E.apcprd06.prod.outlook.com (2603:1096:108:1::432) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Fri, 13 Jun
 2025 02:54:14 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8813.021; Fri, 13 Jun 2025
 02:54:14 +0000
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
Thread-Index: AQHb24IeM0HrrMksj0qjPEmThyghWrP/UB+AgAEUAQA=
Date: Fri, 13 Jun 2025 02:54:14 +0000
Message-ID:
 <OS8PR06MB754143A2AC8D351D8E715685F277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <f635caf3-a93f-4a31-9957-4f455f4eafc9@kernel.org>
In-Reply-To: <f635caf3-a93f-4a31-9957-4f455f4eafc9@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SE1PPFF9F12DF7E:EE_
x-ms-office365-filtering-correlation-id: a45f1658-2bb9-42d6-93a4-08ddaa2594d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?emE3YnVNQXBMTm9lN2xzOElvZE5xTWxHczJJRWIzM3dNZnVHS1kyZE91RXVZ?=
 =?utf-8?B?alVHVjV5SjFmd1hHL1l3LzhCQlphR21nRCtCblpXd3FqbTlqSDlnR25HdUlL?=
 =?utf-8?B?NTkwYitleDUvUU5lNm9uRDVBN1ZkNDUvNlgrcktOSk43cmZjZ2ttMDQ1RUNG?=
 =?utf-8?B?T3B3KytyRVhJVjdkdThpbno4Q3hTWmJzVTRwY1g1eEVmZ2RLblNFZ2hWSHR2?=
 =?utf-8?B?NkNTM1NHZTFoaUx6NGpkOUd0aFcwQW1jZlZidENwTXVKSWo3UmNXcHU5UzBm?=
 =?utf-8?B?MVVGRUhrc3VSMHBOZGdvTW03RUJpMjJFN1oyVGNPT2Urd0hMaTJ6QVM4NGdO?=
 =?utf-8?B?b1hiUDJQUGhOSXo5VzhvM1NZWkQvNXF5U3hzT1lXTzNlL2FPcUlmWDBpKzEz?=
 =?utf-8?B?elNmam1sMWNaYjdzTit1Uk1XWll4RGtmdGJtaGdKcXh0aHRZYlNKM1diNmxq?=
 =?utf-8?B?bE9ud1RPR0pFK1ZGbjZRVjVUMjRJWks3bGFBdmI3SGhmVXNlWVRzMkpVbFpN?=
 =?utf-8?B?NUI0UnU2bDd5Qm9zakNTK003WXQyeWhmdUxQT1FYVFBpOXcxZ25obkFSWEhr?=
 =?utf-8?B?cVVjQlg4OUZucStRRVlVM2FpaHRqYTE3NG1yWFlFcGxWMTdLOTlvd3V6czJa?=
 =?utf-8?B?bW51RG9CMHZQaGVHOFNiZS90UmVPM0lEYUVFS2dXQnJCNDNPWFNsQXM5MDlN?=
 =?utf-8?B?Sno1SXlkKzgyeHQxS09XYWZMcnZORGduWkhSWlNSVWVMcUNaM1JDcFNJclRJ?=
 =?utf-8?B?aitzOEZFdEJpVUszRkpMcGJYUHN0b3pyTThIZUNrZWJ4OG5pZUtBZkk4NGh3?=
 =?utf-8?B?MEh0YWk1cWRnKzY2RWhZUFFtamhQUWxWRjBPdENiZ2dhYUE4bUhId2lQcnZE?=
 =?utf-8?B?ejJMS1hLakR2VUFROU1kNTh5Ky9WWnBjSFdnd2NIRVd3cGRmVnJWSURobS96?=
 =?utf-8?B?anJJQ1dkSWIvOUNCZFJnV1c5YjdoZmJHZTk2TE9iamhnV0k4Yi9ibHZxUmtI?=
 =?utf-8?B?U3YyUnA1bjROempwK1BUYjNhU3ZYM2g5OVZ1c1RYSktNQ3RKT2t0NlRZd3V3?=
 =?utf-8?B?eVk5djNuYXZUdGc2SHB5Q3MxWTFiWnFZeUIzdEM4Z0YwZnFmaGl6Z05Obm4y?=
 =?utf-8?B?a1VEUmovMGt2RmpXWENabFRUQjBKT3RYT3liMjVBdW9oM2Q3emx1cUdqT1Fz?=
 =?utf-8?B?bUR5amJuTnlNTU5KWWM2ZGgxaUltbmRBL2VEVEFZNmZ4SGFiQzhRN0lvcUt5?=
 =?utf-8?B?QVp4eWt6MGp4MHdHUWJUTWNnWU1idENCV0NucEFsL2U4bjBrYUp0SDhWVFFp?=
 =?utf-8?B?bmQ1ai9WemNKM2Iva1hkVnZWNmhBeFFMUVFybW5kaTBjZ1FsMWNTM0FMaEJM?=
 =?utf-8?B?L3FmRVAzODRLWHVUcmNmT2JDam9SRnhaUWJvdVJWYThRTm9BZEtnY3BmSjdq?=
 =?utf-8?B?WXdvTkZXWTBJMnV5MjNENjRIeC9MVUgzY0hzVzVEbjh0OUNVMFBVSXZ3MHJR?=
 =?utf-8?B?S3dqd2h2V1FRckV0cW9BWTI0V3ZFeGpsRmR1K0RtcVRHZVJIYXV3V1lOUTZF?=
 =?utf-8?B?NmgzT1E5U0tnQ0tKMnJaMEs2RzBmYkRZSjdNbTlEMmNhbktqQjNRL3R4K0NP?=
 =?utf-8?B?VHREMEpWTExCRVJkOHMwN0lVSERGaHptNW1oY0NKZSt6eGhxZEs3TWxIZzJT?=
 =?utf-8?B?N1diWnpvOElzdk1zTVRYelNXczdFZ3pmTGpVcnpPdUVXS2FGcFdPU3NzcFVp?=
 =?utf-8?B?QXNzUVl6K0ZnZ1lkY1hLeHR1ZWFwc0RybmtBeEFmbys2czZHanorQ3RCUHg1?=
 =?utf-8?B?UmRMOFV6VTZna2tTaElCbTZDakRNWmJoOWROV2dkUCt6VllpY3FJUmlRd3c2?=
 =?utf-8?B?OTdET0N4T3BNaDY0UTMvV0treHYvV2gvTHZwZFlBb1poUWZVK1F1Z2tCUnZk?=
 =?utf-8?B?OEgvcE9hcFdUdHBEck9nNFpoekp0UG9pMTFIbEtDYmRESlhjQm9rTXlzQmp3?=
 =?utf-8?Q?CtKwTlWoOAM6HNs4d3WEzQqt2pRUAk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZXb3dPQWVid2tnc1RDT1VnbVR4emRWSndaWEIzSlpzVFNFU1c1N2lEUDFz?=
 =?utf-8?B?UnNjcm1GNHZ0eXJwRlYyNWJOSFBNazdJdDVaMDlaaEovNlZkc2kvQ3RVQW5s?=
 =?utf-8?B?ZXBublBsRVViWXRJVFZSVU5BbkZnRmVweC9iMU9vcmUxNUh5QkFPYkdCL3hU?=
 =?utf-8?B?eFI4b0tNUGtJbCtVblNzaG5wZXo3L2N4TmwwdUZpTkpLdFE3MWtyU2RFMW1n?=
 =?utf-8?B?RUtFTzVqZHpqZGZiSHZBVklIWWNCMENLZmpCeEtVZ25zekt6elQ3c1FYZ3Iz?=
 =?utf-8?B?cmxIby9CVmZzalVTc29QYmpLMVR6eTJ5QWRVMWZIaWFtcVZwNGFoN3o3djlR?=
 =?utf-8?B?SXFUdm81cTR4RU1sQWhRMFBRYUhMWUhOK0h2TGlnamhRcWVNWVEyYWlNenNH?=
 =?utf-8?B?Yk9oWEtCemJWNER5QThwbkZGMDVBY1cxZ1VScW9DTUQvWXU4OFBWMVpkdkM3?=
 =?utf-8?B?Q1JUYmZmNW1POHpuWEpYZ2EzdWNyUnhUWFBzVnNnT2JRZ2NvdVhBa2hxYVZZ?=
 =?utf-8?B?MVlBdXBYdVlFb2hlOWNvTndDUW92ZitRdlU4VGtoOTVZTVRqcUdYMzNxM3N2?=
 =?utf-8?B?OTJNd0tHakhHRjBKL0VqWnIyTUtSbURuV3NqdTVCUWJIdjFwR2pMRjgzTUJk?=
 =?utf-8?B?QThmM3JaTVdqdEFuZ0Z6VUxpcTZyZVNwMHpEeWhobS9Dd3VMNnU2SmJ4SXJ1?=
 =?utf-8?B?VGhoMnZaU0NJOGMvR3ZiOExHbGpRVDQvc1BJdXF2allOUGxDUHhDOXlUV28y?=
 =?utf-8?B?V2lIOTkzZ1BmamxncGhuaE9QUU5wQk5QTHNiS2R1cVpOMEo3ZlVFK0FaU3dw?=
 =?utf-8?B?WVdENjYzWjlpd3FlUmlCZlNnYjZEZ0tKZHZvenpUdXd0SGpqZHZZMStIOVAv?=
 =?utf-8?B?SWQrTC9TdUFBREwrbmE5S2V3MUwraGFiRWt5WFhJQjh4OUFDWWJhY1pWdWFC?=
 =?utf-8?B?Rms4Q1lncFNuZlZzYTNzMmdwS1RrZzZkVkRaV3FOa28rN1RXbWlMbDNxZGNS?=
 =?utf-8?B?ZWpkM3ZLdGN5b2dkd01nemtzTXY0NHp2ZS9BSGlhSXEycjg1NWN2UVFOazJE?=
 =?utf-8?B?K1BCd1BIYnBpQUNBTlBuNVM1MFdpd292T3ZCbzkzVVU3cEVaUjdrTTc5a1dD?=
 =?utf-8?B?OWVTS0J0WGZoa1lJd1N4Wmp0bXlKYXo3K2Q5ZDR0b0liVEl6S3JHOVdyZ0JK?=
 =?utf-8?B?KzZVU01mUTVMN1JadEliN0dlNzI3R3YvcFcxazBRVkYwcGhsMFNHYzJVWldk?=
 =?utf-8?B?UWxQK0FJdW54K1JFeXNicTF5SjdzSmtXMmw0MUNqWE9yZG9DUWk4NjVKTWpw?=
 =?utf-8?B?NEtFVTg5M0tZcmZ4Lzh0UXoxSVFDQ05IVFZTbG9tMTRBeU5CT0NBYy9NU3hs?=
 =?utf-8?B?QXBRdUJxN2Y2VVl2UUtUZWRIY1JrK3J5RURjek9XZUFPVmx5clB2Y0d4VGhQ?=
 =?utf-8?B?MHFQdlZ0a0tVV1c1bmJkMlhrSTVlMHl5K0pmTnk4dmV2OHZFb2tTZmVUKy8x?=
 =?utf-8?B?dmY1U1JtTHZTYW11dDRVc0h4TkhHK0NEMkZDbFR0QnhWYnkyWlJMbi84dGYv?=
 =?utf-8?B?Z3dteDRpOFZUdGlIOWE0MmhEOGxXMWxhbzlwV2UvbzF6NE9MYjUyaWpkRkVQ?=
 =?utf-8?B?RHhUYVNmY1BIbVIyNVJpZGdhSmlXc09CalI2YU5YQTF0dCt4dVMyZ0E0NEFT?=
 =?utf-8?B?Qlh5cEthRjl5WTVDNjdNMFJhZjl4SlhITHZPQ1BKSE5pTTBnV2UzeDVNUURX?=
 =?utf-8?B?TGRLWWZFOUZIM2RjeFdraDRFUWFMeVRaT2prT3ludWdKZXdzVjJlQ2xGdDFH?=
 =?utf-8?B?SStVSGN0NWVQRTJTMDRoQVlXMEgvbE9ueTVnZnZBMTBhVnBUaE9razJSdFc2?=
 =?utf-8?B?cS9QRFhqTFJPVWxJSWgybHMzQ1ZkSGRZZmVwRW1yOTcyRnBFbThTejEybXg4?=
 =?utf-8?B?ZWtEbjN0NWo5WjcvTzEzZ1A2TlRBY2FSWGluMHVHaFNIMG1mZ3A5ZmRhU3RY?=
 =?utf-8?B?Vjcybis4Z3QydUFXcU03SHBNRDIyUW5KRDJ3ZGRPVnR0clNLUlZQNGUrNWpP?=
 =?utf-8?B?cGdXTUtSVEgvNjB1cFBCV2ZoR2pUWWFxWTdZdDUwK2MrM0VCTW5EL1dDVm83?=
 =?utf-8?Q?7tUR3B0/v0QHs5glZMxH0r6XS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a45f1658-2bb9-42d6-93a4-08ddaa2594d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:54:14.4054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqFqqLW0S4/d5CFFGBlS7a3wgdy80XnZzzMbi/JVB5jDMFKZJXNiqV186H7N2wR/pyusBI9hshePMOit1a6DhTAZenAsVZ7h3rYTYNhepGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFF9F12DF7E

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gMTIvMDYvMjAyNSAxMjow
OSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ICsNCj4gPiArCXNvYzA6IHNvY0AxMDAwMDAwMCB7DQo+
ID4gKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPiArCQlyZWcgPSA8MHgwIDB4MTAw
MDAwMDAgMHgxMDAwMDAwMD47DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKwkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJcmFuZ2VzOw0KPiA+ICsNCj4gPiArCQlzeXNjb24w
OiBzeXNjb25AMTJjMDIwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAw
LXNjdTAiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPiANCj4gVGhpcyBtYWtlcyBubyBzZW5z
ZSAtIG5vIGNoaWxkcmVuIGhlcmUuDQo+IA0KPiA+ICsJCQlyZWcgPSA8MHgwIDB4MTJjMDIwMDAg
MHgxMDAwPjsNCj4gPiArCQkJcmFuZ2VzID0gPDB4MCAweDAgMCAweDEyYzAyMDAwIDB4MTAwMD47
DQo+IA0KPiBOZWl0aGVyIHRoaXMuDQo+IA0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsN
Cj4gPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+IA0KPiBOb3IgdGhpcy4NCg0KDQpJIHdpbGwg
YWRkIGJ5IGZvbGxvd2luZy4gDQogICAgICAgICAgICAgICAgIHN5c2NvbjA6IHN5c2NvbkAxMmMw
MjAwMCB7DQogICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3Qy
NzAwLXNjdTAiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnID0gPDB4MCAweDEyYzAyMDAwIDB4MCAweDEwMDA+Ow0KICAgICAgICAgICAgICAgICAg
ICAgICAgcmFuZ2VzID0gPDB4MCAweDAgMCAweDEyYzAyMDAwIDAgMHgxMDAwPjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KICAgICAgICAgICAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQogICAgICAgICAgICAgICAgICAgICAgICAjY2xvY2st
Y2VsbHMgPSA8MT47DQogICAgICAgICAgICAgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47
DQoNCiAgICAgICAgICAgICAgICAgICAgICAgIHNpbGljb24taWRAMCB7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI3MDAtc2lsaWNvbi1p
ZCIsICJhc3BlZWQsc2lsaWNvbi1pZCI7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwwIDB4MCAwIDB4ND47DQogICAgICAgICAgICAgICAgICAgICAgICB9Ow0KDQogICAg
ICAgICAgICAgICAgICAgICAgICBzY3VfaWMwOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxRDAgew0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3Qy
NzAwLXNjdS1pYzAiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAw
eDFkMCAwIDB4Yz47DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMg
PSA8R0lDX1NQSSA5NyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQogICAgICAgICAgICAgICAgICAgICAg
ICB9Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICBzY3VfaWMxOiBpbnRlcnJ1cHQtY29udHJv
bGxlckAxRTAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNl
bGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFzcGVlZCxhc3QyNzAwLXNjdS1pYzEiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MCAweDFlMCAwIDB4Yz47DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8R0lDX1NQSSA5OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQogICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsMDogcGlu
Y3RybEA0MDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFzcGVlZCxhc3QyNzAwLXNvYzAtcGluY3RybCI7DQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZyA9IDwwIDB4NDAwIDAgMHg2MDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCiAgICAgICAgICAgICAgICB9Ow0KDQogICAgICAgICAgICAgIHN5c2NvbjE6IHN5c2NvbkAx
NGMwMjAwMCB7DQogICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxh
c3QyNzAwLXNjdTEiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnID0gPDB4MCAweDE0YzAyMDAwIDB4MCAweDEwMDA+Ow0KICAgICAgICAgICAgICAg
ICAgICAgICAgcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MTRjMDIwMDAgMHgwIDB4MTAwMD47DQog
ICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAgICAgICAgICAg
ICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KICAgICAgICAgICAgICAgICAgICAgICAg
I2Nsb2NrLWNlbGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgI3Jlc2V0LWNlbGxz
ID0gPDE+Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICBzY3VfaWMyOiBpbnRlcnJ1cHQtY29u
dHJvbGxlckAxMDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0
LWNlbGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImFzcGVlZCxhc3QyNzAwLXNjdS1pYzIiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MCAweDEwMCAwIDB4OD47DQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmludGMxXzUgMD47DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgfTsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgc2N1X2ljMzogaW50ZXJydXB0LWNv
bnRyb2xsZXJAMTA4IHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI2ludGVycnVw
dC1jZWxscyA9IDwxPjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJhc3BlZWQsYXN0MjcwMC1zY3UtaWMzIjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnID0gPDAgMHgxMDggMCAweDg+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZpbnRjMV81IDI2PjsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQogICAgICAgICAgICAgICAg
ICAgICAgICB9Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsMTogcGluY3RybEA0
MDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNzAwLXNvYzEtcGluY3RybCI7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwweDAgMHg0MDAgMHgwIDB4MTAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIH07
DQogICAgICAgICAgICAgICAgfTsNCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo=

