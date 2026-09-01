Return-Path: <linux-aspeed+bounces-4903-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB17C61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 23:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZMzh1drMz2y71;
	Wed, 02 Sep 2026 09:50:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788297575;
	cv=pass; b=BBHk58v0amY5ReT9dydoeViiKxpzwq8V4rnxoMp8/GYQuW451y/U/uH1XLbmiJgDfYVH7at8tLUDddqeyFvIeMSJoiN2Tk4e0L44xFZDNYG/PNauCDD50pbPz947We9oRnn2bjcGXkGjR8o76CKSnwtEL7f+7PjCi0qgCMODAAVDF5sZEkbEx9iVRhnI+ZgMr1na4P7EixD0EIdQaj9EVmDipC69dhZTNkCpyNheH8d9iPO2k32+Y/cvQYQzdWrFQlJdbhSiuW5ofUeItShbVhg1pc+l6EIlQqt+m0UZSaQYWfCrQJqCiIFwXkEQ8JU37wuPNvgqeFSKn3Ij2bOBAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788297575; c=relaxed/relaxed;
	bh=w77II0Rsn+plUXj7vgkwwl877K7QmvECZKXGNtXBYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YRPQg3uD+esPxwLbMbKoLGVWPjBX6nQAYNHq2LcplpGZgd/5s6luoRdQQPUTML7oMXJEFd0IUH6Aa6mQ601m95t0Pto26y8E1pFHmNYiVYc8aRGhy2uuCYgeZBELGbYBKqnkh47BlunZPJox2H2uJX/nCnBznhmIQTuWclbMfI7BPrKcOuk3hB9vGdTy64f+J+D05HyeBRBSu9N4ba4gyuH/8VJdsNbCXNfarVA5p7HjDsNOHUJhXcSbD8sPF0h9Jkj3/8WGUxjSbzI5E5JqAJLItB/8A4/F2BrGQU7amP4MgUIdN5mIHuBpIIhe5e5+dOc+89Up6aiQny5cm2AC6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HFQfpJcT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HFQfpJcT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZJdy031Zz2xmh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 07:19:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTTBWu7c4LrWL91FIgv9na/e6kaRAMdyJbQrIhlPFK0uW5pS2yApv0QtijzM7InNIxB28rHDOzdKiNNhPqUZpkcrL32givnZP2PjFsAr4Kj6ZnHg/OUwN+ZyDsw405niqxUCXGnnjCXFQm5+z0XAsE5rlw+7xC18YEJpij9QMLSCpFuYfUURkZO6MVRS0LNRtshRagZQ71IDR4r85H4qG39cltrMLuMVnB6Bbthr49BAv//fUY2nrtRRyEGLaKJx6RdhvLZ+WZhqV7jrt9dPkxebWHwnX3FczW/EKRoEqznxR9cOs7w3FLgAtq4rsjwV+UFeuORMsWEVxDtBwdrPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w77II0Rsn+plUXj7vgkwwl877K7QmvECZKXGNtXBYBM=;
 b=PVVQq5+oy1HQ5oNqcnZ/K0Prms/UJBLnTZ7sMTm2bGZY1xqYuWFDKZEDFZnCXShefsUJZKY/bxulOAhS2D9hoh3K8UnKBw7x6dUSBnkwa1iSzLHMjTLJGlRX6tuy5Hg86qT80P1QbYGatG6nqJlt29PZNPdku0mOAjimWSkE/AdGdVbGWkbIFUn2TjgO4oxwfXRpB6f3AzfkNXaE1uKzmNmPIFOX2+aA+YuMMZGE//p5fSXJByDuBqq0MeSSKBIrcXBULno/r9vkpNmRjGBk4SyWnKIA5SDx5hKnxKcMbDVGKExkJA0mA83Gyvlg89Lx8j3pZp1dySQEINHp2Po/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w77II0Rsn+plUXj7vgkwwl877K7QmvECZKXGNtXBYBM=;
 b=HFQfpJcTsjSyX8HsseYgUOVHcex63bi8Zc/+mNPdpgzszFCsDzC2vEvi6l+IbQbdlq6of4cx6lnRcXPvnKBgXAz6zQRpX8Q6+z05tygj4sJptV0os8fXsQOl16Qx+qTRA883y8efd4kLVUzIyTqUQ3gw6hEhO272z1pn1AsDV71+0pq0NZW85Q/nKuPZ+aBAxyw8VZCsCA/rxYqTuUxgQsoT9GAS3IxXgOsWtyvvpAAooKy0vimKDUF0dzu8q+l9hdHZxVSWJkuu0Q8rwKVlnVZCQ5xgKzq6ncTeX/HUALkBfP3mhQBLyc477tg4b1vyOPk5U4QQVRM7rAbTounRhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8558.eurprd04.prod.outlook.com (2603:10a6:102:215::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:19:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:19:08 +0000
Date: Tue, 1 Sep 2026 17:18:59 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] i3c: mipi-i3c-hci: Add support for the AST2700 I3C
 controller
