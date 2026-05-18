Return-Path: <linux-aspeed+bounces-4042-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DC6CD4F3D
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 02:08:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJh6Q5dTkz2xfB;
	Mon, 18 May 2026 12:08:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779070094;
	cv=none; b=jELBJdHlRTYyfhUYV8KYPIex7cxuhJfhvEe2mI+CD0HDwNONLBeNp2sp2C/o/dncbRbFwb04SHzd6Dw8EHjjwAE+TCgZUn8QQKUusuc1Bd/Gc97moe9Q4nqjlJWLxq3k1i0NP5K4nNgaFxr7jIHJ3BdmqKJ/lV65GqFQk9jG6n4cI+TbYnYFCpocEKhdfReRBuSHGgeNCybiNrfyJ1RlkUgJYzEcddUYBazrA8HJ0d2J+AL51qlbx83j7n5aT2UUWcGOgjzFG4HptoQjeJIjE6KPTvWmy4nzLw61vrgOMQSDLkKqIDHTMhbbJAGCy4Ncn/K8mpWZ6EFa54k9EZWn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779070094; c=relaxed/relaxed;
	bh=x8u7GTxrVk0C2PJrbCem+3xBCd5jbswvYhojVoW4ZD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjRp5h19jCWhP9ma5hWI7Dp3yF/cU9iWp0kJqKh2olhqNsyH6ZnWcpuBNdoZPfLh4nmAq45xs/e39dbfIOxfnesgZdvGMzB6inYiOPh5DVCT7rBD0g+6dkl364rZokSHcEeCWZPhdt/ApjtDmiN2s6SQUg3KYJRZERQXLKdxglLXUsJOAaN+TrFFkrktXssFCVVzS83evUS8RxcjzJBNVwLex0WHnAVCwzjCEjegFJQ2eno6IuM44N04X+9Dma3nEAYABm8AZgEfyDsBOrS6NfOIkHIorO4wTKa+6T5zkXteD4w1L8bYVROv3aMRAxfuzz0qI1+VjMXJIduqFkNviA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WjJ1dXe9; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=WjJ1dXe9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJh6N0JZ9z2xWP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 12:08:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779070089;
	bh=x8u7GTxrVk0C2PJrbCem+3xBCd5jbswvYhojVoW4ZD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WjJ1dXe9pkIadrwUEsZ3nLCVl/sBeoO0RlerFs/2F7dsR1vqQ6h9eDUgMn+2BkJTx
	 sU+ufPnAAQlTC2n1ZqiIJ57FPvyX6d2rHwaqtdVQA2eHw9vQaKS71sYWwy+v42CegN
	 J/IlaMjSZiSqQ8sIqirJmsH1FPCrhnyLjeoSEK5x0PyTXTU4nWKrgUf0odHukYNQFB
	 OHEFn5a34TwZfn+n3rTOyQ72FOxTIW6NCsSFIYu/6tKwi/8j+t2+PmB3GBPebZHusL
	 QRsB5qRB4R0G8390g019AOKULWeZ0eKglLCCxJPRG+SUCKjYcAHVgaMAaFMht7F8gx
	 c7PaiHl78VcVw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2BFAC6037B;
	Mon, 18 May 2026 10:08:06 +0800 (AWST)
Message-ID: <7927e6edf6cbe915a66b76746436c8d19f317bd6.camel@codeconstruct.com.au>
Subject: Re: usb: gadget: aspeed_udc: list iterator used after loop in
 ast_udc_ep_dequeue
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Maoyi Xie <maoyixie.tju@gmail.com>, neal_liu@aspeedtech.com, 
	gregkh@linuxfoundation.org
Cc: joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
 linux-usb@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 11:38:05 +0930
In-Reply-To: <CAHPEe=Fs223obDewRunPdTtqhVOM11AXVsLRNHx+=NP0KiFwMQ@mail.gmail.com>
References: 
	<CAHPEe=Fs223obDewRunPdTtqhVOM11AXVsLRNHx+=NP0KiFwMQ@mail.gmail.com>
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

Hi,

