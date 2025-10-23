Return-Path: <linux-aspeed+bounces-2580-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B332CCD1BC
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 08:21:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csfB40QCrz3bW7;
	Thu, 23 Oct 2025 19:21:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761207659;
	cv=pass; b=PwmWxoO4RwQQnpWoxSM6UO0f/e6j9UtTPTIqRGC1BSOR9+qAvVxJ7ciLF88sadEc/orah8tcvi2SM3N3VXU8B/Vc2qBjSS0o41bdFPkM42wGvMM+ppTrGEpDNHmZjtlL2AAGOBNWo1TNz0qqomiFZDaIsfZ+Wta1jz9ZUWIGTnTb3WMy9GK7Fqcjj9UA6l1mj2j1xcWvidvO+31/mYF7/k+B+psYEuzA8l3dOYGayJrLC2sDLPHQBhvU21anrChz1fQ0lI4t/cCmQ0/onvY7ZJKD0yYbxAITvN9dCU0OjWXDNNYqSVgmQ817akMevAfB47Nb+0HSp0qeWKF83nSC1g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761207659; c=relaxed/relaxed;
	bh=sLVCxmgdPTxOkrtRmCtbGCBask5b7vJNCjtt9YKrfvs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czErK+bQfcKuocln3scWB+K4/lSuywrE5Gnm9k82HlF4V3CAjvtN1GmaOi5/I7rqyVW92QC1vRfBWl4d69bJ+NSl66DHpUW57yjTCVbnaPeGcRKFM8eMSDsEPECu1Gt/tyACduRemlMgmvBaSHCa+kUxTI7ZoqdqWz6+fMB4w3tWdneP10QZKmfvhnIv9JNoanYLLIwLRbiGX/18X4QtsksW7fJwLsXWPIDQui2fsJa9JrqoRjWmjRNGf3zc0VybWF1oL72lxs3zCrj8wDet2D1b5ghq5QOzCOvxKq1HV0/5ypIxynSWtK1rl4rqo/bKWIUwGpC1eNsVratoGl4h9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BdSPMF7D; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BdSPMF7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csfB23gLrz304l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 19:20:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RotLaInNXBHNTx+k6TCGHBoIBKlV3plO+eUibTGYKtC4BZYfrH8esiszzP/KcoZRZm2H4wl9BPS6PxoePaRG1svisuuLdBM6wX2gUSRvpZ+Qe0U0Zu589pgNke7X4o5bX0WdsMUcuuahwpWX+qQSMS9E0bgSmmn3IMRsRAidAZF1VA4DEeIMWbMKVy/DpU3Z7+NQmjeAMdp6ymZA/0aJqdkcV95JBP19IYnLfl6MGBvY4OcKXsKeYjRJ+TU53dFj/Z6HpAiWTOsz2lO/uhHneOMS28v9GBYX7jXOXTWU7364ZUXIHNPldy+9Vqsp2nQxlEz4l/s8qUxKaCsO0V0s1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLVCxmgdPTxOkrtRmCtbGCBask5b7vJNCjtt9YKrfvs=;
 b=aiXhsux2w23JB3z7F3sA/FA4yC2albaDttAjzYrPHNgjjfs2qIfJFCC5K9FLlm0vt1MNSqS3qSfWGUtoxUEi6bV55t1XvOvJu/TP/Kfv+0lbXIm8w7rIbkTpeY25jTgU88n0buikLZmXOHodvgCpq7/dIB3j+ZYlF2uF5ZWfB9y2p/oRZEXkrAORhtK8nhtFNy2R12JpQ7xAP/VVSYKzfuz4XZzIqwaCefaBh0smuqHNuvLeTI4akH6mleDCYFtSSsPEG8K+p8AkGxcnP5FAEZ/hgHgrf3rzriOcC/aByyvqgUy9T+mTn9QNzl+T+GrUvxrh4sDa0FTH/ifEB1H7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLVCxmgdPTxOkrtRmCtbGCBask5b7vJNCjtt9YKrfvs=;
 b=BdSPMF7Dup6UupOLGpbA0xDOHzzb8PFhuwO1/9q47wX8IZUOlbAc8WbjS5zUZlOzqf9OlbB8QoS5PCYVw4tquNEON4eK50xHXyO7fHSmpGo31aG04I9SofAzUf5jREFsXdYpzujm3X56lIzsBkFhB8OHNruVjQ/3K3nVLKxQmNCKieF1jRJOTo2OEIl7DLWWoUiFVldUVXrh7sER0dogd3dthz7nzL6HUUPtXdTUZohzsOYI4TJsDMgXrv/VlMNO0vM1drZ5ivsTa2PxmLHcCPLQCZUZbYIGTNevGpf03gqGrE5DFHq3W1hOfiik5F4LhCGU38kXvItoJ3nAp5plug==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KL1PR0601MB5549.apcprd06.prod.outlook.com (2603:1096:820:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 08:20:33 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:20:33 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 2/3] Irqchip/ast2700-intc: add debugfs support for
 routing/protection display
