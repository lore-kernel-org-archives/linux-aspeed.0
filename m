Return-Path: <linux-aspeed+bounces-4905-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98D7C624D6
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 23:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZMzl2mjDz2y8d;
	Wed, 02 Sep 2026 09:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788295899;
	cv=pass; b=O/nTqqijfTWBetVHPJ3kvUVlJaETGuhmiXh0kwpXj6T5JhCKUSkQFeueovUxrzrZfKLZskyFFYroZcuuEd7TVFyQmVP8K6k6tgAOKG6baMgkeE9wvR0Cu/q0ANx/kiHNZXemVeYfdsgVRtd4B3ESrfohe1sY4UTvJYZCBJ++KH5acgiGHcAgsDH3mlLadB80wIoaE5JtgCjDrX8rPU0oUqYJsW/l8Zh41Rqad7whntesTouiIL36sDqpeGCrCWFU3AaIEmBggzfZT2mGzsm5mh+19zkxjR+fgNl0bLzWVCrCIl3C3KHuWc8HvGPIUs6GqlCVsmqhwP3r5H0s8DCc+w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788295899; c=relaxed/relaxed;
	bh=BEJGn9hZuzok9kh02Ld1YUUfNoiCp1E2bBRCPLkUfT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEPpTqQwZjZRkR7KdtavvxjuJbeRZtOGqv49dinB5VClD0+p3dKFoogHnyzukPfbKYd9RS0AP6J6BNfLkTd9SWJZ2erOg2J8M4AvGN+riJZzhf8viPeny4S+BTP3v/5P8eKV6CyIBc0vCiOyQ4nFrLIHX/5UAcPD8zPEcmDxCQodC6j91BniGXX6H+gM1ukP1yGYYnGp5VLOEnfOZf+N1THGD2vMZZWFRWu9eWrEqPWa0fTHuxGEFBWr8VQNALRd2SiDQUFJLEIPzCErQo9g3R9nGxb69HD0cUIvVsBW2hlnw6g+5H4eIpjhozpsF3/ccx3GPnYHBMwIF5ckjQGdPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YW+O8bUt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YW+O8bUt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZJ1l0B8Gz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 06:51:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETLy4N3SBYXrCEeXBodj+9rrhu98ALl+5OjEZjv0Y5lXFPhAMunS5VBPQhAxHSsRNRFrY1btRLgLTbpHjXLiSJ7Pg6LUSG5YYodmWEhO+HiWgaRqEOXTOeFKnIOyjvbPoWvMe6yK4Po+/P22Feq5vgOfjpebvW791uRYWzua9yCKLB+FE0J3wE+kOu1DauXgMuG+4gcYAb/SOM/cnfj2OoNbHUs8mQFXuOWaByYfXSG9BeC9+Fbgh4AmiOr/TWC9FbFAmoUy/wC/Kwtp0rJQ3f6fGZQnRX+k1iOE7ZpvNPhsK6lS8dWHrofcfWfL6dlU0c/geqhdL5QyoGIoYcKUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEJGn9hZuzok9kh02Ld1YUUfNoiCp1E2bBRCPLkUfT0=;
 b=AG22L4+KawM6YOxANEyG3oYwHx8hXeUy3QHWgWm9P58oxVaXf4FbazB9Mb6V5N2ihBMWiNjygXiPV4fqt2bRYKY8lnh8T4RWGP4gbtx/WRpf76oaz6LoC0uch1A8stmdtRerLB95Ssv/kwWk35xNYUl2eMlzhy+aCNUBLU/9qFIPPS6fFRgOWR9G4SaGJn0UgjkIEdHKQu9Zifkm6GMhuNHY2BobQ28oLgf/6KH8PyfCs5crrB/guu1q5NSAQ8+BfErslBmwfkugpVsr7xn5UG9sGK6f2CY0/mxa1/YFmX1UxOf7Bat5PgJ1IQm+iiGrgzrmD/TQDhnCJEcwK4SToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEJGn9hZuzok9kh02Ld1YUUfNoiCp1E2bBRCPLkUfT0=;
 b=YW+O8bUtZnrAxoLQj8/K5r5TqczJsNEPql6kk12t7ni8eprQ2yuoMIsfvPuWzskeqhdbQvSHI+BphMAmacHM3lTCwLqFKRPWmL5W4pkLg3PlCtcWPuh68KO5zyTqr/0pIjDle4pxmHgTsN6luNR4Zp8pT7zeRxeBr40E6Vxa9gLZ8vAdBNF+l7ixXAFY+6evCKFA0mKHoxx1zkL+9ZfqNOSwRmjFZQtaqA5F65M9vm+OGldJA75Ql0vabSzStm+TC6eqqllrHydBJYa8W20rX4RD311g61RmcASqdKmeFmXlaR/xAjOvtVt9Oz8JLkjZXVXmqfea1pd1ObSNdOJPtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:51:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:51:14 +0000
