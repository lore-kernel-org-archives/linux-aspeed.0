Return-Path: <linux-aspeed+bounces-4906-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD1C61DD6
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 23:50:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZMzr5WHJz2yCs;
	Wed, 02 Sep 2026 09:50:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788295715;
	cv=pass; b=QA427GW1aX5VHl998vbIw6c7g14AL8Hbp0XB1UiQC3NsGhPfp/fj3KUU87hSLTO0J8OBNe+914JEw3ptHZAeUT2HtOTuHFCR49GQ3U0qiW6lQfQGMCCnK8jjsElWgkKXiiSCk+aosr/p94O3ChDudwZfvAYgWmqNZRUbbJBYl+SxkmOIpvFXAqPHDxeeTMkMw0QdCKO3H+1fR7v7R6MuaLQpGef7K1wlKs2fnFrRl9I8Oj3VbMn8kXjlPMh7b0dr2hISkFLYeSGlbLBXRYYIvUoPQOZlXqBjESvPmj7Dg6/0Xd9uWIBd43OZU8kSsnVvCftE9+8DQFCUyAcDxJWyJg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788295715; c=relaxed/relaxed;
	bh=OsAf96KL0Ph1960RlxmVAd0O8d0kSh9ADfiusXyUmsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGqyix30j2qMy9F7hufGymZ0BmZz3pIEEBr2z9lo8JFK5L3f3Et87wYWQpx2GL+tin8QYNW6V0/z17OFabxrfkuG9O8Po+kobWetzT0cfBM7rNZtBDIatGe7CuBnmjcMoxDNqWpxAAxj3kHrnnq56HqxwMG+SqH/Q+K4kRSduoxjpm9465rBgSYwGOjuQ91RwsrdKo0pY/2dnWnTq5vqvUdpz4EerMJRurAuufQF/KBg5AeyC+ET7XJScls31/dnsfLr2arHfc+72QlHI/OZbMSTttBdlFW3Ix32AVsMCt9WBD6a6ikmCI9JJkgEvBf9Y40j745+i1gyUc3pRqjsug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ATblWU35; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ATblWU35;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHyB2RVVz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 06:48:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN48C3Je6i/4/7gZlnanKI2AAMHyMdYx2YO+bFxT9lRHZlRnTWuEbB3ixBzK8Nrf+YNb0R+PXk/tH41rGgQzodJXHYfw0Z5gMZNcCzv/YrV9C4/nPMd3Wyg4BfiMWUlaT1QdrW5jbqiytXBlitGtftSDLc2HHkWv7B69xXq/AqkIf/AvJqNYNxqLJZhPYcG4rguRzSK9s+5jnFNBv+lKibQOYPvuKyLkuLEPcuzeUUGs2hXorqbUzyGltioDJxxBDvBz4d7plI0vrkYu9xarR2WFxKJTgR23rzzgRAdCdPw76vg/jGFwv72Fl0t1Tsi6TKtvm4sXLuxtKeOnw/S3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsAf96KL0Ph1960RlxmVAd0O8d0kSh9ADfiusXyUmsc=;
 b=aVRTYHPdYsZduSx5LrqPb0D/4KUEtnwnr/hkaAnX0NNb1QaXAivraHzfsz2S6ldo5UBkoVrLE/yShG9YsgSXrI7IBge/e/ED/qRAv16NdDocwOZsjMqMOsEF2hVgYvIJOI2LmQEXD4eLiK5M0zwCrN4nUUDYd85zBAtqcbyeMgPuTd3OWc+k+DHP94PM1LA1Ce1yqy8OrH/Da1yrU5VJjEHXU7ME9fIPfNcDxE8rJM8/jWun77D5lD5HtoLbNdkRjKiKKgJ3o+yn7mTFo5TVbSQFI6L9PACCW8VZ+l5GB1iL1LmUrRoWCmpXHG9vWDOEUTBJwuU1RrV1Flc+ND8C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsAf96KL0Ph1960RlxmVAd0O8d0kSh9ADfiusXyUmsc=;
 b=ATblWU35wRJNNerjiO4ElRNxybN3AYh0g4sXpiq1RaQ/uJwSd5G3QgGtBAsfrParSX1/ZM9Lr+a6ip8OS7T0d67lI6pHparQc2dq7A50mcu4yJXfoHtXDdyc79gb32GAbIRTzE039pw4WA4+gthusjcoKXowOnSua9Dbumcz8xABtzfu624ByHzzBL1X+WDbAqytWNKiHCRj/2qRShyzfv4kDLt4tQZeUpd7ZDlgt/jP76wfMDMamL70ZZzxKbOZAu4qZO3HMwzJIM54L4BjwmzYhTWdCVaZWLA1/nrWeIDKlG3ukafmR8Neqc5RKLRPPec0OO0mLjy4DZgAp04U5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:48:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:48:06 +0000
