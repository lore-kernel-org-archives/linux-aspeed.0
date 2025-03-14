Return-Path: <linux-aspeed+bounces-986-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D84DC28B2F
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 10:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDgrP75Ntz3cYj;
	Fri, 14 Mar 2025 21:40:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::730" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741948853;
	cv=pass; b=DB1BhoxJvlAN9/XMK2EBaDfqXiVjLxelwAIwb9ZXhewDhiQtkZA4twx5xzBTUu58bJFeJZ10U315d7wfj4P2afMP3eLZSzriHO/GFq8CkODpTPMynbnvdwTi5XwdSXwb58K/b4YwYVvGmGaEYHBZHaiN/GhO8Hq1VMbE2Qnq8i80U5qEVL9vDFOKDDZ6bcfZDqR8k2zMQaifEfHZSHhf+OxKGVqjK/AbnV3fxejaeNiz6MwMInFoNHfuxDU0Ns7OnJkf7BQCEsZ/pHVwmLmf7awqURALKFEk/dOtxV+fOTJBZVmh3TLKU+z0CL86V9P8bHT5K6bREb0BmzibWWeTCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741948853; c=relaxed/relaxed;
	bh=Vt7taJ9jFaGy2PqWPcRNDlH3LVQLTY6sNu+Up2uwHy0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZLVfBcMINtovrAswpIMrDCtrsmCsYJ7CPVjwF4FBDA15VZUJ8b6e5ZTnz1msU3w0cNt1YdCXgcI3zSb8ItGzTvW1TuWb6GgvtWCkD1T7cQP1xzC6QMoNf394fW28Zs6TE1hnVzCdfWu2/8WUiw+XnmEcarGF4reBTofouT+uFncgnwlgw0JZJKQ7NF45lrUVFVpub5MRRL1xuAt0yu4Qzn18bRedsZWlZuJUkIZZzBd8PEW254WJMgcur8byIn7wVojg+n3c3VVuGAJ0qvFczbdNZ58H94/WNNGxAhNcClXPAAjr3IoYGatUKqYorDuYazpys8OV/meJG9kNdPylA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:200f::730; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::730; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20730.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDgqm6nTdz3cYN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 21:40:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rabb2YKSwyCfGD0swVIdo1wko8FrSkVzkthhZ+haCZLLam1NRzK9J7nblullDsxOg7M5NBWbZys3jENi/UlsatWByn64GmWyUk+TEqwEkkOW5Jz506qxVxVoGuYn+EGlFvLGJZaKJxpbLXvejEv0iY8h0boHne6AcVsz/tY0XZN5QFSetjX+amROKUv+oAbvIv+4dqvGR5YqTeDchIS/+TWGmvfuReQgKj1IeD4me/yJHpsXPvI+uTUwWHL9CwdQGxe6lCLZohSG2aJCVQ/aWrivMso2S7U8Nt48n7huSxtYUEbtH8hOG9Q00T3E5DRqs8hu3puQo7cyrxd/Yl6PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt7taJ9jFaGy2PqWPcRNDlH3LVQLTY6sNu+Up2uwHy0=;
 b=eDssABkC5PydNoA92HSuV5NPjc8++bTJ2ZOEIjJzk/zmjmLZaM8J6dUdv0hXaVUWKtjz3yp8/PC5N9IE0rwWlD2xOM6h6KLp6jwwsV3yG54/z7CxuK1l77yqxV67/Oq+U5viyny6yl9MhNYUjQ192SroTd4rrRPanfi91HxDaNdZL38WtI+Cukn01Ng4+mk/Cr6MUpAnvDHGLyBAuRG/TunF4qHtKnGizpFdSDVH2/6BO8pmohw92vD3hf9/IjTXwseTRXEu9nL1UKEXYQvieF7tK3fnytKEv7fJxp43dCyQnO2x+tjSWnl1OG1221SQY2kU1P/c09CNmT8QqpxH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt7taJ9jFaGy2PqWPcRNDlH3LVQLTY6sNu+Up2uwHy0=;
 b=Rkhs1h8b2oBCCJG9cIziVLNJnjh+54zG99DJtFF33qYZJs2F1gr3Az/chWYjyND5X7nxwZCeSocwAEV2+7UnoThUf8fw8FVIs3QU6ns4RGVMKgytRsmtWp2QpLqHlkmn7H2/ASbq/aAGjiK2zdY3JcgV3cVRf4+L8FYHHOl3mnO7fbJU3XcWUOce8p2pfykuyRRoKAL2g6lw6bW8vdb8Lrf/JqLTth0slaasx3viCuDEl5d1MT+3pjsbFKh5jbAWyHDJ+V22fGKm97G8sD7khlDCMhbPs1K0sZQi/0TfP6TTJUuuA49oDMcLgP8yI6HwTzqKOM2y5vKbDbZ1mh2EWA==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR06MB7087.apcprd06.prod.outlook.com (2603:1096:820:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 10:39:59 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 10:39:59 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
	<derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Thread-Topic: [PATCH v2 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Thread-Index: AQHbjPJxRrvZq8xUXkuIjl5B+8oxRLNiyu+AgAAESYCAD7D4YA==
Date: Fri, 14 Mar 2025 10:39:59 +0000
Message-ID:
 <PSAPR06MB49492B48614D381498502A9089D22@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-3-kevin_chen@aspeedtech.com>
 <142a2edc-a668-4a6a-a4e8-eff3e8bf9e91@kernel.org>
In-Reply-To: <142a2edc-a668-4a6a-a4e8-eff3e8bf9e91@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR06MB7087:EE_
x-ms-office365-filtering-correlation-id: d41bab3e-7b12-4ec5-eff6-08dd62e491a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHhWakFUbWorUkVPNWpBOFk5a1kxRitHRnpBY3hvemFVK0Vsa05nekYyVFRB?=
 =?utf-8?B?amsyeXJUUUhjU3FzWlR2bGhlWG9vS0lzMkJBRjZaQ3gzK0w0cEVKaUpuMTdF?=
 =?utf-8?B?bEtodVVwV2F4djlRUEJ4QW93Znl6amlBdXBjOXFsYUE5VCtXb1F5OUxDNmhJ?=
 =?utf-8?B?NXZIZ1EyY0lSaGZ3aFh1OC94RWgwWWNVclVvdnZZVHhBeGJEV1Z6alNjY09k?=
 =?utf-8?B?WmY2SDBJK2VEcTBFZ0ZrQVlNNTFRc0V3ajQ1VWc0Q2VEeW5ZLzdkMmdCZ0U1?=
 =?utf-8?B?bVJBY0FXNWpqM1F6dkdkT00va3JCZ2lUSDh1Q2pHTE03SDhCTDJXeWJPcGJ1?=
 =?utf-8?B?MlNoZGhybW14MmVnWEpJRXhqbkl0RDFKVSsyRlZvZ0dIV01jVEFUVTlUZ3ls?=
 =?utf-8?B?eVdlRE02eGdZTjVVUUtSeFFjSm1mbWU1V2NRS0V6MGJpWXp2Wk42SXpHUTNv?=
 =?utf-8?B?ZHVNUmVjZE5vTVR5T0U2NDVaWk41SzJFQ09iMEpZeFo2Smh3alB2dHVuOGox?=
 =?utf-8?B?c0RqRHprZjcvYlR2ZFF4NXNSQUc1MDI3RS9hamRBRkNqZHc3SWpKUWo2VExL?=
 =?utf-8?B?YlgwSklZNkZYK29aTlZHVjQ0OUpSTXdNaHBRYktTdUc3QStqc1VFenB4S0pz?=
 =?utf-8?B?MHR0cEVIRjV1a3lZUG9tL1d1TkFDdnZ5aUJNVWlHMHZMSldkM2xzemZ6TWl6?=
 =?utf-8?B?T2M4L0d2VzMzZ202RjF5Skxpc3h2eWFwY2c0dlVtbmo5Lzdhd3VEbkhjVVJI?=
 =?utf-8?B?akoweHZVeEhId2FHZ3g3MHByYWkvU3pUN05jaXp0M2VQVkc2Ylg1RzdVSHY3?=
 =?utf-8?B?aVhXS0g5eHJBaGNhOTlXZHB0UWYwbVdVWVgyK09qWXFZYmI2WjR4R2t3Mk1K?=
 =?utf-8?B?TUtta1M2VXpBdStRc2dZUGRiR1c5TXphdG9XMlpiQjh6OUppNkpRN3g1eXZW?=
 =?utf-8?B?cGlkMmY4VVg5THduZHZTWUNpTGJDV0owdlU0V0cxaW1EMERtMTVaZnJtekor?=
 =?utf-8?B?dXNuSWZEN1hsSnRXL0hQZTVMODdXMWhaemhrWXVCR09KU3ltNjJCaVlBK3J1?=
 =?utf-8?B?eHVSeFlIS0NrZFRzZE5xeENUQmFWR3p0RmN2RGFIR0g4SWwwNlRkay83SDg1?=
 =?utf-8?B?QWxGRXRyM2RHaXcwcDZxZDhHOTF4VXBjQ2FDVkE4QkRxbTl4S0h0bFl0TlhL?=
 =?utf-8?B?MnE5UTlFKzVVekdIbTR0SGNNMWpIQUkvMjhKbnNyaUlPc0tXa0Iwd21ZR3RD?=
 =?utf-8?B?c2c5K0hNeHdOVUtiUDdQcVFlOWVmTWxiQkI0SmxDZGo4bXpBejJuTXlPVmdU?=
 =?utf-8?B?NTdQUVNZUUlQRmF6dFJLNHppQi94eU1qK2tkTDl2NWlKMHQzc2syN1c5TWxH?=
 =?utf-8?B?aXEvUklaczA3Q3VPV0tLNjErRm9Td2FzVWQ1cnNJT0kxVE4yQUNZUFdoNi9T?=
 =?utf-8?B?QjhuekxwaUk4dlM3K0NVaEkyWU51Q2tyRU5mZzVCRTFOVEY3MnI4RXVxUFRt?=
 =?utf-8?B?Zjh4Qmw5d0RBVklpOXIra3JUN0JmQWM2ZlhPN29OVUF2dGkybzVVd2ttUndh?=
 =?utf-8?B?YTdOUEc1ZDJTUDJCTnQ1RnUybXJHcFFmMUpTL25sVnZEN0lzN29FQmp3SjVs?=
 =?utf-8?B?MHBhQ1FEN1BuQzRERmNiNm9WUC9iRk9SalZnSXpWRGIvdWpkSC9mejBRMjg3?=
 =?utf-8?B?bFZCSDlXeWN0eVc3YTkxR2creXNkd3JhMzdWOTVUSitCeCtCZEU1NVFYT2Jr?=
 =?utf-8?B?UWdTV3ZBWHRnd0lFVU0yRWEzOTBkK0NrY1hLb3RGR2hMN2pMWEVxNi83eTJB?=
 =?utf-8?B?MVBYS1F2SXpHR1RxcEZuNWp2MGsrNEJGTmcvTnk4S2tneEx2QWx1UWh0RHVG?=
 =?utf-8?B?NkdObktUdWtNZnNjL2YrS3BPUDcwRmJEQlEvNEZldFczeTQxcXd2bXFlTkJI?=
 =?utf-8?B?Z01peW5SQW1MeHVIT0dqWXJuSi9xUnU1MmpCNlcvMitUMWY5WEd3em5RZjU3?=
 =?utf-8?B?Q3pOSmR0ZjVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L29BRGJiN01ISTBrZG55REVQSGdYUzc4SEhWYUFTbUpaTzNwQ2UrRXAwVzFK?=
 =?utf-8?B?dmtGckNxUFc4bHV1Z092VmlhRHROUmFFalp4ZitveXRoOEJRWWdpYkpVL01r?=
 =?utf-8?B?ZE9TOWN3VllkT3AxSzErSkxaV1lGYy9uTUdVRUwrQjhrU05iM2cyVjFzZUE2?=
 =?utf-8?B?SXFGZ1JKeWlpT2tuY2xNNUFJNjRpbENaUU92b1BFZWt1MmZEb3pldDZIV1B6?=
 =?utf-8?B?OXRCcGs1bldva3JBdnNDV3o3U3pyZG1JK3JKTFVpaWNscUM4VTI2aFJRL0t3?=
 =?utf-8?B?OHRXanBOcXEvRmE4V2U4RUFXQzZoWnFvc3R5OU5MWm00bWxIY1QxWnJOU2ht?=
 =?utf-8?B?QjhSNU1xNytwWE82L0dSMCszclFWUW52WUduRFphVnVJN3c4U0k2UXcrekla?=
 =?utf-8?B?QXhUOEp1bHZTbXVwaDJmM2d1aGRrS21FR2RyZUlrQ1lZQzIrV2lXTE1vNWlW?=
 =?utf-8?B?MStiZjdqY0RseVR0dko1bHZEeFYzRUVyeUxidnkvS2F1cnlZRUZPTzJYR3lE?=
 =?utf-8?B?MUM1T2ZvYWRwQ0VJSi8vd01CekRaci9KWnhHbzNFMnlmSVBBZ2xsczlyT0J4?=
 =?utf-8?B?K1V2ZDlZV2psamxHVVZXbWx1d0FvMkpmaHB3MnhZZGlSbDgzOTR4ZWtvUFBP?=
 =?utf-8?B?RWd2dmd4c2czRW9xZys5TTR5UW1rVUk4d1A2NUIyQm4yZUcrYzlrZkgveERo?=
 =?utf-8?B?Qm9vaTN6VnJURmhHWTA5ZjlZdndpeXFPTWFoZVNZOTg3K2NJVWkzYmYvVWhh?=
 =?utf-8?B?anlsZ2h3OGt4TVlrR2plTVQxTGRMWHZTZFg5Nk5sWDZDbitPbWVyS1VJL3JM?=
 =?utf-8?B?VHRGaFQ4WjQzV0x5SFdXRUhYa3ZKcGJZQWowOCsyVE1yT05KcEFVYzdEWkpo?=
 =?utf-8?B?QUJDQzZaZW9GdnZqQjU0OWl5a0VmMG9UT1VGN09hREtSN2MyK2Z1R1JmOS9E?=
 =?utf-8?B?K1VpM29iWWRQRWhsY2NJM3BxWGdDTk4wanBkdmZNZnUzdDhhcTVWZDdBV1BC?=
 =?utf-8?B?bnZoRTNGZHoyTU4xQ25CSWYxazc5TlJ0Tm92R2VER2dWTlRrRUl2Zm1oekZs?=
 =?utf-8?B?R1h1QUErZXVpcW9oUjlnemRtdEdabmpBRjZhS1Vxdk5UTDBYNEtLbkpnbUR1?=
 =?utf-8?B?d0VRVk8zWXNHVENiWW41RWpOTDd2WGNUcVFCWlJUV1ZGUjJwSmR3OFdRY1dY?=
 =?utf-8?B?VVgrcHk1TTcxN3k1bGpydXd5U1Q5MjRlME9kenhqVGYvR0VRdFNNWVlzU3pw?=
 =?utf-8?B?d0xIWWRVTjhYQWs1V1V3TU1sdkhFUGYreWoyMGJITnZzQ0lzTnB0NGh1ZVN1?=
 =?utf-8?B?SjgzZWd2T1VBSFNvb2RIeXBhZ2FzbWJjSERNYTJ6R2JZcVJiL1hyQk41dThX?=
 =?utf-8?B?RC9vV2JTeENSTC9OdGNGKzVIRGkyL0VuSUFNYWM1L1VqaVFHZkNLWDl0OVVu?=
 =?utf-8?B?bGxYVHJOVjBwdFNZUnZrMm4wQTJCMThwQTczTXZialVXYXlYYkdVUnQ4OTNr?=
 =?utf-8?B?TXRzREtObmFkRFFiSlZvRmRqeUUrMnlVLzhXVVRzMm55alNmZ00yYmVxdlVt?=
 =?utf-8?B?UzB0TUhaUXA4bG4reHJENDFBSXFVOVozWktvWHVxMVhteGJUenF5YTB4TFRH?=
 =?utf-8?B?cE1JKzgwQnE3L3g5cWhOTEgzbWU3eEZVcnVzeFNSQmt5RUtMVm1GREZGMDRC?=
 =?utf-8?B?ZnNBSXdPeWEyOEhBQVk5TkZoaldWZ3NqRnhQQXc4QUl4TG5sT3Z6RmtYN2xh?=
 =?utf-8?B?K25iQVV4S1lZSlRPTTRMRk9kN3dGd3B2aXJRR2lNdXpCTGRQaXdZVHFoSjVk?=
 =?utf-8?B?QUdlekNDcUZCUHhtK1lVRWovWUVpeTYyRVk3NDRqVE4wVnN6bUJFbjFkRmM0?=
 =?utf-8?B?bWxTMFhUL0RjVVhad2NRZXJOMFBURGpBZFkxM0xNV014dzZIVzFrSUtuQm1Q?=
 =?utf-8?B?M255RUxBNS9hditNcSs1citXeU9zM1FjZDIxUFlLQzQ1OHVqM1hRM084M2Uy?=
 =?utf-8?B?dFJPaCtVMG5MZERCWXY2VDNLS3F2RTZqalBZanVaVzJCcFpBbFhDUGJoUW93?=
 =?utf-8?B?TUhjTUlKSFA4ZStJTkhaVTcreDZkdVNNaUJYaW5iV0JtbW5VZlYydUI4clpu?=
 =?utf-8?Q?TvFt9t2oLFD+XvucMyruKZA0x?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41bab3e-7b12-4ec5-eff6-08dd62e491a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:39:59.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhz83hch2qReK4QLJxe+nOttblVhEQAgtGyT+iO3Iv6+kDqNMsGxLhHxaBFN6jhvNJlIZiqv5ANgDVPT+32x8afR7GQQFMB5DKqlICOO/J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7087

PiBPbiAwNC8wMy8yMDI1IDExOjQ0LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+IFRoZSBBU1QyNjAw
IGhhcyBQQ0MgY29udHJvbGxlciBpbiBMUEMsIHBsYWNlZCBpbiBMUEMgbm9kZS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEtldmluIENoZW4gPGtldmluX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+
ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzYuZHRzaSB8IDcg
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNi5kdHNpDQo+IGIv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNi5kdHNpDQo+ID4gaW5kZXggOGVkNzE1
YmQ1M2FhLi44N2RjYWNiNzg2OTIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkL2FzcGVlZC1nNi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
L2FzcGVlZC1nNi5kdHNpDQo+ID4gQEAgLTYyNiw2ICs2MjYsMTMgQEAgbHBjX3Nub29wOiBscGMt
c25vb3BAODAgew0KPiA+ICAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJCQl9Ow0K
PiA+DQo+ID4gKwkJCQlscGNfcGNjOiBscGMtcGNjQDAgew0KPiA+ICsJCQkJCWNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI2MDAtbHBjLXBjYyI7DQo+ID4gKwkJCQkJcmVnID0gPDB4MCAweDE0MD47
DQo+ID4gKwkJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE0NSBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiArCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiANCj4gSW5jb21wbGV0ZS4gWW91
ciBkcml2ZXIgY2xlYXJseSBiYWlscyBvbiBtaXNzaW5nIHBvcnRzLi4uDQpBZ3JlZS4NCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

