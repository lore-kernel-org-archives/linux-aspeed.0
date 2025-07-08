Return-Path: <linux-aspeed+bounces-1660-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0303BC71130
	for <linux-aspeed@archiver.kernel.org>; Tue,  8 Jul 2025 02:06:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbkxk4Z1Xz30T3;
	Tue,  8 Jul 2025 12:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751940410;
	cv=none; b=A64s+FcVbdLzAiYzfOl7fFmy+/o0I2A5lVvC0EsiqtvsEYDu8LQ2UijsoPEpYC91bkYMwvOttoUlWeX07aNM/jKvWY/OzMdppvPxazN1H4p27TTV4kyzNJcbGIroqc/EdVgL0+NSqWAyXbBqYysCwHKaT3ZCNUEiJvGgk1O2ppNZ0YDnsQcL70HtyR+uJQeQV7yTeTNthVZ57vfPXy75FGolRlkWVPGXYpIu5PEhCUEw6VSfjm3ot5lFXkwiURc7uJxCIpEXqTYsX7Bz0OyWZjzMYZVl/5OrYuR9MnG0+79xH17Ck17dSUIoTG/vgF7A3pXqHr3rZ+WtFps22OZVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751940410; c=relaxed/relaxed;
	bh=nghdqr1TNgA7GTnWXSxnqQpSMH1Jj0RJB/prk1nIUIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpS8FbLpbGZSg+9HuexYLiqzEwaqLhFGvskXpRBDT++tEQdBy/TmS19AbPJ7oFypLF3ZYCLNo7vuAqItE8q/ziUtKH5dV2bSij6RLKStr0Q+ZU5yLIUPXLdJ6Pno4VY9pQ/EkId2Wi8ItDi96G+n4w2JYe4RpXD5TS57KUzC9QnDM9s/bjbM3P7s+2ighHuOocKCuMefTi8M8TwxvAiBT/WouxZsB0kJParlG5uqtnP79/N9mTyop1U1le3S+hhM40QG16Hql2dRQDfrHNUIp7FCSdT1u5tWZos754XotPbpxrJD3kJuCszNnY55SdJrIdy1lv+zgoAEoUwo3BuXag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=efnZSxRj; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=efnZSxRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbkxk2Q5sz2yFP
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 12:06:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940409;
	bh=nghdqr1TNgA7GTnWXSxnqQpSMH1Jj0RJB/prk1nIUIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=efnZSxRjJWL650CnneLc0hEdvRZaLwoT/UZWjOeiMpODmJ9Qh7k66Ejf1RFGcD+Si
	 RNbW+BHbe8Wbnxg9j5DjAZiT7uANwG9Kl+ZiHYTslCR8NaxSaCDFvl/BPD6lx70ygU
	 gc6kXs/SoeLzq23e6EOWOCW+SEZlnFRaPsCHJsFy9X65evzc+eKBNfCeXPueyyNrWB
	 g678EnZT064/eewjQKeW6naXKWK1grI0oNvOM+1stcQoXJDMJaevtV/6nzBkPw9bBP
	 ZstormeTgESK2Wz847+nLuUXSEAsBD+pYRWcEcJtLBAIpwPLIkb2a8vuNX3xaa3u23
	 7C+Vhb6Sb3ppA==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 26C476AE34;
	Tue,  8 Jul 2025 10:06:49 +0800 (AWST)
Message-ID: <7e4738d944c611cfb0e4eba4ce2926ed55a0096a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 06/10] soc: aspeed: lpc-snoop: Rearrange channel paths
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:36:48 +0930
In-Reply-To: <20250704173443.3436f535@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-6-3cdd59c934d3@codeconstruct.com.au>
	 <20250704173443.3436f535@endymion>
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
Precedence: list
MIME-Version: 1.0

Hi Jean,

On Fri, 2025-07-04 at 17:34 +0200, Jean Delvare wrote:
> On Mon, 16 Jun 2025 22:43:43 +0930, Andrew Jeffery wrote:
> > Order assignments such that tests for conditions not involving resource
> > acquisition are ordered before those testing acquired resources, and
> > order managed resource acquisition before unmanaged where possible. Thi=
s
> > way we minimise the amount of manual cleanup required.
> >=20
> > In the process, improve readability of the code by introducing a channe=
l
> > pointer that takes the place of the repeated object lookups.
> >=20
> > Acked-by: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 ++++++++++++++++++++--=
-------------
> > =C2=A01 file changed, 29 insertions(+), 22 deletions(-)
> > (...)
> > @@ -238,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lp=
c_snoop *lpc_snoop,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_misc_deregister;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Enable LPC snoop channel =
at requested port */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_=
snoop->regmap, HICR5, hicr5_en, hicr5_en);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_=
snoop->regmap, SNPWADR, snpwadr_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 lpc_port << snpwadr_shift);
>=20
> This duplicates a comment which is already present in the driver a few
> lines before.
>=20
> This duplicated comment gets cleaned up later in patch 10/10 (soc:
> aspeed: lpc-snoop: Lift channel config to const structs).
>=20

Thanks, I've dropped the duplicate in the process of applying the
patches.

Andrew


