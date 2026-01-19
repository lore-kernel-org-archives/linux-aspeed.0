Return-Path: <linux-aspeed+bounces-3392-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7523AC9830C
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Jan 2026 02:10:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvYnS0Xzdz2xS5;
	Mon, 19 Jan 2026 13:10:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768788604;
	cv=pass; b=YdhPmgqtAZJD2SoSpdG5GK1uJV2n2Myo2snUkusZLOCEjV++qoa4q00gBD9Al8XFNwJx/GPhPpwbW8UfKCBVufKCEsA4ItERYV0zVNBLM4/FfR9wgWI+5rgt4oDeTIMBe5jLASeifyLyhxWFpyjJQb+9bEfUQPHzrF8unL92RYCO87sdNwGbSqJmGYinD3pXSNjp8P5rhtJvLRuJyCPDB818FxX37+OpW7ytmZiuc+TnUZ/eNpUR0pIQhzTsZDdsadVXwx+T18JZXj1AE79AjBXzHzdAce6b4ZYQncSsfuNWTq67gz1ybdvIKmnpYmkXy7p7G7hwp3uEKZewlBXw8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768788604; c=relaxed/relaxed;
	bh=Rx5jmfo2Kbf12nfLFmLe2kMtM06s6zFkPW75bIBG7+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8gedgVzEac0L0VFdkFnVjL4gTaMK6u9oUz/qPlmxV/ZbgJyXGIqEJ2619RgZA8126Awz0svg4qqZXd3vD5M7o02tpVocEuwcBtxD183hsp2ciaa8NvRDclYea8VqxUX8xfx5PsnM6Nq235mHB2xZ0q4JsEhCQs8vAat+b+nP1ogfTNTnYwBGBhBgSZ4kUINvJn8TxPp5/IgLYE+ekS6xOJM3UB7Z87f/YYbndLE8tRIG2tIufZETf81WIDzf5RyVI9m7nZKCnvHn71A6gXE+Fri6cBn79zrpum1BAFVcI73x+ZQHfPYxlYNludVBWheknvxdfegGVWKiNZgWi22cg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kZod77qX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kZod77qX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvYnQ3SB6z2xRm
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 13:10:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE561qc5RgpX1WoB63qXz/vqyQts3AmU9uzblLEpfRss2spYJuWT2GpICDBM9ksEuqOYxp0mnFDk8EZEKpITyn0idynhlLur+6GGHYI6KF/OH5WvT7F4Sut1+dzl9+lbYigXQdvp2TZVlwwjhW2Kfuvh3D6aZXndy5fqJfbwXkgBxTeBCdtENNyLzdzS04F4gTX3SZ7jlU5gsUXdX6lX/epSLpR0gXJOKd5C24K4CdjxiZIVlGTy2d/+Xj/+mMW3B9YI2XztgnbhaoVmr6XmD6NSzrztjCnbuFikqrySOxXyI9KBjc7FH7d3ICPVHYGqqJst8QDaBngG/zIwRbdRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx5jmfo2Kbf12nfLFmLe2kMtM06s6zFkPW75bIBG7+I=;
 b=YYCL8nSjpJrJ8bla/w+YQz5scRTxoR9HkZ1aDqpt4nfnvV+cwTnUuMD3Hn3BcTQCkW4P19zd4FUo0PhYOOa2GIfQ9kFSDcH4BevRh+rTOupdBIvVHFNESTsqV3S4ziu2iJSkfJ6DYZq5FtfVDa+FEQNMsWmYQeWaX3JMWEq5Flt/nQ8MUy5yrHYa74Ros/314sXpGimEQNPTckGf8B115+awfBZIaVRPEywz6E79eyYoWob8FV65UXNYB+iQKfRW/QtkStPh1wwZkXlKM69kKsfqpTcPRzVzA3tnh1OEoYQlGCuunMy/m1DdcAzJGrRTelcQS110HtEleHzEJGf40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx5jmfo2Kbf12nfLFmLe2kMtM06s6zFkPW75bIBG7+I=;
 b=kZod77qXv48jZebobzaaYRIvZyg1aEMOffwiaKKWHaTeDPfvrSE5fZ72Oavcq8XnDOPWolisoAzERft/WR0pqHOjkzW3mLKLRUocI+wJJuA/xSyxfsBGW/GZ5di+QFLPd+hCfHzN/8sh9fIXatfqLxPHKIzTUuMuY/nDYqqgPJDGOvvjlkJ+nfEo99c58hAElT55q4J7fJYPGfp9wIASqGe0symoXU6Gdo+e/q9U1URG+tUWH7mv+h9utpG/v7sKbDdUK/Qor0uuKyt/qqs8+hdjPlihpMcAOOmlFFAQwwAlnwxpq+eqFDf/SdyEjJkMCvt5A499S7MEEDRAQnA4tg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TY0PR06MB5495.apcprd06.prod.outlook.com (2603:1096:400:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 02:09:33 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%3]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 02:09:33 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, BMC-SW
	<BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 3/5] gpio: aspeed-sgpio: Create llops to handle hardware
 access
