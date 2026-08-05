Return-Path: <linux-aspeed+bounces-4641-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDBC55174
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Aug 2026 00:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnTV3Ykjz304x;
	Thu, 06 Aug 2026 09:59:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785924925;
	cv=pass; b=RXI7hpfm6a7ehaGCFducDtj7wpH/GORCfoXH3njDt40F54ATSzEIlT3R61tIek5UzMYvNAgn9nSW87PjQ6oaxbLzf9wkzk0PtxQ7XErGpDUEMKME+7MxewWAaHfx0EXhx29wNTLZHzfxZSx7pIuXsJQWUiwNRTFvFa5mGVdnFDUaM42eO3ukY7TC8lU9uDLEKmUCMijWHdILVHnJEJaCNYjDJnG+cSW6YRvi57frOSW+iMoOyrNYBHK42WBCWCzXxz4Un1SNtvHRwQ2BDgBZUpOqtmujdS9667hssBeQFv0f0oFAlmkUbwQKywL2iUfGu0pZGhPGN8K8Di/X4x5Rjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785924925; c=relaxed/relaxed;
	bh=5DxoqzE5C5inPeOflpZl3pfhxlvyujxI/BawB25Hhwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vs6Na5CvTQOk70l1ZBayDCve0+H1MkrSmS4tYR/olFaqyU5IqvEeQjFRrhpEeeEGXdVlXH8OqPSUbxIOiW86ACPKxcXHl6D8W8xmJUtgMoeSouvL960hoC2mTyegUiNkWlMlxcJpHDl1pyA6aat0m3V78T/7o0qWmLCg8JDRua0Wptgtiz30lxSqaX0ka4B4R+H/CctYahtwK6rTy/Lr7Wf+H3ilSsSp2luIXjEWUQfJaoWWqZhB+Nk6TN5r8BMS+nXa+ADBskGu9Pv22nwqG3OBRN0Vnjdq62lb/XO7JCe6KOUwyzMHUCWGDn97BVS11n8NhO2JgWRqeBmWrcE5Mg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Lj2mr+r; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Lj2mr+r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=krishnamoorthi.m@amd.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFRB32pYsz2xl5;
	Wed, 05 Aug 2026 20:15:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+VEa7ZBFtU+OB874m4k/OKcJdNvZ+TDfZT6lXQZQ89nGRdXn4cug0W2XqUXh6lN68IKK9tq1A96Ujh1u5QGWb395Pxmv1psjenUxXR9X4T+2aT5dgzM5NfV5kqdzj0uJ+SnI49I0CRApzOse9CbHPKY9cMNyfJMTBQK2qYxQY1kwUFey2cBz5AR5p1jJlF3lAGOmt10ULlANzX91shVSU+E1N4yiW9tq3kJYEL730a5HOR6GPNfAtsps26xFo/WMYGPKY4j9R4PtOY1TmXVKx/mptH5YfHrd8YswYqSWD1tRUs5qXWTVHcjGaVNZhoPDODGmZXQGRBe14ds2s0wng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DxoqzE5C5inPeOflpZl3pfhxlvyujxI/BawB25Hhwc=;
 b=T7T4xYKjnLzOzv4BmvpvpKt/vKSjN2zUTWUOoZOyqpPDKSARDNvN7Cw2wKI7Ful8yMRmX0/yZLqlB0ircGbjDZk5HXQ7vNaezkHRbe9LfaptOTVWjD4jO+oT/FZUo6lpYoUH+tfecf56jyqWHRd3CjwDi2j1HppWlPtNKu1OdQkW0SZfH6W/wAwrmmXPE+XAtFADst1fyPpl3OVg7CfroFgH9iw7wb9Ioe6E/Kz4XmCOAAhlWV4SZXTyAgF8lyhogFJMI33AQIO2D/lNXNBFd+7M53x5GdWIu3ZjZguXbnNVKsnRSiv6fQq2vlskel/7/ykiMyYxE+pqMh/+WlaEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DxoqzE5C5inPeOflpZl3pfhxlvyujxI/BawB25Hhwc=;
 b=0Lj2mr+rugBmW2mOITvVi+unby2q+P/+XP1XCtjgHdGxPVvXwV2ypHFv+T98DF7KDR2wd9KRbXFtCjcbSxzVSHN/M2nz+IHSKtaXJXHvchmxEHq1yCCIZYZNqnTbKMRAbr4g06eHOgOz15yNbfEnkxXw7PeQe/oHM8O95BMNH6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:14:56 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 10:14:56 +0000
