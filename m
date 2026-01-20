Return-Path: <linux-aspeed+bounces-3412-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D059D26293
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 19:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwclP6kGkz2xQB;
	Wed, 21 Jan 2026 06:26:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768937217;
	cv=pass; b=CEMkazTy2+AO0yr3ZIx7Bgzg5lkqlI7oftmclh4dxlYK0KpuVlqCoARhj8JBk6R/8AdJGJCWozubh3k/2oj7VCaKRimtJd47ebu0wt4L422i7L6PNNefQP/yc/UQLHNT7YyZJ1pgfX5F9VymwesUq1tmJLy2bIDLkcMfyxoJPqzjf1IzIUsfrD+b4tEP7007SipptphBhBYd65sRjerpug/tsZky/r6fGYXWJfJ0kTpk3jx4X/nXOqhSRQk2TLkZZ9lZX+TIHaTVqRbix1TZx57kpgdzm1n+A/EDuJNo+qQ5jNnQhRqcg0Pt9AfaNM2DdxKAqCSw4QVbPj3Ng+d0EQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768937217; c=relaxed/relaxed;
	bh=2f1LpzXVqH48h80OENrdu2gvC5SMs8IDMVgjviCdTOc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DL5eSfRyyKVggEJb4SaS+oXORAIO1F6PEcl5Ehc6vhQn/trm3vi8u41G0N1nx2mlk2THjk56dHYr8NLVqDyxC49JTi2nKy4h/vlva4+o8gzj6jDIRCv4DucfVPkfAw/UvM6yG/bMHTiYkswd/zT/ZifIcEZ4+CldgbR2GKyMFqnVW0cfPjbYQ8aNj2dl5VjNPU/dWxOu8RPYOzyBjCPhrMRm0u3tGUI2LRSzvKii5bBtAaNP5ZG3ra0ZuX52aX3pOJ4Oe1Mqz/5FmXhgRS0gxN8oGw21I7DgcJOR4/9jKhOrQswABT4dio6/6pMAo75lD89Cqeh6dgU8qIk6/HIaRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vi9RkDyF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vi9RkDyF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwclN2vBzz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 06:26:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAKzii3WC3FwwAcsFfiutDsvKJcTDLOflUP9eEI+nSiPO+2o6eYHYHlaWDKw32NxKrko0jAvljPGB+qsGd8x+uQYrx+AAtl6PJjmMOo8riaA/zItoEKx5bYwfmXVYELYtZHBjbrU/3IUj8oxbKrgdxICjXbrMGv8Gw5QERPFOLrJV4PCdqYt6bEeYYiiWCeZ+6OjHkmDMD8r2DdACmJuahigmqJYUB1XsdwgwDka6jRJ9HMTPEl4K6dBpFmhQGCSIW0wLEjK040vrCQWFdiKcEFXCBh7Pz/PJMFb+uRiYzxhSFmWeevzdnshqK28DWCLfQx8ifvowqNecF6U+nlSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f1LpzXVqH48h80OENrdu2gvC5SMs8IDMVgjviCdTOc=;
 b=xaitMS7uV9mdN0C45Jx9ZJ2YRtDT82/7Mz/YU7M4yVDW+/EUOWb9BbaHrkyYwwdAXzzwUw6RLp1oCFzRoxdX1tvI/jh5lo9QCemtCcza/PEByhKhCoXBnQqrDlqYEMRuG+L78B+d3S9HPv2gpq/+uCqp7RQS5HMMzc8mJODYc86avv8OZarlfX/YWwbkpFTv81Ol25jWLIvgvwDMETT3rxNxRQIQ5mAUaM3c43aCiqofUis2JsO+ganlNoycbiE9OKssJHXH7fvs3HO22HjpYF+L+15MXZ+5lr6EFz1tHeaPGrBE3lmLgEl8e0D3oJqR9PmtBgN73sPVCeWiCrzqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f1LpzXVqH48h80OENrdu2gvC5SMs8IDMVgjviCdTOc=;
 b=Vi9RkDyFFllZi8Yi1RJS42O2jgnY44bUS3qMAPyfibIR9jvwB84ChzicPmu+uVf/JZwFUQiWxNLfDoZcaxsC7i7d5/VKOVrkoT3ZWBuvpzCm+0qel3qp0uCt0zVRT+diLfKw+WETFXuT7vdT+nJ/XzjTTeY0DAeWRug8UZZ34tJxRs0HVXMwocLdXmIraGV4c1lfEiZVRJezeo+E85o1vzLOi2XqMzGeC8TJXDAz91YZa84suW0EKhbGQHiadBRShsXnanSkpGEQ2Yu+Mj6XrKfTRpWc4nL6UpvT7rc4cL6j9SOLhzq+SX7F21vOOaj6wAWpkfM9ov85taFBcr22gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DS0PR12MB8296.namprd12.prod.outlook.com
 (2603:10b6:8:f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 19:26:30 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 19:26:30 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v3 0/2] ARM: dts: aspeed: Add an alt 128M flash layout.
