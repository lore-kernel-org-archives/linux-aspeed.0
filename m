Return-Path: <linux-aspeed+bounces-1991-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F72CA0ED1
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 02:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3jBn0JxSz3clq;
	Sat, 16 Aug 2025 12:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2407::619" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287256;
	cv=pass; b=kQDQHcyD3lHhV/LAadslvzdNoatCog5Qv3uHoUIUwb9JTeUZbSDWtJ63kDxtW94Hulpwmb/EY138597diRwB3xZyO/vdO8+VedMKWl7ohaXuJzevYmzEgWhX0m1TCiAao3E825F8h3FEZtkF3BULeh3XboB8WdhycOusU5ypJAKKn5xSuV8HFWb/ZElB1vX87zHUFawbBat/toMTkKFVS+3WC7vvbG7wyuzmFcIlzsWt5QKmjSng413Cz9GUwiVaRSTrNTdGW/SMb4pq8kA11HmaMOtNs3TYS3cqRvEOaZ0WUdWAOvy72Rg/aTGGU/J0t8iyVNimnyKdpI8rRTz2ow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287256; c=relaxed/relaxed;
	bh=etT4e9jCLyYcNtzM5fV8W4ut9UjLRRbQGTk1hIXSjG0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WtS7c0bZCq2A10FmE478WGkso6UfILpaEHplKELAnwUQJt7DFEqUx08ThQ/+vb53Y5m1l4v9UJfr1nTnAfREU8wWu6+qYlkWKGu1BrLsygSK2xHtDTDkFvLoO+Cr1a8wJcmxATJDsYpr4EG8l1DwRVHfVETmANXu/flK/iU53d2TXvrf1nFAd1xb6sPamPAB5MWopeM+Tan5wSoy0QXOG2Uy80nk6nQ/qOsjJMk1bPnNYzFHM/zJcTztnLYYgn/7EJEEE+2218s0fjmHuHOeEhHXqycazRfBbydy3bnUEswXA6tk3FCe2Qp0FgfQz3JRLhXvfrF3LAJyocXtwqyumA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oD/b+KtA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oD/b+KtA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::619])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Xh76rVRz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU1N6OBX0/v6T4ZjPvYoCaHNQJFGudhGKrAqMvTh+RN8iduNbAPvPjOuxq2SHrsgsUjZYcZm6+hVCI+NssB9E2vrJQKvAxZYYl6Q+YPbgLfvdS1WQBMKiFHNDx8hOnS50FPQdcU/Bf9ylfi5QrC6oQeydETnus/PeRL8bGdGnSUjcyP8Y2KdYAVm0CXGCcfO3EYWaqaZ/VfWV2YZLsQnsZnX5Ce0jkS48L1zI4oYgKDksvkR/G04cZ8suhvvn2Ex9Qtzag3tiYI66TIOKagM9Sb3U/PkIQ0I9QPHdyxF3+IQayXuwOH9FBl60KFcC5JZoyIrUaYFb+84qfm0b0pyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etT4e9jCLyYcNtzM5fV8W4ut9UjLRRbQGTk1hIXSjG0=;
 b=KYw7iz+QL47r6Zb6KerkcNsipguXYarmyWSAQWTUonDaUGHx9qZr5rvVsR6y4KIjmNm145aGIVY87Qs+e0yJgIEoUn6JVpMwsO7sVEjEuQq8r5hWjmGqvhMch7uDUR/HCtazaKp/9t69+KyqYoBLsQ0AKuoZTRis9zK0VPynzrmDU6JqdyZGTg0MAQLUsKiHRy6lsoDziAGUSipuCSsydHsu20WL/NOTaJNScpmCRsKXC3Z6BLs8pTRGt7Ayqstro4O0RMmUQmoXJPDFCz6hRbF/yjQra4u6qbQguLdv+siIVAQL8MB0OZ4QpwcgfosxhCqHoAp6UP+57ad6p7Z9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etT4e9jCLyYcNtzM5fV8W4ut9UjLRRbQGTk1hIXSjG0=;
 b=oD/b+KtAg7Di9/G/1mKBdfskPCjCf4GOiRqUrEh6uKH4/MV+8SZwGZaEgnvHaRkbuNOeDkcQLkggl70WQuJz2kmFYaKqLmvlBxvo6cV8AZZ4nuXeJGwJHr+/Imr7B3y6ITjwj0Bcgng9oYe11LG20GbL//6jTAg5ygCNVaJQ5MeS0/xOCWuVECa3povMSDe1iAgAwjdlIZitW6WkY/VbCcSEzKREi94LUxb1puXwvxSnsVf0m5cm2a2OlQKfQMQS//muTED++dZU0akI0kzCwxgIA1sTDnr6FOmL00rsdyPxuGQ3Ajb4C6Kc4JGa2zBvuXLbxPRJ9vLtgG7wDZqvSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB6864.namprd12.prod.outlook.com
 (2603:10b6:806:263::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 19:47:15 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:47:14 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Fri, 15 Aug 2025 12:45:56 -0700
Subject: [PATCH 2/3] ARM: dts: aspeed: Add device tree includes for the cx8
 switchboard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-mgx4u_devicetree-v1-2-66db6fa5a7e4@nvidia.com>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
In-Reply-To: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755287229; l=4438;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=eQvt3u0nFHIXL+eokDX6VYIJXaJ3OBDzQWprgGXKoyM=;
 b=Zaq0HTdDTBtPHucwJxugEbfVPKNXZnb3C5YqRuvEmpqO0xYLApDFPrGHVRWDUtkS5jiUA6QTy
 98G+JHI03brB5MZOeCTKSiydqB5NAynuYFWAzPo8Rydbls/h/QlUk+0
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e913e56-1b80-4b71-6370-08dddc3488af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1A0VC9NRFduTWxoOGh4ZlExN3dsOFMzcjNRUnFTNHYyMHB6SFlZcEhXOVBU?=
 =?utf-8?B?d0lLYmY5Q0lCNjlXWkpVUFpKUmFZdlRmaS9OS0dVaVovODhldmdFdUVZRVlU?=
 =?utf-8?B?Q3pKaFRwdEFYSjlLK1lwWlhuQU9hK2hkeUxZZ2U5cTE1WnpNZmo5YWFlWW5L?=
 =?utf-8?B?dE5wOG1xU2szRm55eHZTdm5QRExLL05FTkhpYk9xNnIxREUwTWxNVEtqbHpn?=
 =?utf-8?B?U08zaXd0VDR1QVJRckxLSHV6d0licXcxQVVtendkVHlEVld6RjBwdGRZRU43?=
 =?utf-8?B?Q2VUaWhBS0o1L2tFMnUrMGpaN1l2a3hhZ292em84dFV3YWp6UUJ4V0ZTWVR2?=
 =?utf-8?B?RzFWTlVLNkVGdlVuVEx0b2hZeVVJeEpnd3Ryb1d0YVFia1d2aXczbUlpVGlR?=
 =?utf-8?B?TnQ0OEZhd1BuYmF4QThDditsWVd4ZGVNeDE0SFYvd0ZaODQyYWt0YlczVjNC?=
 =?utf-8?B?NlpBSmE0WmNIUDFndTZlSFo5RHY4cGM3U0czVEs3WERUaVlGUjV3L1dqM01H?=
 =?utf-8?B?aUY0MDFMNjZoNVpZZFRGQ2VOM2xvaXU4Mm9waFlEd3pIMnViaUtEZ0h1WEhX?=
 =?utf-8?B?U1NpQ1pZS0t6ZUtEak5ZdE9xOGdQMHExT2dQc1NhME1GKzFuenR0bDRkc1Jn?=
 =?utf-8?B?YytVMUtJZU5GbGtldm51dmp0czV5Q2hhL1RRM2kxSWJhYlAwdVlUSW5YbnZQ?=
 =?utf-8?B?T1cxVDFpKzJoc2M5QjdaaUdjTE9DSTFDbkV1UjNWbE9taldma0YzRStMcDAv?=
 =?utf-8?B?M0FTQU96TndyRldEMVVBdE5JeEZLZ1pybjJMYzRTOUVaN1pNZG1VVUxjNTAr?=
 =?utf-8?B?Rm5LaW5sRmZMblBDUmRNdlk1V2l3YTYzZU4yYUlsNjRIdk5UWEJ3R0lMQmFz?=
 =?utf-8?B?dGVSc3RZYnNmK1Vwc04wNkdsZ0FhVlVscmFpMnB2enNCN2tsdFp0akxNa2pC?=
 =?utf-8?B?L0hOKzg2WEpxclFoRU11NGQ4YXl0amhsSzkxYzFsNlN2MWFlNzJLWnVVRGFm?=
 =?utf-8?B?VW9WSWRSNUowQ0ZjN0JUK29qNXBaaC9lY1YySlZnUy9tbHhCM1BIQWoyWU1i?=
 =?utf-8?B?R3BqNDFZRTlVazBZN0E1REhqQ1dNc1R5dUxGLzJNc0psNlcvRFViQ05BRU0r?=
 =?utf-8?B?d1hlN0hNZmg0RWNaTy8xQ0R4eHl4WTN3M1lGbkh4bzBmb3ZxQXJnWGV2SUpi?=
 =?utf-8?B?WU0yclVPdmhRSDNzT2ZLd3I1Wk1XSHZGSm5HT0dPbGZCUzhiMEZzbjBTaCtq?=
 =?utf-8?B?ZzVXYnRPVHhpelhWUnh0d2ZFK3lTT1hLMzZpRExMZTExUmxiMjlkU0JZa0xC?=
 =?utf-8?B?S29qZGNGSHVDMXo0ZUFpT29UQ1F3NFdaSUFUL04xNDAyMEUxSFY5TTZTT0ov?=
 =?utf-8?B?Rk9PaW1JM1pGSzZ0Q1V1MkpyY1N0bW1RdjVqSXhaUEJmL0t5Z1VFd04xZHV0?=
 =?utf-8?B?RmcyUUVXYW80QmNrUVluSHNTc2U3MWFoWW9yVDl5TmRkTFFyR1FiOVM3R0NK?=
 =?utf-8?B?eG9qeW1zV2NzWTNyVitJTG1GWndoNlZJZUxqNkxWN2xFTmUyaE5DY284Q21I?=
 =?utf-8?B?OElqNjI5MldOZnI4U0Q3NWxoSlNpNjV4dnZPTTlPdzJNbENjNFhQbnNUL1B2?=
 =?utf-8?B?U1g5d0NQT1I0WGF0TjVNakV5dlNBdGwvcVJ4aTlxNjdLTWtwRmJyNUkzSTBi?=
 =?utf-8?B?Y2cvUUptSkQveGRSa3p2dm9Mc3JQcks1TjNwM0hCUGpqK1dYMmdSbC9IRmxS?=
 =?utf-8?B?SnFtOFFDU2tPYlljQmluejQ0dFgxNTF5eVUwYThWNzgycmxrRVJNUURkRE5C?=
 =?utf-8?B?ZXJTT3hKL1pqMzhrY2NNcGNtT2FTM1pMelROYzhwRDhkUFdUQTNjM2xkWUdJ?=
 =?utf-8?B?SlpUU0pZYkZFWmRKM2J3V09SWGwyZHU5NGVjRTZNOEM5NHpyZXJHRlprSWsw?=
 =?utf-8?Q?T9MbaqpRnUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDBFV0FQSkVEU05TK2cySFBlS0lRNUhlS1lCVVcxclJOM3dvbW1IZXhWc3Yr?=
 =?utf-8?B?cVlNN1J5ekdBUFl0Qzdxd0VqMGxweUVIN1ZQWVVuRjhuQkdVSzFXY09aS1ZH?=
 =?utf-8?B?T0hpaUtrR0N5V2MxME55cEhQV3RMeHBzbmVUMGFKNTNvYUNjMWVaQTlDeGIv?=
 =?utf-8?B?dERaNGgvMmZ2ZDA3eFZObi9oWXd6Vk54UXhWVXlmVDBzZGl3WFFyckhPVW4r?=
 =?utf-8?B?TjRhRGhxTG8xSTljZDZoa0wxSWlNYVpNUHBnQVJQV3BiUHR0Y1ZvZVdXc0J3?=
 =?utf-8?B?Y2ZITXhRd2Qya2RMMWRtTWRHNVc3YVZNRVZqckhUWnJuMXQ1Q0F2Qm5yd1BP?=
 =?utf-8?B?aXRUSHZ0VFE4YWwzcCtuNWd4eVNCcGdUQjV3MnBtVDhIeGNrZTZDaGg5NStB?=
 =?utf-8?B?OFFRVVFLMUxGa0xCbmJnM24wM3hxMG1XYm1JSWh4V0JpQUtaU3YrOEd3VFV6?=
 =?utf-8?B?Q2ZnTWtRRjBDNG9YS0FTZmppYldDVURhSUU0S3prSUxETnRqQTVYbCttYy9N?=
 =?utf-8?B?QWtBaFF0N1hDNnhIOElhWVh6S094RTdvaEVPeWQ2dUpKd3JNTHU3MXIrbUN1?=
 =?utf-8?B?R1YxUnF1MU9iSng2WEY4eDgxYmtCWDVVU3YxcGFkOGdkd1FkWlZORnFjbnFs?=
 =?utf-8?B?OUJycmdkbkQzbXc4ZVFneG9XajR4SFJDeFNET2t2WjZSWXUxQXoyZGR4YS9N?=
 =?utf-8?B?U3E2OTdnS0U5OERkOG1EbnRsd3g1c0xoeXBGN0RjQ0s3K3lPam8vTTc1SmM2?=
 =?utf-8?B?QmtqazdaS3FSaXc2WHFaNG1WTEZ6bVQ5NU1Ebk9aUDk5TzQ1enEzTFR5NVRD?=
 =?utf-8?B?bmlsRlNNYlZTQTEyczhwQWYyUmFDMUhuZEx6ZUYxNno1RWVwYzVpekZieTZj?=
 =?utf-8?B?UGhnQjMxeXQ5RTRob21LRjljWHZJSFRFcmxhci9QUWNvZEkvd21iMXllY0NB?=
 =?utf-8?B?R2hWMWduS3EwSjBHSUJIcXM1c0FaQjQ1WEY0aFUxZk4ya24zWTlIZXdvQWcz?=
 =?utf-8?B?bENJZjI3SzFHUS9yM0pSNGZ1ajFIN1lwKzdtK1kyTEp2dytmN3p0OHJQc2do?=
 =?utf-8?B?TEJpR1F2Z0NKL1JNUEh1SXI1R2R3Q1ZrSk1DUk16YXZFelUvZGV3STNlRHJI?=
 =?utf-8?B?eVBSeDhMS2JEVW15RDI5TU1EZVdvVzh1MFNnVnpUcjh6ajhUUjMxQk1pcDBa?=
 =?utf-8?B?L3R4b2ppTmhOUHYwYVkwWmMxa0xSTnhoRkZWNVNHK1dqZGJVdnFtZ3ZoajNP?=
 =?utf-8?B?cERtMjJSZHFRN1JqNXlaWS9Jbm5GRFgvQzExNTJvUVZzeGkvZUlOaktDeU1j?=
 =?utf-8?B?dWlJb2RlVEl3dmkrMmpVUEtOVVlKOGdNdzdOZDRYcHdlQkY2RWl6SXduR2JD?=
 =?utf-8?B?dk5kU2V1VUVadGZsQURFTEVKUVRxcXgwblBXbnB5bjNnVDRhSWx3SzJWeCtG?=
 =?utf-8?B?V01RYWdWUkNMRW5tMVNOaExCN2ZVVjBVWnZMQmxUVEEyWlE3YmgwajdWSTFs?=
 =?utf-8?B?MGVQOVVIVHZLK0wyOExxTTBRWWdyd1c2Q1Y5Y3FuZUdZRTdJTHdzY29uWVU5?=
 =?utf-8?B?T1ZMRVIyV1U5RmNiU2ZGRGliNW83VFlqSDdndHlyM08wYlMxbVJablpBd2E0?=
 =?utf-8?B?MGNzKytwdWdkS2Rybmc1dEE1QnYzMm5JU05yRHZaZXRwZ3Z2Y1NaVmVra1Fy?=
 =?utf-8?B?ZVhGSGprTGZtcDZJbTZOTUI1OW5HRG9ncXFmTEQrL3R5aG1HYlBWalROS3Iy?=
 =?utf-8?B?TFV3RVkvak5ad0hNV2lnS0FEbW9zQlIzTG9iV0FhOCtBZThlaW1XeG9rc1Q5?=
 =?utf-8?B?blJ1VW5oZzZESkpndVhsUE9DMVRtYzJDUlZ3amFkNXN3bXY3VnVSdDhlQ0ox?=
 =?utf-8?B?ZWNURG5zMmI2OG9LR2lYM3Ribk1CTEVVKzhCb1JtZ1dVSUcycmg5S1U1U05F?=
 =?utf-8?B?TXpYRmpkbXZxU1kvS1pWYmNyZHNBSW1rWHJLZVl6dkVyTnZ4RlZmVU4zTWRn?=
 =?utf-8?B?V2ZHVHlxTXI0QmlJUWZLRzNBd0lYdzlUNE9mYjE0bjVjczJqeGo2VFpjUTl3?=
 =?utf-8?B?cjY5dDE0eXJrejVMMXFGeTVwMmZjRitpTjdGWXViVmZsbWFpM1I2YkphOW56?=
 =?utf-8?Q?P3dOQ3pxerX3XkebuCetC7eaL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e913e56-1b80-4b71-6370-08dddc3488af
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:47:14.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfOLxrbm8unf/w4QOVGzqCvrtzWO6lYo6UJRVCBC2dqEMhl+/nWyDt/9yafgR1tDXIdcpBKAadhK8OD0uae61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

The mgx cx8 switchboard is used to network mgx GPUs

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 .../dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi    | 80 ++++++++++++++++++++++
 .../dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi    | 80 ++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi b/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..051c8cf0b7d12b1fa4c84db896ca480b21627e23
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+eeprom@56 {
+	compatible = "atmel,24c128";
+	reg = <0x56>;
+};
+
+gpio@26 {
+	compatible = "nxp,pca9555";
+	reg = <0x26>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-line-names = "WP_QSPI_CX0", "RST_SEQ_CX0_L",
+			  "BOOT_COMPLT_CX0", "FNP_CX0_L",
+			  "WP_FRU_CX0", "OVT_SHUTDOWN_CX0",
+			  "", "",
+			  "", "",
+			  "TMP_WARNING_CX0", "USB_HUB1_RST_L",
+			  "I2C_SWITCH1_RESET", "MCU1_GPIO",
+			  "MCU1_RST_N", "MCU1_RECOVERY_N";
+
+};
+
+i2c-mux@72 {
+	compatible = "nxp,pca9546";
+	reg = <0x72>;
+	i2c-mux-idle-disconnect;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+	};
+	i2c@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+	};
+	i2c@2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <2>;
+		gpio@20 {
+			reg = <0x20>;
+			gpio-controller;
+			compatible = "nxp,pca6408";
+			#gpio-cells = <2>;
+			gpio-line-names = "GLOBAL_WP", "OOB_RST_N",
+					  "OOB_RECOVERY", "MCU_RECOVERY_N",
+					  "MCU_RST_N", "MCU_BYPASS_N",
+					  "SMBUS_FRU_EEPROM_WP", "";
+		};
+		eeprom@50 {
+			reg = <0x50>;
+			compatible = "atmel,24c128";
+		};
+	};
+	i2c@3 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <3>;
+		gpio@20 {
+			reg = <0x20>;
+			gpio-controller;
+			compatible = "nxp,pca6408";
+			#gpio-cells = <2>;
+			gpio-line-names = "GLOBAL_WP", "OOB_RST_N",
+					  "OOB_RECOVERY", "MCU_RECOVERY_N",
+					  "MCU_RST_N", "MCU_BYPASS_N",
+					  "SMBUS_FRU_EEPROM_WP", "";
+		};
+		eeprom@50 {
+			reg = <0x50>;
+			compatible = "atmel,24c128";
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi b/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..cc8e71f374e100ba7f977138a21ea27a83ca36ed
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Nvidia
+
+eeprom@56 {
+	compatible = "atmel,24c128";
+	reg = <0x56>;
+};
+
+gpio@26 {
+	compatible = "nxp,pca9555";
+	reg = <0x26>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-line-names = "WP_QSPI_CX1", "RST_SEQ_CX1_L",
+			  "BOOT_CMPLT_CX1", "FNP_CX1_L",
+			  "WP_FRU_CX1", "OVT_SHUTDOWN_CX1",
+			  "TMP_WARNING_CX1", "USB_HUB2_RST_L",
+			  "I2C_SWITCH2_RESET", "",
+			  "", "",
+			  "", "",
+			  "", "";
+};
+
+i2c-mux@72 {
+	compatible = "nxp,pca9546";
+	reg = <0x72>;
+	i2c-mux-idle-disconnect;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+	};
+	i2c@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+	};
+	i2c@2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <2>;
+		gpio@20 {
+			reg = <0x20>;
+			gpio-controller;
+			compatible = "nxp,pca6408";
+			#gpio-cells = <2>;
+			gpio-line-names = "GLOBAL_WP", "OOB_RST_N",
+					  "OOB_RECOVERY", "MCU_RECOVERY_N",
+					  "MCU_RST_N", "MCU_BYPASS_N",
+					  "SMBUS_FRU_EEPROM_WP", "";
+		};
+		eeprom@50 {
+			reg = <0x50>;
+			compatible = "atmel,24c128";
+		};
+	};
+	i2c@3 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <3>;
+		gpio@20 {
+			reg = <0x20>;
+			gpio-controller;
+			compatible = "nxp,pca6408";
+			#gpio-cells = <2>;
+			gpio-line-names = "GLOBAL_WP", "OOB_RST_N",
+					  "OOB_RECOVERY", "MCU_RECOVERY_N",
+					  "MCU_RST_N", "MCU_BYPASS_N",
+					  "SMBUS_FRU_EEPROM_WP", "";
+		};
+		eeprom@50 {
+			reg = <0x50>;
+			compatible = "atmel,24c128";
+		};
+	};
+};
+

-- 
2.34.1


