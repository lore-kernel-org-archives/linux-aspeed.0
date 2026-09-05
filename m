Return-Path: <linux-aspeed+bounces-4964-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C642DC79F9E
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Sep 2026 23:34:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdRPV1C2nz2yvY;
	Mon, 07 Sep 2026 09:34:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4440:2::700" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788605088;
	cv=pass; b=bETSn4rsSRauxWKkE8u0VRcTBzfEKOaKbnUveE10SXe8dZkBfq5/ffitHIGVtIlwMz7Vh3H9juNmtmG7RXautlHz7Fwdxv7aYMuSdXVDQXTwV+awj2pecmW/cx0M/Zy6s8OQmQeW92rYH7t+FQIRC9ezsd7XGFog0SJu7t/uGftqkbqT5piRBYI4qtAO8wthpcpfYdQ80mhdwK3dnCczRRrqhfDwL+A5nmUoeoVBc0gA0D7uREu0Q5YfMpF3NrWqU1vB1WX95OGlLm5lJFO3mgooIyN9cFyXXMP3OaRaKJER0KLaTNDwTUyJQTB/YtjNTagLWewEs4BCcVfUm5aKog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788605088; c=relaxed/relaxed;
	bh=+rjw8I+RB3PFqpXkXoNJJuO5rM3Pv6gzIM//0L3gaWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icxGAruyaZMtxX0Lb7Drdkqy6LQwwEsbXdXkbULE5tNKVspkotBXWHwjb1hH3KAcW3v6rxpu66YhEGQuCVmIWxo9yzGLrjlrnp2+4SYG0ykilQksb1fBLAL3OdD9XjJlcxksCxjwFBYWp9sbdTMvjrZQnYyxvPGIeewPNjdSzLqc0HEnBEV27I9io8t71SkjOZ9bofJVfLsKD6sqiYx+mvvNk6nwl5fkgDVeOPOkspDj6tyI4WGp/c5qEtrgxk1dH52SRug13EwWk3eKjFaOtBM7xAuFPJlhfI6YGpZiT9Cu1LYOQZcoeBJ5up3wAcAiVd/LTzCcU+8TkYhHD1XQNA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 876 seconds by postgrey-1.37 at boromir; Sat, 05 Sep 2026 20:44:46 AEST
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on20700.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4440:2::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcVMf2rkPz2ygK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Sep 2026 20:44:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O29hJzAmI8L9qBthLIS4wQYil2UUYS5yScpu+WQboIIidJS2BGK7M4eeL2D/vt1iry1CHieqSF1lwrGfN9UsIhsADdZLQlSn49eoI0HLXuPns0wBcPp4qNJfgYuCPt9BpCVFd7JtnbFy3SEwkf0Ozf0nzM6U+g4pbKZ6jUq7FHvxmTeiGcM7sGNWJfo6CL6tUO27HkLulGqEYddVXzooNvdVaBLX1tru9qCMQzCbqYquGmzWPnE/YMJE+UwZofMndKGjzM22+XohatpN506VAlBRdpv2o293Jvr/Pq5OHquMJzcl9DTrzZA7g9T4mYkspnAhVilOju3d39luB/LHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rjw8I+RB3PFqpXkXoNJJuO5rM3Pv6gzIM//0L3gaWY=;
 b=Ny4PW3X0yF0zsFOTauV6Ckg5TU+Z0otJkbchcNwvpuhpRx253ZR/xQMu+z/pkqcjnhpehqZQuB65pD3i6PvenwuoMc0Km4r1dvA/cqBewCwGpK0VwfnE7Pw83TT4Zk/pjvGVsEm/qaEyzP3VJRdc2nkTw5rbj3Eo+KH/94gqo9uqejbYRGXjf+QxEqm7ohj+pYDBCnFSZspQDGz+eWIfO6jXgAAMai74vNIV33CBNDQm4LG/DFSprFmjLejxUFdIzmO6L6RKGO4lDmILLWSJEjiO3FUoU9M1+szhmG3p68NLVsdxT1pK4cOk1Rp/Sotnp86yIu7BktHlqgLW1FBk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1329.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 5 Sep
 2026 10:29:25 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0315.011; Sat, 5 Sep 2026 10:29:25 +0000
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
Subject: [PATCH v2 4/4] uart-routing: Add UART Routing driver for StarFive JHB100 SoC
Date: Sat,  5 Sep 2026 03:29:01 -0700
Message-Id: <20260905102901.126035-5-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f226a6ef-3f81-4526-6628-08df0b388ede
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|23010399003|38350700014|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4TMhB+2H9v8iBqVSZQX4jph18C3SqrMG/DIIhUjIICVbeHr1MqPkBRpIZDPYBSihsMEHHRab4AEB87GkWavzdN+6ZFYGfuzCWnquTEI3mHELZpjcSKC5ov9NJV2WRd5xcEnL3vQHPsf1zDvJBhuNR2ZtNAHYowxI8cSFXkyf8NzrI7KwfLAstuSzGml0tGR2hKNiiVrxjYvjnfIeiAyKII8CNFr+yQbxRkV+tIa88kZVqQQPnIWxeEtKvuZa9usPWyXzl1ylxjn4r4Sd3uMt77oNN3Y7ExlLjnDozyDBO6Wjy51bvnJ4cGU2lwPsxX15Gm+NDlqJpOMFkX3hZGJQh7+324w0/FtRsAX+zWs6FMiCmwKeyggc+6R1pXCR1A8mk2cXCCVxJrCVJWye8H6B2+jorJ48+Xd3sDuvIyoaw1jjOFPqCX5ISOLgP/FE0TPtsYVoduAvPli4NyesgO6ddK/RuYNvMJqXqyfBjlRhoYG2ft7dDrHEmkhxyKZ0sKByzDqtIJaCr3jS/gXRs5QuTQlliFjwJ1lf1jEpCyvRJb2aBUdVMgI7fs/vNE28Twr4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(23010399003)(38350700014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDra99gohWFCsdjrtKc7Ul8LERnEmzuu5o3kWaateS66vVlDJLdGF/H4Qtm4?=
 =?us-ascii?Q?wGlwT+PMKOVHKWIYcDVv6ITvYHRY9l37WIPEMYJa4YbunZxX1giEiuTwdHwd?=
 =?us-ascii?Q?Lp0NfmxMOhgGdnqPqeEK2nmCUMKjycfT7hUTU+M8/UkNe4rgLLEBl2g1W/Lv?=
 =?us-ascii?Q?6qXudz3J8WqDN1vFqMkHuOeFvW0S7zDdgMaleIeyYF37/NNiwGTYyh1RUIAs?=
 =?us-ascii?Q?vGQKfvqqcpplfOIJW9gvx8UW3a4si2yM8Owbf+B7m1j4docZn7JuhCT1X6hG?=
 =?us-ascii?Q?xfTii1wdiTsnzhagJvYPfb9imo7FNXxAZquY3yhSfHi8ndJnBNZtzIngL4cT?=
 =?us-ascii?Q?jmBqL6BUwXtGeauhu1/hG20x4LzlulqD+06AB+R8M1lHplRfgOij7bWWWbHA?=
 =?us-ascii?Q?qE7uLwd35xHIrEsGPH6DIWHzCwZU7Ebu+cXgOwduUIKQiy+tgb6yJ9nzRLdL?=
 =?us-ascii?Q?PPQZ8umBIItd6BUyRlkBZLuxnkTQxbSXk5YhGRdo9Mmc4bBAVEN3qCYvgJJx?=
 =?us-ascii?Q?JyhHtA1x26VvHTJ+pjd9EPQikiQ1FCZzrTeAjdLo6qsz+x651CzK0LRQxu9E?=
 =?us-ascii?Q?olbzyn5YL/UX4eXQk2B2kkbS7lgo5Z/8/RE0vLx6F5/fTR83/no1xKM5lVxW?=
 =?us-ascii?Q?nSmc+kezQ//xkhgw5mttGEharsbz8wS4ECLTdOdofIwDRU1Y0IR1sVOgcVPQ?=
 =?us-ascii?Q?nsQqaB5rgwPXR8DTSDaCaHhOHQUKfNqcVqYsTe3/KV/JHARpssIGZeV6Hex2?=
 =?us-ascii?Q?VHiKgJxl0iGIvhLk2MghrGbVln2u7W2/61v4TIZLBw42A6RBpZS/wZ4gYXm/?=
 =?us-ascii?Q?JNXRWk+A+KwENfZarKi2c7abovuGRW/NASLUDmFqqU8OcpINrXnqYxvLUX6w?=
 =?us-ascii?Q?v++bbQFei+kM3pCGRD0XAdrA5VJZhPk9cWP7vBZFOoO94YFZXhmbHprozUpH?=
 =?us-ascii?Q?QTXRApCyxaNylkreckCluDkYIePhh40SqumTD7LeOF3OSUNN8o34RLmC3YLL?=
 =?us-ascii?Q?+dQR1bvrG8sgleZP4tM/FjhxEaZXE/AwXAKnv6skWQjLWvezZmRjX/7EQKXi?=
 =?us-ascii?Q?QgkuldUM3a7/LbVj7Mjn0PFkw178YoPhjOmd3RYUHPU3T5s44wp+F/921J/r?=
 =?us-ascii?Q?gJ0HjvKLAbbsqw5AY/lU1bmltFOshf6vh/6yGPED56t8r7fkaoie0IIk23J9?=
 =?us-ascii?Q?TToFNrnRGWPjEzgwrFO/tGJdoPvBuJSVuUiUsdqnMhPzhXwlAx4JyZ+FggWD?=
 =?us-ascii?Q?cijSQTFewoDj9jODSFd4enoIof9bZy+QJyUC8X67DMoJjjZc/lkAmb8ouR7G?=
 =?us-ascii?Q?weD1evNjzW7HuPevcBTnvshgy+aN2bPBu5KyrVXJq2M3nhQ3wrkiM01zoond?=
 =?us-ascii?Q?2jUcuAkxpZCnGLjRraNIyaXPrs2Pm4y1O7aGnXrr6M2M7WHo7ilBbX6Eb3Sb?=
 =?us-ascii?Q?sAzF9Y4m/F8gfzdto8cDEJGawCUL4+gzODe8pOGJ6LYGpdR02kPADS/Dqk2w?=
 =?us-ascii?Q?/wdSI4McXL4QoL1nsDoOrXo4+9lNkuOe/wcr8CsBjpqUgh5V3/ZyhW+Zx5gt?=
 =?us-ascii?Q?EmzLuPPqVppSIwbT8lyYInqwWUFNTeeK2gVjqxjpvl9L/SEOssjmjiUQRWGD?=
 =?us-ascii?Q?EQg3mXy4v5ptonzN0i147IkwOqfen5mWxPU+zT6F67Q7/i2yuzJ62KaNa1HK?=
 =?us-ascii?Q?sQSC37RXANAvZzMt/md+IV6QWf2TemcFrSw3NfJD690CHMe1Rjq6Vrhw67fT?=
 =?us-ascii?Q?RzS1MMfLwi/DJPC4CJedkYH9rvV0oxXLgKAzjNlSrWa5WpoaVh4p?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f226a6ef-3f81-4526-6628-08df0b388ede
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:29:25.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NulqFZ5LZS2Vokl1Wb27sXRnUX5LQFayXkle70resGhoVFESIgPAsZ1nh8lxKa34fROy7DnV4JPW5Xcar4fvAUhJp6/gNYjObwBPV6xQmDfgo2+FdZULWZXZW/frSBdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1329

Add driver support for JHB100 UART Routing control, allowing runtime
configuration of RX muxes between UART controllers and I/O pins.

A sysfs interface is provided for easy checking and updating of routing
paths.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../sysfs-driver-starfive-uart-routing        |  45 ++++
 MAINTAINERS                                   |   8 +
 drivers/uart-routing/Kconfig                  |  13 ++
 drivers/uart-routing/Makefile                 |   1 +
 drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++++++++++++++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
 create mode 100644 drivers/uart-routing/starfive-uart-routing.c

diff --git a/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
new file mode 100644
index 000000000000..737afdf428bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
@@ -0,0 +1,45 @@
+What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/uart\*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of the UARTx device.
+
+		When read, each file shows the list of available options with currently
+		selected option marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		e.g.
+		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/uart1
+		io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
+		uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
+
+		In this case, UART1 gets its input from IO1 (physical serial port 1).
+
+		To switch the RX source of UART1 to UART2, write the desired source to the file:
+		echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
+
+		This indicates that UART1 now receives its input from UART2.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
+
+What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/io\*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of IOx serial port. The current selection
+		will be marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		e.g.
+		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/io9
+		uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
+		uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
+
+		In this case, IO9 (physical serial port 9) gets its input from UART9.
+
+		To switch the RX source of IO9 to UART10, write the desired source to the file:
+		echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
+
+		This indicates that IO9 now receives its input from UART10.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
diff --git a/MAINTAINERS b/MAINTAINERS
index ad6706c18f37..16c2fa9aff57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26115,6 +26115,14 @@ M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/starfive/starfive,jhb100-syscon.yaml
 
+STARFIVE UART ROUTING DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
+F:	Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
+F:	drivers/uart-routing/starfive-uart-routing.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/uart-routing/Kconfig b/drivers/uart-routing/Kconfig
index b67c2a6de74c..13b2424d47c7 100644
--- a/drivers/uart-routing/Kconfig
+++ b/drivers/uart-routing/Kconfig
@@ -28,4 +28,17 @@ config ASPEED_UART_ROUTING
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


