Return-Path: <linux-aspeed+bounces-1147-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F3C36008
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Apr 2025 03:52:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRYwd3G4fz2yS6;
	Tue,  1 Apr 2025 14:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743479537;
	cv=none; b=drBFFCF7sSiTaAy2T9GNQKo+YpYY9NojSL08aZ4OXIq3zq7seNN43xlVyUxQlDes/pvypnXTT/XHlM3BzPuilOqTGjFh1EhWZs2hTIw9VVm9v1QqpjTRn4AOt/Uhjgykq+IWvHTT5CT5+Tx7JqfDXZ+DZdPshndksLPGd4j7clOazUlCbRDoe8JDFPxYnaY5gHQ5S5XU3Frzby8F4OfH2IUVcINBA834Gp4rc2NMdiWVrBD6H/NVFPKSotIeefD4bYkG86iADaYE0zEru2Xrqi+Oc84TPDbPpmmfRiKdwoWxJInkj/u3xvqH4k3GSB+dM7WnoZ5s5F8ytXKqZaTXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743479537; c=relaxed/relaxed;
	bh=MWNPmZie43FsZ2zJ8Q5iKZB2v/V0Po/Z+YO83V2t8Ss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KE4CYQWIb6SlHkkzf1ZckMvI8SisHmYeEgZzckuavt+teDAIbebDg+H0wPgyFQYUY8i+SKRaLcW1gEuGKVp/+d7hSOm5jGKLH3DtVNE2WbIknRl3JfZJBAbhY8PbQUNNe2popY0KUoQFiG2QYF+2Z07G0+1lLOZFk5oj2bMFy51qrFXXY9OR0yH+9Kx38VTniqxD9cgkGsFSEgDRC03RVxC+sWbEgSmwt6C7Q86x/IQmsC2RrglmL263LdwmJ27vWLusu7YIF5bK82/SEBDS8t6DAslATjjWW+NuompXcJteaxQzOI7ihxiMhyZRV4tPS7KfRMLgt4GvZ7S6CLtqDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRYwb2lNbz2xlP
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 14:52:13 +1100 (AEDT)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 5313lvUW010557;
	Mon, 31 Mar 2025 22:47:58 -0500
Message-ID: <bcce62d1bb233edaf39637a60089fcc146c8173f.camel@kernel.crashing.org>
Subject: Re: [PATCH] Subject: [PATCH] usb: gadget: aspeed: Add NULL check in
 the ast_vhub_init_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-usb@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 01 Apr 2025 14:47:57 +1100
In-Reply-To: <20250329002911.132826-1-bsdhenrymartin@gmail.com>
References: <20250329002911.132826-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
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

On Sat, 2025-03-29 at 08:29 +0800, Henry Martin wrote:
> When devm_kasprintf() fails, it returns a NULL pointer. However, this
> return value is not properly checked in the function
> ast_vhub_init_dev.
>=20
> A NULL check should be added after the devm_kasprintf call to prevent
> potential NULL pointer dereference error.
>=20
> Fixes: 7ecca2a4080cb ("usb/gadget: Add driver for Aspeed SoC virtual
> hub")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> =C2=A0drivers/usb/gadget/udc/aspeed-vhub/dev.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index 573109ca5b79..1709a58299a5 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -545,9 +545,11 @@ int ast_vhub_init_dev(struct ast_vhub *vhub,
> unsigned int idx)
> =C2=A0	struct device *parent =3D &vhub->pdev->dev;
> =C2=A0	int rc;
> =C2=A0
> +	d->name =3D devm_kasprintf(parent, GFP_KERNEL, "port%d", idx +
> 1);
> +	if (!d->name)
> +		return -ENOMEM;
> =C2=A0	d->vhub =3D vhub;
> =C2=A0	d->index =3D idx;
> -	d->name =3D devm_kasprintf(parent, GFP_KERNEL, "port%d",
> idx+1);
> =C2=A0	d->regs =3D vhub->regs + 0x100 + 0x10 * idx;
> =C2=A0
> =C2=A0	ast_vhub_init_ep0(vhub, &d->ep0, d);


