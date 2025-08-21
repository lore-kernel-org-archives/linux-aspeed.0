Return-Path: <linux-aspeed+bounces-2010-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C04CA0EFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 01:33:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6m730qwjz30Nl;
	Thu, 21 Aug 2025 11:33:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2417::607" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755740015;
	cv=pass; b=YakTtfO0FS85NYzCQpEwXwpELWH+DOFktL5arb7qKAYHhGNTaSQiS40JTFLfJn1LIuaM47RiiVSkdIypKBRCuVJtigCXWIXh8y7+VJQEtGKVFeVNITQXxZKzMWEkXS6mBh8cbtNRgmQwZeR/NHUrYeLwTTaKYuujYvYun4O11SHK8lUe2QybNCoYz3YqW1ADl/tMH21MK2qx2sffqtdHVuxpSHl1O1M2zV8eJ2zp9MCvWFj8JTym7PeuNg6mXR5tu+fWM9U4D0ZMn0pGfo+Tn/pLkhihFLtLnmSNYf3/GYFAp16QRAXtbgS0+fSAl/Q+UPx47B4Lq6yBSzYuUdXj4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755740015; c=relaxed/relaxed;
	bh=WQ1meg2XpvJjS5FfPVflARBnxbpK5qUfhhfn/Yw+8ek=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MIHKomD5+VnV9WMtnsDGgiVUo48TCz+Uc6tbwyy8PqCe8P3mve5b0/HxuGiy3vHzCfuibQo0uBo7rGugs/qV/LZtZK8X34wJ4xbRlFjkfKhwryJ7Yze6kQVN54lfpiq+eyLYydmzDzt+vwVm4sPs+ROi1eAlWKQHUqkIupFEpPMjN3VpWlrG0HhFhd0Po+jMVBJzTyehlp7jKOpTcXt0bhbKrmpfRQvr3oTUM71UARkmE7FXL7yk3dSisfzshSOuSPcB6JZR3nXWHHO1lrGKJG8r+8mzcufO7PGt7qQpv1xT3L41HWmonsgwc5vy3u94WTDO8DoAhhpcQWG8+7LA8A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uthZNDq1; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2417::607; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uthZNDq1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2417::607; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20607.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::607])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6m720B00z2yGf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 11:33:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnC9yeUofafchbvOJXJYHaO59Ku9/u/TAaL7LvQK+pZZQq7L8UrUlc6e2yL8sCNoF2gUxWkiPcjrhkP9gJuQt+34FaIebPQJodi/zD1xk7d7/ZR34d7vrZEIO8orkICYZGSCcJr6dyd6a87pJANXJxnbztrqObomhxn+KfzfUMLpWlxJeF8a57SVv9LKlTvXNgN6XzNzrogssAmz/F2F0yFUptocOvXUpFbfAtkKjmBMz4uAX7ABySa+yn5VGkO9Re3Q83muxx4OYGeyY612GuVElgqGDgJ3dBytpatjrKtBv7eK5YldoyD2wBm7Cqqr85mcIqmxDOHlI3/53KZf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ1meg2XpvJjS5FfPVflARBnxbpK5qUfhhfn/Yw+8ek=;
 b=lsZgqr1JIwk+1jIszjKKxZE/kxbefj6bfveD2T3Q0vxc+gTKjZuEGpkcN0b8MrRzAtWYOayhsyyYDW/CFtwrUACTcli0gJG0yoLJrFg++ckAMlSIPGINDNcL468zz43nRjrOIvWmxDB5sOIiwzfMghbPIUff6iIFbed/7wVzqyLcfNjYIcQ9idrjk/HB4D958wesBkwVUK++UGgBtM3cQpGy771f4l4Y60sPsZDZcKBKD/ConUFLUJB5kyjkY4LrJTcFXONwqCnh2k5+yiH9BeHCo5K3+PxdjohH5tak6UEk2ovH75HPREaV/l14XBXcTGwQdve37Rd19o15e2q78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ1meg2XpvJjS5FfPVflARBnxbpK5qUfhhfn/Yw+8ek=;
 b=uthZNDq18UQCOmAYjmMj5mp0XJLkNSSppYCqoUg3qpXunZ8gkmbcCmPKqqxMk4eqJjczg+kQeAHlE8Jpls9ErQZkx2gIhZ8dsWNTcOmAktRslRRn0HkuYPxVQSTT6E42gMfMXvy+ZbSzt9zsi5XyYiShZ7EYY38OlgtMs3s5vDMWqJiZwD8abbZ4xjJ2jAlLXl9v9svo4aMOOBIJj+/Jnt2ySQh5kjYNC0HMnZT7PfV+qvk6D+/p4fegZ0iHCXFmgPezwa5S5iBatkHWv4TOpsFmcvNZ/WjuhnzbAT5XhSkEXHJYY2nCk7sJuVF8hVbAFTqv3eGNZznh8qQzlCi+Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667) by DS7PR12MB6213.namprd12.prod.outlook.com
 (2603:10b6:8:97::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:33:14 +0000
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da]) by DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da%5]) with mapi id 15.20.9031.014; Thu, 21 Aug 2025
 01:33:14 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Wed, 20 Aug 2025 18:32:52 -0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add device tree for mgx4u BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-mgx4u_devicetree-v2-2-ccd2831b29ac@nvidia.com>