Message-ID: <96494f6f-fbdc-4705-921b-97ded0acba18@amd.com>
Date: Wed, 5 Aug 2026 15:44:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <2026080416-lagoon-delirium-8e84@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0188.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::15) To DM4PR12MB9733.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec82c44-3031-4c98-30e3-08def2da65ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6gI8XYX+0Ys5vW9klqsL/LNGP7iBlIdaVpvVVhdKRw3UhgSm6BUOxNC/ZAI3FQ9UEHyoJhQWxpQUDcItOB+4LZUdnvxn/EfcS9l5XjsgTEuX6Eg9FbV4VIneRhLDUbXH9hb9/LqHOtrXeOh5jqQOBDCe6+dSt+nZGaHrVjuCI4LhBbrGx/W/XmQffwHG7vDFDzO11loomUm5JCO+cOGW1GFTjcT+2AOnNfEibIdZlcRznBryN6ub4RVjvAFh8X0ZFUu6BGhdLE6caDU8g3JNf/yonWu6gXbJRuu76m0IRor9y6BgdYstkhdEUH5Ln8Cq95DubrjaKfQB6/F2ANmfb4DK04IZeOLgiONXxm2LzW9dZ0/JJAAVQZhd/7Ah2A5MoRLPWheh8AkkwydmJnGljJpR1aj6gfSIM9Xfy47+P4ergyvhGUXzwNnnqsDeyu2ZnryZ1EMpbB1YBQ/szR+wEpppGnlMtmMUsXvfKp3Qg0nQ8Apn7GbnfKDJOPmMGNQMS3B3i6zXeMWk5Ge3k0BZuP2YLeOYByH5AEJZB00Aep/z679wwW/7HZRPikfY0l1qwxhyidbwOROd/aHC2P5iL4VC+tTRlPc2tHOhPx0PYWq3avV4aLitqHiSTCeVo+kyRy3i/khX+k6QuPEVoKCetaSscQCoF/DaTG+eAw+00VM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0hqTlAwTnpYdndXODkwYmhORVp1NVcycW5CanJkRlRGVTJ3OUZuNE1waDRt?=
 =?utf-8?B?SExVaWR5ay9WQjNzV1Jjc0RBS1BJMkJvUzhHTUpETjRFeVdvcG16bWVlZ3BW?=
 =?utf-8?B?STVZOXRlb2VMQmNxbHJpRk10aHZrdDVwRTVkZnZYN0hZU2tGZytyTlk3SUY3?=
 =?utf-8?B?cDdNM3VPcE91R0dHdmE3c3ZhcFJLN21MREdGSDhrc0JDOXU1M2YxRmpQb0p1?=
 =?utf-8?B?WDIrTE0vSXR4SHVPdXVWZXpyNERGUVlwcFp3NjVuVkc5dFVmTHE0ZnhydXRt?=
 =?utf-8?B?SnV6dDNwY0NqT2xEVHZkRUdQNFZ2TWhRSGZJYXJIeWZjRnNiNzAyM0RpN1Nx?=
 =?utf-8?B?MHhMVlZFejlSK2tmV0JseTZnVXFtbTZyZHE2UTFSQVFMUm9PNi9WcWc0L0Zn?=
 =?utf-8?B?ZWpZRUtIVTg5ODhXdHdYQ2J5ZS9qcStIbjRNL0hDeW4rL3BEbnJvWXlRak80?=
 =?utf-8?B?R2lTUFZzRWw0ZW9sQmdPODRucFNsb0ZVRzFvMU9LUC85cU5Fdld1bVZNRjND?=
 =?utf-8?B?Z3NCZTA3TzQvdnJwcU84cERLZlM1bEVpNHdUMkRmVjVZODNWRDVYbWxISVhP?=
 =?utf-8?B?ZGVuUnI1MVVMaTBHZUJoU1B5QU5WblBUNjk2OHpuT0xESDNyNGxPWU52UjBO?=
 =?utf-8?B?SUlIcnllak5Nd2NUOVBWS1VwcjBLZGJ2Vk9TT3BhTENCZ2h4UVU2M3hjMDdD?=
 =?utf-8?B?eGU4aElEVmphL216bWNuSk96NHRhbmVaN1FxUDBPSnNtbDdMKzN3b1gvWmhY?=
 =?utf-8?B?RGJ0RnhSKzFVOXBGSUVMc01DRExva1dWOTRrWFlqeWx0a0R1bng5TDJENUdi?=
 =?utf-8?B?MHdSelRmNm9oQzhxWVYwL241NTFNbWFmUGJoTEREMVZzYU1FVkZzQ1JnMERI?=
 =?utf-8?B?QnIweU5pZzVXTkUrb0tMYWFvemtQUVQvQ2tpVWpXL0Fjc0lJSzJXNDd6UmN1?=
 =?utf-8?B?RFZoRlNXSlVNVjBDVE5EanFkN1JXeUIrdSs1d3UwVTNqVS8wVGhhTTJFWjl6?=
 =?utf-8?B?djhvNit2U29oSWVFcDhFZE4wUngvUld2c0ZpYkxRNTFmL0xZQzdkZXdUL3F4?=
 =?utf-8?B?U0tVWkRSb0tEM2cyeXJPanNOMUZKalhiL3dram9iMkcvWHVrd1ZyMkJPYjNV?=
 =?utf-8?B?YXB1WFgzVVVDUEhtRTg5VXdTMGNSTDlwa1laN29GbnNSWDlIQXcyYzJWdG82?=
 =?utf-8?B?SGhGRnIrTWdCNFBIT0NtakJITHdvVnk4eUJmMS9PbTE1NzJkM0dyY3NRZE1z?=
 =?utf-8?B?djV6dXhJTW85UnBmdmFVZFBKanQwOWNLN3ZWYTNNQWhVekxLM2FnUzdHMXNz?=
 =?utf-8?B?UGdVNkdGOUFhN2pIbURVbGFIMzBMRU04bjNJTnBPTDZHS21vbCtHckoxZ0VM?=
 =?utf-8?B?TC9iY0tWUTNTdTQza3JwN3g3cEo5cUJ6NVJpTVpJOXc0VDAraktyTEJzU0tD?=
 =?utf-8?B?cm1FZ00vYmg4cmM3cWo0MkFmdzIrWTZXaGRKU1pnNmc4WDB1R3VxcHZibzR6?=
 =?utf-8?B?VDA3RmNIK0ZKdWZKbWhaczNCYmZEUHpwQWdEcStGRGVOdWZGR0hqWkRoTW9m?=
 =?utf-8?B?Y0ZaNUlQNlhtZU02MUJ0UmNQTzZkVUxCd0x1N05ySnhmWFVGSEw1VmV5Uk41?=
 =?utf-8?B?NkxoYWZYU2dnYVVLNE0wWDNUWDNaM2pRQmFiUGVkdnVzeTdrZ1VPRUFpVDFP?=
 =?utf-8?B?TnYxTGVuWThLWGRmVi9zSWpxaVVyQzhtZkpVbWFSVTNKcFRrYWVuWDVEL3pE?=
 =?utf-8?B?ODJRTGhBNytKekZ6eU5VWEFCS1p1ZWcvdTVlR3VKV0todEVKcGp2OEhQUFFD?=
 =?utf-8?B?ZHhDNnNPV0t5anU4ZTRZM1lyQkdlSGNLN2cySDRhRGlyd3o3ODJyWEtuYnFD?=
 =?utf-8?B?cXkwYlVMZXJ5VzdmbmJOS0lodVNKcXA0MXFGcGlzRGYzWUpNNnVrNUMyWWdH?=
 =?utf-8?B?cmIySk5GOXMzL3A3ZUpkdlF6aUJEK2h0WDE0dG00clBRZXlmOWVYRlNjVHJp?=
 =?utf-8?B?MHlEekZ2RzJxblZrdURIcG9sY1FxU0MwU0ZpYi9LUGVNaTRwZ1E1eVRpSFQ0?=
 =?utf-8?B?d216aVlscG1Ta1hzNTZIS1IxUXlYbGFmTVlibzU0UklJYXF5R1dpaXpEdWdo?=
 =?utf-8?B?VGZONjBiM3JabitlK3RjQW9sSW81bXlucStqUEFBS3JWVERraEpnYlVsNmFa?=
 =?utf-8?B?S3pCcWJYWnZsVGMvb3V4Q2lzNWtiZDBPTzEyb1p4bVRFUGcySUVIdzNySWRO?=
 =?utf-8?B?T1FYekhQUWE0MTEyQVpVOEhGbnEvdUV5UU1IM0t2N040WUZDbEorTGxPQ2Jv?=
 =?utf-8?B?WTNMT0dTblUrY2NjYkUva1VvRE85SWw3bWJ2bnhCZFdtaGxjMEplUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec82c44-3031-4c98-30e3-08def2da65ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:14:56.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHL/Vp1f1VGA/YIIjr7skkYSBUOOctHnfcH/MPzTkQCuJXKTywYoWvDL418BxRUk4+zxCwBwDzG0Xp9H6l6GWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627