Thread-Topic: [PATCH v5 2/3] Irqchip/ast2700-intc: add debugfs support for
 routing/protection display
Thread-Index: AQHcQyDR1tGnofTzaEGq5MiftiNfKLTOXiAAgADym1A=
Date: Thu, 23 Oct 2025 08:20:33 +0000
Message-ID:
 <TY2PPF5CB9A1BE65F13FC00C09F5C1FAE68F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-3-ryan_chen@aspeedtech.com> <87h5vqyjs7.ffs@tglx>
In-Reply-To: <87h5vqyjs7.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KL1PR0601MB5549:EE_
x-ms-office365-filtering-correlation-id: f0dcbff9-49c1-4c08-0c5d-08de120d0956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b7uaR8dLSFQ89Ds8CsMs2h6aO7KLLOfgXHoAUgMLrX39T0Nm19uhmxsHphSf?=
 =?us-ascii?Q?RHrZ7zwYZzwIAjwMduqxdsQ7ex1uCzsMiV6sc8fJ4G1sGIUVsAYOpcdGbmRC?=
 =?us-ascii?Q?lQH1a4Pd36dbVWmBoaAYIe9bhG1JbBQqvSC/NkIyhJTzxYpvkQzlUubPaIF/?=
 =?us-ascii?Q?y3uY96AnpupDNPv8N3+aGLWw7sstov6BxV/9MDMPdopKY1iwHXKJ/MvZ0ZsF?=
 =?us-ascii?Q?QEqjZX3U+A5VzPs+RfwXxmBItfFJV+Zj0qxWlFHweSmyKk4n31Xc3JL7gDXW?=
 =?us-ascii?Q?slusIn96SGWc+ZsMdkAdHCss0Rco72RP6eKGIxRQ77NBAFTfeDLoMgAlFetQ?=
 =?us-ascii?Q?CsgLx2TWomPf+mAmcZ1CyDQ0VGz+oSC7tS+DF/ZY3m9CUwWygpptlDvi6xRH?=
 =?us-ascii?Q?3HBbQ5jdmIsHMbbLO9ApUufs6EDYdvPDOtEHbl3VAm33pOlH92dUUlqVr+Tq?=
 =?us-ascii?Q?lSILgnwZBZlN68Nwl1jfcpMrQwDJIVAMEdP7xnmEs2yPKrB2IgHVWHQFrAa5?=
 =?us-ascii?Q?tqZquAEyK5UO9+LpBAJrfXd2PwByP5IWQBPasjkPFVBhkrXzyAesUOwJNSWU?=
 =?us-ascii?Q?aRVJwCh/T5z34cQWhQLvOhe6LuWojfBCkp0tTrfBUvDhB/X2LkZjzMLsr2iA?=
 =?us-ascii?Q?bNHnK+XvvmpgqRWV1WaXJ1ZjNLHTYKhohSQ6zF7ykwmogt6aOHHq91VqaEmQ?=
 =?us-ascii?Q?WaDRvcMGfOZqOBlTg7LZ65Rj7dCUdmZsSEK3PuL7vBO5CJtU1c1Aw3zjSL5T?=
 =?us-ascii?Q?KcVR4lc5Z7vrAgF2/bXEA87Kz1fJpPXFFWeAJ+dN8HCHTRNTcEs+M7lr15P3?=
 =?us-ascii?Q?Dwf+nOWjnNiUX8RnQxnc/0CsvHGdBfXriyIjB8r9WnmMcldmrMhLAIICSpCV?=
 =?us-ascii?Q?GIejZd3dbCUpoYDZd026TFGiVz1AXLySAL8aXNcXTJfJTuu1okVcqEpqVH6W?=
 =?us-ascii?Q?CW2f94vQVULR8ApBCKcxIan+tqFeYp1rPmBMKaMfeW8alnOaN0KHBg9D9Mpr?=
 =?us-ascii?Q?+VTeAhzWeDErCzstb9wOgOwFU40eQoaAYys1drSKrZs2TvYOxz3X5jsctSpm?=
 =?us-ascii?Q?lQ1ks+q1ta1mH/0rdRb2p98fYbAwmVr7c/F4cV5eyjEkiHdjFlzyRXVEIH3i?=
 =?us-ascii?Q?MrYClHSdyuu5/A2qVKWN37ZcYrGv+oNc+0ZfkxOtrg4rTdPGb2fJ/vaRJIv1?=
 =?us-ascii?Q?hgfxvJk0UZYuYyhqiJZk2OX4eG+BLfRlxHH/hZIKVqtun7T+M3Z+ovo5iQyg?=
 =?us-ascii?Q?OoIb4zZg5VKYFxO9pkljnyeP8JpVq819hcaY3uVH64Hi6ML8UKHPwxxlUcOn?=
 =?us-ascii?Q?kBa4CemaZbyDY6yaLWFBwp7Xe1VgRCHVXLSpmE4g+04xeZXnCaSKs0b61H5C?=
 =?us-ascii?Q?uuPVx/OIWF3Pwkjr6GOsI0DZRLPlL1gJI0+Y9zEfFDH6aHO3UiuUG+FVQf5A?=
 =?us-ascii?Q?ExvGXXzNpTRQBB4XZL84L7Ga5DNrSuzokzRMGVmw1YliroAsyZiZIKThouSF?=
 =?us-ascii?Q?NHSsK4lJXU4JqxoLUZh77k+8IohlRzZxV3szWtnIMmAuK7O+QTmuNJFXWg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MqbZ3b/Is1+lGq5aZTq/odPuZ69aVRrtO2LBKR6uwAfwYgg2bNf206c/aNN5?=
 =?us-ascii?Q?aqgpEAYk20/L8vT62VTHMzdiPe/OSzG0cFN5dwB2FSaTIfRIuP+vCuifF5rG?=
 =?us-ascii?Q?q/khOzV0o5+od2mLOeQaYbXbCY4BDytld+u0P19FxRbQOnlcRrHXnJBnEbpW?=
 =?us-ascii?Q?dRYAZhglQqz5jv2Yl9EnT1FnkVxgllPs3PLMtgz9BrCmxWPMXnpaKiOhpuzF?=
 =?us-ascii?Q?/VRFhsnnOTL7lLLhwapCI71UiT7y6VlKZAZS9KKgJrRBjz8DqE28uArkx5aF?=
 =?us-ascii?Q?RmFobNNZgtx3v0sxRNXlRj926SbmbczX5nPWxbDDTIDY9wecIOi4v570/2LR?=
 =?us-ascii?Q?1aTFaHRq43AUkhLSSfmHw+0KZhIoIkTOnIPounvSr1J1qkJ41OhvSxRr82mp?=
 =?us-ascii?Q?Yr6jw8KV9s5tIJhoT6Qh21L9TT6X1PijI77avB1xaOYCMWMHQgzIImKbh+zm?=
 =?us-ascii?Q?6PJL2KGNk1VTik0Qfuolpq4LsV7APlYTBhAQ30/YAlXkYl3M5D6UiDOcdewC?=
 =?us-ascii?Q?VfKODvQFOK6QTCF/3ZH7/vfVpgB3ZEXPuQxvW9lIXDIO94555Fw0iFW3Hvnk?=
 =?us-ascii?Q?9a3luWMo6ZcVGwtUR4cepsIkg+C00ozL1uFrTkWHMA1mZ7IfjIULw/SD/b3A?=
 =?us-ascii?Q?T/kJBaBvxrDtDAdMXAQdwqcC/NLNRr5YjE7Wxc0wGmobI+2b7wOVwjMxCq5M?=
 =?us-ascii?Q?BJFS0L/YsfaikAlvATjHe99ZsRApMHUf97usDpWMbOZUy1rlJQRuWiXVkdds?=
 =?us-ascii?Q?MrnWgSejthrrKWHiQ1+lyhUfd0GrIuYv10nnfcfIBST716EdrJFdKv4Eblcd?=
 =?us-ascii?Q?z51DlACndqHYmaBHz8xEuIz9RAO7b/bSAsplMTJ0y+/AKh0iQ+I9zUFvcG0W?=
 =?us-ascii?Q?j8z/n6mMBABEgr5YfRbjH4mDsvyIsv33mIJMVMW3VerCJc+ori8Q9MEfI0Co?=
 =?us-ascii?Q?sj4WoSKgRvzt5de6Bmde2TrChs1xX5pY4ILJBLXskXTpI4NeOpP1Z30G999C?=
 =?us-ascii?Q?L+I2NBwoepzrRsviSzGRBAV+lGUx6eq5I0nSUaZHfE9JqNoGhrLav4prUPTK?=
 =?us-ascii?Q?VnOMpPi3+dF1NKytD7Dl8gK4QD5hw9WjlfKlaQT5ibttT4vsHQbvILXZiWmC?=
 =?us-ascii?Q?s3CPA/nNx1GHJ315pMZ33jCuv823W+v65qmTfgLPfQeaYYP51BOyHdQVs+83?=
 =?us-ascii?Q?3TGqLcHAHo2b6KyqA/Aqb4cylPIOTtbEOXBMsRPww+b+1RWo4sfi1Bv+8nHW?=
 =?us-ascii?Q?ISyoEOx8YCm/t+hxwP2lhQW3CBDAhw1x2QoplRwyAJ4PI44UB9ZKfubFd/1v?=
 =?us-ascii?Q?Ztd2oxnMQhjLXVoqyb9/jVOkxq0OARm2oBRdChNxihvITUS+cv7IRJVdkXUY?=
 =?us-ascii?Q?GVFzhp2N57DKYqmmRHu6Gav7c6VWtc4wNkIl44yxlJCn69FP3pSO3y5yLIDO?=
 =?us-ascii?Q?Qp/xg+icqkbh69+cBjwfYA05YMHyqCRxbVe5mZiWyPVj3rylKBdSlRvyzeeI?=
 =?us-ascii?Q?xr8Id66VyRs9a6WJVDS2M0qsh55rMKm687vzcfD3yNwQeTqxGnadP2RLcUqD?=
 =?us-ascii?Q?Q1VnzuDXlQ72tTnGBhFe4+HH2XhDZvClygEKmKmj?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dcbff9-49c1-4c08-0c5d-08de120d0956
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 08:20:33.3287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwrFCKvYfX03U2iNP8fvn1O+J71E3tGlKBJgC4hoHoPkhtjofSTJfkew8ljTzJinsNZu76umyPU646qiYGcjwyQV0oRD5pkTvZaSXlNGxAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5549

