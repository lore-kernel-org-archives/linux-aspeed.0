Return-Path: <linux-aspeed+bounces-606-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3C2C02193
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 06:16:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymbpt29HWz2xm5;
	Mon,  3 Feb 2025 17:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738563366;
	cv=pass; b=Jwrk3cVr0EuOFXLirZAr1enUfSdTjflaouk5IJdAS/VPm89WIvzY6K/W44yJm5siIKJ5LweZyoobC8wpr36Sfw1rWy2W1BI16FNDidaKqCIhaNQbLzhc+yV2ZtLa1/3qKIs3K+pKtLYsiVlLI5SJnF/3z0U/9uHSFuI7L80LS7XZyMzLdXqD9y7IbGW5Vf7U7XxcLMhXaW7RMTbwFvKtx/tw2k65Yndc8fJMLVRUpGVUyBG9E7yvijfAjAFf3ZjWAE8a+XeKeHdf+Iz8d0vB0MivG+3YSfwRGqayjt9HSxOTYO68qyIsNQtuuIlWW/B9VJFFWBpZ/b8K5MTpgh/KSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738563366; c=relaxed/relaxed;
	bh=JtQDa9kS8bBy/Akk6gw9SAnC+3snmsO6LSGUvqGBaC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAsZ4kQOoQWgro7D+ipGlT30zYwal2C/fzG2gWCjb7pUhmjkiI1ZPrSwfcVysfKn32GzO+xV5BclAv+ojrobMqDw8i32H36Blpa8Dy+FDInqR54MbZgiw43aw1JZ9pZ9me54v2ogrHNZHdSiOqb/mx5/8GEEkPiuZ/ZkOZK/lN+hcvHQW2R9aozllC6kQxOSda6BDvDclxj+rrjb1nFc5EGCOFH0nMry0IU29phKELzKJAtMDRA4AwqOXRgACqaE0CdMF09T85mF8h+32WqyaQdAH14l4iZTANfCKDnr/Y7OEFQkP0UN4L4uZ3xEv9DYaroUu9/EM+tnTCT2BfqXEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymbpb3sMpz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 17:15:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4p1oLdrz51gtdaTOacPvkju8T86cy6cksVSEpdmgb8N98MIuDhfZiqdnCI6NacWBAwHgh1QKFvLvcZUGkfjU96SWVSAWGrISg7b9xYNLbTlUIo/mk5bbZDIpWODNK4tNSdX+AnXg6OLlHPLz0Gbd6JtfcOAE8KyUMIvxImJM6oVBd3UZclOqmw76qpc4wD2R6WCopaP2m7gikpEcZhEewsfp60NnmtO+VvmdKoxfh4+UNhACOkZlHXJWh5A12Ws2KeC/8Os4g8chSGMA/ny6OGC5LXUlYkHVmH8eg8xm8HuPGso7sk04uZ+fnEJyMfiw0D4+4VX4Ln7+vc5fGL3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtQDa9kS8bBy/Akk6gw9SAnC+3snmsO6LSGUvqGBaC8=;
 b=lyJtu0zxCJLAnFIkW6HzBmxvbgs7JGoOOMduaRGygFBiY53YgMpBlcZMKUrByY9QVekQov5ILHTO25AmdletUYbhiNpTy7kO/nGxzD1UHiKNgFacPzo00l0eEw2o88worm0Yf+pohLV1ckuyOnjb3LLJhjKNc2s2Gt4m0K790HbcEgbr2cxyALV8c8JVy8Ercax9Sw2sngaMmqpr/gFQ/bo2cshePNGIRUBK/MXoHmeLwmWFrVwjXjQ0xOt0EiAqMWWkO0ijTu6AE/f8QmIDXXuTa0u6o+qGnYEvNMVnBQtkJlI9k4/RDHMJNOnq+DArBCTvYXgNA/Qot0ra5ZDMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtQDa9kS8bBy/Akk6gw9SAnC+3snmsO6LSGUvqGBaC8=;
 b=ROyaFfAgGuQPzKpx038lNXC+MknfOF4ArMA0C18pMGkMJJS/Bm3ySCCYCYRImBgi4nwo+wYeu3zHWxGp2QENrLtI2dQjrAhXa1TLMiKSExYuxbDFPUpumaI0w4RATBwaVa+A0KmRXk0vITD0Pyb+IbIAfh8J80dht/zh11C5o/hiMQnjh7PUBmzlHqjaCuVebbQr+oM8CJ2cWpCJZ5PU+0PtnTPV0m3DrmHjcHqgoR4v9JJ6QINIplZdAykDyG2IZnMYHarUzovFUltXCjbMv8oc5qz0fv8DRMrf16njfNMlHO0T/VaZMFJwY2xEHbLqeObYoP43rptMaofdB/JrmQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB5965.apcprd06.prod.outlook.com (2603:1096:101:ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 06:14:58 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 06:14:58 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "dmitry.baryshkov@linaro.org"
	<dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
Subject: RE: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed: support for
 AST2700
Thread-Topic: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed: support for
 AST2700
Thread-Index: AQHbJSo35P/BmRLgIU6SdF4s0TdcdrKip1gAgI4zhZCABLVoAIAAKxXA
Date: Mon, 3 Feb 2025 06:14:58 +0000
Message-ID:
 <OS8PR06MB754136502BC5EE774ACC557CF2F52@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241023090153.1395220-1-ryan_chen@aspeedtech.com>
	 <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
	 <173047754439.1930424.6922132618537420144.b4-ty@kernel.org>
	 <OS8PR06MB75417CF1E84556D1492EADF4F2E82@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <df21af9083a189bf9d2598ee4658f9e45fcdde5f.camel@codeconstruct.com.au>
In-Reply-To:
 <df21af9083a189bf9d2598ee4658f9e45fcdde5f.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB5965:EE_
x-ms-office365-filtering-correlation-id: 7a8dd990-e12f-4ad9-68ca-08dd441a15bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWpObHBxWFhlbHpqZ2NhYW5xMkJIdGVsZjBzSnNFWlVNeG4vY2VaNlNacWVO?=
 =?utf-8?B?NnpaaGdRejlpVTM0RDdiS0VzZ0lQWVpzcmx5MXYzSW1mNGRvODBTTWVwaHoz?=
 =?utf-8?B?NGVmQVZIYlVvSDVwYzkraTdCQWMrNEk0Q1lvUElKaE5nYnBBaXVVcjVCVkx3?=
 =?utf-8?B?bGxaWDJQcVozOWtQdHhJbURSOVhLNDBsQWtDMWN2WUJSTHZ4aWJjcWc3OWV6?=
 =?utf-8?B?STlGYkNnZTZ0aDZ5T2hZUG9ZQTdUQjRCT1hhbHN0aThBUm9VMnpzb1h1RjRw?=
 =?utf-8?B?UjliOGtobWZzTkdTWHFlelRhMUQzL0IzM0UwWjM1R3ViZWJaeTRKcWNSbTd5?=
 =?utf-8?B?clQxSW8vaVhFakZTcFdYYlRNNFh1UFJXdUFMaEgzM1phejh0WjJNOUxkMzJK?=
 =?utf-8?B?dk5CQzZLeE5IdkxPOEwvMThVVk5zUDFTMEhLYmdmRDBuY0hmVmNncFpaVzVZ?=
 =?utf-8?B?QlA1TXFVK0N2ZXByQzdEd0JNUXZKNkEvR1hBUlZwN2RtbjdHZGh2ekFNU21p?=
 =?utf-8?B?bVZ2UkVOUVNwa3BCRkw1NnNqWjdxYStVWTFUL2psNjZyd0pvSHMyZnVLdU8x?=
 =?utf-8?B?M1dDMGpRUUp5QVRiN2ZGMTkya08wODJzbzdYNG1QNUs5NitJT3gzcVQva3ZN?=
 =?utf-8?B?UVVDN1NzZW0yN3h5T1dZbS8xVXViamtnUXVIQ0J2dzVLQjF4K1FCczFLY2c3?=
 =?utf-8?B?VDZxOEhvRk13dXp0NDJhOHREblV6KzJDZ3kza20xTndORVp0U3Vsa29uay9i?=
 =?utf-8?B?d0I5SE91SlcvOW1sVFYxNVI5aUR6Y0RaY1JUSFVocjdHWTlrWGNFMmQvQWVH?=
 =?utf-8?B?eEh4S3hDdkUwY29NN2RpSkFGNWlyblBSSjNOMHUzNlM3SUNlTEoxSWxYZ0FO?=
 =?utf-8?B?SDVPSld4V3plMU5MOWNYUmowdEd0LzdUSGpreXN6a3VsM25pZHNUeGRROEo5?=
 =?utf-8?B?aG1lanJ0OVlHVjYyOXh3U3dYa2RJNUttM2ZsQTdpNTBId01rZEc5aTUrNDVz?=
 =?utf-8?B?V0V2ZlQ4U0s5ZDBIUnR5UnVTRjNReHZrZGtHVmZQbVc0dHpuREMrMTZmWVlI?=
 =?utf-8?B?TXFGZ3VjUmlzb09yZk1aSzVTSEwvaHFFcEE5WG16bFdab2IvQWtPT2JMcVJQ?=
 =?utf-8?B?Z0NXb3JRMTl2Z0hRWldsVGRkMzJTZUlCbzJxWm5TdGM5b1ZVVEJhcnFBa2Ju?=
 =?utf-8?B?blZKaGJORlQzblFxL2JEdXNPVDVvSmFGR0RxcmhtRDV5VmxHaGxaNmVvWnc5?=
 =?utf-8?B?bGFLSHdneW1PdFdiWWhLMFVUNDc4bGZCSjF1T2g4dGVxZEtxL3ZsbjR1WG1r?=
 =?utf-8?B?QTJKMTdZZWlWVXFiekFxbWJmVCs0K1NVNmZJaWpjaEpRSUl2QmxHWkhjTmZy?=
 =?utf-8?B?RzhlSlRSOTl0ZTRLZHMwYXZSeVNWbE1DQTV5UUtJaXdSOCtpUDRzTmFFeVFG?=
 =?utf-8?B?ZzVKQlFIM2JzYlFZR0NxOVgzTHFUR3NWcXV2V3VBS3pxbFU3U1dlYUIvdGFr?=
 =?utf-8?B?Q1hZWFhmS0V5cUtSRUZjWG9jSVR6c0pXcGhENUt2a1QwTzNpRENmVGNHZ1ll?=
 =?utf-8?B?cUxjdjJwRUNITThMek1ZU3paekZleDRLOStrQjg0d2JJYVB4R0NoUXIzZDlq?=
 =?utf-8?B?empQVFl1R0ErMmFBeDdNOXBBaXBxa1Y4ODdjZGRsdm5nVWRFNEFockxpckIv?=
 =?utf-8?B?bkpGKzhwVG8rKysyeGRmQ3h4YU1JNTF3czlpSG00MkxzdWpobXduZFJnN1dp?=
 =?utf-8?B?Rll1dWM0aEVTUS9MZ25oendiWHl1U0g5N3pWby94WUU0TGZTYVh5R25Tc2Z6?=
 =?utf-8?B?ZUEzc05BNU1uT1hLUHBMSGFZY3RNRUdrMnVXdC9SL3RZWDJ1UXdtWWNVRHl0?=
 =?utf-8?B?ZHpHMVphdkhROUh1aUdXN3ZhOFFFUk1vZng5MWtLRnA3MVFERjdJZHRzRUVT?=
 =?utf-8?B?eFR6VlJueC9XSjJjZ3l4QmJnSk1qWWxSRGM1QVVnYXhxWHRiU1FRdnZVYkM3?=
 =?utf-8?B?WXJwRHhacWxBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkJITWRuMXNRTUlyTlFSS3JCeE1nZWJrVHN0UXVuclZ4MlhpMUVqcFNjUTdy?=
 =?utf-8?B?ZVgwc2hMdU5aL05ndHUvV1hlcHhVVGpzUS8vVDZlbGJVM3ozRDBGSFNwb1I1?=
 =?utf-8?B?Y0k0aVRFMWN0d3VOT2cvWlR3NEVvVkpMUkt4clBmQ0V4Nm14T05TQXBHbjVk?=
 =?utf-8?B?Q0JpWkZ1dTNhZ1NNQ1I5YTY3MlZlTzlGK1dNeEcwSnpQWTFmUUJDdDNXTHRw?=
 =?utf-8?B?ZG1qN3VnVG91YzdQT2J3b21qNU11bU1DeXAzaEFST0pOQXlUVDR0Qm9UR0tx?=
 =?utf-8?B?ZVdLYzlDUEp6Y0M5MFI0K2RuRkN6Vlp1TWJ0WngvMU1nemtHM09kZGxzWGRO?=
 =?utf-8?B?alVuUy8rd0tIQ2ZCTmVEZjdxeXFsZHdqRDk5ZGJHZ0gvRG5SVVorc0VmY2JC?=
 =?utf-8?B?N3VCdzBxUUlnbU53a2hkUTI5eDdoZzR1QTNyNlJSTFpLWFVPZ21wNEhqSXgy?=
 =?utf-8?B?V01jYW1oKy9NRVZWZFY2cEE0aGN1UXhDUFE1T2FuMThMV1JrL2hDTmVKNGhz?=
 =?utf-8?B?SUFMbXI4QlNMd2lwNkI0RDFUMXFRMW9jbC9sZ1dkQWljSEo5YS93akpVajky?=
 =?utf-8?B?ZThmWWFwNnIyYUdFRnovQ1c3dm80UWxWT1NKU0dtN1ZqRTBkd0xENnlrcG1x?=
 =?utf-8?B?THdYZWJ3WVh3eHpaRmxuT3BrdjlDUndpMVUvMm1xSDlHOU1NQm1Sem90alZU?=
 =?utf-8?B?ak1ITk1ha2ZZK0x1RWNUY3BmRy96cVBpYS9tRjQ1YkxKR2hvcjFRSk4wUTQw?=
 =?utf-8?B?SmQ1N1UyemVPRmE4bUVaRi9mS2kyeFlhMTM0ZUFHQnhrMDVkQ1owbmloeDJs?=
 =?utf-8?B?ZjJvNHY4K0tUbWNwNTIzZG9jY2pvd3RDWHEyTHF0ZnVCM2FFUi9MTUwwZzRh?=
 =?utf-8?B?cHVER2hLY0RPb2R4dzM3NjJ0WnlCdDNEb0Nnd1VDMjhqeVNsRE80NnZNdDZC?=
 =?utf-8?B?OUtBY0NQQnQzOEVGN053L2UyOWR1VzZkSlBMZjRPdU4rd09lQmM3UEVZYlYr?=
 =?utf-8?B?d3BPeDJVd3lQdXVobjdHVGM3ZC84QU9obHJSMlFVeHZGWk9QdG1VUW1jWklW?=
 =?utf-8?B?Y1l6U25sNkVOZk1sZUF1enF1TmNReVI1Y2lJTGF3NW9ncGNNOGFybEcyeFdQ?=
 =?utf-8?B?eDArMG5HakFzb25tQ0hwNnhPL2I3UWhUWUVNdnBKKzJnM2MzcStaU2xVZmZD?=
 =?utf-8?B?OVFTR1p6NHNmSllpNDJ1di8wdnhvOEdtc3BGbkovWVJwV2tCcTcrK3NpSS8r?=
 =?utf-8?B?N1hDYk5XYzF2bXNocFpzTjFycjQzVkJwN3pyTEVMU3dYNnJlZ01WbkJ0WXlv?=
 =?utf-8?B?d1BEeUQ3Q0hmTXRCc1Yzc3lra3FmcEJJcThGYUZ5U09VampvVUVZd2F4ODcz?=
 =?utf-8?B?Uis0bGtXbXNvTzdtSk9oVUVLRCt6ZDMweHB1TUhheis2YStaZ2RHeFRNUG84?=
 =?utf-8?B?S0lyRkY1NWZOR1BCMm5iZ2hhUFMyckhWY3FwM0ZqSlRrbjRBYWkvRnF1UWhY?=
 =?utf-8?B?c0c3WCs0WHBGWTVnT04wdFVMejhhWEY0dUM3QVAxR1lyY0hkUTh4cFRPVGxN?=
 =?utf-8?B?Q0QwY2thYTlZTmlyYkhqVUI4RS94b2o5ckVtMnF2RjVmYW5IWnpJRUUwaTB6?=
 =?utf-8?B?RHFId09tbDMrVHkyZFFtRmZkMkZvQTZQS210KzFMOVFqcTFrMEthekR1NzdQ?=
 =?utf-8?B?SVhOYUoxOVl0cHd5UWlLU3RGSmNuYlNTenhOS2Y5Q0RPV0hkcnVsZkdmQmhr?=
 =?utf-8?B?ZTN2OXg1Rk4zcE0raG10WmtsaE5wSGxhbmluQmtKMU9USDh3VUJ3Um9MOWJ5?=
 =?utf-8?B?SU43R29rTXZCdUtIVzZoaWR1TWwrUVZIbUcvU1UwbmhkZWE5WVRYdUFiaTYy?=
 =?utf-8?B?M1I1MFdiNXJ2bUplcXhibnNlekM0MWcvSVNFWmVJY2JPMHpPRDFSdDlHWStP?=
 =?utf-8?B?QWdMNGZiU2MyOFJIeWVUMVN0cWQxejZrR0RxcnNpMndDak4xQ2V5bXphQ2VN?=
 =?utf-8?B?OHpsdkhLVG5aRGJOZWpvM1p5ZUttS1lKM21RRGpJL2oxMmtRTmgzeTExK2ph?=
 =?utf-8?B?MkJSR0FvSnY5OEhKZGpaMFFON0Y0NzNlemZLS09rQmdhRytRZm5wQzFHVWVq?=
 =?utf-8?Q?J9ABoXfrkRvOjW3RG2X7pjUqT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8dd990-e12f-4ad9-68ca-08dd441a15bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 06:14:58.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4urcRn6m4u33MEWaHBT/jyN0CS3aUvtL0DxoAbkFvApmgZu9JNPdnYFeYcifVNz7IUuCJnBkzJ5oNSutTR69sdNBoAgy2oiDbDYlv+VJX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5965

PiBTdWJqZWN0OiBSZTogKHN1YnNldCkgW1BBVENIIHY2IDEvM10gZHQtYmluZGluZ3M6IG1mZDog
YXNwZWVkOiBzdXBwb3J0IGZvcg0KPiBBU1QyNzAwDQo+IA0KPiBIaSBSeWFuLA0KPiANCj4gT24g
RnJpLCAyMDI1LTAxLTMxIGF0IDAzOjUxICswMDAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTGVlIEpvbmVzIDxsZWVAa2Vy
bmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAyLCAyMDI0IDEyOjEyIEFN
DQo+ID4gPiBUbzogbGVlQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJu
ZWwub3JnOw0KPiA+ID4gY29ub3IrZHRAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJl
d0Bjb2RlY29uc3RydWN0LmNvbS5hdTsNCj4gPiA+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBz
Ym95ZEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gPiA+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZG1pdHJ5LmJhcnlz
aGtvdkBsaW5hcm8ub3JnOyBSeWFuIENoZW4NCj4gPiA+IDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+
ID4gU3ViamVjdDogUmU6IChzdWJzZXQpIFtQQVRDSCB2NiAxLzNdIGR0LWJpbmRpbmdzOiBtZmQ6
IGFzcGVlZDoNCj4gPiA+IHN1cHBvcnQgZm9yDQo+ID4gPiBBU1QyNzAwDQo+ID4gPg0KPiA+ID4g
T24gV2VkLCAyMyBPY3QgMjAyNCAxNzowMTo1MSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+
ID4gPiBBZGQgcmVzZXQsIGNsayBkdCBiaW5kaW5ncyBoZWFkZXJzLCBhbmQgdXBkYXRlIGNvbXBh
dGlibGUgc3VwcG9ydA0KPiA+ID4gPiBmb3INCj4gPiA+ID4gQVNUMjcwMCBjbGssIHNpbGljb24t
aWQgaW4geWFtbC4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBBcHBsaWVkLCB0aGFu
a3MhDQo+ID4gPg0KPiA+ID4gWzEvM10gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBwb3J0
IGZvciBBU1QyNzAwDQo+ID4gPiDCoMKgwqDCoMKgIGNvbW1pdDogNzZjNjIxN2MzMTI2NmU4MDBi
NjdhNDc2YmJhNTlkZmViOTg1OGE5MA0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBMZWUgSm9uZXMg
W+adjueQvOaWr10NCj4gPg0KPiA+IEhlbGxvLA0KPiA+IFNpbmNlIHRoaXMgcGF0Y2ggaGF2ZSBi
ZWVuIGFwcGxpZWQsIGlmIEkgc3RpbGwgd2FudCBtb2RpZnkgSSB3aWxsIGRvDQo+ID4gdGhlIHJl
YmFzZSBhbmQgc3RpbGwgcGF0Y2ggYmFzZSBvbiB0aGlzLg0KPiA+IEFtIEkgcmlnaHQ/DQo+ID4N
Cj4gPiBGb3IgZXhhbXBsZSBJIHdhbnQgdG8gbW9kaWZ5IGluY2x1ZGUvZHQtDQo+ID4gYmluZGlu
Z3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtc2N1LmgNCj4gPiBJIHNlbmQgdGhlIHBhdGNodjggWzEv
M10gcGF0Y2ggZm9yIGFzcGVlZCxhc3QyNzAwLXNjdS5oIE90aGVycyBbMi8zXSwNCj4gPiBbMy8z
XSBzdGlsbCBwcm9ncmVzcywgYW0gSSByaWdodD8NCj4gDQo+IEknZCByZWJhc2UgdGhlIHNlcmll
cyBvbiB0b3Agb2YgdjYuMTQtcmMxIGFuZCBjb250aW51ZSBpbmNyZW1lbnRpbmcgdGhlIHNlcmll
cw0KPiB2ZXJzaW9uLiBZb3UndmUgcmVwbGllZCB0byB2NiBoZXJlLCBidXQgSSBzZWUgdjcgYXQg
WzFdLCBzbyBJIGd1ZXNzIHY4IGFzIHlvdQ0KPiBzdWdnZXN0Pw0KWWVzLCBJIGFtIGdvaW5nIHRv
IHByb2dyZXNzIHY4LiBUaGFuayB5b3VyIGFkdmljZS4gDQo+IA0KPiBbMV06DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAyODA1MzAxOC4yNTc5MjAwLTEtcnlhbl9jaGVuQGFz
cGVlZHRlYw0KPiBoLmNvbS8NCj4gDQo+IEFuZHJldw0K

