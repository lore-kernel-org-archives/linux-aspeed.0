Return-Path: <linux-aspeed+bounces-2133-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1DCA100C
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 10:03:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGyqq1f4Dz2yr4;
	Wed,  3 Sep 2025 20:03:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756893831;
	cv=pass; b=fgiIplEFtt9B+imKYsTYgmaeJ3DLnRkKDY5WoB1maY93LLPmpVmVP0+I6nccET60KYVyB/25x8pnp7lkaXhIyuC/Ylk2Z5lLo/MrXEJu3IUrRnXqXQD+i8CQOo9cxubTwRh+41PgYV+8cauBcFI+RuRrGRGoiYLRTUvzDqkyIy1Sh4fps/4O+xMGPeIdjX/RR2MXXGSi/WN7gO7/DB5mOkdnvajFVwccUcytZQg3WrIbNCIrhi1sPFa4VTa4y9dc/zd021a4TJDDul4aWnO+zuyIkGU2uPfzuiiD/592SCuKPNHkz94OjDrjIlK5lLsIuACYfjyNRbDePfFygtyJ2g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756893831; c=relaxed/relaxed;
	bh=71x9m5mapiP6MS21U8NiHuy+f2aletcS4MFe2BT72T8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkuUm774j7PoUzJifgK6QVS8IaxVu95Qi40KJv2rpgFQKERiGTh69A6hmLkX+xhkPvbHz44UbLe+RiWpGCErNuT7u3D+CVheKedcURXuZ2LYkS57RTv7ZRfqLTTxG4WQA5miXni5G01rurfJvJlu+SKnyWk2CQqj2ovXXn53tDRZbpjSIPtyomru74QNxXmK3GklBoNbMUGIQCtMCXOBH55AvozjMDXORAh65rsukJVIbeUO/9LlPt8KFY8xz6SL2WLe+axeZxyseTiEt4yZzbPZcJTw4T2N4E0TeC/jcRlNNHcHLvo3J1x5TOIhEofHbM0rHwR+ZfF26W2ySTe+sQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nby1tBEh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nby1tBEh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGyqn5fzQz2xrL
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 20:03:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utRXIG6089znTb0Nq9ms5jEyatcar0jSaYFJ6v1gZ6wnKM3PG3I65AufYAaRvWevPGtM6Ma8t2gYIP3CnSOnU+O+mQzsfPcAfKFhd4vvB6AkfuVoYVuO23VU4DTGPXS4WfdM+YHcLw9H3SlN4iYk9YzNV02fwoJBW4SfPapW5hspA6N4cOrodOuUkggNTRvbYNlTW86gLPb5sYWlsQxMt3pvXd9KA5utx4Xt7qdxK2qf0ddvge0VuXUImLo1ZVkZGtU9ukLNvDWF0s2MeXW/ExRYTkfTCWdkL3e8BRm+j1aXH2suV8rtAVl6ccV3mtw3rCz6KegAGneQMKGRso+D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71x9m5mapiP6MS21U8NiHuy+f2aletcS4MFe2BT72T8=;
 b=WHueFqhSRtmgi6+2eCdR2xnSmZ5F4gb2eGdtuRD1K5GbJxRqA/L9HNN9//AIxqvkzKKLHlNtNdXDnbLHMtw7a2pFrjHWgGWrXMsKbDdkf3/qtGPW52cQW7fktefaps7jxh/vMHjciypaSU8pqzBmRPYRcSAuSN4qTXkT2cGmj7JL5rRlKEvvGUvLwzZH477G98udlwwGVm5j4qoY7AogD81I5JCYj19MioszJXYWf+/jAtjQzk2vYUvh8PdtZEBCjFL35D4QTGJQjMl+72OIJzzvJkote2HDkHcIaY14epyD7np9kRJsPAVXE3u8aqM5XpOcjCZLdwxW5jigME1Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71x9m5mapiP6MS21U8NiHuy+f2aletcS4MFe2BT72T8=;
 b=nby1tBEhe1zobfaJvm9jPHuWIvdEq9zSi1krPW8leSWZzWfdmCTFO5BGBVahDXXGqPA9SOFYjsjGJSxSAL9kbLR9rX+OtJMSv4vgvO0OPfPByek3i9CRuaR7P2f5Du5QQmChUUy8nilvA08ylThEUlVIXyyeQi9tcPSRZROkMUxBfS3HSn68gIiHe5ivN0vtxctRO9Q5CKpbuqAWBug9dMp1ZvaVxVBEEj593QN1T241trlLkkY8Q5CCvu49FqoipUK7XwYvzW1ymS7065FJKKcWpUZlecigRktENuBq17K6cwwyafhYBydGH8em9TUb2eJqHWSIq+QESXul+AV39g==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:03:22 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 10:03:22 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/4] irqchip/aspeed-scu-ic: Refactor driver to support
 variant-based initialization
