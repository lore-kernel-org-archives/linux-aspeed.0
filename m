Return-Path: <linux-aspeed+bounces-5045-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193EEC9830D
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrf1z1qZRz2y8d;
	Fri, 25 Sep 2026 15:11:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4440:2::71b" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790313095;
	cv=pass; b=mbNGizbIxw71wL0IwRMI8o+oe4TOIsCEvxlR/8cLitkA+vRL84wcmDTavDND3Ele3OfnGTu+MgbvE6d20RxDJZ6uFtc8qd8iwItZhlEeZrHoGRssXMYkAXHjfeef6fXoJpuzDefqexa2PWsMxIfqdtgdRc0AqJZQng0YFx7nq3yEarRRfDekDxTYzQxwO2taS2eupPhl/H/XyU5oBP6ghFyscpK5fXLhGBTGWXQYWECXGkmxigey+rr3yJFBcadzPiFYIZOIMPiKmoE0ZhnCNQe4FnQoqt4FOZJgvqxsbesQdSSYB83jGNwohgkeWR8aO2iHelLVbNwTlJYyKWRlgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790313095; c=relaxed/relaxed;
	bh=B3WI0l2fLcsjral4dphS2l+e8pM0k0DZhUpFW6LxElk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NUyBCz+gUAkZC9Sb5HFK57G8LnohlZvZsJO6pZUmdp7QaEGwUiS8IUvNI57aUOWnB1W9KnG/AxZmWGvugxA7D7118GrQJ0Dd+Vxh1iNNzYRszuNz/sPBejXoCW4k4l9DWUBqMx/Wqlrlv4Yoef5wbv3eF45MRnRCx2amV3gJoKWli047L5HmZAzOBYSpmLe+nD2NNxuHxawv/LZGAvOKniZ9uOOQdbB7uFuUnk/bhp5YHFHvvxF628iB7oYg32vdVSZxob9PJEU4deuxuZAfBmIWjaFJE38VGBEexS7kJMMyfQkf5bnlDKNTU5zHoJON1977yIul09dakP7kDzTxyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4440:2::71b; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4440:2::71b; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2071b.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4440:2::71b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrf1x1y2Mz2y2J;
	Fri, 25 Sep 2026 15:11:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtTaNyW0LQDvVqrix7NBT1Pgf0wBCarjzsM36GXz51oqS0trmnP5TkytNyizl3fJ967gM6ubHeReF79tLpuqZIfHnXd/irUOBwdCwu5Fr8jCHSFnWUQSJsfPVFeHs3evL5GN4bcwE0UPiSaTHnm8hCfL1fK7HYa+72Ka7CIZ9/IE8wARFZfd6CcGxXmZumvTKvKC0M3w9bXujgEv90rZHMGlTbH3IqtK1K721Ky3QDPERiNwzyHlyrMe9YcvCYElgV/KXygsMzz/Yc3QLj+B+y4YXUUF+S8/YxW1A6YbgKfYvjSzVYJJF1QGlBz3z/bZ3OFwxsNO6Zu1jPfKE3aaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3WI0l2fLcsjral4dphS2l+e8pM0k0DZhUpFW6LxElk=;
 b=e5a+4XK4L4X6p9pC8KVxAVJw1k8RfrGG47nDpjIP678Dpt94+pygr4d/9PteZLTrf8ICiboDICjdw119IczNRlVSauSmFsPy2QaIY4uBXReO6LUWiAHU1P4cOR+fXKuvTcxosJ6NgFss/LYct8DAvQpOeUOp2aP9YE3ln9COCQovWIphnLoLpUj7+8PM/SIsbvzMEV63ssjeahIkldV+DQP3156iWUki3NDhly25Ho4tWTc877WaJYuG071kzmp0JtwnczZZPYmfl5wBdQs7wAwhCd2Aa3DE3syJ2BrU2AIzO2SvsVNBNT/ZqPbV0Y5GG4bp92elXnfKZkYudQyMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 05:11:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Fri, 25 Sep 2026 05:11:09 +0000
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
Subject: [PATCH v3 4/4] uart-routing: Add UART Routing driver for StarFive JHB100 SoC
Date: Thu, 24 Sep 2026 22:09:47 -0700
Message-Id: <20260925050947.9900-5-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1204:EE_
X-MS-Office365-Filtering-Correlation-Id: 65432f77-85ba-42f8-3a51-08df1ac36941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BYgS7ubmrCs2gKUL/Qob1cSCil1TZTyqX9YYvT2sef1LJbk9jGvZxLH3lZWIxrJ8n7Rm96JrC7qpGEbOqf+g1ZK1Z3H7GYSosMpSDqr18B182dR8PoCV140qMNITlKCN42j6YQwVz9/bu2WnzQbjlQUJQeO42Bw3Jw/PXvq8vhvzlCy6ZzlnBWIbfniAGrks65utZC051EfZNqJooAeQqji8YCDLjAJd21VUq0EHN0fk2vkKSlz8YNB17yWOLlX1LGKLep1TBU+Ld+fKXaOPqY71iW+5uHlNYvran0r4wymJHwYW2ug48i8bT7Kdm7jyG1fHZXDJ/Iv9YQBbjr/dpaSaNgQJ0QFlIBZrXmT7Sy5pK2LGXw0jPpTXkUUB8/b3Bye6YMIqobQYWDuTbQWnMGdXHttg7BnPsE6hEmeoQyS5g9wFloCr/LYiHCscRVUbBfWgea6rMMv3pH5PAusuj+hXH1015pnuxYhUtDbC68YS7wEQ4In/FCIYa4w7aHcwO3FM3Hy86uIA6RK5wuwWTHJLL8AxrXfGhikz2pDwjctfL+YFPyzcM0cb9296R2sD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuZqZBT26IXz+0Cxia/xnI64j6fS/k0zLn547fCJYsSnPfWQpHb/p9txQNrd?=
 =?us-ascii?Q?vcrC3kzDYBeKb12dwydmuk9SBKIGMKDIB37zivc5qqZCM1FoX0w/qkAvz1xw?=
 =?us-ascii?Q?QvcSlk+IrAmKx9rQafG7knrWxgiCowFkvOZUWXuneISb6LGYUTfta/ekjPLf?=
 =?us-ascii?Q?W+1kQiSQYE035NXfJirrayKWJ9lQhGuWiliRCiviqwn4VX6qwgUqzlD5Gxf5?=
 =?us-ascii?Q?DXvHMPYvon528vbGih4imwAHMjsJD4Hy5uQy5wurFWDwrCd5F2p/qw6M2qsx?=
 =?us-ascii?Q?hqI/9G1uGYOeLAzm3L9lLIsUi7hxEFWn/ZJJSew0ZFE6pHD9ierpFNSkeFes?=
 =?us-ascii?Q?2WmmXWd4gWcjUqvoJpsT+0DqWky06ciyE+OI4q6nvpbvJcQ03mP8xZRJtdUz?=
 =?us-ascii?Q?XTifgEiya6os8yg8EPtw55k22KNHqIfBzYxfzaGO1ZOpLMOZUKy0CMBUzSWW?=
 =?us-ascii?Q?6KrvXPzj2b5uKYmTH4CQ9JG4oY4xQU4j2delPCzcrsQ8tnmbltgGoWDVtlz3?=
 =?us-ascii?Q?xAn/m/pkNhFEok3M/JtUeOdXEMaOeIXJI/TjAhCXr/Bb0SmkQab8MPZgCSMV?=
 =?us-ascii?Q?9yIE9Qof5qKLcpX1ZmkVQ106P+80rUkr34ZVcPzAH5xL8irov85eh5qB0Zsj?=
 =?us-ascii?Q?0oox4B0riV2JgM9r1FUrrHSQfsNb8v8Yj3u9A0my5y9XnU22zjBLPkc73vDv?=
 =?us-ascii?Q?zuvyW/YZj1GKkiuvcp5Av3hew4ChvmVLQ5adUZaluVZnMYsZEFfpa7DztGm5?=
 =?us-ascii?Q?Ga/SLTRTTap43BzEn1yGy60sxBol6Qqq4jZt+lOAcI43DOcITwkEXLjvyvYG?=
 =?us-ascii?Q?EiSqiU9qnUVc3zHL4u51720kpeHRUMgTcQkj+B/BxquzaqCxO3oEPrptz58r?=
 =?us-ascii?Q?yXrsjk+hfYXiiOVH6jsxzRNnlHADeYOief0mD7qtu4ab1tq+YvnAxl63NexK?=
 =?us-ascii?Q?G+z3TRK6D65RF1NKj0LPPmu5SBkEMCQHFKj/07PLkmMDSNVhlh0VevilpOND?=
 =?us-ascii?Q?OFb78IpKZWxAVD7CSsWwECchB3PF5AH2yovvfKXKzbdpoP8zyQ4c8Y66PCS7?=
 =?us-ascii?Q?ItsSEc6fhIdXWy+oohiIgNWn1Iqtq4mbQ2vLLyTW44BnI8CdmIMyQ9xFHLRf?=
 =?us-ascii?Q?rfHZbJUKMnI/M0zbooOxNS7XDr//qZeRuKmUuEYlEuzqHs97YjMORhYIRbm4?=
 =?us-ascii?Q?G+C5+KPeAH5ePZQK5PCsEwAeW/l49wPXzerWCEI2q6hfQIrJXSyqThZNKarm?=
 =?us-ascii?Q?CwefF05JapPlXuvM9hb65AG4qhFXc6ARtlDGrsPXnPUSFVppY1EVl/TloP96?=
 =?us-ascii?Q?JnHJqAHzpRFeWHSW1TM0AxofC6MyD45PL5k9KV/9bgGaKsXgRR7VJeXPjRO7?=
 =?us-ascii?Q?PTox3zPguqsdV+xRDrGMaJqyH+omqMLG2S9B4n5vQlDZ+T58MbVrbjSjiDB4?=
 =?us-ascii?Q?iMLO7oGALQdhS/yt+521T5YvgKqP0cPYR7nuCwejlOw+ufPqC1e9YkLrWF8i?=
 =?us-ascii?Q?yz7IhZiN20XWUA61ADPFmX1YPHQxhPOHBnawW6rYDPrGlvVFOFJSKtN1a9Ji?=
 =?us-ascii?Q?tVDD7ixpqb11jwjdq776kze35sBtJQ/FzTHfKlCNDsFDDjlgI/AW+3xhrsnQ?=
 =?us-ascii?Q?tqL34+jCRP+2RtWg/6AKI0b8BG6eXFH4uWyd+aNIPWPp5aLbtBLLkneqbWOp?=
 =?us-ascii?Q?08bj/IL4HepBte4LM3EQD1b5pTVZpDK1IIuzSQdjz3qAcFiLerO/39aNdq1y?=
 =?us-ascii?Q?ldWts0+ZPZ+v7zWnNBxHP54lst5JDFV87Her0I6+HBdzwGVXrHyM?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65432f77-85ba-42f8-3a51-08df1ac36941
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 05:11:09.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Layzh+DQ9jDpgY5EteJ34EvVWRgkjzukMjquF04Na77RXNK1qkidF/ubW/b3mvysVOJOIxzSozJnUU/hqVLFChbVtnxCnjA7Pe8HQKaFkBh8oAqE+KRCb0+ZnRAVxG44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

