Return-Path: <linux-aspeed+bounces-1024-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B01C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 00:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGt6N2VMGz2yfx;
	Tue, 18 Mar 2025 11:30:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742257836;
	cv=none; b=mwCFyhe7RarKkLsMlYnZcowQBCTLi1RzxIb+fVI5i9aMjCChTuXOyDbXBXE5oD7sCepkuef4HZJiyi02rNBkhzv3n4q6r4x3FtcsiJPGad8N5ZtYBbl9l0G/La0VcREqgWiV28v8Ds3SL0ZEkTIi7oiUDyDx1chHZbsGIvuhDHUtT1Z1r3sOuH6DSaE+A1lSUEtpA0rsw8aRyLJVkViXovKu5aGrjgn3Br7EsN+/TfnF6+bW2BNIW05gMeIiMTG25+/kdVTKqH9lt3f6oBpT0v+CQJfNAPxpMQszkboSnKx0SAxxiQiyv/ZJJgzs+jLaj0RiJa9bCzVMU526PmuXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742257836; c=relaxed/relaxed;
	bh=qrJOuxJutwKayDAiU7200Ih6LBL1oWuqiTNfvlEeLSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tq/O2e0xUiLJzkFG0kKPI21p/N33Y0u0/EQVmU/y8MKXuG0OGf8bTDKCiw2ss+4Laywbl9/kW76PU3HkDUt5fmiH225MgjrhQa7QQJv4mhPU++QqsFN0Xxu7Djdt7ZlUV2Y9ZMpcd91Rss2/XQ0hpruw75KTzFq2mYmmsRFuoXEVCAKMNM8obVG1/ZLOM1XFWGsFkzheRiF9gX8Mk7E03fRCW+QGd5JfCR2MzlA74mMr0OEHwHFiNiVrSzmP2GeKdU3IStD2PJqNSinaLwDQs3FvHOfV7dqjOQn0PolCbdbM4hN4gQNRC2m7sAWu4Tud7b5BdSql0L7CR7qd2Vzegw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hiwJHTyI; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hiwJHTyI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGt6L1ymSz2yfv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 11:30:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742257827;
	bh=qrJOuxJutwKayDAiU7200Ih6LBL1oWuqiTNfvlEeLSg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hiwJHTyIEKAeof16Bs2vj34PRfatLyOQG/jqDqNY5IoqgH4o7JRAgU4RVKn9R9lkq
	 uzsMqS0GQjqPAHjj81SjHn6QGVre4DQY9WH0mWU8cK2uvurZwecbYObQNbhWTHxRVq
	 Z5HtIZ/pV5uD5ImuWEayi+CnXqofCABoRR9/iBqbuvfcobTRiw6xYmZCMer7GQhP05
	 7Cu6wSrfZ4Kz83e5bnljLZRcOwL1oN0ePXUaiVPLBfExbYgEuj8Db864ZnSUVeGK3j
	 q5U01uGiB0r8wYGjpz10hlsbkXRN9LqHlJJ6TREpRy6BUwbM1uAH1ot2DVvKDvZBBy
	 30nZnWwU5mZzg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F7D977BB4;
	Tue, 18 Mar 2025 08:30:21 +0800 (AWST)
Message-ID: <3c16b98f113fa8918c879a16580811556b0c35c1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] watchdog: aspeed: fix 64-bit division
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Arnd Bergmann <arnd@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>,  Guenter Roeck <linux@roeck-us.net>, Joel Stanley
 <joel@jms.id.au>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2025 11:00:21 +1030
In-Reply-To: <20250314160248.502324-1-arnd@kernel.org>
References: <20250314160248.502324-1-arnd@kernel.org>
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

On Fri, 2025-03-14 at 17:02 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> On 32-bit architectures, the new calculation causes a build failure:
>=20
> ld.lld-21: error: undefined symbol: __aeabi_uldivmod
>=20
> Since neither value is ever larger than a register, cast both
> sides into a uintptr_t.
>=20
> Fixes: 5c03f9f4d362 ("watchdog: aspeed: Update bootstatus handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks,

Andrew


