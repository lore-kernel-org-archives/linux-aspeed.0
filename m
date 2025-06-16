Return-Path: <linux-aspeed+bounces-1469-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E0DC71136
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 08:08:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLN0n2FDNz2xfB;
	Mon, 16 Jun 2025 18:08:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750061289;
	cv=pass; b=j9t66KjlEt2UoG57juZ3dfndrCpe0VsrY+OJfjVpQUlKqYPeYS5cGQi0eZqDd9W5+mZLqc0PgjqKm6rLuzuMo3EhiABL1Bb9CjCQgvwMKNPv9WdkYzW0w8t+CLzl8vX0SYwttQgUGF3xEYmDmm7+o8mfhVeoqS2xYxK0dQTqKzA0Jk+inE/SBF2LbcPKlAoCjHEVjqY/9hP93/0W5SEcLP2BM/wf3bUEWzKnID3DrGQcm9z3A+s1Pv//zCMyQH07jaTChizg890F6d7+G+fyYsoSSaHPx6qhLZYZ5yIlqCcixlQlmdod2+iuFd70UdjstiiJFScjlyKiu1KHpPpB7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750061289; c=relaxed/relaxed;
	bh=J3gQ77/CIH5OxpPytd84pxniUcl9vxL4gKnQlyV+U+k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kT9kTsnxc/U9gqi57/RnknNbuU4Z8gsD2FMSK+ka5dRbrOYLK4HMaZUD0s8RpET9xrK1YbLvLg5e2JY2zPmMjG9ec8MBl4TZpGb616L7voV7PExlWkegc79j3pQydZNvZJL7aEy/Yse5pbn5uGg/maCvFYkSLLBLG06+OaoFZEKMkxfQ6QDnhtLnCVI1d/zzStqIUwpEAcKx6vaXBmcpIP/2vFKc4iy/ORTZObbaeTilaTOKVO8ZCRluGjjZ2YAxoGNAa3EJ9USyFlbIPSbKfcfeg/D+p8zMO7jdAsNZqE6j1yFxpR0lP40jvRkWUd0gZeGCvxwWZi8ivYryp++/kA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLN0G3kRDz2xHv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 18:07:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEO2ZZ7wJXI7rRoTDR8TTLbMAxVLVR58wKmOFffhTJj5DLz24xrmL0RB6UvITHdO+pwptZ03KOSeW9xj6SeHa3y2JpE5lIip4RzPkvWD2f8kOEhFJ6q4JfZwTCZjEVzylZQ+xXnctxQJi8fNtaonTDFHImh8XZ6iqozPitSIDhZ9iGOtO4G+zXjs3r7UmAO0Z7kJdrpQKyIYcUl29ru0XToNyBnw3fW87zis2sUPZ+TODXj0Vhw5kJlJNXgJX2N5GJ3fd0Xwxs2tORyYoRSj8FfjQjSjtaIo/hmTkgD5lca3M9/EPhhRpmyZHXyQAZuApPmvkROldOq7qXjOEStpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3gQ77/CIH5OxpPytd84pxniUcl9vxL4gKnQlyV+U+k=;
 b=d/OxVxAsNXTShnPdpcfR2xtcjUP+wW9xMVCHcnAQDaBv3m9QrTCc6824dh1pHDWZa/aW2C8A0cyBh2cCtkSbMD4ui4KFxO8cnTBod8m9Qsyz5Uw65aK2kw9hxhXC8YSqw96CfiVisWbCSekXJljpH7/HkIxngcud855/c9BcuRVVTiHhR7PjeyClkW2ts1WyFuJVBhbuh+81AxvI5Mwe123z9srmuXPuEytdzFC4BlukBpm+h2co6tYdJ3Z1pftxDB2bmSaxUSyS1QJEL/EaLb16WmsRmz2BZwQ4Ipeut8r3vWtW693qZ3Hzla5N4PudnCWFjNQfQUS0LznF4+tKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3gQ77/CIH5OxpPytd84pxniUcl9vxL4gKnQlyV+U+k=;
 b=myNcHJiIrsxMI1oF270xWa4ZOQwuGfY9ScQY87Kn8blz4Ly7hWjvoIbDZzqYf77vzFb0oinrYtTuBGYCzwUU5isEJKt4g2weUVXLjwktjgHKtZAo6JmwvIv5V5LbSXOb5TNcUdGl3vI9sZL7jqYN3wapWKUXAHCf/v9S1m4p+M76kg9yAcStfB8Yak/F9Kxva9Tg70obOeJRao4uQ/PZH8TEE56ZoMWcNNVDWOCP6cjA71XUVsVQlPcwIe9Xbvvd85vAm2J2WbiYrcMTGtMpaQrpHasxFSQgwLO312SmsyiChlwSuHK5JCfEAWQrtrKcnDq50Vet4Li7qmEZ+YZ3gg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6747.apcprd06.prod.outlook.com (2603:1096:400:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:52:16 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:52:16 +0000
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
Thread-Index:
 AQHb24IeM0HrrMksj0qjPEmThyghWrP/T4SAgAEHZPCAAEdfgIAEbCrggABKjgCAAAPQYIAAA/oAgAAAqeCAAAYOAIAACEKg
Date: Mon, 16 Jun 2025 07:52:16 +0000
Message-ID:
 <OS8PR06MB754181823BC03DADBF0A9B82F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
 <OS8PR06MB7541A100B918AAA84D1ABDCAF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <749c581e-cc00-428f-8eb9-222f9d574486@kernel.org>
 <OS8PR06MB7541FFCA9E28E5767791D869F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e39b5259-db92-4269-84c9-d51e8e4f327e@kernel.org>
 <OS8PR06MB7541645F6A0638FC250B1272F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <a2ca2f58-f648-43f9-8d23-4111e4eb1f1d@kernel.org>
 <OS8PR06MB75412D391E7D10958E70C100F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e623aad6-726b-405e-be94-25f188749349@kernel.org>
In-Reply-To: <e623aad6-726b-405e-be94-25f188749349@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6747:EE_
x-ms-office365-filtering-correlation-id: 6407ef0f-736e-4aa2-7a25-08ddacaab668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXhuNVMzSG9EekxKNDhmZzVPTTN0eS92RUFGdlpmYURLVmlGVmRWZ3M2bkVV?=
 =?utf-8?B?R3dwQ01HKzRIREYxdU5UelZGQTF5Vzh1K1FFU1VCL2tsZmU4bHlySkZwNDhP?=
 =?utf-8?B?TmcyTWNwa0E1WkRjNFdkdVhQMWxPeFJvZ0hrYmpxdGJ6K1NCdjhsZDJSUzlL?=
 =?utf-8?B?YWVucmJKT0xYS3pkYlh4dmlOUGdGYlFwdTV3Q3ZUdDZXQTlBY1o0ZWh1Uzh6?=
 =?utf-8?B?WU5nZ094c0h4TzJycjhrWTQvbVFTRFJFTzJRc0o5NmVMdWVQZ3prUWpxVlZP?=
 =?utf-8?B?cUpOUnVzWXMrY3o4b3A5NUNrWUlLYlRQMWI4VXNrcVU3Vzk5bTE1VkM2SjFB?=
 =?utf-8?B?MUlrYmNwdkhpTjkrQkNrcVZRek5hRERBekljUnRjcFBsT2dsOUVXcXVIcHNU?=
 =?utf-8?B?VS8xcEUybWFackl1UlpjZE1Oc0pPKzBGYmZEdGczdGJJK3l3RFdQYXBTRVJQ?=
 =?utf-8?B?d1hBZDBvRitQZ1BjU3ZpUVpyQllLZG9SN2w2WWhxY2xqeVFXdHBRVEN6WWt4?=
 =?utf-8?B?VlVnT3pFc3hTYVZ2SndTS0F3bUJYSTVUekRxUkxSb2JhV0JmSWJNdEkzRWli?=
 =?utf-8?B?K3F3dkxvc1FsSGo0RmV0bWNFdWlHQjQwRWtQQlk1NEo0eDQ4dXZkNWpoN2Mx?=
 =?utf-8?B?c2NpdGE2d0lZYWlZOVNPcGVyekRENHlUZEpnLzVpWWZ5N2ZGMXgyLy9va2NI?=
 =?utf-8?B?M1N3N1d5c3l4Q3NmRTdEQkloYjZUMllTQVhqSHNIemdva1ppQU9Hd0ZBcGZB?=
 =?utf-8?B?OGJuS2phUHVNVm5TQkY0ekpoWEgrM3RBT3lpR2JOcThSRmUwWUFkYTNTak03?=
 =?utf-8?B?WWdnUzBuZUozMEpBalNNVldxZ0tqQlJvcEE2d2cxVlpyRnkyd1VYWGFpMjl2?=
 =?utf-8?B?WElYTEtUU1ViWUZwYmczaWNZZllTbmJVSHZ3MXRpNjhOS0pqdFdmQmdncURi?=
 =?utf-8?B?NmEvMzFZTTlQN1hMMkV2WDI2dkJTWHV2eSs5RXpmbmplUDhLWm91Zi9uMVB4?=
 =?utf-8?B?NFdEYTZaeWRvZXl1aUlISTFsbDM1YjV6c2xIMUIreHNuYzhOZUpyRFo2TE1t?=
 =?utf-8?B?Z2lCU3lDSWxTcDk0TmgvN0Nvc0FJN3BYd1hiZTlsbjdCYnNTcWJRQStvTjQ0?=
 =?utf-8?B?cGJXQWRNSS80R2ppOHhMOWhNSXNsYlVDaDV1TVoyN2ZRK1htd1c4dUJoaVV1?=
 =?utf-8?B?S2k2SStqeEZzQVZLSDZGNi8wR2xRem1XY0o4NDFXc1JKOG9KRzhyRHRpdWxL?=
 =?utf-8?B?WHVDVnY2NGQ1OXZSR1hKZGpsaFI1b05sQjRVb2lERmFkRGh0YmtqZVA5ZENP?=
 =?utf-8?B?RGZWNFk4ek9MdjRHZW5ubnV2VjJuZmFZVDdCbWpwM3pFcmd4RjVqMlVQUlhO?=
 =?utf-8?B?dWVOazZVUGdkSHZManh2NTBESmlEeDE1RloyMVNWc0UvNW5FcEJzcXB3ajRt?=
 =?utf-8?B?UFlqMFBsY0hLUldQbU8yTnNmRjdHOTE3OUxob1UwY05KUHl6bWJmMDQxMnNT?=
 =?utf-8?B?RnQ0NVUvUFRxdWJwOEdxNHdjVCtTRzZSL3J6RjB4a2FwZzIxRlB6dkMzSFUw?=
 =?utf-8?B?SlBubG83ZkRYUVBKSzF4THMvb0R4eEhESk1LYXpkWWFFOC9vWkhmL2tkWkhP?=
 =?utf-8?B?SUJOT0diUmJ6N2ZVZmlPOXJQZmUxQzI2TDVEeENVOTRmWFNqd2laS3FLcGpQ?=
 =?utf-8?B?Y3ExeTJ1eFR0SnRDcVZRNldpNGxhNWNkZDNDYUN3cnRBcWQ3WE1BWmpLcFdK?=
 =?utf-8?B?eEx1Z0pEVVQxcFRnVGsxaGV4NnNhU3N6TEoxeGJkMitWeGxOcjBhQWNDNHUx?=
 =?utf-8?B?ODBMMUdpb1NCVWhRTmRyQzlIdk4vSGI0M1VndTd1NHJQek9kT3ZicGNSaXZm?=
 =?utf-8?B?em0yNWY4UzRMMHBSU1d0N09hSHBHUVJlNkFpdjhEVzY0M3RyaEZIbW9yOUJY?=
 =?utf-8?Q?KXBjQvxKA0DQ5gD4YVrmZ1UWZxKk6SR3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHR4QVM5Y1RjQlZDVUFQbVk3NEZZajBVZklEZUphVlVLSFByY05uZkR5ZnFJ?=
 =?utf-8?B?ZW9zVHBxQmd0eXpBT3BsSk1RNVNqNHhETm9lTlFvaHlyV3NMM0FialhQN3BQ?=
 =?utf-8?B?bDh2Rm5odkZUc0paZUlGVC9TUDFQUmtQMUgwWEVlcGVhT2dFNzRiY1BXSTZo?=
 =?utf-8?B?M3oyMlU2YnlVQ3RtaGJoLy94SUhHWkxMcW94N1VMdFEraGx6QmMwM2dPWDIv?=
 =?utf-8?B?YU9Ua21CbGpYZUw1eGpHY2FqUFYyZHMrOEZZM0dGWXQxR2pWZG1YZUZYNmho?=
 =?utf-8?B?OGUxVGttR3NWQ3B4dkFDTmRLSE16SmRwMStuS1pSZjNoSUc2RmdVTFc4Y3lN?=
 =?utf-8?B?NzNHVUYzOFZPdU03Yk1FZjZOTm1tVHppR1NvU040eWF6SWg3SFF4VjRrN1B1?=
 =?utf-8?B?dXBJYnp4dCtOekdpVmdyR0FXb2ROd3lQS296Qk1rMytkOHE3ZVNjSW5ISXhi?=
 =?utf-8?B?U2JGaFlTQktMd08wYnhSSVdFd3ppRWp3TFJ4NUl5c2MraUduNHJSUEZYdGJm?=
 =?utf-8?B?bXV1a0cwUlRhaHh6QTRPck9yaHJmcUNKSHZwN3YxNXUzeWdrUjZnVjhxTG9m?=
 =?utf-8?B?SUlGSVppVDFvVGZ6cm9PWVozYnVBdXQyQU54T3VSK05FSDhwTnVyQVJjL0pS?=
 =?utf-8?B?QXN5citkOEd4OTEzZEwySldiUmRoVGxUam1KL2w3ajBkUmMwTVUwYXlXN3lL?=
 =?utf-8?B?Y0hHQWo3c1RGMHR5bWtwTjNKc1ZJRlR4QzZkaG1ZNXFPRDZyTjMzYUg3Qm54?=
 =?utf-8?B?WjlpcHZPNHk5Tzg1L3hGUmpmTjJ6LzNpVXNtUEQyNDBBQjZjcHp4eEtINEwr?=
 =?utf-8?B?NXEyaGU0S0NaelUxVVB4ODRFRXdkZExxU3RCaXRJd25Pd3YzdEJMNHhuZWV0?=
 =?utf-8?B?VWpOU3JYd2ZjbXIwUklSRkpBN1hJOXpVZG5hQ0lBWXBBZHFRcnk5WkdSdkpq?=
 =?utf-8?B?N0JnN0pQdU95eWdPQ3lhWEk5N1h3bTlOdVVCMWtPdU5FV3QycmV0WE1JTVF0?=
 =?utf-8?B?K3dycm9Uc1A1VEZKZHUybDY0aGthOWZ0SU9zUnI0eHJZY0MvWEJJTTB0aktl?=
 =?utf-8?B?V25BamJMaVlLRnRyZDJFRTREWUpEVmd2aGpoUkZJUG9rbHpoVnpiNW11WTdO?=
 =?utf-8?B?ZjFUTE1ycFNkc0NOT29qN1VMZWhFTFNqSTgrMHBJUzA0SUdsaStXVDY2M2tR?=
 =?utf-8?B?ZTlEUDVxZ0tNdnZxUm4remQ5QTcyK1BhWTloV3UyWWREOVZhSGpLUDQvcEZl?=
 =?utf-8?B?dHM3ZnBMZlR1QURwbXJZVFFSWEl1bmt2RWlmVTM2NWhVVkF0T1h6dTA2aXdX?=
 =?utf-8?B?ZEhxT0tEd0VxQ2RZZThCdjJUVGNNcWI0UXBpbloza1d1dk5iekdpSXhYcE9l?=
 =?utf-8?B?RjBlWjJvQlBEY1hKV05LTnFlOVUrZDJWaXNIOFFEdXZodTgyaTUxQ0poOWU4?=
 =?utf-8?B?VDNOMm1OZ3luODdxclhodldSblF6ZTFJU0crY2xSTVdSQ1VJQldQd0hQTjRW?=
 =?utf-8?B?K0NldkRzNUViMWpRVTVycHBHb3c0cVU5dVd6VE9pZlBNSlk1bERINGI4K0Nu?=
 =?utf-8?B?N1dvN0RwcnNxa2NVMmkzcDY2QWZVOTNzN3l5ZEN5bDljMUFpZjZhRzNOVGZz?=
 =?utf-8?B?bHJhN1lTL3B0QllVQ2pXR09ZMzhib0k1NW5VeDlCUHRNbE96Sk9JOURGN2Q5?=
 =?utf-8?B?bnhhaU8wSmUxTU03ZVI3M2Yvdm1HaHQ2R2RueTlEN0N2ZjlMTUI3ai83bEZU?=
 =?utf-8?B?bWF5Nk5xanhDMFRYTmMwSXFCQlZPSExEdmw0blN2RUFwOUpWczMySDh6VHRu?=
 =?utf-8?B?TDVNWHQ2NkdjNFcrZ2hlS2loaDR3bjNRYWF5YnR2MGRIRXVlVXBOOXdNR2s5?=
 =?utf-8?B?RW5Vc0J0WUFINGU1aWJiZ1VKY2g0UUF2VlFNd0dzZUtPQVBXT2ZGeThDYkhU?=
 =?utf-8?B?ai9DckpoOHdwajF0NnptUnJ4TTFZTVYxdjNlTVRWcVA0RjhITTlOb3VCOEgz?=
 =?utf-8?B?ZWU0am1qQTFMd0hBZldlZGxLSXg3cjZBOWpad3dZWFgxd04xYmJscjhMbkZk?=
 =?utf-8?B?Nkc1TTNNRFZ2ZWZXcEgvalYzL2FiYnJPUlRVK3N5Z2FzTCt4RUd3VmkzSFNK?=
 =?utf-8?Q?CoKG44QUh0uUC72yqewqoE3az?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6407ef0f-736e-4aa2-7a25-08ddacaab668
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:52:16.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFZWCOoagJ66HX5FiYamQYJMZkuEbM/N5sEEULLwmc99qu+IrJH2D+F3emOKKJ3LW81qo9nMtJXotbr+VQ06P/34wS503qh4kRFE0hoigb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6747

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjAgMy81XSBhcm02NDogZHRzOiBhc3BlZWQ6IEFkZCBp
bml0aWFsIEFTVDI3MDAgU29DIGRldmljZQ0KPiB0cmVlDQo+IA0KPiBPbiAxNi8wNi8yMDI1IDA4
OjU0LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjAgMy81XSBh
cm02NDogZHRzOiBhc3BlZWQ6IEFkZCBpbml0aWFsIEFTVDI3MDANCj4gPj4gU29DIGRldmljZSB0
cmVlDQo+ID4+DQo+ID4+IE9uIDE2LzA2LzIwMjUgMDg6MzIsIFJ5YW4gQ2hlbiB3cm90ZToNCj4g
Pj4+Pj4NCj4gPj4+Pj4gQnV0IEkgZG9uJ3Qga25vdyB5b3VyIHByZXZpb3VzICJOQUssIG5ldmVy
IHRlc3RlZCIgbWVhbi4NCj4gPj4+Pj4gSSBkaWQgbWFrZSBDSEVDS19EVEJTPXkgYXJjaC9hcm02
NC9ib290L2R0cy9hc3BlZWQvIGRvbid0IHNlZSB0aGUNCj4gPj4+Pj4gZmFpbCB3aXRoDQo+ID4+
Pj4+IGludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMjEwMDAwMCB7DQo+ID4+Pj4+IAljb21w
YXRpYmxlID0gInNpbXBsZS1tZmQiOw0KPiA+Pj4+Pg0KPiA+Pj4+PiBTbywgY291bGQgeW91IHBv
aW50IG1lIG1vcmUgdGVzdCBpbnN0cnVjdGlvbiBmb3IgdGhpcz8NCj4gPj4+PiBTZWUgc3lzY29u
LnlhbWwuIEFuZCB3cml0aW5nIGJpbmRpbmdzIG9yIHRhbGtzIG9uIGNvbmZlcmVuY2VzOg0KPiA+
Pj4+IHNpbXBsZS1tZmQgY2Fubm90IGJlIGFsb25lLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gICAg
ICAgICBpbnRjMDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIxMDAwMDAgeyBTb3JyeSwgZG8geW91
IG1lYW4NCj4gPj4+IGFkZCBieSBmb2xsb3dpbmc/DQo+ID4+PiAJCQkJIGNvbXBhdGlibGUgPSAi
YXNwZWVkLGludGMtY29udHJvbGxlciIsICJzaW1wbGUtbWZkIjsNCj4gPj4+ICAJCQkJCS4uLi4u
DQo+ID4+PiAgICAgICAgICAgICAgICAgIGludGMwXzExOiBpbnRlcnJ1cHQtY29udHJvbGxlckAx
YjAwIHsNCj4gPj4+IAkJCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1pbnRjLWljIjsN
Cj4gPj4+ICAJCQkJCS4uLi4uLg0KPiA+Pj4gICAgICAgICAgICAgICAgICB9Ow0KPiA+Pj4gICAg
ICAgICAgfTsNCj4gPj4NCj4gPj4gTWF5YmUsIGJ1dCB5b3Ugc2FpZCB0aGlzIGlzIGJhc2UgYWRk
cmVzcywgc28gaG93IGNhbiBpdCBiZSBzb21lDQo+ID4+IHNlcGFyYXRlIGRldmljZT8NCj4gPj4N
Cj4gPj4gSSBtZWFuIHJlYWxseSwgZG9uJ3QgYWRkIGZha2Ugbm9kZXMganVzdCB0byBzYXRpc2Z5
IHNvbWUgZGV2aWNlIGluc3RhbnRpYXRpb24uDQo+ID4+IERlc2NyaWJlIHdoYXQgdGhpcyByZWFs
bHkgaXMuIFRoYXQgaXMgdGhlIGpvYiBvZiBEVFMuIE5vdCBzb21lIGZha2Ugbm9kZXMuDQo+ID4N
Cj4gPg0KPiA+IFVuZGVyc3Rvb2QuIExldCBtZSBleHBsYWluIG1vcmUgYWJvdXQgdGhlIGhhcmR3
YXJlIGxheW91dC4NCj4gPiBUaGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgc3BhY2UgaXMgZGVjb2Rl
ZCBzdGFydGluZyBmcm9tIDB4MTIxMDAwMDAsDQo+ID4gd2hpY2ggaW5jbHVkZXMgYm90aCBhIHNl
dCBvZiBnbG9iYWwgY29uZmlndXJhdGlvbiByZWdpc3RlcnMgYW5kDQo+ID4gaW5kaXZpZHVhbCBp
bnRlcnJ1cHQgY29udHJvbGxlciBpbnN0YW5jZXMuDQo+ID4NCj4gPiBUaGUgcmVnaW9uIGF0IDB4
MTIxMDAwMDAgY29udGFpbnMgZ2xvYmFsIGludGVycnVwdCBjb250cm9sIHJlZ2lzdGVycw0KPiA+
IChlLmcuLCBwcm90ZWN0IGNvbmZpZywgaW50ZXJydXB0IHJvdXRpbmcgZXRjLikuDQo+IA0KPiBU
aGlzIGRvZXMgbm90IGV4cGxhaW4gbWUgd2h5IGdsb2JhbCBjb250cm9sbGVyIHJlZ2lzdGVycyBh
cmUgYSBCVVMgb3IgTUZEIGFzDQo+IHlvdSBjbGFpbWVkIGhlcmUuDQo+ID4NCj4gPiBUaGUgYWN0
dWFsIGludGVycnVwdCBjb250cm9sbGVyIGxvZ2ljIHN0YXJ0cyBhdCAweDEyMTAxYjAwLCB3aGVy
ZSBlYWNoDQo+ID4gc3ViLWNvbnRyb2xsZXIgaW5zdGFuY2UgKGUuZy4sIGludGMwXzExLCBpbnRj
MF8xMiwgZXRjLikgaGFzIGl0cyBvd24gc2V0IG9mDQo+IHJlZ2lzdGVycy4NCj4gDQo+IEkgZG9u
J3Qga25vdyB3aGF0IGlzIGEgImdsb2JhbCBjb250cm9sbGVyIHJlZ2lzdGVyIiBhbmQgIm93biBz
ZXQgb2YgcmVnaXN0ZXJzIi4gSWYNCj4geW91IGhhdmUgZGV2aWNlIHNwYW5uaW5nIG92ZXIgbXVs
dGlwbGUgbWVtb3J5IGJsb2NrcywgZGV2aWNlIHRha2VzIG11bHRpcGxlDQo+ICdyZWcnIGVudHJp
ZXMgZm9yIGV4YW1wbGUuIFRoZXJlIGFyZSBtYW55IG90aGVyIGNvbmZpZ3VyYXRpb25zLCBkZXBl
bmRpbmcgb24NCj4gcmVhbCBoYXJkd2FyZSBhbmQgcmVsYXRpb25zaGlwcy4gSnVzdCBsb29rIGF0
IG90aGVyIERUUy4NCg0KDQpIZXJlIGFyZSB0d28gcG9zc2libGUgcmVwcmVzZW50YXRpb25zIG9m
IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciBsYXlvdXQgZm9yIHRoZSBBU1QyNzAwIHBsYXRmb3Jt
Og0KUGxlYXNlIGFkdmlzZSB3aGljaCBhcHByb2FjaCB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRl
IG9yIHByZWZlcnJlZD8gDQoNCk9wdGlvbiAxOiBIaWVyYXJjaGljYWwgcmVwcmVzZW50YXRpb24g
d2l0aCBhIHBhcmVudCBub2RlDQpUaGlzIG1vZGVscyB0aGUgZW50aXJlIGludGVycnVwdCBjb250
cm9sbGVyIHJlZ2lzdGVycyBzcGFjZSAoc3RhcnQgZnJvbSAweDEyMTAwMDAwKSwgDQp3aGVyZSB0
aGUgcGFyZW50IG5vZGUgaW5jbHVkZXMgdGhlIGdsb2JhbCByZWdpc3RlciBhcmVhIGFuZCBhY3Rz
IGFzIGEgY29udGFpbmVyIGZvciBwZXItaW5zdGFuY2Ugc3ViLWNvbnRyb2xsZXJzOg0KDQogICAg
aW50YzA6IGludGVycnVwdC1jb250cm9sbGVyQDEyMTAwMDAwIHsNCiAgICAgICAgY29tcGF0aWJs
ZSA9ICJhc3BlZWQsaW50Yy1jb250cm9sbGVyIjsNCiAgICAgICAgcmVnID0gPDAgMHgxMjEwMDAw
MCAweDQwMDA+Ow0KCQkuLi4uLi4uLi4uLi4uLi4uLi4uDQogICAgICAgIGludGMwXzExOiBpbnRl
cnJ1cHQtY29udHJvbGxlckAxYjAwIHsNCiAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVk
LGFzdDI3MDAtaW50Yy1pYyI7DQogICAgICAgICAgICByZWcgPSA8MHgxYjAwIDB4MTAwPjsNCgkJ
CS4uLi4uLi4uLi4uLi4uLi4uLi4gICAgICAgIH07DQogICAgfTsNCkFuZCBJIGZpbmQgdGhlIG90
aGVycyBkdHNpIGhhdmUgZ2xvYmFsIHJlZ2lzdGVyIHVzZSBzeXNjb24gZXguDQpodHRwczovL2dp
dGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvYXJjaC9hcm02NC9ib290L2R0cy9z
cHJkL3VtczUxMi5kdHNpI0wxNzctTDE5Mg0KDQpPcHRpb24gMjogRmxhdCByZXByZXNlbnRhdGlv
biB3aXRoIG9ubHkgdGhlIHBlci1kb21haW4gbm9kZQ0KVGhpcyBmb2N1c2VzIG9uIGp1c3QgdGhl
IGludGVycnVwdCBjb250cm9sbGVyIGxvZ2ljIGF0IDB4MTIxMDFiMDAsIHNraXBwaW5nIHRoZSBn
bG9iYWwgcmVnaXN0ZXIgbW9kZWxpbmc6DQoNCiAgICBpbnRjMF8xMTogaW50ZXJydXB0LWNvbnRy
b2xsZXJAMTIxMDFiMDAgew0KICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLWlu
dGMtaWMiOw0KICAgICAgICByZWcgPSA8MCAweDEyMTAxYjAwIDB4MTAwPjsNCgkJLi4uLi4uLi4u
Li4uLi4uLi4uLg0KICAgIH07DQoNCg0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQo=

