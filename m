Return-Path: <linux-aspeed+bounces-3011-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57777D116E4
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:43:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGyNL6b8Cz2yvR;
	Thu, 27 Nov 2025 11:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764204226;
	cv=pass; b=oG5vT/NX2PgCdmfGzI1/oS4vzOArYrq8caH10s/3pzDgOwNQn0Jj8OoH+7V2LG7r+zqYAZvSqcwQZecQ803+fMdHx2fWGilnP+JmMgRoe05JbvB/oGKTfyrpHza6kIOpzzGmird9hJL9FmdnqGyrgszNbskT3avwXLSU8E2pjlS6wz1Mvwn6F7hXlM9xElgKehZiaht/EqpwjuXXz7RgFwNhnFdQxqcK5wZv6f61YUqgB84azrK9YKo7nGFHfYzRxzvKj0Czbmq9JVqcgueqkjNze/pvA/evnG/TI4EDG+fRJP45xsdoo8sgmuQvebmBb3uIys2cUMpnY4PdWGguNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764204226; c=relaxed/relaxed;
	bh=koi99H77R5S9jC+bzzl1gOnrFOwAc4uWaXW0ETDc0YY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Oow6NyjG+Kt1eMmHA8rAWMeewgA31a7Edm9AoJ8BM41U9Zeml103dItTvTLTPJe+OvETJv/z2WiNZj0CEbNgXN5OjRmgFe0hnywIRqAXkq4P7RFIzMbZYIVtW5wfEsi0/MByZar/9S12VT9aV7Wp6MnlDdxDj4TiuCq/JBhWBm/uXAErs/NRFiUyRRSpP1OZEAVuzAGIsRLoDlhLd1xcs6jBueG7cJsg5wozKjQwFgecWpI76awgtam9kkekRicOM62pn549mzl87Rp1gPZgyjsAtADO/x+STLl1RPirinPU6dz5D5lmPMPTDB+n2M+kaNCv0bQSeJuCO7iMv0/OVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NFPcbY2X; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NFPcbY2X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGyNK6MM6z2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:43:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkZNMMiqB/SbeG4eEGEVueALlUuBHjcgQ52zeX1Wwyu2KoWsf4vmtrd44X5mYKK0t8x8QlotC/RKOZwIr1mt21rl5/PwSVakhiBP7Royf/jhN2qNKVpcVkvwGcCOa8gRhY+X98w3xmQFtjD18IIiRn/LQvxHyILaitXVdUS3lFkqYwdiIeHRVrkF1PAxsdJ8FMii9i5+k6LAUFhv0XWv78Jxj0ZHwQom2YaYA7WEXKNVztGzR0zAtRPAtb2zB8qsPOf4MgvVHQhy5YygvAxPXeROsdgWn3FBWrD030h0Ljzi/Mdk6+jKrKcjDfVgwyaoHNCp9wEHivrmNXL/FdN6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koi99H77R5S9jC+bzzl1gOnrFOwAc4uWaXW0ETDc0YY=;
 b=LFvTQ7C8dS5lUvLknXB0LVWo8TZpgzYhTTaw+gtkkNSafZSXpYeQhsrXrxeIfbR+pdufcjMgSmdjVMbrH4ehLDjk2NobxjGzZ9hrNSbkdFc5yDBsAXalAWyetOEOORLOF9nIL4LeSdCNvFAbdrv6xWAONt/52fHpZVGYWnE9RwPnfvDAsBv2KbMeeCJBP+MvxWZB8f0lhjNZ0KRWFSHTLPUEAZDJUWRXCeAL4kZ3f0dBlnTz/5RH5qBlPq0Cecpxr0m/QLxATETAusVEeJy3xI5aTszbAsIOPgsS26T86rlALQ3U5mNUkAFtXVcxqyMb7iaCThRJyntkU4v/XD0bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koi99H77R5S9jC+bzzl1gOnrFOwAc4uWaXW0ETDc0YY=;
 b=NFPcbY2Xkr1okPQGRjM8gitfMqFqHVjObMR2oGsQ6L/jViCP9YA/Ka4yBUHBU+kkWdK660p9hoImisnVhPi8jRqcXuyihZ2ICVX9c8k6DJl9toK0bkOotxQ+G3oIAhaDLy/2BqNuONuTncUAz5Qz5zQh0BGlQI33M89/+6niJVZZS3641BvWRRL24T+eClpHS8nC7oPAsuFxVPkOf26FrrDrjWBMwq5j8ExfL4AEmNXFPIn3psi+PrhS+oPDbvf/3izrx1R4QMWGKVhUiwZjfEIrM8Zg+p7cTyvozHytaRlHBGyngeoI0kpdzz0MkxbyeHb4d1KGtaOJR7z0ki8qEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB7855.namprd12.prod.outlook.com
 (2603:10b6:806:343::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 00:43:14 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 00:43:14 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v5 0/2] Add device tree for NVIDIA BMC MSX4 CX8 switchboard
