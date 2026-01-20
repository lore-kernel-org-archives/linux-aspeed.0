Return-Path: <linux-aspeed+bounces-3414-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7610D26296
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 19:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwclR29vbz2xSN;
	Wed, 21 Jan 2026 06:26:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768937219;
	cv=pass; b=R8ZEqgFVIhmZpSFk7CbZcKnt7QUcxup1tSN/AXGj/oEWKtVGzhwKeZAV61eGRjbQ3xIl6YYwNQI/VkB2BOX24EYbUJ+O+eaahjUYW9mFwiGJq2Ss9o4wXlV7kUetIVzMOTJGsfre9gpHFZ25GTOXPBbwHeWiCbMubIwCUc/hNeFKeeYpH+IbKkkDiheP3HmMUeMRVKXw/mP5P1rPFJsTQ1CEMpKw0uPWvK2nZJGpMzZFNWtITccSGActfQOBv4GxcwKShgirJe70YEHCciBzzUalumCS7wLMDXuZ1vEh2bTDnL7saFZDNvAji2Y1NQqD5XnjckFnkAJbxn/sdnym2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768937219; c=relaxed/relaxed;
	bh=0XMcr+LPCugn4O3l8pz+MEan+arKMjlB5JY2cBjBEkg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YOX3g/Lr1em2PypkZW4SZdKVsZsc0MkTo0ZwSy2PyZoZQOg8KMyq/BlT9Rw9vjsgSwOYf2Hl/mtQzuYqKgfYAuN5rMO9ArAHQB2qpv/XFqh058c54GuJtPzA0Mpm37uorxGE5OFoAYpExDB7ioHPJHtLbFh2nBrPsmzcv0E2enNcPBoSOiMWfJUftmBrvIu5vHTtcxhZNJBzRZlCT07MnM9YAVzP891DF4HYRtH55DhFbuR6TQOKDvTgi9EHBcuOgIZ68HRfWjQuH6imjeHss9cjH4Qyxl8QAz/OY/ZdMVw3Y9MLZSxkJTS5UGAzCiDMIL8WzYgMA38BCAtGYKozdw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKG9jw6X; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKG9jw6X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwclQ6NcLz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 06:26:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLsRcpu2EHGUoAwWP+wAz4jLghgsw/dDmI9TNWDNY+zGES3UDz5GHhI0CUz7Z0VagAQUNInH+4JR9WV9Ec10BL8HWAgfMpQ92vC/xPE8dt2JIe7ip8RUS7pE9Z7oGjio/l2FVxqGjO5WhWkS+e07orc9KoOC7stohkxnddnAq6sP56bwW7CqZiZgk0UF32bLn2psI5hJt8SXqCnCcOQtMDc3PZtAPO/YzCXCWPCINzYXpR2rl68/pC74P47tvmuW5xS079hPW0vBOhz8NepzuVbRIakVyVAA7vSAlsoQzFD20nXjEMm2hZlYoX9DZ0TCjKL88zTJrIkqr3OG87a/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XMcr+LPCugn4O3l8pz+MEan+arKMjlB5JY2cBjBEkg=;
 b=ZHns8bXosFRk9xHpnHoADHSY56sWJVxU6kL9szmUuEBZfCJfJlxKSDe+8ZuxSkzqMufX79rDfDV/uq7xtsJxlm7gRt2AlLtrjfZlUn03baXkrAFJgXBdg81HPhZ7J/EYQBLc192eOzm2g6LHOhPO5xFOf9gU5uE2mhb/f4zTKdlo+IZdPlMGsDXg4yvXhxBb5U3EULZQSMf7snB2H420QeOxp+icKTqiM0RElMe2QrdOKwKmq4ZN8QBMtVg8pQp+IQtOY439tNR5TQQzNXog4/CPtL3SAyrV/4Xcx79xuIF+5N+X8KgLNZwJHYYSCt7K/EFw7gYHkq3FtgNcPPdZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XMcr+LPCugn4O3l8pz+MEan+arKMjlB5JY2cBjBEkg=;
 b=RKG9jw6XTwM5gtfCman7kiBNxKOhknrz8fJH8jAiU+V2j8UzmDBqfvI/4sxE6o8eA/OXjDXQ1nT8BBv2rxyoaqFzX6IeytbzQmh7Lv4dOcXqrkIiXjoV7NF3Kc5sgDhRfoWh+kmNovhGFd+6UkYCEOr3q0BRIKkRaW7vuR7QfE61Sr4Kr0tNR6wM6W6Wp7pqtw8qLLo361uFJMDgR8JNn+0PBJnLDEslH+jTJoCUyhNdqSI31bVXitmYoLkvK0abUa2BGx8gkkRGl54tIHw22N+sBk4bjsuwhiRmM65XEc/cbBs3pZhI6oZnV9EVl28sB4Y/cD2zZSbCSTweQWCb7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DS0PR12MB8296.namprd12.prod.outlook.com
 (2603:10b6:8:f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 19:26:34 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 19:26:34 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Tue, 20 Jan 2026 11:26:17 -0800
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add alt partition support to msx4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-alt-128-v3-2-a81bdafc00a7@nvidia.com>
References: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
In-Reply-To: <20260120-alt-128-v3-0-a81bdafc00a7@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768937188; l=767;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=b3YE5gtfNXHybMH9VSZzT2ijd6wYTeWCFl5lAEbC8pw=;
 b=zngc99jjvRHc0stDIEHGETaiuiYEB/v0cqYZyx09DGMw+V6m4BDn3CASJjjHXpduAnFmrTjX5
 YXsc8mwDJO1Ax++z52gzFhIVf5g9C1xswPBAoyubrFW4Albx6bor4S4
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 930a139a-4a1c-406c-f5c2-08de5859d25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b04vTDB3ZncyajVzVjAxWWt2Q0dQSXhhYlRzVTFPOWVIdjNBMURNUjRyK3pZ?=
 =?utf-8?B?RjJaZ1BnSHRVSkNZWERvNzcrSzlKRGF1UjZjbXVJWndnbzJ3RFNVT3VlWUx2?=
 =?utf-8?B?YTUreWhRdTJFU2pJN0h3MGFDWnh2VDlWMmhtTFl6bFh0blNUbHpzK21pK1du?=
 =?utf-8?B?a3kzY3ZhWis2ZGp1T2g3STNLZzl5NENSekZQVFVSa1hVaEIwMVlEM3Q1a3pu?=
 =?utf-8?B?Q0hlbG1zL2o0NDZjMVJSSi9yVWhudktOMU9WV0JDSmYrQWJIY1l3a1FqVFZz?=
 =?utf-8?B?a2thT0NGUGRGMjJ5OTg1QmkrdGUyWldsYWhGWXVKSHNYR0FON1VDZlY4VzFU?=
 =?utf-8?B?Z1R5ZmtmM2V3cmNkVmhTYnJrTjVLV0VGNHk4ckxmUnNZWmVQSG5IRm0rQmlt?=
 =?utf-8?B?TWloUDFMZWFQdjJIWjZYR1FEMG9CRjBvNDRMaVdDRWswM29rc3FRMDJqeEZJ?=
 =?utf-8?B?NjZ6QWRWUE1obU96M2hlUkJzcjVkZ0hZR0VIVjIza1FoU3RUME9KVDZ4TWw3?=
 =?utf-8?B?U3R1Y2VkTTRGV1pKdVN4MFpXbDF5RUdwcE1rUGwyeWpyTUU5akNCb2c4WkVi?=
 =?utf-8?B?SmU1c3VlY2pwMytJOVlmTlc0ZWZoTHV6TFNaaEQzZlF1cTRvUTJYM2tOZ3h2?=
 =?utf-8?B?YTF2bzJzM3dkc1RWMEdld25QeUFsV2YxczhZWmk2dFpMaUROaklFK0oyYjZN?=
 =?utf-8?B?VVlPaWhnRXBaRERaTmpWUHdZVk1OM2RITjlsVUtMOTIzVEJvKzhJL3ZoRnNE?=
 =?utf-8?B?UVdaVUFRWXYyZ1Rob0VtSjhzUlREbi9BL0tadDhCK01FWkxkWERwS1RUTVpq?=
 =?utf-8?B?YldNVlRJRHh4Y09SK3NDd0hzQjgwN0x3YmZjcVdGLytjMjVaUmxLb0NVaG52?=
 =?utf-8?B?SWRuUU9Od3VmVzNINEU4OUVKWmJPbUpUZXZXaVdUYkNPWWFIZElqRXR1YWhB?=
 =?utf-8?B?VDRDREVwdjlVUTd6RjhtVXFFczlWUGRlZGFxZ3BzSS9xajNhY1NoaEw5Ty9X?=
 =?utf-8?B?ajFaNUhUVGJBU0xibVJBRi9LTFl3Um0vWDRXVFg3TDJNUzd2QTZRSko4Q3Bi?=
 =?utf-8?B?U0QvSnIrVnMzQ3JGdzQyM1R6R21mMkhUL29SWjd2dEFkL3hka1A5bWYvZjhE?=
 =?utf-8?B?UDA2djljeG1RNEhMQVRrVmttZTVFcW5ocEh2NWVrSWNWeHdkSlJDN2E5Ym8y?=
 =?utf-8?B?bzFJaHFpZURuZlZjYjBVZ2JjL01ocGN6MVNzeHQzcmdsMEFXdm94OTIySFFs?=
 =?utf-8?B?YnV4cENNRVo5RExGdGp1OE4ySGZnU2JBTSsyT0sxZkUrRExWNkF3VGxXWDVF?=
 =?utf-8?B?TWNUTVhXc21ST1BQNTQvZFR6cko2NFl1enhvVEhtZWp4SFliZVVUNmFaMHQ0?=
 =?utf-8?B?MlhUY1NjUlRqelZwQ1ovSFFuT3Y3YXBtbm02OVhFVVpPTWVlbVRwdUs3eDVo?=
 =?utf-8?B?QVdPWnJsVy9nR254UVJKZjNuYWpibU4wZzJaUHhXVlIrVC9zcVQ0eWNZbHhY?=
 =?utf-8?B?MGlqelgrUFJFZStiZmZSVFBkTkhWanhGQzNyRSszaXFLcUI4N2ROUFp0bUVK?=
 =?utf-8?B?eHZJSkNlakttMEF3b0orSVRBbEMxaG9tM2FyVUFYWUMyQUdZeWwrbnhUR1VL?=
 =?utf-8?B?UEdjZ0FhRkV5Y1FRYVVVcXF0Tjg1Z1V1SWdEdU12dkZrMzFKbzBWTnZlL3BL?=
 =?utf-8?B?RVpraVlZajVlZ0dwbUJnUlhidXhQTXVNbGN1NmVhZHcyVHlNNmx6QXF0eWN5?=
 =?utf-8?B?MUtWNnVaUXlKZjRMWGZBMzJWU3VWSXV6VE9kemJmN0JacUcwbzdrcEZ1N3Bw?=
 =?utf-8?B?M0t1cFVjcUhFRkZzNTRPS1FQbkQ2cSs0blhBdzV1MWRtYzVVbVZmV2lBb2Jq?=
 =?utf-8?B?SExXdmlVdE4vK0RvSUJwVjROWDgxYzZPSUhwcWg2ay9PYnQyd0VrSFFxYURl?=
 =?utf-8?B?M0lZVlpNcnJlVG5vcjczQXZaSjJEVXRaSjlwUFdtYW03SG81TGJ4Nk5iMUht?=
 =?utf-8?B?MWVNR3U3MmhYUEVoMHR3OHgwWFdoTTlnblA2TnpqQ0xJYm53cjhIZEptVzF6?=
 =?utf-8?B?UER2R2RQS2gydStaMWsxbVNpV1YxRjd3UXl6Q3dXaUZocWhDbW8yZWdaOWsw?=
 =?utf-8?Q?TSwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnNQR1k2Si9DbWp2N2RVclV2Q3EvaS8zT3g2QTNaWk1xcnphN1pqbG1aTmhv?=
 =?utf-8?B?aEtKdDVOb0FXSCsrYWM2aGtHbWhBRmE3QllncmpUSEJYL25iNXNzeC9jVUdS?=
 =?utf-8?B?R0pPYWdiTE9YT01tK3RuRW9WcDdwOEh5a0FLZnJVUWdwRUpmR3cya1ZVQXMv?=
 =?utf-8?B?Qmppa0Z6U1BxeG9VSVlhbHZzU0d1VWgxdVd5djYzQ3lEcXlXN2Flb2xRK3pJ?=
 =?utf-8?B?ZWQza0xmRTNuSDdtZ3pkSkpVa1NuL3Z2RzB5MldFTGxjdXcxTHNuaXd4c3RI?=
 =?utf-8?B?bjg5emEyMS9ycUNzNDAydWE5REVEYm92L2NTL3NBSTVpekEremFOMjN1OWlU?=
 =?utf-8?B?SzVySHhOaWgwWDJ0ZlRtcndJSTRXVWlqNkVFUE9GZ3RnQXdJM21HdEZYYjdq?=
 =?utf-8?B?SXBDRWtDOFBkdE1Za1Q2QWVVVTFOVXZpTHJudy93RDJnRmIycTJTNVBRMnox?=
 =?utf-8?B?ZTJyVU1WZURkdXJpL3JnZnhnd3M3YVlVT0xDRVMxL2c3eHJIQmxCTDN0eVZT?=
 =?utf-8?B?dEpWUzdpbTBoaHJMYTRBd1g1NjYxOHVBbXovWnJUaHRkVWhqSnNpclJFMEtL?=
 =?utf-8?B?OGNwNGZYSHlYcVFEN1pESnBjZUVNVnhGa1h0dzBJMktja3lEaWxBMDFqZHc0?=
 =?utf-8?B?Q1Z3TnZ0dGs4ZnF1QkIzY2dFWnZGZmZSRkM1b2JhMkw0V1VCdWZndEJETldp?=
 =?utf-8?B?VkFwTkYrME5sYnM4L1lBbmROWmlCclZpUWV2VFJwWVNITkpOdVBiRVV6VENJ?=
 =?utf-8?B?U3JJb252M214SjRQL1VwMHFvemZqNEcxc0JBVTVMVnBpdXZrRFhTMW1TbFo1?=
 =?utf-8?B?OHEvVkg5dWhROGc4VVhJS3RtQmFydEY2WW1udjd2Z2xhNy9KWGF0dEtXMm9Y?=
 =?utf-8?B?VFV6bng5WGt3M2FWWHJmLzFJQjh1UEVFZWF4MU54SzIwbHl3MkVNdGJJYWh2?=
 =?utf-8?B?eTl6UnJqWUh0WTlEQjRoQ3hzL2dzN1F5VW42Y2JsMXkwa3dDWkUvRUdCM0ww?=
 =?utf-8?B?eWZMaUJncWdWMnRIRURkUEl4NUhIK0RYR1lhOURZWmJWVHh0K3VEZmVuZ2tN?=
 =?utf-8?B?N1hEaUFWT3FkdGNwYXlYWFpGVGJoQXpnTjE3cWFDUCs4bTdYbU42RTNzWHlQ?=
 =?utf-8?B?UU83OEM5TlVmTllEcW9ETXE2MCtyWHUzL0F6c1pYYkl0K1pwRmQwZkZaKy9l?=
 =?utf-8?B?c29KcnNNanlkbEplQndyQVovc2dlemZsVXByd0xDbkRCWlRrRlpkMU1IN05q?=
 =?utf-8?B?RVJQbStwcDhmMFBycEo5ZkVKMDhQWlVZeHI1MlJ0TG4rb2hrUXVoTm8zU3V4?=
 =?utf-8?B?ZXN1alJtcms3T0MxOGtBVmtvckhNTEhuRWpwR2g1YUlDWTZOSll6MDVTWHlV?=
 =?utf-8?B?TkVBQzExeGloTDRkVk5ZNkxjOFJZZGVGZW5Ua00rVGUySTlrbHY2dy9WS2du?=
 =?utf-8?B?ZUxOYnYzUWpuU1BWWUEyaG9CR3dTYU51S1ZoYVBmZEo1TmFxTUJ3blo1U1hH?=
 =?utf-8?B?RXZGOUhOZHlJTnJid1BTendJb0RadUNpcERNck5oN2VxTWhMNFJiUjZQazdl?=
 =?utf-8?B?NDFSTGl6dzBJRHI0dWVhK1ZnZk5FVWZERHJYekpOOFVOeUwvWXVEalBtZUwr?=
 =?utf-8?B?c3o1Y3MzR0N4bTVlTkh3MnZLYUk1N0Jjb2FHNUsxM3VrcnZXRTlZdUdwclN3?=
 =?utf-8?B?RUpTNUJJYzQyRXBxamdMOFhpQyttcEFNNEc4NE5SRFM2VkZCWStCTGVORGFV?=
 =?utf-8?B?MFVUaHlkREtNOTYzZXNoczdScnF5cVhHU2JmZUZPcTdDTGdyNUFiWmluWUpQ?=
 =?utf-8?B?RnpBeXZhS0dDOEp2M3dKY0l0RElsbWowVnBWUXZzRXVCQTR2RzZrc0I2RUZ5?=
 =?utf-8?B?TE10b1BHVUpyS1dwQXdwZTJ4VE1laUtHb0wxVTc0WmtnNFh5VWlod05PNFNt?=
 =?utf-8?B?ZnFjOE1MSWUyL1hlK3pPZVhGTUViZ0wwN0VNRno0b2g4VThKemgzSTA0dnAw?=
 =?utf-8?B?Nml4cG5aM3pOTnE5SDVwMEFkWVE3enh3WnJHVFJTZTV5a1RsbzFXelpxOGxX?=
 =?utf-8?B?RWVSb0RCd3FjQmFTR2xYelVjemgzZ0VpQ2NPOTZpak9oRVpheC9nUnJpcU5z?=
 =?utf-8?B?NVFJbStVNnVHcUE1MVlOcUdnV0htenZ0NEdNbnovQ3pXTHFqMmlwS1lmQlc2?=
 =?utf-8?B?SDFmTXhTNTZSZ0d2UnVvUUkzM2JEalc3NFA2R0d1TzliaXhWLzV2SE1rSWV1?=
 =?utf-8?B?anNMNVpaUUFrVWdGMGVMMlBGeG1mTHoxTU5JR1VEblpZby9Ed2RnK3g3b1dV?=
 =?utf-8?B?NHV5Q05Mbk5RU2lYSzMvTnFML1NkWC9udlgwM2dtVGcyUEhTMlRzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930a139a-4a1c-406c-f5c2-08de5859d25e
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:26:34.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZJ+WwuMvIMhfxMYGb7bMfFO7INT1Y0/waEXcYQHayni/GWm6FNFzQHR8DGEzBAmHwJBY2ajsf1gyENo/4EK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Add support for the alt 128M partition table to the msx4. This allows it
program the flash it didn't boot from by partition.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index 44f95a3986cb..a12d4164de4a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -67,6 +67,7 @@ flash@1 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		status = "okay";
+		#include "openbmc-flash-layout-128-alt.dtsi"
 	};
 };
 

-- 
2.34.1


