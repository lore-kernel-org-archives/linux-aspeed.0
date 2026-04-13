Return-Path: <linux-aspeed+bounces-3894-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE6E93808
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Apr 2026 01:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fv9Y51VgLz2yr8;
	Mon, 13 Apr 2026 11:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776045497;
	cv=pass; b=hXAxP3nGn39fCXWyrtPcVzhCY/53cUE47cjhgIyt676E81niL0R2xL0s06jmVkNuHMvxtr8XwmY3HM5R0JpoYh0cG53BionJU8HQwEFuiY43zQv50VyJlaKwxaeh2CxSj36GoACOz6rghi0w80d0evD7zMi0n8r7Pm3YTkx2u3hzJ3B8r2c147bTBZh1ZOrJb8ZKV0Rrb2QqZnQ3bgIrLupv8D/NhrqPSIG5xkNzxwH+aT0I+0NybtleXIvcMWwp8z9v/Cp719TrV3GoaWQ8VGNG0B16/Pazw4QexfhmRW1Fl8EmwJc6q69cTgnA5LR2bTSzYM63Nnz3aQr1JXQDtg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776045497; c=relaxed/relaxed;
	bh=NxMIA335Kx5utnu1B5+E72rSIBe3vrlT2Mk6fidITiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEcnAibzFKSmAy+t/xDp+0IDdWhhqamBzAYCQG92aO0h/T6DrBglQisxXf4UnBtDIUT45al3L1KKofzSf9/WBBtclfbqhiy6ULuSq399w78uy4ILwk7bm01XfSAUra5v04231ds8oLouX053H8QqayLJZSlLJvMVjg5MN6wx31kDUXPnvhaza2nOdnAd+c4zLx5c3g6z/vIxA4UNdu+sO81vIdIk/LSP4RMxXKdaSUN9Yi7B3pBfjAtFnx9Shtt//MmdxgaczxTTV5OmtmFI/iV9A8v6Yp8tCfdv6D75RrOv6asRWafi6sEXLj1fOWE/nKgNdWFffQczFKcWKle4wg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=YHf0Xelv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=YHf0Xelv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fv9Y14L2Bz2yqf;
	Mon, 13 Apr 2026 11:58:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC9VOhNWbT5Y7V+NIDHjlgkCqppjR5tefnWWVO1+kQbUljtB9PfsUAAMfexoqASPre8hUJE7gr0dFwnvYuG9ycuZq/9RkQmDbCY+5SHwYGhxBUIdmBU4Jxk51LWs6Djwg0Y8y14lPed41gCLAFCnC4ISyOlZmB5Wpx2oe5IyeO/u8WjU9r9lb/dJzmva5uYnBiUs1kNYloZ3C4sljFPd5oTTJ0kmO07HI2fSV8it5lPo8rzrpj+4VK1jRxak5XUEh2On2ph34EOds0Ff29dJcdlYpWO96i9ahDQKyrqN+qa8lGbn/pHu1bbpmF/FhSnbHJECA0PKReCvt0RWAKtmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxMIA335Kx5utnu1B5+E72rSIBe3vrlT2Mk6fidITiw=;
 b=GKuMVGMZCfr09/8KH6pwVpkeFJMAlrKNiOm0WQAdF+s2B76aZod7grLBjNxUWpZNinb560L6gjKXSmVYTfykjOCUrnZJ2gFtXnjp0egYlWO52Gu1EdZYqpbBEt9FFg81WzlGZeItuUqpf2vqV2v5N/Hzq3J+zbbNNqM6/kQuoIC+HOh5PZRj7xtT0Eo+6mdrFA6N7PlGps7luNvGnNQBEjjJaRW23IOVpkI9R5Pqi5w9eki6NlkkyhrUUna/xWIWjivkPugdk0uu4C3uExkCajZeY8SpWSDTSE58pPml7ehsm9ZMEuK/gYaa6LKHwyuUbjaV3qP5lCss7FYHNEUYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxMIA335Kx5utnu1B5+E72rSIBe3vrlT2Mk6fidITiw=;
 b=YHf0XelvKCTaOwcbRieRn1CkeLtb0FSlMfim2KsTiV6UMOr4G6GKjOorlUJ3DojnnANPb8TWeLf6jur3LQX416vg8rCv2Y3QTIQS/B9J3fHViypJpshPLzKZvZkLYYQ5mbmJxNVM6LiKLQdcz3T4XWXDM/XL4VXbBc+KJEiIlBb2mPZJIuSSZVns7ufCk4aMbo7q1vGqzxu/GzSdFu+dxty/qzwU68c2rvmvUAKXJ8OHtFw0cKf1rXwT06p7T/1ZVLwuSTra0zPln49gYtDOSWSAe+7+5/fpT2MhV63oP8+o/Xz3sHSL4r5gGRcUVgJEuFJxMBYwAhE1qqIh3DH/Uw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE3PR06MB8200.apcprd06.prod.outlook.com (2603:1096:101:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 01:57:46 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9769.015; Mon, 13 Apr 2026
 01:57:46 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Topic: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Index:
 AQHcwB5Ez31FCAF2H06H/moL1lfWeLXINCEAgAABqPCAAAIpgIAAAW0AgAADQQCAAAMycIAUEY9g
Date: Mon, 13 Apr 2026 01:57:46 +0000
Message-ID:
 <TY2PPF5CB9A1BE6B6C124B8DE265562A722F2242@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To:
 <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE3PR06MB8200:EE_
x-ms-office365-filtering-correlation-id: 712aad48-bc31-46e4-a65c-08de99000ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ZpdAzHBwTBzgikItf1bdZACnbmREhmKE0o74T7UrfLLkSg85I5K+VrF8T8eY0x7D+lVTotohPqSbfWEfShIfQ3dGfaMDelezPo9VBmV4EWxsIGX6iQYbcXNWlIqMP3H/Ut/QbaFeiAb0IvEWWFIgBj8D94yAIHTEc8pFhY5tmZAlo0uBTncMYc8hrbmhRRVqeE1eXMbusmLA+4442Dr5ZIvhouHXz34wKZ2GiDT+1yt22m2FfOCW8+muGqSHsYtafpC0u3ibsQdyeVVCezJGpwlMOnLFlC50qLNozkhw7DyZBgaw+M2TPnainYo+QczkGYNUKqU8+hmHkQJtLi1+6rLRoh3LBNIWes4UgRD8fJN5JQHqrvwpuoSQnLKQHYUX4VAn+t3EuAMpRoSgb4GaD5vQTSgLLEIPU+mDHssKFw3E2hY3Onr0fxBqxBIaZFF2bcgSPZBYwsCmOdyIq3rsDMi0RXO1ifrVRMlTKwUnWjAcFbCrCOc43eMLl3/ICDhkeacmeyWx4mINJbT0h0ckE+ZfJRbWSlGPxZL9Ip67J6zUAS+O1W/tzJvpw7wmvfPXYYn4OVoQZBw2TMWFMht2+vjwT61aKA1d6kVJ9JZkmvLu7sWvT9O0MTS2P7EpQxIA+DLNE8n3e8mzm6G/TteskQXL4uCp/iZbd23J4O9NLfiMKo9e14hMfZtMKZdF+JD6XfK0NxbssDH80d/WvPUev+OUtF3kM1SuNBGURIc/7sPJob2C+MZDYIKZsEXsVhVYe7OsH8dbcb+djm1npAiNPnah5b0edMDOPusV6tRCUeQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFh5Wk9qMmpWREtadTlTaGo2dkJHM3hwclNuWDJRVk9ET3J1MHUyU240QVZU?=
 =?utf-8?B?Y0hCbnFGbUIvQ3drcWlaTkZUN3NhbjFUVXBPVnNlK2ZnbzZaSER5NjljdFJn?=
 =?utf-8?B?SkRORlY4NkRSMG5vR2pXTWxNM0RjWUtVSDlmajBRWi9pbXArd0o0NnJzRm9h?=
 =?utf-8?B?MVdxNlQzck5JV0FkTHdvakJabGZyZzhkbVo3RlNBOHBxOVd1RUFrZWpBQ0FT?=
 =?utf-8?B?UzBPaDArbTRQS0l3WnBIWE9WNUpraHFqdGROTTFVcm9SeU0vclI5b09aOVNl?=
 =?utf-8?B?dkkvZk1vYVg5OHh2aVlaVUh4WTJvYVorQzMyZGlyRjAyK29PbEY5VXBrVEtD?=
 =?utf-8?B?b0t4WjF5NE4wb3R5T3RxY1J5QXBlSSt4Unc4Y2dId1BuMVBuelE3ME9MK21G?=
 =?utf-8?B?RlZ3MHdVeHJWb2hDYnlDcDFTYlhnU2xraFhIczFYWmJxcE1Oa0lFZmpzbytP?=
 =?utf-8?B?OXJPSFZneFdKTWxiZmtIN0d0YnFTVVNyRWdnTVRFSVo0Q21SNCs2eVBvWE1O?=
 =?utf-8?B?Wm1qNGRoWTZodHRWaDRRenVxM3BMc2pOK1hRb3ZHZEdDSjRSUkc1aWNSNzZw?=
 =?utf-8?B?WHVxcm1pQ2Fhd1FsdGl6K3JoMUlDanU5SzhwV2wvVExoZFhzdElaNE1XYTRl?=
 =?utf-8?B?Wmc2aGpYL1VjV2dYMzgreEY4d3ZnQnNTcDBwNmdvU2VHVmtZWHdoaHBYcGZG?=
 =?utf-8?B?VGxGT2Rhc0ZNZHNQTHM0ZE5xQTNoNkpCRVY1V2VEejdpL3FZaVh5cGYrc1RC?=
 =?utf-8?B?MjNTRXVWd2owSFgzMzZzNW4vanRXNlJBaGtWTVpDNGxIeFlGMmNWK0JVVE9T?=
 =?utf-8?B?bDRma3N5RTFHd0Z5ZjdDYmUzeUpFUVMzMno5MFJHR1hSY2dEa0hGdW1yaWxi?=
 =?utf-8?B?dWlQcmFrVFM2aS9YZjI4aWF6ZTBnYWNHYnNrd09GSnoyYlQyTFJDbWdwOUVw?=
 =?utf-8?B?c01mUE1aRTVDZ01JNlhwR2VKdnE3ajJacXpndThnMFhKU0hxaUtmTS9sVldi?=
 =?utf-8?B?eHhyZThWbzlXbys4UjY0bWR0TlZFNUg1R05QZitFQXZDc0xIeUpwYy95MHpl?=
 =?utf-8?B?cEhESWtNRnBpWnl6SG9rR0Zqd1I5QnRrZkJha1NXOTJRM09meWk0QUVReHdB?=
 =?utf-8?B?am9uTWtkNW43YWNrMlQ2NmlJWW9pRGhqdkhrOWp3aHJiRUlUQmlXY0ZXZ3A5?=
 =?utf-8?B?a2tmUmxYYXVwQmxBWlBDRy9zMi9qd0Z3K0FBUVhPb1BjVkVtYlNoNlFtWkFX?=
 =?utf-8?B?MEhPRk1jRWlVOEhsNytXQTFNSFdXRk5aRXJWRDdoWHJJUS9BRzdpaVgxcGdG?=
 =?utf-8?B?amFySFdQeFpCU3ZEc2JubFQvRHNYcFdSSWNkQ2U0OVBuUFo3dlBaUWZENk5D?=
 =?utf-8?B?cFZVeWozYlZBV05xZWVRUVhjdytBRjd4Q2JOQnVlT0cyZmc1OVViak40Wk10?=
 =?utf-8?B?SjdGYWpXRkQ1dStHZ1A5Z0FWcUI1aUhWOVhxWXlnTHQwTUpqU3F1MXEzUGR1?=
 =?utf-8?B?YTJ2dSsrRmYvNWZzcjBXcGN4NmRyWUorNjdYdE9URm9uLzByRndwM25NTGFV?=
 =?utf-8?B?UkkxK1ZhSWpPdW9VSURvS0ZwL2hHVTlUQnV0SWxpenhhdUhKYWdhYnVrTlNF?=
 =?utf-8?B?ZEpVeFZ4U0xIZGpqR09wZWorbWJ6M2tUT29JMUZJNjVSYmJjeVZPMkpQSEFV?=
 =?utf-8?B?TWdWdWZGRzRtQ2lscVYzakpnU1MwUHlBUzJWVXRIUHkrOVRIMFFSblZWeWYz?=
 =?utf-8?B?WUZHK2QrTHg2UkI5dWRoVFlmYkpZaUFvT3VETFJYekRkRnkxaW5aSVpzU1lh?=
 =?utf-8?B?enZiQzFnS3hUdFhVZFJUQlpWMEhSeXYxY0RGS2RYZEJTOVpuajlpMHczZEZE?=
 =?utf-8?B?elJsRTZ0dkEwVW9iclNGK2daelhZNGJUUlBjTUtZQzF3LzBCQS9vNkQ0UGVw?=
 =?utf-8?B?bjg4K2RlenRMdVBiY280bXcvVHcwejlDYnJ3ZWtqZnRIZVFCM3ZaUzljU3Vt?=
 =?utf-8?B?MTdFVW5OdlduYmtUN1NEcjkyclNOUEYyTit1VWwyMHRTTzdOYloyNjF6emVP?=
 =?utf-8?B?OGxuWERxVHl4T00rdXZ2RmZJYXFNRTBCL2pERVp6Tm9ldWJJK2pReU9YVEpv?=
 =?utf-8?B?aWkyNXM2UnpKQ2JpUHFFV240YkZ4VzU2YnZXek5hdnZYWFJNbWRQOU1nQXgx?=
 =?utf-8?B?QW1OWG9EVEtJMDZyTHFKY2NBd1pQVFZxd3VibVRwd0NYL3FHdlBrbDBEWEo3?=
 =?utf-8?B?ZGt5Tk9DSUxMVnhzNFp2MDcrUmNUTzg2ZFV2dUxWeXhCU2hQUFVtUVIxOGlO?=
 =?utf-8?B?UDJUdTJReHZSMC9uUHhxc29BN1dtendSSW5jYm5NZnUrVUVORkkrZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 712aad48-bc31-46e4-a65c-08de99000ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 01:57:46.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSB5yaEs9xQ2mNBVcbOhdi711SsPe5ntcwNIfiR8pErS5LuEBGucQS0X5c2TiNBOd/Xv6D0AiHJTR9wke3/R7gncDr9iBX5QAtjA9cp7hsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8200

PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjI4IDIvNF0gZHQtYmluZGluZ3M6IGkyYzogYXN0MjYw
MC1pMmMueWFtbDogQWRkDQo+ID4gZ2xvYmFsLXJlZ3MgYW5kIGVuYWJsZS1kbWEgcHJvcGVydGll
cw0KPiA+DQo+ID4gSGkgUnlhbiwNCj4gPg0KPiA+ID4gPiBTb3VuZHMgcmVhc29uYWJsZSwgYnV0
IGJlZm9yZSB5b3UgZG8gc28sIGhvdyBhcmUgeW91IHBsYW5uaW5nIHRvDQo+ID4gPiA+IG1hbmFn
ZSB0aGUgYWxsb2NhdGlvbiBvZiBETUEgY2hhbm5lbHMgYWNyb3NzIG11bHRpcGxlIGkyYyBwZXJp
cGhlcmFscz8NCj4gPiA+ID4NCj4gPiA+IFRoZSBBU1QyNjAwIEkyQyBoYXJkd2FyZSBoYXMgb25s
eSBvbmUgY2FuIHVzZSBETUEgYXQgYSB0aW1lLg0KPiA+ID4gVG8gYXZvaWQgdGhlIGNvbXBsZXhp
dHkgb2YgbWFuYWdpbmcgRE1BIGNoYW5uZWwgY29udGVudGlvbiwgSSBwbGFuDQo+ID4gPiB0byB1
c2UgYnVmZmVyIG1vZGUgYnkgZGVmYXVsdCBmb3IgYWxsIGNvbnRyb2xsZXJzLCB3aGljaCBzdGls
bA0KPiA+ID4gcHJvdmlkZXMgYmV0dGVyIHBlcmZvcm1hbmNlIHRoYW4gYnl0ZSBtb2RlIHdpdGhv
dXQgcmVxdWlyaW5nIERNQQ0KPiA+ID4gY2hhbm5lbA0KPiA+IGFsbG9jYXRpb24uDQo+ID4NCj4g
PiBPSywgYnV0IHlvdXIgd29yZGluZyB0aGVyZSAoImJ5IGRlZmF1bHQiKSBpbXBsaWVzIHRoYXQg
RE1BIGlzIHN0aWxsDQo+ID4gc2VsZWN0YWJsZSBmb3Igb25lIGNvbnRyb2xsZXIgcGVyaXBoZXJh
bC4gSW4gd2hpY2ggY2FzZTogeW91IHN0aWxsDQo+ID4gaGF2ZSB0aGUgcHJvYmxlbSBvZiBtYW5h
Z2luZyBETUEgY2hhbm5lbCBjb250ZW50aW9uLCBidXQgbm93IGl0J3MgYXQNCj4gcnVudGltZSBp
bnN0ZWFkLg0KPiA+DQo+ID4gU28gbXkgcXVlc3Rpb24gc3RpbGwgc3RhbmRzOiBob3cgYXJlIHlv
dSBwbGFubmluZyB0byBlbmZvcmNlIHRoYXQgRE1BDQo+ID4gaXMgb25seSBlbmFibGVkIGZvciBv
bmUgY29udHJvbGxlcj8NCj4gPg0KPiA+IE9yIGFyZSB5b3UgcGxhbm5pbmcgdG8gZGlzYWJsZSBJ
MkMgRE1BIGVudGlyZWx5IG9uIEFTVDI2MDA/DQo+IFllcywgVGhpcyBpcyBteSBpbnRlbnQgdG8g
ZG8uDQo+IERpc2FibGUgSTJDIERNQSBlbnRpcmVseSBvbiBBU1QyNjAwLg0KPiBJZiBJIHJlbW92
ZSBETUEsIHNob3VsZCBjYW4gSSBrZWVwIGJ5dGUgYW5kIGJ1ZmZlciBmb3Igc3lzZnM/DQoNCkhl
bGxvIFJvYiwNCg0KT24gdGhlIEFTVDI2MDAsIHdlIGhhdmUgYSBzaW5nbGUtY2hhbm5lbCBjb25z
dHJhaW50LCB3aGljaCBtYWtlcyBETUENCnN1cHBvcnQgYWNyb3NzIGFsbCBjb250cm9sbGVycyBk
aWZmaWN1bHQgdG8gaW1wbGVtZW50IHdpdGhvdXQgc29tZSBraW5kIG9mDQpwcmVkZWZpbmVkIGNv
bmZpZ3VyYXRpb24uIFRoYXQgd291bGQgYmUgYSBiaXQgb2YgYSBtaXN1c2Ugb2YgYSBEVCBwcm9w
ZXJ0eS4NCg0KRm9yIGZ1dHVyZSBwbGF0Zm9ybXMgc3VjaCBhcyB0aGUgQVNUMjcwMCwgRE1BIHN1
cHBvcnQgc2hvdWxkIGJlIG11Y2gNCm1vcmUgc3RyYWlnaHRmb3J3YXJkLiBETUEgY2FwYWJpbGl0
eSBjYW4gYmUgaW5mZXJyZWQgZnJvbSB0aGUgY29tcGF0aWJsZQ0Kc3RyaW5nLg0KDQpVbmxlc3Mg
dGhlcmUgYXJlIGFueSBvYmplY3Rpb25zLCBJIHdpbGwgcmV3b3JrIHRoaXMgc2VyaWVzIHRvIHVz
ZSBidWZmZXIgbW9kZQ0Kb25seSBvbiB0aGUgQVNUMjYwMCwgYW5kIGFkZCBBU1QyNzAwIERNQSBz
dXBwb3J0IHNlcGFyYXRlbHkuDQoNClJ5YW4NCg==

