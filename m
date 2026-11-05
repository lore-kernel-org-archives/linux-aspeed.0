Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0725606A33B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EDYxslUQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKrFw3tldz2xNC;
	Thu, 05 Nov 2026 16:19:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793855956;
	cv=none; b=TzoZcgIDtXhopBksQT2mhxe/mhJDW9BjFnxloRmAQgZSce2LnyJe7t5m9BZD1Xts+IncNaCKiTLINTDDDujg6dYIp3Ri+5jaPrtLpfi/bMXeRyAF0d3+pB4wvrgB4gjA6WAVyqXFZvUue3K+g7n4mJ04Z+z/TzwxaCT/qyz6n5RCFLy+kU56FJLmAU6HncBwIKLtD3DtkcUSaJ9qlRYT8sMSDG9uOsmiVj8kL0ESBTkOXVOynGDXWxT37TRfQwAndbqLwrjDXr2WR9FXvSekpPW7NwCurBD4insKarB+x5k2keH7oiAoltRBG5xrkiSS27NvRP0cpFWP1qzffeUIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793855956; c=relaxed/relaxed;
	bh=fOCYY6s4NWFJAtXADmmsBtaGwYYG3CP3GVT6+oHGss4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnVI7dqzZkXO2ki6Y/m6eYiDysatkguuLR2xqQjbscnfgqPy93FNbchZPEl/7NXHw78Hv5pCB5zrxKcbvYWLoqdzkGKMHC8IsvNZsDsXSBieM2LETSUMz0VWf3sjZliptxkknTrCbYxq6hChf6Ve4EUvOKAjv9xk0b1M/QFXWkLLnNnDgOrT0GtEIRVQqpcPS/Zo2SBGjiip34AD5CTFdVyVsFdCfF7pX3sD2hPPM4zFCAJU43PnBm92qBqQRLMHBB5lOy1W5TUkNbP1sihAoSvDHOwdX8HFPn8vpPLO2nNKdTLcbPlOVfebklkhI3jdvrJGhkz7sGsLpIG6AqodNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EDYxslUQ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EDYxslUQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKrFw0tplz2xLd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 16:19:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793855955;
	bh=fOCYY6s4NWFJAtXADmmsBtaGwYYG3CP3GVT6+oHGss4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EDYxslUQbO01HBCp/ixmJKShdGoiXZTMP9+Vll/sNFsk6h11qqe+XwZ+6qxPOCfa8
	 tf5r68QKO3IwSt1Q1PkjyBB7xXCcPuFADrPUmaVDYRxJnu5CPVf54q+avuxr5HJM0P
	 oDJalrYvOce34ImZ9Gsm3A1ydY5yEnHFM0JvRtYF9kvdhihB1KTZFoz4D3BK/5AZ/X
	 ZQ2oVKI4EzR2TNuTWPfiY6uMN5HT+dLEsqVQ1fUeYnLUunafRDOIQq4DDCkr9WS0xO
	 nDjeVOC1KDk2ZchRKkiv/gb4ViKzoIM6Oz+XetODn/xtG0+G8e7wGk1Vt5DLiCO8dq
	 gYsKnkWq2WuPA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EAF2664698;
	Thu,  5 Nov 2026 13:19:14 +0800 (AWST)
Message-ID: <2dff7406f6bbcb188f70c4caf7193fb5f0fb8e82.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] gpio: aspeed: Preserve the pending G7 interrupt
 status on control writes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 05 Nov 2026 15:49:14 +1030
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
References: 
	<20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
	 <20261104-gpio-aspeed-irq-status-v1-2-9805645f856d@aspeedtech.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 11:58 +0800, Billy Tsai wrote:
> On G7 each line has its own control register, and its interrupt status
> bit (bit 12) is write-1-to-clear. aspeed_g7_reg_bit_set() updates a
> field by reading the control register, replacing that field and writing
> the value back. When the line's interrupt is pending, the status bit
> reads as 1 and is written back as 1, so updating an unrelated field
> such as the interrupt enable, trigger type, direction or debounce
> selection also clears the pending interrupt.
>=20
> Mask out the status bit when composing the value to write, so it is
> written as 1 only when the status field itself is being set to ack the
> interrupt.
>=20
> Fixes: b2e861bd1eaf ("gpio: aspeed: Support G7 Aspeed gpio controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

