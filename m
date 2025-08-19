Return-Path: <linux-aspeed+bounces-2000-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33344CA0EE6
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Aug 2025 23:34:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c65X76S7Nz2xcD;
	Wed, 20 Aug 2025 09:34:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2413::613" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755630626;
	cv=pass; b=Hb2wWlUfi8VhwIacxGKpsglEGeMgJa7XnWiPGnDx98TRi86xSMbNopecWr9M73Cxq8J8IlvBk1RDREJAf/GZpE1B/JN0edCj1SpLRybPYl/QVpbA+JzkP6UgNdLpo6Gk34F/HwmERMPD3IPOwnp9LAfiQBQhpoA/an8qovE1fcaSnFGhAaF5YqVp1kYHHeKHF844JpPt7tr/Uk718eCP0y8GQNDBwx66TJe+ZI80IKqua9tgzU7GaeFkb8zCgldDjmycYmmUT7xA80vc7F0GtkqClcLor6ADb1V0oyPCmaJihLvcqm5WV0XORKBmOJ5sFq6B+k7nxju2Hiw7ovKcOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755630626; c=relaxed/relaxed;
	bh=yvMuVwJsZKFZ0Kkf8zz6P/EOG4ohN3OYQrHMnAT8Mgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QzQlW7lrO6tFB6Eu8tSd8zlcO1i0qX9dEX1Ni8umiAc7V1SVZ2ambaij7EfP9dDFZYyMjR4+WW4D8xxb2HOr/KtPV7+Q5JDWgT7bbPq4HmAWxfyuG/nfA00HKlCmIXVe9Y8TsaDa5PpsW7xmyJWt2tAcc02dlCLva8E4m5RuFI7Vh2FVYq1B/Zf4LRI9MF4+LOljyF1lVDf8Q2GAgAEiULLSqtAnYyHoxuy3J4eQuLClNwQ4FXZHpUOhJ/oISbAPfaRGuxiNFbs6M5lSaWfbawe8EpD8yIx0liRCkOiWJdPJwUra4rn1eKErnViKr+bZBXLXK3sYCH/ggsOJMQx/wQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eheewyKU; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2413::613; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eheewyKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2413::613; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::613])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5zgP04NBz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Aug 2025 05:10:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKEvBkCxk86U//D1gqqjPdxTTCmrEAxN7VJIs2ekn6a+glZf0k1OijsavOLYriRxl797o8Uju0lXpkuSWLr5VLeUrTKNTqGNUEknpjZuYwo1BzZXzYWvBoRa8XI2sbri4DAsDiv2GRu3Gpv4PKDzIgpNwHudYceK2Y+AKos4JbzKrW5ArOvZcQUopAsAG9G7mYClGQ3h+Ev+151l2Iy8MsQeeT0ECV53LGCJf8YzbcLC8C53j6Ck0stBRewkJCR73UW79NA5LP6fSuCOMvv26ywPRkf8doetIryIl/Ule8EC5v2940HfbTcnb2W7uOZILavlDvTTSvOH/dKhJ5RzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvMuVwJsZKFZ0Kkf8zz6P/EOG4ohN3OYQrHMnAT8Mgk=;
 b=GK1Xc7vpHeFgTez6ks39j4yHVsQIPMzHqeP7i0Ugt5idJ5KbVO9/iOJifPZntbuVTX4m6BxiIu+Z2MwqsHmVSfrjjbluwAfZ+lr6Yz4kb4Hl8fNS34/12/G0aqi9o3NuseiI2iYYJ4i0Ksm3bqbAxN6Q5KlBos+eaHSV4+EXxwquDZx+U4JFDvRvkadPY4mlOsZ84X58B7cj1aFqKwhU0oHU6krhxU8Z3C0+5Etyg98nioncHgw1VcTSKoTP0nNcJpS4FELAfiVBmgjUQ1B4+EJFZihv8fyWfpBguOzcnt0ifShZOMM8yK1Tlf9zLi0PkbEUiThQegMLjqHXd8q+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvMuVwJsZKFZ0Kkf8zz6P/EOG4ohN3OYQrHMnAT8Mgk=;
 b=eheewyKUZsWxJCUS20zNZfywO89pgDaChi8WsgkM7NI35v4XJrNHes4s+XsmI91TdrvDx2Dh02QaqlyKyLe0EufQvgGfMlM+Cnq/Nc4U73lbuE7trf0kgCcd9AdLZ7uuVww6vthPrYjRgplBhPdYYFuSLFRy9nf9+TBiSxzfl85gMl/sRweRs6ttxNASJEukfMbNQebcdK9aTnd7NC38yvVpq0aEvRfZneog+k+nEgY1Caui8CuZT4YwpRt/QzpoGqPbN5aAjDFKJr39BixKS5NK9SME4sSLaJfFffxX8ULWgIf550f6NzYgsoFW99DmPVeHFDZzGGoaElrNw2hlYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667) by SA1PR12MB6677.namprd12.prod.outlook.com
 (2603:10b6:806:250::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 19:09:59 +0000
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da]) by DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da%5]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 19:09:57 +0000
Date: Tue, 19 Aug 2025 12:09:55 -0700
From: Marc Olberding <molberding@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: Add device tree includes for the
 cx8 switchboard
