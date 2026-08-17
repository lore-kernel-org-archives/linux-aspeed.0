Return-Path: <linux-aspeed+bounces-4745-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE645C5DF74
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 00:26:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP9VY45GFz2xW5;
	Tue, 18 Aug 2026 10:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786964272;
	cv=pass; b=ocBpE1c7ovi0U/mXPaRAVb+u9Dv/+Dl/zz4/OQede8bydhJDhyWx9X0untuDuqQJ54xgRcT8UZIztUug7rtgnRqlPd6NC9jBqsRuk0hqsij3ivZYxiN3YLVYn7RC9jeTAVM+xhHqYSyJMAzMLvRUW6IB7ms6G1yA4hxac2Xek1Il1hVFAe+CJ7wMk1OrSMqObgZbFBi1o5KWMQ+CdvNUYJ7/gV8mGqOl+do1vDNKU60W2mCbW5AaKSFLJlX5+WxLlMXh0fmSB+BjE716gffMtvFTLCWiDezRsjYVeSc3sS14CzXcG97Mgm7p75Hixv+28vgATSVeXZJB4gtASk6hDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786964272; c=relaxed/relaxed;
	bh=AKordBliv2zhM9/2Ze2Go4qpXSBRxuJ9g807t6kOW08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=djfbNKhTf3XF6huc2HkGOJmf4pWZGAz32jyrAFATugubcdC6hDntYJyLcFBiQwH4Yaq7Cohza27IVUiIGyYbOBl2UL26DFnjbFDFSZFOU/8MIWYZj6RFNw7iL5IpklRbm+i92zFF3h9tzbgci9YfPMLt2wmyqFBRtTBXDaWC3sVp/8Q/JVXTSBZ0kDmjjQj9EVpizRQAORyLPFR6SyUnlRVpjn35wh1xtZpyg6w9HA8e1FMh7XlV3LTSDjhFGF1uCBhtXxNDReAQmIpECHjsIjcfkLWDoAbnSe3t8lhYjNQDa8nFtEirdRlHfqEzAJXAMnLj3wdoMg01hkTFbu0/7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WvbasTiO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WvbasTiO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNqYT3mYxz2xWV;
	Mon, 17 Aug 2026 20:57:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBb8u9f/sPkFU43EXCFy55bzF12Ut8xZ9SzfYTPrOtt0sMQOSFc1wMq54H7ZqPQenykZA25ww2wL+C0NO2/xKus6moxaiQERNAegyOoi75HDh8Gn2GHlwEGTRuDs3OHdQOn2fBlvzyy6RBoXwxmzF8XijBWK1NIesAqwJBoeDrDBsDrVv/qB55Op578Yk5zWGOeV/bt2SHAEf2DQ5uObs0XXT5Jyz483hv9lIdEmnFN7SYvC5DkRJHH4mNJit8DdrOSHwCuP9hXTZR92RLBonIHit8XmOvFRhnLSQPQPaKQcfhSAUD6z2qtt+GwFrD7AlHdXYK14+p05KV/Ab4iKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKordBliv2zhM9/2Ze2Go4qpXSBRxuJ9g807t6kOW08=;
 b=CQCan7WfC7qt2meOOdtzujDs3xPKHwGCnaOS+TGGmRtPysA2T3J7Qbr0lZQdUdnQenLcJ3Lq1Gv7SXi3olfnA9T8NmV40PiK28Otl1QbdYzZ2MQwOku2J+I2n3TbKNjFv04DzRkIa779yyQBFt9WIB4LksNdumJDVICrg2gaZJAOS7FvULeFTRjg1Jg4IPQXTezYAD6WQ8UYbKhMiEkerSm3mkjweCsstFntsrv/qgeFIEc1/xS2YtAnqtjGo+eP+qy3jLLtUlUV4xxP2ISR+MmYXQwj7v1Kcr1lpEz5Ty6Y9CX/426OZntc5PIaj0JLP6rmaPll630cZ7vLIvRqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKordBliv2zhM9/2Ze2Go4qpXSBRxuJ9g807t6kOW08=;
 b=WvbasTiOIoSx8/BLAehFI/u+ylEC/XIMDuU86Bmmd9iINrYWoDLAF/kaXb7mcTqZJ5+j3SlJNQXXTX00MVxmJ17AxM9X43PBN3wzIFbysNKO908sy32aRahHlGvC7vbWQgEIZlJpJWKYRaWovzNeHqXWlkbNkzENwcsBgnDthlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:57:22 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 10:57:22 +0000