Add driver support for JHB100 UART Routing control, allowing runtime
configuration of RX muxes between UART controllers and I/O pins.

A sysfs interface is provided for easy checking and updating of routing
paths.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../sysfs-driver-starfive-uart-routing        |  49 +++++
 MAINTAINERS                                   |   8 +
 drivers/uart-routing/Kconfig                  |  15 +-
 drivers/uart-routing/Makefile                 |   1 +
 drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++++++++++++++
 5 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
 create mode 100644 drivers/uart-routing/starfive-uart-routing.c

diff --git a/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
new file mode 100644
index 000000000000..76aeed729d4b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
@@ -0,0 +1,49 @@
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/uart*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of the UARTx device.
+
+		When read, each file shows the list of available options with currently
+		selected option marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/uart1
+		  io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
+		  uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
+
+		In this case, UART1 gets its input from IO1 (physical serial port 1).
+
+		To switch the RX source of UART1 to UART2, write the desired source to the file::
+
+		  echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
+
+		This indicates that UART1 now receives its input from UART2.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
+
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/io*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of IOx serial port. The current selection
+		will be marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/io9
+		  uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
+		  uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
+
+		In this case, IO9 (physical serial port 9) gets its input from UART9.
+
+		To switch the RX source of IO9 to UART10, write the desired source to the file::
+
+		  echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
+
+		This indicates that IO9 now receives its input from UART10.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 8667b05b73f5..e8a91b66685e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26523,6 +26523,14 @@ M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/starfive/starfive,jhb100-syscon.yaml
 
