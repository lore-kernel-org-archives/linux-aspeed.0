Return-Path: <linux-aspeed+bounces-5220-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A965CC6B2A
	for <linux-aspeed@archiver.kernel.org>; Sat, 17 Oct 2026 07:08:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6CZn1x2xz2y2J;
	Sat, 17 Oct 2026 18:08:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70b" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792220913;
	cv=pass; b=iOyh8k7r62EtVyxm8LyaL29oNaexR7bmKorqUDCyvKF3xdRFMC1trXMoL/eovS9dWkxa0a8N4jYNcFhRJcrpoeaZ8IWAofWoBjLzRiziEK9kNzDzIDxlgm70CglZLfrwHtOdBYozYTblcXx+EFEuXOceiiky2eaZEa87ncG747shenBCzhCM8k8N0tGQd83bbuORiXwDEBhw9q3E5hHkiqk0HPIKtTWTqx4Jo72bQ+zylv0ET2pEELhHcGY+XP3PW3njtfkMTY0Obgkasyj82a/gsn+OkPJ0UaTBR3KX1t4dGL3mnF0iMeH/eSxuoATLDZ/AgCvd6irq669kGtrtaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792220913; c=relaxed/relaxed;
	bh=P9fvpEDXxRo4joGgx4s5iXFjBycG9jJi06nMAvOqQPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O2MsYN1eQ+4VSXq6uIB8qkAqAkfuoRjD9BbieNzojTbSnjWqIvwPb4MKOQZB8kpYog8DugU55HnYWLSHSTMPS8X7BJTZIr/tS9gGtIeMJ9LrfD57FsHfgcLvokyZioWELlwgBSf/vfPRuGF3dyiKGGxJVmY0SDEUVkP51h3Pj/bEcXiRAEMLjcPkD87X7flk2SJ/k8qmZCuWE7dS64YJaKhyZnemn+vSwoT/Z7AtHC2Id5INxVx4xQq8K4tbvNuUiiY9q6yFwp38Q0elsH4cnj06fCj7HjNBq9By7xX2D4QwDmC/L9yiIw1WdXtZogpEhZNWeMsFcKGY4yiwOr4RVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70b; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70b; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6CZl5XXrz2xqr;
	Sat, 17 Oct 2026 18:08:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw4gT+xw66Sp+rS2wr03QLc0hX58v+3NlKhjJYbDO8brDCm5uIiRUCKn1C9E376iBw+hYwehroB+r4FTzdYm3O9HexFqzyebSt8Un2ddir1uSwJ39PzZ0kDhMDiNQJJTOO5t3qaHzjtuonciLB9FmBauG8UDk2tcw5kKra+jaoe+nog4nvoHeMbfyiVxJnm230G6EK8pNo8vvpXgbFdziGeBPnTLcgzPx8U/elfLuOyNdVj533t4GO8+WxMjbzNjkCDhtMEzN/nump1zwZUTH3SNlJz/o+dfkG4T8QfbbCPmPa44FIEeybC0bpXyTk4e533jzvjVR/wwf02ax7Twpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9fvpEDXxRo4joGgx4s5iXFjBycG9jJi06nMAvOqQPE=;
 b=k2WotCrsHT1X94X3vZ0I1tflassA2LiIAxX2MquIgGFm7z77/Z2HAySnZ16vTlF4Zr1aKhi3r4Vr3dGdjd5SqURKCrQ8uMOScoKkUdfztT6qpzRIz8GjBP81d7pq08qjbAUyXT0in8Z/9tUHyKBuy8HOOrxCkLF8FOAAjm+zXRJLbKZysE8UJFX2irYDkgkOr7/zS6BkT2CnRC7tzuL3l85LhWWP46JD+v2hJebXYTwgGHv0ZddZ49hy6J8pc4TTZdfreZyJqSEgGgPyevhjSO0UTV4AgqJxU7jUWvtWsNYpGsL4OscBh2kGvJb8r3llMlqXBJxwXWXfyuLcMdAJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1156.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 07:07:50 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.016; Sat, 17 Oct 2026 07:07:50 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Breno Leitao <leitao@debian.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Oskar Senft <osk@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Jani Nikula <jani.nikula@intel.com>, Vitaly
 Lubart <lubvital@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Andrew Morton
	<akpm@linux-foundation.org>, Alexander Usyskin <alexander.usyskin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Philipp Zabel <p.zabel@pengutronix.de>, James
 Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>, Stephen
 Hemminger <stephen@networkplumber.org>, Dave Penkler <dpenkler@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Dan
 Williams <djbw@kernel.org>, Mukesh Rathor <mrathor@linux.microsoft.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Alexandra Winter
	<wintera@linux.ibm.com>, Julian Braha <julianbraha@gmail.com>, Karthikeyan KS
	<karthiproffesional@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/4] uart-routing: Add common UART routing framework