References: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
In-Reply-To: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755739989; l=30553;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=PFRnuTaHAqJU3tzbHVGMzl8lbDJrZT9rNGh0o70Uo9o=;
 b=1P+vx0K7w9QDoT/MKZDBquf56RR+P35B84TPZrcYArf/H5S7Fi3Awv2aGdRJmCi8Jj6yNWNoq
 4kjP6XEnM0WDa7jcoJy7pW6l6VMc4jJg07T5+xqpjfSlKna0t5hh4v9
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:303:b8::10) To DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667)
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
X-MS-TrafficTypeDiagnostic: DS5PPFEAC589ED8:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ba2af9-8426-4b31-d8a0-08dde052b21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUZyZ1lkZUNLWjFlUVJJWHlXc3JDc3NxZ0hjZnBpb21teGF3cVE4NFBlMGRv?=
 =?utf-8?B?dFhSY1VrZU4yajNZZzFFMjQvNlpjbzRaQm5aQVZXcjdta1cvckRHTVFRc3cr?=
 =?utf-8?B?VjBIeWpCL0l1SzR6eitUTEE4ZlRaUVJBczUvWnRWd1hVejdEVlJhd1RDN3ZU?=
 =?utf-8?B?ckpRalZUMmVhSlVaMmkyMEo2Vm1CbmhFWlRCeFFoamtTNFYvQTA1Q2Zndk5V?=
 =?utf-8?B?RVZjSUtiTHdGNXVWMnRaWjlrbUxoeWhSMTlCa0lYek9jT0QvcGlXVldjMFBN?=
 =?utf-8?B?WnltQW5ySm4vbkY3ZERHRExtNEN2T1pXT0VGRXhYR2JGaEpXanp1azRJbFBq?=
 =?utf-8?B?aVdpdS9BcUIvbkhYbDN5UW5DN1FMY01henI3MUFPbE4xaGJoaGhUNGd0TzRx?=
 =?utf-8?B?aW03c3RDVmFianBtbGhBSzFucDVQN1JhSTNmeDJUVVNtMVFFcEFxb0w3Vm1y?=
 =?utf-8?B?NnhVU1Y2RDllREttNW4yWlIwTFA0bUhRMEp6RXh4QTArNEg4OVEvdGFvMkVX?=
 =?utf-8?B?SC9SVDVBZW9ZYVFLblFXYlZoMEplZDZ0Qk1XN1JuWE4rUmNLSFVnT0VuK3la?=
 =?utf-8?B?bklIdytmZVJBanArbUlNQXExclpaYklmS29ramF2MkQrM3FIc0ZNVVFxOUV6?=
 =?utf-8?B?ME0vMU9Ya2pwRElSWVhSVFM4dFd4amFSY0grUDJERXptejlBTE02SXhaSEpX?=
 =?utf-8?B?V2RHL2k0M0UwVVhadnZ0UXA5RUV2QlVaZHBxTmdxMnZjckpDRFVkSU8zQ0xR?=
 =?utf-8?B?UzFVTjMyTXUxQ0d1YzZpRENlcjNKTVdWa00yNUxnVjZuU0pWZmJ1S3g0YXpo?=
 =?utf-8?B?cmsycnVvU2xhcE03ajQ5VmE0eFpaVnNCTnNjaUhtcUwzLzRqUTdnOHl5SHRq?=
 =?utf-8?B?WXJUOU5WOGVrSGtXQWhRelBLTkdqdHZQRDd1eTNHWkVZalRWengzS05LbXNa?=
 =?utf-8?B?RXlJb3g3V2RYNndyUWM4alFBRnFDdkRuM2kxWDBaeWtBUHZ4SUxDMDYreGtO?=
 =?utf-8?B?Y1pRaHNUUHo2NW16Z2FUcklVb3ZNUnBoMWJ4OW14V2ZNZ1FPcGpTbGtXbkY2?=
 =?utf-8?B?V01BZlNPWks0V3BDUlBMZkFMZlYzNVFCZ0Q0MVdwRzNkZ1NXTDFOSURROUZD?=
 =?utf-8?B?Z0xiS25wZlV2azl1QVkwdUpRREVhNW1tVTlRYy9HSFArUmFvKzlQQUJqTlJE?=
 =?utf-8?B?NzdncE16a2xSTXRicUhZUE9jTUVxckQ5STVPdkwyTm5WNWN4L3p4bHd0Vzh2?=
 =?utf-8?B?QzkwQlBhUUc4aXBISEdmVUlzRXMzOGIwdkpORXZSdm9zN1A3Sm8zWXo4UE9w?=
 =?utf-8?B?Sm1VNnRvZDA1TEkyL0Z4SjNHeEFuelhVS05hWHk2QWlmOStobDllVTFuT25i?=
 =?utf-8?B?N1JoNWxObnV2bjdmVUl1cFlxK2dsYlRVdGJpeDhOVFZucE5sMXZFNXRiVHNM?=
 =?utf-8?B?U0RSUkVrdVdhbTdlanNpRlhWak1qd2tUOEs2SWtyalhFd2NtVnFVZERYUHla?=
 =?utf-8?B?cGE2bjVvZXZXWnBIcDZXMjd4bVdyQXVGR2xBZ2FtSTluZ01XNTdZdHJqM3hy?=
 =?utf-8?B?UFlhT0pqZ3BXZlBFQ24rZjVEN1JneGlZaUNISDFSWHhLQ2tiU0xNR25oSkZG?=
 =?utf-8?B?YzA4YVlaNFBXQUpZY1A4SDl2NWtNbTA3bVNZcXlOakVCaDdvYVc2SkFUU1Vz?=
 =?utf-8?B?d0R4blZET09iRDZMZXl5aU5qQnZjZ01jemlKTkdvbitXRFJmNWozZXRYTXp1?=
 =?utf-8?B?MmQ2clVvRHk0cStrcnhmWlZJNlhIYys0WGk4SEN5L2tjQUl1TDNYbGFMeE1w?=
 =?utf-8?B?dnJkRXBGSFQ2cnZnQkp5aUdtK3EzaWQvTkhNR2Irbm1ZdWYxcDQrZVNKY0Fo?=
 =?utf-8?B?cWtaand6VnZWOVpCR2ZMV1JrYWxoNnVDVVFjMGllNFRpeGlKanVITHA5b1N5?=
 =?utf-8?Q?3XsIhLDQ5X8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFEAC589ED8.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NjREp5RWhGL1BoQUNPRVF4M1U2YkEzWUY3c2VkTjFGSTJ4YzRNZzQ3R0FS?=
 =?utf-8?B?L05yUkFwa3gxYkp2VGl5RUgvSG04TEovQXgxeTBZeFl1dE9zbExQRlpRSkl6?=
 =?utf-8?B?TlhvcDhQdUluaXZHSTkwVlFyMkM1MzZrbnhWNHYrK1dsZHVKeXFRNzg1QVp3?=
 =?utf-8?B?ZExQSHVCTEloSGdiYUwzVEw0cURmaHFxN1dPMys0bjkzdFZaZ2FMdEhvYXRU?=
 =?utf-8?B?M2lza1VRc0xmSmNzRG9PbElPZm42NW82VWZCZU1oMXBIY01Wa0ZHRjFmL3l1?=
 =?utf-8?B?ZHJZU3hMQmtDUDIxbG05bTVUTTU2VEdMdEQ2RGFudXJwTTh1b0RJS2JuUUR6?=
 =?utf-8?B?aWI0aFYzbStobU53TE1VNUZmZWZubGZCUDBQRjlDZExmZWJqeE1lTzdaTm1m?=
 =?utf-8?B?OCtEcjhHRXlhaFFkOHhDRjZORVAvdFNicEFFR3VHc2dRR1lIT05VeFdoNUx5?=
 =?utf-8?B?NDIwbDdNdkdnZzFDZVhuREcvVFk3UkM0akc4MjhoSXZZaWRrSlZCaHBDWWdw?=
 =?utf-8?B?NW9NSGNNRXJFYmJ0ZUxhVWNTVXRaWU1JclBBMlpiajFtZFZrQkpUQWlvUEJN?=
 =?utf-8?B?QzZ3cVk1ODV6eS9zNjFKbVl1M3djYlMyT1FMR0FRVS9MN1JRTUJHWjZsNTly?=
 =?utf-8?B?MkFuNndVSHlBb3c1Y1ZCZmhQa1BlTC8xYU9odGdVWmhGNDFmbTZXcDM0QSsw?=
 =?utf-8?B?bVJCd0llV0lRTXhXcG1kOXlCYmtEb2ZPYTB2Z08wNkE0TW00Njk3SlJSanB2?=
 =?utf-8?B?V21BN1Q5MzFpUVFGMHRwN29ZWXRRVTB5clovVVByaG1EaWNJSFNQV0M0OFZC?=
 =?utf-8?B?eUlpWUFqSnJ1ODhmT1ppL05OWDdXOW04OWRFUHJvUFNQN1N1cHU2WHo4RStM?=
 =?utf-8?B?Z0IrRjdMZjFyU1ZUM1c2R2hKL1puTVZvMVJTRTU2MXBSS05HQW1XRzRnYVI3?=
 =?utf-8?B?bWZESkpRdTJPQ2Zuck1UZDI4L0QwbGkvSDI1ZzQ5WnNiazFyNkU1LzdodlNH?=
 =?utf-8?B?dUc5UFR3eG0wOWVlY2JFTWtlSCs0c3FZSDJrTXY5emZvOGN4dlpJTWgxL2J5?=
 =?utf-8?B?OTBaWXE4alFCSmF5REEwdkgrRzk3ZGVydnRsYXZ6K1U4NEljTmY2MjhEN3Zz?=
 =?utf-8?B?eU5zVXRrWGhPUk1xeDlDSHJVVjRMZjNjTVNVZ3FIbWtRWU5xS2lrb1hEK2Zn?=
 =?utf-8?B?R0Uvd0Jxby9oU3dsYXg5VThabUM0NmhLQWowVVdOUjJjMjhFdXpYNDA2M1F3?=
 =?utf-8?B?eGFocHdlaSs4LzUycXZjeXFBOFI4M3J2YWU2c1NMR0dNUExiSUpJY1V0WFVH?=
 =?utf-8?B?NjFtaVdXQThrOUptdExsSDEwR2QybjNIL25uaTk4dFVkTGVmYUZMRmxJaXNN?=
 =?utf-8?B?L1dxbTU0NUxDeDJ6S1QzVkhVSWUvR3ZIQ1BjVC9zc0VZM214VmRxWXFVU2lp?=
 =?utf-8?B?QXgwbkR6enFCNzBwZ05kbzdXUHU5VVJib0MxMlM0OTNiY3d0cncwd1BHRlZu?=
 =?utf-8?B?bk92L0VEckhiZkhaeElrWjVQQXRiMGsxZnR4ckVHcHpFWmltY3l0eFNyUFVO?=
 =?utf-8?B?L2JIQndDSlRMUHpEZE1nWitkVEUvb0x5KyswUEptbHVHb0ltRTM5T0loQml2?=
 =?utf-8?B?UFFnYjg4bWk0ODRWdE9yeTllR1l4WUtpd0h2SnpvbmZpdG0wK0JkVmZGT1lr?=
 =?utf-8?B?d3prV2F0c0lvM3B0OE5sbVFjSmhwVGZyNWlzYmdsME1wZy9PRlpjV3ViZTQz?=
 =?utf-8?B?YzJab3NQYTM4Z2JmMVM0M09kMUxQSk5ES1o2azZ6amFlQ1J3VFNFYUUrdE50?=
 =?utf-8?B?NjhvREhkczdsT2lDME9IWjRGS1haankza0UwOEoxRm1DQWxZQkhuekhKa1hW?=
 =?utf-8?B?SGNSWWttTVJyVG9xejd5anh4eksyRjgwQld3WnNUYjV2QU80dE0yTTl4Y0lo?=
 =?utf-8?B?M3FEdGJKYWdGbHozcXhhTFE1eld4eXdOS3hzKy9nRFdhRC93UDFmanVoSmxT?=
 =?utf-8?B?VTk1MzJlV0RVRHJ2dENOOWVYMENrTHZWRzAxZkxYNzdyYXllenhhL3QxRytI?=
 =?utf-8?B?M2VISnJSZUU5cjhyQWtDZll5QTZNNEpSQzBXVEJvTFZHTldaM0hPdkhmdmQ4?=
 =?utf-8?Q?nEFmeR8nJG3HLSuUSK2bT2u0o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ba2af9-8426-4b31-d8a0-08dde052b21b
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFEAC589ED8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:33:13.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5+oNf/2ucqPmTmWEyr5bTeOUFrPHFFHLlzbbhpZ5Yf2J4GoiCmxi3H2DSOQbquT65O2/YkDU2DdUJymJpsnaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