+STARFIVE UART ROUTING DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
+F:	Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
+F:	drivers/uart-routing/starfive-uart-routing.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/uart-routing/Kconfig b/drivers/uart-routing/Kconfig
index 983e7fbd1bc4..be6f5d54721e 100644
--- a/drivers/uart-routing/Kconfig
+++ b/drivers/uart-routing/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "UART routing drivers"
-	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on ARCH_ASPEED || ARCH_STARFIVE || COMPILE_TEST
 
 config UART_ROUTING
 	tristate
@@ -29,4 +29,17 @@ config ASPEED_UART_ROUTING
 	  If M is selected, the module will be called
 	  aspeed-uart-routing.
 
+config STARFIVE_UART_ROUTING
+	tristate "StarFive uart routing control"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select UART_ROUTING
+	select REGMAP_MMIO
+	help
+	  Provides a driver to control the UART routing paths, allowing
+	  users to perform runtime configuration of the RX muxes among
+	  the UART controllers and I/O pins.
+
+	  If M is selected, the module will be called
+	  starfive-uart-routing.
+
 endmenu
diff --git a/drivers/uart-routing/Makefile b/drivers/uart-routing/Makefile
index 226980c639a4..59d9b65c2273 100644
--- a/drivers/uart-routing/Makefile
+++ b/drivers/uart-routing/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_UART_ROUTING)			+= uart-routing.o
 
 obj-$(CONFIG_ASPEED_UART_ROUTING)		+= aspeed-uart-routing.o
