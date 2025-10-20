Return-Path: <linux-aspeed+bounces-2532-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10D2CCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 08:50:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqpzY1ZmCz3000;
	Mon, 20 Oct 2025 19:50:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760950233;
	cv=pass; b=Lwzj2T7TaWfE2G45x9FjKCtJDQBRv5LZ+b8m+XEGk1gTo/lqc5jxQSI6Kt8ZYSbGtXvyzjx3woQ9kE5h0WtGrfs+xkmnPlaYHFDI0JU5wUckeJx17Y+hKYhkbs1z/kJwqMpPUZsaBNuHf0rWfb5OHAbO+ccgtrApyXC2zHiUbz3nB7frwE1kt6DOOsIlGSJgKkXAVOJg7AFr2NoxZTM4F1g7fFp9P6WcSHJqkV25HssBj1mMh1XnsArDLQoHPmGsSLCalWs4rrFm20/YpWhjuKltx1zLMpTIEPH6+bahpAsQuH0DWjWPGurPSElvoLFpXUGfxGZIIcnvBYpbdM4Mvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760950233; c=relaxed/relaxed;
	bh=sQkNEpbSWqj5ius3juw3SYtBaq3lEkXXXElEd0VFpDg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYS7IO4vOB7Bksmek11RzDl89DjdSKJ3cm/Bax0C9BUOJC77VfD3WWLiaCEGPpZFsecVPyR/MXCzPdABjq5dDRscFMsbTKWKfPzYS/07UKU0h1Rt73vcU/Jb3amc5KyXVq9KjgaOoF4YloIusLLGWXJvQgZXkn6Hgx8avZhj1OxpBRYHXmw453Vvr5V8CKNgPP23fK/68NidjD5hmic6Ul5cpD6Ffml3XL+dHUMJ0vE6k24oMix/HbdiRezAa3YY7TIoNTmfPm6usk5dPA2J9lSzHQpDmeYLIvvFge8vD11wWAukE74/HjShKCcU2GSGgKdhYqcWaWvFc1QZI5dwpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IbCbpF0c; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IbCbpF0c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqpzX42Q8z2ygH
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 19:50:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfDtR1FivrX5YDA1aLuXuplu9pwPcRZmoEQpypzFuDwBOkfx5OsJk/de50furMIN8FRWzrASEyBzCxpeLO/NPSIybfRd8byFk9VjWIygnjhAuOpntqD/aWY8D9+PV1m3oaW6r6e7fSUXr4NafnF5+7ljyb0UHakF0IL6boDflCM4b23XorfCWR8Vk77+wxwl8bSWakDVrBJ8hzRtjsl1ZfQ1xb4K/EmfmB4T7bVEUq06P1W01IYZ5TuVmfzqzWGbdxANlYyfT1cfCTBAHrYahb8kF4LxHa8XzCdcUGWaEMeKlTrGUZ8qkV8Pp8Sz+iA8P4u9gcgXLPspVFXJURMsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQkNEpbSWqj5ius3juw3SYtBaq3lEkXXXElEd0VFpDg=;
 b=VZTp1wa1/ACGLIR6SqgrGjI6JX8Smr1bYcYCrF5s74P2wAYnZ3RZIFjYHfQPdLrIavecjCN6k5ZpMlxtDWnwVPfVQw8KV52MyPOaJJV28COqUIAE0qRDfhDiHwQvuQXNYQwS2syhRkjPDCJ3WbbHxEtu0sBr84DATyBaNhaiND1eeCouy6s84kjj7Wc6P6ZR2m9FbeqnY/YuC1ULXf06L7TL/QmbDhwNcF/fGsgrNppj4OcrmWpbXqpuHmd7fJK+jvyIXgJWNsS2Gy2/e15BXfJo3hvq5hGvix1Q2aiY6G4nyI4xIz72YdyaTDjs5i3MMgcronJapwzMmiEQrQg4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQkNEpbSWqj5ius3juw3SYtBaq3lEkXXXElEd0VFpDg=;
 b=IbCbpF0cEhf1OJPO9x7uTrjWEdA3G7418Xwui2rP1AwlErHWvgAmUoHVT9z9rUvtWNB5prYv46+zjS2kka0fDtRddRZJ02qqYkfzJ2ydZdoZ4/8ImiDqVZrmrao5cvNJOV6nZ89wbmlnaVH5V9YylgKcMIWd/WULwTHwyWq+xO+WF3NtgxsqymLvPViv9GElDkUpr6SQfFD3w6PN89tnUVNDd87vTn8pPWQ4irFi6MDc1rYe4LaJ7znVoKy1kvkY+aOp0hSekV+ncrVsHeBQSUQHqef9twihDnEsDvfsiyEQsBKYQt/+NuUqrVyV8EBwASB+OqIerj2PS3m9B2081Q==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB5466.apcprd06.prod.outlook.com (2603:1096:101:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 08:50:07 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 08:50:06 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Topic: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Index:
 AQHcQWZVHXgbRjt/U0uvaTyLW9Dz6LTKj6aAgAAA+wCAAAUvAIAAAXyAgAAFsgCAABB08IAAC+UAgAAAzJA=
Date: Mon, 20 Oct 2025 08:50:06 +0000
Message-ID:
 <TY2PPF5CB9A1BE6D5DF2D5348DAD6410D42F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
 <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
 <TY2PPF5CB9A1BE6CDC6F04CC0F472FE6451F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6b30c646-cc52-4552-8311-86974c1459e7@kernel.org>
 <e7fec714-aa68-49a1-85e5-356115843307@kernel.org>
 <TY2PPF5CB9A1BE65E96ED9C3CE0E8C7A53EF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <TY2PPF5CB9A1BE658D97FEB9B56E67534DCF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6cf7f86d-00f1-4939-aed0-4f97c1e0fd69@kernel.org>
In-Reply-To: <6cf7f86d-00f1-4939-aed0-4f97c1e0fd69@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB5466:EE_
x-ms-office365-filtering-correlation-id: 28d0d922-0929-4112-765e-08de0fb5aac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWljc2ZmbDIySjFPMGo5QUw0TmF0c2FQb2NqcGxuaHFxN2pGUXl4Q1VxNkZY?=
 =?utf-8?B?U0tGcHpjT3ViSDV2dHhwTEM4N3poZG9TN1dNWCtmTTFSYmZMTXF5Z2R2eWZL?=
 =?utf-8?B?b0NKSFFSWUhwOENMR00rTWRpQS9OdmNPRXpPQ0t6MmpRcTFTdUVpbHoraTlC?=
 =?utf-8?B?a2orOW8yeE1sckVDRTlPMXl6dG5OWUhVR3dXSGRoVllsUGY3V0JDcGNDb25K?=
 =?utf-8?B?V1cyOC9uNklFWjQwT2hhNVI3ZmZMdHdDRGJ1ZkpHanBwcWRVeUhpR0pXUTU4?=
 =?utf-8?B?ektteG5mS3ROY0JBcGVHVnRUZGpUaURxREFEYmlhb0plWlZZTnN0Y3RzRlJF?=
 =?utf-8?B?QmUrK0F3cXlFbWEwdHZhN3lnRnpKdENURE1maFIrYXlwRDhUY3RpcjZ5OWM3?=
 =?utf-8?B?cGxrRG4vaXNMWHdtaFhwUkFGWkxNTUZxVzJEazZDcHhZY3l4emdWZlY5REJ2?=
 =?utf-8?B?ZDdOK0VZOTVjU1Q2RWdoVUV0bDlyRzNHd0tRUkpEMThBZDdKUUhwNGxROHYz?=
 =?utf-8?B?NVJPb2RsN1lyRUh0QWpYYTdRNHM2ZHVjTWtsckRLNWx4Ty95aFlnT3ZISGZ0?=
 =?utf-8?B?OS8rSnMyOU5paCswNWh0eWIwODhpUnVWM0JvK2JkYzB4R1NFVGdXM0VjNGJO?=
 =?utf-8?B?cmdFaVB3TjJRb0dPWllWcW56eUlRcTE4L0w0ZjRTVkh0cy85UE5zMUFlZ3Jq?=
 =?utf-8?B?cmtzUEVXZk4vYXoxS0pyUGExcEY1bFBSZEJVbzMyVTJ4M0g2OTVMZkY5Z2dl?=
 =?utf-8?B?MkZQM3ZndVJCSTVvbSsyQXRkSXhFcC92UC82QXVDSitBNkJxeTArRS9WTmk5?=
 =?utf-8?B?dmFrV2R2M3hPUUVrNzQzSVU3dWdvZUtlMks2aVFFdDM1b0Qvai9MMXR6WVo1?=
 =?utf-8?B?NjZvckFHZ3NReVJZV083Q1N1Nzh5MGF5a2w3Y3lkNlVpUXloSnVxeG16cm45?=
 =?utf-8?B?WWltMnlYVnZYSk5DK1I5cCs2VmtLVVlrd1NFbjR2cEEvZ3RteDFYejNjUkZD?=
 =?utf-8?B?c0kybGQ0OEdDeFRrbk1XRS9FUkFkME4vSDhTWDRTa0s1bUFCK0JXL3d6REtz?=
 =?utf-8?B?TldQVFkzQVc0Z2lRWmgveEpEN0NxWlIwV2RJWmdkK2tiRFUrM1ZqbEZoMXJV?=
 =?utf-8?B?ZGtFZzlzY3VjOW0yTzNEdGdhM2dPSGQyUjBvVTdudkxoMGtyQzhUemduUWFK?=
 =?utf-8?B?RGV0ZmY2eTdZT1B6cXBQR2I1WmRpWWM1RVhGVm14bFBvVVFQMTk4dkkvQXVH?=
 =?utf-8?B?QXlnY0VxRXI3dmxhRldtZFQ1cXZ0RXFTVEhrcHh3a3ZlK2JMM003cGdXalQy?=
 =?utf-8?B?aVYrRndUR04wUlAxcURFWTdRNnMvRkowb2xLaHZ0QStwMnFnYWNCN2FBTDBy?=
 =?utf-8?B?OWFCZFZOQWoxR29IK0FveHdSZ3NQZk5lUmMvajJKanZWaVRuM0hrS3hBMjBv?=
 =?utf-8?B?T0VUam1YM0szaUFPSDhTUzMvQ3E2SEtlYm5Wcm50bDdnbEdFTEdzemZUdk1Y?=
 =?utf-8?B?dTZnRi95WGZGekJKS2NXS0RORkxicEY4dDAwUFJWUmZISTlXM2RvbWF2S0R0?=
 =?utf-8?B?SjBkZnNUOWRXU2pja3U3ZExpVUV3VlEzclVXUmdSYytVekpOMGI1eVZKa3pQ?=
 =?utf-8?B?dkRTcy9CVWc5ZkEzSU5xWjd6ZTNJQy9KUmw1ZjBZd29IbEh5OWNVUFl2cU1w?=
 =?utf-8?B?eGJ4U2I5ZHExT1BoUUQrWWxBcjZKeEJCeTNxbnBuREhSY2dNQi9ZUXpPT0JP?=
 =?utf-8?B?N04wRkxKVkhBVGdkbzhFVVdhbXpyUDFETWNDU3VKZStIdzFIUXNrSWdWay9B?=
 =?utf-8?B?eUFEQ0wrWUV1UlhHQ2p0VkFSZUZpeE9CUHdzU3ViNHBEcFpsQ0h4aXAyUkRI?=
 =?utf-8?B?SXVNbXpBeEh2enJyMXBKSUZSdUlWRHUwb1pmbkNFajM1TzBKR2Z4R0hndHZy?=
 =?utf-8?B?ZGJ3NVMxcmNheCs2ZkcyWm5UR0NNbkJFb1ZoZERzYXFtT3pXMTE3ODN3SnVS?=
 =?utf-8?Q?5R/jpJW5uaH/IKm7NUm/jV4i3aSUdU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1RJQ1Jiekk1SkJyMXFBVUtCZ2pYQzFFOFJxLzNRSXE0VG5vZGFPbXZCNXpu?=
 =?utf-8?B?bWZMSGJiTUNraXpsR2ZRT0VvdzN3WDZTVUxFWlNaUk55Mjc0RFBmYXV5M0lo?=
 =?utf-8?B?T0RLYk5xYkM1OURxTVJHQ3JCV0J1c2RjSldOUW9QT3ZMRS9xbDdueVM2M0N6?=
 =?utf-8?B?NTR3T3hzZ1pnSmFYZmNGc1FzMzRvcDIzS1lGZnE3RWF2Z2FucFJhb3BnNk8z?=
 =?utf-8?B?ODFIZ0tvVW9ONWpwVUlZY2NMM2VtbmNJazBveE5uVFpwOTRpeWl6blRDWTRl?=
 =?utf-8?B?K3RFbno1d2s3MHpmY2pUNkxMQmZUVi9zNlJYYks4Y040OEhLMDdUYnFsWUFX?=
 =?utf-8?B?M3BEYlpUdEtSZWRIenZTTmZ3NjE4VWRPa25wV0t6djFBamhUQVdWak9uQk9x?=
 =?utf-8?B?ZndNTnRWNHdkMG1sa2xwYjFYeWJYTG9BbmtZdGFBWkhCYkc5bDNJZVRDa09E?=
 =?utf-8?B?dXpsWXlsc0ROR2Q4SllSajBwc2dreGk4WjIzSjhXek81SkdmME14YXl0T2to?=
 =?utf-8?B?Vmk0UDk4QmdGd1FLWmJDUGJUQ2lQVlJIKzh2UzVtWFNCM2ZUVE14Qk8xbE5z?=
 =?utf-8?B?ZTNkeGpiODFSMlplRUlZbWpWWC9PL01TUWJEYlF1NTFHK1JISldCdTVSdXZW?=
 =?utf-8?B?RkYzR0lSYnlCd2pVdWtSL3lpZVRVK29KYlRMWmZyQXJUR3VUZEhKYkVSUzRE?=
 =?utf-8?B?YWg3aDNwdE5tVXprcG51TUxRYmhabUI0YzVFRHZnaGtTNjBySi9KQkJzaUZo?=
 =?utf-8?B?ckNQSEJVdENvZjE1d1I1dHdZTHd6THJIc2M5WmcwTFVxQjlBeHYxeFhwUXRh?=
 =?utf-8?B?Q0czbTlyOEZ5YkRUWGFSR1U0UEYrT2FWUUllWnQ4a0pMY2RYUnNSMEhSakFi?=
 =?utf-8?B?QklBbHR3dlpjRi9rY3hEV08xRDc4ZVdSVk5ENDBSL2d4RXlOSGphYjQvRFNw?=
 =?utf-8?B?R2tMSFFYYmZuaGNoUHNidm9tYlZldkpidTcxcmdjK3ozVHZ1VGlBVVNENTFl?=
 =?utf-8?B?cDhPU1hpbDFxczhGaVZDblcwN2xHTFc4SHZwb0d1WnZvT0tUYWJFTGhLalo3?=
 =?utf-8?B?ZWZ6aDlDVzZKTmlmTXBFSEQ3T2RiVXZuNDBkT1luRDNyRGp5TGhqc0VtMTNh?=
 =?utf-8?B?aitkeWpXNHlhU2R6SmpzTzdPQmRYRUo4d0o3WE5ob3JwNjZNeE9uODJBYndu?=
 =?utf-8?B?cHpoVTBIdHJTLzMzSXl6V3hDcW9xYXp1NUNKc2V4QlV2L3B0MEtYYStDdmFH?=
 =?utf-8?B?dkE2eW5MTGZKQnhkbUt6QjIvQmMreUluTWdBTVpJTHR2WC9vbzV2Smk5VjAx?=
 =?utf-8?B?MzhuTnVGY0oyR2N0NlhoNzIxR2Nnb2QrM0grU1YyZFN2aWNpRTc3YXFKclBL?=
 =?utf-8?B?RDlabkEvY0NGTmwrTHBhQXoxcU9uZGFXTlBCZStIRG5MRHNwcGRQc1FJV2ZX?=
 =?utf-8?B?em1adEN0NEtaOXo4UGE4TGpiVzhXY3J3Q3hBMXR4Y0tFUHVFcHRsQ0hIZlNS?=
 =?utf-8?B?NnBaM0ZTSHZmbURxZmg0QzVheHZ4aDY4RVY2QWpMc1ZVZjBrYkR6WkFiY3BX?=
 =?utf-8?B?dE9lWkxrM1cyMFdkU2pIOWswZEFmbmZYa0xjL0xxcURsS3drQnV3M2hNRUlC?=
 =?utf-8?B?elRwclQ5UTBvRWMvcElrSUZRSGFnc3BwaHUzcnpKQnVReWVnWUF1emx0VnR3?=
 =?utf-8?B?eTRoM2lUSVRseXErMjd2WFJjVVZmMVBuZXF6Q21WNmhBS0E0R0F5K21adnUw?=
 =?utf-8?B?bGYwTXptVDRKVTF5Qk1sQi9zSHlRaGxjdkNlbWdQejk1Z0VJcUxPVGNmaTdt?=
 =?utf-8?B?dW5hc2tyRi8rQ0IxSmFOMWxudmtMODZQSk4zRTY0NUJXUmNaN2s4aUtYN3M4?=
 =?utf-8?B?VXpVK1R4dTJJSFMvcHJYNjhFQ2NDUmt4eC9lVFhIV3dGNVNhQldhRzBZSnA2?=
 =?utf-8?B?M3hxU1B0ejB3N2FYZE5wOGZ3dXVWdWg4ajJOZDBiZStURVlPSzU2OGtHa3hv?=
 =?utf-8?B?S0ttRlQ3SExpSFZROWhRUnZjd0lCNDRUbW5oU1BwMms3aXJwdWU2QmdFWnFh?=
 =?utf-8?B?djg3enoxVGpTbDJqUVYyVjg2d3BwNWd6VDhmckswTCtYM0gwRlRrY2t6MnY5?=
 =?utf-8?Q?2giQkugPLSwi9ou3LrDwhXFVg?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d0d922-0929-4112-765e-08de0fb5aac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:50:06.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju1j90cL2gvgLYrQOGE93cUjiTF/4MsXTH9siGoNWV7S66RiTlvm7gS6qILfuapOo+m/fbTcmw3mbx99y3UIlwi13WRoiDLyCt5RnrqqfQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5466

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjAsIDIwMjUg
NDo0NyBQTQ0KPiBUbzogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBMZWUg
Sm9uZXMgPGxlZUBrZXJuZWwub3JnPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBB
bmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVk
LGFzdDJ4MDAtc2N1OiBhbGxvdyAjc2l6ZS1jZWxscw0KPiByYW5nZQ0KPiANCj4gT24gMjAvMTAv
MjAyNSAxMDoxOCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIXSBk
dC1iaW5kaW5nczogbWZkOiBhc3BlZWQsYXN0MngwMC1zY3U6IGFsbG93DQo+ID4+ICNzaXplLWNl
bGxzIHJhbmdlDQo+ID4+DQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczog
bWZkOiBhc3BlZWQsYXN0MngwMC1zY3U6IGFsbG93DQo+ID4+PiAjc2l6ZS1jZWxscyByYW5nZQ0K
PiA+Pj4NCj4gPj4+IE9uIDIwLzEwLzIwMjUgMDg6MzksIEtyenlzenRvZiBLb3psb3dza2kgd3Jv
dGU6DQo+ID4+Pj4gT24gMjAvMTAvMjAyNSAwODozMSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkLGFzdDJ4MDAt
c2N1OiBhbGxvdw0KPiA+Pj4+Pj4gI3NpemUtY2VsbHMgcmFuZ2UNCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBPbiAyMC8xMC8yMDI1IDA0OjA3LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4+Pj4gVGhlICNz
aXplLWNlbGxzIHByb3BlcnR5IGluIHRoZSBBc3BlZWQgU0NVIGJpbmRpbmcgaXMgY3VycmVudGx5
DQo+ID4+Pj4+Pj4gZml4ZWQgdG8gYSBjb25zdGFudCB2YWx1ZSBvZiAxLiBIb3dldmVyLCBuZXdl
ciBTb0NzIChleC4NCj4gPj4+Pj4+PiBBU1QyNzAwKSBtYXkgcmVxdWlyZSB0d28gc2l6ZSBjZWxs
cyB0byBkZXNjcmliZSBjZXJ0YWluDQo+ID4+Pj4+Pj4gc3VicmVnaW9ucyBvcg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+ICJtYXkiPyBTbyB0aGVyZSBpcyBubyBpc3N1ZSB5ZXQ/DQo+ID4+Pj4+DQo+ID4+
Pj4+IHdoaWxlIEkgc3VibWl0IGFzdDI3MDAgcGxhdGZvcm0sDQo+ID4+Pj4NCj4gPj4+PiBTbyB0
aGVyZSBpcyBubyB3YXJuaW5nIGN1cnJlbnRseT8gVGhlbiBkb24ndCBtZW50aW9uLiBZb3UgY2Fu
bm90DQo+ID4+Pj4gdXNlIGFyZ3VtZW50IG9mIHBvc3NpYmxlIGZ1dHVyZSB3YXJuaW5nIGFzIHRo
ZXJlIGlzIGEgd2FybmluZw0KPiA+Pj4+IG5lZWRpbmcgdG8gYmUgZml4ZWQuIFRoaXMgbWFrZXMg
bm8gc2Vuc2UuIExpa2UgeW91IGFkZCBidWcgaW4geW91cg0KPiA+Pj4+IHBhdGNoc2V0IGFuZCB0
aGVuIHNlbmQgKmRpZmZlcmVudCogcGF0Y2ggY2xhaW1pbmcgeW91IGFyZSBmaXhpbmcgYSBidWcu
DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiBUaGVzZSB3YXJuaW5ncyBhcHBlYXIgd2hlbiB2YWxp
ZGF0aW5nIHRoZSBBU1QyNzAwIEVWQiBkZXZpY2UgdHJlZS4NCj4gPj4+Pj4gVGhlIFNDVSBub2Rl
cyBvbiBBU1QyNzAwIGhhdmUgc3ViZGV2aWNlcyAoc3VjaCBhcyBjbG9jayBhbmQgcmVzZXQNCj4g
Pj4+Pj4gY29udHJvbGxlcnMpIHRoYXQgcmVxdWlyZSB0d28gYWRkcmVzcyBjZWxscywgd2hpY2gg
aXMgbm90IGFsbG93ZWQNCj4gPj4+Pj4gYnkgdGhlIGN1cnJlbnQgYGNvbnN0OiAxYCBjb25zdHJh
aW50IGluIHRoZSBzY2hlbWEuDQo+ID4+Pj4+DQo+ID4+Pj4+IEhlcmUgaXMgdGhlIHJlbGF0ZWQg
cmVwb3J0Og0KPiA+Pj4+PiAgIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDI1LzkvMi8xMTY1DQo+
ID4+Pj4NCj4gPj4+PiBUaGlzIG11c3QgYmUgdG9nZXRoZXIsIHNvIHdlIGNhbiByZXZpZXcgZW50
aXJlIHBpY3R1cmUsIG5vdCBwaWVjZXMNCj4gPj4+PiBieSBwaWVjZXMuIE9yZ2FuaXplIHlvdXIg
d29yayBjb3JyZWN0bHksIHNvIHJldmlld2luZyB3aWxsIGJlIGVhc3kuDQo+ID4+Pj4NCj4gPj4+
IEFueXdheSwgSSBtYW5hZ2VkIHRvIGZpbmQgeW91ciBvcmlnaW5hbCB3b3JrIGFuZCB0aGVyZSBp
cyBubyBuZWVkDQo+ID4+PiBmb3IgdGhpcyBwYXRjaCBhdCBhbGwuIFlvdSBkb24ndCBoYXZlIDY0
LWJpdCBzaXplcyB0aGVyZS4NCj4gPj4gVGhhbmtzLCBJIHdpbGwga2VlcCAjc2l6ZS1jZWxscyA9
IDwxPjsgZm9yIG15IG5leHQgc3RlcC4NCj4gPg0KPiA+IEhlbGxvIEtyenlzenRvZiwNCj4gPiBT
b3J5IGJvdGhlcnMgeW91IGFnYWluLg0KPiA+IEFmdGVyIGNoZWNraW5nIHRoZSBBU1QyNzAwIHBs
YXRmb3JtIG1lbW9yeSBjb25maWd1cmF0aW9uLCBpdCBzdXBwb3J0cw0KPiA+IHVwIHRvIDhHQiBv
ZiBEUkFNLiBUaGlzIHJlcXVpcmVzIHVzaW5nIGAjc2l6ZS1jZWxscyA9IDwyPmAgZm9yIHRoZQ0K
PiA+IG1lbW9yeSBub2RlLCBmb3INCj4gPiBleGFtcGxlOg0KPiA+DQo+ID4gCW1lbW9yeUA0MDAw
MDAwMDAgew0KPiA+IAkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gPiAJCXJlZyA9IDwweDQg
MHgwMDAwMDAwMCAweDAgMHg0MDAwMDAwMD47DQo+ID4gCX07DQo+ID4NCj4gPiBHaXZlbiB0aGlz
LCB3aGF0IHdvdWxkIGJlIHRoZSBwcm9wZXIgd2F5IHRvIHByb2NlZWQ/DQo+IA0KPiANCj4gSSBk
aWQgbm90IGNvbW1lbnQgb24gbWVtb3J5IG5vZGUuIE1heWJlIEkgbG9va2VkIGF0IHdyb25nIG5v
ZGUsIG5vdCBzdXJlLA0KPiB0aGF0J3Mgd2h5IHRoaXMgc2hvdWxkIG5vdCBiZSBkaXNjdXNzZWQg
aGVyZSBidXQgaW4gdGhhdCBEVFMgcGF0Y2hzZXQgcmVhbGx5Lg0KDQpVbmRlcnN0b29kLCB0aGFu
a3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KSSdsbCBtb3ZlIHRoaXMgZGlzY3Vzc2lvbiB0byB0
aGUgQVNUMjcwMCBEVFMgcGF0Y2hzZXQgYW5kIGVuc3VyZSB0aGF0IHRoZQ0KYmluZGluZyBhbmQg
RFRTIGNoYW5nZXMgYXJlIHJldmlld2VkIHRvZ2V0aGVyIHRoZXJlLg0KDQpBcHByZWNpYXRlIHlv
dXIgdGltZSBhbmQgZ3VpZGFuY2UuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

