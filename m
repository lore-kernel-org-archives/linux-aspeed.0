Return-Path: <linux-aspeed+bounces-2990-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83D4CFD368
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 23:15:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFhVv37BMz2yvV;
	Tue, 25 Nov 2025 10:15:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764026103;
	cv=pass; b=Jpnf3GOrWGkasEwIS4jbHt1zAD8Ytpcg9VDaEu2BB2kGOvv/FIq3tuorwbHuxVpchOmHKKzw1rUaj7HF4e+1gfOzNcNj3qbostxHrOx7KN2e9g0BZqKd4m3hZBEJxGBFJYjqBVG67BN2+7+/jcFHroEAW6MARfPlhtLyTZgBAkfLZnUu60+XviJQEVWIx89rsai0eI3+D3P7/kF7r3xbf98uE/12/c8Ulhn/i3KmLEx5L8hUwrYPyxXOEdGdwQJgzlCwgBdkVzp8ZhHtb20JXI/b5noyLbkoZlMdUV+PKfzT+RlOsdLck0jQvsvd4E0AXOTGl1lSrhivRzuPQUoG4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764026103; c=relaxed/relaxed;
	bh=6BWHPUDrzjL57oVUOplMHhRYydzYlGWDEouYHJqGXTk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GY0cB8/qlXoj/HdcU3rMu1FxYImd6atqvfB+WCJ4ai9ElowqVflf1RJqCvJEqG3tO8+TrY43B4UYhjWA0aHS2E6wN9K+Vo09qZ0NvLAL2LIcQhJN4Fm4rMDOtYF6tUxfBSbnEFqHueRE8NNYGg5lvKOruGyNx67Pb4CPaoGr0QEeeNLoiFFLrXQqfRPQKnOUclkxArjT+k8rRznpRKKDnxyrzi0/BIbuOO5zAHQKsCoNxFHsDpjGTICoD7tcJuu6UQZ2nIOQzQr5OXkUZfO06QsIL7199OD7fN+mwDdtQgFDStDlEJhv9bcIgQaeGXzRZhySXEfOXN2YnU7wCcfc9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bYn0/U1b; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bYn0/U1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFhVt6yjLz2yvB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 10:15:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGwLJHKg3KCxh2Urercn2rt8YU1p3JEE5y9IjFMP0VtF2CcibMirWsCCu6jV2accgB7mBSnIvrN5XzoX+GPBxTfYGhMrPygwNm3qtstX02XoTaie/OBPsFH2ata15JMZDz5yNxMsskPjRd7B8+QUHR3SrKI3KvhPKEC24SSgc5N5CQgkzxi99u2SIMLrAO3VlQHC9OFea4hILhwei4zEqNSLcu69lFw1yTyI3kibCAtbnlywief4zPkdPXXCJGBsiUtptxCBhlq7igoHHo5sEQr5k5N36EZPIu6alGurPs/d0EUbtRSV4+kT2REKKTUmFkyzK5vHqsZJfa19TgFm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BWHPUDrzjL57oVUOplMHhRYydzYlGWDEouYHJqGXTk=;
 b=jCK+LNnY7fEqz8dnb+EgfyZVCg1PJjREolbhR/z7uqa4wXpVBan6CjC5ADrH6e3EBSDUCTqTAhlkLXQ3i6tzivvNKmEbqXdFSTnURhAgSw534gylcSZjI2ijLeSyXu06mSOem+4j5s5v4kbV1GEMYwca/LO6jKoydg9oUag1lqJ8Fn0D8LG51AQoGqJFNA0ZQu700mV81XJ7MYXU/orl667gLMScrvIecn1LyToQwJXIz1PhfOGCBOA189uEShRcRLdVYO7TxLNFDww+OEL8y8xsacC/wfeQgawaNCRYkeXcr55dDU46SXa8/+uI/kEbGw5TVXhf3yQGWZcr8sRBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BWHPUDrzjL57oVUOplMHhRYydzYlGWDEouYHJqGXTk=;
 b=bYn0/U1bDlcygJp3PL/vgWs8AP8t5ayOtPzTfCmL0UpHwHgbf7SiuKtRO1DmjPg8Uj9hXKfH2U3UkELx0OVm8QS190930iOzbwYZeUaBO3iesBHZx6s3AUDzgb/owy3NsAkRmrbMXIGnkwbEFFfE8Gj9M7R9KPFRxPj+Cj7KCNWYCWwwd19zufkz4d6fxlYrGHYr5LZ4OJA1bYdXChPMIrsE7Mgv+Lnzx5euM1BzNTtjbgcwf0mkFsMrLPTLO8o9frCrIZOxsSwPfEJ9AoIFXg/8amsrNG5Sg94D15QsFa/8CTZJH4NVViUJ8vcyJht5d8ou0l+45YhfXsOe01I1Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DM4PR12MB7598.namprd12.prod.outlook.com
 (2603:10b6:8:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:14:38 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 23:14:38 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Mon, 24 Nov 2025 15:14:18 -0800
Subject: [PATCH v4 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-msx1_devicetree-v4-2-a3ebe3110a67@nvidia.com>
References: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
In-Reply-To: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764026074; l=5833;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=uIpwsGUhiUlqJpD1YLKrVP7o+zWogDPjtw433an5/58=;
 b=MSi4XJ/EyLQX8mXtVNRssgGPnxqoXj4NbKWbhfAcrHDZzGLdV6cTsaAsPSNKUY4TnNm66rf0Q
 aQTXi5AGLxCCFl23+FIJZrQCV5OOCLg8+8ZpP+LyFTgKcz4MlIXGAl7
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a59a65-991a-48ca-0d72-08de2baf3d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cktWMyt6bEIwaG1oL253a2xCaVNad2F0N3dZYUZaalR2ay9CWG9LZUREVGk5?=
 =?utf-8?B?TVhrYVFMVlZRV2ZpQVNKY2FxM1JlMHMrOE9oUUg0SVRoMXRNTVVmbXY3MWdt?=
 =?utf-8?B?M2JTeDVIV1BMNk45ZG8yZkc4N084U0hOYzVTMVJXclQwSWtIRWJ5MHZKZGZY?=
 =?utf-8?B?YTB3K3dLeVk4T1BVRTM5aUxuUWlMWHg1WGxyTHR5b2xrU1I3ZWs5NnZHdTFJ?=
 =?utf-8?B?ZFZMTlpldVA2bTk0eDN2SDNXTlR6dURac0J1ZTVaUThvTS9vK0dXcW4xazU2?=
 =?utf-8?B?Wk5rVnp3UCs5a21DZ2pHdVpoT2tvbk1Ma1ZvMC9vS2taZUhDSVN0S0VIV2Nk?=
 =?utf-8?B?VkNveWNpY0NnN21mQlUrOGpacTQ0UUROUHFMa1Qxb1ErQnlGaUdmOXU3YlRR?=
 =?utf-8?B?NnVibUoyV1lmU1JHVDRzNzNpV0pocFFMempyamhqWGwwaEZBYWhuMHZodmtm?=
 =?utf-8?B?d3d6NTlNTC9Xam5iWGprV3JORjBYMUx3ZnBTd0FBMVppU21iUTZNbWVHdU95?=
 =?utf-8?B?QnIvQWFKU2JoS05FNHE3Ym1lQ0NjaW1xTXlpUHNuVGlYMVdVQ0sxZjg5a3ZN?=
 =?utf-8?B?OGwxTFpVNklJL0RKc2lGQ1cvcGtJekdRTk9GaGlEc2V1ZW54bSthalpkOTF4?=
 =?utf-8?B?Smt6U2dVWmdYak9Qejh6cm5VTmorcXRmRkFwWm1FdHF2TG56R3dWcnFycHov?=
 =?utf-8?B?eTJpY05KUjZkN2gzT1BFdFdHaDF6cDVSZnNkWTlLL3Y2WkZ0d1VzU1hCNmVH?=
 =?utf-8?B?OWZTNGI4UTA5SGZSNzAzZkpFNGw5RnNEeWpUQlFqUlMySVlFRStYV01jTWJo?=
 =?utf-8?B?QTFyTkZydExFdis0Y2xUL0hWVGY1NU11MG01aXo4bGx1dFo4am53VFR0V1JK?=
 =?utf-8?B?N0pGRHhrNlBocGVlbWc0QmZoSUlqNCsvbzU3Sk1jeTBYOU45Z3ZPeHNySlRl?=
 =?utf-8?B?YlhOMTZjT3hTQkI4Z1VFNGZhMTFmbG9lT1BvQ3YxdHh4bjFzZXUwUlBQRDVx?=
 =?utf-8?B?Mmxza2I3YWtCWkVwQklldDdzSm02aEZuQ1JjNTVHeEdVMSsxK3hzU0pxTEI4?=
 =?utf-8?B?L0RWZVQ4WlJTWUZTUURSdmVISzdra3lEZDRRZDVxT2licllnR0JYTkpGREFt?=
 =?utf-8?B?SnRLYXVJSzhRWEVjTkV1WUJQT0N0ejN4MytvUWtIL3RXWDUwblZjdHVzM0ZR?=
 =?utf-8?B?Mi82ZjM3a2toakMvdG5YL0pEV3cxSHVhRUVYdFNlL0JRY29PTUpWR05JVGU0?=
 =?utf-8?B?QUdqQjlJbUhpYk9XQlFmaUFrMjhqUmxNelE5UnhEUDN1elhwVlpyZlNJRldm?=
 =?utf-8?B?dEFqUzVlaDNYREdYcUhMRHlEVmZKOGZkcTlQeXJFR2J1YnZXTjRDOU9ycmJM?=
 =?utf-8?B?VGhwVDNKK1NRVVFRdXVFSFV4YXBiT003N2xBU3hMUE9aUEdmQkhjTDA2YUpJ?=
 =?utf-8?B?aGZrZUFWZWREbTJPVXVhd3JObUVoYlBaUmpNTVJSNHBOeGJXVlZ5dks0Q0E5?=
 =?utf-8?B?b2pEczNISjNtK0l4NTJybXdReUp5bHZmT2hRalZnODlEK1lnY0JHbVRNZ0M4?=
 =?utf-8?B?b1NKN1dJbjRFaUlJSzBkZ2g5RU5FTGpMbmovNm1TbHpsb3FUUHVzdHNqczdN?=
 =?utf-8?B?a3doamdGamRpdmEwM1V3N3lMZEJZN2huVHV1RjNhWWVyWENwYzM4WHZHNC9a?=
 =?utf-8?B?UGI5YUxhV3U0ZHlVOFFhNSt6enhEK1hkZ2w4dlZ5NXJOZXVNN0h2Z0RLV28x?=
 =?utf-8?B?UGtyRGlrT2lHVFNmb2w2Rldka21teDN2M1BNMmpjbGRLTGRpa3BVMGlIb1hE?=
 =?utf-8?B?Qm5ERllUVVZ1Mm1MOG1tM1dLdVRabXAzcGRXU3h2MVYvTVo4MXlDZXFGZ1V5?=
 =?utf-8?B?V2hGUStBeDdsWStZWGlqN0tjTERUSlVrSVVOK2ZNQUgzY2dNZ3FENmRHS3Vt?=
 =?utf-8?Q?cqeWZFiEAhi4+Tr2Liv2TZjskNUil0j4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXhKUDB5djdOc1Z1V0lBWjF2bStuMVgwai9pTVJQS1d5b3NIVUFaTDFjWmRv?=
 =?utf-8?B?VXpxaVNGcXp3a25jcmxGWnlaTHdEMGJIQjUyT3hSZmV3UmJaMXNXVnNMUzB6?=
 =?utf-8?B?bmRGdmtFcXYxczBNYlFWdjhjMEYrTGxKUVVibmhUSGlWY3FnWHRGKzRROWt2?=
 =?utf-8?B?cnpYMlB1VVhLRzNYdEpNbTgyZjJEQ05PQTVZdTFpa0xHbEVDWTJhbzBaRGM4?=
 =?utf-8?B?eU1OajZWK3o5V3ZHZFk3ejN4dDJPVGtRT3NRdDN2SU5xOUJUb0d6Sk5SOGJM?=
 =?utf-8?B?SGw5Wm5aaWc5aEN2SDhKM0RCYThFN2VpN3ZOcGZsTC9MeGNDOFRyL0FRQmJL?=
 =?utf-8?B?QkhOVCt1c2Vlb3BlUXBoUll6d0g4T3VCa2puZ3hDdG52MmhqeFVVNnYvMUpa?=
 =?utf-8?B?ZTBDZGdwMk03cE80U2ROM3p4bHZHN2oyY210d1RjeERmSFZJRmlCN0x2RmpL?=
 =?utf-8?B?TUR0QUIzamhmeFYwaW5yTEd0eWJDV1MyV0RUcHNyUDVNOXpBV2lVOG1aakdi?=
 =?utf-8?B?NXU1T05FTjJ2dGowdjl5Z3BrcC9rT0Y4VzRKTW9tRDVzUzBtbUQrRHUyY0ts?=
 =?utf-8?B?VUdlYURKUWQ4aEk0Z1VlWXBqVFJxbGdrNnJJNnB0V0NaOHJhdHB2bG4rSDY4?=
 =?utf-8?B?dzdXeTR3aW9ad3phbEFBdUQyWG85aW9tWG4zMk51T3lTcmZ0bzR6TG9NM0NZ?=
 =?utf-8?B?REZzVmMxbEl1Sksrb1FVbXNnbDhsV3o3bVRLVEd2Zmo2NWg2TlVLZVFHL0ty?=
 =?utf-8?B?RUg1OWxQOXZwdE1GRzhIRkI0QVJwTU9BTDUrOEkyVC9JQkpFbW9TNXFvQjNX?=
 =?utf-8?B?ZHhzaG9vWForYjFMcVkzeTlyUVhKNGU2Y3hPV2NlZDRLWGIrS2lnQ0wxV3dt?=
 =?utf-8?B?NGF4d2N3R0FHQmR0RytrcC9lWXdXZFBHNm1jSUozYkxFdzdpSGE5S2dJK2ZV?=
 =?utf-8?B?MFdaNXJDdnY4TklQaWYzMERCZ281Zll0amdjL3p2RW13THpzdTR5ZGRWazNm?=
 =?utf-8?B?c2dzeVExNldQUjVZRTdMR01JRWJINWoxdHRaangzUVdPRFB6ZEhSVW5rdzZK?=
 =?utf-8?B?MjM5NHdjNmxWWlZpZFA5VC9CYitVRmEvR1J0c0NPU3dZSG5WN1R4b1Jqb011?=
 =?utf-8?B?T21LQlgyMTZnQ1pDaGhOd2VxQjg3RmxYN2x1bnpTTm9vMG1ma2FhYk45Y3hu?=
 =?utf-8?B?bVJJTTNUdGZnS0VBYXhOSy9lYmtRV2kwMXgwNkJhWUdpVnRKVG1iVU5rT1Vr?=
 =?utf-8?B?ck1LcU5DSTdPK1ZBVThFalA5SVd0enRWYk1NSHRZMlUzV1FvZlpGUzMwdHZs?=
 =?utf-8?B?SVJIMWhmNkJjWlRZVlA4NVFsT2ZoUXlwU3dLOFVPQy94L3JHM2lXRXVETjFL?=
 =?utf-8?B?ZjNkY2xXcXlqd2lnc2NENHlvbk92ODBEUUMrcE5QaFVNREYza2ZvZUdvSXhq?=
 =?utf-8?B?MjJwaGovZW93SlFXVUMvYm00VnpjQzU4VlA3cXRYUTErZ0ZMVGpWekVLS0tH?=
 =?utf-8?B?RlVxV3M1NnJnRUpRSm1TaVh6RDFLQk9NTTIrT1dpUHRNajJqUWx5WVF0U3RB?=
 =?utf-8?B?MzNpUmJOSWhuYnlpYTZ1VHN1V1hJSFduUXJVRmdNejAzSm1vU1ZjcVo5WGs2?=
 =?utf-8?B?cjYzdElvb3JvVVF6UzhTb0RrZkVXY2FDL1YzNThxM1pBdjNlUGZaemtNYW9k?=
 =?utf-8?B?b04zZGM4c0VvdGdVZHNGcTlpR3dhL2J5djhFRWhaU3c3SFhJQSt1ZXZaTy9v?=
 =?utf-8?B?ZlF3ZmhTanRnQXhyL05xQVdVaURZSytsbGRadUpmRHgzd0pNWjhkbXlwOTRW?=
 =?utf-8?B?V1YwN25nN2VtamR1TjdSbG5YUGFCNmVGWm9tVVQrYWtNR2lpRFI1WUo4aENF?=
 =?utf-8?B?NDR2NjJWVzZVZEszb29SMTZqbG9PWVd5TEpuMThhajM4b2NtYUZZRjdtT2w4?=
 =?utf-8?B?LzFuQVhIUno4NVVublpZTVBLei9kYjIxdmtaZkVzY0ErdGVRaUJaeC9EVnlk?=
 =?utf-8?B?bEpOVGhRSy9BWTZuWEQ4MkxxQnhvQ1RxSnNzNXVXRGJWUVdCcmljMEJ6aU1T?=
 =?utf-8?B?b0N1QmlNd1ljYVJmMTUzTmY1dldUTkRaQ3JmaUVOT2t6ZFNSeFJidURKMFVR?=
 =?utf-8?Q?BmMXCfz5y1IsYOzNplL0Rkrea?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a59a65-991a-48ca-0d72-08de2baf3d87
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:14:38.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyaBESOvsYYqlwN1ouCSUIoyoFOc4pA8c/Pn6Bp24Zty+JgNzvVPDGLrdXaIv4W5qzaLP7TvtkTQ2ypeomE1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Adds a dts for the nvidia mgx pcie switchboard reference
platformi hpm. This is a dual socket granite rapids based platform.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 248 +++++++++++++++++++++
 2 files changed, 249 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b7076545e6babb2f25f302b5d70b71d8a19..c3ce0d218b53f2b4c37061cace483f5f2c6d3bf1 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-msx4-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
new file mode 100644
index 0000000000000000000000000000000000000000..79d46c2c6cd3e1fbc9408b9b3f941a8d13177853
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MSX4 BMC";
+	compatible = "nvidia,msx4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "uart5:115200n8";
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
+			compatible = "shared-dma-pool";
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			reusable;
+		};
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		label = "bmc";
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		status = "okay";
+		#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		label = "alt-bmc";
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		status = "okay";
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
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"ASSERT_BMC_READY","","","","","","","",
+	/*C0-C7*/	"MON_PWR_GOOD","","","","","","","FP_ID_LED_N",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N",
+			"","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"MON_PWR_BTN_L","ASSERT_PWR_BTN_L","MON_RST_BTN_L",
+			"ASSERT_RST_BTN_L","","ASSERT_NMI_BTN_L","","",
+	/*Q0-Q7*/	"","","MEMORY_HOT_0","MEMORY_HOT_1","","","","",
+	/*R0-R7*/	"ID_BTN","","","","","VBAT_GPIO","","",
+	/*S0-S7*/	"","","RST_PCA_MUX","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","BMC_INIT_DONE","";
+};
+
+// Devices on these busses are available after POST
+// however there isn't a great way to defer probing
+// until that point today, as the BMC doesn't
+// have direct control over when the host completes
+// POST, especially from the kernel.
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "atmel,24c256";
+		reg = <0x51>;
+		pagesize = <64>;
+		label = "sku";
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs1 {
+	aspeed,lpc-io-reg = <0xca0>;
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&lpc_reset {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <80>;
+	status = "okay";
+};
+
+&uart_routing {
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
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};

-- 
2.34.1


