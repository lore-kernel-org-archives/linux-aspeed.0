Return-Path: <linux-aspeed+bounces-276-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0001BE77184
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 03:04:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCdnx46kGz30ML;
	Wed, 18 Dec 2024 14:04:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::702" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734491093;
	cv=pass; b=CtMODaGA1aZh+rqT3wnUK/g/dpt7fD5HO00gikimsck6mJXWrL27weEn76H9fj8WsO5gWlOko3Ane5a6rau1TXgksu66LbI/Y0vbIzsV0FHGZt+q+wkBnvQeDpddN94iQqZgAwxdWgBddEaDTMPKo76SmSvlSnPM597ofNMA3eY2in0dc22HBcpDZNM6Gh26RhRkR+lthuWekxo6RLuh1pfLjq2jrZSsd0yPb4tDl/R5Q1OtvqC1/wgrinxCUBWpKfTMvf87uiEV4q0qFVHioOQKTfqL30Mmu4cNogYP+kmbfQ+R09+o9P1g10tIY5jRHyApZVfxik5sFWlgT/lRMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734491093; c=relaxed/relaxed;
	bh=DJ8+fA0qv9iwjZJ3zK9kXtKHmgrAD3mgBLN20FXLqmw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4Q3Af9sEOVDpuLrujPLF6FWCziUUWmKLg09arsJzB2urao+XnlRbSQXpi6pHccpnY+ve09QGTnJisFOu3RpuAUrakOWp4WsOUMExHpvQuIr3YdTKRkEeTM9Ug+8D8D6pq92joU5p/vPS6QuaGz/nv4MZ2rn2aepkxqcbA8gS0a8Z/Mw1DcBLHixl8vb7cgDucPbTxJiX92rbSYxKms/LP0GvCAm+RWrjH7IhiyH61kzXOGQUwE/JvRdnzqPODHGtFA8maNPKvXpL5gByeec3C0FDmWjOmhKd+7OGM5kmSuyQnMeDsaKI6SuOSJdyCtvPL/Rby+pqeIXJHMq88K9uw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=qXrKjjlG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::702; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=qXrKjjlG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:2011::702; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20702.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::702])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCdnw4PCNz30Gq
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 14:04:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuweD6ZnDHEglD3PWkSDeGEHqi14UFjBtYVru5hgqN/exHi2vCZwJ1dzivEqc1QO8iwFyvZeDemfuwW9g6SSnNOxweyCxJ9o3Tl0CrHyNShrADnbPB5EuiZtT8eEzLe3PrA8vrKF4gPcZytgt13tZlZJY/YSL4RgWfZCI1a/M0FzPOpjBuqaoR3vBlU7VMrYiLWLUnyz6donYkMePR96AVKaVmUeHWvedvHT7WSJaNwieX5QZE3Ap1FwbsJGfmWFdDlzWq4vaYxeHzlOiIsJohoUBgAqS5Bd4DzOwQQ8yFW6l1xjTHTQAUo6Xo7VRJmn5y+/s5/a+ASmxiVpwAfCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ8+fA0qv9iwjZJ3zK9kXtKHmgrAD3mgBLN20FXLqmw=;
 b=iYgL5u4DDY91hjO2rA/PlTBE+ii5A1WTKz3Syn/UVVF2KKlw0aog2vaU6EcCPQCsYezoaIXu6aDCUL1T+5evQJ+k1eXj1xDe9jK62KiMuTjXM+8+B2pSh5s1/PpYjz2Yb88ForwLKA7m6mLXaysUoMsbWs0aCQXX4ZNAaHCTBGBc+8EGr74kouUxRjpTLvuiZsgDCWUQBaznT6u/jrczXlywumSzArX/sv/ctBinmncSreGRG2GNhOSoNmsRJhRNfwpIJjmj05PtndHCFgqn71P7NhA3Jp5HFdBPt58DsPKCEWFVE9gKkrMtPY+k2gO03tCxXzZMFLtN7GXzemYTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ8+fA0qv9iwjZJ3zK9kXtKHmgrAD3mgBLN20FXLqmw=;
 b=qXrKjjlGn2G8FgaoamuExhS89B3Q7O+Ed7GE76pYrIk3OOv+Jm0OvGvdz2qCiP8aaB7PlXkCt3kvkaUsvz5DvWENw7DZAulobQPBkDqJfGpIGFgvwsHS8ASBrioImEXI0Xi2pzUeG7ykpNbLLIrFrvuGq8xnKA78HoiCCI/qi7Um3wRPoxTNlf5vDHYCWPd9JYurn2JSGXdjAXmhjUltNvQRZ29haLjWQcg6974ES4mCf9BHMLzpkTLjCXVNzjtKN8/Wy/0aMcEpTBB5rghjOXvX4SSNrVrqETzJRnHAXD3UNUIEIVueVsOIxV0S/v8oDhYUDvF449K9s1it9zbJ4Q==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5730.apcprd06.prod.outlook.com (2603:1096:400:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Wed, 18 Dec
 2024 03:04:32 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 03:04:32 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"konradybcio@kernel.org" <konradybcio@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Thread-Topic: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Thread-Index: AQHbTK3kC5Kg7l8oJUKHP7lHHpriK7Lj0FIAgAeH4iA=
Date: Wed, 18 Dec 2024 03:04:32 +0000
Message-ID:
 <PSAPR06MB4949CF57BD69B2F7C1D141CD89052@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-3-kevin_chen@aspeedtech.com>
 <11ad5a97-b066-4bea-8829-50e0416cea9d@kernel.org>
In-Reply-To: <11ad5a97-b066-4bea-8829-50e0416cea9d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5730:EE_
x-ms-office365-filtering-correlation-id: debb3a81-db08-4738-b47b-08dd1f10b21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mk02SVRhMzhKcGJaNTNFNlRldGEwMW1jNlZrVTFNRFdGRmxWdGxtN3k4a0c2?=
 =?utf-8?B?SWQvWlB1QUdLVTF3cGpmVzBPN2JHMVVYRUdLK0x1dElrNWV1TDByV21Kc3p1?=
 =?utf-8?B?YUh1NkNSeEh2VFVJcHA5K2J0SWZyU1R2cEpUaHBPQWdJcGtnYmViT3JKdVQ5?=
 =?utf-8?B?NHZXcHFoTi9UUlhVbFFMZ0c1V2FNY2h2L1UxNkJaUkNBakNTT2I2T3creGNN?=
 =?utf-8?B?NWtjbURWWWh0Nk11azIwalhJeUtEd0JqMjdVU3N3WXJuSTVtWUdSZS9tVTFy?=
 =?utf-8?B?NXA4NEkreG9BZ0tmeTBWRFBKQVpVWDNmUFd2eGd5WE5OeFNrTk93ajZLdjJ6?=
 =?utf-8?B?a2tOTmNabWsvNHlkZUQvL1c5WWRGa0RUK3FQRUJNckpyZXoyK3o1QWVTN2Zx?=
 =?utf-8?B?WDdXWndZRWM2cHRnR2VEZm92azZoTWl2U2ltbmExaFgvZXV4YXhILy96dUQy?=
 =?utf-8?B?WFNiSzlFaVJ5OG1LWkR0dXBjbFkxOTd2VXhYeStxMWNuKytiS3NaSEVGbFpR?=
 =?utf-8?B?Z1RSaUl2a2V5clFJWkNiREprSE94SmdtR0lpYTJaRHlhU0Y3UGdMd1FrL3Zv?=
 =?utf-8?B?MWR5L3h0QjliTlZiZ2dKNVhmSlpOSlZjVmVNcldMWEFacU4zNER1VzE5TDFh?=
 =?utf-8?B?THEzVlpmRTNLNlliRlhSb2VxMzMwVHppRjBxREJ1eDByeGtHbEVzU05GWDB5?=
 =?utf-8?B?MDZ4ZlZiWWtuZFR6ekdYa1ZsQzlYV092N3FKZ0xCYWx3VCtEU1VhOHJRc0sz?=
 =?utf-8?B?a0J2RnlFblp6L1Zma1p5aFFzOTdybyt1Y0s2bUFMY3VLdHlqRXJKOU5CdnBz?=
 =?utf-8?B?cnFQYksyazhyMGdYRDAwV3VycVAyekdPdmJFNUwyMFB5cm1TRFo2SzNDekU2?=
 =?utf-8?B?UzdTQm9HSmd1S3pxWk9UWnZIUWt3cDhSdVlCMTdNOGRodC8xN2NBaXExeWZY?=
 =?utf-8?B?UHo1REthVitRMHpTR3VneFBuT1BJanBLalZSNjBzT3RvaWU0aWcrS1gvSlRp?=
 =?utf-8?B?bGs4ZmFQUVdtcTBueVMrZkVJQjQyS0l1MlRBL00zbGpTeUxhOTNXbWIyZjA4?=
 =?utf-8?B?dkNpVjZacEpJNUVBMU1uRmY3VHZyc1dkR2l6TmZxaGwwR0x4eXE3WnB3UTdJ?=
 =?utf-8?B?RmhmRzdnVWlISStsM0M4aUhVTi81MmViMTNFOWErRzc4dmxqdTg1a2lWYlg1?=
 =?utf-8?B?KzlQbXJTTW5yY09ZQzVJN2lEVlZNMGZyN1hoMUl2N1k5ZnJlMnZDVVY3bERj?=
 =?utf-8?B?cUtablBkaDJ1ZThQVlhEUUZTQnBKOW9rSUtVRzVsajIvZ0Q2M0U4THBPWVNJ?=
 =?utf-8?B?ZVIrejk3TUljd2x6NWg5N1pMa2lBUUxIQnBralpWcXlFRXFDYzVlUmlhdklw?=
 =?utf-8?B?NlNtYWwrYVJXZzBTL29PR3VSNVp4a0FaVlhxQlhmN3ZqUjFBZldnS2lkYU5K?=
 =?utf-8?B?Nm1tSStKakFYayttbjFlNEdndUJZay9BQ053dzJUUGIyREJDbE5Nb1lHTFZH?=
 =?utf-8?B?MEdKMzB6U1FhMEUyeDgrOG9OcnRQNURGbHZvNlRrcXlmaUdCMGpweUZubEo5?=
 =?utf-8?B?UkJ3U0F1dGgwbVh5cVpjbGVoL0FwbmZNM1Y1dGZtc1VEVWM4aXg1VnJWTkNv?=
 =?utf-8?B?c2xtTnZPWWhaM0orRGdwTFl2dWFacjdEOHVYZVZGSklIUXNnaUxqN3hBWk5D?=
 =?utf-8?B?OGUyYmcrL1laWTRUdVB6OU9DaS9zaVQ2WlEwOGlDS21GcFFuSkFVMjVLOXFy?=
 =?utf-8?B?L1ZrYnM2ckFiOEl3RVVlWk9CRUVneDBJcFI0T2RZdjNCZEFtTUFkUHcrRnRZ?=
 =?utf-8?B?SmR1Y00vVTRsUmp3TGJ1WEpYVGpVQTZCV3FVOEdzRHk5UkxmMngwYWR5RFBC?=
 =?utf-8?B?cERsVTg5S2dSeUxsQ0l2dk1VQmtwK0FJNWREWHdmdURYMlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2RTZ1RpVjdQQU93eDM5MGFjTnBWQVo1SHY5R2hFbDhGSi9Sa3FVWCtwdTdC?=
 =?utf-8?B?R29HN2lBaTVWSTY5OEJ2QklnSmJ2QlEzTGg1aG54aFBrODlicHErNFZXWTdk?=
 =?utf-8?B?d3VmQ2E1RjZCeWd1M0RmL0dJUkxNaHR1OWZVZ09HT2JEbFAyWkhKclc1S1Rx?=
 =?utf-8?B?RDdnblc4OU84bUU1ZWNlRXdwRVZ6NEthN1RrZHJCWndNK0ZIYWFDOUE3SkZT?=
 =?utf-8?B?NVNrNTVkajJIdXZJY08wQnQvWlRkeHg2NXQxWGxxemZQOXpXSTEzQWhPejVE?=
 =?utf-8?B?a01KMWQ0Mkl0WEVVQ1MzZXZkcGYxYStOY0VGUmI2QWl1a0xGQ1FpZUk5SFp4?=
 =?utf-8?B?d3VBSFF0MU5IL1NTeDNnM0UxZ1NGWUR6by80cTZ1eEhVdFlzMDJNQzJFMDIy?=
 =?utf-8?B?SCt2OENid3BYNmRiaVhMa3dycEdWcjJ6dTBBT0ZyK1ArUDFYb3lqeCtNZHMy?=
 =?utf-8?B?L3VQQU9BM2wrOFB2SmdYQkNDalRlRFdMRmkwRG44d1FmaEUrYWQvS29RZmZj?=
 =?utf-8?B?QXB2d1UyQ01KNTZ1cUF3MG1qaWhoYU15S1prb1NNUGpQbHJ5TFIwZXdWNVJM?=
 =?utf-8?B?UFRQZ2hHOGpGRllCejFjdDkrOWVVaWFpdGVHdVV1K2tlYW02dnAwUEdVaXJ1?=
 =?utf-8?B?RW1DVGhScDhBQ1dzVWk4dkc4Yzh1OXl5N2diZEZodTdxaCtKU2lIeXV0cGcw?=
 =?utf-8?B?R3ZHN3dpZzVuZ3NqLzNhc0U5TjVubGI5eEVKNXYreXZzdUFhNi9ldjN6ZlhS?=
 =?utf-8?B?bmtWQ0J4U0g4cDl0S2tVbVlWS0hjSlhQOFVzTWhwaDhPVURRY3Z4MUl3a082?=
 =?utf-8?B?ODE4WWpWTlQxbXBZcm95RkZEOVFoQmlUaWtyRTk5aExEeVZkMGV4SDhkU2Zp?=
 =?utf-8?B?WC9uUG5XbVIvaTNlMi8yNWRHMVZrem5YbStNcGVxMkhKZEplL09jbGpUS0NW?=
 =?utf-8?B?cWJuU0NsZllZTVNuWU1IR2gySVpnczNSay9pckhLalJvTFBCaytyWDhndFdG?=
 =?utf-8?B?VEhEelR3S3c2a3VseG1CWjNwbzNLeTFFSHdXR2ZEY3ovUWN3KzJ0aUcyVld0?=
 =?utf-8?B?cGRFWUZjMjJRcnRnWWJYUFZZNVZXYm5mSklYMURmQTB2VDJiY2hadGFwNXdp?=
 =?utf-8?B?NVhTMkV2dnhKVitBTEh4OFdPTTlaYnFDcisya0xSd1Zya0kvRStYRzYzeUk5?=
 =?utf-8?B?VEtQOHVsbVBaMGZBOWVudW5kMGNhWC9vRjBudVU1aUhJMzZIZzJVaVg1S1pD?=
 =?utf-8?B?djZ4UVMrUnUrYWhzWmVrQWtqbWZhZElsNUdrbCtOM3VNVEdlQlhsVE5nYmMw?=
 =?utf-8?B?YStWY1p6Z3Byc1hjQWZ4QkhGOU5aY1hyYzJwdXNtbFNBMGlaRW9yWVFUanUw?=
 =?utf-8?B?Y2MwU0RSMFp0NlJLTjhxNDlGVXQ0VnBmZTUyQWxSQVhqcTlBTEQ1ajdkeURM?=
 =?utf-8?B?QSs5b3BWZUZQZDdqQ1hhS0dlcWhBREdVWXdaa1EvZE53RGYyaEdYN3JHdGNT?=
 =?utf-8?B?NFByWm9FdVVaQ052L0lVc3dBRTdkdnlXblphRUhxRTJaLzFpdFpMdHVhdy8z?=
 =?utf-8?B?ZXp1aG53a2lybEN5NlY3R3BVTEI4aG1RTno1Zkp4bVFmREJpMTF0bC9Meml2?=
 =?utf-8?B?VmVmNStWT2lUOTdQeGhTVXQ3elBSZjJvU0RzTnFESTY5ZGgyTG5xR2JGWXBJ?=
 =?utf-8?B?dzF4Rmd2VjlXclJoeEdHUFIzekRaZFdXMmlHNU9uQVpZSXZjeHltdi9CVnUx?=
 =?utf-8?B?Q0pJNG1BQytsVVBnRVZNaENHSEJpNjlvR3JEV1RQQ09mcEM0dktzNW8rREQr?=
 =?utf-8?B?NmFybWRtSlNuVkkrb2xZUUVRdzhFUFVXTFllSGFEcTBlS1JhOGhJYmU0bFFa?=
 =?utf-8?B?NldaVlZNWkhpV0FHdmFNTzdvR05TVzUxYk5XT2JlV2pBS2Q2MUMrVGtkdzEz?=
 =?utf-8?B?UzQ4UVdVRUZ2QUIxQkFEdDJaM29MQ2JpbWVtZEdyVkZsanljcEVmdmhEejNk?=
 =?utf-8?B?QVJWMWt4RG5JWW1UWWtCeWNES0kvWnVpa1k1M0g4SDhlUzJiaHROay9CR3Nu?=
 =?utf-8?B?YXU0c2xJdFdKTkFTOVBBc2V1T0Z2ZTREWkZhck83M3NCTzZ5bFNQNFB5MXBl?=
 =?utf-8?Q?yIuUWAsYnEd48IAWmQCQ1rLik?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: debb3a81-db08-4738-b47b-08dd1f10b21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 03:04:32.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14e9Gh15jShp1GKKFKKu71Ux1XGdig4YmP5v/YuxcgpbOVtRSLlwlukTuidvdmhO4M1/3yeUMc2NUp2f9sOFI22p5PtDOCZv7aL52ZFmdU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5730

SGkgS3J6aywNCg0KPiA+IDEuIEJlY2F1c2Ugc2l6ZS1jZWxscyBpcyBubyBuZWVkIHRvIHVzZSAy
LCBtb2RpZnkgdG8gMSBmb3IgdXNlLg0KPiANCj4gPz8/DQpTbywgaXMgaXQgT0sgdGhhdCBJIGNo
YW5nZSB0aGUgc2l6ZS1jZWxscyBiYWNrIHRvIDIgaW5jbHVkZSB0aGUgYXNwZWVkLGFzdDI3MDAt
aW50Yy55YW1sIGV4YW1wbGVzIGFuZCBhc3BlZWQtZzcuZHRzaT8NCg0KPiANCj4gPiAyLiBBZGQg
bWluSXRlbXMgdG8gMSBmb3IgaW50ZXJydXB0cyBmb3IgaW50YzEuDQo+IA0KPiA/Pz8NCkZvciB2
YXJpYWJsZSBpbnRlcnJ1cHQgbnVtYmVycywgSSBuZWVkIHRvIGZpeCB0aGUgYmVsb3cgd2Fybmlu
Z3MgYnkgbWluSXRlbXMuDQogIERUQyBbQ10gYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXN0
MjcwMC1ldmIuZHRiDQovaG9tZS9rZXZpbi9saW51eC1tYWlubGluZS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FzcGVlZC9hc3QyNzAwLWV2Yi5kdGI6IGludGVycnVwdC1jb250cm9sbGVyQDEwMDogaW50
ZXJydXB0cy1leHRlbmRlZDogW1szLCAwLCAzODQ0XV0gaXMgdG9vIHNob3J0DQogICAgICAgIGZy
b20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW50ZXJydXB0LWNv
bnRyb2xsZXIvYXNwZWVkLGFzdDI3MDAtaW50Yy55YW1sIw0KL2hvbWUva2V2aW4vbGludXgtbWFp
bmxpbmUvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXN0MjcwMC1ldmIuZHRiOiBpbnRlcnJ1
cHQtY29udHJvbGxlckAxMTA6IGludGVycnVwdHMtZXh0ZW5kZWQ6IFtbMywgMSwgMzg0NF1dIGlz
IHRvbyBzaG9ydA0KICAgICAgICBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL2FzcGVlZCxhc3QyNzAwLWludGMueWFtbCMN
Ci9ob21lL2tldmluL2xpbnV4LW1haW5saW5lL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2Fz
dDI3MDAtZXZiLmR0YjogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIwOiBpbnRlcnJ1cHRzLWV4dGVu
ZGVkOiBbWzMsIDIsIDM4NDRdXSBpcyB0b28gc2hvcnQNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJvbGxlci9hc3Bl
ZWQsYXN0MjcwMC1pbnRjLnlhbWwjDQovaG9tZS9rZXZpbi9saW51eC1tYWlubGluZS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3QyNzAwLWV2Yi5kdGI6IGludGVycnVwdC1jb250cm9sbGVy
QDEzMDogaW50ZXJydXB0cy1leHRlbmRlZDogW1szLCAzLCAzODQ0XV0gaXMgdG9vIHNob3J0DQog
ICAgICAgIGZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW50
ZXJydXB0LWNvbnRyb2xsZXIvYXNwZWVkLGFzdDI3MDAtaW50Yy55YW1sIw0KL2hvbWUva2V2aW4v
bGludXgtbWFpbmxpbmUvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXN0MjcwMC1ldmIuZHRi
OiBpbnRlcnJ1cHQtY29udHJvbGxlckAxNDA6IGludGVycnVwdHMtZXh0ZW5kZWQ6IFtbMywgNCwg
Mzg0NF1dIGlzIHRvbyBzaG9ydA0KICAgICAgICBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL2FzcGVlZCxhc3QyNzAwLWlu
dGMueWFtbCMNCi9ob21lL2tldmluL2xpbnV4LW1haW5saW5lL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YXNwZWVkL2FzdDI3MDAtZXZiLmR0YjogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTUwOiBpbnRlcnJ1
cHRzLWV4dGVuZGVkOiBbWzMsIDUsIDM4NDRdXSBpcyB0b28gc2hvcnQNCiAgICAgICAgZnJvbSBz
Y2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9pbnRlcnJ1cHQtY29udHJv
bGxlci9hc3BlZWQsYXN0MjcwMC1pbnRjLnlhbWwjDQoNCj4gDQo+ID4gMy4gQWRkIDEgaW50ZXJy
dXB0IG9mIGludGMxIGV4YW1wbGUgaW50byB5YW1sIGZpbGUuDQo+IA0KPiA+IDQuIEFkZCBpbnRj
MSBzdWItbW9kdWxlIG9mIHVhcnQxMiBhcyBleGFtcGxlIHVzaW5nIHRoZSBpbnRjMCBhbmQgaW50
YzEuDQo+IA0KPiBXaGF0IGlzIGFsbCB0aGlzPw0KPiANCj4gQlRXLCB0aGVyZSB3YXMgbm8gc3Vj
aCBwYXRjaCBpbiBwcmV2aW91cyB2ZXJzaW9uIGFuZCB5b3VyIGNoYW5nZWxvZyBpcyBzaWxlbnQN
Cj4gYWJvdXQgaXQuDQpBZ3JlZSwgSSB3aWxsIHJlc3RvcmUgdGhlIHByZXZpb3VzIHZlcnNpb24u
DQoNCj4gDQo+IFN1YmplY3Q6IGRyb3AgYWxsIGZ1bGwgc3RvcHMuIFN1YmplY3QgbmV2ZXIgZW5k
cyB3aXRoIGZ1bGwgc3RvcC4NCj4gDQo+ID4gLS0tDQo+ID4gIC4uLi9hc3BlZWQsYXN0MjcwMC1p
bnRjLnlhbWwgICAgICAgICAgICAgICAgICB8IDYwDQo+ICsrKysrKysrKysrKysrKy0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2FzcGVlZCxhc3QyNzANCj4gPiAwLWludGMueWFtbA0KPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2FzcGVlZCxhc3QyNzANCj4gPiAwLWludGMueWFtbCBpbmRleCA1NTYzNmQwNmE2NzQuLmVhZGZi
YzQ1MzI2YiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hc3BlZWQsYXN0MjcwDQo+ID4gMC1pbnRjLnlh
bWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXNwZWVkLGFzDQo+ID4gKysrIHQyNzAwLWludGMueWFtbA0KPiA+IEBAIC0z
MSw2ICszMSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIHR5cGUgYXMgZGVmaW5lZCBpbiBp
bnRlcnJ1cHQudHh0IGluIHRoaXMgZGlyZWN0b3J5Lg0KPiA+DQo+ID4gICAgaW50ZXJydXB0czoN
Cj4gPiArICAgIG1pbkl0ZW1zOiAxDQo+IA0KPiBOb3BlLCBub3QgZXhwbGFpbmVkLCBub3QgY29u
c3RyYWluZWQuIFlvdXIgc2NoZW1hIGlzIHN1cHBvc2VkIHRvIGJlDQo+IGNvbnN0cmFpbmVkLg0K
PiANCj4gDQo+ID4gICAgICBtYXhJdGVtczogNg0KPiA+ICAgICAgZGVzY3JpcHRpb246IHwNCj4g
PiAgICAgICAgRGVwZW5kIHRvIHdoaWNoIElOVEMwIG9yIElOVEMxIHVzZWQuDQo+ID4gQEAgLTY4
LDE5ICs2OSw1MiBAQCBleGFtcGxlczoNCj4gPiAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4NCj4gPiAgICAgIGJ1cyB7DQo+ID4g
KyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwx
PjsNCj4gPiArDQo+ID4gKyAgICAgIGludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMjEwMDAw
MCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJzaW1wbGUtbWZkIjsNCj4gPiArICAgICAg
ICByZWcgPSA8MCAweDEyMTAwMDAwIDB4NDAwMD47DQo+ID4gKyAgICAgICAgcmFuZ2VzID0gPDB4
MCAweDAgMHgwIDB4MTIxMDAwMDAgMHg0MDAwPjsNCj4gPiAgICAgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwyPjsNCj4gPiAtICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAtDQo+ID4gLSAg
ICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXJAMTIxMDFiMDAgew0KPiA+IC0gICAgICAgICAgICBj
b21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLWludGMtaWMiOw0KPiA+IC0gICAgICAgICAgICBy
ZWcgPSA8MCAweDEyMTAxYjAwIDAgMHgxMD47DQo+ID4gLSAgICAgICAgICAgICNpbnRlcnJ1cHQt
Y2VsbHMgPSA8Mj47DQo+ID4gLSAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPiA+
IC0gICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTkyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgMTkzIElSUV9UWVBF
X0xFVkVMX0hJR0g+LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgMTk0
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19TUEkgMTk1IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgPEdJQ19TUEkgMTk2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgPEdJQ19TUEkgMTk3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiANCj4g
DQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGlzIGFsbCB0aGlzLg0KPiANCj4gPiArICAgICAg
ICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArDQo+ID4gKyAgICAgICAgaW50YzBfMTE6IGludGVy
cnVwdC1jb250cm9sbGVyQDFiMDAgew0KPiA+ICsgICAgICAgICAgY29tcGF0aWJsZSA9ICJhc3Bl
ZWQsYXN0MjcwMC1pbnRjLWljIjsNCj4gPiArICAgICAgICAgIHJlZyA9IDwwIDB4MTIxMDFiMDAg
MHgxMD47DQo+ID4gKyAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiA+ICsgICAg
ICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4gKyAgICAgICAgICBpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgMTkyIChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gSVJRX1RZUEVfTEVWRUxf
SElHSCk+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE5MyAoR0lDX0NQ
VV9NQVNLX1NJTVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0hJR0gpPiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICA8R0lDX1NQSSAxOTQgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkgfA0K
PiBJUlFfVFlQRV9MRVZFTF9ISUdIKT4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19TUEkgMTk1IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpIHwNCj4gSVJRX1RZUEVfTEVWRUxfSElH
SCk+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE5NiAoR0lDX0NQVV9N
QVNLX1NJTVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0hJR0gpPiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICA8R0lDX1NQSSAxOTcgKEdJQ19DUFVfTUFTS19TSU1QTEUoNCkgfA0KPiA+
ICsgSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0KPiA+ICAgICAgICAgIH07DQo+ID4gKyAgICAgIH07
DQo+ID4gKw0KPiA+ICsgICAgICBpbnRjMTogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTRjMTgwMDAg
ew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLW1mZCI7DQo+ID4gKyAgICAgICAg
cmVnID0gPDAgMHgxNGMxODAwMCAweDQwMD47DQo+ID4gKyAgICAgICAgcmFuZ2VzID0gPDB4MCAw
eDAgMHgwIDB4MTRjMTgwMDAgMHg0MDA+Ow0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsNCj4gPiArICAgICAg
ICBpbnRjMV80OiBpbnRlcnJ1cHQtY29udHJvbGxlckAxNDAgew0KPiA+ICsgICAgICAgICAgY29t
cGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1pbnRjLWljIjsNCj4gPiArICAgICAgICAgIHJlZyA9
IDwweDAgMHgxNDAgMHgxMD47DQo+ID4gKyAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDI+
Ow0KPiA+ICsgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4gKyAgICAgICAgICBp
bnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZpbnRjMF8xMSA0DQo+IChHSUNfQ1BVX01BU0tfU0lNUExF
KDQpIHwgSVJRX1RZUEVfTEVWRUxfSElHSCk+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICAg
IH07DQo+ID4gKw0KPiA+ICsgICAgICB1YXJ0MTI6IHNlcmlhbEAxNGMzM2IwMCB7DQo+ID4gKyAg
ICAgICAgY29tcGF0aWJsZSA9ICJuczE2NTUwYSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MCAw
eDE0YzMzYjAwIDB4MTAwPjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZp
bnRjMV80IDE4IChHSUNfQ1BVX01BU0tfU0lNUExFKDQpDQo+IHwgSVJRX1RZUEVfTEVWRUxfSElH
SCk+Ow0KPiA+ICsgICAgICAgIHJlZy1zaGlmdCA9IDwyPjsNCj4gPiArICAgICAgICByZWctaW8t
d2lkdGggPSA8ND47DQo+ID4gKyAgICAgICAgbm8tbG9vcGJhY2stdGVzdDsNCj4gPiArICAgICAg
fTsNCj4gDQo+IEFuZCBhYm92ZSBpcyBub3QgcmVsYXRlZCBhdCBhbGwuIERvbid0IGFkZCBlbnRp
cmVseSB1bnJlbGF0ZWQgY2hhbmdlcy4gRHJvcC4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbi4gQ2hlbg0K

