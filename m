Return-Path: <linux-aspeed+bounces-4626-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A283AC55174
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnRZ3Qcmz2yh4;
	Thu, 06 Aug 2026 09:58:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785954980;
	cv=pass; b=XeDsOyoqR+6CrZxgyhbWWWDnUbA1Zg0Xz8n6VPpW2tEdViug9bwkh6guwkJrgiRticC5vtvLF3aDTeDt42QYxVSLPgn+hvnmjzdas0hNmghcMzgxDELiqPIP3X/wKSUMCJI9Bl5bHVZsSkNcku8RRRLURdzzw4tM5lBu4wrlwlXNSQJbLXmlUMbq1fPv6eo6/FtXIjRf6NaF12ZCpcWyvAgMkTsNO0uVqYf/sN8qT8eb76pSg9sgBQ3GUt0h/gdLyYxAGN7vzwWvkh835k3vYDQrGNJRaybdSPHRaXs/6yHYXLrXTwXUC13TSTmSg5fZ8wB9KePc6gEhWA0l43LvDw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785954980; c=relaxed/relaxed;
	bh=3dSz7HRP7/oqONUkxxJvZqnOeQw+x1BDaDBLUyHzdI8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b6R77a3PsZ9dke6hTe3uHXZrL2PKytJqotSH2CeLCmeytymgslEvrb4AamCWE7GiXpuNr6xmWATnMOc00gDMnmoN9/uD6wVVdSeDjfqHsmvP2hsPutVkLLDp0KcujIaYhz34t4INTqhmWPSeQe7GlYQP8bFknFRVthn2ozSXWRx0hpZrdeHCBhiykCmw7C2fTisDbdNz7mCGTR9qt4t8rQzyfdGbx/IxPzRhmQGcdRfIMUdKVQ4Bfon4730pvTrKkgMycaUByFDuMTOSQN7zxbLZvvII7yVCPpqXb5SiDDQqxWt6Iut2CQWxBxEcYQerblzW55SBZqd3O6JWHnzz1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=En69wfUA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=En69wfUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFfJ21G8Jz2xpn;
	Thu, 06 Aug 2026 04:36:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv9OA+W0ELBj0uXcziQEX9856OIoieQmI16ECM9TpYjYH5fRisQkbn84IkDWNpbPnuDAn29r8tRtOz9a54g5THd3BX8+KbYqwymmMJN0bFr2fDXoj9ObVD4cX0kiu/XWGvDEE1h3rIQRJf/yRcIgbFmh3ZV+saG+5OzZQhOxIDYNBQ9kJFITcRFXk7w9IpjRx2ItRrkOwU3MtYBkwD4E9pQS8rtyzk51qiC71/86XoVmnLwB51Ih4VU5gPrsisgrrNzwUTuyVh0bwMBjSC5js+CS/p848l1EB6TEljJFDdxdByHTeKf94k8q5X+p+VRYcrOyBeTzaOgnnnI1T3cnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dSz7HRP7/oqONUkxxJvZqnOeQw+x1BDaDBLUyHzdI8=;
 b=S0lSnsQEFORiwEBBop6IBoa2E0mifLWwNoNttNrRFBI5mB2NjF5ebeBKVWU4Lb4rrkOSeiQjDeReSio+jN+sV/zQTSJx3BMDrVPWeMrBlnrhHo+9xlNtkRost7l61giX1NMABGhYfYwY2IgatnE8PmozGOrUffbNq/WRWqbcFtOC63jmLLdRpL3TN+f8W+pFval3cMTcXjwSReP258b9DtRHWFSd8uTgXv0THBSKlV6OyxGAaiCxhSPxXMNH4N/sXtXtS1b3u0aGnR6L0HfhbUEr5VmfRIH41gM3Ft3eyW14URCdvB4t/G0lV0cmFFZfXETOjt3w+qe9XM54xeMU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dSz7HRP7/oqONUkxxJvZqnOeQw+x1BDaDBLUyHzdI8=;
 b=En69wfUADxelM37uGhRgG7ia7xzPrzGLbGJ46z2PhvIDSBaRVbPm9poUEBsUKHOyOZ97IjJngkXlV/qUWBOIKGvWWHCo80RxZ1z1unnMEXkGuqVnXd+ldhTpBeV+1tU9GaDUOgLKIdwUNY6ZTD/3G3zpyoNJkb8MJzeMg2M/NzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by BN7PPFEDA8E6F1A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 18:35:48 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 18:35:46 +0000
