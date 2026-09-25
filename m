Return-Path: <linux-aspeed+bounces-5046-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCBCC98306
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:11:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrf1z669Hz30VF;
	Fri, 25 Sep 2026 15:11:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70d" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790313095;
	cv=pass; b=dvH1TmFrKpMlxdrZ2xr/arcpopEUhqcaXuJXGoDOLXu563uQVT3ZWJNmdFbmA/28PsxUp1zDT7B9eLRiGUe+iAeLiNjXRv9bu3yU7XTRvwxhpdPx4FKTm4Ek0ac7U8AXcNMC+9FfZ8fTspePdeQYerkmbKuHRM0N1jBnLrMgD2yMT7nQrCujBnLGMj/8xsp12gaTY8wpgXPKGyLzH+y/8KZUHyHt+HTPgnMeuJZ6rxSnGRWQqKu5tL74RumCYo1QnSDKyt31inmGmEIZKAbevRv9O6cpmkHXLFrV8DWFR50yJht8PhSzrMmuGDUf5lWaGgeHCtOgjDj7cUT+R2hbsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790313095; c=relaxed/relaxed;
	bh=vS0mwKKUID6NtqCRyzu/4zn9jVsRM7VA/+aPh41MbwE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X23BIOK1wVVknGL7pFpw7e7dxA0vGEMYSS1PhSW6UYkThTm2B+0bFNmYTc3tOiHHpdN9jPhRrro4c+UC5NTss19Y9X2CxSIrnNiTZqnpikmw96Pk5dw4zCioPopTa9JXpHEeQokdDYGfIDT7b8UOtCF1O7/wyusGGF9UWXmrlLe9595GSwQJ5+iGCy9DVcl0ua3QvPuoiPENQTjMmnZoRfkS1Jm51ncB8FB66xuyzEJME3gfb9RaIQ/gZCQurTLiSJnU0oZ3uPjdEtsVa/5sTJM8aGBuNDcn20cmLDlfXkGlB4lt4I2p6yv9LYMgLAlGtmXMc04hX/azx4Fb2MW3mg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070d.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrf1y2Llvz2y2M;
	Fri, 25 Sep 2026 15:11:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJiX4P8ouR4pkKK25NEe5fMnieVTNTQksQCKBtb9A3XsZxylycHeZd2iXaqk9ftypug/eizyH8mb0esnHX3A5uNFoOpfw1bbXT9gGzL1LhtkNpCv3y1XVCBWIfJfG6l9yW8G1FPkdc0CnbEuUD36zgUwQT9/kQe5ORPE0x2zJUj+fNvMepDR7+95D1QeM5IlitEgJyxmJdqoLpYz6IU3HbqgZE3AsybGvoY64zbri2FUwP2Y7kyN/cg2gjuvWtv0u4W9wodyAzhc14smlnQmXrybsB6y1eEO7jtJ5eUr6Yikji8fPk2XLUZDfLjAD/EWk0NTGNjctNzgPmDdB9Y3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS0mwKKUID6NtqCRyzu/4zn9jVsRM7VA/+aPh41MbwE=;
 b=ih1pQrcVVwPUjenH7qOXrI4Fbrjbu3QIbuzrk+m5tHWC7ujFbe95EDFMnUnCfmeaIoUnltJe6MQTu/t/pbpiwsNkTKhGzt6mbWmOBKI9vkKdBsQWbXRb6Y8J5q7Qtgb13ltQNAr47OJpEEJgaTKf5vS2wo7FIB1NMfcssURehrH0EbvU9+H9GCRN1QI1d2OG+sYu+CQDAPBm2pRE6DUz5RitQ7DzBD1A5M9U5mHbarArOoDlz4K7nr0S01jcTu8s7n+cX97KJ1SuRxxyBwmX8HZ0UcYiLYBvWfjkbjyxSu/Y/lhvw3HRgXcIDMjRekcKBKh2b/wgiiKSy7MtFztjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1169.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 05:10:59 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Fri, 25 Sep 2026 05:10:59 +0000
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
Subject: [PATCH v3 0/4] Add support for StarFive JHB100 UART Routing
Date: Thu, 24 Sep 2026 22:09:43 -0700
Message-Id: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 0a402724-6b59-430e-285c-08df1ac362db
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|10067099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	uf7dDOgohsxMdlJYJ9X61RY1xPmGu/ei6gULtnol0SKEBJ9dYLowQQtNOSkzjvUHF73zhFittn4AzSw/B1IybjRDcji4a/Qiqn+x6Y3f51TSZk4L3sWiydmx+L/1/+AQXsEBXzgP5LgK7kNE0lI6lWq3towGzIYgr7d1706W3fpgJRa8a9LPjTFJeSf/ASd4ztxvl48h94izivLzlTtgQOvZHQQAn0aaR+DN7mk6n2mvxKJlTEBry6breF2MKK6ZnCXbsv+uewYqZRyDIyVK6WQGbHVvUY3UR6dhCw85H9HMjPLfPbXeRiDgqHA6/mvJ7iBhzlYAmLGr5pFfxI9TfUsvS8H6BtKkrjWmvKw9TeUDfSlYNFXfr6Pe8iPoG6nArzA1jMuApdvCeGv16p0NsoqtfYDXcIsplRFbLfUo1LYZaWkzpw/mv9rSwWyH4Ngp9/t2dqFx09Kye6a5+Q8pJ5Q8ZVXoenJbGF4s4LZiNGmaKHQqm/dmwozZMmwxJXxOckhZsS8QeNR/F3CiDtNvctpzCIDnkIiXTOiwyIxfi05nCJC981xy7vcxFDViSl4d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(10067099003)(18002099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XiD6BVEHpHHaW6t5TdfUHnFVeCo0I0RmCxhWumSBgzlbFgQN/jY7wLcqNry3?=
 =?us-ascii?Q?IE+Ep2g3ETMhXZn1z4+tB/oinsNnQAeJF8C75NsIbYtH7Y+h6AByHdkOrH6t?=
 =?us-ascii?Q?Us/TOZhZQZRoIMdUDMFf4pyKCAiLrQFerJIHJbzFoD+TMjlswbRyu1bYPkaK?=
 =?us-ascii?Q?2RlMfuKYuw7mVBPv4cDdm8XMpTek4NA3yaLMYuo9yhddyk6tpeeWn0xZyqEk?=
 =?us-ascii?Q?S9qov6sVmEE5yFnSmiz+s8ozXOR0EKrAoRZ82MnsFgznqLWrRn+26ODJmpcS?=
 =?us-ascii?Q?VA7ZcE5/q9SAa9ZA63Citbq4wbo03HO2xJv5bnqX1uq2jg9wRB73sX5GPHTf?=
 =?us-ascii?Q?2NzSesK3Kh9kza2ziXmOtBhmJHuEAsWBSx3q3uPTjfgR+WCpO3V2WqLqbWLK?=
 =?us-ascii?Q?OuM6e5byzeDTnezcyUg+Zptr/HaFEBEoNQTc3otXjGqmpUBjRTzZtKRWr4WA?=
 =?us-ascii?Q?Yj/DNgy9zONanU53VfCA2lqrOTlyoHgym0r2KSS6YY5XZiJ1WOFZkr8xBRMB?=
 =?us-ascii?Q?bonkFFy6N2+qJycpmDy04vQzHqtnMoJHo5iTluShPcpy5QyRES3cTjFmT9QY?=
 =?us-ascii?Q?o+0OzxpBR8EkGGZoRD/fcWTcJ9oX/Vtn/OKpQqE0X3LAV7GtVIAPG5a5Krbu?=
 =?us-ascii?Q?Sp6qIwqncga/VzkB4U2+qt01DdhtGI6pqfH+q/nNxiXCHSkskn9yy6hoPCDi?=
 =?us-ascii?Q?ZKE+FIfd7Yv9R1z7xESiLnF04pbASmo4VQRh4K1M0Ep+m84DPnrpOyzoWNSt?=
 =?us-ascii?Q?6PM+vyHy0Xr+2hwyXXJQkDkZalHO088MPbOedNVbGMh/06kNpIyQ94kFH+/G?=
 =?us-ascii?Q?TKs3TuFYNNzV6wnBI142vymj4A+7RT9vzsP4PrPLuWgrcY3A+A5VC62ywar7?=
 =?us-ascii?Q?THolFponJgHjiz4K4OKPk9fEKLXxNhxWLLwKnnvF1IPkbqR87gWZH/QktixX?=
 =?us-ascii?Q?2sAzMtmhWpv7pgvrWIGJLUfQzdx2H3yrizF7QjLnvfudXDQS/h/xcijLl9Kl?=
 =?us-ascii?Q?7HBIPZ6GATkM29X8hxV6LtXtY3v+ZHqh3Ig1zSao3mIl5cl02QpgO7MS/YYm?=
 =?us-ascii?Q?jTtZjJKblWOeEzuWpnbl8mk7nzvMVYdwB9eCsInW70MPktrEqpv4ywz0bEh3?=
 =?us-ascii?Q?T5f4OPm9RkTQ/I1xjkW1NZFU3mawrnqiBD/Ei/nNh/wE9gy7IV51lTOyNE5v?=
 =?us-ascii?Q?tSZxajGtdrsK4G8Qg0Z9TD8mCl1m/4fWTlRl3CACSHYwICLHB8xyNwvDM3hI?=
 =?us-ascii?Q?XNd/96OeXjmZ/AgR/jXv1detRgQjNjRyaVKObn8wC+YOpReaUtno0ai0q54c?=
 =?us-ascii?Q?A/pjya3IiC560RGqi+10BGxxgun7nQE/P6LzeFV7Evfc5Oi7ePqIocCfs0ht?=
 =?us-ascii?Q?oyW8Lxcr5M/4rf4LHPpqeSuld/eXKFh/67evFEXMAO9cOUtDcf/k/cOW8Rj2?=
 =?us-ascii?Q?9tW1/w+B8RY9GrxztMe5FqLCgD4HwSUqjOdEHzhYMSP7/DEG+OsrrvQCldQl?=
 =?us-ascii?Q?pMv2q7WPKieMCgplB7aCC8KJMA8UTtlP+frHO4dyGcu26dnNiTroCfH6QrY0?=
 =?us-ascii?Q?YuWygFpA6a5xpi4w8DqPth4r7IEGgpYmvsNwyhMtv89xSC25dfHeUlw+aiu0?=
 =?us-ascii?Q?BGjOQOGAQY4dWwartBPXCy2wYemMZU0pM9Tr9odhv3TQF1Plt3Ud04Xg6GDd?=
 =?us-ascii?Q?md5FKbAf02TGlQg/BjaiKWAJCfVoJsMcyCoywrrHz1BLtkdD0eaymjXTdbG2?=
 =?us-ascii?Q?OxNh8bUg/ejbcI1EHWtC3zWmdsArtHa/B8v9ELW4ht4kNfm11Ces?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a402724-6b59-430e-285c-08df1ac362db
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 05:10:59.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hKK//bnQ/lbFJQJcDutB3i6ABBrh6UtfTmtOcbS81ABfDWxerN6i6tbp5ayNE2DxGyHxpg9LSIYOfrDV6lMtc11/kuGU3N/V254ULa7WBWH0PQeNyqVr+FK+pDpNqNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1169

Currently, since Aspeed also has a similar driver, there is some code
with identical structures on both sides, but a common framework is
lacking. Therefore, this series introduces a generic UART routing
framework. It also moves aspeed-uart-routing.c under this generic
framework and makes it use the interfaces provided by the generic
framework. At the same time, StarFive also registers its own driver
based on this generic framework.

StarFive JHB100 UART Routing allows dynamic routing of inputs between
built-in UARTs and physical serial I/O ports, enabling use cases such
as Host <-> BMC communication via UARTs.

This series has been tested on the EVB1 board.

changes since v2:

PATCH 2:
- Add a "depends on ARCH_ASPEED || COMPILE_TEST" to the "UART routing drivers"
  menu.

PATCH 3:
- Move the binding to bindings/soc/starfive/ and update the $id

PATCH 4:
- Append the depends on ARCH_STARFIVE to the "UART routing drivers"
- Use RST literal blocks instead of backslash-escaped asterisks in the
  sysfs ABI documentation.
- Update the MAINTAINERS entry for binding.

v2: https://lore.kernel.org/all/20260905102901.126035-1-changhuang.liang@starfivetech.com/
v1: https://lore.kernel.org/all/20260830065118.51551-1-changhuang.liang@starfivetech.com/

Changhuang Liang (4):
  uart-routing: Add common UART routing framework
  soc: aspeed: Move UART routing driver to drivers/uart-routing
  dt-bindings: soc: starfive: Add StarFive JHB100 UART routing
  uart-routing: Add UART Routing driver for StarFive JHB100 SoC

 .../sysfs-driver-starfive-uart-routing        |  49 ++
 .../soc/starfive/starfive,uart-routing.yaml   |  46 ++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/uart-routing.rst     | 145 +++++
 MAINTAINERS                                   |  25 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/soc/aspeed/Kconfig                    |  10 -
 drivers/soc/aspeed/Makefile                   |   1 -
 drivers/soc/aspeed/aspeed-uart-routing.c      | 601 ------------------
 drivers/uart-routing/Kconfig                  |  45 ++
 drivers/uart-routing/Makefile                 |   5 +
 drivers/uart-routing/aspeed-uart-routing.c    | 415 ++++++++++++
 drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++
 drivers/uart-routing/uart-routing.c           | 200 ++++++
 drivers/uart-routing/uart-routing.h           |  84 +++
 16 files changed, 1210 insertions(+), 612 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
 create mode 100644 Documentation/driver-api/uart-routing.rst
 delete mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c
 create mode 100644 drivers/uart-routing/Kconfig
 create mode 100644 drivers/uart-routing/Makefile
 create mode 100644 drivers/uart-routing/aspeed-uart-routing.c
 create mode 100644 drivers/uart-routing/starfive-uart-routing.c
 create mode 100644 drivers/uart-routing/uart-routing.c
 create mode 100644 drivers/uart-routing/uart-routing.h

--
2.25.1