Message-ID: <aKTMA/006Nl/tOPT@molberding.nvidia.com>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
 <20250815-mgx4u_devicetree-v1-2-66db6fa5a7e4@nvidia.com>
 <f1f7d028-0c8c-44b3-9f3b-0830e5571890@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f7d028-0c8c-44b3-9f3b-0830e5571890@kernel.org>
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667)
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
X-MS-TrafficTypeDiagnostic: DS5PPFEAC589ED8:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: d347d5fe-547b-4405-de20-08dddf53fc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8N9p/nbHRn9H52qyHWECast2Iho6erRUEzUSQCKNhLsEgFvz1oLH8Wf/rA9?=
 =?us-ascii?Q?rcxNyDUcaOFUteOF9wMdzQ6SF4WodNUTZCk2gVBe0DuKtqzYxNhuN5cTr7wj?=
 =?us-ascii?Q?eUDWttde06bxTh9+LCax5R0dHMmFSaxeteurPxJAoO2dRZhkIO7otjvyDApp?=
 =?us-ascii?Q?K35B7lrFwf2aNB22F75P/9X2Fx/8X79Rd98z9i6+yH7LY6axR0dFiTDtW8cH?=
 =?us-ascii?Q?WLsj9qVMkEbQD/NcNCmhlKT3pqOrf7ZsCwy/70tbeGeNg2jDL3/3SWGx0V7i?=
 =?us-ascii?Q?TNzYs9OCSb6OyyYhkjX0OrVtwyssBRAVi+/YaLEOehsa9XifHScuBo2QnxsZ?=
 =?us-ascii?Q?yN2Uoikx3EqAlMgu3TzLm+CEsQGoen55uJXcj8hblSb2UTGeeOFSPAdbWdjV?=
 =?us-ascii?Q?NonORJ7AqC84H1ulQWmrmXDLhBNRLIvKxvPsRKtfoD4kOlvle/CE5aQhWqcL?=
 =?us-ascii?Q?Zz4qxmxW8DnTwFQnMgRfaY/2QeYQO2ECdwvCBB1iOEAdJ5JeTbSYcmbc0J4D?=
 =?us-ascii?Q?OOs1l18O603C4Xk52npziZLV3VnTz/udN7OI3u/H4gKUT5gqY6WLGd6kEw0g?=
 =?us-ascii?Q?iTJ7hEhiQc9JoVby0RBczc5nKD6v/diiLEb8EcedQgcCxDsKt/cU0I6aHsE7?=
 =?us-ascii?Q?46mgUQqIMgc/an0rD7hvbN6lkzUQ99yXEc454NOgYf/ku9DKbvJaOBBgrVty?=
 =?us-ascii?Q?bfQzKHlW6qQheQ9B8McHZV/9HLqfonAlQKjzyITOHCgCpNo0g7M5cpXVYB7/?=
 =?us-ascii?Q?4+xnay6XUbn0F8i3tRXzBIPWDWD08DSI+15zCoDeQAYqw2Kie92FaP0jmFcx?=
 =?us-ascii?Q?t56L0/VZ8mgabzKKwW53579fnBuAdqVw4CbFyyRaU0m4rBRC4M4+mOd0uovw?=
 =?us-ascii?Q?NPMsA1ZS7s1NEi0qbI87ZDTCZ5vZbYkVcO0PZXM6RjXIpPluUrBaNW84cxwO?=
 =?us-ascii?Q?V8fFIqeqw8v4xhGptqkvprO/H8/871VQVqbKNwBNQWl0KsClKR7KcEyqSEm8?=
 =?us-ascii?Q?FBLssMjE4zgp6bRgFzQvBHflKDt5hzYq559dWsKqQ1KnjXKCYbOemwCngu3i?=
 =?us-ascii?Q?igirBdWcaDvGxHspUKe+7YSxXHH5YweATO9P7ENsgNhaJ7EmtlDQo/Zzxq4q?=
 =?us-ascii?Q?sgp3CPQxHm9IpwAIupXkFDuwjCUf8KcFFVRvjFtF1BP+DO1Jfyjr38zfyGAh?=
 =?us-ascii?Q?KHgovPOUDMu5lSGH7oPO9Bfip+NY48SGCHCBn5ZgzVv+PsJItxJFZNd6x8Mo?=
 =?us-ascii?Q?aDHJP4Tm4uS6AYrbkaSQeydyBDioTeGQpxB5T6LJAK8nuiDqPbu/li5rULPh?=
 =?us-ascii?Q?1yy+zQwvxNb6tETa9JbXHzznx4tt8DsVtzxORcPn3v7kDKOg4gA5EHLgrTLh?=
 =?us-ascii?Q?1W8Y0cXF43ETwIS9605wWWltophaxQqUuUQzJuwDNr6yfeLwStOF8tN9HY5D?=
 =?us-ascii?Q?1p2pKuLOQOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFEAC589ED8.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtUeKuZUhxpT8BzYg0C5jL8CjroByoYMs+V/KZ5EBBO6vUYSBoxf/lRsutKS?=
 =?us-ascii?Q?a+358T9pHbmAB/fSpLfNd7yPS/poVJEBbIT282oOgxJueqnSdJeZ56gmFtvs?=
 =?us-ascii?Q?1vjqVbi9mogMUDIkMfMtHeghmOOCjtny39tBZGBnZE1mRTAfRkyeqhkuv1He?=
 =?us-ascii?Q?MyDQqHDLRxGB/X060oXa4guQzYQFd7VUpPCGJQtOP89NLD9M2cGtloIvV4Ic?=
 =?us-ascii?Q?fCAQYP9XKA0RqM7AEIrq1jcu9EZOF1uOGCACY1ymvusrEBHKLNGqXS5fb6/T?=
 =?us-ascii?Q?mxXQrqzPLvciFKJTTSv0ZqLwJ2Ky/LNT0JmQj8HmkPuIyISF7PMYz5G5pTqF?=
 =?us-ascii?Q?9iK7x1stKfLAPpS/CbXeIxPHt/K4aUxtskNPe/9t/HmIwnwbUEltc/gTrFQj?=
 =?us-ascii?Q?D8Pm/VZJV3R3TcZKFDwAnyK9yeSmZ5+wOtZIkuBOY3Sl+2d7q7ETDrdXYrf9?=
 =?us-ascii?Q?ZfLYjglgwTYIQi3185IlFmkdkMQ/enVu2BR6Cj2WfHMoUPLqH07hQImpF42k?=
 =?us-ascii?Q?Oz2WVKMBk/N7HXwUaihPcIHDM0vVM7RtNWgKBYjiLzXazwelJ9PHfM5CNTtz?=
 =?us-ascii?Q?RNyzMWPUjDt2CUimcUJtjW4UkNDUrSfEWTxUifLQw7JgP/PQ+Xnc4Fx9qJQT?=
 =?us-ascii?Q?VLlHOvdP/18+qorG/C67Batn3B4fmX5s6nqtKbpzPva36goEyg0QiFhTIyFh?=
 =?us-ascii?Q?vPKt2WsLiY7zkZ9j8CGeKiwvW6XDcbkoItrKIhDnybN/adgqRxtDTzh99gr9?=
 =?us-ascii?Q?yGXwWUfSTDLYhBzwGnBcMcOC6uv32ccGzXDYFCWg6+Fdvky0rEtmd0Bo1iOR?=
 =?us-ascii?Q?XGYgzvJ4x/s3wN2V5fhV5EWRtzuXkhGCWTzrdrT2z3VPk0VtCadWoKYlKNZR?=
 =?us-ascii?Q?mDOnvIgT8mV7WoApO9kkhMJNRqY7HYMGyLT2RbdZMidV7aqW7w6EaDX27zFp?=
 =?us-ascii?Q?WXJ3DjGc/CbCDYtRPa2j0DpG331CKOHPjl1JwfyebVBY7xH0q0KOHtMX7OGD?=
 =?us-ascii?Q?IAGP38ioQGQQQo44KH00kl75SVDUk9PMiUJjAyrD7GwEAASvlm0axK6QqX3i?=
 =?us-ascii?Q?Dxqfg2R1cq4HO1C8G82Cv1dt/WF8eN4P7rBSPJOtFEExQWT1vyCPvNTclwu4?=
 =?us-ascii?Q?ZktNxaQA2xU9EhEAaFylhLosUsSRbUnCocnW5xx9LH15Op3Zh1c6m2kN+THF?=
 =?us-ascii?Q?uAbMkxEC4WbzuJ6lMZp+c1OMp8LjJZfohR4NuigZh8AYaqyWZuw/sOnFoDHI?=
 =?us-ascii?Q?NpIVo8ImHGfYWxeag1yY4DuzjveDUvFBtklr7tP3mubBxJUu82wIv1cl9Sos?=
 =?us-ascii?Q?a5NdtkVgnbbIdcecYr19jWi474DEaBww0DzLHGXbagVksQBng582egHKNyuO?=
 =?us-ascii?Q?DvwR9YppXkIEObQcyU4gmbGfZm398YyhQ48CT2A7cdFGzKxH5vo7Xfau7FH6?=
 =?us-ascii?Q?d4sl6M8ODM6ua3xylbH7cAcSUNvNYElKblK1hwlpeZWiP24vj8q3Kd6BtaYA?=
 =?us-ascii?Q?ORrbwVD/XgHiWEt8VPaBGXx9bKnC/88G5EX1DYnUCI3+Uy4+XN+k5yCz2xZt?=
 =?us-ascii?Q?sYQrNRw6U5g0AxJi+RBEb5V6c1xhnlk1GlECEOjY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d347d5fe-547b-4405-de20-08dddf53fc3f
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFEAC589ED8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:09:56.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOCagLxrTq677NIu2ovbqUq69pAIYSfzF0l6TLB6Loy1c7uE9zgzEF30clfNw04YUUrMFxNHZeQMxf2wmwG8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

On Sat, Aug 16, 2025 at 10:16:06AM +0200, Krzysztof Kozlowski wrote:
> 
> 
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> Odd license. Since when GPL-3.0 is okay?
>
Ack, missed this. Will fix. 
> > +
> > +eeprom@56 {
> > +     compatible = "atmel,24c128";
> > +     reg = <0x56>;
> > +};
> > +
> 
> This is some completely misplaced DTSI style. Don't do this...

Thanks for the feedback. I'm not sure which piece of this is wrong.
Is the issue with having the contents of an i2c bus in a dtsi file?
If so, would you prefer that we abandon the dtsi all together and
add the contents in the dts file that's currently including it? This is
a seperate board from the one that the dts file describes, and others
may use it when integrating with the mgx-cx8 board, so the thought was to break it out
as a separate file. The only interface we have to describe between the two boards
is i2c, so this structure seemed appropriate. If not, I'll gladly get rid of it.

If its something other than the file structure, please let me know.

Best regards,
Marc Olberding