Date: Tue, 1 Sep 2026 16:51:06 -0400
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
Subject: Re: [PATCH 3/8] i3c: mipi-i3c-hci: Add a quirk for 64-bit DMA
 addressing
Message-ID: <apc6ujQTcvoyPq7o@lizhi-Precision-Tower-5810>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-3-19909e7cbd7e@aspeedtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-3-19909e7cbd7e@aspeedtech.com>
X-ClientProxiedBy: CY8PR12CA0059.namprd12.prod.outlook.com
 (2603:10b6:930:4c::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 92130451-336f-42fa-ced9-08df086ac353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|11063799006|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d6xRl6AbUpT8WEeysUi35XuJSeJzfQqslYUxqPZYaq8Xa97F+/cj6ZOne3diiuz7AAlaO26ruHdbWf6Jyr1xNHJPkb3FkytkdO0tv1R6KRI6GEGbOXk8jYffPvUW9ZIpY1oIlZBcPzhb+LQUyhRf/7Gf7Vu2pmwKINs9hhJYWMEh99VuqXMSaaKDM18sPNIGuW+1x+adRD243d0OXZHNn1f25AZZKH/hFL/Vgr2AtgV+On4ZIxyEbtmEvm4AFwvO73p+nCN0DHdXyE9SzTDT7LfFk3D5gYO6EH9Sm8ZkbOXcbT8kCcN9eVKzW1z7QiPwb4z7PFUFnSyblmZbkBddTKsMqf+FA13a++YTD7qwm4COpbQr+AgTQFT9A+f+fV6jDSdExxt9g4xD9VO1IIbI+vRoyTXjALMj2CvbCLFhQPXmoaheuIND6Pydmeta04kdjkB6pAmhkDV5FaSZKJ+O72mewO9Aj/++wFTGlNhkl6NcR/bBvXkloR8aXFpNxUy6myduiPUAOzFlP9+bzTz+st27mbeqk86We8+dk0CVqA1C2eAtNT1U57piQTFO2DUywX7Ra5ev9ryyi7hdQNpTkepYNd2odUQD+nVKV7hNbNWPJQCBLUWg49sSbnpXcrj3MdifY9W4t9M49iEEVFw0dlwFljNorUtv5qOKFP7QLqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cy7UuOrWheH5uEy7wzTjreHjfhfjDP5EUf0WLCjoUfCQYkygHt38qL1l3wQc?=
 =?us-ascii?Q?mRylea5V7J7p1iX4ENj3RUC+kKbFhEbIF5h08wCio/kEAL8WVjv4sdaqClm+?=
 =?us-ascii?Q?yrPVHiXoNl+Tu+N2GNSEJG7mVX4v+MtnrUqhKBQFj/9N+Aphhr59p4tGlt2W?=
 =?us-ascii?Q?OxPleW5KFNVZtFpAzQdM8SkrUz0ppRBfkPHESOfusNHWCpzNqsBvSJH8viWt?=
 =?us-ascii?Q?ZmiXOSldb9kh0jBjfR70AQ23SyyipX+9ILUmtNqAGnT/u4f/RwzZxjoI2Y5B?=
 =?us-ascii?Q?xm6KmrKFLiioSyPQgWhRZCKID3yuh5jsqWJdi/qdQe+9qJHWUlbHsyw6SYH7?=
 =?us-ascii?Q?rNt+fhuStJMmkkaqEZQWQn2+SFKfqkcueaMQ3wCB7Dlk8pKHcAD/0l0/VQGu?=
 =?us-ascii?Q?5sinun6w84VTlTEjU/FNLI5z36wGsRwrolmcBycZudBHg8BD913OgeIuYvEf?=
 =?us-ascii?Q?NWreeAeNEewDqEDLBqijfOA8g373QHa+nG9gmdrNP1nbdxgIUuv4GJbH8TxS?=
 =?us-ascii?Q?3kvjp9UUSDToz6LsWcnf/5bfbcb+NdZbc12OOgkdZd6Q6AHjjFyaccAaqex8?=
 =?us-ascii?Q?7Q0ahO8nd/gIUT9HGGPaP48zJ6oLj/yNbfqF9ZZLlp2f62DcIipzJlt48V1N?=
 =?us-ascii?Q?/hmpTXb+shz0oaPh/w/b4xzzPlpwLnIu2gcmWAQu7PfAMhxeFSynt5gAIMuN?=
 =?us-ascii?Q?ESpyGpaglWtcgUQQI7AnSHJuztQXVugK06wGxuB/eOEbrMmUiWlQh/BRxV2n?=
 =?us-ascii?Q?gsUrl17xuEJePHEWC8nK4Hgz947JgVE910GLflnTGRCrXMUwMTJyD7jZU3Y4?=
 =?us-ascii?Q?R4buRP9rPFFHcr1y7Xll2faAksTYbUHfQ7BR9xBBUAcq4HyQ3gndBomiBGDG?=
 =?us-ascii?Q?D0wPKMzGOoWuiLa6uuwsn7whPtlJ/EcinG5B41hrq30EGMcpCvmLAQGEaTkA?=
 =?us-ascii?Q?kjJ/8flxXACQAKuv7S8E/8Y5O+nEA3xOEM4MhEVKaHnzMeVFRMPM+wqU4khH?=
 =?us-ascii?Q?gVc+yH7k1Qvi737NTDf1DQZk8fokk1N3e0TXJ8ds1EntfoZtNSq9PYbTEbuF?=
 =?us-ascii?Q?nRgNN2rYwLmhA0Qox1Q73neVFGnJulGhZ+kilD/TNhfUgHxZq3G4FAyNHLgx?=
 =?us-ascii?Q?utdzPhP0UDRuAoEuvcDVMmnrxI5C7nIsNwl1TeLmfAEewratx0Cuz07nCUUX?=
 =?us-ascii?Q?+Fg4g8tImVAZGe2/PDgVo1mC/yKgAzdlZw9qf0X8TeZqDxNHz5eapk3yP2Dd?=
 =?us-ascii?Q?xpmL8y+YHjvGLXw0A0lIuvfkQWF9K3Qszfh+W2AGkLrKMSa3Y2GfWXWxhNGF?=
 =?us-ascii?Q?wCW+9T4YrOEJi+hN+RALHanmn5dOW22HgZtT2I1YI59ezcnbp0finXeVbJ/e?=
 =?us-ascii?Q?f71ylaZhzk1AihV9Hp5wVlkaSeKXQRFjD3KGPySb5nRJZ5e16Ya7Iv/YwlnP?=
 =?us-ascii?Q?iGFs62Y4eLnYxTn2gBIx4CQfDvUx/AbcVYFMwMmXhN3M5y7qVEwk+t+omvBa?=
 =?us-ascii?Q?VMY5C9mda/b6m+EvPvmypqQOYkiAe4FNMt9ZbSjEa10rEqIc877y0ODajSSI?=
 =?us-ascii?Q?FubuXFFvlXxs0z46iNIX86x2Ydo+WP4Flet57mQwTUu17uGMDMxEilMz/c70?=
 =?us-ascii?Q?XIGZI9ugAldP2G/IyMMBs6N78+9jmrup1PjCMets9KHEbuJ0jPR6lvBiOwq4?=
 =?us-ascii?Q?Q136rBQF1j/yzY9pFcXRfjxwRKlqSUh8/Q49EOZFlDBEyPS3RIkLWA0ws9eN?=
 =?us-ascii?Q?SkWsplpU/ohCfkCy5q3O8YeU7k1Qs5ZlWlC+L2Q0BKuIM/6+UnPa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92130451-336f-42fa-ced9-08df086ac353
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:51:14.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMj5HR6By3HH6VrP9P8cEZrUox4gSdnA7bdd7gCzHhO9s6VCBSJLr0we8ujF4ZxFlxR2X8JMxvTstR35KXyhQkp0ajWXPjXEGr0PF9mQtmObS5+vmR8PLVS+vgBhjY8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

On Tue, Sep 01, 2026 at 07:35:30PM +0800, Billy Tsai wrote:
> The HCI ring base registers are 64 bits wide by specification, but not
> every implementation wires the upper half, so the driver leaves the
> platform device at the default 32-bit DMA mask unless told otherwise.
> ASPEED platforms place all of DRAM above the 32-bit boundary
> (0x4_00000000), so under the default mask every dma_alloc_coherent()
> call for the DMA rings fails.
>
> Add HCI_QUIRK_DMA_64BIT for controllers whose DMA engine drives the
> full address width, and declare a 64-bit streaming and coherent DMA
> mask for them before the rings are allocated.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5
> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
>  drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index a624e3c40484..c03c3a9cbe4f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/errno.h>
>  #include <linux/i3c/master.h>
>  #include <linux/interrupt.h>
> @@ -1167,6 +1168,12 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>  	if (!hci->quirks && platform_get_device_id(pdev))
>  		hci->quirks = platform_get_device_id(pdev)->driver_data;
> +	if (hci->quirks & HCI_QUIRK_DMA_64BIT) {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

dma_set_mask_and_coherent() never return fail when bit mask >= 32

	if (hci->quirks & HCI_QUIRK_DMA_64BIT)
		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

Frank

> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "cannot set DMA mask\n");
> +	}
>
>  	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
>  	if (ret < 0)
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index f50fc1e22a85..2110f806a53c 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -178,6 +178,7 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET	BIT(8)  /* Do PIO queue SW resets after DMA abort */
>  #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
>  #define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
> +#define HCI_QUIRK_DMA_64BIT		BIT(11)  /* Controller DMA supports 64-bit addressing */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>
> --
> 2.34.1
>

