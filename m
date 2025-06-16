Return-Path: <linux-aspeed+bounces-1465-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258DC71135
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 06:33:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLKvl6Gpjz2xfB;
	Mon, 16 Jun 2025 16:33:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750055619;
	cv=pass; b=bDpe2QOeQXf0BETH5bsOFQM+c7yOK1pt0+MCvPlQN+UsLTXCjnV+dxu8ix+DW8tGUgp1Sl/xgDR5W46hFAAJk4hPY2w00KOtXtM4jr9rikiAdmQgXvw/QlYWg4jcuVPPvo9kuQuJ3wRuC+RUDzdhv2A379lYlmGADPfP741VMIM6mBAl5O/ccGocldI4/w7ZXHYfZ1HCfc0uHU+uJHimN4DQmMPeYEVrRGRw7gW6SO31jED0i0nBGS/8nINzYcpWza0XFBSJ8zcpIs3XkjSKR4nC6R07G7Q8B4tdvAHFsAtJFevXWihnxww7DVeeJ5xCA6Oer59TSuuNUNciWRWomA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750055619; c=relaxed/relaxed;
	bh=b5a8/LOM0IQ/0Erd5r8AlPGrJlrIQdSw8VUjQQEBnqQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDPcS7DNwc8VO7Nu+sIEE6AXTHMq6jy0Nxoir6Tp8q/0z1LDbovc2ykqGQ1IpQewEB67VLiy3ChRuQoJeKyCCBiQtbgOit8sMo+XOMadHREhUd2VlqlsISK2CHnJOa9DNEEKAMTnkmKDXHcgbhZZrs2Wt6c4BaNXYEY10j5yDOVL7aEhqzTQdymtIiFiHs/EbFPfwt/eRx/KwFZxbbRyxbc3o1CbZSOORKcZZn6y081UJNdLfZ2Um6FQdjb/BcGOoIgVOf99UnZhKQrdvIzKDZg2JpI0CcT0A5lW+u0uIQ72vm2dwn+HldKhuj4g1nE6sSbrXjiiu8V33BHq7kKDmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLKvV5HlQz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 16:33:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsAvdu3hmj5+tT+kJLT5hGo0jR5ahm735VPbFQo8692YXlOzlD2wAjbjRzjxGM390LqzuK85fTQj1FxSlpnnt8ofqzjHNRPWQYOlHsUTWAR74YrGbT8iJflBfp9jtYlHfrjESQvg+iaMuCGLJ0XaY8Qd0BsI+qCgy5yo7vvdHJh9vzE0rP1fOEHIor18cT/K9O002H+SgqTXFPAmy9GtsEV7kAU2W6tLi3vFyNuZlhfyBYAZUKceNew4jHsLVg7BW2Dp702TK91J7GzcySdLxmgB35BVlKLmtbUUuR9/qVXkeG13lV27bCVN9fTvVS7wWXoZHRr+cxwZoQNN6DCxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5a8/LOM0IQ/0Erd5r8AlPGrJlrIQdSw8VUjQQEBnqQ=;
 b=Hu/FW6LiJgzKhBjZKHczAUgkSGS5ps1maMxVfrBqL+xt511Z/1ry39uS9VssJ2gKiKV5LCCZZag3+UQnEfYFz9cmSNDBPffsGNtQc7K6B+DLOb+Wv5qXpUf9M6QBVRLD6trRGN6vUc2B1U7OtYo7Ouus7KIClEsr9Rg1FDLG8ELaIP1pZcB1m1FFK1RttdLnACpqoFJV68ae/kBwB4UDR8XyMz660oVq6rxF49oEfrczAdcm7ytMHJP225owBfS3QqNXeAuTAPnMvYO/rbluBtPChrzQaG9bLEckxwPyzSDk3MLV44qWI0XaJ0WFWdnKoEVyoiAqwyvIoUB95qpURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5a8/LOM0IQ/0Erd5r8AlPGrJlrIQdSw8VUjQQEBnqQ=;
 b=HS78OAey5xrTlDMwzlqHMgSzysy2zwmtKhkT5xEb8czgbnn9/ksQrFr/0mqc6S1f9XaMds5dmQH0ZquqRIGh3m2vy5O2h5l3FWq2kMc2n4/XyUtfIXWVo9UWjgx+LlAJxBL0c3Gim995cXpu3nJpbXd/kwRqJYMZ3hGAZWVDNw2m5quEVNzUAnh6nmvRGAF6cCrIH54datXZ7Z6SjpXEobZ+f3aLIEBWYde7vJK5Yeqnrv0t+EeUmR3LQ84+2F5fKDgMXI0H7hdqQgUXouIle9t4SPF6IYweoDgRB+kU1s1bbtEBe9f/QfFZW99gMk03sNfflvpf7fK5wEqzyFddrw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6916.apcprd06.prod.outlook.com (2603:1096:405:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 06:32:42 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 06:32:42 +0000
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
 AQHb24IeM0HrrMksj0qjPEmThyghWrP/T4SAgAEHZPCAAEdfgIAEbCrggABKjgCAAAPQYA==
Date: Mon, 16 Jun 2025 06:32:42 +0000
Message-ID:
 <OS8PR06MB7541645F6A0638FC250B1272F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
 <OS8PR06MB7541A100B918AAA84D1ABDCAF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <749c581e-cc00-428f-8eb9-222f9d574486@kernel.org>
 <OS8PR06MB7541FFCA9E28E5767791D869F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e39b5259-db92-4269-84c9-d51e8e4f327e@kernel.org>
In-Reply-To: <e39b5259-db92-4269-84c9-d51e8e4f327e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6916:EE_
x-ms-office365-filtering-correlation-id: de3aaebb-44e5-4b74-c4ce-08ddac9f98df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnhJSHhneWRXQVlmd09XS1lCV3hrZHM2QkpuSkxqNGMxcStibTNWVGxTME4x?=
 =?utf-8?B?Wit1a1JWSnFVR2VLK1RVcERQRityODNDMmNIK2tEaFFjN3dPSTYveTlpZTlo?=
 =?utf-8?B?M2xZUms1KzR5MzFWVkFvZU1zRTJ0QmxxbjBZZkhGQzJJT0xzM1ZDTEtMTDY1?=
 =?utf-8?B?bkUySkdETkR0YW51WEFMcEJrQU9MT0FzVkdqZEVUdllGOUFQVzVidVhtMTVD?=
 =?utf-8?B?SUJWWklGcDNZKzFuaDNySkRGTkhjZzBsQ2RHSGhacjdpK2t4MjQ4WGduNHpT?=
 =?utf-8?B?cnp6b2pVdllxZU56YXpCK29TVHlWNnZtcngwTnNySTh5MzY2RnlpdjNhYXpl?=
 =?utf-8?B?ZEIxUXl1S25CQk9kam1iWDNBOWducnI5RTBEUjI2czE3UkU3Uk5mU3ZVa0pU?=
 =?utf-8?B?ZVZiOERMaGZWQmxKd2xrb01ETTFXbUxOZmE5d2dPdmNlc25Rd3hhSlBkampD?=
 =?utf-8?B?SFk3NFhiV3pxRFI0V1lsWGwzTERmM2pIL2xZWktpcXVvdWFudHlRR3VBUlFa?=
 =?utf-8?B?eDdGeE9GNDRtOEthTG9FTDNtRy8za2xqOElvZ0VGcHB1eVFVcjZwTlg3b1B3?=
 =?utf-8?B?cVBTOE1TVE5IbkprdUVidm9taDlsZ0VTUHBJY3R3dUVTakhpVDdjRjR6R3Fy?=
 =?utf-8?B?dFY0VVV0c09FYWl2Y3hxTzVnY0Y0dG92MVpsdXQzdlJhMFNlMlZITXBGRWZx?=
 =?utf-8?B?VjZoenlsanVtMGxWRng3eEFHUHEwalNVN0poS21MZjBpSmVpMWVXOWpBSVNI?=
 =?utf-8?B?NVNodWFFQVlDS1JoRStZcStOenQvZmYvUnBYYXMrS3RrMFpzQ2s5dGlyNVIx?=
 =?utf-8?B?eHFEMEoyM0MzMWRlTXUzbTVBdldCRkdjNjE0V3dYMnNMUm83citxNnBzY2NH?=
 =?utf-8?B?cVZ6bUF2bVd5SU42TklDdkNvVlRsbzE2M3d6Wi8zd0crZnJLN0NjTm1KRkw0?=
 =?utf-8?B?cGpyR2tLWmxmM0Q3eXFlTEtRUnNORkM2TTZrVDY4S3lwUEkrOFFRMzRyTnBR?=
 =?utf-8?B?QytpSVlRUDNtS0x3V2pBY3VBV1diZkN1eWl0dVBSL1hENE1pLytRZy9UQ0FP?=
 =?utf-8?B?OEFuR3BvZktwbjhWWmtKcHI1LzBJMmlaVjNEN2xJU1FRcVhobEp4UDcyOTJq?=
 =?utf-8?B?R0Q4TU03WUJuTTExNU1qRjZqcGhzcklic3pDc05sMzZ5MWY0aXFFK2dCOUln?=
 =?utf-8?B?ZDZDcWJDMWJIdGp1cFlrTlZMMGpzYWR4eXpDbnJ6K1BscXJZNGMzcHg5R2VT?=
 =?utf-8?B?amZpcnRURFloeVk1SVJCajdVMHR0YUtFNTdlUUV6YWpiTFFYcE03dndFcmE5?=
 =?utf-8?B?cVppVHBmUmI5RVFHU1ZmYU9OdXJSSG4vYURFNEc5c2p5akJkSU5ITWNWRDU0?=
 =?utf-8?B?WTdkMmZ6VkorVDZ5S2RwNkh1M3NGdkYvcjhRbUQ4Z2hMNTVORVhiSXhYdWp2?=
 =?utf-8?B?OXUxUHVhcmYyS0Nkc1dzVUNSTE9sMlBHUHlZaytvSHYyWjZRZXc2T0FINUxp?=
 =?utf-8?B?bll3UElxTEh1ZTNvL09TbmtEaHpiSzNDY0s5bGVKc3E4N3NZSkp0bmtmdGZS?=
 =?utf-8?B?Zkswb2dBK0ZFaUhqUXlDNFkzUW9lRllXYVkrbkZsK1MwRFIxRlRNcEdwWHdJ?=
 =?utf-8?B?QlQ4bmptMnNPTW0zQzkwblJxaVJUcWpGcnlwcXlkNU5yclVFQyt1S05uL3ox?=
 =?utf-8?B?RjQwQjBiaTFwdlFWRGNMZE5DUmJqejh0UEVWZ0xxdm16eGZkK3ZyTFpXazZj?=
 =?utf-8?B?SmNiSmVIYmpna0htc2tDcjlyTjFBbDF5M0FDeWZlVUhpN3hhQVVKVnVYVUFn?=
 =?utf-8?B?cCt4Q29mN01tZDVPQjFQSlNTVDdNY3Q0bVlHYmxwTE5Fb1NwTHJzTXdSSHFi?=
 =?utf-8?B?VStxM2xaUC8zelp2bWJhRkEycjRZOHJlMUN0Z3pWdzQzK3ZoY2RxMTVXMHBF?=
 =?utf-8?B?KzlndXpOWTV3Y2lOMithV0RydFcwNExpeTdZZjl3V2FJZDJKbnVvQVpMYzB3?=
 =?utf-8?B?WTd0eDB3dG9zYnpyU1NaVSs2MnlLL0RZVEJ5NDhXVFFZNEZLbkNHOWh4N0Nm?=
 =?utf-8?Q?jvAJx6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0ptZnNmUm8xNndURGdSVkZkd0Q2akkxUWtGUCtLTVNRcTY4TncxSjhxY05D?=
 =?utf-8?B?bGtDVnBpZW10UWxCdk1TZXFjb0MxS213Q0pEZkxBMlpBelJGc2Ivai9jbWx3?=
 =?utf-8?B?Qnl4Z1drTnFCNVlWZmxFWC9TaFFXSHBIZGtUQWZPa1JSV3NkWXo3RUU2V0g5?=
 =?utf-8?B?SEZZL3J1b2NtdHNMck41d0NMWE9pVDJXYlFNbDhiSzlEZ0JocHVQWjJZejVI?=
 =?utf-8?B?cllUbEVGVXpidFdHZVdHVW8zRE1FaWRFajdpZEFDdkcvSlovVnZISkErTmJG?=
 =?utf-8?B?WXN1eDZtSThWcEhEMmZMcmJtSjArdERhTHVaREVIU0RoNXhYVE9zWlp5dkFM?=
 =?utf-8?B?R2UrM0FKR01NUXYwWGJyeEF6ajFITjRreFc1cEpTUmNlbCtsOFkxOXZRcmVX?=
 =?utf-8?B?YTlkbm9nRkl6MUNPakJqOVBqMHV0c0tGYWdtM0F5d3FKRERBaU41dzBSYXl2?=
 =?utf-8?B?T2EwdllrOGN4S0lBL0V3d3hLNG5uV0NsMEJndDNHQ09OOU5vdmV4b2ZtNGth?=
 =?utf-8?B?ZmxtUDBPNUR5dVEzK3BTTiswU0Iyc2t4OVF1czFpK0VSdUFuR1ZPRTRFcjhY?=
 =?utf-8?B?dGE1UUtsZmxOemRzUDhOWE92SldESEcyRG1QY3lHQmUyeUNGeUhsbzhKTWFQ?=
 =?utf-8?B?M1QzZFVXQzBMWTA2cTVTMmV4Y2RUMVUxRUlVcjZXMGVtQ252TVZnT3p5ZEFT?=
 =?utf-8?B?c3JzOUZ5SS9YSHBmU0tQVWZiWjZTR01WQ2xmTEFlWmZRK1RwUWRzSzBURCtN?=
 =?utf-8?B?N0tlUGRTSWZJMUxEZkQ3MEx3MjVocm5tczJaR0FqQjc0bUVEVGt0MGtGVHlq?=
 =?utf-8?B?RjVCNHFDSVR1cUNzYUEya1FlYkJ2SEYwaEpEeUd2bjRya0pCUTJMMWczdGxN?=
 =?utf-8?B?Mlo3WTgwb2NUL1h3M1lvSGh3TVZFR09meDdBTVJvdHF4dUp5dERhb3FEVEQ4?=
 =?utf-8?B?cGl4NTNCeFJ3TzhoSDBnZnJFN0E5TURHVlV2V0ZHd05mUEV0eWsxZldLRE96?=
 =?utf-8?B?QVp1dzBYbnFZRG9jZWRYZWZJaEJLNm9YQ1U4ajBoSWtPRmx4eTVEelBVTVZY?=
 =?utf-8?B?bVpOaDF1N3JXV3p0TEh4R3RodWVXMmZYVnJFNWh1TVh5V05NZ2x3UmkyQmhZ?=
 =?utf-8?B?WjlOcVIxQlpBMkRudDlwRXZvZVByMHlBNDBjbmtHZ3hLVitmU0hTVS9VeUQ4?=
 =?utf-8?B?RkxHRC9UTkxTaXUyejVsamphZFR5c2hHK3owRXUzMUxwSS9yaUErWWl1Tldp?=
 =?utf-8?B?cUZXdzE2N3hCMElGNDJmb3QxMWgxOGhnR1hFNGJJMERTQXVPR2h1Qm9zQVU0?=
 =?utf-8?B?WFNXNGdrdWQ2RnZHVXZJQUU1QWlOcXV1bmw1blN1T1JwVmxkd2pHSjF1aC9q?=
 =?utf-8?B?SGFoT1dpNU5RV2k5clozaU42b0V0ZVozcWM3ck5jSDdIbHIxSWJ1OHoraGRp?=
 =?utf-8?B?WnBrS25Nb3dsRG9aTVdObjRCNWFTVUtOWU1Qd2xiVnA5L295WXA4NFdKN3pZ?=
 =?utf-8?B?MHlPdFRRRFhKTm5rWjdEeTVZM24vS2VqWlp0MzF0K0hTWUVYQXVDcnVqVFpL?=
 =?utf-8?B?U2NEdnR0a1pnVk5NUmdiWW1nN3pwNHl1MXNmWUg3SVJOUHk2dmxGVVdMUkxt?=
 =?utf-8?B?SFIvYk9aQVBFdVlydDJINTZhZ0dVTGJ3T0hLTTBlWFNwbkJocm1objFYMXBk?=
 =?utf-8?B?WmVhZ0pqcnpReGRkSERIdUhHU2RpUEgva1ROZUlIUVFIZ09odmoxK0JIQTIy?=
 =?utf-8?B?RGZGOWZ1RUlGNXZ4azgyM3JVQ3dxUzZaeTdTRWtmUmlzcERIeUIybVB2NDJx?=
 =?utf-8?B?NHc0WWgzcFNBUVhaMnkxcVhCZk5LYVB4VjdEOUJ3eGUrek42clVtSThMcXEv?=
 =?utf-8?B?SlNaMmZSRzI4Sm1UT3pTeWcyVlZhbmRBYUV3aE1GNnlORXN5eTQyTmsvREVs?=
 =?utf-8?B?TzA3TnhpL3FHWFl5K1huY2FJUENNNU9ITGY2OG1ZejhtSjVPSTRKL0N1Mk1o?=
 =?utf-8?B?dExQaTd2K3VRWEpmL1hpVzhHOVk4OFpYSWN3aDBRQUJwR25jdWpEeU0zTWp1?=
 =?utf-8?B?R0VUYmg0eTVYbUgwd2Z4YlphMW94L0FYZkdlVCtlUzdlWXZoNVc5SHlzOTBL?=
 =?utf-8?Q?tt8i0s+7gclexzsTqx4sIVmCh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de3aaebb-44e5-4b74-c4ce-08ddac9f98df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 06:32:42.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXyajdjVFF3pqHevJk2gZXyBvcX3aPPRpe5CuNQsAqxbfvGBShsgmiFb1ZhQSSuoBHuerXYuN0tGkJL33SivUnjqmtHxd5QW2kMMXmY4lso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6916

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gMTYvMDYvMjAyNSAwNDoy
NCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYwIDMvNV0gYXJt
NjQ6IGR0czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyNzAwDQo+ID4+IFNvQyBkZXZpY2UgdHJl
ZQ0KPiA+Pg0KPiA+PiBPbiAxMy8wNi8yMDI1IDA0OjI5LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MCAzLzVdIGFybTY0OiBkdHM6IGFzcGVlZDogQWRkIGlu
aXRpYWwgQVNUMjcwMA0KPiA+Pj4+IFNvQyBkZXZpY2UgdHJlZQ0KPiA+Pj4+DQo+ID4+Pj4gT24g
MTIvMDYvMjAyNSAxMjowOSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+PiBUaGlzIGFkZCB0aGUg
aW5pdGlhbCBkZXZpY2UgdHJlZSBzdXBwb3J0IGZvciB0aGUgQVNQRUVEIEFTVDI3MDAgU29DLg0K
PiA+Pj4+Pg0KPiA+Pj4+PiAtIEFkZCB0b3AtbGV2ZWwgY29tcGF0aWJsZSBzdHJpbmcgImFzcGVl
ZCxhc3QyNzAwIiBhbmQgc2V0IHVwDQo+ID4+Pj4+IGFkZHJlc3MtY2VsbHMvc2l6ZS1jZWxscyBm
b3IgNjQtYml0IGFkZHJlc3Mgc3BhY2UuDQo+ID4+Pj4+IC0gRGVzY3JpYmUgYSBxdWFkLWNvcmUg
QVJNIENvcnRleC1BMzUgQ1BVIGNsdXN0ZXIgd2l0aCBMMiBjYWNoZSwNCj4gPj4+Pj4gaW5jbHVk
aW5nIGNhY2hlIHByb3BlcnRpZXMgYW5kIFBTQ0kgZW5hYmxlLW1ldGhvZC4NCj4gPj4+Pj4gLSBB
ZGQgUE1VIGFuZCBBUk12OCB0aW1lciBub2RlcyB3aXRoIGNvcnJlY3QgUFBJIGludGVycnVwdCB3
aXJpbmcuDQo+ID4+Pj4+IC0gTW9kZWwgdGhlIGR1YWwtU29DIGFyY2hpdGVjdHVyZSB3aXRoIHR3
byBzaW1wbGUtYnVzIG5vZGVzOg0KPiA+Pj4+PiBzb2MwIChAMHgxMDAwMDAwMCkgYW5kIHNvYzEg
KEAweDE0MDAwMDAwKS4NCj4gPj4+Pj4gLSBBZGQgc3lzY29uIG5vZGVzIGZvciBib3RoIFNvQ3Mg
KHN5c2NvbjAsIHN5c2NvbjEpIHdpdGgNCj4gPj4+Pj4gY2xvY2svcmVzZXQgY2VsbCBkZWZpbml0
aW9ucyBhbmQgYWRkcmVzcyBtYXBwaW5nLg0KPiA+Pj4+PiAtIEFkZCBHSUN2MyBpbnRlcnJ1cHQg
Y29udHJvbGxlciBub2RlIHVuZGVyIHNvYzAsIHdpdGggZnVsbA0KPiA+Pj4+PiByZWdpc3RlciBt
YXBwaW5nIGFuZCBpbnRlcnJ1cHQgcHJvcGVydGllcy4NCj4gPj4+Pj4gLSBIaWVyYXJjaGljYWwg
aW50ZXJydXB0IGNvbnRyb2xsZXIgc3RydWN0dXJlOg0KPiA+Pj4+PiAgIC0gaW50YzAgdW5kZXIg
c29jMCwgd2l0aCBjaGlsZCBpbnRjMF8xMSBub2RlLg0KPiA+Pj4+PiAgIC0gaW50YzEgdW5kZXIg
c29jMSwgd2l0aCBjaGlsZCBpbnRjMV8wfmludGMxXzUgbm9kZXMuDQo+ID4+Pj4+IC0gQWRkIHNl
cmlhbDQgbm9kZSB1bmRlciBzb2MwLCBvdGhlcnMgc2VyaWFsIG5vZGUgdW5kZXIgc29jMS4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9hc3Bl
ZWQvYXNwZWVkLWc3LmR0c2kgfCAzODANCj4gPj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDM4MCBpbnNlcnRpb25zKCspICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPj4+Pj4gYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0c2kN
Cj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVk
L2FzcGVlZC1nNy5kdHNpDQo+ID4+Pj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNw
ZWVkLWc3LmR0c2kNCj4gPj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+Pj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5kMTk3MTg3YmNmOWYNCj4gPj4+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4+
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtZzcuZHRzaQ0KPiA+Pj4+
PiBAQCAtMCwwICsxLDM4MCBAQA0KPiA+Pj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXIgI2luY2x1ZGUNCj4gPj4+Pj4gKzxkdC1iaW5kaW5ncy9jbG9jay9h
c3BlZWQsYXN0MjcwMC1zY3UuaD4NCj4gPj4+Pj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNl
dC9hc3BlZWQsYXN0MjcwMC1zY3UuaD4NCj4gPj4+Pj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKy8gew0K
PiA+Pj4+PiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+Pj4+PiArCSNzaXplLWNlbGxzID0g
PDE+Ow0KPiA+Pj4+PiArCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4+Pj4+ICsNCj4g
Pj4+Pj4gKwljcHVzIHsNCj4gPj4+Pj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4+Pj4+
ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJCWNwdTA6IGNwdUAw
IHsNCj4gPj4+Pj4gKwkJCWRldmljZV90eXBlID0gImNwdSI7DQo+ID4+Pj4+ICsJCQljb21wYXRp
YmxlID0gImFybSxjb3J0ZXgtYTM1IjsNCj4gPj4+Pj4gKwkJCXJlZyA9IDwweDAgMHgwPjsNCj4g
Pj4+Pj4gKwkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4+Pj4+ICsJCQlpLWNhY2hlLXNp
emUgPSA8MHg4MDAwPjsNCj4gPj4+Pj4gKwkJCWktY2FjaGUtbGluZS1zaXplID0gPDY0PjsNCj4g
Pj4+Pj4gKwkJCWktY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPiA+Pj4+PiArCQkJZC1jYWNoZS1zaXpl
ID0gPDB4ODAwMD47DQo+ID4+Pj4+ICsJCQlkLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4+
Pj4+ICsJCQlkLWNhY2hlLXNldHMgPSA8MTI4PjsNCj4gPj4+Pj4gKwkJCW5leHQtbGV2ZWwtY2Fj
aGUgPSA8JmwyPjsNCj4gPj4+Pj4gKwkJfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCQljcHUxOiBj
cHVAMSB7DQo+ID4+Pj4+ICsJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPiA+Pj4+PiArCQkJY29t
cGF0aWJsZSA9ICJhcm0sY29ydGV4LWEzNSI7DQo+ID4+Pj4+ICsJCQllbmFibGUtbWV0aG9kID0g
InBzY2kiOw0KPiA+Pj4+PiArCQkJcmVnID0gPDB4MCAweDE+Ow0KPiA+Pj4+PiArCQkJaS1jYWNo
ZS1zaXplID0gPDB4ODAwMD47DQo+ID4+Pj4+ICsJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47
DQo+ID4+Pj4+ICsJCQlpLWNhY2hlLXNldHMgPSA8MjU2PjsNCj4gPj4+Pj4gKwkJCWQtY2FjaGUt
c2l6ZSA9IDwweDgwMDA+Ow0KPiA+Pj4+PiArCQkJZC1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0K
PiA+Pj4+PiArCQkJZC1jYWNoZS1zZXRzID0gPDEyOD47DQo+ID4+Pj4+ICsJCQluZXh0LWxldmVs
LWNhY2hlID0gPCZsMj47DQo+ID4+Pj4+ICsJCX07DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwkJY3B1
MjogY3B1QDIgew0KPiA+Pj4+PiArCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gPj4+Pj4gKwkJ
CWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hMzUiOw0KPiA+Pj4+PiArCQkJZW5hYmxlLW1ldGhv
ZCA9ICJwc2NpIjsNCj4gPj4+Pj4gKwkJCXJlZyA9IDwweDAgMHgyPjsNCj4gPj4+Pj4gKwkJCWkt
Y2FjaGUtc2l6ZSA9IDwweDgwMDA+Ow0KPiA+Pj4+PiArCQkJaS1jYWNoZS1saW5lLXNpemUgPSA8
NjQ+Ow0KPiA+Pj4+PiArCQkJaS1jYWNoZS1zZXRzID0gPDI1Nj47DQo+ID4+Pj4+ICsJCQlkLWNh
Y2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+Pj4gKwkJCWQtY2FjaGUtbGluZS1zaXplID0gPDY0
PjsNCj4gPj4+Pj4gKwkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+Pj4+PiArCQkJbmV4dC1s
ZXZlbC1jYWNoZSA9IDwmbDI+Ow0KPiA+Pj4+PiArCQl9Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJ
CWNwdTM6IGNwdUAzIHsNCj4gPj4+Pj4gKwkJCWRldmljZV90eXBlID0gImNwdSI7DQo+ID4+Pj4+
ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTM1IjsNCj4gPj4+Pj4gKwkJCWVuYWJsZS1t
ZXRob2QgPSAicHNjaSI7DQo+ID4+Pj4+ICsJCQlyZWcgPSA8MHgwIDB4Mz47DQo+ID4+Pj4+ICsJ
CQlpLWNhY2hlLXNpemUgPSA8MHg4MDAwPjsNCj4gPj4+Pj4gKwkJCWktY2FjaGUtbGluZS1zaXpl
ID0gPDY0PjsNCj4gPj4+Pj4gKwkJCWktY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPiA+Pj4+PiArCQkJ
ZC1jYWNoZS1zaXplID0gPDB4ODAwMD47DQo+ID4+Pj4+ICsJCQlkLWNhY2hlLWxpbmUtc2l6ZSA9
IDw2ND47DQo+ID4+Pj4+ICsJCQlkLWNhY2hlLXNldHMgPSA8MTI4PjsNCj4gPj4+Pj4gKwkJCW5l
eHQtbGV2ZWwtY2FjaGUgPSA8JmwyPjsNCj4gPj4+Pj4gKwkJfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+
PiArCQlsMjogbDItY2FjaGUwIHsNCj4gPj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAiY2FjaGUiOw0K
PiA+Pj4+PiArCQkJY2FjaGUtbGV2ZWwgPSA8Mj47DQo+ID4+Pj4+ICsJCQljYWNoZS11bmlmaWVk
Ow0KPiA+Pj4+PiArCQkJY2FjaGUtc2l6ZSA9IDwweDgwMDAwPjsNCj4gPj4+Pj4gKwkJCWNhY2hl
LWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4+Pj4+ICsJCQljYWNoZS1zZXRzID0gPDEwMjQ+Ow0KPiA+
Pj4+PiArCQl9Ow0KPiA+Pj4+PiArCX07DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlhcm0tcG11IHsN
Cj4gPj4+Pj4gKwkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWEzNS1wbXUiOw0KPiA+Pj4+PiAr
CQlpbnRlcnJ1cHRzID0gPEdJQ19QUEkgNyAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+ID4+
Pj4gSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0KPiA+Pj4+PiArCX07DQo+ID4+Pj4+ICsNCj4gPj4+
Pj4gKwlwc2NpIHsNCj4gPj4+Pj4gKwkJY29tcGF0aWJsZSA9ICJhcm0scHNjaS0xLjAiOw0KPiA+
Pj4+PiArCQltZXRob2QgPSAic21jIjsNCj4gPj4+Pj4gKwl9Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICsJdGltZXIgew0KPiA+Pj4+PiArCQljb21wYXRpYmxlID0gImFybSxhcm12OC10aW1lciI7DQo+
ID4+Pj4+ICsJCWludGVycnVwdHMgPSA8R0lDX1BQSSAxMyAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0
KSB8DQo+ID4+Pj4gSVJRX1RZUEVfTEVWRUxfTE9XKT4sDQo+ID4+Pj4+ICsJCQkgICAgIDxHSUNf
UFBJIDE0IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gPj4+PiBJUlFfVFlQRV9MRVZFTF9M
T1cpPiwNCj4gPj4+Pj4gKwkJCSAgICAgPEdJQ19QUEkgMTEgKEdJQ19DUFVfTUFTS19TSU1QTEUo
NCkgfA0KPiA+Pj4+IElSUV9UWVBFX0xFVkVMX0xPVyk+LA0KPiA+Pj4+PiArCQkJICAgICA8R0lD
X1BQSSAxMCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+ID4+Pj4gSVJRX1RZUEVfTEVWRUxf
TE9XKT47DQo+ID4+Pj4+ICsJCWFybSxjcHUtcmVnaXN0ZXJzLW5vdC1mdy1jb25maWd1cmVkOw0K
PiA+Pj4+PiArCQlhbHdheXMtb247DQo+ID4+Pj4+ICsJfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiAr
CXNvYzA6IHNvY0AxMDAwMDAwMCB7DQo+ID4+Pj4+ICsJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1
cyI7DQo+ID4+Pj4+ICsJCXJlZyA9IDwweDAgMHgxMDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gPj4+
Pj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4+Pj4+ICsJCSNzaXplLWNlbGxzID0gPDE+
Ow0KPiA+Pj4+PiArCQlyYW5nZXM7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwkJc3lzY29uMDogc3lz
Y29uQDEyYzAyMDAwIHsNCj4gPj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI3MDAt
c2N1MCIsICJzeXNjb24iLA0KPiA+PiAic2ltcGxlLW1mZCI7DQo+ID4+Pj4+ICsJCQlyZWcgPSA8
MHgwIDB4MTJjMDIwMDAgMHgxMDAwPjsNCj4gPj4+Pj4gKwkJCXJhbmdlcyA9IDwweDAgMHgwIDAg
MHgxMmMwMjAwMCAweDEwMDA+Ow0KPiA+Pj4+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+
ID4+Pj4+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPj4+Pj4gKwkJCSNjbG9jay1jZWxscyA9
IDwxPjsNCj4gPj4+Pj4gKwkJCSNyZXNldC1jZWxscyA9IDwxPjsNCj4gPj4+Pj4gKwkJfTsNCj4g
Pj4+Pj4gKw0KPiA+Pj4+PiArCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDEyMjAwMDAwIHsN
Cj4gPj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGdpYy12MyI7DQo+ID4+Pj4+ICsJCQlyZWcg
PSA8MCAweDEyMjAwMDAwIDB4MTAwMDA+LCAvKiBHSUNEICovDQo+ID4+Pj4+ICsJCQkgICAgICA8
MCAweDEyMjgwMDAwIDB4ODAwMDA+LCAvKiBHSUNSICovDQo+ID4+Pj4+ICsJCQkgICAgICA8MCAw
eDQwNDQwMDAwIDB4MTAwMD47ICAvKiBHSUNDICovDQo+ID4+Pj4+ICsJCQkjaW50ZXJydXB0LWNl
bGxzID0gPDM+Ow0KPiA+Pj4+PiArCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4+Pj4+ICsJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19QUEkgOSAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+ID4+
Pj4gSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0KPiA+Pj4+PiArCQkJaW50ZXJydXB0LXBhcmVudCA9
IDwmZ2ljPjsNCj4gPj4+Pj4gKwkJfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCQlzZXJpYWw0OiBz
ZXJpYWxAMTJjMWEwMDAgew0KPiA+Pj4+PiArCQkJY29tcGF0aWJsZSA9ICJuczE2NTUwYSI7DQo+
ID4+Pj4+ICsJCQlyZWcgPSA8MHgwIDB4MTJjMWEwMDAgMHgxMDAwPjsNCj4gPj4+Pj4gKwkJCWNs
b2NrcyA9IDwmc3lzY29uMCBTQ1UwX0NMS19HQVRFX1VBUlQ0Q0xLPjsNCj4gPj4+Pj4gKwkJCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSA4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+Pj4+PiArCQkJ
cmVnLXNoaWZ0ID0gPDI+Ow0KPiA+Pj4+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPj4+
Pj4gKwkJfTsNCj4gPj4+Pj4gKwl9Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJc29jMTogc29jQDE0
MDAwMDAwIHsNCj4gPj4+Pj4gKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPj4+Pj4g
KwkJcmVnID0gPDB4MCAweDE0MDAwMDAwIDB4MTAwMDAwMDA+Ow0KPiA+Pj4+PiArCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCj4gPj4+Pj4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4+Pj4+ICsJ
CXJhbmdlczsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCQlzeXNjb24xOiBzeXNjb25AMTRjMDIwMDAg
ew0KPiA+Pj4+PiArCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1zY3UxIiwgInN5c2Nv
biIsDQo+ID4+ICJzaW1wbGUtbWZkIjsNCj4gPj4+Pj4gKwkJCXJlZyA9IDwweDAgMHgxNGMwMjAw
MCAweDEwMDA+Ow0KPiA+Pj4+PiArCQkJcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MTRjMDIwMDAg
MHgxMDAwPjsNCj4gPj4+Pj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+Pj4+PiArCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4+Pj4+ICsJCQkjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4+
Pj4+ICsJCQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4+Pj4+ICsJCX07DQo+ID4+Pj4+ICsNCj4g
Pj4+Pj4gKwkJc2VyaWFsMTI6IHNlcmlhbEAxNGMzM2IwMCB7DQo+ID4+Pj4+ICsJCQljb21wYXRp
YmxlID0gIm5zMTY1NTBhIjsNCj4gPj4+Pj4gKwkJCXJlZyA9IDwweDAgMHgxNGMzM2IwMCAweDEw
MD47DQo+ID4+Pj4+ICsJCQljbG9ja3MgPSA8JnN5c2NvbjEgU0NVMV9DTEtfR0FURV9VQVJUMTJD
TEs+Ow0KPiA+Pj4+PiArCQkJaW50ZXJydXB0cy1leHRlbmRlZCA9DQo+ID4+Pj4+ICsJCQkJPCZp
bnRjMV80IDE4IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gPj4+PiBJUlFfVFlQRV9MRVZF
TF9ISUdIKT47DQo+ID4+Pj4+ICsJCQlyZWctc2hpZnQgPSA8Mj47DQo+ID4+Pj4+ICsJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPiA+Pj4+PiArCQl9Ow0KPiA+Pj4+PiArCX07DQo+ID4+Pj4+ICt9
Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsmc29jMCB7DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGlzIHRo
ZSBiYXNlIERUU0ksIHRoZXJlIGlzIG5vIGV4aXN0aW5nIG5vZGUgdG8gb3ZlcnJpZGUuIEp1c3QN
Cj4gPj4+PiBkZWZpbmUgY29tcGxldGUgU29DIG5vZGUgaW4gb25lIHBsYWNlIGxpa2UgZXZlcnkg
b3RoZXIgdmVuZG9yLg0KPiA+Pj4NCj4gPj4+IE15IG9yaWdpbmFsIGlzIHVzZSB0aGlzIHdheSwg
YnV0IHdoZW4gSSBkbyBjaGVja3BhdGNoLCBnZXQNCj4gPj4+IENIRUNLOiBsaW5lIGxlbmd0aCBv
ZiAxMDYgZXhjZWVkcyAxMDAgY29sdW1ucy4NCj4gPj4+IGludGVycnVwdHMgPSA8R0lDX1NQSSAx
OTIgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkgfA0KPiA+Pj4gSVJRX1RZUEVfTEVWRUxfSElHSCk+
LCBUaGF0IHRoZSByZWFzb24gbW9kaWZ5IGJ5IHRoaXMgd2F5Lg0KPiA+Pg0KPiA+PiBMb29rIGhv
dyBvdGhlciByZWNlbnQsIG1vc3QgZGV2ZWxvcGVkIHBsYXRmb3JtcyBkbyBpdCBhbmQgbGVhcm4g
ZnJvbQ0KPiA+PiB0aGVtIGluc3RlYWQgb2YgY29taW5nIHdpdGggb3duLCBjb25mdXNpbmcgc3R5
bGUuDQo+ID4NCj4gPiBUaGFua3MsIEkgd2lsbCByZWZlciB0aGlzIHRvIG1vZGlmeS4NCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvYXJjaC9hcm02NC9i
b290L2R0cy9icm9hDQo+ID4gZGNvbS9iY20yNzEyLmR0c2kjTDU4MC1MNTg5DQo+ID4+DQo+ID4+
Pg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+Pj4gKwlpbnRjMDogaW50ZXJydXB0LWNvbnRyb2xsZXJA
MTIxMDAwMDAgew0KPiA+Pj4+PiArCQljb21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KPiA+Pj4+
DQo+ID4+Pj4gTkFLLCBuZXZlciB0ZXN0ZWQuDQo+ID4+Pj4NCj4gPj4+PiBOb3QgYWxsb3dlZCwg
c2VlIGJpbmRpbmdzLiBBbmQgdGVzdCBpdCBuZXh0IHRpbWUuDQo+ID4+Pg0KPiA+Pj4gR290IGl0
LCB3aWxsIHVwZGF0ZSBieSBmb2xsb3dpbmcuDQo+ID4+PiBJbnRjMDogYnVzQDEyMTAwMDAwIHsN
Cj4gPj4+ICAgICAgICAgY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPj4+ICAgICAgICAg
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4+PiAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0K
PiA+Pj4gICAgICAgICByZWcgPSA8MCAweDEyMTAwMDAwIDB4NDAwMD47DQo+ID4+PiAJCXJhbmdl
cyA9IDwweDAgMHgwIDB4MCAweDEyMTAwMDAwIDB4NDAwMD47DQo+ID4+PiAJCSNhZGRyZXNzLWNl
bGxzID0gPDI+Ow0KPiA+Pg0KPiA+PiBEb2VzIG5vdCBmb2xsb3cgRFRTIGNvZGluZyBzdHlsZSBh
bmQgYW55d2F5LCB3aGF0IHNvcnQgb2YgYnVzIGlzIHRoaXM/DQo+ID4NCj4gPiBTb3JyeSwgZm9y
IG1pc3MtbGVhZC4gaW50YzAgaXMgbGlrZSB0aGUgZ2xvYmFsIGJhc2UgZm9yIGludGUwXzExDQo+
IGludGVycnVwdC1jb250cm9sbGVyLg0KPiANCj4gU28gdGhhdCdzIG5vdCBhIGJ1cywgdGh1cyBk
byBub3QgdXNlIHNpbXBsZS1idXMgZm9yIHRoYXQuIERlZmluZSBiaW5kaW5ncyBmb3INCj4geW91
ciBkZXZpY2UuDQo+IA0KPiA+IFNvLCBJIHVzZSBzaW1wbGUtbWZkLg0KPiA+ICAgICAgICBpbnRj
MDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIxMDAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KPiA+IAkJCQkJLi4uLi4NCj4gPiAgICAgICAgICAg
ICAgICAgaW50YzBfMTE6IGludGVycnVwdC1jb250cm9sbGVyQDFiMDAgew0KPiA+IAkJCQkJLi4u
Li4uDQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4gICAgICAgICB9Ow0KPiA+DQo+ID4gQnV0
IEkgZG9uJ3Qga25vdyB5b3VyIHByZXZpb3VzICJOQUssIG5ldmVyIHRlc3RlZCIgbWVhbi4NCj4g
PiBJIGRpZCBtYWtlIENIRUNLX0RUQlM9eSBhcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC8gZG9u
J3Qgc2VlIHRoZSBmYWlsDQo+ID4gd2l0aA0KPiA+IGludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxl
ckAxMjEwMDAwMCB7DQo+ID4gCWNvbXBhdGlibGUgPSAic2ltcGxlLW1mZCI7DQo+ID4NCj4gPiBT
bywgY291bGQgeW91IHBvaW50IG1lIG1vcmUgdGVzdCBpbnN0cnVjdGlvbiBmb3IgdGhpcz8NCj4g
U2VlIHN5c2Nvbi55YW1sLiBBbmQgd3JpdGluZyBiaW5kaW5ncyBvciB0YWxrcyBvbiBjb25mZXJl
bmNlczoNCj4gc2ltcGxlLW1mZCBjYW5ub3QgYmUgYWxvbmUuDQo+IA0KDQogICAgICAgIGludGMw
OiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMjEwMDAwMCB7DQpTb3JyeSwgZG8geW91IG1lYW4gYWRk
IGJ5IGZvbGxvd2luZz8gDQoJCQkJIGNvbXBhdGlibGUgPSAiYXNwZWVkLGludGMtY29udHJvbGxl
ciIsICJzaW1wbGUtbWZkIjsNCiAJCQkJCS4uLi4uDQogICAgICAgICAgICAgICAgIGludGMwXzEx
OiBpbnRlcnJ1cHQtY29udHJvbGxlckAxYjAwIHsNCgkJCQkJY29tcGF0aWJsZSA9ICJhc3BlZWQs
YXN0MjcwMC1pbnRjLWljIjsNCiAJCQkJCS4uLi4uLg0KICAgICAgICAgICAgICAgICB9Ow0KICAg
ICAgICAgfTsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