Message-ID: <apdBQ3GbChnlUk8b@lizhi-Precision-Tower-5810>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-5-19909e7cbd7e@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-5-19909e7cbd7e@aspeedtech.com>
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: ef041b89-131d-4432-1ab3-08df086ea88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|56012099006|10067099003|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MbKVOEmC6J+XxuojXpbo8eprdxGIXcARITm6YnHhYgW7P+79oKVErKmzX5pDjW2Aj/k+ylLMFrLizoYcFJxT3C9mZI94rCI+IN1OYCSAtFOEG0s8dRKVWWZkPU+k5pomJXQGP9AUXH7HeRq+spylYZXr0+OMS3ynaxjUurfBq2CB3Y1Sj0JdaK8x7l56xH9KToIlOVhLr0pjDNCcl2y7vzCBTBIcbQfdeGhm0psaZIxVJvY3AlI/qRXfccLwjiBvMigzL2a9AkaLnZFhzAvHp3XCnbuDivIraW4J8KmUY1aM1uBzdZMWxtrrXhxz0FudHbgl5VrY8r8mnG5u77V7HTLBAHYuizwEeUX9P1rgSDFed3FYnWoqSi7UB+HQ7qXuYd50lRBTjOq49scwUWU3Q1/+u71vq/6GP7R0EbzZFj7UZEGKUpnoQt/qNIcxWEqS3ResoPZppJffONaV5D3k/KWgqKtTdGvcM8GWOBU0mUX7+vZTCbW/KYwfavFeekDOIcSN58aNVSM0hXp86TK2FeIeYrA2K1y+TNUFEnfpS45uZwiStZpLDfXlGvtqtAXiQxu1uEqQ7bG+rBiY7lqWozB+oY2LTog8Wm3L5fxxxIZ8y453w/lmB1Qq1fkRN42OezalW8IY1M1BSFQADc9dLupmKVPo2WrGjmI3Q5+Ajf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBTTkhvejMvQzB6dTBvMkNaMmJha0RvZERUWGVFYkFqRmFwQWN2S084cVhu?=
 =?utf-8?B?S1dZMUVzUHdEWDR6RDFxZ0VPeUk4THg3S0V0dlhSVU9lN3JhTTFCSnBSMUhm?=
 =?utf-8?B?MlZpU3I2V1F5bGc5OHFVL256SDBuK0R1eVo0RmNBWjlzdkNYSUNKeTNSWTRx?=
 =?utf-8?B?Y1FOUy9rRUJ4Ry9PTGQ3NWxwbFdsWmZ1Mnc0c2xtTWtvYnZsd2llU1ZNWmxz?=
 =?utf-8?B?WXZLR2ZxL0lzM3FtVlNwREV2RVgxajdPN0JFdTllMVpDcVE4WGVxVENtRXJs?=
 =?utf-8?B?dTZMOVhmb3dEdk5UaEJUK2RqNTVDMkZuVXJZblVZQVNOcXMvYVMzRGVTT3Fw?=
 =?utf-8?B?c0UrSUhqR2YrQlJseGJFZ0xxbFA1aXJqSXcwb0RyREdBTVFpSFJDcTZOMEpq?=
 =?utf-8?B?WHFJZm9kbnMyMXU4MEI2bk5TYUNaaW5LeEdRV0xJYzh1NUk4a2xIOTJDUThP?=
 =?utf-8?B?NFFKdFRLN3gyQWtvcVM0eVVMMTlQaWVhY3JQRUFKME4rNVNsSG5NVWdLL1do?=
 =?utf-8?B?bDVhMjVsNWoya0ZyTmFKSEtxS25PelNpM055MkFpU2RNdWpHYW85TUxBWkRn?=
 =?utf-8?B?T3ZnblFTSFBHZXBoUmIzcnlHUExKdmdwblVUZENLQmYwdE5LNGR4WWdPV0Jx?=
 =?utf-8?B?eHhmd2wwMEp6eitiUHBhK3B4eFVUMTRkNFNPOWgwWWpSQTBMT1prbmUyYXFH?=
 =?utf-8?B?eVNXaWJPWWd0aE96VXpDam8vVHBmNXhseFJWOWhlRC9jaHdIMndheXE0OHlq?=
 =?utf-8?B?MVVSeHAzMkp2eUxqU2t0eHZpR1hLaWZUZy9sMWNmS1didFZVMEcrSW9wTndr?=
 =?utf-8?B?SFY1eGxMRmZZZXlpTE9aMGRYYXFMZUtJYXVHZ0ZJRVYyK3I1U01OUm9obDNX?=
 =?utf-8?B?c21RSXREWnQraTdheVZ5QmYySDVLanVaRzFIS1d5cENYd1ExTGhBeEJTaE9O?=
 =?utf-8?B?TnduVXRUbHF2WTFuWmFUdGxhcjlvRjFxNmNkZlVuWHc3MzFzL2RveUllQ1gv?=
 =?utf-8?B?MXpkZ3dDaG1HaFZqUjR3dm9WWUdHQWM5bm5jT3FXaHFkTm0rTmUxdWJVRWZM?=
 =?utf-8?B?aFBYazY3WkNVMWJTN3kxL1FnNWpYeDFISnFDekM5MldSNUNlUG9pVWpQNUMv?=
 =?utf-8?B?b2FCdDZuR25GcDZqNmtTYWg1cVB1Tm5HUEJlZFRsTGhRdDdOSHE0cjlLejFk?=
 =?utf-8?B?d1JpWjdZb1hpRno4K3BGNkI3ZjA4K2Y1eGtFdWhBUDZCUDlJTFFpT2FKV0d2?=
 =?utf-8?B?SGIrMkdKcEJ2OUl1RVd0dDRuRUhmQkhmSUJXelZPY1lTdDh2ZVVoNUU3aEor?=
 =?utf-8?B?ald4Wjl5Z0V3aGRIRVppUVFwYTRvcVJnY0hndVMwVFBPUmJ1Tkd2LzNjSnJV?=
 =?utf-8?B?dS92UFpQSlo0VmxWMnFPTDlvbkdqaDAvWUlaOCthZHJzdU9uUi8rWjU2ak1s?=
 =?utf-8?B?OFRtNDc3NEhjYW85TC9jeHBJUzRvMUQyY3krekRDclVkNFpxeDZ2SkMrcFFj?=
 =?utf-8?B?blh4Q09XekZmSnBRbjB0N0lMc0cvL3AvRDVXS2VDeWZQazFUMGIzQVZNSXBM?=
 =?utf-8?B?NVp0eUkvbDAzNHpHdGpYMWxFRVB0THVLMkwxOGFHcHVvZGRaK2NWSWV0T3R1?=
 =?utf-8?B?UkZ1dE5oS255OFFucXp0L3lzYnZGcDhZd3ZGcFJqN2dFNnQ1WFpYTUZjWG9w?=
 =?utf-8?B?V3crR2RMRU13eUVOc0hkczBocU5pMXhPam9nOGZ4SWllUGFIbmhJb3FsR1BM?=
 =?utf-8?B?LzVKdFF1MkZWeE9ZSUFnQ2JYaGtlSUk4cDQxenBwRXN1RWZucVBLU2RoSWZC?=
 =?utf-8?B?UlU0VkZiUGFkWGYrZlM3cU5WdVlxb25mdERrQjRnVkpKNFAyUDJ2MEZnNXhK?=
 =?utf-8?B?R216MC82aGR3V0lkZW84WEtWVWcxUW12ZmRJdUhKUlI4MlM0YzMzUEJpTk1Z?=
 =?utf-8?B?UUpBS1Jpc1dlQ2kzQXVpaEFtSzFmN0lpWUlVNFZmbzdBckdWYmpwVmV0Vm9r?=
 =?utf-8?B?U1NTZmRVWStESVBPclpJRGZMcTBzMm5NcXpPTndjbGlyVDZuUVV6U0hkbCs5?=
 =?utf-8?B?Y25ya0RHN1JrQVdvcUtCczZITEdYdCtUV1hEWjBrSmhvYkxjTWJ0RUxaTk9Z?=
 =?utf-8?B?S0FDMTVCNDVSL01DQWVKYldMYU5LUFdpSG81enRoQmwzV25tcE9DQUJKTkdR?=
 =?utf-8?B?ZXdvWW92eHV0OGdEenZtdk14bUNva3RBTVdqNkpkRTIzZ1hpayt6N1hMM3FR?=
 =?utf-8?B?ZGxCTGhCaUN1WXBFUW0yd1dKMWU5Y2ZrZmhBaFgzTWhXMDZUVERVeEs0b1F4?=
 =?utf-8?B?cXFjeVVGbGdhWmVCcmZVbGdHdlAxSUlVUnlSMGtac2FGZG1TS2RvQXJpeWV4?=
 =?utf-8?Q?hNT6nWfqLXrevCwEZCVSA0pXNT2lcTqNwL21D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef041b89-131d-4432-1ab3-08df086ea88f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:19:07.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wMuOr4yerxYJkKw5cEWLkIN6pvNPFyBE5x+/wVzbkRrnISfqng6FDuUGh/pstypmi0gnMh3lbkCtgyjVkmb0h/UvMZohaVsZtHlMu05Nyn5fhV3UGTqd4O2HBK+eip1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8558

