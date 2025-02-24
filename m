Return-Path: <linux-aspeed+bounces-823-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71B6C021A4
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 16:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1mPJ3RZqz30MR;
	Tue, 25 Feb 2025 03:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740414484;
	cv=none; b=NKEvDfo+68/rFjz4S9aVanyvwHtNxSghgFBhiZCx+JeTayBVQUKo1npBzwvXMw8QpXC7Trxi4kwcywO8hLcWUIvqbPi9PrvHkWm7om22jrzYBdprlgK0KtJCXNgsVbgRf9EnktGEenSQ2ED+Fq0Pxi086OqoovnD8pG9x6xf3+IahC1/Te0+SeWFu1VxSCW9IapYd/RjPFxIcAfPT+5cek1lX2sRTx66vXKlWZhXT5lM3JJ8TZ72umpbFk/0arT/U/Yi21G6V6WquJ0KJFpxnHIISXek0N/iyO+s9rvhBUkNDmNU8i7/fy07i1nj0rYENId0ODoDeQJxpccNOYOZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740414484; c=relaxed/relaxed;
	bh=ejxJxjGKAAfQRBFmJWKeW9bc62PHTjH8bG/g1795Hcw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqgLPpbmqjtimfa6B6VohOafgsSLqNtQw0zQjtkzuSEjpCSnCIgBqwmTqftdTUEcPoQJyHwrzjwOTvTL0dtuPu05mYwPYSJ99KonMbkmN/c6VIAcAZybX62CvTtq2nLuIR8cJMLDbHrCy2aGkxjTP4WoN8CNPoemO8nVNP22lrJl02ucNlKDe8UzLtr/9ssbl+raQ4qAmByJORNbcHu6TA0QLPTOSUqUTnVECg7Kn7woQ0v6+pgO9KLUIPZUkNNHBssLjKBzzcn/8vaHwJeiMvXUOjJac+V24H6DBf72O4AipuYrqSdSwcWrA68OzXkK5GJjH5g13Ljt7va+OfUydg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1mPH1ltPz305c
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 03:28:01 +1100 (AEDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIv-0005GS-HA; Mon, 24 Feb 2025 17:27:37 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIu-002csr-0G;
	Mon, 24 Feb 2025 17:27:36 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIu-000DzX-00;
	Mon, 24 Feb 2025 17:27:36 +0100
Message-ID: <b00aef9582e223a5770cebc714ad65168eab744b.camel@pengutronix.de>
Subject: Re: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 17:27:35 +0100
In-Reply-To: <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
	 <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
	 <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
	 <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
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

On Mo, 2025-02-24 at 11:15 +0100, Krzysztof Kozlowski wrote:
> On 24/02/2025 11:12, Krzysztof Kozlowski wrote:
> > On 24/02/2025 10:55, Ryan Chen wrote:
> > > +
> > > +static void aspeed_reset_unregister_adev(void *_adev)
> > > +{
> > > +	struct auxiliary_device *adev =3D _adev;
> > > +
> > > +	auxiliary_device_delete(adev);
> > > +	auxiliary_device_uninit(adev);
> > > +}
> > > +
> > > +static void aspeed_reset_adev_release(struct device *dev)
> > > +{
> > > +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > > +
> > > +	kfree(adev);
> > > +}
> > > +
> >=20
> > Every exported function *must* have kerneldoc.
> >=20
> > > +int aspeed_reset_controller_register(struct device *clk_dev, void __=
iomem *base,
> > > +				     const char *adev_name)
> > > +{
> > > +	struct auxiliary_device *adev;
> > > +	int ret;
> > > +
> > > +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > > +	if (!adev)
> > > +		return -ENOMEM;
> > > +
> > > +	adev->name =3D adev_name;
> > > +	adev->dev.parent =3D clk_dev;
> > > +	adev->dev.release =3D aspeed_reset_adev_release;
> > > +	adev->id =3D 666u;
> > > +
> > > +	ret =3D auxiliary_device_init(adev);
> > > +	if (ret) {
> > > +		kfree(adev);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D auxiliary_device_add(adev);
> > > +	if (ret) {
> > > +		auxiliary_device_uninit(adev);
> > > +		return ret;
> > > +	}
> > > +
> > > +	adev->dev.platform_data =3D (__force void *)base;
> > > +
> > > +	return devm_add_action_or_reset(clk_dev, aspeed_reset_unregister_ad=
ev, adev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(aspeed_reset_controller_register);
> >=20
> > No, you cannot export functions without users. There is no single user
> > of this, so this is not justified at all.
> My mistake, I missed patch #3 which uses it.
>=20
> I don't get why do you need to export this in the first place, instead
> of putting it in the clock driver, as usually expected. Handling child
> creation is logically the task of the device having children, the
> parent. Not the child.

Also, consider basing this on top of:

https://lore.kernel.org/all/20250218-aux-device-create-helper-v4-0-c3d7dfde=
a2e6@baylibre.com/

regards
Philipp

