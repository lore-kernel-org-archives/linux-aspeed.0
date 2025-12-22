Return-Path: <linux-aspeed+bounces-3195-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB593E6749C
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 12:13:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZcVj6l9Xz2xSZ;
	Mon, 22 Dec 2025 23:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766405613;
	cv=none; b=IH+4AlhDGgO/uHKPPOk/PzRR+DnX45a0AJVTuHxywmVrgMRc7z3vwGdKMGRXsgyxO2tzUzNhhh3gIg8dgtZRA0RN7y9lBalaFpinodgSf1DxzVXvLL5gcz8v00I7mqvCoeEtmIa0qy9qTbw7KqRgtIWvjFaMQTQH6abqlxu0pO/9KaGvq7TfSTyxm3hORxMXLjrBAgTjStMQSTyCoip/vU6+Wp9Ho1UW6ratS5RoO6JgV8Rq8NA4BErXtAgO+2pL4bKn3O+AmoU3osPLLGlM6Ratbsusvhdyiy/Zmj8aH5sPY7NbhCumm0Lw0BcW+oJEMFvXe/SJH+KK0winuPuhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766405613; c=relaxed/relaxed;
	bh=ruyy63GwboUn7+9s5l67HuCdYOrz3XONvrYdWrJbZr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmW3fzLBhrDBzcaTDrTwE4ve4qb5jgoZld1XlSQQREi9MRRoZqVGWp1vUEcLnX4A50HbUfDM3FZvT+qTzPYIJEcI/+xaeVM4gFUJnzJdHRZbs5oJJXMHJeItFdqq/BKklCnfp4aRABdcWbRaRksodeamxAkcaJGX7oEndk77ysqzwg2/VwEZrZYvKodf1vOmLumvC/1oO7AwoEbzKJIuKvpq0MVl9iB0nOcIwPB4YDC71DVuHmFQFTjfqFjrHzhmrF/Y4zKGyepldwmKTe7zvz7WnDG7QcpKW+YVjFmzSBRTbVO2/w3NhZx5aBMvx5G5h75PqUo7h6x4wm/T6iCJsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sntech.de; dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=vARL6LrT; dkim-atps=neutral; spf=pass (client-ip=185.11.138.130; helo=gloria.sntech.de; envelope-from=heiko@sntech.de; receiver=lists.ozlabs.org) smtp.mailfrom=sntech.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=vARL6LrT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sntech.de (client-ip=185.11.138.130; helo=gloria.sntech.de; envelope-from=heiko@sntech.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1373 seconds by postgrey-1.37 at boromir; Mon, 22 Dec 2025 23:13:30 AEDT
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZcVf4sL6z2x99
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 23:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ruyy63GwboUn7+9s5l67HuCdYOrz3XONvrYdWrJbZr8=; b=vARL6LrT+8uqJV8RIB88I7spsT
	VcvqJXHZ2ESVBUXH8pmBDr6rSZIyusgktlb9xTjaFrNyB/hP0IW8zYhI19KcMG8Ehy65OagQl2NpD
	TvOU/srFlHluBlH5fGPr9Q5HTM6c0cwQoTMUXlnRNLZwLLZbv5gR7+7pFsbX1gH7H4D0EDey8RiC+
	G4KGL3ST5Evr8aKquQSLsW7cZKzGnoZJc418sSO+RcGMthBaCf76o8PLPjSP49so+VUv53GzEFn64
	jlSn2FLqebJcj1lyUNi7AmfUI1VaA9OeuWjOUgqhJfIOWnKlBB974EL1TCGYkXx+5mU3oT4QIiMD/
	MYPy1VZw==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vXeQT-0004nF-5v; Mon, 22 Dec 2025 12:50:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] iio: adc: rockchip: Simplify probe() with local 'dev'
Date: Mon, 22 Dec 2025 12:50:07 +0100
Message-ID: <5782401.ejJDZkT8p0@phil>
In-Reply-To: <20251221142602.47368-6-krzysztof.kozlowski@oss.qualcomm.com>
References:
 <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20251221142602.47368-6-krzysztof.kozlowski@oss.qualcomm.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 21. Dezember 2025, 15:26:05 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Krzysztof Kozlowski:
> Simplify the probe function by using a local 'dev' variable instead of
> full pointer dereference.  This makes several lines shorter, which
> allows to avoid wrapping making code more readable.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Yep, makes the code definitly nicer to read

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



