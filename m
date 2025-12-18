Return-Path: <linux-aspeed+bounces-3147-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25414D6E2DC
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Dec 2025 18:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXKTG65Bwz2xrM;
	Fri, 19 Dec 2025 05:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=40.107.208.13 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766083762;
	cv=pass; b=QTjuQew+3Q1awjI70lYIvEMU50s36l73l7SxLRIyLmS9OGzAaM42Tf8i37jCM5PWfPOuLCTNB9yEaZupg8FflO4afFYXBdilQbi8SeJiz6JRDoAM07z8+0TDA8z5sQXl/KQbhYkV4GbYBBN4KO5NFYsKQWC3mFNUeGyiPt7SQUDB3aQqje2wam6xIicE8BiR5C5ZiUm9W5c5VjJLMQf8DvKPKEcsxVIheey8F3HStrTaC52aKqUpHRlL4EMGJdXf0F5+xg0ahodKsa/qq11oiTEiqVk5/nMiRUi72G5wa5XYcLpcbrzWQcdF9amN4Bw9yX5iEsu7IWnyPqxtlixolQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766083762; c=relaxed/relaxed;
	bh=8V8w8Nx3TBWoQJY5f4eakxNQJHa/PmaoMxuWcr36T/Y=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eDSW46+wmKYYtweeincCG2n7NlnZJWUp1NQYVJJwFEZoEpIisLBoKK4+6ti5+9+MlQa+zt2eDHyWAsnN99Br4pNphNuoxCUiAX1LnupTltOMMntIPUSlsK4/dJ7hWknVkA3YJXJ4hLgErHYkUQ/net7yNZ3byOrf7fyG1UBJCqe9FRdxfytOA8m/n8ShrmlKlAw2+pz5WrDadvuPb/uYcewkeKWyDk5tsgp8wyYIF02qYkUY85Mvdoqwc0IlB3w3vp+TGkse+q8+BjKoFBdbMH/yuh1lkLgTUUGCmM5p010p/9ft+dVGv0uDUXqr/LAQ0ORL1ucSnrq8VoymKL046Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pXY7sZ/P; dkim-atps=neutral; spf=pass (client-ip=40.107.208.13; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pXY7sZ/P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=40.107.208.13; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXKTF1Qr9z2xpm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 05:49:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3MEJMez/e16vNKw0VftNNkpypI6QxjhdiRecofLZ/87AGvTp8yyB0vuglzBkppVkG7iDDAm0k7aATmfTHVX7EMksmfRlo+gVOPEm3TPbCXkELSnEFpKFrjQ3HzyGA9mMdABRx1n+J6ZtVk02ATi1iI+LbUffOGwb2MW+O7gRk8RxpDNMewOYD0WxC/GaPMBTqo46CCC54IPySVZi9ncviPZGu7XcWpIbUIsDAYX/I2LnTXmdo8zCt6/aAk3QTm0LGcQL/xBfxIhVwh3Y/HcHYvI4VL+6lJOkQfjlcN9b/gh4t5C8ABtariTH1ZGhVGOD7z5J1YCsT/dqaPZlWWoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V8w8Nx3TBWoQJY5f4eakxNQJHa/PmaoMxuWcr36T/Y=;
 b=cpoC/bh0BnlZx2vMSya5g+h1Hlgjlo/XWOG80ePFgXeIhG8r1P87NHI6tslvoR8BMuM79nc1/y/rlEJsxiAA5mfM5xHUsq1tnkG076OJgqrHBC3L7BgJGenZKhaqPxjcZE30amdAZrFacCgx4FIzd301Iq2XkCxZDmfDpr97s1SVmz+GM3eDlBXuwymh4Kb2zCiVDwlMybuBn82c15SsqarajMGYMHH6dCYP5ZJOdPlKJ+NalkcGXmRXTFjGVmhC68/QmCXzn4mNlEg34faQXjaeJopRU3Jcfm6pJLreGFUgT+Mvn+yViUEs6WrrjFM41AhIEHUrWCqMtP/Rh3GvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V8w8Nx3TBWoQJY5f4eakxNQJHa/PmaoMxuWcr36T/Y=;
 b=pXY7sZ/PvJFoy7Yhm62xEdsDkGF6rF2dgcfq+b6r0M51mvmAi2/xmXJgcn5szRtctMe0NwvU7/+PRnnV7gC5OJdCVOVM9ltt84D8CdsdEKUJNHtPS+tuy9Ic6KMdCvLutlvigF7wYzLRA8qezOQ2sb2zkz7Y5GqyWSAuOvQWcegKeI8lQLaEVZzgsiZ21LwGo5/C4xfLsMXUbjC8bsZfe7cf8oXf+7uj5a76Pl1eXh7OdFjt4XSqIRjJXgtBy94SzazytiGwD4Q4uCXJZx+VqsmV7a0seaWYPPtZzoVlmqHBcQcilmgEjtm+iiE7O/y6rwVnjBvmrUX3GFEJiHQIwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by CH3PR12MB9217.namprd12.prod.outlook.com
 (2603:10b6:610:195::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 18:48:37 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:48:37 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v2 0/2] arm: dts: aspeed: Add an alt 128M flash layout.
Date: Thu, 18 Dec 2025 10:48:10 -0800
Message-Id: <20251218-alt-128-v2-0-10499a0b7eb9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpMRGkC/02OwQrCMBBEf6Xk7EqytDT15H+Ih5hs7ULbaJIGp
 fTfDVJE5vRg5jGriBSYojhVqwiUObKfC+ChEnYw852AXWGBEhuFSoMZEyjUoDpspdNdrVsUpf0
 I1PPra7pcC/fBT5CGQOZ/r3770bz9kiArKJGyb1qHN1ub85zZsTlaP+3aQM+l/Eq7e9s+3wfb+
 LUAAAA=
X-Change-ID: 20251218-alt-128-19270d894872
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766083715; l=1405;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=aK4q/QRpkEE76OURWyH2ZsaocTXWFTo++EmHAId2TKw=;
 b=XNySoEkzWvw0zmNU9Ws74xKxfFF+rEXjAyAUw7rScZoEuR1kNdOPpYK3pmftfa8Yc7HefKgh4
 kgX8FsTYZ+rBx+bpweRwT/swm1sqhlU1B1nwcMgI0Ax6q5/GTuw0W+b
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: c1714166-1550-4a46-1917-08de3e660dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0Fxdi9VeHBGWDhEMi9MRkJodnMxSGpNc3pDRCtlVGIyZUZBcTdvMkdhWmZk?=
 =?utf-8?B?ZVN1TVBCeUVCMnZkTnBjUVNlcWlyN2QvdnY1MFQ4MHJKUnlHSHoySm9SZzM4?=
 =?utf-8?B?VFc2cm5WeXQ4WHlmNkhlQXRSVDdGRnFxcHZMR1R3Z2E1Vld6aVR4VzY4MGhG?=
 =?utf-8?B?VzZ4WUNvKytxY3Vrb1JVbUtkbU1FSEgvS3pwM2huaXJGVEZtQUNGc2VLb1Z1?=
 =?utf-8?B?YVZMVDROMXMzRWRqNTUrR29VMmJnanRuMHNVek01NzJQanpsUWJWVGxGYnZ0?=
 =?utf-8?B?c2o0dFQxOGhOcUZLQndicHR2V2NKTDFzMUtINEplR2t5TkV0a1M1N094bnIv?=
 =?utf-8?B?K1RXN0NsWjRKbTQ0VzRDMXMvY2JtTGhqM0R3eW9qQ3JuUG04R3hqTkJ4TXZV?=
 =?utf-8?B?QllaZm1iaUI5NEEyRG5Ueis2dGI4NGdXWmRFdUZnMjdxemxxMVFXNVI1a0t6?=
 =?utf-8?B?RW9UZHhGR1lNTzRrMU5XVDRGSWRURWowOUtuSkhNemh4SU5zSWJOdU1VK1Jz?=
 =?utf-8?B?VnRaclZVZGF5TTFqMWxWZkRxcXpHK1JYYmpNUUNNMk4wTW1uN1BBK1VaNmlC?=
 =?utf-8?B?eUg2YnBnZHM3NW0wcEEreG5ZQTE1K2JDMGs4QXo3SUVncFhLK0xDMVI3Tzhn?=
 =?utf-8?B?c0ZIMVlMSzg5UzBRM3pHeXZzbzJ5bFh3eEw0dmJyYlIwUEI5NlJ2Qm8xRm9E?=
 =?utf-8?B?SW9XS0FjYURoc3hGQlZIUmViSGhpQ3ZZSWNWbk9GaEYwbFRwbE5vUzV5emM3?=
 =?utf-8?B?cHZOQkR6ZGphSUJxQlE5UnplZUZjU0E4TVIvZ1R5WU40YVNoSENnSFdvUW5L?=
 =?utf-8?B?djlnZ2JGNkNKcFhETVdTS1hpL2YyZllxS3pnODF4cTVsaWxxd3JHaUY2R3Vr?=
 =?utf-8?B?b29NdEZaeHJRRGJBRVdlVjdjRmVuekRLMVpoM0FvUWltK1QvcnNmQUlJdkxQ?=
 =?utf-8?B?MnAyMk82emw0UHpBL0ZlWjc0TjM4VEdhNDg4Y1k3UlNIaWhlT2FPZXNpSHVj?=
 =?utf-8?B?dk9Oamx1ekdocm1VSXVKQXo2R2hvSTJFKzhDY2xxK2llUDU5cmlBSFE3S2FS?=
 =?utf-8?B?QTBCMWhHWG5Nc3FrOHRCa2NmeVhvN2M5VHFpVlYydHRBOE44RlFlK3hLZDVM?=
 =?utf-8?B?OGdzNlczUW1zZkRtQ0xBMjk1VWpSK3BBcFA4Z1p1NGVMS0UxMStHaEQxOHNW?=
 =?utf-8?B?S3pPZ0hETzJHeE9ZQmNmMFJsS05Ra0t6ZHAzS2JZSm54NExZbzhLRlJjOWNx?=
 =?utf-8?B?WFVpR051VjZvOVlrZjJPTzZ3Q0N6SG5DK3pYNFhBc2YvNmJndHZYYzNrWUN3?=
 =?utf-8?B?YS85QVpCeFJ2RHF6a2JXaW1jNkVMVXFTdy9mZUZrbFcwUXROTzkxRVh4VTAy?=
 =?utf-8?B?MzUyeVp1amlpV2ovMytiZGdjZ3FmbUhUSWRYclZmdUdYR2ZPVUtaU3ZRQlda?=
 =?utf-8?B?NUszb0Z6aUx0NGxtc2lpU08zci83eVNDTmRjS2cvaU85dnhTR091YkZzejhm?=
 =?utf-8?B?RGdCbTVTdmk5akVmUkZyUjdZYU1mdVJtN1RrOHRkN0xKYitsL2dSbDJpR3dq?=
 =?utf-8?B?M0F0NFJSV0NQaGdsZEVDN2ZuaWxHM2FORURaamRJYldaL1FVRVFLdmxWRGgx?=
 =?utf-8?B?ZFZjdUJmSTNtUWdyL1llbjE4U2ozUjI4ZTNvNVFyMTZhd0pQMWs0dXJXbjBG?=
 =?utf-8?B?NC91RjJzOHBGUnNNVGlKZVNSOWFHbkIvVDYrQkVSMXM0M20xT2tRTnZkYUp5?=
 =?utf-8?B?WVpUQzRoTnhpZWlsbmI1VlF4bFN5bEVXcWNVekFNY3ZGalZTcDhFR2hXWVFs?=
 =?utf-8?B?TVMzYjIzUVF6bkpWdVNMRGlXalpYNlBCRDNCVXp5cE5MY29COENHU2lrSXJx?=
 =?utf-8?B?dk9tNEJhbjBodG5oSUlNdTI0dHVrdTQrU1dVbXBlYk5qMTVRQ2ZrbHdtcitE?=
 =?utf-8?Q?9uocBBZHrCOtySpXj3bfRjZAQC9DjAhN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RuYzdpaXdNR1c1eSs0TnhhbXRiUUNPZEw5Zjk5cXdSaXpRdWc4b0w3Qm5y?=
 =?utf-8?B?Q2duaTJDdW13TEUwZkZHbGE3YVVRNGNwbGlNaEc2VnRFM1h1ekhPcVBHcHlx?=
 =?utf-8?B?UnRZRjhsTzFmdkkyV1VDMEJ4MkVRRGFvdGhtYVJqQlZ1Y0k0UDdCNSt6aG94?=
 =?utf-8?B?K3BXQzBqNFFMRHNZeXlQNVozWXhNUXJYTlgzSlQ2WTlkMnBKOGRLODJDV1JW?=
 =?utf-8?B?WnVINW1JZEl1clVheU4rcE1BbkdVTHQzSnY5d2tjRVBWcitoRjRIeTk1dms5?=
 =?utf-8?B?U2lWaXNEa045UHlYVTErdExrT1BqamhHSXpUNFdJMWxnOTBzbVhNYi9Scmoz?=
 =?utf-8?B?TEV4T2pFTmc3M2MrVThGY1A0YXFibnZVclA1NGZ1bEdPdlMrQjFPV3BSWERj?=
 =?utf-8?B?NDdPRzBWUDBXaWVtYVlaNERZUENXVTFEMWxaNjJGVmVSQXlBWUw4eU5JTXlh?=
 =?utf-8?B?Zzh1QnpwQjA0azZyeUhXeGhpNlhmQzRuQXo0aXJBSDN1T0x3WUxGUGRWRmlZ?=
 =?utf-8?B?ZG5KeGlEclIvaHNIQXdGN1NFMGtnV25MVkFvZ3JRM3UwbzBtMkJ4WmZQUXNt?=
 =?utf-8?B?SnVuaVFBbGc2L3dkQlBHbnJhbkVFeXNDSEE4anJEQWE5ajNiTm9mZVJmMHNx?=
 =?utf-8?B?TENJZU5tZWVSYXR3TlNncHRTNnJscFg1UHRJQjNXcmZGNW5lejh1ZkZZaklN?=
 =?utf-8?B?cHNuVmtEcGhXamhiRExsNmJyQXhtZG9US1BhQkFLdExwODdNSndDR2ZVdkRU?=
 =?utf-8?B?cVl2czB3c205MFVpWnNQWFNUWm5ydTF4L2ZvNDVIMWxObDlQc1VPUDZ1dUhX?=
 =?utf-8?B?ZVdUdU9KZllBRGtsYVlQaEUrT25mdUhRU0MvcU1Da2JlQUxJbDZ0WDBDZlln?=
 =?utf-8?B?TnJZWWVvOEFQREI1ODY2UmVSbk85cVlXYmlwUHRDM0VhbkVQSWg3VDRST1Ja?=
 =?utf-8?B?eUNZb1dNLzFKQS9ZSGNpc0o2RWc0c1dEc2dmTFp1aVdmUmF1UVE4Z285cGll?=
 =?utf-8?B?SGE1dytESDFHYWxYVzY5TFEyRjJCeUppYTlxMkVnWkltNkQ2RElwdHlNeDVv?=
 =?utf-8?B?ci9pSzhzclRtd1ZjcXBHaDl5eGFENDdzUCt2SHJJUnNZNUZlUUpzeExQa3Vt?=
 =?utf-8?B?eVpoZ0NpM0gvTG8zcEtMU1JIQ3FXQVZsWHE2Wit6NjUrdVJGRkwxTmg0Qk5x?=
 =?utf-8?B?Z0Qyc25YdTRPU2VDUFBjZlFxdi9iQkg5NlV6blUvM3BaRVB2Q21TbGhtSGVM?=
 =?utf-8?B?dDczWWRFUWhVRXhGNklpU2ZqUXZmRk4rM1lFTnhabkRRR1duQmg4b0lQNmV1?=
 =?utf-8?B?V2w2UWtHTVQ3SytGTC83aUhWdE43OE5Va3hSRnN3aXJ0NzZySUdlL2F5LzEw?=
 =?utf-8?B?dDdkYkVKNG1uUjFtbVB4MTR0SmxtbEZxc2xnbGpvUTRqcWNXc2ZvUFMxY0th?=
 =?utf-8?B?eU9HSDNSdk96RXNhQ2dqa28rN0VsVGh2cDVoTThJajhPRTdUeGhWNnV1OWE0?=
 =?utf-8?B?MEtRcHBaSEtocFpJZlJ3ODloOFRKT0pQNHlaa2p3L25LdmwrNFJvcmNiT1Ex?=
 =?utf-8?B?YlhqOTFPSWcycmVEeXdSTjFxSnZ1MElhYytUSEg5d1BwWmlpMlBGOElraE1K?=
 =?utf-8?B?RFltK3BiUXZzSmVTL0RFRERWdlc1UUdLK2dEYmFCaGd5SlJkMkp5ZjFXdEdG?=
 =?utf-8?B?VVBCWDZ1T3c5VXdmK2RndTJXREhUeUhTNXZYR2Fqclh5MEI0eHVrQ0hwRmJK?=
 =?utf-8?B?ME8rRVV3NjFZUHdDVUN2cXdkdmFMQXZLQ3IyQ2I3NlhBTG42NzkrTW5JR1RP?=
 =?utf-8?B?RUI4R1Y4VStSNkJKdmZUWXA5TThrUmRJS3k2em92SENTVk10bTVoWU9sM3g4?=
 =?utf-8?B?ckJHNzNPY3J3U1dTd2pIN0U4b3NPOFhzZE5WektmbG1qOUNEMXdIZ0xSR0lw?=
 =?utf-8?B?RmlCakJ5TW1iZzllVWw0cjViRFFUQ0hkTVpHWHYwaDhTdWxITkNKZXV3TUh6?=
 =?utf-8?B?Ui8zeHVjckhPZm1TM1FURXBWUzJQbHQ3WG5RWm1ZSWVUYVBCcmRQSHFPN01o?=
 =?utf-8?B?NDRtSnB6TndtdkQrOHVBTy93dCtuTUs3L3NNYTduWUg2NnpnUVdsMGdnakoz?=
 =?utf-8?Q?PlGMpbH8hA78NAIg9MYkqQvlL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1714166-1550-4a46-1917-08de3e660dc4
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:48:37.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVTyKBIG7lC457gtyDG0EPB7zMZ1GtBKijYooHUHYQrIg/s1D3vuAce5G5UkNZEpV1BbUZUXttP6mP4vorkhwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217

Add a layout for an alternate 128M flash layout. This is useful for the
aspeed ast2500[2] and ast2600[1] SoCs, where it has the ability to boot
from one of two spi chips, nominally the primary and backup SPIs. Adding
a layout allows userspace to flash the alternate spi by partition and
switch over to it, allowing lower downtime for firmware flash, or for
updating the primary flash from the golden backup flash. This is already
an established scheme for the 32M and 64M layouts, where the layout is
the same but each partition has `alt` prepended to its name. This allows
userspace to just prepend alt to the images in the update process to
specify which flash chip to update. This series also adds support for
the msx4 to use this layout.

References:

[1] https://www.aspeedtech.com/server_ast2600/
[2] https://www.aspeedtech.com/server_ast2500/

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Marc Olberding (2):
      arm: dts: aspeed: add an alt 128M flash layout
      arm: dts: aspeed: Add alt partition support to msx4

 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts |  1 +
 .../dts/aspeed/openbmc-flash-layout-128-alt.dtsi   | 32 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: 459a5aa171c0f13fcd78faa9594dc4aa5a95770b
change-id: 20251218-alt-128-19270d894872

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


