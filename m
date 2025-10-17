Return-Path: <linux-aspeed+bounces-2509-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F48CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 19:49:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpFlY11ybz30Vl;
	Sat, 18 Oct 2025 06:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760730585;
	cv=pass; b=TM4+vJwB6aJnsSDs/KiT+cMPnKSVuZq4TJB47thytm64cI+ePDQU3dU4vrDxIS/Fg+9ZRBRTXDqDHITWWAICiBg1cjZ4NZ/h8ygnIoUU+/nltXjgCVC2fa/j8rovHnqVsx9bEG04HT5BIUOEwPyxntq6V6rtet763uo3gvGZY4rN5aOp5SKqHG7zLGcvF6QxXCRsYoIEm5Wfd2splMkj9AW5QyYPT7C02//dkxNywNaqIZCz6bCS1rjNtpvXmyqNwn4wYZUzSqZ5Uhw7viCKorZ20Lj1Tt/HPVKIqqqMy51kN7qkWtXAEsCVvatCt0ykidg6Hf0ybjmjROIbPL9Z5w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760730585; c=relaxed/relaxed;
	bh=RWX6UcmsSk8FPxfdTA1CdktxdkziQV2i/BSl9tgQ2wM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X3XJRhJeSRKDGYrxg+48Bmyyhw0BNQ/tllUuXpf8rTllJNOkF4ZK3V5N9G7txrjeFRl6TRoqiTJxSTKsHEuWMECmcR6hwVFFULqE9Wiz7enAO2kvBoPaLhHldEHoNfjApwPku34qf1ircJEWknUflZIa28W/GWtZCa0ALkoB1eS+oSpAK7K7OsYjgIVjImxJercRGAhsJKjlKJObOXyMak2FAY9LQzdtVw1MvKsWb8Enpy4AaL2UJQgyU6qnnOMooQqln26K/nAmb5jDZLVZ8ZXNXiSU6ygwFhwNtks1aFkUu34YdRD5rKZ7GcOVXfYXFcHgtMNXl/CUgxY9m6aTDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cpFlX1v1fz2ypw
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 06:49:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWDHzgS70AXCJbP4AGDFdp2BK5S3qSB9PTSm8CeS2r1wGgtLmP7w0KSQncr82Gc2yGUVUtkQ3gpzEagDq9orph3XkCdYMGLIJm70+5lRAYDz3168zC66Cg9FhEuD2c6F6DID0TVhIaRy7TfwpmAELca8fl+mlD4HiZzs004Pgoc4H+lyK+eM7sBTKw6XIrdU9kIBZXPzf9hu0sNXxy7CY8UoFftgcY3ZUOwkciV2xNiwjVkS0H0crrLrNyvr2OrJY8x4aSkPHiBiSvypD35dBZcHwGErGjEC9+96kWf+p2s1RvdLwPCJphzZQYIJJGt4WK0EFn4AWZjY6tz/WRQ+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWX6UcmsSk8FPxfdTA1CdktxdkziQV2i/BSl9tgQ2wM=;
 b=Wn7KvWS/rDzqdJ7WUIe7qDTKsda43vn+IBMmJj8Er7dilits21QBuwI1+IMROrhJCkmMbgfTFffIWGfZDostWK33CZ/DNg6paJK0XLOAndPo4Rj1CvMGsrq5oMrc15EoswYJLOZWE4mJzPVnLa1kR8ucbgI9cLNnh50kAbio0vDzRhv41dN80/w2J07IL4UNHbEXC3Pv6Sdqj46MfHDvWgDTnEsXEPRMAkjVPvoyWq2h/5VVE4OQKdlxSljLyzfp+UaCmnj9idIc3snfyW4SC8j+NtOM48Vbfz4aRHasdUC82atefIptpUl6+mClPtixbQx1ZE9mjH41yX8CQRHdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR5P281MB5048.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:49:19 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9%8]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 19:49:19 +0000
