Return-Path: <linux-aspeed+bounces-4961-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79268C79F9E
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Sep 2026 23:32:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdRMD69b1z2yvh;
	Mon, 07 Sep 2026 09:32:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4440:2::717" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788605161;
	cv=pass; b=LHhD2jKPEq6RtQCY1uQhVqOnzRUfiYVJhyilQShrJs/I8LP/MIIBEf1bQSfOKJvJh+yH8p9V19X9x1CyO9EBPH9Hj6sOUxX/aI/ZsmRbZzlthuKQioPGU07P0Rhsgc3HAkSmaKEMFw+SvBQkGo+KJwAq/efyViRWp1/uQfpDfw7Joj75F1DWkLYTfh9SyD/F3js+PAItp8ml59HuNWNQXEvjReUi+dQ6VDsik4NynE5SUrntHlMA1OTqKDH+zwhGt1FUePwtR89ZiGBxokMU2q4QdRjaUYGMn8Kx7jCo3N4tgE6Mt+vfPwL1Tg0SmVsFT9pqITtjY08pZgiK93rW3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788605161; c=relaxed/relaxed;
	bh=9A0vpzxSOocxNsRBupRn+sLupJcN3VbGYFOYjlXYm+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKxmw+zIkNnBOUAh2kcYlIzN9HH+JUgAmTRP+jDriWSzJu+bR+LjSD29Otc3fuk49/MozsG40MgJq2mWmY84BbYjYR+hWN5y4vEH/x/BMaBxcM0y0JmgFvbX9Gf15Z9XXfbt7YSNeumY+p3AZ7dbJZBpt4BD1f+P6LqcWijbmyPd2Fqk+UKvS4MKG1c07+2wFriPviJbhI2/b6sUhqWU7UTfgI7DvUwvP381fSCTGhhly6QruNWimiVazFDqiuc1gn7Mz8H7Vb4sDghPPl2C2KzmUmFV4IGFnu+pEZJFg3Onva3YP6EBMlGGAVliHz7y6DX8cVGztAo3LMShftokqQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4440:2::717; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4440:2::717; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on20717.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4440:2::717])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcVP41lGMz2ygK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Sep 2026 20:45:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+/KhoS4GlJQT8oySQ4Ls+VgsgaMxLdOH3bH9ssqewxO6pmRRX9JDPqQVKRPsu/Ipz4y+ZVDLoaPPZT2tEGKrFK0htJHosS/5ILalMF0spXQRhzeg7szUeOE29WFlFvokiLL3iBRVzylyQINakBUCv6GWnsmfhVRFQQKqjsDTuDoqFGDdDY8PT/uMusBkyvoUlnqVlR8QskIiWKm8lo0Zs5zJqQOBVvblo19byD6hopNJLJJSgRIr46DP+IitZghNhGSqONmdJZvqthP1PLYDSMftLFVRT0deAe7km29I8NQtofdtr8JQg5+pMvhj4hpL2OJy3V+jW2dNVtZOvdFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A0vpzxSOocxNsRBupRn+sLupJcN3VbGYFOYjlXYm+E=;
 b=Vg99zfwGYxEKjtU/VS66mfYVSQcNcjkwgnPRcUNuFk7+QlpauiQB31U+RjD2uu/IxNN0vDX7Ka6E5rtbHTwojy3FxyXK64CNyCIYGjzOXzeWCJV8rfCVLNIvjXj7MZF19ATNm+l92J4qGqqUSKAO1Lr/NAQxZtsPFVP1ZqQPxk0abWllHyw3qLlT1IbAR3BVwkwhqtl2c4ZZOYrFkkIZnD/wHhjEGTSRuIIfRTeGLylXdsM1Kqr8vpOiAPFQNpcqHfdY3Gnj6eBzWP9SrtQBXkG9s+EQAaYSGH7Wt53AkqWYqiqFC3AGI9ngfwabRB0+EbhSWawhuC/7JaAYAk6JhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1329.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 5 Sep
 2026 10:29:18 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0315.011; Sat, 5 Sep 2026 10:29:18 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Oskar Senft <osk@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Vitaly Lubart <lubvital@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Breno Leitao <leitao@debian.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	James Morse <james.morse@arm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Julian Braha <julianbraha@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/4] uart-routing: Add common UART routing framework