Date: Tue, 1 Sep 2026 16:47:58 -0400
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
Subject: Re: [PATCH 2/8] i3c: mipi-i3c-hci: Support address-indexed DAT slots
Message-ID: <apc5_qthRg3GMEyz@lizhi-Precision-Tower-5810>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-2-19909e7cbd7e@aspeedtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-2-19909e7cbd7e@aspeedtech.com>
X-ClientProxiedBy: CY5PR22CA0090.namprd22.prod.outlook.com
 (2603:10b6:930:65::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: c52cf0f4-cbe0-470b-ec7d-08df086a52e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|11063799006|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+LrvUh2Lxc0mY+u58/2jRLmcDc3VFJeYp3wg57WHuAkwHMEcmRCnVipwP0TB293QQjuUTLxiHPZYejqDS9w0oOMPNdCuLYN3DuDkvgRKcnkytRcAS4wvSALvD9a6fbsIhRDmnHjv6N1or0fZWBBIz8N82TnWIMZry6yMNVNvHRbWxMt1uhib/TalPLWA7dc/ScRYqVPn9RhhTbW9OrZWv/AwHXZScAIT1IBQmcOLPYp11uwApEUams+En5/P80sZYi8Eke/QWSZdwgS0E07YoP50/+gd7LYQ0t0amrHt+C4J7t9CkbfUTJlco2sN9GzqlDMxwkILCUtN15bBasF6BYwYVJs1mPx5xDfW7lVCeR81z7RBDlgmt4BS6YGmyv+YI/wNx5JCkBmLcogoUyVo/hTt2X3oUvNVMW2Fo0qx5CAec4iSuEicKo7pSBahSJ61Lq0Qlj7tnmKZ1lkQEMKLPFSmp1LTMZLqsOx9yqP4xzKYCIsZOah1Uj/gXOn/GkS7pgQlU73YY6dzlh7tZLAQjbk4xAed+B6Yve6EF9AMKrtLNxFA67JGfKCw2uAfdM3Ex6+4ecTxLDlBWNmurCLkB1pS+kl8c6DFuXjFlNj8G8hqfcF32b9mSrG7OA0T655DFsDvL7WNqW5kg1PNrwmRQTTBZScmooFQCeJqVCOyL8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6X+SlvgxATIeLNEFkk8rX0ZWuUvgaNe/26aYbrIp3d5sRTGJ/XmgCa+L+11N?=
 =?us-ascii?Q?14NNxFHe2MGT802drJCmyETh0Z1/sVqjZVDyMH3FrgJN+qTd7F9jksuFuaRm?=
 =?us-ascii?Q?HknY6W+3S2yKA8xXisizsbB9+Sx9iWmbpPvz/QzDeF4K+jwzKVg/YfU+sDy1?=
 =?us-ascii?Q?wjjKN/ZCJ8tbRvBHB/hVbP8Ij/s/MpH1mt+ZOQPHB4dwnYw9yifj+idqla4n?=
 =?us-ascii?Q?/YWBHkMtAY7sUE1FnT9WSXlxmwthiCiRrEmEQYRFLMheH7aCn6VJyzJg1EAx?=
 =?us-ascii?Q?UQWwSck/n7Zq3iddphkHMrG9RWoBxI/FjxIJdDFOV60xF2Pu4UOPwI+GyJre?=
 =?us-ascii?Q?mY9eXfe+ufpZRbpkjKjZPj7Qnz0YfpqMmPnVHxL8nbotIYwKwxs53wyvLy+8?=
 =?us-ascii?Q?s2mD+MuCUVKHG6fQif3LoxTs7VGfzlJ4TUcru07pMlqDMbYG/cxlIZiC7h68?=
 =?us-ascii?Q?l6iPQKUJi5dbhjSeulxBQGSu/VcPbZw4W+BOZGXL8+LgalL+/C2FMfKOGiZ/?=
 =?us-ascii?Q?MNM/aDRL0siu0xcH1NwYZTKZaxu9Ak+aDA5BaC5T6zlSjcyhvsbM7Glm4zjK?=
 =?us-ascii?Q?CTkbubeGVHthC+yLr2JUCdPVZlUUxqA6ygKpzrWAKowysgE6NO/Agi4R7cWn?=
 =?us-ascii?Q?ddFc5JR1ZReiPC0wS8N/dd7d2bHGvxicNOgmkaEdbk72bP/Uz4dW4Rmwijf0?=
 =?us-ascii?Q?sXZK1l/+nXOaEZ+uv4nRwe8IGvdwig13sYTipcOKnjXnqTCRO8PeDG1eZANn?=
 =?us-ascii?Q?7qD4bKhjurlQv8qcbKlFmyNT8aPzCfHk3g0Pp9lNCxi/8uATxVtD3jw9Rmui?=
 =?us-ascii?Q?0vKkRdcjYqWReCi09hGzETDIdCQJ970MFdRG0mhMAt1yPqlfxFZ1EonolQjb?=
 =?us-ascii?Q?MipM/6fiCoD+P9/z2SbiTIwnv8QFqRw/rEEtCt3i2vN4gMAcmzV4gAiYJ92p?=
 =?us-ascii?Q?E4tUsLFFlAYApUFqqYiXHuDurcyp31OedEbCKsz3vU2sKIztbNjjTKtcEhtG?=
 =?us-ascii?Q?M+pGECRiNZFrjZ9hvoIY49tMWNo3Q/VAq/+nArxzMwbhxdT9fIXkXcrba9wJ?=
 =?us-ascii?Q?4yPaByoITjOS5SIvH46pW33mWCkwAlL92Gt3+pNANiwr+/6EPizL7lD5pWL1?=
 =?us-ascii?Q?Yoybu4x31y5D3uRKFoubshIC93IbRNZBaHDY3DUAaGhLAW1BrFynrmxAok0o?=
 =?us-ascii?Q?308NaHZajc5x+y8QxeZUP3Olzz5baBsbM36fU0mL+/lqFFdRUY1fzlNWYGcM?=
 =?us-ascii?Q?fQp+o3bfNoCLE1IPu13Xjci1FksIQI8U8GgN6THWRLg8xZFS6dM36IlVBY77?=
 =?us-ascii?Q?bGHIsJ52UWNSMYOH1kqtqxdguqENMTX8UvxExQr2eSAx+BU6iMkkzT828HIP?=
 =?us-ascii?Q?r8VnwP0A3dYyOfsqZpgsXFXRz3Ngn0bp6lXGdAm2s+Lky80Q78E74yhX1pQF?=
 =?us-ascii?Q?zESjx1zmTwGtG52b8BkddkT2kLw0oK6C2o7ycTXLg86gz7UVFdP3LYDL+/uz?=
 =?us-ascii?Q?GAp7J6gNNL6k2Cb2yzSvkj/s7EdVELihlGwexdVk2KhvwQ/WSK9WBjLow1k2?=
 =?us-ascii?Q?Ov8532hgvb4V5OVkyXriSJyewGoXpNWIGdmILj+g5MGYsSTxBOPjiIXHnLjC?=
 =?us-ascii?Q?uBWoH0qp4Y8heEVDMVHGZ3CYFROdzFfsk+u/hZLYMAPBULfWmfqMf/xkSiPe?=
 =?us-ascii?Q?JounYSMFvo+PVqkYQmebl4+bb8mpOPpy6jSQfdzTTCHmAjKyIu5FEn/R9HFX?=
 =?us-ascii?Q?Ay0ykAv5hntX3yZVwwZS0eQZloT0zqELl4HmsbhXbiJsO3xpW0lz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52cf0f4-cbe0-470b-ec7d-08df086a52e6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:48:06.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4hWlfeYsGFBd1zDGcfQO0GWAGqyUM0ocV5lmiAYr9YEwYLzHSsKul2UnO57s0VtP3QaGkd3lEKD20hQnrOEDh+4MRgt+S7grj+iVacbUwZNdCbB0xIymxUKcuU+X0WY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

On Tue, Sep 01, 2026 at 07:35:29PM +0800, Billy Tsai wrote:
> HCI v1's DEV_INDEX allocation is sequential: the driver picks any free
> DAT slot, with no relationship between the slot number and the
> device's I3C address. ASPEED's I3C controllers have long needed to
> support more devices than the standard 5-bit DEV_INDEX field
> (addresses 0-31) allows, so they use a layout where the DAT slot
> number is itself the device's address, requiring DEV_INDEX to widen
> to 7 bits (addresses 0-127).

Does ASPEED work if use 5bit DEV_INDEX?

Frank

>
> Add HCI_QUIRK_DAT_INDEX_IS_ADDR for controllers with this layout:
> allocate address-indexed DAT slots and emit the wider DEV_INDEX field.
> Moving an entry on a dynamic address change can fail if its slot is
> already taken, so set_dynamic_addr() now returns an error that the
> reattach and DAA paths propagate. Controllers without the quirk keep
> the existing behavior.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5
> ---
>  drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 35 ++++++++++++------
>  drivers/i3c/master/mipi-i3c-hci/core.c   | 19 +++++++---
>  drivers/i3c/master/mipi-i3c-hci/dat.h    |  5 ++-
>  drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 63 +++++++++++++++++++++++++++++---
>  drivers/i3c/master/mipi-i3c-hci/hci.h    |  1 +
>  5 files changed, 98 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> index 3b9345718d273..9a11affb14bf6 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> @@ -141,6 +141,14 @@ static enum hci_cmd_mode get_i2c_mode(struct i3c_hci *hci)
>  	return MODE_I2C_Fm;
>  }
>
> +static u32 cmd_v1_dev_index(struct i3c_hci *hci, unsigned int dat_idx)
> +{
> +	u32 mask = hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR ?
> +		   W0_MASK(22, 16) : W0_MASK(20, 16);
> +
> +	return field_prep(mask, dat_idx);
> +}
> +
>  static void fill_data_bytes(struct hci_xfer *xfer, u8 *data,
>  			    unsigned int data_len)
>  {
> @@ -195,7 +203,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
>  			CMD_0_ATTR_I |
>  			CMD_I0_TID(xfer->cmd_tid) |
>  			CMD_I0_CMD(ccc_cmd) | CMD_I0_CP |
> -			CMD_I0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_I0_DTT(data_len) |
>  			CMD_I0_MODE(mode);
>  		fill_data_bytes(xfer, data, data_len);
> @@ -205,7 +213,7 @@ static int hci_cmd_v1_prep_ccc(struct i3c_hci *hci,
>  			CMD_0_ATTR_R |
>  			CMD_R0_TID(xfer->cmd_tid) |
>  			CMD_R0_CMD(ccc_cmd) | CMD_R0_CP |
> -			CMD_R0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_R0_MODE(mode) |
>  			(rnw ? CMD_R0_RNW : 0);
>  		xfer->cmd_desc[1] =
> @@ -233,7 +241,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
>  		xfer->cmd_desc[0] =
>  			CMD_0_ATTR_I |
>  			CMD_I0_TID(xfer->cmd_tid) |
> -			CMD_I0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_I0_DTT(data_len) |
>  			CMD_I0_MODE(mode);
>  		fill_data_bytes(xfer, data, data_len);
> @@ -242,7 +250,7 @@ static void hci_cmd_v1_prep_i3c_xfer(struct i3c_hci *hci,
>  		xfer->cmd_desc[0] =
>  			CMD_0_ATTR_R |
>  			CMD_R0_TID(xfer->cmd_tid) |
> -			CMD_R0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_R0_MODE(mode) |
>  			(rnw ? CMD_R0_RNW : 0);
>  		xfer->cmd_desc[1] =
> @@ -268,7 +276,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
>  		xfer->cmd_desc[0] =
>  			CMD_0_ATTR_I |
>  			CMD_I0_TID(xfer->cmd_tid) |
> -			CMD_I0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_I0_DTT(data_len) |
>  			CMD_I0_MODE(mode);
>  		fill_data_bytes(xfer, data, data_len);
> @@ -277,7 +285,7 @@ static void hci_cmd_v1_prep_i2c_xfer(struct i3c_hci *hci,
>  		xfer->cmd_desc[0] =
>  			CMD_0_ATTR_R |
>  			CMD_R0_TID(xfer->cmd_tid) |
> -			CMD_R0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_R0_MODE(mode) |
>  			(rnw ? CMD_R0_RNW : 0);
>  		xfer->cmd_desc[1] =
> @@ -306,19 +314,22 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
>  	 * Yes, there is room for improvements.
>  	 */
>  	for (;;) {
> -		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
> -		if (ret < 0)
> -			break;
> -		dat_idx = ret;
>  		ret = i3c_master_get_free_addr(&hci->master, next_addr);
>  		if (ret < 0)
>  			break;
>  		next_addr = ret;
> +		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci, next_addr);
> +		if (ret < 0)
> +			break;
> +		dat_idx = ret;
>
>  		dev_dbg(&hci->master.dev,
>  			"next_addr = 0x%02x, DAA using DAT %d",
>  			next_addr, dat_idx);
> -		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dat_idx, next_addr);
> +		ret = mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dat_idx,
> +							   next_addr);
> +		if (ret < 0)
> +			break;
>  		mipi_i3c_hci_dct_index_reset(hci);
>
>  		xfer->cmd_tid = hci_get_tid();
> @@ -326,7 +337,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
>  			CMD_0_ATTR_A |
>  			CMD_A0_TID(xfer->cmd_tid) |
>  			CMD_A0_CMD(I3C_CCC_ENTDAA) |
> -			CMD_A0_DEV_INDEX(dat_idx) |
> +			cmd_v1_dev_index(hci, dat_idx) |
>  			CMD_A0_DEV_COUNT(1) |
>  			CMD_A0_ROC | CMD_A0_TOC;
>  		xfer->cmd_desc[1] = 0;
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index dadf049bd4b54..a624e3c40484e 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -574,7 +574,8 @@ static int i3c_hci_attach_i3c_dev(struct i3c_dev_desc *dev)
>  	if (!dev_data)
>  		return -ENOMEM;
>  	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
> -		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
> +		ret = mipi_i3c_hci_dat_v1.alloc_entry(hci,
> +				dev->info.dyn_addr ?: dev->info.static_addr);
>  		if (ret < 0) {
>  			kfree(dev_data);
>  			return ret;
> @@ -593,9 +594,17 @@ static int i3c_hci_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
>  	struct i3c_hci *hci = to_i3c_hci(m);
>  	struct i3c_hci_dev_data *dev_data = i3c_dev_get_master_data(dev);
>
> -	if (hci->cmd == &mipi_i3c_hci_cmd_v1)
> -		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, dev_data->dat_idx,
> -					     dev->info.dyn_addr);
> +	if (hci->cmd == &mipi_i3c_hci_cmd_v1) {
> +		int ret;
> +
> +		ret = mipi_i3c_hci_dat_v1.set_dynamic_addr(hci,
> +							   dev_data->dat_idx,
> +							   dev->info.dyn_addr);
> +		if (ret)
> +			return ret;
> +		if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR)
> +			dev_data->dat_idx = dev->info.dyn_addr;
> +	}
>  	return 0;
>  }
>
> @@ -623,7 +632,7 @@ static int i3c_hci_attach_i2c_dev(struct i2c_dev_desc *dev)
>  	dev_data = kzalloc_obj(*dev_data);
>  	if (!dev_data)
>  		return -ENOMEM;
> -	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci);
> +	ret = mipi_i3c_hci_dat_v1.alloc_entry(hci, dev->addr);
>  	if (ret < 0) {
>  		kfree(dev_data);
>  		return ret;
> diff --git a/drivers/i3c/master/mipi-i3c-hci/dat.h b/drivers/i3c/master/mipi-i3c-hci/dat.h
> index 6881f19da77f2..d4c7b03724d37 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/dat.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/dat.h
> @@ -14,12 +14,13 @@
>  #define DAT_0_I2C_DEVICE		W0_BIT_(31)
>  #define DAT_0_SIR_REJECT		W0_BIT_(13)
>  #define DAT_0_IBI_PAYLOAD		W0_BIT_(12)
> +#define HCI_DAT_ANY_ADDRESS		((unsigned int)-1)
>
>  struct hci_dat_ops {
>  	int (*init)(struct i3c_hci *hci);
> -	int (*alloc_entry)(struct i3c_hci *hci);
> +	int (*alloc_entry)(struct i3c_hci *hci, unsigned int address);
>  	void (*free_entry)(struct i3c_hci *hci, unsigned int dat_idx);
> -	void (*set_dynamic_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
> +	int (*set_dynamic_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
>  	void (*set_static_addr)(struct i3c_hci *hci, unsigned int dat_idx, u8 addr);
>  	void (*set_flags)(struct i3c_hci *hci, unsigned int dat_idx, u32 w0, u32 w1);
>  	void (*clear_flags)(struct i3c_hci *hci, unsigned int dat_idx, u32 w0, u32 w1);
> diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> index 852966aa20d98..19b0f72e4ac82 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
> @@ -89,7 +89,7 @@ static int hci_dat_v1_init(struct i3c_hci *hci)
>  	return 0;
>  }
>
> -static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
> +static int hci_dat_v1_alloc_entry(struct i3c_hci *hci, unsigned int address)
>  {
>  	unsigned int dat_idx;
>  	int ret;
> @@ -99,9 +99,17 @@ static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
>  		if (ret)
>  			return ret;
>  	}
> -	dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
> -	if (dat_idx >= hci->DAT_entries)
> -		return -ENOENT;
> +	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
> +		if (address >= hci->DAT_entries)
> +			return -EINVAL;
> +		if (test_bit_acquire(address, hci->DAT_data))
> +			return -ENOENT;
> +		dat_idx = address;
> +	} else {
> +		dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
> +		if (dat_idx >= hci->DAT_entries)
> +			return -ENOENT;
> +	}
>  	__set_bit(dat_idx, hci->DAT_data);
>
>  	/* default flags */
> @@ -118,9 +126,43 @@ static void hci_dat_v1_free_entry(struct i3c_hci *hci, unsigned int dat_idx)
>  		__clear_bit(dat_idx, hci->DAT_data);
>  }
>
> -static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
> -					unsigned int dat_idx, u8 address)
> +static int hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
> +				       unsigned int dat_idx, u8 address)
>  {
> +	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
> +		u32 dat_w0, dat_w1;
> +
> +		/*
> +		 * The controller derives the device address from the DAT slot
> +		 * index, so DAT_0_DYNAMIC_ADDRESS is never written: an address
> +		 * change moves the whole entry to the slot named by the new
> +		 * address instead.
> +		 */
> +		if (dat_idx == address)
> +			return 0;
> +		if (address >= hci->DAT_entries) {
> +			dev_err(&hci->master.dev, "invalid DAT slot %u\n", address);
> +			return -EINVAL;
> +		}
> +		if (test_bit(address, hci->DAT_data)) {
> +			dev_err(&hci->master.dev, "DAT slot %u already in use\n",
> +				address);
> +			return -EBUSY;
> +		}
> +
> +		dat_w0 = dat_w0_read(dat_idx);
> +		dat_w1 = dat_w1_read(dat_idx);
> +
> +		__set_bit(address, hci->DAT_data);
> +		dat_w0_write(address, dat_w0);
> +		dat_w1_write(address, dat_w1);
> +
> +		dat_w0_write(dat_idx, 0);
> +		dat_w1_write(dat_idx, 0);
> +		__clear_bit(dat_idx, hci->DAT_data);
> +		return 0;
> +	}
> +
>  	u32 dat_w0;
>
>  	dat_w0 = dat_w0_read(dat_idx);
> @@ -128,6 +170,8 @@ static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
>  	dat_w0 |= FIELD_PREP(DAT_0_DYNAMIC_ADDRESS, address) |
>  		  (parity8(address) ? 0 : DAT_0_DYNADDR_PARITY);
>  	dat_w0_write(dat_idx, dat_w0);
> +
> +	return 0;
>  }
>
>  static void hci_dat_v1_set_static_addr(struct i3c_hci *hci,
> @@ -169,6 +213,13 @@ static void hci_dat_v1_clear_flags(struct i3c_hci *hci, unsigned int dat_idx,
>
>  static int hci_dat_v1_get_index(struct i3c_hci *hci, u8 dev_addr)
>  {
> +	if (hci->quirks & HCI_QUIRK_DAT_INDEX_IS_ADDR) {
> +		if (dev_addr < hci->DAT_entries &&
> +		    test_bit(dev_addr, hci->DAT_data))
> +			return dev_addr;
> +		return -ENODEV;
> +	}
> +
>  	unsigned int dat_idx;
>  	u32 dat_w0;
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index ee73f6e6756a1..f50fc1e22a855 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -177,6 +177,7 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>  #define HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET	BIT(8)  /* Do PIO queue SW resets after DMA abort */
>  #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
> +#define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>
> --
> 2.34.1
>

