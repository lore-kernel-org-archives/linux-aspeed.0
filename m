Return-Path: <linux-aspeed+bounces-2705-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CF9CCF9FA
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 22:21:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cyJVK3jrzz2yx7;
	Fri, 31 Oct 2025 09:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761820297;
	cv=fail; b=Ycb0OeOT/+cM+CY9WeyOUxQVdoDZwUMzM4Rf7hA2/X8ec6E1x0/OKXV9cxffHLZFMCxkjp7sSmEAY0ICTuExr+0vSmxYJ7827a10XR6m8Qxuq4s6UuUQc2zFvxCGOEA9y9A3LX6iaqu84yC6+T2YcHCXOqG2QsTpMnmnCBBko2qJHwc1eZg8PL839AeKEo22t69xOm+eIQDlyT94f7yQFlkdZDK+kw5mgieYs4hXKcd96/bXMlDZlIhVj3Ml52qRhBMfAogWV3Kr9VcuevhbVkZgAVyUbuX4DTqvvvq8pts6lv+oI1URygJBtGyB1KCHl0qo82MxE3Q2EXM6xWPaKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761820297; c=relaxed/relaxed;
	bh=KuYZxvoha75lgDLkz/2TrrmOzPAYiECgCRZzjMztoDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgRudgcee0/sniDIbF53gUPal504jMfob93xi+cd+nw/oXNJKZEZh8YM+0l3Nus6h92ElBvL83nbYrxejT6RPJdHx47uDEqIu7DjfGeL/PLI4MkHcxmHcj4rpdfl78L9L/Rsf++u9/7Fkeve8u+b4bIe0jiDrvs6P5ZuuxjP7IZtJ1OvqqhoF0oh/sGMGwEpVbz7gV05WbZov/08nXmnJDNJhegEjrHUcrBo/hpLmWkb5VnA1wwd24eIqWavWMR+BvgJrkv4CVOLpozdGmJ/pek3YZ9GB7PNeUwS/7PYvO3rnfuZ5woreUM7xhoODhpZJrq3R9nkw9fyWOeKLilypw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ND/d/o4R; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=giovanni.cabiddu@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ND/d/o4R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=giovanni.cabiddu@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cy0lV4631z2xxS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 21:31:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761820295; x=1793356295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3eoxxFb9gz+LjO+Yz4oIFcMb6TYRGbtBAsJ+HFlhfWs=;
  b=ND/d/o4R0q4qrgmgFRddeGb0E6ApOCfIr1uEMzc7GhbY67axuEa0kIU5
   wWCylmgyFKu9oZaJnkYaIj3cQsfSBO9wtVUkwyjfpDJZD3W/tTILznac6
   d9PQwgt+9E+cz14UpvZ45UVlK37XPRnFV43S9/spydAkZ1F9cKm50yWNB
   VgmmI9i2SP2ZCfv/BZyxjWYX2payYIbnQoWC5msWt63ht7uWMqffcTWct
   3bUZzrkCAg9Hi+WNZ9uZ2F4672MuGTEIYhnCYv2FH2yDZ875E8IaDiusz
   fZ1tbwzXauaTAFTiBoOsninfu5AymGDWBm+DeQYAc4nHyHbdqwMppHJ6q
   g==;