Date: Wed, 26 Nov 2025 16:43:05 -0800
Message-Id: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmeJ2kC/23O0arCMAwG4FeRXltp0m2tXvkeItK12bEXbtJKU
 WTvbhQRpYdc/SH5krvIlCJlsVncRaISc5xGDu1yIfzRjX8kY+AsUGGr1srKU77CIfCkp0siksY
 N6GHw0AYleOucaIjXl7jbcz7GfJnS7XWgwLP7tqC2CkguG7wypBDAbscSQ3QrP53EEyv4AQCUq
 QGUSnakO+qtsaHHCtDfwD8faAa88X1jjAuEpgKaLwCbGmgYcJp60nzAdb/APM8PNiKhFHIBAAA
 =
X-Change-ID: 20250908-msx1_devicetree-7af2c1fc15d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764204193; l=2191;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=I5rt/C66btvSkxNJTSMuZSYfJi0xW9PiRpHH+Cuzv/A=;
 b=pDxJU0t1IvWV7rtkRgdPRPC+XTH9yOHsi7IIjboOGxXNN1brUZYguM8uiLIpQCx6HcGTKZ3x+
 bl/KrkV7SMhDjaQmXr5fotpLP4UDy+NKDyNemAgI+sAOCzI+9xKCGBa
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: d8212bc5-b88f-4c23-5c9a-08de2d4df2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEVKYWhWVGJlai9Gallqb2xFazBlQ2lNbWxLYVJIckJKNGJYanNxQVdYTXI3?=
 =?utf-8?B?Y1dhNmtlcGVMWVgvU3VLQklYa0NFQnBUcCtXMitURGRSOFJYTEs0ckMvaFRG?=
 =?utf-8?B?U3NjTVAyTThkK3pmZVRPcDNFMUg1RVlSRHdYejdyTnlybHZBOTMwaTM3R2Qx?=
 =?utf-8?B?UjRLMTEvVDZsNkZTOEc3WXdpZ1JrWG9NL2l1S3NyZDRGckMwZytvQTBINEdJ?=
 =?utf-8?B?SHFnNTg0MnlFa0V1LzBEQWlxNXRYbTJJOFYveWZ6eGdvZGt1eWlPTnhSYVpM?=
 =?utf-8?B?Zkp5QWdDc0E5MVlZWWl5a3BrOHB1aFJCa2tGRDRuS0JlbFVod291L2h1STRC?=
 =?utf-8?B?V0tIN2FUYVRjMFpicVVzd28xOS9oNEczYkVtN3pTbnpBUmVCbTZmTUs2YWhE?=
 =?utf-8?B?bnBKRlhMMGRickU4R0Zxb1ZFVVliaGtxVVVSMVBHQTBkYmdmU0w4WkVXbm9l?=
 =?utf-8?B?N2dDSEYxM0h5WHNRY2k4UFkreUhJMUJqbm1QUDlDcHJuU3Y2VE02ZDhWVmRV?=
 =?utf-8?B?T2RTb0IrVEE4blNXb1dUeUZMSjZiQ1E4Sm1OWHkwY2g1WUZNQ1RLZ3NPZy9J?=
 =?utf-8?B?c3d6TmxHN3ZWeXZBMlZvTlNDWE9lVXlOVXlhd0hYQUtZWm5VbWdvMjJ5Q0dY?=
 =?utf-8?B?QjZ4dEVjMEdnN1haMEowcVRON04zNGI5Y2VnVFRKYXZCR3lVbzV2eHRNNEVF?=
 =?utf-8?B?bGRnQUdDaDhXUDFtRTA1UVBScEhLVVZzK1YwOE10ZDR2TERTTUJlQkpMbm9x?=
 =?utf-8?B?L1VaVUE1Vjd1UjJOWDZEUUZYQXJKQzFVdWtCalJZbUFWU3Y3OEJYeFMyM0dW?=
 =?utf-8?B?RU1zRmRQTUVFclRHc1ZyMW8yVFdFZXJkOUxoMmlGcUE4dEJRUWZ3ZC92WVVZ?=
 =?utf-8?B?QTB2WitqOUVJNDh3WmRZTnZDNkUzWmNqWkFCeTFVaURTMGlLck1ZaytnNXBD?=
 =?utf-8?B?UGF4N3ZJSXVPR0Q5ODMxbXlqdGFkSmtqZ1B4a0xTSG1qK2NZYmZaV3NPR0lm?=
 =?utf-8?B?OG1lOXVBdjd5ak82L3lNQVNXQ0xMQS9JSnozN0E2cjhVZ3NNeW9TRy85SXdx?=
 =?utf-8?B?RlA5c1Y1MFVOWnZFaks4Q2xXdHlsSVYvSmNXZnd4Y2RVYktGMVJWV01DaWVF?=
 =?utf-8?B?K2hwZUZ1ZS9NZUoyODRGRXVRU3poM3pTWmh1T3pmNVFYNVZSVEgvQ2tOVzh0?=
 =?utf-8?B?blNVeWtrSm1WeDgwTVhtVTdBZHdYSWs2VU9qNFhpU3dMN0RwdkVWUmJhSjJl?=
 =?utf-8?B?MCtiSjljY2lLOHp1OXVhbGRPKzJIZWl4V3VtQWRWcmhTbFV1U0QwdldtMmFn?=
 =?utf-8?B?dTUxYXREdE1yaVAyaHRTNFRNN2tJUllKWDQ5M0RUSENIV2FBQ25Lb1BHSzFh?=
 =?utf-8?B?SzRhK2h1dDBxbnlCTVljYzc1TldudkpJQmxRL3NBem5CSnJrQzhqeGZQSkpq?=
 =?utf-8?B?T3NBZVBmU3hhaTU2aDg5bG9MbDloNFZvd2JVaWhVampiUTE4ajMrM2l5QVp6?=
 =?utf-8?B?MWNuQkdoS1ZoeUc1TlU5bm1tY2s2MjlYVnJkaDVnTmlwREtjVzY4a0RSWEY3?=
 =?utf-8?B?Q1lGS0Uva0FWcGsrcHBuMk1YaVNZbGx4RDZBQTlHelU4QUtjT0hnQlZVT1F6?=
 =?utf-8?B?b3BLWFBnTWVSR0pQMVZOa0RYRDJkQnpyVGVBWFpMbm5hS1c1clFPYkhlR2Nt?=
 =?utf-8?B?SmE0RUU5cFJaN2VvYVV3ZnVERGR3MWJXUkIvU1dCT2xWMU9kM2JIL3Nadzhm?=
 =?utf-8?B?aGYzSnZTU0tKVll6WmZmVmcvTGNCSW9yOWNLdzRaNWJ1aS9aQmcyOGFKK3VT?=
 =?utf-8?B?b3cxaHVubDFXK0dzbTN0c0R0cmozMUZGcjNlQnJkVHhwNGlKaEg1MUJyV0pY?=
 =?utf-8?B?QXJyMXJqZGVNazFBZzcxNGhMWkJ0b3NqVEdKQ0g5VmtpWE10d0ZGRnd3UnJB?=
 =?utf-8?B?M2FCTjhNSnM0RDUrUFhha2o0cm1jNDhQaHJZUCtrdGJtd3NIRkpWcE0vSWsz?=
 =?utf-8?B?aHZRSXAxNm1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhnRU85bXZDV3FqMW83QXBsVVcySUpIc3VZR2V2YjhXVS9TajJuS0U5YUhD?=
 =?utf-8?B?Z3Q5ZENQZXY0WnBKZ1p3NEJLa2tYLy85NVRNTVY2dkx4dFoyajFNTTB1S3Ir?=
 =?utf-8?B?U1hKSGJDdWNvaERYVk0yZzllMkVneFBWNWZrdmJ0enR5M2ZVc2VTTHpER0Zh?=
 =?utf-8?B?NVRDNlI4OWU2NjdOZUt3TURFcGc4aUhBOTFBSW4zeEVkbTc4R1U5eE1ieTJj?=
 =?utf-8?B?NEl1L3hXdGNMbkZ4d0lrZFcwKzBPK3RaQ3d5NkYrK1NXeTRsT0hIUkxrR1dO?=
 =?utf-8?B?elgweTNScHhCSm9uUzFQNUw1ODk4bmNtcWdUTVNnU3l1UkRWelpmcHMzTEVR?=
 =?utf-8?B?UjE2V2xkL3NwK0lxenpydXNicmtrTTMxRnZhNG9WZ2hCbjZsWEVhNFAvUU4v?=
 =?utf-8?B?aXM3aFFXVEVPSVZoYUdWMTVBUjVYNXhhUmZyN0hxdXpBT1FVYWxCcjBobnBH?=
 =?utf-8?B?K1JHWHRyVTZSemRDYjRCdkFWUEtIZTByUDAzSERzMnBPaGR2cmxoOE9RNWQ2?=
 =?utf-8?B?RCs2dzlqSTI1NDFrRFdFZWpTbUs0c0krMThnYzJOOHd1L2k3VytpNUlwSEw5?=
 =?utf-8?B?eHFuMTZqSnFSUDJOMXNWQ0RUcW9ZMjE2R0RDRXdLTUg2MGp0RCthQ1pnQ0s1?=
 =?utf-8?B?YzBrRDYybVpyZURXOTBzWG9rc3ZyN3hobG01QnZqR0EwSTlhNkZVdC95ZmVC?=
 =?utf-8?B?NXlvYUc2QjY2OFlUUWNGbTd3STIvcG9rM2txbU16ZmNyVFdmQ3ZxQjdxcWFQ?=
 =?utf-8?B?QXNTZVdsOGE0WmJ2aW96UXJCYjd4OUVvRkVSSnhjemtXanI5dkgvVDV5RWhQ?=
 =?utf-8?B?M1JseDJ5ejJSOE5naVJaMHdOYys0K01LVUdsVHJiUitNMFNYTklhTk9Uc3RL?=
 =?utf-8?B?S0l3b0o0R2NDT3hOTWFhTnR3ZmFHYWxmOTN5THFkZFo3MHEzb0VGS0JVUlhK?=
 =?utf-8?B?VlMxM0p6SFV1alA4cjBhL0diYU5IRFFsVjlHRDROTlIyditTV29xTDdpZ1FD?=
 =?utf-8?B?cHROMFJVQ2lMTHlUVEhuc1ZiWXhYUE14bWw0MUFMQ1hTOTczTCtPTDRSandX?=
 =?utf-8?B?anZqeDk3S0VrbHYvcDU4MVJQKzd0TGFNRVFmYWpydVZtSGN0SUhtZEVORFBy?=
 =?utf-8?B?MXRNVnl2dThGMDU3SE5YTU03di9pUVJBLzF0TlA5OXFkcWx3M2VHMCtSKzhH?=
 =?utf-8?B?NFFpSXBSU3VGZUxTdTMzR1Z2ZlFFU1NGNDFINTBSUDQ5U3AxYWpSLzE1NWpE?=
 =?utf-8?B?clI5VEowbUhucHZ6cUtxM0dZMk9DQnozdXZ4eElJbVIyWHpTY28xY3MrZUY5?=
 =?utf-8?B?ZkxiM3NERUdvQWJtQnpHNHJZcFVJRFhPdDUwcFFTWHdOcjZRdWxXTVgrVHpY?=
 =?utf-8?B?MXk2QkUyc1VRakppL1h0Y0tEWVdneTRiSDh6a1RVRlhoNTNmUzUzZGVEOWp3?=
 =?utf-8?B?Lzk3RjRpekEvV29FSVNmYWVwTklHRVJ3RmdKN2dUKzBCeFU3T1V3ai9KVjNn?=
 =?utf-8?B?MXJqUE1GMVYwUXJWWVE2NmQrTTdXVkgxUVpkT2ROK1U3Q1J2VTlDSHZ3Vk02?=
 =?utf-8?B?WHlIUjRqMm5wTk9sRDBtcnFhVEpQbXJXZGpybTY4TVNYckZaallvci9jTXJs?=
 =?utf-8?B?UjJWVUMwRlBMWjlvbVEzMlBXeWVxa01DZ1J1MEJRa3dVd0dkVW9OMldCSVhk?=
 =?utf-8?B?SUc1WVQ4Z0U3ZjR1cVR0WFRWL2VUTzhOT0QvT0F5cFBoc0NYekRjbFdYeVJ2?=
 =?utf-8?B?azFzVDcvU1RLSHlvMllMcDdUaEtGVGhDTE5oYzlHZWN3czh4b3VjQlRRZlZI?=
 =?utf-8?B?eDdFVmVhYWZuSnJWNzg1SU1VY1Z3di9EYW5wL08yUGlocHc3dTI3NXpPMWd0?=
 =?utf-8?B?SDNXS09lb2NNbzRjb2JVaDgvYW1zMnQ2RGdpbUtqaFp1N0dFVUNQRXRkajc1?=
 =?utf-8?B?TzRlWlVtbXRKVklaZHhINWROQ05iblN2UmZnaHpGRUlUc2xGUndmL0Jrdzl1?=
 =?utf-8?B?SHFoQjd2eCtxWmJUaDdGNWtSb0hWRG1Xd29uUU9QUkJLNGFoeXVBYUE0bk1u?=
 =?utf-8?B?YmpGd2hEOUdJUDg0UVhxa3htTU1md3RjNHhtMWdDa1c2eHpWWHBsYk9OSEFB?=
 =?utf-8?Q?07iu5z4hIuZN76Z63Kaoffs9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8212bc5-b88f-4c23-5c9a-08de2d4df2e0
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 00:43:14.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IR2awBb8fgybvj6wp2xfAGH30I80stUs1mT9N217YysdIDVEwWayXp4GeGaYEXPwqCWRM3BnhM0aLp/mzvOgnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Patch 1 Adds the binding for the MSX4 CX8 switchboard
Patch 2 Adds the device tree for the MSX4 CX8 switchboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing the NVIDIA MGX CX8 switchboard.

