Return-Path: <linux-aspeed+bounces-860-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223D9C021BE
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Feb 2025 08:04:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3P4w46qMz3bnc;
	Thu, 27 Feb 2025 19:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200e::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740643472;
	cv=pass; b=Tg5UV7ZPlvotYXdY0NC2osit/qkThXkQL5v7mKdcVvK5EwNfWJQD3NF/npRxG98V6AHKr0ztdfopxt8TWEAOOS27DNtqfZpyCd/2E/cLhNT9Zw7yuPKijruBnVMQIWLXr/aVx6csWvhcUBqCOXkLY66ONwFJmhjOp4wtr8Z9Jlizy1b0lKwHaVxR6iVtIOlsmZhbJHYWvsC6326saUpuDmmyp8czB7LpZMmxz8MZSLo7rOXzMhJ1yc4FKo+nXFeCFeAqZ0gLiyctnVcBcy/cLHijyRT2cAacVs8LRDVLN56bp1MNyJ2G9m+igqpVQcW4xWhgYTFeb3mcqNzMFruZcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740643472; c=relaxed/relaxed;
	bh=nDC8NjYJQTUTbK+MB5lN7wuxIi8svRxwTrpMtW/1hcc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kq89PQ/6QNm4OswfKhk1ZnboSA5aFc4tD0jteCeeZtrfnvOgJnbK2zcJ75r6oKzZMPxZnQweMumVyv7WRoY76Trli6aQ1NspieOuQAWftk8suiJm96VT2hqVoDXjgNf2tS4qmyif0l/GiNLIIBZ1/0y31ig4HtjAaum6HLuoKPAZFxp7GsxNHEGt0unlEdxzLw2KLF8V5N8n8cjICpCGG6oLQvNk5ASiGtG/M7I43XfmxHU9T7BaF9aHh8qpUDiz8C/3NaWaysWLMpA1j0FQgD02exONAjKyV3AzEgZJSMk12bIFI9PpVDeHN/ySPnqNoVx5npDagp0fpEShvgg3tg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:200e::70f; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200e::70f; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f403:200e::70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3P4p1mqfz308V
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Feb 2025 19:04:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H70uq0/uTf3UopJsgYC3tAvmgic6CVWjgGBgYdVJ8HY4o26RnkjWbK3u3SzMIIDo6AkPPbrXQENCFGaLwOqC5JYYW89DfsMUP+Oc/4/iZK65bMwkrHZRzY3qZro0LwdrfMga0QiXY7R4btrzsE6ilDoGYA+ODOhs9N3pgbCJbyhoByKLTv3gWiSkaaKGwlaFN2J9ePrGNScW2wJb5EHC8Iti+j5vY5THVDRhim+CZ2dkdez91UA1CI/zSADsk8jRUrSBsBr15A4Nwvh2n9l9QWIBTT35DDrrcTkr15fpax9S/pl+g8aIYDLVhmF3MkJDTFJTvSuL3BRF4TpxcP9rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDC8NjYJQTUTbK+MB5lN7wuxIi8svRxwTrpMtW/1hcc=;
 b=O5Ygm3AarT0+zDx1Me2hvdHUcQCD9DiiFZ2S5UJOBNIDRYIRNtzomV4pkC2GwpHvhpmSXU1vey2wjYRWEwTB2TmIwsGkkXll8hopiOSqIjlqtUoLf9ge05/mgDlHUMtPLbXvF+9MDCf5qdmDX/oiOxzPpKMfUr/iUnmZtsq7obAHqeC1sbb+cEpJuIA2GLJnf1tOi6TqAPyAuRqcD7GVobKvN2Dd5ZorvNpfb4X4EboKw9FgsNXm8OuRpUTJxa8PXuAgmRnzpDguegTqtVPEZDLtE6aTzXBbF0FBRkbiMIZ7Js7qHKDq/zpU17vlaZerR6LTggAosO4uwLgOSdpH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDC8NjYJQTUTbK+MB5lN7wuxIi8svRxwTrpMtW/1hcc=;
 b=BZR431k5DzIRkyazQ+6UWxXD3ZfvHOgrT4QI+6ZbnwghGWfbuIBCi2M7kPYq5k2W46OQdWz3m5xBLFWSXYJPQVFDc8XlyZ7uOI1vZOcIicblBWEibA5XVU7nemZYhUImQzVAU17kJx6SAK/3P/SdOxp1QYuX2wC1w6duPcg/W1nMc9yia+Fc5zP/hdZSHDd0oG/kkWfjhR4hVXSACTubusnWlX2XzgM5kT14OdEX290GP58X3poETZ8W/AhOtJbD0tz8R5sbodAN+yZOGl5aZG1Iih3fl5G/zDs1W6pOs9ugVA1CDULEBzl6bpbwZt9TsBJhPMmOHcdCsWf/g9TSwQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY0PR06MB5494.apcprd06.prod.outlook.com (2603:1096:400:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 08:04:04 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 08:04:03 +0000
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
Thread-Index:
 AQHbhqIygZnvzo4Bt0Wa/Nj5P77JfbNWO12AgADwbfCAAHvmgIAAHaSggAA7nQCAAPFIAIAAaLUAgAFw3FA=
Date: Thu, 27 Feb 2025 08:04:03 +0000
Message-ID:
 <OS8PR06MB7541CBC30DBFF4553A295302F2CD2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
 <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
 <OS8PR06MB7541D685A626D300AC730A5BF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <2b64a9d7-7048-4842-9cc1-fe23f5abdd00@kernel.org>
 <OS8PR06MB75411AE082C9630314966F2AF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <c4727195-757a-4624-8580-78e5c32e9290@kernel.org>
 <OS8PR06MB7541615D536BC1D44FF6D18DF2C22@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <1175a8d2-65ac-439e-94b8-cf7af8db37b3@kernel.org>
In-Reply-To: <1175a8d2-65ac-439e-94b8-cf7af8db37b3@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY0PR06MB5494:EE_
x-ms-office365-filtering-correlation-id: e80c0ac3-70ec-4295-55e4-08dd57054d02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWFmQkY4TzJoR0tYK05vOGFVZWZENGRaV21zTzhkcnR3RzNvR09QeTB1ZVJY?=
 =?utf-8?B?Y2l1UGJQZklpUFBXaXpXMTFlQThnVE9jTkcwRC93dlVhazhGMkxBS2dVc05y?=
 =?utf-8?B?YlNmWXhCV0ZhSys5a3JNNUo5cTBpWFRFcTlyY3R3UUV5MjNSdXRJRGJhNmlq?=
 =?utf-8?B?dk4wbmhucFdoNEc1dGlVZGlyL0dqVmtIeXVzUHErb0VpVWwrRHI5bVI4OHpQ?=
 =?utf-8?B?QVVEeUVQTm1ZT0MyNm9tUTVrbmlNMWlSaFhZMTgvR3FVaERkTE1RclJQTHc4?=
 =?utf-8?B?UjBwR3ByU1Zrcm45Zy9JRkIyWHF6MXV6bDBKOGdYWVhMN3ZFQ1pRVjBjT212?=
 =?utf-8?B?YWRldzlhQlJiN3JtN2V3N3lOR0lFWWFQSTZFNDZ5TnhVZ3B3eHM4UWFMZkxv?=
 =?utf-8?B?cXg5K1hadWl4QVZFQ0FNRDgxV2UzUU04aDg4REd3bkxidm40ZWtQL05FQU1y?=
 =?utf-8?B?dFcyREd2YjVDb2pnczRpOVgxd1JWY3RlK0NoVHU4bVlPczU4Sm54MW42dnFZ?=
 =?utf-8?B?MUhUTzdXc2w3amlqSU9ZT3ViZGpIV25pWm1LRlZwVlRobmQ0VU1SbVJlcllk?=
 =?utf-8?B?OFl1SkFjcWdVTko5WHFDa2p6eUhVTVZVQzZNTVJ5NEFHRlEyVHhBeldkem9m?=
 =?utf-8?B?OUVUdlRyeXRxaytycU9VdUxERVRpbmk0TXVoVXI3ZktOblgyaU43eDk5NmpF?=
 =?utf-8?B?SWNldStJL0NTcTNXWFh6ZFN2eUdNNVhWMGlYa2pCbnVHTWovb0t2aGl0Y3FL?=
 =?utf-8?B?UVJqYnd5ZW5IWmxieDlCV3dWTmhQd2tBUnZHelM2K0Fyem44TkxPL3RFTzhZ?=
 =?utf-8?B?K2RjNDN4ZGRTajg4b0RZd2ZSOFFXYldPZE8yMEJvbGFJdkZoYkVUTnRNK3Rp?=
 =?utf-8?B?b29OT0ExVUdWZHZjU21hZFhQRVltSFhqVTNCMzNyM2Y3V3BGNFBId3FWam41?=
 =?utf-8?B?NlBBQkdQVklKOGZjV21IU2x1SHFQem1hMEFOSzFLeWxWamU5eUd1eGFxa2ln?=
 =?utf-8?B?Qk01SW5BblVoenc2VitHK3hoeUVwdVQzTUZWQWJ2ZmRXOUdkWW9tZWhZVUhK?=
 =?utf-8?B?dHdMdHMzakVEbmhjUFFMKzZCR2craHpNVFg2UnpJL1hTaTJTVW1QRkxYdlRp?=
 =?utf-8?B?YmhUL2lEeVdBU0tqV1dUS1VUZVBmL0pFTStJMXhReE8xNmx3TGFLVzhSenhL?=
 =?utf-8?B?L1ZjaG9MQSsvcEZzMXNJZzI5cU4vRlZxdnVYcVBMNE5KYTlOOHd4QVd1Mi9T?=
 =?utf-8?B?Y1F5VlhyeFpqUGszTTlacWo1NlRHWlo3bDRZcDhFODl3UTlNbVVDK2RIS3h5?=
 =?utf-8?B?RHVEbmhIOXF2UXFESDZ2d0pHR09WN0ZrNm1VaW1pOVVDZkptaWJrSEFzQzg0?=
 =?utf-8?B?L1c1OVFUZ1FlMUhFekZWTlJYV2JvRmtXRXhtNEhPVXNVQm5kZWR4MVlCOWhp?=
 =?utf-8?B?ajFNZFJ5ZU5xRlRPdjI2bSs3YXI1ak93eThCRG41cDNXS25mcHRTWTF1eFA3?=
 =?utf-8?B?ZzNiZ0tWM0pKZzNJaDA1QTFYUVJMMGMrU0lYU3YrYVlvb0dWYVFMNWNSb2Vu?=
 =?utf-8?B?b3h3bUF0ZWJMN21MMElyWlgzSG5wUDBVcWZOU2Q2QmlWMzA2V3dLZDdIM3JI?=
 =?utf-8?B?RWhKT0FzOUxlelpZdHpmZ09CTjgyVFA4dEN1UGNHZXZrTlU1TG5KdjVmTFlV?=
 =?utf-8?B?SEVISWx5RGt5a1VsTENWZXRQUnhabGY2R1FyWkJFVzhYN0FFdlN5dWorMGZJ?=
 =?utf-8?B?VEh3Zmg3RUpoRWZLUU5BWnI0a0NvOSszdC9ONno1NUI3ekdXZjlKNVVwTXND?=
 =?utf-8?B?d0lmM2ZxNzFYM1lmVTIvazM2Q2RwbE0rOEx5NTZIM3I3VWRBaHFzU2svR0cr?=
 =?utf-8?B?T1lxRGlPeGVyQ0hsT2J3bHNXcllnVXltSE1TNStrMzlBM0JYWkdLOUtlcUs5?=
 =?utf-8?B?L01Oa2NZZHQ2aXZWRUlpQnFRSlB5N2pMbjUzdXJVNFFsWkg3R1Jmb1dEd3ly?=
 =?utf-8?B?bStTYXlka2RnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE1tYlkxekM5cFZjWUt1QmtibE13V2tBYjJJZ1M1MG1KbmZKOWNCSXdtbVZw?=
 =?utf-8?B?ZlY3aFcrZlIzeGt5cnh5eVlCajFEaUtHUUVXN2NSNmkySFIwZTVNTW9TS3dC?=
 =?utf-8?B?cmZKT0hTWFR5NWRPaWhPdm9IK3VkZ0lFcENSeWtTUVdzaHJZQThzWTZaSjc0?=
 =?utf-8?B?RUpFdmNrNlNtNytPTnVmZUR3d0ppSC9rZ2Z2aWtCY202UDJxTUNvakRmS3hS?=
 =?utf-8?B?K0NDZEhBaS9xa1VDenJUKzEybm95eUN0bXBaY0VWbEFvdmw4bkdoYVRTMGw4?=
 =?utf-8?B?eXB0ZmQxNU5XSjZzR3g0UklPTDVaYmxJemEvMSszdUxHOVpPMVhhT01nKzhG?=
 =?utf-8?B?d2pOTWl1bU5jUTlrQXBoOXQ2bG9GU2UvaUgxK2NXOXR6Y0tldm1PL3YySFJU?=
 =?utf-8?B?WGoxM0tURk5XT0JxMERndy9Veld0NkNPdXJYUGVkYTdpY2dSMTE1Nm1nQS8z?=
 =?utf-8?B?MnUraHg4Wm8vTThKamw2WnE1eXRQT1VQVklubkNzSWlyWVk0RURHU3FBWXFR?=
 =?utf-8?B?THZEdmI1QlBDSlB6WElJYWF0NnFqS0I1OWV3WmVPa2E4eEpXSEx0TkhDUjJJ?=
 =?utf-8?B?Q2ZoTHRJcDFOT2Q2T3hWZkxHTHZ5SkZTcS91R05VQXB5TnZwdEhRVDI3UFE0?=
 =?utf-8?B?VnlyWmFMb281bVFTUFE0NmRxcEI3VTBYN2pqOFdpeWVFcXJrRitPVStEcGFJ?=
 =?utf-8?B?SUFtNlFWUGZDaGNaaG1lRmtiL2VJbzRUK25IZVVtQjVadkVvRXBOeTMzVDVM?=
 =?utf-8?B?ZDV5ZFZvY0VzZGVBcFRjNHF5bDBDbDlPbm9tYllESWFZOFo5NjcrVzJCUFlu?=
 =?utf-8?B?STRtOXN2NjVLeTBXT1JpSHVURkFSMVNhQ0ZvVk9ENVFqRVdJU1IrUWRiVnVu?=
 =?utf-8?B?MjNPQjZ4VDZTeVdVckwyZnJOTXNRYW1hSG9rSVduTW52Sjk5VnBJUWJoUWtV?=
 =?utf-8?B?SkVTYWNXMVBLcyt0MVlXdkgrT01HaWVjMzZXNXB5ZUxLUFRPVlBVS3ZHMmEx?=
 =?utf-8?B?QjdYcVBqMlNjcyswYkdib1pEdEUvQzNPc3hwY3RGNjV1cDArcXo4ZXZ1WnFY?=
 =?utf-8?B?YjNmVXg3QUwxMjBNWTFZQ2Z4RDRJc3RvMHRLYm5uait0VGhqMDdlbHdnN0pO?=
 =?utf-8?B?VjZqQXZSakxzOHFVSHoyallOS2ZGRzByUHBTb0o3aEdpVEEvaTNpcHRXMU9z?=
 =?utf-8?B?TzNtSmJpbStwUmpPQ3UrWkNVS1pzcStyNU9LUThWU1ZXem1QRzJ3UkF5d1dX?=
 =?utf-8?B?Tm8rbFFvMTdhU2c0TGtsNFZ1ZVhIYjcyK1ZaQ0RITEhoNFZZTXR0anJIaW1l?=
 =?utf-8?B?S3cwZ29vMkl6MUh2YTh5MzVTcVZ1RnhtQ2RqV2l6c2E1QWVBVXNxU0hPZThv?=
 =?utf-8?B?N2gzTkxvcnhPbWpKZ1Y3SmplUGxBUkJWWXd5QTdCSFFiVGk0NDRSb0JpektP?=
 =?utf-8?B?N1l1a0grNlJqUlBYeTYrM1dMSDYzWHRpeEszMHREWk8yY1dxb1lFblJ3KzhF?=
 =?utf-8?B?VStTWFo2RlhXd2tMWWxMN1FlMU9nbXhOQ0M5SHBOaTV2NktPUU9GV0MxemZt?=
 =?utf-8?B?WUd2TENLUndJZEtpbmxFWHU1d2hnaGFsRzg2bkhLMnoxam1IVDc2UnZJL0Q3?=
 =?utf-8?B?K3ZTVmVqS0ErRTFJbWQyMkpGdWc2T1RDQ2NUVmNENXV0Z1QwVnZVMVBPTm1h?=
 =?utf-8?B?dnBrdTNscFU2SkpTMUpPZkVVWDR6a3V5YVdLT1B2NGxOdzJMT0lRdytkQVlw?=
 =?utf-8?B?OG1GZ3JqQklNdDk5QjBIOHlPZERNR1ZiZlg1YTBtVXl2VVZwNjBFMW95WU1J?=
 =?utf-8?B?TVVCdXRlMWlVVXZMWExLSjNVTkxFSjlzek8ydWhKZW1JUzBib1RUYUxCYnFj?=
 =?utf-8?B?MGNSNkVxSmptaEd2aGxvbTlVbzJYZndLUUI4YkxDWWM3TWlITXlpU3plQXJB?=
 =?utf-8?B?aEZsaks0Qk1sdGEyNUdkZllkUFBSblNmTHdRaHVSUEV1aXV0Yi9lOWVuV2Zx?=
 =?utf-8?B?Ynl1Yzh0VG44S3RUOTRSTUhYSTBFUUo2YXIyWEc3WUhzU3FVL0RtYzJhTEta?=
 =?utf-8?B?NlUyNGVPMzZPV1B1dFBzZDRCSVN6alRlZi91bVBsNGkyRUZzYk92VTlyTDVh?=
 =?utf-8?Q?L9zCNxCkV7O2OyscnpvQAUSVO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e80c0ac3-70ec-4295-55e4-08dd57054d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 08:04:03.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5scacJ9i1BqUHEpD+/vd48xpMBke9e6KrjDPJL4/llXRqc9SmuakE4zNMIh9oTCQLTk+ti5lEd3sfqUPYXI7lznIYXsLJl74VStDi8qyBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5494

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDEvM10gZHQtYmluZGluZzogY2xvY2s6IGFzdDI3MDA6
IG1vZGlmeSBzb2MwLzEgY2xvY2sNCj4gZGVmaW5lDQo+IA0KPiBPbiAyNi8wMi8yMDI1IDA2OjEw
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMS8zXSBkdC1i
aW5kaW5nOiBjbG9jazogYXN0MjcwMDogbW9kaWZ5IHNvYzAvMQ0KPiA+PiBjbG9jayBkZWZpbmUN
Cj4gPj4NCj4gPj4gT24gMjUvMDIvMjAyNSAxMDo0OSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAxLzNdIGR0LWJpbmRpbmc6IGNsb2NrOiBhc3QyNzAw
OiBtb2RpZnkNCj4gPj4+Pj4+IHNvYzAvMSBjbG9jayBkZWZpbmUNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBPbiAyNC8wMi8yMDI1IDEwOjU1LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4+Pj4gLXJlbW92
ZSByZWR1bmRhbnQgU09DMF9DTEtfVUFSVF9ESVYxMzoNCj4gPj4+Pj4+PiBTT0MwX0NMS19VQVJU
X0RJVjEzIGlzIG5vdCB1c2UgYXQgY2xrLWFzdDI3MDAuYywgdGhlIGNsb2NrDQo+ID4+Pj4+Pj4g
c291cmNlIHRyZWUgaXMgdWFydCBjbGsgc3JjIC0+IHVhcnRfZGl2X3RhYmxlIC0+IHVhcnQgY2xr
Lg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gLUNoYW5nZSBTT0MwX0NMS19IUExMX0RJVl9BSEIgdG8g
U09DMF9DTEtfQUhCTVVYOg0KPiA+Pj4+Pj4+IG1vZGlmeSBjbG9jayB0cmVlIGltcGxlbWVudC4N
Cj4gPj4+Pj4+PiBvbGRlciBDTEtfQUhCIHVzZSBtcGxsX2Rpdl9haGIvaHBsbF9kaXZfYWhiIHRv
IGJlIGFoYiBjbG9jaw0KPiBzb3VyY2UuDQo+ID4+Pj4+Pj4gbXBsbC0+bXBsbF9kaXZfYWhiDQo+
ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgLT4gY2xrX2FoYg0KPiA+Pj4+Pj4+IGhwbGwtPmhw
bGxfZGl2X2FoYg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJIGNhbiBiYXJlbHkgdW5k
ZXJzdGFuZCBpdCBhbmQgZnJvbSB0aGUgcGllY2VzIEkgZ290LCBpdCBkb2VzIG5vdA0KPiA+Pj4+
Pj4gZXhwbGFpbiBuZWVkIGZvciBBQkkgYnJlYWsuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+
PiAjMS4gU0NVMF9DTEtfVUFSVF9ESVYxMyBpcyByZWR1bmRhbnQsIGl0IGRvZXMgbm90IGltcGFj
dCBBQkkgYnJlYWsNCj4gPj4+Pg0KPiA+Pj4+IFlvdSBkaWQgbm90IGV4cGxhaW4gaG93IGl0IGRv
ZXMgbm90IGltcGFjdC4gQ2xvY2sgd2FzIGV4cG9ydGVkLA0KPiA+Pj4+IHRoZXJlIHdhcyBhIHVz
ZXIgYW5kIG5vdyB0aGVyZSBpcyBubyBjbG9jay4gVXNlciBzdG9wcyB3b3JraW5nLiBBQkkNCj4g
YnJlYWsuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBTb3JyeSwgU0NVMF9DTEtfVUFSVF9ESVYxMyB3
YXMgZGVmaW5lZCwgYnV0IHdhcyBuZXZlciByZWZlcmVuY2VkIGluDQo+ID4+PiBhbnkNCj4gPj4g
dXBzdHJlYW0gZGV2aWNlIHRyZWVzLg0KPiA+Pg0KPiA+Pg0KPiA+PiBUaGF0J3MgaW5jb21wbGV0
ZSBkZWZpbml0aW9uIG9mIEFCSQ0KPiA+Pg0KPiA+Pj4gU2luY2UgdGhlcmUgaXMgbm8gaW4tdHJl
ZSB1c2FnZSBvZiBgU0NVMF9DTEtfVUFSVF9ESVYxM2AsIGl0cw0KPiA+Pj4gcmVtb3ZhbCBkb2Vz
DQo+ID4+IG5vdCBjYXVzZSBhbiBBQkkgYnJlYWsuDQo+ID4+DQo+ID4+DQo+ID4+IFlvdSBpZ25v
cmVkIG91dCBvZiB0cmVlIHVzZXJzLiBQbGVhc2UgcmVhZCBjYXJlZnVsbHkgQUJJIGRvY3MuDQo+
ID4+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4+PiAjMi4gQ2hhbmdlIFNPQzBfQ0xLX0hQTExfRElWX0FI
QiB0byBTT0MwX0NMS19BSEJNVVggT2xkZXINCj4gPj4+PiBpbXBsZW1lbnQNCj4gPj4+Pj4gd2hl
cmUgYG1wbGxfZGl2X2FoYmAgYW5kIGBocGxsX2Rpdl9haGJgIHdlcmUgKipoYXJkY29kZWQNCj4g
Pj4+Pj4gZGl2aWRlcnMqKiBmb3INCj4gPj4+PiBBSEIuDQo+ID4+Pj4+IEluICoqdGhlIG5ldyBh
cHByb2FjaCAodjgpKiosIEkgcmVmYWN0b3JlZCB0aGUgY2xvY2sgdHJlZSB0byBjbG9jayB0cmVl
Lg0KPiA+Pj4+DQo+ID4+Pj4gSSBzdGlsbCBjYW5ub3QgcGFyc2Ugc2VudGVuY2VzIGxpa2UgInJl
ZmFjdG9yaW5nIEEgdG8gQSIuIEl0J3MNCj4gPj4+PiBtZWFuaW5nbGVzcyB0bw0KPiA+PiBtZS4N
Cj4gPj4+Pg0KPiA+Pj4+PiBJdCBzaG91bGQgYmUgQUJJLXNhZmUgY2hhbmdlDQo+ID4+Pj4NCj4g
Pj4+PiBObywgeW91IGRvIG5vdCB1bmRlcnN0YW5kIHRoZSBBQkkuIFlvdSByZW1vdmVkIGEgY2xv
Y2sgSUQsIHRoYXQncw0KPiA+Pj4+IHRoZSBBQkkgY2hhbmdlLg0KPiA+Pj4+DQo+ID4+Pj4gT3Ro
ZXJ3aXNlIGV4cGxhaW4gaG93IHRoaXMgaXMgbm90IGNoYW5naW5nIEFCSS4NCj4gPj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+IE9yIHlvdSB3YW50IHRvIGtlZXAgb3JpZ2luYWwgU09DMF9D
TEtfSFBMTF9ESVZfQUhCIGRlZmluZSBhbmQNCj4gdGhlbg0KPiA+Pj4+PiBhZGQNCj4gPj4+PiBT
T0MwX0NMS19BSEJNVVguDQo+ID4+Pj4+IFRvIGJlIDFzdCBwYXRjaCwgdGhlbiAybiBwYXRjaCBy
ZW1vdmUgcmVkdW5kYW50DQo+ID4+Pj4gU09DMF9DTEtfSFBMTF9ESVZfQUhCPw0KPiA+Pj4+DQo+
ID4+Pj4gSWYgeW91IGJyZWFrIHRoZSBBQkkgeW91IG5lZWQgdG8gY2xlYXJseSBleHBsYWluIHdo
eS4gV2UgaGF2ZSBsb25nDQo+ID4+Pj4gY29udmVyc2F0aW9ucyBhbmQgeW91IHN0aWxsIGRpZCBu
b3Qgc2F5IHdoeS4NCj4gPj4+Pg0KPiA+Pj4gU29ycnksIG15IHBvaW50IHdpbGwgYmUgZm9sbG93
aW5nIHN0ZXBzIHRvIGF2b2lkIHBvdGVudGlhbCBBQkkNCj4gPj4+IGlzc3VlcywgSSBjYW4gbW9k
aWZ5IHRoZSBwYXRjaCBzZXJpZXMgYXMgZm9sbG93czoNCj4gPj4+IDEuICoqUGF0Y2ggMToqKiBB
ZGQgYFNPQzBfQ0xLX0FIQk1VWGAgd2l0aG91dCByZW1vdmluZw0KPiA+PiBgU09DMF9DTEtfSFBM
TF9ESVZfQUhCYC4NCj4gPj4+IDIuICoqUGF0Y2ggMjoqKiBGaW5hbGx5IHJlbW92ZSBgU09DMF9D
TEtfSFBMTF9ESVZfQUhCYC4NCj4gPj4NCj4gPj4NCj4gPj4gSSBkbyBub3QgdW5kZXJzdGFuZCB3
aGF0IGNoYW5nZWQgaGVyZS4gWW91IHJlbW92ZSBleHBvcnRlZCBjbG9jaw0KPiA+PiB3aGljaCBp
cyBBQkksIHNvIGhvdyBpcyB0aGlzIGFuc3dlcmluZyBteSBxdWVzdGlvbi4NCj4gPj4NCj4gPj4g
WW91IGtlZXAgZG9kZ2luZyBteSBxdWVzdGlvbnMuIEhlcmUgSSBhc2tlZCAid2h5Ii4gSSBkbyBu
b3Qgc2VlIGFueQ0KPiA+PiBhbnN3ZXIgd2h5Lg0KPiA+DQo+ID4gQXBvbG9neSwgSSBjYW4ndCBj
YXRjaCB5b3VyIHBvaW50LiBCdXQgSSBzdGlsbCBuZWVkIHlvdXIgZ3VpZGVsaW5lLg0KPiA+DQo+
ID4gKipSZWdhcmRpbmcgYFNDVTBfQ0xLX1VBUlRfRElWMTNgOioqDQo+ID4gICAgLSBUaGlzIGNs
b2NrIElEIHdhcyBvcmlnaW5hbGx5IGRlZmluZWQgYnV0IHdhcyBuZXZlciB1c2VkIGluIGFueSBp
bi10cmVlDQo+IGRldmljZSB0cmVlcy4gKGkyYy1hc3QyNzAwLmMgdjEgfiB2OSkNCj4gPiAgICAt
IFNvIHRoZXJlIHNob3VsZCBub3QgaGF2ZSBBQkktYnJlYWsgYW0gSSBjb3JyZWN0Pw0KPiANCj4g
DQo+IE5vLCBiZWNhdXNlIHRoZXJlIGFyZSBvdGhlciB1c2VycyBvZiBiaW5kaW5ncy4gQWxsIGZv
cmtzLCBvdXQgb2YgdHJlZSBEVFMsIG90aGVyDQo+IHByb2plY3RzIGV0Yy4gWW91IGRlZmluZWQg
QUJJIGZvciB0aGVtLg0KPiANCj4gPg0KPiA+ICoqUmVnYXJkaW5nIGBTT0MwX0NMS19IUExMX0RJ
Vl9BSEJgIOKGkiBgU09DMF9DTEtfQUhCTVVYYDoqKg0KPiA+ICAgIC0gVGhlIHByZXZpb3VzIGlt
cGxlbWVudGF0aW9uIHVzZWQgZGl2aWRlcnMgKGBtcGxsX2Rpdl9haGJgLA0KPiA+IGBocGxsX2Rp
dl9haGJgKSBmb3IgQUhCIGNsb2NrIHNlbGVjdGlvbi4gKGkyYy1hc3QyNzAwLmMgdjEgfiB2OCkN
Cj4gPiBtcGxsLT5tcGxsX2Rpdl9haGINCj4gPiAgICAgICAgICAgICAgICAgICAtPiBjbGtfYWhi
DQo+ID4gaHBsbC0+aHBsbF9kaXZfYWhiDQo+ID4gICAgLSBUaGUgbmV3IGFwcHJvYWNoIHVzZSBg
U09DMF9DTEtfQUhCTVVYYCwgd2hpY2ggQUhCIGNsb2NrIHNvdXJjZXMNCj4gPiB2aWEgYSBtdXgu
IChpMmMtYXN0MjcwMC5jIHY5KQ0KPiA+IG1wbGwtPg0KPiA+ICAgICAgIGFoYl9tdXggLT4gZGl2
X3RhYmxlIC0+IGNsa19haGINCj4gPiBocGxsLT4NCj4gDQo+IFlvdXIgZm9ybWF0dGluZyBpcyBv
bmUgb2YgdGhlIHByb2JsZW1zIEkgaGF2ZSB0cm91YmxlcyB1bmRlcnN0YW5kaW5nIGl0Lg0KPiBB
Ym92ZSBpcyBub3Qgd3JhcHBlZCBvciB3cmFwcGVkIG9kZGx5LiBZb3Uga2VlcCB1c2luZyBib2xk
ICogYnV0IGRvdWJsZSAqKiwNCj4gd2hpY2ggaXMgbm90IGEgc3RhbmRhcmQgbWFya3VwLiBQbGVh
c2Ugc3dpdGNoIHRvIHN0YW5kYXJkIG1haWxpbmcgbGlzdA0KPiBmb3JtYXR0aW5nIC0gcHJvcGVy
IHdyYXBwaW5nLCBvbmx5IHRleHQgbW9kZSBhbmQgdXNlIGNsaWVudCB3aGljaCBhY3R1YWxseSBj
YW4NCj4gcGFyc2UgYW5kIGNyZWF0ZSB0aGF0Lg0KPiANCj4gV2hhdCBJIGRvbid0IHVuZGVyc3Rh
bmQgaXMgaG93IGNsb2NrcyBjb3VsZCBjaGFuZ2UgaW4gaGFyZHdhcmUuIFlvdSBkZXNjcmliZWQN
Cj4gaW1wbGVtZW50YXRpb24sIGJ1dCB0aGUgY2xvY2sgSURTIGRvIG5vdCBkZXNjcmliZSBpbXBs
ZW1lbnRhdGlvbiBidXQgdGhlIHRoZQ0KPiBtYXBwaW5nIHRvIHJlYWwgaGFyZHdhcmUgY2xvY2tz
LiBTbyBob3cgU09DMF9DTEtfSFBMTF9ESVZfQUhCIGNsb2NrDQo+IGRpc2FwcGVhcmVkIGZyb20g
aGFyZHdhcmU/DQoNClNvcnJ5LCBJdCdzIG5vdCBkaXNhcHBlYXJlZCwgaXQgaXMgcmVwbGFjZWQg
YnkgaW1wbGVtZW50Lg0KDQotIFRoZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiBoYXJkY29kZWQg
YG1wbGxfZGl2X2FoYmAgYW5kIGBocGxsX2Rpdl9haGJgIGFzIHRoZSBvbmx5IEFIQiBjbG9jayBz
b3VyY2VzOg0KICAgICBtcGxsIC0+IG1wbGxfZGl2X2FoYiANCgkJCQkJCS0+IGNsa19haGINCiAg
ICAgaHBsbCAtPiBocGxsX2Rpdl9haGI+IA0KDQotIFRoZSBuZXcgYXBwcm9hY2ggaW50cm9kdWNl
cyBgU09DMF9DTEtfQUhCTVVYYCwgY2xlYXIgY2xvY2sgdHJlZSBzZWxlY3Rpb24gb2YgQUhCIGNs
b2NrIHNvdXJjZXMgdmlhIGEgbXV4Og0KIFRoYW4gdGhyb3VnaCBkaXZfdGFibGUgdG8gZ2V0IGFo
YiBjbGsuDQogICAgIG1wbGwgLT4NCiAgICAgICAJCS0+IGFoYl9tdXggLT4gZGl2X3RhYmxlIC0+
IGNsa19haGINCiAgICAgaHBsbCAtPg0KDQo+IA0KPiA+ICAgIC0gQW5kIHNpbmNlIGkyYy1hc3Qy
NzAwLmMgKHY4KSBpcyBub3QgYXBwbGllZCwgc28gdGhlcmUgc2hvdWxkIGFsc28gbm8gb25lDQo+
IHVzZSB0aGlzIEFCSS4gQW0gSSBjb3JyZWN0Pw0KPiANCj4gSWYgYmluZGluZyB3YXMgbm90IGFw
cGxpZWQsIHRoZW4gd2hhdCBhcmUgeW91IGNoYW5naW5nIGhlcmU/DQoNCk15IHBvaW50IGlzIG9u
bHkgaTJjLWFzdDI3MDAuYyAodjgpIHVzZWQsIHdoaWNoIG5vdCBiZSBhcHBsaWVkIGluIExpbnV4
LiANCkFuZCBpMmMtYXN0MjcwMC5jICh2OSkgbm8gbmVlZCBhbnltb3JlLg0KDQo+IA0KPiBEb2Vz
IGl0IG1lYW4gaGVhZGVyIGRlc2NyaWJlZCBjbG9jayB3aGljaCB3YXMgaW4gdGhlIGhhcmR3YXJl
IGJ1dCBpdHMNCj4gaGFuZGxpbmcgd2FzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gdGhlIGRyaXZl
cj8NCj4gDQo+IA0KPiA+DQo+ID4gSWYgdGhpcyBpcyBub3QgYWNjZXB0YWJsZSwgbXkgbmV4dCBw
YXRjaCB3aWxsIGtlZXANCj4gU0NVMF9DTEtfVUFSVF9ESVYxMy9TQ1UwX0NMS19IUExMX0RJVl9B
SEIgZGVmaW5lLg0KPiANCj4gTWF5YmUgbXkgbGFzdCBtZXNzYWdlIHdhcyBub3QgY2xlYXIsIHNv
OiB5b3UgbmVlZCB0byBleHBsYWluIHdoeSB5b3UgYXJlDQo+IGJyZWFraW5nIEFCSSBhbmQvb3Ig
ZXhwbGFpbiB0aGUgQUJJIGltcGFjdCBpbiB0aGUgY29tbWl0IG1zZy4NClVuZGVyc3Rvb2QgeW91
ciBjb25jZXJuIGFib3V0IHRoaXMuDQpJIHRoaW5rIGFkZCBuZXcgU0NVMF9DTEtfQUhCTVVYIHRv
IGF2b2lkIEFCSSBpbXBhY3Qgd2lsbCBiZSB0aGUgYmV0dGVyIHdheS4NCg0KVGhhbmsgeW91ciBn
dWlkZWxpbmUuIA0KPiANCj4gPiBCdXQgYWRkIG5ldyBTQ1UwX0NMS19BSEJNVVggZGVmaW5lIGZv
ciBhdm9pZCB5b3VyIHBvaW50IEFCSSBicmVhay4gSXMNCj4gdGhpcyBhY2NlcHRhYmxlPw0KPiAN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