X-CSE-ConnectionGUID: bAASoymuRw2Y5yWb6L9RXA==
X-CSE-MsgGUID: x6OamYjtSFiRFz1uHo92SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63657896"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63657896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:31:32 -0700
X-CSE-ConnectionGUID: l3pcPFOfTkKRH/pJG3Obvg==
X-CSE-MsgGUID: +K4LDoV4TVqsbUsKx7UzXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186266733"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:31:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:31:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 03:31:26 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v28emJkbaBDcixIVSNCMgN625bMUqg9zR+W2F0+NOBtK9l7hqUYzURIyCUuwV1uXjBkj87n3b1NtkMiYeDvEB/UWEibMTXlEZjpYQeK8m0qHCRKYqSIWJDDuPk0jTe1mK/sCgeWkjLFPcKLtGapP5XuOXXYKRi3gE7zGWkqZ8CAYUVhOjELPu3Niu9qXETu4kmBQCkNKT9cT7JjXs1Kf99lQsTR60f7Yo7lzs5ACT2t+jlb5KmGbSqFLWYQ61958gH0dQhne6XjEpheqhRpE8URKxwlbfyX9mRTgMns8oerIZYiy9m162hyYU6iGX3EvTwdYnKJ2Dxp1v2sKcM/fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuYZxvoha75lgDLkz/2TrrmOzPAYiECgCRZzjMztoDI=;
 b=cRcR4USaFUEVCgVXamIosm1GXlVrXZcSvZSYb/KSLjBrV2dF4M5AVFxQ2BbqXmWyrWE3sO8dC/FX8KSCxVfNIhiFVm97Xbo0IC60yH6HkJJM9hWT+gi7wMZ+xsmQLnAPSe4ML7D2TRfr8kl6y/OO7jZdbvSZGx1Wmg529SW/74bLYPnyyv1D6BR22aOu14yHiOLaCQ4rHRE9bDluIQ4tgh+XYs98XB+GJFwxEQIxrhFCXq0CXEmxuejQH+FVQYnkzE3RWI3DWD+/2PntoXgGY/vyLvjSkoHjXw97fA5Y6gA7jhKYk92VJrSxlcpOtq962SENlEbb/h2cPoVhZZ2e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 10:31:22 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 10:31:22 +0000
Date: Thu, 30 Oct 2025 10:31:12 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky
 Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>, "Vincent
 Mailhol" <mailhol.vincent@wanadoo.fr>, Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Kim Seer Paller
	<kimseer.paller@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, "Cosmin
 Tanislav" <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<qat-linux@intel.com>, <linux-gpio@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-iio@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/23] crypto: qat - convert to common field_get()
 helper