Date: Sat,  5 Sep 2026 03:28:58 -0700
Message-Id: <20260905102901.126035-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1329:EE_
X-MS-Office365-Filtering-Correlation-Id: 901757ce-c4c7-4bce-c0fc-08df0b388a71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|23010399003|38350700014|10067099003|6133799003|56012099006|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	zNygDcAZXdEfk9NtuVS7ZZOj7SdS1absdMxqmc08BwSCBjWbAPrkWGQ/rF3z8ZnI1eqwtSAdkpbqTWA/+zLsPeo2KN3zQJpHZyS2AEKltLQdV8QUpeq51EFCEqOkajXMdlAPJtDOjNbLtJG6k3z+Lc1PngXEFap9+2O4kd69yrUFVdFg6RXwtK3cQjsnLb/puUB0kvtFAccaWKoYBwfXZhEeOssmgHVufm/1uO/Hd4QYTJ8M9l4cYgV9niBwIgbN5nnDbOIxri+VvPbz/VlAWNeLbB9CM0WaezoAWWt0h327urxJaVvPlNxpuV6cDWrbseK/ELEBhpilJHnOYBshnGM4764ZjgwilOj2ctvp9iuzIXiqd2FGvYE6wgiQILylzSO5dDJCh6BAT6A74KtR4BkyjWM8iWTxAXzP+t1sEenAqsZb1HOFrg8Ml0jp9UgU8AMp2aqQquoE3rhQDvvUHXRY9b9fRMd3lvSdTUID21Ym6VpZ4KB9tAKRT2P5kfnQEZc2OS5iD+gWrUmJA2jLuUkYpiRfeSfx4l5PuFkIVS9pls3Kyi6KpVnrXX53+y4N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(23010399003)(38350700014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nppYDMLwhDDmjFsQI9+EQhiFHV5xwVFvLE/1j9M7Q1gSgvEYM5Bz7cno6tp?=
 =?us-ascii?Q?Sx4GKbobACSs4tEHG8NxbtKpSsmvmUf8c//9uFoJVv+j+3GcYsI6drlCbjRN?=
 =?us-ascii?Q?ZURDp17DFo/U17XC/kRgKwFQ8g1+TX0a910E7u0YBwqSpfuhSXzU0N8/gzwi?=
 =?us-ascii?Q?PLP3167h7+CuEF/CK9J7ot6ErpQqCit5h/GumswvfDJveANxii/w9WaEJdce?=
 =?us-ascii?Q?wLjzZ0hgCkUAINYznmy+SNHp2Fmf7OTMEXubHycD5omLuoUOE37iWZvWhClf?=
 =?us-ascii?Q?hW+iPljvRwYHqx4kg4hD0Ql4gsK2Nt5eNUorUp5OLdbkIk6I+O6GpqU+3Ync?=
 =?us-ascii?Q?TcQGyj7LKUiUuMwrlaBlK+mRL8pR4l0j9RIMkngWBNt5A9kVhFuXswSpUsKU?=
 =?us-ascii?Q?fvG1RNJTLl+wSMnTkuFDmUgD7G3Tqjn4Losnxbh3eHYFGShJv4JXZ9u513fu?=
 =?us-ascii?Q?AMHWXSGoOad/m1i3Lcpg6Lt2/RWGnvhSniyx2PaBn3fwG3BkLTl/UF1c3DV2?=
 =?us-ascii?Q?C7Q6B1yGKwtvs00RMY4NufT4u6MvYREki18QxAyLPCyFX0Y3XDqll81DjZnY?=
 =?us-ascii?Q?LRqy5AWBd+3hPArSZkz0u8JFsRKq6/KW3YLxXZmg9hZj6ObTjKruqhGGQqOM?=
 =?us-ascii?Q?5q9x1y/l2RtBogRaM4bRtLYYICpd87gA92XG1gnkI5wSxhVDgVHhCb9dipm2?=
 =?us-ascii?Q?lmx12s8jfI7na1x7OPSF2BpVsUrsKx2cMieUHf76knMI8b5vQ8Ni1mWsjeQh?=
 =?us-ascii?Q?cvZgDtyob6FzW0tO7CtyiLZ5wCrwVp8pbKxLNn4kGAeAjNuzAvQDg0TS2zDJ?=
 =?us-ascii?Q?XdqdX2cj74u41ScBS/junmXa6a/z4wRHrx4JM0U4MO32uoG9Vb4hQalpX7Yy?=
 =?us-ascii?Q?UmF/yP4E9nEVSGmsCR5+IIxUm6gWZtUO3yv91lYMvh9pFvDyueljlhJ03Suz?=
 =?us-ascii?Q?BpgXpqIrLqmWHgtm1XeUodAryn+iAWSgZzhf/mkUJ9rNozNL//27mlD3Xzmg?=
 =?us-ascii?Q?XXhBxoWfA3YjOMW0FCOUtEmlfJL/YQdlnbbqtenB0aqls5+7eqUBFZgs2rFd?=
 =?us-ascii?Q?81rTbZiu8a6lV8+8I7ZKlSu3pGsjQsTSZhrQHQeKdk8L4bu/2mDu5TJ5BP5X?=
 =?us-ascii?Q?z2dS298PpjhHiVtRuoRUqfIKzdz8azfCNMArlBk67IfSQw0LAomUlohS5tCM?=
 =?us-ascii?Q?+Hg8y7DM5BFoL8qYtWx3nGcPaz2lBQ1CF7lJ3+dbsVOTIV0usmVP9zY7z4u9?=
 =?us-ascii?Q?7NJ93vn+DYGmOeQRm1UMofDMaXn76ftWPxgq+CrGrY5mV5bH6biV2ODaY+ml?=
 =?us-ascii?Q?3/HacJtg+e/2QnKZFqEtOqwHpRxUw92tEQEjJvW75rxgWQB4YQ+BJUysAVLN?=
 =?us-ascii?Q?3gLEEqyiq+ULCJSjnOHKqSxpHgffYKa8dlx3wUCuZOHw1dBn53KWvOoYFoDK?=
 =?us-ascii?Q?3qryAwylNbgWm/iFDmEH/O0MJc3QEie/nn6mwIDTtS5IahqmYplaH2+K57EX?=
 =?us-ascii?Q?H6PHWOMVXX3+5Iru3j20VJM5zbt2Q2GByZQoMUhcJzWb4iIouLRkf4U9SQdz?=
 =?us-ascii?Q?BQW7qi/ujYvxtAwuP6jozLainBDWIKmMvGDi7jUE1ZxbJ2nXmCd0Jl/IGK/9?=
 =?us-ascii?Q?b+fkhIKzEDUsP1cnM0RmrfPvIf8oAVuStaeLBAlvOvHczXabbLi1/MWGc2Xj?=
 =?us-ascii?Q?QbOukWm2By7iC5aQIxjRBDilDnt4mO5/9fFcL2UYK90Ic+tJ3GXfgLPr9qyC?=
 =?us-ascii?Q?K3HYg3q3oLndqJx0SAr4StVBrqBXVOUpji3JWhFEBOgIx+Xl8txN?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901757ce-c4c7-4bce-c0fc-08df0b388a71
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:29:17.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6BKU8Hopq6iMSj+yvi6ZmCCQ74cpe0ZRotuqY5j8u5aYcxpCLRMPva3HQ0Y00+4g2LRn6iDg9C6/HRq0XuMQVVs/rRshGK8rByDtbRR6FBETE6sElEkxBHDScW5YJtM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1329

Several SoCs contain a serial crossbar, usually called UART routing,
that lets the RX line of any on-chip UART controller or physical serial
port be fed from any other endpoint. The Aspeed AST2400/2500/2600 and
the StarFive JHB100 both have one, and both expose it through the same
user space interface: one sysfs file per endpoint, listing the routing
targets with the current one in square brackets.

The two drivers implementing that interface duplicate the whole sysfs
plumbing and only really differ in the description of their register
layout, so factor the common part out into a framework.

An SoC driver now only describes each mux with a
struct uart_routing_selector - register offset, bit position, field mask
and the array of routing target names indexed by the raw field value -
gathers them in an attribute group and hands the group and a regmap to
devm_uart_routing_register(). The framework validates the description,
creates the files and implements the show()/store() handlers.

The framework keeps its state in a devres node rather than in the device
drvdata, so drivers stay free to use dev_set_drvdata() for their own
purposes, and the sysfs files are removed by devres, so drivers do not
need a remove() callback for them.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/uart-routing.rst | 145 ++++++++++++++++
 MAINTAINERS                               |   7 +
 drivers/Kconfig                           |   2 +
 drivers/Makefile                          |   1 +
 drivers/uart-routing/Kconfig              |  16 ++
 drivers/uart-routing/Makefile             |   2 +
 drivers/uart-routing/uart-routing.c       | 200 ++++++++++++++++++++++
 drivers/uart-routing/uart-routing.h       |  84 +++++++++
 9 files changed, 458 insertions(+)
 create mode 100644 Documentation/driver-api/uart-routing.rst
 create mode 100644 drivers/uart-routing/Kconfig
 create mode 100644 drivers/uart-routing/Makefile
 create mode 100644 drivers/uart-routing/uart-routing.c
 create mode 100644 drivers/uart-routing/uart-routing.h

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6601a258690f..2a0f375cd206 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -146,6 +146,7 @@ Subsystem-specific APIs
    tee
    thermal/index
    tty/index
+   uart-routing
    wbrf
    wmi
    xilinx/index
diff --git a/Documentation/driver-api/uart-routing.rst b/Documentation/driver-api/uart-routing.rst
new file mode 100644
index 000000000000..67bb84958977
--- /dev/null
+++ b/Documentation/driver-api/uart-routing.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+UART routing framework
+======================
+
+:Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+
+Overview
+========
+
+Several SoCs contain a serial crossbar, usually called *UART routing*, that
+sits between the on-chip UART controllers and the physical serial ports
+exposed on the package pins. The crossbar lets the RX line of any endpoint be
+fed from any other endpoint, which makes it possible to, for example, snoop
+the traffic of a host serial console, or to loop two on-chip UARTs back into
+each other without any external wiring.
+
+Two endpoint families are involved:
+
+``uartN``
+	the RX line of the on-chip UART controller number N.
+
+``ioN``
+	the RX line of the physical serial port number N.
+
+The crossbar is programmed through bit fields, one per endpoint, spread over
+one or more registers. The value written into a field picks the endpoint the
+RX line is connected to; the meaning of a given value differs from field to
+field and from SoC to SoC.
+
+The framework in ``drivers/uart-routing/`` takes a static description of those
+fields and turns it into a set of sysfs files, one per endpoint, so that SoC
+drivers only have to describe their hardware.
+
+User space interface
+====================
+
+Every endpoint gets one read/write file in the device directory of the
+platform driver, named after the endpoint. Reading the file lists all the
+routing targets the endpoint can be connected to, with the current one
+enclosed in square brackets::
+
+	# cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+	[io1] io2 io3 io4 uart2 uart3 uart4 io6
+
+Writing one of the listed names to the file changes the routing::
+
+	# echo uart2 > /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+
+Writing a name that is not part of the list fails with ``-EINVAL``.
+
+The list is not necessarily the same for every file: it is ordered by the raw
+value programmed into the hardware, so the first entry is the target selected
+when the field reads back as 0. Some SoCs define fields that are wider than
+the number of documented targets. When such a field holds a value with no
+name attached, the read appends ``[unknown(N)]`` to the list instead of
+bracketing one of the names.
+
+Fields whose name is ``reserved`` are placeholders for values the hardware
+does not implement. They are listed so that the position of the following
+names stays correct, and writing ``reserved`` programs a value that has no
+defined behaviour, so do not do that.
+
+The exact set of files of a given SoC, together with the routing targets each
+of them accepts, is described in the corresponding
+``Documentation/ABI/testing/sysfs-driver-*-uart-routing`` file.
+
+Writing a driver
+================
+
+An SoC driver describes each mux with a ``struct uart_routing_selector``,
+defined with the ``UART_ROUTING_SELECTOR()`` helper::
+
+	static const char *const foo_uart1_options[] = {
+		"io1", "io2", "io3", "io4", "uart2", "uart3", NULL,
+	};
+	UART_ROUTING_SELECTOR(foo_uart1_sel, uart1, FOO_MUX_REG, 16, 0x7,
+			      foo_uart1_options);
+
+The arguments are, in order, the name of the variable to define, the name of
+the sysfs file, the offset of the register holding the field, the position of
+the least significant bit of the field, the field mask and the array of
+routing targets.
+
+The mask is given in field coordinates, that is, it is *not* shifted by the
+bit position: a three bit field is always described as ``0x7``, whatever its
+position in the register is.
+
+The array of routing targets is indexed by the raw field value, so
+``options[n]`` is the name of the target selected when the field holds n. It
+has to be NULL terminated, and it may be shared between several selectors
+that happen to have the same target order.
+
+The selectors are then gathered in an attribute group::
+
+	static struct attribute *foo_uart_routing_attrs[] = {
+		UART_ROUTING_SELECTOR_ATTR(foo_uart1_sel),
+		/* ... */
+		NULL,
+	};
+
+	static const struct attribute_group foo_uart_routing_attr_group = {
+		.attrs = foo_uart_routing_attrs,
+	};
+
+and handed over, along with a regmap covering the selector registers, in
+probe()::
+
+	static int foo_uart_routing_probe(struct platform_device *pdev)
+	{
+		struct device *dev = &pdev->dev;
+		struct regmap *regmap;
+
+		regmap = /* ... */;
+
+		return devm_uart_routing_register(dev, regmap,
+						  &foo_uart_routing_attr_group);
+	}
+
+The framework validates the description at registration time and rejects
+selectors whose target list cannot fit in the field, or whose field does not
+fit in a 32 bit register.
+
+The sysfs files are created and removed by devres, so a driver does not need
+a remove() callback for them. The framework keeps its own state in a devres
+node rather than in the device drvdata, so drivers are free to use
+``dev_set_drvdata()`` for their own purposes.
+
+Locking
+=======
+
+The framework does not serialise accesses itself. The read-modify-write of a
+selector field is done with ``regmap_update_bits()``, so concurrent writes to
+two endpoints sharing a register are made safe by the regmap lock. Reading a
+file always reports the current hardware state, which may have been changed
+by another writer in between.
+
+API reference
+=============
+
+.. kernel-doc:: drivers/uart-routing/uart-routing.h
+
+.. kernel-doc:: drivers/uart-routing/uart-routing.c
+   :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 90919c672d4d..b7fa722755c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27818,6 +27818,13 @@ F:	drivers/misc/uacce/
 F:	include/linux/uacce.h
 F:	include/uapi/misc/uacce/
 
+UART ROUTING FRAMEWORK
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/driver-api/uart-routing.rst
+F:	drivers/uart-routing/
+
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
 R:	Zhihao Cheng <chengzhihao1@huawei.com>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index f2bed2ddeb66..cb2b5c3b22b0 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -251,6 +251,8 @@ source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
 
+source "drivers/uart-routing/Kconfig"
+
 source "drivers/resctrl/Kconfig"
 
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 0841ea851847..fe4b11419496 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,6 +195,7 @@ obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 obj-y				+= resctrl/
+obj-$(CONFIG_UART_ROUTING)	+= uart-routing/
 
 obj-$(CONFIG_DIBS)		+= dibs/
 obj-$(CONFIG_S390)		+= s390/
diff --git a/drivers/uart-routing/Kconfig b/drivers/uart-routing/Kconfig
new file mode 100644
index 000000000000..a0c45a7bba47
--- /dev/null
+++ b/drivers/uart-routing/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "UART routing drivers"
+
+config UART_ROUTING
+	tristate
+	help
+	  Common framework for the UART routing controllers found on several
+	  SoCs. It turns a description of the routing selectors of a crossbar
+	  into a set of sysfs files, one per endpoint, that report and change
+	  the current routing at runtime.
+
+	  This symbol is selected by the SoC specific drivers below and is
+	  not meant to be enabled on its own.
+
+endmenu
diff --git a/drivers/uart-routing/Makefile b/drivers/uart-routing/Makefile
new file mode 100644
index 000000000000..975165f070a5
--- /dev/null
+++ b/drivers/uart-routing/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_UART_ROUTING)			+= uart-routing.o
diff --git a/drivers/uart-routing/uart-routing.c b/drivers/uart-routing/uart-routing.c
new file mode 100644
index 000000000000..70037a256e5f
--- /dev/null
+++ b/drivers/uart-routing/uart-routing.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common framework for UART routing controllers
+ *
+ * A UART routing controller is a crossbar that connects the RX line of each
+ * on-chip UART controller and of each physical serial port to any of the
+ * other endpoints. The mux of every endpoint is described by a bit field in
+ * a memory mapped register, and is exposed to user space as one sysfs file
+ * per endpoint.
+ *
+ * Copyright (C) 2026 StarFive Technology Co., Ltd
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+#include "uart-routing.h"
+
+/**
+ * struct uart_routing - per device state of a routing controller
+ * @regmap: regmap holding the selector registers
+ */
+struct uart_routing {
+	struct regmap *regmap;
+};
+
+static void uart_routing_devres_release(struct device *dev, void *res)
+{
+	/*
+	 * Nothing has to be undone here: the selector description belongs to
+	 * the SoC driver and the regmap has a lifetime of its own. The
+	 * release callback only exists so that the sysfs handlers can find
+	 * the state again with devres_find(), which leaves the device
+	 * drvdata free for the SoC driver to use as it sees fit.
+	 */
+}
+
+static struct uart_routing *uart_routing_from_dev(struct device *dev)
+{
+	return devres_find(dev, uart_routing_devres_release, NULL, NULL);
+}
+
+ssize_t uart_routing_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	const struct uart_routing_selector *sel = to_uart_routing_selector(attr);
+	struct uart_routing *routing = uart_routing_from_dev(dev);
+	unsigned int val, pos;
+	int len, ret;
+
+	ret = regmap_read(routing->regmap, sel->reg, &val);
+	if (ret)
+		return ret;
+
+	val = (val >> sel->shift) & sel->mask;
+
+	len = 0;
+	for (pos = 0; sel->options[pos]; pos++) {
+		if (pos == val)
+			len += sysfs_emit_at(buf, len, "[%s] ", sel->options[pos]);
+		else
+			len += sysfs_emit_at(buf, len, "%s ", sel->options[pos]);
+	}
+
+	/*
+	 * The field is wider than the number of documented targets on some
+	 * SoCs, so a value with no name attached can legitimately be read
+	 * back from hardware left in an unexpected state.
+	 */
+	if (val >= pos)
+		len += sysfs_emit_at(buf, len, "[unknown(%u)]", val);
+
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(uart_routing_show);
+
+ssize_t uart_routing_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	const struct uart_routing_selector *sel = to_uart_routing_selector(attr);
+	struct uart_routing *routing = uart_routing_from_dev(dev);
+	int val, ret;
+
+	val = __sysfs_match_string(sel->options, -1, buf);
+	if (val < 0) {
+		dev_err(dev, "invalid value \"%s\"\n", buf);
+		return val;
+	}
+
+	ret = regmap_update_bits(routing->regmap, sel->reg,
+				 sel->mask << sel->shift,
+				 (u32)val << sel->shift);
+	if (ret)
+		return ret;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(uart_routing_store);
+
+static int uart_routing_check_group(struct device *dev,
+				    const struct attribute_group *group)
+{
+	unsigned int i, nr_options;
+
+	if (!group->attrs)
+		return dev_err_probe(dev, -EINVAL, "empty routing group\n");
+
+	for (i = 0; group->attrs[i]; i++) {
+		struct attribute *attr = group->attrs[i];
+		const struct uart_routing_selector *sel;
+		struct device_attribute *dev_attr;
+
+		dev_attr = container_of(attr, struct device_attribute, attr);
+		if (dev_attr->show != uart_routing_show ||
+		    dev_attr->store != uart_routing_store)
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: not a routing selector\n",
+					     attr->name);
+
+		sel = to_uart_routing_selector(dev_attr);
+
+		if (!sel->mask || !is_power_of_2((u64)sel->mask + 1) ||
+		    sel->shift + fls(sel->mask) > BITS_PER_TYPE(u32))
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: bad field mask %#x shift %u\n",
+					     attr->name, sel->mask, sel->shift);
+
+		if (!sel->options)
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: no routing options\n",
+					     attr->name);
+
+		for (nr_options = 0; sel->options[nr_options]; nr_options++)
+			;
+
+		if (!nr_options || nr_options > sel->mask + 1)
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: %u options do not fit field mask %#x\n",
+					     attr->name, nr_options, sel->mask);
+	}
+
+	return 0;
+}
+
+/**
+ * devm_uart_routing_register() - expose a routing controller to user space
+ * @dev: device owning the routing controller
+ * @regmap: regmap the selector registers are read from and written to
+ * @group: attribute group listing the selectors of this controller. Every
+ *         attribute in the group has to be the &device_attribute of a
+ *         &struct uart_routing_selector.
+ *
+ * The sysfs files are removed automatically when @dev is unbound, so drivers
+ * calling this do not need a remove() callback of their own.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
+int devm_uart_routing_register(struct device *dev, struct regmap *regmap,
+			       const struct attribute_group *group)
+{
+	struct uart_routing *routing;
+	int ret;
+
+	if (!regmap || !group)
+		return -EINVAL;
+
+	ret = uart_routing_check_group(dev, group);
+	if (ret)
+		return ret;
+
+	routing = devres_alloc(uart_routing_devres_release, sizeof(*routing),
+			       GFP_KERNEL);
+	if (!routing)
+		return -ENOMEM;
+
+	routing->regmap = regmap;
+
+	/* The state has to be reachable before the first file shows up. */
+	devres_add(dev, routing);
+
+	ret = devm_device_add_group(dev, group);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to create routing attributes\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_uart_routing_register);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("Common UART routing framework");
+MODULE_LICENSE("GPL");
diff --git a/drivers/uart-routing/uart-routing.h b/drivers/uart-routing/uart-routing.h
new file mode 100644
index 000000000000..7302be34fa13
--- /dev/null
+++ b/drivers/uart-routing/uart-routing.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common framework for SoC UART routing controllers
+ *
+ * Copyright (C) 2026 StarFive Technology Co., Ltd
+ */
+
+#ifndef __UART_ROUTING_H__
+#define __UART_ROUTING_H__
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+struct regmap;
+
+/**
+ * struct uart_routing_selector - a single routing mux exposed to user space
+ * @dev_attr: sysfs attribute backing this selector. It has to be initialised
+ *            with UART_ROUTING_ATTR() so that the framework handlers are used.
+ * @reg: offset of the register holding the selector field
+ * @shift: bit position of the least significant bit of the selector field
+ * @mask: selector field mask, expressed in field coordinates, i.e. not
+ *        shifted by @shift. A three bit field is described as 0x7 whatever
+ *        @shift is.
+ * @options: NULL terminated array of routing target names. The array index is
+ *           the raw value programmed into the selector field, i.e. writing
+ *           @options[n] to the sysfs file programs the field with n.
+ *
+ * SoC drivers describe their crossbar as an array of these, one per sysfs
+ * file, and hand the resulting attribute group to
+ * devm_uart_routing_register().
+ */
+struct uart_routing_selector {
+	struct device_attribute dev_attr;
+	u32 reg;
+	u8 shift;
+	u32 mask;
+	const char *const *options;
+};
+
+#define to_uart_routing_selector(_dev_attr) \
+	container_of(_dev_attr, struct uart_routing_selector, dev_attr)
+
+ssize_t uart_routing_show(struct device *dev, struct device_attribute *attr,
+			  char *buf);
+ssize_t uart_routing_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count);
+
+/**
+ * UART_ROUTING_ATTR() - initialise the attribute of a routing selector
+ * @_name: name of the sysfs file, given as a bare token
+ */
+#define UART_ROUTING_ATTR(_name) \
+	__ATTR(_name, 0644, uart_routing_show, uart_routing_store)
+
+/**
+ * UART_ROUTING_SELECTOR() - define a routing selector
+ * @_var: name of the variable to define
+ * @_name: name of the sysfs file, given as a bare token
+ * @_reg: see struct uart_routing_selector.reg
+ * @_shift: see struct uart_routing_selector.shift
+ * @_mask: see struct uart_routing_selector.mask
+ * @_options: see struct uart_routing_selector.options
+ */
+#define UART_ROUTING_SELECTOR(_var, _name, _reg, _shift, _mask, _options) \
+	static struct uart_routing_selector _var = {			 \
+		.dev_attr	= UART_ROUTING_ATTR(_name),		 \
+		.reg		= (_reg),				 \
+		.shift		= (_shift),				 \
+		.mask		= (_mask),				 \
+		.options	= (_options),				 \
+	}
+
+/**
+ * UART_ROUTING_SELECTOR_ATTR() - reference a selector from an attribute array
+ * @_var: variable previously defined with UART_ROUTING_SELECTOR()
+ */
+#define UART_ROUTING_SELECTOR_ATTR(_var)	(&(_var).dev_attr.attr)
+
+int devm_uart_routing_register(struct device *dev, struct regmap *regmap,
+			       const struct attribute_group *group);
+
+#endif /* __UART_ROUTING_H__ */
-- 
2.25.1


