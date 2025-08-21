Return-Path: <linux-aspeed+bounces-2008-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A197CA0EDC
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 01:33:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6m710gTdz3091;
	Thu, 21 Aug 2025 11:33:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2418::60d" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755740013;
	cv=pass; b=CXV4DcZajhRVal5lhH6Z7463Spthr3nSiu+ZRkcsYrnI/jx+I6i0Ez144KiXfhmYg2FU8dq5Z1ikkXc/bMV5k1jgq8hjAZmSOutAPz5Nqg+6t0jEtDrRJDOBzgkzwb7kK4HCUzqPuIdfmd5vox8BiY1vPJswN/Ed9JlyAZhAfwxZha83AoRCs8GrQ1lWlP4K2Mfci17M5A8kp82e2BAzis9/YkB2nS5Wim8s/AICMeBY8ItZIlrcX1JsIUPg5wJthvtF/Uc41bGLKvY6b3/gv/XpoLqRz7BNMd+BzKuk09O9oWyhbdKEWVhuY/134AFKvNJRWgftCeO0JapXIGVyLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755740013; c=relaxed/relaxed;
	bh=rBoBoUG1r6ueyCnwBGxtAXmpf0EkMXCa1pKPW8+7OpE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bk3Toj/OE+zIid2Az6jfdnMRItUyYbatRzhfLtsMDjjywdLtOdmaKAJPP2TUOW0owbq6J92RftckBpISOqccIffij3FtPHV4Vlku09vmzgcdLKeNKLmKnIfg8IPlXmc/GP9uA6OJjAClvjr3HxhXRZ2KJ/yheWwL6DUaqctCPAO6oOZZiSj25/YNI41KjdD/xUfqk5oLbtdcMV3LB8QRdM45AwvsfIbMI10Bah7iInjmnjV9gGzxAB7F8qvX8o8py0kx6uzXmCWwMW4lYdaRkVd7e7CQY7aP2ZI+9YVYvak+XaFbLOEH2U7ZSRXtJcTPwRpeI4euPZNlCaoknBrmpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QqL72jok; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2418::60d; helo=nam12-bn8-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QqL72jok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2418::60d; helo=nam12-bn8-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2418::60d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6m6z74z7z2yGf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 11:33:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbzEfVAUM+1MhFTHB/okyOjlqp3o0WuD2oTvcffzf5NokNMQaGAfsfUkKJg9Am6nkAiGD1LOcu1VymYdA8vQOrxkjFn5XXvK339z33cSQwq/3jKB1E8nUFMztkLv3uxu3GeHmkVDOH8eH/R+nGgRYvhHCXp4Tk+01XyeSejHJWii89ioU5jt3UqA5AyRx9rhsOthYmVq+kAeFvx8Chh/O0ZIUJxiT5xB6lqO18EnkfbA5gDLwwf8sPSMmY9JP+IBr9vzHx/qoXPpyKMOl6uveUONNzA+avE8p+yucF3/J89TCv7ILCTBygkNknT1sBhZxLGIKg7Fwb3T7g2ipavtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBoBoUG1r6ueyCnwBGxtAXmpf0EkMXCa1pKPW8+7OpE=;
 b=O1rDA0hI8j2ew/n1S28O7jqAoGgB1GtPZDcJuYbdE5I0QUcctZZKxJot3wZlxmaBUyBXIhban4xlmRbp3yilzAhc9ypFfFP/tYW1nn/TCZlXjPBsR6wtuKJE3YFLTeeqdNpbkRpWXONI6BV4W2kwerPV8hihuQKGUWANv2fKyAoITyooTReXM1PE3WU8FCVgbI2H9+A0sehXworoVW/YcWDV57I8eHYssg6tNdUhrHzUZ06ww57KVOeiXenARn9TM2kcENsEhQXBw0v4+NxUmbr5Y00SEchn5qvdhe8XI2AC5Hh7v39e8eCo15ukYDLtRiOT7OKdl5/fya4pShPA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBoBoUG1r6ueyCnwBGxtAXmpf0EkMXCa1pKPW8+7OpE=;
 b=QqL72jokY5CMQz76Xra+pG9KnYsZ5F6/38Ye/TNBSNISYVCLi9lEo076mLoa0hC/QJD61FrwwZzNHT7nT/J6Ysbj+bo4K9AZecNdKnEilB0FDyxBQoGEGbg4CcDXO2EZsOj/4Y7NvFRgEtdrawoDdhTemYnKmseoxKPhc8glbAmgv9JBK1bJenoerhlAhV8zMxd0i2yh2sQebuCAnVjOJKADp+cEVFPgyGTDCJjalvzxGCnnj6fpxwXpZnVn9D2t2uRHCFWm/ZYnzSsGLmr9wl6mj22ONULIvVWoi4czJE3i+eL9+cnca4HnaZ3bEXecXm9hjaKeWWpK8bzft6K9hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667) by CH1PPF946CC24FA.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 01:33:11 +0000
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da]) by DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da%5]) with mapi id 15.20.9031.014; Thu, 21 Aug 2025
 01:33:10 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v2 0/2] Adding device tree and binding for Nvidia mgx cx8
 switchboard
