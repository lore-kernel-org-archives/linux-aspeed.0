Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB91606A88E
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lWVtj1Al
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPzCb2QH4z3bVW;
	Thu, 12 Nov 2026 09:46:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794417134;
	cv=pass; b=djWntQpg4nmAvEcZ1F3h1qlxTqZZdIqNitS7EF13SCzWY9hENbBcPuUH5dHTbG0o0dgApUUQIeVEdoABsmd4Jx5nfJSuSUw+XvBKrpFMYUqRlnIOPU46xZzz9wuPz1YFg5BGSX7Rza+nKxnBn9/KIoWFoAIG2lG3vrHZGEoKqAm2+KMaHctxj3wSzS+sRqorBgQPJ/zBpWdaR6X6qbaD0dDelc/PEwtEsNpVijU92jo5OQt9c4otIcrSzDeYfWF1SKMuGMVb1ycx1gVfaqEkpN8kJK86Gnk7Ng5ZHvQJfdic5Kis7PQ/srQgJ8IG06z+ah5FY4Fl0qi5IOY3MGv4Yw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794417134; c=relaxed/relaxed;
	bh=yy22XWQwpnPPgJ/pVk38p0ugt5BRPKvge48cU9RAFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W6G8U2BWVUIMK1bHG3k++nLckEo6Szhx2jiv/07PxQYpm+ACjmlpd/kFEpOLJGI3s4cawoOuUCNsFGva/GKJmFrX50MUVoTj2uIq3dtilVw69ou9N4ibCXRtiwmlN4RKIKauL/Lcl04t4xjmxJ2U34Po5vDmQ/HtX8qneB8eatZd3GkOIIY+/sb/MA6DUo+DM/Ua/+k9UTkBy2di2VD2UzQpxkoTNLNrMlHgoEIq9vgtMVkto8n5PZg77Lj9aCmR+6xQuJH6sB+iVmrxsPQNeKmBN7/MMI3R00AgPZhPJUXIp84rZROiBnF/fFusL6r24ISyolzgnXq1GnMG1yyhtA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lWVtj1Al; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lWVtj1Al;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPqnl6Hfqz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Nov 2026 04:12:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUWmbepC/ZDeioBE2E7IiXdXiX6It3fzKUQOE96uM2YWXCPRw/OixLLNDl9vJfYCSbbxyq843qpKLRHSxCrrJ44Jig7LxiJuHQH22iHQfGmWIU4mEFr4writ3F+vMnZZoIU4XLPetvGEXJgpSWnhmlf/21Be7C58edDDPurQqII3Nnw7hndMpCfj5ujisVbQQhoREAKs/54ymMwjGtZBFBGba1IbnD1qeLwcT8tWN9DH96qigq2AdVSfDbtbX5B72YmyPeQdMQBzDSINHE2Uyzc3V01srDjHiL8KfpJinJBvosFr8t8toWolYJPL6xOfguei66IJh1c5q7iv1NdMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy22XWQwpnPPgJ/pVk38p0ugt5BRPKvge48cU9RAFDo=;
 b=SYAs53JymBj/d2aqvALSV6rWkTXM9F7aARhVS582WXGkJMhO1eaT8dOO5SbYCRXGAULliZJvD4n/beWurJ7dOztE5Wd9RsvAqPenWUBL41NGje0lYQTDjeOE6NMWmoJjf/yLCvkpBBxfG7MJGvPXwj3U1RRMDD0y1nOzqs+atNHy2dfJR895KlBbjzT8yKfEm1huS0h5FlogS9m6d69jQEDop7VJwxZelFeBOMv1WItmPRmxH75e720HWsW3C4vVrRwnyq5EcP2oT4YezjhX9zl0/hrmXyPlH+/BGyG/WY5l2lRQd7nn36zEu1nBbZq8begf7iB3CK3E/v40PUli9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy22XWQwpnPPgJ/pVk38p0ugt5BRPKvge48cU9RAFDo=;
 b=lWVtj1Al4RHPwVNrBbxSyLRoqcX7Q6ZK/R4wEOKsOJr1hmHetbluCZU0g4IhgGPgChlhDbT7boEmcoMKwhsHvdjtHRZ5DcScbslmzVv0KvnPqr/x5a5ZUXR+SRq4ak0u0WFlXSHoDGSTLH0p+PA/v/WihYoymHwiKcQdY558B0+BFI1U6qL1RFVWhPSrYFR+J/IKBy9h7kQMkg6jVPrNVJaY+evdiPWp8lgjUlxwAc9M9G/u50fEzAk2YnqhrcQhI8pv7v7UzjJkwqmzxVTrZD0KfVAJuT+7+jz6G60UtpSYAxNhrmBKOUAP8I3658R/JH+kUU2erUOVkEy9N1IH+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:11:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:11:52 +0000
Date: Wed, 11 Nov 2026 12:11:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>, tbevis@amazon.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] i3c: mipi-i3c-hci: Add support for the AST2700
 I3C controller
Message-ID: <avShzxfk1kpji2iZ@lizhi-Precision-Tower-5810>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
 <20261111-b4-i3c-hci-ast2700-v2-6-4d8fff5c5196@aspeedtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-b4-i3c-hci-ast2700-v2-6-4d8fff5c5196@aspeedtech.com>