Thread-Topic: [PATCH 3/5] gpio: aspeed-sgpio: Create llops to handle hardware
 access
Thread-Index: AQHch6LbTxZfi00O+EG9xRc0ikvT8LVWgaEAgAI3VL8=
Date: Mon, 19 Jan 2026 02:09:33 +0000
Message-ID:
 <OSQPR06MB725219B6ED261DBB4E8BC33D8B88A@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
 <20260117-upstream_sgpio-v1-3-850ef3ffb680@aspeedtech.com>
 <55fbb766-12b5-441a-b06c-d807097e5476@lunn.ch>
In-Reply-To: <55fbb766-12b5-441a-b06c-d807097e5476@lunn.ch>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TY0PR06MB5495:EE_
x-ms-office365-filtering-correlation-id: 41541a69-2443-4910-7d04-08de56ffc9b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?I47k8d1kFWndkL37PdzUpuaz7xCj72K/Tb9YnFyWlKX/fRydxjmouAxX?=
 =?Windows-1252?Q?o4JPvLP+ZNWIep+lAn3XI9IAglMvOKVCyBhnJ5TCCopTg8yLufCqd/aO?=
 =?Windows-1252?Q?iZ8DgeMR1kS83qvezPw1iPsEJxnlnExyrVg4cwk3PBbzTWMuGM+2nl5U?=
 =?Windows-1252?Q?6Zt7n+hGflGEEWCh7a9mCgtk0tUFe7lEruSgwCfBfJbW3HqAbvYRLUjM?=
 =?Windows-1252?Q?Spw/Etxr1Hdm+WIGZQeh7XX5UZZCts5KYfs0PAQ/61S3Ou17ngfC4XRn?=
 =?Windows-1252?Q?b9nXfLfDe30IkobHg7IF1hofXliBrWgkzwo7GVsQOxiI1ZLYTIqKvLhh?=
 =?Windows-1252?Q?99eIbpCme78StQODaJ0X4WToGcEdL0BsVVbNFIBUF7TDpC+BjOYbLS0c?=
 =?Windows-1252?Q?Udj26M2cSoZWs9pH8QGeOxZAuOFtF5G+GPeDJQrwNIUE/pJhsdfrQ0Ki?=
 =?Windows-1252?Q?F1izqEHDMvtjt8mfGd2GaQ7uEPj2qQsEQF68GbSJUUyPHQF9CdPInUqq?=
 =?Windows-1252?Q?CqUFEQa6ZoS/hjOKjSsdfTitDVxyOcHsB0Q0a1uMMLaA6QUwIeTAG4/R?=
 =?Windows-1252?Q?1t28607cD2Xyhjm2xkUznWQ6jyeairGBViITTYa+zDWMqGSyrra8IOmc?=
 =?Windows-1252?Q?J+XRVyYdjK9xaeFL/sZYDbiskbP6htBAheTaB7XdfwgG7i5UoShsKR9P?=
 =?Windows-1252?Q?KY2UFwxkgubRH1jNy4eTKgAcGTNj2z8+q5AeQ8uq2DSx/DtuumVZvraD?=
 =?Windows-1252?Q?a4FgpdWm3HSgKkFovh3GyALn2mhA3s3gbmwzZvT7eb7TzVNEyrQFcUBD?=
 =?Windows-1252?Q?SL43dbwJmAeLPPvH8hwhxZFT8FfXFfyZfRb6a6WHLjkO0VFHRd8dDMln?=
 =?Windows-1252?Q?dsb50F0qclW1l/z1zOKGrxnrRKf2K88cqR5+IASal6pOaESr/ZRWYThO?=
 =?Windows-1252?Q?jnrCuO34womDybiWuymz2jrjtmrobyaWUSL7h3tmRfc+21EDGWX7hRJ0?=
 =?Windows-1252?Q?9kluEm6kt4HzAmqT7B3d+1SrXpJ4fpdCR1VQ3ZQqCCtyzw39Y+0YPBtN?=
 =?Windows-1252?Q?u5RFRJDGrcItNq70KVUv1ezX6ml0qiQ7ZzE5/6R0lxTWsPpumOfycOXM?=
 =?Windows-1252?Q?hjv4HmtxYk2dSr3t0iYGkYLX8jbwY6y6SUF9DPhr+DX2HDcdoMtzDpOI?=
 =?Windows-1252?Q?ukzAzmVLoyp/SEClKx1UHhG/yWpu8FxmJrcOR7z/vZ79dCnj8AcX0w0t?=
 =?Windows-1252?Q?2U3qVesjVjHizNJc16JtpPVjLhrjwt7pyp8g0bLieZHVx+usyQZMilN5?=
 =?Windows-1252?Q?QTDYtL6DeUN+LRWeWybf1uNz/5+yS1aXFGxsfTtljZooM9/oqjZefGWx?=
 =?Windows-1252?Q?h8sRXY0CiQJ9enao3dbkm/+JojNdXjlzRUaoGFmlNO2IEIZ8FAvXfBSw?=
 =?Windows-1252?Q?ck+DdJsCZlnC941zj756LhJb/0HrIUEvypQY1jLeV5OBKZggxw00K/QJ?=
 =?Windows-1252?Q?OGOGuQTeJWuKq1znmfnS7cALUhlHe0jlkfq7mz64919ONC9Z9bnvnLu8?=
 =?Windows-1252?Q?C+QDvgSsrefzMtMBuS7ErI/nqqXEJCh8S/iRQEwTsQNM+ZExuTfQ1Iav?=
 =?Windows-1252?Q?KqL5F8odJuzWeAYBoQ2oUzWfBtoVc87wpB6jAdoCInoQC18mvrzaT64/?=
 =?Windows-1252?Q?4hWneTvQpRenGMI0KwWpji1nKINAmU4ClNc8HQ5CTvKm348a25U1hkjX?=
 =?Windows-1252?Q?3wnkN5bPgRZZ/C9ST+0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?rkRwalyl4T4U6y/2CQ0vMXuJ9/zF23wEnUERgbloydG3c5vRYgHzhbt3?=
 =?Windows-1252?Q?xuL1I9sh+Lyk+CJHMxXibG8EfMnTXut6klEGWReVCvvbCUyzKeSMpRQC?=
 =?Windows-1252?Q?JvWDNM55M91hFeU3WZMPQzzhjVa2DimN42waYmUuwhbB+7dTzKn5AM3G?=
 =?Windows-1252?Q?3K0fiGXa7UFKkWTDcE+QTG2pro1J+0tMtpUEnEBvCM6Lxd7tJ0Wq1v/B?=
 =?Windows-1252?Q?i+ZXwsadKVSP85EYRgK4FN/dRl7vRnESFKsWjl7YWge0IpmBQ7DZp1WL?=
 =?Windows-1252?Q?fuBbgFOPLttDzgSWCVgID8rjxJbV+EYXTqbdxVhCXwSwgz1wbZX+mis9?=
 =?Windows-1252?Q?NsgE/JpAk33dNkXc9H4FJKS/XgKNP8QL+0fiNu6vtnYO8epEtLxlaamW?=
 =?Windows-1252?Q?HxCXkvoXdDRZESasi0bm5E6R+YjCj2mY2POVRddCyorX9WN5JAJwt5c+?=
 =?Windows-1252?Q?7wYpwrs0teHoWnSLwGF+cO/zKl3VEaF+rdyaEPLEWtNpIDj6+bojWheK?=
 =?Windows-1252?Q?4ADoM4VeOOQnkoqr9PJV8uTmFlfDwTiV+/jR/GbKoX11XnEdNUSq26Cm?=
 =?Windows-1252?Q?GJwNmaHA9FRVtUJflpZRJulsDl/T66+6aQ2UFp3Pjf2TxZ1lQg9lAK5/?=
 =?Windows-1252?Q?D+xslwKZzhI0ZbJLPv/TXvX25uiyK6UFNWYsQb2TV3oUXxp0AWRVGq9a?=
 =?Windows-1252?Q?9FgMjtXYr5ESAYS5QO/y7B/3g1SoNN251oK22MeehA/s4XP6EPtIESAv?=
 =?Windows-1252?Q?td9MNfKSk8B6GzzGZxiM7sY0h/fUL6XW1ceQHi4MUhd5x57W8n9aQfDj?=
 =?Windows-1252?Q?5FNh0l3ga9OKUq7QR1hIuv6+ve9/N91D/UGaw9I6dOv9F0HNgDN+6ET8?=
 =?Windows-1252?Q?Ed5uW4RCj7kECmOkqIpXbIwloC0HcekeBGAFlqMb569JtBac6m56Qe7K?=
 =?Windows-1252?Q?kRxoLJN/XtsPM9GXlGbFyDiVtO9f0PI/3y+lmtqz2dW7GZd6VgXM+sQU?=
 =?Windows-1252?Q?gZLjRIDy1kvDRdCRQ6ZtbeSMDgw4M+VZCxl2x/80pS87PZMSuwQNQlvz?=
 =?Windows-1252?Q?z0hL7cGgkfrHLgd4i8gy+iAavo1kHpYAse4LcD1zEdxmVXuGe4tYgsof?=
 =?Windows-1252?Q?BYdlNtNXGwHRLrGGa5Rn+bFXEtckY+/OMRgw4ZqZcc+y6qfStadJ7nDz?=
 =?Windows-1252?Q?QmTrWUjVl1OMrCWqLYGu5rGJw0dseBVYfG8Dt2Ekn2F43laHBm2daPi7?=
 =?Windows-1252?Q?HDnnkCyTmDpcoV3FDP72kl6oe9HeToPCa3k5dSJ2++0GpuxZ16QYLBaU?=
 =?Windows-1252?Q?ibP2KlLzfEAD0vJ49C1ebNgAWAba+UMZi9h0/1x0DKwUgpi6WiXl9FEC?=
 =?Windows-1252?Q?dwuKXQopw4qI2hrPCMT69kP9qgvqumk7/5IyTav7E0QxPF4twLQ+0td0?=
 =?Windows-1252?Q?aSV4esxM7XhfGw36Jx7adzKbdWOLpOYCYnAkay+I6Msd+dKkgtj5TTOj?=
 =?Windows-1252?Q?GRa88YdiJ52YnveoLiD/NUICcLydhZxSiS/2zrK3r/znNdugEmXh2O7K?=
 =?Windows-1252?Q?DFDGpVW4a2PJNzHdi43Ru0/t/O9co7CtrZbXakcIBdosC1Gtat3hnvlh?=
 =?Windows-1252?Q?AN3P/rnFZYZw9Q0qM58ibMMrQHV/K+cTlzZyp2n1gIzYNB7dtst3tuep?=
 =?Windows-1252?Q?uKf/HyRw9Av0q2bBS0dmbMKdsuTUqSJM1nH0XtLUQmi01G2Bj0hMLzus?=
 =?Windows-1252?Q?JbOr1+X+67rEBGaVrGl6LSX+rgAjjJHmz+IThnoWKqNbnWieTHq1WXiI?=
 =?Windows-1252?Q?Wmx81Mg/5xeUUa0qbXHFB6+1GYhrNqqSMLmorFRx7a7fcIF1TDTsrWIC?=
 =?Windows-1252?Q?WK7bsXJ5LBhH27LYQAqqnRRm0GPMCxvB19w=3D?=