Hi Greg,

On 8/4/2026 5:48 PM, Greg KH wrote:
> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
>> Feedback Requested
>> ==================
>>
>>    1. We chose a dedicated bus_type for the reasons described above
>>       (capability negotiation, four independent channels, asynchronous
>>       ALERT#). Does the community agree this is the right direction, or
>>       is there a strong preference to extend the SPI subsystem instead?
> 
> That's up to the SPI maintainers and developers...
> 
>>    2. Is the blocking notifier chain the right mechanism for event
>>       delivery to slave drivers?
> 
> Notifier chains are almost never the correct solution, especially for
> real data you wish to send to devices/drivers.  Just use a real
> callback function you have to register for, and a workqueue, or
> something like that.  Ideally just use the process context of the thread
> that created the data in the first place, why can't something simple
> work like that?
> 

Thank you for the feedback. The notifier chain was chosen to support 
multiple slave drivers subscribing to events from a single controller. 
However, your concern is valid — it is not the right abstraction here. A 
cleaner approach is a typed per-device event callback on struct espi_driver:

void (*event)(struct espi_device *edev, struct espi_event *event);

When the controller decodes an ALERT#, it identifies the originating 
chip select# and calls the callback only on the driver bound to that 
device — no chain walking, no per-driver filtering, no untyped casts. 
The callback is invoked directly from the threaded IRQ context that 
decoded the event, keeping the delivery path simple as you suggested.

We will rework the event delivery along these lines in v2. Does this 
direction sound acceptable?

Thanks,
Krishna

>>    3. Any concerns with the ops table design or the -EOPNOTSUPP fallback?
>>    4. Naming and structure of the public API in include/linux/espi/espi.h.
> 
> What specifically are you asking for for this?  Do you have userspace
> code you want to integrate, if so, does it work with this?  And where
> does it live?
> 
> thanks,
> 
> greg k-h


