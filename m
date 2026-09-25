Return-Path: <linux-aspeed+bounces-5048-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D71CC9830D
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:12:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrf244xC8z30VT;
	Fri, 25 Sep 2026 15:11:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70d" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790313100;
	cv=pass; b=ZxMrmKRCsx0XmnabihoIWXfJW3NWxoerqbPudFNbycKAnYe1Yh0QcerLxFdrnoqCkl9Cp66VUsSOzx+Yfvw6/KhX7AJKYN893U5R6acvM2em+ou71qGBDj+4Yxt5rbQMz2flbQfKQ9kTNBbQnJIPrLak73gx0zffariE4ehTUC5NyCAfRpNhtTUi8809H+zWp6M820qw7TLbDYF5JBaCqzXmtjhCfGBaqEBe2inyHfoVPcV5S8v34mZ4pIqqtzfBTkKMGcMxMpl6lweFdPfQ48TyqoZViptGqPeLcnqR0vwqqnHOcZ03J8hx88t2lpOkw54JLvzknIeVeUMvDic/Zg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790313100; c=relaxed/relaxed;
	bh=8GlyTpv83S44Bih6mJIJF/sTD6su6oInbumDMgSd9gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ceHA97ZRbzr+OTwKHbHw6S6R05R79S74nDINffsRMvItwGb6MXILAD/P5q9DEcctmdkIxk4cL5w5EW6BaFPhCKoIhwfrULrA5pC9DbpTMk+qBR77u/Pw64OUgMHUB0eNlUapA/iO9ubnq3Dn4xL+Po4k/tFyWyl2tGN0WVaIEZwhVYnUwb4O9R6RhVgoXAyO3dZmrSPsuhD8WwaQ1VfGWNTocbrUjAGrXwDMaKxi4OC5mN+Ync79I/mJ/7eMWQ1hgxM/SkYVbu4HGyjYYokzmbzrVCYkoACN7WDTOlu0rKRGm+RdQ4cVMssSkv9bMIYvm4ADillCqRGZG9W6x+DawQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070d.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrf224Pwrz30Vn;
	Fri, 25 Sep 2026 15:11:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu2MxH7NtdXKEp7Osphu/TgRaKwOYYfhjo+x9YPuPz7ufISHXshkA7mIotX6yjrYBlOZUzgBtggfpMD4wI8E9Od5pizdXBZI4TFK47SRk6cUGiOMf3snc4hB92HqnPQ6o8sgHmJ2fsUpQbp6FHf/lyRhpqK/7x1NfA6J7x/mkSInWLtC5Qhh9CcrdTf6Y4PtcQfoQ0pNrYsilElnwNXr3F6VQbf65G/exueX/bbkCUv110dW+jJkaUSq0C7OL53c7OEIkWN2YVAG2nFiqxqpAjfxD9P/hJaWARuy0sV86VPNsVgV/fUQykzL0iT72NiO2D4RhK8GCKa6rWGVgdKmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GlyTpv83S44Bih6mJIJF/sTD6su6oInbumDMgSd9gI=;
 b=nzpPs4bxhSXrnzeBx5P/UKFWtPYM7eOy8rnTtnfzJrbhI0BZVWmUrAC/mSXA+wIi/K8YhJpfG0n7mhVUfpUIfAblSNX+wefZfDrnUTtErBw36ky4DueGoidbBarK6fJMe0FnDzzziPI2MyYI2ZdOXJPCEF3Di5MjId8phKJT2L1SftmKv9higDuP3l/PVP/ohma7MT1WwP/iqLdEbBbTpacV1yDkD5I+j40rtGdlK7cCkyuA3Gy1zV/Oh/moN6n9wyof/IsnkFq4s9SqdjerxG4feEQ7aLHEhdNdWOVqGn2VqGAimqZFCTWJVC+J8DSCJHwOSEMxzcCA5gU7o8enFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1169.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 05:11:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Fri, 25 Sep 2026 05:11:04 +0000
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
Subject: [PATCH v3 2/4] soc: aspeed: Move UART routing driver to drivers/uart-routing
Date: Thu, 24 Sep 2026 22:09:45 -0700
Message-Id: <20260925050947.9900-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
References: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::17) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd0e6fe-8e50-4c42-9343-08df1ac36640
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|10067099003|6133799003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	UqSyrkVPwzaudEPV2DiMM4Gif95KjaZJObT0BbicNuWg4ZXrYSg/xNCJ/19MjV6wgTYTzGgKaS1M6Ro9NI4IjUDPdVFqwWzWRLXMCiuf060ExNotf94kuejomoxUSEBKKyVslnUysO1kq6pixhPE3/VuW3v3ZhIfIRGZW5TQfylSJUF71XaFGqcOOfB3n5fI//+wqGV6hXsfgVZMCXaRWDPqiTF6MGkGvNIC8ZzBuYwkUu4hn/vbXaWgC5WHRURguqEW/sWRsfKFNoamaXjEXDevFnV8ihTn+OBvhGhv2wpepOc9GJj27vSsV4eW7MFIF7xL1XZFV8+/ncHvRsG7uYZb6cnHi/jLIC6flSM8jmJOEBRled+nu5lK9eBkMNuXt7/CrNHDznH4A7pY/LsRZ6HU4ixrlTpisyO6XYd/M445whjX7Ae88tyolZwL/i2vSgkOYcDdbhl8w/k1O9G9kiMlRdasMimMTVKmo1CkxOZwYE0Uw7L0jQJhzJNAhLYB2ckoo6Og4gwoNLyz7vJXf/aesyX3R5shkAu/mespuSK5IUhQsiZW5lEAE0TcQE0X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xJfg+L3NuvKjEdQS6Fgg1tZPm61Sz6Soy2XAB2v8hWuhQkq9isKJduEy0JK?=
 =?us-ascii?Q?a8whVbiIKh+MIpeBd2yGISt0mHMCaXSeXgDnyl9oz0igrGHZiREb2INdzyPl?=
 =?us-ascii?Q?aGFcNPi65yyP0d966rRhFX32tjqDceLwmduBkaEN/FMxPMGAdeaFIC5npyqy?=
 =?us-ascii?Q?zBJ4+TBIDr91ctKfUWmPeZqsKImIAHfHI2TQPwGqDKmKvMIatKVPLdWc01r7?=
 =?us-ascii?Q?ptQG9Qegb7ik2SgXA+0FJpYXVPMOR37BiOa9EByGk+Hc48HsdMsEV/bax3sN?=
 =?us-ascii?Q?0vq7UKCMrTvlhaM2VmepFyUHYX9tOJxsQyzhW4VYBURPOeVK9/Mh36mH8MQd?=
 =?us-ascii?Q?6WNdJq8KySnZg20W2lZ5QeqJ/B7+ZZWYmX9CH3XPTIsiUHgzLJWkxD5S7908?=
 =?us-ascii?Q?gucE5nIp/1lYEt0UthGx+QX3L2L+N+qm7Ztp21uQTBBi05jAzn4fTqOPw8Yq?=
 =?us-ascii?Q?UozRqgjpxYIpahVqPyWisJQQ7eplObK0voLQ54DgoBPaGqOO8Qt2is3XtnJr?=
 =?us-ascii?Q?d/mVfdS3jIdRM/20PKTeM06EaUFPLiXIqY2bSBFTQV4PObUHcF5OnDJRln6C?=
 =?us-ascii?Q?r3Vg8Zem1PXl34uQ4ZHoVU0d5b8p+oa5WreClHV5/daPaP7225GXqGI8fe1O?=
 =?us-ascii?Q?yR2bqKM6SQk+zuqC9O0KrIJ+50SxMtpXZNOxcpAWdQnEm9EHgz+eYW7HUu+O?=
 =?us-ascii?Q?xvxe8OKmZPeqF8dzCCJVoni9bpMST1PoBPm8MbcG62CrKN3ymVXSOARZp+3N?=
 =?us-ascii?Q?WlTq5X0CDhMizTAGHIbEHhUANaJjlxqQUdFpSBbhiBj7QGT7ld4LRKL/Y5GD?=
 =?us-ascii?Q?VkKGQ1eN+8l6MQHxBbktaU1Vc6gWLRVdD/iqJ6KmaiNmN0vgkbPjK91u+xyF?=
 =?us-ascii?Q?FZq5G0jQT7LnFkMfB5z0T8J//33e6gqAe3pmSemQbGHaN72K8GAodOarhlv3?=
 =?us-ascii?Q?MxOBe/LhZJFvFj9Lsf887fvnYMmcosjx+baXJQrsoHlUkmzaOZIMIMTLtQMi?=
 =?us-ascii?Q?rN8QdMRihMz/EhDnQEikhEvMkvIZiTr6dwzwgVRmgYMLbP3ZcY5Ip6RZ16ue?=
 =?us-ascii?Q?SBgLcbhy5Bl8WYO3Qh+RinlfwLH1GSii7lotbkYB24gvh3jehqmmaWp4lCde?=
 =?us-ascii?Q?TkuvAk7ynS6RsAxD3y8dmVFR27/N8BfqfIOAToo3nNzSgsaW2QJww32IvA1L?=
 =?us-ascii?Q?rM4C0qHDFdKAgpWRMYbXbmuoWhpwrHNI/buEkw88BgGQLKthPRW/MoBmOoI4?=
 =?us-ascii?Q?65EEPys/lbS2MESxeUYQ9pziNiBxL0E5SK7HbyBOgqmmIOer12pSs9/Dxtvx?=
 =?us-ascii?Q?1InM+u/4eexowWIRQ06XrLR4NsddtoeOb3Z6RkB4HTMeI468hqZSQIfdDfeM?=
 =?us-ascii?Q?hJFWX4Qdl4TmgjTcmutPJciIhjcNeJ18TtWShgOl0fM63ukdXxAMohG6Itm0?=
 =?us-ascii?Q?QEPa37tFX9yB3Vb0ZSg5X/YeqnReNo7KmRhZcDynb3LI0Wu/bYnR8gZTqYon?=
 =?us-ascii?Q?DqO23Bg9ARdTqR5aPDTjyfZFiKx7yGbgN0kMWkFrKyVtoO5UKUAqXKa0Y+Wx?=
 =?us-ascii?Q?Qb7VIWnzYRgVbKD0kxtxvHXPlyAliF/3wdZqqzQct01AVhShJjxQvCo1erO9?=
 =?us-ascii?Q?03rlw/6I+JssHoawP8R83u70dRJ3mAZ2zXyaKo63OSeQ4l5tK09LfvFI8Nd+?=
 =?us-ascii?Q?rh354Cmt/Pa5IDN/4DkEw7YvLNxpSOswm1tLOtEy3msgv0p7h/+J/AtDwlF1?=
 =?us-ascii?Q?8PWTZ6pin9JzixcxMMRjHIPUVliiziFHGg/PXnvk/BkwPKslbrSI?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd0e6fe-8e50-4c42-9343-08df1ac36640
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 05:11:04.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBpYqlfRpoXioWiFnXTd/QkytflLqxgLkZe4o0Zpz8WPvH1/s1fHBGxSRAwXrS/M9yw1nSSpYDRr7OBWdLn2wghGY6bOH5OLAVPA2vbUs719IOqqlOtge6uahi6/mvO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1169

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
index b17e90363262..8667b05b73f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4133,6 +4133,16 @@ S:	Maintained
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