Date: Wed, 20 Aug 2025 18:32:50 -0700
Message-Id: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEN3pmgC/2WNQQ6CMBREr0L+2pq20IKuvIchprYf+AsKabHBE
 O5uJXHl8k1m3mwQMRBGuBYbBEwUafIZ5KkAOxjfIyOXGSSXijeiZGO/Vq+Hy1WLS0BkVqIoueY
 1by6QZ3PAjtZDeW8zDxSXKbyPhyS+6U+m/mVJMM60dk/dGWVqrG4+kSNzttMI7b7vHxVELzyxA
 AAA
X-Change-ID: 20250813-mgx4u_devicetree-c2e130607089
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755739989; l=1503;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=EAB9UvfjeKMWXy/CPRYZ39i01YhHc1ZVVaSjRa/fBS8=;
 b=HA0qsQP3ZC0QuPRmJk5sg5ahRA9hrz4lnhLjZMSm8J8AP/E7FF/UlW5eoZOqbE3Gc3bw4gOeE
 z0OBhVSlbksA1+Lxc4TTibsSEQprjfxe0fLBGlB/DW12EsyEI/K0xct
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To DS5PPFEAC589ED8.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS5PPFEAC589ED8:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaae6ea-2122-4172-f3ca-08dde052b040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTVqK0gvRklkOGF5UzhWL29BdW84b1hMbGFFb243NjIrazVHdHkwVWNvbWp1?=
 =?utf-8?B?Mk01Z0lUVXZGL1FXdUdpNVBSNUc1UG1hWEdjdkNJMkxkSXBiN1RMSmZQSlNZ?=
 =?utf-8?B?bmxGSWE0T3lVZUdKaUV6UFYraUxHaS9ySWQvNHpraUllbFVxYlVRY2gzeFl5?=
 =?utf-8?B?cUo5d2lPRkZGSHdLZndycXh1QkZWcmFRMVE1QVN2bzdEVGZhU25qL0hUZVhm?=
 =?utf-8?B?cDZRREJMNDN1NmRqNEhTQlJVblJUVjI4NzNxZUdLZ3JsdWxFcFFzdjU3SE41?=
 =?utf-8?B?YlFtKzAxbkdGUXh2RTBqUGlqYm8yMFF1RUpHMHBoMzN6a1NsQ0F6RG4xNHlJ?=
 =?utf-8?B?Ry80RWRIM2JmUUlyK255ZUJoUmFqNWpvbjg1V0FHRUpPS3Z3VEkyQWpKV3NM?=
 =?utf-8?B?YnBWSCtYTXArd2xLQWhTVXU5cnllNlg4Y3RBT1BIQ2tsNkpRa3czeFNFNGFk?=
 =?utf-8?B?ZVB5RjFvNXg4OFdaTXBxMTFlUFRFc0lOeTR2SGVUUFVEdCtPcHVTdXdSZGZn?=
 =?utf-8?B?akVEQUkrOU1XL3NpSUtucGFIeDlBcGgyQmxTUXdwT1RiMFJhQlQxdVpUaXo5?=
 =?utf-8?B?MlB4am55M20zZm5LVGpIdVc4U1RaQXRpRlFTbTJpbzN4d0h4Q0VUcnVJekNG?=
 =?utf-8?B?d3BlVlVsczhRSUc5bzVTOVE1enZUaHdJaDdETXlnS3RBQnBtajRnb085UERJ?=
 =?utf-8?B?K08zUEJZYTZ4aXdBemRnM20rTnpRUCtqMXBPbjRUUUdzS3V2ZVovZ0hBd2VK?=
 =?utf-8?B?Vk1KdEZMWFY3UXRCcy83YzFRYjdzaG51LzgwUDdkVFltVGVTdnRvS2NNajVk?=
 =?utf-8?B?ZklnQlpzNjJ6M1NGWmovd0xUV0xsT1N3aVIrTVNGZFVJb3Yvc1JRS09zYUh5?=
 =?utf-8?B?NURNWEhuRXZjeVBTWVQwbWQxQnA2cEV5WU9WN1lmK3czUXJzcUxyMGlXQkUv?=
 =?utf-8?B?ZEE5aXlScUVZdnZLQ0JyODJydktWWDYycHA4UGJtRDJlYW1XVnZKSjRYckE1?=
 =?utf-8?B?c3BXRlNFREc3ZFRBbUY3eUV2SERlZm5SWEhiNkhGeDhHNnhrSVl6WEJTUWFz?=
 =?utf-8?B?Qi9LUVpLaDFsMzBmVXBGQlRLSW1kQnRvVUpjeUZlZnd2TXhNL3VQUmdyMU92?=
 =?utf-8?B?Tm5jR0VlM3VINnlIS1RaOFJCTXhVWHlQR21abXFHWXNpVDBrZVloVDZsdlls?=
 =?utf-8?B?aHFPN00wZkJvcHMwdXZ1ZlVSRTlYWHl0dDcycUVKNUhIeUNxcmpzdUpEcmlt?=
 =?utf-8?B?blRjN2ROZHVVL3lJR1U3MWZDR2hKU0c3MVc2MndrTHBNK05Oa2lDQUpXUHJE?=
 =?utf-8?B?NEw2eHhWNjRtb1hIZlF3THJ3U2NIaU9GYnpwSGtzQUtHVnYzc0puM2szRDNQ?=
 =?utf-8?B?KzBuTjNhcHZCN1FGMHpaeXJRNElXY1hTUzZEeWJYRUQ4NEZjTHdzOWRqUTR1?=
 =?utf-8?B?dmhJVXZuQ3hwSzJFcmtOZGtNTzV6ZHVGRDRDK1FzUzFMY2h0TEtYTFR6MHlz?=
 =?utf-8?B?b0dZeGpBK2xqUUw0RENLcXZ3WEJ1bytIRW5UR1FYa0Y4NGZQT3hIT0FZWkdN?=
 =?utf-8?B?MWg2NUJ3ekpQNU5DQ2tYditzOExKQkxNTkxGQ3pkY090ODF6QzR1QTlkUnpl?=
 =?utf-8?B?OXdXMzcxNndhcFNJcmRscHJxOXUyVEszcldhcjFWM2VnVG5rZnFkZlp3b1ht?=
 =?utf-8?B?Uld1Rjl3MjJLa09QQ3h5ZUxtV3c0bzU2a081V3JhL3ZUb1ZhRUQrUVVRNC94?=
 =?utf-8?B?a3lvamVMUlBqMVF6cWhmd294NlBWV0U1Q0ZKSlQyTitmTlVwS1hLcUhDV0cr?=
 =?utf-8?B?QUVvNFM1M0xWQ0FwREt3QzdWWDNVVUxrdVR5d09CWENGMytnTDFsY2x1YVA0?=
 =?utf-8?B?eFpFMTJnbHc2bjMxQkxIL0VibndaUVJYNmI4RGROYjZyaXJ2T2h2MzY3Z3Rw?=
 =?utf-8?Q?9GiB0vesEkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFEAC589ED8.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STAvOWU4WXZGMWsvWStnSWdxOGZ6VW5DTnE1UUIzNHA1SEFqVnV4VEE4Mml3?=
 =?utf-8?B?RU9JUTQzZUo4NUlTemVZYVBPYXRFeGhDWi8vTWMxc21MUHY4M2kwbWZHWTRH?=
 =?utf-8?B?QnAvdGlxZkcrZTBCNVA1alMxQXNVWE91WHlCT3A1QSs5elFCM2NSYlZQZHFm?=
 =?utf-8?B?dkF6andQS3ZVc3hLakZCSzlXZ0hZTXR0a3pnYk9FOFYzaEN2bllTN1Y3ejZF?=
 =?utf-8?B?SUEwbTVKeFRuMktyUUVIY0k0Mk1NSUNMWjM5K2o1MFdMM2IzeWJTRmdJS0Zi?=
 =?utf-8?B?VEdQVU85OGxZUlV5MTA3SU1OdGV6dzRnZXZ5akw3N2E3Yi96QkU2KzBCUHEr?=
 =?utf-8?B?Rkd6dFJ1NFFuek1IWkJOK1QraWE2QndBbzF6ZG4yZU8wcGRONStkVTFZYzFa?=
 =?utf-8?B?ZTl3dDllMXJNbUJFT0ZJWGMyMGdEY0QvcC9PNTNxdDNqSjEyM1pKWEFhVFF1?=
 =?utf-8?B?UzM1NlFYVGFMRzh0NUI5TUlvTjZBVmU4cEpDYTVsS3UydWxLUEo5L2c0WE01?=
 =?utf-8?B?RVJ2ZHVoOEVwbGZuaEUyYUZ6MDJTZm1ReTZnWGlkT3BteC80SWVqakY3Z2Qz?=
 =?utf-8?B?RHN6bHIwQjhwQ0pzYWZOQVFUb2h0YmE4QzFaK20vbjlIUnJpZGZSM3dTZzB1?=
 =?utf-8?B?RkpQUWVxMlc5a2VIaEw4UXp2VTF5MmR5NVBDRGdkU0p5Z3R6d0ZGbHVERUcw?=
 =?utf-8?B?cDR2dUZ4b0dwWXIydzJ3cnBRS2pDaG91U3F5WnZ5U0VFMCtHa2VLWGJzL1Vn?=
 =?utf-8?B?UnlFQVFQZWNiOTZ5ZVJ1K2tFM2Y0c010a3pCMk1Oenh6bXIxaktHNXNOcWN2?=
 =?utf-8?B?L3hmdEhqa3NyZ2ZrOVgrTG5XOWxJN0FyV25hMWpwZjlWVHcwS0lvZ0k4MG9m?=
 =?utf-8?B?LzFUSVBGQVFzdGxLN3JtbjBQTFZDek1RNEo0aFNRNkllWmNBeDdyT0tzbENv?=
 =?utf-8?B?OGVaUHVFQzEzQjl2MUozZm8zRnZtdHlQcUQ0SWNKWmlkTm1FVVpZN2dPUFAw?=
 =?utf-8?B?YzZuU1RLVUlZSm8zRXN6MmEzVzZDQXhjVUhUNitZTWNTaW11bHBnTVcrNTdz?=
 =?utf-8?B?V0tUWDlQS3ZNSU9IZjBJaXl2M3RzZXJVSDBtV1VVa3hzZ2hnelpCWUVNTTFz?=
 =?utf-8?B?eTJoRWN6UEZmM3BKTjRCVGdMd3FneHVicnM0LzU0ZTZ6Y0xMalVYcUNZTWhT?=
 =?utf-8?B?Z2psSnZSeU0rUytoSGFFb01PUXN1bjhvai9TRnZZZ1U4ck5rZG9lMTc5YjZJ?=
 =?utf-8?B?ckZoVXphRmdFMkNESFpELytFZ1FZQ0RxZ0NPUXV0S2c1cFlwVGZrSWx2dFE2?=
 =?utf-8?B?TkVYWmFwYVNvb2JRZENER0R4dWQ3ZERyS1pXWThscndsZ0RJU1JkZ1BEWXdt?=
 =?utf-8?B?T043ck5WcXVDNFFQcFJONzU5alZGMmxvMTl2RVg0T3RySjFUejQvQXd4TmMv?=
 =?utf-8?B?bG9MbzB6OUdZbEpzWnh5Z3JHYzQxdUo5djgra2NKazBIMmtkQTFDQ3pqbThI?=
 =?utf-8?B?UXpZK2htaG5Pazh5TmNjUEFpWHNVWXlhdlNqNUsxZlJWK0VnNTcweHFJU3BG?=
 =?utf-8?B?b1pMY3hwQm1uRE1VZ1lqLzZkN1BLOUxocnF4bTVhcW92NGJwTk5tamJvNkNF?=
 =?utf-8?B?cDl5MEJXOFViUysyeTBJWnovd1dQVHhRZ251S2RLYis5SnI3Z1FVMVErS3Nn?=
 =?utf-8?B?WVNuSTNLeE5UK2lKdWRra2VYa0xhZmNYNWsvdng1b0FyZFA5ci9jc2RkUEYx?=
 =?utf-8?B?U3FlS3dzOGd1SC9jU1hxU2swRUtLL21Bd0YrS2FybEtSbnFGRXJpZFpsU29P?=
 =?utf-8?B?U252Y3J0S0NHSVk2ampreXphUzR3L1VTWkRKWUoyMGkyTWhIM2dISldFQUhX?=
 =?utf-8?B?NjczMTY5Z3N3V0xFSmk2UWFNNHhIc1hRMVpNWU1qNkd1ZVFLTHRhbHVrNTJa?=
 =?utf-8?B?bHJaNmNGTlpzVHlaa0VUUnh4MDhQQ1AxNmJPcWhIK0oyMGU3SGhOUDNzcGtq?=
 =?utf-8?B?cWZ6bDJjUEJKY0hLcitpUGJzV01BTEMvRmVGTkM4SyszQ1lRaUZtSnVIaEwv?=
 =?utf-8?B?VWFmb3YweWhxSEx2S1d1elBEajFzZGdoOHFONkRIQy9yVmJzS1VjVW8vNzJQ?=
 =?utf-8?Q?fT6OzuYa3Em39F2Go1ZCUVrOU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaae6ea-2122-4172-f3ca-08dde052b040
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFEAC589ED8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:33:10.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OVMDGmoPwQd8fw5aHxq+eOCZdkwtlVXEDwEdfhBKkKJf0PVbkjfhEXL9FeqSz7+tiw/JH/gO14tckiIE76OtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA

Patch 1 Adds the binding for the Nvidia mgx cx8 switchboard
Patch 2 Adds the dts for the mgx cx8 switchboard motherboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing an Nvidia mgx cx8 switchboard.
 
Reference to Ast2600 SoC [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Changes in v2:
- Made all node names generic [Krzysztof]
- Rebased the series ontop of 6.17-rc1 [Rob]
- Merged contents of the cx8 switchboard dtsi's into the main dts and dropped the dtsi [Krzysztof]
- Fixed license on dts to be gpl2 [Krzysztof]
- Changed phy-mode property to be rgmii-id to correctly reflect that delay compensation happens on the PHY [Andrew]
- Changed chosen node to use stdout instead of bootargs [Krzysztof]
- Link to v1: https://lore.kernel.org/r/20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com

---
Marc Olberding (2):
      dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
      ARM: dts: aspeed: Add device tree for mgx4u BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1452 ++++++++++++++++++++
 3 files changed, 1454 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-mgx4u_devicetree-c2e130607089

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


