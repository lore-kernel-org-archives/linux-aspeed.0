Return-Path: <linux-aspeed+bounces-4615-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447EC55184
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 00:42:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFBTF6pSxz2xnp;
	Wed, 05 Aug 2026 10:42:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785890561;
	cv=none; b=aSQ92pn1f2g0IwC664fuIhoqYMP644EwLMXDFLHWIEMCXglMIlnxFhhLlmSkt5VlvkiIAtcKLn7ynK1cUcEWt37lCjFhDLn2Mmr6gaZ04wHHsHJ2ynsgFn/ZF0AVS1syHipWjjwTiHQbJb4mi21SJ0eIArlAnBxjKCgXuQbV3w3zoQ9fensGHKLONuhqSfcePkAR3O3G7OEajSOWX+q45UY81gdKTJDC2jfmU2PAbO2pdK8mfQI36qhfGLu7V8wtJQfkbzSg3jL8/iE8AzqaOI+gp7kPloQwRhCHC2wFDxg/3BWvlbCcsKpOQImk82hEfWU6fx4ZNL4UP2QVCD1wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785890561; c=relaxed/relaxed;
	bh=oF+pMqKRVfoHbj0aKmhSJyXoon4yiMyJ+CZtPLw2efU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9R3efs5w+fqCHYNCuJ08NfZgwYkiYLdPJhxxPoSGS6MEqRLbKyZoiMTZ7acWQoGmQExEWv1/2CtMlxQ+OkBpeSSO8u76t21yduiXC9DJz+s0bqe0OlYWTls/6rKU8tPbysK4mzWnqVLSe2FiSN3T4q0RwIURGz0DJsAWW/S+Kwp/XMplOqNe5kqDl3MOzQvT2y6UKL4J6Ap7sBEaEfK/AEGBarEXH/Uc8UZSriOVJ8C3LOTCNShwHWAW7nvG+SLQXdk63oZeAY4vSI9/by6AgVD8/CvZhOtlQS2A+eiRCWRkS2J9eNCK1Ewccu8euaietncSUDgn8shMlyGrJ14DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c51MoOa0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c51MoOa0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFBTC6Rbpz2xYg;
	Wed, 05 Aug 2026 10:42:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785890557;
	bh=oF+pMqKRVfoHbj0aKmhSJyXoon4yiMyJ+CZtPLw2efU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c51MoOa0qnaW3TduSdx06EE6rJuShhuxXVETYm2f1U2ukoI0+XhZOrLuGUJ8nphU3
	 97nskKjuXTQHfWVza+H5DxU68zAYrb+h5sRgO5vYvhIfDCguZV3bM3EDAnsa7AmzZw
	 mck/Me0g6012NuTdXFokiaJWE/3vwGMLaMRuODe9MNIJisqZzoxFCGd9Q32IYr7vJy
	 jzjBHZq5lZyRyKTJFNFemv2H1nopyQjavdGlsiKfXOVbB7GKx6eRt4d80VeUn+HxuM
	 7QRJQ1NvLnsm24lO1B71uU+7UXX/a8EOJ+qTUVWqEr6Gvgcz0B/+N5csdmLqtIjU2a
	 l6lhOZ6hkoLLg==
Received: from [192.168.68.117] (unknown [180.150.113.112])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DAD4166B55;
	Wed,  5 Aug 2026 08:42:35 +0800 (AWST)
Message-ID: <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Greg KH <gregkh@linuxfoundation.org>, Krishnamoorthi M
	 <krishnamoorthi.m@amd.com>, aspeedyh <yh_chung@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, 	akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, 	chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, 	skhan@linuxfoundation.org,
 linux-aspeed@lists.ozlabs.org, 	openbmc@lists.ozlabs.org
Date: Wed, 05 Aug 2026 10:12:34 +0930
In-Reply-To: <2026080416-lagoon-delirium-8e84@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
	 <2026080416-lagoon-delirium-8e84@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Greg, Krishnamoorthi,

YH Chung has been working on eSPI support for ASPEED's BMC SoCs, so
I've included them in the To line.

On Tue, 2026-08-04 at 14:18 +0200, Greg KH wrote:
> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> > Feedback Requested
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > =C2=A0 1. We chose a dedicated bus_type for the reasons described above
> > =C2=A0=C2=A0=C2=A0=C2=A0 (capability negotiation, four independent chan=
nels, asynchronous
> > =C2=A0=C2=A0=C2=A0=C2=A0 ALERT#). Does the community agree this is the =
right direction, or
> > =C2=A0=C2=A0=C2=A0=C2=A0 is there a strong preference to extend the SPI=
 subsystem instead?
>=20
> That's up to the SPI maintainers and developers...

There's concurrent discussion from YH regarding device-side eSPI
support in the thread ending here:

https://lore.kernel.org/all/KL1PR0601MB4276FA2C6347192CC45826E490ED2@KL1PR0=
601MB4276.apcprd06.prod.outlook.com/

So far it's arrived at a matching proposal for drivers/espi.

>=20
> > =C2=A0 3. Any concerns with the ops table design or the -EOPNOTSUPP fal=
lback?
> > =C2=A0 4. Naming and structure of the public API in include/linux/espi/=
espi.h.
>=20
> What specifically are you asking for for this?=C2=A0 Do you have userspac=
e
> code you want to integrate, if so, does it work with this?=C2=A0 And wher=
e
> does it live?

I've seen your follow-up realisation Greg, however, regarding
userspace, the thread above suggests that we should be able to back
existing subsystems (GPIO for VW, MCTP for OOB, MTD for some flash
functionality) onto eSPI to minimise eSPI-specific interfaces:

https://lore.kernel.org/all/KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0=
601MB4276.apcprd06.prod.outlook.com/

That doesn't cover the peripheral channel, as that's dealt with in
hardware on the device side, but for the purpose of the controller the
devices on the peripheral channel should all be driven by the kernel
anyway.

Andrew

