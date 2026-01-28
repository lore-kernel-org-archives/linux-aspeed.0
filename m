Return-Path: <linux-aspeed+bounces-3434-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9892D35662
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Jan 2026 07:43:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1Dlz2QYRz2xT6;
	Wed, 28 Jan 2026 18:43:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769586207;
	cv=pass; b=RsFz4nHUDtas9MsxdBB87JPbqzeDzVIm2QFFzp78yC+TZM1WcJGFCBv3X7afyVE84/XLVM7kJgDKfGzJ39Njf01eKckflTXQMDvz5kmF8lDeeh8Dkxv1ZV5yr/aK6rq8q0RTUvAgONtLC29agzx7Xdl0f7gg+hqKFSxL/gQYSnbFPIKp6bQFLCiFNWpKEKETbVzWjqQ9KjncWf21NSIAyokjevpP381+axqEPN8t5dGSp1wdeqf/9DScOklBUCi3HnQzQFxZNnKEMJipqxnwUj7uno7tTTnrHhN4Gq5eUjw02pJ6vTX8+hX0zRaxhPafIBMDDRByiQLUdF9et4odNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769586207; c=relaxed/relaxed;
	bh=v7BhjJkFHFO0fYGcb+mVEuYCRZ7aua7Jrll8XB791tY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=de4exsQPA1k1UcbZcL4ylUEzxkiYFX3ZgRiF2tzWC8bkMi0lMSonUpmgENLtqYFP0BWT1aHVqxKFf8IQ6rlRKFthrN57VFbexuADqN9KDa9gyUomvx6JYa/WxkEqrLdNCB1qvkQvdXCegwc5DF87MvpT44frxBDVcTYFsQAQmN0EtZVV5+mu2LR6kz88MGq2pUvqcFhgLs90Lj51ZT4UZY9eJSyQVaRBwSU7wBnNSBZ0Zt9qrJZ8zAAUtLotLc5yUOqzGxYk8DPtFSQASkMJF33+N818+N2U2dPFYc46bEHkwMg8a+cj6hs7kIGC1u948YH1eEbQ7D0V1EMlZMMCVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=qStN0Oto; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=qStN0Oto;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1Dlx2Dnmz2xHt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Jan 2026 18:43:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjOrN6gqv1W2XBeCxZGsu8Ws7HgWIUiGeJqje8XAj0l5lEuuITdteloihbAVDyLGgKIltpn53g4LRoTw3tFMia3BslklfvH4/VJera2AuSZEl1eA/yOoEGghfRVWluFxLn1evlHxIwZPys0FHCky3pabJ4hHiyVye6QIv+Siar6/BG9bDiJsMoXEao2iOPrvhRICIa1Hntt4c3MSuQU+RoGbvxULVMwAJ+w5E/6GxuDXW5b5kOUSRLEcHlhXkG1HHsgGHmKpC7rQQCUwWgFLhjcxis//wvuKEVXOlCjUbgg9HEjONX4TnWvLtUE/l1iUSe0bWi/y6A6Ar6PxR5Bh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7BhjJkFHFO0fYGcb+mVEuYCRZ7aua7Jrll8XB791tY=;
 b=L0imnU19xRkYJjlExRaHPZjiwJQdThQUXsDZTdqGnzHwbV9hngyMM22gGbuJvIG7s42BNfLGt53tdsB3FpTDEdVlt0c2Nzz3ZnPtLAjZhoqnjOdUadPZ4EQEawvFVRSxGXBLMCqOBWZI5ZrXaSsO8IA8KoW0oOHVE11XjztVNw7gjvJ/+5rCfSSybrskx3z1Wx59DunY75KyVFGryz3y2GXMgnt+PrivI5DEbeOhY+Rmz4uRFpwu+caVdXpWDl7el09Iaux8zWO8pPuyQPhOb1jQiz326GfIAL4uhHyISp3/kbnmiosW73m71ZdlpGwesYXbZ14X4klB3V+U/VbeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7BhjJkFHFO0fYGcb+mVEuYCRZ7aua7Jrll8XB791tY=;
 b=qStN0Oto+ytN7TXDWAO5tCq814ohuhmLJStAu9l5n9viMOYPK+ppluGSHIGq40bQSYkL39by61MqeflrQRMHlonQTZ1vFirh4cYopOH16hxpEVo3WCbsW07Gv5uAxd3BgomtVtc1wzhLd1gYR0ORuU1pD4wWR+Z4PkLzKEe+LKi5OakBUAvI7MjHuONWjjGQuL2CHTsAeB5UHT7/iFrcsoLwkIQ8QHi6GgSajvbTtIIK7tNGzTC7ftvMg0vFc8y3v5W/ZRMh0E5NvlCl2RrWE9NFlq4cUeCtlMds9TKYvR9z9My0YN3WhvcneurvsLU+a4OLraSf7gaUDKIra80DEw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 07:43:01 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 07:43:01 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "joel@jms.id.au" <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] ASPEED clk updates for v6.19
