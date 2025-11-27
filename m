Return-Path: <linux-aspeed+bounces-3009-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08ACD116E3
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:43:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGyNJ1nxSz2yvN;
	Thu, 27 Nov 2025 11:43:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764204224;
	cv=pass; b=m9s+8MLdZvpf6tFEg9FvIAx49CiB2dMKVbjgKhGQzUDWyi16SZqoS4JcZpJd0o3akBK0JKp8BTLkrftkc9m/hzIYdFJHoH0BgVRNzrhlvNHZlGcl80qmlWCVzUJtPocFQwRxTQp8bP3O439eOkaAXkDo35akuypZ0xxaBI1aInteoX/ow1A8CmmJXLMaVDNJl0WURTkoTJB2Q8k981jXKZryN7PGhytH2mT7WuRjtmWYT5cfz8IhspEqovmRQFhGVfn4t+TUC4NevH/UIBP//iyUHZ6bi2U7C3UE5u+VqjlYKeXUSZmhxcXRnfSADhbF7b7UqsWo6JkIOYKkOh4Bnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764204224; c=relaxed/relaxed;
	bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cuGqR4sdQKn4f7J4WryxD7aBHhMvG/mNhCD6JanbHVC/AlS0ItuEoNI0SaNTK1EZx43kaY8UmYcQv9X8GttsHKtW2ksyHywkgDpBW8LmFienm9khq6TsMYbMh8EFKTxeA26UP1D8tQnANmMe61ojpV18rArr+9A4M4iLnHAqyhA2Eg2IYYKKU+fkkyzcFezmXMS66mL8+2WVx3xr7cFJ8ylShH6n8P++2G7fSh9VsDu3UAxIrUjQ6AkbBPLrEskL3mXIL9yYxyWpzk4idvA/4+a5pSdH65pXpOCHX0HeDLmdBvpGAe8TnpeVbQIUHgdy05PBe4bOyCyB47RgFxxp8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i+Jxrh/n; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i+Jxrh/n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGyNH0d2Cz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:43:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOaN5z5du1l5kTtaz9/eFeM3zJrUED+yKEO/ignkdwDSQ7o/hKpV5v04Pg4cnr8VJ+CRM9yw/MsHeJ1QpdFGx94rr29ruE/m7HiggR4bQ4+Ib6dsYiJ9ej0WbDc4MKlXnjF63iqgB1Fhj4T9ehsQhh2S3F+tmfWUQ66sYGFw40BpMXm4zfE8rv61jwVfN6fkTdDCUilv8gnVgCQuFWHqr3rkidjgDMA0BJwwlpRupEWjDZ32fHu4rLnIjaxphc+GvhaOpZrI4p86kOIpxrCkWrIFwkKoiJ/ey80W9+2aGCnCqT0MQGe9vpsGv0clMi62z5MM52FEbE8gSOxgGWg+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=BZO77oGZFw63MqmbDw/CksiH/rq/ERxh7ObDsDvCIB0UDJdmZYG43JvmeA5sOfCRmV7ovzPmCl5ZMx2zlfqON2+suF60XTkmQ2i5U2pU0gckvW5UFC10QohL6MoWc1G1+EAhwWEtqsLEYSwZttQl4xvD4GQP7WmaM7QKLbiGewKqrGe3MRnh1k3dn1dTbah/06HDjNLR8TfgJa8tJ7SP073L9XAAuK7JxGswqwrElpsYOWsMHQgNntw2oBKTcn+RCepVovt10vp+DPLJhSouEGHqzDVe7CsT4WVmlxU7e3NTDEjND0e+X/WyynLt8kC2FAp8xmV9YsJu0QlysTqWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=i+Jxrh/nVbb4jL8VGYqRPqdgIp+vUsRaAqNi/+WSBRQsjsgB/dTtZ+ByRd+6H73vVZSu9Twobzo6QRwQD7qRlUmkHvlLvf/cTqx3HcgzTApE7RoJuKXE3sFKs1kP/FQieM/60wfjvW65tf4oUqBuLUzHUF7tOBufAEKcE6E2QLM9QKOJKZPYCrjKX1T+TYGP75WjSD1ktTqi5kD11wFjDBFC5VlZ11T2db7PS6mWPSd9c03BJLx3zWvz64hZlm5l/wBQlN7Wz4TyUll5Rf6osius5HjGAONgboweBAXoNzB4F5e+GiRAZ3yk1019lu1TOEOK9BWXBib9ZV8IAF5mKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB7855.namprd12.prod.outlook.com
 (2603:10b6:806:343::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 00:43:16 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 00:43:16 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Wed, 26 Nov 2025 16:43:06 -0800
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-msx1_devicetree-v5-1-e508d13e2dda@nvidia.com>
References: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
In-Reply-To: <20251126-msx1_devicetree-v5-0-e508d13e2dda@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764204193; l=928;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
 b=jliNTQhH55wdxoX7x48yrbz9SkQcpWa3KwlKFk3fGBe+59Cw89lq3kPbwmaLyjN9hHEAW2xuk
 dUxoufPLQTUC8YG91Vy7gnQOlhL095HG5geDBtaKFkPkz7f3pdxcbwn
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:303:16d::13) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0bf65042-771b-42b6-02b0-08de2d4df3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU51REw1RDdoYWgzc1JtanEzYjQreE4zeStNTnBEQUg3R1BIbkZFeHU2T25S?=
 =?utf-8?B?VkRlYVNCQ2NGK0FtOWtJU0lGYXo3dzdkK2NTWVVwdkhPRFJFdWdRRWh0UVZ4?=
 =?utf-8?B?akViUTlVc3RSVWE1M3prN1B2aC9VWnFzcWVUdmplcXVNblhxTW11eTRGd0RV?=
 =?utf-8?B?RHlRTi9NK2FQNTdZZitXZGpEWHd5ZWl3QTcvQ3hXUzVVeWx3OTRCcmFUY0xK?=
 =?utf-8?B?YTZsSUQvRGVOaU5GaFdtTkZiem5zcWF0aUt5MWo5TEpVY1JnZXRJV25nVUpa?=
 =?utf-8?B?SVRxTnFtT0xCVllGdjIzUFFjbFJLTkQzcjVraS9tU0d0RlNpaVJKL3grVXZF?=
 =?utf-8?B?eEw1Z1lxZFBaY2RYZHhNczFCUytnNTdhSHBZcjI4MkpQTEJKSmtmZzljWDR0?=
 =?utf-8?B?aldBNDdVZHRKSUNtT0E1b2wxNmF6ZTl5NVdSKzYvUGJYL3hXbUZUQXoydU5x?=
 =?utf-8?B?cEt0aVloeDUzTDNvcFQ2Njk0Szdkc0k1RFQzQWJiUS9KaFNMMm1MMW92N3ZY?=
 =?utf-8?B?UUlNTnlicjdQQzlvMnBPNDJ2WGI0bE0xVVBWTk5EdHI1VDBoQW9nOTZlYTND?=
 =?utf-8?B?dVZQR2gxS2ZuY3c1aW1UV05CVytnME4xT3N5SFdNU3F3TVBxNDhMVTUrWCsv?=
 =?utf-8?B?M211WWhVUi9xeHpWOGtUbXV1bXp4LytJazBqVEMwRnlmOWlWMUY2TFlibGdo?=
 =?utf-8?B?UUFiM1A5dXppU25hLzFqbDZPeTArREJlcjVIaXlBYW93YkFFWFlYWlRNL3Ir?=
 =?utf-8?B?R0M4bWVLeGc3empvQVpTQnlDWDUvRnYwK1BHT25IeU5YWVlDK1owMmc2ZCtj?=
 =?utf-8?B?VWY2ZEJqeGx3aXgzajVqQnAvNnhxaHAzL3Q2NHpRbk5yckdNOG92ZXlvZkVH?=
 =?utf-8?B?NnBIa1FkRHZOaWthMVZ1OFNKNlE1aVVaWmdoUi9scDNKWG01UVgyU0ZqL3Bt?=
 =?utf-8?B?QVNERmRBc0JYZS9MemFHQTBJeEduSU5SMEhrU2E2Vi9tNThwM1FSUXpveEpV?=
 =?utf-8?B?MENkdFVtc1NwQWFvaFNzaHZKMkJWbnBYbTk3WDB0V1JQK1g0aURSL0RTUWdj?=
 =?utf-8?B?TEFpTnZKcENaVzE3OTd0aU84WmxUWWVLUUhoUW1kNW9oZlZ3VjhBY2FaZVVD?=
 =?utf-8?B?ZnhGUE1LRGZ5dlllbUdZKy9jcVRpdFJXYisyVlZuVTBVYytYajJoazY4bStr?=
 =?utf-8?B?aFkzUUhHMVNjaURsOTdHVTZ5ZlN1anl0YkF1Z1IvQVdpWUJIRVFzeHc0SnZh?=
 =?utf-8?B?TFpqdzRSQnMrTXd3clg0QmoyOHRHY2FKcGZCUU1WM0xZTWs3OUZNY25BVHg5?=
 =?utf-8?B?Y00yRm4ra1IrZ2hXamExVkdxS2NxcWVGbDliK3RxcXZTaXhLTjF3eWRHRlBL?=
 =?utf-8?B?RXZtUEZ5VE82S1cyTEU3eUt3dGp6TEgzRmVXKzk1WmtuZ2xKZmNRSXVDUWZh?=
 =?utf-8?B?cDFHejlOTVB6VUNweVYzd1F0TWt5dWdMTENMRHl0dWM4T1BvUCtjV1FWekM5?=
 =?utf-8?B?SGZva0xVMWlFeFZ3S3ZKaTFjTEdWUXkrbTlXRy9waGJady9Db1pZUVlWSUQ4?=
 =?utf-8?B?bnZDUFpiaWNQblltNzM0bnEvWVcxT2xTdXNUYVVMcDVtS05BQjdOVnlXWk5v?=
 =?utf-8?B?SWhyUzk3V0lMdmcwV3lQbStiR200QlpsSWhUVmRCVGEwNitSd2NIbVRPdGpE?=
 =?utf-8?B?YUNWUkpKTXAvSVBQTU95ZDFmMDNEYnpDODhZUE9EbWtYWFB5N05jeFZ2YVB2?=
 =?utf-8?B?UXFycHlOazlQWWRGNkVnMzUzR2EwVEZkQXY1bUR0c08xN1ZyRk92U0ZDeWZQ?=
 =?utf-8?B?ZlF3N0ZWaDBrdjdpOWhrQ2Ixd3FzZjgyTlFMbWRELzV6cnI1OEFzYTBQRmRY?=
 =?utf-8?B?bCtPTW5PUmwwejdDYmY2R1dpajFDOFAxaVJiOG1pSlYvNTdvOUZJS2ovRnRN?=
 =?utf-8?Q?5SJG0W8GLmu+9kPcurKUVGmnbEBgMBAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFVORHAzVGZGVHBtNURGRXB4VWYxTHNoN2M2ZTVTZEhQU1R2MFlWWU1yT2sx?=
 =?utf-8?B?YW1YWStFQk15T01MRS9PQUc0aDRlSDBlR2hCZ2R0Z0hUMXBuQ3M4NkxLSVV3?=
 =?utf-8?B?T2Yyam1ZRnFPVCtQNU9haDFLVkxXZS95Smk3Z2wwZ2czN2V6ZDRSTFhZV3Az?=
 =?utf-8?B?RHFLWkx6WUw0YmxqazBrTFR6TkVjOXNWaisrVHAxUzBOQW8wclFuVElrU0Nx?=
 =?utf-8?B?elNuejVod1BIVnBEbHNITG1WNHdhcFFVZE9JUXRVVVlsQ3FKSW84S1VCWitV?=
 =?utf-8?B?YjlsYnB3ZzM1TlNtK290UHJ6TnNDd2N6ZEM1RnBaWmgxV1hIcE5wcDRwdERq?=
 =?utf-8?B?ZDF1UFQ0Tkx0bXpRTzUrODIrZS85a1Z2NnZSR3hqVVF1T0dmRjNSa25rZytM?=
 =?utf-8?B?N3BtZUllMlVJU3BSNjQybnlYUkQvTWtFRlZibVgxTkdYN3gybWN6cnVIMHpu?=
 =?utf-8?B?MGs0S1lzTEgrVGpDM3ppcUI1MjlvQmJ5Y3Z0M0xFVG4wcmdURm1hbjN3eHNh?=
 =?utf-8?B?eFlmZUJQbkZHMWxrYTIreXkzbUF3MkZycVEwOXNUS2VlTWlia0M3RVF1dVoy?=
 =?utf-8?B?OWxIYjJkd09rZXpHSUt4OE5wSklZUk1kcDFGUmJ1Zm84cUJIKzI3VEJBWGsv?=
 =?utf-8?B?dWQ5WVNxeTlmZXBGZEVyY2hGZGtub2dDME1KVDIweVJkYkpPV1lsbStFM0tv?=
 =?utf-8?B?RlRmU3B1NnZ5TzhVQ2VUdkNPWXVXV3MvVFd4SG1mOFljd0R3VmhVZzVFd1RS?=
 =?utf-8?B?UHBOZzFkSWRvUmplMVoxM2d3MURPWDRHU3FJREJScU5XYkVpSHE3bTFVZCtz?=
 =?utf-8?B?Y1NIWE9lODFURWJJV1Q0eDc5Q2NXT1U5VUYvcFE0MFNjVWZXZ3F3S3cyKzJp?=
 =?utf-8?B?Smh3OWNRZ1FJbDdNUll1NDBrS2ZrTktScEhoRktkSVhPYWJPRlZha1dCelBM?=
 =?utf-8?B?dVVDYjUvejZqUnJobDZWKy9jcHJndkZqZHZHNzJRSzVwMTlGOWY4b1B3aHlQ?=
 =?utf-8?B?RnF6WVF6dDJETHVBOElVaUhiREZUWjhpUk9sZkNtUzN3bHdNOFcvcGFVTUdO?=
 =?utf-8?B?WVRzQ2RKQ3QwSmVad2VyeEsxd1VpU0NCTXE0R2ovMGd0WDhBUXAraTVZRlcw?=
 =?utf-8?B?aCtHTm5OK1RyQ2MxZm5WLzgwOHFvRG9teGNjUGROMGhHZ0UwSS8yL0JxbTVz?=
 =?utf-8?B?QnYzUmpzMnhuOHBtV1lxS2lubmJzSDFaVC9zUVJRMFNxTjZwN09tNUEvMHR0?=
 =?utf-8?B?VWNyQXppNUNZZTlDTUUvMWNhVXVVU2dlazJqQVhMcWNJV2ViR1VCc3c2U3Q3?=
 =?utf-8?B?bzVWYm11cjR1eE1ZK1NoSXd4a1hjb2pzZmRHT0d2S29SV3hlSmxZdnZqd2xs?=
 =?utf-8?B?cWJiWlg4czJMaG5VM0x3Z1VBMnRpUWJGT1RYQytrUi9OSUZhaUVmbWM4RFd2?=
 =?utf-8?B?aEt1YU5EdnZHeFRhTnV4MkExNFp4cXRHbmFWQ1dKVUtpWWVvWm5qWitWaCs3?=
 =?utf-8?B?Y1ViaEJIYjhEUXhlYXBlM01RV1JGNnVPYWYzMzZRZlNRTVhWSkQvdlRwUzky?=
 =?utf-8?B?NllOV2d1R3JZM0puYWJhazB4OGZqZ2lGejhzMXlzb0ZROGhOQVBkUklrbWto?=
 =?utf-8?B?UUowNjR1VXJqbk1LTHNEWXM1MGNPeFBVbnJRWlJwZFhISnlDcitmQ0c0UVlP?=
 =?utf-8?B?N01QbFBaRklaeWhydGRWMGwwc2xZMmFuYWV5dGhQa1hXN1owUFdrTi9TMU5o?=
 =?utf-8?B?UHVHNGI4aitRY1VRZGhRa3dBdms4QnR3V2c0SFJLV0hYYlRBdEVGM0RNWkI1?=
 =?utf-8?B?bVVEWjZwTUk5djJxcGxjVWNIRkNTdm1FK1FEdzJmL01SS1lOeUNWWGRhYzJW?=
 =?utf-8?B?MEs5ODZaQ3BuMDBlaFZXZ1BiUk9reE5oMlczWGJCSytHSDhKTFdnWS9PbmV4?=
 =?utf-8?B?VENaTkhKWnN0WEFVY3hIVnM1Q0hkMm9zZnVPYkROc1BCMlRkNGNpekhEWG9r?=
 =?utf-8?B?SWdSVDN4QmppWHp2ZGw1YWpYc2RjNi9tQUYwYlRpa1NVV2FOVDBlRW83ZTR5?=
 =?utf-8?B?MTR0Z1oxbTkwWS82eXBlcXNhd1VJdnNNK3VPWGNxMnYyb01XckZxcEhiaUhi?=
 =?utf-8?Q?koiBILxkMzgCpj1v+dkukjEse?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf65042-771b-42b6-02b0-08de2d4df3df
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 00:43:16.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCxNKadcss79/0ITejKXmWPzy+I7BKWiFvMZh5cVCD+etAlyBCWs8MxLqGNW+eSpqPkYrvBDwWYYFqnswz9elg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Adds a compatible string for NVIDIAs msx4 BMC board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a80b5c9d14098b60ce277391fcdcb..5933eda3371b33f16a1129cbb84933c1393c9b2a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -104,6 +104,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,msx4-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


