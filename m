Return-Path: <linux-aspeed+bounces-2839-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B03CCCFA13
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 22:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3r8r18hFz3btS;
	Sun,  9 Nov 2025 09:25:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762640716;
	cv=pass; b=HI711xmHkal1yatUGpfJA2/WUdqiNdWYODj4AUJUSxdn51x0n+gsjUWp4f23uOkSIvAAlJT0h68cKgKxVLrDZlu91Jb7dkzUWgzt+GkBedW4uDTL6SCLWBISV0V9Lt5KU/Z90cXMkLwjnXZO12gWWAXH8HDpNlAV6TUOABDImnETuLgOlcJH09lBKQoXnimBg/WlvdPGPBQZ4LaQrJ73EUgIkZF/BiW3h8hvg10dhdrWxlN9aQmDVAPE9rb/iZ5A5IGZsHRFwkJYLbR20Tc9x6RTmQ9EvZzpkLfajCYH8sKJE4FyeQcgAHZCG45nOS328PdigIwxFIkMNAf41GtnYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762640716; c=relaxed/relaxed;
	bh=Ms2FYpMmSppKEvOvCvAO9C5BjVcTRyC3yVkSQaQ+AKo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AUAu8oNQQe5KlEUGC8+0fmzxcldJQheb4ugxkLbNemLp57djbGzuqlDZGjd0X774O3a+/byF07pLZ3lHhvvjzIcaxsDhBCYRD67p1N9AASSOsn7tNIeIJ6PwzHLw+x5O1hZaLxEmz/a+BpNnIlFt6OnhGZXAT4rQP3yJ33bRZup3RflQi0mbZQuV3lZH/4MhoSk+CTH9HvpO0jOhSk+EyneGb/B7uuMZ9RnWlNQt6BfGoraiWzQyGywSPwgZlPsIoKX4bzke2dTRYj0QNVZUpJ4s7AfZMOdmKEhmMJnoFrd/Mk/618+F7Qiy5S4lLSVp9AX5lpgkctS8zwDC6rS2PA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=musnOKfw; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=musnOKfw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3r8p5yNfz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Sun,  9 Nov 2025 09:25:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrWD6hVmP58FxbrUoFYRWagI+JMYlAOxgnFkpnAT2zhtsq0YsGqKjtwijRoOAtw4vkcLDummHRO7InGK1CmObD9GCVe0c+HKLOiI9Q3z+QOKKvet6hfiqxsOc/5sw+HGLi3DjHr9ZLlVNb8FkuMrCck0vz7Qky9sDsODEm/WbLjd2DEvxi0Ji/Ihgc4LMCBUEZR8R4dgqVVqB0q6Sc4mjY3xlWWNDVYKtNLHZdN0vJbqvhUuILUaz3rxBBR03a17bctcrmXf96hEYSE60SDZN64dMebVypbN2JLCzJb3zr4cpVgknK/8CK3UPhCeaee4nCjfdXPF16vscYt7OGEMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms2FYpMmSppKEvOvCvAO9C5BjVcTRyC3yVkSQaQ+AKo=;
 b=KM/Mzk6b1Bui+y5KXkvy+oh/Y7o1fMRlbbb7g7+/CsZDJ6QUQY4pq0Lz43IC/q6IjC9Wmo+YAGapM/iwKj4ExTWAETHLisYwHn7gvfZnb3sXtwEPHg6pJV6LEeYMv9t/ZfshqnTF9SySULdtA4j+nJFOD14Umg1FciDdDZwtBiA4Od38deo/vwg2UuIe6NzblqZ5nC7h/y5STEr+Vi1js8T02iolgrDHql8AL7DqX2cU3LV3QPLv+6FMpGB6xI4fpcSdnNMIMBmp96/v2wwWbX0xr9A4ORVXcW7WcPFaTtwriJpp4dALoNMKe2vwzfUVDj/2o+OU8zpZK9nB65uolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms2FYpMmSppKEvOvCvAO9C5BjVcTRyC3yVkSQaQ+AKo=;
 b=musnOKfw8iQc0Wf5iK2BOUrkf7LHBIC4SJbpVadblF0mmjpF4mY8Aeo1FVWAWgucf8JB942HyopQQzSArN9FxgvLdTixm9YN0ptiVYR6szz3zuv8rQIPDrZDDd3PiGBhlNd8mL1syrt16fMbmcdXzNxK4yoaOgt5PKDD2+I4cF0MEqhL00CqUONkvjHQcWMj+3wAR07908S0yw2EfT+4CwKxR5qmTr999e4nWUKQMxq4diqVDrhpY48r6glhwdPVCTpkABAtm/PjEIK/EdZvDNP73nAVJ2RhHFof9h7L2gX5tpH2Ms4/6UvUqO3tdikNXfomDQ8d3QF64+RTi1brnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by MN0PR12MB6056.namprd12.prod.outlook.com
 (2603:10b6:208:3cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sat, 8 Nov
 2025 22:24:46 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 22:24:45 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v3 0/2] Add device tree for Nvidia BMC msx4 cx8 switchboard