Thread-Topic: [GIT PULL] ASPEED clk updates for v6.19
Thread-Index: AQHckCiLzLK2QhM6QEOokVQA35P4vw==
Date: Wed, 28 Jan 2026 07:43:01 +0000
Message-ID:
 <OSQPR06MB7252BF7364580CADD7D3F6928B91A@OSQPR06MB7252.apcprd06.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|PUZPR06MB5850:EE_
x-ms-office365-filtering-correlation-id: eea0b63a-5d22-43d8-c74f-08de5e40dd39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tUepT/RAQz6NPt1gUhlX0Oxr3rpxvgl1PqcdzdsAGaBN7Vd+UEM412uyhB?=
 =?iso-8859-1?Q?GA6g9MQSG79YafsMO2684W0iJaM1ub/gupZzVZqFsjNok32aFkb5w9Cig8?=
 =?iso-8859-1?Q?gGedXFiSSuZsdvoeNi0+Ll1Q/mXrRNg9IiMOHQp7uliiOKyO6PYhGPfJAt?=
 =?iso-8859-1?Q?WOvAOZrLy3J3u/NPTTOPy+H3+v8e/YuYx02Bd61nFxChxP08Qc1TqoT7w1?=
 =?iso-8859-1?Q?m+UXDg9Bghvr62Eon61NCUZe1RQHDgBuDAxAD0NU33l1jcwFuCHQr1/PiR?=
 =?iso-8859-1?Q?MkWb79BjhMMeWD/JT6EUiLG2S3TAu/kUIhj9FV9+KQxrg7spYEOjk05tXZ?=
 =?iso-8859-1?Q?NguXqMQ76ilNysk/HsBbJ3JGAZJ7G1HWWWOS3nDam3aZzMBp7GXEeWF1+g?=
 =?iso-8859-1?Q?y72dUj8s/Q3v6zg2x6ZmYWBajFeh8vH7c8eXOH6AeFh6Hr80fmnIgwsws3?=
 =?iso-8859-1?Q?D6ymlzjyEoCZvap5EBaI8ihoOoX2gfd1JHZIclD3SqwNpXkzddr4kWRiPQ?=
 =?iso-8859-1?Q?X8THXOTBvTSb9KLtGGyyqZeaJmBxrOPGvnpXHTFafJYJQN6e2gVjgV3Y2f?=
 =?iso-8859-1?Q?y0L7GmZDDNZrC+PzW1uydfi7xDEUNa3dU6ekg4BogQ9AOSn96ZIWcFqhGJ?=
 =?iso-8859-1?Q?xBpMZ27q3wFS7wUUCu8FCGpYfeIS91yAMseTXdNcj+IxZHfO8Ea7l0qAuS?=
 =?iso-8859-1?Q?1pN/3kII2D+SFb3r71LLf9IZ1DDa9V/OHgFMiUaprJGMDaFuwYHduv8JqM?=
 =?iso-8859-1?Q?rgfb0vfPcxilPfmzJIM/FwkOR/FDFShEcvKSMVsDgUFvb7C429UvNzw0CD?=
 =?iso-8859-1?Q?2T44BvJf2iqSJR51EC4zHKdoUJWb4FqNc/FMhDMQUhkcdhbddz8ChfP7qf?=
 =?iso-8859-1?Q?51z8j9OpbLNp4USQlhTVtir+cziuUIUFgHI6yOT6y1wuWqockN4NibfIgM?=
 =?iso-8859-1?Q?BmZRHdykIf263W+7xXlLMKR5WnDOfwIDPFrZYT3lqlsAuWVlmy0uRxY+jy?=
 =?iso-8859-1?Q?CAyy/khfTi4TZYX7yWHrPLFm2kWSFd1BSye2W7o7EF8nzF+EIt5NDV6VoF?=
 =?iso-8859-1?Q?ZZCHelafEcS18X6nTC7RcRdVoS88YN741rjRWgyFPdyA7+nxdGn4NcY64V?=
 =?iso-8859-1?Q?AhLxqOWvNm0G4dTBoW115pOobgJIdz6TRzVAK/kyBIkJmUZwgZwEnjbcv7?=
 =?iso-8859-1?Q?0rJZCYjJv0hloMnfztM4eWTTeMpbS9ajDJ0YfFQLS/pHJv9u6N/f8xyzJW?=
 =?iso-8859-1?Q?WGrA5HAdMR7Y1/CXaSw4JcnZnpFdqOkbJC2UykvyU1iS7DAnjnMY2C7FhX?=
 =?iso-8859-1?Q?S9jMn2c5AUGWBfVD+fLfiuOK2IoYZbEfsvKLPzrI/zVUkb45pxa4P/83Wd?=
 =?iso-8859-1?Q?Q1QSAJ/0xBsZrfGxbzVgOazCLPJpCtxcZWNMGt8i8c5dbB9SeU0TsQZznL?=
 =?iso-8859-1?Q?bWNIR6qrI9kCAKd4scvw2utJHLVTZSFdXah7QsNAfqtnSmUxHopkjJhfRF?=
 =?iso-8859-1?Q?a1qTVBvzSZtw6m0uis7QLTQaRod2ULwpUA8IqdYjBMx0YulXfbMgyEXJcE?=
 =?iso-8859-1?Q?SFI/j6P2Aa80Q9dqccp9iem4ti3T5dJov59W9L07i419Xgzs/Ma3N5jpxH?=
 =?iso-8859-1?Q?x7pmDkdx7aSeCzdf+P/1M3NzG4x/FnBUIEgIBfysWIdvya/o22RPxgpSX3?=
 =?iso-8859-1?Q?BTDRVzMjCBXpfivLHAc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WQfXwQQy27NeQOYLEK7h5XazgfM1tmCvXvErfYc15ZhZORc3p9/G1lO3EG?=
 =?iso-8859-1?Q?LUTMSfRl1/3M8k+6UGpfFWG8Eatl3gG/N/6HgdFYskauT6wLxM1v3Ia4fu?=
 =?iso-8859-1?Q?mmSELahN+hUJLbE9LUU20rPzn1yffIC/XYLhm/bUzMpibtZIMI6Zx7W41X?=
 =?iso-8859-1?Q?L5lALB13d/6bghVHh/4paj3xGscmHCuVyIZl8lWN8bk7biVWA7d3dFtOU8?=
 =?iso-8859-1?Q?6PUSrYo8shRtKg8hbGk6k1IQUdrJS/VA4a4ANtYFNFYyOGejd0ySDbvGkY?=
 =?iso-8859-1?Q?hdadX+u9FJp0r8hp44D26wDQh2wy3gc8ERMjxfN+Y8hICaP9GE59koPBlG?=
 =?iso-8859-1?Q?srldt1wNgjck3MoFCmNFQ1BG2KAmTbt6njCJwS4Zxn42AwJ9Q4MiXJNGBs?=
 =?iso-8859-1?Q?tyILso1Pssjn2CjTuDyqatz4p8vnm3fbCKfSTMTimKEFpy5Rizte86USjp?=
 =?iso-8859-1?Q?SSebv4eBg0IZtxftpGGo9KQpOIPNGDhUhRwcPB9atEW1uqWQN1o+r9Tw6Z?=
 =?iso-8859-1?Q?uQ8jUj9T4XxN0TN0M9b1kK+UNF/3CnU+sGmv73Hk5rXZhdtio+CMjkZr2g?=
 =?iso-8859-1?Q?RKUsm5SXFoH9Si9DdevsuZq6Cli+niW13zTY1vbR+Eyvf7Y6cWK5E3bdKJ?=
 =?iso-8859-1?Q?2L5qCaeRYO8WxTFQXbhqnRdUmvlkPZYKA8Aef6jt2DvyhCRFnnXPsMwYsj?=
 =?iso-8859-1?Q?YEXW+3+5h0PLRBJ+0wI6uKpJCYUU1yKnLdSbnBi3Tw0nJ87BQuaC2vhCWy?=
 =?iso-8859-1?Q?aklUjjPbTTnmybL6MTsUXz5L9ykKdGmS1RImDQ3cNNrSMCqVhccSz6mDs1?=
 =?iso-8859-1?Q?fW+A/PmU6OIXkVp173gnJVXkXJyaNUZTSSuw6wvU8gcNNitMIGYvyDDIxV?=
 =?iso-8859-1?Q?JOwrGk1t9VwQw5q/HWf1CF9PZohEs8LiNNs2F0rD+1E7uv07G7IuJfbniQ?=
 =?iso-8859-1?Q?hJ/cVH7z1iGD46pDBH5/zuArAgAjt1YyivNISKNcULQSlo/NHPg3bh5FPw?=
 =?iso-8859-1?Q?Zt0A8AW0OHMLY4Bn1KWqsSGumaDmVRs65xTSGtx6HgNgzDl6vE0gR9yoKr?=
 =?iso-8859-1?Q?Tah7GHugwB2gTNlXH1hs7V7U5nGIJR5dtrrnw5BnfCiTpAtqDO7vudE5QN?=
 =?iso-8859-1?Q?Xa9fkQLh2umYRXP3abhG4RActOev/h17U4kDID7OGapIKGjCey3qmDHD8r?=
 =?iso-8859-1?Q?WePm5hXoR6JXZqWq1FhfcKvAl81b56sIBMXvDD1P7MFZ/B8QsGWk9pJDNd?=
 =?iso-8859-1?Q?UJBPAIxXBr+iWFAhB8WGyzMxLUyUle72WI2QxNdZ1sGYEtiafmvPk0zscM?=
 =?iso-8859-1?Q?v7IkbJOf4AtOXf5aH6b855/Ilmr3oa/D6jplkf7AJQX3T0iZRqLxjo4iKH?=
 =?iso-8859-1?Q?JmtZly4FeL3JtmiHpfezDnG1sXY+58jXoLjseoWEHN07CyAxGJYrqre1oG?=
 =?iso-8859-1?Q?0qX4TrkuLAJXw3xXDC+xgEAcDjXL3IHLiu3EW/lWbwlaF7LYi5MEAmHXd+?=
 =?iso-8859-1?Q?AGHodom5cCKnmAq2P3/Yubf1QvXiN/0Rfl9JSGeGnW7IUXe6CL3Kp2yNLX?=
 =?iso-8859-1?Q?ZDIqpadPHXVQIUqQF7G8U4mTb7CBm3YjRCrKX3gFDl6zEBZE2o72VvVnJa?=
 =?iso-8859-1?Q?r8dWEB2GPV7OG4jts1as3tUOGRvzdN8Z7vU9MG2iHlEhNx+qf8Lp925eof?=
 =?iso-8859-1?Q?GS7uCnnvlfD4XepwFjeHmxVWzehkgM+CoOgZPxawQDcgBMxsT3RMT8q+vf?=
 =?iso-8859-1?Q?gLRZwMqaHojr1OMwsewvY/yluVSOJXq58/3pLdGzMZ+hGD9rForNJKngIX?=
 =?iso-8859-1?Q?ZtICdyoeAA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0b63a-5d22-43d8-c74f-08de5e40dd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 07:43:01.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEkO8T0WtERiVeqDzOtHAk9mtQ6V3rBBEdyO4jAHBD+MsPb3/wEGRsgxCp1FIDJAxZMk84Su45DN3Bn452gR06q7jPDb3Ji1SVLB5aH7iD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850