Content-Type: multipart/alternative;
	boundary="_000_OSQPR06MB725219B6ED261DBB4E8BC33D8B88AOSQPR06MB7252apcp_"
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41541a69-2443-4910-7d04-08de56ffc9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 02:09:33.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NN5JmIit2OGS4HolIvIXeralEd8ZfoyuQ5V+Ic1ExP2xo0lzP0Ne1JVGgTA4FRtx+29BdpAOLV/QNlcQb1QGPGzJzWwbMA+SM5GqvyJ4cJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5495

--_000_OSQPR06MB725219B6ED261DBB4E8BC33D8B88AOSQPR06MB7252apcp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Thanks for the detailed review =97 your comments are very helpful.

> > Add low-level operations (llops) to abstract the register access for SG=
PIO
> > registers. With this abstraction layer, the driver can separate the
> > hardware and software logic, making it easier to extend the driver to
> > support different hardware register layouts.

> With a quick look at the code, it appears the register numbers stay
> the same? Is that true?
> I think you have reinvented regmap.

Yes, the register numbers remain unchanged for ASPEED G4 in this patch.
The intent of introducing the llops abstraction is to decouple the driver l=
ogic
from the underlying register layout so that we can support SoCs with differ=
ent
SGPIO register organizations in the future. The actual AST2700-specific sup=
port
will be added in a subsequent patch.