Date: Tue, 20 Jan 2026 11:26:15 -0800
Message-Id: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfWb2kC/2WOQQ6CMBBFr0K6tqYdIaWuvIdhUWiRSYBqWxoJ4
 e5WYpTEzOpN/n/5C/HGofHknC3EmYge7ZjgdMhI06nxZijqxAQYFBx4SVUfKIeScgmC6VLmpQC
 S0ndnWnxupmuVuHV2oKFzRu37/Nvv1WynQCOn6RhrC6GhbnJ1GSNqVMfGDh+tM48p7Qo/d4c+W
 DdvoyO8v//7IlCWxLmUitXC1HIvrtZ1fQFrQJbG+wAAAA==
X-Change-ID: 20251218-alt-128-19270d894872
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768937188; l=1880;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=4h61JRjNQRn83cZfE0bSIaL835Tlr9kAj9UH88khZqc=;
 b=kkizfmJWxLQhx2bBMIaAxAfRp3KhaY2jtLekS7K+e/zHwIHcOTvmMiUr0QcPDRrut3tu1UVpF
 QTfBqvPhDEeCYfLwyaSmsRnMIMXU1Cb3gV4p8SoTR2hLu9jHI/0h0W2
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a64730-b516-426d-7478-08de5859cffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJiUWxYek80Smh1KzNGd2QxdFNwZ3FEbUxVUDVUYUxYL2VLbThTdlIyNFpa?=
 =?utf-8?B?K3YrZE1OdnFKK1BrOG56ZFluVUY4TFYrTk1XWEtHVVZxNlkrUUFwWVd5VGVm?=
 =?utf-8?B?anRHUUV3QnBaeFlvY1FEVzBlOEczc1RKMUo3ZDM2alc4MTJLMDd5QVI5YlpX?=
 =?utf-8?B?N0JaNEZUZkhaWkdmZXVqS3ZReVJjQnptelVudDBVQkwxaVlzZlBnQzNJSkZT?=
 =?utf-8?B?UEh4TXBVQzgxYUFndHpLMGRRL21NVmIrRldOdVk0WXR5eWM1L1ZYSVFNVHFP?=
 =?utf-8?B?VmpGTHFyN005VjM3UGwyV0c5UVJWaFRkTDJjTGdIcUx3cDV1WEZwSzIvbVl5?=
 =?utf-8?B?RTdYWmdocUM0UjBXR09NZTRMU0VYL3FGWEphSmJmcEVjTHo0M0VsVElwd0lN?=
 =?utf-8?B?dmxZTStXMUlMUURZMTlpY0dGNC9JSVhlTHFsbENBelM3V3lPRjh6R3pTbDdh?=
 =?utf-8?B?K29BREJSbHR0bTk5M0JyY3VRVDV6dmgwWkw1VmJpRHRpc0xJSi9lZE1MR3lG?=
 =?utf-8?B?UVJSWHV1ZWZGNHdBZGV1R200L3g4c2NPdTdDUCtXQWRkUzc4QUx4bzBkUkFJ?=
 =?utf-8?B?YTdPNXBQOGZxWHY3bDg1OEpNbmtmWis5ZFJ4TDF1K1Jzd2swY2hoMy9IR2Ny?=
 =?utf-8?B?c3Rvckh0VnBnaHhOajBiK2U0M1JvczJ2UThDNXM0aWQ5ZTJSUWUxbHF3aHgr?=
 =?utf-8?B?T29xbUlkL0NPcUNFQ3pUZTl0OU1WS1BXMVczQjJnMnprMC9wUTBtZlIvZlJC?=
 =?utf-8?B?U3VjODNDMUtwcXpOU0J1RlNOb1U1eUtsNDg3MG56TGhVNklTS3NWTmtXYUJ4?=
 =?utf-8?B?MDgrYzI4Slcvd0k3dTlQRkFGeUlWTGprZHpJV2FaQ09UTUEvRkplVTZPbG1z?=
 =?utf-8?B?eHJqQkxkcDJlc3NqZWVkd2h5djlIOHNHWFF6emtBVHYvYnl5d3FMZnVnSTVF?=
 =?utf-8?B?N0NkRGN0di9UdEZhaW1uTTR2U0g5TGV3NUEvMUtIeXZKL2tIL2J6RUdvUW1X?=
 =?utf-8?B?cWd1S0xMejd2dUsrVVRObGZ2SmQ5M0FhTHZwTEFldWNsMThManBBWUpTYjAr?=
 =?utf-8?B?Q1ZxbE1yUS8reUdsZDR3bWxTWmNtcGw1QVhFRlhKK01ITHlEaEx3M2tWRyta?=
 =?utf-8?B?V3dUSVk2S0RWUU5iS0xZTDBrRXhWOTdmcG9WVlE2Vmd0SThSM0drMmlJZmkw?=
 =?utf-8?B?MG5aTGpZTC9SMUExOUFNdk52N0VmTTZUZlkvNTRDNGJxTm9MY3VjbnVCS1FK?=
 =?utf-8?B?bWZ0L3NDeDU3UFhVdGpYN1ZxTml4MjNpRXFEcTJZVHR6VXNNMkVwcW5DUmpt?=
 =?utf-8?B?YUNtMDZnVkRmSDdDWlZTWFFvMGFrSUd0ZS9ZR0NzbjZjTlpDeXVxZENHY2FQ?=
 =?utf-8?B?SEZaVE1wcVRjUGc2cTl2ZDNJcHpqdlhFSEpBNHlBQUg4cXRBZUlETEJrelhr?=
 =?utf-8?B?M24rZ0RsRFc2dVJhSWVYc0tCcDBrYnpqM3phRlVORTJqaGZGRCtwb1k1U3d5?=
 =?utf-8?B?Si9SNXVGTVZWSE1sUzJNQ1JZKzZvbWM0OVdQT0tqcEd4TU5OK1Z3dFRwRWxB?=
 =?utf-8?B?U042NWpoNGkrMDdiU2FBOE4wdWxPT1hVN1pWbVYzdFArZzdxSXM5RVhSNnhK?=
 =?utf-8?B?Um9hZWxaNzJHb2d4ZlZwemNjUDlZQ2pMejdBSGQ5Z09uVkNrQ1VUODZ1YUlE?=
 =?utf-8?B?NWlTa05tTW8zQnZTa2RVeUl5am1sV0p0eEg1NFd0b1ZEWGoyMDRTQjB4VTJJ?=
 =?utf-8?B?a3krcEk1K1dBRHFpb1VJUXZzT3htNjFjejI0NjRxU3VjRHREQm9weG5Ya0lX?=
 =?utf-8?B?aWE3VlpDbjZaNVBDTDBmcE5PY2x6TTA4NEtTSzNvU0VORGQ5eGRmNDk5czdO?=
 =?utf-8?B?MUwxZ1h3Y3dVcDNQZWRsdzQ4VG9xYVc4V2pYR0daQk9RM3dHU2cwYlFrRmdj?=
 =?utf-8?B?U05XRzFLdE41NmIwWDZLZ1pGSURiRmZoV0t5Ti9LRWNCNFNFVlNVNVRqSFdm?=
 =?utf-8?B?QW9EblNRVGNRTG9LcVJ5MHd6S2kzZE0yQzlVUTBKd1M1Wml4UjVLcjJpdXNo?=
 =?utf-8?B?S0t1bER3Z203OGowWjBJRG4rdjFJMG9qaEpGOFJkVG9hUnBTaGlxblFiNnFo?=
 =?utf-8?Q?i5ZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFibWR0OWVSOFlYM3JCVTh6RVBKZE5ud0lQY1ZMWHhrQVZxelR4ODJrWDdy?=
 =?utf-8?B?TTJPalVLMThtNGpxcklyS1luRTc4OFFqeUNPNFpDWnlJRStWZEhTOXlnTUEr?=
 =?utf-8?B?WDZRWW5ua1U3bEM0cC8rK1dmYVV3QVhOdkZLQjBUYmJDOXRyY0ticzNtRXBl?=
 =?utf-8?B?RHNBKzZqOTdiVGlhbGk5cWtidm9OQjdFZElOdENPMFBJT2VhMlgwMEMyUlNx?=
 =?utf-8?B?SVZ1ck03MWU2SEEySWZHcGc1dCtzNE1iQ0h3bVl5MGNlTGIwZEo1L25iaFR0?=
 =?utf-8?B?WHdJdUlIY2dsOXg1aGwvcVJMMG5rOGU4R0o1QitHd1hHRkRmdzZhellZYk1Z?=
 =?utf-8?B?TDFNc3NkQUl3U2F2V05qa2FuTzZ4YStsOUphWHV5Rlk2eW9SYnR0S2FSc21h?=
 =?utf-8?B?Tm9TamE0QmFEKzZMRUllcWZBRXF1dkY3M3Z0QU5lbDM3YTVZTlUwTVlTbmIy?=
 =?utf-8?B?WlZhcnNSVGFTOFU2RWpES1pONTExY1RMdVFJWGJ2M2pXSXU2WUl0SzE1OE9N?=
 =?utf-8?B?L0I5bk9tcWhUdzdybnM0TVd0eDJyUEVIUllyTFNSblJEa2MxMXJzZURzakxy?=
 =?utf-8?B?NEZVbkZNYWZXKzlPdHEwOTB5SWlLNXJyanVIeHBPZVVVSC8wNEtnNzJ3eXJq?=
 =?utf-8?B?MlRkTGozd2RnRnVjV0ZjNzlpUEI3cDVrWkpXRUEvOE9BTmEwL3IyRm9DV05r?=
 =?utf-8?B?N0c1MTcxMjhVbmZpWDUvNlhHOFFOQnVxS21aQW9SVnZVam5wTzBrbVJ2eHhn?=
 =?utf-8?B?alUybjFhV3VjcmFCQUFCVGlkSGNMT2ZDQko3NFA0Q2tMWjZYTGRLOUFUOEFO?=
 =?utf-8?B?MVA5cGJhOFdUU1BZNExiK2tiR2VsbjZPM0hmRjlMVFIrZjFSNWdLbjIvUEhG?=
 =?utf-8?B?SWMyZUtOTUE2dEdWSkhsY2tNY0R5clA0OWhkNDAzTW1iSkwyR2ZYanQ2b2V5?=
 =?utf-8?B?ZGFmdTJDS21zMkdhUUx4UFJGVHZINnB4S3lRVndDa1JIcW12ZGRSdUFmRHds?=
 =?utf-8?B?NnlCVFY2ZTR0MmoxWmkreVRnaDVxdnhMVzdVbDRpTk5kdlZvSEdsVE1xbDQ2?=
 =?utf-8?B?K2RUUWRZM1Q4ZlV5bXdYd0ZNckZSWWxvRnVjMEhaZUVUTlcrNVgvNDFqMVox?=
 =?utf-8?B?ZWExQlAwZjBQcmh6MFNnSEZkcSsycFJQSEVxdStIUWFyQ1F2MTI2VnJRWlgz?=
 =?utf-8?B?ZGFVcGhhMDNEMEVhakRqcHVCc3dpTkp0M1NNYmk3SWVQc1JiaTNaMjNYbFRn?=
 =?utf-8?B?MStYRjFWYjZ0NXBtbzVwWHEzeXZwZG5rWVZ5VXVkQW5uTlNYVkliRWMvN29l?=
 =?utf-8?B?UDUwRHZRMnJhN3ZOMkhHeTlLVjNkb1JMUC9DVXkwVEpuR2xJc0xSd3VOWUla?=
 =?utf-8?B?RVZFNXFMOTloa0kyYVZuUG5iUmZXWmtVYndlQ2ROTFhETk5WMDg3RFpaNm11?=
 =?utf-8?B?WXNQQjQ0OGpiQkpCNEFCeUhtazYxMkh0VklZVzBvVTZCQTNmMDhKeVE4c2dn?=
 =?utf-8?B?N0VjZEJXSVRUVUwxYnpSMENuSyszanNqbFU4VjFEaEhaazRhM0VVUWhzeFhq?=
 =?utf-8?B?aWZ6S1dUeCtnZVB1UXowRnVlT3dyakZhaE5kNlZUcnhQb2RUa08rYjNxSk1F?=
 =?utf-8?B?YU41RHQxVnR5ZUJsNUlhMHhTVGRuR3lKSVJxUHhvaFNmRElGdWlLTTRlNXZw?=
 =?utf-8?B?SFlIU05YaDh2MzRuVGFnUEg5MlNULzFwK2RFeFpnenFEV2NwcXZsTVk2R1N6?=
 =?utf-8?B?WXR2WFB3d2xJZGI4VHRmdlZvZHhlK2J0VTU4TDFzQ2l6QjNvV0FlbmlSRFRW?=
 =?utf-8?B?a1BiWDFmUWdzWkhVbVkrR3VaMlNEMVl2R1ZRUVRXWVArQXFDemRTdEhaTlVo?=
 =?utf-8?B?WDdKU3JoS0VBVk5neDYyK3NtWUIvZWJuZjBTUEhXU0VVVkRZK0xpTlhSRE8w?=
 =?utf-8?B?b0JFSHNWT2hjTDRkL2ZJQWlrYzBDay9TNE50aTJsU2NRRjFyYlR3bzlDQmly?=
 =?utf-8?B?ZE9XMVdHN0JtMW85S1FpK0NpVTB1bHVDejJkUUJDcHdNdVZQZENNNUlXVng3?=
 =?utf-8?B?NVU2bVVOa25FT1BTTEpXdjR3Z0R3eXg3WlNyMHVCSGtXc2pyL1RwcFBON0V6?=
 =?utf-8?B?clFOaUN5aml5eEttSTRKcFEvV1p0RVlKZ0dMa2tBR0lycU5pUkUzY3V0ZG1Y?=
 =?utf-8?B?VjdyZFVZODhwN2VaUDJFZzY4L3BDZHNFejhONmNZWU1kRktoNnhnTGQzN0VX?=
 =?utf-8?B?ZStBb1d4TWh1b21PQTAxMkI3OWFiZjMzUG5kTG9FalVlZW1pMkhhU1VHVDFt?=
 =?utf-8?B?K09WSUFkN3kzT0RYeEJjRFVUU1F5SEFUQzl2M2ZMRGk2V3ZLRUhldz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a64730-b516-426d-7478-08de5859cffd
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:26:30.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4je/qEWSPo2MopPMuzoLdTp79fIn9dFrNWfqfdQOR9RqDp3GSF0cpFS0VzDG4clwasYMFKNfK52ricH8Y+66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Add a layout for an alternate 128M flash layout. This is useful for the
aspeed ast2500[2] and ast2600[1] SoCs, where it has the ability to boot
from one of two spi chips, nominally the primary and backup SPIs. Adding
a layout allows userspace to flash the alternate spi by partition and
switch over to it, allowing lower downtime for firmware flash, or for
updating the primary flash from the golden backup flash. This is already
an established scheme for the 32M and 64M layouts, where the layout is
the same but each partition has `alt` prepended to its name. This allows
userspace to just prepend alt to the images in the update process to
specify which flash chip to update. This series also adds support for
the msx4 to use this layout.

References:

[1] https://www.aspeedtech.com/server_ast2600/
[2] https://www.aspeedtech.com/server_ast2500/

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Changes in v3:
- Reworded commit adding alt flash layout and fixed formatting issues
- Expanded testing section 
- Readded the Changes in v2 section, somehow they got lost
- Link to v2: https://lore.kernel.org/r/20251218-alt-128-v2-0-10499a0b7eb9@nvidia.com
Changes in v2:
- Retargetted series for the bmc tree
- Added a usage of the dtsi in the MSX4 device tree
- Link to v1: https://lore.kernel.org/all/20251211-alt-128-layout-v1-1-100f57d2bc4a@nvidia.com/

---
Marc Olberding (2):
      ARM: dts: aspeed: add an alt 128M flash layout
      ARM: dts: aspeed: Add alt partition support to msx4

 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts |  1 +
 .../dts/aspeed/openbmc-flash-layout-128-alt.dtsi   | 32 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: 459a5aa171c0f13fcd78faa9594dc4aa5a95770b
change-id: 20251218-alt-128-19270d894872

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


