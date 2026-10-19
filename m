Return-Path: <linux-aspeed+bounces-5224-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CB3CCF2D6
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 10:08:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WST2zDVz2yfH;
	Mon, 19 Oct 2026 21:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404457;
	cv=pass; b=DhMfHTUNPhscBfka4+SQ0mzDMwHw8aev2Iu0pRCPzpQLSW5xmgjnAhjU1JyscxIgEmbWXudSvixg6Tv1/5D23fKsLL7sgWukYZ3YRVL2R6ftAOdoQ2f7KE2vWOoRmf0pqr25ZsA7ophdwMUvyJZii6FrvsLaU8NIAfNMWtr5UvSfm16CWhKC6885soHkXq+B10kIpP9EWWkuLCPOHXlvchynAsueQbiEvFuCdbiCcF/1n5+kjAqkybMr7XeKG8yzK8AG77xbk2GseX4lm5v1Fu5srz6I9x/Q7w5Fs5qIm+SSv3mTNhlbVvAQNE2bnL0pvxyoi7ziu8gFGvEtk0nYLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404457; c=relaxed/relaxed;
	bh=CMwIvC7rwhF+OovLMEVh4v7K04b1tr+Qd/dpvwS1gQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdqZXYGIphV8TLVQWBweA2jYj3JomBX/imeYYbXhv8dGPuojxgQBVp8fo1R+nKaPnNb1yfpMI+mPCf4zED/XnuXI0/LSqC4/qIgOeVA3hRV6jWqe+hF9FhtPDOKxYMuT9mCQHudTt6dbhPplR3oQR05zTzk1BguMDEA2M/tGfxxPKGfYMj0rixZcboPAI8NKcL4CAnyRdUSsqEqe+Ri2/1bw7Nz4seiTePX1dssy31orguRJDrxG9CxBHH6RSFXlR4CwKfJOkl/L8YttAxR+D7W2yhJIl2QypwaLC661L0brBQ8kq1nEhoMWdF4A5cpQk8rkPz9HfMoAA9w2bVXOFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070f.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WSR203Gz2ygW;
	Mon, 19 Oct 2026 21:07:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYNGVpPM0uWHGA25BCZ6rPF7yTPKeVuQ9Wc+UIAwvh8iNOMD9KL05+1KxW6luJwBz+FHS/bra3YpreeXe9VfjN7makUNHXtm13PThy+h+idBJnlrajyC/H8+6HPNNh/ev5BxkVjK35cJcQjs02+d/iBOIFkJDpqwrzCllZ4DjKht+YWyLVhxuJr79sD++yWkCaXB9HaASaW19XfWPRwrB7tmOVxyWV1Cjrl+YtLjPFfy5w1QYej2P9+dYQS1RFKQWzXH8SMcMTdMI4rep5HrlKNypjcDO/ED+1z6/5Zpq1s/jJe8eWeaBM11U4Npk+g2ajsQ3Tb8ogjuBswifHOvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMwIvC7rwhF+OovLMEVh4v7K04b1tr+Qd/dpvwS1gQc=;
 b=AyvTILIR78X9SV3AePikoZ7ZiyDgZor9babqQZ7xbwGX9ma2kAe+svcnFiVfF7ch2FZgKB9LaafUoUtW7bzBkoZtMq89FMpJcTEIIEwyQTIkh7a5U7VpzTLRyKKIPY/h3Vol+71LUGAEhxxAQp7aZ/Vqzqwn1gIMs7Wm3ciZqra4Xb/FHCWYGJvMbgAkxtSYsTkcmQ2rcn75ByeAWCFo76rrjw6s+xx106d2lDm3i/4+mvE57SE4Vd9noO05aqv8EkQYVmYemSBTzUzEfmplFv61DbDQdnggTIadf1Qz+Rjz8rBC5V3BXDdGt6D+wkn1EDI9rx7fej8m9CorucxVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:07:01 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 10:07:01 +0000
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
Subject: [PATCH v4 2/4] soc: aspeed: Move UART routing driver to drivers/uart-routing
Date: Mon, 19 Oct 2026 03:06:41 -0700
Message-Id: <20261019100643.49099-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1e6e6b2-e444-44a1-8c53-08df2dc8b7cf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|52116014|6133799003|18002099003|22082099003|10067099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Vp7MdVtcRUKytZeDXWyK9AyyHxyFnBrwoA/08WrL1RXeWGT8viaI1tEirtyqGGU7nLEaK2ehse2PQU+D74agVG+z4YtqSq3XoM4xcv2C+UtwjyO82Ib7EopEe0+uVMzUZ1wWKr4BrzM3LIcV2OdwrU5EdRj5gfEYLIUNn0WVA9hsA1FypqFuUFIDiSeFSoXwczSydEJmJ12GmekcgmLUIUk/Osj1QaxSqy7hTt7ZmcLAMUBSGwSZSPSOYksCgy0dbIODTKqXSXZKcUY/B2aJn+fSZqzGFdSaghVFLlTBwCRo5vDms898ljoII/F1HZVy74/OJTUKk9vXE3W/stcO9bVuhwI0bQDHZgjv8JAo/LiytpZjBSsTT0pzH+h+RXrI3OY9FAf22lANfFuiH688jH46tRb2oE8RvayvA3qarIeSsttAm2vlmuD8vdSuF1pGI/srppjUR6u1c2VUiU3XFEKxb3bVR1mAeXgdIy0aWofxRa2YMDfKjdf91+FxUUrYkQw04MXZtMkaSLwdhGC3WUJVI7Y+0AtLWmHKDPxBWMSYdkZ/UhlVTKbuq+xqXeIR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQ72cbOj0ZQQnb7ixCoEtxG4rI1UsYJNHzQLi1XZKD16cIZeSJG4kB7e7VVl?=
 =?us-ascii?Q?GUuGnNviSvOvA9v8PIDQ2jiLpbmQIIlgUqjGnGtj4sRjH6lAuhl2MhU3BdVw?=
 =?us-ascii?Q?NRN3xu/R9csNxhOakMy7l3rQ2CK4Y1r4UGJcU73VO/0xF3yv5xCZ2Buw/9jx?=
 =?us-ascii?Q?oHoniZt1IwHTaWqU3lUtaK0ISO+sKzo9OXX5uB94mSgQypO011zjvfvNPU/Y?=
 =?us-ascii?Q?FS143bbkP3OuHiEzFKqqv+/GAVCj7D/SOPh0L220cbB+WvyFGv2VSLjwpWDF?=
 =?us-ascii?Q?GD/FBtOOL7wpgvyS31vMw9YTQ0uM6szIHtXtxKQRJh6lwWnsVAGYBqsGY9tp?=
 =?us-ascii?Q?Gvv1spD7FeYpBeZqMb2nuo44adfnKWAlOme+2Qsfya3hS2i/oj9vD7fQW81H?=
 =?us-ascii?Q?z0R07aIFJOHsjk6tGRfsOCrhL6oaW5KNsLkrtxgGUnpt3wgRvpGunfUVvYoI?=
 =?us-ascii?Q?7ulOvonZzRSnzfxwX9ovaK7gVM9EMJsZEecm5dkwIMz66WlUjuytckzZYadQ?=
 =?us-ascii?Q?gf2sKpILRTgQRZl43NG6Ly1ZD4uhtY1YWlS+tyfBgqQhrxAaA9qH7w0CTOla?=
 =?us-ascii?Q?heVcPXgW6kFlrsMCV5vLb1rF/PsNXgsGO3Aa33Y704UWMIH+Ia1SAU6m4D2y?=
 =?us-ascii?Q?JOPeXV4Xdt5OL9JNU1/2MT0WKMnqse0Ql4zUuKerHd3Jle709nbZH4NFk7hS?=
 =?us-ascii?Q?h0vWmDGdE/lnsTEy91En80N0RbhYDrv1W2X00BZqTcdBdBMzlvZSwSX7rE9X?=
 =?us-ascii?Q?adpFChjheHtNLQWDwgXHmt5eoSAkZI3p+0u9vu3fDSQLH7o79wemrr4XZNPO?=
 =?us-ascii?Q?CsmgfxbB/ID5BCDfulDuvurXj9GKBvU1h6JqdfzrjybnJ8W9Pf1IV8QeTL4b?=
 =?us-ascii?Q?0J0VvOyGfPY/kL57ePsoRYtW6u69b/OO+cHFecbsufggTSQMwxjhZhG6XF7V?=
 =?us-ascii?Q?p0SpKQZqypF/se4nutwxihyncW1BdhybAkMscncJe7CWXR9HReXyzrxWKiz5?=
 =?us-ascii?Q?EfPnGPgiHqpedwfYeDjvug9xZ262Lxx6WhOnVqbMXXZ5RKPdi3CGnzidmDbM?=
 =?us-ascii?Q?MjGt4x7nxXZvvKy80S5wFBe+UiqtjafCopVloCABDY5yqfTjBqFlDEInI55L?=
 =?us-ascii?Q?n0VvuMQCV4J2GwY2olB7js0vcRzlhqytAV2JO78SwYB8+JKZWcGzSXC8jpOA?=
 =?us-ascii?Q?5ANsN6aJ4i12uusrmbr3zqnO3Dt9Wjis8lnCMav5FwhdAXAwRhKX7bjFg5xn?=
 =?us-ascii?Q?nrvqiwffeD7kHn7ABxSMAIPhvBfDDZ3eH+ll4r4KEcQ14M6nbMcqF4gi5GLk?=
 =?us-ascii?Q?UShRl+/dGxGgkQkWa9MQXiBRunaSz7oXmzBTYgkkTTgIX9UOzq/dxlBLyOgg?=
 =?us-ascii?Q?0mDRjENS11sUypJQ67SNPZCQ1R8UsYO+Gm4WSaMqHFOvm+7e6HoqtgFPK/IF?=
 =?us-ascii?Q?nEhyPmBxjhQZKmS8y3Nfzdo3r9SjVh6GvnJDNjquGRGKumTFi2jbXI4xsxzd?=
 =?us-ascii?Q?2fcGdu6WQ7WUAm5V4KKndovKM9pbrswwIdJbRAuNC4+1/lSmUBXSBPP49hGQ?=
 =?us-ascii?Q?hQgZiC1ePiYp1mWJJGevRHn//tOJ6YxKdiH5nyEWBzlD0CMvhlv40N2SS7Ir?=
 =?us-ascii?Q?RvTuBO2ijxmGe9wBKMY0qK5UhchMge/4rOUknN+Q1tKYFhzqVWShqp7pfT6u?=
 =?us-ascii?Q?UTV3ILO24Wo1SlyHYJq/3ORhW1HyUdi+NGq6ZUcndkHreodmDMMU4VsSH479?=
 =?us-ascii?Q?pMqma8ePn1lkKW+1yUr5i3VkFoavaIl9t0aOVuM2N9giHTr6owwH?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e6e6b2-e444-44a1-8c53-08df2dc8b7cf
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:07:01.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2meSrZbvTRDdqWhsgwnl0QPvKfoQN3GMAACXOWDh7lTWvneexHiE0L/pxx3cXrL9oZlFoFYB4UISLXZN3/UD0vHse21mkXdl/lVpLzEmashMJ5rtzR/c+tBpFIyvijmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