Hi Stephen,=0A=
=0A=
Please pull the following ASPEED clock driver updates for v6.19.=0A=
=0A=
The series includes:=0A=
- Reorganization of ASPEED clock drivers under drivers/clk/aspeed/=0A=
- MAINTAINERS updates for ASPEED clock drivers=0A=
- New ASPEED clock driver support=0A=
=0A=
The branch is based on v6.19-rc1 as requested.=0A=
=0A=
Thanks,=0A=
Billy=0A=
=0A=
----------------------------------------------------------------=0A=
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8=
:=0A=
=0A=
  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)=0A=
=0A=
are available in the Git repository at:=0A=
=0A=
  https://github.com/billy-tsai/linux.git tags/aspeed-clk-for-v6.19-rc1=0A=
=0A=
for you to fetch changes up to dc345e213f16d3ae5dce01bb0002e46bc4eaff4c:=0A=
=0A=
  clk: aspeed: add AST2700 clock driver (2026-01-28 14:58:47 +0800)=0A=
=0A=
----------------------------------------------------------------=0A=
ASPEED clk updates for v6.19-rc1=0A=
=0A=
----------------------------------------------------------------=0A=
Ryan Chen (3):=0A=
      clk: aspeed: Move the existing ASPEED clk drivers into aspeed subdire=