X-ClientProxiedBy: PH7PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:510:33d::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9ca551-b35d-4e79-4fab-08df4016e167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|6133799003|261009221227099003|261009220027099003|261009223327099003|261009221727099003|261009223027099003|3023799007|4143699003|10067099003|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	bZ3pGIZidm2LsAYG/6ZHBmb7HvHSci7MgyjpzWk9u0oYXXxh5yblpx8uy4TqORmt3GXfa0M+hfQx6Sit/nvpHMK1+wm3y0HPxWraB6xenvKrzQyEHMStVIUbLJH9v9WGOVJo0fOeoWn8CUMGDpfwmMlDjaIC9uaCLUH8AQ14O5+pQ+Hjs0Y1ANWjS9amgh7FCkhy4EoSLlAtfK5HjRd7Gp2fnqDNKdxXCmnBJDWchEO1rCYUVw9YZ1cTzbGw3aGWDvsM4xMP7PjdkIs693LiFPWKaClrwg8JrgK2jUP1AnjJcjNxW1IlnvPu1/bgkWgiTxeNtGXaK5xYIjGr+cXPbO9tSYkuWIRVzh3sZOm2+M9fpN1wP6S5zHhrMzB0ocUxRt2xmy+aBObJp6dw3WTONIJvafl4xr5q5Qb9WW129XTzKVYAx+bdaJ18AfL3m9kMXve7dbEg6AnUtE6VLupp9TPpfRWY+TLuu6R61AD3Gfxddz5motqvrb2pWyS2lnFD/6zgGC/6n5910W88XOgwYfa7heH06wDM/mwmwmd368JBRMfnunH92XRRpSUTwX02yhL46J+hDv7UzPpyCL0dfgAg4idCzqEsUPuihfnlwB4QkHZg1uI/4V12qrQkO5CKfIllkc5o000lczwq0HJjEBo5TAiJGu9OM1g5nuNdtDU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(261009221227099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009223027099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hwECnjLJWyrAx2jrCDlKVRJCnnd8EoNZ1yKEtLPO+iXneHrhhIp7ZJ+B0lzs?=
 =?us-ascii?Q?V7vqQOfZ7z/woLfytLpiyQfj1mGu/lvKgAkIiDrbcGP7cda0hbHIhKdAAZZK?=
 =?us-ascii?Q?OauUpFdWQlxlUSUMgVdvg/sPYN9OCVg0ejVZDcH5OVvSEaflxmRX4Y3W/mCC?=
 =?us-ascii?Q?oslt+5OIIonMvX3DqZlXHKLrt5OMpHJsyH9WlXBD9W1GC9o4zh2uIbbSZp3s?=
 =?us-ascii?Q?KIcxpOh0mMQyPVVTk2UXmE0PeFQ0ey4fOnXVj4XkW9wGFx5TbWQL4Rfr5ycS?=
 =?us-ascii?Q?dCdSATfY/sN4iUkC6gT3SuBo9UMjamxanSoENn4IkET4Yy/OlsGDWPhSKiy4?=
 =?us-ascii?Q?k3+Uj/ky3GG8BYl4vX2ETA6TrXYsNlcmTsUtQOazAVhWh79sr2oVpTEM5Ecp?=
 =?us-ascii?Q?j1aOkGohjXGzasXhcNJfRJAIHxgHoTHRZRiK9oYSbL0Ol+bgx569J9Xbkohh?=
 =?us-ascii?Q?w1J11yS/uoaGu8ZhZLS2yHpLsFDUEOzMSNmDOZAQyhQ+4aIkyivqOKy6zN0u?=
 =?us-ascii?Q?EnAvgBpHTZNvuYTK0f5akfOuyfSeV1NOH8I7bRjNfO+qtGWcrA0x14ffpM9r?=
 =?us-ascii?Q?uEqvSd/+03dPQty1pbFAaJQl1qOvpnSi/OJTq3IHWJwB7fo0f7T9j/zhmwk3?=
 =?us-ascii?Q?gLAVnXP83bVVrrV2VyJortisfb9ZPLx7gMdBPlJcyheR2681CVpUTZN8eeFP?=
 =?us-ascii?Q?ciocLYazNO/8f7YhuHJlmx/2zxOVgbb5E9pe5vTIkEXZwXht89d3F+hjWSYI?=
 =?us-ascii?Q?z18vnB8QFVwFL9WJuj+DFDj9H6ExCaIQUaEPPwlKS1jDM60y8VQ/rQMT0epT?=
 =?us-ascii?Q?hgoR9HmJaiSBSTaDuhcmq+5f0lQm/G8G/1lfIPeNZr6+QEqTd6TEsYkxVidJ?=
 =?us-ascii?Q?mO6xipYXZejFXsRthNRAUuiUZ8E/JWfSXo/ao/u8D7iir+bqwNhVq/cN5V0F?=
 =?us-ascii?Q?BXSdPmi5CSh/NkrsWCnrKsaF4w/LITgN/sYed8psWy2wPJ1xvJa1RDv+DhYB?=
 =?us-ascii?Q?E6nkFiVZCryWt3aaieG0Hd2V+RruTfuEZ4UuAfjyJMgElBTWI0bQfc2HWgmZ?=
 =?us-ascii?Q?ijisn4gyTcfOWYyqox9FdLCcZxKYv/ajLpytyGpKuev0RRWz3HjYuPvWhbNU?=
 =?us-ascii?Q?nFzDN/DUHLQOi/bAsb1ZIFGI+lcU7XEZpHOqXMu5RqOM7rRU/lNirva8QE9L?=
 =?us-ascii?Q?xEUQWdmvV0MXWswmDpvKHI0Zk7f2K0WiaUTbfcPt4+zN1VhOuzJNv8HwuPn1?=
 =?us-ascii?Q?aKi9n6mXR7L/x1FJUYb5tuyJj4VrDBKGUZB8liBWr5guskJ/yyVCd9SlJg9i?=
 =?us-ascii?Q?f/N2ROyVt8gAaZGFWgTBLE/U1962KklWqCZLFCdEOlkGftf9s1VUwdY9YEwi?=
 =?us-ascii?Q?sRVBV9ejt+YkJp4rnyzXaSjGC59XYJKKVJU9fsqT6uoAaSpTW5po4IsEgTSD?=
 =?us-ascii?Q?cwKYc4YiYyH6iB4TRrLl59O7AbVr5N13Okgac8Of4A4aNh5lRav++o3kcPgX?=
 =?us-ascii?Q?5WYV1QW032dReOcDN2qyxryMtka6OjJIA04eQ9O+tAAz4WrQlo7nyOA4Nzay?=
 =?us-ascii?Q?Lt2QIKg2OIZQAXjV+Imt7b83l9y2C0F4eSTZFcxLaKjsxKRERKIh+kzQPodh?=
 =?us-ascii?Q?c5UG2wOWvWzx1DcvA27NsJdEASeTYqhmQ7801e/WyLjbSwdW20lRNqZvY/Vg?=
 =?us-ascii?Q?JdHjGAfEES+Z96trXU8pThjSaugN08f5kTy0ZDofbhQxsJ2wcFy4OVn2G/ji?=
 =?us-ascii?Q?87qh7jG1t1feMAYpxaCxXreEPFmQcDAW8kU5IWcW0ua/wRcFvvUa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9ca551-b35d-4e79-4fab-08df4016e167
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:11:52.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQU06uM/mIeHGlZLhDZS+lGWlUDAXyGIHLTb9YUpL6Y3BKXu/Y4pR9/CHtM0wWcUbcHcAv1qlYHxUGEA86i6PIZWZNavELPbE4UXb9ITYes3NgnVriFMrq8TONcXI2BU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:16:34AM +0800, Billy Tsai wrote:
> The AST2700 I3C controller carries an ASPEED vendor extended
> capability describing an in-house control block and a PHY programming
> window. Recognize the ASPEED MIPI vendor ID in the extended capability
> parser and cache both register bases via the generic vendor_data
> pointer, which other vendors (e.g. NXP) also populate.
>
> Bringing the controller up for transfers needs more than the generic
> HCI reset sequence: the vendor block has to be switched to master
> mode, PHY timing registers programmed from the selected bus rate (with
> i3c-*-ns device tree properties to override values derived under
> nominal bus loading), and all interrupts funneled through a vendor
> summary register whose handler dispatches to the same core and IO
> handlers as the generic path. Master clock stall is enabled alongside
> master-mode init so an underrun pauses and resumes the transfer
> instead of aborting it. Hook this initialization into bus setup and
> resume, and acquire the core clock and reset-names resources the
> binding describes for it; probe fails if the vendor capability was
> expected but the hardware doesn't actually expose the register blocks
> it needs.
>
> During normal operation, the vendor DAA index registers must be told
> which DAT slot is being assigned during ENTDAA, clearing all four
> index register banks each time since the controller scans forward
> across all of them for the first bit set to pick the address to
> assign. The PIO/IBI FIFOs also need resetting after a DMA error or
> abort, which the core already implements behind
> HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET, so set that quirk.
>
> Each of these behaviors gets its own quirk bit
> (HCI_QUIRK_VENDOR_BUS_SETUP, HCI_QUIRK_BOARD_PHY_TIMINGS,
> HCI_QUIRK_VENDOR_INTR_SUMMARY, HCI_QUIRK_VENDOR_RESOURCES,
> HCI_QUIRK_VENDOR_DAA_INDEX), set together for the
> "aspeed,ast2700-i3c-hci" compatible alongside DAT_INDEX_IS_ADDR,
> DMA_64BIT and TX_START_THLD.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/Makefile   |   2 +-
>  drivers/i3c/master/mipi-i3c-hci/aspeed.c   | 351 +++++++++++++++++++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/aspeed.h   | 160 +++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/cmd_v1.c   |   3 +
>  drivers/i3c/master/mipi-i3c-hci/core.c     | 148 ++++++++++--
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.c |   2 +
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.h |   1 +
>  drivers/i3c/master/mipi-i3c-hci/hci.h      |   7 +
>  8 files changed, 658 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
> index e3d3ef757035f..ce560b81be01f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
> @@ -4,5 +4,5 @@ obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
>  mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
>  					   cmd_v1.o cmd_v2.o \
>  					   dat_v1.o dct_v1.o \
> -					   hci_quirks.o
> +					   hci_quirks.o aspeed.o
>  obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
> diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.c b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
> new file mode 100644
> index 0000000000000..3aa910e786f8e
> --- /dev/null
> +++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 ASPEED Technology Inc.
> + *
> + * AST2700 vendor capability handling: resource acquisition, register
> + * access, PHY timing initialization and DAA index support.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include "hci.h"
> +#include "aspeed.h"
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
> +	struct clk *clk;
> +};
> +
> +int hci_extcap_vendor_ASPEED(struct i3c_hci *hci, void __iomem *base)