Message-ID: <aQM+cHWAANcc8wvC@gcabiddu-mobl.ger.corp.intel.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <2556adf9d1dca0077d03785bef1f7592936c16c8.1761588465.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2556adf9d1dca0077d03785bef1f7592936c16c8.1761588465.git.geert+renesas@glider.be>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
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
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 141e6157-0b37-46aa-5bfa-08de179f789c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KHUkBRAa4KLWxFYU2VptJ0CbdF3eYNQvuO5rGe23yPs0l3H46ErUOqpKbLee?=
 =?us-ascii?Q?+bGhJOdDDRdTnRk3QUCjD1ZQ2v4PxYDgM6YJx5XhuvjFnqwu29XhEv3xlM9g?=
 =?us-ascii?Q?Cy1aZiGY9OT2ep0Ai0wM/hQAfkxpl6h8Lff0Oh5rTLjPG/oxG45QfSfGOz3/?=
 =?us-ascii?Q?nUqtJEo5ukJXnIbxy2UxcQ5+NKE2puB8w9nSb0t2V195c1HkV4x7McW2pfm5?=
 =?us-ascii?Q?6Vkfa8cTm8ddCjQ5Cv5EMvUvCibmFensz0FdHUrrwNmeHkzso8dKNcBVZ+HP?=
 =?us-ascii?Q?Vf5Qf94rF8Ci539ri4XhEmzi+NU1eFUhTBvLK3HaDgMpFfAfowgPPPmTSNxr?=
 =?us-ascii?Q?l2OQFBQim1G5JwkBq7phBcLEDs9xYFo067NKr6C6HGUG3bRG/HsMk21E4vkY?=
 =?us-ascii?Q?3qcFPOVwuwGgfNUjAiOvjAooNCySWY64EQprSPGWbNPH/tcc4PHA85b8Dwlv?=
 =?us-ascii?Q?TLUYdC0Rz6lDR8MFRUj7HXZ82JOKfx4B9ymV13QpauRM2GbbYI5w3BtR2lUJ?=
 =?us-ascii?Q?3lFjKfbkk+a/rYZ8tk695ZP9nqHUs4KCNCJdUQAzEoPDQEqQiZts+7GVqcAN?=
 =?us-ascii?Q?fm+A/kqeeurSPPmaqNsdXJy3t2Q9Dw46LqKHPRdapFNF9KIU/xdkHVvIMk7r?=
 =?us-ascii?Q?2S0MVaFYQGaTH7U6VQyMgtkhTX2du5xLoCy+GfOLjQQGCdASFunCHXbM0Xbl?=
 =?us-ascii?Q?YbqIjHISKcMnj96YmHskN5nUYRYvcKZ+oUThWZYnkTEvYeLAjlIFyvATncke?=
 =?us-ascii?Q?oEqtX8817fhaPwEwEml67v62cJ7+8uS+cgj14yuai4WncvdCEMsmIzs5VCAv?=
 =?us-ascii?Q?kQPa94i2NKLmjqeBAleJpwM+fOlpcxgDC7N3SNY6kBfUzOW2pHv399AEM7jw?=
 =?us-ascii?Q?CCDPBAFgqvGUO0Rl/zQ2KtnIiST2OlDtFmvwAzsyv0eYOt+4YKqtJf9kHJ9I?=
 =?us-ascii?Q?ALtjlBBJjJMDx0kEdz7fH20EvK2BaP2H+RvlQ809Rl12K/YTlwEBUjeRWmxJ?=
 =?us-ascii?Q?2jJsTtUjfsnscaxMcTO+QeLT+Mt57tBLn8rh3nY6H1UDk+AuO0IcIgSmgbWh?=
 =?us-ascii?Q?DgdA9GKQeMiSv8QAwtjb3oZT07P3EwrZfbkBXceySbJFPsQ7lyhQhFqVxmaK?=
 =?us-ascii?Q?QgkQ0+CdLUNx/Acji+AMoUugZB7MXVwnCO2f7Y47OYr6u74nVTojNo8ITGQA?=
 =?us-ascii?Q?aoBHBKb67bpXBqVBOoD0BchT4p1YdeYvA1qcC3My3nbsAN0gtSLG1cEooAmX?=
 =?us-ascii?Q?kshrcWxptaF7He6JXXaAig7QRAXopYnt3ojaPAs6Od04RQwt/P0i2pVlytsi?=
 =?us-ascii?Q?LPrnET4WqBbhmpPzGdcNBQAv7dQtLRggImBvr099JVr3DAixmJ2H+muUoUHz?=
 =?us-ascii?Q?Yhljk4GYzOaJr68rQW2aCWKOl4yi7uidTDrm2Jb1Fm6rGA/7IScygQGYREeI?=
 =?us-ascii?Q?hUYi1PhZ3xjH4xhx1wo5rZ8mcdrcpWOH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkbepLgy0zymXxzyRLZFzCtzpqvB4IoCuJ0/php86UOzO9bvn4XgKkUCqiJe?=
 =?us-ascii?Q?aBFRD75Gbwp0vWRvOFBKQAyqFl/VFb+jWTQVIu7SeXXwGl2jcyTwVYBdbNIf?=
 =?us-ascii?Q?4kTXf2u7KBEwFrpbHbmtRVoyoSE+Q0YFAunsCzNkFUNrJ7PhT843ZEi/Aldu?=
 =?us-ascii?Q?eF3Ngh5CHLbYx7TxTR+ltbZeJ2tuIDybglCMEhrdTxb5vu/16KvDE3+6bpb+?=
 =?us-ascii?Q?/shGKSbd8wfetgG5DbCqrA/chAZTTj+2Fq/QyveGWrm0ae4RZ0jdKAnHuLTa?=
 =?us-ascii?Q?ihi01Uem9U71ZTc69b4+oQq7gITKu9OYJMwF9e4Imbr2EtuVwumRKwWAOxUl?=
 =?us-ascii?Q?g6v8ptN7MLXTc06GGakKoaScvR4NVoTInklPwIMiipwAOj/f/i5kFAcXCric?=
 =?us-ascii?Q?+IDQnc9Z4p0mb61EIGcZJ47tw+g3V/Q3LSNf/mB8u0Gai9GKnM3jO18HNCd3?=
 =?us-ascii?Q?brBIlKyUDe36Ykl+FtKExz49ldfzIxcVg+hYwEXGrVanrgkcSqxb6JTbvsX9?=
 =?us-ascii?Q?dLMMae1HMIUB6Jb3ASXiSxsR/b0RhmGf6EM5Y/oxa6LFLQkExV+ZWv9Yw6oo?=
 =?us-ascii?Q?SCVytBt1DBxAhpeJWJXZ8xoyphfiq/SB7rdbgXqunYUvvo84eaVZ3DcKCXpt?=
 =?us-ascii?Q?CWR253JlFSZnf45AC9mOKnTw1Mm/6KiM4j6kE8Kd4PB4AwSvVzBEmnDgK1yZ?=
 =?us-ascii?Q?oMCB0TtzGtnYJuwO/JXYWIZ1F3cJldaL/CRWn/ZBzIfzqsiIWVKPP3Rnr5O3?=
 =?us-ascii?Q?OOyvZCEOhu4HhB7vKYfYgMITfqGxPCw35tOYlMkHWMmKPWgbMyiKXmupGT8h?=
 =?us-ascii?Q?wtBWEZ+AYh+em/8IELiqfHsp+7BY3K/GeAYgTTTCZ1B0f+rrAbYzBS9Ml5zi?=
 =?us-ascii?Q?U+F/yKLJsuaNF6Ypy9vQ3TcBAdyWdfU3fiC7C94IjgEqV/lpkubG7EanuGJa?=
 =?us-ascii?Q?xJA3cxnOt6qi4Q82U3yHABzEJEDyOU0GNFOScCSTqsjRQEQXIB4wbVZfCyox?=
 =?us-ascii?Q?QyNGR0YAKgGW3Hi/sgawoPBplv8n341R+4S5p42FcbdVFg1ziMtNztMR8u29?=
 =?us-ascii?Q?dn7iIZHMmygEiEMLM9/mQLFPjAn9awC6cv4QNUiVQITe6iusaxGXAny95NvA?=
 =?us-ascii?Q?Iq0URDZVjoP+gjKTNpfTaM9S7Rn5ngSPWhPtBy1zqARtg8G6OiJWIxibJ0yb?=
 =?us-ascii?Q?+uZ4/+G1GYAQk49Njk8Rh0gubqTIhA+sc5Yj4t5s93+JJ5byG1iPzG1Xd6EC?=
 =?us-ascii?Q?e5ITlYTB1AHw/OeLJKv7wRcqbbFzl02LoggpUCyM469V00XNRq7CALzPavLv?=
 =?us-ascii?Q?ZN4U0IICBhFV9KspZCIA0veYCUD56a8emRQ0n4jOhvig+8GosfbG6BsgmCZj?=
 =?us-ascii?Q?FdhWmdqCfXj56T13rlrwx+kCZT4V6WPB4IYFA2+7YfLJO8i1G2p98dIPITXQ?=
 =?us-ascii?Q?bROx7uno2a72o+2iK3iTHCYkfnPtaHxCqJ4excB957GTp+XHY62v/CI/ueDn?=
 =?us-ascii?Q?1aC2EndF8HuurQYrEWK4C+a0Ill29tZgmzDq0RsvkBmKPTEsX0E1KgnL7YKH?=
 =?us-ascii?Q?CCaa8hhi1dqj0byART+FD0BgXCdu1ONuGN+6xGGdINJxB5jWYfFIhiLrkl41?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e6157-0b37-46aa-5bfa-08de179f789c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:31:22.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F0J2IJpXUa+inIFB+NeTE5jJbAFyTN/L2+s8FE1f8G46YzCQ7BVHAszmubtshYsnSJiaTNTfkODr8plif4ir7p1p6ImE8gs1vC+WXJs6jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

On Mon, Oct 27, 2025 at 07:41:47PM +0100, Geert Uytterhoeven wrote:
> Drop the driver-specific field_get() macro, in favor of the globally
> available variant from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

> ---
> v5:
>   - Extracted from "bitfield: Add non-constant field_{prep,get}()
>     helpers".
> ---
>  drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> index 6186fafb4a7b0dab..4ccc94ed9493a64c 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> +++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> @@ -1,19 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2025 Intel Corporation */
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/sprintf.h>
>  #include <linux/string_helpers.h>
>  
>  #include "adf_pm_dbgfs_utils.h"
>  
> -/*
> - * This is needed because a variable is used to index the mask at
> - * pm_scnprint_table(), making it not compile time constant, so the compile
> - * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
> - */
> -#undef field_get
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -
>  #define PM_INFO_MAX_KEY_LEN	21
>  
>  static int pm_scnprint_table(char *buff, const struct pm_status_row *table,
> -- 
> 2.43.0
> 