On Sun, 2026-05-17 at 23:46 +0800, Maoyi Xie wrote:
> Hi all,
>=20
> (Resending from a personal address =E2=80=94 my previous attempt from
> my NTU corporate account carried an auto-appended confidentiality
> disclaimer that you've declined to accept. The content below is
> unchanged.)
>=20
> I have been running a small static check for list_for_each_entry
> past-the-end patterns, similar to Jakob Koschel's 2022 cleanup
> (commit 2966a9918df and related). The check flagged
> ast_udc_ep_dequeue() in drivers/usb/gadget/udc/aspeed_udc.c, and I
> would like to ask whether you consider this a real defect before I
> send anything formal. The same code is present in v7.0 and in
> v7.1-rc1 (the two files are byte-identical).
>=20
> The code in question is around line 691:
>=20
> =C2=A0=C2=A0=C2=A0 struct ast_udc_request *req;
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 list_for_each_entry(req, &ep->queue, queue) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&req->req =3D=3D _req) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_d=
el_init(&req->queue);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ast_ud=
c_done(ep, req, -ESHUTDOWN);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _req->=
status =3D -ECONNRESET;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 if (&req->req !=3D _req)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D -EINVAL;
>=20
> If nothing matches, the loop exits past-the-end and req becomes the
> synthetic container_of(&ep->queue, struct ast_udc_request, queue).
> Reading &req->req after the loop is undefined per C11. The post-loop
> check works in practice only because real _req values do not collide
> with that synthetic address.
>=20
> What made me suspect this was not intentional is that 14 other UDC
> drivers in the same directory (at91_udc, atmel_usba_udc, dummy_hcd,
> fsl_qe_udc, fsl_udc_core, goku_udc, gr_udc, lpc32xx_udc, max3420_udc,
> net2280, omap_udc, pxa25x_udc, pxa27x_udc, udc-xilinx) use a
> different pattern, with a separate iter cursor and a result variable.
> For example dummy_hcd.c:
>=20
> =C2=A0=C2=A0=C2=A0 struct dummy_request *req =3D NULL, *iter;
> =C2=A0=C2=A0=C2=A0 list_for_each_entry(iter, &ep->queue, queue) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&iter->req !=3D _req) cont=
inue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req =3D iter;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 if (retval =3D=3D 0) { ... }
>=20
> aspeed_udc seems to be the only outlier in drivers/usb/gadget/udc/,
> which is what made me think this was probably an oversight rather
> than a deliberate idiom.
>=20
> I also tried to confirm whether it observably misbehaves. If _req
> happens to coincide with the synthetic past-the-end address, the
> function returns 0 (success) on an empty queue without removing
> anything. I attached a small userspace reproducer (poc_aspeed_udc.c
> and its output log) that arranges this collision. In normal use _req
> comes from the kernel slab and the collision is unlikely to happen
> naturally, so I am not sure whether this rises to the level of a
> real bug or just a code-quality issue.
>=20
> Two questions:
>=20
> =C2=A0 1. Do you consider the past-the-end use here a defect worth fixing=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 or is it an accepted idiom in this driver that I=
 am misreading?

I don't know that it's an accepted idiom - there are only two
invocations in the driver and the other doesn't suffer the problem
you've highlighted.

list_first_entry() does note that the caller be sure that the list
isn't empty. As you note this isn't tested, so it's now a pre-condition
of ast_udc_ep_dequeue() that it's not. A bunch of gadgets test if they
have requests in-flight before invoking dequeue, so that may not be
unreasonable. However, given ast_udc_nuke(), and the implementation
admitting that the provided req might be invalid by the existence of
the test, I'm not convinced that the invariant is upheld.

Note that the (other, separate) Aspeed vhub driver avoids your concern
in its dequeue implementations, so I'd rather it's avoided in the udc
implementation as well:

 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/usb/gadget/udc/aspeed-vhub/ep0.c?h=3Dv7.1-rc4#n438
 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/usb/gadget/udc/aspeed-vhub/epn.c?h=3Dv7.1-rc4#n472

>=20
> =C2=A0 2. If it is worth fixing, I already have a small patch that brings
> =C2=A0=C2=A0=C2=A0=C2=A0 the function in line with the 14 sibling drivers=
. Would you like
> =C2=A0=C2=A0=C2=A0=C2=A0 me to send it, or would you rather address it lo=
cally?

IMO send the patch. It's almost always better to be reviewing a
concrete change proposal.

Andrew