Date: Sat, 08 Nov 2025 14:24:33 -0800
Message-Id: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHDD2kC/2XN3QqDMAwF4FeRXq8jqWi7Xe09xhjaxpkLf2ilO
 MR3X5UxGJKrE06+LCKQZwrimi3CU+TAQ59CfsqEbav+RZJdykKBKuACRnZhxqdLTUuTJ5K6apT
 FxmLhQKSr0VPD8y7eHym3HKbBv/cHEbft18KjFVGmMc6CJlCI5tZHdlyd7dCJDYvqByCCPgJKg
 iwpL6k22rha/QHrun4AMT4BC/AAAAA=
X-Change-ID: 20250908-msx1_devicetree-7af2c1fc15d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762640683; l=1482;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=kSD6dBD+vgzQ7qkQu6QwqMsw2m8Pr5Hc4ZKRRRKFP7E=;
 b=3pCrfydcrFw+QnLItN+Ba/5jpvyV9vTUfcYXGRdmawP5vZ0lkhTUhMqfiHl128QrUr64NbgTD
 ydWVhVNpheAB3qXj9W35TaLWIZgtwt22xk4G1D5o8xeP3eA/5pqgkh+
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0e37ce-532e-4b4d-928e-08de1f159ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkJyeDJFV0dRN2g4MExPbjFtMXdKQ2ljVFZvRXR3dCtONDd4UEZ6WUtmdmpl?=
 =?utf-8?B?eUYyMUFxYmN4cjJEVkQ4cXBic1RrSDB2RWZCZDlzZ3NPb3FSL2xtbGIraCsz?=
 =?utf-8?B?ODFKOS9MZHhmTXNiVWpwY3hNOVgyU3F0RXhZdHQzTm91VnoveTVDRm53Zy8y?=
 =?utf-8?B?cmJCbUdFc3RiUDZrT0lsSFFPWFJLMUdkV3hGQXg2TG85ZTNqRTdEVEI2bnJv?=
 =?utf-8?B?TFNsaGVJVGx6VDQwQXNsQmE2VVdXcmFCWU9PdGQvMC9IR2xxbUIrK0ZGL0ZI?=
 =?utf-8?B?aEpkTm1WKzVtUWc5cXZZTWRiMkRKTHRvTnRXanoyalkyS2gwaGpjTGMxd1pE?=
 =?utf-8?B?R0M2SlE5SnlCTFluS0g2RUxOcnRtTTZsUGFuSmp1b3Fac0lpeVFFM2JweUc3?=
 =?utf-8?B?a2VPem90M0pjWXJncHhLN3NRTlRMODBRRzEzQnFuODB4UGkvZ1RzaDhUUDJo?=
 =?utf-8?B?RlRKNlBCR3Z3Kzg1NnBoR2pkNmllcTVoRko4OThOa3pwbi8vOStOTW9iakRL?=
 =?utf-8?B?QTlxQUNmU1ppQWx4VkJkTS9nWGVid2dDcXg4T3c2SkFKS0xkcHlaaG9raFhO?=
 =?utf-8?B?MUY0TDFsVS94OXBQS3hsYThIaDZFMERIZkMzT2dxY0dEck5ySEVMa0pwMVgr?=
 =?utf-8?B?Vm4ycEZMd0Q3ZlJoYmtjVnJWa3RiTDdhbEpsOHJVUm9rR2N3WC80VmM4Mmpz?=
 =?utf-8?B?TU1ubmwrK2pEMVBra1pZWm43SFdjOHRpVHYwUDlFcXJPQ2xNSmdHN3VnL1VF?=
 =?utf-8?B?aW9jbkJOUzlDd0U1aUtnVUhkRXhQSFF6Nzlhajlla0hmalEyS29lMjA4R2Zs?=
 =?utf-8?B?SFFZaDZRQ0NvRGdqNDNUdkQ1UXNRcVBTOG1jcHdKMUZVWlluV0RCUVZuR0pl?=
 =?utf-8?B?MGJ2OHdvbkhlbmlwSGtlZEVRNFNKeXJ1SmF4Q3R1SXRlOXQxYVlZQXJDR1Iz?=
 =?utf-8?B?YzNKNnQ5RVh2UlhwYVE1SUlLR3BQYVVzYjhBNElqV0JhTXBQbTNlT3dlZ1M2?=
 =?utf-8?B?UkQxMDN6V0w5VmhzQTJCditPVFBkcjBKbWR1aVhUcW5uTXZSc0MzRHIzS2oz?=
 =?utf-8?B?bW9TcjRucHZSbHZ2Wkk3cXlyNHpTUUVnM1hQVEpka1FJcElUQlM3Q1hjOUlQ?=
 =?utf-8?B?KzlwUFZsSm1raVRwNzlSeitGVDI1em1CQytWK1JjT2xQT1ZhRTg4d01XN1lN?=
 =?utf-8?B?ZTJWUUlBTGFsR1VaZDlIbTkyQzhuekhmQkxwZ09FbDhJNDVUS29yTTA3N1JL?=
 =?utf-8?B?Sk5RR1pvMDZUMXUwbEI5bEdpNG5xcSs5SzZ2RmFuWmRTaGNnMEFtemRoaTFu?=
 =?utf-8?B?RG1XVnJ6N3FaS3lQWEtEOUpOcVJTeDNFZFhFbytrWkp2M1JiRlArb3Z1V001?=
 =?utf-8?B?Szl1RndHOURCN085b1lrSUdZbWxLTnJZblozajR1M0xQR0ZRU0cwRElldWxa?=
 =?utf-8?B?dVZraUNjQkJpMmxydEZteWtZOFNnWGFrZzZqb1pHTUgrelBVTnNzeGRybEZr?=
 =?utf-8?B?OUg5amEwdzJEMjZGc2ROTlQxdmFRdERlRTFOajAwbktqRVFUVjdySnlvQlp1?=
 =?utf-8?B?a082eUMzWXRLeml1M05iVUJUL083QjhCWmhDV1NsMlFDdHB0UkVFTW5ORGRw?=
 =?utf-8?B?Mm5abXNyTlRFLzJaZTZtMk94ZytMNHF2V2RLQ2ZpcWtnWEN6dWh6YWwyb3NN?=
 =?utf-8?B?UGh6V1lLVHdMNmQ2VkI1Z2ZBVVdTRzRsLytYbTVaanp1WjNOZXVWQmlYenI3?=
 =?utf-8?B?N1pTQkM0K210VFRvbDBHaHNxdUxXWEZIcThhbzV6cUFCRHpPUnV6R2d1Yjkz?=
 =?utf-8?B?RlZyaW1jeFdhYXpFTHZGS3lNMkd5SEhOODBnSTJzdFpKMUZlR3BNTS8rbXJG?=
 =?utf-8?B?M3lhZXVneHNtWDFkQldJVnVicTl3MmVSTC80QS9EWFlvRDdpaXI2MERxbXNX?=
 =?utf-8?B?QW1TQTFPOW50TWpNcFZmSDZ5SVBHbjNzTE1YalIxUUZzUjFiTWl2Q0pjbzY2?=
 =?utf-8?B?KzJuL2wwbGxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUZFUmFKaUhxWG5OdFhFVTM3UEtXQ0hzWWY4QzJFVFRjYVdZbVZQTmFrUkVp?=
 =?utf-8?B?QWRBcmJWK3B2bUhrMG45eTNCRVNJL3JjcVRoUkNZMW9mc3FDeTZvVG9oRWQ5?=
 =?utf-8?B?SlExaXVteHFxNzREQ3g4YS9jSVp1WWR0b3dQOTdaZFovT0laUjRNQU5ZT1Rs?=
 =?utf-8?B?SFVibFoxaXZBMmw4ZmxNQklkeU1rN3dyQ1ZCL2RvUUszRmdBeUFOcG9FK0Fn?=
 =?utf-8?B?Wit4cXpqVkpGbXRCSG50TGhnMmZHZjhXZEhKcFJNT0ozOFczdExYY3VDeExm?=
 =?utf-8?B?NXpuRnlCSkYzNG4reGF0US9QajVKYS9UQ04vbkFwUmRqZ242ZVBucU5QOGxQ?=
 =?utf-8?B?SWJ4V2lZS2RxTThpNjJncGNNSUVzOVVPWE9rbDBocWJnamphZmJOelRCdTFG?=
 =?utf-8?B?MkMzczVNOXNLUjNRMTVKemIvRjZWbWtkd3A4ZUgzSDNGMUhLQmlhSUJySlE1?=
 =?utf-8?B?WnF4WWROL01HTlQ1T09DV1BncEJRdU9yT3FnMklhcEFkTzBzcGVwajU1a2dn?=
 =?utf-8?B?RnQyWFYvaC8vTjVvSjZ0a2FGb2J1czFOdDB5TU1PK0JKSXY5SWZrZVJ6ZmxT?=
 =?utf-8?B?a2YvVDFDS3kwQ0ZMSjR3S3dzeEZoY2pwZ3F3UmRyVVZpaDVVTW5tWmM2VVdj?=
 =?utf-8?B?dHlmQjN2Sjc2L2hUWmhweHpqRFRISm9XS0p6OWN4R01PRE50MFk2enhhREN2?=
 =?utf-8?B?TDhBMWJUWkFua0xRMmRaaDc5YWFyVkY0WmphYjBGUVNwTURML1BPVlZ2ejN6?=
 =?utf-8?B?SDA3NnFFSDFrTHkwR096cUVZdXM0M3Nwc00xZTFNR0RhZURNdDBFaW9OeXJW?=
 =?utf-8?B?QUJUdXdhTzdidTRjUkNtSVBQZU84cHlTc2ExOTlmLzdRQUExU2ZGMk9YeXpM?=
 =?utf-8?B?dENWcURhMmNDeGFZb24zOWpZbUt0OVlLSG1tTjRvMnp5V1lhbzJLRm1TWWxv?=
 =?utf-8?B?aXY1bS9kUXdJQUZNOUd6RndnMlhIc01uNERNQjlNakhQdkNkOFlGcHFTUkE5?=
 =?utf-8?B?U3NQQXdqNmlUTjhFZTh4WWwxbmNIWGRBc1dseVVGdHdDSUt3aVdSS1JXRW9H?=
 =?utf-8?B?cFlkaWJtcWhpMG4xVWFVQ01ibGpGRThablVXQXhvMGphQitKTWVQM01UNUo0?=
 =?utf-8?B?V0Y3djNVamR6YU8veGZqazNYU2xSc2RJc3pxYVI3aFZhaC9YSFc1ZXlSa3Uy?=
 =?utf-8?B?UkVQTTJBTFVwRE1PaUFVYWlhU2F4VkUyaGdGZ2hSK3g2QXZtV2tRK3hXK0Fw?=
 =?utf-8?B?TTl1UUpOdjhvdzRTaEl6NmR4VWdibkZ2T3QvM2RuVFRVQnpLUENEUCtIZEVZ?=
 =?utf-8?B?d09USUIyYzNZTG41dno2MmFnellwbDFyQk9kUTFsSnJzdEp4a3EvT3crQmw3?=
 =?utf-8?B?QjlUTkJaam5IclVSTWhQWHpqOUtZUld2RjV1ODJHaHpYcGZudkg2alFEUWZM?=
 =?utf-8?B?ZTJNL3NZbkdqTWwxbUlGYTRNdmtYVlo4OHN6by9QK1F5L2prcTZMVmdCa2Jk?=
 =?utf-8?B?WEtQRGRESW4yM2hsSXA5UDJhS0xqL2tPWDdDK3JSM240eDJWQmtSQnVsRyt1?=
 =?utf-8?B?ZDJYVXBkeTNlVnpDNmljejZXZGU1ZmNqYVRaY3ZZSkMrcGNpNS85Nm42QXZM?=
 =?utf-8?B?V0E2di9LVUs0TXRod1RZQmFlSDdPZ3lNakZJU3B0SE9uU2FER0VIVVBkT1gv?=
 =?utf-8?B?cWRpMm5KNEsyVjA1VS94MUhGWHBaRTRuSjJLMkFvRFVNdkc4aXlpaWtyY2xD?=
 =?utf-8?B?MFRTSlZGL2FjZnRJMm5jamRmY0l4NmNObnQvRUpWMjM1RnFMV2NMdzVKZ200?=
 =?utf-8?B?ZTFsNjFwUm42dVBNWTJnRzRoeW80SW5IdXY1eFU3bXppYml4UkUzdWFlZXdW?=
 =?utf-8?B?MkFVTE5sakdBK0oxc2xCZGgvNjVPanR1VjVGRVdlbXpWd29TODdNTkIvUTE3?=
 =?utf-8?B?bGtKUXF3U0JrR1RHRzAyVDZiK04yYWJjdm1mYXI4Slc2TFpOM2F3UUdsNXIz?=
 =?utf-8?B?bUdaQnpGNDBLY3ovTFZEbkxxRWRPQ2tHakZGVmZJcGI2bkx6eFdvWStmaEpE?=
 =?utf-8?B?RDl0L1EzaU5TQ0lIR3pkZnV3ZDBFK2V1R1NVb21SMklnR0IzenI4US9td3VH?=
 =?utf-8?Q?tI6Q9ehO4m72rhnhy+KFunMb8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0e37ce-532e-4b4d-928e-08de1f159ede
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 22:24:45.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TytjjafpxhNyPkLXeZF8v9iULKADEZcEVTvy8kuI1c+EgIOu5EAeHjMmXXqIEm3UgZiMPU/2r8clGqcvcIlesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

Patch 1 Adds the binding for the msx4 cx8 switchboard
Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing the nvidia mgx cx8 switchboard.

Reference to Ast2600 Soc [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
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
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 235 +++++++++++++++++++++
 3 files changed, 237 insertions(+)
---
base-commit: 38a2c275c3d3f7d7180d012386cd6fcf87854400
change-id: 20250908-msx1_devicetree-7af2c1fc15d0

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


