Return-Path: <linux-aspeed+bounces-977-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8AAC282DE
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Mar 2025 00:22:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBZGS6yVsz2yYJ;
	Tue, 11 Mar 2025 11:22:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::721" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741652560;
	cv=pass; b=DlBq2oiRQsj94odoyTGgd+NxeXZeciMuFo4UawHFfzxxEBdhxjHEDWoQsXdvgo99a3ErkTZEV+nvoQH+5LEsVf1bPnMPLvnpw4oY8lxQE6P+2Gvw4mMrbhICDotfno3YaqwokUPPCSauaRqVDvTIog1sb3xYOt1+zCbRYF4W4VuxEYcTSfABJzcu60Hr0eR7/kgJpKcu/rI246pTeXM5cGBgaS/WcCzk4nLAh3wgctDti1BcX5pg+Gfth9ahWSViGyuQLUv+tcq79x9frk6gvqG2OUi2mqbZ9S5yN89dLK/lxQfLTA8JoMCnD++L/RDcP1AKLBxUQg0giapyCLuEiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741652560; c=relaxed/relaxed;
	bh=5vMaE/fdvF9sFNBr7UnIPHG1fKu9VfjvL1nK5zvhU/0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dX3iaT1fA+4lB63lz7FMM+x+MRm+ErP4bFdK4ADlJ1driOKWdKCHwDYEzMWfZsIjS9LcVeZt4qzP405dSEqalvKsTdLmai1iNptWUqjnJnBCU6b2Ghc3q0pdOAKW4Tblo78+fJe9DZhXb5zS9ffmzKJ/E5Hczf4C/Mo5Q+3bhk1NVfAs1snwKPTjpLQmOc4OMcrqww0k36wgt5eyxkV1EHts4H5IzTY4nTdzGAClKeqzoTJNStGtjt008iT+KNHNFz3qok+4ztqUG+1iT1iDbo4E3OUj2kaMhCXvq9MfcS5EKDcu/G7h4y9GJP3h9J9emX6F5yH2umYRTBfKZvzxoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=GJcqNkuE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::721; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=GJcqNkuE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:2011::721; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20721.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::721])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBZGS0ZmNz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Mar 2025 11:22:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZv/vXZyqwemP2Vxwe2heTfeisqMB0VecowcL9dps1ubaPBzyGcjfe8yE8PRJ9GoQAKk6kaFAKV3jJ+rSqipYUTOd5bRCfn0tSlN06dghZFXQgtRPPBUBsL6hjz8nxPqCX5Kx7q644iJ6tWcdbuiBk9st52Tekbnplpbc2oJL8V2OU3IOiwcBlZnCa7ivDmOrD4O/HIfYy/fZbbo+Q6JmQYjmxA4KlU74dDJ9amIPzc4PBUw/CJQ4mqsHFVyuuq4BsBNrq/q/H0QpRHmRC0QMJFv2jMKVOVhV9/UXfizUz4mvPzQw9pBKmksFMj2uHYBz7eZ17JmEzoFng5gSIj9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vMaE/fdvF9sFNBr7UnIPHG1fKu9VfjvL1nK5zvhU/0=;
 b=Zd+vfrUCaeZ+gNpTFixQLphOIDROLXmCY/Rp/jRLKdmnkWQOqkOWa57ZhNMzampbd7AwVfk8CkCPhWnMld/Dj5Te+pWRBluWcX8CbocCjwz2sioCtxtEbDUGaa8OlE+vLYbdZChO5ZQu03JnyXkBF2UWE1z95YMU3gbfMYkVfbtnezCWmEbMJqijf6kEMK2dmFtOK6WihSKEy8IXOj1j4+gkPwECSfjtLPwF1GX2AJWznbMQvdQ5z3YdmFdorcvDf68K/aO32y66RrTA3GqtPYEZr+H/aKp8CaQTs3wHngKX/8/yUmRSvZCKlvxuQaZGynjRgX8w31nvGLY/jVnFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vMaE/fdvF9sFNBr7UnIPHG1fKu9VfjvL1nK5zvhU/0=;
 b=GJcqNkuEYPMJ0tkGTxajskjhZ6OpPf6KgXAKm3xc/sKlFt0WqfaaW3z1g7mi68oRjll6IRXN1Ia4jE4IogBP6JK/xo7LpZ1gsvRU/xedAamu+gvKI/+BFoXJ/ZtNxUhNgJq7nFhYe17a5tvSKNCRZ4KroytmlXvRDnc5O2/nyejeJ/alVUMgkh9mXmmRyQ/w5RVgJ/YYukFVdV57H1ASvAJSr7qqfwuhMqdVDxmd4Ft8eCAEay43OclMYHgySF/v40Em4EEPJHOOVRjiFdNIKWxaCzvGfX8kMLGpJ2FemDvxqn0VgWSg8rGm5ZFG8+1LbGap/uaOtbXnkGoJkGl74A==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5494.apcprd06.prod.outlook.com (2603:1096:400:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 00:22:18 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 00:22:18 +0000
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
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
Subject: RE: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Topic: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Index:
 AQHbjPJy2F3uXFUe20eiIvujFTWQbbNkGJyAgAeEr9CAAGEtAIAAJ+fwgAAitoCAANMbsA==
Date: Tue, 11 Mar 2025 00:22:18 +0000
Message-ID:
 <PSAPR06MB49493E890869FE5B3650A7AB89D12@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
 <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
 <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <e17cdf9d-ba96-41d2-9656-9e50d0e0795a@kernel.org>
 <TY0PR06MB496045B19DCB149EC902D0FF89D62@TY0PR06MB4960.apcprd06.prod.outlook.com>
 <a12afc26-2e8e-42cc-ac68-27ba8906707f@kernel.org>
In-Reply-To: <a12afc26-2e8e-42cc-ac68-27ba8906707f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5494:EE_
x-ms-office365-filtering-correlation-id: 061dcb1c-b375-46c8-3a4a-08dd6032c855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDFMcXlpMTZlQW9nU215dmw3cFpoUktBcEQ3aFhlSWRmQitlK1d5OCtpd3VC?=
 =?utf-8?B?TFhSUzBHeUJxd05XelUzNHIxZ0ZrN3V3SHFYeTZwSlZwSnZzcU5wUnhQMzZl?=
 =?utf-8?B?dmo2SWgxa3hHUFdPd0dFemt2VDMxaVpXd3kzbXRiSlRkN04zNlRYU0xrZWty?=
 =?utf-8?B?Sk5BaDd3L2RrVUExTHZnM2J1ZUpDb3U2ZzZpZFN4S2hicUpsa000ZEwwbVkx?=
 =?utf-8?B?OW0yR2c4QnVEM2FiSGdXdWI4UkRUdmE2VWxGeWtJaGdiQi8vMjJqZjI2U1JR?=
 =?utf-8?B?SnRjalVUdTltajRRTGVTTU0yN3lTUkRNYUdUN2FYVFNVQ1JnOE80UUR0YVY2?=
 =?utf-8?B?cHpvR29xUkJYZTV4dzd4QU5rN0g5K1lCVElRVHhwZ2JORENwQUlsZzJ2cmho?=
 =?utf-8?B?YmJlanZKNjFCMWIxaUdHazNabUd0WHFWdXBsOG94RGh2QjVqK01XdEt0b0Va?=
 =?utf-8?B?N08xZnp2L1NGSEpWVUt6ZnI4R3hHNEhreGtqa21aRVVLWXh6YjdHRXhJTE5l?=
 =?utf-8?B?VWZNM0FBcXVPNVQ4TGZMNkxyL3JTVFBxeEdUOWw3T2s5RWdLT1lndExWdlhT?=
 =?utf-8?B?dzZ5enNkK3hFMU5ndkFSNHQ2NWJHa3dPQThpMjRibWdVZGk0ZXZ6L25FeXFz?=
 =?utf-8?B?OWhvRWF0dFdFbk91UVV5RldOb1FuNGpneklPbGpEWnBpejF6dHZOWkZvRmZh?=
 =?utf-8?B?UzZWUXZSbVZubmVQOE5PdzRtNkw5d3BxRWwxVnc0dkhOTko5NWl6YUhYdWV1?=
 =?utf-8?B?S1p1VzlXMUNOZXVkc2NQVGFZWitlZS9XTEtBTnVJZVc5dkVTNXJOR0N6VjBX?=
 =?utf-8?B?NUM3bzNTYUtPcEpDYXJBbVNrWFlJU2liVzR4SE5vK09hdE90ZU9iYkxDOHJj?=
 =?utf-8?B?MlhvUzM3cHdUSlMzWmd5YWd3TlpCMFAzSjl3S0VCTk1JdkFFdkRJcXdwcGNP?=
 =?utf-8?B?RUdDTkxqSVNhVGZWbkxleVhvV1dETG4xYld6UFQvTHkzM1F1ZTRibE5jTTdG?=
 =?utf-8?B?MnIyNEFMRHpJeUw0NlUrT3dZQXc5SGJTeTcrR0hjWk14eHhPcVpkb0w5dVdZ?=
 =?utf-8?B?V0tCdlpFRHRPbHdXa2FUK2NOZ0dHRDY5QVBjaUpINFRwQkhpUHRJU3ZKNVdx?=
 =?utf-8?B?Sng4cnpGTDRtNHluVStwYTRkNkNuT1Z1TVZvQ2krZWgrcndiNUM2YitURTVa?=
 =?utf-8?B?S092YXlPcUdzbVNSSXhsL1JIUHdFSmx1cUs3TDNhUGhLYUtDQm94bXRiaTlW?=
 =?utf-8?B?Q2VCUWZjMnEvZkFDNkpQNHBOQmdZNTdUNlQxby9MRUh1MW4zZzczZUZ1ZW5U?=
 =?utf-8?B?M3hHV01xU0VzMWlKMERMd2ovUDlSdXlXYjJ3c091aDdQN01oNmFSZWYvZWpV?=
 =?utf-8?B?MTNrK2RGVEZ4dlV3MGxOY1ZtVDdVZDN5b3BGeFF6aVhYaVpkaWpBSHIzby9Y?=
 =?utf-8?B?RjRMYld1T25xY0Z0OXpRSXVpSjBLei9tTUFCem5lRTR5azlXMnJvKzBicWdG?=
 =?utf-8?B?dllma243b0pXK0cwSGtXVE1UL1dRbWdFWnZvN1ZNRnhHcjZaeW9SVFU2ci84?=
 =?utf-8?B?N3UzOGhBd0kvdExLOVRsT0JFUnlVS0YzMVRLbmNZRnhodFBKa1d3b3h6aDgy?=
 =?utf-8?B?MTNkMm4yY0xJSXZlNjYyVHZVMjdtVFhMSWVIbHlxRlJrS2RiWU1PdldWcTdN?=
 =?utf-8?B?QlpNWWdVUHhhVlY1K0d4TXJtYWlkM09zSDRUSG1SK2pTQmdYRmplSmYxL1Vh?=
 =?utf-8?B?dGJBRTJlWU40TTcwWWZUMzlaUGZEWnBseFplTzdjUGdIRW1lRU5oYkp3bDdY?=
 =?utf-8?B?eUkwS2xPNDJIVUxzVWU4eklvSngwOHVLaWdTWUlHZnlzSmdIU0VReUZYWjhm?=
 =?utf-8?B?WCtqTkZ0cG5BTHZtUjRwTTVXMUhUcklXeTNjY2p5M0xoZ3FHUUVvVFV1L3dM?=
 =?utf-8?B?SnQ3U0VzTUJ3WXc3RFZFS2xScWRFejgwZGtkTTdoVmhGeHJad2JxT3orZzFJ?=
 =?utf-8?B?em92aGxRMWFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OExLSGZUazZWdUduaU50SHlqaFd2d2V0b2JEZnZFVStIODlnWU9iODJ6akdv?=
 =?utf-8?B?KzlHV2hONmgvQ0w4Zkc1QjYrSDVveDNmOHEvc0dDeG1qdUtmTDBUd0h5VGU0?=
 =?utf-8?B?a1NBM0V0WGxBVUtnb3RQdjdYaFF3WUdqY3BJbkQ4bmJkMExVblNIK2wwenhR?=
 =?utf-8?B?UFphZUIwZHczT3BwcEhaZ1lOc081M0o4Z3Iycnl0UlAyeUJYMzFSWmdyd1ZK?=
 =?utf-8?B?VHdUU3NVcmV2MmxLTVBQYkRUVGFCSkZZc0QvUi9wZ0VNbkJMOUYyLzBmZ1FO?=
 =?utf-8?B?MTJGZEdxUjlKRXZoRjBTZE9pMGRyZGt3aVlCMDZRTEMrSHpYbERhNmUvNzFS?=
 =?utf-8?B?UVowa09MMVY4aXJ6VGJnTVMrVi9MamtTZnBGTkhBU0doNXdpYk5EOE5kWE1B?=
 =?utf-8?B?ZVhTeHJlbXFqSCs5ZXdDN1NKMWNCejExZFlCbDNnYW9Idmc0NHR5ZDhna1dh?=
 =?utf-8?B?d3N0NGhGaFRFSG5JenhYQWZTb0JYZ3M2RDN2U0ZncHo5NFZ2Y1FGeGd2Q2ph?=
 =?utf-8?B?RFpuQmFSU2k4WVhRZ3VadWU0aUJvN3lhZSs0cHEreFNJWkJyVXdDUlA5dVoz?=
 =?utf-8?B?akUyY3dPVU5qTndGakl6cWJPMEk3eEp1UldwSUtjdncwRnM1TWNSZXdIbEJD?=
 =?utf-8?B?Y3habE8zbnV0OWY2OEh0ZHl2OXNUOWNDaTFZVG4wWm1nclc0TWdWZ014cC8v?=
 =?utf-8?B?NWJGekFtaDZIdFZGRVpwU20rK01DbTkxZzAvMVJ4NVc1L2wyV1FRZ3l5WEtn?=
 =?utf-8?B?d1ppZXNMT0dCdW0vRDg4VERDd0syMjVwZWFTWisycS84WG9UbmZSTGtMWm9y?=
 =?utf-8?B?TE1KRHhKMFloQ2dxWjBNUnJpQng1NVlLeWJSSmdjRXcrYlBuNno2c3hFaEVH?=
 =?utf-8?B?VXMxMXA4L2ZwenhEUWVwdWFqRng4VXdScHhrY0RQWXh1M1Q2b2ZnYnJFZi8y?=
 =?utf-8?B?THg3M1pLWEVmM2NKelNkbThaSEZUQzhwQjdGMzRKQUhkT3VZLzRDcU0zZThP?=
 =?utf-8?B?dXRra0MxNGN3MHNkMGNKQXJGVGtqWFN1YmltRGFnL0V4R0h3bW1zcWlza0xL?=
 =?utf-8?B?N2krbEtmR25McGVJOFFHUnZqRDlSV3U0VUc4MElndmRVaUs1VVZXOEdBVXZh?=
 =?utf-8?B?cVZoZXQ5VXZYV3NPeE54Qy9NRUo0a3o3RTVBcVd3M1o3WnZWaTZsaWJyZkZw?=
 =?utf-8?B?cnZYTlF6djJSTGl3T2FRQ3JzZHU3dGVxWWpkSWh5eFBzSkhGUDY5YWpiOS80?=
 =?utf-8?B?NnBwYkV6R3dOTVlsMDR1c0pyekk5MitlZnBGWWs1MzkyRmVuUDdnMzB5STZj?=
 =?utf-8?B?bVJkT2pKdXBUNVJBTlo3SzZjZXZGMHhRSDJrZk1INDRGeDBIc09aZHJacjcr?=
 =?utf-8?B?ek1QY1grUEIxdExocHI0aVVRWko1VVVPNlVNMzJseS9jS0dPRGxIbHlvVU1m?=
 =?utf-8?B?eFZwUjRZVUIza3ZURW14b0RsaWFKQ3VXWXZqS3FBVTlQQi9VSmpqK0VFbUtO?=
 =?utf-8?B?N2ZDdmVibDlRT0J0SXNPenM2V1kwaVFSQTVlN2lmM3hqcWdmK09JZjJrWC9U?=
 =?utf-8?B?VS9iTVJ4ZDJzbVBIN1QxdWE3aXF4dHNJS0ZzSDBobEdmYmdSRnJsTk9ITWcv?=
 =?utf-8?B?c3RFOFZaUUhYNjMybWNrOC9iQjJxT1h4d0wvSzdxbXhXcnVvUzBNU2luYmVY?=
 =?utf-8?B?SDZ4WFJrZnpYYlppdFNzbG1JMFdvdzUyKzVmaHc0T2hNWHR0amU0b1JmK21U?=
 =?utf-8?B?QXd2WW9WM1o3NVBjSU9TTUVoYitTaEExemdtMTRpa1kyOEZkMmlDNVBvakIx?=
 =?utf-8?B?a2VhK0UxVnRYYkVzQjNsaGtNMTB5QnkyenorK1RhOCtWdzhRR285QXhWaFpu?=
 =?utf-8?B?ejUrd0tiSEpaK2hFcUpoTFprN1hLRjF6RlBjZ3RyMEk3amp5aFNYTlVKcG5B?=
 =?utf-8?B?Z1pVcDNaeHdibTB0RThaWVlaSWRjd0JNbzVjMkxPQjRJNXJnMG12eFNFNXNM?=
 =?utf-8?B?UGZabmIwL3hyck5nSndUTXd6bS9iSENGQ3hmRmk4R29HdXUveG1mdUZ6RkFB?=
 =?utf-8?B?Tm0zWXU3S1F0ZGxXU2tSZHpCeHVBQ1N1dHhJM1plQkdWRUg5OUYzVDlxVWhp?=
 =?utf-8?Q?Hz2vlDQ8JN9w5+luSNrPopqno?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 061dcb1c-b375-46c8-3a4a-08dd6032c855
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 00:22:18.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvI3r5U/KO2ewFIIWUMPmyyAf3EeGvH1smcquGtBIg+OxJuAdNnU4sSN1LEBdnOzzr1W1tyKEhn//F5H0e0v2ZD1sKa/W3Wm7B7afIfKATY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5494

PiBPbiAxMC8wMy8yMDI1IDEwOjQ5LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+Pj4+PiArICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1scGMtcGNjIjsNCj4gPj4+Pj4gKyAg
ICAgICAgICAgIHJlZyA9IDwweDAgMHgxNDA+Ow0KPiA+Pj4+PiArICAgICAgICAgICAgaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDE0NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPj4+Pj4gKyAgICAg
ICAgICAgIHBjYy1wb3J0cyA9IDwweDgwPjsNCj4gPj4+Pg0KPiA+Pj4+IFNvIHdoYXQgMHg4MCBz
dGFuZHMgZm9yPw0KPiA+Pj4gSG9zdCBhcyB4ODYgYXJjaGl0ZWN0dXJlIHdvdWxkIGFjY2VzcyB0
aGUgMHg4MCBwb3J0LCB3aGljaCBpcyBtYXBwZWQgdG8NCj4gdGhlDQo+ID4+IEJNQyBQQ0MgSFcg
bW9kdWxlLg0KPiA+Pj4gQXMgYSByZXN1bHQsIHg4NiBjYW4ga2VlcCB0aGUgcG9ydC1tbWFwZWQg
SS9PIHVzYWdlIGFuZCBhY2Nlc3MgdGhlIEJNQw0KPiA+PiBkZXZpY2UsIHdoaWNoIGlzIG5lZWRl
ZCB0byBrbm93IHdoaWNoIHBvcnQgdXNpbmcgaW4gdGhlIFBDQyBtb2R1bGUgaW4NCj4gQk1DLg0K
PiA+Pg0KPiA+PiBBbmQgb24gZGlmZmVyZW50IGJvYXJkcyB0aGlzIGlzIG5vdCAweDgwPw0KPiA+
IFRoZSBwb3J0LW1tYXBlZCBJL08gZGVmaW5lZCBpbiB0aGUgaW50ZWwgbGVnYWN5IGRvY3VtZW50
IGFzIHRoZSBleGFtcGxlDQo+IHVzYWdlLg0KPiA+IEZvciBleGFtcGxlLCB0aGUgY29tbW9uIHVz
YWdlIGFncmVlbWVudCBvZiBwb3J0LW1tYXBlZCBJL08gYXJlIHRoZQ0KPiBmb2xsb3dpbmcuIEJ1
dCB0aGlzIHNldHRpbmcgY2FuIGJlIG1vZGlmaWVkIGR1ZSB0byB0aGUgaG9zdCB1c2FnZS4gV2Ug
cHJvdmlkZQ0KPiB0aGUgZmxleGliaWxpdHkgdG8gbW9kaWZ5IHRoZSBJL08gcG9ydCBzZXR0aW5n
cy4NCj4gPiBLQ1MgOiAweENBMihDTUQpL0NBMyhEYXRhKQ0KPiA+IEJUIDogMHhFNC9FNS9FNg0K
PiA+IFNOT09QL1BDQyA6IDB4ODAvODEvODIvODMNCj4gPiBNYWlsYm94IDogMHhDQzANCj4gPiBT
dXBlcklPIDogMHgyRS8yRiBvciAweDRFLzB4NEYNCj4gPiBTeXN0ZW0gVUFSVCA6IDB4M0Y4LzJG
OC8zRTgvMkU4DQo+IFNvIHdoaWNoIGJvYXJkcyBoYXZlIGl0IG1vZGlmaWVkPw0KVGhpcyBzZXR0
aW5nIHNob3VsZCBiZSBhcyBzYW1lIGFzIHRoZSBzbm9vcC1wb3J0cy4gWW91IGNhbiBjaGVjayB0
aGUgZHRzIGluIGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZCBmb2xkZXIuDQphc3BlZWQtYm1jLWFt
ZC1kYXl0b25heC5kdHMNCjIxMjogICAgc25vb3AtcG9ydHMgPSA8MHg4MD4sIDwweDgxPjsNCg0K
YXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQo3NzogICAgIHNub29wLXBvcnRzID0g
PDB4ODA+Ow0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

