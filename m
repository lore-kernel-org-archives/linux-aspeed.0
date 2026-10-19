Return-Path: <linux-aspeed+bounces-5223-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E80FCCF2DA
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 10:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WSR0Rtxz2ygD;
	Mon, 19 Oct 2026 21:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404454;
	cv=pass; b=mqrVmWi43IXmXME5+uSuLnrbESyyP1B8Sc72pjQxHtDMtP3f+/WL09nHc0GnSOfmmOoJUhUfN5JhSGQ7dLBN/njLAlf+0h7HEeq/7Rvg9v+aCkSbUMIcUPJQKwDkkToBVmge3Gb/9sD2Ugw9HBcfuF9zj2XvrvKpFuc6YclshalZJ5F013NasLv3jJS3exfu0lPm7eIYjkNRAypbNOpZCb4dPW6KN/EEDFkZ4g3f1u1aXiRh5hj/aH5oZo1e/kd2J4NR7P2+Q/TvR9z3UIp3yprDENvXnEh67hR433ffAkTD3AVfUkRWyFA3IOd8PQxsMO/NQEAMl8mM8Fq9B109/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404454; c=relaxed/relaxed;
	bh=DJQd4uOjVq6K13leIoD5x/ddyPh7D16WX2lRg6z2n50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOmm787f9809wkLb/9vDJ2D2LQ0IIfx8aoh6pqKX9gazzmlpBO5gnRHlZETPGATDr+WYnHQtHUYNoWlKNRdsoxNR86r4vg2G4xqkqqoHcLIpUsOR9LQko1ZeLHDavQzbaeD7RikRIl7slndmb11t3U4cKhh0HYLWlwAde+8TdS6nOkqMiF0IPSWAJX8w0/ju2HSQwwXf0dJ4KarbTneEIGwgJLC/RjkUxKdanPadQ2vbrACfpk44x9Mm+RGQCMCENZVXbDPV9jEnU8FmoL0T0HLC2GdDV2GPQO2WbGG1wsmi4rZQDiPzrMaCBGWW5HlBezP0WacLxJ9H9CMFzF8c0w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070f.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WSP02Ngz2yfH;
	Mon, 19 Oct 2026 21:07:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfHJeAo6qQLWbD7dz+JXMD+tgXLtVbeajWU+Z3y1SSse5Y1/N3Ent9rOzW+7kHw6xxv+0FE6FuXts8KmkNQWMfN0vVqNDh7KDMBDX9+rr34xTZ9p2FhpFlte3L+oGutXOpEJbc8pc8o686ZkaSKi0yM0ZXfMwqrnJBu7S6t83EmWab4EKUwCbLDZLWGh0a8OnMPP9Zvv54K59GE4efyZV7gaKcZoAa22UN+IneHU+NP4yM79FWuZHD9MMSAu/GNXWn/S9Jfg2ZczypYMN2YfBXOljH+JiybycyKKDXcG8IkOrdMlhgJnmaD01rthzIgwNBgstvaAnR4YQdumNkqRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJQd4uOjVq6K13leIoD5x/ddyPh7D16WX2lRg6z2n50=;
 b=TbsNJRRP9Xdz7P2p4Na/Oq0F8+kIgnsLYYh5DbjOY3wK5PhDgfEOpoS+w6cXuUhedoWbLeW8dqNqnp23VQ69qX5LdRia1UqDLrp14ob3J7VgEGbOPiLEnkvTGs4H307nwBttaV+bfUr9/QZHz//2Q09nrum3BmdXgm8nwvSdvZTKHqEC7rhUR4zmO+dXL7YiEEpewLR60h9A31LbghSMdg3EifX7def/i3H5en+wiQ3Dam8hdHrNa49N5Kn4++rWr387v0iRH8+P+it7q/PX2+HEEsLYPThfForjGAE9ghLq8gJbhqmPV3u6ggouDKv2FqZlpJWNhFuER3W4sRreTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:06:58 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 10:06:58 +0000
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
Subject: [PATCH v4 1/4] uart-routing: Add common UART routing framework
Date: Mon, 19 Oct 2026 03:06:40 -0700
Message-Id: <20261019100643.49099-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
References: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn (10.2.10.20)
 To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn (10.2.3.102)
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1204:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4e9abe-ffb8-44cb-c743-08df2dc8b65d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|52116014|6133799003|18002099003|22082099003|5023799004|10067099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	nAI2Gvae4yXh6aKM63WlDwv2dSA5TWZairrDIAkvoC7CUpeqWVaO8K6lzjTlWQHuNfL4ljTc4IQImhwcXRsLA5U+OOl+FY67TLn4J9ERrQ4a4NJ4AvIt5uldyQ7tICBY+EJOsxNUl3YZfj4+Id+8gojowlazzeZNsHgnEdX2+a/P5s/8Cl57wL65AbnN2KY/h/dpN/yBKFP1eNtPPrl9TyzvRePKEKGZJBEjQTGGTXXtgwFr4a7gqGJOahIaAA2qah/fXoUXWFNMbzf5mxapUb0S4Bm3iSwh3g8RuSbwaGNvrHbCH8maMy/IXSodPCxdpJ8cnch2QgCq4zE9VizYXLjV/z2FhZtsK7wiYEUxChzIpcNkxJ1EAnLDmbjfcTyUhoC4Z4X9qy3Mkd02lpIPev1Dobg/G+5W1J7fJWNrWF7pMel8V0eTJ+opxVqR8qkvop/BvpVgO9VYJhu1hgTYkOZ3QiiHipPO1oQd6CKw21lhdoAsK2SXWTJCJLc8pl19HDTf1+35iAkVr48M9/CumTtbKT7lKOOt6x0N6jHX2MtfCgueQmh3gjxzGzjAcpM/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(52116014)(6133799003)(18002099003)(22082099003)(5023799004)(10067099003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GcSmcggGrsjOzVqWLpByEHY5s/j8pesHrY2BOIbk/C9E9n4LNXEqItnb+RXy?=
 =?us-ascii?Q?UH2LOaWotIvPYrWTLYwwY87K+LZb5eEyndsVvXGn0pO8Eru5diw/sWFWf9uD?=
 =?us-ascii?Q?6mg5b2xVqT857ITt2SFhLjuPny4ReAgr0qWejJpFeA9wjTawZhbPW4ZT0dwD?=
 =?us-ascii?Q?xYW+7AaAWaBSjZ4j9u6y4RltVVbQwwyE3jKsqyx/KhMnSOn+TqrdoYWmXXc2?=
 =?us-ascii?Q?lr7HF5WO+dIMpvpmXRZnZQ+KKeOKNPh0jQnXI8L+k62e9I55Wvm2UA5ziCvM?=
 =?us-ascii?Q?+tDxBGGbDcvGqXgtVf9bKnaEZRdeH30aKlTJGDAmL16nQlBvGeCEar3ZGjEs?=
 =?us-ascii?Q?kgKG5U4+S2qtOaRZBDb0TG0MdJxog4AVv0onpd59vfG5a0lIqNqSUnqOhej7?=
 =?us-ascii?Q?9BVs2Iu3yE6+hCNI5eukOg+LPDxAKbEr3f1+AtnAft1x19BhVAeMl4CBqM1H?=
 =?us-ascii?Q?zZ92cKGSBWbaPBKou2Q1Ozzt/a2LsW71EdMFwFUAeGgptyXb/FShcQSu/zeB?=
 =?us-ascii?Q?DcpdRsTgXNb/Y3irUSuHB99DqIhjetOo/cSyeU6AbfAyMo0pALG140w5Ywl5?=
 =?us-ascii?Q?2JzznfxvmcnJRJ+4bma9MqQXkf8ifAWlSMNniJhtjO7fqjDktMJLEHFz4awH?=
 =?us-ascii?Q?OmXpf04TJXbw4tJh6J2MxrV6aHKPkKOZmSiTqNCDxkPYRa9JUABfZhB0MrNi?=
 =?us-ascii?Q?ei3n01oj2TqbeaXd/EfZWVtmnk3UtPAIh4P1t9G7aG/6ItFZieP/GtzyjYc+?=
 =?us-ascii?Q?0Se0hl05sLwpw1Z9OpJiObqCEzGVxKnL3RQhcQTYab3XsB0v6TlxN8CNqiWZ?=
 =?us-ascii?Q?NPKvQAsXPYPGEno/Si9oaMpmiHRykyMC25X8LsKIs/PpnTma5l2AOrEqBndv?=
 =?us-ascii?Q?CWL8xhpckYuxuljSrhn7X1ogQR2rXLosgkSaqQbyrqA0VUDdRJv+iGVE8MHs?=
 =?us-ascii?Q?qSa0QLfnZL2lbvDzVi95oS+hxF4Ws+Cji53KctkDeP8Nx9yURxw5i19pv6iC?=
 =?us-ascii?Q?WnMrnpbk1KcLTM5ArZAJRYmCzVbrW+M//t8YncBHrB3I6SxtKTk+gunffIPa?=
 =?us-ascii?Q?crPK0LSJLQ453g2E4wniuyaWasd81cLOkHd7ZxauO3SjEotEn3lEIVoobVMl?=
 =?us-ascii?Q?ZD443lcxDrhII87lSov1KCJDgYF663MoNvH/jO717jzWGEyMEEfniRYw3wOH?=
 =?us-ascii?Q?U3v0No/YXrzokAbTQVREaXpybR7J6EeBfT6cvDSbEONcl4Pkm/UOJAi+1PxY?=
 =?us-ascii?Q?QtMhUP91j9nsg5/o8zYyR9zQCB9GKvo4CBmMREeXYzZ8kFM4zk3PaJ8dUTnX?=
 =?us-ascii?Q?Js64M24ggrSStedGv+qW6+G1XLyb+mnhg5Y4wy3Yecw3f11NAWb+25HxQEb2?=
 =?us-ascii?Q?OaKCqaWq25GwlJu+gzkls0KmZk1os76YK+OSS+kC2ufhgb1cXZRnutSncFta?=
 =?us-ascii?Q?/Dwme6oEkJVO77v+e507z0g34ktIWdvrO29RrpicrpLkVs2d4xyTTmRuRJJG?=
 =?us-ascii?Q?i3hbMUjHefUNdVpuo8Nef03/pFz/m99OTki15WqCi3bZaC7x9NOmhsBsLdKO?=
 =?us-ascii?Q?6vU39WI95m9OQlnSdbeZPIYZObrfQKx1cH3VAOks51c07LPb24/K6AKnwSCy?=
 =?us-ascii?Q?R3BgOtqoPqju0zKUzSznWDxrTgsF2F2z3RQkaf7b+iXJP6Jy+86hsS4NeZ7B?=
 =?us-ascii?Q?+Z242dW4ByxDAEDpHvbLCvfMlyrn8SxGJK+EYHoES7gYaRM//AWjUALCq7EU?=
 =?us-ascii?Q?JbySTUHZ+ZaQ0bK/X8Ng75ff2SpYJbsCa2X75zuiNSKlp8MEzbYK?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e9abe-ffb8-44cb-c743-08df2dc8b65d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:06:58.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQPCAcYjk9vDt+YiN7gJFJgoya2NzAONXQ2hPQ9cLJpFS6ZE7PtOBE+gKEBD/g2Jswa7RzA4H8QMMqpkUARE2rDtlUnLKhZm6qtbfR/r0U9Xa101KN92hfRDpxAgVZwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

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

The framework keeps its state in the device drvdata, the sysfs files are
removed by devres, so drivers do not need a remove() callback for them.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/uart-routing.rst | 144 +++++++++++++++++
 MAINTAINERS                               |   7 +
 drivers/Kconfig                           |   2 +
 drivers/Makefile                          |   1 +
 drivers/uart-routing/Kconfig              |  16 ++
 drivers/uart-routing/Makefile             |   2 +
 drivers/uart-routing/uart-routing.c       | 183 ++++++++++++++++++++++
 drivers/uart-routing/uart-routing.h       |  84 ++++++++++
 9 files changed, 440 insertions(+)
 create mode 100644 Documentation/driver-api/uart-routing.rst
 create mode 100644 drivers/uart-routing/Kconfig
 create mode 100644 drivers/uart-routing/Makefile
 create mode 100644 drivers/uart-routing/uart-routing.c
 create mode 100644 drivers/uart-routing/uart-routing.h

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index aaf5d76ed074..11a535bb9caf 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -148,6 +148,7 @@ Subsystem-specific APIs
    tee
    thermal/index
    tty/index
+   uart-routing
    wbrf
    wmi
    xilinx/index
diff --git a/Documentation/driver-api/uart-routing.rst b/Documentation/driver-api/uart-routing.rst
new file mode 100644
index 000000000000..56975523aa63
--- /dev/null
+++ b/Documentation/driver-api/uart-routing.rst
@@ -0,0 +1,144 @@
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
+a remove() callback for them. The framework keeps its state in the drvdata of
+the device, so a driver must not call ``dev_set_drvdata()`` on it.
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
index d6039e440efb..3f33f8184be1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28403,6 +28403,13 @@ F:	drivers/misc/uacce/
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
index f2bed2ddeb66..57983a019075 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -253,4 +253,6 @@ source "drivers/cdx/Kconfig"
 
 source "drivers/resctrl/Kconfig"
 
+source "drivers/uart-routing/Kconfig"
+
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
index 000000000000..2539b8358b1c
--- /dev/null
+++ b/drivers/uart-routing/uart-routing.c
@@ -0,0 +1,183 @@
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
+ssize_t uart_routing_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	const struct uart_routing_selector *sel = to_uart_routing_selector(attr);
+	struct uart_routing *routing = dev_get_drvdata(dev);
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
+	struct uart_routing *routing = dev_get_drvdata(dev);
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
+ * calling this do not need a remove() callback of their own. The framework
+ * stores its state in the drvdata of @dev, which is therefore not available
+ * to the caller.
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
+	routing = devm_kzalloc(dev, sizeof(*routing), GFP_KERNEL);
+	if (!routing)
+		return -ENOMEM;
+
+	routing->regmap = regmap;
+	dev_set_drvdata(dev, routing);
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