Message-ID: <9180f5d5-9885-492b-b80e-c2aaaeb39501@amd.com>
Date: Thu, 6 Aug 2026 00:05:37 +0530
User-Agent: Mozilla Thunderbird
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg KH <gregkh@linuxfoundation.org>, aspeedyh <yh_chung@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
 <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
Content-Language: en-US
In-Reply-To: <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|BN7PPFEDA8E6F1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd3f93e-5de7-461c-aed4-08def3205d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ItGbx9lpoPHF37HZCJGqfjbxILsDPIqBW/65YPQs34DpUl1hyjGHfg9l7iyRZ87LnfxruQ9Rzxgt1RVL/VIwvhuvDVUmNTUJ+i8EbJqWNDPdGjFsLrrAYXwqij1bEl++Jup0btGgfWgS5hvNHDNhqK3QrA+mF8RvwqnQ9oQlvSA+94h+axssOuSWJJ4PYzm1wIvJKkKS1DwK8+vWZCblg6sUFDF04XXHJB74oEbCCuyhuXkuLIuWaqyL0O/AHKQYqleZPIc/eniPuAACghWDeDdh2RDpvpOstF7cyLJejJg463mwCCgHPcSrg6DDZxDUAGxW5byulIlMuw/o2qGyStKM1IgEfY+MRx5gzKKLciT6FqrMYcAH2AWvjVOSiRNyNCfgFGvwJf1lEZjwA3YjtJtFwUOVQVHWQ8pgnIw6MDGqQ1vZZ+VURtyiCaIPB+IQaLP9PJ8ylCE3g6GheqD0yjsKoBkuuq+p79TZ+bgBkqZYRvibxbUyudfz6Vk9ic+M2DKCxbKJ8+pQNdxjr3ZWkBVQYUe/XDYLViBEGOujn6gXqm8RCKiki+VvE4LkS8gKXIqJJ45TP0T4KhEIwvWbEPsjDWRNyUPmqkA0ggRB2ZUvDmyG6QanII/lyBT+yx92ty9CkoRKrsde6X1Jwklm+wyjTnITFYr6fvWPe0byfQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHFjL0NWK1FMbWFObkk3M1pOSW1BUStyNmdLVUp6TElDSmdTK2xVbXFYSlYz?=
 =?utf-8?B?Q2ovV1RuVEpvcExvQ2VFL3Y2d1pKWmJHVm1mSTFEWUcxV0RaNHFxMDFPODlo?=
 =?utf-8?B?NFU4MG84K0FiVGhvbU1KRUdKcHFSTXpBSUZpM2lHSVJCQXV4RXNTOW0zcTNa?=
 =?utf-8?B?b1FmZ2l0eXM3K2JlSlJLMEN0bW5Xa1ZxZkZVd01VbHVSUzNzTzFrKzJ0VGww?=
 =?utf-8?B?a1luU2lLUGZ4TkxEbFRieFNFZUl4azd5NGlyQmRIbDYwV00vSmJiTFppM2g0?=
 =?utf-8?B?QjBuMEFkK3pOWEJMMGxnYS9DQUFQTlhWRU5lMFp2SllwOTVyRS9IU3NhRW81?=
 =?utf-8?B?TjFLR1ZHTVNkQ0syYTdMQmhuN0d4VlFubW9lWjhMaGMxa1FDZzJIMGlsbWNn?=
 =?utf-8?B?L1R1QlNhaGwzMWtjYUc2QUtLcGNSdzR3YW1zaWdkUDlmeit4RFRseGh5UGMx?=
 =?utf-8?B?TkpzUm1PM0k0L3E3cEVxTWJySHpEelBiVHlyV2lEVDB4OWhZS2FYNTZ0Zy9H?=
 =?utf-8?B?QkpCSDRZR29tQ0hqWW1zRjRuTmJNd21TdFduN0hOMUV6YXBwbmNXbXFjWFhr?=
 =?utf-8?B?SEkydVZGMGdNMVErRTdsZDRJS2hmaXl0TXo2ZGV5TGZzajY0c09ZVnZKbW5z?=
 =?utf-8?B?ZWF1OVdHQ2RBWWIxdzZPam91R2xBUE1tNERPQnlHZjlmTXdIZmNYZmwyd0NJ?=
 =?utf-8?B?bmNkQXJJYkRnY0dRdE50ZEhNbFgwWGlNd051Nlh4aTEvcFpSdlMvMnp3M0tR?=
 =?utf-8?B?REtmZ3N4a0YxcVFrczN6aTJNakNqaHpuNVdzYTJjR0l2Y0ppSWVqc0tEd2tE?=
 =?utf-8?B?WnVUS28zUVFOSEg0WjJ6TmttcGQrMlhRWUFiZTNPRGZEbVZQVTVidXJRaDBZ?=
 =?utf-8?B?b3NtMVFLM05mcEJkcThoajUzdmJVeEt0VnJQWXU2endFQXVPYjlaNGlCQTc5?=
 =?utf-8?B?MFB4MUpta0d0QVo1dnNZQVp3NHMzN0FlVjArV1VzREtqaytQZHMxYzFxb3BE?=
 =?utf-8?B?YkxsS0ZhS28zRkwwcGZvMG9JcVNCcUJZZWNZcFRpbUMwakNXbWlOM0pYZmdO?=
 =?utf-8?B?S0tqRzh6b1p5VkJETDFQenAyTmRJSXBMYlVPRGx4WTFsQUhSY2xUb0hCTndk?=
 =?utf-8?B?YnpBNUJVdTJjWWl3MStEVDBDOS9TWWJmNDdoTDd1SU8yQmh3dkJRZGFoRWRx?=
 =?utf-8?B?VElvcUw1YjhpbXRKMGJudkZHaFFQcCtFRjIvVHUxWGI1dHZScjZkQUVuOXRp?=
 =?utf-8?B?bWVqajQwTFZQZlk1ZEVSTVlCKzZ2MFdTUEZxSGwzSk91a1pLUTZMSGkxRERo?=
 =?utf-8?B?bWlnTlRxZkhxa1V2eEtndk81N1NLekpnZ1M4TUdJU1E3OUxnU2wyQVVYcFM4?=
 =?utf-8?B?dEZoa1NjaWw0b1lxK1dqelk3YWtONFlHZ0tZdUN1Tmg4K3I0cFpwZ0l5SGJm?=
 =?utf-8?B?UFNGdXRmTlFheXVzS1p4c3V4ZDFNSS9aLzQ3dG5tSmVXeFNpNzFmZjRtOENj?=
 =?utf-8?B?a016R0NiejNwRlRodzhtVEg1aUhOTmlyUmEyLzgwUGVOQ2FnaHh4cmZrSXRC?=
 =?utf-8?B?ZFVtdVhKa2tWQWlUM0M4ZVRScU43WTNxNGtpYVNmN3AyNUdWK2IyNm5wMkhp?=
 =?utf-8?B?RGwwd0lkeEs0cW1EY1hCdXViUHJHMEVXamJ2NXZtQVRla0JlOGxFZ1hha2dw?=
 =?utf-8?B?QzNpVGJVdWYwUWxkTkUzRjN6YzkzRVREb3dKamY4Ylo3NnlBbDVBVHE0Vkpw?=
 =?utf-8?B?TlovSlIzVklRN3Z6a1U1Y3I2QnJ1Vk14aVErNHhDNzkzUnoyL0JMaUl0cHFT?=
 =?utf-8?B?WWhZOVdKRnBJOHFBYjFUTnEzbDEvNTFmdDJaTnN2VjZ4L3h1emlGekJBN3Vv?=
 =?utf-8?B?dGVaTzFMcVRsZDdldDRSM2dmenJ0MEM3Rk45Y3lFcDNUVlRsamtYZjdOUU9V?=
 =?utf-8?B?MWRCTDZNVEhSTzZnOHJGUGdRZ0VhRHRMaHhhMGZMYndnMFhBU1BVcGR2QjJp?=
 =?utf-8?B?TzVpSHhkbmliN1Awbk5RWW5MU21IeGtsbEpnOHJWSXBOTkQwMkZ0SmJFVXBE?=
 =?utf-8?B?RmFNc29IQjdFUUxOa0JXbC80QVpTRFdxUHEzN3BFWHY2TXlXQlRROHQyeHJn?=
 =?utf-8?B?bWhJRzRRWSswZmJ2T2Z5TXIvS3paM0lPU1QyZUtlTm4zOWIybGJYUlpFck8v?=
 =?utf-8?B?VVdDZVhscVRmd3ZJdmt4S3BhVVVQR0JGUnF6a1dCaTFJUW84WElISWJHNzNr?=
 =?utf-8?B?akFRc3cyS0VveWVURTh3TEk0MWRMVXd2dXhVTlp4VzJvVkJnTDcxQVVGMXpn?=
 =?utf-8?B?bUp0V2VtTWJraWxtcC95NGNoaUV5bkNtMTFZUWRxeE90WkJqZjFMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd3f93e-5de7-461c-aed4-08def3205d4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:35:46.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3l73FMOsmxQa7Tz1g3J4eOiUwishBXJVZ6Cj+vNwtlCjPpG8LOppIDWJ/k3NoU0FU2uZVMBhO6aw4wdH56sVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEDA8E6F1A

