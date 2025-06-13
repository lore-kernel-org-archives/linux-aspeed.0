Return-Path: <linux-aspeed+bounces-1421-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCA1C71148
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 02:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJN0w5gQzz2ySQ;
	Fri, 13 Jun 2025 12:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749780080;
	cv=pass; b=MzS91cEq44usHBPsIyiBduUC2WWTl33oI7ajE85NQbPocfB8RQRY1qoI6XOjqyWkmTWlplFzg9uJ5ahIwtGznWOCmk1MFGrB6TG8oJVDs2NQuULKyX8uFP7ahrHpkXe3n7klIpoU7/4irofPGQH11+tE5ffE13SrnhLBrajhSWwxVwL1odyz1d4ugz1EBfHO7Nod4gl+P5x0Zw76Kq6tvz0s0QNMJI7p7tWiN5gkSrb598I/buHczZY3S0NvmBRoI+BbbsnlbdA0i/snUSxrBb4eXwaNYg5NhkeUe9gexcaWExfRO0BQwNfquC1CQPZFyS17kGK4B0G+rsNsLDD90w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749780080; c=relaxed/relaxed;
	bh=3DWMmmARDnfDOvtL7GxjYuq1hLPDObsbuInHstc82MQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZnEGwGJFEzccMs7beICYI0JcecohheHo8MBvMw/+O7H2yevDvaune1+Bbb9XDeBY+a8MvGlOZ6xIcy1y2+0tVePUQaK0xhoIXgEVz/6f8NpK+6lEi08zJdROnEg2p0J5ny3axiCUiF5cueo4yxKDgd+IWKeFQjRdAINUrYhpK+GEzuFA4C5i5FXVucrqPhT+8lKmbfX262Y9H2o6aEM1c30XZpMdwQCRg5kJORaoJHC4RI9QQA5LfRvG+SZ5R+Zj9yGCYvxUyhI0i6UM585AAIzhT3BAmJ/MiH7Q/705doEaU8jyvlM/PoxUzFi7sHE5Yhle8bezFS7NxzwXYgn1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJN0f2SHJz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 12:00:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2hIj/OEBxvTB7EyFk4KX/lUTm7k/NMpdrQ0T1TBXHOO1697OMX9yZETj4Mq7YQQOQGhJkbok0xJKURtjaNJzmDFQQ1r5si0ljvGX47YIVYe5A+92p2xSFDXQO0+c3LiNdieHf/YwHUJJVDzTFHUCIIL6NQ/JdmkXLLZseZzYmxbhYr7pTF4Adpqtnq/TfeOvrV90eAWCV/2SosK9qDm1KuAxh8i1yfnqdxaeh7zOBnQswpIgSg++bhZm5/NVBiNev5A6G7jjdlDX0DS+uJVgCjUhXeiov7v76gQlkcnC/YnUcbG/d79rs7ZkS/woRJD2WXCsJIf4cIbkglmEK5TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DWMmmARDnfDOvtL7GxjYuq1hLPDObsbuInHstc82MQ=;
 b=S1uWCqsP3bfvfL1x7K/H3uyFqPIHAt2xw35rTnYGgV97Fl1rd2uQ3uQquzSoqFuz3WAF+r/Ptmq4IexOCiYnY9sj/fX/7r4MOvhZc2ffHUBaXdcBONB88BzodE0m69rG248ytXzJ/5U0AGcE6bMx3gyCix1LEszWkcYMs2C6CVLxlxXk4D/B+qHJS6ldsEAX7jwKEkJy2RBGgoZAEiST42uH/Zy3ZmdwdnEdMcCsGsjRu6W6ZUp8z9PQ5iJebz5crdYNjS6RPp0IrGW7iqTT6Nel33ffyKJNHP2b2MviMw8n0KD0hBGYtoLahjYZtH7h8/RiQZz7Jv7beDVdwyQzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DWMmmARDnfDOvtL7GxjYuq1hLPDObsbuInHstc82MQ=;
 b=VZJYriro7iX6PRcxXXOTzSBKS6aKqC8omu6hisLtloREwt3U/nWQzPBVHA1/A3kcjolTzk93V8QvP9BR0XHlYM0cTKvxRdCA2dymanZrx2uASMqanx7CYwFGBE7yUKmXzTsaIBqQ7wEbRwKZFgiOTyUCilQGSdvlQH2HNSaYlMndZ4rv6sknwYVF3muq21r/So1o9OTbAjA98LV/VTjCz7adPxarFJBygUlNI24PrDkjJmlTEL2Y9n+u+9vWAQ38F94nsdUglwxlBzWTslaz33B70chctD0ftw+rVts+TGL48zQdOVcYnKJNcYPKvEfjFbQicy3WCbfrZOiVoqe4FA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB5480.apcprd06.prod.outlook.com (2603:1096:101:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Fri, 13 Jun
 2025 02:00:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8813.021; Fri, 13 Jun 2025
 02:00:18 +0000
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
Subject: RE: [PATCH v0 1/5] dt-bindings: arm: aspeed: Add AST2700 board
 compatible
Thread-Topic: [PATCH v0 1/5] dt-bindings: arm: aspeed: Add AST2700 board
 compatible
Thread-Index: AQHb24IdOCKn20r1VE+Du2gnGQSf77P/TvKAgAEHp2A=
Date: Fri, 13 Jun 2025 02:00:18 +0000
Message-ID:
 <OS8PR06MB75417E28FB28DEBF9568531FF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-2-ryan_chen@aspeedtech.com>
 <278193c2-7061-4cd3-88e3-402ac85eddf7@kernel.org>
In-Reply-To: <278193c2-7061-4cd3-88e3-402ac85eddf7@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB5480:EE_
x-ms-office365-filtering-correlation-id: f88c4988-0ac1-4a29-ac12-08ddaa1e0bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjlCY2FGZkZLV0RlS2dqSG8xTWMwTVMvQ2FLT0ZscExvTUIxUlVFbU1XbU12?=
 =?utf-8?B?ejlTVDdlaXJILzBJRWNsRmNXSGJQcmNzMmtRYWJWZDRwcXdBKy9rSVVBUGhK?=
 =?utf-8?B?c3BDcVpaRjZhN0R0VzhGMVFEcU9Gci9QaEFWSlFaMUQ4akpMTUJhUyt2UWM0?=
 =?utf-8?B?RTVvbkFIQkYvMS9jR2JjVEFZd3JCNjQ1alh3UENwOExMbEhQanY5N3gyUm9O?=
 =?utf-8?B?RVk1eUF2Mzl6U3VSODNCeVFSLzQ4cDkvL08vVVhLeVFsUXpTKzIxaFh2WnZO?=
 =?utf-8?B?TU9mRVluLy9LNUo5ekxpQnVzbXdyNHE5c1p5Zmw3MUkxZG9QeG43cldCU092?=
 =?utf-8?B?V1JvcDFBdXprZWZaZVJNcHJORG5VS3RxQlhQeW5kYTNOVW5sMndtM09xUWRI?=
 =?utf-8?B?a3BEVGlkTE5UZjFEN25TRnZiUUJKTWErSUU5Z1RIRGNaY0hmanVFYUhTNGNp?=
 =?utf-8?B?WUNuaGpjTlRmanJacE5BREpnQkpicHlWODhKbVpmbDBsWmJnV0M4M1ZXTjlt?=
 =?utf-8?B?V0l4cTlFNkx2K0hwTU02QnFVUlBxTWtiNCtoeThNNERIaFhGNW1ERWtIOHFj?=
 =?utf-8?B?YnljM3N1SzlVT01lUjk1YUFDUmM2aXFrTGkxSitmaHo2Q0VsZ1JlUG4vellW?=
 =?utf-8?B?UnFac3ExbHlQbmFRTFNac0ZBZUk4a3Jjc3hhNnZ0aG5zZkN4amgwSGlGMEdF?=
 =?utf-8?B?OGFuTHFHbnJrVXhRM2hVWlZ4YWoweGxlY3MxeW5ZNXpoQlR6U1AwejZGanBY?=
 =?utf-8?B?MnIyUkZpTXM4STdtRHk2OWw3TlU1QmEwbjFpRmlscDRkQk8zRnh1OS9sajV0?=
 =?utf-8?B?SFQwdFBQQ2lUOEt3ZTFNUzZMMERvK3AyeDBEUXEyUFFkTnQxdGxmeGVrSjl1?=
 =?utf-8?B?eU1NZGJWUjZRamlaZDNmUUZpVWEvampHZ2hoQUc2VXVrWklRTjJ6QjB2MExh?=
 =?utf-8?B?c3JkZ2ZuTi9vUGN0N2Rnc0hvV2hkeXc5RDZuclNpWTZQc0ZmYlpDWUJFeW40?=
 =?utf-8?B?ZUJad2hGS3pMMFROdGpCVHBaYU9wZkY1YXdTYWhndUw2NVZWRzFYKzQ2c1M4?=
 =?utf-8?B?NSs3Snh4cC9sdDBrd21scWNiWVNlQ0hDS2ZyZldRcGRGVWdNMWk0T05EZXhC?=
 =?utf-8?B?UnVRZ29BZmVYUENsZThGVm81RFF1bnZ6b3FHdkVpakZROHRhb3pqT0Z3eFlL?=
 =?utf-8?B?VnRUa3lKM29vZEJiSUYxSXU1dnJTZmxRdm1iT0hjT2VkSG9qbE9IWVJvU0M5?=
 =?utf-8?B?VVozL3VBTUQ1cTlZVDBjd3pmbkhxUGZnU3dFYTZhdVVCVTZUQVhGUEV5OWN6?=
 =?utf-8?B?SHQ0TFlBbm54ei91U0djbjFZWm5wa0dzeG0vVFpEODlWV00yL1pDeHVxLzlG?=
 =?utf-8?B?Y2NPTzZ5Q2RNc3JIT1ZWalBhMlp4R2hRNFYvY3g0RVFkamxqM0lxOGhpV1l1?=
 =?utf-8?B?TDVFbVVHNGdBWCtmM0FieGUxMlUwN0NJdzIxbHZJMlVjaHFXWTJFRnBJdnF3?=
 =?utf-8?B?L3IyOWlhbklzZ0VrS2dSSDRnbFI1NlFJZVNDYTIyZ3lJNlVRc25yQUFQVlNr?=
 =?utf-8?B?L3g5S1NNVlVQd0RnYm9yTVNURUdYZ0p5Um1vWFpXRUhsaVdsUExiM0lIYzZm?=
 =?utf-8?B?RzZ6UHMxTk4ybklxWlZCWjVzdXc1ajdTUW1oVG5VRW8vTE5ubC9OM0hKRlZU?=
 =?utf-8?B?RmhBb0c0Tkd6U3NMWkZEc2ZXc2tFL0pnVmhIU21TNmttUmRTRXFsNHFoZkFH?=
 =?utf-8?B?eFhpU3FtODAwMjVZejVrTEsrWk1VaVE4Slo5clhFU3VNR0ZkRlBSMlBDc0pp?=
 =?utf-8?B?WGJZV3lTWk9CTTBVZ2Z3NkQwK01LdlpIeC95d1QrcW5HVDA5TG5HVkY0c1dQ?=
 =?utf-8?B?cUNWM1BPZHhadnE5WHBzV3Bza3NrRW5LbVJ6dk9WanVpR2dzZ0hxVzRHbUxx?=
 =?utf-8?B?Y3QzdUFtWmpUcG80Uytqd1pZc0ZvSTNtYlZFdFF1bFh0VVE4Um52ZFpoZXNJ?=
 =?utf-8?Q?fAJT15sFZmlRjr/VI4ppBJjJEM3dFk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ald1R2ZkOFpUaG5XTXR1ZE9KaGtBWFllUml5dk5ManpiamdLMDgzWS9rcW5Q?=
 =?utf-8?B?MHFJSC80UW9QS2psZXhSU3loZkIwVGRPcWhycmhqZ3B0b2xhL2xIUjJ4VW1T?=
 =?utf-8?B?NmlRaWZUSk5TS2hlOFgzQ1I5NlIrTjl3QTFTaFd1NDZnOHhYV0M5YitRcWNI?=
 =?utf-8?B?WW8rdnRpU2x6aGp4TmlieUdscHBFSlVYY09HZi9RZS95MkdBRnZZWGQ4M3NU?=
 =?utf-8?B?ZFBPM0h3dGJib3RkT1hPUElIRTBGMEhQYWtoWkVNR1JHVi8ydlR4aisrRElv?=
 =?utf-8?B?eUpzbitOcTFWdStxd1RFVElIbHQ3eXRtM0U2L20zNjEwWDlVbzBncUVGN3Jk?=
 =?utf-8?B?TTIybDc3S0ZtSFZOcndnZlEvQkJFaGNZSTRod0VINmErRGtqdWRwdktjQmdv?=
 =?utf-8?B?d2RjaDVBSFVJUWRMbzQ5YTBjdFd2bUFQUGlYQ1dxK3kzMWxqZFRFOWVSTGtS?=
 =?utf-8?B?d2NPdDRLSUt5bDM4M3VrRzFyVmMxZHVLd01wWklsRzcxMzZlQ0thY0srdUxK?=
 =?utf-8?B?WXY2MXRBOTVNcVBZcTMxWC9CSXBTOXQzTjhSOHJsUm9NTUlQV0IzeXdOeXdi?=
 =?utf-8?B?bnhrTnRQSmlvMk8wVWZwaS9heU9VTjRBM0FIVXhnWGZQUHY5dXdnM0gyVUNY?=
 =?utf-8?B?dDBQczMyNk5tTHZzbWk0Zi9LQ3FCNkFlQlJaS09MZUg4Q25vcDRBVW55VHpE?=
 =?utf-8?B?V3RiSFRYaTBLbTQ5bDEyVmYydUVIb1VGdG1Pd0VxNEFFNDM0NVdFTENTRmVF?=
 =?utf-8?B?U2xHMWNMYnJYZHVBdXUxY3czV3hPVkFKbFZ3UFhTd3BmUWlLd1M4cXlKcnhP?=
 =?utf-8?B?T3NwcEdXWTl4Wm1OV2pTc1ZEOWNYQVo0TkpTZFZQblpxKzhBVUliczBpYUVK?=
 =?utf-8?B?WW5kTWhBZ0g5OGZ5MXMwMHFKWFI1ZjVYenIzYWthNEx1SU9yTEVEaXJsUFly?=
 =?utf-8?B?dmVCbjdMdlR0c3YrTkF0UXRhRGFDOEFkaEI3OUluMllEQ0VoQldtQzJQMGI4?=
 =?utf-8?B?YkcyVEh6VjRWeHlENUpuOEswR3VCcmFEMlUvT3dZbkZHU0FseFlBNmpNUlFT?=
 =?utf-8?B?b250QThNT2NqZklza3h3Z2lhY1Rxdjh3OFJmaEw4T2FLNVMxb0gzZk5OOHpI?=
 =?utf-8?B?REhSRWZWaXdsYmZlQkhHZ05qUVNYWDJsbTNXaVdOT3BJMW94ckZpMGhNMVYx?=
 =?utf-8?B?elRtQnUvSjdOZEFDUVJvUE9zQXFQSlNJRUNVeEFJQ0VmbkI1S3F2dXJrNlQx?=
 =?utf-8?B?SWpITm83VEo1WFYyK2ZxQkd0enVyR25mL0o0RThsdURkeXZIOUlPekxpQ0xk?=
 =?utf-8?B?aFExV2hleXp4dHh4ME5yQURJNnY3amRuT3VoWldUbVFWTGJjNUVtcGpHZG5i?=
 =?utf-8?B?dFZrbHpKRDA4M1pGTkJmWE44NHV2S2VKaTVndTJYUzhSbDBGRDJybnpPdmha?=
 =?utf-8?B?UXowaUw1MVU2d0N3UFc1MDNRY3YwbjkxNHRnR2NEdlA4L0orVkVlRVl4ME9i?=
 =?utf-8?B?VTdOUWFyRTFEZzdnRHJnTFJtZkVCS3pub09qNVJGL0lVOHFWN1pwd0RSeFJL?=
 =?utf-8?B?a2FGUkZyS1YySUxCU3d4TjFIWGtsK09oR0g3cVJVaWNKdmFCYjVuSzkvWTdy?=
 =?utf-8?B?dGQ2QTBsQzZqeVNDa3kyM1VNYTl4cng5RFhJN1ZVcmgyeXh5TDhNVjBaeTR2?=
 =?utf-8?B?aU11OXNSUU02OUpGL0E3c2k2djZjVngzaHpTampSbkNESzRxVEdKL3gxbjBG?=
 =?utf-8?B?OVl1dHNnSFdTczNsTkZML01DVkVyVXJCanIrdXFIeWRFRnVvalFYU2swak5H?=
 =?utf-8?B?a0w1T1JVVWxTTGNxSmdxVXpiVlJIKzIxdjJycS9MK1hqMWtYQnNUb3FnVnRN?=
 =?utf-8?B?K1M5cVFWRjkwOHhNWFNSUUNZWnF1UldmUTJXWHJ6bHVyRW9vV1ZIcFAxSHQr?=
 =?utf-8?B?ZTRRQjVvU2IvbXczSjJnUkdVUm96czZJK3E3WXQvTWt3ZlB1Y3RZeWRkSGVE?=
 =?utf-8?B?Z3FmR1YzSXNjQVp4YndYTWJmYnJLY2d3cENYd2thVjNJSTRYUEZnNzN6Znpq?=
 =?utf-8?B?ZDlIMnQvNmgwMU5QTHBscm1sL0tPTUI2ZEJIMHRqY2t3VG15Z0R5czcyMk9H?=
 =?utf-8?Q?thrUrMHWmQrr1cA/VjtIpp8zD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f88c4988-0ac1-4a29-ac12-08ddaa1e0bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:00:18.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzbzwdlm0aFOvoU2AIMeiaqDWbWzGF1QUS5rTe55TNiXNxLsZBfNsEuWprJXyDpNG3mtyrlS0QxyxJ8UXYvpambHKAYdlba/mBC/XuvgDiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5480

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDEvNV0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVkOiBB
ZGQgQVNUMjcwMCBib2FyZA0KPiBjb21wYXRpYmxlDQo+IA0KPiBPbiAxMi8wNi8yMDI1IDEyOjA5
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gQWRkIGRldmljZSB0cmVlIGNvbXBhdGlibGUgc3RyaW5n
IGZvciBBU1QyNzAwIGJhc2VkIGJvYXJkcw0KPiA+ICgiYXNwZWVkLGFzdDI3MDAtZXZiIiBhbmQg
ImFzcGVlZCxhc3QyNzAwIikgdG8gdGhlIEFzcGVlZCBTb0MgYm9hcmQNCj4gPiBiaW5kaW5ncy4g
VGhpcyBhbGxvd3MgcHJvcGVyIHNjaGVtYSB2YWxpZGF0aW9uIGFuZCBlbmFibGVzIHN1cHBvcnQg
Zm9yDQo+ID4gQVNUMjcwMCBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFu
IENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gQWxpZ24gd2l0aCB5
b3VyIGNvbGxlYWd1ZXMuIFRoaXMgaXMgbm90IHYwLCBidXQgdlgrMS4gQW5kIFggd2FzIGFscmVh
ZHkNCj4gMyBzaW5jZSB5b3Ugc2VudCBpdCENCj4gDQpHb3QgaXQsIHdpbGwgZ28gZm9yIHY0LCB0
aGFua3MgdGhlIGluc3RydWN0aW9uLg0KDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MTIxMjE1NTIzNy44NDgzMzYtNC1rZXZpbl9jaGVuQGFzcGVlZHRlYw0KPiBoLmNvbS8NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

