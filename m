Return-Path: <linux-aspeed+bounces-4871-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31CBC61DEB
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 20:25:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY3Xy3cx9z2xwN;
	Mon, 31 Aug 2026 06:25:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788121554;
	cv=none; b=e6hnbBnNO8s39NPdgQw0+uEkRyyv2r7I9cIet40Ai7I0U1WXvAZEdW+wF47s7/bv0iZcKwWo5kUG3wKyOuDGQFfNaTiplm76zeCB+i4n0qG6fD0sshTadRNXjEYmYY78EWrPoa7IPz98b6MX3+dStwVi/DFn1QCtg5xHiZfBbEec4SlGdChgnpdZTZfCkOFUiqh4DVmSWvcT6VAHkftlekY3J/MPU8x8GZwor7TYMi36pvsRyjA0P/XjldRsIEPxQYkfJm4cbm58fi1bFytgEQEHe5KsYZun1N3thF0izMjkW9tt1x0rc+grskXfEKpP3A8k1nC6e1hXOd2mCcuIew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788121554; c=relaxed/relaxed;
	bh=gWUrnFGYufl3syZYwtYjuU9uZOGyhIpP8L/7zqTakLE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NMpRFbK0zdHavb9YxVXhWDysphLR8KsfWdm8bX7ZUaEV7XQG+b3Pl6D8u7prGg0fzzI8qDgXsYPN5FOuevx/5+AQD4B5xtz5sIS1juan/QRyxwnYfZsAgeLZL7JDD819txp2WYei2jO2YIXSccHIWkBeGr4vRVVrY8vs8nnAhpoyeyEoq7RoJPkV3fQHD+E/YLjum1No5bBhllV8UlUYCAkNFGnabQjq1jJ9WEZPbb/BW/Rew23w/DibPnh9iPi6ME1ax4bauT0dA0cZt9ZLNyUsQ2bC7Hd66fVPJGro+PebmCOSteyNof2YCUJaClzk5LDV0Pz9oVOamAisU8hBhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPBijgbn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPBijgbn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY3Xx3V55z2xr2
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 06:25:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BF3F600E2;
	Sun, 30 Aug 2026 20:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6106B1F000E9;
	Sun, 30 Aug 2026 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121549;
	bh=gWUrnFGYufl3syZYwtYjuU9uZOGyhIpP8L/7zqTakLE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hPBijgbn++DmdnYqGa42jWjjiWb2KXV9V3Ge1OpXI77KCVa8yY6hCjGY07HXKfM/e
	 I7p2qKfD2orBLXZFLkrYkZQaeguGGNvadmhiO0Vc57HbPsB78VAmgo8pNvdWG3yGjP
	 akW3HG7vXrWEFETDSk7z34d4Ckiu6XMFBHSl6oqC57fpCHstx+sux5H0MaWh7vReri
	 kjExMIWOe+iqZYm6Fj2RLJAqzRLG3qrpUsXF0pPpHBUZf2SW9pIb/0BaSa6SlFOKOZ
	 RIhsoJ6QVd8+40EtdE5r4AwV3cKWI/0nrxo7/ykbKxHaVc/TVhyuzkGhrWDvrOI2xr
	 w/Ldo0xLBUDsg==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iio: adc: aspeed: propagate reset deassert errors
From: Jonathan Cameron <jic23@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260830134227.9085-1-pengpeng@iscas.ac.cn>
References: <20260830134227.9085-1-pengpeng@iscas.ac.cn>
Date: Sun, 30 Aug 2026 21:25:43 +0100
Message-Id: <178812154332.2788519.4278277683256006454.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=608;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=DpsBPTsiiRMc9Jfqxq9ivIXspOVDc/2T+OP02ftTjxg=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlJHMmuJ2BEz3bQ3iQmyjjiHsjbBZLIJdc99yp
 C6/aP+1PXCJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSRzBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiLykD/9YQs9EHXb9+mHMdLXUhmpJRh//t4UnHIHIsaopeW59sqq
 xi58RVSrrqeZ2bGLYmoU1k0YvLOdFNrMu6VaI0evHYSspOGpOX+3kzypS1u47wxTcCdbb+rc7QJ
 ngbbI8GY9Pud17iy8tF3nyaFM3keLXbjfnz40H+trKnx98DY5W5Ce4CxTIE0JkJG3sP4S5MaCiP
 muawDsufIm+U4WxtMeRThY1uBkHLKAxt009OR5Fz0Yc6/V83oBG2twLxXNouevIIF/4MaotrhCT
 jf8noauo6bm0cN+HPV3P0OYryEXQYlXJ8mOeGBpBldteZ60UGHZvAmYG7V1+0B+D6azirMZU1qy
 jBb9UBqkrXRo+9otOHPQN6XkpXzoTklg3EN0WolYWv06X2r8Ef7w6tae8nJy0jTCWw5qw6GnnU7
 dHNWJGYacZvhZDL0i2+gc3Fg9/RXdoDx1vr9R2KfjixmFysFdrm27XZVOoTniVbcuaSDeMagRhP
 roP3Y2OAxOXB9CQ8YX8Al1oks/Ikokr+OqleyI/xukHOY8TAo/3nA2d4y3yH5yzGO3DNV78PKzp
 qZ/jKoG5ZuzlPvNf58jHB/tKZt7TGEgHLVH8gqxwuyhQDeJ9q88CpUCumFxhn2ATryeWCkNFGh0
 L72SuSltOmlouErS1Zwpqt4iLHFLIbqqB5UuxVQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> aspeed_adc_probe() continues to register ADC resources after deasserting
> the shared reset, even if the reset controller reports a failure.
> 
> A failed deassertion leaves the hardware unavailable, so stop probing
> before
> installing the cleanup action and enabling the ADC.
Something odd happened here with the line wrap.

Otherwise, this one looks 'obvious' enough that I'll pick it up
now and apply it to the fixes-togreg branch of iio.git.

Note I'll be rebasing that on rc1 once it becomes available.

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

