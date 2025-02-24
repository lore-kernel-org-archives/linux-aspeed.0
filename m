Return-Path: <linux-aspeed+bounces-815-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236A9C021B3
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 09:32:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1bBD5Njjz3011;
	Mon, 24 Feb 2025 20:32:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740389572;
	cv=none; b=LQbasrrjIaaFSHi3e05R4ECbxVi9BK2sYkb2GnJHvbMxVuoEqEMOD6aFoaOFQltLaHBLSU1tvRavM28VqZFwx8mxKq8j2g4qI+RaUGAP9DN0/XQ91NFL54pRcLIU8SUjraE4wiRmn1sydepbc0F5cyG1sf0gaQn8413/f/8yn6QwheWl1exMIzXCTYm33xeZ/TwqeDmUEvAeZ8oUKn4xf0tmtSHgz8jrDsqAXZCVWhcwxam/WCaVmvd8gVPGuePsGJKYe5t0yktvHavlphsYjqklIIoO8G/HUekmxPX7Q+ruh3hPs9/BwlN30czg+p4msobM8aEMX2U0Bk0HQZhmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740389572; c=relaxed/relaxed;
	bh=MWFLyE+zepQ0gwE9Kxqdao03pl2+fyemSDhVBXoCKgk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMjoU5s3biGtMh+vkYXdjjIiGoByy8li5QOPWawxOiD93wAX3p86X++OV+Aw+z+FnvmP7qTC/dM1XrB+LJEGEYHtgSMdBUoCG/ebqTPgNFyBZxHWR/JZOBivJAUIXfWpS7GHhLzkxRrzFFg2lsZ6Dn80DwYDWWNdaDTMdO2p2wHsOI2CyePc5+t4ZMWg029o8i2pAmcaWJddFsBnB1J9+6F2QGCnOihzjSJlCgHLIFdwiADCGGiLuYOto5i2Li08O7VkB/wJ2U6Bz5VJZTDosekZBW5uaaN4IG52+Jke1JSsT0QprjjvRPl+zQ0LTr3v1YrSqV+Dg1mcDhLeurN+9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1bBD1Vl7z301N
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Feb 2025 20:32:52 +1100 (AEDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmUpA-0002iD-0i; Mon, 24 Feb 2025 10:32:28 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmUp9-002ZLh-14;
	Mon, 24 Feb 2025 10:32:27 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmUp9-0003W5-0p;
	Mon, 24 Feb 2025 10:32:27 +0100
Message-ID: <db8dad75c03d747d16cdc67ebbedd5c2f8c27a6d.camel@pengutronix.de>
Subject: Re: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, "benh@kernel.crashing.org"
	 <benh@kernel.crashing.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andi.shyti@kernel.org"
	 <andi.shyti@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org"
	 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"andrew@codeconstruct.com.au"
	 <andrew@codeconstruct.com.au>, "andriy.shevchenko@linux.intel.com"
	 <andriy.shevchenko@linux.intel.com>, "linux-i2c@vger.kernel.org"
	 <linux-i2c@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Mon, 24 Feb 2025 10:32:27 +0100
In-Reply-To: <OS8PR06MB75413DA9AF08F23506FA6DDBF2C02@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224055936.1804279-1-ryan_chen@aspeedtech.com>
	 <20250224055936.1804279-3-ryan_chen@aspeedtech.com>
	 <ee0f5b583aadb42e7557e1afc49c5b9af594d2c3.camel@pengutronix.de>
	 <OS8PR06MB75413DA9AF08F23506FA6DDBF2C02@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-aspeed@lists.ozlabs.org

On Mo, 2025-02-24 at 09:04 +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new
> > register
> > mode driver
> >=20
> > On Mo, 2025-02-24 at 13:59 +0800, Ryan Chen wrote:
> > > Add i2c new register mode driver to support AST2600 i2c new
> > > register
> > > mode. AST2600 i2c controller have legacy and new register mode.
> > > The
> > > new register mode have global register support 4 base clock for
> > > scl
> > > clock selection, and new clock divider mode. The new register
> > > mode
> > > have separate register set to control i2c controller and target.
> > > This
> > > patch is for i2c controller mode driver.
> > >=20
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > > =C2=A0drivers/i2c/busses/Kconfig       |   11 +
> > > =C2=A0drivers/i2c/busses/Makefile      |    1 +
> > > =C2=A0drivers/i2c/busses/i2c-ast2600.c | 1036
> > > ++++++++++++++++++++++++++++++
> > > =C2=A03 files changed, 1048 insertions(+)
> > > =C2=A0create mode 100644 drivers/i2c/busses/i2c-ast2600.c
> > >=20
> > [...]
> > > diff --git a/drivers/i2c/busses/i2c-ast2600.c
> > > b/drivers/i2c/busses/i2c-ast2600.c
> > > new file mode 100644
> > > index 000000000000..bfac507693dd
> > > --- /dev/null
> > > +++ b/drivers/i2c/busses/i2c-ast2600.c
> > > @@ -0,0 +1,1036 @@
> > [...]
> > > +static int ast2600_i2c_probe(struct platform_device *pdev) {
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct ast2600_i2c_bus *i2c_bus;
> > > +	struct resource *res;
> > > +	u32 global_ctrl;
> > > +	int ret;
> > > +
> > > +	i2c_bus =3D devm_kzalloc(dev, sizeof(*i2c_bus),
> > > GFP_KERNEL);
> > > +	if (!i2c_bus)
> > > +		return -ENOMEM;
> > > +
> > > +	i2c_bus->reg_base =3D devm_platform_ioremap_resource(pdev,
> > > 0);
> > > +	if (IS_ERR(i2c_bus->reg_base))
> > > +		return PTR_ERR(i2c_bus->reg_base);
> > > +
> > > +	i2c_bus->rst =3D devm_reset_control_get_shared(dev, NULL);
> > > +	if (IS_ERR(i2c_bus->rst))
> > > +		return dev_err_probe(dev, PTR_ERR(i2c_bus->rst),
> > > "Missing reset
> > > +ctrl\n");
> > > +
> > > +	reset_control_deassert(i2c_bus->rst);
> >=20
> > No reset_control_assert() in the error paths below? You could get
> > that and
> > simplify this by using devm_reset_control_get_shared_deasserted().
> >=20
> Sorry, devm_reset_control_get_shared_deasserted is new for me.
> Do you mean modify by following=20
>=20
> i2c_bus->rst =3D devm_reset_control_get_shared_deasserted(dev, NULL);
> if (IS_ERR(i2c_bus->rst))
> =C2=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(dev, PTR_ERR(i2c_bus->rst), =
"Missing reset
> ctrl\n");
>=20
> - reset_control_deassert(i2c_bus->rst);

Yes see [1]. Remove the reset_control_assert() in ast2600_i2c_remove()
as well.

[1] https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_=
shared_deasserted

regards
Philipp