The Aspeed UART routing driver is not really a SoC driver: it only
exposes a serial crossbar through sysfs, and the same hardware block
exists on SoCs from other vendors. Move it to drivers/uart-routing/ and
convert it to the common framework living there.

The register layout description, that is the list of selectors with
their register offset, bit position, field mask and routing targets, is
kept as it is; only the surrounding sysfs plumbing is dropped in favour
of the framework. The per selector option lists become separate arrays
because the framework refers to them by pointer instead of embedding
them in the selector.

The Kconfig symbol and the platform driver name are unchanged, so the
sysfs paths documented in
Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing stay valid
and existing configurations keep working.

Also update MAINTAINERS to add entries for aspeed-uart-routing.c
based on the file authors, as the file currently lacks maintainers.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 MAINTAINERS                                |  10 +
 drivers/soc/aspeed/Kconfig                 |  10 -
 drivers/soc/aspeed/Makefile                |   1 -
 drivers/soc/aspeed/aspeed-uart-routing.c   | 601 ---------------------
 drivers/uart-routing/Kconfig               |  16 +
 drivers/uart-routing/Makefile              |   2 +
 drivers/uart-routing/aspeed-uart-routing.c | 415 ++++++++++++++
 7 files changed, 443 insertions(+), 612 deletions(-)
 delete mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c
 create mode 100644 drivers/uart-routing/aspeed-uart-routing.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f33f8184be1..13dfdc1f7aa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4132,6 +4132,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
 F:	drivers/pci/controller/pcie-aspeed.c
 