Thread-Topic: [PATCH v2 1/4] uart-routing: Add common UART routing framework
Thread-Index: AQHdPSFocjktLUPKVk6wGx4cu9RnpLb+m6cAgAL2hSA=
Date: Sat, 17 Oct 2026 07:07:50 +0000
Message-ID:
 <ZQ4PR01MB12025942CE5D2F83D82BD1BCF29A2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
 <20260905102901.126035-2-changhuang.liang@starfivetech.com>
 <atCibvmbCSTMTMYD@gmail.com>
In-Reply-To: <atCibvmbCSTMTMYD@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1156:EE_
x-ms-office365-filtering-correlation-id: a036de3e-805d-45b2-1520-08df2c1d5b06
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 utRJekgtv75KZ6hbikRcPwP3g3AMvj/lP6rydsEhUkVBc7wo8Ka/DkxMvfD4jzcmFve9UZVHly3MDAwLLiQwI+LbA2cGyH7g0mDIreIUDqbP/gSITjtL6LLhauo4NVjBhOnW7w0O4fCDGEvBJxNyQ3G1g7zVDrSgTztXkX7ryN79X7V/dSmOQmnXvlx2iN8QL0JZ1ve3Ponpi3+UodJbk/r80zimh7CrJ7GoR3QeWwFqDaZD5hJqq7ecpY6Z3lRypM5DECNg6y+EsZ5patGbSfxO8yxLOpWfzQe5vyO39loz/bgJcAm+VEsMZGD742kDdxO4Pl/inbMj6xkEdag0xKVTvOXZ8hC1H8QGokolKQd4Sj/yBQRjN2doLjkYy4sti7MhsOmoWlDQXfJGrpKzKs7r3PJZjSdHxYo8YKu0UNLhGFaik0b60R34wWeXfSkgIUBL/JObeh9OffZc1w6tOXQqcrywFqynscQe+KdPmppITWurM4YH8PUy1g0GEX1zsMHSnoIJJ1PhYdvHsKiu2hN6klvyMrKDQYO7mS+3WKyuwexva55zbpcJ5vG+7x3A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O2wuCtjpR4/HkokmUVsZ6yzWuRW4oc/VqfJbhtJsQ8j0xB2nj1KFxuWfdcNW?=
 =?us-ascii?Q?v2bpEHhq6q3fXgQmbEqqbpC7JJuqNqRUks/c24jQ/o9Iqyj3bBZjlWHLlDyH?=
 =?us-ascii?Q?i10g/V11rGedpZq3CWQv/+qRHFiQvkuCr1gyjg6xBNIaarRLniZb5hPRdC9s?=
 =?us-ascii?Q?f9SykGzmcq/6NgUTPTNHeH0Dhs1052IhqQyHIz88uPnQfQh4LIO0qblI7f9a?=
 =?us-ascii?Q?x2mehoOAjo2OhlxwL8lIwb9KgGWSGP0m6QTHB39KdeL4yq1mQvbHHLwWyEnS?=
 =?us-ascii?Q?uHgrvvmQR2Nt6zdxdHBrrHGEGpr5mmTcHGfNoHygK2zAHpnwPd64cR7XsQ89?=
 =?us-ascii?Q?kprwmCaGViCGxGLFGUf4Qx/Uvs3UBKPGwyvXAxKAjmbY7aE8zaUyvbJzN+cM?=
 =?us-ascii?Q?GwMslLjZgKRqWR/G1+soDVe6JIAuoudpiBDTlisQCM/3xXpDZsmUrs6+BuUM?=
 =?us-ascii?Q?5WSvof+X+ypZRjvATwfcFiwLyZqeU0CYMPXJaYOHpZq/PVEcQilyjFTGLKVu?=
 =?us-ascii?Q?oNHYdVBhU+zo+LXb5VIutnnXnSw9fZ3FRDKIRkNmkgo9XvTLy/oW/Pvc+zyZ?=
 =?us-ascii?Q?A4Hr3OAF5j29Fkc3+ESUc2hzzEekYMVNjt68NW4liRPoux4X4JJiSaqNjLZm?=
 =?us-ascii?Q?fAeSH11WhK3+ur9Y6FhRKl5+st0yiPU8iVAl3qdgKmvWiUXUYkW9zA7HKQ5t?=
 =?us-ascii?Q?NdUGlDh5B8oEWyVeGxN2lw4Rr9V1W1rVKO7K6Za7BElmBHwRAKwSn8zCu1Dc?=
 =?us-ascii?Q?hqmS0nj1mQbTPOZGKZTstDDpNGfElN/9u1bIWu81iA0zkGei2PYqCgZILT/4?=
 =?us-ascii?Q?yiG6M+Y9P+bD/YwjPCWmBPRyc76VuKQFp5wAUf+UVUb0BltgDD3w1dfAggcF?=
 =?us-ascii?Q?x+cro2jppSSmt4q8V+mON7zmq7ES17IP6JroYVfEB5xZRZar00fBiiHAcnej?=
 =?us-ascii?Q?e1OnxxAtPSP0kVkmBJLs6Pu4TuREBcsYoUbiJF1r+aRmngAQKEQZJbpqH4i9?=
 =?us-ascii?Q?cDdMqh6LsVL9qBBQ+HcZZvBiz0qg1ezgMl0tGTIz+ln0U57+hmpKrEDmSJIt?=
 =?us-ascii?Q?qB0wQucupfKojesWQuQj+xzgNDrLaJTvX1DC9V2E2OdirgYxILzu0N3KhIT9?=
 =?us-ascii?Q?X9wxLWX/NLs7i5WCogTK6QiC2cNk7i1iYu9WReuxQOidljR3e+ldHaxQF08C?=
 =?us-ascii?Q?x1XJWuwUg148vicfiSfAAZJkt6xJNPmN5v8Jt7Hi/Y123qLIbR6cG7+Z2gzd?=
 =?us-ascii?Q?ajfievEw7HTBqogLrNhUcDC44BUIl4xeq0kLZdMuwTMHZiYycJEFE1CzsQPG?=
 =?us-ascii?Q?u29W6XfnmWEw9R1OLYwTK0deHdp58faUCxIiHgq5R8kO8DHM0QgGvCPR4hEH?=
 =?us-ascii?Q?ebJrfM2poA0IvYyeQQYtTVWwJ7WQp2OqgSuAeWTbERKxfItp2OADTh+rbTUH?=
 =?us-ascii?Q?HQzDn74dO2EIZas3TVj8EB6zqGQh6WBTBfgYJbomcF95/Fx1C3RtsaWMLpIP?=
 =?us-ascii?Q?9OszPwXxGW4r2QuC1PNcccYBlbRK/MqUKNYyh/NRik0eBOYacEKlWpleyKjZ?=
 =?us-ascii?Q?kDyIx7gOEUfrkdJ1EC4SiJQtWfn/QXEeMNLHjqmV4ejZ4ro21VU0JSD4ueRg?=
 =?us-ascii?Q?dNkkhaDjAzhODiW9+evyAj+F3kXCVeiPqihQxPnCtORuRXVUOmBpAxPv05iN?=
 =?us-ascii?Q?WB2/PiqCoGY1kbI2xXCB1hUrjZmaLSp0EYBNujl/+NAXaUkD9ZHi88JEZNE9?=
 =?us-ascii?Q?QtqEYaWJEyi4MHkHwxLX55BOJWZe4c0=3D?=
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
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a036de3e-805d-45b2-1520-08df2c1d5b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 07:07:50.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ohhki4sPohoPiX7ARVEE5zvNCg5zHqO2isikhZ4PNd7rbBa1RvxOarTsaVH+bDJaoxu9HTyTUJhKHnz6d1dLges4gOJB02F1xIY85FdVIl669IyheX6t9gn7LhaVJmgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1156