Message-ID: <cae47933-ccef-491f-a79f-910686047b42@siewert.io>
Date: Fri, 17 Oct 2025 21:49:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Content-Language: en-GB
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251011112124.17588-1-tan@siewert.io>
 <20251011112124.17588-3-tan@siewert.io>
 <eb9ed79a820b67d7d3dbb0ab7ec6349bf962fe9c.camel@codeconstruct.com.au>
From: Tan Siewert <tan@siewert.io>
Autocrypt: addr=tan@siewert.io; keydata=
 xjMEXY4MwBYJKwYBBAHaRw8BAQdAdDPxHO4UUyhKcZXkztTv4iVAbjk/+F8ayCYnegO4q4zN
 HFRhbiBTaWV3ZXJ0IDx0YW5Ac2lld2VydC5pbz7ClAQTFgoAPBYhBJ1bd8XzFb0F9Kx5LnjQ
 kBYSrhG1BQJnqiY3AhsDBQkSJuqzBAsJCAcEFQoJCAUWAgMBAAIeBQIXgAAKCRB40JAWEq4R
 tbtDAQDyPybWLk2EYMeY+vv/WID8hk18+jp3fZCNp9aJp9GkJwD9GeQNvCO1LPDUjkMQqf8d
 DgMM9pmsvbJUFfViYbflbQ7OOARdjgzAEgorBgEEAZdVAQUBAQdAjtzTYeMaO9yG3M1uBtQy
 JB57UJXf+m+mNDhWkOY69DADAQgHwn4EGBYKACYCGwwWIQSdW3fF8xW9BfSseS540JAWEq4R
 tQUCZk72AwUJEibqwwAKCRB40JAWEq4RtUkGAP0R8RmddZqdGdqdod1MkVXpw/z5OOptToXf
 za1W8nsGmgEA5gvQzkN1LJ8oP9LB8YGAmJt82tPvJCmi4WzesI53kQY=
