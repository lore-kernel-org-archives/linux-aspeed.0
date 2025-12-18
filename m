Return-Path: <linux-aspeed+bounces-3148-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF25DD6E2D8
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Dec 2025 18:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXKTH4VBDz2xrk;
	Fri, 19 Dec 2025 05:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=40.107.208.13 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766083763;
	cv=pass; b=WjS29+AIhc1hZ2pI4PfUA3V52bRyq6PfiT7/9s9l6S8lx08ogKVBfEdSvgUOGXtRXCia+Xa3zbf75thIr9lXizcMAdNFFkpP5BjOnFmVk5J09HuK8mLwOnLN765mIglTJIGPuzOdYWe/4WY+WsMvFp9PdTHqGUzLxBK3bENhEeKtn/d3fKWgFODeJPlUxi4G/bzk4PGF1hrYm/luWm+/fcp0MbkfYpqNMk4U0t0thGkFw6pgmL7ImsWRyWAyjUnVGaUgQg68Sswx79ZXTOhPgqRF/cqEMIPdw/cmyH3o4mV+vTuL8xD5K0gXPQiJTeRe4FkrWwSpmJcRyJ1VHtRTSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766083763; c=relaxed/relaxed;
	bh=3RSzQi5aKr1DrbMRRv5XNDYBsQTbGzD5mX7QK79Pq/s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kQEgqHpa/YkW0OX2u/JRFv/Truz881/80MlRINXOVxTDOJvg6JY6gP9ElosPNZ1Ugexy1X/1LenhvBkAsFMgizJPuIfULC0FlQZRLGoOVHCUox3uugJ/Y7PG2g9fBAfrZGMz+sb97CIsOFF4yTtJC9FL7n6k3rHjGyno5bZg/HyHFwCuLB2gSktZGZgSbpjWqTIYcQzAbBjR/tyfMYjDQH51rfpeIq6VXwJ1wEIVrzwqdCLT/ceebJ1+eH3RbWLM3KIMvOVT3ZDf/ocnly1R0q+DbPFURrGiEcorGjFBfuicqnLKC8OSALkP1Mr9YSbkJMnybMM5zQ+utPGQn1IjIw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hr5AR7Hr; dkim-atps=neutral; spf=pass (client-ip=40.107.208.13; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hr5AR7Hr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=40.107.208.13; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXKTH0Jf3z2xpm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 05:49:23 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuLHLo3vFd8UCxN84Y3qSTnH+llvy+UxGuyBodxVug/Q8kFVsdd626hVnW5kpsoMt48pcPlujVAQcC/Azcws5EIN6rNiWeMypZuNAlofSTcVUT1ukdpFtfTONkY3YcRacVRRScdmq6AXaAtLBH3UB7Cff+TFTte3IrD5TGFeWn3ycIkvx2rFmCI/h16x9ZKREzQS0fp1PMT9NQYjKzsQeKasjTKKowwwJ+MVl2DYJ5onb9emDZCfXpIM9q/21PiVxDrkwTpclWmzCNkVdBEhoHolxXIRsOiJoHyfoMGN9ml+1DLXf7URIEohLudr0O2DBLzeWn5WlQaUm2P/JN+3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RSzQi5aKr1DrbMRRv5XNDYBsQTbGzD5mX7QK79Pq/s=;
 b=EZysWXsf7+aWgd13O/W3oPCVyTAIKaLm6j7ESW1AwhpjqIol4apgJSFFrCTLHZCxtZVSdRnHW6XsIkYsPpm9gBEQMo5v7I3G+LvFQwqUu5WUZDO1dmxRgzGBOiwpfQr9hbe/pc54tDPksYTm7/V8PqXhoAZlnqGkq3gNU/EYP8joEY4JOQU9QgZm5VvrTBqTPC9u9rQvZ6s4OtLqnXWfa3zNhXnk50M6rOmEaozai/PMQozLLQEFZDZ7TqJi0gOUYpNXOFerlp1Xy8qmU/PukyjE6c0vPFGcmWpaXxvnbNPagijWQztlCVgmVGyzYgLQrxNdvgcgUlzBHjO5FEQM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RSzQi5aKr1DrbMRRv5XNDYBsQTbGzD5mX7QK79Pq/s=;
 b=Hr5AR7Hr777xK5I+oamytiE0KeOwRNJtNfEt1btnv2HoXugJNnrHslhf6CagbE8cRJj+tVvEdciSbG1CJqQSDCDJ10ciLNu78x68Vq/DrCiEQqK1J3Ja382v+XsPF3qBosRZg7wNoxEiCCqA9aQJk44/jKvP1KsKl73x//6jfjAEYr1qLcom2MLix9MkbOUkVYInf/mkFw/1UCDqCF4aSnQulHxdsW5Mq0fKJRzwB151UVx6gku6tTed87Lcb2OEbW3rQzJwfqJF0liyuTcgegXaPrUllo8AUPqNmVItkKh5reE0ZWFaCJ9bQCgmPLlj+jrgZP1l4GX92jBMGuUJQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by CH3PR12MB9217.namprd12.prod.outlook.com
 (2603:10b6:610:195::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 18:48:39 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:48:39 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Thu, 18 Dec 2025 10:48:11 -0800
Subject: [PATCH v2 1/2] arm: dts: aspeed: add an alt 128M flash layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-alt-128-v2-1-10499a0b7eb9@nvidia.com>
References: <20251218-alt-128-v2-0-10499a0b7eb9@nvidia.com>
In-Reply-To: <20251218-alt-128-v2-0-10499a0b7eb9@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766083715; l=2170;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=WwMfse0ni/nAUTF78JiG/UwvhlewA+GEplk1pps1gfs=;
 b=/VzUN72j1sbAjjpGbD+EJ+IBdgxiRsS++k4ZSmV5eSupQ8qu9dfb3+U866En0xzKClyBknO5E
 oanc/q+mbG2AenX17LRICR9R3nh4BJ3NYqRz8y/BcToZGuMIpHQ5Uui
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 237467c5-1c7d-48cb-127c-08de3e660ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ynk4eWhaNVdPVFphc21PQlJqOVlRVHN5dWZSakZwVksyU2xnd2lJd200MHh2?=
 =?utf-8?B?eDFuRzZ4ZCtjaVBiZTUzUkx3cms0akM4M2NBRVpTbURYQjlEbzM0ZTFJZTBo?=
 =?utf-8?B?Q0Q0RlFENDUrVTd0dFk2ZjcyTWROajQxYitJWGVxTVZFa2pBWm5pRzFESW1y?=
 =?utf-8?B?b21DY2kxMWpQS0syQ2RSdDlLSUNtOGh0alVROHYzWS84NjNBZ0lqK0JhRWFF?=
 =?utf-8?B?cHFRMTFwWis5TVRtd1dNeGdIYzlmSExJdlhZZlZiQlBGZVhmMTZrMHdyQ0VL?=
 =?utf-8?B?MlFxRkcvU0FUNWdNdmVGUGU0WUFMODNSVDh1Nkx1dGRmanVsaXlEYnM2YWdr?=
 =?utf-8?B?ZmJjbEozSCs4VDVTQkRadFV1djVVeVljeVJpSXZXcmo4V0VqMHE1UDREejg5?=
 =?utf-8?B?ZG9XbDV5U2I1MGRkbGRQK1B3Y0U0UHgzTjlabEo5U0pEcndPUUMzdElsckJ3?=
 =?utf-8?B?T3dtN05ObTZOSmFRRGpQWlFzbXA5TklBOWZ1MnFXL29iUEtVbU5BejN2T1pm?=
 =?utf-8?B?ZkRaenYvRHlWTG16VmdRY2ZDQ3Z6S2xkdHJnS3RieEVmSWUzMUhOQVYxS1Nw?=
 =?utf-8?B?anBhTTZyNzAwUGgrdVBxSEtiOVJyZWpNeHJyYWlIb0dJY3AvSWszUkVrem1U?=
 =?utf-8?B?a0tNMmc3R08zNC9pM21CVmM1R1V2NnJEMWQ1WHRydVVtaFVkZUlhRXhBZHps?=
 =?utf-8?B?Z0s5SUZYK01NN2h0dHgvT3djR2hjeVpvZTVtUVNnUCtRTmtWT1RxQVE4K2FP?=
 =?utf-8?B?Q0pQNDIwUUMwOFZtZTd6MVNtMG5oaW0xOFJpYUcvYysyVU9LKzRMTk9zbjh4?=
 =?utf-8?B?RFJYM3Qyd2pDMmhpb3hGRzF3Zm5BVnRGd0pVc2FwRjVrbWpQNmRjcklYaSs2?=
 =?utf-8?B?Z2U4dmhMc1ZERmRzcHVpZS9RaEhHVkY3OEN0NFlRREZLNkNaTmRYcm5VZnF6?=
 =?utf-8?B?cmRaeGExcURtd3B6Qnp6L2tYbmZHTzU4SW5rdnhTUHVHYXU4cm83ejZ2MjI0?=
 =?utf-8?B?Vzc3S1ArWUplQ3pNaVBlVk5aVjltMWwrTTlpcDc5RlJObUpSZ1BjQSt4c2NU?=
 =?utf-8?B?aFBJY2ZTZWl0NS9xV0ZiZ1J3V1ZBejBaVmxhS0VXU1l4RkxpOUFHVklCOCtT?=
 =?utf-8?B?dVhOM1NmZFBUNmFLUTA1eFNUTGViWnZpdjV4Z2hrVmo5WFRjdXRhOXFZV0tW?=
 =?utf-8?B?L1BjaC8yWXRhUjUvcGluRjFiVE9ia1lYbzQvSjFUZmZ3VVQ1ZHRMS2UzQVE4?=
 =?utf-8?B?b1laL05HcGx4L2V2RVplVUo1WGZySno3YTFWTTNoQlk2aTV2ZlhET2xLQVVN?=
 =?utf-8?B?cU4xLzFuTUx5bDRWbXczcmNKenZRU3l5cHlmQk1pWXl6a0VVN0tXc1A3V1lE?=
 =?utf-8?B?dDIrM25aSTM1eEdXRHF2bWVXRjlIK283L0F2UDFaV2dibmJUMTFUdFZnOFFv?=
 =?utf-8?B?QTFsaTdOQis0b0Z0S0hVeU5mV3pQdzlFUFhiTGZGZ09PRkZrOEVEWjBLN2Zr?=
 =?utf-8?B?MDJidFRKRFpwaW8zOVkxdkFxcUQ5V1JuM3d4UUdrWE82bjljdWowUEUzNzl2?=
 =?utf-8?B?dldPMzFPVDdVbktja3Vwc3V5SExmVU53TDhsQ1pDRWZWcXlyMENtYTAzNGVl?=
 =?utf-8?B?akVGZ2hsZk42R0lsbXdoMi9Oa0ZVNkxoR281UUhlMTQ4ZnVuclFXUnU1d09p?=
 =?utf-8?B?MklSeDhuQXhOTWwvNkNhVnBmeGk5a0tBU0t0QUdCdjU5S2ljY3RneTF2aEZt?=
 =?utf-8?B?Z01ZdVJtUlJ0dGhxM3hIV3J1MFl2bzJYNUFlZTBSSlFkV1UvQ2VaTk9zamJU?=
 =?utf-8?B?c1BtWDBleU9nTEJ5TkVSSks2U3NFK0F4eEQrV1h1eFh6TlFHanRNYUtKNmRm?=
 =?utf-8?B?NTRKbzA1QUJyVWFtUm5mOHE4R2licHNiZ3NWNG5vWGtWRU9RM013cU84amZ4?=
 =?utf-8?Q?Ip1wrwhUiNTi68Mv8/KdbUteMNhAlrCw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REp1bnVVdnhYQ1B4NXM5ZUpkMnZiQXZyaFAvckZZV3VnODNBOWw0ZU5nWEJM?=
 =?utf-8?B?OCs1czIvSXV0NmF2RkE3VTlOY0I4R0dOOStqWnBuTW1FYVFpb0UvLzB4L0RY?=
 =?utf-8?B?amZidHR5NlArV01rOXFKbjhmRGM0YVJ6NENRbVBxczducGg5bFkxWlFVaDQy?=
 =?utf-8?B?VkNKNDRNQmttK09ZRTJNTTNuYktBQkhROFJSRlN1cHE4RXdmV3FJbERVbkRQ?=
 =?utf-8?B?Z0twa2xIakprSUtZUnZqZW5kZXBkMDRvQ2R5V2Fqb1RLSFg5YkpTNVdUN2Mx?=
 =?utf-8?B?aDdJeU5lQ0xLZkdBQUxlRGZlZ0pJKzJ0WitoSmNoaDdVVnBVRmlOMFh3ZHJh?=
 =?utf-8?B?T3RvV1ZnOTlvRE14Tlp6YVk5ek8vb1Y3ME1wMG9tRVlzbUFraUpINXcxY1hE?=
 =?utf-8?B?TFhROXZuVXE1WExrZDhKL0xHL254OXFCaStIa2dRVzVKcDUzUWJGQVViajJU?=
 =?utf-8?B?ZHExSCswakovUU16bUpsUkNHU2ZiQ2ZTaXdkYUlaazJqeVorYS9uV2Ftc2lJ?=
 =?utf-8?B?ZTI1Z016WkRmdVdCZm1tZklPUXFLamxRS3BLTSthTC9TQWcwWWM1RUU3V0VY?=
 =?utf-8?B?eUJ1KzJXWTNFL1pGSlRBM2tUWmlIOHhPQXFZVW1uQzBuZ0sxYmpJYmFFL2p2?=
 =?utf-8?B?cE85SndnS2ZpbmJ2TENBempROE1JK0V0ZmpkeHFWalpCQ3hBSTU0cXdCUUdy?=
 =?utf-8?B?ZXNUSndnWGdwa2VXZHoxRWpXL25kTnRydnR4QTh6OUQ4MVE2eUltUHNkTk4x?=
 =?utf-8?B?MUJpYWFBak5TRmNNQ1RZMXVsYTVaYXlMSXlIV1hWOE52RGFpenNnTU9reDVE?=
 =?utf-8?B?U3J0Zll1UGdOR2NnSmZkL1BhNk4wZjlWOUpJalRiR2cwUk9IVVNWbkhtbWFh?=
 =?utf-8?B?bXNVQjN6VFQ2NXVXWlpPcTVRbWR5ZWJ0enVCSFdhb0QzTlNNNXNFK2Q2Nnc5?=
 =?utf-8?B?d0hrdlJIVXBhMzVYSGc0VzlUVHY2RDIxTEV6QmxYTWo0S1c5dFkvcWdieDlK?=
 =?utf-8?B?alVEU2dmQUE4ZDEwbmtySkFQZzJPWEhqTGhkbUFaNEFaNjFqS0Q4SllFTUdh?=
 =?utf-8?B?Z05aWXR0UXVzT1lCSHM1MjAvUlBBRERITDgrQ2V5MEorWVlwUTV3U0tIK0Ft?=
 =?utf-8?B?TW1qU21McEUwY291Tnc5VVRRWjBFNUNjNmw2NHVwNmNKOGNJTW9yWTBuU2ht?=
 =?utf-8?B?dWU4bTM3QWhhNUwxM2VTRzZ1dGR6N1lPLzRKd3N0eWxFaWZZQWRCM1RUSStX?=
 =?utf-8?B?R2plaldLUStkdGlNQWhxSWNtU2t6VFM5UGJZZWtJYmVQMUN2NW9UVEltOHFa?=
 =?utf-8?B?MlVGZGEzS0c4YmdxSldDZkZET3J2cllSaWszZm5MSStnSmlocEJsVVRKc2t4?=
 =?utf-8?B?aE1qYS8wN05VNUlnbnZvYWJnYlI5VEpsQnBXWVU4UktGelBqaVdyckFKTnJL?=
 =?utf-8?B?OFdjS2FtOXdnUVNqL3NHWFdGajM5OC9maER5bEFQZjNlZ0RhMGtEQ2RqUGhQ?=
 =?utf-8?B?eHR1ckEwL1JsbFdwTitacFRNS1prbGdUNGpkL3NocmNVYklzcG83YmdRSDdN?=
 =?utf-8?B?RStXSE5GbVpWajdMRndzenBja0diZWxNbSs0RzM0NitSQW9wNDFsUE01QVpL?=
 =?utf-8?B?TS9UcVJUMXpENGM3Ulk5a3hJUndyZ3J0Mm9oK0swd0xBMXJFdmVrYVlIUDl3?=
 =?utf-8?B?eGcxYzh0M3ZLZmxmbG96dEExYlN0U2hHY0ZCL1I5ZUtWekpWOEE1N3NCSnFs?=
 =?utf-8?B?VFE1SWZKdm5Xa2dROXFneitqbGJOdU9USCt1ekxjV01YOG9tM3dYRSttQjFJ?=
 =?utf-8?B?V1dGSDZCVHNGcXFBd3EzRnErTlJjQUtGakNjSjRMYW1yRjlQTlIyb2pSbEtG?=
 =?utf-8?B?SVgyZ1l6WXhEWUJwS1N2QWNJUTc4QzBBZUtDQitDOFVXOHlUb2RrRHkvYUtD?=
 =?utf-8?B?cm5OMXRpR0tIS3ZOM09mT0xTQm9YKzI3NnlPSkoyZVNMVzM4cWRib2ZudXFR?=
 =?utf-8?B?cllRL1VqSlFQdjNHVFdKQ2NmUll1dCtaNGwzbGZPMkZBdkQ3VHNROHJXOTNV?=
 =?utf-8?B?WnhiY2xyMTNEVDVVaWtSMUxsQ1lHa0Qxa1dsT2E0WnA2cjBWNzBzOHpybkZ1?=
 =?utf-8?Q?Efgl6ziAosUlpebF0+YsC5IQ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237467c5-1c7d-48cb-127c-08de3e660ec3
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:48:38.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnFx87dDxECquRqVhThp1+UKvcEncFJ91/Rl6+NpGNb/vnfptOy4o44dzSYrWZma8nSWtY+z9+vY8CrA/H3dbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217

Add a 128M layout for the BMC flash chip we didn't boot from. Including
this allows the user to write to each partition on the alternate spi
chip. This dtsi follows the existing standard of using the same layout
as non alt version and prepending `alt` to each partition's name.

Testing: Include this in msx4 and cat size, offsets and name
```
for devdir in /sys/class/mtd/mtd*; do
>     [[ -d $devdir && -r $devdir/name ]] || continue
>     name=$(<"$devdir/name")
>     [[ $name == alt* ]] || continue
>
>     size=$(<"$devdir/size")
>     offset=0
>     [[ -r $devdir/offset ]] && offset=$(<"$devdir/offset")
>
>     dev=$(basename "$devdir")
>     printf "%s name=%s offset=0x%X size=0x%X\n" "$dev" "$name" \
>        "$offset" "$size"
> done
mtd10 name=alt-rofs offset=0xA00000 size=0x5600000
mtd11 name=alt-rwfs offset=0x6000000 size=0x2000000
mtd7 name=alt-u-boot offset=0x0 size=0xE0000
mtd8 name=alt-u-boot-env offset=0xE0000 size=0x20000
mtd9 name=alt-kernel offset=0x100000 size=0x900000
```

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 .../dts/aspeed/openbmc-flash-layout-128-alt.dtsi   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..08ce2eab472c3da4aa3d841adb0eb1c971e6a25a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/openbmc-flash-layout-128-alt.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot@0 {
+		reg = <0x0 0xe0000>; // 896KB
+		label = "alt-u-boot";
+	};
+
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x20000>; // 128KB
+		label = "alt-u-boot-env";
+	};
+
+	kernel@100000 {
+		reg = <0x100000 0x900000>; // 9MB
+		label = "alt-kernel";
+	};
+
+	rofs@a00000 {
+		reg = <0xa00000 0x5600000>; // 86MB
+		label = "alt-rofs";
+	};
+
+	rwfs@6000000 {
+		reg = <0x6000000 0x2000000>; // 32MB
+		label = "alt-rwfs";
+	};
+};

-- 
2.34.1


