Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7286606A32C
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ndZFzLE5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLTQL2c2dz2xNC;
	Fri, 06 Nov 2026 17:13:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793945626;
	cv=none; b=n3LPbU+x8oQJWdxIiB+gajrjhC9n8be4+5DDgaV3GRI/b3hjwzNIa+rgLdcv5b47tQpfrOQQk8JSkurCEv2Rzu+9QAbhVaDdkrYIMaOmoNH7LSldvlu7sCXigq5mq0SJsPlukVx1bIqYX5vA3GFFjDVAUb16SSTdsM00I+HRYL+VMu1jJ16THBzLpyA96m82BeY5V4o8ua7ou5TnCc6c3nwCO59nrhssphtcvIWIapKqodKtrF6G21Yde49DrLdCGdwn4EVzXKT+pYoSc5/d4Ht4VRf3i17qpOfwwQirjxvo8OZc0tq3gHgr+jNwg4e6hXLgzF+Bt4Qve5KFeh9vQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793945626; c=relaxed/relaxed;
	bh=rzvF6MsRtSNRQYkAnE8s0gTVzXdnYrXPinbLwOnBUXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsKOjwDpn8Boq64XfDE5UFFTnyNRMudEMllp2OA6cjbSrow42ALNUUyT981b+SKfn0X/WfWHpKwarNEM54EJ/ezUoLX7zKuUUPmbkROwFuWtKVmRc6VVDFr3LbmAJHqXITVCftYoHr5UEDCEtZCNiqN9zVePjGvT6rY8J+rtN2ApmqXW33j9p0MzXdJuIuQfdKJG7NQVg06x5HfmpN8Eu6A92Di0OoX8yjF8OekX4Z/xOGeX66wKYZdos88vw1yRk3mnKH16HYK98+at9O5cu1+vLcuHUnpXTI2jXKKi9yR5LcqBsubsVR4t9mnL0ZFvbq0LRclNhCkSo7nAqRodtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ndZFzLE5; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ndZFzLE5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLTQK5ZJVz2xKx;
	Fri, 06 Nov 2026 17:13:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793945623;
	bh=rzvF6MsRtSNRQYkAnE8s0gTVzXdnYrXPinbLwOnBUXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ndZFzLE5AsFZxPNSYiwe1F7iskrv784pVUWFqTXYG7o/4s6WIGZF/QcWN8C9inFSo
	 d8MXP2mSJgLPYNoW2AWLn5VRNIrPj1LvIP1mHVKZgWOhOhRI1K25XLF/k41y826lKv
	 7v6ZUAbAXf0oSctj+L3mLhLfjRcu6yV4dTGlwR+GFYPnnTZ0Mpl4+zXQrBBq5Jf9Ps
	 6HKEmS/q5zVbYOPc/TJlicZ8TdETKFUGMYUXrevKj92uB3KYj9iN289JumYhwMUiVc
	 xZc+5Q1POjXSzWFRBjBDRuAzzg7r5Zf16DH2Yx6Mk9Yn6HZE//t+JEvCfKXgJZTiuz
	 1HdzsucRlCc9Q==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0140E649EE;
	Fri,  6 Nov 2026 14:13:41 +0800 (AWST)
Message-ID: <8afcccd35b8a78730c6a9cc46c30dbeb99694e6e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/2] pinctrl: aspeed: Use managed pinctrl registration
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, 
	linusw@kernel.org
Cc: joel@jms.id.au, ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, 
	brgl@kernel.org, tan.siewert@9elements.com, linux-aspeed@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 16:43:41 +1030
In-Reply-To: <20261106022907.10735-2-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
	 <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
	 <20261106022907.10735-2-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 07:59 +0530, Prasanth Kumar Padarthi wrote:
> The shared Aspeed probe helper registers its controller with
> pinctrl_register(), but does not unregister it when the device is
> unbound.=C2=A0
>=20

This is a problem in its own right. IMO the rest of the discussion can
be left out, as it depends on the subsequent change, which still needs
consideration.

> Registration can therefore outlive device-managed callback
> data, leaving a registered controller with pointers to freed memory.
> The G6 handover change in this series embeds that data in a
> device-managed allocation.
>=20
> Use devm_pinctrl_register() so controller teardown runs before earlier
> devres allocations are released. This also cleans up the registration
> if later probe processing fails.
>=20
> With this change and the G6 handover patch, one unbind/rebind cycle
> passed under generic KASAN in AST2600 QEMU and on B650D4U hardware.

IMO this sentence is enough to describe the testing, the rest reads
like unnecessary detail that tends to be generated by LLMs.

> Controller debugfs entries disappeared on unbind and returned on
> rebind; a subsequent pins read succeeded without observed KASAN
> reports. The unfixed control case has not been runtime-tested.

What is this last sentence referring to?=20

>=20
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---
> =C2=A0drivers/pinctrl/aspeed/pinctrl-aspeed.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/as=
peed/pinctrl-aspeed.c
> index 7e0ebf11a..d19b4d23c 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -461,7 +461,8 @@ int aspeed_pinctrl_probe(struct platform_device *pdev=
,
> =C2=A0
> =C2=A0	pdata->pinmux.maps[ASPEED_IP_SCU] =3D pdata->scu;
> =C2=A0
> -	pctl =3D pinctrl_register(pdesc, &pdev->dev, pdata);
> +	/* Unregister before earlier devres allocations such as pdata are freed=
. */

I'd rather the comment is removed.

Cheers,

Andrew

> +	pctl =3D devm_pinctrl_register(&pdev->dev, pdesc, pdata);
> =C2=A0
> =C2=A0	if (IS_ERR(pctl)) {
> =C2=A0		dev_err(&pdev->dev, "Failed to register pinctrl\n");