Thread-Topic: [PATCH v2 1/4] irqchip/aspeed-scu-ic: Refactor driver to support
 variant-based initialization
Thread-Index: AQHcGh0ElAQPEfmbl0aYVcVcd6TuzbR/3bEAgAFYypA=
Date: Wed, 3 Sep 2025 10:03:22 +0000
Message-ID:
 <OS8PR06MB75410181B488F905427AD1F7F201A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-2-ryan_chen@aspeedtech.com> <871pop2etv.ffs@tglx>
In-Reply-To: <871pop2etv.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SG2PR06MB5382:EE_
x-ms-office365-filtering-correlation-id: 9cf8a978-0f97-49a8-da11-08ddead11d95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sjWYSGd1RN9vYMOPOB7Ob8meVyGUJRS0lF3VWvedvyl7oQjEcQ0/8qNtksEo?=
 =?us-ascii?Q?/YOOj5ntG/4JiLZFB+VIiFspdds2v3aZ64mhELgAwG3Ss3OimivjudkJMZXt?=
 =?us-ascii?Q?sdpPRDYCt6UjFLssbIKG+jx0MjaWdOXgdA0KKGGga33nH9tJG5QTOtnsmrcX?=
 =?us-ascii?Q?HYvplIRFK8wnnfLG5bc+Pe521MdkgWTabwSm14L43x3FkR9o8n1BhHoVpjv2?=
 =?us-ascii?Q?K8IAJysPWRwi3d8z0Kk4vgsABwRZHatF0/v8rrzz/DxSjo9cH9P09OoYiuAj?=
 =?us-ascii?Q?AKyRiHRWGlJllIrAAC3SaGLnLtvfBc2EjZXcTawe1c5ijdGeM/b8RfctnDEm?=
 =?us-ascii?Q?mQqSotrgtQ5mLz7pmE2BvxfQ+pd0BCiA4qaklnQ2VTEOGtQGUnO7FWQT/Ihb?=
 =?us-ascii?Q?qpjjT5ncSoqRxf1J7P9mMyDb1CSH5n577Uk99eDF9Kilk7RHFDtuzngxuTxE?=
 =?us-ascii?Q?KTO1oaQ2DPiE7UAZX7hsQGqkXjd8HqV/etrKUQFavfSnzaGWSAoM/iSYes9y?=
 =?us-ascii?Q?eUoqyUAYYDo2sYZwkFtPwxiE6LTAYEMPvALaHR9PYMkh3BFN8JyqA8qmweh6?=
 =?us-ascii?Q?I3xvz1lsGmEoana4SEA9EwXKAHTbr/jlAk/7kJgNShQZ0+DifOiNIARq9pHL?=
 =?us-ascii?Q?XH3jm4EH4SCG4efw7NqNqtwwHUMf64/Yd3Gu3jzKfY6PWTgO0TCJTvntypgc?=
 =?us-ascii?Q?R/Vn2qEwFPiqcAvkgOZJP+M8M+Fnb7InU+uU0b0vbrNdOEnKMQqI4DEAWl66?=
 =?us-ascii?Q?uwxztYu+NspjOkW5xjJJIgBwQ7GZ3UZNpxYgJPCw9ovCYW7SX8rhpEU6V8mj?=
 =?us-ascii?Q?1QvIeosOsBP5KHudleD1gjNbT/0VoJAe5Bqe/22zl8pBzhpBSemf+erCEq8k?=
 =?us-ascii?Q?25ky74arm9XA/ewiV7MavRchBIrdjfezH7GxNEzhx8c0T7gfFwqVzVpDr4Ve?=
 =?us-ascii?Q?owzC+QhKR2qgl+uMJJjfliaxqPZX4DOzB4T+YazKm6KkTxSIoiJDlhPazlH+?=
 =?us-ascii?Q?UFSNN3vYagdYII+ybXVtz/x95tXTJ2Ni2eNuWyMMSCQT7XJ8yf+g82RU+P2b?=
 =?us-ascii?Q?ZqeSGgY3tSqp5hk6Mprm5Vd3LRyqKSuXdxH28/FpPDuDrs98JX3Fb0Zh1LdM?=
 =?us-ascii?Q?LOVr/hWc4WA95fWbFUw/yNIZLqcLostA6pf6WVLpxnIe5npoVXxalGDDc01s?=
 =?us-ascii?Q?aLYtSCGKPlkKM2i7dnh//1FGICtddQ1yXxVIKGBuRbSziBpu+Ix9/qxoDty3?=
 =?us-ascii?Q?Q6L2dfwjbFHjXPvfLc5PsZs62AfODepIOmOz6xgd8PcOcxJ6rrdRwRaODr6/?=
 =?us-ascii?Q?kBBt08OSSmjhfkTedT8sn93Zah8jGVJPgvdrb9mZ5v5mfq3q9uWnJueQ2VON?=
 =?us-ascii?Q?OaH+oh19vo5XP1rc47NYTt1orP5btZVGjJn5o/crhyimqziyBRvgMz2CSPpt?=
 =?us-ascii?Q?KVyQmtMkSs9wh8qf1pSh9UchvekTJSwRgzs6Ao6lQaRilYt93OqFrmFQtNa6?=
 =?us-ascii?Q?tFjSFfH1Vr516BArlR7dKz2kD29T46AQ6Iwk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OceKOBnwOyPHzGL8mEyAMg/sGYhuaPjAOTrKeeLHX96GxF2vuuvLA7eRrR0C?=
 =?us-ascii?Q?gFK1b2pr7j+Ve9jlN7sXaYRPPbTmqatHA4Bw4YpkoSSd20r0OLhuTUraJ3wv?=
 =?us-ascii?Q?ZVRWZhM8NBvS3oM7+y28NvUvA7r+ksyeEuFRpJc2yPCq42PqGf1d/KBYEyGU?=
 =?us-ascii?Q?u51MrUHxIe9D0/KCEkT8YQqmFLPcpab9oG1vxTHRZHdn0USZofHQkhz6KXpY?=
 =?us-ascii?Q?fQuFSirtefX7dhjmZOq0n0SVHLtp1PsJBupnNYhf9Q2G8vAHOX9I5eDXnCPB?=
 =?us-ascii?Q?ZdIy8PjcCvBIYSoDRJ7ih+zt2iGStL+aRzcGnIEAN2pwVPWO0rCFdf2icMrt?=
 =?us-ascii?Q?dqb/nytbqLRQHpfdMihiW+3CTTuI9Rj8+AoW92z+ZUu7jdM9fOZhPPCmSya8?=
 =?us-ascii?Q?K9QEYbWp1SVv8R9bmShnjFmOzJB7+3Us/mivj+DHw3xS1FpL41Jw7R8A3L0h?=
 =?us-ascii?Q?rtNJVJlAq+ylEMH7BFvt6yCYqrrTZ/qs0PGD0o/8CuUN2h/RnmnHNhy/uuKp?=
 =?us-ascii?Q?H/x+Pt+IwMPZ3zGRJYK2qsYXl7SneS5h044cOys9LMz7tKsDZXfzbe7N/Mp1?=
 =?us-ascii?Q?5GFkCAhvyVkTRxIqhHS1NXJIH5MuFmbbkKhA9qXkyDL2HvEqynoaVJgLxEX8?=
 =?us-ascii?Q?2d4pfXnfUIRNV+RWZ0n7U+QShFmbb286PxInCH5CwPE2RJJKH7OsCkVNvbUA?=
 =?us-ascii?Q?eWOvvMmNoFqg/HcFEVt7PkWwHFwpRoxqNyNgnyywqWfdbsVZyYY9S/Hc7xck?=
 =?us-ascii?Q?3FFqGEDmwwinERXj7Zrz4RsL/xja8Q9GFWtLukFWqnqB43UhcwI5jeoKpfI3?=
 =?us-ascii?Q?GMForSD9PTBfdtTZtD1G1PKEbq7/UGW5vsbNPCOqmbXwrvOTV4jaJOkB2ypc?=
 =?us-ascii?Q?S0x/yfqQBVTm23dp0BDF35ud9q1gWcKZ5Tq1SWH7z3E5IphHaLuZY2uCzvme?=
 =?us-ascii?Q?l7X0nXXD2JvEaP4tZBo78Lzrgw8O1KnIaLF5P0VLr27Qu38VN6oER6Vh8Q/c?=
 =?us-ascii?Q?mGaZTInyuW3YriJ++r1yE4ymtc5VihS8J6GyvXRLczhEHxeraKoq+wKPITK/?=
 =?us-ascii?Q?LntlN6YaoJHgffDSq8whLclfNoQhXliqHZEWdcimS1/ZpE40javBgt8Ws6kj?=
 =?us-ascii?Q?GmS069MbAcU9qKEKjr8MWGu/6apcxDIC13PFzoJdnCPnYDLhSZR+Z82bQnmz?=
 =?us-ascii?Q?Yr7Wfe/JqM8wre5D51kGB0t4l0ZzYu68i9lcZI0ni8hXChBA35XtbrxrKVF+?=
 =?us-ascii?Q?xUQrIZA2o4VM8OwMEvflbb8a4FpyEie9y7vVtXfoVGNnH7wVH0HsgRByoOXo?=
 =?us-ascii?Q?KtVlrFlqyQWRB+kxiK9/vUVDymdXV4bIJDtX2cCLHVqiqgj2Qq/vhzCx+hV6?=
 =?us-ascii?Q?0/YGGJUnFOAS4og+BB8aerphumhq5kLwf6IRYwbow0M7J4sx39lfOv4U9aOz?=
 =?us-ascii?Q?mUts8ucsZrSXVOiYAwb3avT7zlOU415VsXkJXdLHJatNqngfFsgb+vaDxFjf?=
 =?us-ascii?Q?UNIfV6utA8vx6JdmjWMdnZbIcCEBwJss2t6/IKNg7ENqrYwMznVgP3oTQcpw?=
 =?us-ascii?Q?18dR0VEiGO4Oq2rJMWeeF0hmjmMN/SEmJ+XWZwJr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf8a978-0f97-49a8-da11-08ddead11d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 10:03:22.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bKtw7tRmQqMCisYTUoo86m6mlT1tGxR3qimBKXEieLXlK9Wb83Pc3RsdCPsABUoVhWogpfvIUERnIEpzWSiM95iZgKOOAXRQ1i7S+8MouU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5382