Reference to Ast2600 Soc [1].
Reference to host architecture [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://developer.nvidia.com/blog/nvidia-connectx-8-supernics-advance-ai-platform-architecture-with-pcie-gen6-connectivity/ [2]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Changes in v5:
- Fixed the spi-lane count for flash0 on the fmc.
- Cleaned up the commit messages per Andrew Jeffery's request
- Link to v4: https://lore.kernel.org/r/20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com

Changes in v4:
- Changed model name to be accurate per Andrew Jeffery
- Added comments about why there are no i2c devices described here per Andrew Jeffery
- Added support for probing the backup spi device through fmc
- Link to v3: https://lore.kernel.org/r/20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com

Changes in v3:
- Removed mac and mdio node completely per Andrew Lunn's request. Will add back
    once the mac driver is fixed
- Link to v2: https://lore.kernel.org/r/20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com

Changes in v2:
- Added ack by Conor Dooley on patch 1 
- Changed phy-mode attribute after discussion with Andrew Jeffery and feedback from Andrew Lunn
    and added a comment with a better explanation
- Link to v1: https://lore.kernel.org/r/20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com

---
Marc Olberding (2):
      dt-bindings: arm: aspeed: Add Nvidia msx4 board
      ARM: dts: aspeed: Add NVIDIA MSX4 HPM

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 246 +++++++++++++++++++++
 3 files changed, 248 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20250908-msx1_devicetree-7af2c1fc15d0

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