Message-ID: <9311cc44-f56c-4a96-a55f-d9e7f35937af@amd.com>
Date: Mon, 17 Aug 2026 16:27:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] espi: add core bus framework
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 broonie@kernel.org, linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <20260804115259.4065638-2-krishnamoorthi.m@amd.com>
 <anSGjRK8spayFnKw@monoceros> <0f7469b8-8275-4061-b336-97cbce41ff82@amd.com>
 <anye28kId4k8pxBv@monoceros>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <anye28kId4k8pxBv@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0170.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::7) To DM4PR12MB9733.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 061cbcd5-a138-41dc-f6c2-08defc4e508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dR1GDY+AfDmeAjl/Wqr5+5cyyV9U4jz+zavvEksJfQ/UHiX1dahR+/yFK8mXuunae/hfciB0xZpYD3uZKwUoLxzHVj5HjBpbmJGQRyL4W1ygMNQ8ixFLEuv6U7ah4g478EYw9/rzFz8B0IGVfjjylUhEZDtSi+tD8iJuSIeiDTa7eezydpl/+my30iVw85iwPErQivNqzeB4DSHDGUAZgtZiDne64W2SNaA2VupT031iYMtUT6fXUGQYoc6RUXNb26Umic3S7zvAKkApEXitkFdKSaxInzAu7z39XHwfKi276ZoUnwoK2fmtQVgy7+/IjCYgiULAJkTyvkYI6lUA8tcpBv/HCJm7tJDrEuZTc0NVqhHz31fS9GI0Qmncdmj8Iok7N7mVsFKgAII0o2JWM/v6GriMP6A272Y0FhD5tiP2J/oeTLKbZEP1bYnH5jn0N4hsvMZmX/Zdxx5RqfU0H9xACvMXaHz7XNOvcBI8L7IxfK/M6Ucf4y63unwbzDrbGjSXiA7LRFTfLlhPb9kRHpzcI4MYHS/lZPa538HBNBULZEZyIh12dYqCPVhJgT13RywDaVTOdq4Mkz9eYqVP9PRSNRyguEE/f+EaUF7w/Jvg5Zw9Z+CNS3UnUUJLWjRoCorZuZRB+SdWFMx4vQxePhcBR/UGddzxFFEgorrZPWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJPdCtMWTJFMHk4Z01YdVdTTHRsSFFoWGttbHBqRXFvaHRsT3lVaVJoMWRM?=
 =?utf-8?B?SUtzYXNab0xMVTl5Q1RLUjVXeGpGOE1JR09PaWk2ZUFUZmVXNTBDY0R3RWpn?=
 =?utf-8?B?cEUxYUdtQ1FnM296N1Y1UGZwM1ZwOWF3Zk1aSlRDV2ZZaUZvUEJnU3RDaVhQ?=
 =?utf-8?B?Zi9ZcGRqdW1yanVTUmIvYThuQlB3OG9kaFZsSGlselhQNDRYUXZMVXJUV3NG?=
 =?utf-8?B?YUxGWjZmdUcrTTZaY2NMMWdMbkYyMWpQTnEwZXMyQlBaS3l6ZVU5aktZZkI4?=
 =?utf-8?B?V29sdlNIT0VmdFdNWENMZHc4dTRDdHRQUWxUWVoxZFgxaWEyTFIvejMvcUVk?=
 =?utf-8?B?cmQ4UVVCUnBiQ0kyNkFmbmpRcStTS0ZpVlF6Ym43RUdEejdQeFNJTzg4VWxS?=
 =?utf-8?B?NzBGWXRnN3EvT0xiaUFkTENYVWNtTkVvSzlEczcvbTJXOFVHak9mdUxyRTFD?=
 =?utf-8?B?Tm9hQWgvUks5cENPaExjSDVRMWtkaVVUbkpyald4d3NTclpLdGQ2ZlI5blR3?=
 =?utf-8?B?N1VFaHlZN2t6ZWdoR2ZrOU9Fd2UwRGJxdTVOYk5wY3hpaTIrK2V3TE5ZZTF6?=
 =?utf-8?B?K20rT3FsdmVzRGVST3lsQTBOUU1pTUZub2d0NFpxbk54MGs3U2lzemdiSGl0?=
 =?utf-8?B?eGNCbkpFdTZrOHM0WjZnbWRJZXRLZTNwZGl0RncwY2RvMnlqbytIb0ErcnpY?=
 =?utf-8?B?d0dSR0FidEIramM0ZTBOZmtqenVPSHhFT2F1Qkp6MGpoa2VSY0k2V1pzMFJY?=
 =?utf-8?B?RUg5aS9yMkMxTThiWUd4R3plMnNLRHNibjFRUXRnbEJwYlZtanpnL1A5Sm9a?=
 =?utf-8?B?RkZ1RGN0Ymsrd2M4YUNqcWtEMHN2TGRYLzRYYlE5elMycFdPZVdyWHZTNzdw?=
 =?utf-8?B?clMxVG5OdE5zekJ1VWxaRXhZNG1oS09WbUVlR1lvYTFmOEZGRUt1NWdmSW4x?=
 =?utf-8?B?WHJ3cnhqQ21GUGtrNzA0eVN5eVZveDM2NkwyUWx2QXowVkZ4MjJQVEo4SXJU?=
 =?utf-8?B?ZGVkZllFT0pRckJ3bVljUHZvRTJuR0U5MmlTcHhTSkFwcjQrdktmejVzTHk2?=
 =?utf-8?B?Vng4SjVFSXZDOUlVc1hMK3Fqc1pRejBlVFlJeGpIbzdwcFl2MWNkOUR0cEdO?=
 =?utf-8?B?TXZReFl6L0tucExwc2RSTnJlOTNoYzU2ZVZ3WFEzWFVxUjltM1p1a2ZsMWZT?=
 =?utf-8?B?TkFmdTVxcDd5a3JEZFVSL0E2QXVmbVFqN2swYzhRL3gwNTJ1WUlTa1N6OFV1?=
 =?utf-8?B?T0dNTEpZMktLMTRHV3VGakZZOEZwaW5OeGc0bHRxQ1ltZTRQMEJUTmI1d1hB?=
 =?utf-8?B?L2U5Z0d6dW1wbUNnMU41c3M0TTRNbHkwZzM3Y0dFTndaaFZOdEJuYUE2ckgz?=
 =?utf-8?B?M1laTWh5UmNTMHJ4MzlxQ3ZUUTVRZDQvUC82R0RJZ0U0eTVNZDJyOTlQRkZU?=
 =?utf-8?B?ZGFpNFlhaFpnWE4rUHJ3cWRzdVFoc0N3aWV0bEZlV1R5Z1hnQWxsbVJvWTkv?=
 =?utf-8?B?V25FOXZtaWRYb1FWbThVM3pMR0VpR3V0dFVFTTlaai9SR2ZsNGhYUTJiNkdJ?=
 =?utf-8?B?K2oxbkc5M0FPVno3OEIrQTlBeW5aaFBYbFh2UDJxY3c1NVRJdk9VdWR1R012?=
 =?utf-8?B?SmZaK2JKd2U5ZmI3SmJ4MmxzMWVWVE9RTkg4TllNa0RlTHZsS2JEcWFoQ3Zz?=
 =?utf-8?B?TlJqWGpteEttSzZUem9UY1BkK1h1cWVyUjBQMXhUQ3U3NHc0ODJWM3JtUHNh?=
 =?utf-8?B?Q2lQZDUvRUhoTGFOOHE5UTJIeThYcVhQOVF1QUxFM3lkd2Q3Vmw5aTZUVjNo?=
 =?utf-8?B?YkNWazZ1TFhIT0NVeVFxbHFzV0VEV0JNNEIyTTBQdmhtNFMycE16aDU5R2Nw?=
 =?utf-8?B?amlZUmVXOEZMTUI4RjdocDI5cE1zNzdJVFJtTWZSZGJGck53a29TMUE4Nnpr?=
 =?utf-8?B?dlZ2S3NaSC9FNmpyeVhaYnNYN0VCZVpSVnMrZUYzRzJxbG9XZHE3N0cxOTlE?=
 =?utf-8?B?M0Y0MlJVcXNBOGluUjE1SkwrU2xEcW9rRm9kMmJSTVR0aWJmK1Z5a1V1MExF?=
 =?utf-8?B?eERYSVdhcXZSUGNjRjVTSWZ3OFVqUk0zVnRwMGh5QkdZOE1HdmlsMGw3cE1K?=
 =?utf-8?B?aStua2pZY3U0N1RqSXRSdEgwUkxoQ0hUa1EyUStwNGVXVjFqb0tPUmZaaDNz?=
 =?utf-8?B?Y3p0c0JXZ0gwb1dRa0NpcXl2V3F0L1J5bHBpZForQy9ZU2l2R01NWWlWM013?=
 =?utf-8?B?alV4TkZxak9hZFlqQ0t2Zkw4eTdKcTI1SGdUbkNUVmNIK2FMY0lPMWpTWVVx?=
 =?utf-8?B?RUdkMUQvMWJJbXFLMFNEV3ZQTHZmeTIxVkd2cVVqMWZaVkZWMCsxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061cbcd5-a138-41dc-f6c2-08defc4e508f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:57:22.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Njy6dno6nHlWsbQnuAmf0dKmqnhIKH/Y+cKgoJ7s3sHY8KhWiRhwpEiITCfKWNfkO19RUlLqF7WV7OuNXM2N2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

