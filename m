Return-Path: <linux-aspeed+bounces-1463-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F03FC71157
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 02:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLDPD0dP5z2xHv;
	Mon, 16 Jun 2025 12:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750040720;
	cv=pass; b=VXS6qJCwC8ulvqteMVRhXVChKzMxzHtzNN1jEXBPeYXH7VoxT4F7gkvaZJSwpsLQQ35//xeZqpdNOQulFgBvXNMHnBK+mHw4KnutYMzug0m2vuYT8tqg0L1nnjBKo7TI75cGRYSyRlvn3cra27Xw/vo+l4qCPS++sim1CU8I8z9oeVKUhz3xvpHruDZZb9lJffYF9nQMaCYosXWp8K7294efVCwptLD3bviLykIq92nkWVQkDlo/dI3jh2ZFzVpLawBNT4V71J1DesiNE9Vgpg+iIfZIcXU+oqKr9P3aN7nSqT/Ny/e55INEDkF0FGU5VL0+3UWoOl1vmUthbNnIoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750040720; c=relaxed/relaxed;
	bh=G6FjyHLnWL+kxD7CzzGROEXZDrZuKzDHg4W19LoWqoA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOF0NJ2iLWTXidVb5bU69Vk1PEeDEAAR25pLnRiMVJLebxuM2tHV1lPFU4GaG+babrvYqAkcfug1iD0aR/L0DS7B34lPF1JP1hZc9FVfOkYlEJZh9JuoXYYw8bTZIgm4LV1lvZExksnerR/Cvu7EJgqgfgSPuByJXMj0MhYnAJ2rIZuE0ipTiB994FG+IhUnwCJ+J8gypsh8DjoP9fpm5NSyYQiicVGfLGavqkjMUtneDEUN5bGsCR2e0j3WnPHZ/wYuq2xsNocgMZsiFhTgNAdgLNSsRJN+g4HByMUbuHahYyVBgfWquoPRq79P1ci48A8evxhqOZBxZvMQrJlBJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLDNr4nYgz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 12:24:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRcWyjHOHsKUxLwl/WfwSobkmtJ+3YrmrlrfmQTcj9WIWOM3NdCJHWTSkDEtTKNVjAW/RDAySXAesHrI0HPXk2XgfWAmk1rkgqGAvDMnkI6RakIMd5iBJ04s0M3JGl/7zUkeS5kr/Va4DJYmRvo7BRvn0Dz+SouYsj7/9lwHW71I4+f+z0WbRv+20AwP0VESt73QKDa85ozNCVq2/f1t8mWcrYQcPiBpg17Xr1SS8ofSBopqpYdswEhNKNAT5PpoW2Yg7rC43iKUI9dFIPC2zvQeN97FYVlegOIDtj/oWZjYHhLCPDfAMLx1XM9qyu5b82VSA6mLX60ZzRUyi12PIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6FjyHLnWL+kxD7CzzGROEXZDrZuKzDHg4W19LoWqoA=;
 b=YQvLJSIaXyoPJaFLFYX0+b3V5MTMjUSfvlnn8Szo1BBiHORbI2isHSiOqRZQnBJWfpIaCIglUiR96e+4A+QiwcVD1HRxeTDSHLYNXQrRJmT73AswinHPl+I9AATdUoRKNPSXtCTdX+gR0lNGVRfQ/9C6wQHtdlaaU6AGA32xHB8pK0jwodLL8jb4iosM/IfRSO66kKqp40PxPJYwNq6woPuUY8ZudwfxFEQ8mtbIB+/36YlIrfDgp8PwnfDRqZJQG3SskmjWuAg4ctyGhjFN5WavhOE8zHB2LTkWj8L/fX0pqDIHEHELlzh8fvtYwtrmSGuJUk0Yrx7KPd49WZe2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6FjyHLnWL+kxD7CzzGROEXZDrZuKzDHg4W19LoWqoA=;
 b=F1N1LbAhvbZeQIanI0Porw8RaXNAu84KXA+eFqtCA1tqoLlRUfr+qD/Zr7VgPuvOcML0WejtZseEEDEjhfR33OI1C36q1mhc7UpnIgyXbtFNZNfaTyzUGrQQFquy3LYukwQ+a++lX9ndJQbXwLiUR9M2gX8htDKUGttAqHJebPQ9ua2DPNaIaFFwjW1zTLbCQictbkKs+2wi2K4z/ChTZRqTX2awUE79nZs42PN1SOS+VAeYkpk2pcXRDfQwMGG5bmNpOt2//4hCLKyxM0GXdh8Z0T+4Bwus+vW+Kf4Btamvvxk6qYY1rXe7pTmc6NtEMmZbMkcWuJcXDYLGv+GbPg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6610.apcprd06.prod.outlook.com (2603:1096:101:179::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 02:24:24 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 02:24:24 +0000
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
Thread-Index: AQHb24IeM0HrrMksj0qjPEmThyghWrP/T4SAgAEHZPCAAEdfgIAEbCrg
Date: Mon, 16 Jun 2025 02:24:24 +0000
Message-ID:
 <OS8PR06MB7541FFCA9E28E5767791D869F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
 <OS8PR06MB7541A100B918AAA84D1ABDCAF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <749c581e-cc00-428f-8eb9-222f9d574486@kernel.org>