ctory.=0A=
      MAINTAINERS: Add entry for ASPEED clock drivers.=0A=
      clk: aspeed: add AST2700 clock driver=0A=
=0A=
 MAINTAINERS                            |    9 +=0A=
 drivers/clk/Kconfig                    |   13 +-=0A=
 drivers/clk/Makefile                   |    3 +-=0A=
 drivers/clk/aspeed/Kconfig             |   21 +=0A=
 drivers/clk/aspeed/Makefile            |    4 +=0A=
 drivers/clk/{ =3D> aspeed}/clk-aspeed.c  |    0=0A=
 drivers/clk/{ =3D> aspeed}/clk-aspeed.h  |    0=0A=
 drivers/clk/{ =3D> aspeed}/clk-ast2600.c |    0=0A=
 drivers/clk/aspeed/clk-ast2700.c       | 1055 ++++++++++++++++++++++++++++=
++++=0A=
 9 files changed, 1091 insertions(+), 14 deletions(-)=0A=
 create mode 100644 drivers/clk/aspeed/Kconfig=0A=
 create mode 100644 drivers/clk/aspeed/Makefile=0A=
 rename drivers/clk/{ =3D> aspeed}/clk-aspeed.c (100%)=0A=
 rename drivers/clk/{ =3D> aspeed}/clk-aspeed.h (100%)=0A=
 rename drivers/clk/{ =3D> aspeed}/clk-ast2600.c (100%)=0A=
 create mode 100644 drivers/clk/aspeed/clk-ast2700.c=0A=
----------------------------------------------------------------=0A=
=0A=
The patch series can be reconstructed from the mailing list with:=0A=
  b4 am 20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com=