On Tue, Sep 01, 2026 at 07:35:32PM +0800, Billy Tsai wrote:
> The AST2700 I3C controller carries an ASPEED vendor extended
> capability describing an in-house control block and a PHY programming
> window. Recognize the ASPEED MIPI vendor ID in the extended capability
> parser and cache both register bases via the generic vendor_data
> pointer, which other vendors (e.g. NXP) also populate; add is_aspeed()
> to identify ASPEED specifically.
>
> Bringing the controller up for transfers needs more than the generic
> HCI reset sequence: the vendor block has to be switched to master
> mode, PHY timing registers programmed from the selected bus rates
> (with aspeed,* device tree properties to override values derived under
> nominal bus loading), and all interrupts funneled through a vendor
> summary register whose handler dispatches to the same core and IO
> handlers as the generic path. Master clock stall is enabled alongside
> master-mode init so an underrun pauses and resumes the transfer
> instead of aborting it. Hook this initialization into bus setup and
> resume behind is_aspeed(), and acquire the core clock and reset-names
> resources the binding describes for it.
>
> During normal operation, the vendor DAA index registers must be told
> which DAT slot is being assigned during ENTDAA, and the PIO/IBI FIFOs
> need resetting after a DMA error or abort — which the core already
> implements behind HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET, so set that
> quirk rather than open-coding a separate recovery path.
>
> With the required support in place, make the "aspeed,ast2700-i3c-hci"
> compatible matchable with the DAT_INDEX_IS_ADDR, DMA_64BIT,
> DMA_ABORT_REQUIRES_PIO_RESET and TX_START_THLD quirks, and set
> is_aspeed() from the same compatible.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5
> ---
>  drivers/i3c/master/mipi-i3c-hci/Makefile        |   2 +-
>  drivers/i3c/master/mipi-i3c-hci/cmd_v1.c        |  21 +++
>  drivers/i3c/master/mipi-i3c-hci/core.c          | 175 ++++++++++++++++--
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.c      |  15 ++
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.h      |   1 +
>  drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c | 234 ++++++++++++++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h | 174 ++++++++++++++++++