Hi, Breno

> On Sat, Sep 05, 2026 at 03:28:58AM -0700, Changhuang Liang wrote:
> > +ssize_t uart_routing_show(struct device *dev, struct device_attribute =
*attr,
> > +                       char *buf)
> > +{
> > +     const struct uart_routing_selector *sel =3D
> to_uart_routing_selector(attr);
> > +     struct uart_routing *routing =3D uart_routing_from_dev(dev);
> > +     unsigned int val, pos;
> > +     int len, ret;
> > +
> > +     ret =3D regmap_read(routing->regmap, sel->reg, &val);
>=20
> It seems routing can be NULL here if the file is read while the device is=
 being
> unbound, and uart_routing_store() has the same problem.
>=20
> I hit this while testing v2 on arm64 (next-20261008 with KASAN), and the
> code is unchanged in v3.
>=20
>         d=3D/sys/bus/platform/devices/$DEV
>         drv=3D/sys/bus/platform/drivers/aspeed-uart-routing
>         while :; do cat $d/uart1; done >/dev/null 2>&1 &
>         while :; do echo $DEV > $drv/unbind; echo $DEV > $drv/bind; done
>=20
> and then got:
>=20
>     KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
>     Internal error: Oops: 0000000096000006 [#1]  SMP
>     pc : uart_routing_show+0x64/0x288 [uart_routing]
>     Call trace:
>      uart_routing_show+0x64/0x288 [uart_routing] (P)
>      dev_attr_show+0x64/0xc0
>      sysfs_kf_seq_show+0x21c/0x380
>      kernfs_seq_show+0x138/0x1c8
>      seq_read_iter+0x358/0xa30
>      kernfs_fop_read_iter+0x438/0x500
>      vfs_read+0x484/0x6f0

Thank you for pointing out the issue. I will reproduce and fix it.

Best Regards,
Changhuang

