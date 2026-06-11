Return-Path: <linux-aspeed+bounces-4225-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BB8CD98C6
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 05:07:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbVxZ3gFwz3bqD;
	Thu, 11 Jun 2026 15:06:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781154418;
	cv=none; b=kDqH5Tp3veC1e1zhp+jTHEor2uC3Gs+fTPRoiUSXTD8dpQ99MwdJvkYDzaEi+mxNXD2Ml8/YgsAmI8p7tEC3vnTFEOqiujj3BW22nBIfSaO0fC03jlFRWGzGB5oxli+c093OjloyCwShP//QnOSwELt4kVcF1e1rVn2ijegSyo77Xai6oSi0hcqx0lCJ5uOs4qRRkTAtVoO8KnmSQI+FGCiAinQ3HUoUbcQP4m541T6qxzmXlzsRD0kV6gZjy7m6GDm+4tI+5aPw0EUCMyH3rHSGs7ZMx3jgJ0x9HbbzLYp3ArckVpGfsyVR6Qoz5bE16v/B+o+YgSzTbf+4FHxwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781154418; c=relaxed/relaxed;
	bh=GyRbe+8t9Qx3vOYKAfgP9Hg3BnwoylvXSDWp38DlcgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1A+JHLsOaUarjApbmQdCGYR4wxu9gw4bQ825pmgwPQ1hjbJRbrCJtHO3k0wdTRHG7X91beBfh/oJT9HD0IQ4/Ey2nTSC/LCqPqWic8WQnVYnXrJDp8VvItXw5qS9fu6ppIekQY8w6FDsZTz5CmnO3EQlTPkSZSCx03rr4ARbhQoCimt2rsojr+uvDKrUu7J2FmBYjtqglzEVliTT/XjFGxnU5bIRXvtFdr1lPxLKekn2VHtlQ+kCb3gFyNJ1i63Kbm5Yly0hl8KLm/sQTzFAPnIWcK0GVUyRMJPsAnDfXVu+fM3Ga0ed0jShp+Yj5nMx8JZdtDu9MhffytSB7fpPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lClyaaPM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lClyaaPM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbVxY0Vbrz2yb9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 15:06:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781154415;
	bh=GyRbe+8t9Qx3vOYKAfgP9Hg3BnwoylvXSDWp38DlcgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lClyaaPM5lDcE3g5Glq3XQLIx86iO6NcjaNXhDeR5Z5LYRMPRMwIcEx4GxUaMuj6u
	 C8SK6XqZ7engUuff59cS8Gx48DxyEVjtdLBpTeviDDeYDK1BTwn7FkfbgivHbKCYvT
	 wJqF38FTY5slwLr/A6GL+zqmog22WNjamQYPuxfH/8u+ZpucqJ9ubXB8razfCTNUmx
	 mjkw7RY6YxsoPLPRaDa2O5tRWb627uslqGlZTj+DR5C4lt6YbUHmtkXPj1Y82DNSPY
	 NRzgnHu+7HaCDMjRi+zJNos3TU6q8CSN0/M8dyCkdDI0aLCwFTgSCiJvFaOYRh6jKJ
	 LFEgR7mVEesMQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 164E96450D;
	Thu, 11 Jun 2026 13:06:54 +0800 (AWST)
Message-ID: <a4f09170d3d618d285f7019c82e63142b268d6ce.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] usb: gadget: aspeed_udc: check endpoint DMA
 allocation
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ruoyu Wang <ruoyuw560@gmail.com>, Neal Liu <neal_liu@aspeedtech.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 14:36:53 +0930
In-Reply-To: <20260610121022.3-1-ruoyuw560@gmail.com>
References: <20260608081948.3-1-ruoyuw560@gmail.com>
	 <20260610121022.3-1-ruoyuw560@gmail.com>
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

On Wed, 2026-06-10 at 20:10 +0800, Ruoyu Wang wrote:
> ast_udc_probe() allocates a coherent DMA buffer used as the backing store
> for endpoint buffers. ast_udc_init_ep() derives per-endpoint buffer
> pointers from udc->ep0_buf, so a failed allocation is dereferenced during
> probe.
>=20
> Check the allocation before endpoint setup. The existing probe error path
> called ast_udc_remove(), which unregisters the gadget unconditionally and
> is not safe before usb_add_gadget_udc() succeeds. Add a local cleanup
> helper for probe failures so pre-registration failures only unwind the
> resources that were actually initialized.
>=20
> This was found by a local static analysis checker for unchecked allocator
> returns while scanning Linux 6.16. The change was checked by applying it
> to current mainline and by running checkpatch. I do not have access to
> Aspeed UDC hardware, so no runtime testing was performed.
>=20
> Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