needn't "vendor"

>  7 files changed, 606 insertions(+), 16 deletions(-)
>
...
> +++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
> @@ -0,0 +1,174 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (c) 2026 ASPEED Technology Inc.
> + *
> + * AST2700 specific MIPI I3C HCI definitions
> + */
> +
> +#ifndef VENDOR_ASPEED_H
> +#define VENDOR_ASPEED_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/of.h>
> +
> +#include "ext_caps.h"
> +
> +struct clk;
> +struct reset_control;
> +
> +/*
> + * The AST2700 vendor extended capability points to an in-house control
> + * block and a PHY programming window inside the controller's register
> + * space. The core clock and reset lines are only specified in the
> + * AST2700 binding as well. All of it is ASPEED-specific, so it is kept
> + * out of the generic struct i3c_hci and reached instead through its
> + * vendor_data pointer.
> + */
> +struct aspeed_i3c_vendor_data {
> +	void __iomem *inhouse_regs;
> +	void __iomem *phy_regs;
> +	struct reset_control *rst;
> +	struct reset_control *dma_rst;
> +	struct clk *clk;
> +};

should be in aspeed.c

> +
> +/*
> + * hci->master.dev.of_node is only valid once i3c_master_register() has
> + * run device_set_node() on it; probe() pre-populates it before that
> + * point (see i3c_hci_probe()) so this works from early init onward too.
> + */
> +static inline bool is_aspeed(struct i3c_hci *hci)
> +{
> +	return of_device_is_compatible(hci->master.dev.of_node,
> +					"aspeed,ast2700-i3c-hci");
> +}

Don't suggest is_aspeed(), you split each feature and use drvdata like
previous QUIRK.

It will become complex if new chip appear, such aspeed,ast2800-i3c-hci,

Frank

