Return-Path: <linux-aspeed+bounces-4299-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45D3CDB47F
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 12:21:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glgyb23Npz2yVv;
	Wed, 24 Jun 2026 22:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782303671;
	cv=none; b=kZcSwwRb1fBkgX2kFqBNcF2MR1141TLSu+YoFirJyzrXXnTR9htF8HhRwZfh1ABssHWUM52ob/a8yRUpDh/RRLwfKn8z0CY1sQgIeP1z4ZQECoTlsg2vFl6HVjV7N44k2k6hPttMPfshUM1tpkNP1cI+xsGVt4XyLrfXWcx9uhsSK6rzESLXcWddWMhIXeWrFvLrmC9Tp4mjYzdNTBuXvVsCY6nu/f3opLcC0pcSilPw0+udoKwT7bV+Md7JIp7liOyEoXSdqv1KnX7DMfmlT/nnJrmiYuPO3AopLTDTU6TZe+kJjBUBKXUr1B5EsVeJxjCPzlUWfb6zBeQ2S6bqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782303671; c=relaxed/relaxed;
	bh=yI/LWbw4aHxVlWynpn2njorIzEWobjJWE83Engadbww=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VSi75TGheAwrzdMPKpRLlJg1GX5Px/gim1sZzMG0qM4w2Ke8QEqZm+A7Wbza3ncv8FqxEbm09tI1VH/FjepAv8NwyM/qD82JlO+trZZuCPj8e3KiM7wnImMIJVN9axwIEbhXZQSL9ZyG1r9/64JkAajM44Qy4R5+/Bob9WBNxrla+ZPRK14o5SPVyp0uko6AO6Fy34pjbdVqLRQJ22BxhVeIh7kN6b55hvg00WuIshtgXmXXCkiyxuECdH7rI50sKyTMsa7GtaTWadYbDbQ2YGsUL2f4c86qxX5uViewnXOjXDrzUlfU3CqSz2rcWnblRs9Tqu0OgTntSpVsQHuYIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=pmVJVITj; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=pmVJVITj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glgyY2p12z2yRF;
	Wed, 24 Jun 2026 22:21:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782303655; x=1782908455; i=markus.elfring@web.de;
	bh=yI/LWbw4aHxVlWynpn2njorIzEWobjJWE83Engadbww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pmVJVITj3eYAXWogDK20wovGFrZkVuaW4s26JRohVrsq6sNkgDAylYQQQTQ0zz4T
	 Mf50/rAzFfEjdUSy+2IIFopTNqp8n0Hr7QxpNmR5IT+ZOfV0e6HNbOAfXU/aSgnHT
	 eia9Xnfkp1eBupBcrp1ibNIZmz9Q2K5V+pF9IEzLduQYwzSZYHrO2X2ZfOIjPKhoz
	 vOkW0sUcN0AdIP0S/olZpboJkDbbuJzWUyC5EQYERK1WyTMHKJusSuUlx1xDCXzrA
	 S7QNgzYvvmvaZmrTSYo3pZFfriCyWQhWyKBfk3LaT1sIzukVlcXt4X+PzKbo8S/C7
	 Dq8VNJnQC1DC0le3JQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6y1-1xAb3U0aKR-00amEB; Wed, 24
 Jun 2026 14:14:39 +0200
Message-ID: <3ab543eb-ca09-4d75-b75c-b8a4c71b2173@web.de>
Date: Wed, 24 Jun 2026 14:14:36 +0200
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
User-Agent: Mozilla Thunderbird
To: YH Chung <yh_chung@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maciej Lawniczak <maciej.lawniczak@intel.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
Subject: Re: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVwodSElK2bARrHe3YMglBE6wXZMwKTpMuDSiv2niVSEWeetjGY
 CoWWjivzGMjBj8dJj2HaiHA45PFcvSUdfDFoi29cw6kKlZbHsozAqXr7gbojO6OzIcZFV7b
 fL4DjlAgAgdvTpMO9zbmqJIk1+N3BT+orGHn345u4qRMXWy7+NlHnEombL73z2QGpxladQc
 UbNsqm5vpePLAx34eTqQQ==
UI-OutboundReport: notjunk:1;M01:P0:hISHF5NeE/k=;CZ7L+oNiNbqt5a2W5T/s3vmFdc2
 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
 ZBV9z16A1m9MopESRA=

=E2=80=A6
> +++ b/drivers/soc/aspeed/espi/aspeed-espi.c
=E2=80=A6
> +static void aspeed_espi_flash_rx_work(struct work_struct *work)
> +{
> +	struct aspeed_espi_flash *flash =3D container_of(work, struct aspeed_e=
spi_flash, rx_work);
> +	struct aspeed_espi *espi =3D container_of(flash, struct aspeed_espi, f=
lash);
> +
> +	mutex_lock(&flash->tx_mtx);
> +	aspeed_espi_flash_handle_lun(espi);
> +	mutex_unlock(&flash->tx_mtx);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&flash->tx_mtx);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.1.1/source/include/linux/mutex.h#L253

Regards,
Markus

