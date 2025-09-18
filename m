Return-Path: <linux-aspeed+bounces-2287-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C23CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 23:12:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWch53fbz30QJ;
	Fri, 19 Sep 2025 09:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758237140;
	cv=pass; b=Rrc1KjM67L6T/piIMrmCb18NkMohcKL1a15vxnkusRnLaDQOeREF+qdqIopZjwTdxNhBGICkDaWDqtE8rHCH/CbUSYYxLv0BDP30r7oHxxREkJpLfsbzPEK68Wn0Bhmju0NDVaHYsh2ETAAfBwQPAAVzYaTkaHsgri5mxRQ2pRYIBwpELtibZygE6BuSMOWQ2f66EdlGt2ytW2dJdZTjZ4XDSqhRdc245A0FYOYzrNEvZl4HuyEVQJ3+oUnerGgVMZOyAVQf2Y90zjPDZBUkUcBIpVkgvR1qOasNDiCozQN5sQACzrsT8nfHoaBM5RoL4Hlnn95Q8aSvCaL9bMzOIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758237140; c=relaxed/relaxed;
	bh=E5ibpKN3xu3mCZsJ6nSAaAStOpUnsjrp4p+ZpHO1aWI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c4NQQ5WH6OlCDfwTkfwU/MwH2b7j5bfTYjIvV1tjIiNGQVJIJYiGrtYU11JbyYQCU7lqxwVDtDQ8j+p7AI//Brro0FGLY5OOIjTu5EkoimY15tfCT9xKhrDc1ZAtlBbXJ2BWu346DL616BfZd2zd8VUp0b/Zq+MLclNds9riKpelSg9NM9qJR8ppEQjKFhDeyDY77iMn9TbWqC9xQ5FSb5p44Hz//rNJWsdSOBf6LlUhKQuoZfXtT6QnHDmia1UIQGNp09B4dCD5GSfKZ2Den7SzYsRm0Koyk4ubGQ1xYMyAzKFRi8WpJAG7XeDsBXuoNlQTd54Wr24dj0Hz3/TUXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nfjh8/xP; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nfjh8/xP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSWch1CKPz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 09:12:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPJyg9Os5Jrbk0xnLvpi0qW4OMvAEZ88txhoMIlfvKc+2lXDAbcox4dHdt0GhcRuZnNU6jZKtYDkI+1tVRUUMHja6BXtrmcVDuydVxtu0hsVWw3aEQtDnvvoRGjo2ZYWUF1RwZ4HLX7Uw23a/+bNudhRSfHlC+oW4S3L2oQU1HS4LtucgcqCLknakkMy5lBHKmu15aeUOGswzoR3jTeS+zTRr8/QQrJUOsPNbyKohkyNOGj8SdBipzJPAc4LlEZMrv0RyqB2HVhx5Gm12zTbY7oeGE7L1fmWjHbk86IHrN7GK42u7num4HfJJ929ZBHNHwiSoKWB67n1Vb7TEPsUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5ibpKN3xu3mCZsJ6nSAaAStOpUnsjrp4p+ZpHO1aWI=;
 b=FS6ccccOeCL97IIONQZOAiCr5kxYBiwXhLZs2avGOO5PDSmWmMQwcS53biXu2m8jBzObSbnlEN2AyRfVkHLySPfEoZo5hFukAtmj9IpdupYX3ccNljQKXIDqnqA8BTUuCXRVsoc0tb22MGEfoCnFB16hIuW5gw8CCIqS5nIwALMhp4PBYYnyBiBvQuGSCXtVmUkHAXe8R8IH0kLQb1Keq7tVerC6VWUZnEzwagYY0toxxo3kM2YHDAc9YEaqjlKD3N03kJJcMS9HbnG0feRyGbYLBeqBPOw3aaKhtrfBUJ5svK0Y/98SkHoYaAPq6P4grlWx2KbhmdD3TbUEXiiruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5ibpKN3xu3mCZsJ6nSAaAStOpUnsjrp4p+ZpHO1aWI=;
 b=Nfjh8/xPDHCg17Rg0tAJfSb8oE4i7e9PQYpfVRZDm/ouZdHJ/dXhISG1xYLdzjdvreITorMb+/Q1gl/CSbZ8mUn3ErKHh9qwkP1XFhzhkqy1fXRz6WRAOVNMQh3mZfrVozEu4ZWgvpzwAoYbLHrWS7jr6mzpSfiNY7fH6l4mgmho6QAnfMJedMRR4gOHDL8dkFuktiswabBr8owJcFk4Fs+Nkea0yz2BdybxnmS1SPiIjbQJU5PO0V419h9v0RYZsdGPycn+sRNu1hZEgrY91jTSNgwhtuF8Ad+F7LUZmdkbsG4S63SZ06dxUuRUY7A54d19hpWekf7p9ZVzzzVMAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by IA1PR12MB6483.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 23:11:55 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 23:11:55 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Thu, 18 Sep 2025 16:11:38 -0700