In-Reply-To: <749c581e-cc00-428f-8eb9-222f9d574486@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6610:EE_
x-ms-office365-filtering-correlation-id: 36d67473-c083-4e7c-891a-08ddac7ce915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1lDN09hd2dTcmRWMXF6UlIwWnJIWmdIdW4wU0JyeGVEVk9rOTFSOG1jbEp0?=
 =?utf-8?B?TjhXcHhGTVN3VlJtVEtpRDd1aGNub3VqVFNmVFY0dmQ1M21jRlFXM2ZDdEJN?=
 =?utf-8?B?K0loZVAwZjBseWVzd0dSVEl1TWU1S29ZdytNVmExT3JwblpvTXcxN09JUmJO?=
 =?utf-8?B?dGZaM2R4RGNGdUdJeWhzb2dCSGk5V0ZObmU1N1V6N1BIV2hPV0pJSnI1ck50?=
 =?utf-8?B?UEU1VkVOZ09scFlTdm1sMkppbUJWWFdvUFptL1ZUcW1BK1lCUDBsU1gweE5o?=
 =?utf-8?B?TitVSnEwMkhuLzAzM3BnZzFvZCsrSUtadTFGWUtqL2trdVM1Si82cWwzenFn?=
 =?utf-8?B?cHhXOGs5NUE3ajdwZm42RmRoaENOVjVZeXVKdFpQUFpkK2VDcEZnVWRQeXZK?=
 =?utf-8?B?UFVOK051L3F0dWFQRTBsVDdGVDJkS2c3TyttYnFGZnd0b2VxTHc0NlhTcXlr?=
 =?utf-8?B?aGR2QXBtLzU0Q3NNZFpTeDdsTkRzSVZsSk1TekNoS2pSQzlvZ0FpZU1jMnJH?=
 =?utf-8?B?WlVnL2JrTE5JSUVkSHZ3ZVBWM1hwU0dTcWNLcHdhdU0zcjM1V1J4S0dxeEtI?=
 =?utf-8?B?T0hDcTRha0RMemVsdFptYVdjQUZQd0tMOHRuTUJzNXJUWXdXS1Fsaml4djZW?=
 =?utf-8?B?RitEK2N0M2tkSXVmTGM3cjNGY2VsRUhjbEpmby9xdnNUNmptR2pVOGdGbk9P?=
 =?utf-8?B?Skh2cWpzYm5CRE0rb3NnMjBma3Qyb2FXcUUwTWdsUENqWTZtQ0pQV0pjc0pN?=
 =?utf-8?B?NWhWZnZMeTFwbXA1dFI0R3p3eHQ4REYvYUpvdEhlNEt4dHJJcXNlaVFKRzBD?=
 =?utf-8?B?QUxiSVBKZ0pYL3pTcXF0bXZQb2NFUzFSUVQxeGN4Tmh4bzlHSHZzMDFDRkVB?=
 =?utf-8?B?NTdLSjlHK29iaVBQTXh4b0IxNGhIREVGemFUd2VmaUhVMi9qbUI4dzRoU0dV?=
 =?utf-8?B?WERtYXBHeUk5bmV5aG1QVmxFRVUzdmF4OVBJZDIrUjFYT3F4ajFldEMvSWt0?=
 =?utf-8?B?Zyt2eUhzMzV3ZXdJeFJRSnBzTHFBYk01dnFSaFFWYkVLZVp3OVJLaUcrQlZj?=
 =?utf-8?B?VEhvN1NaaXVkRTlXWnFWcFV3ZG1IUEljdTMwdzBwZE9ubmxBdG5ucmxkWGUx?=
 =?utf-8?B?eTJmV1F6SVB1V1I0WVM3bC81MVd3bUtOZEsvWnk4Vk9nU0Q0SVBHVURsT1c3?=
 =?utf-8?B?Qzd6cklMSGlRTFRqY0hkaW14Mzl1bFVsbjlUSFlEM2hhcjI5bnRxMXlRNUdj?=
 =?utf-8?B?OGdDdDRtdUpMVmRqWENHbTRZL2lEeCtZTVdPNHlrbWdUQURTTFN0WGFzbk55?=
 =?utf-8?B?OG9hbGs5UVA1em1tK3lYQTN5SUlYZ2ZVQXk0eVlRYXdSY2FNcFRhQkZYYmF1?=
 =?utf-8?B?L00rVEozZFMrdjNiaEFqcWloRVEvUkhsOUxtYmRiWHFHekFNejBPYlU0cmxh?=
 =?utf-8?B?QjJxZjJCQXIyZ0txSWNWUzlDOG12WlpvZ2ZtYjFLdkpvbGdEZXhVSFhINDUw?=
 =?utf-8?B?RzhFNi9SYXVTTHg5TmVLUVdMM1dqUXBuOExZUkx5SExGYzNuekZpN3pWNTVE?=
 =?utf-8?B?bE9xYklpYlB0OUU4RnpLSXZycWppd04zMUJYS3FVT0JpeE83dzF1QUgxNUlZ?=
 =?utf-8?B?WGl0R0VDaW9XQkIrYnZJUkZqK0NZVlAzZnlHWnJsak9nbTNqc2pGM0ZSYUg2?=
 =?utf-8?B?d2Y2ZHA1bm85T1dOaFhwUFVaVUJoV2xVL2NXOVUyczl2dUdDd3pBa1hTZWJR?=
 =?utf-8?B?dVArVytGQmo5NEpVaVNVWTBZYUk4ZktPb2c0S0M1UEpRNFBieFdxZWdXTDF6?=
 =?utf-8?B?bi9GOCtkUEJsWS95MkM2RFhmd3pzdG9Kem9BdTN2SFhTNU1pWlYwellVdjFB?=
 =?utf-8?B?ZmFZTkNnUS9zekhydWNvMEZOMG5RdzhKWnVqajNNSERnL1pETGR5VXNxbEZQ?=
 =?utf-8?Q?kuHg0B/BDfJzEh+V3jlk8p1cHtoZRzqP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHkrTjNMdnhjbTdObmhFZHZpTXhua3NaQUFqQzQ1dXhmUDhGdUtrUCs5aFIw?=
 =?utf-8?B?N1lnTWhtbFVjbEFaODI5ZUxPT3dCSlVPRldDRlI0OWtDSDRpb1ZLMk5FeVBG?=
 =?utf-8?B?RkdjTXhRQStVdmd6YUFBQktmZGtzV01kRXJnNitveTRISVhUZzU3a3BZVTZ6?=
 =?utf-8?B?TVFnT3pJTmZPVVMycEZWVW5lSEN2R0Nqc2VqUVhFS0kyYnovT1Z4QU9QdjBr?=
 =?utf-8?B?Ym5ZL0h0VHZ4My9mczJnM21TNVoxVFFiZkJlQ3N6MklOVTVVNFdReXB6ai80?=
 =?utf-8?B?UWNPTThtQWQzblVreXBnQWhmSllMMDhaZ1dHMHZHQjNXMGVxcmhuYWZjenlV?=
 =?utf-8?B?WFdzNDE2TmhzaHAzeDZlM2wwN0thSXN5Vnc1RHNHK0xlanJGU3QrS3ZDOVA5?=
 =?utf-8?B?VktsaXNoUTlvU012N0RvSk5GWWF4TkhwQnZoVDZzQ0hUa01vU3VJNGQ1ckh3?=
 =?utf-8?B?ZHRPVjBPVEpLcGIxditPeVY1TVZkVzR4cldBK3A4TDlMR2h0Uy9kWEJNRVVo?=
 =?utf-8?B?SWlHdFhjQ0VLN2hYcmx4SjN3b0hNQ3psOUhKYzl2V0J4bWxHTXFQNnVqdmo1?=
 =?utf-8?B?M0tyNnNLN0NqMFVGQ0szT0k4L01JWXRVemE2Y2N1a01HTmpOQlNKcjNpM0xm?=
 =?utf-8?B?a0hIU2tDWUpXczJFN08zSlNhZ294dTN1UlprME1XOUNjdjRiRkxPRVVpdC9P?=
 =?utf-8?B?S015bFRIeVdzOExDUkI2U2wwbTMwUURSS2xVQmpkOVN2S3Q4dmNJYmlYSzVp?=
 =?utf-8?B?SUpubXFhNUhsSmdGRVA1eUNZSG9NUThTOHU3NUw1anlTN1dlWElDQnllU1VK?=
 =?utf-8?B?a3ZVTWkrU1FoMksvZy9Ib3kzSGl0Sk9XQU1uNURGd2lENDJNRm41cnRqNmRh?=
 =?utf-8?B?OXlaSVNtU3d1U2YvbWIrZ3hQa2lWaDBCaWZvcExiL2VOMFVVbFFQOGZhcnJF?=
 =?utf-8?B?SENISWxvcjZ2L3RrMmFzV0t3eUUxbTlkMENoQVdzN21zMjFHNlF2eU5Xdnh6?=
 =?utf-8?B?dnVveVJWcUdrUkpXVmhScXZlaGNnTTBSYU1rYXhSWlY4ei8wc0l3QXlBTmVt?=
 =?utf-8?B?YUFMYVdHWXF1SC9OblYxeHVIOTdoeUZsaWVmQ3RRM3dvN2orL1VtandzWE5p?=
 =?utf-8?B?NEVLLzlvd1k5VU9tVmJPc1ArR0liSXdqdGJTOUJrKzUxaUFuTmVXWEVJY0po?=
 =?utf-8?B?cTFSMlI0ajF1d1MxcDZ1eDk4QlBVYTI5SlJ3d1NhYS9VVitOTlRwaTA0bzhm?=
 =?utf-8?B?bW5YbS9HT245YkhwK3MrOUxJbXZXemN5ODhQQzlISnJRKzZCelhUckJoeHhE?=
 =?utf-8?B?VElaVE9TV2FlNlZqYWc5YXcybnRNSWNMcmlWVDZNRVVPM2prUHNrQTAyRzdN?=
 =?utf-8?B?ZS9ES0d2cXE1NkxmNzZRbUdnTnljQzU0cHhLTG9XUkZ2YVdsZUtQTE5KNHRP?=
 =?utf-8?B?QytSUW1xc1JBMWFzVmRIL3ZmSFRaZE5BWHgxZ0JrWWVwYVNqNmpva0libW11?=
 =?utf-8?B?eWY5Z3ZvcEFCRXpQYnlleFhMbnVnM3VpTngwNEoweGkxM21UeXhFUUFTYVJ4?=
 =?utf-8?B?SERpMGdWK0FCM3htV01YaEJsZ2NsK0d6em1MOXh5Z21xc1Ara2VJWFA3YUFZ?=
 =?utf-8?B?bXI4MUZkMTFnYU9RWllpc25yRDd0TlNGOVNLMk1wcThZRVo1UFJWZjI3YzNV?=
 =?utf-8?B?SzFMU0QzR0pVRklxQklvQ3FlL3B2RVZ2b3UvTFlUV2JIUWRIbVNtRVFmT0pG?=
 =?utf-8?B?aC9RZ2ZBSDZUbW1hMUFNcEt1NnJWV3lMSi81RDgwOWEyRlpKelpWU1Ara2x6?=
 =?utf-8?B?NVZVN0ZVWjBVaXQyd0w3QzdRWS9Zc05odkNyWURITkJLRmtqU0l1RXg2Uklk?=
 =?utf-8?B?VGlDVGZUaFI5dlUvMEhSVlNJSzl4QUlkVmtXcE1kU212UmJNbDVvbDRvWDNs?=
 =?utf-8?B?VlZRZENnWVJwOUVzSUk5UDIvRU1URmhUaDRZL1JXUlNpLzIrdDNMb0FaV1Vo?=
 =?utf-8?B?cmE1MlBuODd1YmNnYWtrL1cyS2NiZ2tWL1NpRGFrdXd5KzVRTHljYlZQM013?=
 =?utf-8?B?R3NLc2FHaThIOEhLcEs2dTRwckdDVWdVT1JCclgzdUVHSU1JQkV6ak5ORXdU?=
 =?utf-8?Q?4Y2KCJMfrjskfCANq9063LbhO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d67473-c083-4e7c-891a-08ddac7ce915
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 02:24:24.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoDVkj+OIgBsiiopeDc459vAfwes9sWzxFVMxaNMT2PJOD8+/nAyUImq6SKglLjgKiBZVunRTCn3MMmA/tDP1PA73fNjb4PWPzOD7eYpzqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6610

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gMTMvMDYvMjAyNSAwNDoy
OSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJt
NjQ6IGR0czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyNzAwDQo+ID4+IFNvQyBkZXZpY2UgdHJl
ZQ0KPiA+Pg0KPiA+PiBPbiAxMi8wNi8yMDI1IDEyOjA5LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+
PiBUaGlzIGFkZCB0aGUgaW5pdGlhbCBkZXZpY2UgdHJlZSBzdXBwb3J0IGZvciB0aGUgQVNQRUVE
IEFTVDI3MDAgU29DLg0KPiA+Pj4NCj4gPj4+IC0gQWRkIHRvcC1sZXZlbCBjb21wYXRpYmxlIHN0
cmluZyAiYXNwZWVkLGFzdDI3MDAiIGFuZCBzZXQgdXANCj4gPj4+IGFkZHJlc3MtY2VsbHMvc2l6
ZS1jZWxscyBmb3IgNjQtYml0IGFkZHJlc3Mgc3BhY2UuDQo+ID4+PiAtIERlc2NyaWJlIGEgcXVh
ZC1jb3JlIEFSTSBDb3J0ZXgtQTM1IENQVSBjbHVzdGVyIHdpdGggTDIgY2FjaGUsDQo+ID4+PiBp
bmNsdWRpbmcgY2FjaGUgcHJvcGVydGllcyBhbmQgUFNDSSBlbmFibGUtbWV0aG9kLg0KPiA+Pj4g
LSBBZGQgUE1VIGFuZCBBUk12OCB0aW1lciBub2RlcyB3aXRoIGNvcnJlY3QgUFBJIGludGVycnVw
dCB3aXJpbmcuDQo+ID4+PiAtIE1vZGVsIHRoZSBkdWFsLVNvQyBhcmNoaXRlY3R1cmUgd2l0aCB0
d28gc2ltcGxlLWJ1cyBub2RlczoNCj4gPj4+IHNvYzAgKEAweDEwMDAwMDAwKSBhbmQgc29jMSAo
QDB4MTQwMDAwMDApLg0KPiA+Pj4gLSBBZGQgc3lzY29uIG5vZGVzIGZvciBib3RoIFNvQ3MgKHN5
c2NvbjAsIHN5c2NvbjEpIHdpdGggY2xvY2svcmVzZXQNCj4gPj4+IGNlbGwgZGVmaW5pdGlvbnMg
YW5kIGFkZHJlc3MgbWFwcGluZy4NCj4gPj4+IC0gQWRkIEdJQ3YzIGludGVycnVwdCBjb250cm9s
bGVyIG5vZGUgdW5kZXIgc29jMCwgd2l0aCBmdWxsIHJlZ2lzdGVyDQo+ID4+PiBtYXBwaW5nIGFu
ZCBpbnRlcnJ1cHQgcHJvcGVydGllcy4NCj4gPj4+IC0gSGllcmFyY2hpY2FsIGludGVycnVwdCBj
b250cm9sbGVyIHN0cnVjdHVyZToNCj4gPj4+ICAgLSBpbnRjMCB1bmRlciBzb2MwLCB3aXRoIGNo
aWxkIGludGMwXzExIG5vZGUuDQo+ID4+PiAgIC0gaW50YzEgdW5kZXIgc29jMSwgd2l0aCBjaGls
ZCBpbnRjMV8wfmludGMxXzUgbm9kZXMuDQo+ID4+PiAtIEFkZCBzZXJpYWw0IG5vZGUgdW5kZXIg
c29jMCwgb3RoZXJzIHNlcmlhbCBub2RlIHVuZGVyIHNvYzEuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVk
LW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+PiAtLS0N
Cj4gPj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaSB8IDM4MA0K
PiA+Pj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzODAg
aW5zZXJ0aW9ucygrKQ0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiA+Pj4gYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiA+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDE5NzE4N2JjZjlmDQo+ID4+PiAtLS0gL2Rl
di9udWxsDQo+ID4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcu
ZHRzaQ0KPiA+Pj4gQEAgLTAsMCArMSwzODAgQEANCj4gPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAjaW5jbHVkZQ0KPiA+Pj4gKzxkdC1iaW5kaW5ncy9j
bG9jay9hc3BlZWQsYXN0MjcwMC1zY3UuaD4NCj4gPj4+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVzZXQvYXNwZWVkLGFzdDI3MDAtc2N1Lmg+DQo+ID4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPj4+ICsNCj4gPj4+ICsvIHsNCj4g
Pj4+ICsJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4+PiArCSNzaXplLWNlbGxzID0gPDE+Ow0K
PiA+Pj4gKwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiA+Pj4gKw0KPiA+Pj4gKwljcHVz
IHsNCj4gPj4+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+Pj4gKwkJI3NpemUtY2VsbHMg
PSA8MD47DQo+ID4+PiArDQo+ID4+PiArCQljcHUwOiBjcHVAMCB7DQo+ID4+PiArCQkJZGV2aWNl
X3R5cGUgPSAiY3B1IjsNCj4gPj4+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1IjsN
Cj4gPj4+ICsJCQlyZWcgPSA8MHgwIDB4MD47DQo+ID4+PiArCQkJZW5hYmxlLW1ldGhvZCA9ICJw
c2NpIjsNCj4gPj4+ICsJCQlpLWNhY2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+ICsJCQlpLWNh
Y2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4+PiArCQkJaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+
ID4+PiArCQkJZC1jYWNoZS1zaXplID0gPDB4ODAwMD47DQo+ID4+PiArCQkJZC1jYWNoZS1saW5l
LXNpemUgPSA8NjQ+Ow0KPiA+Pj4gKwkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+Pj4gKwkJ
CW5leHQtbGV2ZWwtY2FjaGUgPSA8JmwyPjsNCj4gPj4+ICsJCX07DQo+ID4+PiArDQo+ID4+PiAr
CQljcHUxOiBjcHVAMSB7DQo+ID4+PiArCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gPj4+ICsJ
CQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1IjsNCj4gPj4+ICsJCQllbmFibGUtbWV0aG9k
ID0gInBzY2kiOw0KPiA+Pj4gKwkJCXJlZyA9IDwweDAgMHgxPjsNCj4gPj4+ICsJCQlpLWNhY2hl
LXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+ICsJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+
ID4+PiArCQkJaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+ID4+PiArCQkJZC1jYWNoZS1zaXplID0g
PDB4ODAwMD47DQo+ID4+PiArCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KPiA+Pj4gKwkJ
CWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+Pj4gKwkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8Jmwy
PjsNCj4gPj4+ICsJCX07DQo+ID4+PiArDQo+ID4+PiArCQljcHUyOiBjcHVAMiB7DQo+ID4+PiAr
CQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gPj4+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0
ZXgtYTM1IjsNCj4gPj4+ICsJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+Pj4gKwkJCXJl
ZyA9IDwweDAgMHgyPjsNCj4gPj4+ICsJCQlpLWNhY2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+
ICsJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4+PiArCQkJaS1jYWNoZS1zZXRzID0g
PDI1Nj47DQo+ID4+PiArCQkJZC1jYWNoZS1zaXplID0gPDB4ODAwMD47DQo+ID4+PiArCQkJZC1j
YWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KPiA+Pj4gKwkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0K
PiA+Pj4gKwkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmwyPjsNCj4gPj4+ICsJCX07DQo+ID4+PiAr
DQo+ID4+PiArCQljcHUzOiBjcHVAMyB7DQo+ID4+PiArCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsN
Cj4gPj4+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1IjsNCj4gPj4+ICsJCQllbmFi
bGUtbWV0aG9kID0gInBzY2kiOw0KPiA+Pj4gKwkJCXJlZyA9IDwweDAgMHgzPjsNCj4gPj4+ICsJ
CQlpLWNhY2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+ICsJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9
IDw2ND47DQo+ID4+PiArCQkJaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+ID4+PiArCQkJZC1jYWNo
ZS1zaXplID0gPDB4ODAwMD47DQo+ID4+PiArCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0K
PiA+Pj4gKwkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+Pj4gKwkJCW5leHQtbGV2ZWwtY2Fj
aGUgPSA8JmwyPjsNCj4gPj4+ICsJCX07DQo+ID4+PiArDQo+ID4+PiArCQlsMjogbDItY2FjaGUw
IHsNCj4gPj4+ICsJCQljb21wYXRpYmxlID0gImNhY2hlIjsNCj4gPj4+ICsJCQljYWNoZS1sZXZl
bCA9IDwyPjsNCj4gPj4+ICsJCQljYWNoZS11bmlmaWVkOw0KPiA+Pj4gKwkJCWNhY2hlLXNpemUg
PSA8MHg4MDAwMD47DQo+ID4+PiArCQkJY2FjaGUtbGluZS1zaXplID0gPDY0PjsNCj4gPj4+ICsJ
CQljYWNoZS1zZXRzID0gPDEwMjQ+Ow0KPiA+Pj4gKwkJfTsNCj4gPj4+ICsJfTsNCj4gPj4+ICsN
Cj4gPj4+ICsJYXJtLXBtdSB7DQo+ID4+PiArCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1
LXBtdSI7DQo+ID4+PiArCQlpbnRlcnJ1cHRzID0gPEdJQ19QUEkgNyAoR0lDX0NQVV9NQVNLX1NJ
TVBMRSg0KSB8DQo+ID4+IElSUV9UWVBFX0xFVkVMX0hJR0gpPjsNCj4gPj4+ICsJfTsNCj4gPj4+
ICsNCj4gPj4+ICsJcHNjaSB7DQo+ID4+PiArCQljb21wYXRpYmxlID0gImFybSxwc2NpLTEuMCI7
DQo+ID4+PiArCQltZXRob2QgPSAic21jIjsNCj4gPj4+ICsJfTsNCj4gPj4+ICsNCj4gPj4+ICsJ
dGltZXIgew0KPiA+Pj4gKwkJY29tcGF0aWJsZSA9ICJhcm0sYXJtdjgtdGltZXIiOw0KPiA+Pj4g
KwkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDEzIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4g
Pj4gSVJRX1RZUEVfTEVWRUxfTE9XKT4sDQo+ID4+PiArCQkJICAgICA8R0lDX1BQSSAxNCAoR0lD
X0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+ID4+IElSUV9UWVBFX0xFVkVMX0xPVyk+LA0KPiA+Pj4g
KwkJCSAgICAgPEdJQ19QUEkgMTEgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkgfA0KPiA+PiBJUlFf
VFlQRV9MRVZFTF9MT1cpPiwNCj4gPj4+ICsJCQkgICAgIDxHSUNfUFBJIDEwIChHSUNfQ1BVX01B
U0tfU0lNUExFKDQpIHwNCj4gPj4gSVJRX1RZUEVfTEVWRUxfTE9XKT47DQo+ID4+PiArCQlhcm0s
Y3B1LXJlZ2lzdGVycy1ub3QtZnctY29uZmlndXJlZDsNCj4gPj4+ICsJCWFsd2F5cy1vbjsNCj4g
Pj4+ICsJfTsNCj4gPj4+ICsNCj4gPj4+ICsJc29jMDogc29jQDEwMDAwMDAwIHsNCj4gPj4+ICsJ
CWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ID4+PiArCQlyZWcgPSA8MHgwIDB4MTAwMDAw
MDAgMHgxMDAwMDAwMD47DQo+ID4+PiArCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPj4+ICsJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+Pj4gKwkJcmFuZ2VzOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJ
c3lzY29uMDogc3lzY29uQDEyYzAyMDAwIHsNCj4gPj4+ICsJCQljb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNzAwLXNjdTAiLCAic3lzY29uIiwNCj4gInNpbXBsZS1tZmQiOw0KPiA+Pj4gKwkJCXJl
ZyA9IDwweDAgMHgxMmMwMjAwMCAweDEwMDA+Ow0KPiA+Pj4gKwkJCXJhbmdlcyA9IDwweDAgMHgw
IDAgMHgxMmMwMjAwMCAweDEwMDA+Ow0KPiA+Pj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
PiA+Pj4gKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+Pj4gKwkJCSNjbG9jay1jZWxscyA9IDwx
PjsNCj4gPj4+ICsJCQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4+PiArCQl9Ow0KPiA+Pj4gKw0K
PiA+Pj4gKwkJZ2ljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMjIwMDAwMCB7DQo+ID4+PiArCQkJ
Y29tcGF0aWJsZSA9ICJhcm0sZ2ljLXYzIjsNCj4gPj4+ICsJCQlyZWcgPSA8MCAweDEyMjAwMDAw
IDB4MTAwMDA+LCAvKiBHSUNEICovDQo+ID4+PiArCQkJICAgICAgPDAgMHgxMjI4MDAwMCAweDgw
MDAwPiwgLyogR0lDUiAqLw0KPiA+Pj4gKwkJCSAgICAgIDwwIDB4NDA0NDAwMDAgMHgxMDAwPjsg
IC8qIEdJQ0MgKi8NCj4gPj4+ICsJCQkjaW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KPiA+Pj4gKwkJ
CWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+Pj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1BQSSA5
IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gPj4gSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0K
PiA+Pj4gKwkJCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4+PiArCQl9Ow0KPiA+Pj4g
Kw0KPiA+Pj4gKwkJc2VyaWFsNDogc2VyaWFsQDEyYzFhMDAwIHsNCj4gPj4+ICsJCQljb21wYXRp
YmxlID0gIm5zMTY1NTBhIjsNCj4gPj4+ICsJCQlyZWcgPSA8MHgwIDB4MTJjMWEwMDAgMHgxMDAw
PjsNCj4gPj4+ICsJCQljbG9ja3MgPSA8JnN5c2NvbjAgU0NVMF9DTEtfR0FURV9VQVJUNENMSz47
DQo+ID4+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDggSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ID4+PiArCQkJcmVnLXNoaWZ0ID0gPDI+Ow0KPiA+Pj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+ID4+PiArCQl9Ow0KPiA+Pj4gKwl9Ow0KPiA+Pj4gKw0KPiA+Pj4gKwlzb2MxOiBzb2NA
MTQwMDAwMDAgew0KPiA+Pj4gKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPj4+ICsJ
CXJlZyA9IDwweDAgMHgxNDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gPj4+ICsJCSNhZGRyZXNzLWNl
bGxzID0gPDI+Ow0KPiA+Pj4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4+PiArCQlyYW5nZXM7
DQo+ID4+PiArDQo+ID4+PiArCQlzeXNjb24xOiBzeXNjb25AMTRjMDIwMDAgew0KPiA+Pj4gKwkJ
CWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI3MDAtc2N1MSIsICJzeXNjb24iLA0KPiAic2ltcGxl
LW1mZCI7DQo+ID4+PiArCQkJcmVnID0gPDB4MCAweDE0YzAyMDAwIDB4MTAwMD47DQo+ID4+PiAr
CQkJcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MTRjMDIwMDAgMHgxMDAwPjsNCj4gPj4+ICsJCQkj
YWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPj4+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPj4+
ICsJCQkjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4+PiArCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0K
PiA+Pj4gKwkJfTsNCj4gPj4+ICsNCj4gPj4+ICsJCXNlcmlhbDEyOiBzZXJpYWxAMTRjMzNiMDAg
ew0KPiA+Pj4gKwkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEiOw0KPiA+Pj4gKwkJCXJlZyA9IDww
eDAgMHgxNGMzM2IwMCAweDEwMD47DQo+ID4+PiArCQkJY2xvY2tzID0gPCZzeXNjb24xIFNDVTFf
Q0xLX0dBVEVfVUFSVDEyQ0xLPjsNCj4gPj4+ICsJCQlpbnRlcnJ1cHRzLWV4dGVuZGVkID0NCj4g
Pj4+ICsJCQkJPCZpbnRjMV80IDE4IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gPj4gSVJR
X1RZUEVfTEVWRUxfSElHSCk+Ow0KPiA+Pj4gKwkJCXJlZy1zaGlmdCA9IDwyPjsNCj4gPj4+ICsJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+Pj4gKwkJfTsNCj4gPj4+ICsJfTsNCj4gPj4+ICt9
Ow0KPiA+Pj4gKw0KPiA+Pj4gKyZzb2MwIHsNCj4gPj4NCj4gPj4gVGhpcyBpcyB0aGUgYmFzZSBE
VFNJLCB0aGVyZSBpcyBubyBleGlzdGluZyBub2RlIHRvIG92ZXJyaWRlLiBKdXN0DQo+ID4+IGRl
ZmluZSBjb21wbGV0ZSBTb0Mgbm9kZSBpbiBvbmUgcGxhY2UgbGlrZSBldmVyeSBvdGhlciB2ZW5k
b3IuDQo+ID4NCj4gPiBNeSBvcmlnaW5hbCBpcyB1c2UgdGhpcyB3YXksIGJ1dCB3aGVuIEkgZG8g
Y2hlY2twYXRjaCwgZ2V0DQo+ID4gQ0hFQ0s6IGxpbmUgbGVuZ3RoIG9mIDEwNiBleGNlZWRzIDEw
MCBjb2x1bW5zLg0KPiA+IGludGVycnVwdHMgPSA8R0lDX1NQSSAxOTIgKEdJQ19DUFVfTUFTS19T
SU1QTEUoNCkgfA0KPiA+IElSUV9UWVBFX0xFVkVMX0hJR0gpPiwgVGhhdCB0aGUgcmVhc29uIG1v
ZGlmeSBieSB0aGlzIHdheS4NCj4gDQo+IExvb2sgaG93IG90aGVyIHJlY2VudCwgbW9zdCBkZXZl
bG9wZWQgcGxhdGZvcm1zIGRvIGl0IGFuZCBsZWFybiBmcm9tIHRoZW0NCj4gaW5zdGVhZCBvZiBj
b21pbmcgd2l0aCBvd24sIGNvbmZ1c2luZyBzdHlsZS4NCg0KVGhhbmtzLCBJIHdpbGwgcmVmZXIg
dGhpcyB0byBtb2RpZnkuDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9t
YXN0ZXIvYXJjaC9hcm02NC9ib290L2R0cy9icm9hZGNvbS9iY20yNzEyLmR0c2kjTDU4MC1MNTg5
DQo+IA0KPiA+DQo+ID4+DQo+ID4+DQo+ID4+PiArCWludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxl
ckAxMjEwMDAwMCB7DQo+ID4+PiArCQljb21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KPiA+Pg0K
PiA+PiBOQUssIG5ldmVyIHRlc3RlZC4NCj4gPj4NCj4gPj4gTm90IGFsbG93ZWQsIHNlZSBiaW5k
aW5ncy4gQW5kIHRlc3QgaXQgbmV4dCB0aW1lLg0KPiA+DQo+ID4gR290IGl0LCB3aWxsIHVwZGF0
ZSBieSBmb2xsb3dpbmcuDQo+ID4gSW50YzA6IGJ1c0AxMjEwMDAwMCB7DQo+ID4gICAgICAgICBj
b21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiA+ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
Mj47DQo+ID4gICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiAgICAgICAgIHJlZyA9IDww
IDB4MTIxMDAwMDAgMHg0MDAwPjsNCj4gPiAJCXJhbmdlcyA9IDwweDAgMHgwIDB4MCAweDEyMTAw
MDAwIDB4NDAwMD47DQo+ID4gCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gDQo+IERvZXMgbm90
IGZvbGxvdyBEVFMgY29kaW5nIHN0eWxlIGFuZCBhbnl3YXksIHdoYXQgc29ydCBvZiBidXMgaXMg
dGhpcz8NCg0KU29ycnksIGZvciBtaXNzLWxlYWQuIGludGMwIGlzIGxpa2UgdGhlIGdsb2JhbCBi
YXNlIGZvciBpbnRlMF8xMSBpbnRlcnJ1cHQtY29udHJvbGxlci4gDQpTbywgSSB1c2Ugc2ltcGxl
LW1mZC4gDQogICAgICAgaW50YzA6IGludGVycnVwdC1jb250cm9sbGVyQDEyMTAwMDAwIHsNCiAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KCQkJCQkuLi4uLg0KICAg
ICAgICAgICAgICAgIGludGMwXzExOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxYjAwIHsNCgkJCQkJ
Li4uLi4uDQogICAgICAgICAgICAgICAgfTsNCiAgICAgICAgfTsNCg0KQnV0IEkgZG9uJ3Qga25v
dyB5b3VyIHByZXZpb3VzICJOQUssIG5ldmVyIHRlc3RlZCIgbWVhbi4NCkkgZGlkIG1ha2UgQ0hF
Q0tfRFRCUz15IGFyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkLyBkb24ndCBzZWUgdGhlIGZhaWwg
d2l0aA0KaW50YzA6IGludGVycnVwdC1jb250cm9sbGVyQDEyMTAwMDAwIHsNCgljb21wYXRpYmxl
ID0gInNpbXBsZS1tZmQiOw0KDQpTbywgY291bGQgeW91IHBvaW50IG1lIG1vcmUgdGVzdCBpbnN0
cnVjdGlvbiBmb3IgdGhpcz8gDQoNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg==