+ASPEED UART ROUTING DRIVER
+M:	Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+M:	Oskar Senft <osk@google.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
+F:	Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
+F:	drivers/uart-routing/aspeed-uart-routing.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 63a656449a1a..e27623a94fd2 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -24,16 +24,6 @@ config ASPEED_LPC_SNOOP
 	  allows the BMC to listen on and save the data written by
 	  the host to an arbitrary LPC I/O port.
 
-config ASPEED_UART_ROUTING
-	tristate "ASPEED uart routing control"
-	select REGMAP
-	select MFD_SYSCON
-	default ARCH_ASPEED
-	help
-	  Provides a driver to control the UART routing paths, allowing
-	  users to perform runtime configuration of the RX muxes among
-	  the UART controllers and I/O pins.
-
 config ASPEED_P2A_CTRL
 	tristate "ASPEED P2A (VGA MMIO to BMC) bridge control"
 	select REGMAP
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b5188dcde37a..ace038b6ff22 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
-obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
 CONTEXT_ANALYSIS_aspeed-lpc-snoop.o	:= y
diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
deleted file mode 100644
index b4b521b5ddf1..000000000000
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ /dev/null
@@ -1,601 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2018 Google LLC
- * Copyright (c) 2021 Aspeed Technology Inc.
- */
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-#include <linux/platform_device.h>
-
-/* register offsets */
-#define HICR9	0x98
-#define HICRA	0x9c
-
-/* attributes options */
-#define UART_ROUTING_IO1	"io1"
-#define UART_ROUTING_IO2	"io2"
-#define UART_ROUTING_IO3	"io3"
-#define UART_ROUTING_IO4	"io4"
-#define UART_ROUTING_IO5	"io5"
-#define UART_ROUTING_IO6	"io6"
-#define UART_ROUTING_IO10	"io10"
-#define UART_ROUTING_UART1	"uart1"
-#define UART_ROUTING_UART2	"uart2"
-#define UART_ROUTING_UART3	"uart3"
-#define UART_ROUTING_UART4	"uart4"
-#define UART_ROUTING_UART5	"uart5"
-#define UART_ROUTING_UART6	"uart6"
-#define UART_ROUTING_UART10	"uart10"
-#define UART_ROUTING_RES	"reserved"
-
-struct aspeed_uart_routing {
-	struct regmap *map;
-	struct attribute_group const *attr_grp;
-};
-
-struct aspeed_uart_routing_selector {
-	struct device_attribute	dev_attr;
-	uint8_t reg;
-	uint8_t mask;
-	uint8_t shift;
-	const char *const options[];
-};
-
-#define to_routing_selector(_dev_attr)					\
-	container_of(_dev_attr, struct aspeed_uart_routing_selector, dev_attr)
-
-static ssize_t aspeed_uart_routing_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf);
-
-static ssize_t aspeed_uart_routing_store(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count);
-
-#define ROUTING_ATTR(_name) {					\
-	.attr = {.name = _name,					\
-		 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },	\
-	.show = aspeed_uart_routing_show,			\
-	.store = aspeed_uart_routing_store,			\
-}
-
-/* routing selector for AST25xx */
-static struct aspeed_uart_routing_selector ast2500_io6_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO6),
-	.reg = HICR9,
-	.shift = 8,
-	.mask = 0xf,
-	.options = {
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO5,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_uart5_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART5),
-	.reg = HICRA,
-	.shift = 28,
-	.mask = 0xf,
-	.options = {
-		    UART_ROUTING_IO5,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_uart4_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART4),
-	.reg = HICRA,
-	.shift = 25,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_IO6,
-		    NULL,
-	},
-};
-
-static struct aspeed_uart_routing_selector ast2500_uart3_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART3),
-	.reg = HICRA,
-	.shift = 22,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_uart2_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART2),
-	.reg = HICRA,
-	.shift = 19,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_uart1_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART1),
-	.reg = HICRA,
-	.shift = 16,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_io5_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO5),
-	.reg = HICRA,
-	.shift = 12,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_io4_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO4),
-	.reg = HICRA,
-	.shift = 9,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_io3_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO3),
-	.reg = HICRA,
-	.shift = 6,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_io2_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO2),
-	.reg = HICRA,
-	.shift = 3,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2500_io1_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO1),
-	.reg = HICRA,
-	.shift = 0,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART5,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO6,
-		    NULL,
-		    },
-};
-
-static struct attribute *ast2500_uart_routing_attrs[] = {
-	&ast2500_io6_sel.dev_attr.attr,
-	&ast2500_uart5_sel.dev_attr.attr,
-	&ast2500_uart4_sel.dev_attr.attr,
-	&ast2500_uart3_sel.dev_attr.attr,
-	&ast2500_uart2_sel.dev_attr.attr,
-	&ast2500_uart1_sel.dev_attr.attr,
-	&ast2500_io5_sel.dev_attr.attr,
-	&ast2500_io4_sel.dev_attr.attr,
-	&ast2500_io3_sel.dev_attr.attr,
-	&ast2500_io2_sel.dev_attr.attr,
-	&ast2500_io1_sel.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ast2500_uart_routing_attr_group = {
-	.attrs = ast2500_uart_routing_attrs,
-};
-
-/* routing selector for AST26xx */
-static struct aspeed_uart_routing_selector ast2600_uart10_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART10),
-	.reg = HICR9,
-	.shift = 12,
-	.mask = 0xf,
-	.options = {
-		    UART_ROUTING_IO10,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-			UART_ROUTING_RES,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_io10_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO10),
-	.reg = HICR9,
-	.shift = 8,
-	.mask = 0xf,
-	.options = {
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-			UART_ROUTING_RES,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-			UART_ROUTING_RES,
-		    UART_ROUTING_UART10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_uart4_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART4),
-	.reg = HICRA,
-	.shift = 25,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_IO10,
-		    NULL,
-	},
-};
-
-static struct aspeed_uart_routing_selector ast2600_uart3_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART3),
-	.reg = HICRA,
-	.shift = 22,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_uart2_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART2),
-	.reg = HICRA,
-	.shift = 19,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_uart1_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART1),
-	.reg = HICRA,
-	.shift = 16,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_io4_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO4),
-	.reg = HICRA,
-	.shift = 9,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART10,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_io3_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO3),
-	.reg = HICRA,
-	.shift = 6,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART10,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_IO1,
-		    UART_ROUTING_IO2,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_io2_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO2),
-	.reg = HICRA,
-	.shift = 3,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART10,
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct aspeed_uart_routing_selector ast2600_io1_sel = {
-	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO1),
-	.reg = HICRA,
-	.shift = 0,
-	.mask = 0x7,
-	.options = {
-		    UART_ROUTING_UART1,
-		    UART_ROUTING_UART2,
-		    UART_ROUTING_UART3,
-		    UART_ROUTING_UART4,
-		    UART_ROUTING_UART10,
-		    UART_ROUTING_IO3,
-		    UART_ROUTING_IO4,
-		    UART_ROUTING_IO10,
-		    NULL,
-		    },
-};
-
-static struct attribute *ast2600_uart_routing_attrs[] = {
-	&ast2600_uart10_sel.dev_attr.attr,
-	&ast2600_io10_sel.dev_attr.attr,
-	&ast2600_uart4_sel.dev_attr.attr,
-	&ast2600_uart3_sel.dev_attr.attr,
-	&ast2600_uart2_sel.dev_attr.attr,
-	&ast2600_uart1_sel.dev_attr.attr,
-	&ast2600_io4_sel.dev_attr.attr,
-	&ast2600_io3_sel.dev_attr.attr,
-	&ast2600_io2_sel.dev_attr.attr,
-	&ast2600_io1_sel.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ast2600_uart_routing_attr_group = {
-	.attrs = ast2600_uart_routing_attrs,
-};
-
-static ssize_t aspeed_uart_routing_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
-	struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
-	int val, pos, len;
-
-	regmap_read(uart_routing->map, sel->reg, &val);
-	val = (val >> sel->shift) & sel->mask;
-
-	len = 0;
-	for (pos = 0; sel->options[pos] != NULL; ++pos) {
-		if (pos == val)
-			len += sysfs_emit_at(buf, len, "[%s] ", sel->options[pos]);
-		else
-			len += sysfs_emit_at(buf, len, "%s ", sel->options[pos]);
-	}
-
-	if (val >= pos)
-		len += sysfs_emit_at(buf, len, "[unknown(%d)]", val);
-
-	len += sysfs_emit_at(buf, len, "\n");
-
-	return len;
-}
-
-static ssize_t aspeed_uart_routing_store(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct aspeed_uart_routing *uart_routing = dev_get_drvdata(dev);
-	struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
-	int val;
-
-	val = __sysfs_match_string(sel->options, -1, buf);
-	if (val < 0) {
-		dev_err(dev, "invalid value \"%s\"\n", buf);
-		return -EINVAL;
-	}
-
-	regmap_update_bits(uart_routing->map, sel->reg,
-			(sel->mask << sel->shift),
-			(val & sel->mask) << sel->shift);
-
-	return count;
-}
-
-static int aspeed_uart_routing_probe(struct platform_device *pdev)
-{
-	int rc;
-	struct device *dev = &pdev->dev;
-	struct aspeed_uart_routing *uart_routing;
-
-	uart_routing = devm_kzalloc(&pdev->dev, sizeof(*uart_routing), GFP_KERNEL);
-	if (!uart_routing)
-		return -ENOMEM;
-
-	uart_routing->map = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(uart_routing->map)) {
-		dev_err(dev, "cannot get regmap\n");
-		return PTR_ERR(uart_routing->map);
-	}
-
-	uart_routing->attr_grp = of_device_get_match_data(dev);
-
-	rc = sysfs_create_group(&dev->kobj, uart_routing->attr_grp);
-	if (rc < 0)
-		return rc;
-
-	dev_set_drvdata(dev, uart_routing);
-
-	dev_info(dev, "module loaded\n");
-
-	return 0;
-}
-
-static void aspeed_uart_routing_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct aspeed_uart_routing *uart_routing = platform_get_drvdata(pdev);
-
-	sysfs_remove_group(&dev->kobj, uart_routing->attr_grp);
-}
-
-static const struct of_device_id aspeed_uart_routing_table[] = {
-	{ .compatible = "aspeed,ast2400-uart-routing",
-	  .data = &ast2500_uart_routing_attr_group },
-	{ .compatible = "aspeed,ast2500-uart-routing",
-	  .data = &ast2500_uart_routing_attr_group },
-	{ .compatible = "aspeed,ast2600-uart-routing",
-	  .data = &ast2600_uart_routing_attr_group },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, aspeed_uart_routing_table);
-
-static struct platform_driver aspeed_uart_routing_driver = {
-	.driver = {
-		.name = "aspeed-uart-routing",
-		.of_match_table = aspeed_uart_routing_table,
-	},
-	.probe = aspeed_uart_routing_probe,
-	.remove = aspeed_uart_routing_remove,
-};
-
-module_platform_driver(aspeed_uart_routing_driver);
-
-MODULE_AUTHOR("Oskar Senft <osk@google.com>");
-MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Driver to configure Aspeed UART routing");
diff --git a/drivers/uart-routing/Kconfig b/drivers/uart-routing/Kconfig
index a0c45a7bba47..983e7fbd1bc4 100644
--- a/drivers/uart-routing/Kconfig
+++ b/drivers/uart-routing/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "UART routing drivers"
+	depends on ARCH_ASPEED || COMPILE_TEST
 
 config UART_ROUTING
 	tristate
