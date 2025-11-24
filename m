Return-Path: <linux-aspeed+bounces-2988-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58642CFD365
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 23:15:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFhVs6r9zz2yvG;
	Tue, 25 Nov 2025 10:15:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764026101;
	cv=pass; b=lh5WV5AWGikcKa74ielkyjPmrA0tg7SnvMhrmltvlA88DIGPieG1nIXQedsI3k7e1ChXTHU4sNVRTY5RzaDOoygef/yAy++N0+rbX2R8Ws1sWw8zNqzFV2afMUpYq5xhedcu8AQEw1VqCaIJH2rJaBsK83eX4XnNJop6ORmOuGD0aY0zAr2kmSYKr9xMTHI4vfVmYq19sihlAHa05YR+hvNmi7aq+qVjPSmDlEDg/jdDZ2Awfq78MZ/yH8/k4c9X2mJqwFFTxDkO2aTMQybd4io9qgj/WITp6lD9PV3+5iW/Yk2gfdoY3z7OETEIGP7KODuWBgF0Wqc2GHl1SgLqvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764026101; c=relaxed/relaxed;
	bh=4gHvFbipi6itqDGuSVqdxdujIBXcLx0MuRFPd269TGI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Q+oj8Zm2PV5U4oE+E2v2/LOPfSETOi8xEyD4RvPXMBKV8aXqG591mQAxKWUu9BZKr7h+zBqKDH3DbN0tFFgU7X6y98bJ6mU+60gS+3C9ydAKmnsc4LRzX8LuVahYOkCHks37y7kOQvaxhSLL7Bu35ZruTNExV5Z6X9/U1EbEMLh3QbMkevwsV+3Jo3GVx8UFB7CI19lywzuE43HGyWRIhsQYXyDdI7OnyeESofLTU+bMwrC6NHLGe1lD6rDpYDZjlYKitdbw4+KXrnfH772BMTsw8bj7LljXbNTpiWyQuZOIQjFgdLJl1b5sn6kKR8rBx0DtcElfHrbul89nfvEioQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n8QRvA9w; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n8QRvA9w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFhVq6q50z2yvB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 10:14:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wqbm46q4Nw/lMYZyl9Ld9JO02O+FmSka6Xr52EiJqDM0D02YUM3XDVmm4+po39jMC5h74biSgFJ/fuaHxZhj88iDbB/J4KoQSz5B/zVDmxT1HWaCeN+KXTmP7saQgf5iDHlUR1mISo0OK0ECAs/4GRZmoFW3cTCUAP2Bk0UqiTC4HqyO3H9ReFq/OPj2L7h/Id3ACelYW7RPmoPaeZr5P2+E6TfHLk4Q4UApIA/kjygAcRrLvRldEShfSZapD2GQHFC1U8PZTSDysFSlXsr/gXUUgtvP8U47hW19rmO5fzYWj9eKeOMoMHhZb88u6KDFm6GDROkSRGvTJzzFCPmqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gHvFbipi6itqDGuSVqdxdujIBXcLx0MuRFPd269TGI=;
 b=T0vJtXa16HVG5JqCdsClXiTPus2ISF6x5RUAkleOWxe4IJf0XCs+7T95Rzd6BebY8UTa8KKyFIIHo009trBsTWJljfp3vtPn/77xk61OamI4PItbIcAuumn9C3IX3i3pC0mBeBE4gbfwRwyYh+8kcWOSLLiJkgFb+KEfQywJ9syiuNnFBJBZEZGyvwoGxPOym2Q20Vm26yQm/3pVzudlD0c1z+pMkfdd6GgbPWN//m7vvYV+a6kqyyRXGeWdDOWBY9wY1UCDXxLuBLPPCD02k0JNu+VSUEm9+TfC6WiZzm3R1iuJIbMLWoO5eSTVVFYnWgopGn7rQFbR1R3TzSENkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gHvFbipi6itqDGuSVqdxdujIBXcLx0MuRFPd269TGI=;
 b=n8QRvA9wq2LvDXF7BqKMZ+vvP/puqvgbQsDvEQGIG5V2V0l6qw8sK9j05ifE9wk0wQjmZm425/tUd73VBKDRAbrFaLMhXKiAV3nSeN5/i7NslF6Y6gZv9+VSNGRGs435T7khfIGa8k4xE6Y7OjJ37f6V4839fPp3z6AKwSwDJ7essUZuwmplmNMrvBM8HJx50wfI/NUWZJIEuZ/kn9CnNX8noSG8Or7H80qYFQDqqSQxY+as8VXWF6SC5MiFFOcVvf+owNHR3HCB8Cxq+Gwnquu8UTrLYeockAqidP1CCXdlJdgVl33vitMqXwkLe2utowQ6y4r3iF+TEs+dC8lCeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by DM4PR12MB7598.namprd12.prod.outlook.com
 (2603:10b6:8:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:14:35 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 23:14:35 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v4 0/2] Add device tree for Nvidia BMC msx4 cx8 switchboard