In-Reply-To: <eb9ed79a820b67d7d3dbb0ab7ec6349bf962fe9c.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::6) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
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
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR5P281MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: f0932a13-5e16-4cf0-f7e4-08de0db642bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2hOU3RzWlZ1WFVKUnRYNjc4Y1YxbVZJalcrTEJMeEZYSXJ0dzdDUm53aFdP?=
 =?utf-8?B?dlhZRW81MGp0VDBKdXh0Uk92YjBwSDIySmJ6UHZIaU01WU5zd2JXSzIwSlNK?=
 =?utf-8?B?OUJETGxhZVNlRHNpK1VVRWdxMVFOYlpzWkJOUzc5dnZ2TW9ra3VzWkdBN3VZ?=
 =?utf-8?B?bmJ1S2hkM2NRMkZHOTFyTjVFVXZlbjAxWWxsWUR1R1Rra3lEZjdpMVpHKzFm?=
 =?utf-8?B?R3kvWGRETmRLdnFLKys3czNqVTZka2NyZEpGWWpXMHYxV21UUW9paDVvRmVk?=
 =?utf-8?B?dTBoNXA1OVlqSkplTm9pUk5Jb3MyL2l5Tk1ReU95ZFhCak1SK25MUjBpd290?=
 =?utf-8?B?NmlrVTkrMVEzQkpJenp6YmVaRlRBbEFNMHBkVmVYa3pXbDRrRGZsMzZsTjM5?=
 =?utf-8?B?YkVHc1VHMkhDc2tUVVBSUFZkMlJkdFE1ZmNvRDNYaFBlNC9idllhZE5JZUxU?=
 =?utf-8?B?Wk1KQlpkS3hvbmNKcy9XYnVqQjVxNUFXd2xaSFo2NkxSYjhYYUl1Ri93Vnc0?=
 =?utf-8?B?Y2NITWNUc3RtZ3h5UWJZRVpsS0t0Vklqb2VwNDYrZ2tDT0I5R1U5ZDBQenZu?=
 =?utf-8?B?SS9qdU1saGxCS2FXWXN5bFBEUVhObWpIZ2cyS2RIUTBCSXF4ZHJ2dE9tZUw3?=
 =?utf-8?B?MytTVEc2cXI1RkQrQllZUjhnY2h5WEhuaE9EdDd5cXdPVnh3eFNWajkrY0Rt?=
 =?utf-8?B?T01lMlZ3RzJyMFkyZ2lyZ2VYTW1kdnVUWmE1SG1uMjg5c3ZyZVVCU3NDQkFV?=
 =?utf-8?B?NEFOTU0vYUJQT3pVV3FyWXQ3UC9kdFZ5Vm5tT0xDaEphWHNYWEhvb21YbjZr?=
 =?utf-8?B?VUYxamdmQlJ6aDlINGVGTW9YOFd6SW9obG12MHNySENrdlZyNGZDMXh5aStV?=
 =?utf-8?B?ZlFndXIwSXkrSVBySnZPcUl6eFhCeklDbHk0QmYzL0dESmNScWhoWkp0ekhv?=
 =?utf-8?B?eFVtcnU1dUlMWHNXWTBHamh5Uk5UdW5aZFNRVWlKcURQSkdaYlFVL05yTmhY?=
 =?utf-8?B?Sk1mWkpIYXZpL0IvbFlqL25zb29paWN5cXRkUWpJSUdOZlpneXRLM2VTTUFT?=
 =?utf-8?B?TlVNaU1CNHZKL2VGak1telBmVC91akZSRWc4eUdSdGRBNUFERkFlZ2xiUEVU?=
 =?utf-8?B?TnBod2NLN0hEY3d3cXo1OGhtSWEyZ094K0ZGODE4R3BqeTRJbm4rN3A3Vjds?=
 =?utf-8?B?K2x0b015SERRUVBjZDloOXkrMk05R2ZZSFlNLzJxbm8rbmx5MFBVYlJQZnN5?=
 =?utf-8?B?WjNOUDQybDVYOWlVanZnY05CUHUwS2VVZUpQcWgrbFROemppYW9aY3MwTnhX?=
 =?utf-8?B?Z0h0NEgrcWNXSFMvNEdQWVNXbFB1MDhrcUFNM1Rqdmlpd3I0Z1U1cWp2TkFl?=
 =?utf-8?B?a25xNnJkWWVmSUY4VEZFQWl4aWR0akdzOCtOQmUyYkcvc09HWWpQYkdRL3lw?=
 =?utf-8?B?Tm9KR0VPZGJYR1F2T0lNUGRxL1c4N1hrUW15NmxlZU5nUXkrcHBGaUFoaEt0?=
 =?utf-8?B?OTFsSCsyMVlXSW9tSEpBVEFVWThJSnczT29UM05BKytZYWpNZCtINGZIazVt?=
 =?utf-8?B?WlJMYm55djF6NkV2ZEdTZCtkSkhNcU40ZG1kR2dlQXliam1lQXMvMjBnOWhV?=
 =?utf-8?B?RjJ0OWM4WXhiRUJqZ3Yza3JDM1hNMW9JYlNwbDhCMG8rLzJaSGprdldmaWow?=
 =?utf-8?B?SVV1alc0SlhieURUSFFzalJaSVU0MUV0cjZnYm9ONmExbUd3U1BSM2lZSXYy?=
 =?utf-8?B?SmorZWZuZmZ1QnFOaU1DbVBXQURnVkQ1Qjd6MmlCeWlLb2RYY2ZMblNwcjF3?=
 =?utf-8?B?SlFncTdUTXhjWnJzTGJ2d09DQmNvY0JkVjJsVFBYQmRUd2lVdWV3RU5abUhR?=
 =?utf-8?B?U00zVGsvM1VQdU9DVmtQZDlsdkwzUldqcEY4cWxjcDhEN3BwV1phTW1qQWEr?=
 =?utf-8?Q?ttusu4HP0fBEnERgt/HG2wtDYXmBgHdl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JiSVE1dUdGQnZRUC84NmR6bytyekkyNk5OZHd3NUdja1NrVVdNRmQxZHlX?=
 =?utf-8?B?QkJGTnh2S2lldS9VUE82Y1FYQUx6WWxGcXJQZjQ3MGpDT3FISEdMWlFiUzJl?=
 =?utf-8?B?amtGVE1IdjduK2tVYUFWTTVKdVlia3RRVHdwNENRQWUzemFKaHNYQXY5Q3du?=
 =?utf-8?B?QkdZdWhKUnhGRFZaRURCdjltbVYyeUFIcklBbWVXbmNPdkdick5iajBCd1o1?=
 =?utf-8?B?Wmg2OTVKdEx3K2lxbElFSGM4YVg5b01YZmhyMjY5bjhTK05jK3A3aE5WeUFZ?=
 =?utf-8?B?ODhGUm1RYXdIaUdVQjd4OFNwWk16bHovUUt1dUtmUWVXZHhxZ1QzZGRNUFI5?=
 =?utf-8?B?bSt6RlBJbG1DWmpZanFOc0V5TkRMRlVUSzl4V3ErYm5PZVJPaXhHMlB5NlFS?=
 =?utf-8?B?RFBJMXhRNVlzOEVpMTJzMnBKM3lzSWY3NTNhUlBJTHNqTzdjSVVNYWhKc3FS?=
 =?utf-8?B?NE1iV1NiZ25EUkx5U1VzNkxRRGJVbWhna2lrempiVm5TSFVhY2RPTDBEMzFG?=
 =?utf-8?B?czAwTE01RXJlZ0E0TWdVQURoL0U2ZmdrY2VaN2dMUTlsSmM5VkRsUTdNbUhL?=
 =?utf-8?B?N2dIL2RONDhoM3FqNWRvNmtCd1BrQ3ZzTnZvWmttcFB4WVI1NGpuTHlWTnVh?=
 =?utf-8?B?NlU2WTZLQW9Jd3JUUElVZTZxSDFlMFNFcmhINXlqQ0lFbkFyZGhIcW5sa0Yw?=
 =?utf-8?B?QlpXUmEyR2VnZFdFaWxSS0sxRnpYbW5CdktoelMxdzBVeTVsNmdVYUUrTjBX?=
 =?utf-8?B?YU9nb3oxRGdmcnB0NGs4N2xHc0RGMGpvVmg5ZkxxKzg0TFZ2Q0tENEF1ZVJR?=
 =?utf-8?B?bWV4elZYM2tGanVta2ZleU1weE1YMGtoa1gxNXV1czFUd0lUc2VPMVFCV0I2?=
 =?utf-8?B?SHNGdkVhSm9DL2cwMmNHaGJtUHgrcjF0aVF0UVhBcWltaXBQUXNTeW0yeUc1?=
 =?utf-8?B?RHZGZkdQZ0VDRmdtekF3NDJnME1yeW84QWRhM1NidjVWOVJ2bWlyeUQxTi9K?=
 =?utf-8?B?U2N3dnlZeXgyYU9DbnpFZkVaNDlnSTAzQlFxeWdqRjdvczRyN1FJRXFpUzc2?=
 =?utf-8?B?VTNaS1I0RnRpQ1gzK3prTEFrMkRaMDVtTExZQUVMdDhpdmwrdHVPcHhSNWxJ?=
 =?utf-8?B?ekFIR0o4c2FUclhETkt1TkJSa0NOd2R5M3g5ZnlZZE10TmFyUHIzQVRRa09I?=
 =?utf-8?B?azkwbUNUL2poZWh0ODNiZmlUVS8xOEJQNXZDYktGMFF5dGxjbldjUm9ibm10?=
 =?utf-8?B?cEhobWl1ZjhBWTZCZmdNOTZFMXhKWWl6RHNNTFlST2JhTFd5VWVIVUtzVWc2?=
 =?utf-8?B?NmV2ZWNZN3JrWnc5a0hiMEdkbVVMVENZUkZzSmlEKzkxcDFCdXl5Y2Jiamls?=
 =?utf-8?B?WkozQndwRnVxVW42MVhSY2RrN2QzVis4cDZBWnFMT0VjdDMzajNxVERPa0VI?=
 =?utf-8?B?dW1RTFFMQVVHbVNnYzRkTG95a3FlU3g4MzlvM0dzcmtxOFVWOXpNZDRjc1Zt?=
 =?utf-8?B?RGVJVlZqNnZoV2M2SjhhQkpkYTV0dWJ2NHdGVmJvcmJhYitNZS9sT0ljRnpO?=
 =?utf-8?B?SEdGWnFlQTBaelhaN0UxdHpmMkZiVlNCUkRyakoyWGhicWZLK2NkM1NaWUZx?=
 =?utf-8?B?alc3amd4dnp6ekFCVjc1MTh2SkpQYXljTmh6dlVlcWYzTXhBZURmN2FEUWpp?=
 =?utf-8?B?T3JYeUxBcHMyc21Hbnd0UzNCN0FzVXkzakRpNDRXWWp3WkNYL2pmdmdIbDVW?=
 =?utf-8?B?VGhzZkk2NjVabEU4TGlPdUJ4QW1mQzlrQjZ1YVFHdGI5QnpqZWxtbEIxSElF?=
 =?utf-8?B?K0thRDZROUVKYk9pNnQ1d2FvNTVuQjlScGV4R2ZqUDJmZ3FyMGhSSFg1VEE1?=
 =?utf-8?B?QXlqa1k2ZmtKTjFydHI3ZG5iS2drLyt1VC9jdEd0VWRqSkoyTFpJVGNKbW5M?=
 =?utf-8?B?MFJhUElYVkpSeHEzS2xOVk4yRnlER3BReS9iNGlTdHJlZnpIU1hOeXRmUkF0?=
 =?utf-8?B?YXN5MjdqZmtBNHlGR094cXlhNlZsYU1EM0ROQTFFTGh6N1ZoV0xIMlNNYTZT?=
 =?utf-8?B?clUxZnRxOFlXZi9RWmpUejEycGdpVHQ2V3FpWVFoOHB2aVh3ZFcrejJWNC9x?=
 =?utf-8?Q?bMu8=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f0932a13-5e16-4cf0-f7e4-08de0db642bb
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 19:49:19.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+c5AUDSuVasdwz8lqn1WJE6SMYoOa6AN/UGpmzDgKp79AkrpUg+zbIJByFRuEy3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5048