Hi,


On 8/12/2026 10:00 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Aug 12, 2026 at 06:20:29PM +0530, M, Krishnamoorthi wrote:
>> On 8/6/2026 7:01 PM, Uwe Kleine-König wrote:
>>> On Tue, Aug 04, 2026 at 05:22:56PM +0530, Krishnamoorthi M wrote:
>>>> [...]
>>>> +const struct bus_type espi_bus_type = {
>>>> +	.name	= "espi",
>>>> +	.match	= espi_bus_match,
>>>> +	.uevent	= espi_bus_uevent,
>>>> +	.probe	= espi_bus_probe,
>>>> +	.remove	= espi_bus_remove,
>>>> +};
>>>> +EXPORT_SYMBOL_GPL(espi_bus_type);
>>>
>>> Do you really need this exported?
>>
>> Yes, it is required. Controller and slave drivers built as modules reference
>> espi_bus_type directly when registering devices. Without the export they
>> fail to link.
> 
> I would have expected that
> 
> 	drv->driver.bus = &espi_bus_type;
> 
> in __espi_register_driver() is enough for drivers to not have to use
> that symbol directly?
>

You're right. __espi_register_driver() already sets
	
	drv->driver.bus = &espi_bus_type,

and controllers register via espi_controller_register(), so no driver 
module references the symbol. I will drop the EXPORT_SYMBOL_GPL.

Thanks,
Krishna

> Best regards
> Uwe


