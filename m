Return-Path: <linux-aspeed+bounces-1992-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D784FCA0EE4
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 02:11:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3jBn57xrz3clB;
	Sat, 16 Aug 2025 12:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2407::619" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287255;
	cv=pass; b=JJcTLcrC+sWnPdZhaWOeCzXeq9fsQL+8YHWxSxuqRNkdyDgeg303fGDppGGld2OMoaM2fbgR0zCEzDw1N77v85sSkIdcfVF+L7Nuq4eGGByx1uIyLoNAERPZ/iMMIqjxAjoDdsrJwLNAs2Ysc8iiJDaW2xs/MLI1V0q4iSVN45JnM0sqfeYkAgf8jVEcH59sEeW0fzk2KyVlRjr19gZkeQN/ePvEzMrZ/wafrEBBKFBVlDOSocTmmJsWQXmltqbujVA/TGAW+DrzF3iQKvuHNA/ORbof6O/FZDHeklPAsshhc8lIoVcV0Vfc+DWO0kKX7lX0MRlw+UV9N4Cn36pnww==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287255; c=relaxed/relaxed;
	bh=ETSMax8tjo93bmHY7B5e6IFZk72uftJe35epafTLkvs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LYd9Pv/RbXmaxJ9l5ci8qXf9tdXL/FQDti2fZbRXAsokEh44qel1MwEqHcHdB/OZSHYOD51jaUOpTlOctGCTSEZZvPWTaU6HpeZZ2DeSRSmAaMU/MkB9JswCK0BOGwRstqGSehVVNRm2CI2icRFaYRUhPGyw1NQsdyRRvcviO9EsiOnXjnl1vXy6yYsIt6iRfsQKH8IC0qJRazYijhogqxlpEOnBgp0EFqyG27NmMW1r4MOgE10iVZxFfAFJn1FGru3UFjuA/IyXU12fFwJXLZOchyIMEmHqMTMBCSXOJPyNbctLM5/t0gYwkr3dxwXKL97QMfT0TLoUqMcir4RBXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GzY2BFzs; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GzY2BFzs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::619])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Xh72Cdtz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZO1+E+18b1IRje9BWVMpGFJqGB0q14NwkSTmvvRVzeCng0el5VvJlyHjJhSXA+6ypqC0ETwupDVODVOXwmgNFMCjX8pOhrZ6oxybOFcuP0lPzbeNvmPda2VHOmQ+JsMoiJnVS3b72p4Kx0NJYL5PxpfmYX5RxD0ku9uxehl8wr0I+1il3WnrPEQ6BqMik3aYbq4tlEF8bjl82ja6IuFDhlpEGztMK0TnyT2CYBFYeaZB1LMew9PzRz96xgtdsMDYPlfs83rtrP2wLqQ2Zul0d99W1QKOj2rwaVFVbAuMZn/R0C7PpcFscHTqFs3dA3P9cPSduYjlfg5pVtQo90qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETSMax8tjo93bmHY7B5e6IFZk72uftJe35epafTLkvs=;
 b=oywYYfmuM3ximWKKGb6MO7JLr1ambdmJDLIxwks3cQBBfTEHlk2yZC2XrAh9fRizQfxypbJ8+D8m0toFu5Ja9i98PNlYxAa8sd3XY9pOdmHzHW01AVXF/qC+ReWR19QRlla3vej48/0kJjQnU2jLdSOjNUnrUqcwH/GKVNPc/CmDMDMY278ZcxjDBxn8ajWlzJnUd4pxc62ytoVM/4hXyUayWOCU73nv+VWASSQqs4qzLpFPuic0vWEAR0kp90picycpszUJ8WHFe+MUjtp7dN468iQInUepP4WCFznJhcbEwjvpYFuisP6nfwPt2VRw8ad2FpMwVwZb8n29tVoYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETSMax8tjo93bmHY7B5e6IFZk72uftJe35epafTLkvs=;
 b=GzY2BFzss/2NEr8Wco0WzXYj3DbKxgOchTEnWXLKq+2IOdiu1EvcomnKRVR6YBCUsMOXbpyBQE2lUWEQk5fv1IHj3xgr57sAHDpSAtbbjkD73MlghRiCDEkoPU2pYiRQCyti8nXfCxa6pV12YcegmjMLmE+55R7vPAZKjMDc9iZ01MvOVkOTGwMIlPckJyIAZAFc4D3cmhUtE2oQbg1ixGj/TNLHzrBjbpA1AIsp/XTS1TxvUOujTVHvYxLEGRdIaz/wxuL75kq2vNuVQW4OLXYIBdvA3vUlRUgI+SOQKE4nVd1OEDn++bz4r0dg9ACUXlW/Bmb88v1LNFZAFXMxqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB6864.namprd12.prod.outlook.com
 (2603:10b6:806:263::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 19:47:13 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:47:13 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Fri, 15 Aug 2025 12:45:55 -0700
Subject: [PATCH 1/3] dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-mgx4u_devicetree-v1-1-66db6fa5a7e4@nvidia.com>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
In-Reply-To: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755287229; l=872;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=bZryK9TBxMPATAVJWuEQPUK/avnzaPB+Qc6/3YZVDH8=;
 b=6R0Z9B9Y55JMHM14fRJHaqmFb14f0c32ab2ZJnGvvX5Loeddgea99h4VBh5a2VnAZz7C7oOY8
 GL6y5ucJJ8bAChY9E2+uVAfpzSXdf72HkiTect1dP2WR/oYxbt5UWtu
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0abe8903-755b-446a-8268-08dddc348780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDI1RmVILzU1eG1YTTdPUk01NUVJSXRCUVQ4NEgvM0pHVnRDYTgrZVJYNURy?=
 =?utf-8?B?Q1Zqb0lwZFRkRTFXbzhTU2ZTR1h1K0srbkdQM0RyZjlaTTlPQ3Q1a0R4NGQz?=
 =?utf-8?B?RGY1K28vUGhGVnE3d3E1S3R3VmhaWjBoZXVtMEFNNTUvVEtvSFFDMFl5Q3pl?=
 =?utf-8?B?MUdYOGJHbDZvaDllcDhkNmNjTkVSOXk3VytFQnNBZ0tqR2x6UU5VaGhDN2Nt?=
 =?utf-8?B?OUVkVGxaazNkN2d0MDBVcitZQ1Z3VWVtWHZFSVBMWWVtaFZsTy80VWRkZ1BM?=
 =?utf-8?B?M2ptNkkvWWdjSnd0Vm5HQTk5aG82eE1RNkxIYlNTdnVkSUcxMnhHQWpoWWdB?=
 =?utf-8?B?bU1pV0ZIeG4zUHh2R3lvQWtYSEthUU5nZ1Y2SDJWOTVLakY5MW0xcFM3WURt?=
 =?utf-8?B?L01YZk1pVWFCNVp3Uk1NUnJac2NlRVQ0TXdQRzhzbUtGT2drZFZ1VDE0cTRl?=
 =?utf-8?B?OWVPOFc5ZjFzVEtYTjJ0bzJLQ3pqNEwxcUp6QndNWHlEcXhPa21NUzFhclg5?=
 =?utf-8?B?UHJ3OU5MTHpBTnpUOFBxb1ZpRWJPRlBEdlNKbmFhZzAvNGt3aW1WNnJlTFFK?=
 =?utf-8?B?Y2xjMVo1clc0MVJaMWg2YTlNeitNcEVrSzljY0ZtYzlVb0hPTSs0U2hIQVBp?=
 =?utf-8?B?WkxYaUMzNVZKTkhHNTUxdUdvTEdVcHo5a2E5WFZvcG1TdlFvQlNnb2VTemFE?=
 =?utf-8?B?Ry9oaUU4MWRYWWdoRWVOYzl4SUM2cURuMXhCN3pPY1JXTVMvSHVLYkFWLzNt?=
 =?utf-8?B?Z1BuczF1cHM0MzdYM1dkb0tqNGFqOEd6RmoyN0RVUTk2eVFSUTltU0RZOTRl?=
 =?utf-8?B?Mzl3Y01zTlRVdTd4ai9rSFI0MXZqNlNjT2dNMUpkMmpSQ0lWcThtdnFXK3Fm?=
 =?utf-8?B?Ti9JV2E1eFpPczVCOFRDcjVBWjV0OE0reVErRHdOWUt2VkZETVAxNEY2VUN3?=
 =?utf-8?B?bi9RV1Y2blhLMHlib0psMGlvTWNMWDJKbmhaSk1laXk0NjZ3Y2dLNEtRNndq?=
 =?utf-8?B?eVFaNTFSSUhiNmxtNmhLQnZnYWczUlRob3U3MmJuS0ltaSt0am52YVM0VGhp?=
 =?utf-8?B?Ri9lRmZvWEY4NEo3dTYvbnRySzRuQjNiZjk0V2NXcmsxemtRdTBRcHFuWFgv?=
 =?utf-8?B?SFZmMTAwU21tY2RqcFZqK2ZHN0hiMFFOcEwveGJtdWNkUFJTZWdLcGlGOE9S?=
 =?utf-8?B?OTVGMHpwOFNNdEJKL1BTTEJHWTlNM2N0bHdaSW1mWUhMdyttVGJPZW43RXAr?=
 =?utf-8?B?b0lQWDAxemZRWEtrd2pHdkJwRW1yNE9VSlIyMnYyTzBtTkJ1V1N1NnUzWWY0?=
 =?utf-8?B?TnEvNUNvcmw1ZE9RTElvZ0VaQzhNMnEzM0JTcUFUdXRTODNmdjJXbU1xWTRp?=
 =?utf-8?B?blhhOXlKMlMvS0hNNWdNOEQ0Z0dPOERPODlQRnlPRlUwK2N3Z2M2Wk96Y1ds?=
 =?utf-8?B?c05RQk1ieVpkNEgydTN3WlJnbm5TU3lMcVh5bEFoR1Z0R0NLUUR2cmtCRXFl?=
 =?utf-8?B?OHp3RTJNLytXQ0h5QkRlQTltZkxRR1h0bVFYV1dZV3RNbFpZdlAzRldQODVL?=
 =?utf-8?B?SDRaeVI5OXVvWXMxZW5CWXJGb2xBc0EyZkxsaE4vbHdab2dyNHBWQnlKUExh?=
 =?utf-8?B?Q0NBckdLY2VaVDVvcDh3eXYzQ3cySnRnVVhuV3FtZ2NVbTJjcCsxYmlWSVl3?=
 =?utf-8?B?YmVVa1NQUFQvR25WWTJ0T0RkVlVaNHJnWWdZUGpwR1h1TTd1ak80d0tUNTBQ?=
 =?utf-8?B?djBEd3QvUjJYdGRSUEZsbEEwK0p6VEdyQzVFdXdCdDA3SHJ1TWVtejJTMXBu?=
 =?utf-8?B?UURYbU9zbjlkZjFPemxUVXBmTEJ4SlFISjR6Tk92RVYxTytpKzJCbi9jVTQv?=
 =?utf-8?B?ZS9qNFgvakszUzF3ZEx0NzN0Y01XYS9ucVF5YmdkTW8vemtCblUvdC9xZm9R?=
 =?utf-8?Q?i7WIGnmGFhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WndKQVVlT1liMkxoU1ErTnc1L1JxMXM2RjVoMXZQQnYxbkg5OElUYkVmaE5J?=
 =?utf-8?B?UWE1U0krVFlxbTY3bGFPNVNPdjBva0tsUExacWE2UTZZemlRclhYSG0yeEgw?=
 =?utf-8?B?cDdiTjFyNFM0eE40ODhJUlgwd2w2emJyeUlKbUxYOGNVT2lMNWF3VTN2VlJs?=
 =?utf-8?B?dStNOHFId29qN01LbGs5Q0gxRVYrZldTelFWdnlwWEFOdjlpS09yK2pJNmM2?=
 =?utf-8?B?NlhoZnNCZmRoM3E5REF2TG1JQWFFaldyNHcwcUlLalhicWRZSEtnVng0aFBW?=
 =?utf-8?B?Rlh0Q1FYbERSL20rYlllT2FZVDNsb1VGZ2pDdjVYTmlQdm5OWTNxRTM0MkdS?=
 =?utf-8?B?QjNrazR3VG05RUVGZ2dsOGF0WEpUclE4TW5NRHVLWjk1L0ZKdVJQbVdFMEJN?=
 =?utf-8?B?MEhjMkxONmd1Y3Y5eFNGQUt5QkZFbXRpK1J5Nml5cmZMS0JxMm00VEJ1bUMz?=
 =?utf-8?B?QmpxWjEva0ozRG52alhiSGZhdGNCeTNzTnFSNklPMVplZG1uaVduUGpyZlN4?=
 =?utf-8?B?eDAvakJSZ2xFNWdmUUY2VG5WZmREVksrWnRXdEd3Rk5EYXlxUjJpV2VwVnVw?=
 =?utf-8?B?OThRdVRRTmtjcHlPc2ZqYWhQWis1dUd6d1NVZkdocSt0K1J4ZEZVRHYvRDE5?=
 =?utf-8?B?SlliekJoRTErYlB0eFptR0FnV015bVhybHFIYVRYWVNybjhzUU95bXNTcmhS?=
 =?utf-8?B?MHBhby9Hak10WjNkS3NqVVM5K1Z2VkV0OXNTQzUwT09zVkZPN3Q0Y202VGp2?=
 =?utf-8?B?eEZUWHUxaEhxVGR1b1E5YzRQNHNuSXJvYS9NcmFzVGlodytZcnhjZzlyM216?=
 =?utf-8?B?dTNwL3RaWTVNNE96Z1o1OUU3TmdvQ1ZoaTBUUm1Wd3dFLzBIUDJmcjVsb0FT?=
 =?utf-8?B?R09qT3VtOFoyc3BHbDJndE1lUjdMUFRlTHFVMG01N1lzRGdPVWZ3a2RGakZW?=
 =?utf-8?B?bm1qUlNrTnBHRnhvejVITktFcE5Pc0daOHRUM25XUlhUMlhBOEJzeHZ6Zk9F?=
 =?utf-8?B?UTVGbnMzZWlrZi9WMmg0d1c5YXNudlpVUlJCY2ljZXZFQzByREQ3UXBQak45?=
 =?utf-8?B?SmlzcGZqcW1EeTF5N1RwTExIamdWUlNaUEh3eDE0Nm1mUXl5UlBuUHhlZDYv?=
 =?utf-8?B?aCsya1R2c2JJNmZQMzhqNDNNazZtWVZxMUU1WlpwWFpvamtiakRvdFV4L2x2?=
 =?utf-8?B?OFZxSlMwYkR3Ykp1TFVib0twYm1DWGx6elN6UmNBaHArWEtXRVpjYlZKMUhj?=
 =?utf-8?B?M1ZVZ0dWa3dKaDRkbVgzbjJtbXU3T2MzdmpKZEg5ZHB6aExkSnk3TGFHQnp0?=
 =?utf-8?B?cldPaGFSZ2FsSWVvVjNQb2JUT2NVVUdKdjRPcXVLVzExZzRWR0hXU3VmNWs5?=
 =?utf-8?B?VmtETi9yY3lIdFNzU0lSaTBqTEI5QlhDVXhCSndPdG93c1I3dVlWSDlqQUJG?=
 =?utf-8?B?eER4T0pFQm5jOFFNMjhtb1F1WXZYdVhUNzhmb0dkSlV5dWEzbzFUZW5NMDdP?=
 =?utf-8?B?SVF1Mmlob0kwQ2RIbGs5M3E2QnRSN2tZcWtnT2I5Zm5wRWh4V2Q4eFhVaExP?=
 =?utf-8?B?VU5abEpneTFYV0hsaWpYU2NKS0NPVFc3Z0ZPTzdMWUJzUTB5MStCZFRLNGxW?=
 =?utf-8?B?bmVZYmFPdEVjMWRKRFRqRGRKVWVLbEhvcy9aVExxb3VFVHgzaW4xeVVmYklU?=
 =?utf-8?B?bXJLelVweVZGbXdOSjQ1VmtoN3pKWnZXaFZtZlpaRlNqQjlpbjE4YU42NjY0?=
 =?utf-8?B?b200UXpxWE9KelI2OFpJSjNxMkxOTUdsL0RDWXc0K2NhOG44ajllMzVKeTFD?=
 =?utf-8?B?WmRHdDA3MXYyNjJaWFZJUzlJUml1bDhxMHE3V3ZGSTdmN08yYmRkbVl2a3ow?=
 =?utf-8?B?MXoydXRKRmVQS0FsN2dKRFJ1MEJaT2cxajNWVlk4SFJNckM4V2o5bDZWRWhn?=
 =?utf-8?B?MysxMGVzMEZPSGtVRHlXaVRUbmcrUWFtbGlkN3RiY1NNMERjZzBZT0pjb282?=
 =?utf-8?B?TmRFaDIrTnpKVm8vU29HeEdDNUpReU1jU1dDQW5BaVBxOW9IVHc3Z1hzdTNG?=
 =?utf-8?B?d1lpQXBzU1NFQUpYYjRQcW13WUswVzhvME1iTEpKN3UvU1dnV1hBY2l4anZ4?=
 =?utf-8?Q?8UEoStj6bqDiwv9C980de0aZd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abe8903-755b-446a-8268-08dddc348780
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:47:12.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU8bDVuNSqnf9qmu4xB17g9KG7uLmYMZYq4bYTuKbAwGgKRZ+aQLmzMPVoISidMLXg7dmC0eQE2Ei05PScB2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

Adds a compatible string for Nvidia's mgx4u BMC board.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index a3736f13413057ed45791bd0bf655030e90ce3e4..b7ee725c3bdbd99b6ac0c8d5184648bfe6740921 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -99,6 +99,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,mgx4u
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