function name don't mix low/up case.

hci_extcap_vendor_aspeed()

> +{
> +	struct aspeed_i3c_vendor_data *vd = to_aspeed_vendor_data(hci);
> +
> +	vd->inhouse_regs = hci->base_regs + readl(base + 0x04);
> +	vd->phy_regs = hci->base_regs + readl(base + 0x08);
> +
> +	return 0;
> +}
> +
> +bool aspeed_i3c_vendor_cap_found(struct i3c_hci *hci)
> +{
> +	struct aspeed_i3c_vendor_data *vd = to_aspeed_vendor_data(hci);
> +
> +	return vd->inhouse_regs && vd->phy_regs;
> +}
> +
> +static void aspeed_i3c_core_rst_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +int aspeed_i3c_alloc_resources(struct i3c_hci *hci, struct platform_device *pdev)
> +{
> +	struct aspeed_i3c_vendor_data *vd;
> +	struct reset_control *rst;
> +	int ret;
> +
> +	vd = devm_kzalloc(&pdev->dev, sizeof(*vd), GFP_KERNEL);
> +	if (!vd)
> +		return -ENOMEM;
> +	hci->vendor_data = vd;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "core");
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	ret = reset_control_assert(rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, aspeed_i3c_core_rst_assert, rst);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Unlike "core", "dma" is shared across every I3C instance and the
> +	 * DMA engine behind it does not tolerate being reset once running,
> +	 * so it is only ever deasserted here, never pulsed.
> +	 */
> +	rst = devm_reset_control_get_optional_shared_deasserted(&pdev->dev, "dma");
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	vd->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(vd->clk))
> +		return PTR_ERR(vd->clk);
> +
> +	return 0;
> +}
> +
> +/*
> + * The DAA index registers name the DAT slot being assigned during ENTDAA;
> + * they live in the vendor capability block discovered at probe time. The
> + * controller scans forward from the named slot across all four banks for
> + * the first bit set to find the address to assign, so a bit left over
> + * from a previous round must be cleared or it is mistaken for the current
> + * one. This assumes exactly one index is armed per ENTDAA attempt,
> + * matching hci_cmd_v1_daa()'s one-device-per-command loop; it is not
> + * meant to arm multiple indices ahead of a single multi-device ENTDAA.
> + */
> +void aspeed_i3c_set_daa_index(struct i3c_hci *hci, unsigned int dat_idx)
> +{
> +	void __iomem *inhouse_regs = to_aspeed_vendor_data(hci)->inhouse_regs;
> +
> +	writel(0, inhouse_regs + ASPEED_I3C_DAA_INDEX0);
> +	writel(0, inhouse_regs + ASPEED_I3C_DAA_INDEX1);
> +	writel(0, inhouse_regs + ASPEED_I3C_DAA_INDEX2);
> +	writel(0, inhouse_regs + ASPEED_I3C_DAA_INDEX3);
> +
> +	if (dat_idx < 32)
> +		writel(BIT(dat_idx), inhouse_regs + ASPEED_I3C_DAA_INDEX0);
> +	else if (dat_idx < 64)
> +		writel(BIT(dat_idx - 32), inhouse_regs + ASPEED_I3C_DAA_INDEX1);
> +	else if (dat_idx < 96)
> +		writel(BIT(dat_idx - 64), inhouse_regs + ASPEED_I3C_DAA_INDEX2);
> +	else
> +		writel(BIT(dat_idx - 96), inhouse_regs + ASPEED_I3C_DAA_INDEX3);
> +}
> +
> +u32 aspeed_i3c_read(struct i3c_hci *hci, u32 reg)
> +{
> +	return readl(to_aspeed_vendor_data(hci)->inhouse_regs + reg);
> +}
> +
> +void aspeed_i3c_write(struct i3c_hci *hci, u32 reg, u32 val)
> +{
> +	writel(val, to_aspeed_vendor_data(hci)->inhouse_regs + reg);
> +}
> +
> +static void aspeed_i3c_phy_write(struct i3c_hci *hci, u32 reg, u32 val)
> +{
> +	writel(val, to_aspeed_vendor_data(hci)->phy_regs + reg);
> +}
> +
> +static u16 aspeed_i3c_ns_to_cnt(unsigned int ns, unsigned long period_ns)
> +{
> +	unsigned long cycles = DIV_ROUND_CLOSEST(ns, period_ns);
> +
> +	/* All PHY counter fields are 11 bits wide */
> +	return min_t(unsigned long, max_t(unsigned long, cycles, 1) - 1,
> +		     ASPEED_I3C_PHY_CNT_MAX);

now use min() and max() should be okay.

> +}
> +
> +static u32 aspeed_i3c_get_sdr_ctrl0_reg(struct i3c_hci *hci)
> +{
> +	struct i3c_bus *bus = i3c_master_get_bus(&hci->master);
> +
> +	if (bus->scl_rate.i3c > 8000000)
> +		return ASPEED_I3C_PHY_I3C_SDR0_CTRL0;
> +	if (bus->scl_rate.i3c > 6000000)
> +		return ASPEED_I3C_PHY_I3C_SDR1_CTRL0;
> +	if (bus->scl_rate.i3c > 4000000)
> +		return ASPEED_I3C_PHY_I3C_SDR2_CTRL0;
> +	if (bus->scl_rate.i3c > 2000000)
> +		return ASPEED_I3C_PHY_I3C_SDR3_CTRL0;
> +
> +	return ASPEED_I3C_PHY_I3C_SDR4_CTRL0;
> +}
> +
> +int aspeed_i3c_phy_init(struct i3c_hci *hci)
> +{
> +	u16 hcnt, lcnt, total_cnt, min_tbit_cnt, cas_lcnt, cas_cnt, cbp_cnt;
> +	u32 pp_sda_hold = 0, cas_ns = 0, cbp_ns = 0, sr_p_low = 0;
> +	struct i3c_bus *bus = i3c_master_get_bus(&hci->master);
> +	u32 pp_high = 0, pp_low = 0, od_high = 0, od_low = 0;
> +	struct device_node *np = hci->master.dev.of_node;
> +	u32 sdr_ctrl0_reg, ctrl0, ctrl1, ctrl2;
> +	unsigned long core_rate, period_ns;
> +
> +	core_rate = clk_get_rate(to_aspeed_vendor_data(hci)->clk);
> +	if (!core_rate) {
> +		dev_err(&hci->master.dev, "invalid core clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	period_ns = DIV_ROUND_UP(NSEC_PER_SEC, core_rate);
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_CAS_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_SU_STO_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FM_CTRL0,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL0_CAS, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL0_SU_STO, lcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_SCL_H_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_SCL_L_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FM_CTRL1,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL1_SCL_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL1_SCL_L, lcnt));
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FM_CTRL2,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL2_ACK_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL2_ACK_L, hcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_HD_DAT_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_AHD_DAT_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FM_CTRL3,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL3_HD_DAT, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FM_CTRL3_AHD_DAT, lcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_CAS_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_SU_STO_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FMP_CTRL0,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL0_CAS, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL0_SU_STO, lcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_SCL_H_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_SCL_L_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FMP_CTRL1,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL1_SCL_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL1_SCL_L, lcnt));
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FMP_CTRL2,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL2_ACK_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL2_ACK_L, hcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_HD_DAT_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FMP_AHD_DAT_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I2C_FMP_CTRL3,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL3_HD_DAT, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I2C_FMP_CTRL3_AHD_DAT, lcnt));
> +
> +	of_property_read_u32(np, "i3c-pp-scl-high-period-ns", &pp_high);
> +	of_property_read_u32(np, "i3c-pp-scl-low-period-ns", &pp_low);
> +	if (pp_high && pp_low) {
> +		hcnt = aspeed_i3c_ns_to_cnt(pp_high, period_ns);
> +		lcnt = aspeed_i3c_ns_to_cnt(pp_low, period_ns);
> +	} else {
> +		/*
> +		 * Each of hcnt/lcnt is programmed as N-1 (the PHY counts N
> +		 * cycles for a stored value of N-1), so pre-subtract 2 here
> +		 * to cancel the two implicit +1s and match the requested SCL
> +		 * period exactly. Clamp the pre-subtraction value so
> +		 * total_cnt cannot underflow when an unrealistically high
> +		 * scl_rate leaves less than 3 cycles per period.
> +		 */
> +		unsigned long cycles_per_scl = DIV_ROUND_UP(core_rate, bus->scl_rate.i3c);
> +
> +		total_cnt = max_t(unsigned long, cycles_per_scl, 3) - 2;
> +		if (hci->master.bus.mode == I3C_BUS_MODE_PURE) {
> +			hcnt = DIV_ROUND_DOWN_ULL(total_cnt * 2, 5);
> +			lcnt = total_cnt - hcnt;
> +		} else {
> +			hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MIXED_MAX_NS,
> +					    period_ns) - 1;
> +			lcnt = total_cnt - hcnt;
> +		}
> +	}
> +
> +	ctrl0 = FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL0_SCL_H, hcnt) |
> +		FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL0_SCL_L, lcnt);
> +	sdr_ctrl0_reg = aspeed_i3c_get_sdr_ctrl0_reg(hci);
> +	aspeed_i3c_phy_write(hci, sdr_ctrl0_reg, ctrl0);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_SDR0_CTRL0, ctrl0);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_DDR_CTRL0, ctrl0);
> +
> +	min_tbit_cnt = DIV_ROUND_UP(60, period_ns) - 1;
> +	ctrl1 = FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL1_TBIT_H,
> +			   max_t(u16, hcnt, min_tbit_cnt)) |
> +		FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL1_TBIT_L,
> +			   max_t(u16, lcnt, min_tbit_cnt));
> +	aspeed_i3c_phy_write(hci, sdr_ctrl0_reg + ASPEED_I3C_PHY_CTRL1_OFFSET,
> +			     ctrl1);
> +	aspeed_i3c_phy_write(hci,
> +			     ASPEED_I3C_PHY_I3C_SDR0_CTRL0 +
> +			     ASPEED_I3C_PHY_CTRL1_OFFSET, ctrl1);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_DDR_CTRL1, ctrl1);
> +
> +	/*
> +	 * tCAS and tCBP default to a value derived from the SCL low period
> +	 * of the applicable bus context, clamped to the MIPI I3C minima
> +	 * (tCAS >= 38.4 ns, tCBP >= 19.2 ns). Explicit device tree values
> +	 * are used as-is; the binding carries the minima as constraints.
> +	 */
> +	if (hci->master.bus.mode == I3C_BUS_MODE_PURE)
> +		cas_lcnt = lcnt;
> +	else
> +		cas_lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_I2C_FM_SCL_L_NS,
> +						period_ns);
> +	of_property_read_u32(np, "i3c-cas-period-ns", &cas_ns);
> +	of_property_read_u32(np, "i3c-cbp-period-ns", &cbp_ns);
> +	cas_cnt = cas_ns ? aspeed_i3c_ns_to_cnt(cas_ns, period_ns)
> +			 : max_t(u16, cas_lcnt,
> +				 DIV_ROUND_UP(ASPEED_I3C_PHY_OD_MIN_CAS_NS_X10,
> +					      period_ns * 10) - 1);
> +	cbp_cnt = cbp_ns ? aspeed_i3c_ns_to_cnt(cbp_ns, period_ns)
> +			 : max_t(u16, cas_lcnt,
> +				 DIV_ROUND_UP(ASPEED_I3C_PHY_OD_MIN_CBP_NS_X10,
> +					      period_ns * 10) - 1);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL0,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL0_CAS, cas_cnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL0_CBP, cbp_cnt));
> +
> +	of_property_read_u32(np, "i3c-od-scl-high-period-ns", &od_high);
> +	of_property_read_u32(np, "i3c-od-scl-low-period-ns", &od_low);
> +	if (od_high && od_low) {
> +		hcnt = aspeed_i3c_ns_to_cnt(od_high, period_ns);
> +		lcnt = aspeed_i3c_ns_to_cnt(od_low, period_ns);
> +	} else {
> +		hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_OD_SCL_H_NS, period_ns);
> +		lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_OD_SCL_L_NS, period_ns);
> +	}
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL1,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL1_SCL_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL1_SCL_L, lcnt));
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL2,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL2_ACK_H, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL2_ACK_L, lcnt));
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_HD_DAT_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_AHD_DAT_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL3,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL3_HD_DAT, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL3_AHD_DAT, lcnt));
> +
> +	of_property_read_u32(np, "i3c-pp-sda-hold-ns", &pp_sda_hold);
> +	hcnt = aspeed_i3c_ns_to_cnt(pp_sda_hold ?: ASPEED_I3C_PHY_HD_DAT_NS,
> +				    period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(pp_sda_hold ?: ASPEED_I3C_PHY_AHD_DAT_NS,
> +				    period_ns);
> +	ctrl2 = FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL2_HD_PP, hcnt) |
> +		FIELD_PREP(ASPEED_I3C_PHY_I3C_CTRL2_TBIT_HD_PP, lcnt);
> +	aspeed_i3c_phy_write(hci, sdr_ctrl0_reg + ASPEED_I3C_PHY_CTRL2_OFFSET,
> +			     ctrl2);
> +	aspeed_i3c_phy_write(hci,
> +			     ASPEED_I3C_PHY_I3C_SDR0_CTRL0 +
> +			     ASPEED_I3C_PHY_CTRL2_OFFSET, ctrl2);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_DDR_CTRL2, ctrl2);
> +
> +	of_property_read_u32(np, "i3c-sr-p-scl-low-period-ns", &sr_p_low);
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_SR_P_HD_NS, period_ns);
> +	lcnt = aspeed_i3c_ns_to_cnt(sr_p_low ?: ASPEED_I3C_PHY_SR_P_SCL_L_NS,
> +				    period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_SR_P_PREPARE_CTRL,
> +			     FIELD_PREP(ASPEED_I3C_PHY_SR_P_PREPARE_HD, hcnt) |
> +			     FIELD_PREP(ASPEED_I3C_PHY_SR_P_PREPARE_SCL_L, lcnt));
> +
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_PULLUP_EN, 0);
> +
> +	hcnt = aspeed_i3c_ns_to_cnt(ASPEED_I3C_PHY_OD_DAP_NS, period_ns);
> +	aspeed_i3c_phy_write(hci, ASPEED_I3C_PHY_I3C_OD_CTRL4,
> +			     FIELD_PREP(ASPEED_I3C_PHY_I3C_OD_CTRL4_DAP, hcnt));
> +
> +	return 0;
> +}
> diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.h b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
> new file mode 100644
> index 0000000000000..7ff1f66b67cd9
> --- /dev/null
> +++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
> @@ -0,0 +1,160 @@
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
> +
> +#include "ext_caps.h"
> +#include "hci.h"
> +
> +struct platform_device;
> +
> +/*
> + * The AST2700 vendor extended capability points to an in-house control
> + * block and a PHY programming window inside the controller's register
> + * space, plus the core clock and reset lines the AST2700 binding
> + * specifies. All of it is ASPEED-specific, so struct aspeed_i3c_vendor_data
> + * stays private to aspeed.c; everyone else reaches it only through the
> + * functions below.
> + */
> +struct aspeed_i3c_vendor_data;
> +
> +static inline struct aspeed_i3c_vendor_data *to_aspeed_vendor_data(struct i3c_hci *hci)
> +{
> +	return hci->vendor_data;
> +}
> +
> +int hci_extcap_vendor_ASPEED(struct i3c_hci *hci, void __iomem *base);
> +int aspeed_i3c_alloc_resources(struct i3c_hci *hci, struct platform_device *pdev);
> +bool aspeed_i3c_vendor_cap_found(struct i3c_hci *hci);
> +void aspeed_i3c_set_daa_index(struct i3c_hci *hci, unsigned int dat_idx);
> +u32 aspeed_i3c_read(struct i3c_hci *hci, u32 reg);
> +void aspeed_i3c_write(struct i3c_hci *hci, u32 reg, u32 val);
> +int aspeed_i3c_phy_init(struct i3c_hci *hci);
> +
> +#define ASPEED_I3C_CTRL				0x00
> +#define ASPEED_I3C_CTRL_CLOCK_STALL_EN		BIT(14)
> +#define ASPEED_I3C_CTRL_INIT			BIT(4)
> +#define ASPEED_I3C_CTRL_INIT_MODE		GENMASK(1, 0)
> +#define   ASPEED_I3C_INIT_MST_MODE		0
> +
> +#define ASPEED_I3C_DAA_INDEX0			0x10
> +#define ASPEED_I3C_DAA_INDEX1			0x14
> +#define ASPEED_I3C_DAA_INDEX2			0x18
> +#define ASPEED_I3C_DAA_INDEX3			0x1c
> +
> +#define ASPEED_I3C_INTR_STATUS			0xe0
> +#define ASPEED_I3C_INTR_STATUS_ENABLE		0xe4
> +#define ASPEED_I3C_INTR_SIGNAL_ENABLE		0xe8
> +#define ASPEED_I3C_INTR_SUM_STATUS		0xf0
> +#define   ASPEED_INTR_SUM_INHOUSE		BIT(3)
> +#define   ASPEED_INTR_SUM_RHS			BIT(2)
> +#define   ASPEED_INTR_SUM_PIO			BIT(1)
> +#define   ASPEED_INTR_SUM_CAP			BIT(0)
> +
> +#define ASPEED_I3C_PHY_I2C_FM_CTRL0		0x08
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL0_CAS	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL0_SU_STO	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FM_CTRL1		0x0c
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL1_SCL_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL1_SCL_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FM_CTRL2		0x10
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL2_ACK_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL2_ACK_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FM_CTRL3		0x14
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL3_HD_DAT	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FM_CTRL3_AHD_DAT	GENMASK(10, 0)
> +
> +#define ASPEED_I3C_PHY_I2C_FMP_CTRL0		0x18
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL0_CAS	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL0_SU_STO	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FMP_CTRL1		0x1c
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL1_SCL_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL1_SCL_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FMP_CTRL2		0x20
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL2_ACK_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL2_ACK_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I2C_FMP_CTRL3		0x24
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL3_HD_DAT	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I2C_FMP_CTRL3_AHD_DAT	GENMASK(10, 0)
> +
> +#define ASPEED_I3C_PHY_I3C_OD_CTRL0		0x28
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL0_CAS	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL0_CBP	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I3C_OD_CTRL1		0x2c
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL1_SCL_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL1_SCL_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I3C_OD_CTRL2		0x30
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL2_ACK_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL2_ACK_L	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I3C_OD_CTRL3		0x34
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL3_HD_DAT	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL3_AHD_DAT	GENMASK(10, 0)
> +#define ASPEED_I3C_PHY_I3C_OD_CTRL4		0xd8
> +#define   ASPEED_I3C_PHY_I3C_OD_CTRL4_DAP	GENMASK(26, 16)
> +
> +#define ASPEED_I3C_PHY_I3C_SDR0_CTRL0		0x38
> +#define ASPEED_I3C_PHY_I3C_SDR1_CTRL0		0x44
> +#define ASPEED_I3C_PHY_I3C_SDR2_CTRL0		0x50
> +#define ASPEED_I3C_PHY_I3C_SDR3_CTRL0		0x5c
> +#define ASPEED_I3C_PHY_I3C_SDR4_CTRL0		0x68
> +#define   ASPEED_I3C_PHY_I3C_CTRL0_SCL_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_CTRL0_SCL_L	GENMASK(10, 0)
> +#define   ASPEED_I3C_PHY_I3C_CTRL1_TBIT_H	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_CTRL1_TBIT_L	GENMASK(10, 0)
> +#define   ASPEED_I3C_PHY_I3C_CTRL2_HD_PP	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_I3C_CTRL2_TBIT_HD_PP	GENMASK(10, 0)
> +
> +#define ASPEED_I3C_PHY_I3C_DDR_CTRL0		0x74
> +#define ASPEED_I3C_PHY_I3C_DDR_CTRL1		0x78
> +#define ASPEED_I3C_PHY_I3C_DDR_CTRL2		0x7c
> +
> +#define ASPEED_I3C_PHY_SR_P_PREPARE_CTRL	0x80
> +#define   ASPEED_I3C_PHY_SR_P_PREPARE_HD	GENMASK(26, 16)
> +#define   ASPEED_I3C_PHY_SR_P_PREPARE_SCL_L	GENMASK(10, 0)
> +
> +#define ASPEED_I3C_PHY_PULLUP_EN		0x98
> +
> +#define ASPEED_I3C_PHY_CTRL1_OFFSET		0x04
> +#define ASPEED_I3C_PHY_CTRL2_OFFSET		0x08
> +
> +#define ASPEED_I3C_PHY_CNT_MAX			GENMASK(10, 0)
> +
> +#define ASPEED_I3C_PHY_I2C_FM_CAS_NS		1130
> +#define ASPEED_I3C_PHY_I2C_FM_SU_STO_NS		1370
> +#define ASPEED_I3C_PHY_I2C_FM_SCL_H_NS		1130
> +#define ASPEED_I3C_PHY_I2C_FM_SCL_L_NS		1370
> +#define ASPEED_I3C_PHY_I2C_FM_HD_DAT_NS		10
> +#define ASPEED_I3C_PHY_I2C_FM_AHD_DAT_NS	10
> +
> +#define ASPEED_I3C_PHY_I2C_FMP_CAS_NS		380
> +#define ASPEED_I3C_PHY_I2C_FMP_SU_STO_NS	620
> +#define ASPEED_I3C_PHY_I2C_FMP_SCL_H_NS		380
> +#define ASPEED_I3C_PHY_I2C_FMP_SCL_L_NS		620
> +#define ASPEED_I3C_PHY_I2C_FMP_HD_DAT_NS	10
> +#define ASPEED_I3C_PHY_I2C_FMP_AHD_DAT_NS	10
> +
> +#define ASPEED_I3C_PHY_OD_SCL_H_NS		380
> +#define ASPEED_I3C_PHY_OD_SCL_L_NS		620
> +#define ASPEED_I3C_PHY_HD_DAT_NS		10
> +#define ASPEED_I3C_PHY_AHD_DAT_NS		10
> +#define ASPEED_I3C_PHY_OD_DAP_NS		12
> +
> +#define ASPEED_I3C_PHY_SR_P_HD_NS		16
> +#define ASPEED_I3C_PHY_SR_P_SCL_L_NS		40
> +
> +/*
> + * MIPI I3C minimum timing for the open-drain start/stop, in tenths of a
> + * nanosecond to keep the fractional spec values (tCAS >= 38.4 ns,
> + * tCBP >= 19.2 ns) in integer arithmetic.
> + */
> +#define ASPEED_I3C_PHY_OD_MIN_CAS_NS_X10	384
> +#define ASPEED_I3C_PHY_OD_MIN_CBP_NS_X10	192
> +
> +#endif
> diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> index d267aa19cb75b..04e29313b1fb2 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> @@ -14,6 +14,7 @@
>  #include "cmd.h"
>  #include "dat.h"
>  #include "dct.h"
> +#include "aspeed.h"
>
>  /*
>   * Address Assignment Command
> @@ -338,6 +339,8 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
>  		if (ret < 0)
>  			break;
>  		dat_idx = ret;
> +		if (hci->quirks & HCI_QUIRK_VENDOR_DAA_INDEX)
> +			aspeed_i3c_set_daa_index(hci, dat_idx);
>
>  		dev_dbg(&hci->master.dev,
>  			"next_addr = 0x%02x, DAA using DAT %d",
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index da77384e985cf..759892a3785b8 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -26,6 +26,7 @@
>  #include "cmd.h"
>  #include "dat.h"
>  #include "ibi.h"
> +#include "aspeed.h"
>
>  /*
>   * Host Controller Capabilities and Operation Registers
> @@ -140,6 +141,20 @@ struct device *i3c_hci_sysdev(struct device *dev)
>  	return dev->parent && dev_is_pci(dev->parent) ? dev->parent : dev;
>  }
>
> +static void aspeed_i3c_bus_setup(struct i3c_hci *hci)
> +{
> +	/*
> +	 * Enable master clock stall: when the controller cannot keep the
> +	 * data pipeline fed it holds SCL low instead of underrunning, so a
> +	 * transfer pauses and resumes cleanly rather than aborting.
> +	 */
> +	aspeed_i3c_write(hci, ASPEED_I3C_CTRL,
> +			 ASPEED_I3C_CTRL_CLOCK_STALL_EN |
> +			 ASPEED_I3C_CTRL_INIT |
> +			 FIELD_PREP(ASPEED_I3C_CTRL_INIT_MODE,
> +				    ASPEED_I3C_INIT_MST_MODE));
> +}
> +
>  static void i3c_hci_set_master_dyn_addr(struct i3c_hci *hci)
>  {
>  	reg_write(MASTER_DEVICE_ADDR,
> @@ -153,6 +168,15 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
>  	struct i3c_device_info info;
>  	int ret;
>
> +	if (hci->quirks & HCI_QUIRK_VENDOR_BUS_SETUP)
> +		aspeed_i3c_bus_setup(hci);
> +
> +	if (hci->quirks & HCI_QUIRK_BOARD_PHY_TIMINGS) {
> +		ret = aspeed_i3c_phy_init(hci);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
>  		ret = mipi_i3c_hci_dat_v1.init(hci);
>  		if (ret)
> @@ -826,22 +850,12 @@ static const struct i3c_master_controller_ops i3c_hci_ops = {
>  	.set_dev_nack_retry	= i3c_hci_set_dev_nack_retry,
>  };
>
> -static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
> +static irqreturn_t i3c_hci_core_irq(struct i3c_hci *hci)
> +__must_hold(&hci->lock)
>  {
> -	struct i3c_hci *hci = dev_id;
>  	irqreturn_t result = IRQ_NONE;
>  	u32 val;
>
> -	guard(spinlock)(&hci->lock);
> -
> -	/*
> -	 * The IRQ can be shared, so the handler may be called when the IRQ is
> -	 * due to a different device. That could happen when runtime suspended,
> -	 * so exit immediately if IRQs are not expected for this device.
> -	 */
> -	if (hci->irq_inactive)
> -		return IRQ_NONE;
> -
>  	val = reg_read(INTR_STATUS);
>  	reg_write(INTR_STATUS, val);
>  	dev_dbg(&hci->master.dev, "INTR_STATUS %#x", val);
> @@ -864,12 +878,73 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
>  		dev_warn_once(&hci->master.dev,
>  			      "unexpected INTR_STATUS %#x\n", val);
>
> +	return result;
> +}
> +
> +static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
> +{
> +	irqreturn_t result = IRQ_NONE;
> +	struct i3c_hci *hci = dev_id;
> +
> +	guard(spinlock)(&hci->lock);
> +
> +	/*
> +	 * The IRQ can be shared, so the handler may be called when the IRQ is
> +	 * due to a different device. That could happen when runtime suspended,
> +	 * so exit immediately if IRQs are not expected for this device.
> +	 */
> +	if (hci->irq_inactive)
> +		return IRQ_NONE;
> +
> +	result = i3c_hci_core_irq(hci);
> +

this part should be seperate patch, which not related add aspeed controler
support.

Frank
>  	if (hci->io->irq_handler(hci))
>  		result = IRQ_HANDLED;
>
>  	return result;
>  }
>
> +static irqreturn_t i3c_aspeed_irq_handler(int irq, void *dev_id)
> +{
> +	struct i3c_hci *hci = dev_id;
> +	u32 status, inhouse_status;
> +
> +	guard(spinlock)(&hci->lock);
> +
> +	if (hci->irq_inactive)
> +		return IRQ_NONE;
> +
> +	/*
> +	 * The vendor summary register ORs together the core HCI status
> +	 * (CAP), the PIO/DMA ring status (PIO/RHS) and the in-house block's
> +	 * own status (INHOUSE) into single bits, so each source is
> +	 * dispatched to the handler that knows how to service it.
> +	 */
> +	status = aspeed_i3c_read(hci, ASPEED_I3C_INTR_SUM_STATUS);
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & ASPEED_INTR_SUM_CAP)
> +		i3c_hci_core_irq(hci);
> +	if (status & (ASPEED_INTR_SUM_PIO | ASPEED_INTR_SUM_RHS))
> +		hci->io->irq_handler(hci);
> +	if (status & ASPEED_INTR_SUM_INHOUSE) {
> +		/*
> +		 * The in-house block has no dedicated handler; just
> +		 * acknowledge its status bits so the summary IRQ clears.
> +		 */
> +		inhouse_status = aspeed_i3c_read(hci, ASPEED_I3C_INTR_STATUS);
> +		aspeed_i3c_write(hci, ASPEED_I3C_INTR_STATUS, inhouse_status);
> +	}
> +
> +	/*
> +	 * Unlike i3c_hci_irq_handler(), this IRQ is not shared
> +	 * (IRQF_SHARED is not passed at request_irq() time), so a nonzero
> +	 * summary status is always ours to handle.
> +	 */
> +	return IRQ_HANDLED;
> +}
> +
>  static inline bool is_version_1_1_or_newer(struct i3c_hci *hci)
>  {
>  	return hci->version_major > 1 || (hci->version_major == 1 && hci->version_minor > 0);
> @@ -921,6 +996,11 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>  	 * Bit 0:5 are defined in IP version < 0.8 but not handled by PIO code
>  	 */
>  	reg_write(INTR_STATUS_ENABLE, GENMASK(31, 10));
> +	if (hci->quirks & HCI_QUIRK_VENDOR_INTR_SUMMARY) {
> +		aspeed_i3c_write(hci, ASPEED_I3C_INTR_SIGNAL_ENABLE, 0);
> +		aspeed_i3c_write(hci, ASPEED_I3C_INTR_STATUS_ENABLE,
> +				 GENMASK(31, 0));
> +	}
>
>  	/* Make sure our data ordering fits the host's */
>  	regval = reg_read(HC_CONTROL);
> @@ -1004,6 +1084,15 @@ static int i3c_hci_do_reset_and_restore(struct i3c_hci *hci)
>  	if (ret)
>  		return -EIO;
>
> +	if (hci->quirks & HCI_QUIRK_VENDOR_BUS_SETUP)
> +		aspeed_i3c_bus_setup(hci);
> +
> +	if (hci->quirks & HCI_QUIRK_BOARD_PHY_TIMINGS) {
> +		ret = aspeed_i3c_phy_init(hci);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	i3c_hci_set_master_dyn_addr(hci);
>
>  	mipi_i3c_hci_dat_v1.restore(hci);
> @@ -1181,6 +1270,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	if (ret)
>  		return ret;
>
> +	if ((hci->quirks & HCI_QUIRK_VENDOR_RESOURCES) && !aspeed_i3c_vendor_cap_found(hci)) {
> +		dev_err(&hci->master.dev, "required vendor capability not found in hardware\n");
> +		return -ENODEV;
> +	}
> +
>  	/* Select our command descriptor model */
>  	switch (FIELD_GET(HC_CAP_CMD_SIZE, hci->caps)) {
>  	case 0:
> @@ -1205,6 +1299,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  {
>  	const struct mipi_i3c_hci_platform_data *pdata = pdev->dev.platform_data;
>  	struct clk_bulk_data *clks;
> +	irq_handler_t irq_handler;
> +	unsigned long irq_flags;
>  	struct i3c_hci *hci;
>  	int irq, ret;
>
> @@ -1233,7 +1329,7 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	}
>
>  	platform_set_drvdata(pdev, hci);
> -	/* temporary for dev_printk's, to be replaced in i3c_master_register */
> +	/* Temporary for dev_printk's, replaced with the real value by i3c_master_register(). */
>  	hci->master.dev.init_name = dev_name(&pdev->dev);
>
>  	hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
> @@ -1243,6 +1339,12 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	if (hci->quirks & HCI_QUIRK_DMA_64BIT)
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>
> +	if (hci->quirks & HCI_QUIRK_VENDOR_RESOURCES) {
> +		ret = aspeed_i3c_alloc_resources(hci, pdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
>  	if (ret < 0)
>  		return dev_err_probe(&pdev->dev, ret,
> @@ -1254,9 +1356,15 @@ static int i3c_hci_probe(struct platform_device *pdev)
>
>  	hci->irq_inactive = true;
>
> +	irq_handler = i3c_hci_irq_handler;
> +	irq_flags = IRQF_SHARED;
> +	if (hci->quirks & HCI_QUIRK_VENDOR_INTR_SUMMARY) {
> +		irq_handler = i3c_aspeed_irq_handler;
> +		irq_flags = 0;
> +	}
> +
>  	irq = platform_get_irq(pdev, 0);
> -	ret = devm_request_irq(&pdev->dev, irq, i3c_hci_irq_handler,
> -			       IRQF_SHARED, NULL, hci);
> +	ret = devm_request_irq(&pdev->dev, irq, irq_handler, irq_flags, NULL, hci);
>  	if (ret)
>  		return ret;
>
> @@ -1291,6 +1399,16 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>  	{ .compatible = "microchip,sama7d65-i3c-hci",
>  	  .data = (void *)(ulong)(HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>  				  HCI_QUIRK_RESP_BUF_THLD) },
> +	{ .compatible = "aspeed,ast2700-i3c-hci",
> +	  .data = (void *)(ulong)(HCI_QUIRK_DAT_INDEX_IS_ADDR |
> +				  HCI_QUIRK_DMA_64BIT |
> +				  HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET |
> +				  HCI_QUIRK_TX_START_THLD |
> +				  HCI_QUIRK_VENDOR_BUS_SETUP |
> +				  HCI_QUIRK_BOARD_PHY_TIMINGS |
> +				  HCI_QUIRK_VENDOR_INTR_SUMMARY |
> +				  HCI_QUIRK_VENDOR_RESOURCES |
> +				  HCI_QUIRK_VENDOR_DAA_INDEX) },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
> diff --git a/drivers/i3c/master/mipi-i3c-hci/ext_caps.c b/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
> index 77840fd4aa51f..ab0f18f74a5f7 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
> @@ -14,6 +14,7 @@
>
>  #include "hci.h"
>  #include "ext_caps.h"
> +#include "aspeed.h"
>  #include "xfer_mode_rate.h"
>
>  /* Extended Capability Header */
> @@ -221,6 +222,7 @@ struct hci_ext_cap_vendor_specific {
>
>  static const struct hci_ext_cap_vendor_specific vendor_ext_caps[] = {
>  	EXT_CAP_VENDOR(NXP, 0xc0, 0x20),
> +	EXT_CAP_VENDOR(ASPEED, 0xc0, 0x08),
>  };
>
>  static int hci_extcap_vendor_specific(struct i3c_hci *hci, void __iomem *base,
> diff --git a/drivers/i3c/master/mipi-i3c-hci/ext_caps.h b/drivers/i3c/master/mipi-i3c-hci/ext_caps.h
> index b15e629951f03..46dd83c0d4c54 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/ext_caps.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/ext_caps.h
> @@ -12,6 +12,7 @@
>
>  /* MIPI vendor IDs */
>  #define MIPI_VENDOR_NXP			0x11b
> +#define MIPI_VENDOR_ASPEED		0x3f6
>
>  int i3c_hci_parse_ext_caps(struct i3c_hci *hci);
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 3f28f821bf0dc..2b876dfb1087b 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -181,6 +181,13 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
>  #define HCI_QUIRK_DMA_64BIT		BIT(11)  /* Controller DMA supports 64-bit addressing */
>  #define HCI_QUIRK_TX_START_THLD		BIT(12)  /* Clear TX start threshold in DMA mode */
> +#define HCI_QUIRK_VENDOR_BUS_SETUP	BIT(13)  /* Vendor block needs setup to bring the bus up */
> +#define HCI_QUIRK_BOARD_PHY_TIMINGS	BIT(14)  /* Apply board-specific PHY timing from DT */
> +#define HCI_QUIRK_VENDOR_INTR_SUMMARY	BIT(15)  /* Vendor interrupts funnel through a summary */
> +#define HCI_QUIRK_VENDOR_RESOURCES	BIT(16)  /* Vendor block needs its own reset lines/clock */
> +#define HCI_QUIRK_VENDOR_DAA_INDEX	BIT(17)  /* DAA needs the DAT slot in a vendor register */
> +#define HCI_QUIRK_IBI_PAYLOAD_THLD	BIT(18)  /* Controller has a payload IBI term threshold */
> +#define HCI_QUIRK_VENDOR_TX_AVAIL	BIT(19)  /* Controller reports exact TX FIFO free space */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>
> --
> 2.34.1
>

