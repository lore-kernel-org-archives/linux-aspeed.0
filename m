Return-Path: <linux-aspeed+bounces-184-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A63E77173
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Dec 2024 00:28:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y62lZ6GRnz2xtp;
	Mon,  9 Dec 2024 11:28:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733704106;
	cv=none; b=FiNZYOlUkan+3sUohnZ21Z+iYnUipVHMkkVA0omDg18ShAbgUGI7mctnpoDKHPLQYrFgJuKEE0ZfbKrfM6Z/0w+0Bruq15FGUfk6pQFBggQmsCulVv7Vk4YdfGDKqm5pGyhWvTkcBIvLD3sZTKTss/yibx4aWi2mB0L9JgNEdu8jzGrJmAiR2Xq6jTYpw4lW44ovhfd23TyZjlNj/JLM7zOhf/VTs3wBQ7mE6Cw6P+jHpoIcULJdH9NRa4d88D+75UMI6f2Degv8Tjjl4HkEFYtGnEgglpIFKWUVhHmKhFGm+zHktsgROvOAy1a9YxOhp9XH+n0K1J1mGpAhEBQ3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733704106; c=relaxed/relaxed;
	bh=j+M3+w44VfmoQ+L+MEa21llPrt85cOsM3omagjhX8Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g25SZxhWPxrbJKlKuGmWfTSJXKdsfhHSK9xBZicw7vbCIiZ2JjxLx0p6BdBWBsM3wFU6NsIjq+XjgEuUrAulgkFVtaLJ6UIhlVdQUCd2uyS/rtryGKzQHN2Z+ZjzJGGOaV+Z1KKAsn8/LVS9WM3KS0B9RKaDrp1v6ix2rb9YKdeXm6F9EyRcZNjETyTyYpe1/myqSkGC1lzyi9GwuBLMqXCVRpzHVa+GG10dLUcIAAN8y+Hp/1rcOdpDEei6a63nWBtG/xTMjZI8JET/9TUZ9ZLEYe5pR8i9K31dQR9jEXToDlgXlb/+6Xx+/MWztU/hEvwsh4E8pgQF14uRXm9xJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h8p8eJQa; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=h8p8eJQa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y62lY0Lphz2xtb
	for <linux-aspeed@lists.ozlabs.org>; Mon,  9 Dec 2024 11:28:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733704102;
	bh=j+M3+w44VfmoQ+L+MEa21llPrt85cOsM3omagjhX8Lw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h8p8eJQaULseTM12ciXr7o3Q1gzCD5Rc/lOsuwfpdr0y5a4QH6nF24s4zsHGvLdRh
	 HpGw4ezAmsPO3CidaijSMZ+SAvMW2f3PdvoAPiuBgqcKv+FkFu/HNz5FXzr0GKt/cw
	 xnAT8X/40fDCzZtrmsh/aAXEioog+3Dw+LVuLccAHBfSGOu5HPdVmed+BE/a+Y+zgp
	 TSkzeZOqyRejyLmFYoBPWVLJc0HjNFm1uwyTGHlqW9MpXH/rlrURaZnjdAY5FOQPjk
	 O5sCAuDWNnfZ05ACDxshyi/BBJDNtn4txejIg8gArlbUSauJ8p+tNVUIHqyXgvvEFS
	 On6g3+7nYlY4g==
Received: from [192.168.68.112] (ppp118-210-188-212.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.212])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4CB126C643;
	Mon,  9 Dec 2024 08:28:19 +0800 (AWST)
Message-ID: <fff9f13e9839c086d566925c9066d885d46130ed.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: aspeed: deregister a misc device on error
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, joel@jms.id.au
Cc: linux-aspeed@lists.ozlabs.org
Date: Mon, 09 Dec 2024 10:58:18 +1030
In-Reply-To: <20241207032504.1203334-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241207032504.1203334-1-joe@pf.is.s.u-tokyo.ac.jp>
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

Hi Joe,

On Sat, 2024-12-07 at 12:25 +0900, Joe Hattori wrote:
> The error path of aspeed_lpc_enable_snoop() does not deregister the
> misc
> device, which results in a memory leak. Therefore, add a
> misc_deregister() call in the error path.
>=20
> Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9ab5ba9cf1d6..083ddf6dcb7a 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -221,6 +221,7 @@ static int aspeed_lpc_enable_snoop(struct
> aspeed_lpc_snoop *lpc_snoop,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0hicrb_en =3D HICRB_ENSNP1D;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0misc_deregister(&lpc_snoop->chan[channel].miscdev);

We should free the kfifo too.

Anyway, all the switch statement is doing is setting up mask metadata,
the non-default cases don't depend on the acquired resources. I think
it would make more sense to move it prior to any resource acquisition,
rather than try to unwind their acquisition in the default case.

Andrew