Date: Mon, 24 Nov 2025 15:14:16 -0800
Message-Id: <20251124-msx1_devicetree-v4-0-a3ebe3110a67@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnmJGkC/23OzQrCMAwH8FeRnq002UerJ99DRLo2cz1sk3aUy
 di72w0RZZLTPyS/ZGKBvKPATruJeYouuL5LId/vmGl0dyfubMoMBRbiKBRvwwg3myYNDZ6IS12
 jgdpAYQVLWw9PtRtX8XJNuXFh6P1zPRBh6b4t2FoReCpljZAkEECdu+is0wfTt2zBIn4AACG3A
 HLBS8pKqpRUtsINkH0Dfz7IEmCkqXIptSWUP8A8zy8/kHxMMQEAAA==
X-Change-ID: 20250908-msx1_devicetree-7af2c1fc15d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764026073; l=1801;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=BH5EC9lCe/k5wmY2NiPJlD677/ptWAiXNK5wN5SJNWw=;
 b=hRhMHY27evIfTKUiLpBceFhRQtF6q/7rzPB2vWyUxx12zybm+7qd2pjPE+zGYjDiErIjnRP3N
 XmwTrY/Bu7tALSfGmqgp9wUen9RVIH0tVw+iaN3RrZ/2gNdDvJ2mHI1
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d0f10174-9b37-4fbd-e9f5-08de2baf3b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdxSVJQV0NQUTVmRTliaGxFVFRuOVg0OExFbjBzMUxUZ0pnQzl2dzFUdzZR?=
 =?utf-8?B?TW9aYk1JdWZRMWZ4Z094b3dXeU04VmZoOGF6V0pRNkZ0VzE2OWVGaFI0dTlx?=
 =?utf-8?B?ZzhBUmVOb0I4UTlGc3BWODk1MzdqS2liTEsyVldZSFdYSUVtWmdRaGNqWHdq?=
 =?utf-8?B?Yk1SY2VqWi9pL08wamdOd3VUeHJ5cVM0V3IxekZkR242VTlzR2JrcGRCalpy?=
 =?utf-8?B?N3ZhTm9Tc2dzT1BFUWV2TE13bVE5TEgwQ1ZTSmJEMUowcWhPa3ZycjcyemFh?=
 =?utf-8?B?cFF2ejdtTUxEVVRvZlFBUWhjK094OEF1N1R3NTBTUW9JL1JjSk1mZUZPZUw0?=
 =?utf-8?B?cXN0b05UaE53aWs4MTlkcnNvS0E1L1A1bzBzaXhBVEZkM1NEYzlPTUlpWVF3?=
 =?utf-8?B?SEIyN1huMVptbmpENHIwSHdnY3M2eWVlZFFZN0hQOG1oTzc2RzA5SnZsMFpL?=
 =?utf-8?B?cVBxak5IV0lFZFZFd2VCZktZcml2ZW10T0dneDBGTUNXQW1RdXJuMVhLb0l2?=
 =?utf-8?B?SzBhMzVGczU4N1FRTExjZHJSeExtdGpvRERsalBJU3g4bEJybHhBL0t6aHIr?=
 =?utf-8?B?TkU0RVhSaDZuUjUxSkJaNXVrRGJBQkV4K0VkK1RJckp6dEpvWUtkUCtGMXNr?=
 =?utf-8?B?ZzlsQ0pUSEovc1llTnp0TTVrSUc3ZFRGMjhSbmhZWmRKQ0dKVlhRUVU3ZmZL?=
 =?utf-8?B?Vzg3Y01CUVJKcVVtU1lreEo1S25HZ0g2dGtmejU0b2dtS3hTRGk2eTBEUVZC?=
 =?utf-8?B?QVM2MVl4b0xrb0lNT3ZyWWxQKzU1UWxNajFRajFzVE10TjFpZkFlTHhJVW1G?=
 =?utf-8?B?eW9OVFpyY2xvZW0rVHFYV3FKUk4yWmFlR0lHUkFZT1hQZmV2WFk1M0N3ZmZo?=
 =?utf-8?B?YnJpQjRkSUEvbitrZTJyYkFORENPSUNHRUJRcHhIbVhBeVlsbFdteEljUGR5?=
 =?utf-8?B?MktSWWM1bFlvU1F1K0FEdklrVEUySnlYTEVBRldYczhjMFBoaUVQdXlpN3RC?=
 =?utf-8?B?MEhGditkUHR1bDJjSFRWTXRxR05tV2krZHVBWk9xK3E2UGRodHdjN1d4d0lK?=
 =?utf-8?B?WGRnZ013bGhDQ3BzYVJuZmtieDU5ZUVpRmJDOXpNM0FseE9BbEcvV3hpNEhj?=
 =?utf-8?B?bVNpbkdSWTg0dE5aZUJTR0tYd1J1OWdXWVdoc2d2REl3QXJRT1hNa21TOTV0?=
 =?utf-8?B?UTRvUjh3ZHZHTEN2Q0RERHpGendtMWhybkp6U1gwYTRsT2tkbXZWR3RERE1I?=
 =?utf-8?B?bFRJbForK2JFbTl2MUFGcDFOc3hyTjdkRkREUlZRK1dPdnVKTGRGc0tab2tD?=
 =?utf-8?B?RC8xOWx2aERRNVROb0l4Z3NPOGJGdTRBcnMzUkZSVlNCaUM1ZlZGUFZJbldm?=
 =?utf-8?B?RFRta1JmcVNIR2YvamJJbmp1K3licjVraTBJMk4weS9MQmhuVDcrVWFVMHla?=
 =?utf-8?B?ZGgrTHJCNGFwOG1QQWk5Mm9Ca1FSNUpMWkQrZmY5Q3hQQ3pzMjE4YXVEVG5P?=
 =?utf-8?B?UndITWhOVnEyakdpWGwrRVMzRTdKZVdqdUNjQzhkZktqN0F0ZE9FZ090dWF0?=
 =?utf-8?B?YmRTNWVOUkVoM3UwcDEvZVgzdzZvQWgyUmNHSE02Um9ia1ZHNUNsTG5WOTFl?=
 =?utf-8?B?NzU4aE8zWHFxU2NSUG1PUjNsc2RCRGhvMUNlZUZDUGIycGxxREEvTDFTNzlu?=
 =?utf-8?B?bjRLWmxLaHdlQ3BIMzRUeExUSXl6QnR3SHVFMXpSZmpjM3hUZlZnWlpRVDZk?=
 =?utf-8?B?L2Jmcm5HWENIZERBN2UwY3lSbUpLOXBDUVJ1UDVpeThWNTh1N0dYWEhoYnJm?=
 =?utf-8?B?dHRuY2xJSWRVeUI2V3J1ZkFoL3JQb01BendCQU5KMVlwWTF1MnV6cjB5ejlT?=
 =?utf-8?B?NVNtclA3WnhUZkl4cXFWelNtZVVJOUxEZ0Q2T0t1UVdRNkRDQWVqVVdFSUZh?=
 =?utf-8?B?ZFBsYXRzTUI3RFV3ajhGSlVqNnNHd0t1STI0L3dOa09neEFOS1R5Y3Y5Nzdr?=
 =?utf-8?B?dDR5WlhMdDl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUtTQWVhWE1KaUs4M2t1aGtpSWJWMTlVbWZKZS95OXZCMW1pangyckNyK2JJ?=
 =?utf-8?B?Z2FYdnhwNGVmMm52b1lvRWcxU0xEWFYwTU4vOWU1ekVGdFA0YTdTbU9CeHM1?=
 =?utf-8?B?WUpreUpKMEV4dUlMNWcyMW54eVg3SEMvWG5QYlZ2ejJvQjFMd1lsbWZucmdj?=
 =?utf-8?B?aHhIeDcrUW5uODN5VVJubjlpUFdmcGhnODRsdzc2azRSV0QrTzVpZUlmYU52?=
 =?utf-8?B?RzhZVHNoZWgxUHpBc1l1M3Zsdjl5VVY4dW93aTVhcTI5ZGU1Z2d1cDNZaWNS?=
 =?utf-8?B?eXZqK1NybkRmQjlyNHp0djJnbTRTc0RpUGpQelpzZWxvMy9wUlJjVkVZM1ZE?=
 =?utf-8?B?NDRwbm1QWUEwWDdLM2R0TUMvTWt6Wm1XNmpVUVdJbm8wckhGV1puMzdoMzl5?=
 =?utf-8?B?c2pGU2dsM0pLSnUvQVNFL1BRd2RtQ0MwNkovOFZvc3RzQ2svUHo3bjFaR01v?=
 =?utf-8?B?Yys5SjB4elFSNWx3TllMVktzd0ljNVB2dnVUMnpuTk9nUkpIVi8rYjN0bzBW?=
 =?utf-8?B?QjRzdElmeGVWeEsrdVRzWVZtOTNXV254WHFOSVdEd0RjdGJ1eDZibk1lRkxR?=
 =?utf-8?B?SmIwOUdFaVE3U21oNFpFOUd6R25la0tYZm1SQUJBb3NIRVBEQnhnVkxEQTlD?=
 =?utf-8?B?blhBTVFuVURlbmlERzZlVG53bTljUjIzczFGTHdDTXRUVU5RQXpWaCtIVEZG?=
 =?utf-8?B?UW5GYkcrcjdoQWtnWDJtbHVsU2djYWQxdnIzd0ErK3dKdnRKeWdVeGFkb0Nm?=
 =?utf-8?B?RVV1QTh0VGYyL1dKdVovb2lSTFVXeFJWbUp1OEt3dHFoYTdPUlFPK0NtM2xT?=
 =?utf-8?B?ZlJ5TllYUWxESEM3M3graHRhYkpuR1plTTc5RDFsUWMrUmZ3OUpoME45bFJO?=
 =?utf-8?B?WVhjVDRFM2MzbG1PcVBmSW5wS0ZTeG5HV2FkelljNnY1YmcrRDJuMnYzYisy?=
 =?utf-8?B?V1V1SHJ0aTRtOUtJdklDYVA5QkZGMGZJSGE4WlNleGczWFI2bTVEM2p4MENQ?=
 =?utf-8?B?cWZjZWRtR1E4Y1M3WkRlREE3dnAzai9FYjYxN2dNbWh5aU9ObTlMOTNoZFNi?=
 =?utf-8?B?ZHRpcnE1S1d1cDVkWWNRS3c1WTZiK1NlbWsyN2tteFJYZ08rcEhrZDdCUURi?=
 =?utf-8?B?bndnV0thbHhIWGx2d3FDN0E0bFJ0VGhjekoyOTdpblRZbTkvMUt0cVdzYXJD?=
 =?utf-8?B?aEtzQ1RpdFRCcW5qUjdVT3R5RUY4VGRHd0FDOHlvVTRZbW5JRmVCOWF4Y2dD?=
 =?utf-8?B?YmVBRFRkUlV0SlRaTlBZZ1pTaHdEY0tBMHZVZUZVelZwb3c2TFJJZE1VNGZU?=
 =?utf-8?B?c01KaGtyUVQzMU5IUVVVYXFqL3dZbDBNUzIzSTBldW5XUHFmVmQ3RTJtK1Rx?=
 =?utf-8?B?N3BLT0V6N1VjWU9xb2pOUVBlbUhnaWVub0xiRTR1V016MmI5SithSkY5aUNK?=
 =?utf-8?B?bXhyWTFMVkdnVjZJUElkWHFDNmxwbXJmY3dFQmVoekoyMzc2TW9CYWlCdWhS?=
 =?utf-8?B?WWdJODM3aG5DTVBwQktuSDJpdDg0em82amFBSG1BdEoyR29kK0d5Z2FmSEhW?=
 =?utf-8?B?ZCsrZkRZK3I5Q01xMWVKMXppNE4wUVZqbGVNQndlSWNNVGZJUGpxOSthVWxl?=
 =?utf-8?B?RGltZjQwVzQ0OWl1Smh4d2tpQXZKN2VvRzU3NHdGdFgrNFREQmliMThUdjZv?=
 =?utf-8?B?UkRXY0NVRE16VEhBckdRSW13a2JFZkpGUDRzNmsrQXpDMXpjYTVDSW4zbW1N?=
 =?utf-8?B?eWF2U3hpYm82QnMraEEyeUV0RTNLbkZWMUEzNUNmenE3MFlZekZaZExUb0V5?=
 =?utf-8?B?Z1FnaXYyQmRIMHI3bUVOVGVaOUxMbUFtcldNYjdjcURqaFlWcEYrcXFJcWJE?=
 =?utf-8?B?VVJkZ09LTU83SWtZUzNOUWFPOHBuUlNCUzM5bnhMNVJNblVDM0laQ0pNL2lk?=
 =?utf-8?B?R1BaSmFCaWVCMHFCS3NqL3NWRnAzd21XeGt0K0tHVXA2QTZGMHhXRzRzTlFP?=
 =?utf-8?B?SFRoclkzeEJOclRyem5JR20rcEl1aVo3aC9md28zQlVEMkJwSVc5anh5cWw5?=
 =?utf-8?B?ZG9WS2U5WTIvZUJlYStIOXVVQnA4TmQrbTdGcEFxdC9kdXRjcVEyMTdMRmFF?=
 =?utf-8?Q?RTogfG9blq4cLCPNKPJoox6Rs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f10174-9b37-4fbd-e9f5-08de2baf3b94
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:14:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkdR7GM1sBh8jq2vYT7ep7n1raJkLIAHiDoDjzsXzlfrcHJ67Yb+Fx0CAxhZ23/9Xy7PskHHbLqHcXMuAAWTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Patch 1 Adds the binding for the msx4 cx8 switchboard
Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing the nvidia mgx cx8 switchboard.

Reference to Ast2600 Soc [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
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
      dts: aspeed: Add a dts for the nvidia msx4 hpm

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 248 +++++++++++++++++++++
 3 files changed, 250 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20250908-msx1_devicetree-7af2c1fc15d0

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