> Subject: Re: [PATCH v5 2/3] Irqchip/ast2700-intc: add debugfs support for
> routing/protection display
>=20
> On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:
>=20
> The prefix is: irqchip/ast....:

I'll use irqchip/aspeed-intc:

>=20
> > AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only include
> > the interrupt controller child node ("aspeed,ast2700-intc-ic"), but
> > also provide interrupt routing and register protection features.
>=20
> Lacks a new line to open a new paragraph.

I'll split the opening sentence and the follow-up paragraph in
the commit message.
>=20
> > Adds debugfs entries for interrupt routing and protection status for
>=20
> Add

Will update

>=20
> > AST2700 INTC0/INTC1.
>=20
> But what you are failing to explain is why this is required and useful. J=
ust
> adding code because we can is not a real good reason.

The INTC0/INTC1 routing and protection registers are set up by early firmwa=
re
and are not modified by Linux.=20

When routing is off, interrupts get merged/misdirected silently.
A minimal kernel-side visibility helps confirm that the upstream interrupt
topology (e.g., which INTC1 groups are funneled to which INTC0 inputs / GIC=
 SPIs)
matches what the DT and drivers assume.

The protection bits gate which CPU can write/read specific INTC=20
windows (PSP/SSP/TSP). When those are mis-programmed,=20
Linux can neither steer nor even read status in places it expects to.=20
A raw readout lets us verify that Linux isn't boxed out by mistake.
>=20
> Thanks,
>=20
>         tglx

