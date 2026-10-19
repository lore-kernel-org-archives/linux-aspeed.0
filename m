Return-Path: <linux-aspeed+bounces-5222-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0E2CCF2DF
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 10:07:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WSN5vqzz2yb9;
	Mon, 19 Oct 2026 21:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404452;
	cv=pass; b=NE4RHzjd5TiHM8UJ2ISZTgDXsg3ntzPBh1GO2nm38CpRbJu4QOp/eVllQ8xLbXfZI/00uFVqcxGByW8G2dO5mC2xoFsSvqvcvugJxBer/ImyB0a5P2b//Ldrk81BrMZgkMMnX6oa3ZFwyrJtuaLNAg/DA9tvyawIYgqdeDN2nn9aEbLMFoXECQ2f3EgllbZZjvO0SYy9Zvua4FIsrPSrqnkWczvz7rLaM85g7lgg/496toSwu6kGrfYa5eLon7XZ9ZtxfaV1uHyQLZjfCln24hetgwmGQqYEHE5Mqpn+J4U2155y+HVYYIdsK5G2ew2pSdLQTqjWC2WZjYdect+hVA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404452; c=relaxed/relaxed;
	bh=EM1HS8KVy9IpOTpYM00zs5YciG03UPL9v4iVf6mweMI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AIKC0TA1JGxTF2zOdwgab+scRtU51R/Gjlo2f85PMacZsF6VzKj9lzwkZzxqwVi1z8hmw4WFP4Mb/+4KFXAQpjge7vb0vmIzHQmWCgHJK536Tf1QbXyud9uQknPCe3SGdRM76h/zN1sBTr3AcfP4e1LqReS5OufWWAvRM3ADBqQvuXjjyZjWI49lO4cfMHx33jqEw5cOKPHbmbqOfSmU3Qfa8eECvFBJkY2lpje9oe1+mzICOS3aoyLKpxQ1Up7iRj0zvSr0g7MWUUiYK2cMCjwcXX6PCcN6rWG1VyfT2EmbeJuyzNcb+0pCVMtjKQnaSOqgazCFiq/SqJBl6een6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070f.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WSM2f94z2xVK;
	Mon, 19 Oct 2026 21:07:28 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lozkSConZnzztoW5t4DA2JpvfrL1iJlyInskcQqPzZyU53ETvDKbFkDYSsGsKVu4tBp1I8dTmerGp1j9NFb7J1TQLylJoj8K982TwjYJqyRzOn3WDsWEQzwIGG9Jf5jlJeaWkrzUvxu8yxGDRezvWsqr6a3j+8nOgUQfQ2VqNXEnmRoy/4q9GSMYhA36uONnJqNMuNSzswfwBhiOX+2kRCpemjiTGF6w44kThb3fKBuY1+cx6p+k3Xe2FQVH296uZozPH0xX7V9lkv5AHaz4tBlBY16IUKVu1DlUQ5DZqMCXWAH5WZqBEtqBeIXUlZ4WtCq70LbzfJmvRoXgKqQoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM1HS8KVy9IpOTpYM00zs5YciG03UPL9v4iVf6mweMI=;
 b=HJ4tpPir1KmDWsXMy6o8L1Br1rdARSij7E7U3e+D/LCEBguAKXFsucPUvrRyfR4SB9C/6xK1rMwtlbQljTnSI9ISqU6m05wjrJ0o455HT6HahzR+hlkrXnHZz4wmde8o0RD0fxmlBY/Fvips30IWz2puMKPvk/30Ze84u+Zb0TfX/yB1vj1W0zwYd62VD0X8mKWA+dQSOAgt+8m39Nc8GEX/VeaYu3wkxz8HCosjjRNaft5bEmPAMXkFoTjeARinXmezhZHIwGuiX5GFJ/9Pz58CIZAwEC7LJ0b2xVG9OeeaFYVDtv0yj79sDMe5hK4i4XhHEGxYanXPbRF4gsRp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:06:56 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 10:06:56 +0000
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
Subject: [PATCH v4 0/4] Add support for StarFive JHB100 UART Routing
Date: Mon, 19 Oct 2026 03:06:39 -0700
Message-Id: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 549f7307-e67a-48ce-d83f-08df2dc8b4e5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|52116014|18002099003|10067099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	drGg/3gb1qbWo1ix0UZ46lACAqDPI2JOvWTKpjyT7/JGOQhjQAdMtg7PWJfwWFWslt41p+inUSEQfvC+rgSxUYt/0/TE6qNgFj+QKbHI7Jb6gCbim9qk8eM7k8cztbgOyg7GXSudpjsp3q9m+ktgIUt02QUk9il7BG/VlvpkfQBsqsA0AOO6s4/zAozAOI5inIA6lO2dJEqr7pq/OmfKEP0Bp2UszpuCbw2oqYliYB8UTM73aKh0DLp1dJkvCqsIp0bg+RvVZVKTQHoBid6AE/AYIDy7VA4vtdqwfdTqD7HIQPE6jlD/pkcUPzqIVOWMaX30s1z9DJDxe2mO6mbTvVg1VgtErum97WKe+9xG9gzsw50v6wiQ4D0EftYmzg+I6coadgG93UJURP6tzk85LjBJv81HMxR1CzyFi6l0LspEOjwIF8zZg8JsiEXB232lAHSzJ46mVJpO91DG9FqCfIzBJpj/daRhrSVPvN5kVWQU/hnLTCZj9Xt7DwgWqrixy/PE7nXPnmopGdKZQ67bACt5jydVVCQLdR8haZJn64Yr5eQFIFBoZc6bjgNOgcgy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(52116014)(18002099003)(10067099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9Y28a4XNj+apUNTWo0xNddRZmUoYxFA0yZ2Dnz8i7R7jO4xKJn7XEoaLTBc?=
 =?us-ascii?Q?gxwmvR0k7x8bBiYrRB4TXiPbUuFE9aCR/TikUtgZ/P9TOrBh6Joc+LJOrFuk?=
 =?us-ascii?Q?tBaLlH9uMUnyva2/SDwmWnIE84sZ1Exj9kaYTUKVUxp8tXMQwuxSvHgyaBVv?=
 =?us-ascii?Q?FH+dQstTcNxgen3IkLsgvd11AdH7sYBeL83V5C6308bQ6L7voc8Sw1eF6m4n?=
 =?us-ascii?Q?FLJgzDTFP1Qa215Fos1o6cLygrPi+pA185vxymk29bUDdAQSo4nlkI4nolbn?=
 =?us-ascii?Q?Alg9LivWj5uFPoc9F/mmSgv87BN4QrZNt3mGgTYoZrwkdvwyuMkTdMhp6nA9?=
 =?us-ascii?Q?4sOyq1omsjN71ZDUYLdVjQUrOMfS96F+0sBdbqrG5Bdcsw1svmrk9qvfMteF?=
 =?us-ascii?Q?/b1HgFZSAIOPTzf+LtohkdyrCfeT+ZqdBEhZh67ND8rblYp0P3XtdlrVJIA3?=
 =?us-ascii?Q?zSV7UOE4rQAufAtSe23lH1iMxMk19Z9mt3DhaDievWRa9zB994KKgvmE5Ch6?=
 =?us-ascii?Q?aGxOHp42zZ/Sggw/4fsAYcJY4sv3dUhl63UlSlCdMP1UmCbMQQ58Q2LVtmAm?=
 =?us-ascii?Q?NdBlfGF24S6/nCnTpMLNCxvg9ZE9TG9zXV6n5L78j7XKl2RbPfLgcO2PdPTN?=
 =?us-ascii?Q?C1w7yXaytvYEPEa3fuQarzQcqZkhsuK8kmtBitfpIwEP4gU1FXCd82ETyGN4?=
 =?us-ascii?Q?mUsE5jFLcJxgdgP9z9JIfB7JMhZSO37Ag+uS4rjy71ygAa1IvffCYyPfy4V+?=
 =?us-ascii?Q?J4sN51SUetzWpEbq2eEJuqB1hv2qiTk6p3AKtrib3bEg+gXXu4o/6jUJ0pLr?=
 =?us-ascii?Q?VMY4AM18Nsp0hUoW5K5e+Sq27JlD8iA5GT8RyzcLHF7+2WJAZShGzLN4A+M3?=
 =?us-ascii?Q?UepN3lCrW/X5a2PGM31dRRd+ErNmeelMYuvOlVk69hEI4tif079WxM8oTlkW?=
 =?us-ascii?Q?OH/pTRq6wx6qs9wSxPbbs9e2+K2t93FCMMkKdoWcxwHGJ7+AYckqb5jj7QUQ?=
 =?us-ascii?Q?rKifh4SdJkDxFONPGcyU7K1E47qKzpo6xPUex7juAMau44CM1hqlRKRxn/ve?=
 =?us-ascii?Q?7ZX9gZg6aEACuiIXVSK4tiL6wIRUGwHapMdgV7+kdwdeMnKAIISkgBh36qUq?=
 =?us-ascii?Q?zD1VVPvQM9+Tfq8qT0z+fOad5OAWVeyCoMuGe7laxMlkheOweSR4mu7y9/Jq?=
 =?us-ascii?Q?a4hS5ouHi70FOo0UX5Qf7QWBFwYT+Pc8RbvxiTYq8iK4+fWzVOww39REZ+pK?=
 =?us-ascii?Q?q82mX8Wsm7zQVj5oNQS20Vb2DdeB+EssZdxPdEnO/tI6q5IdG9JC1V1WN1oI?=
 =?us-ascii?Q?S2QfNR0QjtsxSLEKaGg/2VvuwedkQQtOPYRAGU6RXOQKC70SxOK/FVIjSmnz?=
 =?us-ascii?Q?7tzlCZrnZNj2zco4gbWyuFj4R8oVJrOFicETr1Rel7cMWJELbhECKlKSnT6B?=
 =?us-ascii?Q?88bthDoC73MbuTdxM+gpSXQzIrZo4GXXK9cRocSON6n017fSvrv2RK1e8YGl?=
 =?us-ascii?Q?nvizve/7zP6e4vVdDCYZhkEyEq/v/uc6QgQi0+QX9ksQIts9WLNOT2/XECON?=
 =?us-ascii?Q?BeMnbDj+K4VVNWMmnrjBUxkGXr4IUtgS5J0vQRbY7+clZRtoP9jU+wIEXpXO?=
 =?us-ascii?Q?8lj8h4OzxENsrzJPeAqD67zDnx8/Dyz175b2XCZeV83XzlrGnyOYbQLT1wBh?=
 =?us-ascii?Q?GiFFnqEgywM+mdvG5lC+JBtNZYyYULuue4PJWJbU/iB4hJpSTiu+Ur3khzwM?=
 =?us-ascii?Q?RDJMRdXDwpf1h5YkNUvYRxfDekpY3M4+wGWfuJLlGOe5ald6PGkd?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549f7307-e67a-48ce-d83f-08df2dc8b4e5
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:06:56.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ7hDMsUbo96hthrEk6AhCQ3ni+U4zIMqJ/UY52NZT0MePYtx9lVks3glIZoqM+ZLD7P8Qu2ZYM3FXmV3eeyWJaCE2OOCD6vPqMXgqvQ+AFVDYEtnpPfrSl6J72ham4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

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

changes since v3:

PATCH 1:
- Use dev_get/set_drvdata() to obtain struct uart_routing * to avoid
  null-ptr-deref issues.
- Update uart-routing.rst: since dev_set_drvdata() is now used by the
  framework, remind the SoC driver side not to use dev_set_drvdata().

PATCH 3:
- Add Rob's "Reviewed-by" tag.

v3: https://lore.kernel.org/all/20260925050947.9900-1-changhuang.liang@starfivetech.com/
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
 Documentation/driver-api/uart-routing.rst     | 144 +++++
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
 drivers/uart-routing/uart-routing.c           | 183 ++++++
 drivers/uart-routing/uart-routing.h           |  84 +++
 16 files changed, 1192 insertions(+), 612 deletions(-)
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