Subject: [PATCH 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-msx1_devicetree-v1-2-18dc07e02118@nvidia.com>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
In-Reply-To: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758237110; l=5826;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=vcOUvVBYR/mx7lAwONwxtrj27CGavJhEJQC/flEeeXc=;
 b=Q28PbKZ4C1E6IwVfb3aHFvDAh0oytWbRCmiW3t7fHB5b7wPPSbzUmfJA6Z6E+kSb6xc6juOpz
 6zvB4+5GQJeDccWLJ9h/pvOcmBzR9d0NJtuJX4vhyavi5xkIkqnlGEF
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b6adbf-af03-40bb-0e8b-08ddf708c29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnlTWmFIaFBxaFpQU0Y0Zk12UXBvYS9CTU43NnU1VXdNRjgyMnZHMVlUbXBN?=
 =?utf-8?B?QnZPVGlqajFpRFBQT2tuTndHYVdnRUpVWHUrQ3ZkaG90dXJTTGV6b1hyS21S?=
 =?utf-8?B?bXV2UE5qOStzeVFlVGJsSlVsNmM4T1BQSjczWHE1N0toSXBXZHk4U1BZVzQ0?=
 =?utf-8?B?cGdiMllIUVZ2OWdiQVNScmVVeUtNTTJzbCtJRHppd3ZCaStHOWYvQmdFY1gr?=
 =?utf-8?B?QlRuWlpnajc2WUZKYk1wZnh4ekZjNFh0MlZHTE9JN2d5Y0RBRGlieEJ0aXlv?=
 =?utf-8?B?SkV1VGNhZWpuQUhSemF1dDBNejhDeUZRdGdZR090TDBYNmU2WitmUE1tQm55?=
 =?utf-8?B?UHJwZ3RsK2xIb0tOOGtWMi9nRFVEdkZxOWI4a3VXUmtMNzUvcGNpbHJiK1hw?=
 =?utf-8?B?Y05pL0hVZUxlNElvZlpXd2I1YllRZGdpanVPZlBrYTdveWpKMjBJdUJzNjI2?=
 =?utf-8?B?TWk1bHJLdXViY1RJTHk1dXRXNXFDMmcyeE9QVm9VME5SdmZ3VzBTd3lNbFA1?=
 =?utf-8?B?RVRocW5Dbkw4SE01Mm02SG9XOWczZ3dhKzZOTGhNcDR5cnI4WjU3VVV5TU04?=
 =?utf-8?B?VXpzeGFlVEFEY1NVSUQwVmRNMXJQc003TEFWMUhNU1BtbHBVR0pIeHdZY2JM?=
 =?utf-8?B?dldvV05MVm1hZ1RaVGFhRE41TjVFS2ExdUk4QTRWd0YwUHJRMHJvTUk0QjNq?=
 =?utf-8?B?emlvUzVMOVEwUGtqdCtTdTUxcEw3WGdwT1BHOXgyOER6eVVid1lWeDhndUVG?=
 =?utf-8?B?aFlPRk8wSERMZkdTR1hra1FRUUorOXA0bjR3R0NzMGFrOFhtbEJYWE9GblBo?=
 =?utf-8?B?a2RZVFpNYVVMczgyL2ZWQUJubEFrTDZ0ZC95SGM3WFFiTEpvUkFmSmRvUUNE?=
 =?utf-8?B?Tzh6Zi80aUducmMwc3ljRVJDWEpGRGdiV1ZWa1A2dUhXQmFFYXJFQzhmcE01?=
 =?utf-8?B?K3h5clFadGRCN05USWQ1YUQrQWNhcVF0NE8zRk9aVWs5d1F0YlZ3TXR4alhJ?=
 =?utf-8?B?d2ZVMzJpQkZSNmNqaDZkUkpQOXI2clE0d2k4VHhLeTdCbXNjZkozb2xXVEMy?=
 =?utf-8?B?Z0Rxb0M2VjkyMjdLOVNxTnBVNEhsdGhWeHN5K0xvQzBiYWljZEVMUzhodm1K?=
 =?utf-8?B?Q1BRTGkxcU9XRHJZQUszL2JQbjNpdXhWamhYOTFlWlZBOS83R053SGx3SHBR?=
 =?utf-8?B?NThhV2tGMUpDSlB0Zi9OSFYyQ3Z5NEF0Nmt4TjVMS08rYXNrRTlNNkxCcXBE?=
 =?utf-8?B?eEgwRnZjU1p6TWd5K1dUOTkrSXpnS2V2Z0RqbDN4VzFmT04rR3lIN3IvQWpn?=
 =?utf-8?B?UVEwWWIzbCtpOHlTZC8zNEpHdElLY3FjUzRsTG1mZ1pvVGgzdEJpVjFKS1Q2?=
 =?utf-8?B?aTBwT2dLNUdvSGhiYm93ZllDcXhjajZjUHVTN2xIMmhpUU12NVZBSWJocFkr?=
 =?utf-8?B?Nzc2cHU0Sjk4R0xzbVR5NlNseldyeXdIMzhLUzVIV1hDSis5VkpuT3k0bW45?=
 =?utf-8?B?ZzcrRWZXK0tCMWZBYXN1OUkrYWdadzBZcEdUWHByaFNybk9GT1EvN3ZpeVh2?=
 =?utf-8?B?bVRsSkk5VkFFU1NSd1pQOXRqZW1ydXI4aVIwdXBIUGlIVW0vVUZqU04zU0Nu?=
 =?utf-8?B?NEpBUUg3RHlyWW5SN1lKdDNiVFhIR2hQODN1cmh6eGxsdG9rNHoxcEhJdVhi?=
 =?utf-8?B?ZmcrZ1dpOTBaMkkwUTllZjJDQTRPNUZaWld6dkJvZXVVNnoxR0l2dmpiS2h6?=
 =?utf-8?B?WTZ1VVU5cjI3SkhmYUF3OWdTWEZpZGk4T1hZOVY3ZGFueERYaTQvOUQ1bHVs?=
 =?utf-8?B?UGlSUExKUVNIbmZiMmZvakI5OVA1dGdGRmgrMzMxV0JaTWlab010bm9rZmZ0?=
 =?utf-8?B?NjN6MWNRcVcrU2NyN0k0Wkd2LzE0eWdkR0VxcDZpY3JUWTNvV1hHZS9LbUJl?=
 =?utf-8?Q?9DRHsjhhd4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmhtUWZpZGJNQTEyMHpIa3B1amdOZ2k2dGNYbEtNTTl6S0RHejd3VVhobU5i?=
 =?utf-8?B?Wm14Q1ZVdk5qMUxLYS9SaDNTb3ZmdlAwK0ZBbFJFeVlwVS94UzRKRlZMV1B3?=
 =?utf-8?B?V3A5RzNqTEs0MVd6aTNSaWtFVm9MQzBpbkFraTFrN3NBa1IvaXBmdTMxWGlD?=
 =?utf-8?B?RzJwNmxNbkxKSFJJNmMvbW5pMlVUZ2pGSmc0K3lNckNGRUZsNzMyazhUNG80?=
 =?utf-8?B?SVNhbmNDWTFhVVhUSjYwV0YvL0hJWXRHOURaZzFWODdleHV2anFLZVdqb3Rx?=
 =?utf-8?B?TkplbWhoUGZycXpvbU40bjJxajdqRTRTbWVOYXd3MTRXbnZnUWJmMXlLWDVv?=
 =?utf-8?B?V0VZU2owYnljNk52Ly9EMUdFM0hrcDBpWWlNZmM4b0JlbHhCTmh3RFpHQkJ5?=
 =?utf-8?B?YlE3THJQZ08rYi9MUzlkdFBjQ3UyV3hobnd0bVhnWVozNEF2ZElzNisvQk9z?=
 =?utf-8?B?a0trVk1pU3YveUtrODBRVkNOUFpiSU1YUERWNWUwMTVtRFYxdlQxS2VHaWQ0?=
 =?utf-8?B?UzVOdnFJd0U5MWd3S0dXa0pnSUhVRWszNUdKZDIxWmUwZWcwN0kvWXlTbWNN?=
 =?utf-8?B?UXduRGxGL29TbFM1c1NsT3ZwUWtrcEVpQmx5YUdzS0lJNWhJakMzSEJzMzFC?=
 =?utf-8?B?Q1ppYWJHVGFDVVF2WHV2WDRndFVVbU5EcTdJaVJodWxyb0FLUlNnTVhoVkhH?=
 =?utf-8?B?WmFWWGFteTNPb213OEhCYmhzL0RDbGFlM1VuZ2xJOC91ZEJQZjUydjQ5eUk3?=
 =?utf-8?B?QlpZWmFSVHNyL3dLQlBSWjRGSXZVN2E2ZVZ5aFBVRjRyVHc3eTROemRyeFZj?=
 =?utf-8?B?OU9yak4vZFFWa2czUEEvNEh4QnFXMExLeWhMbitGeGk0Y2hKZGJsZUswNGR5?=
 =?utf-8?B?bVJVSmJkYzdUQ3V6V3JBbnhTTmF1K21GYk5SYkZJeUI1dUg0RDcvNzhrZ2VY?=
 =?utf-8?B?U1dWMWd2RmNqRFF5YUM1Z2F6cFJaRS9POXZRTWZnb0NlaEQ2b1BRYmZEY3dK?=
 =?utf-8?B?dHh0b3p6SC9IRW9IWXZlRHg0a01WdS8wTHRhcktvYms3c0xYL3N2Sit1N3I1?=
 =?utf-8?B?WDlUR1ZjbGIyRDNzUS8rRFNCNWgvdkNoUWFrNXdrSXRKTmtZODJGZWpQMEE2?=
 =?utf-8?B?U1VucXlLczBYZW1zWGFReTh4N0tpQzdTeHhSZzA0L0ZmTEluNTFzY0w4YWdZ?=
 =?utf-8?B?NHpnRFRlbktuM3JCT2ZzZnQzVHRWV1RTTG1jM1lKd2V5N2VseC9YaUh3S1dv?=
 =?utf-8?B?U243aWFmRmlEY2ZzV1VveFZVb0hwYk55bFpEbm9GbmFmSDZOS0NPRHp1NzZH?=
 =?utf-8?B?dlR2TnRPZk9mT3FFeEdZd3o5S285dmtQMlNlYmVWN3ZBN05TMWhjNENITG9C?=
 =?utf-8?B?RXhGaGZjNW4vbk45ZE1nV0xrV04vRE9JRzdXWXZpYnd2MkRDbWR5VVJWcGEv?=
 =?utf-8?B?TThFUFYvWVh2NnMwcFk0UWpHMTgxRmdnaTlYOFM0LzVkYnBUc3c1NVdBblZa?=
 =?utf-8?B?MXQybTJMdEw2QnFJRWlva2NHTVVMOU5lY2t0S0FKWnJaU3RDWFg1NlJVSTBl?=
 =?utf-8?B?ZXluVmc0WUlVRk05cVNtRTFxUEZNelBhNXJpdm9za2s2US9uQ0M2YUtqL1Ew?=
 =?utf-8?B?UGwydDcvSUgvM0JCOXZTNlJzS240WElnZkVkNmUwaEc5RnFkbjdyOENHT0Zl?=
 =?utf-8?B?R1Zlc3NML0taRU1EZXNPNVYxOEtEVXRvUS9kNXh5OS93Ris5eUJkdDgzS1Zv?=
 =?utf-8?B?clBpeGloK3RiT2lYUHM5U25MNXZjSTlCV2JXcjlRNk5hN2dROEZsNzJBdDBS?=
 =?utf-8?B?dEdkTHBNNVp0MmtaOTk0NnB5VnJxb203cHZTdXJuakpVc00vK2hWYWdUS0RF?=
 =?utf-8?B?dWxWL3kybjFhbFJxbURjVG04a3J2RmlmRWF2QjVaNStBdVhIVXVOM3dLNTFQ?=
 =?utf-8?B?aGpnNDNKL1hOTDYrM1lsT0pqc0J2U1Y5eEJIbE5seGx0MktnV2h5cEI5TWNN?=
 =?utf-8?B?ZnJyVFk3RFdtK1BnOXl0Y3NSbDZoTDlYaTBET0hqVzliNXZrc2NoQktxM2F0?=
 =?utf-8?B?djJiMUZFdGcwZGRLYWQ3cGRSS0s0Ykt4N0dGb1RZTXBmdWRFMm9GcXN0VFJy?=
 =?utf-8?Q?0t07eDu2x8J71BQkzGOm2CDiU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b6adbf-af03-40bb-0e8b-08ddf708c29a
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 23:11:55.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MczR3lHbuT9mwb1TGmgANEIMw3lMEjIAwv+OUM+PKNmVeTtWECsXokRW5iSBhnpUNcyWsDy+kZCkFXz+D19GIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

Adds a dts for the nvidia mgx pcie switchboard reference
platformi hpm. This is a dual socket granite rapids based platform.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 254 +++++++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index aba7451ab749f4938aa56ffe332a94e04a55eb52..c5ac392d77420d2778990a1f7d4fc3f659ac37b4 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-msx4-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
new file mode 100644
index 0000000000000000000000000000000000000000..178b29ca4ed786751d760fd301863d26b2b69ea4
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MSX4 Kernel";
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
+// bootloader takes care of proper mac delays for now.
+// phy-mode is here to prevent breakage once the aspeed
+// mac driver is fixed.
+&mac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy3>;
+	max-speed = <1000>;
+	status = "okay";
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+	};
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


