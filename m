Return-Path: <linux-aspeed+bounces-4962-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A638C79F9E
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Sep 2026 23:34:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdRPH4YLrz2y2L;
	Mon, 07 Sep 2026 09:34:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4440:2::700" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788605091;
	cv=pass; b=g0AxUwFJAVim1/8gnHdCd155SKX+71rA4Oleme0gzjHbHF3mBJ8T4C/nQJgLfb0MShIjZjI4Zm7aiMaDZR2x7JlYqOQGXCTMpMsnEAxl2F6QxaG7NeOAOUONPWyc7IhZI/BTRD8l0TXQKOB4PYCPcZJsC27VJ2PgwVuUNIXZWcrWucKVy6HPS/y6AmibjeNbBlskr6w2gRekUADRxFZeqxVAEho0nMnoHYc4LuOZv8PaIqQN50pUWwCfUfdTkW2fCqW0uI9M7uIa+67hp2cBxpUDMAhGEWAIVTHPYQs+bwaGbZZCUliD+XPNKfOQA1/ukqNIf1XXx8Y1gwOEEQcF5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788605091; c=relaxed/relaxed;
	bh=0CNuR7HWfq+QfYinMdIdDVfIF6bEdOBDp+r8MMPyU5U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kD8UFJlDgk2lQ/8zf9oVbtHcimf/1CDNvyjwx9uOLsw5iawAd2ydSOqmbz+UCuSjtkJk/h2Xe5MwQ1XO+dt3YHOeih8M9vfPprhI+wOOtWkqWcbTwCWC3xi1YsaJZvE4QS5vLVulUJ103WR0JCpRg5sgCeZMJWjjaHboqPpaq9ATxe2xSf6i/R2HPKtEDlW7RGFir1mQKx5lEwTSGY16kV9FDG7oYh5AoUAsbj5AL7e41lODFjE0oF9YCCSNFbq9rsEXUHPSJ7+HKC2oC5rH9+5TkoFG0trr8tgj3gbKiJqmm6LfL3jHr3wDE+E+DRK/m3n1ea/cTbgRwrrxQ80h+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on20700.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4440:2::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcVMl0Q0hz2ygK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Sep 2026 20:44:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4gaR8wP3mfVsXtlrDj/qeeWY66OgxXCbwus+E41ncd4kv/3rMlJjvZR1EEN97Q8610dANIRK2tlQe0zzDQiMbqszjsdFgSTv/lSlXS9E5IVPIzpa6T2xy7PqyLINeY3SJ0CTluWIYTAvi+gACqIc3HvTgnco1Z0sJ9onKvWlGu5Y803LkgBqn8kF3km1Yd6ZJ8zQBpEueOdeVyCWZaD6PPEN+edb3aE1Eijjj6sRGHWh9N6pqPU/lCyOpSRW931G4k5SegNSTA33JdmfCJW47P8f2ud1drYYD3LT4TCSNzD7eAIGsniKfDFJTi+xHxvH+nP2fvd7Vp5TamfAVE4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CNuR7HWfq+QfYinMdIdDVfIF6bEdOBDp+r8MMPyU5U=;
 b=Ucv9/d5Nypsinpw8RUi1gxjk4jDqOAMwlUNsIqAH4QvD08qERjy+FMZo4yCnOrjkqWqcU48fUimqYVT9PZ2UB+ZGT/IwjZzbqvTiIIa03NNOWPExOXcZojFK4WHWgoP+UVWs/FvjgpuC5i5qZDclrvDEidJRGKeyLtJCJuloxIJdPB+UC1IMqB6/3QnUG+cuOqAcjEYXGTaA1Q7apyJH5f6br3sCN196IXh069VEfghqi6xBrGrZETJzwYOeeCoy76+0Q179YXJR4sa+7e4i94lGU1aUmIzYxy6bOdLNcg0N78MqyemUohW/4ZCQtD7nRnmFzFgidDCUN0HjemFFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1329.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 5 Sep
 2026 10:29:15 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0315.011; Sat, 5 Sep 2026 10:29:15 +0000
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
Subject: [PATCH v2 0/4] Add support for StarFive JHB100 UART Routing
Date: Sat,  5 Sep 2026 03:28:57 -0700
Message-Id: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 2d2f000f-80eb-4cad-4991-08df0b3888f9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|23010399003|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qvd6GxNvGrJhBxKdQnzmSMYROzoZ55iYxkdJWY5BemilJPR9CVjC4DJadx9Rnj2z+ucj8swB7RImXVsTGGnbwPfvIvx1zGtPOIuv7Nr4a0dNaDWQAi2rBQGFJ7FkUiPK3gsgD/0sFYGvFq4AVXOumasLBlLxeTG6g2bGV2c3TgslV8EdJrPtEMcP32LpHXehlBDaTb+KYj33tp6ZPolCWrjEYFsR03ZhW0518MVr2ytjzaFepkr169KuDJA7TZ4PQwktJDCpn8Cgktd1w6zlY95lCVvVd2AdsOjDndmCKiYH9ysKWFh8llLl4ICh+jbA4qvrsHIeATeZdvhEi7xjxveLSA/bI10zujIswCe/55k1f9LerE5QNC7nvxSAessejCXTJ4ATIeEAS4/CVnutEQFm5tsMx8ZaGQrVtvs8hwnBalXnJgsNJKZfrJAqrtKvmy+XPh1HEemPkZYkCsqmopWecTO14hWpWqubo47usRDIb96NdbaBqzHfjIC7AbsuuU4Tupcw8Dg6BauTsitSxp8JvS9yXStmgFBeDJNXrT5TBAquDqMO76h5TsWJFMcD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(23010399003)(38350700014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gz2SSq8zCy0SF1IPyNv1m3kIbc1CJpte01pSzK//cwk4LOQwTechqTYeLat8?=
 =?us-ascii?Q?BsWMfxcCqpmOYDHh5uztU3L9hogu1oAcU1hRvBJzp6ddCu1RJJ3wXu/YvJdf?=
 =?us-ascii?Q?r4i/4Zzn59Jvz1ZQ0sr7OChgZLSy/JFJiQqD1PJRjCdS5BD6iekSXvYZlhZU?=
 =?us-ascii?Q?jhtG5bVaLTUjU+voZVBPwmukwHq0jf+EgnDw7mLqTggleLijphflaergCPOR?=
 =?us-ascii?Q?LPB+1UHuGEP2peuyyAGYWWrUQ6sBzikXUltHyNmrcTufT+cSQLWMi4ibnJ7z?=
 =?us-ascii?Q?pgYO2DuneM48KGuDs216j0USkVNXf3diJ8lDMryzKZtmX7VCfE8TdU6G7elw?=
 =?us-ascii?Q?JxEZbETvKGoa0eyLZPAWmhxbMnhnuYPdSQAaXm16LC1vhpk0ck07huHOT6Pv?=
 =?us-ascii?Q?z8Z76q2LAdd2JbWMXgSd8RX1Srh65HYvju1gvT0QHeFUqhXFt709OdYE/umA?=
 =?us-ascii?Q?0n9xS4mE5StHbxLiHGG7uHSfTZuJMTmH+G0NaePCxqlf2qrgqyAoDk3NbXxh?=
 =?us-ascii?Q?g7B5I91lyofl345M/XzudUPN+s0j3TyT4E6z2Ee6gQzDE9k/YWccrPFMAeYH?=
 =?us-ascii?Q?wrQo8vuP8hP6WSXr7GG+lhZmQnEj3Fu9vKA1ue+x924q8Tbs6AqJOCBzPWyd?=
 =?us-ascii?Q?QTQz4+YQsf59j+thRjZZsGGBzd22c3mhcgMclVmatyD1CTHqmOQZpP/xwE9B?=
 =?us-ascii?Q?A5Vzjyv41BlSSiY+SQmq6uYSKA0JJPvwYt6iZaP0EaS+N9SSxG9LIQczvSKN?=
 =?us-ascii?Q?FYBTlYvUb0VOdfaPHmARoJk9jReyte4ly4EGMnDmZ9xDR5L9TC6BwlP8D7yx?=
 =?us-ascii?Q?PPPJqP/rf9tiTpXtp4EqpMXJTqQ4+wCXNrz/XK60mxkNv/RIrCtmCzJ0VS0A?=
 =?us-ascii?Q?qKltG4aR73qjxnPY4Z7d/0fFLr8/elrmdhy7X51KnS2rnS39G8m8J7Ap11X6?=
 =?us-ascii?Q?sIxF9ExBpZHnRRG/6meINNAfLwn0OOPs2zR0P6TyIelEESUoEM5ViTaETSFj?=
 =?us-ascii?Q?WWvNhKl5YcmSg/gRuoYD1cmQvSO2k0vf28kqNXLQ/ei6mmVHRIDCufn8BblY?=
 =?us-ascii?Q?ssK4LYCMsgKLmqOpbN9aWGeYlAoaRODIPG43jeBcUSy0uTqbE94tHHWAvNYt?=
 =?us-ascii?Q?fQ0rbX+iGfbGVTQZu9I0b5kY1tgJJs0HPTgUDOIlJsgmirm0wSMJ0E0VN861?=
 =?us-ascii?Q?/KQZX9R5QyMn5MJ0dD15sM8SJJUNwoswuOw8IOExOHOg24cX8CP+Ohh1Gp1F?=
 =?us-ascii?Q?TOUTjDFLL9rEJGFb3Gg+lTzXZNCWhOb2uELN1usd7gWQjzLyOqeY27PqxB8i?=
 =?us-ascii?Q?ah5iUJq2+ODsT8mPN1O2GdXxvGxT871pX4Q4wjAfxoh8Z9PD+32avhoheYAI?=
 =?us-ascii?Q?ggsPz7QFrKmtbGbxNI0rLyxwZwuyv1O1oFrtecttPslR1tGMU0p5b3k19S7z?=
 =?us-ascii?Q?RokDxC2NNAtLbGUNY0UfIYqIRqPuXjJuXCdYQhzLnpxBK0P0aJEcidM8qYle?=
 =?us-ascii?Q?IhhUTzKMjFNyDsjTX0sw9dKAdJkcM8iVgTOTaSYPtXz0lYcPhu4ZQpMh17bj?=
 =?us-ascii?Q?xIlcuVL/jkqv/F+KYKLqHXa9BqfSYjoZNe8Go+/qaLCxpZd8xsVaQ5GVPNyT?=
 =?us-ascii?Q?OqtA8Psx7kz4XquP3aONqL/YV4eblv8c52xqAImWWH9hoRjS6pkIsxafdkJC?=
 =?us-ascii?Q?FgTxc35oQj8I7pTPL/rcekWZidx1WiJXg1MkkNCJbRJUhnbbaexcDPRstZIh?=
 =?us-ascii?Q?4S9Nzdsum8rEMiC47Y6DTIUpbP23RRrp3ALhtWwOdHwYrV8pKs50?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2f000f-80eb-4cad-4991-08df0b3888f9
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:29:15.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xb+Y3br2dEJCIENJ3gNq3HUGRENliUbPV/9kse3Xe+JY3U0xPbNo+mXKoSciMqxAg4YOdkIwWEZ00P+3rtSFeWsD2rm38ZDdfg2i7cN37px4Nhk7VR9zLASQXIjXpPf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1329

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

changes since v1:
- Add a new patch 1 to implement the generic UART routing framework
  (drivers/uart-routing).
- Add a new patch 2 to switch aspeed-uart-routing.c to use the generic
  UART routing framework

PATCH 3:
- Move the dt-bindings to the uart-routing directory.

PATCH 4:
- Register the JHB100 UART routing driver via the UART routing framework

v1: https://lore.kernel.org/all/20260830065118.51551-1-changhuang.liang@starfivetech.com/

Changhuang Liang (4):
  uart-routing: Add common UART routing framework
  soc: aspeed: Move UART routing driver to drivers/uart-routing
  dt-bindings: uart-routing: Add binding for StarFive JHB100 UART
    routing
  uart-routing: Add UART Routing driver for StarFive JHB100 SoC

 .../sysfs-driver-starfive-uart-routing        |  45 ++
 .../uart-routing/starfive,uart-routing.yaml   |  46 ++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/uart-routing.rst     | 145 +++++
 MAINTAINERS                                   |  25 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/soc/aspeed/Kconfig                    |  10 -
 drivers/soc/aspeed/Makefile                   |   1 -
 drivers/soc/aspeed/aspeed-uart-routing.c      | 601 ------------------
 drivers/uart-routing/Kconfig                  |  44 ++
 drivers/uart-routing/Makefile                 |   5 +
 drivers/uart-routing/aspeed-uart-routing.c    | 415 ++++++++++++
 drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++
 drivers/uart-routing/uart-routing.c           | 200 ++++++
 drivers/uart-routing/uart-routing.h           |  84 +++
 16 files changed, 1205 insertions(+), 612 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
 create mode 100644 Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
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

