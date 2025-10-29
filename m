Return-Path: <linux-aspeed+bounces-2678-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F247CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 02:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxBJb2yprz3bf4;
	Wed, 29 Oct 2025 13:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761705535;
	cv=pass; b=U+NivkZo7LWi6JamAs75qsCWuzTs17EwiTz5EqVnzm7vc952nB5z6u4LsNfvMGlGX8SrG2k3Ku1sTJuHhLV+bXTamgLIzAM5tNqkt93d1bzjU+S1llPrcZoe1eCxt9pRxy9n7+y75OEyXEH0tcd36HBvON/6MmtWHzWpnJip/uAvMVka8vO7BjRuFCb2RpwCEUwJeHuUmZTDX6GTp2Mi7Tt6docC73aMMjJIuNohcDrsh57pAnJDgGTChkkUf7MM439hd+hWgP/KRbbJpZrmOdxQD1T/pAjrfQUAppH0JDt5j/XZeVXylHhacEuib4V1Ahd26VFWQkyLT9q0HN9oPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761705535; c=relaxed/relaxed;
	bh=S4pfOlbDwaa4H6/ux/Zll59zAelvwFM8VCjnJjYv0tI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BK68M4LVaPiCYiQWaH/3VDB8/JkIsYrcQHJ6i/7uqHhsTmDeyg+XNgw3rQfvVt7N1RJ/aoQAjwQmACQpEawirwU8YcIB30nkusTuKP+eD9PhTmdgbPmaqdVAbJOQAtbQjHgDJ90q+kKX7MMjI/p3XgMsGMpZqK4tzpLnN3z4pRrPGae/gMeNaAm/wj9+gDZHO4Vz2UTVb2lPn24JK15V0INyKSh/3xD5U3RWRcX/kGZEkjHq1DdkU6pffjcy7UE2GOv/v07sldxtcnZDYjyLls2kaNzpaBJLk1ugkVrSelvlpxw4yH49u4K+VTs3y4+uhoAp1wrOTFD0V+i/svRGHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=i0+RHhJc; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=i0+RHhJc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxBJZ3kjDz30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 13:38:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpbXq4ZqxqobQXhaGp/4OKwB3eoJ4+2K5d+/dEiYVtZ5dj7/A3VFbgQM5lW1r+uGCC1WmbqmiRz41bhMUrWwXYszz1fpGhP+GRyxntXEXjrX+m6lQ1qSqAKaiF97JbwIrS8i4RjurYzMAvecvPswP/PqxI4KDS0dxQHQwXxD4dVK1rXSyhbs1twwEzTnzLW99Q9jWiBc8giLG+Kv3utaBxCLUiKtRebWugod80pVrIFW+xMiYlhJcusdZB6mLmQHx9S6ftmfHsIllpx5ME33IJZt9QKzNI+ARA//WrBMRalIswOp7UD0eVLdEzHodC0sduXfhgVuvL2vid/pzz4rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4pfOlbDwaa4H6/ux/Zll59zAelvwFM8VCjnJjYv0tI=;
 b=suOMoFrZ49Hes2Ddo7BMZFW0E0mVgcH/5EL4vD6GxNhMgx6cooSA/ErWx6tiUxbxBOivcbbCNzHeRgKsloio4vfHcpKQsYGVCE0VD+31MaK1j6dF6ooInB27c/xhz3e4QMXmLS4+DstZM2aMuIpvVou8U9i8LTaz/Iw0YsGHO02CUoMi7v44UhqfwPVnXKyYnGWVIRbDHg9duNBSmwTxs+RlZ2jPBHsta16g+jcSZ7z/ACENW/edFjn0isCUNoY8yhjp5EYAgC3YXoAQ7ES1K+MYJCsbe97/uoVT2VzD5iLcZhxY2QiD6Uf/RhH5f77D1Lw3+n/u6XLbE3mwjXQKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4pfOlbDwaa4H6/ux/Zll59zAelvwFM8VCjnJjYv0tI=;
 b=i0+RHhJcMbgfDkl3jFNFQnvcW4PZtveOiB9oz4YJNEPheiKEIN6AY1KSjX2I2AdyvTEy0pBo+9kltG/uPOSnG93PMQxar/wIUn+Qf0DPm67Mx6oVd+tCPSKCjAA1p1ql9DSdOCAYFzwYb9RfF9ZYyjuXM4X7K6g1juvoYMJ2yi3CJhN6fvh7JlwvcyNrEXx4gw0WhmelvxazSJZ/79eDC5Rev1T4CABH4YJRTGze5JlHj+eOT0yUcqRII2SWn6tbovqvo6hra0k5RmyKDLdz3fTz4w/sXp8TzK1I8h97fe6n+s0t8364l/iGjEMq81koLDEORH4mW7kC9drG9cNCHw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEZPR06MB6976.apcprd06.prod.outlook.com (2603:1096:101:1f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 02:38:30 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:38:30 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>
CC: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, Lee
 Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Nishanth Menon <nm@ti.com>, =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index:
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAIADDnEAgAAO3MCAAJ3UAIAADpuAgAJ3fVA=
Date: Wed, 29 Oct 2025 02:38:30 +0000
Message-ID:
 <TY2PPF5CB9A1BE6D0FC241696E44EB1F463F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
 <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEZPR06MB6976:EE_
x-ms-office365-filtering-correlation-id: 8f02b3bc-bb19-43a4-0c06-08de16943f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFd5Y3Z2VkVlM1lTNUVvZWlqOTA2b0hSamUyaW1jRVc3cGVuOXI1dUxPQ0pD?=
 =?utf-8?B?QXUwZGIyZy9vWm1RVXpFakxJNXlRdzZ5YytDYjFMV3NlRGZNcVMzd05hbnR5?=
 =?utf-8?B?VnBZYVFUUXdHQ25vcUFyNW1OZGpldUk4ek4vemR3Rms2UlZSYTA2WjhLd1Y5?=
 =?utf-8?B?czNXaUxCY083N3d4WDVLVmM3USt1b1cwREhLcGVyZGlWOGlYT3NDRjNHZW9I?=
 =?utf-8?B?VzAwcHhqWU05cnNqWFNSSmVPYW9XRWtMVjgzNnBZZzd6eDJySUQvcFZTeGhF?=
 =?utf-8?B?TkovWW9wQVdjb3dha3EwUEtKMEs0cTlQRzI0ZnlZaHR0VnNTWXlOOCtlbXNl?=
 =?utf-8?B?M1VQQ3ROelhpVStPNEllL3J3OVlVWTJ1b0xaRWF4dVhWZC9PVUFpUitDQnRB?=
 =?utf-8?B?RVpLak1HL3ZaR1FrUUgvUkdCK2JRaWt6MjZFcUorbWwvaVBLc2lETFdlenQr?=
 =?utf-8?B?NUJGS1MwdHRMZzd1ME1nZTA5QXRxTWVmK2NsQ2oxaW81ai9Sem02RmkzNURC?=
 =?utf-8?B?YW4rdkRLQ21scVlGMzJxT1JValNpVVUzYnBZL1U4Y3ZrNyttS28weVZXcXc3?=
 =?utf-8?B?NjJodkhSUkRYWkcycGF6VExOdkJaZ2lGMjhicWRLb3BWV2hYRUdWcjAveVRk?=
 =?utf-8?B?ZUxiUEgxNTNLNWZRNkZxV1NtSUMyVkE2a0lHa3NxVWE3WnoyeWxQZGJ1K25J?=
 =?utf-8?B?ZWsrUE8vRVVmMGswdEFNakFXNkpDdi9YdnBKcVIvam1TeWplN2xRMWdTUkJj?=
 =?utf-8?B?aHh1SGpSUUFTajM3ZGpPS2tIMjVKemdmMXRQczhoYkZDODl2dm5GZ0pXdjB6?=
 =?utf-8?B?WGtKVkNKT2owWWdaRXM4UDFHNUJYTGRGNzNJWURkb05hMjhNUlBKMTNsOU9F?=
 =?utf-8?B?c3dTWVZQTGVjZ2pjT1U1U1U1Y1BjUXZ2ZkhqSVZwczNlTDMvdzY1QW1IRzZN?=
 =?utf-8?B?U2o1ZUxra0JheW5KUk5PdTRoSk9CUWwvM2FlZXlBdndEVGtQT1hUbCswUlZr?=
 =?utf-8?B?YVhMOERxY1M0SmlVSlZFQ0hURitoNkVwY0lka1VySnlvR251LzdWeXgyb0Zs?=
 =?utf-8?B?Q3hITG5HdXR0NWJyUjlEWVQ5dzZ2WFFibWpCdktZdjQ5SXNlWEVpS3piSCs0?=
 =?utf-8?B?SU9zUjZBLzN1MGpJWHpzcm5hWWpBemN0WEhzREtiRkFteEdvd0VSUjVxUjhS?=
 =?utf-8?B?VjFZeThQSkx4WFNMTW5CUXQ3elAwckFGNmhQNnU5YmJDajJJdTYxMzErN2ow?=
 =?utf-8?B?V1ZBWFZPcEdkaHY3Q3FLU2U2Q1lScHkwTnMrRVIrNlluVSs4QWJYaHFiSlA1?=
 =?utf-8?B?S3E5emRCZDJFbWtFcG5LS1VUSitqY1NlNThWemhTL3Bkb1dSaSthcEVBdU5s?=
 =?utf-8?B?cnAyZkhiY3hVZStCbDg1Zi9LMDFEQTFETXluNXRiNVRabWtHQVd6U2NBYXJn?=
 =?utf-8?B?bklqaTVhSVpmR0xSL01ScWpWekl2VjM2WGxKUThheUk3bzZvbXJ1VFdpcXJE?=
 =?utf-8?B?OWpKVWZUVk5kZk5KN0k3aXVaQUZhU21uaDhNUWtUYVpXa3BjMWZQR1FIYkxM?=
 =?utf-8?B?M3pWVVJqSStuc25HbDNiZHg3K215OUlxV3d4L0xGVlZDTHRFWXdGNUQycDZ0?=
 =?utf-8?B?RktXTERWZ0xUdTB1eXgxRUU1OVV4MXNyVGNXeENROU1BaitIRytsbUF0bmYy?=
 =?utf-8?B?Tng4Zi9SbTE0WC9XcTBXRjVCa21JWnluYW1FSytHQWVoZ3hNS0RJSTE3OFFq?=
 =?utf-8?B?TUFZU2RRdUJGZ1V1L0ZSNVYyWGU0RnFWQWttaitTc3EvbjFoWjk0U1ZrWTIr?=
 =?utf-8?B?eEpOaUlJTmh4bkVhVFF1cEZ6M0c5WFRwajFTZ3dqeHdsYU95YTA5bTNldVZK?=
 =?utf-8?B?clFqVHBKVEFEaFFmTjlUeVErNUtIcUQwRFB5VGJ1Y1p4VU0xOW1UY0tVRVhI?=
 =?utf-8?B?OXFZdWpVZmZSaXVzNHE3SWtYakV2SDZyaDdGWDhuQXlENHQ3TFZoVllpN1Ba?=
 =?utf-8?B?RW1xdWZNUisrdUt2VndqcW9yRW9wSUgzd2d4NUR1UnU5eTc4NHdEaDNkMlU5?=
 =?utf-8?Q?vPeN3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alNkOEd1ajhTSklGUW5KbzJ3SExMNzc4d05ZWVkrWTFuS0JHZW5zZnE4MzBw?=
 =?utf-8?B?eklBZnp0MmdJR3YzMERwOVFSaE1XSnlJb2ZKM3pVRXpDaDNWMXQzb1h3dlAz?=
 =?utf-8?B?OEY5Q0tGQnpkUURoZTRJcGxjSTVteWhOOE9EYzNHa1ZPTUJjNjlyc2xmeEZM?=
 =?utf-8?B?cmFRcjBOV1R4T1FaY2w5STBiL2V1TlBUQXZjVVh4bmllczFicnEzVHNmQU9Y?=
 =?utf-8?B?V0pQYm1FWVhqUmlQSTlXUUd0Z3prRjZPNmllZGI2dEFGMVVLUjMxMEJJaG5w?=
 =?utf-8?B?N29VOFU2eGlGdTA5R2NpUUZJWFNqd250dTY2MVNtQVZYNk9HQjkyYUQ5T0w5?=
 =?utf-8?B?WUk3M2xHQjI1REgxOUNyTEI2NlVTTkFNeEZ4U3c1QXBaSGtQRSt2M0VqWmpN?=
 =?utf-8?B?Nkg4VGREVXAzOURsc29DZHVWa1VBYk5aajhPQ29oTWVqT2ppQWw2ZmtNc3px?=
 =?utf-8?B?L1grdVdBeitBQ241dW1RN1BuSy8xa3VxbHJFRGdmT1d5U3h3eDhNZkhFbGZu?=
 =?utf-8?B?YVBmZFFEQzNxTkRwa3FiSjJJamxIRFhnems5UjVtRENjQVNhcE9LRDcyWDVi?=
 =?utf-8?B?KzlDOUVoL1dYTFpxb0pITHVZNE95STlTOHoydUdvUzJSR3UzRDlad0FrNlY3?=
 =?utf-8?B?MXlMSHFDdmwxbUJhR2RFcWZnY0J2c2pYM1o3c3FGbUNoTklCWDFBcVBSRjZ1?=
 =?utf-8?B?YjRxRklSK0xXZmQ4SGIwdmlRVGdkcVp3R3V1S2hYNjBBeEVvY1NJaHYxM0pj?=
 =?utf-8?B?RkNwcGpUL0hDVVY1VXpON1VBaFdIQWQ0Q0RsYkxieHRaenU4aW95WlVuazBo?=
 =?utf-8?B?K2JzY1pTNk9IWmR6QWU2cWpDZkovbGQ5L0t0N01oS2pwVk9NSWVNYXZBRG1G?=
 =?utf-8?B?Q2xnMWhMdzJ2QUdHYTlYTjRGYVpqWUZFcCsyWWE1WXJlajBqZDdDYUxwOUFZ?=
 =?utf-8?B?UU5iaHR0NmhSdHpocU01S2hxUnJhZGF5MFhMdVI2K2dXM2ZzVEZuU2I3ekIr?=
 =?utf-8?B?YnRlV2Z6K0U0Nnd2L0o3TWJldmIzYU4wQitvRys3NjVOWVlUcXY4Q2hManBy?=
 =?utf-8?B?T0RFcHdVaDZ1NmRZY0o4NlhtODJHWTAwcXQ4b1BVdVhsdnZqSTRxYzVIK1l2?=
 =?utf-8?B?SnpMTVJxdVlsaXNKUmdTMVdyVnNnM0RnRmlsOVdaam5ndVh1djlQRGRuemVn?=
 =?utf-8?B?OCtjNGRob3BlWGR4Z0hkY1ZnRXY3cmNUZ1Nqbjd4blVEbVdzNmxqdFBVMi9M?=
 =?utf-8?B?UUhrLzN0UncvR3BTRVFKTHVRWjVUOXB4empDeFJLY09xamFzVzZLdGFOa3FZ?=
 =?utf-8?B?M1BMM3VLam1MaFZCU0xxZ2ZxSDVaVFlXOTdvUEU0NUhpbllhdk1FOFlNZ1Yy?=
 =?utf-8?B?ZEw4REFnU0VMeGRBdlRUSVRGQ1dSNkRub292blZ4WGw5TUhxR0NTN29ZMER3?=
 =?utf-8?B?ZkJsRnU3bC9tODNjQjhnTkYrKzBkNVR1bTFybmN4NldsRVRCNnQ2azVEdWYy?=
 =?utf-8?B?Vk9UdUVZQkZ6bi84ci9RRmFXT1RmdkdsdU9oVE1ROHB6NHZiUElaV0RqaHZs?=
 =?utf-8?B?eUFyemZ0VWE0dHN1VTBzaGk1NTZOUW9nOXZ1eTBmTlFyaXJJcm9oRVcvWlRB?=
 =?utf-8?B?Y0R6ZkIxYThHd285ZERSMHNSaU9PN09pR3hhQWtVUmFobEFCVFBwTGxuaDJv?=
 =?utf-8?B?UjdkNXI4b1ZHY29QaVlwQjIrcm9Nb21SS09Qa3NaVjlGNTlsT3h4K05QQVJP?=
 =?utf-8?B?emJPeWpYV1l3dzIyQnR1VDJKT1Buc3RnbVRwejkvRXpnSXJYNWlyMXBGWjM1?=
 =?utf-8?B?cGtmelhEak4xcXJTS1lnZFRYWVBiZkdCZHZ1aGZnTlFib0E5eDg2MGZUUkxK?=
 =?utf-8?B?c20zSmQyYi8wVzgxMEtkeTduNHp4eGFwK2ZNc1dpbVExYTBVbEl0T3p1TjFQ?=
 =?utf-8?B?WDBjT0o5R2s2QlFOclo5WitkTC9Id3hPOGlpTmRpZ0cwYWM5ZjAwdmhhZmx3?=
 =?utf-8?B?OVk5NGRTMGgvWGM5NXhtTkxiTytuRUsvVXFEbTY5djVCS3pHTUYrNk5JKzh3?=
 =?utf-8?B?cTNaTlczbXoxMUdNOXdGNDNkUUNyWmYvdThwNTB5VnE4dGl5cE9pck9ZeGZz?=
 =?utf-8?Q?aY9gJLdnNa4EFNpSI3KjAqLyQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f02b3bc-bb19-43a4-0c06-08de16943f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 02:38:30.2975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xklNZeILkR9gFHHZ7/0k7zdZg6NgU3DtP+aeyiDob2R+SqJ7QpXW9qyTrRaaQiB9G40TGjb4dDDvDLbJMEQtn9xUJSPbLFJMiGGID6xJw8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6976

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvNl0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gSGkgQW5kcmV3LA0KPiANCj4g
T24gTW9uLCAyNyBPY3QgMjAyNSBhdCAxMzowMSwgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNo
PiB3cm90ZToNCj4gPiBPbiBNb24sIE9jdCAyNywgMjAyNSBhdCAwMjo0MjowMUFNICswMDAwLCBS
eWFuIENoZW4gd3JvdGU6DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNC82XSBhcm02
NDogZHRzOiBhc3BlZWQ6IEFkZCBpbml0aWFsDQo+ID4gPiA+IEFTVDI3MDAgU29DIGRldmljZSB0
cmVlDQo+ID4gPiA+DQo+ID4gPiA+ID4gU29DMCwgcmVmZXJyZWQgdG8gYXMgdGhlIENQVSBkaWUs
IGNvbnRhaW5zIGEgZHVhbC1jb3JlDQo+ID4gPiA+ID4gQ29ydGV4LUEzNSBjbHVzdGVyIGFuZCB0
d28gQ29ydGV4LU00IGNvcmVzLCBhbG9uZyB3aXRoIGl0cyBvd24NCj4gPiA+ID4gPiBjbG9jay9y
ZXNldCBkb21haW5zIGFuZCBoaWdoLXNwZWVkIHBlcmlwaGVyYWwgc2V0Lg0KPiA+ID4gPg0KPiA+
ID4gPiA+IFNvQzEsIHJlZmVycmVkIHRvIGFzIHRoZSBJL08gZGllLCBjb250YWlucyB0aGUgQm9v
dCBNQ1UgYW5kIGl0cw0KPiA+ID4gPiA+IG93biBjbG9jay9yZXNldCBkb21haW5zIGFuZCBsb3ct
c3BlZWQgcGVyaXBoZXJhbCBzZXQsIGFuZCBpcw0KPiA+ID4gPiA+IHJlc3BvbnNpYmxlIGZvciBz
eXN0ZW0gYm9vdCBhbmQgY29udHJvbCBmdW5jdGlvbnMuDQo+ID4gPiA+DQo+ID4gPiA+IFNvIGlz
IHRoZSBzYW1lIC5kdHNpIGZpbGUgc2hhcmVkIGJ5IGJvdGggc3lzdGVtcz8NCj4gPiA+DQo+ID4g
PiBUaGlzIC5kdHNpIHJlcHJlc2VudHMgdGhlIENvcnRleC1BMzUgdmlldyBvbmx5IGFuZCBpcyBu
b3Qgc2hhcmVkDQo+ID4gPiB3aXRoIHRoZSBDb3J0ZXgtTTQgb3IgdGhlIEJvb3QgTUNVIHNpZGUs
IHNpbmNlIHRoZXkgYXJlIHNlcGFyYXRlDQo+ID4gPiAzMi1iaXQgYW5kIDY0LWJpdCBzeXN0ZW1z
IHJ1bm5pbmcgaW5kZXBlbmRlbnQgZmlybXdhcmUuDQo+ID4NCj4gPiBEVCBkZXNjcmliZXMgdGhl
IGhhcmR3YXJlLiBUaGUgLmR0c2kgZmlsZSBjb3VsZCBiZSBzaGFyZWQsIHlvdSBqdXN0DQo+ID4g
bmVlZCBkaWZmZXJlbnQgc3RhdHVzID0gPD47IGxpbmVzIGluIHRoZSBkdGIgYmxvYi4NCj4gPg0K
PiA+ID4gPiBIb3cgZG8geW91IHBhcnRpdGlvbiBkZXZpY2VzDQo+ID4gPiA+IHNvIGVhY2ggQ1BV
IGNsdXN0ZXIga25vd3MgaXQgaGFzIGV4Y2x1c2l2ZSBhY2Nlc3MgdG8gd2hpY2ggcGVyaXBoZXJh
bHM/DQo+ID4gPg0KPiA+ID4gQmVmb3JlIHRoZSBzeXN0ZW0gaXMgZnVsbHkgYnJvdWdodCB1cCwg
Qm9vdCBNQ1UgY29uZmlndXJlIGhhcmR3YXJlDQo+ID4gPiBjb250cm9sbGVycyBoYW5kbGUgdGhl
IHJlc291cmNlIHBhcnRpdGlvbmluZyB0byBlbnN1cmUgZXhjbHVzaXZlIGFjY2Vzcy4NCj4gPg0K
PiA+IEFyZSB5b3Ugc2F5aW5nIGl0IG1vZGlmaWVzIHRoZSAuZHRiIGJsb2IgYW5kIGNoYW5nZXMg
c29tZSBzdGF0dXMgPQ0KPiA+ICJva2F5IjsgdG8gImRpc2FibGVkIjs/DQo+IA0KPiAicmVzZXJ2
ZWQiIGlzIHRoZSBhcHByb3ByaWF0ZSBzdGF0dXMgdmFsdWUgZm9yIHRoYXQuDQoNClRoYW5rcyBm
b3IgdGhlIGNsYXJpZmljYXRpb24uDQoNClNpbmNlIHRoZSBTb0MtbGV2ZWwgLmR0c2kgaXMgc2hh
cmVkIGJ5IGFsbCB1c2VycyAocG90ZW50aWFsbHkgb3RoZXIgcGxhdGZvcm1zKSwNCkkgZG9u4oCZ
dCBhY3R1YWxseSBrbm93IGluIGFkdmFuY2Ugd2hpY2ggcGVyaXBoZXJhbHMgd2lsbCBiZSBhc3Np
Z25lZCB0bw0Kd2hpY2ggQ1BVLiBGb3IgdGhpcyByZWFzb24sIG1hcmtpbmcgbm9kZXMgYXMgYHN0
YXR1cyA9ICJyZXNlcnZlZCJgIGluIHRoZQ0KLmR0c2kgbWlnaHQgYmUgbWlzbGVhZGluZy4NCg0K
SSB0aGluayBpdOKAmXMgbW9yZSBhcHByb3ByaWF0ZSB0byBrZWVwIGFsbCBwZXJpcGhlcmFscyBh
cw0KYHN0YXR1cyA9ICJkaXNhYmxlZCJgIGluIHRoZSBjb21tb24gLmR0c2ksIGFuZCBsZXQgZWFj
aCBib2FyZC1sZXZlbCAuZHRzIG9yDQpmaXJtd2FyZS1zcGVjaWZpYyBEVCBkZWNpZGUgd2hldGhl
ciBhIGRldmljZSBzaG91bGQgYmUgYG9rYXlgIG9yIGByZXNlcnZlZGANCmRlcGVuZGluZyBvbiB0
aGUgYWN0dWFsIHJlc291cmNlIGFzc2lnbm1lbnQuDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31z
LA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0
IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0NCj4g
Z2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0
aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJ
J20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21l
dGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExp
bnVzIFRvcnZhbGRzDQo=