+obj-$(CONFIG_STARFIVE_UART_ROUTING)		+= starfive-uart-routing.o
diff --git a/drivers/uart-routing/starfive-uart-routing.c b/drivers/uart-routing/starfive-uart-routing.c
new file mode 100644
index 000000000000..3bd83ca5a258
--- /dev/null
+++ b/drivers/uart-routing/starfive-uart-routing.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JHB100 UART Routing driver
+ *
+ * Copyright (C) 2026 StarFive Technology Co., Ltd
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/sysfs.h>
+
+#include "uart-routing.h"
+
+/* One selector register per channel, holding the IO and UART RX mux. */
+#define JHB100_ROUTING_SEL(ch)		((ch) * 0x04)
+#define JHB100_ROUTING_IO_SHIFT		0
+#define JHB100_ROUTING_UART_SHIFT	8
+#define JHB100_ROUTING_MASK		GENMASK(4, 0)
+
+#define JHB100_UART_PORTS		15	/* UART0-UART14 */
+
+#define JHB100_IO_TARGETS						\
+	"io0",  "io1",  "io2",  "io3",  "io4",				\
+	"io5",  "io6",  "io7",  "io8",  "io9",				\
+	"io10", "io11", "io12", "io13", "io14"
+
+#define JHB100_UART_TARGETS						\
+	"uart0",  "uart1",  "uart2",  "uart3",  "uart4",		\
+	"uart5",  "uart6",  "uart7",  "uart8",  "uart9",		\
+	"uart10", "uart11", "uart12", "uart13", "uart14"
+
+/*
+ * The two mux fields of a channel index the same target list, but starting
+ * from a different end of it: field value 0 selects IO0 for the RX mux of a
+ * UART, and UART0 for the RX mux of an IO pin.
+ */
+static const char *const jhb100_uart_rx_options[] = {
+	JHB100_IO_TARGETS,
+	JHB100_UART_TARGETS,
+	NULL,
+};
+
+static const char *const jhb100_io_rx_options[] = {
+	JHB100_UART_TARGETS,
+	JHB100_IO_TARGETS,
+	NULL,
+};
+
+#define JHB100_UART_SELECTOR(_ch)					\
+	UART_ROUTING_SELECTOR(jhb100_uart##_ch##_sel, uart##_ch,	\
+			      JHB100_ROUTING_SEL(_ch),			\
+			      JHB100_ROUTING_UART_SHIFT,		\
+			      JHB100_ROUTING_MASK,			\
+			      jhb100_uart_rx_options)
+
+#define JHB100_IO_SELECTOR(_ch)						\
+	UART_ROUTING_SELECTOR(jhb100_io##_ch##_sel, io##_ch,		\
+			      JHB100_ROUTING_SEL(_ch),			\
+			      JHB100_ROUTING_IO_SHIFT,			\
+			      JHB100_ROUTING_MASK,			\
+			      jhb100_io_rx_options)
+
+/* RX source of UART0-UART14 */
+JHB100_UART_SELECTOR(0);
+JHB100_UART_SELECTOR(1);
+JHB100_UART_SELECTOR(2);
+JHB100_UART_SELECTOR(3);
+JHB100_UART_SELECTOR(4);
+JHB100_UART_SELECTOR(5);
+JHB100_UART_SELECTOR(6);
+JHB100_UART_SELECTOR(7);
+JHB100_UART_SELECTOR(8);
+JHB100_UART_SELECTOR(9);
+JHB100_UART_SELECTOR(10);
+JHB100_UART_SELECTOR(11);
+JHB100_UART_SELECTOR(12);
+JHB100_UART_SELECTOR(13);
+JHB100_UART_SELECTOR(14);
+
+/* RX source of IO0-IO14 */
+JHB100_IO_SELECTOR(0);
+JHB100_IO_SELECTOR(1);
+JHB100_IO_SELECTOR(2);
+JHB100_IO_SELECTOR(3);
+JHB100_IO_SELECTOR(4);
+JHB100_IO_SELECTOR(5);
+JHB100_IO_SELECTOR(6);
+JHB100_IO_SELECTOR(7);
+JHB100_IO_SELECTOR(8);
+JHB100_IO_SELECTOR(9);
+JHB100_IO_SELECTOR(10);
+JHB100_IO_SELECTOR(11);
+JHB100_IO_SELECTOR(12);
+JHB100_IO_SELECTOR(13);
+JHB100_IO_SELECTOR(14);
+
+static struct attribute *jhb100_uart_routing_attrs[] = {
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart0_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart1_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart2_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart3_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart4_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart5_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart6_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart7_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart8_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart9_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart10_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart11_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart12_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart13_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart14_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io0_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io1_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io2_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io3_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io4_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io5_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io6_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io7_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io8_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io9_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io10_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io11_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io12_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io13_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io14_sel),
+	NULL,
+};
+
+static const struct attribute_group jhb100_uart_routing_attr_group = {
+	.attrs = jhb100_uart_routing_attrs,
+};
+
+static const struct regmap_config jhb100_uart_routing_regmap_cfg = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= JHB100_ROUTING_SEL(JHB100_UART_PORTS - 1),
+};
+
+static int starfive_uart_routing_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst;
+	void __iomem *reg_base;
+	struct regmap *regmap;
+
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return dev_err_probe(dev, PTR_ERR(reg_base),
+				     "Unable to map IO resources\n");
+
+	rst = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Unable to get and deassert reset control\n");
+
+	regmap = devm_regmap_init_mmio(dev, reg_base,
+				       &jhb100_uart_routing_regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Unable to init regmap\n");
+
+	return devm_uart_routing_register(dev, regmap,
+					  &jhb100_uart_routing_attr_group);
+}
+
+static const struct of_device_id starfive_uart_routing_match[] = {
+	{ .compatible = "starfive,jhb100-uart-routing" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, starfive_uart_routing_match);
+
+static struct platform_driver starfive_uart_routing_driver = {
+	.probe = starfive_uart_routing_probe,
+	.driver	= {
+		.name = "starfive-uart-routing",
+		.of_match_table = starfive_uart_routing_match,
+	},
+};
+
+module_platform_driver(starfive_uart_routing_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 UART Routing driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