We did consider regmap. However, llops is intended to abstract not only reg=
ister
access but also layout-specific bit mapping, which is difficult to express
cleanly with a flat regmap interface.

> > @@ -318,30 +278,25 @@ static int aspeed_sgpio_set_type(struct irq_data =
*d, unsigned int type)
> >       u32 type0 =3D 0;
> >       u32 type1 =3D 0;
> >       u32 type2 =3D 0;
> > -     u32 bit, reg;
> > -     const struct aspeed_sgpio_bank *bank;
> >       irq_flow_handler_t handler;
> > -     struct aspeed_sgpio *gpio;
> > -     void __iomem *addr;
> > -     int offset;
> > -
> > -     irqd_to_aspeed_sgpio_data(d, &gpio, &bank, &bit, &offset);
> > +     struct aspeed_sgpio *gpio =3D irq_data_get_irq_chip_data(d);
> > +     int offset =3D irqd_to_hwirq(d);
> >
> >       switch (type & IRQ_TYPE_SENSE_MASK) {
> >       case IRQ_TYPE_EDGE_BOTH:
> > -             type2 |=3D bit;
> > +             type2 =3D 1;
> >               fallthrough;
> >       case IRQ_TYPE_EDGE_RISING:
> > -             type0 |=3D bit;
> > +             type0 =3D 1;
> >               fallthrough;
> >       case IRQ_TYPE_EDGE_FALLING:
> >               handler =3D handle_edge_irq;
> >               break;
> >       case IRQ_TYPE_LEVEL_HIGH:
> > -             type0 |=3D bit;
> > +             type0 =3D 1;
> >               fallthrough;
> >       case IRQ_TYPE_LEVEL_LOW:
> > -             type1 |=3D bit;
> > +             type1 =3D 1;
> >               handler =3D handle_level_irq;
> >               break;

> This change is not obviously correct to me. It is not about
> abstracting register accesses, what you actually write to the
> registers appears to of changed. Maybe you could add a refactoring
> patch first which does this change, with a commit message explaining
> it, and then insert the register abstraction?

You=92re right =97 viewed together, this change is not obviously correct an=
d makes
the refactoring harder to review.

While the llops interface is designed to handle bit positioning internally
(changing the semantics from passing a bitmask to passing a value), combini=
ng
this semantic change with the abstraction refactoring increases review
complexity.

To address this, I will respin the series and split it into:
                1.            a preparatory refactoring patch that introduc=
es the llops helpers without
changing behavior, and
                2.            a follow-up patch that switches callers to th=
e new value-based interface,
with a commit message explicitly explaining the semantic change.

> > @@ -374,16 +318,14 @@ static void aspeed_sgpio_irq_handler(struct irq_d=
esc *desc)
> >  {
> >       struct gpio_chip *gc =3D irq_desc_get_handler_data(desc);
> >       struct irq_chip *ic =3D irq_desc_get_chip(desc);
> > -     struct aspeed_sgpio *data =3D gpiochip_get_data(gc);
> > +     struct aspeed_sgpio *gpio =3D gpiochip_get_data(gc);

> This rename does not belong in this patch. You want lots of small
> patches, each doing one logical thing, with a good commit message, and
> obviously correct. Changes like this make it a lot less obviously
> correct.

Agreed. I will revert the rename from this patch and handle it separately i=
f
needed.

> >       /* Disable IRQ and clear Interrupt status registers for all SGPIO=
 Pins. */
> > -     for (i =3D 0; i < ARRAY_SIZE(aspeed_sgpio_banks); i++) {
> > -             bank =3D  &aspeed_sgpio_banks[i];
> > +     for (i =3D 0; i < gpio->chip.ngpio; i +=3D 2) {

> Why are ARRAY_SIZE() gone? There probably is a good reason, so doing
> this in a patch of its own, with a commit message explaining "Why?"
> would make this easier to review.

The change from ARRAY_SIZE(aspeed_sgpio_banks) to gpio->chip.ngpio is requi=
red
because AST2700 does not use a fixed bank-based register layout.

Using ngpio removes the dependency on a static bank array and allows the IR=
Q
handling code to work with SoCs that have different SGPIO organizations.
I agree this change deserves a dedicated patch with a commit message explai=
ning
the rationale, and I will split it out accordingly.

Thanks again for the review. I=92ll send a revised version with the changes=
 above.

Billy Tsai

--_000_OSQPR06MB725219B6ED261DBB4E8BC33D8B88AOSQPR06MB7252apcp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-TW" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for the detailed review =97 your comments are=
 very helpful.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; &gt; Add low-level operations (llops) to abstra=
ct the register access for SGPIO<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; registers. With this abstraction layer, th=
e driver can separate the<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; hardware and software logic, making it eas=
ier to extend the driver to<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; support different hardware register layout=
s.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; With a quick look at the code, it appears the r=
egister numbers stay<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; the same? Is that true?<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; I think you have reinvented regmap.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes, the register numbers remain unchanged for ASPEE=
D G4 in this patch.<o:p></o:p></p>
<p class=3D"MsoNormal">The intent of introducing the llops abstraction is t=
o decouple the driver logic<o:p></o:p></p>
<p class=3D"MsoNormal">from the underlying register layout so that we can s=
upport SoCs with different<o:p></o:p></p>
<p class=3D"MsoNormal">SGPIO register organizations in the future. The actu=
al AST2700-specific support<o:p></o:p></p>
<p class=3D"MsoNormal">will be added in a subsequent patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We did consider regmap. However, llops is intended t=
o abstract not only register<o:p></o:p></p>
<p class=3D"MsoNormal">access but also layout-specific bit mapping, which i=
s difficult to express<o:p></o:p></p>
<p class=3D"MsoNormal">cleanly with a flat regmap interface.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; &gt; @@ -318,30 +278,25 @@ static int aspeed_sg=
pio_set_type(struct irq_data *d, unsigned int type)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ty=
pe0 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ty=
pe1 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ty=
pe2 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 bit, reg;<o:=
p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct asp=
eed_sgpio_bank *bank;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_fl=
ow_handler_t handler;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_sg=
pio *gpio;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *ad=
dr;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; int offset;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; irqd_to_aspeed_s=
gpio_data(d, &amp;gpio, &amp;bank, &amp;bit, &amp;offset);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_sg=
pio *gpio =3D irq_data_get_irq_chip_data(d);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D i=
rqd_to_hwirq(d);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch=
 (type &amp; IRQ_TYPE_SENSE_MASK) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
RQ_TYPE_EDGE_BOTH:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type2 |=3D bit;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type2 =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fallthrough;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
RQ_TYPE_EDGE_RISING:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type0 |=3D bit;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type0 =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fallthrough;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
RQ_TYPE_EDGE_FALLING:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler =3D handle_edge_irq;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
RQ_TYPE_LEVEL_HIGH:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type0 |=3D bit;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type0 =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fallthrough;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
RQ_TYPE_LEVEL_LOW:<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type1 |=3D bit;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type1 =3D 1;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler =3D handle_level_irq;<o:p=
></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; This change is not obviously correct to me. It =
is not about<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; abstracting register accesses, what you actuall=
y write to the<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; registers appears to of changed. Maybe you coul=
d add a refactoring<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; patch first which does this change, with a comm=
it message explaining<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; it, and then insert the register abstraction?<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You=92re right =97 viewed together, this change is n=
ot obviously correct and makes<o:p></o:p></p>
<p class=3D"MsoNormal">the refactoring harder to review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While the llops interface is designed to handle bit =
positioning internally<o:p></o:p></p>
<p class=3D"MsoNormal">(changing the semantics from passing a bitmask to pa=
ssing a value), combining<o:p></o:p></p>
<p class=3D"MsoNormal">this semantic change with the abstraction refactorin=
g increases review<o:p></o:p></p>
<p class=3D"MsoNormal">complexity.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To address this, I will respin the series and split =
it into:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a preparatory refactoring patch that intro=
duces the llops helpers without<o:p></o:p></p>
<p class=3D"MsoNormal">changing behavior, and<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a follow-up patch that switches callers to=
 the new value-based interface,<o:p></o:p></p>
<p class=3D"MsoNormal">with a commit message explicitly explaining the sema=
ntic change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; &gt; @@ -374,16 +318,14 @@ static void aspeed_s=
gpio_irq_handler(struct irq_desc *desc)<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct=
 gpio_chip *gc =3D irq_desc_get_handler_data(desc);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct=
 irq_chip *ic =3D irq_desc_get_chip(desc);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_sg=
pio *data =3D gpiochip_get_data(gc);<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct aspeed_sg=
pio *gpio =3D gpiochip_get_data(gc);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; This rename does not belong in this patch. You =
want lots of small<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; patches, each doing one logical thing, with a g=
ood commit message, and<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; obviously correct. Changes like this make it a =
lot less obviously<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; correct.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Agreed. I will revert the rename from this patch and=
 handle it separately if<o:p></o:p></p>
<p class=3D"MsoNormal">needed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Dis=
able IRQ and clear Interrupt status registers for all SGPIO Pins. */<o:p></=
o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; ARRAY_SIZE(aspeed_sgpio_banks); i++) {<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank =3D&nbsp; &amp;aspeed_sgpio_banks[i];<=
o:p></o:p></p>
<p class=3D"MsoNormal">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; gpio-&gt;chip.ngpio; i +=3D 2) {<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; Why are ARRAY_SIZE() gone? There probably is a =
good reason, so doing<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; this in a patch of its own, with a commit messa=
ge explaining &quot;Why?&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt; would make this easier to review.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The change from ARRAY_SIZE(aspeed_sgpio_banks) to gp=
io-&gt;chip.ngpio is required<o:p></o:p></p>
<p class=3D"MsoNormal">because AST2700 does not use a fixed bank-based regi=
ster layout.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Using ngpio removes the dependency on a static bank =
array and allows the IRQ<o:p></o:p></p>
<p class=3D"MsoNormal">handling code to work with SoCs that have different =
SGPIO organizations.<o:p></o:p></p>
<p class=3D"MsoNormal">I agree this change deserves a dedicated patch with =
a commit message explaining<o:p></o:p></p>
<p class=3D"MsoNormal">the rationale, and I will split it out accordingly.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks again for the review. I=92ll send a revised v=
ersion with the changes above.<br>
<br>
<span lang=3D"EN-US">Billy Tsai</span><span lang=3D"EN-US"><o:p></o:p></spa=
n></p>
</div>
</div>
</body>
</html>

--_000_OSQPR06MB725219B6ED261DBB4E8BC33D8B88AOSQPR06MB7252apcp_--