Thaks the review.

> Subject: Re: [PATCH v2 1/4] irqchip/aspeed-scu-ic: Refactor driver to sup=
port
> variant-based initialization
>=20
> On Sun, Aug 31 2025 at 10:14, Ryan Chen wrote:
> >  	scu_ic->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(node=
),
> scu_ic->num_irqs,
> > -						   &aspeed_scu_ic_domain_ops,
> > -						   scu_ic);
> > +						      &aspeed_scu_ic_domain_ops,
> > +						      scu_ic);
>=20
> Please move scu_ic to the previous line.

Will update in next version.
        scu_ic->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(no=
de), scu_ic->num_irqs,
                                                      &aspeed_scu_ic_domain=
_ops, scu_ic);
>=20
> > +aspeed_scu_ic_find_variant(struct device_node *np)
> >  {
> > -	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL)=
;
> > -
> > -	if (!scu_ic)
> > -		return -ENOMEM;
> > +	for (int i =3D 0; i < ARRAY_SIZE(scu_ic_variants); i++)
> > +		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
> > +			return &scu_ic_variants[i];
>=20
> the for loop wants curly brackets.
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracke=
t-
> rules

Thanks.
Will update

for (int i =3D 0; i < ARRAY_SIZE(scu_ic_variants); i++) {
	if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
		return &scu_ic_variants[i];
}
>=20
> > +	scu_ic->irq_enable    =3D variant->irq_enable;
> > +	scu_ic->irq_shift     =3D variant->irq_shift;
> > +	scu_ic->num_irqs      =3D variant->num_irqs;
>=20
> Please use a TAB not spaces when you want to align things.
Thanks, will update
>=20
> > +IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
> aspeed_scu_ic_of_init);
> > +IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
> aspeed_scu_ic_of_init);
>=20
> Stray TAB in the last line.
Will remove tab
>=20
> Thanks,
>=20
>         tglx