@@ -13,4 +14,19 @@ config UART_ROUTING
 	  This symbol is selected by the SoC specific drivers below and is
 	  not meant to be enabled on its own.
 
+config ASPEED_UART_ROUTING
+	tristate "ASPEED uart routing control"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select UART_ROUTING
+	select REGMAP
+	select MFD_SYSCON
+	default ARCH_ASPEED
+	help
+	  Provides a driver to control the UART routing paths, allowing
+	  users to perform runtime configuration of the RX muxes among
+	  the UART controllers and I/O pins.
+
+	  If M is selected, the module will be called
+	  aspeed-uart-routing.
+
 endmenu
diff --git a/drivers/uart-routing/Makefile b/drivers/uart-routing/Makefile
index 975165f070a5..226980c639a4 100644
--- a/drivers/uart-routing/Makefile
+++ b/drivers/uart-routing/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_UART_ROUTING)			+= uart-routing.o
+
+obj-$(CONFIG_ASPEED_UART_ROUTING)		+= aspeed-uart-routing.o
diff --git a/drivers/uart-routing/aspeed-uart-routing.c b/drivers/uart-routing/aspeed-uart-routing.c
new file mode 100644
index 000000000000..7286ecd87bea
--- /dev/null
+++ b/drivers/uart-routing/aspeed-uart-routing.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2018 Google LLC
+ * Copyright (c) 2021 Aspeed Technology Inc.
+ */
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#include "uart-routing.h"
+
+/* register offsets */
+#define HICR9	0x98
+#define HICRA	0x9c
+
+/* attributes options */
+#define UART_ROUTING_IO1	"io1"
+#define UART_ROUTING_IO2	"io2"
+#define UART_ROUTING_IO3	"io3"
+#define UART_ROUTING_IO4	"io4"
+#define UART_ROUTING_IO5	"io5"
+#define UART_ROUTING_IO6	"io6"
+#define UART_ROUTING_IO10	"io10"
+#define UART_ROUTING_UART1	"uart1"
+#define UART_ROUTING_UART2	"uart2"
+#define UART_ROUTING_UART3	"uart3"
+#define UART_ROUTING_UART4	"uart4"
+#define UART_ROUTING_UART5	"uart5"
+#define UART_ROUTING_UART6	"uart6"
+#define UART_ROUTING_UART10	"uart10"
+#define UART_ROUTING_RES	"reserved"
+
+/* routing selector for AST25xx */
+static const char *const ast2500_io6_options[] = {
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART5,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO5,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io6_sel, io6, HICR9, 8, 0xf, ast2500_io6_options);
+
+static const char *const ast2500_uart5_options[] = {
+	UART_ROUTING_IO5,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_uart5_sel, uart5, HICRA, 28, 0xf, ast2500_uart5_options);
+
+static const char *const ast2500_uart4_options[] = {
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_uart4_sel, uart4, HICRA, 25, 0x7, ast2500_uart4_options);
+
+static const char *const ast2500_uart3_options[] = {
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_uart3_sel, uart3, HICRA, 22, 0x7, ast2500_uart3_options);
+
+static const char *const ast2500_uart2_options[] = {
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART1,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_uart2_sel, uart2, HICRA, 19, 0x7, ast2500_uart2_options);
+
+static const char *const ast2500_uart1_options[] = {
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_uart1_sel, uart1, HICRA, 16, 0x7, ast2500_uart1_options);
+
+static const char *const ast2500_io5_options[] = {
+	UART_ROUTING_UART5,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io5_sel, io5, HICRA, 12, 0x7, ast2500_io5_options);
+
+static const char *const ast2500_io4_options[] = {
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART5,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io4_sel, io4, HICRA, 9, 0x7, ast2500_io4_options);
+
+static const char *const ast2500_io3_options[] = {
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART5,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io3_sel, io3, HICRA, 6, 0x7, ast2500_io3_options);
+
+static const char *const ast2500_io2_options[] = {
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART5,
+	UART_ROUTING_UART1,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io2_sel, io2, HICRA, 3, 0x7, ast2500_io2_options);
+
+static const char *const ast2500_io1_options[] = {
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART5,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO6,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2500_io1_sel, io1, HICRA, 0, 0x7, ast2500_io1_options);
+
+static struct attribute *ast2500_uart_routing_attrs[] = {
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io6_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_uart5_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_uart4_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_uart3_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_uart2_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_uart1_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io5_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io4_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io3_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io2_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2500_io1_sel),
+	NULL,
+};
+
+static const struct attribute_group ast2500_uart_routing_attr_group = {
+	.attrs = ast2500_uart_routing_attrs,
+};
+
+/* routing selector for AST26xx */
+static const char *const ast2600_uart10_options[] = {
+	UART_ROUTING_IO10,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_RES,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_uart10_sel, uart10, HICR9, 12, 0xf, ast2600_uart10_options);
+
+static const char *const ast2600_io10_options[] = {
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_RES,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_RES,
+	UART_ROUTING_UART10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_io10_sel, io10, HICR9, 8, 0xf, ast2600_io10_options);
+
+static const char *const ast2600_uart4_options[] = {
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_uart4_sel, uart4, HICRA, 25, 0x7, ast2600_uart4_options);
+
+static const char *const ast2600_uart3_options[] = {
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_uart3_sel, uart3, HICRA, 22, 0x7, ast2600_uart3_options);
+
+static const char *const ast2600_uart2_options[] = {
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO1,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART1,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_uart2_sel, uart2, HICRA, 19, 0x7, ast2600_uart2_options);
+
+static const char *const ast2600_uart1_options[] = {
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_uart1_sel, uart1, HICRA, 16, 0x7, ast2600_uart1_options);
+
+static const char *const ast2600_io4_options[] = {
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART10,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_io4_sel, io4, HICRA, 9, 0x7, ast2600_io4_options);
+
+static const char *const ast2600_io3_options[] = {
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART10,
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_IO1,
+	UART_ROUTING_IO2,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_io3_sel, io3, HICRA, 6, 0x7, ast2600_io3_options);
+
+static const char *const ast2600_io2_options[] = {
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART10,
+	UART_ROUTING_UART1,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_io2_sel, io2, HICRA, 3, 0x7, ast2600_io2_options);
+
+static const char *const ast2600_io1_options[] = {
+	UART_ROUTING_UART1,
+	UART_ROUTING_UART2,
+	UART_ROUTING_UART3,
+	UART_ROUTING_UART4,
+	UART_ROUTING_UART10,
+	UART_ROUTING_IO3,
+	UART_ROUTING_IO4,
+	UART_ROUTING_IO10,
+	NULL,
+};
+
+UART_ROUTING_SELECTOR(ast2600_io1_sel, io1, HICRA, 0, 0x7, ast2600_io1_options);
+
+static struct attribute *ast2600_uart_routing_attrs[] = {
+	UART_ROUTING_SELECTOR_ATTR(ast2600_uart10_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_io10_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_uart4_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_uart3_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_uart2_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_uart1_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_io4_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_io3_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_io2_sel),
+	UART_ROUTING_SELECTOR_ATTR(ast2600_io1_sel),
+	NULL,
+};
+
+static const struct attribute_group ast2600_uart_routing_attr_group = {
+	.attrs = ast2600_uart_routing_attrs,
+};
+
+static int aspeed_uart_routing_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+
+	map = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "cannot get regmap\n");
+
+	return devm_uart_routing_register(dev, map,
+					  of_device_get_match_data(dev));
+}
+
+static const struct of_device_id aspeed_uart_routing_table[] = {
+	{ .compatible = "aspeed,ast2400-uart-routing",
+	  .data = &ast2500_uart_routing_attr_group },
+	{ .compatible = "aspeed,ast2500-uart-routing",
+	  .data = &ast2500_uart_routing_attr_group },
+	{ .compatible = "aspeed,ast2600-uart-routing",
+	  .data = &ast2600_uart_routing_attr_group },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aspeed_uart_routing_table);
+
+static struct platform_driver aspeed_uart_routing_driver = {
+	.driver = {
+		.name = "aspeed-uart-routing",
+		.of_match_table = aspeed_uart_routing_table,
+	},
+	.probe = aspeed_uart_routing_probe,
+};
+
+module_platform_driver(aspeed_uart_routing_driver);
+
+MODULE_AUTHOR("Oskar Senft <osk@google.com>");
+MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver to configure Aspeed UART routing");
-- 
2.25.1


