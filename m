Return-Path: <linux-aspeed+bounces-3205-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0088E74903
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Dec 2025 05:40:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbggv4ldQz2xqG;
	Wed, 24 Dec 2025 16:40:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=52.101.126.133 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766554811;
	cv=pass; b=lFKYDglFaYIDumkiIhTks6Az1X4+rq0QdzXN5uYrhoboQw28qRrePDMV0ABtQ+BOhGhnm4E+V/X9fqvmvIrjXlqUhb+2X1/Q83Dk2fLl7XZAkKAAqRnd8m2OGs2l5nQjiyfiWm3jXF44tv8eqGLG0k4f1sQ0ouhVUUQrJmNgy/kRRgy+jaf8IFOpkljkvNhSy77j1Z+JQbD7+jvkFfRhEPL0CgUtQS+fNbual/xQtWmIyT+2dUnkGqUmbwBKXenDu8bj0oZ0zj0Tk5oRoAMcWLX/LCrazlwH5E3Zu3lsvs/LJRz2KFVGbodeOe2und+P5csbdkPy2OadSjZ/pOMrJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766554811; c=relaxed/relaxed;
	bh=2qTQw5xW5atoSR+OYcKpWmbmedGgyPtYwQF3SnPg904=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dXEwb50AGlqoi2/kiCEh8WVEy6sxwa2+TZVkyF/UJWoYSaqxSUjhVPcfxxe/2ZXGdBbHBiaTwmGrZt9FNtune8wtyb3GSnWZvB6bfiGAFHBuEk+290/irTTjW9Yxn/anN48GZe74G89TVQ7WpMM7GxaBEFnSZhFnlNGWmJiZ5BRnV7n6aCIwXJJm4T4bcWUwZaMFAA3NV/p4IX7WB22A5v2MLXijyCe/3Y0NY1iXKttqvff4s/iCTg/NXpfZaV6JZ1FQdb+W9z8VkyCVhebsmu0USUxFyBeAahr8HGQdkZqiVtm1rhv++OVlX/UIZBmnwwA8qWxqKHkln0wAMKgYTA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=R6XgnDng; dkim-atps=neutral; spf=pass (client-ip=52.101.126.133; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=R6XgnDng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=52.101.126.133; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbggv0bVYz2xlM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 16:40:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKTqGpn+PsazIU33X+c1ewtgYP3mB5xkybpdH1fu23JXaz9IYdxkrN3bLAqCn/L5agbtbD1l8MGtl9kyRvhGl0DHTnHlROFGl++MepR1SWX3UOhORij6SO9p1WOWPvTmNgxXgGV08ki3bE+vh85hpUN1oZbr1NzErlkqkNfgifQjIbduBM30xDeV/NV0QU8ptCtuSD1tPzKzetftZxp9iDMm8bQxGjU9giH6TpSpn/3Di0ggfCYNzA36dONsp6hHXQ9ayVC8droKrLo9piSDf5sEV4HN6wZVoSE4ELDvcVdJ3FdmgS9SfP7VSs8VxPsDgYTSd925FOaz5Cw6MHBCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qTQw5xW5atoSR+OYcKpWmbmedGgyPtYwQF3SnPg904=;
 b=SaOJSwzZzdnGam2X3HAU8DKTXjqhdKzq2oLvICiIxiWG8hF88834M/lGPWoGjXkz52Esz2Cg33k8+Ht1MTTmJpSk9Dsk4+/vX33JBz3d73iD3H40baJU2TPyQ+a7tfkZh49KMStUZFFkFvA3G/bsODPfTimrz8GebBqa8p3rHhiPd5UI/HxY0CAC+Oq8hlXM0G4G6f50eBB8vvKJ5lPSC/vRxD73zWdbz5Cm5u98QklSxT2gwqu5c69maohuyZXM5QQhN1qSaBypjDyxM7DhkfTIHYXkRVjP1qFflNEsyRwjuX4z4P6NHL5bDNKG6bA1LAfgboThtx3bbnvebe8A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qTQw5xW5atoSR+OYcKpWmbmedGgyPtYwQF3SnPg904=;
 b=R6XgnDngmczvOL8fmw5ZWUqSYbYjWzr2Hrwd0EfFzkVndAPuaR/VU5ToVCK8cvsSKLT8EsQAeiSlL0LLLvYGVyxFqYyt/BfgIiw7p1qbaP85TUlXpGFuyDk0GD2dtkZpuSvAXM3W5hPhHZARJNQ3fSnXZHGf7ixqedCKuzgWaT5HWLY+xDlXB9awq/liHKVEWI1dO7dlZT1GF4D35Yiuks7DMVfSUbDTQxlQDZpk7/nA7+iK7Nc+ezkLMSIT79+bwHqVAcMkwhggLm4gHm6yYXlklxgntZJIL4AuvJ0QeD9/3VTkEms8FWob7Sgr7tNdQ8XnJPa3UeRS5IzBa61z6w==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by PS1PPF2FB011D08.apcprd06.prod.outlook.com (2603:1096:308::248) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 05:39:31 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 05:39:31 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Brian Masney <bmasney@redhat.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, Rom
 Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao
 Zhang <yuxiaozhang@google.com>, "wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>, "dkodihalli@nvidia.com"
	<dkodihalli@nvidia.com>, "spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: RE: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
Thread-Topic: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
Thread-Index: AQHcObcYZfDa5MFRHEuA0bcfdj7WJ7TVoHpQgFi04wCAAmYLEA==
Date: Wed, 24 Dec 2025 05:39:31 +0000
Message-ID:
 <TY2PPF5CB9A1BE61BCB26BC17BE7824D429F2B2A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251010072540.666673-1-ryan_chen@aspeedtech.com>
 <20251010072540.666673-4-ryan_chen@aspeedtech.com>
 <TY2PPF5CB9A1BE64DCD487138F3BAC4FD34F2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <aUl5DPMq8jC1xjRu@redhat.com>
In-Reply-To: <aUl5DPMq8jC1xjRu@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|PS1PPF2FB011D08:EE_
x-ms-office365-filtering-correlation-id: f39ed406-b9db-4ea4-6566-08de42aecff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b+zv4mny1XOSFS4buab/CGIj7UTRskbmLl5N7HnInB/nOaKGb5api1z443pE?=
 =?us-ascii?Q?QXyjdejOKbPDAcVt3lOqWmYOVYr4ZapwP5X6MmcS7ZjVBTZd7SnmjHN6OgHr?=
 =?us-ascii?Q?I4Nh+mV8/8CTLoHZD3ev+oQgtvU4c0mZyxahU5kzBK0v89xFq+H93Tiiq5TY?=
 =?us-ascii?Q?6TJPvNMjZry4DShzYkOZHxfpkb1xF4QLvNfKDs8YcJEylPgacXoLUDlt0fHP?=
 =?us-ascii?Q?zSSqRD1q/LiSxpoOV5Na0dxKVgV/GCQBn+oixby/Fibc9HcXLFkLtFxvVOLZ?=
 =?us-ascii?Q?pRRU+1O2w7Q73Ou/RiieP4pPwHeDJrd5GW9u2sCLPpTqzNJIh3mmURYB532+?=
 =?us-ascii?Q?NmLarDZDPQZ+WMdlebsCyLdlRFIYeZlOEeVScLAMaNvZ1pzWC4YpHGWxCUg5?=
 =?us-ascii?Q?STjY6LZFeHkbPVUmvioKKZ4SsovLTtRF49vAQQsm8WQa9rz++e2ZN4RM8fXN?=
 =?us-ascii?Q?S7UfgZTnsfuhJtOiu171JZ7zy51/C8eTlu5iv1ZBUgrO/yAINWK/Ja+BNFG/?=
 =?us-ascii?Q?bsK4mtDshxfZYZnRuu/25VSugxPTI7Th8/GvX8VuD/0ZIqaL1iYFSmUy5Eiq?=
 =?us-ascii?Q?wVDiaHi/xLbYF70GM1GK6BHeov+cmY70ERMEILrJQLwmyExdIArxWHeJhIA1?=
 =?us-ascii?Q?keCj0G8j7Th2qdmFgAxsAU3ZoOiusSF6TdCR43vzOqXuWc1nXUsR7C+8xNFU?=
 =?us-ascii?Q?GzdYgwvHz3JbKrZg+EtvwV+MGevSKEFfXmkzKsBT9J8YFXLsI6kGraOR2M+s?=
 =?us-ascii?Q?SQ074swCCXzyq2szPwF1AcK7KM5uxD5wXGjyYcyl66NTNm1EcArF8HGd7cuk?=
 =?us-ascii?Q?HuBAMy1bSNZiwrQQ9r6E2HTVsqdJBG4hkLwcyEJ5x3sexuChVYTIeoIISZTW?=
 =?us-ascii?Q?KKZTwTQrEsrbiKcDak9d/D9/E0KvkCpLANHotCdFTaXd66A/A7FufNtnR1BG?=
 =?us-ascii?Q?KkGo0vzhgCCj5/aP2Dank0jThVq4WUkgLhz7r7y3d7X8L7IKXBV8x6LHzOGc?=
 =?us-ascii?Q?+lLa6rv3UOdlHkUk66VqwpqNGNy9J6HfNxixXtdodnXXjxoeQeYbqxkrzay0?=
 =?us-ascii?Q?Uw4U1lT8LuzTbZtwAeez8ttFEtMa4NDoqxzmC7KYFCJx5CG9rQ25N6vLojQy?=
 =?us-ascii?Q?pACG0CQGX9exs02e2TZWbOHoDJdc9gf/M0Pl5iqRrxxUEHjLP7bqJ/b/plmO?=
 =?us-ascii?Q?ETAjjhodpw+0Pggms0FsOmjx4KgU6eDIQ2beGP6AxCA5exiUO4JKvuydPjSz?=
 =?us-ascii?Q?PtvlqOohkmkBhFIGmGP8N4L9q6v4PsWDH+aZVUS1XfogPH+OXxFfY3J1adsz?=
 =?us-ascii?Q?ckeTIA4QOgvg2VKQ9lE7OJpK2/vuv79oFUGGIFdrr11DsdF2l3TG3ll4D4u9?=
 =?us-ascii?Q?qWehco3Jqlee06B97JvKkuoZvIJQB4BWf9TMhtchOFXzc80mNiB9F9oPtin1?=
 =?us-ascii?Q?RSxHKuDbt1tURaeY1HmwvMKt6uME+HpWlhMgfwEvqcdbGIwz/9vkiBaWGuBm?=
 =?us-ascii?Q?SZrmuKh0ku6U64hHwUfrmPs7yqAm0qyNdCGB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?esYyHI6TiED12PT09M6ec0dNUZdUmHApI7Rq/ijtz8HPBXZzSxKEcXIsgX4l?=
 =?us-ascii?Q?LDsGABwpfppOpNbsdoNlsaXeSvMzscewsxiacbK2fWdDmkLh9K/O+8/HH2KT?=
 =?us-ascii?Q?a/ruVdHHzr4PiPO2hR6Cg+7G7zPseutfk8YwMuFW09b+3jmRw0bFUNQBcE7G?=
 =?us-ascii?Q?X+HKhJ/9cerA6SRZF1J0Mm53fn7zEK+q8zA0iFrjbLBQI5I+u0qYtyr5DH9i?=
 =?us-ascii?Q?xY9jXnFMsYyTQLSX0ntA/v8jyrD5BsS5ydPXykue3l8OQWFJVr+qi63RZ2gY?=
 =?us-ascii?Q?i7kKZLn36OXFOMzVrS0suksV4zuHSJoU6bpqjsYkUr3Kd3oAT+hOqITIB/KD?=
 =?us-ascii?Q?5WanYG1aLm2dfVXmiQpyFodvEjAGLYsJvYpx+YfnumXoTmE8m8MM7oWOZWHL?=
 =?us-ascii?Q?To3/bRDden9g4bCWRZpOh90AXvoKrQKNh1F0suOSCGiz6pctxhDHb7SGq9nO?=
 =?us-ascii?Q?27/rUlLq0A9tg+EsIPcx7V0MBNvRkAxWh0kpgpAKunhZNGZd6FmfrMEj8S7y?=
 =?us-ascii?Q?f0XrFES2wdPAx3SfaSYMyoohflp4SefegENc2mOX/r4eFyPxQYe9hhiOUUZW?=
 =?us-ascii?Q?RrOzpAUg8fH1kRAeCSF5OA18avKfpwP5b/ifRbdifi9pNzi4ihLs3QGaxufU?=
 =?us-ascii?Q?E4B7aiKjeCLmWZybkcvyVbHgYPgCpyULN8xwJgDHhVfwDTbU4xWhLZTxfwT/?=
 =?us-ascii?Q?84HsGd8ei2jMgKOPEVvIyb2CeW2fvQLmh2/oci7R6PQ45K3NprHr/w4vFhC9?=
 =?us-ascii?Q?JxqjFg5YfePpeqd0m3AMibaOFydftO3rxxYqVtfNT3C/MqRrDqAwbPvKyUYv?=
 =?us-ascii?Q?0J/ZXQ+WDTyVBSlBT/sSKChukxrJgoMbNdRM0xyuDB3Fp9J34FoYa4A/zVVE?=
 =?us-ascii?Q?zrj6TUNPpCjDx9YENSD+qCFIiMKWmZCmLlPjS6Wy62ERmArq3qBLw9yKtHgi?=
 =?us-ascii?Q?UvZ2zkvMa8LdyGaoIJl54UTR1o3vemmGpaISrUZyTgiTrEcHndNhmj4UxITW?=
 =?us-ascii?Q?HAr/BCn6wTLCo9/O84tFXhaTAKB3DmpzmtEEhUgw2BeZB/11eHvA32cOVOFH?=
 =?us-ascii?Q?vEonrD8mXYZlCRX+pwxo4uqByWJY0SB1m4/Qd22PdcUKgUzsqG4hN2WBeBDk?=
 =?us-ascii?Q?g0AhSm2CryH9zEWUB5fHc/X+ZiSfyT8862sIsIzUuzSCB6aEF90CbzkqDLw1?=
 =?us-ascii?Q?eu5UfHokyFFvEn0a4MZSH3YzO8mdxn7+XI66vfIgue2Dog1UNQh35pnxT2TU?=
 =?us-ascii?Q?Lb1T0CVIGEeRQ6O8lBEPkzuk0lVtEkx5FJ2G3vH66VNsOHEYfTzVonmEJJgg?=
 =?us-ascii?Q?7J5JuzIFMRM75cIS/vdLpzHE0xpMxtII19G55PQxaG0TY/hgFywQm/g2ytFj?=
 =?us-ascii?Q?rMe/x3KUGDla8m8ekw7xIIL+uJdsP0A/2MDIvwok+QmON+/Zf7+2F3qfuxSP?=
 =?us-ascii?Q?PU6UcEYpAfeHbXcojjiXGJfg7Dsb0ef08gFYE9Gj5bGMMgJ9Fxm7ZoMA2Jq3?=
 =?us-ascii?Q?v7sMriWUt4DRsNBc/7fnkdH7p465WATKSVF2W71vWKUWfv/M3Wqo+uTNAa7f?=
 =?us-ascii?Q?EZ3zYm4gYpCgdOFrMGx9j1JFXLvWC76uG7flrhz77SG7W6+yvatNOJmsuUsj?=
 =?us-ascii?Q?wiinHcGX+AlyRvy1LyCRW6sckQ6uMF5zZXhzn3r0plZ1b3CMJdUlGo+6DvL+?=
 =?us-ascii?Q?bKfwC362psX3c+gMTZ9vV+oVUoY99fUJJoH7WvtGFwB30OX9yD/esG7PoC+v?=
 =?us-ascii?Q?xwsbJmvMLQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39ed406-b9db-4ea4-6566-08de42aecff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 05:39:31.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRMb1UOahMwoF8w3OkHzXpxNjiGjnHztbuXTlWgbkoZg0wrb7K1bC5Q8HG9xRjZ/o6Xc4c8w+WJhzCf5avvOuI/twKbsoVqv7c3nQQsOJTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2FB011D08

> Subject: Re: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
>=20
> Hi Ryan,
>=20
> On Mon, Oct 27, 2025 at 06:24:59AM +0000, Ryan Chen wrote:
> > Hello Stephen,
> > 	Will this be accepted in clk-next?
>=20
> Given that aspeed is a SoC vendor, and you already have multiple clk driv=
ers, I
> think at this point your best bet is to do what the other SoC vendors cur=
rently
> do. I think you should:
>=20
> - Create a new subdirectory drivers/clk/aspeed/
> - Move the existing aspeed clk drivers into this subdirectory, and
>   update the Makefiles / Kconfigs as appropriate.
> - Add a new entry to the MAINTAINERS file for the aspeed clk drivers.
>   You probably also want to have that entry cover the reset driver,
>   and any other aspeed-specific drivers as well.
> - Post that patch set. Include this new clk driver as a separate patch
>   in that series. Feel free to CC me to the series and I'll review it
>   for you.
> - After it's reviewed, wait a week or two, and send Stephen a
>   'GIT PULL' using git request-pull. I can help you with the workflow
>   if needed.
>=20
>   One important detail is that you want to base your branch for the GIT
>   PULL on the lowest common denominator, which is usually the latest rc1
>   from Linus. So even if Linus is at rc5, try to base yours on rc1, unles=
s
>   there's some issue, and you need to document why. Stephen should get th=
e
>   merge to newer rcX branches from Linus, and not you.
>=20
> When you send a PULL to Stephen, you can use 'b4 am' to assemble the
> contents of your branch. When I sent him a PULL a few months ago, I inclu=
ded
> the b4 commands that I used.
>=20
> https://lore.kernel.org/all/aL8MXYrR5uoBa4cB@x1/
>=20
> If he accepts the pull, you'll still need to post your patches to the clk=
 mailinglist,
> and have them reviewed on list. Folks from aspeed should do that review
> publicly on the list.
>=20
Hello Brian,
	Thanks a lot for your guidance. I send out v16 next.
Ryan