On 17.10.25 07:42, Andrew Jeffery wrote:
> On Sat, 2025-10-11 at 13:21 +0200, Tan Siewert wrote:
>> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>> 64MB SPI flash.
>>
>> This mainboard exists in three known "flavors" which only differ in the
>> used host NIC, the BMC SPI size and some parts that may be un-populated.
>>
>> To keep the complexity low with the BMC SPI, use the 32MB layout
>> regardless of the used SPI or mainboard flavor.
>>
>> Signed-off-by: Tan Siewert <tan@siewert.io>
>> ---
>> v2:
>>    - fix led node names [robh]
>>    - fix missing gfx memory region and other offenses [Tan]
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 350 ++++++++++++++++++
>>   2 files changed, 351 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>> index 0f0b5b707654..c601af36915e 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-bmc-asrock-e3c256d4i.dtb \
>>   	aspeed-bmc-asrock-romed8hm3.dtb \
>>   	aspeed-bmc-asrock-spc621d8hm3.dtb \
>> +	aspeed-bmc-asrock-x470d4u.dtb \
>>   	aspeed-bmc-asrock-x570d4u.dtb \
>>   	aspeed-bmc-asus-x4tf.dtb \
>>   	aspeed-bmc-bytedance-g220a.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>> new file mode 100644
>> index 000000000000..e9804b0ace9f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/dts-v1/;
>> +
>> +#include "aspeed-g5.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +	model = "Asrock Rack X470D4U-series BMC";
>> +	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
>> +
>> +	aliases {
>> +		serial4 = &uart5;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart5;
>> +	};
>>
>>
> 
> *snip*
> 
>> nvmem-cell-names = "mac-address";
>> +};
>> +
>> +&mac1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_rmii2_default &pinctrl_mdio2_default>;
> 
> If you're using NCSI you don't need the MDIO pins here, right?

Right. Will be addressed with v3.

Thanks!
Tan

> 
>> +	use-ncsi;
>> +
>> +	nvmem-cells = <&eth1_macaddress>;
>> +	nvmem-cell-names = "mac-address";
>> +};
>> +
> 
> Andrew