Hi Andrew,

On 8/5/2026 6:12 AM, Andrew Jeffery wrote:
> Hi Greg, Krishnamoorthi,
> 
> YH Chung has been working on eSPI support for ASPEED's BMC SoCs, so
> I've included them in the To line.
> 
> On Tue, 2026-08-04 at 14:18 +0200, Greg KH wrote:
>> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
>>> Feedback Requested
>>> ==================
>>>
>>>    1. We chose a dedicated bus_type for the reasons described above
>>>       (capability negotiation, four independent channels, asynchronous
>>>       ALERT#). Does the community agree this is the right direction, or
>>>       is there a strong preference to extend the SPI subsystem instead?
>>
>> That's up to the SPI maintainers and developers...
> 
> There's concurrent discussion from YH regarding device-side eSPI
> support in the thread ending here:
> 
> https://lore.kernel.org/all/KL1PR0601MB4276FA2C6347192CC45826E490ED2@KL1PR0601MB4276.apcprd06.prod.outlook.com/
> 
> So far it's arrived at a matching proposal for drivers/espi.

Thank you for the introduction and for pointing to YH Chung's work. It 
is encouraging to see concurrent work arriving at a similar framework 
structure for drivers/espi — this gives us more confidence that the 
proposed design is on the right track.

> 
>>
>>>    3. Any concerns with the ops table design or the -EOPNOTSUPP fallback?
>>>    4. Naming and structure of the public API in include/linux/espi/espi.h.
>>
>> What specifically are you asking for for this?  Do you have userspace
>> code you want to integrate, if so, does it work with this?  And where
>> does it live?
> 
> I've seen your follow-up realisation Greg, however, regarding
> userspace, the thread above suggests that we should be able to back
> existing subsystems (GPIO for VW, MCTP for OOB, MTD for some flash
> functionality) onto eSPI to minimise eSPI-specific interfaces:
> 
> https://lore.kernel.org/all/KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com/
> 
> That doesn't cover the peripheral channel, as that's dealt with in
> hardware on the device side, but for the purpose of the controller the
> devices on the peripheral channel should all be driven by the kernel
> anyway.
> 

I will go through YH Chung's complete thread on device-side eSPI support 
to understand the full picture. Reusing existing well-established kernel 
subsystems (GPIO for VWire, MCTP for OOB, MTD for Flash) to minimize 
eSPI-specific userspace interfaces is a sound direction.

YH Chung, would you be open to collaborating on the slave-side 
interfaces of the new eSPI framework? Happy to discuss further on the 
list or off-list to align on the design before the next revision.

Thanks,
Krishna

> Andrew