The mgx4u is a BMC for a granite rapids based motherboard
that connects to a cx8 switchboard.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1452 ++++++++++++++++++++
 2 files changed, 1453 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index aba7451ab749f4938aa56ffe332a94e04a55eb52..14901843780b860e85db64023e4d1b1c59892025 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-mgx4u.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts
new file mode 100644
index 0000000000000000000000000000000000000000..77ab84b0a64fb89494f6af0a1600012e558f54e3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts
@@ -0,0 +1,1452 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "MGX4U";
+	compatible = "nvidia,mgx4u", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+
+		i2c16 = &i2c5_mux_0;
+		i2c17 = &i2c5_mux_1;
+		i2c18 = &i2c5_mux_2;
+		i2c19 = &i2c5_mux_3;
+		i2c20 = &i2c5_mux_4;
+		i2c21 = &i2c5_mux_5;
+		i2c22 = &i2c5_mux_6;
+		i2c23 = &i2c5_mux_7;
+
+		i2c24 = &i2c6_mux_0;
+		i2c25 = &i2c6_mux_1;
+		i2c26 = &i2c6_mux_2;
+		i2c27 = &i2c6_mux_3;
+		i2c28 = &i2c6_mux_4;
+		i2c29 = &i2c6_mux_5;
+		i2c30 = &i2c6_mux_6;
+		i2c31 = &i2c6_mux_7;
+
+		i2c32 = &i2c7_1_mux_0;
+		i2c33 = &i2c7_1_mux_1;
+		i2c35 = &i2c7_1_mux_2;
+		i2c36 = &i2c7_1_mux_3;
+		i2c37 = &i2c7_mux_0;
+		i2c38 = &i2c7_mux_1;
+		i2c39 = &i2c7_mux_2;
+		i2c40 = &i2c7_mux_3;
+		i2c41 = &i2c7_mux_4;
+		i2c42 = &i2c7_mux_5;
+		i2c43 = &i2c7_mux_6;
+		i2c44 = &i2c7_mux_7;
+
+		i2c45 = &i2c0_mux_0;
+		i2c46 = &i2c0_mux_1;
+		i2c47 = &i2c0_mux_2;
+		i2c48 = &i2c0_mux_3;
+		i2c49 = &i2c0_mux_4;
+		i2c50 = &i2c0_mux_5;
+		i2c51 = &i2c0_mux_6;
+		i2c52 = &i2c0_mux_7;
+
+		i2c53 = &i2c0_1_mux_0;
+		i2c54 = &i2c0_1_mux_1;
+		i2c55 = &i2c0_1_mux_2;
+		i2c56 = &i2c0_1_mux_3;
+		i2c57 = &i2c0_1_mux_4;
+		i2c58 = &i2c0_1_mux_5;
+		i2c59 = &i2c0_1_mux_6;
+		i2c60 = &i2c0_1_mux_7;
+
+		i2c61 = &i2c3_mux_6;
+		i2c62 = &i2c3_mux_7;
+
+		i2c63 = &i2c9_mux_0;
+		i2c64 = &i2c9_mux_1;
+		i2c65 = &i2c9_mux_2;
+		i2c66 = &i2c9_mux_3;
+		i2c67 = &i2c9_mux_4;
+		i2c68 = &i2c9_mux_5;
+		i2c69 = &i2c9_mux_6;
+		i2c70 = &i2c9_mux_7;
+
+		i2c71 = &i2c9_mux_6_2;
+		i2c72 = &i2c9_mux_6_3;
+		i2c73 = &i2c9_mux_7_2;
+		i2c74 = &i2c9_mux_7_3;
+		i2c75 = &i2c10_mux_6_2;
+		i2c76 = &i2c10_mux_6_3;
+		i2c77 = &i2c10_mux_7_2;
+		i2c78 = &i2c10_mux_7_3;
+	};
+
+	chosen {
+		stdout-path = "uart3:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	non-removable;
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	clk-phase-mmc-hs200 = <9>, <225>;
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/ "","","","","","","","",
+	/*B0-B7*/ "","","","","","","","RST_BMC_8211F_N",
+	/*C0-C7*/ "","","","","","","","",
+	/*D0-D7*/ "","","","","","","","",
+	/*E0-E7*/ "","","","","","","","",
+	/*F0-F7*/ "","RST_BIOSROM_1_BMC_N","","RST_SPI_PFRM1_R_N","","","SPI_BIOS_MUX_SEL","",
+	/*G0-G7*/ "","","","","","","","",
+	/*H0-H7*/ "","","","","","","","",
+	/*I0-I7*/ "","","","","","","","",
+	/*J0-J7*/ "","","","","","","","",
+	/*K0-K7*/ "","","","","","","","",
+	/*L0-L7*/ "","","","","","","","",
+	/*M0-M7*/ "","","","","","","","",
+	/*N0-N7*/ "","","","","","","","",
+	/*O0-O7*/ "","","","","","","","",
+	/*P0-P7*/ "","","","","","","","",
+	/*Q0-Q7*/ "","","","","","","","",
+	/*R0-R7*/ "","","","","","","","",
+	/*S0-S7*/ "","","","","","","","",
+	/*T0-T7*/ "","","","","","","","",
+	/*U0-U7*/ "","","","","","","","",
+	/*V0-V7*/ "","","SCM_HPM_STBY_RST_N","","SCM_HPM_STBY_EN","","","",
+	/*W0-W7*/ "","","","","","","","",
+	/*X0-X7*/ "","","","","","","","",
+	/*Y0-Y7*/ "","","","","","","","",
+	/*Z0-Z7*/ "","","","","","","","";
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","SW_MAIN_EN","HOST_GLOBAL_WP_N","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9548";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c0_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@51 {
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+
+		i2c0_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@4c {
+				compatible = "ti,tmp75";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c0_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0_1_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9548";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c3_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-mux@70 {
+		reg = <0x70>;
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c6_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@4a {
+				compatible = "ti,tmp75";
+				reg = <0x4a>;
+			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+				pagesize = <32>;
+			};
+		};
+
+		i2c6_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/*fan controller 0*/
+			fan-controller@20 {
+				compatible = "maxim,max31790";
+				reg = <0x20>;
+			};
+
+			/*fan controller 1*/
+			fan-controller@21 {
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+
+			hpmfanio: gpio@27 {
+				compatible = "nxp,pca9555";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <11 0>;
+				gpio-line-names =
+						"HPM_FAN1_INSTALL", "HPM_FAN2_INSTALL",
+						"HPM_FAN3_INSTALL", "HPM_FAN4_INSTALL",
+						"HPM_FAN5_INSTALL", "",
+						"","";
+			};
+		 };
+
+		 i2c6_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		 };
+
+		 i2c6_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4056 fan board_EEPROM*/
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+
+			/*fan controller 0*/
+			fan-controller@20 {
+				compatible = "maxim,max31790";
+				reg = <0x20>;
+			};
+			/*fan controller 1*/
+			fan-controller@21 {
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+
+			gpufanio: gpio@27 {
+				compatible = "nxp,pca9555";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <11 0>;
+				gpio-line-names =
+						"GPU_FAN1_INSTALL", "GPU_FAN2_INSTALL",
+						"GPU_FAN3_INSTALL", "GPU_FAN4_INSTALL",
+						"GPU_FAN5_INSTALL", "",
+						"","";
+			};
+		 };
+
+		i2c6_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* IO board EEPROM*/
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+		};
+
+		i2c6_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c6_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c6_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c7 {
+	multi-master;
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c7_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@71 {
+				compatible = "nxp,pca9545";
+				reg = <0x71>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c7_1_mux_0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c7_1_mux_1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					eeprom@55 {
+						compatible = "atmel,24c64";
+						reg = <0x55>;
+						pagesize = <32>;
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c02";
+						reg = <0x50>;
+						pagesize = <32>;
+					};
+
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+						pagesize = <32>;
+					};
+				};
+
+				i2c7_1_mux_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c7_1_mux_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
+		i2c7_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* XDPE19284B - CPU0 PVCCIN VR */
+			regulator@60 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x60>;
+			};
+
+			/* XDPE19284B - CPU0 PVCCFA EHV FIVRA / PVCCINF_VR*/
+			regulator@62 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x62>;
+			};
+
+			/* XDPE19284B - CPU0 PVCCA EHV PVCCIN VR */
+			regulator@74 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x74>;
+			};
+
+			/* XDPE19284B - CPU0 PVVCCD0 & D1 VR */
+			regulator@76 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x76>;
+			};
+		};
+
+		i2c7_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* XDPE19284B - CPU1 PVCCIN VR */
+			regulator@60 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x60>;
+			};
+
+			/* XDPE19284B - CPU1 PVCCFA EHV FIVRA / PVCCINF_VR*/
+			regulator@62 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x62>;
+			};
+
+			/* XDPE19284B - CPU1 PVCCA EHV PVCCIN VR */
+			regulator@74 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x74>;
+			};
+
+			/* XDPE19284B - CPU1 PVVCCD0 & D1 VR */
+			regulator@76 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x76>;
+			};
+		};
+
+		i2c7_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c9_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c9_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@26 {
+				compatible = "nxp,pca9555";
+				reg = <0x26>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names = "WP_QSPI_CX0", "RST_SEQ_CX0_L",
+						  "BOOT_COMPLT_CX0", "FNP_CX0_L",
+						  "WP_FRU_CX0", "OVT_SHUTDOWN_CX0",
+						  "", "",
+						  "", "",
+						  "TMP_WARNING_CX0", "USB_HUB1_RST_L",
+						  "I2C_SWITCH1_RESET", "MCU1_GPIO",
+						  "MCU1_RST_N", "MCU1_RECOVERY_N";
+
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c9_mux_6_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_0",
+								  "OOB_RST_N_0",
+								  "OOB_RECOVERY_0",
+								  "MCU_RECOVERY_N_0",
+								  "MCU_RST_N_0",
+								  "MCU_BYPASS_N_0",
+								  "SMBUS_FRU_EEPROM_WP_0",
+								  "";
+					};
+
+					eeprom@50 {
+						reg = <0x50>;
+						compatible = "atmel,24c128";
+					};
+				};
+
+				i2c9_mux_6_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_1",
+								  "OOB_RST_N_1",
+								  "OOB_RECOVERY_1",
+								  "MCU_RECOVERY_N_1",
+								  "MCU_RST_N_1",
+								  "MCU_BYPASS_N_1",
+								  "SMBUS_FRU_EEPROM_WP_1",
+								  "";
+					};
+
+					eeprom@50 {
+						reg = <0x50>;
+						compatible = "atmel,24c128";
+					};
+				};
+			};
+		};
+
+		i2c9_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@26 {
+				compatible = "nxp,pca9555";
+				reg = <0x26>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names = "WP_QSPI_CX1", "RST_SEQ_CX1_L",
+						  "BOOT_CMPLT_CX1", "FNP_CX1_L",
+						  "WP_FRU_CX1", "OVT_SHUTDOWN_CX1",
+						  "TMP_WARNING_CX1", "USB_HUB2_RST_L",
+						  "I2C_SWITCH2_RESET", "",
+						  "", "",
+						  "", "",
+						  "", "";
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c9_mux_7_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_2",
+								  "OOB_RST_N_2",
+								  "OOB_RECOVERY_2",
+								  "MCU_RECOVERY_N_2",
+								  "MCU_RST_N_2",
+								  "MCU_BYPASS_N_2",
+								  "SMBUS_FRU_EEPROM_WP_2",
+								  "";
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c128";
+						reg = <0x50>;
+					};
+				};
+
+				i2c9_mux_7_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_3",
+								  "OOB_RST_N_3",
+								  "OOB_RECOVERY_3",
+								  "MCU_RECOVERY_N_3",
+								  "MCU_RST_N_3",
+								  "MCU_BYPASS_N_3",
+								  "SMBUS_FRU_EEPROM_WP_3",
+								  "";
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c128";
+						reg = <0x50>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@26 {
+				compatible = "nxp,pca9555";
+				reg = <0x26>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names = "WP_QSPI_CX2", "RST_SEQ_CX2_L",
+						  "BOOT_COMPLT_CX2", "FNP_CX2_L",
+						  "WP_FRU_CX2", "OVT_SHUTDOWN_CX2",
+						  "", "",
+						  "", "",
+						  "TMP_WARNING_CX2", "USB_HUB3_RST_L",
+						  "I2C_SWITCH3_RESET", "MCU2_GPIO",
+						  "MCU2_RST_N", "MCU2_RECOVERY_N";
+
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c10_mux_6_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_4",
+								  "OOB_RST_N_4",
+								  "OOB_RECOVERY_4",
+								  "MCU_RECOVERY_N_4",
+								  "MCU_RST_N_4",
+								  "MCU_BYPASS_N_4",
+								  "SMBUS_FRU_EEPROM_WP_4",
+								  "";
+					};
+
+					eeprom@50 {
+						reg = <0x50>;
+						compatible = "atmel,24c128";
+					};
+				};
+
+				i2c10_mux_6_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_5",
+								  "OOB_RST_N_5",
+								  "OOB_RECOVERY_5",
+								  "MCU_RECOVERY_N_5",
+								  "MCU_RST_N_5",
+								  "MCU_BYPASS_N_5",
+								  "SMBUS_FRU_EEPROM_WP_5",
+								  "";
+					};
+
+					eeprom@50 {
+						reg = <0x50>;
+						compatible = "atmel,24c128";
+					};
+				};
+			};
+
+		};
+
+		i2c10_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+
+			gpio@26 {
+				compatible = "nxp,pca9555";
+				reg = <0x26>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names = "WP_QSPI_CX3", "RST_SEQ_CX3_L",
+						  "BOOT_CMPLT_CX3", "FNP_CX3_L",
+						  "WP_FRU_CX3", "OVT_SHUTDOWN_CX3",
+						  "TMP_WARNING_CX3", "USB_HUB4_RST_L",
+						  "I2C_SWITCH4_RESET", "",
+						  "", "",
+						  "", "",
+						  "", "";
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c10_mux_7_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_6",
+								  "OOB_RST_N_6",
+								  "OOB_RECOVERY_6",
+								  "MCU_RECOVERY_N_6",
+								  "MCU_RST_N_6",
+								  "MCU_BYPASS_N_6",
+								  "SMBUS_FRU_EEPROM_WP_6",
+								  "";
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c128";
+						reg = <0x50>;
+					};
+				};
+
+				i2c10_mux_7_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					gpio@20 {
+						reg = <0x20>;
+						gpio-controller;
+						compatible = "nxp,pca6408";
+						#gpio-cells = <2>;
+						gpio-line-names = "GLOBAL_WP_7",
+								  "OOB_RST_N_7",
+								  "OOB_RECOVERY_7",
+								  "MCU_RECOVERY_N_7",
+								  "MCU_RST_N_7",
+								  "MCU_BYPASS_N_7",
+								  "SMBUS_FRU_EEPROM_WP_7",
+								  "";
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c128";
+						reg = <0x50>;
+					};
+				};
+			};
+
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac2 {
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+	status = "okay";
+};
+
+&mac3 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+	status = "okay";
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	gpio-line-names =
+		"","LED_PORT80_0_N",
+		"","LED_PORT80_1_N",
+		"","LED_PORT80_2_N",
+		"","LED_PORT80_3_N",
+		"","LED_PORT80_4_N",
+		"","LED_PORT80_5_N",
+		"","LED_PORT80_6_N",
+		"","LED_PORT80_7_N",
+		"","CPLD_JTAG_OE_R_N",
+		"","RST_PE_SLOT_I2C_MUX_N",
+		"","ASSERT_CPU0_PROCHOT_N",
+		"","ASSERT_CPU1_PROCHOT_N",
+		"","BMC_CPU0_NMI_OUT_N",
+		"","BMC_CPU1_NMI_OUT_N",
+		"","CPLD_PWRBRK_N",
+		"","SPD_SWITCH_CTRL_N",
+		"","COM_DBG_MODE",
+		"","RST_CPU0_RTCRST_PLD","",
+		"EN_MON_VBAT","","BMC_RST_BTN_OUT",
+		"","BMC_PWR_BTN_OUT",
+		"","BMC_WAKE",
+		"","CPU_FRBK_OUT",
+		"","CPU0_BMC_INIT",
+		"","CPU1_BMC_INIT",
+		"","NCSI_BMC_CLK_EN",
+		"","NCSI_OCP_CLK_EN",
+		"","IRQ_CPU0_TPM",
+		"","UART_HPM_MUX",
+		"","DEBUG_BIT_0","","DEBUG_BIT_1",
+		"","DEBUG_BIT_2",
+		"FAN_4056_BOARD_ID_0","DEBUG_BIT_3",
+		"FAN_4056_BOARD_ID_1","DEBUG_BIT_4",
+		"FAN_4056_BOARD_ID_2","DEBUG_BIT_5",
+		"FAN_4056_BOARD_ID_3","DEBUG_BIT_6",
+		"FAN_8080_BOARD_ID_0","DEBUG_BIT_7",
+		"FAN_8080_BOARD_ID_1","LED_BMC_HBLED_CPLD_N",
+		"FAN_8080_BOARD_ID_2","LED_SYS_ALERT_CPLD",
+		"FAN_8080_BOARD_ID_3","LED_PWR_YEL_CPLD",
+		"FAN1_FRONT_TOP_INSTALL","",
+		"FAN2_FRONT_TOP_INSTALL","",
+		"FAN3_FRONT_TOP_INSTALL","",
+		"FAN4_FRONT_TOP_INSTALL","",
+		"FAN5_FRONT_TOP_INSTALL","",
+		"","",
+		"","",
+		"","",
+		"FAN9_REAR_INSTALL","",
+		"FAN_FRONT_SW0_FAIL","",
+		"FAN_REAR_SW0_FAIL","",
+		"FAN1_FRONT_BOT_INSTALL","",
+		"FAN2_FRONT_BOT_INSTALL","LED_UID_N",
+		"FAN3_FRONT_BOT_INSTALL","",
+		"FAN4_FRONT_BOT_INSTALL","",
+		"FAN5_FRONT_BOT_INSTALL","SPI_MUX3_EN",
+		"FAN1_REAR_INSTALL","SPI_MUX2_EN",
+		"FAN2_REAR_INSTALL","SPI_MUX1_EN",
+		"FAN3_REAR_INSTALL","SPI_MUX3_SEL",
+		"FAN4_REAR_INSTALL","SPI_MUX2_SEL",
+		"FAN5_REAR_INSTALL","SPI_MUX1_SEL",
+		"FAN6_REAR_INSTALL","PDB_RST",
+		"FAN7_REAR_INSTALL","PRE_STANDBY_DROP",
+		"FAN8_REAR_INSTALL","",
+		"MLB_BRD_SKU_ID0","",
+		"MLB_BRD_SKU_ID1","",
+		"MLB_BRD_SKU_ID2","",
+		"MLB_BRD_SKU_ID3","",
+		"MLB_BRD_REV_ID0","",
+		"MLB_BRD_REV_ID1","",
+		"M2_1_PRESENT","",
+		"M2_2_PRESENT","",
+		"M2_1_ALERT","",
+		"PASSWORD_CLEAR","",
+		"IRQ_PSYS_CRIT","",
+		"LEAKAGE_MONITOR_ALERT","",
+		"M2_2_ALERT","",
+		"RST_BTN","",
+		"PWR_BTN","",
+		"","",
+		"CPU1_MEM_VRHOT","",
+		"CPU0_MEM_VRHOT","",
+		"CPU1_VRHOT","",
+		"CPU0_VRHOT","",
+		"RST_PLTRST_MONITOR","",
+		"CPU_SLP_S3","",
+		"TPM_PRSNT","",
+		"HPM_HMC_PCIE_PERST","",
+		"CPU1_THERMTRIP","",
+		"CPU0_THERMTRIP","",
+		"CPU1_PROCHOT_CPLD","",
+		"CPU0_PROCHOT_CPLD","",
+		"CPU1_MEMTRIP","",
+		"CPU0_MEMTRIP","",
+		"CPU0_MEMHOT","",
+		"CPU1_MEMHOT","",
+		"CPU_ERR2","",
+		"CPU_ERR1","",
+		"CPU_ERR0","",
+		"CPU_CATERR","",
+		"CPU_RMCA","",
+		"","",
+		"CPU1_MON_FAIL","",
+		"CPU0_MON_FAIL","",
+		"PUS4_PRSNT_N","",
+		"PUS5_PRSNT_N","",
+		"PUS6_PRSNT_N","",
+		"PUS7_PRSNT_N","",
+		"PUS8_PRSNT_N","",
+		"PUS9_PRSNT_N","",
+		"PUS10_PRSNT_N","",
+		"PUS11_PRSNT_N","",
+		"PWRGD_CPU1_S0_PWROK","",
+		"PWRGD_CPU0_S0_PWROK","",
+		"","",
+		"PSU_SMBUS_ALERT_N","",
+		"PSU0_PRSNT_N","",
+		"PSU1_PRSNT_N","",
+		"PUS2_PRSNT_N","",
+		"PUS3_PRSNT_N","",
+		"CPU0_PRSNT_N","",
+		"CPU1_PRSNT_N","",
+		"CPU0_PWR_GOOD","",
+		"CPU1_PWR_GOOD","",
+		"PGD_SYS_PWROK","",
+		"BIOS_POST_CMPLT_N","",
+		"CPU0_CD_INIT_ERROR","",
+		"CPU1_CD_INIT_ERROR","";
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	fmc-spi-user-mode;
+	status = "okay";
+
+	flash@0 {
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <2>;
+		status = "okay";
+	};
+};
+
+&syscon {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};
+

-- 
2.34.1


